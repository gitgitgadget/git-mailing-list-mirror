Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57770C433DF
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 21:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F532075D
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 21:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuTYfj7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0VdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0VdR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 17:33:17 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7399BC061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 14:33:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so4722474ejr.5
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DG0VW5xpprmPQBqWlFwjdvPg6EzPKxilkcyj8ZN5G1o=;
        b=OuTYfj7nXPiB+U9HFXWQKkK+8Z18QBBzH1HURN6+CYBtzWWTpJLhbOMt4kKmXxIERW
         lQaNExge87lTjjIR6TWfHhELzOVKMxfSaJAHj4C3RN0X7OwgxHhOjo913tdVYbOKMm1Y
         4vvt6F4EdQ1Pi2oaPJwzA6kUA4x0PwTpANpXvVLVCb34fHTH9yrHyXeymWe/E9/aHsqU
         DPqnO+MQr30j36cHSwBXq0T9v30HMcjtCS19AGtnsEH7ekiEZdP33VNdedkAtb/HERBP
         yiD5gC5ydvUMSwyf6fp6Jls6bmK/8VCFeFcAL4O+AXXy5e78Mas9Wt9SGxoAKaZ2Dn7N
         XU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DG0VW5xpprmPQBqWlFwjdvPg6EzPKxilkcyj8ZN5G1o=;
        b=b9yejh0vy+xk4Zc3fx9YBNc0NGnmYu+XMC19gbvjsIaHWnCabEsGPqaQ6KP5snJ3sz
         nxhx2i8yVTo6oeLSZItC+8/MIhk3LSDBSe+T3TR7x8Jqs17MFfnUB0NhyASIRHit/TBR
         tV+OfZe02+1bXAR+h8wQeUDhR1SpAIaulPGRtk+HEK7syfD6rmSP8crQArk5S94zsgXS
         8UogTEql/OevDwZ74TJM2KEtMr8n/vNwkWjYawoobtNsHCypVtnIJ3QhGZ2AEOjqRaXj
         I7ADRzhHDXGbksUrItdrCzeYAvdnO0UjA7QiNFPc5/JuKmz5wQkSdnLoXDGdgf6bXrjW
         fiSg==
X-Gm-Message-State: AOAM533RxxzRfxZGM126lmxI29zZhzTE4LLCZH0goSv3sw3qfObedIW+
        4Yw7fXM1HmPIHh6gMRmpwAc=
X-Google-Smtp-Source: ABdhPJxf5RAa3AXSpvJY4miyMz9G4OTmtteMH65PKRPjisZC+mRLgCr+vq+AJzE4CqNDea5IEk+sOQ==
X-Received: by 2002:a17:906:3ec7:: with SMTP id d7mr17310141ejj.9.1595885596169;
        Mon, 27 Jul 2020 14:33:16 -0700 (PDT)
Received: from szeder.dev (62-165-238-20.pool.digikabel.hu. [62.165.238.20])
        by smtp.gmail.com with ESMTPSA id bz14sm7741213ejc.88.2020.07.27.14.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 14:33:15 -0700 (PDT)
Date:   Mon, 27 Jul 2020 23:33:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v4 10/15] commit-graph: reuse existing Bloom filters
 during write
Message-ID: <20200727213312.GP2898@szeder.dev>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <cc8022bdf82d0ada326ad546fdd7bb7801fc3675.1586192395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc8022bdf82d0ada326ad546fdd7bb7801fc3675.1586192395.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 04:59:50PM +0000, Garima Singh via GitGitGadget wrote:
> From: Garima Singh <garima.singh@microsoft.com>
> 
> Add logic to
> a) parse Bloom filter information from the commit graph file and,
> b) re-use existing Bloom filters.
> 
> See Documentation/technical/commit-graph-format for the format in which
> the Bloom filter information is written to the commit graph file.
> 
> To read Bloom filter for a given commit with lexicographic position
> 'i' we need to:
> 1. Read BIDX[i] which essentially gives us the starting index in BDAT for
>    filter of commit i+1. It is essentially the index past the end
>    of the filter of commit i. It is called end_index in the code.
> 
> 2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT
>    for filter of commit i. It is called the start_index in the code.
>    For the first commit, where i = 0, Bloom filter data starts at the
>    beginning, just past the header in the BDAT chunk. Hence, start_index
>    will be 0.
> 
> 3. The length of the filter will be end_index - start_index, because
>    BIDX[i] gives the cumulative 8-byte words including the ith
>    commit's filter.
> 
> We toggle whether Bloom filters should be recomputed based on the
> compute_if_not_present flag.
> 
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  bloom.c               | 49 ++++++++++++++++++++++++++++++++++++++++++-
>  bloom.h               |  4 +++-
>  commit-graph.c        |  6 +++---
>  t/helper/test-bloom.c |  2 +-
>  4 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/bloom.c b/bloom.c
> index a16eee92331..0f714dd76ae 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -4,6 +4,8 @@
>  #include "diffcore.h"
>  #include "revision.h"
>  #include "hashmap.h"
> +#include "commit-graph.h"
> +#include "commit.h"
>  
>  define_commit_slab(bloom_filter_slab, struct bloom_filter);
>  
> @@ -26,6 +28,36 @@ static inline unsigned char get_bitmask(uint32_t pos)
>  	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
>  }
>  
> +static int load_bloom_filter_from_graph(struct commit_graph *g,
> +				   struct bloom_filter *filter,
> +				   struct commit *c)
> +{
> +	uint32_t lex_pos, start_index, end_index;
> +
> +	while (c->graph_pos < g->num_commits_in_base)
> +		g = g->base_graph;
> +
> +	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
> +	if (!g->chunk_bloom_indexes)
> +		return 0;
> +
> +	lex_pos = c->graph_pos - g->num_commits_in_base;
> +
> +	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);

