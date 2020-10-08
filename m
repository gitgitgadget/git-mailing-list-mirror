Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FA0C4363A
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682F921897
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 14:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="FwMC2luS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgJHOPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgJHOPc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 10:15:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42AC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 07:15:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b10so896996qvf.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+pVwjVTaZjemEGRvpJTBig0Pb+dgcmja2SwqIZ3LqQ=;
        b=FwMC2luSAkY6ZCCqnDWoQaO6hBTXxl7ANLnu1ctPTcZNPt+2KpmHPN3PQFwDoP056/
         vWhiCwQ/rizpO1nvnfQ4wNKSuf1ty7hUORLByGGjRxoJl1/YNh8mTCcKZu6EQkIYiyV8
         K56qQ8TByxzVz66rmUFxm0dcWBMPJwPE0HarB2rFYebOOQOOU6ti9MZ4K4aJe+Meq8/3
         KI8pRaQT7LnAVEhmXSOaof8HaX8Wo/stYNZODEv9n2PXBoSizb2lL+QWoaqnD0dBkn7q
         0X3vOoVdGmOOshJXdx6yZXHGIb1SsVA9ft9w4N3F0si1/VRvz4uF9YfrpDDbktC6lqh9
         QXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+pVwjVTaZjemEGRvpJTBig0Pb+dgcmja2SwqIZ3LqQ=;
        b=NQ2GPRRrqh7CrZcJLz15SHrTmEPbDMcaQ/MV+5uCRpTWiLJL1eh9+8/GuIhN9G4tN2
         o3oE9OWorsWuGGmqWaZFM1xOw8D24o9EBYXC8rZF5VDQ/HQcTd8Mkd8FdG+C7/WomWeC
         3qjq+bRIURMMZJIoShRaSdVxiymH7zo0T8YGjM5Jmv/skTkqO1UKXtGYrz5zOm8izdN8
         OyYeQqTELXJdY3GlgvW0WK6NzDQXlQvosUW5e87iTltVGbfMIE29Hxig9h2XrvcnIsd3
         4dWdqpo4qRs6InnuDihcnMB/Ni4NEwxa2+bdUBZ7dYx7iVnUEsRfa6CUZwe0Uhe2Y9cw
         yMoQ==
X-Gm-Message-State: AOAM532q0cxVBw6xGKIUB/DcFAJUBtNoEgfHhdGRTHKUiCVNuJX/2+W3
        /Fg1V5hD+dOICuE1045RFQ5Fhm3gVB8AZkYH
X-Google-Smtp-Source: ABdhPJynl6v0Lh2l9Ds5OAbRD4XT9rviUv0a2pra5V1ogx4FzTh3C2oe+8sPENiaCpt1mzfHUXV+mA==
X-Received: by 2002:a0c:abc5:: with SMTP id k5mr8181731qvb.40.1602166530946;
        Thu, 08 Oct 2020 07:15:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fc6e:d5fb:44be:a174])
        by smtp.gmail.com with ESMTPSA id h18sm3954798qkl.12.2020.10.08.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:15:30 -0700 (PDT)
Date:   Thu, 8 Oct 2020 10:15:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-graph: ignore duplicates when merging layers
Message-ID: <20201008141527.GA351725@nand.local>
References: <pull.747.git.1602165413035.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.747.git.1602165413035.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 01:56:52PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Thomas reported [1] that a "git fetch" command was failing with an error
> saying "unexpected duplicate commit id". The root cause is that they had
> fetch.writeCommitGraph enabled which generates commit-graph chains, and
> this instance was merging two layers that both contained the same commit
> ID.
>
> [1] https://lore.kernel.org/git/55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de/
>
> The initial assumption is that Git would not write a commit ID into a
> commit-graph layer if it already exists in a lower commit-graph layer.
> Somehow, this specific case did get into that situation, leading to this
> error.
>
> While unexpected, this isn't actually invalid (as long as the two layers
> agree on the metadata for the commit). When we parse a commit that does
> not have a graph_pos in the commit_graph_data_slab, we use binary search
> in the commit-graph layers to find the commit and set graph_pos. That
> position is never used again in this case. However, when we parse a
> commit from the commit-graph file, we load its parents from the
> commit-graph and assign graph_pos at that point. If those parents were
> already parsed from the commit-graph, then nothing needs to be done.
> Otherwise, this graph_pos is a valid position in the commit-graph so we
> can parse the parents, when necessary.
>
> Thus, this die() is too aggignoring the duplicates.

