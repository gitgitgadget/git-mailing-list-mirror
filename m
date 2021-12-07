Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20202C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 16:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhLGQqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhLGQqc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 11:46:32 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF9C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 08:43:01 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id r26so28762085oiw.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 08:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0t04FazJFxVvU5u6dpvbx6veVRDkYXE5kweBzPzF/4I=;
        b=M5pCS3io8J50lAxl4lBkK+RfPipFZ7uw1k+zwqc9Xtiwn01LyGX1bUeP5SfYrU0f5p
         K/NP3iDWUIl+e10gZeUC8/rb+oOldrO7EkIpXrT+1ghsAHPZ/3jpzZkUQYFfqRhKEsff
         GQ8nzZEEH4LsFFP4gVkQ/CT46Rcz08xuFU5eCb6H5GYuvdQSIIiuoZUvr0lTzlAwvAEM
         u2EWC3e7MVoHqkAPcJON5Pp2zJhTX6g2NeDasuP0MZgrfW0udhsp00pXd/qG598U4WFV
         B9ia1HBQutmzKq1fB6OjHELXHHyoHDtDoRCARyc5hzl6K7PzoxucT7jJyAOid+vCq5yR
         yLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0t04FazJFxVvU5u6dpvbx6veVRDkYXE5kweBzPzF/4I=;
        b=aeX+5+DSOp8DVkMfusYwARPloYCW6c+sVtWbiBYpGCv7flNlkbWJfCZAFc4dF7oQtO
         AyPD270NAZpuS7TWiXv8ZmE9R44YKq5TPc9rdIhRFjsnobku9/3Heb+C+aL/6Q2rYzJF
         9odctqFx/DBz94dO/FxAd7XA376oWx82TgKr2auZ7tY6hnkjsJE80PxvxZhYShQ90YOl
         Yb5w9joKeKOSDt1ukhqvolg9iLDH+6SqStYFaFPUZ2LzhAz+Zw0hK3FGP/QIpCq5JPZs
         Uwbq33RC5QUW+aUzxx5D6uebGPrOywyYgionPyAlyXt3W1Lo7JxMQzUcx6TetZlntBKS
         eX7Q==
X-Gm-Message-State: AOAM532NlG3a+5uJRzS7LY30vix3hFzw4Aqy+SSTvrFtSRfrDE+YUdUb
        jBnnUnExiYjA/wI9mS3rGAymRvdevX0=
X-Google-Smtp-Source: ABdhPJyzC207Z9jPoBa/kYwo495XVtttJBCeAsvfjXUfLEgE7AjcIDkCcNzadaJ2YYidNP/ds8YJPw==
X-Received: by 2002:a05:6808:55:: with SMTP id v21mr6189333oic.174.1638895381077;
        Tue, 07 Dec 2021 08:43:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id q9sm16672oti.32.2021.12.07.08.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:43:00 -0800 (PST)
Message-ID: <0a9946da-b509-beb0-0558-12affab03d0b@gmail.com>
Date:   Tue, 7 Dec 2021 11:42:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/6] sparse-checkout: enable `set` to initialize
 sparse-checkout mode
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <a90687eb4c1ea6569250391cd2a8111a0e338316.1638648020.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a90687eb4c1ea6569250391cd2a8111a0e338316.1638648020.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2021 3:00 PM, Elijah Newren via GitGitGadget wrote:
>  static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  {
> +	int mode, record_mode;
> +	const char *default_patterns[] = {"/*", "!/*/"};

My gut reaction is that this array should be NULL terminated.

> +
>  	static struct option builtin_sparse_checkout_set_options[] = {
> +		OPT_BOOL(0, "cone", &set_opts.cone_mode,
> +			 N_("initialize the sparse-checkout in cone mode")),
> +		OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
> +			 N_("toggle the use of a sparse index")),
>  		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
>  			 N_("read patterns from standard in")),
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

I think it is appropriate to still have the init steps before the modification
of the worktree. I did have a brief pause to think about whether the set_config()
should be delayed until modify_pattern_list() succeeds.

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

Perhaps use 'default_patterns_nr' as a constant near the definition of
'default_patterns' so these numbers are not so far apart?

> +	}
> +
>  	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
>  }

Thanks,
-Stolee
