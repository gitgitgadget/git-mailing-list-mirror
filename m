Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48698C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8DF207F7
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zvsm12jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgHLM3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHLM3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 08:29:10 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0519C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 05:29:09 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t7so1774005otp.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R4/VtKOJLO5EHysrzcWQKq210x7a3ihbn5NllAZOqDc=;
        b=Zvsm12jI1rTzHU9PBOsVfBegcYC0YPFCyitwlGkjUT6oYBjEMnw97tUcGXdsFCwmAq
         6kY/8E9V792EmHOFhhqt0lYSTRKJf+hHLTQk+MM4IJfpWdVAfx10bhcE6gCzyvsmzbwE
         ycr1lxX/ai8kt/TwWavJbKr+Ygq203lRB+1uAcpUXWkK5k5OEQbsOHFgXJ/aDtsk1fBW
         Fh97GKme93TQFBxNp2527nOnCCCgDVKfrsClPlIeLbSC7CD8rk27wHkVsKAPXPtN1UwI
         XEP5KGfXdbwtwv8ApeaF2Txdsn367EJDGd1awFdc5IAIfPbvZVfh02Vw5dr2G9k0t9BV
         0wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R4/VtKOJLO5EHysrzcWQKq210x7a3ihbn5NllAZOqDc=;
        b=cJ4TtV5XSii2FJbi5tc28MYoxmTuXpby45h0rVCJU57S42FFRJ1x2uRUTV2Krpt7V5
         MpzW8CIipWQPgF/fQSsiUGdA3sIeRoFZvo913Kuh3rZQ0ljt/juz/17UHRvDosr276Bk
         EppaudIKljzk+g4D3QZlmpxJgf+I4FTfHuEPSWScPy8MUQecPh1Ev5JVMyKxH5tqPYlD
         Hbc4F7UsH/PudNAZcnotMKWBv/4gged/+qKop1/jA8T5r5UB/oQQyv6X0b2zVyx0bfkT
         nG/KKiwBzvlmu/2pibgDhBQY4yAG21DkNrQXmVaNlnXDRkEk67D1BcQaf/R0T7n3Ujxy
         WOGg==
X-Gm-Message-State: AOAM532Gblw4x2RVwdu9jXxIDRiGtZLxuXW4yF2jtbFsUFlWEPWLnnzp
        crQMBARkY1Y2aMsvsAgc8AA=
X-Google-Smtp-Source: ABdhPJwqfvkd4BUSU82nI2ImkiqjT0+YG1xXnWNHyx7u5kZ7G2LO7k9KXVazLBH/gr0PTGcW74jj4g==
X-Received: by 2002:a9d:824:: with SMTP id 33mr5815754oty.35.1597235348876;
        Wed, 12 Aug 2020 05:29:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14? ([2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14])
        by smtp.gmail.com with ESMTPSA id z63sm388267otb.19.2020.08.12.05.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 05:29:07 -0700 (PDT)
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ee5c0db0-6582-f039-96e1-be64ee4fe7a6@gmail.com>
Date:   Wed, 12 Aug 2020 08:29:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/2020 4:52 PM, Taylor Blau wrote:
> Introduce a command-line flag and configuration variable to fill in the
> 'max_new_filters' variable introduced by the previous patch.
> 
> The command-line option '--max-new-filters' takes precedence over
> 'commitGraph.maxNewFilters', which is the default value.
> '--no-max-new-filters' can also be provided, which sets the value back
> to '-1', indicating that an unlimited number of new Bloom filters may be
> generated. (OPT_INTEGER only allows setting the '--no-' variant back to
> '0', hence a custom callback was used instead).
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

...

