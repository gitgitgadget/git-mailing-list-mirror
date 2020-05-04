Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CECC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE17B20707
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY1EDuKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEDVkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgEDVkT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 17:40:19 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09218C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 14:40:19 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k18so223862ion.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9f1Ia8NOl3AFs/F5eGf6k3uq1PqrICJafz1vxtdlUKE=;
        b=oY1EDuKgH1lcTchWo3q+/lbfJjP6T2X5WpFWYWlur/wB3OCwjOJl5sEShyxb/V5YRR
         tJJJxV3NcKFzOz+V4LT8djjkIzlwp9IpJab6wwaZ1SsDFMUJOhIHfpG5BRbMGY9Xarhn
         uGQhrTxjC8fjdMZx3hdD62vP4WQ9z94ckwh2DOni0vy5xl0V7yIdZ9RhRQsGlvcpQjhR
         10wU6C1rmS26vcTWn4+QUWrmj7n0eCriNzF+8+p27LHi/3B1ZtkJE9Tljwi3PwhtwLzR
         /ahc9zEO0HDHZI4I6Dwcn3sElpPPG2hjIQFweVHDg+T+FtzEuaM3RBX7ngvHV6R74KGg
         Xtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9f1Ia8NOl3AFs/F5eGf6k3uq1PqrICJafz1vxtdlUKE=;
        b=aFQ52J4dId21geWEApJEU6XUZXTY14umEYx58eiBihzy1YX8krMqoAwClP3QV4dV8S
         BzYNeFz5AmjyUVi8Bl7Vx817vJk8FQjPwsCMsuXLCt/GIlPZFtmmXlitcSjPdJt7KZSm
         VNd5KUiZ60qXyvDjxZhJst94JbFg8ZGTPJFX+rPiclv/TO5WKKYDnu0Az1jBRrEs38aq
         4Jra/qo3Yy9ZxBpizvQrBgJt3i4Ry2K2L1lS9Q2b/3Trr0IzHqMJ5mXXSbLvOoO+Ut+i
         zPz+mEQzZe6GVDHnPIwOylq4dugLsvgFjOLMjBd1rDz/xQ5Zsb9R7Wnh2GPLqeYC8yNm
         JmwQ==
X-Gm-Message-State: AGi0Pub/lylXxHhvcJbb0qZX5H2OKQ4uyBbMPrlx8QY6hSOFrpXkyQFP
        k2QzJW9DmuW1p5NIZwoBF3CPTBMrfj1DhwCjOZk=
X-Google-Smtp-Source: APiQypJtdSErbabx8PxaWFmr7/LC5LgqMANKn2xonzBMtEvlWIG3UBRQMMZf/ESFYfg/ZSJEVuMiRvpU0GO74gn+aP4=
X-Received: by 2002:a6b:750c:: with SMTP id l12mr410510ioh.66.1588628418304;
 Mon, 04 May 2020 14:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP> <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
 <20200504190830.g2tlrognjw6ddipo@tb-raspi4> <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com>
 <20200504201944.gh3zykhil3txdwnk@tb-raspi4> <CAH8yC8mLvG-wqrws6fnXdnuoLAoDfPqgynG9MKoSnJLhPCYu+A@mail.gmail.com>
