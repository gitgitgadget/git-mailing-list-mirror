Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A306BC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 16:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517D364DDB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 16:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhBCQAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbhBCP7z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:59:55 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BE7C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:59:09 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id o18so17879684qtp.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oC1LKNRtEP/vyJcLF5dg07bVy2ZxwzraLjzWKVeUBXU=;
        b=Z0EaZL/nCgLxV1FJqVuil09aGdPGAj+8APav3z7PzFRKlN5Ee06nZd/9+stOogk5Zp
         2oDEHZl9Tb1w0lecSZ0jOdXSMDv67GOqp0jZPO66/98i/2ohLsF/UskkXfHx8+F+M+eO
         wFh9IaTrhCCz8Cvojobl1AGOT3TUdrgGP3lAN19QPxVGVelj3PSYAL2Zzxhe2DIeUWhp
         mmVVGUc9kMnnIs8qeCOiOEdoYiGAYlas6gDRtWrHHUEaKdJ7HsVkKO9Cv+L5r/n66IM0
         yibe4hi7akyDNfFYjYbcUKxR6pae/qk5ntN1rocLtyMs5jz2QnG6TNWVMWjjkHCfdc+L
         6nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oC1LKNRtEP/vyJcLF5dg07bVy2ZxwzraLjzWKVeUBXU=;
        b=EYQZn1cZRCr4WL4nYZ+cZxOfrmaV++6gt9Y3lLTIvtGDBq1HrpMfLkV63Hbbd7uEtt
         /lCo5orpxmyq4YXyaJ3/CiKtrI3/Uy2FEVUAhgWuKfeJQi+LOSlLU+9bzAQ4bWARBylq
         gBwjejDVfUtLZMvIAviu7veYiKmi1f10ftuRoo6S58ITtdKFOrjEuNSRNQG4LMH7A9mu
         j/ZpzelhV33pc5x5ai2kqQ4bBamlO1Vj35k/cbh682Mkb7tGL9NngwSLVn+TkFJ3TdAl
         8oUKsBIn+6H87IbsZ+RWpC42f6XliquTQCOetmMus+d4y23omxLWmJb/KYydzJuKTLhm
         GXuQ==
X-Gm-Message-State: AOAM530jlcB2ejtmrbHALOVXBQZHtewBdKkXhXSSAzmHNvWOyyfy9mkA
        U7uhEMSz+UUmo4AQyj9/b+CQfw==
X-Google-Smtp-Source: ABdhPJzACVB087fBbQ7eCTTTnL8qRKVh244B1CtpSaDqZt5aq5cFL4yiwvc1MsE3Uu0FoH7Rarfbrw==
X-Received: by 2002:ac8:59d6:: with SMTP id f22mr3075972qtf.230.1612367948968;
        Wed, 03 Feb 2021 07:59:08 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id b16sm1578617qtx.85.2021.02.03.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:59:08 -0800 (PST)
Date:   Wed, 3 Feb 2021 10:59:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net, gitster@pobox.com,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 5/5] commit-reach: stale commits may prune generation
 further
Message-ID: <YBrISQ/5/pJKgGGZ@nand.local>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
 <14f0974c987215bd36e91450c1a6ebc6d5732121.1612183647.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14f0974c987215bd36e91450c1a6ebc6d5732121.1612183647.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 12:47:27PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> Note that these are only modest improvements for the case where the two
> independent commits are not in the commit-graph (not until v5.10). All
> algorithms get faster as more commits are indexed, which is not a
> surprise. However, the cost of walking extra commits is more and more
> prevalent in relative terms as more commits are indexed. Finally, the
> last case allows us to jump to the minimum generation between the last
> two commits (that are actually independent) so we greatly reduce the
> cost in that case.

Very nice. The explanation and implementation makes sense to me.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-reach.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index d3a6e2bdd04..c2e0747fea4 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -237,15 +237,27 @@ static int remove_redundant_with_gen(struct repository *r,
>  {
>  	int i, count_non_stale = 0, count_still_independent = cnt;
>  	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
> -	struct commit **walk_start;
> +	struct commit **walk_start, **sorted;
>  	size_t walk_start_nr = 0, walk_start_alloc = cnt;
> +	int min_gen_pos = 0;
> +
> +	/*
> +	 * Sort the input by generation number, ascending. This allows
> +	 * us to increase the "min_generation" limit when we discover
> +	 * the commit with lowest generation is STALE. The index
> +	 * min_gen_pos points to the current position within 'array'
> +	 * that is not yet known to be STALE.
> +	 */
> +	ALLOC_ARRAY(sorted, cnt);
> +	COPY_ARRAY(sorted, array, cnt);
> +	QSORT(sorted, cnt, compare_commits_by_gen);
> +	min_generation = commit_graph_generation(sorted[0]);

This line caught my eye, but we return early in
commit-reach.c:reduce_heads() before even calling remove_redundant()
(which itself calls remove_redundant_with_gen()), so it's always OK to
assume that we have at least one element in 'array'.

This patch and the others in v2 all look good to me.

Thanks,
Taylor
