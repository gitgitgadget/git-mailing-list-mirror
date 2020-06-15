Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C0C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048D220756
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6RtdvDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgFOUE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbgFOUE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:04:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF323C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:04:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n11so17031515qkn.8
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5MuJhecy1KAW3Pwg0fl/iW4xbdQXlQwR7is8ap2GHiU=;
        b=M6RtdvDlgEESJngxdtmSm1cNqhMT5rsrtUsJp9nd9ndgI9PBSIcfU45eGbVyTxnXx3
         u1Gt52EvB6Zn4ZSg4Imq93QAlIEn47NKSmt5ejrWH5ON9M7VRdC4vtutnAAo31fMLW0P
         Nxxe1opaRObbKo2PLaJ3s+65ESu37SaGYbeOFIqeWggiKAGjdxxp4Bw+bXWEkidCbiYN
         IDQbFMDakgJ4E9LYwSOdJoOanJtfZXQBKaeqceW/uSdMhiihQZQj3uMgz9t24hKK7Pao
         70UIAMt/rDlQi3ggO8uUSX86PzILPgr+83cFFUUjr/aWgieel5X27w7wKJzOe9+G3ofZ
         Vxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5MuJhecy1KAW3Pwg0fl/iW4xbdQXlQwR7is8ap2GHiU=;
        b=YFFz60GqkKohraNwDzkdYSjY2ExRAjmlF8fKB6sciqmYXWz4/1xn4jPc03+qlRb4Pr
         7N2l4DvMBVqRLs0475a9MWoDFpqLpIt1TzVbbgUsbEVoIpFVA+s+kTbBmEF/g5SiZsF4
         ho+BpFrAnAuBjg1+m4MC2mO1atO8LWKH+uGhwJG0TDARerUI9WkR6ac5XA3VcqyzT1IE
         ETcTDJG9wsvDOSU2naH/8Gkmr2bp95mWgH3ruDdDNAAFFW36LzqmRtJQ5AZ4dGBZ22NP
         17B2eK42hbvWz49TMal3/dhujvvBr0oswucMejmc36yKSGUTef42PXcFZSefx39KthF4
         robA==
X-Gm-Message-State: AOAM532p6Xc3eOrDdpRjrBHRcZ1cAmJ75YwViw68syzauXdEAwdfugcX
        CD0NbkzS2y60IJz6UxEk+ykY/JT8HpFDiQsLPao=
X-Google-Smtp-Source: ABdhPJxu9bDC1Hlg6vosf6CeN29XLlQieLZfFyn0GLwZZL5VUvPjxhtRa7szmy+MPNTgUSUwB3YhftcOj8+u5Mz+jp4=
X-Received: by 2002:a05:620a:1525:: with SMTP id n5mr16906156qkk.328.1592251497869;
 Mon, 15 Jun 2020 13:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <c4e1ba74464cfae882cde646d3c79778244b8f5e.1591986566.git.gitgitgadget@gmail.com>
 <20200615140049.1647-1-oystwa@gmail.com>
In-Reply-To: <20200615140049.1647-1-oystwa@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 16 Jun 2020 01:34:46 +0530
Message-ID: <CAKiG+9U8mVASyM-wcooFk69diYPmHMpymAQyLJcEL1N8X_Awuw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] Introduce CMake support for configuring Git
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 7:31 PM =C3=98ystein Walle <oystwa@gmail.com> wrote=
:
>
> Hi,
>
> I haven't been able to pay much attention lately. I see this is v4 of thi=
s
> patch series and thought I took a quick look and didn't find anything, it=
's
> possible some of this has been addressed already. If so I apologize.
>
> > So let's start building CMake support for Git.
>
> Yay!
>
> > +
> > +Instructions to run CMake:
> > +
> > +cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=3DRelease
> > +Eg.
> > +From the root of git source tree
> > +     `cmake contrib/buildsystems/ `
> > +This will build the git binaries at the root
> > +
> > +For out of source builds, say build in 'git/git-build/'
> > +     `mkdir git-build;cd git-build; cmake ../contrib/buildsystems/`
> > +This will build the git binaries in git-build directory
> > +
>
> Since the mininum required version is sufficiently high I suggest you
> recommend the following as well:
>
>     cmake -B build-dir -S contrib/buildsystems
>
> This might be easier for scripted tasks (packaging and whatnot) since cd
> and mkdir aren't necessary.
>

We could do that.

