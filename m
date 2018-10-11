Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCC61F97F
	for <e@80x24.org>; Thu, 11 Oct 2018 01:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeJKIqT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 04:46:19 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:40377 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeJKIqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 04:46:19 -0400
Received: by mail-qk1-f202.google.com with SMTP id a130-v6so6713976qkb.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gQpoklug+7REoCkvKzp0LmqQoR4JsRW+iLK49L9sk1A=;
        b=tmG/c/mHGm2wjFPJc3V9DNeQ/6NXLJd9tuFAoKlK+DQCoVKJxrCYOC/d5xzmca2pkO
         V6IBC6eQvpejgchHymStotacLv5it4RUr2lygfHxU3T0M2OSVr+udebrr8y6teadE0i8
         GIxHFxbNr1z+Q4swsjWEgY+rguwCQomI/BP2b9tFYiLu9KIRKC/mZ7gMDdjCyI39jKs/
         Z4DO1Auyh0OcDF5AYF5srPNRs0AshyF59/wIUmrt2ZFdDx119tV+IStlF61mON+HI9nu
         T/IqsvJp5FDgOIgZRk8G5ycSULLuiNE7EIG0muzH3b4DJwsdkfHsmTgqo9vK9vQ+/u4g
         rVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gQpoklug+7REoCkvKzp0LmqQoR4JsRW+iLK49L9sk1A=;
        b=os60I1qwiUhfCWzWICSB+r3DYpd6+X+w9IONbqXFWOLZQLV506hflDAzVWiUXFXfHK
         PZ64S36lT89QdR1Masev7w5EbI8MPABkQ+yXtOCOif7PxWr0f/QHX8s8H6Cl4pP39cwp
         RDIZLL3qS/z2090pT8SNKiMmdMg16sEJ52CybEqQ4KkYn+UIenfg7FMXBlfOF+d3X2Ai
         POoXvRMZ6hnXXSQVv4cxp6/qGb6T2vBpG33AZFKY/FpM7ri4CRc3eip44j83SApcq+X8
         HQ7sR472wQSVvnJ/FcTPKNOdl8XGbZYEm0bF/ZX20LQy3JBifaeDqLutyjToOD0pmCWf
         R0Vw==
X-Gm-Message-State: ABuFfohcYxMe3wBPN/NeVMm0HR4JZRqLRrrxWfRphKvogs0Nn9Dx+Bq6
        GsrXKMd5zMUomYtPyrO3NS8jTe5G1rNgpM39/zPrbqHetvxCexv7sEE2rWilDX3Z3rH6sPwJZRl
        Sb3v6UIbPFEd0bC4ToYAuf6kgB26YxhaydOR/KTP7HmphiBwDdtHUMY6QgBBfjchzCTBsKsYizQ
        6/
X-Google-Smtp-Source: ACcGV61BP9Prhah6IVWbQ8hSeoNnBNSKtqKvXqHEdLwPbqMQ3Y/HTZTIsFj2Ykg8CwlKQ2q5Vo1FiwJ6JUmn8VVuIwj3
X-Received: by 2002:a37:14df:: with SMTP id 92-v6mr2259660qku.26.1539220888471;
 Wed, 10 Oct 2018 18:21:28 -0700 (PDT)
Date:   Wed, 10 Oct 2018 18:21:20 -0700
In-Reply-To: <cover.1539219248.git.jonathantanmy@google.com>
Message-Id: <ebf0a811be047e9fd24b61fea3c4a164b3d18dc0.1539219248.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181009193445.21908-1-szeder.dev@gmail.com> <cover.1539219248.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 1/2] One filter per commit
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        stolee@gmail.com, avarab@gmail.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 bloom-filter.c | 31 ++++++++++++++++++-------------
 bloom-filter.h | 12 ++++--------
 commit-graph.c | 26 ++++++++++++--------------
 revision.c     |  9 +++------
 4 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/bloom-filter.c b/bloom-filter.c
index 7dce0e35fa..39b453908f 100644
--- a/bloom-filter.c
+++ b/bloom-filter.c
@@ -1,14 +1,17 @@
 #include "cache.h"
 #include "bloom-filter.h"
 
