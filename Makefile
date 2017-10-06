# If we are running by kernel building system
CFLAGS_example_sysfs.o := -DDEBUG
ifneq ($(KERNELRELEASE),)
#    $(TARGET_MODULE)-objs := main.o device_file.o
	obj-m := example_sysfs.o
# If we running without kernel build system
else
	BUILDSYSTEM_DIR:=/lib/modules/$(shell uname -r)/build
	PWD:=$(shell pwd)
default : 
# run kernel build system to make module
	${MAKE} -C ${BUILDSYSTEM_DIR} M=${PWD} modules
clean :
# run kernel build system to cleanup in current directory
	${MAKE} -C ${BUILDSYSTEM_DIR} M=${PWD} clean
	
endif
