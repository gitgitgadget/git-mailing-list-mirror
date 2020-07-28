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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D5C433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 13:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E71320714
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 13:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubuuFWt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgG1NOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbgG1NOp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 09:14:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90AC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 06:14:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b79so18499654qkg.9
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IbUBhz/TTVBemMiqNTufuWiBG7N4vfc3AP/M4GWlS78=;
        b=ubuuFWt8lfJleOW4Shr5Zw7eUdBxQt3+SmKsd1voW3M+6FyW6X/nvpt7TzsdK2n4BJ
         4pcYgT0BJyqpfeLa6NhBaYCweH+x3JXaFfHJJLwwEXueWc6QhCRnj9VO0IL5hFjIduvT
         M5kpv3BQpmdcjyeYCdTvsvHv8kXQUZAdgxp3Qa9RQS4H89nORl7YdTHq3eiLyDMiEs3Q
         wIv5R7V/YkH9/QMzis95hXzR45nrhB3yfu2rLViq2OsTG8upzdXdeVkW6MfT04bByybC
         v4f81cN1bDdPToeZZ7CDmFjqtB4ve2++mp7slN1dZMVwVv/IEKNHN4KmvHXanhisD2CR
         ZZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IbUBhz/TTVBemMiqNTufuWiBG7N4vfc3AP/M4GWlS78=;
        b=S/El54qFT6abZyu3GwbII1IwSZZIt8Dxq/n3lHH80HHGLM7t09FGHoBR68LbaxvxOC
         BtUu5W6JMT9Xv3X6exe1OJ/LRnJFfRPOexCOCeH6m6zmOGvxy8f3CBDTv8HyuW8v+xTn
         4ZSuaoJ1dOB76Iue2jAOIhQLagVCEkZH8WNeGyg/aY1yAmdeGKERTe0lPgjcxtMtiZ3c
         IB3FbtZ+/n15K7pMHpwSscmEY6GKVtBdCP+sA84hpwZkjA+m4RKPzW0R25F8AZtU/1Gs
         Swj8TxIJ4xgGNGQH5VZLQiSslHlBXIZMoX193SLhQNNIpYtf+Ojn+LEbAeBd+s0nDgkw
         WLoA==
X-Gm-Message-State: AOAM533FEZaoArRdM/S5Mgcsi6lKzuqCAzT3TMuRv36i6CgI/yRxElpu
        nzXjmAmIL+OGuiUZjufsG1zFr/gRjtRGpw==
X-Google-Smtp-Source: ABdhPJxDb0yq9zGRwLx3tm8H1bCvgEYVdsoQmnv1LVH5w0Phz4uwN0xL+hpjHSpm997eHmTUdCuf7Q==
X-Received: by 2002:a37:781:: with SMTP id 123mr28791112qkh.475.1595942083839;
        Tue, 28 Jul 2020 06:14:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d015:5ac6:e959:4f4? ([2600:1700:e72:80a0:d015:5ac6:e959:4f4])
        by smtp.gmail.com with ESMTPSA id 78sm21836328qke.81.2020.07.28.06.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 06:14:43 -0700 (PDT)
Subject: Re: [PATCH 3/6] commit-graph: consolidate fill_commit_graph_info
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <701f5912369c0fcc07cf604c3129cb5017a125ce.1595927632.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a9d50995-566d-cad2-ff67-8b8604b52eed@gmail.com>
Date:   Tue, 28 Jul 2020 09:14:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <701f5912369c0fcc07cf604c3129cb5017a125ce.1595927632.git.gitgitgadget@gmail.com>
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
> Both fill_commit_graph_info() and fill_commit_in_graph() parse
> information present in commit data chunk. Let's simplify the
> implementation by calling fill_commit_graph_info() within
> fill_commit_in_graph().
> 
> The test 'generate tar with future mtime' creates a commit with commit
> time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
> generation number and has undefined behavior. The test used to pass as
> fill_commit_in_graph() did not read commit time from commit graph,
> reading commit date from odb instead.

I was first confused as to why fill_commit_graph_info() did not
load the timestamp, but the reason is that it is only used by
two methods:

