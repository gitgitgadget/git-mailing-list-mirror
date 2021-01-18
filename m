Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D47CC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD61422D08
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437657AbhART6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 14:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406816AbhARTz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 14:55:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCCFC0613CF
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 11:54:43 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b64so19775929qkc.12
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Blc02q7NGl3kDbjS5YCfcBkdhyKBLe3NPtGj3XXT3E=;
        b=pvuT0K0vS1+vkG0lHudZzj9MFyMhzOGh18Vby00+l5RPtCQ/+YBPrCY7XsUOE/WwL8
         iF6C4YDFZ8nVQuxyPA2HJYKR9DYcdu+zzTWrUZ37LZvq6CNZrNVurr3ISun7bXF0mJxN
         nZFu4elbQ1XshNlWMd+nKYa2Zz/MZIIUwX+U5fIdzSwu2JW9Y6Qj5eJB+Co5ND6OqaTf
         3/j3L+F4GTmWmHjuYEvfP+a0IMvFx/88A8ENTlwXnK/mlKFZ6/FdiOLU3W0zE9LGjESR
         PyMoeALeW3DFR9/KNWV+kEa5QLyIiZGA0lz+QLbYGEYi/79M87AHe4QGlYdw+J4/Qmn6
         Sgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Blc02q7NGl3kDbjS5YCfcBkdhyKBLe3NPtGj3XXT3E=;
        b=EFaGMMEW0+u/jH8J7uZfkINDZJMAN0/QasTNesuQ1uq4oZgacaACOA0nAqXUYG1lZ8
         TfM6UmSsHdiuUG2tt2WZJvLzcgWNC8ey2bjSr7TaULztjoLRtUNBYZMWNsqWmN7d02jH
         OZCXLOwliwnx/LQKDwkeLHXPRrc4E8baWyz471HakJtS0tycf1uh+UR2VnWz0+MIIQPc
         8Aof/eegb0yVs9pUj7KdLkX77bcBNkBARHIw0YLeaTlbPj8hpVTOH0/CfV4q6Pj7nEZ+
         KB/UIgquJgGc2Rh6749En9iW8N+Z3Tg6to/VJFZ5gUAFkKSjvVqdTI1VQjv1Rc2Du0XB
         LUyw==
X-Gm-Message-State: AOAM530LdakfiWVetnQpN72RVwPotHUNHUNBzK4u22ds/Ua1Q54QHRve
        uaOVf2lu0AE5S3z4kr0ZzrX8dA==
X-Google-Smtp-Source: ABdhPJyzdA2dqwAv3orz5Esi2zAtvL69DAKARqjRmgTTqhqtBvoEtNYlRF7/PYlQS/ju6OE8nzsfjQ==
X-Received: by 2002:a37:6141:: with SMTP id v62mr1199675qkb.500.1610999682708;
        Mon, 18 Jan 2021 11:54:42 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:626b:1275:5dba:df42])
        by smtp.gmail.com with ESMTPSA id i27sm11227673qkk.15.2021.01.18.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:54:42 -0800 (PST)
Date:   Mon, 18 Jan 2021 14:54:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 04/17] merge-ort: add outline for computing directory
 renames
Message-ID: <YAXnfwGpvhtxbQhF@nand.local>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
 <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
 <ccb30dfc3c4c9ad2fc7cd33dc72ecf768827ed9f.1610055365.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccb30dfc3c4c9ad2fc7cd33dc72ecf768827ed9f.1610055365.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 07, 2021 at 09:35:52PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> Port some directory rename handling changes from merge-recursive.c's
> detect_and_process_renames() to the same-named function of merge-ort.c.

Thanks, having the source be explicitly named makes it much easier to
check over the reimplementation.

> This does not yet add any use or handling of directory renames, just the
> outline for where we start to compute them.  Thus, a future patch will
> add port additional changes to merge-ort's detect_and_process_renames().

Noted.

> @@ -1086,13 +1098,24 @@ static int detect_and_process_renames(struct merge_options *opt,
>  {
>  	struct diff_queue_struct combined;
>  	struct rename_info *renames = &opt->priv->renames;
> -	int s, clean = 1;
> +	int need_dir_renames, s, clean = 1;
>
>  	memset(&combined, 0, sizeof(combined));
>
>  	detect_regular_renames(opt, merge_base, side1, MERGE_SIDE1);
>  	detect_regular_renames(opt, merge_base, side2, MERGE_SIDE2);
>
> +	need_dir_renames =
> +	  !opt->priv->call_depth &&
> +	  (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE ||
> +	   opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT);

Would it be worth it to DRY up this and merge-recursive.c's
implementation, perhaps:

  int needs_dir_renames(struct merge_options *opt)
  {
    return !opt->priv->call_depth &&
      (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE ||
       opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT);
  }

and then calling that in both places?

> +	if (need_dir_renames) {
> +		for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++)
> +			get_provisional_directory_renames(opt, s, &clean);

Not necessarily related to this patch, but just something that I noticed
while reading the series: I don't find this for-loop to be any clearer
than:

  if (need_dir_renames) {
    get_provisional_directory_renames(opt, MERGE_SIDE1, &clean);
    get_provisional_directory_renames(opt, MERGE_SIDE2, &clean);
    /* ... */
  }

In fact, I think that I find the above clearer than the for-loop.
There's no opportunity to write (...; s < MERGE_SIDE2) when you meant
(...; s <= MERGE_SIDE2), and seeing two lines explicitly makes it
clearer that you're really doing the same thing to each side of the
merge.

Anyway, I may feel totally different than others, and of course I
haven't read many of the previous series as closely as this (and so this
may already be an established pattern and I'm just cutting against the
grain here), but those are my $.02.

Thanks,
Taylor
