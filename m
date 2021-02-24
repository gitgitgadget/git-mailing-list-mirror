Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AA8C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0D164EC4
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhBXPw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhBXP0S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 10:26:18 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83514C06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 07:25:37 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id d20so2720646oiw.10
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U/e5DJoEfkxva2STad441Psmpkgn0NQZS432WAjfcMo=;
        b=fU66b2QNvdbnOiSbyBQpGtZxFMdVtSEDmQRVgghs9tPk1yZWfdzi9KtZhyCAk2+A5D
         wLVIxu3Sk6xVrXhnDUA1YjMMrWnCGrb4jZz8yTb9Zq4nFSk9fi/lvyOyK7Z3lTjs/KVX
         ftMr6Ju8Zv7T5B8mngKNBvknCjacn0jBu+BIZ5Alp7XrwAZKw5MyncssG+GmMqyyxIWT
         0oRUJ/3VEPozeULguV4fvbzLtPHhshfAvkw+5p0zsUIX3BBG/Vy6Eq0oOlKAQYrAqc6/
         D3/2pYBTudxcRK01MKLjqbkSBSawp6o69INNA9nlZZY4KUBBUdrr4w3rjVXxjWSplU2g
         dYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U/e5DJoEfkxva2STad441Psmpkgn0NQZS432WAjfcMo=;
        b=cdVAIxDtFiPL7eBtHIoXWCkqxfHFrVG3s1cEN1oCb/w/8i68f5qIkLRfrRzm52Ads2
         70j/Pgd72JiUosOifuzWu1yTYbC4L6d+vVsOKozl6+eYcQcOVtp0e8X7DZPWwwhxkKvP
         beb/vG4n03/gl2x7AY32hiS6/UHWah7MNYwLqCOekEVdLXjuaJzqTPMW05aFnsV7Mmto
         /Tv5CJdvRHi1b30mdUjEBtjLiFAgj601GgH3fG16BvSG5phr13C9iS45IqhqEJ2uCtEy
         C15qJKem8AlpqMSyBvGjVtZC8etZ43I74Gd0qmrg/4nWsk1nH/2XOGG3BvKKuHHYnHIZ
         cO4g==
X-Gm-Message-State: AOAM530NH+/ybQSq+LlhI3m++vGGC4IRjxylcwM6hQ3bnBj1plBGFG7y
        YSCcA6FNm58i15xY6FDdymk=
X-Google-Smtp-Source: ABdhPJxv5pGS769ZQj3AZW0dFaSli1EAGFLwbhSKQ8r39JmHHRiP2DgOwssvM8qAMXiO+IHyvNBDTw==
X-Received: by 2002:aca:3746:: with SMTP id e67mr2945091oia.81.1614180336766;
        Wed, 24 Feb 2021 07:25:36 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:d50a:c289:effe:68e4? ([2600:1700:e72:80a0:d50a:c289:effe:68e4])
        by smtp.gmail.com with UTF8SMTPSA id j10sm452251oos.27.2021.02.24.07.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 07:25:35 -0800 (PST)
Message-ID: <bb0ef143-3050-6f3e-79ed-f06c1536f0a7@gmail.com>
Date:   Wed, 24 Feb 2021 10:25:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 01/10] Move computation of dir_rename_count from
 merge-ort to diffcore-rename
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <fec4f1d44c0694cf92c9b98f2b6519a15fb78188.1614123848.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <fec4f1d44c0694cf92c9b98f2b6519a15fb78188.1614123848.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2021 6:43 PM, Elijah Newren via GitGitGadget wrote:
> ... While the
> diffstat looks large, viewing this commit with --color-moved makes it
> clear that only about 20 lines changed.  With this patch, the
> computation of dir_rename_count is still only done after inexact rename
> detection, but subsequent commits will add a preliminary computation of
> dir_rename_count after exact rename detection, followed by some updates
> after inexact rename detection.

The --color-moved recommendation is a good one. Everything seems to be
pretty standard, except this function:

> +static void compute_dir_rename_counts(struct strmap *dir_rename_count,
> +				      struct strset *dirs_removed)
> +{
> +	int i;
> +
> +	/* Set up dir_rename_count */
> +	for (i = 0; i < rename_dst_nr; ++i) {
> +		/*
> +		 * Make dir_rename_count contain a map of a map:
> +		 *   old_directory -> {new_directory -> count}
> +		 * In other words, for every pair look at the directories for
> +		 * the old filename and the new filename and count how many
> +		 * times that pairing occurs.
> +		 */
> +		update_dir_rename_counts(dir_rename_count, dirs_removed,
> +					 rename_dst[i].p->one->path,
> +					 rename_dst[i].p->two->path);
> +	}
> +}

is very similar to this:

> -static void compute_rename_counts(struct diff_queue_struct *pairs,
> -				  struct strmap *dir_rename_count,
> -				  struct strset *dirs_removed)
> -{
> -	int i;
> -
> -	for (i = 0; i < pairs->nr; ++i) {
> -		struct diff_filepair *pair = pairs->queue[i];
> -
> -		/* File not part of directory rename if it wasn't renamed */
> -		if (pair->status != 'R')
> -			continue;
> -
> -		/*
> -		 * Make dir_rename_count contain a map of a map:
> -		 *   old_directory -> {new_directory -> count}
> -		 * In other words, for every pair look at the directories for
> -		 * the old filename and the new filename and count how many
> -		 * times that pairing occurs.
> -		 */
> -		update_dir_rename_counts(dir_rename_count, dirs_removed,
> -					 pair->one->path,
> -					 pair->two->path);
> -	}
> -}
> -

but we dropped that "File not part of directory rename" check.

It seems that is no longer possible to use with the new data structure,
but I wonder if this will cause a slowdown in the directory renames when
merging? Or, has the data already been filtered before calling
compute_dir_rename_counts()?

Thanks,
-Stolee
