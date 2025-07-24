Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE92D781F
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363780; cv=none; b=f+ss9HlRG2ktICzksRIIeMkk33s6tf7htkdyoE6E/bRIkeAXT7sal0EFizVBd1w1x0yHyTapynFubC30UplV+MJqBw7C5tGSh0AdpVbJzAqDSqQAM2dxSp8kaAGPg/vGO+JtTw9zveYzF8E69DlQMil2y2vlyR5QrQGmf6xXgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363780; c=relaxed/simple;
	bh=oW3RqlcqcB9icQrzQh4rntm+1oFuHXkx48fiE5PQ4Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfP2dHPRDudwGfPYFb1IwRk4Yhlx63szxaRjwK0qbFwItsveiiryNrOC+JGUJnAfjtqQZ3Q65GR6R1AYOU3Q8LlWG0EpMG3nfPtA2NckE3vQzt+uKzG2hnXpeCSanf9V8eKllnqLGosN2xs06NVlzfTieuvE2WvB/5KV2Br3aWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuH+0RsW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuH+0RsW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45610582d07so6866035e9.0
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753363777; x=1753968577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDrB5odjQusAZnaGW/rVHsjHgaOFf5Iee8e4WTlnh7o=;
        b=TuH+0RsWlged1meNElj2ZrBzMryct2/0n8mMfoifMky9jAFIMHSBV07PBKNz+ePkHN
         mjgGJdXm6h6j5tG4qEKdkn0KxAZ9Onnr8qJW5idmWmsI9xNh4MzoBCTYJidDkeWYLsSo
         iRJNwSqQhbNAb/iw1r/bXzaVTM54F58TDyY3Jskl4Or1av3IdqEZmPiPFEU6aCAZ778w
         HM/9Y5n5z3aRkIbF1RbFPMGekk4tWh8UxCJsDeVr/knEUITvMImI879mjxAff7uJuJv2
         fyfZWj8lvBVeNmeJeN1DShisTxG7PFRHYwP00Dxc5sRuyIcdXNeeomJ/6YBPUvk06psI
         1ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363777; x=1753968577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDrB5odjQusAZnaGW/rVHsjHgaOFf5Iee8e4WTlnh7o=;
        b=paGf9AFDxE14UtIFfGphNxFAsdkyusrkK1YtI3/CV9A1xw48BAGLyzo1KbrvCRAYZV
         XARfSSZzCEcPTSfT61Y0/g6M8TqdL6QKe8pmVT0/obwnUINGeYj7I6g3cWiz43awOVi1
         k58pr6Mb6DmHXaMOB6zNpsDnuQZjiNeyhN4Em5CGmodTIv/2mw9otDVVt3L5Yn/NVwoa
         e46E0TQIGtOWsnY92aCoNB4MpJq4QrRCHqDzzOnl3kUz8z7I6QXxsgTXu/Uf4NIE2WQS
         UkAFrysliEFTHtElxrUj4eo465YCx3AGx+fFXkX6qonPFnWart/3ZgpthbLBSGW/oRl0
         9TXA==
X-Gm-Message-State: AOJu0YxbnGBTMrynQE4YQrRsgQbJKhL0hDRsIdWjgQXguPJijaJiRUDF
	tVmqdEjzibARWZJIsvNj9UyS21jGIldLrRCump1gdG0uWIWVTTKFZvve0WZL8iMlonCZ/iML
X-Gm-Gg: ASbGncuxkxOlPC9az/tLBWCNL+J+DPcgOoncMUIHkUD8vqLIlwtdJt9/+rp7PN9mKD1
	vemxvp2q5P6/3WQOduxa4cBvbNxa9FkvWkAbNwd7/ZV6kQF1TAi/u5SPsgd3U81dLf9EWzEX0T+
	YZEPqtLdBkO3GprjrfQLHaErMr25/yhnjzcKMMlcY8FiAlwGe/oWctmDlKlwtAUQUcpM0uLdIdK
	0bnhYP1dfFkRCfmFJKngh8pLEEiORgIRDXzlO2/Z/CcwM79xvPicsgbkP0EXxlfc4+lPo57JYI2
	s5tOd81LqGQy1t3fQJVSUuHNQLXvorIYWtpYWve0XMLzgdLc4EcnJ9xkSQ9tV5fib0JYksjegmS
	aQ+DH1LNOHPlPoDOt
