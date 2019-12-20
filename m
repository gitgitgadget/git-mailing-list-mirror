Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F99BC2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473B5218AC
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snVPbPIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfLTWF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46994 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLTWF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so9821976edi.13
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n+fhWLRRV8jUrq3jgjTXCVMg0G/wpmNbhsUWvsWJmdg=;
        b=snVPbPIVGAm6s3mv44QCDyyiYbDuhFjgsk1Xwzbq8rxP1JscFS3b4SXd/2ESTKquz5
         FiVZnFWSeDpWCRt4YgwxTBOMTax9I3Qzv5KLTvnQWmedj49jylh3nF+dXfJJTUayi8Oz
         k/b2lM3UwTd0TRrsfNskyjCECtZCFhncsklq+g+jJ5aCaU2kPscFoU3W+p3qLG6uuNqY
         8CO4GAerYc79K/jesq7kYzyWk88JnQOr9aXDduiDpQEhT4eFnOm/GTCHtSYL4JVaBPH2
         motEqV8BagZ2wRlBsUN8R6esn7F62FTuwJ0pIjvvHub0ZxyDpMFKwhUzrIR4Dd5CsX5i
         PZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n+fhWLRRV8jUrq3jgjTXCVMg0G/wpmNbhsUWvsWJmdg=;
        b=X7xvP20Z4Ee4yf8BeQwC1rb8i1n71xX4+ht6uqrLl/HV5suVfeM2pU4wOn0BAOpmWH
         FzbgRIa6U/exaseIVkJQS3Jw1cV5ImXlk/Nr6p8I1KDMd9CrG7/T/1mPGi/w3RX5wwXS
         dvgA18kp5F+7JvenXLSRKtpXyDrXDVVZR+ndBFsyKi1xE26f6Zy0reYS4s197hd0tXSD
         mRZrK0IIvfJvtwe4x3RSa3NsN+AxF7uMHa5jfPfuINJdrrlFXg8E6E7j3SD5CR0Xq/lO
         qPMcxjQrU1FCEMLpzNSsXMrmWALmy1hsFcjNSBD4Y7E7DNgqAtYVD9QKFl2o9Y647JuA
         TC2g==
X-Gm-Message-State: APjAAAWUeVnBaKBxKR4IJfeN5TssmGYjA208zKR6H3CLVhTGhNx3rSF2
        MY2FlL/wu/fEPWLfLNp+brKsK2wO
X-Google-Smtp-Source: APXvYqx+79Cu8GhthflJMCkm+Oo2gofjqN/EzD8MsBHeIrIjPWq6KVNUXiLyi79cjpfoCgdhpBLrGA==
X-Received: by 2002:a50:e108:: with SMTP id h8mr18910851edl.196.1576879524043;
        Fri, 20 Dec 2019 14:05:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2sm1248520eja.37.2019.12.20.14.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:23 -0800 (PST)
Message-Id: <e52c7ad37a306891487bd79a09b040bfb657d723.1576879520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:13 +0000
Subject: [PATCH 2/9] commit-graph: write changed paths bloom filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

The changed path bloom filters help determine which paths changed between a
commit and its first parent. We already have the "--changed-paths" option
for the "git commit-graph write" subcommand, now actually compute them under
that option. The COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag enables this
computation.

RFC Notes: Here are some details about the implementation and I would love
to know your thoughts and suggestions for improvements here.

For details on what bloom filters are and how they work, please refer to
Dr. Derrick Stolee's blog post [1].
[1] https://devblogs.microsoft.com/devops/super-charging-the-git-commit-graph-iv-bloom-filters/

1. The implementation sticks to the recommended values of 7 and 10 for the
   number of hashes and the size of each entry, as described in the blog.
   The implementation while not completely open to it at the moment, is flexible
   enough to allow for tweaking these settings in the future.
   Note: The performance gains we have observed so far with these values is
   significant enough to not that we did not need to tweak these settings.
   The cover letter of this series has the details and the commit where we have
   git log use bloom filters.

2. As described in the blog and the linked technical paper therin, we do not need
   7 independent hashing functions. We use the Murmur3 hashing scheme - seed it
   twice and then combine those to procure an arbitrary number of hash values.

3. The filters are sized according to the number of changes in the each commit,
   with minimum size of one 64 bit word.

[Call for advice] We currently cap writing bloom filters for commits with
atmost 512 changed files. In the current implementation, we compute the diff,
and then just throw it away once we see it has more than 512 changes.
Any suggestiongs on how to reduce the work we are doing in this case are more
than welcome.

[Call for advice] Would the git community like this commit to be split up into
more granular commits? This commit could possibly be split out further with the
bloom.c code in its own commit, to be used by the commit-graph in a subsequent
commit. While I prefer it being contained in one commit this way, I am open to
suggestions.

[Call for advice] Would a technical document explaining the exact details of
the bloom filter implemenation and the hashing calculations be helpful? I will
be adding details into Documentation/technical/commit-graph-format.txt, but the
bloom filter code is an independent subsystem and could be used outside of the
commit-graph feature. Is it worth a separate document, or should we apply "You
Ain't Gonna Need It" principles?

