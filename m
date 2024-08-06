Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E6E18D64A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954050; cv=none; b=L1qP7xA3VFQB/F8uOmSxnElT5YCcKFG6xdDZ0RY0alPOZdp0cZ7H4t5yivydpcgTir/etmRh6KSwd0nK8jfIB6Opu1nPpZnuf6eQ3QGIElL33QtUmR+D00g3MIgMgaFzsKkOQuVSn+w/pe3SM1pJ629IAZVwdVpN+OqifqMTr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954050; c=relaxed/simple;
	bh=n7V9ieUfF+0a5Gqlz/Kzeg3qYnNy0R0mkSLK8TWeJho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3LO/E/votrnSuv+PzHokOoXgDzL5GvlIlIiqkJdrHfsNz0dlV84oMJPupnW1XQTm4hzeD7oB/NBUL+oAV//ptMx6tKfHTGA894I/L6oP8JUvFzEr00STmqOMaKJO5utByMKjTIi9tHiACD7F9n4ujvfKUpGHUD5xfoNYe8DIzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=achY4W6K; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="achY4W6K"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70eec5f2401so524969b3a.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954047; x=1723558847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1RfCfJA+Z3PV949vkgfL/6WT7ffNsER6FKvXR0gfMY=;
        b=achY4W6KElxaqafxypXIoV5cue+0kpX31/JIdhPm4TaTg7Gu8qfCClxu4KcDWeSF6u
         MAn9sMnnMMJxGrcE7CAm57M2Xs97taTH66h6ccSrt75ADCha38PNn2biRgMdCgYkOR9k
         OUWBn+FC4MKKZI1DtRONYtt+M4hELlUu+YlpYmC+Fa7xlCLLoEUlaPjfEhi7noDwTydC
         L7f6PP32OgaMyTvkOeVo+ZaDz3F8BrcvWkRRnJsioUj8JN7nNeodslP+/L3QipAnV3Un
         RJttUM9LoAC1x14i5zJHn/5a4y3fQKNDnlrnK2JBgvVf+bCHsDF3PTMPkkGI+OCDa6Vt
         1Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954047; x=1723558847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1RfCfJA+Z3PV949vkgfL/6WT7ffNsER6FKvXR0gfMY=;
        b=hmT1Oz9Cia09uDteZ5ISKL5wWe8voh5tYCbfFhIbZnvKVKEqYlI1xbOvEwRx8/AVw8
         r3TPTaf5VyQCwqdPWWxM1ZZTBT3SfFpTJh7pqAvOtLig5q4TAeHh87qbOQBC8lKXzh/T
         kDLSoxaTlR2+sDFwvntlXp0DoX/JfjKC+pnqKek5nvF2MvK9RMMro6fYq+Vvy0kLwlwt
         vW9mLBKA6sys+rcMWMgrZGj3Q+5rXxXFcpBDqpnGLJvTxQIV9KolSPVV1vvsBpcMRgCe
         OpUUXNNoxvcZP5GWclT/ayU10H1K4e8sfDFBFTJUl8Q8oa4XSlIiWnWulN10ljsgPWMd
         El1w==
X-Gm-Message-State: AOJu0YxR8ulwp8+cK/IDIa3N7esUrc/poWNh4b/s2Ply3JriT6d0CSiW
	oiEhdx4EHHqK+LQezm2IO0yOkMx4AoGxlpyZW7+qWFGPcn7mEHdH7AA+2i3xu2eclA==
X-Google-Smtp-Source: AGHT+IG2tX3WdBVl1l3eNZCHzobIRkKfcZLTaPsvqM0kW4RNdoOzjRLo5nlRmuIQPLLV+4XSR4g62Q==
X-Received: by 2002:a05:6a20:9189:b0:1c3:3436:a234 with SMTP id adf61e73a8af0-1c69959f1d2mr23215083637.12.1722954046636;
        Tue, 06 Aug 2024 07:20:46 -0700 (PDT)
