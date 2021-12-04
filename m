Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B29DC433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 21:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355746AbhLDVna (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 16:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhLDVn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 16:43:28 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EBFC061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 13:40:02 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f20so7103763qtb.4
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 13:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=k5zTgsVHPAMdwPToSsb15YwiAle7vVYgNCz3WKH11J8=;
        b=RAul5Q3DdNbILLsvvoidTvH42sQ07MZCdnCe6rJLM43cTOMZHZaF11FjDvG2XBzB61
         OHYGKs3SwT3Gibhb+lZOIeykmapCwS+WY/hcsWlfbj8C1HLjm7zevbl5NhVw9ZCaYErE
         YybXEkBgRnGMTPzHySqtCBnc2Q1NnWdrF3nksnOpayEK3g67GcHwGTGYGLDJsrUBm5e0
         5cac0f5y0TnOnU/S0dNGmG2peSfYO8XWn8RxkMO3WKr/c/DQAyZbFlqUyd8F8fGy1dyl
         D45Fsd6oZUzHAd9tJoESI3CsoYpb8Wey+lt2eS0YErswNyHw8tVomZ3gKJy66LcPJ9JB
         kD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k5zTgsVHPAMdwPToSsb15YwiAle7vVYgNCz3WKH11J8=;
        b=6ilpy1UMbzZlSUcLmeIeC/8+0sZ7jDJR+gI68FfDfy1b31AVtYCZCyGSXOcrbL0n9t
         7Kd2OUBfDWwELB6foFcp4KtgzR8gkZSDyfGMI1A+RQCq0tL9yBQ1zLGp3UGp0D+15A5g
         OTu0+dT5lGrlnpgGs6M86SteLGJaZWmgsx6IAmHr/XgnYMT0uHPaUpufpU5VkqtCSKu6
         UqpK03C5etbQU8sOdB4pLEc/FBEBVXArDgqrlLhczZcTNvHAQi/t7WK9Z/OeEqxuBRLl
         Cqjkbc+iGhy8JifzZaa0uN22iWaH+ALe+mQaCQzhFpO8CkoT44dGDuGhichBhrHfuULP
         qfaw==
X-Gm-Message-State: AOAM5322t8yCeLqdHBsYG26bE8m1ckZgxBgDJFtv/o29Mk689PhJ/N/3
        Sbhisbk6jMpCCTnjU4kA6HSi
X-Google-Smtp-Source: ABdhPJxtHtZgQxBa+wJ020uGexBok2B7t6dsngJQFyF40Mn0hIBHFGyOXCwkX61XYQvUAGibsibu1w==
X-Received: by 2002:a05:622a:50d:: with SMTP id l13mr29163807qtx.649.1638654002007;
        Sat, 04 Dec 2021 13:40:02 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id p1sm4183443qke.109.2021.12.04.13.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 13:40:01 -0800 (PST)
Message-ID: <bb738571-f90c-7df5-2e20-ff716ed8a4f0@github.com>
Date:   Sat, 4 Dec 2021 16:40:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 3/6] sparse-checkout: enable `set` to initialize
 sparse-checkout mode
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <a90687eb4c1ea6569250391cd2a8111a0e338316.1638648020.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <a90687eb4c1ea6569250391cd2a8111a0e338316.1638648020.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The previously suggested workflow:
>   git sparse-checkout init ...
>   git sparse-checkout set ...
> 
> Suffered from three problems:
>   1) It would delete nearly all files in the first step, then
>      restore them in the second.  That was poor performance and
>      forced unnecessary rebuilds.
>   2) The two-step process resulted in two progress bars, which
>      was suboptimal from a UI point of view for wrappers that
>      invoked both of these commands but only exposed a single
>      command to their end users.
>   3) With cone mode, the first step would delete nearly all
>      ignored files everywhere, because everything was considered
>      to be outside of the specified sparsity paths.  (The user was
>      not allowed to specify any sparsity paths in the `init` step.)
> 
> Avoid these problems by teaching `set` to understand the extra
> parameters that `init` takes and performing any necessary initialization
> if not already in a sparse checkout.
> 