[Call for advice] I plan to add unit tests for bloom.c, specifically to ensure
that the hash algorithm and bloom key calculations are stable across versions.

Signed-off-by: Garima Singh <garima.singh@microsoft.com>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |   1 +
 bloom.c        | 201 +++++++++++++++++++++++++++++++++++++++++++++++++
 bloom.h        |  46 +++++++++++
 commit-graph.c |  32 +++++++-
 4 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 bloom.c
 create mode 100644 bloom.h

diff --git a/Makefile b/Makefile
index 42a061d3fb..9d5e26f5d6 100644
--- a/Makefile
+++ b/Makefile
@@ -838,6 +838,7 @@ LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
 LIB_OBJS += blob.o
+LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
diff --git a/bloom.c b/bloom.c
new file mode 100644
index 0000000000..08328cc381
--- /dev/null
+++ b/bloom.c
@@ -0,0 +1,201 @@
+#include "git-compat-util.h"
+#include "bloom.h"
+#include "commit-graph.h"
+#include "object-store.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
+#include "hashmap.h"
+
+#define BITS_PER_BLOCK 64
+
+define_commit_slab(bloom_filter_slab, struct bloom_filter);
+
+struct bloom_filter_slab bloom_filters;
+
+struct pathmap_hash_entry {
+    struct hashmap_entry entry;
+    const char path[FLEX_ARRAY];
+};
+
+static uint32_t rotate_right(uint32_t value, int32_t count)
+{
+	uint32_t mask = 8 * sizeof(uint32_t) - 1;
+	count &= mask;
+	return ((value >> count) | (value << ((-count) & mask)));
+}
+
+static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
+{
+	const uint32_t c1 = 0xcc9e2d51;
+	const uint32_t c2 = 0x1b873593;
+	const int32_t r1 = 15;
+	const int32_t r2 = 13;
+	const uint32_t m = 5;
+	const uint32_t n = 0xe6546b64;
+	int i;
+	uint32_t k1 = 0;
+	const char *tail;
+
+	int len4 = len / sizeof(uint32_t);
+
+	const uint32_t *blocks = (const uint32_t*)data;
+
+	uint32_t k;
+	for (i = 0; i < len4; i++)
+	{
+		k = blocks[i];
+		k *= c1;
+		k = rotate_right(k, r1);
+		k *= c2;
+
+		seed ^= k;
+		seed = rotate_right(seed, r2) * m + n;
+	}
+
+	tail = (data + len4 * sizeof(uint32_t));
+
+	switch (len & (sizeof(uint32_t) - 1))
+	{
+	case 3:
+		k1 ^= ((uint32_t)tail[2]) << 16;
+		/*-fallthrough*/
+	case 2:
+		k1 ^= ((uint32_t)tail[1]) << 8;
+		/*-fallthrough*/
+	case 1:
+		k1 ^= ((uint32_t)tail[0]) << 0;
+		k1 *= c1;
+		k1 = rotate_right(k1, r1);
+		k1 *= c2;
+		seed ^= k1;
+		break;
+	}
+
+	seed ^= (uint32_t)len;
+	seed ^= (seed >> 16);
+	seed *= 0x85ebca6b;
+	seed ^= (seed >> 13);
+	seed *= 0xc2b2ae35;
+	seed ^= (seed >> 16);
+
+	return seed;
+}
+
+static inline uint64_t get_bitmask(uint32_t pos)
+{
+	return ((uint64_t)1) << (pos & (BITS_PER_BLOCK - 1));
+}
+
+void fill_bloom_key(const char *data,
+		    int len,
+		    struct bloom_key *key,
+		    struct bloom_filter_settings *settings)
+{
+	int i;
+	uint32_t seed0 = 0x293ae76f;
+	uint32_t seed1 = 0x7e646e2c;
+
+	uint32_t hash0 = seed_murmur3(seed0, data, len);
+	uint32_t hash1 = seed_murmur3(seed1, data, len);
+
+	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
+	for (i = 0; i < settings->num_hashes; i++)
+		key->hashes[i] = hash0 + i * hash1;
+}
+
+static void add_key_to_filter(struct bloom_key *key,
+			      struct bloom_filter *filter,
+			      struct bloom_filter_settings *settings)
+{
+	int i;
+	uint64_t mod = filter->len * BITS_PER_BLOCK;
+
+	for (i = 0; i < settings->num_hashes; i++) {
+		uint64_t hash_mod = key->hashes[i] % mod;
+		uint64_t block_pos = hash_mod / BITS_PER_BLOCK;
+
+		filter->data[block_pos] |= get_bitmask(hash_mod);
+	}
+}
+
+void load_bloom_filters(void)
+{
+	init_bloom_filter_slab(&bloom_filters);
+}
+
+struct bloom_filter *get_bloom_filter(struct repository *r,
+				      struct commit *c)
+{
+	struct bloom_filter *filter;
+	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+	int i;
+	struct rev_info revs;
+	const char *revs_argv[] = {NULL, "HEAD", NULL};
+
+	filter = bloom_filter_slab_at(&bloom_filters, c);
+	init_revisions(&revs, NULL);
+	revs.diffopt.flags.recursive = 1;
+
+	setup_revisions(2, revs_argv, &revs, NULL);
+
+	if (c->parents)
+		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &revs.diffopt);
+	else
+		diff_tree_oid(NULL, &c->object.oid, "", &revs.diffopt);
+	diffcore_std(&revs.diffopt);
+
+	if (diff_queued_diff.nr <= 512) {
+		struct hashmap pathmap;
+		struct pathmap_hash_entry* e;
+		struct hashmap_iter iter;
+		hashmap_init(&pathmap, NULL, NULL, 0);
+
+		for (i = 0; i < diff_queued_diff.nr; i++) {
+		    const char* path = diff_queued_diff.queue[i]->two->path;
+		    const char* p = path;
+
+		    /*
+		     * Add each leading directory of the changed file, i.e. for
+		     * 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
+		     * the Bloom filter could be used to speed up commands like
+		     * 'git log dir/subdir', too.
+		     *
+		     * Note that directories are added without the trailing '/'.
+		     */
+		    do {
+				char* last_slash = strrchr(p, '/');
+
+				FLEX_ALLOC_STR(e, path, path);
+				hashmap_entry_init(&e->entry, strhash(p));
+				hashmap_add(&pathmap, &e->entry);
+
+				if (!last_slash)
+				    last_slash = (char*)p;
+				*last_slash = '\0';
+
+		    } while (*p);
+
+		    diff_free_filepair(diff_queued_diff.queue[i]);
+		}
+
+		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_BLOCK - 1) / BITS_PER_BLOCK;
+		filter->data = xcalloc(filter->len, sizeof(uint64_t));
+
+		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
+		    struct bloom_key key;
+		    fill_bloom_key(e->path, strlen(e->path), &key, &settings);
+		    add_key_to_filter(&key, filter, &settings);
+		}
+
+		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
+	} else {
+		filter->data = NULL;
+		filter->len = 0;
+	}
+
+	free(diff_queued_diff.queue);
+	DIFF_QUEUE_CLEAR(&diff_queued_diff);
+
+	return filter;
+}
\ No newline at end of file
diff --git a/bloom.h b/bloom.h
new file mode 100644
index 0000000000..ba8ae70b67
--- /dev/null
+++ b/bloom.h
@@ -0,0 +1,46 @@
+#ifndef BLOOM_H
+#define BLOOM_H
+
+struct commit;
+struct repository;
+
+struct bloom_filter_settings {
+	uint32_t hash_version;
+	uint32_t num_hashes;
+	uint32_t bits_per_entry;
+};
+
+#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
+
+/*
+ * A bloom_filter struct represents a data segment to
+ * use when testing hash values. The 'len' member
+ * dictates how many uint64_t entries are stored in
+ * 'data'.
+ */
+struct bloom_filter {
+	uint64_t *data;
+	int len;
+};
+
+/*
+ * A bloom_key represents the k hash values for a
+ * given hash input. These can be precomputed and
+ * stored in a bloom_key for re-use when testing
+ * against a bloom_filter.
+ */
+struct bloom_key {
+	uint32_t *hashes;
+};
+
+void load_bloom_filters(void);
+
+struct bloom_filter *get_bloom_filter(struct repository *r,
+				      struct commit *c);
+
+void fill_bloom_key(const char *data,
+		    int len,
+		    struct bloom_key *key,
+		    struct bloom_filter_settings *settings);
+
+#endif
diff --git a/commit-graph.c b/commit-graph.c
index e771394aff..61e60ff98a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -16,6 +16,7 @@
 #include "hashmap.h"
 #include "replace-object.h"
 #include "progress.h"
