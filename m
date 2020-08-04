Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF802C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 12:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864C12075A
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 12:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgTSC7Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHDM5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgHDM5L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 08:57:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29706C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 05:57:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so38267194qka.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rCrR6MxZ4rYQFlQA2oRlf594CeOM9sZH4YP3y6k6Kq0=;
        b=rgTSC7Oiv/QcBepRYqw/FoUH+kvGDkC+G4wSkq4OV/mHu+DMLS6EYXBHuRpfx7XjiH
         qtGd5rkYdBu3AqGM+6sl0FvHA5402ueunDWax4glSozYCcZnycCwDN6hAXF23nFuKGpA
         5a8/hE4PqCJixhxgB//RNdj329XD8P5e3jm0wQ9jctMdAnVeTO9Xu68Yyhz+nWa6jXze
         c0E5SASyJE53bXW04xmImqcVPOyPh9PcmRL9eg47p7qOpbyD/sl7NN8EqmYo067NEBU4
         iQf5frqyg/1y8tnXwQTV5CUWHvjT8rtOxCAgzmeckUNPMk1Ol5GZwaZ6stv4vKQNdrBL
         ZlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rCrR6MxZ4rYQFlQA2oRlf594CeOM9sZH4YP3y6k6Kq0=;
        b=tiZxhqKCi4BRe7KzWdISCCOj2JDQ7Lf31DyEcqgp21LGlHqtTjSXUVVp3S1AQLv1MF
         lY5To64LfsCnoDF886yEKDAF4XewS32fo9ne9Q5yC/+4+6eCdKE+RCBzL3Y1KqvvJmFU
         OHwhRIS406O38q/vhlhidvcUG2QPbwymsJ5thiUoVbh2cAJaqm0dpw4cVdbuX4gyafGr
         bVfi+zo30n5OUwY1+rt3UFfAqQntLwPTapdFtE+2RUIhyRnotIWOmvf/VNdGgPwam8CH
         91xMJJ5mauBHVxNReLTlXZ+qPgixzWaamANoblTP7sjObkTygBmQUas8LMGVt5Q7yYii
         5R+A==
X-Gm-Message-State: AOAM530IoNxsyo4G1QHGKx+atqNurxPZy4GcYoSZLwiItc494KVMJHRM
        U2hzdlxtS0+HqeLd6Rpt/60=
X-Google-Smtp-Source: ABdhPJzMsfur9WnJiocQibEAPXfCfWoolBEApLqsFilR9SGg+OnERsiZ8t66s5QBa/Fh2Pl4XzXmbw==
X-Received: by 2002:a37:582:: with SMTP id 124mr20627432qkf.400.1596545830051;
        Tue, 04 Aug 2020 05:57:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id i75sm17401906qke.70.2020.08.04.05.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 05:57:08 -0700 (PDT)
Subject: Re: [PATCH 07/10] commit-graph: add large-filters bitmap chunk
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
References: <cover.1596480582.git.me@ttaylorr.com>
 <ab789072331127079347742b6ce3b3415bbbe4f6.1596480582.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8483cbba-4a4b-030d-0ef2-0ff265470d31@gmail.com>
Date:   Tue, 4 Aug 2020 08:57:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <ab789072331127079347742b6ce3b3415bbbe4f6.1596480582.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2020 2:57 PM, Taylor Blau wrote:
> When a commit has 512 changed paths or greater, the commit-graph
> machinery represents it as a zero-length filter since having many
> entries in the Bloom filter has undesirable effects on the false
> positivity rate.

You mentioned in another message that you'd like to encode the magic
"512" constant into this chunk. I think that is a good idea. Perhaps
it is worth describing it as a MAX_CHANGED_PATHS variable or something.

I don't think now is the time to expose it as a command-line argument,
but encoding it in the file format is a good idea. This is similar to
the start of the BDAT chunk starting with three values from the
bloom_filter_settings, which are not actually customizable from arguments.

For testing, I would recommend using a GIT_TEST_* variable, just like
GIT_TEST_BLOOM_SETTINGS_NUM_HASHES and GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY
are used in t4216-log-bloom.sh to test those BDAT chunk values.

