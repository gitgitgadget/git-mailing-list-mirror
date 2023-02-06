Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA5C636D4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 16:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjBFQU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjBFQUt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 11:20:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6FC44BB
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 08:20:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r2so10900683wrv.7
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3wrU8Qyouh3D7ghXXfZssTG777hoFILE0d5k41Bekw=;
        b=KYymMxUiQmdZwZgSBkfuoARZby6oSOd3ATbRDm5f3cYmY8sGeNRxlpYu1ISRHDpF8E
         PH4HNbOyCn1OdmyFXoxH79XdfiAa67AkeNtGN8ew8y+lRPwYS8w1JIYkOb0hS0A989Mn
         RKHC1qA93TH37ZHZtxg0hi8jrw9w/AOsj/zWG+cAKEdKL+jXBxZXmMC8GIgw0YefwOuC
         gO8wLi+kQFo8EkuS8+TKxb5jSzkWY9SPIereiGirRq2ByHhd4XENRXIQKoa45IkMP9VH
         KXME28vinWqiqRv9biX9Q23AzyO042ER3Swm2oZstm7l/YnMGunpqSyVcjtG+353fSUA
         x+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3wrU8Qyouh3D7ghXXfZssTG777hoFILE0d5k41Bekw=;
        b=sJSYDbHKmaktLVbTJFyPp/PB4te0ID/gx9A6UZUAZgFPxWsViysdFoRQZJo5mW1EP6
         tRNEqzK8HiQJ6niu0uPlWt09w3gdbIHbjOnWAunhOwWMwkitPzWXSw3eaWSrYP4pwgPn
         z5G+lnI2/tDVgcEkKx4wJAtMcVYc+icr97dQ/tkwpD6Ph0gEarzoaSbH7FVWTuLNLXBM
         DQ9cRX2YqPJ9C6YOkUoNtWiQvtWyaUUI5K4PLuMA4eHMZvrrEaHgnwF03hRr23V6Uw38
         shbpzYtrXg0bkbbPM5kE07tNE9BPfsnhEzGX7xcQHaXTdZ2Q8JQ/YvCq6zcQ4KP88h9u
         SiOA==
X-Gm-Message-State: AO0yUKWUBqAWqfXKfZzP0IjZfb4gjVgQpevDb2YqoVwtxhwkdn4FeyKC
        +dykmJG3SViegCWhP3oblgVZQu2jTo0=
X-Google-Smtp-Source: AK7set8cPzJOEUz9X7jGs33xqWdKdvEj6m5UmsV46fwVPDb3O7hgYTKC1Z2ZrB1dKzvS8ISYN1jV1w==
X-Received: by 2002:a5d:4bce:0:b0:2c3:24f3:8b47 with SMTP id l14-20020a5d4bce000000b002c324f38b47mr18841906wrt.31.1675700429020;
        Mon, 06 Feb 2023 08:20:29 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b003dec22de1b1sm12262058wmq.10.2023.02.06.08.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 08:20:28 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <19a1c71c-d913-8118-a228-da72b5771421@dunelm.org.uk>
Date:   Mon, 6 Feb 2023 16:20:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] diff: consolidate diff algorithm option parsing
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <jcai@gitlab.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <f56bd38ac3f80fb3a7e8c92cadaa57d2b0754b9f.1675568781.git.gitgitgadget@gmail.com>
In-Reply-To: <f56bd38ac3f80fb3a7e8c92cadaa57d2b0754b9f.1675568781.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 05/02/2023 03:46, John Cai via GitGitGadget wrote:
> From: John Cai <jcai@gitlab.com>
> 
> The diff option parsing for --minimal, --patience, --histgoram can all
> be consolidated into one function. This is a preparatory step for the
> subsequent commit which teaches diff to keep track of whether or not a
> diff algorithm has been set via the command line.
> 
> While we're at it, the logic that sets the diff algorithm in
> diff_opt_diff_algorithm() can be refactored into a helper that will
> allow multiple callsites to set the diff algorithm.

You say "while  we're at it" but isn't it a wholly necessary change for 
what you want to do?

