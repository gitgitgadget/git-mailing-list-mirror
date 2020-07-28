Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26336C433EA
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B9F2075A
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SANEkTlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgG1PzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbgG1PzP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 11:55:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979ABC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:55:15 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b79so19078354qkg.9
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3rukE96uo+AtyXw/Z1actxsNGfFSPy62nd5hE0BB2GI=;
        b=SANEkTlL3XwWhKRmKQ8PVA2trZY+/NHEgqeZUI/Gu0JIVq3zOQTUAryhB1sWst54+x
         NcK9oXbkWGmGIb2ZYIkdDMz947t2IUO4NpB9Q651oGKf/rAylpJTvr/VvFW3yDYNp5g9
         w2hbcorlqLvHK+7Wu54FtpOxfPca3EK9GKBADcPI0o3KkqGLlRa8f7S/1cfdMU5c5HxI
         i1Rba9/wKhJIBIAqYQwpgCtQoNiessF58UmaaEYsog1svJP2NSJRyZQV7u0cpC5lhnbu
         oVfRsPmrEMK7od/ChJpJNoslutRdgxaxWzVf8wQlPO84z0d/DoieZ77e3Pv7I/3FxHQx
         mUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3rukE96uo+AtyXw/Z1actxsNGfFSPy62nd5hE0BB2GI=;
        b=VWf3pY0a32ir++eWpkDEAYgmUcWJzTo7iwMqCyszPh20GB9UjfAWWOjVWamWcnSdHq
         /Kebz10SuFk9sdr7W0XDvYlPFpkaEn/KIGq88glhld7IlxXD37x1hnERnk1oZ5ejJ6Jb
         15SSxx7S2Wc6hpe9DBhuIsw1mMKIOt132Phiufkwcysux8yLEueGA4kzOL14BK4GuMpd
         jfEQ3dTbaJNLKLw2nj0F2Tveipht7ZDgk5bMyPdbG8m2U8bnsBJKrHhmSHxhi9RGowbo
         FgwHN5zXJnHwqTRbAVAXkV9kFF7FE0JKBgMhgPzvUtIxDumjX2bSfjvRHtxOKxUQc8mV
         axbg==
X-Gm-Message-State: AOAM531AzVmqPT+GKY4qhX1cxBK4VVkCtckDQvLaE4LVR0soePdpLdbe
        67WWwHR7Ynbmq4RirqRoLf8=
X-Google-Smtp-Source: ABdhPJynLV1bGVCGCt8MP5pn4+yx21Bdefxtoxu5+4rj/J2YGdGyYzz/a/+8X7sR3RT2l7H2uGx7eA==
X-Received: by 2002:a37:9507:: with SMTP id x7mr21804161qkd.253.1595951714615;
        Tue, 28 Jul 2020 08:55:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4854:557c:a990:d78e? ([2600:1700:e72:80a0:4854:557c:a990:d78e])
        by smtp.gmail.com with ESMTPSA id n81sm23193952qke.11.2020.07.28.08.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:55:13 -0700 (PDT)
Subject: Re: [PATCH 6/6] commit-graph: implement corrected commit date offset
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <647290d0368e385227614dd1822aa9083b0dba5e.1595927632.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e8646aaa-667f-b7d8-f8f2-efbaaeb8877d@gmail.com>
Date:   Tue, 28 Jul 2020 11:55:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <647290d0368e385227614dd1822aa9083b0dba5e.1595927632.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/2020 5:13 AM, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> With preparations done,...

I feel like this commit could have been made smaller by doing the
uint32_t -> timestamp_t conversion in a separate patch. That would
make it easier to focus on the changes to the generation number v2
logic.

> let's implement corrected commit date offset.
> We add a new commit-slab to store topological levels while writing

It's important to add: we store topological levels to ensure that older
versions of Git will still have the performance benefits from generation
number v1.

> commit graph and upgrade number of struct commit_graph_data to 64-bits.

Do you mean "update the generation member in struct commit_graph_data
to a 64-bit timestamp"? The struct itself also has the 32-bit graph_pos
member.

> We have to touch many files, upgrading generation number from uint32_t
> to timestamp_t.

Yes, that's why I recommend doing that in a different step.

> We drop 'detect incorrect generation number' from t5318-commit-graph.sh,
> which tests if verify can detect if a commit graph have
> GENERATION_NUMBER_ZERO for a commit, followed by a non-zero generation.
> With corrected commit dates, GENERATION_NUMBER_ZERO is possible only if
> one of dates is Unix epoch zero.

What about the topological levels? Are we caring about verifying the data
that we start to ignore in this new version? I'm hesitant to drop this
right now, but I'm open to it if we really don't see it as a valuable test.

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  blame.c                 |   2 +-
>  commit-graph.c          | 109 ++++++++++++++++++++++------------------
>  commit-graph.h          |   4 +-
>  commit-reach.c          |  32 ++++++------
>  commit-reach.h          |   2 +-
>  commit.h                |   3 ++
>  revision.c              |  14 +++---
>  t/t5318-commit-graph.sh |   2 +-
>  upload-pack.c           |   2 +-
>  9 files changed, 93 insertions(+), 77 deletions(-)
> 
> diff --git a/blame.c b/blame.c
> index 82fa16d658..48aa632461 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1272,7 +1272,7 @@ static int maybe_changed_path(struct repository *r,
>  	if (!bd)
>  		return 1;
>  
> -	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_INFINITY)
> +	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_V2_INFINITY)
>  		return 1;

