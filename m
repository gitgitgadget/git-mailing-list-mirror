Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4FAC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 09:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGAJYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiGAJYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 05:24:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5031813DF1
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 02:24:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb34so2906913ejc.11
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=tjLXJdPjMPo4i3Q9AenOlchP2K2SmuNMyceYfpEUXqM=;
        b=Nrzi9WdkkPdq198AMK/CoH17IK43wYTHf9Fd7vPBKDy1IcQPqI6mRo7Th5artphaMx
         X//+2D2wVybU5RwzqDBm+RymRBeoQ4dTPoQcFqzIKxyIfBmb0/K8tEPbojXPx+TJMxWR
         bnyWq0wFPoC4ExJhP7sCc2QZ+s+UwubdXDgduZSU4xekCryvWo2ooqQYqIaQtc3s6tSx
         e02DwFhJutd0LVPq6PI19geRyqYD+G5u5uC78gOJrwoEEIJBN7wgJBbpVGPNSuLM3Xg2
         pj+6Vl2H78D1jbJ01lI+WKfS0BjqJYLqHf/i6YA9qgyT/ySO0xbARh/iPDPj3xyQ+g8l
         STaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=tjLXJdPjMPo4i3Q9AenOlchP2K2SmuNMyceYfpEUXqM=;
        b=R822Fe8/9fLK63WhheTRzSGMkm5cMOupSOwEv1xv2rdIOLmg/gS4rLGbSVGACw1FIj
         4qUGejQ+LgHv6kBkIC4YnckEaYdvBOU7MriCt7kOC6Jo8mF9aaKeL2cVph45i5xcFzcK
         D0aRFYIgh89hvGsz2RPZD7r2fDzIMxjPP1OPzI9CXTwd2lBPeHYebCLZw7jmm5TzAEAi
         dLRkgeP3SL/2gUmc1R4o/PLjpsPY0Cqqs4R/LCtUJXX2J2Ne7KCo6g4YnsgmEm40oTnF
         t2p/akUY1CKCybMva62LbjZA4z/GPe3t8pmh3fCxty6K3LeRCdYv1UUM5IbE6NQ84TjL
         D++A==
X-Gm-Message-State: AJIora8HxH2XYrFhbGiEHKS5NOk3rJ+vqNDmwhljpZ6aYWAWZ7oxOWC9
        U/xxW9DRVN4uoOKlunHY1xQnExGtxlVXNA==
X-Google-Smtp-Source: AGRyM1vMgB02cSWwYoynTvmSpU6IYVbRGtl1cceYQDNpJ1VS8GJk+FqGzAJkpPHS04udE74V8+vbPg==
X-Received: by 2002:a17:907:c0a:b0:726:22b1:9734 with SMTP id ga10-20020a1709070c0a00b0072622b19734mr13472768ejc.195.1656667453360;
        Fri, 01 Jul 2022 02:24:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090653c500b00722e8c47cc9sm2628445ejo.181.2022.07.01.02.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 02:24:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o7Csl-00396k-8l;
        Fri, 01 Jul 2022 11:24:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] merge-ort: shuffle the computation and cleanup
 of potential collisions
Date:   Fri, 01 Jul 2022 11:16:33 +0200
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
 <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
 <d3eac3d0bf6539d81751813d89ec5158dcb57338.1656653000.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <d3eac3d0bf6539d81751813d89ec5158dcb57338.1656653000.git.gitgitgadget@gmail.com>
Message-ID: <220701.86o7y9b2ys.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 01 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Run compute_collisions() for renames on both sides of history before
> any calls to collect_renames(), and do not free the computed collisions
> until after both calls to collect_renames().  This is just a code
> reorganization at this point that doesn't make sense on its own, but
> will permit us to use the computed collision info from both sides
> within each call to collect_renames() in a subsequent commit.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

This is much easier to read & review with the prep patches, thanks a
lot.

B.t.w. on the "legacy code" comment wrt merge-{ort,recursive}.c : I
didn't look in that case, but I've seen that you've copied various older
code from merge-recursive.c to merge-ort.c (which makes sense) in the
past, but I didn't check the origin in that case. Sorry :)

> @@ -3106,6 +3105,7 @@ static int detect_and_process_renames(struct merge_options *opt,
>  {
>  	struct diff_queue_struct combined = { 0 };
>  	struct rename_info *renames = &opt->priv->renames;
> +	struct strmap collisions[3];
>  	int need_dir_renames, s, i, clean = 1;
>  	unsigned detection_run = 0;
>  
> @@ -3155,12 +3155,22 @@ static int detect_and_process_renames(struct merge_options *opt,
>  	ALLOC_GROW(combined.queue,
>  		   renames->pairs[1].nr + renames->pairs[2].nr,
>  		   combined.alloc);
> +	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {

The "int i" here will need to be pre-declared earlier, per: 6563706568b
(CodingGuidelines: give deadline for "for (int i = 0; ...", 2022-03-30)

I also don't mind us just saying "we've waited enough". Junio?

> +		int other_side = 3 - i;
> +		compute_collisions(&collisions[i],
> +				   &renames->dir_renames[other_side],
> +				   &renames->pairs[i]);
> +	}
>  	clean &= collect_renames(opt, &combined, MERGE_SIDE1,
> +				 collisions,
>  				 &renames->dir_renames[2],
>  				 &renames->dir_renames[1]);
>  	clean &= collect_renames(opt, &combined, MERGE_SIDE2,
> +				 collisions,
>  				 &renames->dir_renames[1],
>  				 &renames->dir_renames[2]);
> +	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++)
> +		free_collisions(&collisions[i]);
>  	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
>  	trace2_region_leave("merge", "directory renames", opt->repo);

