Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63A2D8365
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363800; cv=none; b=cT07UKufFC6uhKm2B1YzXhSFffi+lryWBHVxc9+LUJiOVNr5BMB/tpLfpLZmUaoVtG03nZxvp++rEWYPSEt8T7JHXq2czFHCpEpPizaX4zPymajJzmaKVe4rSW84urBsnJkwIwkdw0L2HnZ4IEUmOUn0fVbvqHioRStGI9q4Phs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363800; c=relaxed/simple;
	bh=jiN2SVzpOAB55MxBqYZqVBdmd5NmMSFBiwbn7fDEqMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCZjEOw89fFSxGmqk0Mwy8gU5q1xagkAjQs8o5zGaXDwWDP44gmF/mnDoJ4tS664jHdD633H7F1Rkm6y4Y/6rEw4nEvibtFstO7LiM1x8Od3nctBvX6+f82WZw5HyG8HmeC4TiuCTMVR2vuOOWiFlbvbVR5jlrak0rueZl2NKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by+YPqH5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by+YPqH5"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b77377858bso195625f8f.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753363795; x=1753968595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9CukQtvQeMAkfN6nLPDYUXB20mMywLbffweg0NkSpg=;
        b=by+YPqH5ANtbPws+UtWLrWZTFUaWLZWljcKf/7quiWIIl/T//QhM+sQJWcXeIJylLu
         ZzdL6ZLnbiFA3vFMPrF9ekBLcmYuFF7E8PPtrLYGH7AOiMi706ISggxgkHdP7HJ6L/oz
         dugB7v0RLmzApzOIf83hZqeUi2VTi6daI9g+pQP+5Wz5FBsuooDWEtU75BR2UxEkzU+O
         Sssy6gC4rx4BXcpaQz9wpmGH61LfbNf9pdaZIHWApKEtOyXaJWqHWwWr9DvsLRmIfSuJ
         iv00UzxkscmmrGvF9RCzacjUTbiHPkCIjw9xOi7KKpcXzD8Wfzp9f086/nSL3QftotX7
         hBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363795; x=1753968595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9CukQtvQeMAkfN6nLPDYUXB20mMywLbffweg0NkSpg=;
        b=XaH+eZiaVBgySiNFLLhwoi9FtsuOZEvPEpaHUdK2xhW9ft1JUErz7OtCwU7XBIFdoI
         D8EjEJJ4padPS/jScb/zfoIRHBnz8pGmdI4dtXN9wa917rq3MoHJfaVEsVwtFQqpvkqZ
         6sfzOEASb6trCj+bU473SM0EHHKfL06FGQrqhJjqfdtH+brEesM1SEiuwteaiBw6RYOE
         bxJZxLeWqIzTFtKByQsRx9RaMFGVYjz+8LrVTXHJUHGoRGWCjAGxYCacleF8y4IqwpJe
         J0iNxvyQDOihfsFxh0aQTqYqI0vFqpAjGFlSd39/9CQiEufkAjyQG/i+xY2iSAwCbmNf
         54Vg==
X-Gm-Message-State: AOJu0YwObDS4+94JOhzA/ALuCRDkI3U3gyRouzYJjVyioqRg3zfy6I6b
	gpKlC7s7TfCf3cBESdNkOy7UOceRtXPCRSgUr3LQepof/Q1K/PQf/sczNHBLk8701pvDNACL
X-Gm-Gg: ASbGncvbQHmwmACfksGJjzmB0Tey5htmqtONvCUCnwE3fPu1g9s4cqG0ACrKUBgtaTE
	lMWh8cNSHJbs5l7FyNonvDF7RfNCb77veny2taAiQFMoFQOEOqUT02EjDHMq1yqCeLHhgkrwfXy
	qRnemFXNuQSMPnRcA8+O5WRo9sTsmXwYYmjgJ1Vrf2dUoybX+fJKB58UIMiQD5jHJGbS0XOdTgy
	4Yl/uMGpBn9CqrkRTSOiF+Jif38QhgVsGA2HWw4ORNc2m8W2XJp6G6uBuUGa0iUSk8oRuVt7a1/
	PqeTsOmikfYvWnD/0GIcsWufjQJwNdJux2kz31g1hjW52r0QdKRdhCcPQUeuWTqozb9+k7fwx2D
	ZBJ8DyFylke1vXuJD
X-Google-Smtp-Source: AGHT+IHaCl8bLzqJ290+deHzlA1+I4aEq/8JlyWesoWDHs81qMNnNs3SVkvw2ssP73zGXrMpHNsLEA==
X-Received: by 2002:a05:6000:2486:b0:3b7:6205:25c7 with SMTP id ffacd0b85a97d-3b768cb3cb5mr5856642f8f.13.1753363794423;
        Thu, 24 Jul 2025 06:29:54 -0700 (PDT)
