Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED731C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 11:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348896AbhLALX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 06:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348897AbhLALXz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 06:23:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4DEC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 03:20:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d24so51503344wra.0
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 03:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8lG79O4RBWL6P3N6CVtsNq5ypMkk1sSn06uQJhFgDKU=;
        b=ZF+AdGzdVOP/fy3pua+k19m/8QG6JrmcPNS3mZBejdHlNvNGObQSrodbDLpVsUMWrs
         5VrApmRKWBnSIAm2ZZgoQ5djbkKPWILTl9AhIeYxR4ehO1hmin1wdJcEba5p2hAE4EWH
         az2sq2xosxmh79khQaWoNIVA2TqKAkxC5wscwa3/XXbrjPOO6823y7E12gAJXWeSmGEd
         vq3CLEWAYgUdcdth4HdAcWNAsC7LEUYyltn8crrahypJUGgVOXltLea6j4z9fwVo8qMV
         Gkgaumeeyfw5xPgXHVUk251zGm8G7hu5Hp1RJXfBbwqGIQWj+PSdunAZneBvWVCr4SYt
         ylvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8lG79O4RBWL6P3N6CVtsNq5ypMkk1sSn06uQJhFgDKU=;
        b=QR9o3bSWI7aYdu2NHpZR878IdFBxZQz45Gi2h9S5LT3L3BwOOb6bEkL8mzPvNcuwtU
         387RK04W78vejOEnDvSRClm8wXHbDWr5N8i43Pbb1rgb2M2a+rYwF/siakfv+HzRxRWc
         E9u5r1ZVc4AR4Wdt/kVABDswTE9JDi4LvKtqUTPCjAbRe1tUHbP7RHfKIxKe9LFbB7UH
         4sdZb1s8nXbk8zBvUXBwldrwEJF3OZVizWbkvkh8ujgotpEs0sRzCZk1JGeSGIwaT/Vr
         pfy1MDslIVutNVOxj3Q3qEOuvHOGladb3OJI0Vh2wbRlxSQ2xT1oOE+8wr82lXX3m+Ip
         1How==
X-Gm-Message-State: AOAM533DWxovXtSmvhsUF9UbghNaoZTlfZjegXIcQrjuR85HfYE65n3I
        me1AVevX2exThO8Pvt0uaCQ=
X-Google-Smtp-Source: ABdhPJzmcfWuAXmNOk7hDJ/dAjm26QaeIzBhvxWBljWDQDRQg7z7W9zFjdXzc02pkKgA/SjEsaNG8g==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr6016063wrd.52.1638357632822;
        Wed, 01 Dec 2021 03:20:32 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id w2sm18386184wrn.67.2021.12.01.03.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 03:20:32 -0800 (PST)
Message-ID: <a936a701-c13f-346e-69ee-85441ca20641@gmail.com>
Date:   Wed, 1 Dec 2021 11:20:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] add -i: default to the built-in implementation
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?U2xhdmljYSDEkHVracSH?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
 <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 30/11/2021 14:14, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 9a5315edfdf (Merge branch 'js/patch-mode-in-others-in-c',
> 2020-02-05), Git acquired a built-in implementation of `git add`'s
> interactive mode that could be turned on via the config option
> `add.interactive.useBuiltin`.
> 
> The first official Git version to support this knob was v2.26.0.
> 
> In 2df2d81ddd0 (add -i: use the built-in version when
> feature.experimental is set, 2020-09-08), this built-in implementation
> was also enabled via `feature.experimental`. The first version with this
> change was v2.29.0.
> 
> More than a year (and very few bug reports) later, it is time to declare
> the built-in implementation mature and to turn it on by default.
> 
> We specifically leave the `add.interactive.useBuiltin` configuration in
> place, to give users an "escape hatch" in the unexpected case should
> they encounter a previously undetected bug in that implementation.

Thanks for doing this, I agree it is time to switch over - it feels like 
it is quite a while since anyone reported a bug with the C version. Both 
patches look good to me. I've left one minor comment below but it is not 
worth re-rolling just for that. Thanks Slavica for your work on this, 
it's great to have it converted to C.


> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   Documentation/config/add.txt |  6 +++---
>   builtin/add.c                | 15 +++++----------
>   ci/run-build-and-tests.sh    |  2 +-
>   t/README                     |  2 +-
>   t/t2016-checkout-patch.sh    |  2 +-
>   5 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
> index c9f748f81cb..3e859f34197 100644
> --- a/Documentation/config/add.txt
> +++ b/Documentation/config/add.txt
> @@ -7,6 +7,6 @@ add.ignore-errors (deprecated)::
>   	variables.
>   
>   add.interactive.useBuiltin::
> -	[EXPERIMENTAL] Set to `true` to use the experimental built-in
> -	implementation of the interactive version of linkgit:git-add[1]
> -	instead of the Perl script version. Is `false` by default.
> +	Set to `false` to fall back to the original Perl implementation of
> +	the interactive version of linkgit:git-add[1] instead of the built-in
> +	version. Is `true` by default.
> diff --git a/builtin/add.c b/builtin/add.c
> index ef6b619c45e..8ef230a345b 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -237,17 +237,12 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>   	int use_builtin_add_i =
>   		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
>   
> -	if (use_builtin_add_i < 0) {
> -		int experimental;
> -		if (!git_config_get_bool("add.interactive.usebuiltin",
> -					 &use_builtin_add_i))
> -			; /* ok */
> -		else if (!git_config_get_bool("feature.experimental", &experimental) &&
> -			 experimental)
> -			use_builtin_add_i = 1;
> -	}
> +	if (use_builtin_add_i < 0 &&
> +	    git_config_get_bool("add.interactive.usebuiltin",
> +				&use_builtin_add_i))
> +		use_builtin_add_i = 1;
>   
> -	if (use_builtin_add_i == 1) {
> +	if (use_builtin_add_i != 0) {

This could be simplified to "if (use_builtin_add_i)" but don't re-roll 
just for that

Best Wishes

Phillip

>   		enum add_p_mode mode;
>   
>   		if (!patch_mode)
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index cc62616d806..660ebe8d108 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -29,7 +29,7 @@ linux-gcc)
>   	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
>   	export GIT_TEST_MULTI_PACK_INDEX=1
>   	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
> -	export GIT_TEST_ADD_I_USE_BUILTIN=1
> +	export GIT_TEST_ADD_I_USE_BUILTIN=0
>   	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>   	export GIT_TEST_WRITE_REV_INDEX=1
>   	export GIT_TEST_CHECKOUT_WORKERS=2
> diff --git a/t/README b/t/README
> index 29f72354bf1..2c22337d6e7 100644
> --- a/t/README
> +++ b/t/README
> @@ -419,7 +419,7 @@ the --sparse command-line argument.
>   GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
>   by overriding the minimum number of cache entries required per thread.
>   
> -GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
> +GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when false, disables the
>   built-in version of git add -i. See 'add.interactive.useBuiltin' in
>   git-config(1).
>   
> diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> index 71c5a15be00..bc3f69b4b1d 100755
> --- a/t/t2016-checkout-patch.sh
> +++ b/t/t2016-checkout-patch.sh
> @@ -4,7 +4,7 @@ test_description='git checkout --patch'
>   
>   . ./lib-patch-mode.sh
>   
> -if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN false && ! test_have_prereq PERL
> +if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN true && ! test_have_prereq PERL
>   then
>   	skip_all='skipping interactive add tests, PERL not set'
>   	test_done
> 

