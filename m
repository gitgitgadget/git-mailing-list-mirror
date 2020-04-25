Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76379C2BA19
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4F320704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZruMo1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDYDut (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgDYDus (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 23:50:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B145DC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:50:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so9757699qtb.5
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIEoSu67n7aqJ7uA8ZL0JBYqfTmIhECYZKL3oqb+u20=;
        b=iZruMo1mOXYjWKMeSLP0Ny/zpg71z9gcmb0Iq4CNEHMuyVGw+uHndexz94//8iRYgF
         4ult/e5+npFv+ET3hHj1b6YEKqq+gYnCMIDzwB1N8dbWMfzI+jLwS8ZnCvmVbuQjQgxm
         xx8VSaEW23s1OBoG3ZE+EXRVoYZtyuRCpmF/hr1rqI+PRPp3SeuBShO/HVx/WHUQuCgN
         t7lPEzOf9rnATgwPjUZqfLSF9o2DVGVZ6sRK0pnj/8VZB/lkZJOZ7blkBlqp7jTsu4Bi
         hU3DmvNEkvlfzJYGnwdPoDIxQc9ZQp6792glHcEX/53zOwINVZ6MWpMbnL9INUlMPra+
         QpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIEoSu67n7aqJ7uA8ZL0JBYqfTmIhECYZKL3oqb+u20=;
        b=Dm+Ea+sYAxODI32zJRPRF3hjbA2uiFavCtVwuRnnVbXD3A0QFu2r+1t27ElsN5JDq0
         B/A5xthicl67ntt0wVhRNiFSG70hRhe0ZazHskeLAKL1Vr2myRCK2YfjsKExHvHavkjC
         6mIVmVip08kvsuQ99BMY+L23dnsdvmFSOiyi+zaxkddj/lGXubBIR47FZTFL7mPc4qeu
         tfdFV0Mpx9+XVluNBWZ8kcMysMzaKHD6t/fM+VXEIA2IN5Ku3G0RbO4/7wUdzyNR9Nmv
         sBEtihcz2VRX69vSW4kBjMohwmwJWa3a14TXSQgnbbppn73K9lrUPnstQfdVj9/7MQZy
         qZWg==
X-Gm-Message-State: AGi0PuZ0a7MVdOUJArM6XwcV70bBCqHWZSMhKMRyVMGRttHtexAWn2+x
        GlwsVAD7p1Y6MbI7Wgv0MMWC66g4RRnrZ714Ocg=
X-Google-Smtp-Source: APiQypKsByf5rHJyA7qpndwAw/l0fZfKYSo1VHK97ulhPsaJ9jED829rGN+souPvi/CTuRbsRZPF795bYDuMG9lQOic=
X-Received: by 2002:ac8:19fd:: with SMTP id s58mr13008483qtk.222.1587786647795;
 Fri, 24 Apr 2020 20:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <70ab1f03dd5413256166bf9db47be47b746ea6b1.1587700897.git.gitgitgadget@gmail.com>
 <20200424170540.GH1949@danh.dev> <CAKiG+9VxPkqq-iLCu9pj=jf_4Lgq+05aFb9avfH8dtDtNVzy4w@mail.gmail.com>
 <20200424225621.GD721@danh.dev>
In-Reply-To: <20200424225621.GD721@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 09:20:36 +0530
Message-ID: <CAKiG+9VZcyjGQLHzT2S70mptKNhHLpwZ9Sd1rto32cN6a-7f_w@mail.gmail.com>
Subject: Re: [PATCH 1/8] Introduce CMake support for configuring Git on Linux
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 4:26 AM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-25 02:36:12+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> > Yes it does,
> > all you have to do is -DZLIB_ROOT=/path/to/zlib/root
>
> OK, I need to learn this syntax
>
> > > > +find_package(EXPAT)
> > > > +find_package(Iconv)
> > > > +find_package(Intl)
> > > > +
> > >
> > > > +if(NOT Intl_FOUND)
> > > > +     add_compile_definitions(NO_GETTEXT)
> > >
> > > find_package(Gettext)?
> > >
> >
> > find_package(Gettext) does not define libintl and libintl.h.
> > If NO_GETTEXT is not defined, it means that libintl.h is present.
> > So, we use find_package(Intl) for libintl
>
> People do weird things.
>
> But, I bet that a lot of people have system that have libintl.h
> installed, but they don't install gettext tools. ;-)
>
> Anyway, can I override NO_GETTEXT from command line?
>
> Let's say, I want to bootstrap a new distro?
> In the boostrap step, I don't want to build any i18n things,
> because the bootstrap package will be thrown away and rebuild again.
> I don't want to waste time on building such translation things.
>

So, you are trying to build two times and configuring it only once. Am I right?
If so I don't think you bootstrap with CMake. Will let you know if I
figure something out.

> >
> > > > +     if(NOT Iconv_FOUND)
> > > > +             add_compile_definitions(NO_ICONV)
> > > > +     endif()
> > > > +endif()
> > >
> > > ICONV_OMITS_BOM?
> > >
> >
> > Forgot about this, will add it.
>
> Thanks, my platform relies on this definition!
>
> > > > +
> > > > +include_directories(SYSTEM ${ZLIB_INCLUDE_DIRS})
> > > > +if(CURL_FOUND)
> > > > +     include_directories(SYSTEM ${CURL_INCLUDE_DIRS})
> > > > +endif()
> > > > +if(EXPAT_FOUND)
> > > > +     include_directories(SYSTEM ${EXPAT_INCLUDE_DIRS})
> > > > +endif()
> > > > +if(Iconv_FOUND)
> > > > +     include_directories(SYSTEM ${Iconv_INCLUDE_DIRS})
> > > > +endif()
> > > > +if(Intl_FOUND)
> > > > +     include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
> > > > +endif()
> > > > +
> > > > +find_program(SH_EXE sh)
> > >
> > > We want to find usable sh, not just sh, no?
> > >
> > > It's matter on Solaris, HP-UX
> > >
> >
> > How do I check for this, can you help?
>
> Sorry, Please ask someone else, check Makefile to see who fixed build
> for Solaris and HP-UX.
>
> > Also, the script is not supported on Solaris and HP-UX.
>
> If Solaris or HP-UX is out of equation,
> I'll just write: SH_EXE=/bin/sh ;-)
>
>

This is exactly what the current definition does.

> >
> > > > +
> > > > +#default behaviour
> > > > +include_directories(${CMAKE_SOURCE_DIR})
> > > > +add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
> > > > +add_compile_definitions(SHA256_BLK INTERNAL_QSORT RUNTIME_PREFIX)
> > > > +add_compile_definitions(NO_OPENSSL SHA1_DC SHA1DC_NO_STANDARD_INCLUDES
> > > > +                     SHA1DC_INIT_SAFE_HASH_DEFAULT=0
> > > > +                     SHA1DC_CUSTOM_INCLUDE_SHA1_C="cache.h"
> > > > +                     SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h" )
> > > > +list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
> > > > +
> > > > +
> > > > +add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
> > > > +                     ETC_GITATTRIBUTES="etc/gitattributes"
> > > > +                     ETC_GITCONFIG="etc/gitconfig"
> > > > +                     GIT_EXEC_PATH="libexec/git-core"
> > > > +                     GIT_LOCALE_PATH="share/locale"
> > > > +                     GIT_MAN_PATH="share/man"
> > > > +                     GIT_INFO_PATH="share/info"
> > > > +                     GIT_HTML_PATH="share/doc/git-doc"
> > > > +                     DEFAULT_HELP_FORMAT="html"
> > > > +                     DEFAULT_GIT_TEMPLATE_DIR="share/git-core/templates"
> > > > +                     GIT_VERSION="${PROJECT_VERSION}.GIT"
> > > > +                     GIT_USER_AGENT="git/${PROJECT_VERSION}.GIT"
> > > > +                     BINDIR="bin"
> > > > +                     GIT_BUILT_FROM_COMMIT="")
> > >
> > > I wish I could verify this.
> > > Have you check this part on a default build system for a Linux distro,
> > > FreeBSD? For things started with "etc/"
> > >
> >
> > These are the values I got when I looked at the build logs from the
> > Makefile (make -n) in Linux and Windows.
> > Don't know about FreeBSD
>
> Linux will install configuration to /etc, Windows (by using msys),
> will also do that.
>
> *BSD port installs git with /usr/local prefix, and install
> configuration to /usr/local/etc
>

Aren't the above definitions relative paths?(With RUNTIME_PREFIX)
Once you decide to install, you have INSTALL_PREFIX(similar to
DESTDIR) with which you
can achieve the above.

> >
> > > > +
> > > > +set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
> > > > +add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> > > > +
> > > > +add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> > >
> > > /proc/self/exe is Linux only, no?
> > >
> >
> > Yes, it is. This first patch only supports Linux build.
> >
> > > > +list(APPEND compat_SOURCES unix-socket.c)
> > > > +
> > > > +#header checks
> > > > +check_include_file(libgen.h HAVE_LIBGEN_H)
> > > > +if(NOT HAVE_LIBGEN_H)
> > > > +     add_compile_definitions(NO_LIBGEN_H)
> > > > +     list(APPEND compat_SOURCES compat/basename.c)
> > > > +endif()
> > > > +
> > > > +check_include_file(sys/sysinfo.h HAVE_SYSINFO)
> > > > +if(HAVE_SYSINFO)
> > > > +     add_compile_definitions(HAVE_SYSINFO)
> > > > +endif()
> > > > +
> > > > +check_c_source_compiles("
> > > > +#include <alloca.h>
> > > > +int
> > > > +main ()
> > > > +{
> > > > +char *p = (char *) alloca (2 * sizeof (int));
> > > > +     if (p) return 0;
> > > > +     return 0;
> > >
> > > All code path will return 0?
> > >
> >
> > This check is for a working alloca.h.
> > Some systems define alloca in malloc.h (Windows)
>
> Does CMake have a macro for check function in which include files?
>

The check functions is something that was used to match the automake behaviour.
If you want to check whether a function exists in a particulae header
file use check_symbol_exists().

> >
> > > > +}"
> > > > +HAVE_ALLOCA_H)
> > > > +if(HAVE_ALLOCA_H)
> > > > +     add_compile_definitions(HAVE_ALLOCA_H)
> > > > +endif()
> > > > +
> > > > +
> > > > +if(CURL_FOUND)
> > > > +     set(remote_exes
> > > > +             git-remote-https git-remote-ftp git-remote-ftps)
> > > > +     foreach(s ${remote_exes})
> > > > +             file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git-remote-http ${s})\n")
>
> Now, I looked at this again.
> I didn't see the creatation of CreateLinks.cmake anywhere!
>
> > > > +             list(APPEND git_http_links ${CMAKE_BINARY_DIR}/${s})
> > > > +     endforeach()
> > > > +endif()
> > > > +
> > > > +add_custom_command(OUTPUT ${git_links} ${git_http_links}
> > > > +             COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/CreateLinks.cmake
> > > > +             DEPENDS git git-remote-http)
> > > > +add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
> > > > \ No newline at end of file
> > >
> > > No new line at end of line always leave a bad taste in my mount!
> > >
>
> --
> Danh

Thank You,
Sibi Siddharthan
