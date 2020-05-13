local get_wind

if minetest.get_modpath("climate_api") then
	get_wind = function(pos)
		local MULTIPLICATOR = 2.5
		local wind = climate_api.environment.get_wind({x=0,y=0,z=0})
		return vector.multiply(wind, MULTIPLICATOR)
	end

else
	local yaw = math.random()*math.pi*2-math.pi
	wind={}
	wind.wind = vector.multiply(minetest.yaw_to_dir(yaw),10)
	wind.timer = 0
	wind.ttime = math.random()*5*60+1*60

	get_wind = function()
		return wind.wind
	end

	minetest.register_globalstep(
	function(dtime)
		wind.timer=wind.timer+dtime
		if wind.timer >= wind.ttime then
			local yaw = minetest.dir_to_yaw(wind.wind)
			local yaw = yaw+math.random()-0.5
			wind.wind = vector.multiply(minetest.yaw_to_dir(yaw),10)
			wind.ttime = wind.timer+math.random()*5*60+1*60
		end
	end)
end

return get_wind