> > +#set the source directory to root of git
> > +set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>
> See if you can avoid this. This this will break if another project includ=
es Git
> as part of itself with add_subdirectory() or the ExternalProject module. =
If all
> you use it for is paths to other files then you might as well do this:
>
>     set(repo_root "${CMAKE_CURRENT_LIST_DIR}/../..")
>
> and use ${repo_root} the places you use ${CMAKE_SOURCE_DIR} now.
>
> AFAIK the places CMake accepts relative paths it's usually relative to
> CMAKE_CURRENT_SOURCE_DIR and not CMAKE_SOURCE_DIR, anyway. I don't think =
it's
> automagically updated when CMAKE_SOURCE_DIR is changed.
>

Since we are using a single list file, it is fine.
I understand your concern that git is included as part of another
project things might break, but that is really rare.
I will try to fix these issues after adding support for BSD and APPLE syste=
ms.
The main priority for this patch series is to help git-for-windows
developers for now.

> > +include_directories(SYSTEM ${ZLIB_INCLUDE_DIRS})
> > +if(CURL_FOUND)
> > +     include_directories(SYSTEM ${CURL_INCLUDE_DIRS})
> > +endif()
>
> This is better handled like this these days:
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/C=
MakeLists.txt
> index 8367b73e94..ca1f90e58c 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -121,10 +121,6 @@ if(NOT Intl_FOUND)
>         endif()
>  endif()
>
> -include_directories(SYSTEM ${ZLIB_INCLUDE_DIRS})
> -if(CURL_FOUND)
> -       include_directories(SYSTEM ${CURL_INCLUDE_DIRS})
> -endif()
>  if(EXPAT_FOUND)
>         include_directories(SYSTEM ${EXPAT_INCLUDE_DIRS})
>  endif()
> @@ -606,7 +602,7 @@ endif()
>  #link all required libraries to common-main
>  add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
>
> -target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
> +target_link_libraries(common-main libgit xdiff ZLIB::ZLIB)
>  if(Intl_FOUND)
>         target_link_libraries(common-main ${Intl_LIBRARIES})
>  endif()
> @@ -659,17 +655,17 @@ if(CURL_FOUND)
>         add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/http.c)
>
>         add_executable(git-imap-send ${CMAKE_SOURCE_DIR}/imap-send.c)
> -       target_link_libraries(git-imap-send http_obj common-main ${CURL_L=
IBRARIES})
> +       target_link_libraries(git-imap-send http_obj common-main CURL::li=
bcurl)
>
>         add_executable(git-http-fetch ${CMAKE_SOURCE_DIR}/http-walker.c $=
{CMAKE_SOURCE_DIR}/http-fetch.c)
> -       target_link_libraries(git-http-fetch http_obj common-main ${CURL_=
LIBRARIES})
> +       target_link_libraries(git-http-fetch http_obj common-main CURL::l=
ibcurl)
>
>         add_executable(git-remote-http ${CMAKE_SOURCE_DIR}/http-walker.c =
${CMAKE_SOURCE_DIR}/remote-curl.c)
> -       target_link_libraries(git-remote-http http_obj common-main ${CURL=
_LIBRARIES} )
> +       target_link_libraries(git-remote-http http_obj common-main CURL::=
libcurl)
>
>         if(EXPAT_FOUND)
>                 add_executable(git-http-push ${CMAKE_SOURCE_DIR}/http-pus=
h.c)
> -               target_link_libraries(git-http-push http_obj common-main =
${CURL_LIBRARIES} ${EXPAT_LIBRARIES})
> +               target_link_libraries(git-http-push http_obj common-main =
CURL::libcurl ${EXPAT_LIBRARIES})
>         endif()
>  endif()
>
> With this change we're feeding proper CMake targets to target_link_librar=
ies()
> instead of just a bunch of strings. CMake can know a lot about a target, =
such
> as it's dependencies, required macros and so on[1]. This means some boile=
rplate
> code can be removed: Notice that the manual handling of Zlib's include pa=
th is
> gone. The same can perhaps be done for the other libraries as well but I
> haven't checked that.
>

It depends on the implementation of the CMake modules. We can do as
you suggested for Zlib and curl.
Iconv added exported targets recently.
Intl still does not have this syntax yet.
Using ${*_LIBRARIES} works all across the board.

Thank You
Sibi Siddharthan

> > +include_directories(${CMAKE_SOURCE_DIR})
> > +(...)
> > +include_directories(${CMAKE_BINARY_DIR})
>
> See if CMAKE_INCLUDE_CURRENT_DIR[2] makes this unneeded. It might not sin=
ce you
> overwrite CMAKE_SOURCE_DIR manually.
>
> =C3=98sse
>
> [1]: https://cmake.org/cmake/help/latest/manual/cmake-properties.7.html#p=
roperties-on-targets
> [2]: https://cmake.org/cmake/help/latest/variable/CMAKE_INCLUDE_CURRENT_D=
IR.html
