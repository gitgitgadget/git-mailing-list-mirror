Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85ACC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D66E60EBB
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 11:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbhI1L61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbhI1L60 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 07:58:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76199C061604
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 04:56:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ba1so24263483edb.4
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+k/DgYBNu/bIzpp/iGus5qWusmZ8vH5CnaE+mM3gWAQ=;
        b=BzfhcdLSt7kaK8E0fERu0CeztEetMLbYX21cRpUyWRAum+pq598IQKuF3tcLlP0o5a
         oDKpn2ye+cZnAXUTHNucxGat90RgRASR2nS32R3QFv/wjCnJETUfuzxflYG4WGQW98aE
         lFa5/83GYPo1K4Q/UIiV04doqcI6dkY7amyKqVrAt0gwzBIGCBw8WGHyQOAl4/5tadYR
         NEuwsHIeZCU96iGIFmVbFp5P89wStgxITyZRD+Mb/g3Dyj1AeR7svvX4AHsiOI+wdcgc
         zRrnESJp7LJns9CrExolvl7GUCIJfDGEGZ2v/2QMuBf+2428jU/vVO1ISs1lMATo/xe6
         G6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+k/DgYBNu/bIzpp/iGus5qWusmZ8vH5CnaE+mM3gWAQ=;
        b=4PZPhX0wLCFWKHF57Mlg71MgmJp22t0VDzjw+RI6e63bDtKOL5du7Hh8lFgW1fLz3L
         2pe48rZ/TZ5Mh4TYVWPhbhIb9lO9TofieKKRa9ajIrgaaNk86QV41tmzrp7fYbEhofZi
         OlmdNH5AoKrxgNhpqqMMn4pLEXPuUyvGDORvJ+b0h/HiWTius5Vc/BBVOeLd3s/DjNpo
         TF/K38AJi8bKCHk+1cQy+tZsj3ntA11nejJOgvKXEwnhOCbv3DhdsKThwmLpY4Y3Tu3y
         KXZ8k9ub63HHwxJs9ZNwPXGtPF1kOn9zvmpGDUNlz7I2tgeFfveOI4dWswbqAI9vvEzJ
         ZYVw==
X-Gm-Message-State: AOAM53192GPjBHQmZekqPVk79G/ujZkbKsMnGPgy7TVrAyrJB8OYMHBT
        DOg4XhhlAWkurLlZzKfMb8TSMoOM9PnuCw==
X-Google-Smtp-Source: ABdhPJwMqxiEUQjm8I32VbYjkgNFuvqFjrL05OTV0bhcdUsROp+RjifSoHb8YjLfrWEC6sPkdVrZ8A==
X-Received: by 2002:a05:6402:5186:: with SMTP id q6mr7204345edd.64.1632830204727;
        Tue, 28 Sep 2021 04:56:44 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bd2sm4948717edb.65.2021.09.28.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 04:56:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 1/3] Makefile: restrict -Wpedantic and
 -Wno-pedantic-ms-format better
Date:   Tue, 28 Sep 2021 13:46:14 +0200
References: <20210928091054.78895-1-carenas@gmail.com>
 <20210928091054.78895-2-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210928091054.78895-2-carenas@gmail.com>
Message-ID: <87o88cx69w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 6a8cbc41ba (developer: enable pedantic by default, 2021-09-03)
> enables pedantic mode in as many compilers as possible to help gather
> feedback on future tightening of the net, so lets do so.
>
> -Wpedantic is missing in some really old gcc 4 versions so lets restrict
> it to gcc5 and clang4 (it does work in clang3 AFAIK, but it will be
> unlikely a developer will use such an old compiler anyway).
>
> MinGW gcc is the only one which has -Wno-pedantic-ms-format, and while
> that is available also in older compilers, the Windows SDK provides gcc10
> so lets aim for that.  Note that in order to target the flag to only
> Windows, additional changes were needed in config.mak.uname to propagate
> the OS detection done there.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  config.mak.dev   | 6 +++++-
>  config.mak.uname | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index cdf043c52b..c81be62a5c 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -9,11 +9,15 @@ endif
>  DEVELOPER_CFLAGS +=3D -Wall
>  ifeq ($(filter no-pedantic,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS +=3D -pedantic
> +ifneq ($(filter clang4 gcc5,$(COMPILER_FEATURES)),)
>  DEVELOPER_CFLAGS +=3D -Wpedantic
> -ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
> +ifneq ($(filter gcc10,$(COMPILER_FEATURES)),)
> +ifeq ($(uname_S),MINGW)
>  DEVELOPER_CFLAGS +=3D -Wno-pedantic-ms-format
>  endif
>  endif
> +endif
> +endif
>  DEVELOPER_CFLAGS +=3D -Wdeclaration-after-statement
>  DEVELOPER_CFLAGS +=3D -Wformat-security
>  DEVELOPER_CFLAGS +=3D -Wold-style-definition
> diff --git a/config.mak.uname b/config.mak.uname
> index 76516aaa9a..aa68bbdec7 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -589,6 +589,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	SHELL_PATH =3D /usr/coreutils/bin/bash
>  endif
>  ifneq (,$(findstring MINGW,$(uname_S)))
> +	uname_S :=3D MINGW

Just in terms of implementation, this somewhat pre-dates your change,
but every single other uname we check as a constant. I wonder if this
"findstring" is really needed under MINGW. It was added in f4626df51f6
(Add target architecture MinGW., 2007-12-01).

(Goes and seaches stackoverflow etc.)

Ah yes, it seems it'll emit e.g. "MINGW64_NT-10.0", ew!

In any case, I wonder if we should at least be better off with the
diff-at-the-end on top (untested).

And also not necessarily for this series, but IMO this sort of thing
really longer-term belongs in config.mak.uname (or maybe a
config.mak.dev.uname, ew!). Well, maybe. Anyway, looking at potentially
implementing that we get into similar ordering issues as I noted in my
2/3 comment, i.e. we'd have to hoist "COMPILER_FEATURES" over to the
main Makefile before including both.

So nevermind I guess, but aside from which variable we set/override
where (and feel very free to ignore my musings there) this change LGTM.

diff --git a/config.mak.uname b/config.mak.uname
index aa68bbdec72..0028891ac67 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -11,6 +11,10 @@ uname_R :=3D $(shell sh -c 'uname -r 2>/dev/null || echo=
 not')
 uname_P :=3D $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V :=3D $(shell sh -c 'uname -v 2>/dev/null || echo not')
=20
+ifneq (,$(findstring MINGW,$(uname_S)))
+	uname_S :=3D MINGW
+endif
+
 ifdef MSVC
 	# avoid the MingW and Cygwin configuration sections
 	uname_S :=3D Windows
@@ -588,8 +592,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	SANE_TOOL_PATH =3D /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH =3D /usr/coreutils/bin/bash
 endif
-ifneq (,$(findstring MINGW,$(uname_S)))
-	uname_S :=3D MINGW
+ifeq ($(uname_S),MINGW)
 	pathsep =3D ;
 	HAVE_ALLOCA_H =3D YesPlease
 	NO_PREAD =3D YesPlease
