select * from Suicides.dbo.global_suicides 




Select country,year,sex,age,suicides_no,population, (suicides_no/population)*100 as Suicide_percent
from Suicides.dbo.global_suicides
where country like 'Australia%' 
order by 4




Select country,year,age,sex,suicides_no,population,(suicides_no/population)*100 as Male_Suicide_percent
from Suicides.dbo.global_suicides
where country like 'Austra%' and sex='male'
order by 3 ASC
(
Select country,year,age,sex,suicides_no,population,(suicides_no/population)*100 as Female_Suicide_percent
from Suicides.dbo.global_suicides
where country like 'Austra%' and sex='female' )
order by 3 ASC





Select country,year,MAX(suicides_no) as Maximum_sucides
from Suicides.dbo.global_suicides
group by country,year
order by 1, Maximum_sucides  DESC





Select country,year,age,sex,population,MAX(suicides_no) as Maximum_sucides
from Suicides.dbo.global_suicides
where sex='male'
group by country,population,year,age,sex
order by age ASC ,  Maximum_sucides  DESC 
(
Select country,year,age,sex,population,MAX(suicides_no) as Maximum_suicides
from Suicides.dbo.global_suicides
where  sex='female' 
group by country,year,age,sex,population)
order by age ASC , Maximum_suicides DESC 



select * from Suicides.dbo.no_suicides

select country,year,MAX(suicides_no) as Maximum_Suicides
from Suicides.dbo.no_suicides
group by country,year
order by Maximum_Suicides DESC



select gs.country,gs.year,gs.sex,gs.suicides_no,population,ns.generation
from global_suicides gs
join no_suicides ns
on gs.country = ns.country 
and
gs.year= ns.year 

Create table #Global_Suicide_Rate
(
country varchar(150),
year varchar(150),
age varchar(150),
sex varchar(150),
population int,
suicides_no int,
MaxSuicides int);


insert into #Global_Suicide_Rate
Select gs.country,gs.year,gs.age,gs.sex, population,gs.suicides_no, SUM(gs.suicides_no) as MaxSuicides
from Suicides.dbo.global_suicides gs
join no_suicides ns 
on gs.country = ns.country
and
gs.year = ns.year
where gs.sex='male'
group by gs.country,population,gs.year,gs.age,gs.sex,gs.suicides_no
order by age ASC , MaxSuicides DESC
(Select gs.country,gs.year,gs.age,gs.sex,population,gs.suicides_no, SUM(gs.suicides_no) as MaxSuicides
from Suicides.dbo.global_suicides gs
join no_suicides ns 
on gs.country = ns.country
and
gs.year = ns.year
where gs.sex='female'
group by gs.country,population,gs.year,gs.age,gs.sex,gs.suicides_no)
order by age ASC , MaxSuicides DESC

Select * from #Global_Suicide_Rate