Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7485C433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 19:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938FD206F0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 19:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkcJ0Ode"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgE3TJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 15:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3TJL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 15:09:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1586C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 12:09:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c185so5463072qke.7
        for <git@vger.kernel.org>; Sat, 30 May 2020 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=czM2d6PsSPalOUqenn4qL0lv0Zw3+F4vOKNFSJ/Jvpo=;
        b=QkcJ0OdeDweQXS70ECFL4XY6u2rH/4tmwBxm0R9aBFubzFz1kB5joHvY/9EiEFVw6U
         74vpsRYw1S6Atd/pxmnWOXrxdfOb8ZsRVcuWEXKxi6WtcV27xI9wF4YiAdF98al6mvuG
         OcTaS4siDH9lBTUITM+qCv/5XlplPHYiPAZRbqHB5BoCusohaUdVQQ12hV0G6qS9/Ra3
         HPYY7Pag6ss2WXXL8d7dOe3Dj/QkniTgEY4EBrCE0ZAKisSocsH0Jfbi6Zg9K98kO6yB
         qD54UHuw19nWIlXRjWgqEjibwb4/wRBvc5cLeCfTV8JIJq0KUp3PwY4W8kbBcAbP/rPD
         xItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=czM2d6PsSPalOUqenn4qL0lv0Zw3+F4vOKNFSJ/Jvpo=;
        b=V3nduXwGPwq/Ojvi2U48x1tbxnt6oMG9j8EVUz/uiVV8DFvvrJy3PHM4B58+ipWJ3I
         3di9wmGR8g2cBGdnX8CWa1p6xjqH+zTLLp95PjyywYo+UPR/QBWy2qOSNg0tz95UW/t4
         U1CtJlsU3Qhp63lazzxLrY7CWKQZfDW/PR1PeSiSW3g6AyFTfOfhvYMmSNDSveowD6aC
         9V8k4kzRWi3WDIoYvzV1ZKSEMeLg/I5Mh71ZqVXzwlIdQxohzbl1ZdVfwihugFS+g3wB
         6IHx27s3IEMkiDcCZsm0QVXPSYIofDgasttH1MBQB5JuLs4cxSPss7IPnKwE5vPAXRxF
         o0wg==
X-Gm-Message-State: AOAM530RHdU53zw5jKLqyWnPiIXE1jOSyH6Mw7Sl1DmUeMuLgMWOedg0
        nI3dkrJ/38Y/6Y3WcCsZMZU5g1Ek/Zvx9ZogdjqRlQvR
X-Google-Smtp-Source: ABdhPJwTtzq4tcdimrv7U1we8IKGv6gakfrEJoZwxjYVTPsZvjFQnmtAOyfLNeB7UW8XpgSQq24iN5SUjajFL3AEquo=
X-Received: by 2002:a37:a89:: with SMTP id 131mr13065999qkk.92.1590865749879;
 Sat, 30 May 2020 12:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com> <8f36e30cd2218fa56fb0c2b89f6f51726b0eb285.1590759624.git.gitgitgadget@gmail.com>
 <20200530140847.GC2151@danh.dev>
In-Reply-To: <20200530140847.GC2151@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 31 May 2020 00:38:57 +0530
Message-ID: <CAKiG+9XrSb_WeLVzjSqQmdHRqUeha+cRRAFmAJeC_=9o3DB3iQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] cmake: support for building git on windows with
 msvc and clang.
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 7:38 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2020-05-29 13:40:23+0000, Sibi Siddharthan via GitGitGadget <gitgitgad=
get@gmail.com> wrote:
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
> > instead of setting errno=3DEINVAL when invalid arguments are passed to
> > standard functions.
> > This commit explains it in detail:
> > 4b623d80f73528a632576990ca51e34c333d5dd6
>
> I think it's better to say:
>
>         See 4b623d80f7 (MSVC: link in invalidcontinue.obj for better
>         POSIX compatibility, 2014-03-29) for detail.
>
>
> (I haven't read the referenced commit, FWIW)
>
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
> > CC=3DClang cmake `relative-path-to-srcdir` -G Ninja
>
> I think you meant CC=3Dclang, note the lowercase c,
> that will cmake this note applicable for case-sensitive filesystem.
>
> ... reading this patch ...
>
> So, this is applicable for Windows only, it's fine as is, then.
> It's still better to lowercase it, though.

will change it,(typo)

>
> >               -DCMAKE_BUILD_TYPE=3D[Debug or Release]
> >
> > On cmd
> > set CC=3DClang
> > cmake `relative-path-to-srcdir` -G Ninja
> >               -DCMAKE_BUILD_TYPE=3D[Debug or Release]
> >
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  contrib/buildsystems/CMakeLists.txt | 55 +++++++++++++++++++++++------
> >  1 file changed, 45 insertions(+), 10 deletions(-)
> >
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems=
/CMakeLists.txt
> > index 46197d0b806..0a3f711db88 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -98,8 +98,11 @@ find_package(ZLIB REQUIRED)
> >  find_package(CURL)
> >  find_package(EXPAT)
> >  find_package(Iconv)
> > -find_package(Intl)
> >
> > +#Don't use libintl on Windows Visual Studio and Clang builds
> > +if(NOT (WIN32 AND (CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMP=
ILER_ID STREQUAL "Clang")))
>
> Personally, I find this is a bit ugly.
> Does it work to move the if(WIN32) down there, here.
> Then make sub-condition for MSVC and Clang?
>
> > +     find_package(Intl)
> > +endif()
> >
> >  if(NOT Intl_FOUND)
> >       add_compile_definitions(NO_GETTEXT)
> > @@ -123,7 +126,7 @@ if(Intl_FOUND)
> >  endif()
> >
> >
> > -if(WIN32)
> > +if(WIN32 AND NOT MSVC)#not required for visual studio builds
>

Can do that.

> for the down there, I meant here.
> Using "NOT MSVC" here and `CMAKE_C_COMPILER_ID STREQUAL "MSVC"` above
> may puzzle people interest in this patch.
>
> >       find_program(WINDRES_EXE windres)
> >       if(NOT WINDRES_EXE)
> >               message(FATAL_ERROR "Install windres on Windows for resou=
rce files")
> > @@ -135,6 +138,13 @@ if(NOT MSGFMT_EXE)
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
> >  add_compile_definitions(GIT_HOST_CPU=3D"${CMAKE_SYSTEM_PROCESSOR}")
> > @@ -172,6 +182,10 @@ endif()
> >
> >  #Platform Specific
> >  if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
>
> I missed this line from previous patch
> (and my comment in previous round, which suggested remove ${})
> Does `if(WIN32)` and `if(CMAKE_SYSTEM_NAME STREQUAL "Windows")` have
> different meanings?
> I don't know much about CMake on Windows to really sure about this.
>

They are the same.
The reason for using CMAKE_SYSTEM_NAME instead of (WIN32,UNIX,APPLE...) is =
that
if you specify `if(UNIX)` it means both Linux and Darwin, whereas if you sp=
ecify
if(CMAKE_SYSTEM_NAME STREQUAL "Linux") it means Linux only.

Thank You,
Sibi Siddharthan

> --
> Danh