Received: from Ubuntu.. ([27.59.87.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec416aasm7040563b3a.70.2024.08.06.07.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:20:45 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/6] t: move reftable/stack_test.c to the unit testing framework
Date: Tue,  6 Aug 2024 19:43:37 +0530
Message-ID: <20240806142020.4615-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240806142020.4615-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/stack_test.c exercises the functions defined in
reftable/stack.{c, h}. Migrate reftable/stack_test.c to the
unit testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework and renaming the tests to be in-line with unit-tests'
standards.

Since some of the tests use set_test_hash() defined by
reftable/test_framework.{c, h} but these files are not
'#included' in the test file, copy this function in the
ported test file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |   2 +-
 reftable/reftable-tests.h                     |   1 -
 t/helper/test-reftable.c                      |   1 -
 .../unit-tests/t-reftable-stack.c             | 350 +++++++++---------
 4 files changed, 175 insertions(+), 179 deletions(-)
 rename reftable/stack_test.c => t/unit-tests/t-reftable-stack.c (77%)

diff --git a/Makefile b/Makefile
index 3863e60b66..464a17e11a 100644
--- a/Makefile
+++ b/Makefile
@@ -1342,6 +1342,7 @@ UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-record
+UNIT_TEST_PROGRAMS += t-reftable-stack
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-strvec
@@ -2683,7 +2684,6 @@ REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
-REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index d5e03dcc1b..28fe1be72e 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -14,7 +14,6 @@ int block_test_main(int argc, const char **argv);
 int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
-int stack_test_main(int argc, const char **argv);
 int tree_test_main(int argc, const char **argv);
 int reftable_dump_main(int argc, char *const *argv);
 
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9d378427da..f35db442ae 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -9,7 +9,6 @@ int cmd__reftable(int argc, const char **argv)
 	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
-	stack_test_main(argc, argv);
 	return 0;
 }
 
diff --git a/reftable/stack_test.c b/t/unit-tests/t-reftable-stack.c
similarity index 77%
rename from reftable/stack_test.c
rename to t/unit-tests/t-reftable-stack.c
index e3c11e6a6e..c578659017 100644
--- a/reftable/stack_test.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -6,19 +6,11 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "stack.h"
-
-#include "system.h"
-
-#include "reftable-reader.h"
-#include "merged.h"
-#include "basics.h"
-#include "record.h"
-#include "test_framework.h"
-#include "reftable-tests.h"
-#include "reader.h"
-
-#include <sys/types.h>
+#include "test-lib.h"
+#include "reftable/merged.h"
+#include "reftable/reader.h"
+#include "reftable/reftable-error.h"
+#include "reftable/stack.h"
 #include <dirent.h>
 
 static void clear_dir(const char *dirname)
@@ -29,6 +21,11 @@ static void clear_dir(const char *dirname)
 	strbuf_release(&path);
 }
 
+static void set_test_hash(uint8_t *p, int i)
+{
+	memset(p, (uint8_t)i, hash_size(GIT_SHA1_FORMAT_ID));
+}
+
 static int count_dir_entries(const char *dirname)
 {
 	DIR *dir = opendir(dirname);
@@ -72,11 +69,11 @@ static char *get_tmp_template(int linenumber)
 static char *get_tmp_dir(int linenumber)
 {
 	char *dir = get_tmp_template(linenumber);
-	EXPECT(mkdtemp(dir));
+	check(mkdtemp(dir) != NULL);
 	return dir;
 }
 
-static void test_read_file(void)
+static void t_read_file(void)
 {
 	char *fn = get_tmp_template(__LINE__);
 	int fd = mkstemp(fn);
@@ -86,17 +83,17 @@ static void test_read_file(void)
 	const char *want[] = { "line1", "line2", "line3" };
 	int i = 0;
 
-	EXPECT(fd > 0);
+	check_int(fd, >, 0);
 	n = write_in_full(fd, out, strlen(out));
-	EXPECT(n == strlen(out));
+	check_int(n, ==, strlen(out));
 	err = close(fd);
-	EXPECT(err >= 0);
+	check_int(err, >=, 0);
 
 	err = read_lines(fn, &names);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; names[i]; i++) {
-		EXPECT(0 == strcmp(want[i], names[i]));
+		check_str(want[i], names[i]);
 	}
 	free_names(names);
 	(void) remove(fn);
@@ -122,7 +119,7 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 	return reftable_writer_add_log(wr, wla->log);
 }
 
