Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AE3C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CDC20730
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfp3ar87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBEW4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46285 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbgBEW4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so4786055wrl.13
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=giTjJmwJhq1qUSbIqFOOEMqe01ON8bbkk5K6qbT/7kI=;
        b=qfp3ar875Z90lQm5x7ZYHG0cAGoqjT+xHSBSsUT7R2RRZI7pp93mgXKJiN9cgZ8IbE
         R7L2EFvK/vq9ExKuJgXDDBQjyvMfrgigS7LQtzpHVnLxigOY8KBZJdo15q9SBFpwabrf
         TccnYcPGNno67fQ+DIaV5d4aFCISrznHiVawSVjSHj9IvqiRAXfwtBlGoMREOV30Jx7O
         5c4Ig4oXlQzLi2/XfLFHBOcM9Gb+Op5N/wtcZDoVELm89/o2FwUS27qP5yb0zBGHiiA/
         unCAkueogUVMkg+K0FLavuRwTk1NCQ6kws74l5tyLmNDKMko2veHFNPWhV2EERUGF/lj
         feig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=giTjJmwJhq1qUSbIqFOOEMqe01ON8bbkk5K6qbT/7kI=;
        b=ODzLKcaqgrF/vqEIwh3AcpQPiy9iPvwW2uqd3n8QUq0bTUqwMULJ7EZGvlip5XRfIt
         bEeBhhdmR4yQ86QzVZW/1v7uCsj+Vkpkmypy8BG9qIzOWNe3C0b0dyooxuwCoN0BmBs3
         FdWJslRWaSZzzKPCjyjuZdf5LJEqOFMEpu+aSXtH0u0XMasps2xp62RzSuZXqf4qidrH
         rVef/Vb8rbXydi8RtrBiiVHoZg7p9rzDiGuhFSxeebpQkJwBbog9Xh4mDBBevPsRi51P
         977IHG3f1oHu6W5DOY2d8nX7/HGEBJNDrZb4TQqlj5Je1D+pQ4cKArQNnxhuy9rw5IHs
         DIsw==
X-Gm-Message-State: APjAAAUnRQQ8N/kmRzxDbpI/58svuPJywc1hthHj/V5dVusS3n5NXxkt
        CycR28B+g6LBMTzHA43r0kki2hO/
X-Google-Smtp-Source: APXvYqzILyuLNhE70i7fS0Nbm2DTl3JIhCc1YdOSc0OO6EZ3XQsfVVZ7fSSkXgLmGwtvD4aiy7hhig==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr198563wru.398.1580943396833;
        Wed, 05 Feb 2020 14:56:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm1604401wrs.73.2020.02.05.14.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:36 -0800 (PST)
Message-Id: <39ee0610800d7d2d92785d392df941fc5a0b231b.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:26 +0000
Subject: [PATCH v2 07/11] commit-graph: write Bloom filters to commit graph
 file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Update the technical documentation for commit-graph-format with the formats for
the Bloom filter index (BIDX) and Bloom filter data (BDAT) chunks. Write the
computed Bloom filters information to the commit graph file using this format.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 .../technical/commit-graph-format.txt         |  24 ++++
 commit-graph.c                                | 118 +++++++++++++++++-
 commit-graph.h                                |   7 +-
 3 files changed, 145 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index a4f17441ae..22e511643d 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -17,6 +17,9 @@ metadata, including:
 - The parents of the commit, stored using positional references within
   the graph file.
 
+- The Bloom filter of the commit carrying the paths that were changed between
+  the commit and its first parent.
+
 These positional references are stored as unsigned 32-bit integers
 corresponding to the array position within the list of commit OIDs. Due
 to some special constants we use to track parents, we can store at most
@@ -93,6 +96,27 @@ CHUNK DATA:
       positions for the parents until reaching a value with the most-significant
       bit on. The other bits correspond to the position of the last parent.
 
+  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
+    * The ith entry, BIDX[i], stores the number of 8-byte word blocks in all
+      Bloom filters from commit 0 to commit i (inclusive) in lexicographic
+      order. The Bloom filter for the i-th commit spans from BIDX[i-1] to
+      BIDX[i] (plus header length), where BIDX[-1] is 0.
+    * The BIDX chunk is ignored if the BDAT chunk is not present.
+
+  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
+    * It starts with header consisting of three unsigned 32-bit integers:
+      - Version of the hash algorithm being used. We currently only support
+	value 1 which implies the murmur3 hash implemented exactly as described
+	in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
+      - The number of times a path is hashed and hence the number of bit positions
+	that cumulatively determine whether a file is present in the commit.
+      - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
+	contains 'n' entries, then the filter size is the minimum number of 64-bit
+	words that contain n*b bits.
+    * The rest of the chunk is the concatenation of all the computed Bloom
+      filters for the commits in lexicographic order.
+    * The BDAT chunk is present iff BIDX is present.
+
   Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
       This list of H-byte hashes describe a set of B commit-graph files that
       form a commit-graph chain. The graph position for the ith commit in this
diff --git a/commit-graph.c b/commit-graph.c
index 32a315058f..4585b3b702 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -24,8 +24,10 @@
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
+#define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
+#define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
-#define MAX_NUM_CHUNKS 5
+#define MAX_NUM_CHUNKS 7
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -325,6 +327,32 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 				chunk_repeated = 1;
 			else
 				graph->chunk_base_graphs = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_BLOOMINDEXES:
+			if (graph->chunk_bloom_indexes)
+				chunk_repeated = 1;
+			else
+				graph->chunk_bloom_indexes = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_BLOOMDATA:
+			if (graph->chunk_bloom_data)
+				chunk_repeated = 1;
+			else {
+				uint32_t hash_version;
+				graph->chunk_bloom_data = data + chunk_offset;
+				hash_version = get_be32(data + chunk_offset);
+
+				if (hash_version != 1)
+					break;
+
+				graph->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
+				graph->bloom_filter_settings->hash_version = hash_version;
+				graph->bloom_filter_settings->num_hashes = get_be32(data + chunk_offset + 4);
+				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
+			}
+			break;
 		}
 
 		if (chunk_repeated) {
@@ -343,6 +371,17 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		last_chunk_offset = chunk_offset;
 	}
 
+	/* We need both the bloom chunks to exist together. Else ignore the data */
+	if ((graph->chunk_bloom_indexes && !graph->chunk_bloom_data)
+		 || (!graph->chunk_bloom_indexes && graph->chunk_bloom_data)) {
+		graph->chunk_bloom_indexes = NULL;
+		graph->chunk_bloom_data = NULL;
+		graph->bloom_filter_settings = NULL;
+	}
+
+	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data)
+		load_bloom_filters();
+
 	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
 
 	if (verify_commit_graph_lite(graph)) {
@@ -1040,6 +1079,59 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 	}
 }
 
+static void write_graph_chunk_bloom_indexes(struct hashfile *f,
+					    struct write_commit_graph_context *ctx)
+{
+	struct commit **list = ctx->commits.list;
+	struct commit **last = ctx->commits.list + ctx->commits.nr;
+	uint32_t cur_pos = 0;
+	struct progress *progress = NULL;
+	int i = 0;
+
+	if (ctx->report_progress)
+		progress = start_delayed_progress(
+			_("Writing changed paths Bloom filters index"),
+			ctx->commits.nr);
+
+	while (list < last) {
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		cur_pos += filter->len;
+		display_progress(progress, ++i);
+		hashwrite_be32(f, cur_pos);
+		list++;
+	}
+
+	stop_progress(&progress);
+}
+
+static void write_graph_chunk_bloom_data(struct hashfile *f,
+					 struct write_commit_graph_context *ctx,
+					 struct bloom_filter_settings *settings)
+{
+	struct commit **list = ctx->commits.list;
+	struct commit **last = ctx->commits.list + ctx->commits.nr;
+	struct progress *progress = NULL;
+	int i = 0;
+
+	if (ctx->report_progress)
+		progress = start_delayed_progress(
+			_("Writing changed paths Bloom filters data"),
+			ctx->commits.nr);
+
+	hashwrite_be32(f, settings->hash_version);
+	hashwrite_be32(f, settings->num_hashes);
+	hashwrite_be32(f, settings->bits_per_entry);
+
+	while (list < last) {
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		display_progress(progress, ++i);
+		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
+		list++;
+	}
+
+	stop_progress(&progress);
+}
+
 static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
@@ -1198,8 +1290,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	load_bloom_filters();
 
 	if (ctx->report_progress)
-		progress = start_progress(
-			_("Computing commit diff Bloom filters"),
+		progress = start_delayed_progress(
+			_("Computing changed paths Bloom filters"),
 			ctx->commits.nr);
 
 	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
@@ -1444,6 +1536,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
 	struct object_id file_hash;
+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -1488,6 +1581,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
 		num_chunks++;
 	}
+	if (ctx->changed_paths) {
+		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMINDEXES;
+		num_chunks++;
+		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMDATA;
+		num_chunks++;
+	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
 		num_chunks++;
@@ -1506,6 +1605,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 						4 * ctx->num_extra_edges;
 		num_chunks++;
 	}
+	if (ctx->changed_paths) {
+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
+						sizeof(uint32_t) * ctx->commits.nr;
+		num_chunks++;
+
+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
+						sizeof(uint32_t) * 3 + ctx->total_bloom_filter_data_size;
+		num_chunks++;
+	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
 						hashsz * (ctx->num_commit_graphs_after - 1);
@@ -1543,6 +1651,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	write_graph_chunk_data(f, hashsz, ctx);
 	if (ctx->num_extra_edges)
 		write_graph_chunk_extra_edges(f, ctx);
+	if (ctx->changed_paths) {
+		write_graph_chunk_bloom_indexes(f, ctx);
+		write_graph_chunk_bloom_data(f, ctx, &bloom_settings);
+	}
 	if (ctx->num_commit_graphs_after > 1 &&
 	    write_graph_chunk_base(f, ctx)) {
 		return -1;
diff --git a/commit-graph.h b/commit-graph.h
index 952a4b83be..25fefefb3e 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -10,6 +10,7 @@
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
 
 struct commit;
+struct bloom_filter_settings;
 
 char *get_commit_graph_filename(const char *obj_dir);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
@@ -58,6 +59,10 @@ struct commit_graph {
 	const unsigned char *chunk_commit_data;
 	const unsigned char *chunk_extra_edges;
 	const unsigned char *chunk_base_graphs;
+	const unsigned char *chunk_bloom_indexes;
+	const unsigned char *chunk_bloom_data;
+
+	struct bloom_filter_settings *bloom_filter_settings;
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
@@ -77,7 +82,7 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
 	/* Make sure that each OID in the input is a valid commit OID. */
 	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
-	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4)
+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
 };
 
 struct split_commit_graph_opts {
-- 
gitgitgadget