s/aggignoring/aggressively ignoring ?

>
> This leads to some additional complication that we did no have before:

s/no/not, but I am more wondering about what "This" is. I think what
you're saying is: "Suppose we didn't die on duplicates, what would
happen? Well, there'd be some additional problems, but here's a way that
we can fix them (storing the de-duplicated OIDs separately)".

> if we only ignore the duplicates, then we will produce a commit-graph
> that has identical commit IDs listed in adjacent positions. This excess
> data will never be removed from the commit-graph, which could cascade
> into significantly bloated file sizes.
>
> Begrudgingly, the best way to fix this is to copy the commit pointers
> into a new list that only contains de-duplicated commit IDs. This adds a
> slight memory overhead, but it is small compared to having all of these
> commits parsed in memory, so it should be an acceptable cost for
> avoiding these failures.
>
> Since the root cause for producing commit-graph layers with these
> duplicate commits is currently unknown, it is difficult to create a test
> for this scenario. For now, we must rely on testing the example data
> graciously provided in [1]. My local test successfully merged layers,
> and 'git commit-graph verify' passed.
>
> Reported-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     commit-graph: ignore duplicates when merging layers
>
>     This wasn't quite as simple as what Peff had posted, since we really
>     don't want to keep duplicate commits around in the new merged layer.
>
>     I still don't have a grasp on how this happened in the first place, but
>     will keep looking.

I'm looking as well, but I haven't found any smoking guns yet. I could
imagine that this is a problem that existed before 0bd52e27e3
(commit-graph.h: store an odb in 'struct write_commit_graph_context',
2020-02-03), and simply couldn't be tickled because of how brittle
comparing ODB paths is. I could equally imagine that 0bd52e27e3 did
introduce this problem.
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-747%2Fderrickstolee%2Fcommit-graph-dup-commits-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-747/derrickstolee/commit-graph-dup-commits-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/747
>
>  commit-graph.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index cb042bdba8..29bac78dc3 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2009,6 +2009,7 @@ static int commit_compare(const void *_a, const void *_b)
>  static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>  {
>  	uint32_t i;
> +	struct packed_commit_list deduped_commits = { NULL, 0, 0 };
>
>  	if (ctx->report_progress)
>  		ctx->progress = start_delayed_progress(
> @@ -2016,6 +2017,8 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>  					ctx->commits.nr);
>
>  	QSORT(ctx->commits.list, ctx->commits.nr, commit_compare);
> +	deduped_commits.alloc = ctx->commits.nr;
> +	ALLOC_ARRAY(deduped_commits.list, deduped_commits.alloc);

I'm not sure that this deduped_commits list is actually necessary.

It would be nice for this caller if ctx->commits were a linked list
since it would make deleting duplicates easy, but I think that it would
be a burden for other callers. So, that's a dead end.

But what about marking the duplicate positions by NULL-ing them out, and
then taking another pass over the list to (1) compact it (i.e., push
everything down so that all of the NULLs occur at the end), and then (2)
truncate the length to the number of unique commits.

I could imagine that something like that is a little trickier, but it
seems worth it to avoid doubling the memory cost of this function.

>  	ctx->num_extra_edges = 0;
>  	for (i = 0; i < ctx->commits.nr; i++) {
> @@ -2023,17 +2026,30 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>
>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>  			  &ctx->commits.list[i]->object.oid)) {
> -			die(_("unexpected duplicate commit id %s"),
> -			    oid_to_hex(&ctx->commits.list[i]->object.oid));
> +			/*
> +			 * Silently ignore duplicates. These were likely
> +			 * created due to a commit appearing in multiple
> +			 * layers of the chain, which is unexpected but
> +			 * not invalid. We should make sure there is a
> +			 * unique copy in the new layer.
> +			 */
>  		} else {
>  			unsigned int num_parents;
>
> +			deduped_commits.list[deduped_commits.nr] = ctx->commits.list[i];
> +			deduped_commits.nr++;
> +
>  			num_parents = commit_list_count(ctx->commits.list[i]->parents);
>  			if (num_parents > 2)
>  				ctx->num_extra_edges += num_parents - 1;
>  		}
>  	}
>
> +	free(ctx->commits.list);
> +	ctx->commits.list = deduped_commits.list;
> +	ctx->commits.nr = deduped_commits.nr;
> +	ctx->commits.alloc = deduped_commits.alloc;
> +
>  	stop_progress(&ctx->progress);
>  }
>
>
> base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
> --
> gitgitgadget

Thanks,
Taylor