-void bloom_filter_init(struct bloom_filter *bf, uint32_t bit_size)
+void bloom_filter_init(struct bloom_filter *bf, uint32_t commit_nr, uint32_t bit_size)
 {
 	if (bit_size % CHAR_BIT)
 		BUG("invalid size for bloom filter");
+	if (bit_size > 1024)
+		BUG("aborting: the bit size is per commit, not for the whole filter");
 
 	bf->nr_entries = 0;
+	bf->commit_nr = commit_nr;
 	bf->bit_size = bit_size;
-	bf->bits = xmalloc(bit_size / CHAR_BIT);
+	bf->bits = xcalloc(1, commit_nr * bit_size / CHAR_BIT);
 }
 
 void bloom_filter_free(struct bloom_filter *bf)
@@ -19,24 +22,24 @@ void bloom_filter_free(struct bloom_filter *bf)
 }
 
 
-void bloom_filter_set_bits(struct bloom_filter *bf, const uint32_t *offsets,
+static void bloom_filter_set_bits(struct bloom_filter *bf, uint32_t graph_pos, const uint32_t *offsets,
 			   int nr_offsets, int nr_entries)
 {
 	int i;
 	for (i = 0; i < nr_offsets; i++) {
-		uint32_t byte_offset = (offsets[i] % bf->bit_size) / CHAR_BIT;
+		uint32_t byte_offset = (offsets[i] % bf->bit_size + graph_pos * bf->bit_size) / CHAR_BIT;
 		unsigned char mask = 1 << offsets[i] % CHAR_BIT;
 		bf->bits[byte_offset] |= mask;
 	}
 	bf->nr_entries += nr_entries;
 }
 
-int bloom_filter_check_bits(struct bloom_filter *bf, const uint32_t *offsets,
+static int bloom_filter_check_bits(struct bloom_filter *bf, uint32_t graph_pos, const uint32_t *offsets,
 			    int nr)
 {
 	int i;
 	for (i = 0; i < nr; i++) {
-		uint32_t byte_offset = (offsets[i] % bf->bit_size) / CHAR_BIT;
+		uint32_t byte_offset = (offsets[i] % bf->bit_size + graph_pos * bf->bit_size) / CHAR_BIT;
 		unsigned char mask = 1 << offsets[i] % CHAR_BIT;
 		if (!(bf->bits[byte_offset] & mask))
 			return 0;
@@ -45,19 +48,19 @@ int bloom_filter_check_bits(struct bloom_filter *bf, const uint32_t *offsets,
 }
 
 
-void bloom_filter_add_hash(struct bloom_filter *bf, const unsigned char *hash)
+void bloom_filter_add_hash(struct bloom_filter *bf, uint32_t graph_pos, const unsigned char *hash)
 {
 	uint32_t offsets[GIT_MAX_RAWSZ / sizeof(uint32_t)];
 	hashcpy((unsigned char*)offsets, hash);
-	bloom_filter_set_bits(bf, offsets,
+	bloom_filter_set_bits(bf, graph_pos, offsets,
 			     the_hash_algo->rawsz / sizeof(*offsets), 1);
 }
 
-int bloom_filter_check_hash(struct bloom_filter *bf, const unsigned char *hash)
+int bloom_filter_check_hash(struct bloom_filter *bf, uint32_t graph_pos, const unsigned char *hash)
 {
 	uint32_t offsets[GIT_MAX_RAWSZ / sizeof(uint32_t)];
 	hashcpy((unsigned char*)offsets, hash);
-	return bloom_filter_check_bits(bf, offsets,
+	return bloom_filter_check_bits(bf, graph_pos, offsets,
 			the_hash_algo->rawsz / sizeof(*offsets));
 }
 
@@ -80,11 +83,12 @@ int bloom_filter_load(struct bloom_filter *bf)
 		return -1;
 
 	read_in_full(fd, &bf->nr_entries, sizeof(bf->nr_entries));
+	read_in_full(fd, &bf->commit_nr, sizeof(bf->commit_nr));
 	read_in_full(fd, &bf->bit_size, sizeof(bf->bit_size));
 	if (bf->bit_size % CHAR_BIT)
 		BUG("invalid size for bloom filter");
-	bf->bits = xmalloc(bf->bit_size / CHAR_BIT);
-	read_in_full(fd, bf->bits, bf->bit_size / CHAR_BIT);
+	bf->bits = xmalloc(bf->commit_nr * bf->bit_size / CHAR_BIT);
+	read_in_full(fd, bf->bits, bf->commit_nr * bf->bit_size / CHAR_BIT);
 
 	close(fd);
 
@@ -96,8 +100,9 @@ void bloom_filter_write(struct bloom_filter *bf)
 	int fd = xopen(git_path_bloom(), O_WRONLY | O_CREAT | O_TRUNC, 0666);
 
 	write_in_full(fd, &bf->nr_entries, sizeof(bf->nr_entries));
+	write_in_full(fd, &bf->commit_nr, sizeof(bf->commit_nr));
 	write_in_full(fd, &bf->bit_size, sizeof(bf->bit_size));
-	write_in_full(fd, bf->bits, bf->bit_size / CHAR_BIT);
+	write_in_full(fd, bf->bits, bf->commit_nr * bf->bit_size / CHAR_BIT);
 
 	close(fd);
 }
diff --git a/bloom-filter.h b/bloom-filter.h
index 94d0af1708..607649b8db 100644
--- a/bloom-filter.h
+++ b/bloom-filter.h
@@ -5,30 +5,26 @@
 
 struct bloom_filter {
 	uint32_t nr_entries;
+	uint32_t commit_nr;
 	uint32_t bit_size;
 	unsigned char *bits;
 };
 
 
-void bloom_filter_init(struct bloom_filter *bf, uint32_t bit_size);
+void bloom_filter_init(struct bloom_filter *bf, uint32_t commit_nr, uint32_t bit_size);
 void bloom_filter_free(struct bloom_filter *bf);
 
-void bloom_filter_set_bits(struct bloom_filter *bf, const uint32_t *offsets,
-			   int nr_offsets, int nr_enries);
-int bloom_filter_check_bits(struct bloom_filter *bf, const uint32_t *offsets,
-			    int nr);
-
 /*
  * Turns the given (SHA1) hash into 5 unsigned ints, and sets the bits at
  * those positions (modulo the bitmap's size) in the Bloom filter.
  */
-void bloom_filter_add_hash(struct bloom_filter *bf, const unsigned char *hash);
+void bloom_filter_add_hash(struct bloom_filter *bf, uint32_t graph_pos, const unsigned char *hash);
 /*
  * Turns the given (SHA1) hash into 5 unsigned ints, and checks the bits at
  * those positions (modulo the bitmap's size) in the Bloom filter.
  * Returns 1 if all those bits are set, 0 otherwise.
  */
-int bloom_filter_check_hash(struct bloom_filter *bf, const unsigned char *hash);
+int bloom_filter_check_hash(struct bloom_filter *bf, uint32_t graph_pos, const unsigned char *hash);
 
 void hashxor(const unsigned char *hash1, const unsigned char *hash2,
 	     unsigned char *out);
diff --git a/commit-graph.c b/commit-graph.c
index f415d3b41f..90b0b3df90 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -715,13 +715,11 @@ static int add_ref_to_list(const char *refname,
 static void add_changes_to_bloom_filter(struct bloom_filter *bf,
 					struct commit *parent,
 					struct commit *commit,
+					int index,
 					struct diff_options *diffopt)
 {
-	unsigned char p_c_hash[GIT_MAX_RAWSZ];
 	int i;
 
-	hashxor(parent->object.oid.hash, commit->object.oid.hash, p_c_hash);
-
 	diff_tree_oid(&parent->object.oid, &commit->object.oid, "", diffopt);
 	diffcore_std(diffopt);
 
@@ -756,8 +754,8 @@ static void add_changes_to_bloom_filter(struct bloom_filter *bf,
 			the_hash_algo->update_fn(&ctx, path, p - path);
 			the_hash_algo->final_fn(name_hash, &ctx);
 
-			hashxor(name_hash, p_c_hash, hash);
-			bloom_filter_add_hash(bf, hash);
+			hashxor(name_hash, parent->object.oid.hash, hash);
+			bloom_filter_add_hash(bf, index, hash);
 		} while (*p);
 
 		diff_free_filepair(diff_queued_diff.queue[i]);
@@ -768,11 +766,10 @@ static void add_changes_to_bloom_filter(struct bloom_filter *bf,
 }
 
 static void fill_bloom_filter(struct bloom_filter *bf,
-				    struct progress *progress)
+				    struct progress *progress, struct commit **commits, int commit_nr)
 {
 	struct rev_info revs;
 	const char *revs_argv[] = {NULL, "--all", NULL};
-	struct commit *commit;
 	int i = 0;
 
 	/* We (re-)create the bloom filter from scratch every time for now. */
@@ -783,18 +780,19 @@ static void fill_bloom_filter(struct bloom_filter *bf,
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed while preparing bloom filter");
 
-	while ((commit = get_revision(&revs))) {
+	for (i = 0; i < commit_nr; i++) {
+		struct commit *commit = commits[i];
 		struct commit_list *parent;
 
 		for (parent = commit->parents; parent; parent = parent->next)
-			add_changes_to_bloom_filter(bf, parent->item, commit,
+			add_changes_to_bloom_filter(bf, parent->item, commit, i,
 						    &revs.diffopt);
 
-		display_progress(progress, ++i);
+		display_progress(progress, i);
 	}
 }
 
-static void write_bloom_filter(int report_progress, int commit_nr)
+static void write_bloom_filter(int report_progress, struct commit **commits, int commit_nr)
 {
 	struct bloom_filter bf;
 	struct progress *progress = NULL;
@@ -809,13 +807,13 @@ static void write_bloom_filter(int report_progress, int commit_nr)
 	if (*end)
 		die("GIT_USE_POC_BLOOM_FILTER must specify the number of bits in the bloom filter (multiple of 8, n < 2^32)");
 
-	bloom_filter_init(&bf, bitsize);
+	bloom_filter_init(&bf, commit_nr, bitsize);
 
 	if (report_progress)
 		progress = start_progress(_("Computing bloom filter"),
 					  commit_nr);
 
-	fill_bloom_filter(&bf, progress);
+	fill_bloom_filter(&bf, progress, commits, commit_nr);
 
 	bloom_filter_write(&bf);
 	bloom_filter_free(&bf);
@@ -1030,7 +1028,7 @@ void write_commit_graph(const char *obj_dir,
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
-	write_bloom_filter(report_progress, commits.nr);
+	write_bloom_filter(report_progress, commits.list, commits.nr);
 
 	free(graph_name);
 	free(commits.list);
diff --git a/revision.c b/revision.c
index d5ba2b1598..c84a997928 100644
--- a/revision.c
+++ b/revision.c
@@ -490,7 +490,6 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *parent,
 						 struct commit *commit)
 {
-	unsigned char p_c_hash[GIT_MAX_RAWSZ];
 	int i;
 
 	if (!bf.bits)
@@ -509,17 +508,15 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	 */
 	if (!the_repository->objects->commit_graph)
 		return -1;
-	if (commit->generation == GENERATION_NUMBER_INFINITY)
+	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		return -1;
 
-	hashxor(parent->object.oid.hash, commit->object.oid.hash, p_c_hash);
-
 	for (i = 0; i < revs->pruning.pathspec.nr; i++) {
 		struct pathspec_item *pi = &revs->pruning.pathspec.items[i];
 		unsigned char hash[GIT_MAX_RAWSZ];
 
-		hashxor(pi->name_hash, p_c_hash, hash);
-		if (bloom_filter_check_hash(&bf, hash)) {
+		hashxor(pi->name_hash, parent->object.oid.hash, hash);
+		if (bloom_filter_check_hash(&bf, commit->graph_pos, hash)) {
 			/*
 			 * At least one of the interesting pathspecs differs,
 			 * so we can return early and let the diff machinery
-- 
2.19.0.271.gfe8321ec05.dirty