Received: from localhost.localdomain ([105.113.77.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad7fdsm2232182f8f.43.2025.07.24.06.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:29:53 -0700 (PDT)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 4/5] t/unit-tests: convert reftable stack test to use clar
Date: Thu, 24 Jul 2025 14:28:12 +0100
Message-ID: <20250724132813.59627-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724132813.59627-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
 <20250724132813.59627-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kuforiji <kuforiji98@gmail.com>

Adapt reftable stack test file to use clar by using clar assertions
where necessary.

This marks the end of all unit tests migrated away from the
`unit-tests/t-*.c` pattern, there are no longer any files matching that
glob. Remove the sanity check for `t-*.c` files to prevent Meson
configuration errors during CI and local builds.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                                      |   2 +-
 t/meson.build                                 |   5 +-
 ...{t-reftable-stack.c => u-reftable-stack.c} | 780 ++++++++----------
 3 files changed, 333 insertions(+), 454 deletions(-)
 rename t/unit-tests/{t-reftable-stack.c => u-reftable-stack.c} (59%)

diff --git a/Makefile b/Makefile
index 3b41342ddb..8ed8f234f4 100644
--- a/Makefile
+++ b/Makefile
@@ -1369,6 +1369,7 @@ CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-pq
 CLAR_TEST_SUITES += u-reftable-readwrite
+CLAR_TEST_SUITES += u-reftable-stack
 CLAR_TEST_SUITES += u-reftable-table
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
@@ -1383,7 +1384,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
 
-UNIT_TEST_PROGRAMS += t-reftable-stack
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
diff --git a/t/meson.build b/t/meson.build
index 297937f307..fcbb659263 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -13,6 +13,8 @@ clar_test_suites = [
   'unit-tests/u-reftable-merged.c',
   'unit-tests/u-reftable-pq.c',
   'unit-tests/u-reftable-readwrite.c',
+  'unit-tests/u-reftable-record.c',
+  'unit-tests/u-reftable-stack.c',
   'unit-tests/u-reftable-table.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
@@ -61,7 +63,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-stack.c',
 ]
 
 foreach unit_test_program : unit_test_programs
@@ -1163,8 +1164,6 @@ benchmarks = [
 # sufficient to catch missing test suites in our CI though.
 foreach glob, tests : {
   't[0-9][0-9][0-9][0-9]-*.sh': integration_tests,
-  'perf/p[0-9][0-9][0-9][0-9]-*.sh': benchmarks,
-  'unit-tests/t-*.c': unit_test_programs,
   'unit-tests/u-*.c': clar_test_suites,
 }
   actual_tests = run_command(shell, '-c', 'ls ' + glob,
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
similarity index 59%
rename from t/unit-tests/t-reftable-stack.c
rename to t/unit-tests/u-reftable-stack.c
index 2f49c97519..0e3e3f4f4a 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -8,9 +8,9 @@ license that can be found in the LICENSE file or at
 
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
-#include "test-lib.h"
-#include "lib-reftable.h"
+#include "unit-test.h"
 #include "dir.h"
+#include "lib-reftable-clar.h"
 #include "reftable/merged.h"
 #include "reftable/reftable-error.h"
 #include "reftable/stack.h"
@@ -70,11 +70,11 @@ static char *get_tmp_template(int linenumber)
 static char *get_tmp_dir(int linenumber)
 {
 	char *dir = get_tmp_template(linenumber);
-	check(mkdtemp(dir) != NULL);
+	cl_assert(mkdtemp(dir) != NULL);
 	return dir;
 }
 
-static void t_read_file(void)
+void test_reftable_stack__read_file(void)
 {
 	char *fn = get_tmp_template(__LINE__);
 	struct tempfile *tmp = mks_tempfile(fn);
@@ -84,17 +84,17 @@ static void t_read_file(void)
 	char **names = NULL;
 	const char *want[] = { "line1", "line2", "line3" };
 
-	check_int(fd, >, 0);
+	cl_assert(fd > 0);
 	n = write_in_full(fd, out, strlen(out));
-	check_int(n, ==, strlen(out));
+	cl_assert_equal_i(n, strlen(out));
 	err = close(fd);
-	check_int(err, >=, 0);
+	cl_assert(err >= 0);
 
 	err = read_lines(fn, &names);
-	check(!err);
+	cl_assert(!err);
 
 	for (size_t i = 0; names[i]; i++)
-		check_str(want[i], names[i]);
+		cl_assert_equal_s(want[i], names[i]);
 	free_names(names);
 	(void) remove(fn);
 	delete_tempfile(&tmp);
@@ -103,8 +103,8 @@ static void t_read_file(void)
 static int write_test_ref(struct reftable_writer *wr, void *arg)
 {
 	struct reftable_ref_record *ref = arg;
-	check(!reftable_writer_set_limits(wr, ref->update_index,
-					  ref->update_index));
+	cl_assert_equal_i(reftable_writer_set_limits(wr,
+						     ref->update_index, ref->update_index), 0);
 	return reftable_writer_add_ref(wr, ref);
 }
 
@@ -112,7 +112,6 @@ static void write_n_ref_tables(struct reftable_stack *st,
 			       size_t n)
 {
 	int disable_auto_compact;
-	int err;
 
 	disable_auto_compact = st->opts.disable_auto_compact;
 	st->opts.disable_auto_compact = 1;
@@ -126,10 +125,10 @@ static void write_n_ref_tables(struct reftable_stack *st,
 
 		snprintf(buf, sizeof(buf), "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = buf;
-		t_reftable_set_hash(ref.value.val1, i, REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(ref.value.val1, i, REFTABLE_HASH_SHA1);
 
-		err = reftable_stack_add(st, &write_test_ref, &ref);
-		check(!err);
+		cl_assert_equal_i(reftable_stack_add(st,
+						     &write_test_ref, &ref), 0);
 	}
 
 	st->opts.disable_auto_compact = disable_auto_compact;
@@ -144,12 +143,13 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 {
 	struct write_log_arg *wla = arg;
 
-	check(!reftable_writer_set_limits(wr, wla->update_index,
-					  wla->update_index));
+	cl_assert_equal_i(reftable_writer_set_limits(wr,
+						     wla->update_index,
+						     wla->update_index),  0);
 	return reftable_writer_add_log(wr, wla->log);
 }
 
-static void t_reftable_stack_add_one(void)
+void test_reftable_stack__add_one(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_buf scratch = REFTABLE_BUF_INIT;
@@ -158,7 +158,6 @@ static void t_reftable_stack_add_one(void)
 		.default_permissions = 0660,
 	};
 	struct reftable_stack *st = NULL;
-	int err;
 	struct reftable_ref_record ref = {
 		.refname = (char *) "HEAD",
 		.update_index = 1,
@@ -167,32 +166,37 @@ static void t_reftable_stack_add_one(void)
 	};
 	struct reftable_ref_record dest = { 0 };
 	struct stat stat_result = { 0 };
+	int err;
+
 	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_stack_add(st, write_test_ref, &ref);
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
-	check(!err);
-	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
-	check_int(st->tables_len, >, 0);
+	cl_assert(!err);
+	cl_assert(reftable_ref_record_equal(&ref, &dest,
+					    REFTABLE_HASH_SIZE_SHA1));
+	cl_assert(st->tables_len > 0);
 
 #ifndef GIT_WINDOWS_NATIVE
-	check(!reftable_buf_addstr(&scratch, dir));
-	check(!reftable_buf_addstr(&scratch, "/tables.list"));
-	err = stat(scratch.buf, &stat_result);
-	check(!err);
-	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
+	cl_assert_equal_i(reftable_buf_addstr(&scratch, dir), 0);
+	cl_assert_equal_i(reftable_buf_addstr(&scratch,
+					      "/tables.list"), 0);
+	cl_assert_equal_i(stat(scratch.buf, &stat_result), 0);
+	cl_assert_equal_i((stat_result.st_mode & 0777),
+			  opts.default_permissions);
 
 	reftable_buf_reset(&scratch);
-	check(!reftable_buf_addstr(&scratch, dir));
-	check(!reftable_buf_addstr(&scratch, "/"));
+	cl_assert_equal_i(reftable_buf_addstr(&scratch, dir), 0);
+	cl_assert_equal_i(reftable_buf_addstr(&scratch, "/"), 0);
 	/* do not try at home; not an external API for reftable. */
-	check(!reftable_buf_addstr(&scratch, st->tables[0]->name));
+	cl_assert(!reftable_buf_addstr(&scratch, st->tables[0]->name));
 	err = stat(scratch.buf, &stat_result);
-	check(!err);
-	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
+	cl_assert(!err);
+	cl_assert_equal_i((stat_result.st_mode & 0777),
+			   opts.default_permissions);
 #else
 	(void) stat_result;
 #endif
@@ -204,14 +208,13 @@ static void t_reftable_stack_add_one(void)
 	umask(mask);
 }
 
-static void t_reftable_stack_uptodate(void)
+void test_reftable_stack__uptodate(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL;
 	struct reftable_stack *st2 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 
-	int err;
 	struct reftable_ref_record ref1 = {
 		.refname = (char *) "HEAD",
 		.update_index = 1,
@@ -229,34 +232,25 @@ static void t_reftable_stack_uptodate(void)
 	/* simulate multi-process access to the same stack
 	   by creating two stacks for the same directory.
 	 */
-	err = reftable_new_stack(&st1, dir, &opts);
-	check(!err);
-
-	err = reftable_new_stack(&st2, dir, &opts);
-	check(!err);
-
-	err = reftable_stack_add(st1, write_test_ref, &ref1);
-	check(!err);
-
-	err = reftable_stack_add(st2, write_test_ref, &ref2);
-	check_int(err, ==, REFTABLE_OUTDATED_ERROR);
-
-	err = reftable_stack_reload(st2);
-	check(!err);
-
-	err = reftable_stack_add(st2, write_test_ref, &ref2);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
+	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
+	cl_assert_equal_i(reftable_stack_add(st1, write_test_ref,
+					     &ref1), 0);
+	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
+					     &ref2), REFTABLE_OUTDATED_ERROR);
+	cl_assert_equal_i(reftable_stack_reload(st2), 0);
+	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
+					     &ref2), 0);
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_transaction_api(void)
+void test_reftable_stack__transaction_api(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	int err;
 	struct reftable_addition *add = NULL;
 
 	struct reftable_ref_record ref = {
@@ -267,37 +261,32 @@ static void t_reftable_stack_transaction_api(void)
 	};
 	struct reftable_ref_record dest = { 0 };
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	reftable_addition_destroy(add);
 
-	err = reftable_stack_new_addition(&add, st, 0);
-	check(!err);
-
-	err = reftable_addition_add(add, write_test_ref, &ref);
-	check(!err);
-
-	err = reftable_addition_commit(add);
-	check(!err);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st, 0), 0);
+	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
+						&ref), 0);
+	cl_assert_equal_i(reftable_addition_commit(add), 0);
 
 	reftable_addition_destroy(add);
 
-	err = reftable_stack_read_ref(st, ref.refname, &dest);
-	check(!err);
-	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
-	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
+	cl_assert_equal_i(reftable_stack_read_ref(st, ref.refname,
+						  &dest), 0);
+	cl_assert_equal_i(REFTABLE_REF_SYMREF, dest.value_type);
+	cl_assert(reftable_ref_record_equal(&ref, &dest,
+					    REFTABLE_HASH_SIZE_SHA1) != 0);
 
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_transaction_with_reload(void)
+void test_reftable_stack__transaction_with_reload(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
-	int err;
 	struct reftable_addition *add = NULL;
 	struct reftable_ref_record refs[2] = {
 		{
@@ -315,17 +304,12 @@ static void t_reftable_stack_transaction_with_reload(void)
 	};
 	struct reftable_ref_record ref = { 0 };
 
-	err = reftable_new_stack(&st1, dir, NULL);
-	check(!err);
-	err = reftable_new_stack(&st2, dir, NULL);
-	check(!err);
-
-	err = reftable_stack_new_addition(&add, st1, 0);
-	check(!err);
-	err = reftable_addition_add(add, write_test_ref, &refs[0]);
-	check(!err);
-	err = reftable_addition_commit(add);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
+	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st1, 0), 0);
+	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
+						&refs[0]), 0);
+	cl_assert_equal_i(reftable_addition_commit(add), 0);
 	reftable_addition_destroy(add);
 
 	/*
@@ -333,20 +317,20 @@ static void t_reftable_stack_transaction_with_reload(void)
 	 * create the addition and lock the stack by default, but allow the
 	 * reload to happen when REFTABLE_STACK_NEW_ADDITION_RELOAD is set.
 	 */