X-Google-Smtp-Source: AGHT+IFRrIWuzbLh98Igr+pUHApIUDxe7NokANwRZ4GwEt92bIAg5FecaQ8Bk6+D3PuG6JbRLqBOMQ==
X-Received: by 2002:a05:600c:820a:b0:453:6424:48a2 with SMTP id 5b1f17b1804b1-45868c8da8dmr74404795e9.10.1753363776281;
        Thu, 24 Jul 2025 06:29:36 -0700 (PDT)
Received: from localhost.localdomain ([105.113.77.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad7fdsm2232182f8f.43.2025.07.24.06.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:29:35 -0700 (PDT)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/5] t/unit-tests: convert reftable table test to use clar
Date: Thu, 24 Jul 2025 14:28:09 +0100
Message-ID: <20250724132813.59627-2-kuforiji98@gmail.com>
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

Adapt reftable table test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                                      |  4 +-
 t/meson.build                                 |  5 +-
 ...{t-reftable-table.c => u-reftable-table.c} | 75 +++++++++----------
 3 files changed, 39 insertions(+), 45 deletions(-)
 rename t/unit-tests/{t-reftable-table.c => u-reftable-table.c} (75%)

diff --git a/Makefile b/Makefile
index 3cccc73073..0227fdb3e1 100644
--- a/Makefile
+++ b/Makefile
@@ -1368,6 +1368,7 @@ CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-pq
+CLAR_TEST_SUITES += u-reftable-table
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1384,7 +1385,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
-UNIT_TEST_PROGRAMS += t-reftable-table
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
@@ -3972,4 +3972,4 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 	$(OBJCOPY) --localize-hidden $^ $@
 
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
-	$(AR) $(ARFLAGS) $@ $^
+	$(AR) $(ARFLAGS) $@ $^
\ No newline at end of file
diff --git a/t/meson.build b/t/meson.build
index ac4394b7a2..46d3a8580b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -12,6 +12,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-block.c',
   'unit-tests/u-reftable-merged.c',
   'unit-tests/u-reftable-pq.c',
+  'unit-tests/u-reftable-table.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -59,11 +60,9 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-reader.c',
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
-  'unit-tests/t-reftable-table.c',
 ]
 
 foreach unit_test_program : unit_test_programs
@@ -1233,4 +1232,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
+endif
\ No newline at end of file
diff --git a/t/unit-tests/t-reftable-table.c b/t/unit-tests/u-reftable-table.c
similarity index 75%
rename from t/unit-tests/t-reftable-table.c
rename to t/unit-tests/u-reftable-table.c
index 7e1eb533d0..839107d8a4 100644
--- a/t/unit-tests/t-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -1,12 +1,12 @@
-#include "test-lib.h"
-#include "lib-reftable.h"
+#include "unit-test.h"
+#include "lib-reftable-clar.h"
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/iter.h"
 #include "reftable/table.h"
 #include "strbuf.h"
 
