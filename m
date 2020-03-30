Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949CC2D0E9
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F8D206DB
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5TsM2T7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgC3AcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:32:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34023 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgC3Abu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so19329573wrl.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nMGufsqR/XuepG8BkTiDLOnDxNLVb8iA10FszPkrhg4=;
        b=L5TsM2T7IuxhJFwtLLAZ9AzyjhbOLqaEOsSsWTGeSfc6XsWj5mHEK45aqBjF5XDQJw
         U2k69ZwHWTVTVcs6PuueV01l4vCAH1kexUte/ppzSBWQtHcrBpkAtUHl4X6KKifjfn9y
         D9DbN5mRdvzIIlVzpL+o0hmPVUB9x6V19mtw2uJa8SKjBcfchUHkMf0FgfNn9sIMjbGt
         1tJlUoPMBiPDnFgUZGqAzZy4Fr058cx3JmAWCp5oDcD9Ie8xCJomqHIcPoITTexvP8Mz
         rpyzeaKhVnFe02bx0uT9083X7rPyBIKdIzY25u5wtOe0GRZLowZcLb7Idup7jCm7KGhY
         t3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nMGufsqR/XuepG8BkTiDLOnDxNLVb8iA10FszPkrhg4=;
        b=A6+rKppqQooeaaaJMwSKS280+DE2DRR5jUTpD1EB0nfsGmXUWGOmhXlkqSto6jkzC1
         lxo5yoy2PBzzAk17soJYdjAoZrksiDpjTWCKIW4ChA1QQusMkcoZuphR2TBGEE9PUGSa
         OJS6K0pufRslav0X80+lb8Q7On/pqo3OmoYDkn/56Kb38MAQIhUg+QTCvnd80pgHMjyj
         Dh6olBFLt0mLfHY+06fFPmvlZovWxLJgH4sFM7XMW2GNZj9YeZAD6cImPdRD+X3W/z04
         nxQMJcdktbUHe3UczWMQfVtk8H9OM2D012b1xflWoTE080MUT8lMnk+rn9IUtji/ZfC+
         9K+g==
X-Gm-Message-State: ANhLgQ23o+UyblP1Hyg6pbBI8K9IDuVfiRTkCFF+ioDWvFhBjM2Cdyyg
        4PUX2UWMb1CjvoNyorYPf6oquvTn
X-Google-Smtp-Source: ADFU+vucnpB1jFp+CzmEHP2g6ITOglIG5wj+7Hz6qxWJMpl5nwBtYXuJ38IRJO4y2BLaDq138ZtRSA==
X-Received: by 2002:adf:9e94:: with SMTP id a20mr12492807wrf.334.1585528309525;
        Sun, 29 Mar 2020 17:31:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm7138457wmh.37.2020.03.29.17.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:49 -0700 (PDT)
Message-Id: <68395d4051b7b2863c1dc3d758e7066f2b16a81d.1585528299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:33 +0000
Subject: [PATCH v3 11/16] commit-graph: reuse existing Bloom filters during
 write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add logic to
a) parse Bloom filter information from the commit graph file and,
b) re-use existing Bloom filters.

See Documentation/technical/commit-graph-format for the format in which
the Bloom filter information is written to the commit graph file.

To read Bloom filter for a given commit with lexicographic position
'i' we need to:
1. Read BIDX[i] which essentially gives us the starting index in BDAT for
   filter of commit i+1. It is essentially the index past the end
   of the filter of commit i. It is called end_index in the code.

2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT
   for filter of commit i. It is called the start_index in the code.
   For the first commit, where i = 0, Bloom filter data starts at the
   beginning, just past the header in the BDAT chunk. Hence, start_index
   will be 0.

3. The length of the filter will be end_index - start_index, because
   BIDX[i] gives the cumulative 8-byte words including the ith
   commit's filter.

