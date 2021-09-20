Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE69C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1259660F58
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbhITMsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbhITMsB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 08:48:01 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B63C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:46:34 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id ay33so41915744qkb.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/cMzClzwf1a7UVX6kJWdq8uyPAcq64DoQzVStHge1zo=;
        b=qqqPi1RkT0kPtOBX+7cTyY6AzvA4mCUcBTPRIgZG6UI7NNBqTzUjwH6IdlvS3ZAhgI
         cZbrCVYOGqs96yO93AGmZoxprGK+0R+USW1yWsFHPeQeCSwIdO/8TGWAua3EI0/MWCHh
         MN9uNs0M4GLxHadoaxkLGdJZjFE+v7u5j9MMYsC+oyxzZe1NrieA9buASMtAk3cSmWk5
         7eEAdbRyBOjMZIOzIweu7WgtFccAWu8WEvwr9d08jThGlJDJMwlA5U63CPDSREcjeFHt
         SEPAgGniSu3XcOUcgHAWMnbvDXGctcf5gXjLmyTb/z9oMqnkS27ClSMQm348BnASRWYz
         WqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/cMzClzwf1a7UVX6kJWdq8uyPAcq64DoQzVStHge1zo=;
        b=RJH0czjNdvfnOLpjFb6QcPGiPh9Yi/KYTR5fvnRUP2gsdajbfmnGpoMdS60jcPWaNh
         0F80WP4K5xIy+5UMGNkeN8U9/2KvSbSIF4Po8NWZcX/mzMooOA0FcLpiYCg0zKMuK6rz
         unu7v5N7UtGI7xCduuVDlkTU5ad3CcBXHXzar1efehqGxADopfCAKLLi0scxZkWNbVw2
         TBmR55sIFQcyeuVNAn7qQhwzgzYk9hUnP3txMELeJfIUhAyAlHAuAYzUb54j2NQY/U9T
         88rs+SosZLJXpdxXRKpEN7gycNXFY+Nh8x7sg4k0XKoLy2OZT0INFJsp5W10UhAEdGKN
         38Lw==
X-Gm-Message-State: AOAM530iVaXsg1992F6xHvzADOUOZDy3CBvd97lnIRYXh58Xt36ZEyuT
        LQU2hT33TeB18qHj90kySiWvnlBS53131w==
X-Google-Smtp-Source: ABdhPJyZNaKabIsMIPISYhcrKFXzXMwLv9fhxQjQPztNn9LdfU7kJS4SrumD6zcp1vM3G+JdhmynRg==
X-Received: by 2002:a05:620a:25e:: with SMTP id q30mr21050119qkn.159.1632141993575;
        Mon, 20 Sep 2021 05:46:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3dd4:10d2:c651:2ba0? ([2600:1700:e72:80a0:3dd4:10d2:c651:2ba0])
        by smtp.gmail.com with ESMTPSA id e16sm2446490qtx.7.2021.09.20.05.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:46:33 -0700 (PDT)
Subject: Re: [PATCH 1/1] builtin/commit-graph.c: don't accept common
 --[no-]progress
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, avarab@gmail.com,
        dstolee@microsoft.com
References: <cover.1631980949.git.me@ttaylorr.com>
 <e41e65ddf77c596a7926e75bfc15f21c075d0f03.1631980949.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <088241fc-4070-95ea-b5eb-01c7771ee3af@gmail.com>
Date:   Mon, 20 Sep 2021 08:46:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e41e65ddf77c596a7926e75bfc15f21c075d0f03.1631980949.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/18/2021 12:02 PM, Taylor Blau wrote:
> In 84e4484f12 (commit-graph: use parse_options_concat(), 2021-08-23) we
> unified common options of commit-graph's subcommands into a single
> "common_opts" array.
> 
> But 84e4484f12 introduced a behavior change which is to accept the
> "--[no-]progress" option before any sub-commands, e.g.,
> 
>     git commit-graph --progress write ...
> 
> Prior to that commit, the above would error out with "unknown option".
> 
> There are two issues with this behavior change. First is that the
> top-level --[no-]progress is not always respected. This is because
> isatty(2) is performed in the sub-commands, which unconditionally
> overwrites any --[no-]progress that was given at the top-level.
> 
> But the second issue is that the existing sub-commands of commit-graph
> only happen to both have a sensible interpretation of what `--progress`
> or `--no-progress` means. If we ever added a sub-command which didn't
> have a notion of progress, we would be forced to ignore the top-level
> `--[no-]progress` altogether.
> 
> Since we haven't released a version of Git that supports --[no-]progress
> as a top-level option for `git commit-graph`, let's remove it.

I agree that is the best way to respond right now. Moving it to
top-level will need more work.

> @@ -50,8 +50,6 @@ static struct option common_opts[] = {
>  	OPT_STRING(0, "object-dir", &opts.obj_dir,
>  		   N_("dir"),
>  		   N_("the object directory to store the graph")),
> -	OPT_BOOL(0, "progress", &opts.progress,
> -		 N_("force progress reporting")),
>  	OPT_END()
>  };
>  
> @@ -95,6 +93,8 @@ static int graph_verify(int argc, const char **argv)
>  	static struct option builtin_commit_graph_verify_options[] = {
>  		OPT_BOOL(0, "shallow", &opts.shallow,
>  			 N_("if the commit-graph is split, only verify the tip file")),
> +		OPT_BOOL(0, "progress", &opts.progress,
> +			 N_("force progress reporting")),
>  		OPT_END(),
>  	};
>  	struct option *options = add_common_options(builtin_commit_graph_verify_options);
> @@ -246,6 +246,8 @@ static int graph_write(int argc, const char **argv)
>  		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
>  			NULL, N_("maximum number of changed-path Bloom filters to compute"),
>  			0, write_option_max_new_filters),
> +		OPT_BOOL(0, "progress", &opts.progress,
> +			 N_("force progress reporting")),
>  		OPT_END(),

Meanwhile this diff is easy to verify.

Thanks,
-Stolee