Let's suppose that we encounter a bogus commit-graph file.  This would
then segfault if 'lex_pos' were to point past the end of file, i.e.
past the mmap()-ed memory region.

> +
> +	if (lex_pos > 0)
> +		start_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
> +	else
> +		start_index = 0;
> +
> +	filter->len = end_index - start_index;
> +	filter->data = (unsigned char *)(g->chunk_bloom_data +
> +					sizeof(unsigned char) * start_index +
> +					BLOOMDATA_CHUNK_HEADER_SIZE);

And this could lead to segfault later when accessing the Bloom filter
data if 'start_index' or 'end_index' were to point past EOF or
end_index < start_index.

IMO all indices and offsets read from the commit-graph file must be
checked to ensure that they fit in the corresponding chunk, like I did
in my modified path Bloom filters implementation.  However, I'm not
sure how it's best to handle an out-of-bounds offset...  Simply
erroring out in case of a bogus commit-graph file is the
straightforward possibility, of course, but since the commit-graph is
only an optimization, it would be better user experience to warn and
ignore it and finish the operation without the commit-graph (albeit
slower).  But is it even possible to ignore the commit-graph, say, in
the middle of a 'git rev-list --topo-order HEAD'?

> +	return 1;
> +}
> +
>  /*
>   * Calculate the murmur3 32-bit hash value for the given data
>   * using the given seed.
> @@ -127,7 +159,8 @@ void init_bloom_filters(void)
>  }
>  
>  struct bloom_filter *get_bloom_filter(struct repository *r,
> -				      struct commit *c)
> +				      struct commit *c,
> +					  int compute_if_not_present)
>  {
>  	struct bloom_filter *filter;
>  	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
> @@ -140,6 +173,20 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  
>  	filter = bloom_filter_slab_at(&bloom_filters, c);
>  
> +	if (!filter->data) {
> +		load_commit_graph_info(r, c);
> +		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
> +			r->objects->commit_graph->chunk_bloom_indexes) {
> +			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
> +				return filter;
> +			else
> +				return NULL;
> +		}
> +	}
> +
> +	if (filter->data || !compute_if_not_present)
> +		return filter;
> +
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive = 1;
>  	diffopt.max_changes = max_changes;
> diff --git a/bloom.h b/bloom.h
> index 85ab8e9423d..760d7122374 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -32,6 +32,7 @@ struct bloom_filter_settings {
>  
>  #define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
>  #define BITS_PER_WORD 8
> +#define BLOOMDATA_CHUNK_HEADER_SIZE 3 * sizeof(uint32_t)
>  
>  /*
>   * A bloom_filter struct represents a data segment to
> @@ -79,6 +80,7 @@ void add_key_to_filter(const struct bloom_key *key,
>  void init_bloom_filters(void);
>  
>  struct bloom_filter *get_bloom_filter(struct repository *r,
> -				      struct commit *c);
> +				      struct commit *c,
> +				      int compute_if_not_present);
>  
>  #endif
> \ No newline at end of file
> diff --git a/commit-graph.c b/commit-graph.c
> index a8b6b5cca5d..77668629e27 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1086,7 +1086,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
>  			ctx->commits.nr);
>  
>  	while (list < last) {
> -		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
>  		cur_pos += filter->len;
>  		display_progress(progress, ++i);
>  		hashwrite_be32(f, cur_pos);
> @@ -1115,7 +1115,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
>  	hashwrite_be32(f, settings->bits_per_entry);
>  
>  	while (list < last) {
> -		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
>  		display_progress(progress, ++i);
>  		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
>  		list++;
> @@ -1296,7 +1296,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  
>  	for (i = 0; i < ctx->commits.nr; i++) {
>  		struct commit *c = sorted_commits[i];
> -		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
>  		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
>  		display_progress(progress, i + 1);
>  	}
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index f18d1b722e1..ce412664ba9 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -39,7 +39,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
>  	struct bloom_filter *filter;
>  	setup_git_directory();
>  	c = lookup_commit(the_repository, commit_oid);
> -	filter = get_bloom_filter(the_repository, c);
> +	filter = get_bloom_filter(the_repository, c, 1);
>  	print_bloom_filter(filter);
>  }
>  
> -- 
> gitgitgadget
> 