In-Reply-To: <CAH8yC8mLvG-wqrws6fnXdnuoLAoDfPqgynG9MKoSnJLhPCYu+A@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 4 May 2020 17:39:50 -0400
Message-ID: <CAH8yC8nyg6pRStrQxkO6DzqRbLhhza0vx1U1cGUV4P4MQ3jZ7Q@mail.gmail.com>
Subject: Re: Git 2.26.2 and failed self tests on OS X
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 4, 2020 at 4:30 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Mon, May 4, 2020 at 4:19 PM Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> > On Mon, May 04, 2020 at 03:20:11PM -0400, Jeffrey Walton wrote:
> > > ...
> > > > Does
> > > > ./t3902-quoted.sh   -v -d
> > > > give anything useful ?
> > >
> > > Yes, it looks like the command reveals a couple of problems.
> > >
> > > I'll have to look into my iconv recipe. It has not changed in a while=
,
> > > so something else may be responsible for the failure.
> > > https://github.com/noloader/Build-Scripts/blob/master/build-iconv.sh.
> > >
> > > I'm not sure what to do with the HEAD problems.
> > >
> > > $ ./t3902-quoted.sh   -v -d
> > > Initialized empty Git repository in
> > > /Users/jwalton/Build-Scripts/git-2.26.2/t/trash
> > > directory.t3902-quoted/.git/
> > > expecting success of 3902.1 'setup':
> > >
> > >         mkdir "$FN" &&
> > >         for_each_name "echo initial >\"\$name\"" &&
> > >         git add . &&
> > >         git commit -q -m Initial &&
> > >
> > >         for_each_name "echo second >\"\$name\"" &&
> > >         git commit -a -m Second &&
> > >
> > >         for_each_name "echo modified >\"\$name\""
> > >
> > >
> > > fatal: iconv_open(UTF-8,UTF-8-MAC) failed, but needed:
> > >     precomposed unicode is not supported.
> > >     If you want to use decomposed unicode, run
> > >     "git config core.precomposeunicode false"
> > >
> >
> > I am quite sure, that the trouble starts here.
> > It seems as if you are building iconv yourself ?
> > And that iconv does not include "UTF-8-MAC", which is a specialty
> > for Mac.
>
> Oh, thanks. I was not aware.
>
> I'll open a bug report with the iconv folks letting them know
> configure has some gaps on OS X.

Thanks again Torsten.

I am not seeing an option to enable the encoding in iConv. Would you
happen to know what is needed?

Thanks again.

$ cd libiconv-1.16
$ ./configure --help
`configure' configures libiconv 1.16 to adapt to many kinds of systems.

Usage: ./configure [OPTION]... [VAR=3DVALUE]...

To assign environment variables (e.g., CC, CFLAGS...), specify them as
VAR=3DVALUE.  See below for descriptions of some of the useful variables.

Defaults for the options are specified in brackets.

Configuration:
  -h, --help              display this help and exit
      --help=3Dshort        display options specific to this package
      --help=3Drecursive    display the short help of all the included pack=
ages
  -V, --version           display version information and exit
  -q, --quiet, --silent   do not print `checking ...' messages
      --cache-file=3DFILE   cache test results in FILE [disabled]
  -C, --config-cache      alias for `--cache-file=3Dconfig.cache'
  -n, --no-create         do not create output files
      --srcdir=3DDIR        find the sources in DIR [configure dir or `..']

Installation directories:
  --prefix=3DPREFIX         install architecture-independent files in PREFI=
X
                          [/usr/local]
  --exec-prefix=3DEPREFIX   install architecture-dependent files in EPREFIX
                          [PREFIX]

