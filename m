Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3489C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56BB20723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGR43QJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgE2Ivr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgE2Ivn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02619C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so2416422wmh.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6YxhcOeTLGvQ4A3/oRLd1a/aKbqOjLybu1G5SKuJ4o=;
        b=UGR43QJEi+ByaewTQP/VyOyNLwA8avRB4fu7yCBsoECeE8IdaswjhNAeGVU9u5gnGz
         Mg0KCDfTBjGDSqglS1t706M0hpxTsLAv+vZ7v3yBrm/FVrU7XkHGPCcMd1cwvBrA/Rf4
         nJoQG4cv2WXHd0nowc5iHlUgVALBG+xdv2izI4MqI4EvRlH45S4fKIUtfKorzBvqJV1G
         Nj6ugh/Kez5FFP81cxURFDukmeXAHFyTNz8KF/oZwI+xITePAb4DJSXpyMUvI095KLYy
         K5CqXy6MjIrlM/rLK2fKh7DZegyeVe3Pvg6bVAvMSJnIBf9J4o7r526u41IWJNzyuCQf
         FPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6YxhcOeTLGvQ4A3/oRLd1a/aKbqOjLybu1G5SKuJ4o=;
        b=g65O5HLGyRu3LgESpiYLJqR3EoKfC8HPmJAf4r4XJrANDKgAdNWIZoWDDC1bA/cm52
         Y2eOzJkBqdSAlywy/RF9tkec3OoD5WCi6mEphUzykyHwOdj3nkBL6CsSJL4/04MV747J
         N/4bJ78YKq218Ho1JRu58E6/P6wQWSnpHvn0ybcwoDc/aMd1LiB+dSdwlrYwSf3DGeFo
         nVTZzc7bw4m+OKreFv4WFGN6rmbm3s74F63qguPq8FvRcS4Jqn9G53h+6RoGJ6QCoOsH
         qNqWH7v13HhVDNe0Y6egYqdKJ+0ga4Bi4elVRWYmpZkalr00t5GFSn+4aBgqFZUzs8Lj
         nI7g==
X-Gm-Message-State: AOAM531fIMymIVp8mgeMYJTJuIhP934VKTwEODZnMWFRj2BW4n+EmCfZ
        eUrUNY+frRzcqbDTw5rxgFuTkex7
X-Google-Smtp-Source: ABdhPJzySL6vI4u3NmH7Oshm5r8CZKfYPF9MoA8gyenBBcXHSoBscvvgTmIpmyQS8MOq0ZWoNHMddg==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr7690219wmc.180.1590742300970;
        Fri, 29 May 2020 01:51:40 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:40 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 28/34] commit-graph: write Modified Path Bloom Filter Merge Index chunk
Date:   Fri, 29 May 2020 10:50:32 +0200
Message-Id: <20200529085038.26008-29-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Explain!]

The table below compares the runtime of

  git rev-list --full-history HEAD -- "$path"

with modified path Bloom filters for only first parents and with all
parents of merge commits for 5000+ randomly selected paths from each
repository.  It also shows the size increase of the commit-graph file:

                          |    Average runtime            |   commit-graph file size
                          |                               |
               Percentage |    first      all             |   first     all
                of merge  |   parent     merge    Average |  parent    merge     Size
                 commits  |    only     parents   speedup |   only    parents  increase
  ------------------------+-------------------------------+----------------------------
  android-base    73.6%   |  7.0890s    0.9681s    7.32x  |  29.8MB   218.0MB   7.32x
  cmssw           11.0%   |  0.7164s    0.2577s    2.78x  |  22.9MB    51.8MB   2.26x
  cpython         11.7%   |  0.3815s    0.1460s    2.61x  |   7.8MB    10.6MB   1.36x
  elasticsearch    8.4%   |  0.1217s    0.0582s    2.09x  |   9.6MB    10.9MB   1.14x
  gecko-dev        3.5%   |  1.6432s    0.9689s    1.70x  |  63.5MB    90.4MB   1.42x
  git             25.3%   |  0.8743s    0.1729s    5.06x  |   3.8MB    10.4MB   2.74x
  homebrew-cask    9.6%   |  1.1454s    0.1846s    6.20x  |   6.5MB     7.2MB   1.10x
  jdk             25.0%   |  0.2598s    0.1242s    2.09x  |  15.1MB    20.3MB   1.34x
  linux            7.4%   |  2.8037s    1.3339s    2.10x  |  78.1MB   269.8MB   3.45x
  rails           22.2%   |  0.2854s    0.0926s    3.08x  |   6.0MB     8.4MB   1.40x
  rust            27.0%   |  1.9803s    0.1794s   11.04x  |   8.2MB    22.0MB   2.68x
  tensorflow       9.1%   |  0.3886s    0.1237s    3.14x  |   9.0MB    19.0MB   2.11x

