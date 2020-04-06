Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90751C2BB1D
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C05D21841
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIhbfxoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgDFRAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38520 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbgDFRAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id e5so379171edq.5
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mCODFr8ve01DYmbjK4Fo96EeGpzXWBRbaONvoDMgaPc=;
        b=pIhbfxoZPxBcEUz5EIbb02gjXhmnqeG5T1wG+L9ulk34q1GbkzwpLks26sXMyxzRyB
         231L3n39nA62LTFDMPRZcQb3/5Ma1Lv6aWHo2PZsc2InDe7dVWOyrgVLtXZKcN/mG7Ot
         D3+OHKe5+9yal1zpQdWrvck5PakcBQQQq2ejSzXUnhaQK0wniqYVQ6Hiw4tXlGE52itu
         UmVt5g0noq+Z8mpTOAGmUkvDaQzeXSvKwE2SNEw0jhL7AwCEiNPsS1gu0U29Ziyyz74i
         miDJrHyaZoKUcY70Ng3sttb8P0Ij8Wj3oO3QUXt3VUFuGLpXWWM8URAOU+wv1xBArNck
         Dk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mCODFr8ve01DYmbjK4Fo96EeGpzXWBRbaONvoDMgaPc=;
        b=Vevu2zcD8c0xFYO7HlwvKWeu3/7DS3a9sGDNWLZpl7JVXlpwByaQBMBXv1FNd9lYUG
         101+Ikf2q6jw7yfbMo5YsqK95MOJuiprZXaen7/sFy7EZLzescTAUSl9dICMHBa3mRHh
         ywbeHi0avEFhxebuNRC17YCFW6+U5gwFX/WtOusYUMlNzfeKu7OrqBlX9e6+5dK78zy+
         3MAC5LFFYKidoT9Ugf772abPKDMwPUSnNDMSMcazoxK2o++32lbWooeO6Z9iMJr5PtKf
         UXpJa/Wav+zhuQOj5yWyG6GUQ2ZV7RVpTW4fEkE9nX+S1zge44dJcUSw4NvPVeqObCwa
         0S9w==
X-Gm-Message-State: AGi0PuYO0Ft2452qYhU/74GhocPDG6zGkvuj149oBXUEzZDP8W8X0YPX
        N8PFc8/CITLZaomXjrENgzYu4nE1
X-Google-Smtp-Source: APiQypJeowY5aCnRS8Sa64EwGbFIlz3rV1przZa8Xm2pCub/0oxQGP9V0+9+eUdhTvhpXPrT0JATWg==
X-Received: by 2002:a17:906:7d4:: with SMTP id m20mr466804ejc.10.1586192404331;
        Mon, 06 Apr 2020 10:00:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21sm2958780ejz.10.2020.04.06.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:00:03 -0700 (PDT)
Message-Id: <cc8022bdf82d0ada326ad546fdd7bb7801fc3675.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:50 +0000
Subject: [PATCH v4 10/15] commit-graph: reuse existing Bloom filters during
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
index a16eee92331..0f714dd76ae 100644
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
 	diffopt.max_changes = max_changes;
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