-static void test_reftable_stack_add_one(void)
+static void t_reftable_stack_add_one(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct strbuf scratch = STRBUF_INIT;
@@ -141,29 +138,29 @@ static void test_reftable_stack_add_one(void)
 	struct reftable_ref_record dest = { NULL };
 	struct stat stat_result = { 0 };
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_test_ref, &ref);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
-	EXPECT_ERR(err);
-	EXPECT(0 == strcmp("master", dest.value.symref));
-	EXPECT(st->readers_len > 0);
+	check(!err);
+	check_str("master", dest.value.symref);
+	check_int(st->readers_len, >, 0);
 
 	printf("testing print functionality:\n");
 	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
-	EXPECT(err == REFTABLE_FORMAT_ERROR);
+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 
 #ifndef GIT_WINDOWS_NATIVE
 	strbuf_addstr(&scratch, dir);
 	strbuf_addstr(&scratch, "/tables.list");
 	err = stat(scratch.buf, &stat_result);
-	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) == opts.default_permissions);
+	check(!err);
+	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 
 	strbuf_reset(&scratch);
 	strbuf_addstr(&scratch, dir);
@@ -171,8 +168,8 @@ static void test_reftable_stack_add_one(void)
 	/* do not try at home; not an external API for reftable. */
 	strbuf_addstr(&scratch, st->readers[0]->name);
 	err = stat(scratch.buf, &stat_result);
-	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) == opts.default_permissions);
+	check(!err);
+	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 #else
 	(void) stat_result;
 #endif
@@ -184,7 +181,7 @@ static void test_reftable_stack_add_one(void)
 	umask(mask);
 }
 
-static void test_reftable_stack_uptodate(void)
+static void t_reftable_stack_uptodate(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL;
@@ -210,28 +207,28 @@ static void test_reftable_stack_uptodate(void)
 	   by creating two stacks for the same directory.
 	 */
 	err = reftable_new_stack(&st1, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_new_stack(&st2, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st1, &write_test_ref, &ref1);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st2, &write_test_ref, &ref2);
-	EXPECT(err == REFTABLE_OUTDATED_ERROR);
+	check_int(err, ==, REFTABLE_OUTDATED_ERROR);
 
 	err = reftable_stack_reload(st2);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st2, &write_test_ref, &ref2);