-	err = reftable_stack_new_addition(&add, st2, 0);
-	check_int(err, ==, REFTABLE_OUTDATED_ERROR);
-	err = reftable_stack_new_addition(&add, st2, REFTABLE_STACK_NEW_ADDITION_RELOAD);
-	check(!err);
-	err = reftable_addition_add(add, write_test_ref, &refs[1]);
-	check(!err);
-	err = reftable_addition_commit(add);
-	check(!err);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, 0),
+						      REFTABLE_OUTDATED_ERROR);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st2,
+						      REFTABLE_STACK_NEW_ADDITION_RELOAD), 0);
+	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
+						&refs[1]), 0);
+	cl_assert_equal_i(reftable_addition_commit(add), 0);
 	reftable_addition_destroy(add);
 
 	for (size_t i = 0; i < ARRAY_SIZE(refs); i++) {
-		err = reftable_stack_read_ref(st2, refs[i].refname, &ref);
-		check(!err);
-		check(reftable_ref_record_equal(&refs[i], &ref, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_stack_read_ref(st2,
+							  refs[i].refname, &ref) , 0);
+		cl_assert(reftable_ref_record_equal(&refs[i], &ref,
+						    REFTABLE_HASH_SIZE_SHA1) != 0);
 	}
 
 	reftable_ref_record_release(&ref);
@@ -355,17 +339,15 @@ static void t_reftable_stack_transaction_with_reload(void)
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
+void test_reftable_stack__transaction_api_performs_auto_compaction(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = {0};
 	struct reftable_addition *add = NULL;
 	struct reftable_stack *st = NULL;
 	size_t n = 20;
-	int err;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	for (size_t i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -385,14 +367,11 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 */
 		st->opts.disable_auto_compact = i != n;
 
-		err = reftable_stack_new_addition(&add, st, 0);
-		check(!err);
-
-		err = reftable_addition_add(add, write_test_ref, &ref);
-		check(!err);
-
-		err = reftable_addition_commit(add);
-		check(!err);
+		cl_assert_equal_i(reftable_stack_new_addition(&add,
+							      st, 0), 0);
+		cl_assert_equal_i(reftable_addition_add(add,
+							write_test_ref, &ref), 0);
+		cl_assert_equal_i(reftable_addition_commit(add), 0);
 
 		reftable_addition_destroy(add);
 
@@ -402,16 +381,16 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			check_int(st->merged->tables_len, ==, i + 1);
+			cl_assert_equal_i(st->merged->tables_len, i + 1);
 		else
-			check_int(st->merged->tables_len, ==, 1);
+			cl_assert_equal_i(st->merged->tables_len, 1);
 	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_auto_compaction_fails_gracefully(void)
+void test_reftable_stack__auto_compaction_fails_gracefully(void)
 {
 	struct reftable_ref_record ref = {
 		.refname = (char *) "refs/heads/master",
@@ -425,32 +404,31 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
-
-	err = reftable_stack_add(st, write_test_ref, &ref);
-	check(!err);
-	check_int(st->merged->tables_len, ==, 1);
-	check_int(st->stats.attempts, ==, 0);
-	check_int(st->stats.failures, ==, 0);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
+					     &ref), 0);
+	cl_assert_equal_i(st->merged->tables_len, 1);
+	cl_assert_equal_i(st->stats.attempts, 0);
+	cl_assert_equal_i(st->stats.failures, 0);
 
 	/*
 	 * Lock the newly written table such that it cannot be compacted.
 	 * Adding a new table to the stack should not be impacted by this, even
 	 * though auto-compaction will now fail.
 	 */
-	check(!reftable_buf_addstr(&table_path, dir));
-	check(!reftable_buf_addstr(&table_path, "/"));
-	check(!reftable_buf_addstr(&table_path, st->tables[0]->name));
-	check(!reftable_buf_addstr(&table_path, ".lock"));
+	cl_assert(!reftable_buf_addstr(&table_path, dir));
+	cl_assert(!reftable_buf_addstr(&table_path, "/"));
+	cl_assert(!reftable_buf_addstr(&table_path,
+				       st->tables[0]->name));
+	cl_assert(!reftable_buf_addstr(&table_path, ".lock"));
 	write_file_buf(table_path.buf, "", 0);
 
 	ref.update_index = 2;
 	err = reftable_stack_add(st, write_test_ref, &ref);
-	check(!err);
-	check_int(st->merged->tables_len, ==, 2);
-	check_int(st->stats.attempts, ==, 1);
-	check_int(st->stats.failures, ==, 1);
+	cl_assert(!err);
+	cl_assert_equal_i(st->merged->tables_len, 2);
+	cl_assert_equal_i(st->stats.attempts, 1);
+	cl_assert_equal_i(st->stats.failures, 1);
 
 	reftable_stack_destroy(st);
 	reftable_buf_release(&table_path);
@@ -462,12 +440,11 @@ static int write_error(struct reftable_writer *wr UNUSED, void *arg)
 	return *((int *)arg);
 }
 
-static void t_reftable_stack_update_index_check(void)
+void test_reftable_stack__update_index_check(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	int err;
 	struct reftable_ref_record ref1 = {
 		.refname = (char *) "name1",
 		.update_index = 1,
@@ -481,39 +458,33 @@ static void t_reftable_stack_update_index_check(void)
 		.value.symref = (char *) "master",
 	};
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
-
-	err = reftable_stack_add(st, write_test_ref, &ref1);
-	check(!err);
-
-	err = reftable_stack_add(st, write_test_ref, &ref2);
-	check_int(err, ==, REFTABLE_API_ERROR);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
+					     &ref1), 0);
+	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
+					     &ref2), REFTABLE_API_ERROR);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_lock_failure(void)
+void test_reftable_stack__lock_failure(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	int err, i;
+	int i;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
-	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
-		err = reftable_stack_add(st, write_error, &i);
-		check_int(err, ==, i);
-	}
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--)
+		cl_assert_equal_i(reftable_stack_add(st, write_error,
+						     &i), i);
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_add(void)
+void test_reftable_stack__add(void)
 {
-	int err = 0;
 	struct reftable_write_options opts = {
 		.exact_log_message = 1,
 		.default_permissions = 0660,
@@ -526,9 +497,10 @@ static void t_reftable_stack_add(void)
 	struct reftable_buf path = REFTABLE_BUF_INIT;
 	struct stat stat_result;
 	size_t i, N = ARRAY_SIZE(refs);
+	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert(!err);
 
 	for (i = 0; i < N; i++) {
 		char buf[256];
@@ -536,66 +508,66 @@ static void t_reftable_stack_add(void)
 		refs[i].refname = xstrdup(buf);
 		refs[i].update_index = i + 1;
 		refs[i].value_type = REFTABLE_REF_VAL1;
-		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(refs[i].value.val1, i,
+				     REFTABLE_HASH_SHA1);
 
 		logs[i].refname = xstrdup(buf);
 		logs[i].update_index = N + i + 1;
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		logs[i].value.update.email = xstrdup("identity@invalid");
-		t_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(logs[i].value.update.new_hash, i,
+				     REFTABLE_HASH_SHA1);
 	}
 
-	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
-		check(!err);
-	}
+	for (i = 0; i < N; i++)
+		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
+					     &refs[i]), 0);
 
 	for (i = 0; i < N; i++) {
 		struct write_log_arg arg = {
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, write_test_log, &arg);
-		check(!err);
+		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
+						     &arg), 0);
 	}
 