> In addition to these too-large filters, the commit-graph machinery also
> represents commits with no filter and commits with no changed paths in
> the same way.
> 
> When writing a commit-graph that aggregates several incremental
> commit-graph layers (eg., with '--split=replace'), the commit-graph
> machinery first computes all of the Bloom filters that it wants to write
> but does not already know about from existing graph layers. Because we
> overload the zero-length filter in the above fashion, this leads to
> recomputing large filters over and over again.
> 
> This is already undesirable, since it means that we are wasting
> considerable effort to discover that a commit has at least 512 changed
> paths, only to throw that effort away (and then repeat the process the
> next time a roll-up is performed).
> 
> In a subsequent patch, we will add a '--max-new-filters' option, which
> specifies an upper-bound on the number of new filters we are willing to
> compute from scratch. Suppose that there are 'N' too-large filters, and
> we specify '--max-new-filters=M'. If 'N >= M', it is unlikely that any
> filters will be generated, since we'll spend most of our effort on
> filters that we ultimately throw away. If 'N < M', filters will trickle
> in over time, but only at most 'M - N' per-write.
> 
> To address this, add a new chunk which encodes a bitmap where the ith
> bit is on iff the ith commit has zero or at least 512 changed paths.
> When computing Bloom filters, first consult the relevant bitmap (in the
> case that we are rolling up existing layers) to see if computing the
> Bloom filter from scratch would be a waste of time.
> 
> This patch implements a new chunk instead of extending the existing BIDX
> and BDAT chunks because modifying these chunks would confuse old
> clients. For example, consider setting the most-significant bit in an
> entry in the BIDX chunk to indicate that that filter is too-large. New
> clients would understand how to interpret this, but old clients would
> treat that entry as a really large filter.
> 
> By avoiding the need to move to new versions of the BDAT and BIDX chunk,
> we can give ourselves more time to consider whether or not other
> modifications to these chunks are worthwhile without holding up this
> change.
> 
> Another approach would be to introduce a new BIDX chunk (say, one
> identified by 'BID2') which is identical to the existing BIDX chunk,
> except the most-significant bit of each offset is interpreted as "this
> filter is too big" iff looking at a BID2 chunk. This avoids having to
> write a bitmap, but forces older clients to rewrite their commit-graphs
> (as well as reduces the theoretical largest Bloom filters we couldl
> write, and forces us to maintain the code necessary to translate BIDX
> chunks to BID2 ones).  Separately from this patch, I implemented this
> alternate approach and did not find it to be advantageous.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  .../technical/commit-graph-format.txt         |  9 ++
>  commit-graph.c                                | 85 ++++++++++++++++++-
>  commit-graph.h                                |  2 +
>  t/t4216-log-bloom.sh                          | 20 ++++-
>  4 files changed, 112 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> index 440541045d..a7191c03d3 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -123,6 +123,15 @@ CHUNK DATA:
>        of length zero.
>      * The BDAT chunk is present if and only if BIDX is present.
>  
> +  Large Bloom Filters (ID: {'B', 'F', 'X', 'L'}) [Optional]
> +    * It contains a list of 'eword_t's (the length of this list is determined by

I'm not sure using 'eword_t' in this documentation is helpful. How large is that
type? Can we make that concrete in terms of 32- or 64-bit words? Below, you
describe that this is an uncompressed bitmap whose 'i'th bit corresponds to the
'i'th commit.

> +      the width of the chunk) which is a bitmap. The 'i'th bit is set exactly
> +      when the 'i'th commit in the graph has a changed-path Bloom filter with
> +      zero entries (either because the commit is empty, or because it contains
> +      more than 512 changed paths).
As I expect you will update this in v2, try to create a name for the "512" constant
to re-use here.

> +    * The BFXL chunk is present on newer versions of Git iff the BIDX and BDAT
> +      chunks are also present.

Expand "iff" to "if and only if". Perhaps this would be simpler to have only one
direction:

	* The BFXL chunk is present only when the BIDX and BDAT chunks are
	  also present.

