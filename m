Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF6C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73823615E3
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhJVDl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhJVDlx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:41:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF84C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:39:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso4697250pjm.4
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s3KB5z2P+ZVF0Dg7Kma4I+YFYrZeXwj03R/RTeiHzPY=;
        b=YkmGXLMkuXD5cKFYTgUtyTNp0RYlAo9uqC6lFZNDYu3/rJyknRtB+icbVkF+XE1oub
         HsGQ5ZJDyxOcdzRL/TBpn3dJuKOhEcyzJJdu3grmHG1L65OWM19FD6L4Z0Oe/Qd3Kip2
         NWxnh85gfpzOM3a6kmorRXq99/QgWXdr6/2aUtxfU+AHhUMqN04IfPxbMMNfpYSfzeKV
         1dK4giYxTpF3p1ixp9ealqCpTWmklMOCQf5z7c/L7geZXCIxv/A0t1AhE2wMwYSGmQcG
         uAQsTZ3V+Sw4LeTxx2t2qYaetbumTCQclN4AMw/R1TPVi4QVVILHYJk2X+lPqaQQMDex
         g+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s3KB5z2P+ZVF0Dg7Kma4I+YFYrZeXwj03R/RTeiHzPY=;
        b=xkfnhrpz470F8tcwnFmdYSV+cuqbDNld24+Tqo39DmaqwpfKF8Bu4NSdGBlknfo8B2
         qFxsUsvPwbth0eCdZ5wm+pSzWXfenzuhxPl8k7wc+roy6PsWeI1KmFEJG7aYGrvR3qSx
         zDTOW2V3vsPjxN62FEuD6f8Vu0M7qy/BAXc05nxl10YEodElt0ZUWXoBxPGIsPt7bUVr
         Kv9sTTcIAQ8eLgSwmLlcymrTbaLW/fxzkfcUKbl4U37YIXGccnqASHup9WvTilYKSiZE
         iq0qOVzyYCAiS/Y0IF1T8evpFyh0ywRlsK/jGdWmErhHgx7hZMHUFIbBYPJyL72DKNoa
         MNxw==
X-Gm-Message-State: AOAM530rhsfDRnwj0FVRgE6+TDse+1zKuSo8EbGHp4IaQ51FWgIUM7Wv
        3/CImVB6AmubCzgBddJ00yy5kg==
X-Google-Smtp-Source: ABdhPJyEEdNzbQJIfrSkdpUUMvLFymKpH9qMV1bcDk3U9qDtGidEI7Yt1F5+yMT/nnwFfXoYUNmgWw==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr11610366pji.163.1634873976516;
        Thu, 21 Oct 2021 20:39:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3866:91e2:ded9:17f2])
        by smtp.gmail.com with ESMTPSA id h2sm7152252pjk.44.2021.10.21.20.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:39:35 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:39:31 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 09/10] various *.c: use isatty(1|2), not
 isatty(STDIN_FILENO|STDERR_FILENO)
Message-ID: <YXIyc7+ipDVxj7Ff@google.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-09.10-2cf14881ecf-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-09.10-2cf14881ecf-20211013T222329Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 12:28:25AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
> only these two used the stdlib.h macros to refer to them.
> 
> Let's change these for consistency, and because a subsequent commit's
> commit message outlines a recipe to change all of these for ad-hoc
> testing, not needing to match these with that ad-hoc regex will make
> things easier to explain.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Usually I'd really rather see this go the other way and reduce the
number of "magic numbers" in the codebase, but I think file handles are
pretty well-known, so I guess for the sake of brevity it's ok...

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> ---
>  builtin/bisect--helper.c | 2 +-
>  builtin/bundle.c         | 2 +-
>  compat/mingw.c           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 28a2e6a5750..1727cb051fb 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -830,7 +830,7 @@ static int bisect_autostart(struct bisect_terms *terms)
>  	fprintf_ln(stderr, _("You need to start by \"git bisect "
>  			  "start\"\n"));
>  
> -	if (!isatty(STDIN_FILENO))
> +	if (!isatty(1))
>  		return -1;
>  
>  	/*
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 5a85d7cd0fe..df69c651753 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -56,7 +56,7 @@ static int parse_options_cmd_bundle(int argc,
>  
>  static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
>  	int all_progress_implied = 0;
> -	int progress = isatty(STDERR_FILENO);
> +	int progress = isatty(2);
>  	struct strvec pack_opts;
>  	int version = -1;
>  	int ret;
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 9e0cd1e097f..0f545c1a7d1 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2374,7 +2374,7 @@ int mingw_raise(int sig)
>  	switch (sig) {
>  	case SIGALRM:
>  		if (timer_fn == SIG_DFL) {
> -			if (isatty(STDERR_FILENO))
> +			if (isatty(2))
>  				fputs("Alarm clock\n", stderr);
>  			exit(128 + SIGALRM);
>  		} else if (timer_fn != SIG_IGN)
> -- 
> 2.33.1.1346.g48288c3c089
> 