This patch basically looks good, I've left a couple of comments below, 
thanks for separating it out as a preparatory step

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>   diff.c | 87 ++++++++++++++++++++++++++++++++++++----------------------
>   1 file changed, 54 insertions(+), 33 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 329eebf16a0..a8a31c81fe7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3437,6 +3437,22 @@ static int diff_filepair_is_phoney(struct diff_filespec *one,
>   	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
>   }
>   
> +static int set_diff_algorithm(struct diff_options *opts,
> +			      const char *alg)
> +{
> +	long value = parse_algorithm_value(alg);
> +
> +	if (value < 0)
> +		return 1;
> +
> +	/* clear out previous settings */
> +	DIFF_XDL_CLR(opts, NEED_MINIMAL);
> +	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> +	opts->xdl_opts |= value;
> +
> +	return 0;
> +}
> +
>   static void builtin_diff(const char *name_a,
>   			 const char *name_b,
>   			 struct diff_filespec *one,
> @@ -5107,17 +5123,40 @@ static int diff_opt_diff_algorithm(const struct option *opt,
>   				   const char *arg, int unset)
>   {
>   	struct diff_options *options = opt->value;
> -	long value = parse_algorithm_value(arg);
>   
>   	BUG_ON_OPT_NEG(unset);
> -	if (value < 0)
> +
> +	if (set_diff_algorithm(options, arg))
>   		return error(_("option diff-algorithm accepts \"myers\", "
>   			       "\"minimal\", \"patience\" and \"histogram\""));
>   
> -	/* clear out previous settings */
> -	DIFF_XDL_CLR(options, NEED_MINIMAL);
> -	options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> -	options->xdl_opts |= value;
> +	return 0;
> +}
> +
> +static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
> +				   const char *arg, int unset)
> +{
> +	struct diff_options *options = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(arg);
> +
> +	if (!strcmp(opt->long_name, "patience")) {
> +		int i;

This is copied from the existing code but as `options->anchors_nr` is a 
size_t it is probably worth converting `i` to a size_t here.

> +		/*
> +		 * Both --patience and --anchored use PATIENCE_DIFF
> +		 * internally, so remove any anchors previously
> +		 * specified.
> +		 */
> +		for (i = 0; i < options->anchors_nr; i++)
> +			free(options->anchors[i]);
> +		options->anchors_nr = 0;
> +	}
> +
> +	if (set_diff_algorithm(options, opt->long_name))
> +		return error(_("available diff algorithms include \"myers\", "
> +			       "\"minimal\", \"patience\" and \"histogram\""));

I think this should be a BUG() as it is a programming error if we reach 
this point.

Best Wishes

Phillip

> +
>   	return 0;
>   }
>   
> @@ -5242,26 +5281,6 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
>   	return 0;
>   }
>   
> -static int diff_opt_patience(const struct option *opt,
> -			     const char *arg, int unset)
> -{
> -	struct diff_options *options = opt->value;
> -	int i;
> -
> -	BUG_ON_OPT_NEG(unset);
> -	BUG_ON_OPT_ARG(arg);
> -	options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
> -	/*
> -	 * Both --patience and --anchored use PATIENCE_DIFF
> -	 * internally, so remove any anchors previously
> -	 * specified.
> -	 */
> -	for (i = 0; i < options->anchors_nr; i++)
> -		free(options->anchors[i]);
> -	options->anchors_nr = 0;
> -	return 0;
> -}
> -
>   static int diff_opt_ignore_regex(const struct option *opt,
>   				 const char *arg, int unset)
>   {
> @@ -5562,9 +5581,10 @@ struct option *add_diff_options(const struct option *opts,
>   			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
>   
>   		OPT_GROUP(N_("Diff algorithm options")),
> -		OPT_BIT(0, "minimal", &options->xdl_opts,
> -			N_("produce the smallest possible diff"),
> -			XDF_NEED_MINIMAL),
> +		OPT_CALLBACK_F(0, "minimal", options, NULL,
> +			       N_("produce the smallest possible diff"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
> +			       diff_opt_diff_algorithm_no_arg),
>   		OPT_BIT_F('w', "ignore-all-space", &options->xdl_opts,
>   			  N_("ignore whitespace when comparing lines"),
>   			  XDF_IGNORE_WHITESPACE, PARSE_OPT_NONEG),
> @@ -5589,10 +5609,11 @@ struct option *add_diff_options(const struct option *opts,
>   		OPT_CALLBACK_F(0, "patience", options, NULL,
>   			       N_("generate diff using the \"patience diff\" algorithm"),
>   			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
> -			       diff_opt_patience),
> -		OPT_BITOP(0, "histogram", &options->xdl_opts,
> -			  N_("generate diff using the \"histogram diff\" algorithm"),
> -			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
> +			       diff_opt_diff_algorithm_no_arg),
> +		OPT_CALLBACK_F(0, "histogram", options, NULL,
> +			       N_("generate diff using the \"histogram diff\" algorithm"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
> +			       diff_opt_diff_algorithm_no_arg),
>   		OPT_CALLBACK_F(0, "diff-algorithm", options, N_("<algorithm>"),
>   			       N_("choose a diff algorithm"),
>   			       PARSE_OPT_NONEG, diff_opt_diff_algorithm),