Storing modified path Bloom filters for all parents of merge commits
significantly increases the size of the Modified Path Bloom Filters
chunk, though when looking at the size of the whole commit-graph file
the relative increase is sometimes not that much.  FWIW, the average
speedup in most cases (except android-base and linux) is higher than
the size increase of the commit-graph file.

Beware!  To create a Bloom filter from the paths modified between a
commit and one of its parents, it seems natural to extend
create_modified_path_bloom_filter() with a 'struct commit *parent'
parameter...  and then things would blow up when encountering commit
a733a5da97b2 (Merge branches 'release' and 'fluff' into release,
2008-02-07) in linux.git:

  $ git -C linux.git log -1 a733a5da97b2 |head -n2
  commit a733a5da97b238e3e3167d3d0aee8fe1e8d04e97
  Merge: 299cfe38081b 299cfe38081b 9e52797131e8

Notice how the same commit is both the first _and_ second parent!  So
extend create_modified_path_bloom_filter()'s signature with the int
index of the particular parent.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config/core.txt |  13 +++
 commit-graph.c                | 169 +++++++++++++++++++++++++++++-----
 2 files changed, 158 insertions(+), 24 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 820f7d3bcf..b4311c5f31 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -594,6 +594,19 @@ core.modifiedPathBloomFilters::
 	commit-graph file to speed up pathspec-limited revision walks.
 	Defaults to false.
 
+core.modifiedPathBloomFiltersForAllMergeParents::
+	EXPERIMENTAL!!!
+	If true, then Git will store Bloom filters for all parents of
+	merge commits in the commit-graph file.
+	This has no impact on repositories with linear history.  In
+	repositories with lots of merge commits this considerably
+	increases the runtime of writing the commit-graph file and its
+	size.  It has little benefit in pathspec-limited revision walks
+	with the default history simplification, but can speed up
+	`--full-history` considerably.
+	Defaults to false, ignored if `core.modifiedPathBloomFilters` is
+	false.
+
 core.useReplaceRefs::
 	If set to `false`, behave as if the `--no-replace-objects`
 	option was given on the command line. See linkgit:git[1] and