I really like this change! It always seemed weird that `set` would
implicitly `init`, but without any of the options in `init`.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/sparse-checkout.c | 52 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index e252b82136e..cf6a6c6c3a7 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -682,17 +682,26 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
>  }
>  
>  static char const * const builtin_sparse_checkout_set_usage[] = {
> -	N_("git sparse-checkout set (--stdin | <patterns>)"),
> +	N_("git sparse-checkout set [--cone] [--[no-]sparse-index] (--stdin | <patterns>)"),

Since `cone` is an `OPT_BOOL`, shouldn't it appear in the usage string as
`--[no-]cone`? Without a `--no-cone` option, it's not clear how a user would
disable cone mode (since `set` preserves the existing cone mode setting if
`--cone` isn't given).

>  	NULL
>  };
>  
>  static struct sparse_checkout_set_opts {
> +	int cone_mode;
> +	int sparse_index;
>  	int use_stdin;
>  } set_opts;
>  
>  static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  {
> +	int mode, record_mode;
> +	const char *default_patterns[] = {"/*", "!/*/"};
> +
>  	static struct option builtin_sparse_checkout_set_options[] = {
> +		OPT_BOOL(0, "cone", &set_opts.cone_mode,
> +			 N_("initialize the sparse-checkout in cone mode")),
> +		OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
> +			 N_("toggle the use of a sparse index")),
>  		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
>  			 N_("read patterns from standard in")),

I know this isn't part of this patch, but is `stdin` really a bool (i.e.
someone might specify `--no-stdin`)? If not, I think `OPT_SET_INT` might be
more appropriate.

>  		OPT_END(),
> @@ -700,11 +709,52 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  
>  	repo_read_index(the_repository);
>  
> +	set_opts.cone_mode = -1;
> +	set_opts.sparse_index = -1;
> +
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_sparse_checkout_set_options,
>  			     builtin_sparse_checkout_set_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN);
>  
> +	/* Determine if we need to record the mode; ensure sparse checkout on */
> +	record_mode = (set_opts.cone_mode != -1) || !core_apply_sparse_checkout;
> +	core_apply_sparse_checkout = 1;
> +
> +	/* If not specified, use previous definition of cone mode */
> +	if (set_opts.cone_mode == -1 && core_apply_sparse_checkout)

I *think* this is supposed go before the `core_apply_sparse_checkout = 1;`
above it (if the intention is to only use the pre-existing cone mode setting
when already in a sparse checkout). If not, the `core_apply_sparse_checkout`
part of the condition is redundant and can be removed entirely.

> +		set_opts.cone_mode = core_sparse_checkout_cone;
> +
> +	/* Set cone/non-cone mode appropriately */
> +	if (set_opts.cone_mode == 1) {
> +		mode = MODE_CONE_PATTERNS;
> +		core_sparse_checkout_cone = 1;
> +	} else {
> +		mode = MODE_ALL_PATTERNS;
> +	}
> +	if (record_mode && set_config(mode))
> +		return 1;
> +
> +	/* Set sparse-index/non-sparse-index mode if specified */
> +	if (set_opts.sparse_index >= 0) {
> +		if (set_sparse_index_config(the_repository, set_opts.sparse_index) < 0)
> +			die(_("failed to modify sparse-index config"));
> +
> +		/* force an index rewrite */
> +		repo_read_index(the_repository);
> +		the_repository->index->updated_workdir = 1;
> +	}
> +
> +	/*
> +	 * Cone mode automatically specifies the toplevel directory.  For
> +	 * non-cone mode, if nothing is specified, manually select just the
> +	 * top-level directory (much as 'init' would do).
> +	 */
> +	if (!core_sparse_checkout_cone && argc == 0) {
> +		argv = default_patterns;
> +		argc = 2;
> +	}
> +
>  	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
>  }
>  
> 

