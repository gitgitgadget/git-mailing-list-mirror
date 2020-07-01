Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99ECC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 17:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80C72078A
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 17:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+mtsE/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgGARpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgGARpM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 13:45:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E2C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 10:45:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q198so23028345qka.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4jgAEUJ/+8fKfpWFU3bp9BEKeOqpKvw0WT4igACdhs=;
        b=L+mtsE/HAl6Vr0XaQBdhpMSX57CRsIT62omA/ZV3eR2RBv8qLOwjFmzE4YxcHLhhV9
         6Q2sd/uCexUfTvtQC4g3opea9eb2MiaooVxwvxwXZcoF+wbHWKIBgfXQ5Xw/Zs/ssGNY
         MRKSRSgykJydE+gus3eSMEhnytZns9svxfyWNYxbdPpT7nAkgMQWDSDMekbLCDoklDj8
         01xSzFLB9L20/0p6y+O901Tr0IzPYFR2AnxvprjE75sDZCccZurlsCuVua9Z8uIcJD+i
         ERlcrWfSRKr1A808ml9BKuwb6xeBnwHbqYilgcvnLJ1/F3cuT0SiKugBzh9kIantwaBM
         +0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4jgAEUJ/+8fKfpWFU3bp9BEKeOqpKvw0WT4igACdhs=;
        b=ovfY7j6l2BHD3XIEEiDjqKi525qyvUTWDxi34yHJV2taF/cM8kGdeWaFZsqKTZYLdZ
         7ApTcUzb404gzUNuh6X8DH8HBlkG7v/++whot85w6b6vzk5OFi99AoCfwgok3kJA7v6o
         iF2Pg8RTvnIFVM34zJ9cv4x9caEbl6HkhIAq+Msxu1US5V+Ww0/rXhJxoc88uxO8RRsC
         6QMN5mAnVmQuGJvKUht5sZMMadPD9Eb8Ly3buENBggOUTD94MJ/oCjM0rnA33jENdoS5
         7UGFXx77NFMOn8feWXR7fvPyg9Bo4/b0CLuF97+hxes1iuHh/vCL/Jksk3BKr3bvPTRg
         ADMA==
X-Gm-Message-State: AOAM530jvUA3i1pHlmeLGK654v4NDa9qbJjNWRFvFl/ILMni/xDi3EAd
        DqXRc2AyMrjiznmpIwt26OO2oC3jbzTyvFu/5EU=
X-Google-Smtp-Source: ABdhPJzmZ3oNEOzh2FpmCzzGf5cAaKwDVTwyjnt2nE1Ri2BHHLCpdGeSeSpfb9mf4w+oDSMZSClPyViIOxy8J3LUf2s=
X-Received: by 2002:a37:84a:: with SMTP id 71mr6894429qki.77.1593625511194;
 Wed, 01 Jul 2020 10:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
 <pull.614.v5.git.1593187898.gitgitgadget@gmail.com> <10acdbf5e4d4c49f69889ab1129d3d6b5a7fd754.1593187898.git.gitgitgadget@gmail.com>
 <20200630072521.GC1962986@gmail.com>
In-Reply-To: <20200630072521.GC1962986@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Wed, 1 Jul 2020 23:15:00 +0530
Message-ID: <CAKiG+9Vws-_6rYh=Kcc2W3qbo_7LdxrE0WGPwLmGGewM+VqcVg@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] cmake: support for building git on windows with mingw
To:     David Aguilar <davvid@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This module should not be used here as Git is built with pthreads in mind.
All of the Linux systems have the pthread library at install. For
Windows, there is a pthread layer implemented using Win32 calls in
compat/win32/pthread.c,h .

It would be nice if the library checks for pthreads on Windows
(libwinpthread and similar implementations), but it does not.

Thank You,
Sibi Siddharthan

