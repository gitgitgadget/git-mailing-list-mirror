Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1358C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 14:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjBHO2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 09:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBHO2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 09:28:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F8F422A
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 06:28:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1612063wms.4
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 06:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5G1vX2JFTprSRloEAfL3sQb4biGkEO2OssDa/xqWUeY=;
        b=ORQcGnIp/GaDh21y05d8f6S8hnqNK5QAsvncpwrEAsn/b+H01Upfnqvss+/SHxzQsB
         8tKIiaNCg1GAogMs1rfnEuiOsVyUH3SawUF/i3STQzsi8w97lyx8rohHxs2XIVyl1qes
         UUfBsxKUxmuhNbPgmUS2/aH43HKw7WfzK+mRXwV+yrJvynIMkvra9SLp7Y9L+3TZkGRu
         sG3vS+qaGYEiC4x2KHiBQVIPB8WPpRfX6FDOknmLGo2HTOEfrnQYn/fjQMziVQ5PaB4v
         xZttaZRZdbzfmBBQR3cN5LqT3o9P2h/yHwmHK887fmZRtgdHX2DaOhM0YVkzh21K1F5O
         WP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G1vX2JFTprSRloEAfL3sQb4biGkEO2OssDa/xqWUeY=;
        b=V7c1g/kaWre2k83UbmABTzt4hRNj/HzKcKKCq+TjqvuYivLnDfbsh/MKooenYKTxNF
         UCE0V0fZZ7AKjczEZhwD22iMZqwNaPr6LNgKSq0lwn6jZTW4KhjPm1pHB0P1gTNgT6fb
         6whzsx291HCugOQjXhfb1geYPmgChg0LMaP/sXK3kCcx23YxCxh1I7j8URcXLQH2zdU3
         jBuGto1ewzxY2wcHmGNssUceYkor7Bx7FLSXHuR4XrnFrAhzq7gQVSu0eWbKkvLMWIKj
         21VFqVfHb88qhkjSjXSL/EY4eICUDOPT4cwNqgsKKwmyK+RRZ+HJuFxCrMQwUQ1vvUQ2
         61RQ==
X-Gm-Message-State: AO0yUKU8nX30H8dC6kiorebidR2Pdz9SIBW1fIHGRm8qU81J4O8bNwDb
        pfHOUOpJpHhbQMZaHNMIQNtIhPe/ZH0=
X-Google-Smtp-Source: AK7set/mNH6goRHYhY6fpMwy9NU2Y9YMMWmU9oChPe3TwgRXrdRHli9EGIqEG+alGInEb5q4aOYKog==
X-Received: by 2002:a05:600c:1d28:b0:3df:ff11:6775 with SMTP id l40-20020a05600c1d2800b003dfff116775mr1769510wms.14.1675866514781;
        Wed, 08 Feb 2023 06:28:34 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id ay42-20020a05600c1e2a00b003dffe312925sm2070386wmb.15.2023.02.08.06.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 06:28:34 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4ae106ed-bfa8-2824-c0c7-6cde32dbe369@dunelm.org.uk>
Date:   Wed, 8 Feb 2023 14:28:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 5/7] diff-lib: refactor out diff_change logic
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-6-calvinwan@google.com>
In-Reply-To: <20230207181706.363453-6-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 07/02/2023 18:17, Calvin Wan wrote:
> Refactor out logic that sets up the diff_change call into a helper
> function for a future patch.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>   diff-lib.c | 46 +++++++++++++++++++++++++++++-----------------
>   1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/diff-lib.c b/diff-lib.c
> index dec040c366..7101cfda3f 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -88,6 +88,31 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
>   	return changed;
>   }
>   
> +static int diff_change_helper(struct diff_options *options,
> +	      unsigned newmode, unsigned dirty_submodule,
> +	      int changed,

I worry that having three integer parameters next to each other makes it 
very easy to mix them up with out getting any errors from the compiler 
because the types are all compatible. Could the last two be combined 
into a flags argument? A similar issues occurs in 
match_stat_with_submodule() in patch 7

Best Wishes

Phillip

  struct index_state *istate,
> +	      struct cache_entry *ce)
> +{
> +	unsigned int oldmode;
> +	const struct object_id *old_oid, *new_oid;
> +
> +	if (!changed && !dirty_submodule) {
> +		ce_mark_uptodate(ce);
> +		mark_fsmonitor_valid(istate, ce);
> +		if (!options->flags.find_copies_harder)
> +			return 1;
> +	}
> +	oldmode = ce->ce_mode;
> +	old_oid = &ce->oid;
> +	new_oid = changed ? null_oid() : &ce->oid;
> +	diff_change(options, oldmode, newmode,
> +			old_oid, new_oid,
> +			!is_null_oid(old_oid),
> +			!is_null_oid(new_oid),
> +			ce->name, 0, dirty_submodule);
> +	return 0;
> +}
> +
>   int run_diff_files(struct rev_info *revs, unsigned int option)
>   {
>   	int entries, i;
> @@ -105,11 +130,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>   		diff_unmerged_stage = 2;
>   	entries = istate->cache_nr;
>   	for (i = 0; i < entries; i++) {
> -		unsigned int oldmode, newmode;
> +		unsigned int newmode;
>   		struct cache_entry *ce = istate->cache[i];
>   		int changed;
>   		unsigned dirty_submodule = 0;
> -		const struct object_id *old_oid, *new_oid;
>   
>   		if (diff_can_quit_early(&revs->diffopt))
>   			break;
> @@ -245,21 +269,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>   			newmode = ce_mode_from_stat(ce, st.st_mode);
>   		}
>   
> -		if (!changed && !dirty_submodule) {
> -			ce_mark_uptodate(ce);
> -			mark_fsmonitor_valid(istate, ce);
> -			if (!revs->diffopt.flags.find_copies_harder)
> -				continue;
> -		}
> -		oldmode = ce->ce_mode;
> -		old_oid = &ce->oid;
> -		new_oid = changed ? null_oid() : &ce->oid;
> -		diff_change(&revs->diffopt, oldmode, newmode,
> -			    old_oid, new_oid,
> -			    !is_null_oid(old_oid),
> -			    !is_null_oid(new_oid),
> -			    ce->name, 0, dirty_submodule);
> -
> +		if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
> +				       changed, istate, ce))
> +			continue;
>   	}
>   	diffcore_std(&revs->diffopt);
>   	diff_flush(&revs->diffopt);