> diff --git a/bloom.c b/bloom.c
> index ed54e96e57..8d07209c6b 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -51,6 +51,21 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
>  	else
>  		start_index = 0;
>  
> +	if ((start_index == end_index) &&
> +	    (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
> +		/*
> +		 * If the filter is zero-length, either (1) the filter has no
> +		 * changes, (2) the filter has too many changes, or (3) it
> +		 * wasn't computed (eg., due to '--max-new-filters').
> +		 *
> +		 * If either (1) or (2) is the case, the 'large' bit will be set
> +		 * for this Bloom filter. If it is unset, then it wasn't
> +		 * computed. In that case, return nothing, since we don't have
> +		 * that filter in the graph.
> +		 */
> +		return 0;
> +	}
> +

Here, you are creating a distinction between an "empty" filter and
a "too large" filter at a place that I don't think is important.

For instance, this code will be triggered by "git log -- <path>"
but you only care about the filter being too large when writing the
commit-graph. I think this check for a "too large" filter should
instead be inside get_or_compute_bloom_filter(). I include a patch
below that applies on top of tb/bloom-improvements that gets to
my point (and how minor the issue might be).

Thanks,
-Stolee

--- >8 ---

From 92a7a3d0f769fad7617426730cb97584a3d07794 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Wed, 12 Aug 2020 08:20:03 -0400
Subject: [PATCH] commit-graph: lazy-load large Bloom filter bitmap

The bloom_large bitmap in struct commit_graph is currently loaded
immediately upon first parse of the commit-graph file (when the chunk
exists). This is needed because the current implementation of
get_bloom_filter_from_graph() is special-cased to return NULL when the
filter is marked as "too large".

This has a slight drawback: before we can read a single commit out of
the commit-graph file, we need to load this entire chunk into memory.
This happens even for commands that don't need changed-path Bloom
filters, such as "git log -1".

This "too large" information is only used when writing a commit-graph
file, so we can delay the check for a large filter until after we check
compute_if_not_present in get_or_compute_bloom_filter(). Also, place
that lazy-load directly in the get_bloom_filter_large_in_graph() method,
so we ensure it is ready when needed.

This may be overkill. For a repository with one million commits, this
filter size is approximately 125 *kilobytes* of data. My local
measurements found that this took between 1 and 2 milliseconds to load
into memory. Even for repositories with 10 million commits, this
difference would not be noticeable for end-user commands.

On the other hand, these handfuls of milliseconds could add up when
running a hosting service using Git, so this extra effort is probably
worth it.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c        | 27 ++++++++-------------------
 commit-graph.c | 30 +++++++++++++++++-------------
 commit-graph.h |  8 ++++++++
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/bloom.c b/bloom.c
index 8d07209c6b..6d0884fa19 100644
--- a/bloom.c
+++ b/bloom.c
@@ -51,21 +51,6 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 	else
 		start_index = 0;
 
-	if ((start_index == end_index) &&
-	    (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
-		/*
-		 * If the filter is zero-length, either (1) the filter has no
-		 * changes, (2) the filter has too many changes, or (3) it
-		 * wasn't computed (eg., due to '--max-new-filters').
-		 *
-		 * If either (1) or (2) is the case, the 'large' bit will be set
-		 * for this Bloom filter. If it is unset, then it wasn't
-		 * computed. In that case, return nothing, since we don't have
-		 * that filter in the graph.
-		 */
-		return 0;
-	}
-
 	filter->len = end_index - start_index;
 	filter->data = (unsigned char *)(g->chunk_bloom_data +
 					sizeof(unsigned char) * start_index +
@@ -212,16 +197,20 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
-		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH &&
-			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
-				return filter;
+		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
+			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
 	}
 
-	if (filter->data)
+	if (filter && filter->len)
 		return filter;
 	if (!compute_if_not_present)
 		return NULL;
 
+	if (filter && !filter->len &&
+	    get_bloom_filter_large_in_graph(r->objects->commit_graph, c,
+	    				    settings->max_changed_paths))
+		return filter;
+
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
 	diffopt.detect_rename = 0;
diff --git a/commit-graph.c b/commit-graph.c
index 4aae5471e3..ea89f431cc 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -435,17 +435,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 			if (graph->chunk_bloom_large_filters)
 				chunk_repeated = 1;
 			else if (r->settings.commit_graph_read_changed_paths) {
-				size_t alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);
+				graph->bloom_large_alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);
 				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
 				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);
-				if (alloc) {
-					size_t j;
-					graph->bloom_large = bitmap_word_alloc(alloc);
-
-					for (j = 0; j < graph->bloom_large->word_alloc; j++)
-						graph->bloom_large->words[j] = get_be64(
-							graph->chunk_bloom_large_filters + j * sizeof(eword_t));
-				}
 			}
 			break;
 		}
@@ -953,9 +945,9 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
-static int get_bloom_filter_large_in_graph(struct commit_graph *g,
-					   const struct commit *c,
-					   uint32_t max_changed_paths)
+int get_bloom_filter_large_in_graph(struct commit_graph *g,
+				    const struct commit *c,
+				    uint32_t max_changed_paths)
 {
 	uint32_t graph_pos = commit_graph_position(c);
 	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
@@ -964,8 +956,20 @@ static int get_bloom_filter_large_in_graph(struct commit_graph *g,
 	while (g && graph_pos < g->num_commits_in_base)
 		g = g->base_graph;
 
-	if (!(g && g->bloom_large))
+	if (!g || !g->bloom_large_alloc)
 		return 0;
+
+	if (!g->bloom_large) {
+		size_t j;
+		g->bloom_large = bitmap_word_alloc(g->bloom_large_alloc);
+
+		for (j = 0; j < g->bloom_large->word_alloc; j++) {
+			const void *data = g->chunk_bloom_large_filters +
+					   j * sizeof(eword_t);
+			g->bloom_large->words[j] = get_be64(data);
+		}
+	}
+
 	if (g->bloom_filter_settings->max_changed_paths != max_changed_paths) {
 		/*
 		 * Force all commits which are subject to a different
diff --git a/commit-graph.h b/commit-graph.h
index 75ef83708b..126fd43380 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -51,6 +51,13 @@ void load_commit_graph_info(struct repository *r, struct commit *item);
 struct tree *get_commit_tree_in_graph(struct repository *r,
 				      const struct commit *c);
 
+/*
+ * Returns 1 if this commit was marked in the BFXL chunk as having more
+ * than max_changed_paths changes.
+ */
+int get_bloom_filter_large_in_graph(struct commit_graph *g,
+				    const struct commit *c,
+				    uint32_t max_changed_paths);
 struct commit_graph {
 	const unsigned char *data;
 	size_t data_len;
@@ -74,6 +81,7 @@ struct commit_graph {
 	const unsigned char *chunk_bloom_data;
 	const unsigned char *chunk_bloom_large_filters;
 
+	size_t bloom_large_alloc;
 	struct bitmap *bloom_large;
 
 	struct bloom_filter_settings *bloom_filter_settings;
-- 
2.28.0.38.gc6f546511c1


