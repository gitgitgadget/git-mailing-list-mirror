Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E6BC433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 17:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C4D207A4
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 17:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgLCRBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 12:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLCRBI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 12:01:08 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1019C061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 09:00:27 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id p12so1830261qtp.7
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bxiqG1DhiN1UO5GkdJrASCy40sA0hU+MEPQvFeEUBtM=;
        b=DCcngy3A2gtHv66jakSIIh+T9hrR2ybQgsHzF1w7cl1FkXhkspzpl/Qek85G6bdJcO
         kMeYkGrTvHgUlV4lTAYpqlzDgQElUEdtzqn/pYitcm3WRMOO1UPFK5srF2sbl4fQIagt
         xVgaBXeh8fLxWpAde7/vfIiDFCSttcbNEtw556dtJcF/AfL9RQTXmyzKJNeqHV97Uaca
         dYrf/7940gj7zItCCDr/wY+UkpSxF2sHdGoxSgkXq9/WjDWwr4ZnoDv1WvtLCbcR58TU
         qqrNtcjC6lR6MkqAlGZzDalvEvLdytBbjbi8WheX42iPJXBKQD7V1TGhmiG/CdeqAaHi
         bYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bxiqG1DhiN1UO5GkdJrASCy40sA0hU+MEPQvFeEUBtM=;
        b=AsCJ9ekq5XRJsnIUgoSyf9/Z9Fhw9HY+3DzVHVpazCsjnFNlCgJKFoJCtkkc73fGR8
         UK0YVYr7rE2zGgATiMMIFALgPG9g8yNCNxDUt/g+TlORTZXzC3NX6xKgSizJK+7Zs9Tn
         GcXGkJ+ocy2Rbg6wBXg0CNKM+IenB8ieNo3AgMlvp8v0+nJ5biARsxr7PBwmqcEhSf1g
         txJ8V2dJ2dJy8+E+4Mfd0E1BHMuOccw/jmvcGmbrUIbTm16VBUVuVhRdcsFFlaXWDXEp
         4rYCwHlNfLsAFK7JL5vieH1ct2vW8/86xdbg4hwiLeewC8CpI3jRQTEGA+EwhrqkoFb0
         LLrA==
X-Gm-Message-State: AOAM530gvnXrLr1uz9lleCJcQr4EOslvUF3lRiPhdRdFX+2gmDXQ7wEd
        GyTt8keVpCsevU9NycXGnQRZSssX4i4Bgw==
X-Google-Smtp-Source: ABdhPJxXVW8r/E11+SzUNUivhzjKmWFGOv/LEHuxAIgI+wefpP7Mj4QkH0c2N1Kxyy1fvEAJVnjuYQ==
X-Received: by 2002:a05:622a:291:: with SMTP id z17mr4043960qtw.180.1607014826990;
        Thu, 03 Dec 2020 09:00:26 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id e19sm1734121qtp.83.2020.12.03.09.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:00:26 -0800 (PST)
Subject: Re: [PATCH 2/7] merge-ort: add a clear_internal_opts helper
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
 <5d73827b8d6c254f5bc4a99afa421ae34f07182e.1607011187.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42a99014-573f-cc5d-ffa0-b22aec288425@gmail.com>
Date:   Thu, 3 Dec 2020 12:00:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <5d73827b8d6c254f5bc4a99afa421ae34f07182e.1607011187.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2020 10:59 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Move most of merge_finalize() into a new helper function,
> clear_internal_opts().  This is a step to facilitate recursive merges,
> as well as some future optimizations.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index b556897bc0..0654c76c8c 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -194,6 +194,29 @@ static void free_strmap_strings(struct strmap *map)
>  	}
>  }
>  
> +static void clear_internal_opts(struct merge_options_internal *opti,
> +				int reinitialize)
> +{
> +	assert(!reinitialize);

I was first confused by this new assert, but you are essentially
saying "this parameter doesn't do anything (yet)" which makes sense.

> +
> +	/*
> +	 * We marked opti->paths with strdup_strings = 0, so that we
> +	 * wouldn't have to make another copy of the fullpath created by
> +	 * make_traverse_path from setup_path_info().  But, now that we've
> +	 * used it and have no other references to these strings, it is time
> +	 * to deallocate them.
> +	 */
> +	free_strmap_strings(&opti->paths);
> +	strmap_clear(&opti->paths, 1);
> +
> +	/*
> +	 * All keys and values in opti->conflicted are a subset of those in
> +	 * opti->paths.  We don't want to deallocate anything twice, so we
> +	 * don't free the keys and we pass 0 for free_values.
> +	 */
> +	strmap_clear(&opti->conflicted, 0);
...
> -	/*
> -	 * We marked opti->paths with strdup_strings = 0, so that we
> -	 * wouldn't have to make another copy of the fullpath created by
> -	 * make_traverse_path from setup_path_info().  But, now that we've
> -	 * used it and have no other references to these strings, it is time
> -	 * to deallocate them.
> -	 */
> -	free_strmap_strings(&opti->paths);
> -	strmap_clear(&opti->paths, 1);
> -
> -	/*
> -	 * All keys and values in opti->conflicted are a subset of those in
> -	 * opti->paths.  We don't want to deallocate anything twice, so we
> -	 * don't free the keys and we pass 0 for free_values.
> -	 */
> -	strmap_clear(&opti->conflicted, 0);

the rest of this is a clear code move.

Thanks,
-Stolee