By default, `make install' will install all the files in
`/usr/local/bin', `/usr/local/lib' etc.  You can specify
an installation prefix other than `/usr/local' using `--prefix',
for instance `--prefix=3D$HOME'.

For better control, use the options below.

Fine tuning of the installation directories:
  --bindir=3DDIR            user executables [EPREFIX/bin]
  --sbindir=3DDIR           system admin executables [EPREFIX/sbin]
  --libexecdir=3DDIR        program executables [EPREFIX/libexec]
  --sysconfdir=3DDIR        read-only single-machine data [PREFIX/etc]
  --sharedstatedir=3DDIR    modifiable architecture-independent data [PREFI=
X/com]
  --localstatedir=3DDIR     modifiable single-machine data [PREFIX/var]
  --libdir=3DDIR            object code libraries [EPREFIX/lib]
  --includedir=3DDIR        C header files [PREFIX/include]
  --oldincludedir=3DDIR     C header files for non-gcc [/usr/include]
  --datarootdir=3DDIR       read-only arch.-independent data root [PREFIX/s=
hare]
  --datadir=3DDIR           read-only architecture-independent data [DATARO=
OTDIR]
  --infodir=3DDIR           info documentation [DATAROOTDIR/info]
  --localedir=3DDIR         locale-dependent data [DATAROOTDIR/locale]
  --mandir=3DDIR            man documentation [DATAROOTDIR/man]
  --docdir=3DDIR            documentation root [DATAROOTDIR/doc/libiconv]
  --htmldir=3DDIR           html documentation [DOCDIR]
  --dvidir=3DDIR            dvi documentation [DOCDIR]
  --pdfdir=3DDIR            pdf documentation [DOCDIR]
  --psdir=3DDIR             ps documentation [DOCDIR]

Program names:
  --program-prefix=3DPREFIX            prepend PREFIX to installed program =
names
  --program-suffix=3DSUFFIX            append SUFFIX to installed program n=
ames
  --program-transform-name=3DPROGRAM   run sed PROGRAM on installed program=
 names

System types:
  --build=3DBUILD     configure for building on BUILD [guessed]
  --host=3DHOST       cross-compile to build programs to run on HOST [BUILD=
]

Optional Features:
  --disable-option-checking  ignore unrecognized --enable/--with options
  --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=
=3Dno)
  --enable-FEATURE[=3DARG]  include FEATURE [ARG=3Dyes]
  --enable-silent-rules   less verbose build output (undo: "make V=3D1")
  --disable-silent-rules  verbose build output (undo: "make V=3D0")
  --enable-dependency-tracking
                          do not reject slow dependency extractors
  --disable-dependency-tracking
                          speeds up one-time build
  --disable-largefile     omit support for large files
  --enable-static[=3DPKGS]  build static libraries [default=3Dno]
  --enable-shared[=3DPKGS]  build shared libraries [default=3Dyes]
  --enable-fast-install[=3DPKGS]
                          optimize for fast installation [default=3Dyes]
  --disable-libtool-lock  avoid locking (might break parallel builds)
  --enable-relocatable    install a package that can be moved in the file
                          system
  --enable-extra-encodings
                          add support for a few rarely used encodings
  --disable-rpath         do not hardcode runtime library paths
  --disable-nls           do not use Native Language Support

Optional Packages:
  --with-PACKAGE[=3DARG]    use PACKAGE [ARG=3Dyes]
  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=3Dno)
  --with-pic[=3DPKGS]       try to use only PIC/non-PIC objects [default=3D=
use
                          both]
  --with-aix-soname=3Daix|svr4|both
                          shared library versioning (aka "SONAME") variant =
to
                          provide on AIX, [default=3Daix].
  --with-gnu-ld           assume the C compiler uses GNU ld [default=3Dno]
  --with-sysroot[=3DDIR]    Search for dependent libraries within DIR (or t=
he
                          compiler's sysroot if not specified).
  --with-gnu-ld           assume the C compiler uses GNU ld [default=3Dno]
  --with-libiconv-prefix[=3DDIR]  search for libiconv in DIR/include and DI=
R/lib
  --without-libiconv-prefix     don't search for libiconv in
includedir and libdir
  --with-libintl-prefix[=3DDIR]  search for libintl in DIR/include and DIR/=
lib
  --without-libintl-prefix     don't search for libintl in includedir and l=
ibdir

Some influential environment variables:
  CC          C compiler command
  CFLAGS      C compiler flags
  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
              nonstandard directory <lib dir>
  LIBS        libraries to pass to the linker, e.g. -l<library>
  CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
              you have headers in a nonstandard directory <include dir>
  CPP         C preprocessor
  LT_SYS_LIBRARY_PATH
              User-defined run-time library search path.

Use these variables to override the choices made by `configure' or to help
it to find libraries and programs with nonstandard names/locations.
