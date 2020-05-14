Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F840C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0867B2054F
	for <git@archiver.kernel.org>; Thu, 14 May 2020 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBfZkqsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgENSbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 14:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbgENSbd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 14:31:33 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C85CC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 11:31:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i5so3969561qkl.12
        for <git@vger.kernel.org>; Thu, 14 May 2020 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GGb1tKRws+HUzp18n/vZtkUImh+/vkkT7bidWgjRq5E=;
        b=pBfZkqsyiNPsjYI+wDxEbIQv2+zPVG4Iw5pTq+AwZj8nIvhFYyqMQuO249b8HA5JEJ
         RaN2tRCoC8af4hi+j506hWfaOfFKEcZl5gFSgtKf76eb8+enXezLNPj3B1oV0crTJszF
         q/YQs4dXhHWr+4Djj4P3r+hMiGmZpuu4Gq6eW1EIJ6Tb3KejQJx7W+rWWc0uzmnQ6akJ
         7xep8QcOeu+AFiRrLZkFU16GzaeVu+cA1vwqYD55iWCKfSQAWLeZe6GJe07vNByuloJ0
         3oFx5qidI0jR9zpPaEVhfbrbs+kX8zxqwYkEMKjRgm6asMPtvuMheLmZRtySC30zw+In
         rpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GGb1tKRws+HUzp18n/vZtkUImh+/vkkT7bidWgjRq5E=;
        b=hk69qTTsabePolluTsxJpnJyFN/pyNYBl112k9AvKbs5hfYe8zAvQ/BdCug/z6OdXg
         VZOHOe0sLJz7y1HKfB44zarTT9irUGQR+3TYl6f/DzTR3mgNWOVYFq2MMNLtIQPH9zP0
         OCY6sTq7PQS5pFfKMk+b5IqGs3cIykEL7k4dwSUoDDWI1B4zLPRM87saGT94cnNWolIc
         Q0CTS4fxwV6LW2urOnvpo+CthpvmNfQNBjKuLju2JIir3XszqinZQBXQ0afxkmLC7mDm
         tE4dbJ74B2A1dqhnkL4o6dwyjjqpsli5qfxQXQSu+eHxxTDCQlom5636cWVqsTAyLIrO
         mpTA==
X-Gm-Message-State: AOAM530quuGKSYtqvTnvHM6kyZ7sVsKfNw3FAG0zNnXCtcjxDk1sUYuG
        Re+DivgYakH84W15dFYz2kHnk/PVDVSbk+aH8uxF9TzP
X-Google-Smtp-Source: ABdhPJxfx3GVeN1apR5HnRW//9I1NkD2eKlCVWk6E68eH4wiOw8nm6LWuYgHTufHsLV1Pz3dgItr/37K1AX1eLN7igY=
X-Received: by 2002:a37:7702:: with SMTP id s2mr6145757qkc.125.1589481090270;
 Thu, 14 May 2020 11:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <f496cd7d8aa12047db7f6c0212fbcb2497469785.1589302255.git.gitgitgadget@gmail.com>
 <20200514153140.GB1939@danh.dev>
In-Reply-To: <20200514153140.GB1939@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Fri, 15 May 2020 00:01:20 +0530
Message-ID: <CAKiG+9Xu2OMnj9JghEbzD358ZdcR6vw5XdswAqimrZWWXLHvJA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] cmake: added checks for struct stat and libiconv
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 9:01 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2020-05-12 16:50:51+0000, Sibi Siddharthan via GitGitGadget <gitgitgad=
get@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > The CMake script now checks whether st_blocks is a member of struct sta=
t
> > and set the compile definition NO_ST_BLOCKS_IN_STRUCT_STAT accordingly.
> >
> > The check for whether ICONV_OMITS_BOM is also added as requested by Dan=
h.
>
> Please don't write my name in the commit message like this.
> This maybe rephased to:
>
>         While we're as it, add the check for ICONV_OMITS_BOM.

Sure, will remove your name from the message.
I added it because gitgitgadget PR bot suggested it as a good practice.

