Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEEEC352A1
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574CC20730
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRc0b6lP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBEW4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:40 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44508 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgBEW4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:39 -0500
Received: by mail-wr1-f41.google.com with SMTP id m16so4803651wrx.11
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=irc6cwDbgJseRKMaRVbHeWotacTn/pA+DLen9k9PFQ8=;
        b=HRc0b6lP3U7YyBradLjhymF9//TplLUw+SgaS9DV7UOA1ohHIKRtIjOtgLLIjDwA+2
         CSITzMaDF9O/JiTrY2NNWFNNgjRmk4G9y0zH2XViHV1WbkR+CKpd12/ErGb/U4Dh9wTF
         SyRdI/4Lbma7T/T2f+tzPLuZpA8ptdRpMncD+c82QIJNHbTdzuT8tR+q7W1wysXgN/4A
         7LEa8ZAZcVX0XBZmyz8nRC0z+efwRNP0ImEFtHB37ODbALESPey9QLNfOPsFygrDtfVY
         zztoR6UvQ/QlKa5HjH4QAW8W/mRS+a0CahY23ooU4y9rR4M9Mrdoy4fAO86BG+7LqZKw
         kenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=irc6cwDbgJseRKMaRVbHeWotacTn/pA+DLen9k9PFQ8=;
        b=S79HxRgn6MtmIDUbSmDza5Q6HBFiKI5lBiwi2QtuJ+DMFS+VOd3kTizvLe1sc0qP2G
         D0e0fKQ6VXpok3TdJ37gMfmYKRPjPq8TAKSO+07rcQOfsGAjgCeCekpoU9B3ycF/YhtL
         9lK0GOU+fmCY5+8IMwfN/7Mcsz7xS7liO0DZlX+dup9wW2lmHovMSwt0Cn5MPpHF9q0q
         LYg0sXch5Kd1XFF08Ulr3ZMNhbonwEw3C/n0wX5wL5cGlnLMfBhZJ/Z8ehTYpZxwdylC
         uR9DUA7O4MjzoJtVzmuCLpYchcA2sV/MXmXCRAX+8PHiDH4/qznwHS0rhThWMwBmaE4n
         Nq+Q==
X-Gm-Message-State: APjAAAVGvMoHibD36JZQsiDy7+IsNLnFcvRBbb4YARkstCZhitmDhp20
        2wRWBXBbtPJUlekyT2YMn687XEFT
X-Google-Smtp-Source: APXvYqw5VKPw97KPCf3EOQdlk/nnUzSJ+uCYS5eaWl/HvUqmF/ZH9w8/tcfJFkUCK5hqRmLktSyCRA==
X-Received: by 2002:a5d:4052:: with SMTP id w18mr206056wrp.112.1580943393292;
        Wed, 05 Feb 2020 14:56:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm1189465wmg.22.2020.02.05.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:32 -0800 (PST)
Message-Id: <02b16d94227470059dcee2781e29ae7ae010f602.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:21 +0000
Subject: [PATCH v2 02/11] bloom: core Bloom filter implementation for changed
 paths
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

Add the core Bloom filter logic for computing the paths changed between a
commit and its first parent. For details on what Bloom filters are and how they
work, please refer to Dr. Derrick Stolee's blog post [1]. It provides a concise
explaination of the adoption of Bloom filters as described in [2] and [3]

1. We currently use 7 and 10 for the number of hashes and the size of each
   entry respectively. They served as great starting values, the mathematical
   details behind this choice are described in [1] and [4]. The implementation
   while not completely open to it at the moment, is flexible enough to allow
   for tweaking these settings in the future.

   Note: The performance gains we have observed with these values are
   significant enough that we did not need to tweak these settings.
   The performance numbers are included in the cover letter of this series
   and in the message of a subsequent commit where we use Bloom filters in
   to speed up `git log -- <path>`.

2. As described in the blog and in [3], we do not need 7 independent hashing
   functions. We use the Murmur3 hashing scheme. Seed it twice and then
   combine those to procure an arbitrary number of hash values.

3. The filters are sized according to the number of changes in the each commit,
   with minimum size of one 64 bit word.

4. We fill the Bloom filters as (const char *data, int len) pairs as
   "struct bloom_filter"s in a commit slab.

5. The seed_murmur3 method is implemented as described in [5]. It hashes the
   given data using a given seed and produces a uniformly distributed hash
   value.

[1] https://devblogs.microsoft.com/devops/super-charging-the-git-commit-graph-iv-Bloom-filters/

[2] Flavio Bonomi, Michael Mitzenmacher, Rina Panigrahy, Sushil Singh, George Varghese
    "An Improved Construction for Counting Bloom Filters"
    http://theory.stanford.edu/~rinap/papers/esa2006b.pdf
    https://doi.org/10.1007/11841036_61