-static int t_table_seek_once(void)
+void test_reftable_table__seek_once(void)
 {
 	struct reftable_ref_record records[] = {
 		{
@@ -22,32 +22,32 @@ static int t_table_seek_once(void)
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int ret;
 
-	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
+	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
 	block_source_from_buf(&source, &buf);
 
 	ret = reftable_table_new(&table, &source, "name");
-	check(!ret);
+	cl_assert(!ret);
 
 	reftable_table_init_ref_iterator(table, &it);
 	ret = reftable_iterator_seek_ref(&it, "");
-	check(!ret);
+	cl_assert(!ret);
 	ret = reftable_iterator_next_ref(&it, &ref);
-	check(!ret);
+	cl_assert(!ret);
 
-	ret = reftable_ref_record_equal(&ref, &records[0], REFTABLE_HASH_SIZE_SHA1);
-	check_int(ret, ==, 1);
+	ret = reftable_ref_record_equal(&ref, &records[0],
+					REFTABLE_HASH_SIZE_SHA1);
+	cl_assert_equal_i(ret, 1);
 
 	ret = reftable_iterator_next_ref(&it, &ref);
-	check_int(ret, ==, 1);
+	cl_assert_equal_i(ret, 1);
 
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	reftable_table_decref(table);
 	reftable_buf_release(&buf);
-	return 0;
 }
 
-static int t_table_reseek(void)
+void test_reftable_table__reseek(void)
 {
 	struct reftable_ref_record records[] = {
 		{
@@ -63,35 +63,35 @@ static int t_table_reseek(void)
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int ret;
 
-	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
+	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records),
+				 NULL, 0, NULL);
 	block_source_from_buf(&source, &buf);
 
 	ret = reftable_table_new(&table, &source, "name");
-	check(!ret);
+	cl_assert(!ret);
 
 	reftable_table_init_ref_iterator(table, &it);
 
 	for (size_t i = 0; i < 5; i++) {
 		ret = reftable_iterator_seek_ref(&it, "");
-		check(!ret);
+		cl_assert(!ret);
 		ret = reftable_iterator_next_ref(&it, &ref);
-		check(!ret);
+		cl_assert(!ret);
 
 		ret = reftable_ref_record_equal(&ref, &records[0], REFTABLE_HASH_SIZE_SHA1);
-		check_int(ret, ==, 1);
+		cl_assert_equal_i(ret, 1);
 
 		ret = reftable_iterator_next_ref(&it, &ref);
-		check_int(ret, ==, 1);
+		cl_assert_equal_i(ret, 1);
 	}
 
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	reftable_table_decref(table);
 	reftable_buf_release(&buf);
-	return 0;
 }
 
-static int t_table_block_iterator(void)
+void test_reftable_table__block_iterator(void)
 {
 	struct reftable_block_source source = { 0 };
 	struct reftable_table_iterator it = { 0 };
@@ -147,14 +147,14 @@ static int t_table_block_iterator(void)
 					     (uintmax_t) i);
 	}
 
-	t_reftable_write_to_buf(&buf, records, nrecords, NULL, 0, NULL);
+	cl_reftable_write_to_buf(&buf, records, nrecords, NULL, 0, NULL);
 	block_source_from_buf(&source, &buf);
 
 	ret = reftable_table_new(&table, &source, "name");
-	check(!ret);
+	cl_assert(!ret);
 
 	ret = reftable_table_iterator_init(&it, table);
-	check(!ret);
+	cl_assert(!ret);
 
 	for (size_t i = 0; i < ARRAY_SIZE(expected_blocks); i++) {
 		struct reftable_iterator record_it = { 0 };
@@ -163,22 +163,26 @@ static int t_table_block_iterator(void)
 		};
 
 		ret = reftable_table_iterator_next(&it, &block);
-		check(!ret);
+		cl_assert(!ret);
 
-		check_int(block->block_type, ==, expected_blocks[i].block_type);
-		check_int(block->header_off, ==, expected_blocks[i].header_off);
-		check_int(block->restart_count, ==, expected_blocks[i].restart_count);
+		cl_assert_equal_i(block->block_type,
+				  expected_blocks[i].block_type);
+		cl_assert_equal_i(block->header_off,
+				  expected_blocks[i].header_off);
+		cl_assert_equal_i(block->restart_count,
+				  expected_blocks[i].restart_count);
 
 		ret = reftable_block_init_iterator(block, &record_it);
-		check(!ret);
+		cl_assert(!ret);
 
 		for (size_t j = 0; ; j++) {
 			ret = iterator_next(&record_it, &record);
 			if (ret > 0) {
-				check_int(j, ==, expected_blocks[i].record_count);
+				cl_assert_equal_i(j,
+						  expected_blocks[i].record_count);
 				break;
 			}
-			check(!ret);
+			cl_assert(!ret);
 		}
 
 		reftable_iterator_destroy(&record_it);
@@ -186,7 +190,7 @@ static int t_table_block_iterator(void)
 	}
 
 	ret = reftable_table_iterator_next(&it, &block);
-	check_int(ret, ==, 1);
+	cl_assert_equal_i(ret, 1);
 
 	for (size_t i = 0; i < nrecords; i++)
 		reftable_free(records[i].refname);
@@ -194,13 +198,4 @@ static int t_table_block_iterator(void)
 	reftable_table_decref(table);
 	reftable_buf_release(&buf);
 	reftable_free(records);
-	return 0;
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_table_seek_once(), "table can seek once");
-	TEST(t_table_reseek(), "table can reseek multiple times");
-	TEST(t_table_block_iterator(), "table can iterate through blocks");
-	return test_done();
 }
-- 
2.43.0

