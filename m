Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9CDC433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiBXUj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiBXUjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:39:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8412B179A39
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j17so1535143wrc.0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DvSQK/G2m6Bdv2aN+1Fpo52695PwNA5hh49bMwr88UM=;
        b=UE+nvRjKkjzyUFH4JYTPO4I+xP5lxm1W7aBPxq1EKtTUi3LiLWfYyg5yI+fJyGnDsm
         6F9x4Kq616taZdjYhb2UyZrZZf7fT5z/vA7vw7rgdZB4Wg5F0dqMfAsusrx9dZb+MsUO
         uyxQcF0iUZN0MkN73LdzhMRCxHnHw/Ds/hiQvZmBq8fhvN26SxBRuTCYDVRKAPJNkJzr
         a6Pk3WsQWJ6MhRUz9/L87U8WAeTKZD/sOIof7MX5sYqemCIrKAXf60+b/W2brja2Rag/
         1Ks+WesvIPG786HSuQiqozjZvGkxpPOmIjS5iNIWiLu8jDQyrfSvnlqtFW93+oyr/igx
         CbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DvSQK/G2m6Bdv2aN+1Fpo52695PwNA5hh49bMwr88UM=;
        b=IHfh183oE+zo9eOV7GEOc+3C748vo8mIQ8AMjESLFdFpaW3gBhiU++7Q/MSNagnHLG
         dg0KJBx4GFcRa9iITM2M96yO8Yg0VIvlBz5DQVGDYt805R2xr/zpYu4qwYTJXVZRL79D
         n3PH1IrL0SCsPNpAKyOh4GbTMQ5HbCbeP/oCJcUTibvJYu9quffTIzkmhSxSkgUQKD9Q
         vwuUiLbF1xHHIvb2u8IzsbQAoChkMt43Msf2JfGYplCmPP/FivryWNumskg65XFjV1Ri
         lSDVFrmDKLxjl4Oo4mOkOnVeZWUfzNhzjA+zvX3Vq4x19moXGTXXTIVCxeSQFVNlJ9SR
         EcDQ==
X-Gm-Message-State: AOAM5337isQ+9J3I0koiCCJ24IXNXhNZETJr0h3aOUdZ2k7LO1ElYY+C
        0MTmjpBqm8hn1y/ezPr4RT6KklNd9i0=
X-Google-Smtp-Source: ABdhPJzuljswhmeaO20f2wAE9Gc51sSRK4CqvVmOVG99qL+0lNovSeKF7fR3ONzpMUUbIrs+ABmgjw==
X-Received: by 2002:adf:d22d:0:b0:1ed:f5c3:b654 with SMTP id k13-20020adfd22d000000b001edf5c3b654mr3117536wrh.497.1645735123802;
        Thu, 24 Feb 2022 12:38:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1-20020a05600c2f8100b003811ff27380sm1236597wmn.10.2022.02.24.12.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:38:43 -0800 (PST)
Message-Id: <ade697c4d34a43d09db5be686591b2dc7d68f012.1645735117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 20:38:36 +0000
Subject: [PATCH 7/7] commit-graph: write file format v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The commit-graph file format v2 exists so we can modify the meaning of
the Commit Data chunk to store corrected commit date offsets. Thus, we
trigger the write to use this different file format only if the
configured generation number version is 3.

The implementation needs to be careful of a few things to ensure we
enable computing corrected commit dates and do not compute topological
levels. We also still need the Generation Data Overflow chunk, but we
compute the offsets into that chunk while writing the Commit Data chunk
instead of the generation Data chunk.

Testing 'git merge-base v4.8 v4.9' in the Linux kernel with corrected
commit dates, but the only difference being the file format (between
generation number v2 and v3) we get these results:

Benchmark 1: generation number v2
  Time (mean ± σ):     144.4 ms ±   8.3 ms
  Range (min … max):   127.4 ms … 154.6 ms    20 runs

Benchmark 2: generation number v3
  Time (mean ± σ):     139.3 ms ±   7.3 ms
  Range (min … max):   125.1 ms … 148.1 ms    20 runs

This provides a 3.6% improvement, and the only reason is the reduced
I/O. This test was run with hot caches, so I re-ran it in the cold-cache
case, trying to demonstrate that this I/O cost is higher when reading
directly from disk every time:

Benchmark 1: generation number v2
  Time (mean ± σ):     469.9 ms ±  14.8 ms
  Range (min … max):   434.5 ms … 494.4 ms    10 runs

Benchmark 2: generation number v3
  Time (mean ± σ):     413.4 ms ±  18.9 ms
  Range (min … max):   372.8 ms … 428.3 ms    10 runs

With cold caches, the improvement increases to 13.4%.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/commitgraph.txt |  4 ++-
 commit-graph.c                       | 46 +++++++++++++++++++++++++---
 commit.h                             |  1 +
 t/t5318-commit-graph.sh              | 25 ++++++++++++++-
 4 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 30604e4a4c2..79d57d06a67 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -1,7 +1,9 @@
 commitGraph.generationVersion::
 	Specifies the type of generation number version to use when writing
 	or reading the commit-graph file. If version 1 is specified, then
-	the corrected commit dates will not be written or read. Defaults to
+	the corrected commit dates will not be written or read. If version
+	3 is specified, then the commit-graph file will be slightly smaller,
+	but will be incompatible with some old versions of Git. Defaults to
 	2.
 
 commitGraph.maxNewFilters::