> +
>    Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
>        This list of H-byte hashes describe a set of B commit-graph files that
>        form a commit-graph chain. The graph position for the ith commit in this
> diff --git a/commit-graph.c b/commit-graph.c
> index d6ea556649..c870ffe0ed 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -41,8 +41,9 @@ void git_test_write_commit_graph_or_die(void)
>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
>  #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
>  #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
> +#define GRAPH_CHUNKID_BLOOMLARGE 0x4246584c /* "BFXL" */
>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> -#define MAX_NUM_CHUNKS 7
> +#define MAX_NUM_CHUNKS 8
>  
>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>  
> @@ -429,6 +430,17 @@ struct commit_graph *parse_commit_graph(struct repository *r,
>  				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
>  			}
>  			break;
> +
> +		case GRAPH_CHUNKID_BLOOMLARGE:
> +			if (graph->bloom_large.word_alloc)
> +				chunk_repeated = 1;
> +			else if (r->settings.commit_graph_read_changed_paths) {
> +				uint32_t alloc = get_be64(chunk_lookup + 4) - chunk_offset;
> +
> +				graph->bloom_large.word_alloc = alloc;
> +				graph->bloom_large.words = (eword_t *)(data + chunk_offset);
> +			}
> +			break;
>  		}
>  
>  		if (chunk_repeated) {
> @@ -443,6 +455,8 @@ struct commit_graph *parse_commit_graph(struct repository *r,
>  		/* We need both the bloom chunks to exist together. Else ignore the data */
>  		graph->chunk_bloom_indexes = NULL;
>  		graph->chunk_bloom_data = NULL;
> +		graph->bloom_large.words = NULL;
> +		graph->bloom_large.word_alloc = 0;
>  		FREE_AND_NULL(graph->bloom_filter_settings);
>  	}
>  
> @@ -933,6 +947,21 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
>  	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
>  }
>  
> +static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> +					   const struct commit *c)
> +{
> +	uint32_t graph_pos = commit_graph_position(c);
> +	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
> +		return 0;
> +
> +	while (g && graph_pos < g->num_commits_in_base)
> +		g = g->base_graph;
> +
> +	if (!(g && g->bloom_large.word_alloc))
> +		return 0;
> +	return bitmap_get(&g->bloom_large, graph_pos - g->num_commits_in_base);
> +}
> +
>  struct packed_oid_list {
>  	struct object_id *list;
>  	int nr;
> @@ -969,6 +998,11 @@ struct write_commit_graph_context {
>  	const struct split_commit_graph_opts *split_opts;
>  	size_t total_bloom_filter_data_size;
>  	const struct bloom_filter_settings *bloom_settings;
> +	struct bitmap *bloom_large;
> +
> +	int count_bloom_filter_known_large;
> +	int count_bloom_filter_found_large;
> +	int count_bloom_filter_computed;
>  };
>  
>  static int write_graph_chunk_fanout(struct hashfile *f,
> @@ -1231,6 +1265,15 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
>  	return 0;
>  }
>  
> +static int write_graph_chunk_bloom_large(struct hashfile *f,
> +					  struct write_commit_graph_context *ctx)
> +{
> +	trace2_region_enter("commit-graph", "bloom_large", ctx->r);
> +	hashwrite(f, ctx->bloom_large->words, ctx->bloom_large->word_alloc * sizeof(eword_t));

Should we be using word_alloc here? Or can we trust that the bitmap
was allocated to the exact right size to fit our number of commits?

We probably need to be careful about network-byte order here, right?
Or, should we treat the bitmap as an array of bytes?

I see that eword_t is a 64-bit type, which makes things a _little_
tricky. We normally would use hashwrite_be32() for writing 32-bit
words. Likely, we will want a new hashwrite_be64() that is a wrapper
around hashwrite_be32(). Notice that this could be used when writing
the chunk offsets in commit-graph.c and midx.c. For example, we
write the 64-bit offsets in write_commit_graph_file() as follows:

	for (i = 0; i <= num_chunks; i++) {
		uint32_t chunk_write[3];

		chunk_write[0] = htonl(chunk_ids[i]);
		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
		hashwrite(f, chunk_write, 12);
	}

This would be nicer as

	for (i = 0; i <= num_chunks; i++) {
		hashwrite_be32(f, chunk_ids[i]);
		hashwrite_be64(f, chunk_offsets[i]);
	}

I know this adds complexity to an already meaty series. However, this
should help us avoid this network-byte order issue in the future while
cleaning up existing code.

> +	trace2_region_leave("commit-graph", "bloom_large", ctx->r);
> +	return 0;
> +}
> +
>  static int oid_compare(const void *_a, const void *_b)
>  {
>  	const struct object_id *a = (const struct object_id *)_a;
> @@ -1389,6 +1432,24 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  	stop_progress(&ctx->progress);
>  }
>  
> +static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
> +{
> +	struct json_writer jw = JSON_WRITER_INIT;
> +
> +	jw_object_begin(&jw, 0);
> +	jw_object_intmax(&jw, "filter_known_large",
> +			 ctx->count_bloom_filter_known_large);
> +	jw_object_intmax(&jw, "filter_found_large",
> +			 ctx->count_bloom_filter_found_large);
> +	jw_object_intmax(&jw, "filter_computed",
> +			 ctx->count_bloom_filter_computed);
> +	jw_end(&jw);

Helpful stats.

> +
> +	trace2_data_json("commit-graph", the_repository, "bloom_statistics", &jw);
> +
> +	jw_release(&jw);
> +}
> +
>  static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  {
>  	int i;
> @@ -1396,6 +1457,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  	int *sorted_commits;
>  
>  	init_bloom_filters();
> +	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD);
>  
>  	if (ctx->report_progress)
>  		progress = start_delayed_progress(
> @@ -1412,11 +1474,24 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  	for (i = 0; i < ctx->commits.nr; i++) {
>  		int pos = sorted_commits[i];
>  		struct commit *c = ctx->commits.list[pos];
> -		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
> -		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
> +		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph, c)) {
> +			bitmap_set(ctx->bloom_large, pos);
> +			ctx->count_bloom_filter_known_large++;
> +		} else {
> +			struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
> +			if (!filter->len) {
> +				bitmap_set(ctx->bloom_large, pos);
> +				ctx->count_bloom_filter_found_large++;
> +			}
> +			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;

Is this sizeof(unsigned char) necessary? Or just a helpful reminder that
filter->len is a number of bytes?

> +			ctx->count_bloom_filter_computed++;
> +		}
>  		display_progress(progress, i + 1);
>  	}
>  
> +	if (trace2_is_enabled())
> +		trace2_bloom_filter_write_statistics(ctx);
> +
>  	free(sorted_commits);
>  	stop_progress(&progress);
>  }
> @@ -1739,6 +1814,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  					  + ctx->total_bloom_filter_data_size;
>  		chunks[num_chunks].write_fn = write_graph_chunk_bloom_data;
>  		num_chunks++;
> +		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMLARGE;
> +		chunks[num_chunks].size = sizeof(eword_t) * ctx->bloom_large->word_alloc;
> +		chunks[num_chunks].write_fn = write_graph_chunk_bloom_large;
> +		num_chunks++;
>  	}
>  	if (ctx->num_commit_graphs_after > 1) {
>  		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
> diff --git a/commit-graph.h b/commit-graph.h
> index d9acb22bac..afbc5fa41e 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -4,6 +4,7 @@
>  #include "git-compat-util.h"
>  #include "object-store.h"
>  #include "oidset.h"
> +#include "ewah/ewok.h"
>  
>  #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
> @@ -71,6 +72,7 @@ struct commit_graph {
>  	const unsigned char *chunk_base_graphs;
>  	const unsigned char *chunk_bloom_indexes;
>  	const unsigned char *chunk_bloom_data;
> +	struct bitmap bloom_large;
>  
>  	struct bloom_filter_settings *bloom_filter_settings;
>  };
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index b3d1f596f8..231dc8a3a7 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -33,7 +33,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
>  	git commit-graph write --reachable --changed-paths
>  '
>  graph_read_expect () {
> -	NUM_CHUNKS=5
> +	NUM_CHUNKS=6
>  	cat >expect <<- EOF
>  	header: 43475048 1 1 $NUM_CHUNKS 0
>  	num_commits: $1
> @@ -195,5 +195,23 @@ test_expect_success 'correctly report changes over limit' '
>  		done
>  	)
>  '
> +test_bloom_filters_computed () {
> +	commit_graph_args=$1
> +	bloom_trace_prefix="{\"filter_known_large\":$2,\"filter_found_large\":$3,\"filter_computed\":$4"
> +	rm -f "$TRASH_DIRECTORY/trace.event" &&
> +	GIT_TRACE2_EVENT="$TRASH_DIRECTORY/trace.event" git commit-graph write $commit_graph_args &&
> +	grep "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.event"
> +}

Could this helper be moved earlier, so we can use
test_bloom_filters_computed in 'correctly report changes
over limit'? We could then check that filter_known_large is
zero while filter_found_large is 1.

These tests would be an excellent opportunity to use a
GIT_TEST_* variable to lower the 512 limit to something
smaller to make the test run a tiny bit faster ;).

> +
> +test_expect_success 'Bloom generation does not recompute too-large filters' '
> +	(
> +		cd 513changes &&
> +		git commit-graph write --reachable --changed-paths \
> +			--split=replace &&
> +		test_commit c1 filter &&
> +		test_bloom_filters_computed "--reachable --changed-paths --split=replace" \
> +			1 0 1
> +	)
> +'

Adding this test is valuable. Thanks.

-Stolee