1. fill_commit_in_graph(): this actually leaves the commit in a
   "parsed" state, so the date must be correct. Thus, it parses
   the date out of the commit-graph.

2. load_commit_graph_info(): this only helps to guarantee we
   know the graph_pos and generation number values.

Perhaps add this extra context: you will _need_ the commit date
from the commit-graph in order to populate the generation number
v2 in fill_commit_graph_info().

> Let's fix that by setting commit time of (2 ^ 34 - 1) seconds.

The timestamp limit placed in the commit-graph is more restrictive
than 64-bit timestamps, but as your test points out, the maximum
timestamp allowed takes place in the year 2514. That is far enough
away for all real data.

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c      | 31 ++++++++++++-------------------
>  t/t5000-tar-tree.sh |  4 ++--
>  2 files changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 5d3c9bd23c..204eb454b2 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -735,15 +735,24 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
>  	const unsigned char *commit_data;
>  	struct commit_graph_data *graph_data;
>  	uint32_t lex_index;
> +	uint64_t date_high, date_low;
>  
>  	while (pos < g->num_commits_in_base)
>  		g = g->base_graph;
>  
> +	if (pos >= g->num_commits + g->num_commits_in_base)
> +		die(_("invalid commit position. commit-graph is likely corrupt"));
> +
>  	lex_index = pos - g->num_commits_in_base;
>  	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
>  
>  	graph_data = commit_graph_data_at(item);
>  	graph_data->graph_pos = pos;
> +
> +	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
> +	date_low = get_be32(commit_data + g->hash_len + 12);
> +	item->date = (timestamp_t)((date_high << 32) | date_low);
> +
>  	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
>  }
>  
> @@ -758,38 +767,22 @@ static int fill_commit_in_graph(struct repository *r,
>  {
>  	uint32_t edge_value;
>  	uint32_t *parent_data_ptr;
> -	uint64_t date_low, date_high;
>  	struct commit_list **pptr;
> -	struct commit_graph_data *graph_data;
>  	const unsigned char *commit_data;
>  	uint32_t lex_index;
>  
> +	fill_commit_graph_info(item, g, pos);
> +
>  	while (pos < g->num_commits_in_base)
>  		g = g->base_graph;

This 'while' loop happens in both implementations, so you could
save a miniscule amount of time by placing the call to
fill_commit_graph_info() after the while loop.

> -	if (pos >= g->num_commits + g->num_commits_in_base)
> -		die(_("invalid commit position. commit-graph is likely corrupt"));

> -	/*
> -	 * Store the "full" position, but then use the
> -	 * "local" position for the rest of the calculation.
> -	 */
> -	graph_data = commit_graph_data_at(item);
> -	graph_data->graph_pos = pos;
>  	lex_index = pos - g->num_commits_in_base;
> -
> -	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
> +	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;

I was about to complain about this change, but GRAPH_DATA_WIDTH
is a macro that does an equivalent thing (except the_hash_algo->rawsz
instead of g->hash_len).

>  
>  	item->object.parsed = 1;
>  
>  	set_commit_tree(item, NULL);
>  
> -	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
> -	date_low = get_be32(commit_data + g->hash_len + 12);
> -	item->date = (timestamp_t)((date_high << 32) | date_low);
> -
> -	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> -
>  	pptr = &item->parents;
>  
>  	edge_value = get_be32(commit_data + g->hash_len);
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 37655a237c..1986354fc3 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -406,7 +406,7 @@ test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
>  	rm -f .git/index &&
>  	echo content >file &&
>  	git add file &&
> -	GIT_COMMITTER_DATE="@68719476737 +0000" \
> +	GIT_COMMITTER_DATE="@17179869183 +0000" \
>  		git commit -m "tempori parendum"
>  '
>  
> @@ -415,7 +415,7 @@ test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
>  '
>  
>  test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
> -	echo 4147 >expect &&
> +	echo 2514 >expect &&
>  	tar_info future.tar | cut -d" " -f2 >actual &&
>  	test_cmp expect actual
>  '
> 

Thanks,
-Stolee
