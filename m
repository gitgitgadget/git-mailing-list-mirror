Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F431C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1146B611CB
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhI1MMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbhI1MMa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 08:12:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DE3C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:10:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r18so6211345edv.12
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6gojjqoZ+1CBK4Duf2oH1kqWXOiBc1JYuaVHRa3y/zo=;
        b=R9jIvX2KixiJq9T59Y4ei9TYrEzvVeXRg3bDx2IEeRimpTdQp5wJCUk42g9ovOfi7+
         XL0WHtOBdN+A5AeA+bQQ8/2RQziuE9Zbzum4Tx8Ut1M8YQRv0sgAvnMPEw8O341fgdW4
         YoobmGHja46dP9Q2IvSrJ8TR/5sE3/QTP8iIt3wh/YAtyCz9LYlrHN6/0wlqoZ+FnZ6F
         RjncO/vXRNLJAMoPBFRAhNFD3Jlo8PePAVhYpgcELSDwhKAT9bKvzSdyax/32cMJHhHv
         OtFvjyS1wLmnxjh8A1iwFKkeRJ+J/ZOCOIGJe/Xgq9GDorFUp0fApnedd97QpnhKEiij
         3jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6gojjqoZ+1CBK4Duf2oH1kqWXOiBc1JYuaVHRa3y/zo=;
        b=O53vySnto/8I4UWBhgjcFubjcq27a8F9LUchsn3F9qk8KzyCMJppE9ufiNJuVFul0Z
         ktme74XJcWrHbTPS847kMGcv+7ISf0OUaHrWxNxSc28t/djSZQEl36zEbDlkxUfKe4we
         x3DCTKWHcD6n9un+vOct+wNBiyQj0Vaxnmrelivfw/La4jgP6qjcHW4D0nh6Xpw7q2zV
         4LWgEJIkin8/+g63D6iSko/4NFxhNU5xffa3puB6WeQzQV65n82aaFiWkRbbv23i+ei/
         D6NjMgqyF98j1bJm2UoroJtGuCqhrboZ3J8TKKriLejY+PVD2ZMwbzzpMOSI7vKA8fRn
         eaGw==
X-Gm-Message-State: AOAM533iMuYo7wEfLNU+ciGYUXstlWWRqPhnUexAN77MBQnsdaULvvBN
        d8owXNsxlm57BdJZDqipv07OuKfUkMCreg==
X-Google-Smtp-Source: ABdhPJynh/wvsXBPob2sg1p2p8ABt0otuPVQgV3CtUnwS7Kq9g93vobKT4BukE5f6CnlJX28PLLfWg==
X-Received: by 2002:a05:6402:8ce:: with SMTP id d14mr7137163edz.193.1632831048949;
        Tue, 28 Sep 2021 05:10:48 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx11sm10670095ejb.107.2021.09.28.05.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 05:10:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 3/3] config.mak.dev: simplify compiler check for
 multiple compilers
Date:   Tue, 28 Sep 2021 14:07:09 +0200
References: <20210928091054.78895-1-carenas@gmail.com>
 <20210928091054.78895-4-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210928091054.78895-4-carenas@gmail.com>
Message-ID: <87k0j0x5mg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 1da1580e4c (Makefile: detect compiler and enable more warnings in
> DEVELOPER=3D1, 2018-04-14), includes an $(or) of two different filters
> to check for both gcc and clang versions.
>
> As shown in a previous patch, a simpler syntax is available so apply
> the same logic here also for consistency.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  config.mak.dev | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index 90c47d2782..b66fae8665 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -31,7 +31,7 @@ ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
>  DEVELOPER_CFLAGS +=3D -Wtautological-constant-out-of-range-compare
>  endif
>=20=20
> -ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPIL=
ER_FEATURES))),)
> +ifneq ($(filter clang4 gcc6,$(COMPILER_FEATURES)),)
>  DEVELOPER_CFLAGS +=3D -Wextra
>  # if a function is public, there should be a prototype and the right
>  # header file should be included. If not, it should be static.

This looks like a good cleanup and ends up being much more readable.

I wonder if eventually a larger change to simplify this like perhaps the
below wouldn't be nicer. I didn't test it carefully & may have gotten
the logic wrong, which I think somewhat makes the point that reading
this ifeq/ifneq logic (especially the nested bit at the end) is a bit
hard, at least for me:)

Anyway, feel free to ignore the below, and I think it's certainly not
needed for this series, just my 0.02 if you're eventually refactoring
some of this.

diff --git a/config.mak.dev b/config.mak.dev
index 0a87d8cbe9d..df27340b4b0 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -2,6 +2,14 @@ ifndef COMPILER_FEATURES
 COMPILER_FEATURES :=3D $(shell ./detect-compiler $(CC))
 endif
=20
+# These are all the empty string if the compiler *isn't* X or
+# earlier. Note that clang v5, v6 etc. also qualify as "have v4".
+CC_HAVE_CLANG4 =3D $(filter clang4,$(COMPILER_FEATURES))
+CC_HAVE_GCC4 =3D $(filter gcc4,$(COMPILER_FEATURES))
+CC_HAVE_GCC5 =3D $(filter gcc5,$(COMPILER_FEATURES))
+CC_HAVE_GCC6 =3D $(filter gcc6,$(COMPILER_FEATURES))
+CC_HAVE_GCC10 =3D $(filter gcc10,$(COMPILER_FEATURES))
+
 ifeq ($(filter no-error,$(DEVOPTS)),)
 DEVELOPER_CFLAGS +=3D -Werror
 SPARSE_FLAGS +=3D -Wsparse-error
@@ -9,9 +17,9 @@ endif
 DEVELOPER_CFLAGS +=3D -Wall
 ifeq ($(filter no-pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS +=3D -pedantic
-ifneq ($(filter clang4 gcc5,$(COMPILER_FEATURES)),)
+ifneq ($(CC_HAVE_CLANG4)$(CC_HAVE_GCC5),)
 DEVELOPER_CFLAGS +=3D -Wpedantic
-ifneq ($(filter gcc10,$(COMPILER_FEATURES)),)
+ifneq ($(CC_HAVE_GCC10),)
 ifeq ($(uname_S),MINGW)
 DEVELOPER_CFLAGS +=3D -Wno-pedantic-ms-format
 DEVELOPER_CFLAGS +=3D -Wno-incompatible-pointer-types
@@ -29,11 +37,11 @@ DEVELOPER_CFLAGS +=3D -Wunused
 DEVELOPER_CFLAGS +=3D -Wvla
 DEVELOPER_CFLAGS +=3D -fno-common
=20
-ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
+ifneq ($(CC_HAVE_CLANG4),)
 DEVELOPER_CFLAGS +=3D -Wtautological-constant-out-of-range-compare
 endif
=20
-ifneq ($(filter clang4 gcc6,$(COMPILER_FEATURES)),)
+ifneq ($(CC_HAVE_CLANG4)$(CC_HAVE_GCC6),)
 DEVELOPER_CFLAGS +=3D -Wextra
 # if a function is public, there should be a prototype and the right
 # header file should be included. If not, it should be static.
@@ -49,8 +57,8 @@ endif
=20
 # uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
 # not worth fixing since newer compilers correctly stop complaining
-ifneq ($(filter gcc4,$(COMPILER_FEATURES)),)
-ifeq ($(filter gcc5,$(COMPILER_FEATURES)),)
+ifneq ($(CC_HAVE_GCC4),)
+ifeq ($(CC_HAVE_GCC5),)
 DEVELOPER_CFLAGS +=3D -Wno-uninitialized
 endif
 endif