-	err = reftable_stack_compact_all(st, NULL);
-	check(!err);
+	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), 0);
 
 	for (i = 0; i < N; i++) {
 		struct reftable_ref_record dest = { 0 };
 
-		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
-		check(!err);
-		check(reftable_ref_record_equal(&dest, refs + i,
-						 REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_stack_read_ref(st,
+							  refs[i].refname, &dest), 0);
+		cl_assert(reftable_ref_record_equal(&dest, refs + i,
+						    REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_ref_record_release(&dest);
 	}
 
 	for (i = 0; i < N; i++) {
 		struct reftable_log_record dest = { 0 };
-		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
-		check(!err);
-		check(reftable_log_record_equal(&dest, logs + i,
-						 REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_stack_read_log(st,
+							  refs[i].refname, &dest), 0);
+		cl_assert(reftable_log_record_equal(&dest, logs + i,
+						    REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_log_record_release(&dest);
 	}
 
 #ifndef GIT_WINDOWS_NATIVE
-	check(!reftable_buf_addstr(&path, dir));
-	check(!reftable_buf_addstr(&path, "/tables.list"));
-	err = stat(path.buf, &stat_result);
-	check(!err);
-	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
+	cl_assert_equal_i(reftable_buf_addstr(&path, dir), 0);
+	cl_assert_equal_i(reftable_buf_addstr(&path, "/tables.list"), 0);
+	cl_assert_equal_i(stat(path.buf, &stat_result), 0);
+	cl_assert_equal_i((stat_result.st_mode & 0777), opts.default_permissions);
 
 	reftable_buf_reset(&path);
-	check(!reftable_buf_addstr(&path, dir));
-	check(!reftable_buf_addstr(&path, "/"));
+	cl_assert_equal_i(reftable_buf_addstr(&path, dir), 0);
+	cl_assert_equal_i(reftable_buf_addstr(&path, "/"), 0);
 	/* do not try at home; not an external API for reftable. */
-	check(!reftable_buf_addstr(&path, st->tables[0]->name));
+	cl_assert(!reftable_buf_addstr(&path, st->tables[0]->name));
 	err = stat(path.buf, &stat_result);
-	check(!err);
-	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
+	cl_assert(!err);
+	cl_assert_equal_i((stat_result.st_mode & 0777),
+			  opts.default_permissions);
 #else
 	(void) stat_result;
 #endif
@@ -610,7 +582,7 @@ static void t_reftable_stack_add(void)
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_iterator(void)
+void test_reftable_stack__iterator(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
@@ -621,27 +593,27 @@ static void t_reftable_stack_iterator(void)
 	size_t N = ARRAY_SIZE(refs), i;
 	int err;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	for (i = 0; i < N; i++) {
 		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		refs[i].update_index = i + 1;
 		refs[i].value_type = REFTABLE_REF_VAL1;
-		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(refs[i].value.val1, i,
+				     REFTABLE_HASH_SHA1);
 
 		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		logs[i].update_index = i + 1;
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		logs[i].value.update.email = xstrdup("johndoe@invalid");
 		logs[i].value.update.message = xstrdup("commit\n");
-		t_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(logs[i].value.update.new_hash, i,
+				     REFTABLE_HASH_SHA1);
 	}
 
-	for (i = 0; i < N; i++) {
-		err = reftable_stack_add(st, write_test_ref, &refs[i]);
-		check(!err);
-	}
+	for (i = 0; i < N; i++)
+		cl_assert_equal_i(reftable_stack_add(st,
+						     write_test_ref, &refs[i]), 0);
 
 	for (i = 0; i < N; i++) {
 		struct write_log_arg arg = {
@@ -649,8 +621,8 @@ static void t_reftable_stack_iterator(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 
-		err = reftable_stack_add(st, write_test_log, &arg);
-		check(!err);
+		cl_assert_equal_i(reftable_stack_add(st,
+						     write_test_log, &arg), 0);
 	}
 
 	reftable_stack_init_ref_iterator(st, &it);
@@ -661,16 +633,16 @@ static void t_reftable_stack_iterator(void)
 		err = reftable_iterator_next_ref(&it, &ref);
 		if (err > 0)
 			break;
-		check(!err);
-		check(reftable_ref_record_equal(&ref, &refs[i], REFTABLE_HASH_SIZE_SHA1));
+		cl_assert(!err);
+		cl_assert(reftable_ref_record_equal(&ref, &refs[i],
+						    REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_ref_record_release(&ref);
 	}
-	check_int(i, ==, N);
+	cl_assert_equal_i(i, N);
 
 	reftable_iterator_destroy(&it);
 
-	err = reftable_stack_init_log_iterator(st, &it);
-	check(!err);
+	cl_assert_equal_i(reftable_stack_init_log_iterator(st, &it), 0);
 
 	reftable_iterator_seek_log(&it, logs[0].refname);
 	for (i = 0; ; i++) {
@@ -679,11 +651,12 @@ static void t_reftable_stack_iterator(void)
 		err = reftable_iterator_next_log(&it, &log);
 		if (err > 0)
 			break;
-		check(!err);
-		check(reftable_log_record_equal(&log, &logs[i], REFTABLE_HASH_SIZE_SHA1));
+		cl_assert(!err);
+		cl_assert(reftable_log_record_equal(&log, &logs[i],
+						    REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_log_record_release(&log);
 	}
-	check_int(i, ==, N);
+	cl_assert_equal_i(i, N);
 
 	reftable_stack_destroy(st);
 	reftable_iterator_destroy(&it);
@@ -694,9 +667,8 @@ static void t_reftable_stack_iterator(void)
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_log_normalize(void)
+void test_reftable_stack__log_normalize(void)
 {
-	int err = 0;
 	struct reftable_write_options opts = {
 		0,
 	};
@@ -721,28 +693,26 @@ static void t_reftable_stack_log_normalize(void)
 		.update_index = 1,
 	};
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	input.value.update.message = (char *) "one\ntwo";
-	err = reftable_stack_add(st, write_test_log, &arg);
-	check_int(err, ==, REFTABLE_API_ERROR);
+	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
+					     &arg), REFTABLE_API_ERROR);
 
 	input.value.update.message = (char *) "one";
-	err = reftable_stack_add(st, write_test_log, &arg);
-	check(!err);
-
-	err = reftable_stack_read_log(st, input.refname, &dest);
-	check(!err);
-	check_str(dest.value.update.message, "one\n");
+	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
+					     &arg), 0);
+	cl_assert_equal_i(reftable_stack_read_log(st, input.refname,
+						  &dest), 0);
+	cl_assert_equal_s(dest.value.update.message, "one\n");
 
 	input.value.update.message = (char *) "two\n";
 	arg.update_index = 2;
-	err = reftable_stack_add(st, write_test_log, &arg);
-	check(!err);
-	err = reftable_stack_read_log(st, input.refname, &dest);
-	check(!err);
-	check_str(dest.value.update.message, "two\n");
+	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
+					     &arg), 0);
+	cl_assert_equal_i(reftable_stack_read_log(st, input.refname,
+						  &dest), 0);
+	cl_assert_equal_s(dest.value.update.message, "two\n");
 
 	/* cleanup */
 	reftable_stack_destroy(st);
@@ -750,20 +720,18 @@ static void t_reftable_stack_log_normalize(void)
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_tombstone(void)
+void test_reftable_stack__tombstone(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	int err;
 	struct reftable_ref_record refs[2] = { 0 };
 	struct reftable_log_record logs[2] = { 0 };
 	size_t i, N = ARRAY_SIZE(refs);
 	struct reftable_ref_record dest = { 0 };
 	struct reftable_log_record log_dest = { 0 };
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	/* even entries add the refs, odd entries delete them. */
 	for (i = 0; i < N; i++) {
@@ -772,8 +740,8 @@ static void t_reftable_stack_tombstone(void)
 		refs[i].update_index = i + 1;
 		if (i % 2 == 0) {
 			refs[i].value_type = REFTABLE_REF_VAL1;
-			t_reftable_set_hash(refs[i].value.val1, i,
-					    REFTABLE_HASH_SHA1);
+			cl_reftable_set_hash(refs[i].value.val1, i,
+					     REFTABLE_HASH_SHA1);
 		}
 
 		logs[i].refname = xstrdup(buf);
@@ -785,42 +753,36 @@ static void t_reftable_stack_tombstone(void)
 		logs[i].update_index = 1;
 		if (i % 2 == 0) {
 			logs[i].value_type = REFTABLE_LOG_UPDATE;
-			t_reftable_set_hash(logs[i].value.update.new_hash, i,
-					    REFTABLE_HASH_SHA1);
+			cl_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
 			logs[i].value.update.email =
 				xstrdup("identity@invalid");
 		}
 	}
-	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
-		check(!err);
-	}
+	for (i = 0; i < N; i++)
+		cl_assert_equal_i(reftable_stack_add(st, write_test_ref, &refs[i]), 0);
 
 	for (i = 0; i < N; i++) {
 		struct write_log_arg arg = {
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, write_test_log, &arg);
-		check(!err);
+		cl_assert_equal_i(reftable_stack_add(st,
+						     write_test_log, &arg), 0);
 	}
 
-	err = reftable_stack_read_ref(st, "branch", &dest);
-	check_int(err, ==, 1);
+	cl_assert_equal_i(reftable_stack_read_ref(st, "branch",
+						  &dest), 1);
 	reftable_ref_record_release(&dest);
 
-	err = reftable_stack_read_log(st, "branch", &log_dest);
-	check_int(err, ==, 1);
+	cl_assert_equal_i(reftable_stack_read_log(st, "branch",
+						  &log_dest), 1);
 	reftable_log_record_release(&log_dest);
 
-	err = reftable_stack_compact_all(st, NULL);
-	check(!err);
-
-	err = reftable_stack_read_ref(st, "branch", &dest);
-	check_int(err, ==, 1);
-
-	err = reftable_stack_read_log(st, "branch", &log_dest);
-	check_int(err, ==, 1);
+	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), 0);
+	cl_assert_equal_i(reftable_stack_read_ref(st, "branch",
+						  &dest), 1);
+	cl_assert_equal_i(reftable_stack_read_log(st, "branch",
+						  &log_dest), 1);
 	reftable_ref_record_release(&dest);
 	reftable_log_record_release(&log_dest);
 
@@ -833,12 +795,11 @@ static void t_reftable_stack_tombstone(void)
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_hash_id(void)
+void test_reftable_stack__hash_id(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	int err;
 
 	struct reftable_ref_record ref = {
 		.refname = (char *) "master",
@@ -852,62 +813,57 @@ static void t_reftable_stack_hash_id(void)
 	struct reftable_stack *st_default = NULL;
 	struct reftable_ref_record dest = { 0 };
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
-
-	err = reftable_stack_add(st, write_test_ref, &ref);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
+					     &ref), 0);
 
 	/* can't read it with the wrong hash ID. */
-	err = reftable_new_stack(&st32, dir, &opts32);
-	check_int(err, ==, REFTABLE_FORMAT_ERROR);
+	cl_assert_equal_i(reftable_new_stack(&st32, dir,
+					     &opts32), REFTABLE_FORMAT_ERROR);
 
 	/* check that we can read it back with default opts too. */
-	err = reftable_new_stack(&st_default, dir, &opts_default);
-	check(!err);
-
-	err = reftable_stack_read_ref(st_default, "master", &dest);
-	check(!err);
-
-	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
+	cl_assert_equal_i(reftable_new_stack(&st_default, dir,
+					     &opts_default), 0);
+	cl_assert_equal_i(reftable_stack_read_ref(st_default, "master",
+						  &dest), 0);
+	cl_assert(reftable_ref_record_equal(&ref, &dest,
+					    REFTABLE_HASH_SIZE_SHA1) != 0);
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
 	reftable_stack_destroy(st_default);
 	clear_dir(dir);
 }
 
-static void t_suggest_compaction_segment(void)
+void test_reftable_stack__suggest_compaction_segment(void)
 {
 	uint64_t sizes[] = { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
 	struct segment min =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
-	check_int(min.start, ==, 1);
-	check_int(min.end, ==, 10);
+	cl_assert_equal_i(min.start, 1);
+	cl_assert_equal_i(min.end, 10);
 }
 
-static void t_suggest_compaction_segment_nothing(void)
+void test_reftable_stack__suggest_compaction_segment_nothing(void)
 {
 	uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
 	struct segment result =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
-	check_int(result.start, ==, result.end);
+	cl_assert_equal_i(result.start, result.end);
 }
 
-static void t_reflog_expire(void)
+void test_reftable_stack__reflog_expire(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	struct reftable_log_record logs[20] = { 0 };
 	size_t i, N = ARRAY_SIZE(logs) - 1;
-	int err;
 	struct reftable_log_expiry_config expiry = {
 		.time = 10,
 	};
 	struct reftable_log_record log = { 0 };
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	for (i = 1; i <= N; i++) {
 		char buf[256];
@@ -918,8 +874,8 @@ static void t_reflog_expire(void)
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		logs[i].value.update.time = i;
 		logs[i].value.update.email = xstrdup("identity@invalid");
-		t_reftable_set_hash(logs[i].value.update.new_hash, i,
-				    REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(logs[i].value.update.new_hash, i,
+				     REFTABLE_HASH_SHA1);
 	}
 
 	for (i = 1; i <= N; i++) {
@@ -927,31 +883,23 @@ static void t_reflog_expire(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, write_test_log, &arg);
-		check(!err);
+		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
+						     &arg), 0);
 	}
 
-	err = reftable_stack_compact_all(st, NULL);
-	check(!err);
-
-	err = reftable_stack_compact_all(st, &expiry);
-	check(!err);
-
-	err = reftable_stack_read_log(st, logs[9].refname, &log);
-	check_int(err, ==, 1);
-
-	err = reftable_stack_read_log(st, logs[11].refname, &log);
-	check(!err);
+	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st, &expiry), 0);
+	cl_assert_equal_i(reftable_stack_read_log(st, logs[9].refname,
+						  &log), 1);
+	cl_assert_equal_i(reftable_stack_read_log(st, logs[11].refname,
+						  &log), 0);
 
 	expiry.min_update_index = 15;
-	err = reftable_stack_compact_all(st, &expiry);
-	check(!err);
-
-	err = reftable_stack_read_log(st, logs[14].refname, &log);
-	check_int(err, ==, 1);
-
-	err = reftable_stack_read_log(st, logs[16].refname, &log);
-	check(!err);
+	cl_assert_equal_i(reftable_stack_compact_all(st, &expiry), 0);
+	cl_assert_equal_i(reftable_stack_read_log(st, logs[14].refname,
+						  &log), 1);
+	cl_assert_equal_i(reftable_stack_read_log(st, logs[16].refname,
+						  &log), 0);
 
 	/* cleanup */
 	reftable_stack_destroy(st);
@@ -963,26 +911,21 @@ static void t_reflog_expire(void)
 
 static int write_nothing(struct reftable_writer *wr, void *arg UNUSED)
 {
-	check(!reftable_writer_set_limits(wr, 1, 1));
+	cl_assert_equal_i(reftable_writer_set_limits(wr, 1, 1), 0);
 	return 0;
 }
 
-static void t_empty_add(void)
+void test_reftable_stack__empty_add(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	int err;
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_stack *st2 = NULL;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
-
-	err = reftable_stack_add(st, write_nothing, NULL);
-	check(!err);
-
-	err = reftable_new_stack(&st2, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
+	cl_assert_equal_i(reftable_stack_add(st, write_nothing,
+					     NULL), 0);
+	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
 	clear_dir(dir);
 	reftable_stack_destroy(st);
 	reftable_stack_destroy(st2);
@@ -998,18 +941,17 @@ static int fastlogN(uint64_t sz, uint64_t N)
 	return l - 1;
 }
 
-static void t_reftable_stack_auto_compaction(void)
+void test_reftable_stack__auto_compaction(void)
 {
 	struct reftable_write_options opts = {
 		.disable_auto_compact = 1,
 	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err;
 	size_t i, N = 100;
+	int err;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
@@ -1022,32 +964,31 @@ static void t_reftable_stack_auto_compaction(void)
 		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
 		err = reftable_stack_add(st, write_test_ref, &ref);
-		check(!err);
+		cl_assert(!err);
 
 		err = reftable_stack_auto_compact(st);
-		check(!err);
-		check(i < 2 || st->merged->tables_len < 2 * fastlogN(i, 2));
+		cl_assert(!err);
+		cl_assert(i < 2 || st->merged->tables_len < 2 * fastlogN(i, 2));
 	}
 
-	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
-	       (uint64_t)(N * fastlogN(N, 2)));
+	cl_assert(reftable_stack_compaction_stats(st)->entries_written <
+			  (uint64_t)(N * fastlogN(N, 2)));
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_auto_compaction_factor(void)
+void test_reftable_stack__auto_compaction_factor(void)
 {
 	struct reftable_write_options opts = {
 		.auto_compaction_factor = 5,
 	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err;
 	size_t N = 100;
+	int err;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	for (size_t i = 0; i < N; i++) {
 		char name[20];
@@ -1059,16 +1000,16 @@ static void t_reftable_stack_auto_compaction_factor(void)
 		xsnprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
-		check(!err);
+		cl_assert(!err);
 
-		check(i < 5 || st->merged->tables_len < 5 * fastlogN(i, 5));
+		cl_assert(i < 5 || st->merged->tables_len < 5 * fastlogN(i, 5));
 	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_auto_compaction_with_locked_tables(void)
+void test_reftable_stack__auto_compaction_with_locked_tables(void)
 {
 	struct reftable_write_options opts = {
 		.disable_auto_compact = 1,
@@ -1078,21 +1019,20 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	write_n_ref_tables(st, 5);
-	check_int(st->merged->tables_len, ==, 5);
+	cl_assert_equal_i(st->merged->tables_len, 5);
 
 	/*
 	 * Given that all tables we have written should be roughly the same
 	 * size, we expect that auto-compaction will want to compact all of the
 	 * tables. Locking any of the tables will keep it from doing so.
 	 */
-	check(!reftable_buf_addstr(&buf, dir));
-	check(!reftable_buf_addstr(&buf, "/"));
-	check(!reftable_buf_addstr(&buf, st->tables[2]->name));
-	check(!reftable_buf_addstr(&buf, ".lock"));
+	cl_assert(!reftable_buf_addstr(&buf, dir));
+	cl_assert(!reftable_buf_addstr(&buf, "/"));
+	cl_assert(!reftable_buf_addstr(&buf, st->tables[2]->name));
+	cl_assert(!reftable_buf_addstr(&buf, ".lock"));
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1102,25 +1042,23 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 	 * only compact the newest two tables.
 	 */
 	err = reftable_stack_auto_compact(st);
-	check(!err);
-	check_int(st->stats.failures, ==, 0);
-	check_int(st->merged->tables_len, ==, 4);
+	cl_assert(!err);
+	cl_assert_equal_i(st->stats.failures, 0);
+	cl_assert_equal_i(st->merged->tables_len, 4);
 
 	reftable_stack_destroy(st);
 	reftable_buf_release(&buf);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_add_performs_auto_compaction(void)
+void test_reftable_stack__add_performs_auto_compaction(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err;
 	size_t i, n = 20;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	for (i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -1140,8 +1078,8 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 		snprintf(buf, sizeof(buf), "branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = buf;
 
-		err = reftable_stack_add(st, write_test_ref, &ref);
-		check(!err);
+		cl_assert_equal_i(reftable_stack_add(st,
+						     write_test_ref, &ref), 0);
 
 		/*
 		 * The stack length should grow continuously for all runs where
@@ -1149,16 +1087,16 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			check_int(st->merged->tables_len, ==, i + 1);
+			cl_assert_equal_i(st->merged->tables_len, i + 1);
 		else
-			check_int(st->merged->tables_len, ==, 1);
+			cl_assert_equal_i(st->merged->tables_len, 1);
 	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_compaction_with_locked_tables(void)
+void test_reftable_stack__compaction_with_locked_tables(void)
 {
 	struct reftable_write_options opts = {
 		.disable_auto_compact = 1,
@@ -1168,17 +1106,16 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 	char *dir = get_tmp_dir(__LINE__);
 	int err;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	write_n_ref_tables(st, 3);
-	check_int(st->merged->tables_len, ==, 3);
+	cl_assert_equal_i(st->merged->tables_len, 3);
 
 	/* Lock one of the tables that we're about to compact. */
-	check(!reftable_buf_addstr(&buf, dir));
-	check(!reftable_buf_addstr(&buf, "/"));
-	check(!reftable_buf_addstr(&buf, st->tables[1]->name));
-	check(!reftable_buf_addstr(&buf, ".lock"));
+	cl_assert(!reftable_buf_addstr(&buf, dir));
+	cl_assert(!reftable_buf_addstr(&buf, "/"));
+	cl_assert(!reftable_buf_addstr(&buf, st->tables[1]->name));
+	cl_assert(!reftable_buf_addstr(&buf, ".lock"));
 	write_file_buf(buf.buf, "", 0);
 
 	/*
@@ -1186,36 +1123,31 @@ static void t_reftable_stack_compaction_with_locked_tables(void)
 	 * compact all tables.
 	 */
 	err = reftable_stack_compact_all(st, NULL);
-	check_int(err, ==, REFTABLE_LOCK_ERROR);
-	check_int(st->stats.failures, ==, 1);
-	check_int(st->merged->tables_len, ==, 3);
+	cl_assert_equal_i(err, REFTABLE_LOCK_ERROR);
+	cl_assert_equal_i(st->stats.failures, 1);
+	cl_assert_equal_i(st->merged->tables_len, 3);
 
 	reftable_stack_destroy(st);
 	reftable_buf_release(&buf);
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_compaction_concurrent(void)
+void test_reftable_stack__compaction_concurrent(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err;
 
-	err = reftable_new_stack(&st1, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
 	write_n_ref_tables(st1, 3);
 
-	err = reftable_new_stack(&st2, dir, &opts);
-	check(!err);
-
-	err = reftable_stack_compact_all(st1, NULL);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st1, NULL), 0);
 
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
 
-	check_int(count_dir_entries(dir), ==, 2);
+	cl_assert_equal_i(count_dir_entries(dir), 2);
 	clear_dir(dir);
 }
 
@@ -1228,32 +1160,24 @@ static void unclean_stack_close(struct reftable_stack *st)
 	REFTABLE_FREE_AND_NULL(st->tables);
 }
 
-static void t_reftable_stack_compaction_concurrent_clean(void)
+void test_reftable_stack__compaction_concurrent_clean(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err;
 
-	err = reftable_new_stack(&st1, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
 	write_n_ref_tables(st1, 3);
 
-	err = reftable_new_stack(&st2, dir, &opts);
-	check(!err);
-
-	err = reftable_stack_compact_all(st1, NULL);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
+	cl_assert_equal_i(reftable_stack_compact_all(st1, NULL), 0);
 
 	unclean_stack_close(st1);
 	unclean_stack_close(st2);
 
-	err = reftable_new_stack(&st3, dir, &opts);
-	check(!err);
-
-	err = reftable_stack_clean(st3);
-	check(!err);
-	check_int(count_dir_entries(dir), ==, 2);
+	cl_assert_equal_i(reftable_new_stack(&st3, dir, &opts), 0);
+	cl_assert_equal_i(reftable_stack_clean(st3), 0);
+	cl_assert_equal_i(count_dir_entries(dir), 2);
 
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
@@ -1262,7 +1186,7 @@ static void t_reftable_stack_compaction_concurrent_clean(void)
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_read_across_reload(void)
+void test_reftable_stack__read_across_reload(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
@@ -1272,37 +1196,35 @@ static void t_reftable_stack_read_across_reload(void)
 	int err;
 
 	/* Create a first stack and set up an iterator for it. */
-	err = reftable_new_stack(&st1, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
 	write_n_ref_tables(st1, 2);
-	check_int(st1->merged->tables_len, ==, 2);
+	cl_assert_equal_i(st1->merged->tables_len, 2);
 	reftable_stack_init_ref_iterator(st1, &it);
-	err = reftable_iterator_seek_ref(&it, "");
-	check(!err);
+	cl_assert_equal_i(reftable_iterator_seek_ref(&it, ""), 0);
 
 	/* Set up a second stack for the same directory and compact it. */
 	err = reftable_new_stack(&st2, dir, &opts);
-	check(!err);
-	check_int(st2->merged->tables_len, ==, 2);
+	cl_assert(!err);
+	cl_assert_equal_i(st2->merged->tables_len, 2);
 	err = reftable_stack_compact_all(st2, NULL);
-	check(!err);
-	check_int(st2->merged->tables_len, ==, 1);
+	cl_assert(!err);
+	cl_assert_equal_i(st2->merged->tables_len, 1);
 
 	/*
 	 * Verify that we can continue to use the old iterator even after we
 	 * have reloaded its stack.
 	 */
 	err = reftable_stack_reload(st1);
-	check(!err);
-	check_int(st1->merged->tables_len, ==, 1);
+	cl_assert(!err);
+	cl_assert_equal_i(st1->merged->tables_len, 1);
 	err = reftable_iterator_next_ref(&it, &rec);
-	check(!err);
-	check_str(rec.refname, "refs/heads/branch-0000");
+	cl_assert(!err);
+	cl_assert_equal_s(rec.refname, "refs/heads/branch-0000");
 	err = reftable_iterator_next_ref(&it, &rec);
-	check(!err);
-	check_str(rec.refname, "refs/heads/branch-0001");
+	cl_assert(!err);
+	cl_assert_equal_s(rec.refname, "refs/heads/branch-0001");
 	err = reftable_iterator_next_ref(&it, &rec);
-	check_int(err, >, 0);
+	cl_assert(err > 0);
 
 	reftable_ref_record_release(&rec);
 	reftable_iterator_destroy(&it);
@@ -1311,7 +1233,7 @@ static void t_reftable_stack_read_across_reload(void)
 	clear_dir(dir);
 }
 
-static void t_reftable_stack_reload_with_missing_table(void)
+void test_reftable_stack__reload_with_missing_table(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
@@ -1322,46 +1244,40 @@ static void t_reftable_stack_reload_with_missing_table(void)
 	int err;
 
 	/* Create a first stack and set up an iterator for it. */
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 	write_n_ref_tables(st, 2);
-	check_int(st->merged->tables_len, ==, 2);
+	cl_assert_equal_i(st->merged->tables_len, 2);
 	reftable_stack_init_ref_iterator(st, &it);
-	err = reftable_iterator_seek_ref(&it, "");
-	check(!err);
+	cl_assert_equal_i(reftable_iterator_seek_ref(&it, ""), 0);
 
 	/*
 	 * Update the tables.list file with some garbage data, while reusing
 	 * our old tables. This should trigger a partial reload of the stack,
 	 * where we try to reuse our old tables.
 	*/
-	check(!reftable_buf_addstr(&content, st->tables[0]->name));
-	check(!reftable_buf_addstr(&content, "\n"));
-	check(!reftable_buf_addstr(&content, st->tables[1]->name));
-	check(!reftable_buf_addstr(&content, "\n"));
-	check(!reftable_buf_addstr(&content, "garbage\n"));
-	check(!reftable_buf_addstr(&table_path, st->list_file));
-	check(!reftable_buf_addstr(&table_path, ".lock"));
+	cl_assert(!reftable_buf_addstr(&content, st->tables[0]->name));
+	cl_assert(!reftable_buf_addstr(&content, "\n"));
+	cl_assert(!reftable_buf_addstr(&content, st->tables[1]->name));
+	cl_assert(!reftable_buf_addstr(&content, "\n"));
+	cl_assert(!reftable_buf_addstr(&content, "garbage\n"));
+	cl_assert(!reftable_buf_addstr(&table_path, st->list_file));
+	cl_assert(!reftable_buf_addstr(&table_path, ".lock"));
 	write_file_buf(table_path.buf, content.buf, content.len);
-	err = rename(table_path.buf, st->list_file);
-	check(!err);
+	cl_assert_equal_i(rename(table_path.buf, st->list_file), 0);
 
 	err = reftable_stack_reload(st);
-	check_int(err, ==, -4);
-	check_int(st->merged->tables_len, ==, 2);
+	cl_assert_equal_i(err, -4);
+	cl_assert_equal_i(st->merged->tables_len, 2);
 
 	/*
 	 * Even though the reload has failed, we should be able to continue
 	 * using the iterator.
 	*/
-	err = reftable_iterator_next_ref(&it, &rec);
-	check(!err);
-	check_str(rec.refname, "refs/heads/branch-0000");
-	err = reftable_iterator_next_ref(&it, &rec);
-	check(!err);
-	check_str(rec.refname, "refs/heads/branch-0001");
-	err = reftable_iterator_next_ref(&it, &rec);
-	check_int(err, >, 0);
+	cl_assert_equal_i(reftable_iterator_next_ref(&it, &rec), 0);
+	cl_assert_equal_s(rec.refname, "refs/heads/branch-0000");
+	cl_assert_equal_i(reftable_iterator_next_ref(&it, &rec), 0);
+	cl_assert_equal_s(rec.refname, "refs/heads/branch-0001");
+	cl_assert(reftable_iterator_next_ref(&it, &rec) > 0);
 
 	reftable_ref_record_release(&rec);
 	reftable_iterator_destroy(&it);
@@ -1374,12 +1290,13 @@ static void t_reftable_stack_reload_with_missing_table(void)
 static int write_limits_after_ref(struct reftable_writer *wr, void *arg)
 {
 	struct reftable_ref_record *ref = arg;
-	check(!reftable_writer_set_limits(wr, ref->update_index, ref->update_index));
-	check(!reftable_writer_add_ref(wr, ref));
+	cl_assert_equal_i(reftable_writer_set_limits(wr,
+						     ref->update_index, ref->update_index), 0);
+	cl_assert_equal_i(reftable_writer_add_ref(wr, ref), 0);
 	return reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
 }
 
-static void t_reftable_invalid_limit_updates(void)
+void test_reftable_stack__invalid_limit_updates(void)
 {
 	struct reftable_ref_record ref = {
 		.refname = (char *) "HEAD",
@@ -1393,59 +1310,22 @@ static void t_reftable_invalid_limit_updates(void)
 	struct reftable_addition *add = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_stack *st = NULL;
-	int err;
 
-	err = reftable_new_stack(&st, dir, &opts);
-	check(!err);
+	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
 
 	reftable_addition_destroy(add);
 
-	err = reftable_stack_new_addition(&add, st, 0);
-	check(!err);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st, 0), 0);
 
 	/*
 	 * write_limits_after_ref also updates the update indexes after adding
 	 * the record. This should cause an err to be returned, since the limits
 	 * must be set at the start.
 	 */
-	err = reftable_addition_add(add, write_limits_after_ref, &ref);
-	check_int(err, ==, REFTABLE_API_ERROR);
+	cl_assert_equal_i(reftable_addition_add(add,
+						write_limits_after_ref, &ref), REFTABLE_API_ERROR);
 
 	reftable_addition_destroy(add);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_empty_add(), "empty addition to stack");
-	TEST(t_read_file(), "read_lines works");
-	TEST(t_reflog_expire(), "expire reflog entries");
-	TEST(t_reftable_invalid_limit_updates(), "prevent limit updates after adding records");
-	TEST(t_reftable_stack_add(), "add multiple refs and logs to stack");
-	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
-	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");
-	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
-	TEST(t_reftable_stack_auto_compaction_factor(), "auto-compaction with non-default geometric factor");
-	TEST(t_reftable_stack_auto_compaction_fails_gracefully(), "failure on auto-compaction");
-	TEST(t_reftable_stack_auto_compaction_with_locked_tables(), "auto compaction with locked tables");
-	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
-	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
-	TEST(t_reftable_stack_compaction_with_locked_tables(), "compaction with locked tables");
-	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
-	TEST(t_reftable_stack_iterator(), "log and ref iterator for reftable stack");
-	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
-	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
-	TEST(t_reftable_stack_read_across_reload(), "stack iterators work across reloads");
-	TEST(t_reftable_stack_reload_with_missing_table(), "stack iteration with garbage tables");
-	TEST(t_reftable_stack_tombstone(), "'tombstone' refs in stack");
-	TEST(t_reftable_stack_transaction_api(), "update transaction to stack");
-	TEST(t_reftable_stack_transaction_with_reload(), "transaction with reload");
-	TEST(t_reftable_stack_transaction_api_performs_auto_compaction(), "update transaction triggers auto-compaction");
-	TEST(t_reftable_stack_update_index_check(), "update transactions with equal update indices");
-	TEST(t_reftable_stack_uptodate(), "stack must be reloaded before ref update");
-	TEST(t_suggest_compaction_segment(), "suggest_compaction_segment with basic input");
-	TEST(t_suggest_compaction_segment_nothing(), "suggest_compaction_segment with pre-compacted input");
-
-	return test_done();
-}
-- 
2.43.0