[3] Peter C. Dillinger and Panagiotis Manolios
    "Bloom Filters in Probabilistic Verification"
    http://www.ccs.neu.edu/home/pete/pub/Bloom-filters-verification.pdf
    https://doi.org/10.1007/978-3-540-30494-4_26

[4] Thomas Mueller Graf, Daniel Lemire
    "Xor Filters: Faster and Smaller Than Bloom and Cuckoo Filters"
    https://arxiv.org/abs/1912.08258

[5] https://en.wikipedia.org/wiki/MurmurHash#Algorithm

Helped-by: Jeff King <peff@peff.net>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 Makefile              |   2 +
 bloom.c               | 228 ++++++++++++++++++++++++++++++++++++++++++
 bloom.h               |  56 +++++++++++
 t/helper/test-bloom.c |  84 ++++++++++++++++
 t/helper/test-tool.c  |   1 +
 t/helper/test-tool.h  |   1 +
 t/t0095-bloom.sh      | 113 +++++++++++++++++++++
 7 files changed, 485 insertions(+)
 create mode 100644 bloom.c
 create mode 100644 bloom.h
 create mode 100644 t/helper/test-bloom.c
 create mode 100755 t/t0095-bloom.sh

diff --git a/Makefile b/Makefile
index 6134104ae6..afba81f4a8 100644
--- a/Makefile
+++ b/Makefile
@@ -695,6 +695,7 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
+TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
@@ -840,6 +841,7 @@ LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
 LIB_OBJS += blob.o
+LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
diff --git a/bloom.c b/bloom.c
new file mode 100644
index 0000000000..6082193a75
--- /dev/null
+++ b/bloom.c
@@ -0,0 +1,228 @@
+#include "git-compat-util.h"
+#include "bloom.h"
+#include "commit-graph.h"
+#include "object-store.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
+#include "hashmap.h"
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
+/*
+ * Calculate a hash value for the given data using the given seed.
+ * Produces a uniformly distributed hash value.
+ * Not considered to be cryptographically secure.
+ * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
+ **/
+static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
+{
+	const uint32_t c1 = 0xcc9e2d51;
+	const uint32_t c2 = 0x1b873593;
+	const uint32_t r1 = 15;
+	const uint32_t r2 = 13;
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
+	return ((uint64_t)1) << (pos & (BITS_PER_WORD - 1));
+}
+
+void load_bloom_filters(void)
+{
+	init_bloom_filter_slab(&bloom_filters);
+}
+
+void fill_bloom_key(const char *data,
+					int len,
+					struct bloom_key *key,
+					struct bloom_filter_settings *settings)
+{
+	int i;
+	const uint32_t seed0 = 0x293ae76f;
+	const uint32_t seed1 = 0x7e646e2c;
+	const uint32_t hash0 = seed_murmur3(seed0, data, len);
+	const uint32_t hash1 = seed_murmur3(seed1, data, len);
+
+	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
+	for (i = 0; i < settings->num_hashes; i++)
+		key->hashes[i] = hash0 + i * hash1;
+}
+
+void add_key_to_filter(struct bloom_key *key,
+					   struct bloom_filter *filter,
+					   struct bloom_filter_settings *settings)
+{
+	int i;
+	uint64_t mod = filter->len * BITS_PER_WORD;
+
+	for (i = 0; i < settings->num_hashes; i++) {
+		uint64_t hash_mod = key->hashes[i] % mod;
+		uint64_t block_pos = hash_mod / BITS_PER_WORD;
+
+		filter->data[block_pos] |= get_bitmask(hash_mod);
+	}
+}
+
+struct bloom_filter *get_bloom_filter(struct repository *r,
+				      struct commit *c)
+{
+	struct bloom_filter *filter;
+	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+	int i;
+	struct diff_options diffopt;
+
+	if (!bloom_filters.slab_size)
+		return NULL;
+
+	filter = bloom_filter_slab_at(&bloom_filters, c);
+
+	repo_diff_setup(r, &diffopt);
+	diffopt.flags.recursive = 1;
+	diff_setup_done(&diffopt);
+
+	if (c->parents)
+		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diffopt);
+	else
+		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
+	diffcore_std(&diffopt);
+
+	if (diff_queued_diff.nr <= 512) {
+		struct hashmap pathmap;
+		struct pathmap_hash_entry* e;
+		struct hashmap_iter iter;
+		hashmap_init(&pathmap, NULL, NULL, 0);
+
+		for (i = 0; i < diff_queued_diff.nr; i++) {
+			const char* path = diff_queued_diff.queue[i]->two->path;
+			const char* p = path;
+
+			/*
+			* Add each leading directory of the changed file, i.e. for
+			* 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
+			* the Bloom filter could be used to speed up commands like
+			* 'git log dir/subdir', too.
+			*
+			* Note that directories are added without the trailing '/'.
+			*/
+			do {
+				char* last_slash = strrchr(p, '/');
+
+				FLEX_ALLOC_STR(e, path, path);
+				hashmap_entry_init(&e->entry, strhash(p));
+				hashmap_add(&pathmap, &e->entry);
+
+				if (!last_slash)
+					last_slash = (char*)p;
+				*last_slash = '\0';
+
+			} while (*p);
+
+			diff_free_filepair(diff_queued_diff.queue[i]);
+		}
+
+		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		filter->data = xcalloc(filter->len, sizeof(uint64_t));
+
+		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
+			struct bloom_key key;
+			fill_bloom_key(e->path, strlen(e->path), &key, &settings);
+			add_key_to_filter(&key, filter, &settings);
+		}
+
+		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
+	} else {
+		for (i = 0; i < diff_queued_diff.nr; i++)
+			diff_free_filepair(diff_queued_diff.queue[i]);
+		filter->data = NULL;
+		filter->len = 0;
+	}
+
+	free(diff_queued_diff.queue);
+	DIFF_QUEUE_CLEAR(&diff_queued_diff);
+
+	return filter;
+}
+
+int bloom_filter_contains(struct bloom_filter *filter,
+			  struct bloom_key *key,
+			  struct bloom_filter_settings *settings)
+{
+	int i;
+	uint64_t mod = filter->len * BITS_PER_WORD;
+
+	if (!mod)
+		return -1;
+
+	for (i = 0; i < settings->num_hashes; i++) {
+		uint64_t hash_mod = key->hashes[i] % mod;
+		uint64_t block_pos = hash_mod / BITS_PER_WORD;
+		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
+			return 0;
+	}
+
+	return 1;
+}
diff --git a/bloom.h b/bloom.h
new file mode 100644
index 0000000000..7f40c751f7
--- /dev/null
+++ b/bloom.h
@@ -0,0 +1,56 @@
+#ifndef BLOOM_H
+#define BLOOM_H
+
+struct commit;
+struct repository;
+struct commit_graph;
+
+struct bloom_filter_settings {
+	uint32_t hash_version;
+	uint32_t num_hashes;
+	uint32_t bits_per_entry;
+};
+
+#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
+#define BITS_PER_WORD 64
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
+void fill_bloom_key(const char *data,
+		    int len,
+		    struct bloom_key *key,
+		    struct bloom_filter_settings *settings);
+
+void add_key_to_filter(struct bloom_key *key,
+					   struct bloom_filter *filter,
+					   struct bloom_filter_settings *settings);
+
+struct bloom_filter *get_bloom_filter(struct repository *r,
+				      struct commit *c);
+
+int bloom_filter_contains(struct bloom_filter *filter,
+			  struct bloom_key *key,
+			  struct bloom_filter_settings *settings);
+
+#endif
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
new file mode 100644
index 0000000000..331957011b
--- /dev/null
+++ b/t/helper/test-bloom.c
@@ -0,0 +1,84 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "bloom.h"
+#include "test-tool.h"
+#include "cache.h"
+#include "commit-graph.h"
+#include "commit.h"
+#include "config.h"
+#include "object-store.h"
+#include "object.h"
+#include "repository.h"
+#include "tree.h"
+
+struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+
+static void print_bloom_filter(struct bloom_filter *filter) {
+	int i;
+
+	if (!filter) {
+		printf("No filter.\n");
+		return;
+	}
+	printf("Filter_Length:%d\n", filter->len);
+	printf("Filter_Data:");
+	for (i = 0; i < filter->len; i++){
+		printf("%"PRIx64"|", filter->data[i]);
+	}
+	printf("\n");
+}
+
+static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
+		struct bloom_key key;
+		int i;
+
+		fill_bloom_key(data, strlen(data), &key, &settings);
+		printf("Hashes:");
+		for (i = 0; i < settings.num_hashes; i++){
+			printf("%08x|", key.hashes[i]);
+		}
+		printf("\n");
+		add_key_to_filter(&key, filter, &settings);
+}
+
+static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
+{
+	struct commit *c;
+	struct bloom_filter *filter;
+	setup_git_directory();
+	c = lookup_commit(the_repository, commit_oid);
+	filter = get_bloom_filter(the_repository, c);
+	print_bloom_filter(filter);
+}
+
+int cmd__bloom(int argc, const char **argv)
+{
+    if (!strcmp(argv[1], "generate_filter")) {
+		struct bloom_filter filter;
+		int i = 2;
+		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		filter.data = xcalloc(filter.len, sizeof(uint64_t));
+
+		if (!argv[2]){
+			die("at least one input string expected");
+		}
+
+		while (argv[i]) {
+			add_string_to_filter(argv[i], &filter);
+			i++;
+		}
+
+		print_bloom_filter(&filter);
+	}
+
+	if (!strcmp(argv[1], "get_filter_for_commit")) {
+		struct object_id oid;
+		const char *end;
+		if (parse_oid_hex(argv[2], &oid, &end))
+			die("cannot parse oid '%s'", argv[2]);
+		load_bloom_filters();
+		get_bloom_filter_for_commit(&oid);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c9a232d238..ca4f4b0066 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -14,6 +14,7 @@ struct test_cmd {
 };
 
 static struct test_cmd cmds[] = {
+	{ "bloom", cmd__bloom },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "ctype", cmd__ctype },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index c8549fd87f..05d2b32451 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -4,6 +4,7 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "git-compat-util.h"
 
+int cmd__bloom(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
new file mode 100755
index 0000000000..424fe4fc29
--- /dev/null
+++ b/t/t0095-bloom.sh
@@ -0,0 +1,113 @@
+#!/bin/sh
+
+test_description='test bloom.c'
+. ./test-lib.sh
+
+test_expect_success 'get bloom filters for commit with no changes' '
+	git init &&
+	git commit --allow-empty -m "c0" &&
+	cat >expect <<-\EOF &&
+	Filter_Length:0
+	Filter_Data:
+	EOF
+	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get bloom filter for commit with 10 changes' '
+	rm actual &&
+	rm expect &&
+	mkdir smallDir &&
+	for i in $(test_seq 0 9)
+	do
+		echo $i >smallDir/$i
+	done &&
+	git add smallDir &&
+	git commit -m "commit with 10 changes" &&
+	cat >expect <<-\EOF &&
+	Filter_Length:4
+	Filter_Data:508928809087080a|8a7648210804001|4089824400951000|841ab310098051a8|
+	EOF
+	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
+	rm actual &&
+	rm expect &&
+	mkdir bigDir &&
+	for i in $(test_seq 0 512)
+	do
+		echo $i >bigDir/$i
+	done &&
+	git add bigDir &&
+	git commit -m "commit with 513 changes" &&
+	cat >expect <<-\EOF &&
+	Filter_Length:0
+	Filter_Data:
+	EOF
+	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute bloom key for empty string' '
+	cat >expect <<-\EOF &&
+	Hashes:5615800c|5b966560|61174ab4|66983008|6c19155c|7199fab0|771ae004|
+	Filter_Length:1
+	Filter_Data:11000110001110|
+	EOF
+	test-tool bloom generate_filter "" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute bloom key for whitespace' '
+	cat >expect <<-\EOF &&
+	Hashes:1bf014e6|8a91b50b|f9335530|67d4f555|d676957a|4518359f|b3b9d5c4|
+	Filter_Length:1
+	Filter_Data:401004080200810|
+	EOF
+	test-tool bloom generate_filter " " >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute bloom key for a root level folder' '
+	cat >expect <<-\EOF &&
+	Hashes:1a21016f|fff1c06d|e5c27f6b|cb933e69|b163fd67|9734bc65|7d057b63|
+	Filter_Length:1
+	Filter_Data:aaa800000000|
+	EOF
+	test-tool bloom generate_filter "A" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute bloom key for a root level file' '
+	cat >expect <<-\EOF &&
+	Hashes:e2d51107|30970605|7e58fb03|cc1af001|19dce4ff|679ed9fd|b560cefb|
+	Filter_Length:1
+	Filter_Data:a8000000000000aa|
+	EOF
+	test-tool bloom generate_filter "file.txt" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute bloom key for a deep folder' '
+	cat >expect <<-\EOF &&
+	Hashes:864cf838|27f055cd|c993b362|6b3710f7|0cda6e8c|ae7dcc21|502129b6|
+	Filter_Length:1
+	Filter_Data:1c0000600003000|
+	EOF
+	test-tool bloom generate_filter "A/B/C/D/E" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'compute bloom key for a deep file' '
+	cat >expect <<-\EOF &&
+	Hashes:07cdf850|4af629c7|8e1e5b3e|d1468cb5|146ebe2c|5796efa3|9abf211a|
+	Filter_Length:1
+	Filter_Data:4020100804010080|
+	EOF
+	test-tool bloom generate_filter "A/B/C/D/E/file.txt" >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