We toggle whether Bloom filters should be recomputed based on the
compute_if_not_present flag.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c               | 49 ++++++++++++++++++++++++++++++++++++++++++-
 bloom.h               |  4 +++-
 commit-graph.c        |  6 +++---
 t/helper/test-bloom.c |  2 +-
 4 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/bloom.c b/bloom.c
index dbcf594baec..151d598ce7b 100644
--- a/bloom.c
+++ b/bloom.c
@@ -4,6 +4,8 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "hashmap.h"
+#include "commit-graph.h"
+#include "commit.h"
 
 define_commit_slab(bloom_filter_slab, struct bloom_filter);
 
@@ -26,6 +28,36 @@ static inline unsigned char get_bitmask(uint32_t pos)
 	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
 }
 
+static int load_bloom_filter_from_graph(struct commit_graph *g,
+				   struct bloom_filter *filter,
+				   struct commit *c)
+{
+	uint32_t lex_pos, start_index, end_index;
+
+	while (c->graph_pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
+	if (!g->chunk_bloom_indexes)
+		return 0;
+
+	lex_pos = c->graph_pos - g->num_commits_in_base;
+
+	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
+
+	if (lex_pos > 0)
+		start_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
+	else
+		start_index = 0;
+
+	filter->len = end_index - start_index;
+	filter->data = (unsigned char *)(g->chunk_bloom_data +
+					sizeof(unsigned char) * start_index +
+					BLOOMDATA_CHUNK_HEADER_SIZE);
+
+	return 1;
+}
+
 /*
  * Calculate the murmur3 32-bit hash value for the given data
  * using the given seed.
@@ -127,7 +159,8 @@ void init_bloom_filters(void)
 }
 
 struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c)
+				      struct commit *c,
+					  int compute_if_not_present)
 {
 	struct bloom_filter *filter;
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
@@ -140,6 +173,20 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	filter = bloom_filter_slab_at(&bloom_filters, c);
 
+	if (!filter->data) {
+		load_commit_graph_info(r, c);
+		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
+			r->objects->commit_graph->chunk_bloom_indexes) {
+			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
+				return filter;
+			else
+				return NULL;
+		}
+	}
+
+	if (filter->data || !compute_if_not_present)
+		return filter;
+
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
 	diffopt.detect_rename = 0;
diff --git a/bloom.h b/bloom.h
index 85ab8e9423d..760d7122374 100644
--- a/bloom.h
+++ b/bloom.h
@@ -32,6 +32,7 @@ struct bloom_filter_settings {
 
 #define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
 #define BITS_PER_WORD 8
+#define BLOOMDATA_CHUNK_HEADER_SIZE 3 * sizeof(uint32_t)
 
 /*
  * A bloom_filter struct represents a data segment to
@@ -79,6 +80,7 @@ void add_key_to_filter(const struct bloom_key *key,
 void init_bloom_filters(void);
 
 struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c);
+				      struct commit *c,
+				      int compute_if_not_present);
 
 #endif
\ No newline at end of file
diff --git a/commit-graph.c b/commit-graph.c
index a8b6b5cca5d..77668629e27 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1086,7 +1086,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 			ctx->commits.nr);
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
 		cur_pos += filter->len;
 		display_progress(progress, ++i);
 		hashwrite_be32(f, cur_pos);
@@ -1115,7 +1115,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	hashwrite_be32(f, settings->bits_per_entry);
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
 		display_progress(progress, ++i);
 		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
 		list++;
@@ -1296,7 +1296,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = sorted_commits[i];
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
 		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
 		display_progress(progress, i + 1);
 	}
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index f18d1b722e1..ce412664ba9 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -39,7 +39,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 	struct bloom_filter *filter;
 	setup_git_directory();
 	c = lookup_commit(the_repository, commit_oid);
-	filter = get_bloom_filter(the_repository, c);
+	filter = get_bloom_filter(the_repository, c, 1);
 	print_bloom_filter(filter);
 }
 
-- 
gitgitgadget