On Tue, Jun 30, 2020 at 12:55 PM David Aguilar <davvid@gmail.com> wrote:
>
> On Fri, Jun 26, 2020 at 04:11:36PM +0000, Sibi Siddharthan via GitGitGadget wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > This patch facilitates building git on Windows with CMake using MinGW
> >
> > NOTE: The funtions unsetenv and hstrerror are not checked in Windows
> > builds.
> > Reasons
> > NO_UNSETENV is not compatible with Windows builds.
> > lines 262-264 compat/mingw.h
> >
> > compat/mingw.h(line 25) provides a definition of hstrerror which
> > conflicts with the definition provided in
> > git-compat-util.h(lines 733-736).
> >
> > To use CMake on Windows with MinGW do this:
> > cmake `relative-path-to-srcdir` -G "MinGW Makefiles"
> >
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  contrib/buildsystems/CMakeLists.txt | 117 ++++++++++++++++++++++------
> >  1 file changed, 94 insertions(+), 23 deletions(-)
> >
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> > index 2768ee5b71..2d7c0ed88e 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -42,6 +42,10 @@ cmake_minimum_required(VERSION 3.14)
> >  set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
> >
> >  find_program(SH_EXE sh)
> > +if(NOT SH_EXE)
> > +     message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
> > +                     "On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
> > +endif()
> >
> >  #Create GIT-VERSION-FILE using GIT-VERSION-GEN
> >  if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
> > @@ -65,7 +69,9 @@ project(git
> >       VERSION ${git_version}
> >       LANGUAGES C)
> >
> > +
> >  #TODO gitk git-gui gitweb
> > +#TODO Enable NLS on windows natively
> >  #TODO Add pcre support
> >
> >  #macros for parsing the Makefile for sources and scripts
> > @@ -104,6 +110,7 @@ find_package(EXPAT)
> >  find_package(Iconv)
> >  find_package(Intl)
> >
> > +
> >  if(NOT Intl_FOUND)
> >       add_compile_definitions(NO_GETTEXT)
> >       if(NOT Iconv_FOUND)
> > @@ -125,6 +132,14 @@ if(Intl_FOUND)
> >       include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
> >  endif()
> >
> > +
> > +if(WIN32)
> > +     find_program(WINDRES_EXE windres)
> > +     if(NOT WINDRES_EXE)
> > +             message(FATAL_ERROR "Install windres on Windows for resource files")
> > +     endif()
> > +endif()
> > +
> >  find_program(MSGFMT_EXE msgfmt)
> >  if(NOT MSGFMT_EXE)
> >       message(WARNING "Text Translations won't be build")
> > @@ -156,11 +171,35 @@ add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
> >                       BINDIR="bin"
> >                       GIT_BUILT_FROM_COMMIT="")
> >
> > -set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
> > -add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> > +if(WIN32)
> > +     set(FALLBACK_RUNTIME_PREFIX /mingw64)
> > +     add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> > +else()
> > +     set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
> > +     add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> > +endif()
> > +
> > +
> > +#Platform Specific
> > +if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
> > +     include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
> > +     add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
> > +                             _CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
> > +                             NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
> > +                             USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
> > +                             UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
> > +     list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
> > +             compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
> > +             compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
> > +             compat/nedmalloc/nedmalloc.c compat/strdup.c)
> > +     set(NO_UNIX_SOCKETS 1)
> > +
> > +elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
> > +     add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> > +     list(APPEND compat_SOURCES unix-socket.c)
> > +endif()
> >
> > -add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> > -list(APPEND compat_SOURCES unix-socket.c)
> > +set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
> >
> >  #header checks
> >  check_include_file(libgen.h HAVE_LIBGEN_H)
> > @@ -223,7 +262,12 @@ endif()
> >  #function checks
> >  set(function_checks
> >       strcasestr memmem strlcpy strtoimax strtoumax strtoull
> > -     setenv mkdtemp poll pread memmem unsetenv hstrerror)
> > +     setenv mkdtemp poll pread memmem)
> > +
> > +#unsetenv,hstrerror are incompatible with windows build
> > +if(NOT WIN32)
> > +     list(APPEND function_checks unsetenv hstrerror)
> > +endif()
> >
> >  foreach(f ${function_checks})
> >       string(TOUPPER ${f} uf)
> > @@ -444,7 +488,13 @@ unset(CMAKE_REQUIRED_INCLUDES)
> >  #programs
> >  set(PROGRAMS_BUILT
> >       git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
> > -     git-shell git-remote-testsvn git-credential-cache git-credential-cache--daemon)
> > +     git-shell git-remote-testsvn)
> > +
> > +if(NO_UNIX_SOCKETS)
> > +     list(APPEND excluded_progs git-credential-cache git-credential-cache--daemon)
> > +else()
> > +     list(APPEND PROGRAMS_BUILT git-credential-cache git-credential-cache--daemon)
> > +endif()
> >
> >  if(NOT CURL_FOUND)
> >       list(APPEND excluded_progs git-http-fetch git-http-push)
> > @@ -516,15 +566,34 @@ parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
> >  list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
> >  add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
> >
> > +#add git.rc for gcc
> > +if(WIN32)
> > +     add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
> > +                     COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
> > +                             -DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
> > +                             -i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
> > +                     WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> > +                     VERBATIM)
> > +     add_custom_target(git-rc DEPENDS ${CMAKE_BINARY_DIR}/git.res)
> > +endif()
> > +
> >  #link all required libraries to common-main
> >  add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
> > -target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES} pthread rt)
> > +
> > +target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
> >  if(Intl_FOUND)
> >       target_link_libraries(common-main ${Intl_LIBRARIES})
> >  endif()
> >  if(Iconv_FOUND)
> >       target_link_libraries(common-main ${Iconv_LIBRARIES})
> >  endif()
> > +if(WIN32)
> > +     target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)
> > +     add_dependencies(common-main git-rc)
> > +     target_link_options(common-main PUBLIC -municode -Wl,--nxcompat -Wl,--dynamicbase -Wl,--pic-executable,-e,mainCRTStartup)
> > +elseif(UNIX)
> > +     target_link_libraries(common-main pthread rt)
> > +endif()
>
>
> Small note about pthread.  In CMake land, the typical convention is to
> use the FindThreads module. [1]
>
> To use it, add this to the top-level:
>
>         set(THREADS_PREFER_PTHREAD_FLAG TRUE)
>         find_package(Threads REQUIRED)
>
> and then use the Threads::Threads target with target_link_libraries()
> instead of hard-coding "pthread" here.
>
> That way it'll only use the "-pthread" flag and library links as needed.
>
> I'm not sure if mingw makes this advice moot, but I figured it was worth
> mentioning.
>
> [1] https://cmake.org/cmake/help/latest/module/FindThreads.html
> --
> David