>
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  CMakeLists.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 57 insertions(+), 2 deletions(-)
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 4353080b708..975791c8b89 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -22,6 +22,7 @@ project(git
> >  include(CheckTypeSize)
> >  include(CheckCSourceRuns)
> >  include(CheckCSourceCompiles)
> > +include(CheckCSourceRuns)
> >  include(CheckIncludeFile)
> >  include(CheckFunctionExists)
> >  include(CheckSymbolExists)
> > @@ -128,7 +129,7 @@ if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
> >       include_directories(compat/win32)
> >       add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRL=
F NO_UNIX_SOCKETS WIN32
> >                               _CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=
=3D".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
> > -                             NOGDI OBJECT_CREATION_MODE=3D1 __USE_MING=
W_ANSI_STDIO=3D0 NO_ST_BLOCKS_IN_STRUCT_STAT
> > +                             NOGDI OBJECT_CREATION_MODE=3D1 __USE_MING=
W_ANSI_STDIO=3D0
> >                               USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PR=
EVENTS_DELETE USE_WIN32_MMAP
> >                               UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYS=
TEM_IS_SET)
> >       list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat=
/win32/path-utils.c
> > @@ -280,6 +281,11 @@ if(HAVE_CLOCK_MONOTONIC)
> >       add_compile_definitions(HAVE_CLOCK_MONOTONIC)
> >  endif()
> >
> > +#check for st_blocks in struct stat
> > +check_struct_has_member("struct stat" st_blocks "sys/stat.h" STRUCT_ST=
AT_HAS_ST_BLOCKS)
> > +if(NOT STRUCT_STAT_HAS_ST_BLOCKS)
> > +     add_compile_definitions(NO_ST_BLOCKS_IN_STRUCT_STAT)
> > +endif()
> >
> >  #compile checks
> >  check_c_source_runs("
> > @@ -344,7 +350,6 @@ if(NOT HAVE_REGEX)
> >       add_compile_definitions(NO_REGEX NO_MBSUPPORT GAWK)
> >  endif()
> >
> > -
> >  check_c_source_compiles("
> >  #include <stddef.h>
> >  #include <sys/types.h>
> > @@ -368,6 +373,56 @@ if(HAVE_BSD_SYSCTL)
> >       add_compile_definitions(HAVE_BSD_SYSCTL)
> >  endif()
> >
> > +set(CMAKE_REQUIRED_LIBRARIES ${Iconv_LIBRARIES})
> > +set(CMAKE_REQUIRED_INCLUDES ${Iconv_INCLUDE_DIRS})
> > +
> > +check_c_source_compiles("
> > +#include <iconv.h>
> > +
> > +extern size_t iconv(iconv_t cd,
> > +             char **inbuf, size_t *inbytesleft,
> > +             char **outbuf, size_t *outbytesleft);
> > +
> > +int main(){return 0;}"
> > +HAVE_NEW_ICONV)
> > +if(HAVE_NEW_ICONV)
> > +     set(HAVE_OLD_ICONV 0)
> > +else()
> > +     set(HAVE_OLD_ICONV 1)
> > +endif()
> > +
> > +check_c_source_runs("
> > +#include <iconv.h>
> > +#if ${HAVE_OLD_ICONV}
> > +typedef const char *iconv_ibp;
> > +#else
> > +typedef char *iconv_ibp;
> > +#endif
> > +
> > +int main()
> > +{
> > +     int v;
> > +     iconv_t conv;
> > +     char in[] =3D \"a\"; iconv_ibp pin =3D in;
> > +     char out[20] =3D \"\"; char *pout =3D out;
> > +     size_t isz =3D sizeof in;
> > +     size_t osz =3D sizeof out;
> > +
> > +     conv =3D iconv_open(\"UTF-16\", \"UTF-8\");
> > +     iconv(conv, &pin, &isz, &pout, &osz);
> > +     iconv_close(conv);
> > +     v =3D (unsigned char)(out[0]) + (unsigned char)(out[1]);
> > +     return v !=3D 0xfe + 0xff;
> > +}"
>
> I think the closing double-quote should be placed in a newline,
> in order to make sure the source file ended with newline,
> old C standard requires final newline.
>

Okay

Thank You,
Sibi Siddharthan

>
> --
> Danh
