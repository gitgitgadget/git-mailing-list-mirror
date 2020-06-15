Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917FDC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D222071A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPuy1hub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgFOT4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgFOT4r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 15:56:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2269BC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:56:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so16963176qka.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SDtjFBJM2ICIR3QBWHkqLiWyzNEj1qIk3IqY036CHtE=;
        b=iPuy1hubOj1E0/b24wsqJF+xDee/OX1HkkFniOluVx6fKNbi1uzftZf2qYpqoLkzG5
         I1VFnmOF+uQWm6vPjASfurJs9Gp+7Y94quYLGm9WrhQWRLgNvejZm6TEpD84WOpehMYX
         bEmdPZ6Wfrhrq5qV8NChrXal9qrEH5k9rtHUl1LdwHKefpLrVwyBcv7n4gNFgyCiJnfV
         V6XPMN+7cBbvgATvJsYP4OiyWfpFAqnbOeXkMHwlLTbFRY3F7ET2Z93GvBcnUEVjQNgj
         pFmEq2L9aVyHrdRQMiR5ncNYfDPW2pzz6LpumeqIRrsq/KL3U9fykLoamA2cKJxPILBL
         fA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SDtjFBJM2ICIR3QBWHkqLiWyzNEj1qIk3IqY036CHtE=;
        b=tklafA4T5dz5LfC9dDFq7ddish62eYwGa5pG0jauYHaoOkqf0l+tuzvcthQkzYDdSP
         ou+WgmxZCGHfEg5A0CjhES7d1riXW2nzYfMRpTgFVuIbAPWqPj7EsTf0l//sd2BFQFbo
         WcpyODYwERub8oiTyS0ayYTSypGqxfoLurh/CchM4EhnPxAUdaS+GxRiwLjcNcwO7BYD
         SjX3w3kz4V59L0QZ/knscf893NuQ6qt0jOJOcGK7hiT32dO4D4qvjXprilhDLRpSJHHt
         fi1iExCWoYPkieT1n0MVzcDS+uQYuXOt3TCDalV+RpMpEb45EcEpUzxmEMCDBnZ+e+dp
         PwRw==
X-Gm-Message-State: AOAM530hHTKW0O98HEJami9js+CYR3ueunzi/1bW+FUhjwSN9oiGCLAj
        bdMcpDaPWyQcRsMOjCED8rVfYYCHt7CNpieMv4mt+ZFN
X-Google-Smtp-Source: ABdhPJwQy2Pv8RiYosO5Aj+uboQjZ2zO/yyoO63vD3zKkIfHYTg707TyYQmjE6WUVtQ0oOnSXN+drhkm+EJRlfXPYdU=
X-Received: by 2002:a37:4696:: with SMTP id t144mr16921844qka.431.1592251006396;
 Mon, 15 Jun 2020 12:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <f85ea0ac0ca5160a23a0a4ea26b7090638bcaf11.1591986566.git.gitgitgadget@gmail.com>
 <20200615140442.1847-1-oystwa@gmail.com>
In-Reply-To: <20200615140442.1847-1-oystwa@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 16 Jun 2020 01:26:35 +0530
Message-ID: <CAKiG+9Xm2h-cXYhd7Mmc6NEa7u2i2cYznBBgHSvMGN15LX3iXQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] cmake: support for building git on windows with
 msvc and clang
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 7:34 PM =C3=98ystein Walle <oystwa@gmail.com> wrote=
:
>
> > +#Force all visual studio outputs to CMAKE_BINARY_DIR
>
> What is the reasoning for this? AFAIK this makes it impossible to customi=
ze it
> from the outside by doing `cmake -DFOO=3Dbar ...`.
>

When you test git, the test system expects the binaries to be in a
particular directory relative to a bunch of miscellaneous
scripts(wrappers,etc).
Since Visual Studio is multi config generator the binaries go into
CMAKE_BINARY_DIR/(Debug|Release|RelWithDebInfo...). By doing it this
way it is a bit easier to handle, along with the other generators like
Makefile or Ninja.


> >  if(WIN32)
> > -     add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
> > -                     COMMAND ${WINDRES_EXE} -O coff -DMAJOR=3D${PROJEC=
T_VERSION_MAJOR} -DMINOR=3D${PROJECT_VERSION_MINOR}
> > -                             -DMICRO=3D${PROJECT_VERSION_PATCH} -DPATC=
HLEVEL=3D0 -DGIT_VERSION=3D"\\\"${PROJECT_VERSION}.GIT\\\""
> > -                             -i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_=
BINARY_DIR}/git.res
> > -                     WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> > -                     VERBATIM)
> > +     if(NOT MSVC)#use windres when compiling with gcc and clang
> > +             add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
> > +                             COMMAND ${WINDRES_EXE} -O coff -DMAJOR=3D=
${PROJECT_VERSION_MAJOR} -DMINOR=3D${PROJECT_VERSION_MINOR}
> > +                                     -DMICRO=3D${PROJECT_VERSION_PATCH=
} -DPATCHLEVEL=3D0 -DGIT_VERSION=3D"\\\"${PROJECT_VERSION}.GIT\\\""
> > +                                     -i ${CMAKE_SOURCE_DIR}/git.rc -o =
${CMAKE_BINARY_DIR}/git.res
> > +                             WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> > +                             VERBATIM)
> > +     else()#MSVC use rc
> > +             add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
> > +                             COMMAND ${CMAKE_RC_COMPILER} /d MAJOR=3D$=
{PROJECT_VERSION_MAJOR} /d MINOR=3D${PROJECT_VERSION_MINOR}
> > +                                     /d MICRO=3D${PROJECT_VERSION_PATC=
H} /d PATCHLEVEL=3D0 /d GIT_VERSION=3D"${PROJECT_VERSION}.GIT"
> > +                                     /fo ${CMAKE_BINARY_DIR}/git.res $=
{CMAKE_SOURCE_DIR}/git.rc
> > +                             WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> > +                             VERBATIM)
> > +     endif()
> >       add_custom_target(git-rc DEPENDS ${CMAKE_BINARY_DIR}/git.res)
> >  endif()
>
> If you list a .rc in the call to add_executable() then CMake knows how to
> handle it and will invoke the resource compiler on it. I am not 100% sure=
 how
> to provide additional arguments right now, but I believe it will lead to
> simpler code than using add_custom_command() and add_custom_target().
>
> =C3=98sse
>

CMake does know how to handle rc commands including defines.
The issue here is the conflicting redefinition of GIT_VERSION which is
used in the source files.
And CMake uses llvm-rc(completely broken as of llvm 9.0) for the rc compile=
r.
Hence the above monstrocity.

Thank You,
Sibi Siddharthan
