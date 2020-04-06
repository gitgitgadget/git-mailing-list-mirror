Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A75C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D6320780
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3agDrgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgDFRAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45127 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbgDFRAD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id m12so322587edl.12
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=hB+IdW0dP0vYOihG25fJnUEDSo2H4LGMF60eszlgdzA=;
        b=J3agDrgjZD7tJJCBpu16uq9XM/WeE6GZtMIjxuuyeu9+KwbAN7H0eFgskFuLUzRE10
         6+frQ8hsPSIn3dS2UZzxKXRPiDqKgKsOFVmOiYZeQx7dr1VtTgh+JXNrP7ANKoFjcX+b
         6D3t1my1WnzoEj3MeRziGJ/u8fLQZ9ervKg5R9UWlD4ypWu+oPammIYlsmEkbiAZXDzA
         J4UOeRxyY4UfiYLNCxx3phAJcImn6m29P/cf5IjfgL3cQBdRA+S96uCZ5XycZ7RbRiw1
         XU+5PPTdAAnVcIqpnOt7/FWFkH+XxWvWO+WOS6xxQKrZoncQFNnAfiRHb9asZLaGN4SD
         oouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=hB+IdW0dP0vYOihG25fJnUEDSo2H4LGMF60eszlgdzA=;
        b=qGstLe+j2i5eyh+aRoYL/aLiis1A/d5+Od5ezt+qT6zvGZwogHZJ5RvaMU80UIepU7
         Y0DFshHq8/gEf+niwM6i9bDFr7ABrK5LzaeU89dnyH5Ad+srLdMLfnLGvawpim6yccsq
         tRsQjPJ1NNXkWrQ0nNHfr09O01x4hyVpk8ufbRQuB8WGlHCpiWxr2q0zQrBOqW3jVjWh
         GqQIG675KXRYM3NkgDsFs8o00xWofverYsg+seg5QyTs/k/YzkPJPYJCtxT+8CrIepwf
         0wpBYwABxSwKw+554gMkkfNJnLOw3+HNvE0Hh3TnXf30c4C0cOlcQim6ly0Tkkuriumy
         3J5A==
X-Gm-Message-State: AGi0PuaNq6aBAyStKV+vleCQKxeLpB7unV0gNZk3fXzU3f4sA2NdScm+
        TCbVkUrABaCBZ7vFJo+/dHkceT9M
X-Google-Smtp-Source: APiQypLbUhiHTLWYfYeTxVhvqEIaNGoEpkJVRI+Q5cDD7DlwvxsMAtmTSuMNuQmqJqCF6Uax4ropTA==
X-Received: by 2002:a17:906:d1cf:: with SMTP id bs15mr453829ejb.280.1586192399715;
        Mon, 06 Apr 2020 09:59:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dj1sm2544700edb.70.2020.04.06.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:59:59 -0700 (PDT)
Message-Id: <8304c2975207ee847c6709abd71efee918fc4142.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:44 +0000
Subject: [PATCH v4 04/15] bloom.c: core Bloom filter implementation for
 changed paths.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add the core implementation for computing Bloom filters for
the paths changed between a commit and it's first parent.

We fill the Bloom filters as (const char *data, int len) pairs
as `struct bloom_filters" within a commit slab.

Filters for commits with no changes and more than 512 changes,
is represented with a filter of length zero. There is no gain
in distinguishing between a computed filter of length zero for
a commit with no changes, and an uncomputed filter for new commits
or for commits with more than 512 changes. The effect on
`git log -- path` is the same in both cases. We will fall back to
the normal diffing algorithm when we can't benefit from the
existence of Bloom filters.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Jakub Narębski <jnareb@gmail.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c               | 97 +++++++++++++++++++++++++++++++++++++++++++
 bloom.h               |  8 ++++
 t/helper/test-bloom.c | 20 +++++++++
 t/t0095-bloom.sh      | 47 +++++++++++++++++++++
 4 files changed, 172 insertions(+)

diff --git a/bloom.c b/bloom.c
index 888b67f1ea6..881a9841ede 100644
--- a/bloom.c
+++ b/bloom.c
@@ -1,5 +1,18 @@
 #include "git-compat-util.h"
 #include "bloom.h"
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
 
 static uint32_t rotate_left(uint32_t value, int32_t count)
 {
@@ -107,3 +120,87 @@ void add_key_to_filter(const struct bloom_key *key,
 		filter->data[block_pos] |= get_bitmask(hash_mod);
 	}
 }
+
+void init_bloom_filters(void)
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
+	struct diff_options diffopt;
+
+	if (bloom_filters.slab_size == 0)
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
+		struct pathmap_hash_entry *e;
+		struct hashmap_iter iter;
+		hashmap_init(&pathmap, NULL, NULL, 0);
+
+		for (i = 0; i < diff_queued_diff.nr; i++) {
+			const char *path = diff_queued_diff.queue[i]->two->path;
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
+				char *last_slash = strrchr(path, '/');
+
+				FLEX_ALLOC_STR(e, path, path);
+				hashmap_entry_init(&e->entry, strhash(path));
+				hashmap_add(&pathmap, &e->entry);
+
+				if (!last_slash)
+					last_slash = (char*)path;
+				*last_slash = '\0';
+
+			} while (*path);
+
+			diff_free_filepair(diff_queued_diff.queue[i]);
+		}
+
+		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		filter->data = xcalloc(filter->len, sizeof(unsigned char));
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
diff --git a/bloom.h b/bloom.h
index b9ce422ca2d..85ab8e9423d 100644
--- a/bloom.h
+++ b/bloom.h
@@ -1,6 +1,9 @@
 #ifndef BLOOM_H
 #define BLOOM_H
 
+struct commit;
+struct repository;
+
 struct bloom_filter_settings {
 	/*
 	 * The version of the hashing technique being used.
@@ -73,4 +76,9 @@ void add_key_to_filter(const struct bloom_key *key,
 					   struct bloom_filter *filter,
 					   const struct bloom_filter_settings *settings);
 
+void init_bloom_filters(void);
+
+struct bloom_filter *get_bloom_filter(struct repository *r,
+				      struct commit *c);
+
 #endif
\ No newline at end of file
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 20460cde775..f18d1b722e1 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "bloom.h"
 #include "test-tool.h"
+#include "commit.h"
 
 struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
@@ -32,6 +33,16 @@ static void print_bloom_filter(struct bloom_filter *filter) {
 	printf("\n");
 }
 
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
 int cmd__bloom(int argc, const char **argv)
 {
 	if (!strcmp(argv[1], "get_murmur3")) {
@@ -57,5 +68,14 @@ int cmd__bloom(int argc, const char **argv)
 		print_bloom_filter(&filter);
 	}
 
+    if (!strcmp(argv[1], "get_filter_for_commit")) {
+		struct object_id oid;
+		const char *end;
+		if (parse_oid_hex(argv[2], &oid, &end))
+			die("cannot parse oid '%s'", argv[2]);
+		init_bloom_filters();
+		get_bloom_filter_for_commit(&oid);
+	}
+
 	return 0;
 }
\ No newline at end of file
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 36a086c7c60..8f9eef116dc 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -67,4 +67,51 @@ test_expect_success 'compute bloom key for test string 2' '
 	test_cmp expect actual
 '
 
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
+	Filter_Length:25
+	Filter_Data:82|a0|65|47|0c|92|90|c0|a1|40|02|a0|e2|40|e0|04|0a|9a|66|cf|80|19|85|42|23|
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
 test_done
\ No newline at end of file
-- 
gitgitgadget