+#include "bloom.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -794,9 +795,11 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1,
-		 check_oids:1;
+		 check_oids:1,
+		 bloom:1;
 
 	const struct split_commit_graph_opts *split_opts;
+	uint32_t total_bloom_filter_size;
 };
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -1139,6 +1142,28 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static void compute_bloom_filters(struct write_commit_graph_context *ctx)
+{
+	int i;
+	struct progress *progress = NULL;
+
+	load_bloom_filters();
+
+	if (ctx->report_progress)
+		progress = start_progress(
+			_("Computing commit diff Bloom filters"),
+			ctx->commits.nr);
+
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
+		ctx->total_bloom_filter_size += sizeof(uint64_t) * filter->len;
+		display_progress(progress, i + 1);
+	}
+
+	stop_progress(&progress);
+}
+
 static int add_ref_to_list(const char *refname,
 			   const struct object_id *oid,
 			   int flags, void *cb_data)
@@ -1791,6 +1816,8 @@ int write_commit_graph(const char *obj_dir,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
+	ctx->bloom = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
+	ctx->total_bloom_filter_size = 0;
 
 	if (ctx->split) {
 		struct commit_graph *g;
@@ -1885,6 +1912,9 @@ int write_commit_graph(const char *obj_dir,
 
 	compute_generation_numbers(ctx);
 
+	if (ctx->bloom)
+		compute_bloom_filters(ctx);
+
 	res = write_commit_graph_file(ctx);
 
 	if (ctx->split)
-- 
gitgitgadget