-	EXPECT_ERR(err);
+	check(!err);
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_transaction_api(void)
+static void t_reftable_stack_transaction_api(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -248,32 +245,32 @@ static void test_reftable_stack_transaction_api(void)
 	struct reftable_ref_record dest = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_addition_destroy(add);
 
 	err = reftable_stack_new_addition(&add, st);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_addition_add(add, &write_test_ref, &ref);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_addition_commit(add);
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_addition_destroy(add);
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
-	EXPECT_ERR(err);
-	EXPECT(REFTABLE_REF_SYMREF == dest.value_type);
-	EXPECT(0 == strcmp("master", dest.value.symref));
+	check(!err);
+	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
+	check_str("master", dest.value.symref);
 
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
+static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = {0};
@@ -282,7 +279,7 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 	int i, n = 20, err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -303,13 +300,13 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 		st->opts.disable_auto_compact = i != n;
 
 		err = reftable_stack_new_addition(&add, st);
-		EXPECT_ERR(err);
+		check(!err);
 
 		err = reftable_addition_add(add, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 
 		err = reftable_addition_commit(add);
-		EXPECT_ERR(err);
+		check(!err);
 
 		reftable_addition_destroy(add);
 
@@ -319,16 +316,16 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			EXPECT(st->merged->stack_len == i + 1);
+			check_int(st->merged->stack_len, ==, i + 1);
 		else
-			EXPECT(st->merged->stack_len == 1);
+			check_int(st->merged->stack_len, ==, 1);
 	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_auto_compaction_fails_gracefully(void)
+static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 {
 	struct reftable_ref_record ref = {
 		.refname = (char *) "refs/heads/master",
@@ -343,13 +340,13 @@ static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, write_test_ref, &ref);
-	EXPECT_ERR(err);
-	EXPECT(st->merged->stack_len == 1);
-	EXPECT(st->stats.attempts == 0);
-	EXPECT(st->stats.failures == 0);
+	check(!err);
+	check_int(st->merged->stack_len, ==, 1);
+	check_int(st->stats.attempts, ==, 0);
+	check_int(st->stats.failures, ==, 0);
 
 	/*
 	 * Lock the newly written table such that it cannot be compacted.
@@ -361,10 +358,10 @@ static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 
 	ref.update_index = 2;
 	err = reftable_stack_add(st, write_test_ref, &ref);
-	EXPECT_ERR(err);
-	EXPECT(st->merged->stack_len == 2);
-	EXPECT(st->stats.attempts == 1);
-	EXPECT(st->stats.failures == 1);
+	check(!err);
+	check_int(st->merged->stack_len, ==, 2);
+	check_int(st->stats.attempts, ==, 1);
+	check_int(st->stats.failures, ==, 1);
 
 	reftable_stack_destroy(st);
 	strbuf_release(&table_path);
@@ -376,7 +373,7 @@ static int write_error(struct reftable_writer *wr, void *arg)
 	return *((int *)arg);
 }
 
-static void test_reftable_stack_update_index_check(void)
+static void t_reftable_stack_update_index_check(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -396,18 +393,18 @@ static void test_reftable_stack_update_index_check(void)
 	};
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_test_ref, &ref1);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_test_ref, &ref2);
-	EXPECT(err == REFTABLE_API_ERROR);
+	check_int(err, ==, REFTABLE_API_ERROR);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_lock_failure(void)
+static void t_reftable_stack_lock_failure(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -415,17 +412,17 @@ static void test_reftable_stack_lock_failure(void)
 	int err, i;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
 		err = reftable_stack_add(st, &write_error, &i);
-		EXPECT(err == i);
+		check_int(err, ==, i);
 	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_add(void)
+static void t_reftable_stack_add(void)
 {
 	int i = 0;
 	int err = 0;
@@ -443,7 +440,7 @@ static void test_reftable_stack_add(void)
 	int N = ARRAY_SIZE(refs);
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char buf[256];
@@ -462,7 +459,7 @@ static void test_reftable_stack_add(void)
 
 	for (i = 0; i < N; i++) {
 		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -471,18 +468,18 @@ static void test_reftable_stack_add(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		int err = reftable_stack_add(st, &write_test_log, &arg);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_stack_compact_all(st, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		struct reftable_ref_record dest = { NULL };
 
 		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
-		EXPECT_ERR(err);
-		EXPECT(reftable_ref_record_equal(&dest, refs + i,
+		check(!err);
+		check(reftable_ref_record_equal(&dest, refs + i,
 						 GIT_SHA1_RAWSZ));
 		reftable_ref_record_release(&dest);
 	}
@@ -490,8 +487,8 @@ static void test_reftable_stack_add(void)
 	for (i = 0; i < N; i++) {
 		struct reftable_log_record dest = { NULL };
 		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
-		EXPECT_ERR(err);
-		EXPECT(reftable_log_record_equal(&dest, logs + i,
+		check(!err);
+		check(reftable_log_record_equal(&dest, logs + i,
 						 GIT_SHA1_RAWSZ));
 		reftable_log_record_release(&dest);
 	}
@@ -500,8 +497,8 @@ static void test_reftable_stack_add(void)
 	strbuf_addstr(&path, dir);
 	strbuf_addstr(&path, "/tables.list");
 	err = stat(path.buf, &stat_result);
-	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) == opts.default_permissions);
+	check(!err);
+	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 
 	strbuf_reset(&path);
 	strbuf_addstr(&path, dir);
@@ -509,8 +506,8 @@ static void test_reftable_stack_add(void)
 	/* do not try at home; not an external API for reftable. */
 	strbuf_addstr(&path, st->readers[0]->name);
 	err = stat(path.buf, &stat_result);
-	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) == opts.default_permissions);
+	check(!err);
+	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 #else
 	(void) stat_result;
 #endif
@@ -525,7 +522,7 @@ static void test_reftable_stack_add(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_log_normalize(void)
+static void t_reftable_stack_log_normalize(void)
 {
 	int err = 0;
 	struct reftable_write_options opts = {
@@ -553,27 +550,27 @@ static void test_reftable_stack_log_normalize(void)
 	};
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	input.value.update.message = (char *) "one\ntwo";
 	err = reftable_stack_add(st, &write_test_log, &arg);
-	EXPECT(err == REFTABLE_API_ERROR);
+	check_int(err, ==, REFTABLE_API_ERROR);
 
 	input.value.update.message = (char *) "one";
 	err = reftable_stack_add(st, &write_test_log, &arg);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_log(st, input.refname, &dest);
-	EXPECT_ERR(err);
-	EXPECT(0 == strcmp(dest.value.update.message, "one\n"));
+	check(!err);
+	check_str(dest.value.update.message, "one\n");
 
 	input.value.update.message = (char *) "two\n";
 	arg.update_index = 2;
 	err = reftable_stack_add(st, &write_test_log, &arg);
-	EXPECT_ERR(err);
+	check(!err);
 	err = reftable_stack_read_log(st, input.refname, &dest);
-	EXPECT_ERR(err);
-	EXPECT(0 == strcmp(dest.value.update.message, "two\n"));
+	check(!err);
+	check_str(dest.value.update.message, "two\n");
 
 	/* cleanup */
 	reftable_stack_destroy(st);
@@ -581,7 +578,7 @@ static void test_reftable_stack_log_normalize(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_tombstone(void)
+static void t_reftable_stack_tombstone(void)
 {
 	int i = 0;
 	char *dir = get_tmp_dir(__LINE__);
@@ -595,7 +592,7 @@ static void test_reftable_stack_tombstone(void)
 	struct reftable_log_record log_dest = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	/* even entries add the refs, odd entries delete them. */
 	for (i = 0; i < N; i++) {
@@ -619,7 +616,7 @@ static void test_reftable_stack_tombstone(void)
 	}
 	for (i = 0; i < N; i++) {
 		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -628,25 +625,25 @@ static void test_reftable_stack_tombstone(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		int err = reftable_stack_add(st, &write_test_log, &arg);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_stack_read_ref(st, "branch", &dest);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 	reftable_ref_record_release(&dest);
 
 	err = reftable_stack_read_log(st, "branch", &log_dest);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 	reftable_log_record_release(&log_dest);
 
 	err = reftable_stack_compact_all(st, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_ref(st, "branch", &dest);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 
 	err = reftable_stack_read_log(st, "branch", &log_dest);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 	reftable_ref_record_release(&dest);
 	reftable_log_record_release(&log_dest);
 
@@ -659,7 +656,7 @@ static void test_reftable_stack_tombstone(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_hash_id(void)
+static void t_reftable_stack_hash_id(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -679,47 +676,47 @@ static void test_reftable_stack_hash_id(void)
 	struct reftable_ref_record dest = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_test_ref, &ref);
-	EXPECT_ERR(err);
+	check(!err);
 
 	/* can't read it with the wrong hash ID. */
 	err = reftable_new_stack(&st32, dir, &opts32);
-	EXPECT(err == REFTABLE_FORMAT_ERROR);
+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 
 	/* check that we can read it back with default opts too. */
 	err = reftable_new_stack(&st_default, dir, &opts_default);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_ref(st_default, "master", &dest);
-	EXPECT_ERR(err);
+	check(!err);
 
-	EXPECT(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
 	reftable_stack_destroy(st_default);
 	clear_dir(dir);
 }
 
-static void test_suggest_compaction_segment(void)
+static void t_suggest_compaction_segment(void)
 {
 	uint64_t sizes[] = { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
 	struct segment min =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
-	EXPECT(min.start == 1);
-	EXPECT(min.end == 10);
+	check_int(min.start, ==, 1);
+	check_int(min.end, ==, 10);
 }
 
-static void test_suggest_compaction_segment_nothing(void)
+static void t_suggest_compaction_segment_nothing(void)
 {
 	uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
 	struct segment result =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
-	EXPECT(result.start == result.end);
+	check_int(result.start, ==, result.end);
 }
 
-static void test_reflog_expire(void)
+static void t_reflog_expire(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -734,7 +731,7 @@ static void test_reflog_expire(void)
 	struct reftable_log_record log = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 1; i <= N; i++) {
 		char buf[256];
@@ -754,30 +751,30 @@ static void test_reflog_expire(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		int err = reftable_stack_add(st, &write_test_log, &arg);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_stack_compact_all(st, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_compact_all(st, &expiry);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_log(st, logs[9].refname, &log);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 
 	err = reftable_stack_read_log(st, logs[11].refname, &log);
-	EXPECT_ERR(err);
+	check(!err);
 
 	expiry.min_update_index = 15;
 	err = reftable_stack_compact_all(st, &expiry);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_log(st, logs[14].refname, &log);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 
 	err = reftable_stack_read_log(st, logs[16].refname, &log);
-	EXPECT_ERR(err);
+	check(!err);
 
 	/* cleanup */
 	reftable_stack_destroy(st);
@@ -794,7 +791,7 @@ static int write_nothing(struct reftable_writer *wr, void *arg)
 	return 0;
 }
 
-static void test_empty_add(void)
+static void t_empty_add(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
@@ -803,13 +800,13 @@ static void test_empty_add(void)
 	struct reftable_stack *st2 = NULL;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_nothing, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_new_stack(&st2, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 	clear_dir(dir);
 	reftable_stack_destroy(st);
 	reftable_stack_destroy(st2);
@@ -825,7 +822,7 @@ static int fastlog2(uint64_t sz)
 	return l - 1;
 }
 
-static void test_reftable_stack_auto_compaction(void)
+static void t_reftable_stack_auto_compaction(void)
 {
 	struct reftable_write_options opts = {
 		.disable_auto_compact = 1,
@@ -836,7 +833,7 @@ static void test_reftable_stack_auto_compaction(void)
 	int N = 100;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
@@ -849,21 +846,21 @@ static void test_reftable_stack_auto_compaction(void)
 		snprintf(name, sizeof(name), "branch%04d", i);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 
 		err = reftable_stack_auto_compact(st);
-		EXPECT_ERR(err);
-		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
+		check(!err);
+		check(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
 	}
 
-	EXPECT(reftable_stack_compaction_stats(st)->entries_written <
-	       (uint64_t)(N * fastlog2(N)));
+	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
+		 (uint64_t)(N * fastlog2(N)));
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_add_performs_auto_compaction(void)
+static void t_reftable_stack_add_performs_auto_compaction(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
@@ -872,7 +869,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 	int err, i, n = 20;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -893,7 +890,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 		ref.refname = refname.buf;
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 
 		/*
 		 * The stack length should grow continuously for all runs where
@@ -901,9 +898,9 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			EXPECT(st->merged->stack_len == i + 1);
+			check_int(st->merged->stack_len, ==, i + 1);
 		else
-			EXPECT(st->merged->stack_len == 1);
+			check_int(st->merged->stack_len, ==, 1);
 	}
 
 	reftable_stack_destroy(st);
@@ -911,7 +908,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_compaction_concurrent(void)
+static void t_reftable_stack_compaction_concurrent(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
@@ -920,7 +917,7 @@ static void test_reftable_stack_compaction_concurrent(void)
 	int N = 3;
 
 	err = reftable_new_stack(&st1, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
@@ -933,19 +930,19 @@ static void test_reftable_stack_compaction_concurrent(void)
 		snprintf(name, sizeof(name), "branch%04d", i);
 
 		err = reftable_stack_add(st1, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_new_stack(&st2, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_compact_all(st1, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
 
-	EXPECT(count_dir_entries(dir) == 2);
+	check_int(count_dir_entries(dir), ==, 2);
 	clear_dir(dir);
 }
 
@@ -960,7 +957,7 @@ static void unclean_stack_close(struct reftable_stack *st)
 	FREE_AND_NULL(st->readers);
 }
 
-static void test_reftable_stack_compaction_concurrent_clean(void)
+static void t_reftable_stack_compaction_concurrent_clean(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
@@ -969,7 +966,7 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 	int N = 3;
 
 	err = reftable_new_stack(&st1, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
@@ -982,24 +979,24 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 		snprintf(name, sizeof(name), "branch%04d", i);
 
 		err = reftable_stack_add(st1, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_new_stack(&st2, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_compact_all(st1, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	unclean_stack_close(st1);
 	unclean_stack_close(st2);
 
 	err = reftable_new_stack(&st3, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_clean(st3);
-	EXPECT_ERR(err);
-	EXPECT(count_dir_entries(dir) == 2);
+	check(!err);
+	check_int(count_dir_entries(dir), ==, 2);
 
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
@@ -1008,27 +1005,28 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 	clear_dir(dir);
 }
 
-int stack_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_empty_add);
-	RUN_TEST(test_read_file);
-	RUN_TEST(test_reflog_expire);
-	RUN_TEST(test_reftable_stack_add);
-	RUN_TEST(test_reftable_stack_add_one);
-	RUN_TEST(test_reftable_stack_auto_compaction);
-	RUN_TEST(test_reftable_stack_add_performs_auto_compaction);
-	RUN_TEST(test_reftable_stack_compaction_concurrent);
-	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
-	RUN_TEST(test_reftable_stack_hash_id);
-	RUN_TEST(test_reftable_stack_lock_failure);
-	RUN_TEST(test_reftable_stack_log_normalize);
-	RUN_TEST(test_reftable_stack_tombstone);
-	RUN_TEST(test_reftable_stack_transaction_api);
-	RUN_TEST(test_reftable_stack_transaction_api_performs_auto_compaction);
-	RUN_TEST(test_reftable_stack_auto_compaction_fails_gracefully);
-	RUN_TEST(test_reftable_stack_update_index_check);
-	RUN_TEST(test_reftable_stack_uptodate);
-	RUN_TEST(test_suggest_compaction_segment);
-	RUN_TEST(test_suggest_compaction_segment_nothing);
-	return 0;
+	TEST(t_empty_add(), "empty addition to stack");
+	TEST(t_read_file(), "read_lines works");
+	TEST(t_reflog_expire(), "expire reflog entries");
+	TEST(t_reftable_stack_add(), "add multiple refs and logs to stack");
+	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
+	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");
+	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
+	TEST(t_reftable_stack_auto_compaction_fails_gracefully(), "failure on auto-compaction");
+	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
+	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
+	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
+	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
+	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
+	TEST(t_reftable_stack_tombstone(), "'tombstone' refs in stack");
+	TEST(t_reftable_stack_transaction_api(), "update transaction to stack");
+	TEST(t_reftable_stack_transaction_api_performs_auto_compaction(), "update transaction triggers auto-compaction");
+	TEST(t_reftable_stack_update_index_check(), "update transactions with equal update indices");
+	TEST(t_reftable_stack_uptodate(), "stack must be reloaded before ref update");
+	TEST(t_suggest_compaction_segment(), "suggest_compaction_segment with basic input");
+	TEST(t_suggest_compaction_segment_nothing(), "suggest_compaction_segment with pre-compacted input");
+
+	return test_done();
 }
-- 
2.45.GIT