diff --git a/commit-graph.c b/commit-graph.c
index 32738ba4b8..9cce79d452 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -65,12 +65,23 @@ struct modified_path_bloom_filter_info {
 	 * -1 before that.
 	 */
 	uint64_t offset;
+	uint32_t merge_index_pos;
+	struct modified_path_bloom_filter_info *next;
 };
 
 static void free_modified_path_bloom_filter_info_in_slab(
 		struct modified_path_bloom_filter_info *bfi)
 {
+	/* The instance got as parameter is on the slab, don't free() it. */
 	bloom_filter_free(&bfi->filter);
+	bfi = bfi->next;
+	/* The rest is in a linked list, and must be free()d. */
+	while (bfi) {
+		struct modified_path_bloom_filter_info *prev = bfi;
+		bloom_filter_free(&bfi->filter);
+		bfi = bfi->next;
+		free(prev);
+	}
 }
 
 define_commit_slab(modified_path_bloom_filters,
@@ -1115,7 +1126,8 @@ struct write_commit_graph_context {
 	const struct split_commit_graph_opts *split_opts;
 
 	struct modified_path_bloom_filter_context {
-		unsigned use_modified_path_bloom_filters:1;
+		unsigned use_modified_path_bloom_filters:1,
+			 all_merge_parents:1;
 		unsigned int num_hashes;
 		/*
 		 * Number of paths to be added to "embedded" modified path
@@ -1143,6 +1155,7 @@ struct write_commit_graph_context {
 
 		/* Excluding embedded modified path Bloom filters */
 		uint64_t total_filter_size;
+		uint32_t num_merge_index_entries;
 
 		/* Used to find identical modified path Bloom filters */
 		struct hashmap dedup_hashmap;
@@ -1361,28 +1374,70 @@ static int write_graph_chunk_modified_path_bloom_filters(struct hashfile *f,
 
 		bfi = modified_path_bloom_filters_peek(
 				&modified_path_bloom_filters, commit);
+		for (; bfi; bfi = bfi->next) {
+			if (bfi->duplicate_of)
+				continue;
+			if (!bfi->filter.nr_bits)
+				continue;
+			if (bfi->filter.nr_bits == GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS)
+				continue;
 
-		if (!bfi)
-			continue;
-		if (bfi->duplicate_of)
-			continue;
-		if (!bfi->filter.nr_bits)
-			continue;
-		if (bfi->filter.nr_bits == GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS)
-			continue;
+			if (offset >> 62)
+				BUG("offset %lu is too large for the Modified Path Bloom Filter Index chunk",
+				    offset);
+
+			bfi->offset = offset;
+
+			filter_size = bloom_filter_bytes(&bfi->filter);
+
+			hashwrite_be32(f, bfi->filter.nr_bits);
+			hashwrite(f, bfi->filter.bits, filter_size);
+
+			offset += sizeof(uint32_t) + filter_size;
+		}
+	}
+	return 0;
+}
 
-		if (offset >> 62)
-			BUG("offset %lu is too large for the Modified Path Bloom Filter Index chunk",
-			    offset);
+static int write_graph_chunk_modified_path_bloom_merge_index(
+		struct hashfile *f, struct write_commit_graph_context *ctx)
+{
+	const uint64_t no_bloom_filter = GRAPH_MODIFIED_PATH_BLOOM_FILTER_NONE;
+	uint32_t pos = 0;
+	int i;
 
-		bfi->offset = offset;
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *commit = ctx->commits.list[i];
+		struct modified_path_bloom_filter_info *bfi;
 
-		filter_size = bloom_filter_bytes(&bfi->filter);
+		display_progress(ctx->progress, ++ctx->progress_cnt);
 
-		hashwrite_be32(f, bfi->filter.nr_bits);
-		hashwrite(f, bfi->filter.bits, filter_size);
+		bfi = modified_path_bloom_filters_peek(
+				&modified_path_bloom_filters, commit);
 
-		offset += sizeof(uint32_t) + filter_size;
+		if (!bfi || !bfi->next)
+			/* No merge index entries for this commit. */
+			continue;
+
+		do {
+			if (bfi->duplicate_of) {
+				uint64_t offset = htonll(bfi->duplicate_of->offset);
+				hashwrite(f, &offset, sizeof(offset));
+			} else if (!bfi->filter.nr_bits) {
+				hashwrite(f, &no_bloom_filter,
+					  sizeof(no_bloom_filter));
+			} else if (bfi->filter.nr_bits == GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS) {
+				uint8_t filterdata[sizeof(uint64_t)];
+				memcpy(filterdata, bfi->filter.bits, sizeof(filterdata));
+				filterdata[0] |= 1 << 7;
+				hashwrite(f, filterdata, sizeof(filterdata));
+			} else if (bfi->offset != -1) {
+				uint64_t offset = htonll(bfi->offset);
+				hashwrite(f, &offset, sizeof(offset));
+			} else
+				BUG("modified path Bloom filter offset is still -1?!");
+			bfi->merge_index_pos = pos++;
+		} while ((bfi = bfi->next));
 	}
 	return 0;
 }
@@ -1403,7 +1458,19 @@ static int write_graph_chunk_modified_path_bloom_index(struct hashfile *f,
 		bfi = modified_path_bloom_filters_peek(
 				&modified_path_bloom_filters, commit);
 
-		if (!bfi || !bfi->filter.nr_bits) {
+		if (!bfi) {
+			hashwrite(f, &no_bloom_filter, sizeof(no_bloom_filter));
+		} else if (bfi->next) {
+			uint8_t filterdata[sizeof(uint64_t)];
+			if (!commit->parents->next)
+				BUG("uh-oh #1");
+			if (bfi->merge_index_pos == -1)
+				BUG("uh-oh #2");
+			memset(filterdata, 0, sizeof(filterdata));
+			filterdata[0] |= 1 << 6;
+			((uint32_t*)filterdata)[1] = htonl(bfi->merge_index_pos);
+			hashwrite(f, filterdata, sizeof(filterdata));
+		} else if (!bfi->filter.nr_bits) {
 			hashwrite(f, &no_bloom_filter, sizeof(no_bloom_filter));
 		} else if (bfi->filter.nr_bits == GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS) {
 			uint8_t filterdata[sizeof(uint64_t)];
@@ -1618,14 +1685,18 @@ static int handle_duplicate_modified_path_bloom_filter(
 
 static void create_modified_path_bloom_filter(
 		struct modified_path_bloom_filter_context *mpbfctx,
-		struct commit *commit)
+		struct commit *commit, int nth_parent)
 {
 	struct modified_path_bloom_filter_info *bfi;
 	struct object_id *parent_oid;
 	uintmax_t path_component_count;
+	int i;
 
 	if (!mpbfctx->use_modified_path_bloom_filters)
 		return;
+	if (nth_parent &&
+	    !mpbfctx->all_merge_parents)
+		return;
 
 	/*
 	 * This function can be called multiple times for the same commit
@@ -1635,11 +1706,25 @@ static void create_modified_path_bloom_filter(
 	 */
 	bfi = modified_path_bloom_filters_peek(&modified_path_bloom_filters,
 					       commit);
-	if (bfi && bfi->filter.nr_bits)
+	for (i = 0; i < nth_parent && bfi; i++, bfi = bfi->next);
+	if (i == nth_parent && bfi && bfi->filter.nr_bits)
 		return;
 
-	parent_oid = commit->parents ? &commit->parents->item->object.oid :
-				       NULL;
+	if (commit->parents) {
+		struct commit_list *p;
+		for (i = 0, p = commit->parents;
+		     i < nth_parent && p;
+		     i++, p = p->next);
+		if (!p)
+			BUG("couldn't find %dth parent of commit %s\n",
+			    nth_parent + 1, oid_to_hex(&commit->object.oid));
+		parent_oid = &p->item->object.oid;
+	} else {
+		if (nth_parent)
+			BUG("looking for the %dth parent of commit %s with no parents",
+			    nth_parent + 1, oid_to_hex(&commit->object.oid));
+		parent_oid = NULL;
+	}
 	mpbfctx->hashes_nr = 0;
 	strbuf_reset(&mpbfctx->prev_path);
 	diff_tree_oid(parent_oid, &commit->object.oid, "", &mpbfctx->diffopt);
@@ -1647,7 +1732,23 @@ static void create_modified_path_bloom_filter(
 
 	bfi = modified_path_bloom_filters_at(&modified_path_bloom_filters,
 					     commit);
+	if (!nth_parent) {
+		/* This is the right bloom_filter_info instance. */
+		if (mpbfctx->all_merge_parents &&
+		    commit->parents && commit->parents->next)
+			mpbfctx->num_merge_index_entries++;
+	} else {
+		/* i is one step ahead of bfi */
+		for (i = 1; i < nth_parent && bfi; i++, bfi = bfi->next);
+		if (bfi->next)
+			BUG("Huh?!?");
+		bfi->next = xcalloc(1, sizeof(*bfi));
+		bfi = bfi->next;
+		mpbfctx->num_merge_index_entries++;
+	}
+
 	bfi->offset = -1;
+	bfi->merge_index_pos = -1;
 	if (path_component_count > mpbfctx->embedded_limit)
 		bloom_filter_init(&bfi->filter, mpbfctx->num_hashes,
 				  path_component_count);
@@ -1667,10 +1768,20 @@ static void create_modified_path_bloom_filter(
 static void add_missing_parents(struct write_commit_graph_context *ctx, struct commit *commit)
 {
 	struct commit_list *parent;
+	int nth_parent;
+
+	if (!commit->parents) {
+		/* root commit */
+		create_modified_path_bloom_filter(&ctx->mpbfctx, commit, 0);
+		return;
+	}
 
-	create_modified_path_bloom_filter(&ctx->mpbfctx, commit);
+	for (parent = commit->parents, nth_parent = 0;
+	     parent;
+	     parent = parent->next, nth_parent++) {
+		create_modified_path_bloom_filter(&ctx->mpbfctx, commit,
+						  nth_parent);
 
-	for (parent = commit->parents; parent; parent = parent->next) {
 		if (!(parent->item->object.flags & REACHABLE)) {
 			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
 			oidcpy(&ctx->oids.list[ctx->oids.nr], &(parent->item->object.oid));
@@ -2079,6 +2190,13 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			chunks[chunks_nr].write_fn = write_graph_chunk_modified_path_bloom_filters;
 			chunks_nr++;
 		}
+		if (ctx->mpbfctx.num_merge_index_entries) {
+			ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
+			chunks[chunks_nr].id = GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_MERGE_INDEX;
+			chunks[chunks_nr].size = ctx->mpbfctx.num_merge_index_entries * sizeof(uint64_t);
+			chunks[chunks_nr].write_fn = write_graph_chunk_modified_path_bloom_merge_index;
+			chunks_nr++;
+		}
 		ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
 		chunks[chunks_nr].id = GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_INDEX;
 		chunks[chunks_nr].size = sizeof(uint8_t) +
@@ -2487,6 +2605,9 @@ int write_commit_graph(const char *obj_dir,
 		warning("not writing modified path Bloom filters with --split");
 	} else if (res) {
 		ctx->mpbfctx.use_modified_path_bloom_filters = 1;
+		if (!git_config_get_bool("core.modifiedPathBloomFiltersForAllMergeParents", &res) &&
+		    res)
+			ctx->mpbfctx.all_merge_parents = 1;
 		ctx->mpbfctx.num_hashes = GRAPH_MODIFIED_PATH_BLOOM_FILTER_DEFAULT_NR_HASHES;
 		ctx->mpbfctx.embedded_limit = GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS / (ctx->mpbfctx.num_hashes * 10 / 7);
 
-- 
2.27.0.rc1.431.g5c813f95dc

