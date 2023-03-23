Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3873FC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 19:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjCWTjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjCWTjK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 15:39:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F30DBCD
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:39:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so1582279wmq.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679600348;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cXA8QzqBa9VGOP4qgR92TdJSdGPvDJ9Zj12/gKLYOg=;
        b=dctsEoblvnfsyVIhjkFy7RS/dPeHvmm7CD28JZAvgmnyuyg0xZ3c/PRqvyDYf5B4v1
         QUrjPO1zKXPWcLJr3Ir9alsSZdx/FPbbvMlwJNIGi9/NQn6/iGJ4R4wW7sMQRczEXhAN
         Dv6osEnGTCQEZtNArhpP7mymOyK85C+KTQ+foJT1Q4N9prJylOdFS6BpI69YN2vjpCfh
         hrIsYZCdmQg9SH6kl/dYFt7VT70CCIHeF5tAH7iYDM2KIdZL83iz0Xylsupm+SiamLb5
         LmHHuUgnz/RQvN0bSPfo001au+6+sP8xozuKoBH0g/Ub5f+hEpeJVhN6HsSr//04a+Br
         LnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600348;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cXA8QzqBa9VGOP4qgR92TdJSdGPvDJ9Zj12/gKLYOg=;
        b=mfOZhriXGOz7V8sDtBAq8vCWzKpKA7kDWC/iydQoP+ZsAqrlJ3knm5iSK/lWdMZCz1
         kQb2aTIoS9INHM6ZvHUyIqTUeN9PzQ4uWRZRrBcHI9urs+Vx20GstT/AWxV5/Rr9yebd
         +Ga74byo/9zF3HZS4/k7bCMLMoBS17M5WEtujrsodwNjrTxJkE6hWutn56MniACS/z5k
         ecTEt8mVpKDNpCE377TtjB819ubR6/YPs1k7mbA4vQeWQXEiCMVMaTnW9H9lJELyO9MP
         4AEESqpJK/FnocqIYBpPvrYKddIzkhgujfkG9RJfdafmUEoD1P3p6WV/H9HFPbJdgRoO
         3YnQ==
X-Gm-Message-State: AO0yUKV6ko0kdkg6ElaJbiQGQNLKzvjxY+fh/c446qdfvgVBqqTLrh27
        jT0fqkw+2keMcP+KYSSuruzZUnOprO4=
X-Google-Smtp-Source: AK7set/vvTVpG/d22PSyyU+wW3RXwh58p3vrP9wDwNEftZqtxWtFWQwAUbei/xZLepSnrBqVzb1OaQ==
X-Received: by 2002:a05:600c:3795:b0:3ed:a82d:dffb with SMTP id o21-20020a05600c379500b003eda82ddffbmr467720wmr.40.1679600348118;
        Thu, 23 Mar 2023 12:39:08 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b003dc434b39c7sm8053891wms.0.2023.03.23.12.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:39:07 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <28e9e0fe-3a00-50f7-2204-57f69a20c693@dunelm.org.uk>
Date:   Thu, 23 Mar 2023 19:39:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/8] rebase: move parse_opt_keep_empty() down
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-3-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162235.995574-3-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald
On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> This moves it right next to parse_opt_empty(), which is a much more
> logical place. As a side effect, this removes the need for a forward
> declaration of imply_merge().

This looks good, it is nice to get rid of that forward declaration

Best Wishes

Phillip

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>   builtin/rebase.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 8ffea0f0d8..491759db19 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -362,19 +362,6 @@ static int run_sequencer_rebase(struct rebase_options *opts)
>   	return ret;
>   }
>   
> -static void imply_merge(struct rebase_options *opts, const char *option);
> -static int parse_opt_keep_empty(const struct option *opt, const char *arg,
> -				int unset)
> -{
> -	struct rebase_options *opts = opt->value;
> -
> -	BUG_ON_OPT_ARG(arg);
> -
> -	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
> -	opts->keep_empty = !unset;
> -	return 0;
> -}
> -
>   static int is_merge(struct rebase_options *opts)
>   {
>   	return opts->type == REBASE_MERGE;
> @@ -969,6 +956,18 @@ static enum empty_type parse_empty_value(const char *value)
>   	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
>   }
>   
> +static int parse_opt_keep_empty(const struct option *opt, const char *arg,
> +				int unset)
> +{
> +	struct rebase_options *opts = opt->value;
> +
> +	BUG_ON_OPT_ARG(arg);
> +
> +	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
> +	opts->keep_empty = !unset;
> +	return 0;
> +}
> +
>   static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
>   {
>   	struct rebase_options *options = opt->value;
