Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD95DC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA02166E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlXiNerv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgDXVf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXVf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:35:29 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10162C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:35:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so8693581qts.9
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uu60j0NBBZOP+ZSY0OKfakGoBxTrHDT1O+miG+9QnkE=;
        b=UlXiNervggeQO2Q7013fCBn+94OHn+ccP3xs20SdgnZ1S0NU26qt2Le4BOp0x9o52j
         Ekk90kzlVIXxP8vhGbPHGF7B/W5qiMuCVZzFkxiEdLULEfpFkmVWYqa1nWIJKxhCN2RI
         lgVaF6vvneYwPFJvSEjbCpkt3lefqtq7ytr7/OsyOoeyPbUKTe9eufY/oF1eii9WeDEG
         FXQpbz5+3KPoRAjwziDaS+aTtHrHLQSRlkCgSuRFqsriHMm74WBFMtiH7oD0dS36C3vS
         JtnEnRuoI6oVh8BsUAqqBRupnvmFOpTnf8GLfMbqlBlVxBcINJkpaDHtNpluU69YmFIy
         qnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uu60j0NBBZOP+ZSY0OKfakGoBxTrHDT1O+miG+9QnkE=;
        b=RwhkQn+jwvFMTnpkvkm5SgGM2+pLARPCZGgjEnTSLwXn/17qxpkDGoCWcb0U4KFNRa
         OtyTgckKvON3wEPwahV/bXNmqNIQ9WTrIwNm23sCRa1MATlIpoXOjPuuc529+wJUxOZq
         VGtZzwAxjsh+eoZZYWpqIyTd0WLyONe6XxgKfXL/JHn6cNzBT1uEWxSJ+fOqyCeReaRS
         /tluDLpYFJ3CKl6bSG64N+gfFS5sqamDGAYj4X+tB/mv5IoKrm1TBhC6g987WV41bfcX
         Befg8KITmhgPzoxU+BamfdbC1e80FU6tDhliENuqQGkWOqrqbjz0GXCiY0x0riIvTPWb
         Ideg==
X-Gm-Message-State: AGi0PuZEYmnqX2DC6plvrk/9mEUvuSBTlPZNQ4i3MV+5Jel0t0YTKexP
        oAI3rjhqT3NpqGIKQ2ucjMtD372fo3IIVhy/TUo=
X-Google-Smtp-Source: APiQypKUzdYLCeW0QSQrP1Jw0ZNI/RSMqDM+4NIq9hiOsBgr2jTsY/SgZA+28Ik0yKzAc9zxzyPpWk+508sY9F1ehIY=
X-Received: by 2002:ac8:65d4:: with SMTP id t20mr11632606qto.358.1587764128153;
 Fri, 24 Apr 2020 14:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <0577d7bf0a84f94396bd956bd7f6bbc711d3bf26.1587700897.git.gitgitgadget@gmail.com>
 <20200424173951.GM1949@danh.dev>
In-Reply-To: <20200424173951.GM1949@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 03:05:16 +0530
Message-ID: <CAKiG+9Wr+-ax_2=eK+n0Kt50hafTZd-xwxNf5cG96a-RCFP_jA@mail.gmail.com>
Subject: Re: [PATCH 7/8] cmake: support for building git on windows with msvc
 and clang.
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 11:09 PM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-24 04:01:36+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > This patch adds support for Visual Studio and Clang builds
> >
> > The minimum required version of CMake is upgraded to 3.15 because
> > this version offers proper support for Clang builds on Windows.
> >
> > Libintl is not searched for when building with Visual Studio or Clang
> > because there is no binary compatible version available yet.
> >
> > NOTE: In the link options invalidcontinue.obj has to be included.
> > The reason for this is because by default, Windows calls abort()'s
> > instead of setting errno=EINVAL when invalid arguments are passed to
> > standard functions.
> > This commit explains it in detail:
> > 4b623d80f73528a632576990ca51e34c333d5dd6
> >
> > On Windows the default generator is Visual Studio,so for Visual Studio
> > builds do this:
> >
> > cmake `relative-path-to-srcdir`
> >
> > NOTE: Visual Studio generator is a multi config generator, which means
> > that Debug and Release builds can be done on the same build directory.
> >
> > For Clang builds do this:
> >
> > On bash
> > CC=Clang cmake `relative-path-to-srcdir` -G Ninja
> >               -DCMAKE_BUILD_TYPE=[Debug or Release]
> >
> > On cmd
> > set CC=Clang
> > cmake `relative-path-to-srcdir` -G Ninja
> >               -DCMAKE_BUILD_TYPE=[Debug or Release]
> >
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  CMakeLists.txt | 57 ++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 46 insertions(+), 11 deletions(-)
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index d9eb1060390..5ad3a2557f7 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -2,7 +2,7 @@
> >  #    Copyright (c) 2020 Sibi Siddharthan
> >  #
> >
> > -cmake_minimum_required(VERSION 3.14)
> > +cmake_minimum_required(VERSION 3.15)
>
> 3.14 is a step too far, and, now, we want CMake 3.15?
>
> >
> >  #Parse GIT-VERSION-GEN to get the version
> >  file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN git_version REGEX "DEF_VER=v(.*)")
> > @@ -32,8 +32,11 @@ find_package(ZLIB REQUIRED)
> >  find_package(CURL)
> >  find_package(EXPAT)
> >  find_package(Iconv)
> > -find_package(Intl)
> >
> > +#Don't use libintl on Windows Visual Studio and Clang builds
> > +if(NOT (WIN32 AND (CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")))
> > +     find_package(Intl)
> > +endif()
> >
> >  if(NOT Intl_FOUND)
> >       add_compile_definitions(NO_GETTEXT)
> > @@ -61,7 +64,7 @@ if(NOT SH_EXE)
> >       message(FATAL_ERROR "sh interpreter was not found in your path, please install one. On Windows you can get it from here https://gitforwindows.org/")
> >  endif()
> >
> > -if(WIN32)
> > +if(WIN32 AND NOT MSVC)#not required for visual studio builds
> >       find_program(WINDRES_EXE windres)
> >       if(NOT WINDRES_EXE)
> >               message(FATAL_ERROR "Install windres on Windows for resource files")
> > @@ -73,6 +76,13 @@ if(NOT MSGFMT_EXE)
> >       message(WARNING "Text Translations won't be build")
> >  endif()
> >
> > +#Force all visual studio outputs to CMAKE_BINARY_DIR
> > +if(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
> > +     set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
> > +     set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
> > +     add_compile_options(/MP)
> > +endif()
> > +
> >  #default behaviour
> >  include_directories(${CMAKE_SOURCE_DIR})
> >  add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
> > @@ -110,6 +120,10 @@ endif()
> >
> >  #Platform Specific
> >  if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
> > +     if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
> > +             include_directories(compat/vcbuild/include)
> > +             add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)
>
> This is fair, I hate those warning, too.
>
> Is _CRT_NONSTDC_NO_DEPRECATE implied when _CRT_SECURE_NO_WARNINGS
> defined? Or otherwise around?
>
>

They both are independent

> --
> Danh

Thank You,
Sibi Siddharthan
