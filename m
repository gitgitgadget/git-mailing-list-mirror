Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF310C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C138661938
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhC2K7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhC2K6y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 06:58:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA9AC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:58:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so5724547pjg.5
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6OeltWF2ckNDwkKLC4RifatQG0uN5MgrSMVbe1l+s44=;
        b=jp1ydfX02aJgB6zyeqymXiERkB1Ydcf7JFwkNaSQSOVy79OO6gWn6Ujo2XL02NtRQ5
         AKHWki5gyWLNJtZ8/+tbXYnMXlkxdF7iT1y92mGWwyH6uF95DsRrDXLjOXRqccTWnxkp
         +94kkLAZjICbcfpYpUmZaM1aPkc/2u/y9wdNL/leQCvr1hhbpIghWedAtQxv+BuI/2Gb
         jNVrwC2xvT1sfsIJvrTGWoVsaENlgtS66vJ2hdVwP8DNJMzSIYaZCVh9E/YV9Kd6W5b2
         nLnDovVPlS+lSBVfTzvDiU3fFTWrVv7RLDgfsLS+I+qJu3dzHT2DlsvJaYq5wor9J79e
         cdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6OeltWF2ckNDwkKLC4RifatQG0uN5MgrSMVbe1l+s44=;
        b=YOc3Nu+pA3qWnnSEYIhrHAXWe7Ewt+SMlkWmW9MIH9gbLddDqGeLIgogyaLmBUi+mZ
         JZ1C3cMxEVz7ZElKcg2XLDxETgpk5r05wg70qh1nrQjJ/YyREDMpYWLkKWRxo+60Zj8n
         mowH/fpkaOp0qfjUaFCwxSEk+05mr/gfCqOLAnZa7SNWLTrik+WQh4Idy220QQoSdOXM
         4my672c/2n1XMW2TwoYfFz1SpZFreqscC4XzZpEA4Ge4fv2/cDHMWDVC9NajSwg7j0Pu
         o/TxbVi0hd9ZGwDVex4mvTv2Ns64HRBNViOXj3B0cYqqs3ctttFk2AD+oLOj7+1G9zdt
         zLhA==
X-Gm-Message-State: AOAM5325LBn7acph31VDLuAzUseHwCdLCvrkuL6sk4nLVrZK+lR3gvCL
        /uVXHo047ULX/IGgg+F2F+VCSmHjopkTpg==
X-Google-Smtp-Source: ABdhPJzLcva+5bKy5j8eleKughphsmBQMqzzajElq4HR+CPV97Rvo4UlMSXoHKCtU0jPcvG51G2sVg==
X-Received: by 2002:a17:90a:9d82:: with SMTP id k2mr25249637pjp.48.1617015533554;
        Mon, 29 Mar 2021 03:58:53 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-74.three.co.id. [180.214.232.74])
        by smtp.gmail.com with ESMTPSA id f65sm9082685pgc.19.2021.03.29.03.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 03:58:53 -0700 (PDT)
Subject: Re: [PATCH v3] column, range-diff: downcase option description
To:     Chinmoy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Chinmoy <chinmoy12c@gmail.com>, git@vger.kernel.org
References: <pull.920.v2.git.1616926582735.gitgitgadget@gmail.com>
 <pull.920.v3.git.1617014753305.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <eb3c37fe-45b1-6a25-c4c5-851dd88649bf@gmail.com>
Date:   Mon, 29 Mar 2021 17:58:51 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.920.v3.git.1617014753305.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/03/21 17.45, Chinmoy via GitGitGadget wrote:
> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> 
> It is customary not to begin the help text for each option given to
> the parse-options API with a capital letter.Various (sub)commands'
> option arrays don't follow the guideline provided by the parse_options
> Documentation regarding the descriptions.
> 
> Downcase the first word of some option descriptions for "column"
> and "range-diff".
> 
> Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> ---
>      column, range-diff: downcase option description
>      
>      It is customary not to begin the help text for each option given to the
>      parse-options API with a capital letter.Various (sub)commands' option
>      arrays don't follow the guideline provided by the parse_options
>      Documentation regarding the descriptions.
>      
>      Downcase the first word of some option descriptions for "column" and
>      "range-diff".
>      
>      Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-920%2Fchinmoy12c%2Fissue_636-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-920/chinmoy12c/issue_636-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/920
> 
> Range-diff vs v2:
> 
>   1:  b032c2fa5b28 ! 1:  61be08b7dd73 Documentation: make (sub)command options conform to TD of option parsing
>       @@ Metadata
>        Author: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>        
>         ## Commit message ##
>       -    Documentation: make (sub)command options conform to TD of option parsing
>       +    column, range-diff: downcase option description
>        
>       -    The Git suite option parsing API's Technical Documentation suggests this
>       -    about the option descriptions of a (sub)command:
>       +    It is customary not to begin the help text for each option given to
>       +    the parse-options API with a capital letter.Various (sub)commands'
>       +    option arrays don't follow the guideline provided by the parse_options
>       +    Documentation regarding the descriptions.
>        
>       -    `description` is a short string to describe the effect of the option.
>       -    It shall begin with a lower-case letter and a full stop (.) shall be
>       -    omitted at the end.
>       -
>       -    Various (sub)commands' option arrays don't follow the guideline provided
>       -    by the parse_options Documentation regarding the descriptions.
>       +    Downcase the first word of some option descriptions for "column"
>       +    and "range-diff".
>        
>            Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
>        
> 
> 
>   builtin/column.c     | 8 ++++----
>   builtin/range-diff.c | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/column.c b/builtin/column.c
> index e815e148aa18..40d4b3bee2dd 100644
> --- a/builtin/column.c
> +++ b/builtin/column.c
> @@ -27,10 +27,10 @@ int cmd_column(int argc, const char **argv, const char *prefix)
>   		OPT_STRING(0, "command", &real_command, N_("name"), N_("lookup config vars")),
>   		OPT_COLUMN(0, "mode", &colopts, N_("layout to use")),
>   		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
> -		OPT_INTEGER(0, "width", &copts.width, N_("Maximum width")),
> -		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("Padding space on left border")),
> -		OPT_INTEGER(0, "nl", &copts.nl, N_("Padding space on right border")),
> -		OPT_INTEGER(0, "padding", &copts.padding, N_("Padding space between columns")),
> +		OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
> +		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding space on left border")),
> +		OPT_INTEGER(0, "nl", &copts.nl, N_("padding space on right border")),
> +		OPT_INTEGER(0, "padding", &copts.padding, N_("padding space between columns")),
>   		OPT_END()
>   	};
>   
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index 78bc9fa77062..50318849d657 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>   	struct option range_diff_options[] = {
>   		OPT_INTEGER(0, "creation-factor",
>   			    &range_diff_opts.creation_factor,
> -			    N_("Percentage by which creation is weighted")),
> +			    N_("percentage by which creation is weighted")),
>   		OPT_BOOL(0, "no-dual-color", &simple_color,
>   			    N_("use simple diff colors")),
>   		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
> 
> base-commit: 84d06cdc06389ae7c462434cb7b1db0980f63860
> 
Patch title and description match, looks OK.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