I don't see value in changing the name of this macro. It
is only used as the default value for a commit not in the
commit-graph. Changing its value to 0xFFFFFFFF works for
both versions when the type is updated to timestamp_t.

The actually-important change in this patch (not just the
type change) is here:

> -static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> +static void compute_corrected_commit_date_offsets(struct write_commit_graph_context *ctx)
>  {
>  	int i;
>  	struct commit_list *list = NULL;
> @@ -1326,11 +1334,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  					_("Computing commit graph generation numbers"),
>  					ctx->commits.nr);
>  	for (i = 0; i < ctx->commits.nr; i++) {
> -		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
> +		uint32_t topo_level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
>  
>  		display_progress(ctx->progress, i + 1);
> -		if (generation != GENERATION_NUMBER_INFINITY &&
> -		    generation != GENERATION_NUMBER_ZERO)
> +		if (topo_level != GENERATION_NUMBER_INFINITY &&
> +		    topo_level != GENERATION_NUMBER_ZERO)
>  			continue;

Here, our "skip" condition is that the topo_level has been computed.
This should be fine, as we are never reading that out of the commit-graph.
We will never be in a mode where topo_level is computed but corrected
commit-date is not.

>  		commit_list_insert(ctx->commits.list[i], &list);
> @@ -1338,29 +1346,38 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  			struct commit *current = list->item;
>  			struct commit_list *parent;
>  			int all_parents_computed = 1;
> -			uint32_t max_generation = 0;
> +			uint32_t max_level = 0;
> +			timestamp_t max_corrected_commit_date = current->date;

Later you assign data->generation to be "max_corrected_commit_date + 1",
which made me think this should be "current->date - 1". Is that so? Or,
do we want most offsets to be one instead of zero? Is there value there?

>  
>  			for (parent = current->parents; parent; parent = parent->next) {
> -				generation = commit_graph_data_at(parent->item)->generation;
> +				topo_level = *topo_level_slab_at(ctx->topo_levels, parent->item);
>  
> -				if (generation == GENERATION_NUMBER_INFINITY ||
> -				    generation == GENERATION_NUMBER_ZERO) {
> +				if (topo_level == GENERATION_NUMBER_INFINITY ||
> +				    topo_level == GENERATION_NUMBER_ZERO) {
>  					all_parents_computed = 0;
>  					commit_list_insert(parent->item, &list);
>  					break;
> -				} else if (generation > max_generation) {
> -					max_generation = generation;
> +				} else {
> +					struct commit_graph_data *data = commit_graph_data_at(parent->item);
> +
> +					if (topo_level > max_level)
> +						max_level = topo_level;
> +
> +					if (data->generation > max_corrected_commit_date)
> +						max_corrected_commit_date = data->generation;
>  				}
>  			}
>  
>  			if (all_parents_computed) {
>  				struct commit_graph_data *data = commit_graph_data_at(current);
>  
> -				data->generation = max_generation + 1;
> -				pop_commit(&list);
> +				if (max_level > GENERATION_NUMBER_MAX - 1)
> +					max_level = GENERATION_NUMBER_MAX - 1;
> +
> +				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
> +				data->generation = max_corrected_commit_date + 1;
>  
> -				if (data->generation > GENERATION_NUMBER_MAX)
> -					data->generation = GENERATION_NUMBER_MAX;
> +				pop_commit(&list);
>  			}
>  		}
>  	}

This looks correct, and I've done a tiny bit of perf tests locally.

> @@ -2085,6 +2102,7 @@ int write_commit_graph(struct object_directory *odb,
>  	uint32_t i, count_distinct = 0;
>  	int res = 0;
>  	int replace = 0;
> +	struct topo_level_slab topo_levels;
>  
>  	if (!commit_graph_compatible(the_repository))
>  		return 0;
> @@ -2099,6 +2117,9 @@ int write_commit_graph(struct object_directory *odb,
>  	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
>  	ctx->total_bloom_filter_data_size = 0;
>  
> +	init_topo_level_slab(&topo_levels);
> +	ctx->topo_levels = &topo_levels;
> +
>  	if (ctx->split) {
>  		struct commit_graph *g;
>  		prepare_commit_graph(ctx->r);
> @@ -2197,7 +2218,7 @@ int write_commit_graph(struct object_directory *odb,
>  	} else
>  		ctx->num_commit_graphs_after = 1;
>  
> -	compute_generation_numbers(ctx);
> +	compute_corrected_commit_date_offsets(ctx);

This rename might not be necessary. You are computing both
versions (v1 and v2) so the name change is actually less
accurate than the old name.

Thanks,
-Stolee

