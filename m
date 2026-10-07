Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A314BD378
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381068; cv=none; b=MVwxnJFVutFxbaeauW2/7U4eDdxH4ZG3J6HFtQSJGmjYwAbFTnBrdh4kiyQLtak5EYGYo8q1nnE1UGVDZVIulaV6+y6haMZ7cYxErJp8i7vp2ZMBsp1Y56HLSvkVwxcZAyc7gIKneluznJQDR6KtyisktvDyzFifDTFtNKOWJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381068; c=relaxed/simple;
	bh=j8ktTAI11hDKdOCL9/VVDLVp0OZ+hjBbyTSzEmBhDkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8VMn7+cmccJ2DHIWenq6fyIjpbhWOMq3EcN5qihaA73tR8MwVTo3KTD8zfynFkdEAQD719j5ZI8sCRx4yOJHD+DLTCKgyej29D8yErvWDOycmTZJl1PeHYvUocx9iGXZBgF/EwXVlRaOedNGJsmetWj2kewthbYeD+NGwNYjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScBJ/F79; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScBJ/F79"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4d192643dso835248a12.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791381057; x=1791985857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BVDDWbnzA/6iAbUwqabyvf4riHnyp1wW3g6URSrb3I=;
        b=ScBJ/F79NXZDHAB6omNoUQ/+CHqwj4FEfl9zq5gnpuIugFgJpUD4NIhztj+3gMSrxc
         zzKdC1cuyzGYFR46PcO8fUqMZ64XfIgDnn3WPEKF2YZiBuKnCJuPfvgKJVxhZQwWLPKL
         x3ulY6gF9KuUop2F5T2t/cD8u9G3l1FkM1pPOpz3RqGu4Po+LZmhRXTohF0YdI37s2R0
         0HLP67k7COThrNUjGEBv4QPS2vtjxQzmWQxlc6Y5SRDIMelZ6SkyBFmjbzwLxMZPWmeF
         8rqHq+Tluewxlijf92jsWyKPXVLCcPyzmuBfIh02CoCspZcL8bZS0RYjC4ZIcszy8jtK
         wbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791381057; x=1791985857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BVDDWbnzA/6iAbUwqabyvf4riHnyp1wW3g6URSrb3I=;
        b=JQFzONA8ml3HdWpJx94kQQj1HGHkmfFyiEQeTL1puoebVgU/7r2F5ptilHFukXXf/j
         a8kVp5ymsW8vqz+VBkP1kHwM9i2R6GQ9F14NDQ/rCvR0IgsqVGx9lg82R8Ngw6gU4cGR
         pBQjUGkhrpCsj1BaMerJpZ7WGVcIABNWz0UMoTRx+N2Q73Nufp/K3wUDFi77B05U9B3I
         ztxpp9EIjvTVtjA62VNjYx3sWFm3vL9CfbZoWRDcxZQivHHacPpqf/F6bQf1jAdxb93l
         XagzOyw0LlTD8jh1Ng4PCyGLK+3mK7bOnGEUrIl5KRxTBBtbWCF2gKcwUFjq66IgUa/z
         obfw==
X-Gm-Message-State: AFq9FYKV4dJ/C9sRSDDMTCQ5qtIy4oEGSIg1+VvKlN9q+wdbnATFT8/B
	V+0ngcfYkZUmR/ms8MGB/YoIo/TRhN9Eo4dKfUdjKtf+7DXJIn6Cq7XwFNQrmfEu
X-Gm-Gg: AYBFou19XD2n1SEzHfqDN1LL/0zICGreKbEtO5ybL9Zj/YqUrNf2QOe8xSTPM04581j
	f3BYKUCwivOUnzQU1d7k9WYxlG93OZ3twMI6EHOMyqpHHFZe41H+gUY7GuKx0T+OZvYvDnqIhYa
	gOCQv/8AmU8eIBOpsPcg31JQS1L1Z0jwpeMKPlwFrjotPdYYhSHzgjHuocbj69CKLBRHXrLfm/l
	mY8WpgWZZAVHl+vjE1bX8Uo7qsEEmQMlwpRg74jh3hAoVM7xBe9oJ6B+3+XFv4lBRxNDxv9CLMq
	6nlrJCrh88nQSJqQCrrpduaoHp5vHlon715eB4YP9sYygvQf+2r0ABlPYWQGJXhzlbgQj9Xd4xh
	r8WfvJ8J1z9+kY/1vcY1Ph8uTmSNKkUhMm9UGExV8OAKdxcYVmnjY2puj0ZOTMGhyVWOGyEtrOb
	n+T0BrqMVaEgMq5xX7MjL9zepuTJW23eeag0Xp/cBYtdb5C2Ax3xztzp6UK0fqivi4YFMIdUrLC
	+MotUA=
X-Received: by 2002:a17:90b:4b86:b0:3a4:ca46:840f with SMTP id 98e67ed59e1d1-3a89f6878f9mr1750796a91.8.1791381056968;
        Wed, 07 Oct 2026 06:50:56 -0700 (PDT)