diff --git a/commit-graph.c b/commit-graph.c
index 366fc4d6e41..82f7401b283 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1035,6 +1035,7 @@ struct write_commit_graph_context {
 	struct progress *progress;
 	int progress_done;
 	uint64_t progress_cnt;
+	int version;
 
 	char *base_graph_name;
 	int num_commit_graphs_before;
@@ -1118,12 +1119,14 @@ static int write_graph_chunk_data(struct hashfile *f,
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	uint32_t num_extra_edges = 0;
+	int num_generation_data_overflows = 0;
 
 	while (list < last) {
 		struct commit_list *parent;
 		struct object_id *tree;
 		int edge_value;
 		uint32_t packedDate[2];
+		uint32_t generation_data;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
 		if (repo_parse_commit_no_graph(ctx->r, *list))
@@ -1203,7 +1206,18 @@ static int write_graph_chunk_data(struct hashfile *f,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
+		if (ctx->version == GRAPH_VERSION_1)
+			generation_data = *topo_level_slab_at(ctx->topo_levels, *list);
+		else {
+			generation_data = commit_graph_data_at(*list)->generation - (*list)->date;
+			if (generation_data > GENERATION_NUMBER_V3_OFFSET_MAX) {
+				generation_data = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW_V3 |
+						  num_generation_data_overflows;
+				num_generation_data_overflows++;
+			}
+		}
+
+		packedDate[0] |= htonl(generation_data << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1243,12 +1257,16 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
 {
 	struct write_commit_graph_context *ctx = data;
 	int i;
+	timestamp_t offset_max = ctx->version >= 2 ?
+					GENERATION_NUMBER_V3_OFFSET_MAX :
+					GENERATION_NUMBER_V2_OFFSET_MAX;
+
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
-		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
+		if (offset > offset_max) {
 			hashwrite_be32(f, offset >> 32);
 			hashwrite_be32(f, (uint32_t) offset);
 		}
@@ -1474,6 +1492,13 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 	int i;
 	struct commit_list *list = NULL;
 
+	/*
+	 * Skip topological levels if file format version is two or more,
+	 * since the Commit Data chunk uses corrected commit date offsets.
+	 */
+	if (ctx->version >= 2)
+		return;
+
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
 					_("Computing commit graph topological levels"),
@@ -1526,6 +1551,9 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct commit_list *list = NULL;
+	timestamp_t offset_max = ctx->version >= 2 ?
+					GENERATION_NUMBER_V3_OFFSET_MAX :
+					GENERATION_NUMBER_V2_OFFSET_MAX;
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -1585,7 +1613,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
-		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
+		if (offset > offset_max)
 			ctx->num_generation_data_overflows++;
 	}
 	stop_progress(&ctx->progress);
@@ -1908,7 +1936,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	add_chunk(cf, GRAPH_CHUNKID_DATA, (hashsz + 16) * ctx->commits.nr,
 		  write_graph_chunk_data);
 
-	if (ctx->write_generation_data)
+	if (ctx->write_generation_data && ctx->version == GRAPH_VERSION_1)
 		add_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			  sizeof(uint32_t) * ctx->commits.nr,
 			  write_graph_chunk_generation_data);
@@ -1936,7 +1964,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
-	hashwrite_u8(f, GRAPH_VERSION_1);
+	hashwrite_u8(f, ctx->version);
 	hashwrite_u8(f, oid_version());
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
@@ -2317,6 +2345,14 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
+	if (get_configured_generation_version(r) == 3)
+		ctx->version = GRAPH_VERSION_2;
+	else
+		ctx->version = GRAPH_VERSION_1;
+
+	if (ctx->version >= GRAPH_VERSION_2)
+		ctx->write_generation_data = 1;
+
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
diff --git a/commit.h b/commit.h
index 38cc5426615..a668b5cdec0 100644
--- a/commit.h
+++ b/commit.h
@@ -15,6 +15,7 @@
 #define GENERATION_NUMBER_V1_MAX 0x3FFFFFFF
 #define GENERATION_NUMBER_ZERO 0
 #define GENERATION_NUMBER_V2_OFFSET_MAX ((1ULL << 31) - 1)
+#define GENERATION_NUMBER_V3_OFFSET_MAX ((1ULL << 29) - 1)
 
 struct commit_list {
 	struct commit *item;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a14a13e5f7b..77e130ef63e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -110,8 +110,13 @@ graph_read_expect() {
 	then
 		OPTIONS=" read_generation_data"
 	fi
+	VERSION=1
+	if test $GENERATION_VERSION -gt 2
+	then
+		VERSION=2
+	fi
 	cat >expect <<- EOF
-	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
+	header: 43475048 $VERSION $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
 	options:$OPTIONS
@@ -343,6 +348,15 @@ test_expect_success 'build graph using --reachable' '
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'write file format v2 with generation number v3' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git -c commitGraph.generationVersion=3 commit-graph write --reachable &&
+	graph_read_expect "11" "extra_edges" 3
+'
+
+graph_git_behavior 'graph v2, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'graph v2, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
@@ -880,6 +894,15 @@ test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'set up and verify repo with g
 
 graph_git_behavior 'generation data overflow chunk repo' repo left right
 
+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'set up and verify repo with generation data overflow chunk (v3)' '
+	cd "$TRASH_DIRECTORY/repo" &&
+	git -c commitGraph.generationVersion=3 commit-graph write --reachable &&
+	graph_read_expect 10 "generation_data_overflow" 3 &&
+	git commit-graph verify
+'
+
+graph_git_behavior 'generation data overflow chunk repo' repo left right
+
 # Do not add tests at the end of this file, unless they require 64-bit
 # timestamps, since this portion of the script is only executed when
 # time data types have 64 bits.
-- 
gitgitgadget