Received: from archlinux ([2409:40f4:314a:a1e2:9855:ada9:1db7:a1fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533abe0asm10577916a91.1.2026.10.07.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:50:56 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v2 3/3] t: retire the sorting benchmark and mergesort helper
Date: Wed,  7 Oct 2026 19:20:25 +0530
Message-ID: <b540e3a3d2c30bccaaa0d8dca3428a77c1d2ea76.1791365181.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791365181.git.dilsheddilu123@gmail.com>
References: <20261007034205.32619-1-dilsheddilu123@gmail.com> <cover.1791365181.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p0071 compared sorting implementations during mergesort development.
Retire it as suggested during the unit-test conversion. A new benchmark
can be added if later optimization work needs performance measurements.

The benchmark was the last caller of the sort-only mergesort helper.
Removing it allows us to delete the helper and its build and command
registrations as well.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 Makefile                  |  1 -
 t/helper/meson.build      |  1 -
 t/helper/test-mergesort.c | 67 ---------------------------------------
 t/helper/test-tool.c      |  1 -
 t/helper/test-tool.h      |  1 -
 t/meson.build             |  1 -
 t/perf/p0071-sort.sh      | 52 ------------------------------
 7 files changed, 124 deletions(-)
 delete mode 100644 t/helper/test-mergesort.c
 delete mode 100755 t/perf/p0071-sort.sh

diff --git a/Makefile b/Makefile
index cac535ba19..4b35808b2e 100644
--- a/Makefile
+++ b/Makefile
@@ -835,7 +835,6 @@ TEST_BUILTINS_OBJS += test-hexdump.o
 TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
-TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-name-hash.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 3235f10ab8..e94e6f10fb 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -32,7 +32,6 @@ test_tool_sources = [
   'test-json-writer.c',
   'test-lazy-init-name-hash.c',
   'test-match-trees.c',
-  'test-mergesort.c',
   'test-mktemp.c',
   'test-name-hash.c',
   'test-online-cpus.c',
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
deleted file mode 100644
index e8b8de239b..0000000000
--- a/t/helper/test-mergesort.c
+++ /dev/null
@@ -1,67 +0,0 @@
-#include "test-tool.h"
-#include "mem-pool.h"
-#include "mergesort.h"
-#include "strbuf.h"
-
-struct line {
-	char *text;
-	struct line *next;
-};
-
-DEFINE_LIST_SORT(static, sort_lines, struct line, next);
-
-static int compare_strings(const struct line *x, const struct line *y)
-{
-	return strcmp(x->text, y->text);
-}
-
-static int sort_stdin(void)
-{
-	struct line *lines;
-	struct line **tail = &lines;
-	struct strbuf sb = STRBUF_INIT;
-	struct mem_pool lines_pool;
-	char *p;
-
-	strbuf_read(&sb, 0, 0);
-
-	/*
-	 * Split by newline, but don't create an item
-	 * for the empty string after the last separator.
-	 */
-	if (sb.len && sb.buf[sb.len - 1] == '\n')
-		strbuf_setlen(&sb, sb.len - 1);
-
-	mem_pool_init(&lines_pool, 0);
-	p = sb.buf;
-	for (;;) {
-		char *eol = strchr(p, '\n');
-		struct line *line = mem_pool_alloc(&lines_pool, sizeof(*line));
-		line->text = p;
-		*tail = line;
-		tail = &line->next;
-		if (!eol)
-			break;
-		*eol = '\0';
-		p = eol + 1;
-	}
-	*tail = NULL;
-
-	sort_lines(&lines, compare_strings);
-
-	while (lines) {
-		puts(lines->text);
-		lines = lines->next;
-	}
-	mem_pool_discard(&lines_pool, 0);
-	strbuf_release(&sb);
-	return 0;
-}
-
-int cmd__mergesort(int argc, const char **argv)
-{
-	if (argc == 2 && !strcmp(argv[1], "sort"))
-		return sort_stdin();
-	fprintf(stderr, "usage: test-tool mergesort sort\n");
-	return 129;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..2e80dc7ab8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -42,7 +42,6 @@ static struct test_cmd cmds[] = {
 	{ "json-writer", cmd__json_writer },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "match-trees", cmd__match_trees },
-	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
 	{ "name-hash", cmd__name_hash },
 	{ "online-cpus", cmd__online_cpus },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..9442c61ffd 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,7 +35,6 @@ int cmd__hexdump(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
-int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__name_hash(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
diff --git a/t/meson.build b/t/meson.build
index 2752321e0d..07436b63f4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1146,7 +1146,6 @@ benchmarks = [
   'perf/p0006-read-tree-checkout.sh',
   'perf/p0007-write-cache.sh',
   'perf/p0008-odb-fsync.sh',
-  'perf/p0071-sort.sh',
   'perf/p0090-cache-tree.sh',
   'perf/p0100-globbing.sh',
   'perf/p1006-cat-file.sh',
diff --git a/t/perf/p0071-sort.sh b/t/perf/p0071-sort.sh
deleted file mode 100755
index ae4ddac864..0000000000
--- a/t/perf/p0071-sort.sh
+++ /dev/null
@@ -1,52 +0,0 @@
-#!/bin/sh
-
-test_description='Basic sort performance tests'
-. ./perf-lib.sh
-
-test_perf_default_repo
-
-test_expect_success 'setup' '
-	git ls-files --stage "*.[ch]" "*.sh" |
-	cut -f2 -d" " |
-	git cat-file --batch >unsorted
-'
-
-test_perf 'sort(1) unsorted' '
-	sort <unsorted >sorted
-'
-
-test_expect_success 'reverse' '
-	sort -r <unsorted >reversed
-'
-
-for file in sorted reversed
-do
-	test_perf "sort(1) $file" "
-		sort <$file >actual
-	"
-done
-
-for file in unsorted sorted reversed
-do
-
-	test_perf "string_list_sort() $file" "
-		test-tool string-list sort <$file >actual
-	"
-
-	test_expect_success "string_list_sort() $file sorts like sort(1)" "
-		test_cmp_bin sorted actual
-	"
-done
-
-for file in unsorted sorted reversed
-do
-	test_perf "DEFINE_LIST_SORT $file" "
-		test-tool mergesort sort <$file >actual
-	"
-
-	test_expect_success "DEFINE_LIST_SORT $file sorts like sort(1)" "
-		test_cmp_bin sorted actual
-	"
-done
-
-test_done
-- 
2.55.0

