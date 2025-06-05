Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603F226541
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132502; cv=none; b=GPIKZpp5uCGOb8qQ4Etj9g5xYzN8HMjAY9KGgyZ1r4Ojfd5Wd8yOh+hUAsKOmL4/bxl9GpeL5c5XEWwmG9id5/wBd620ZV5XfdCj0L7f7tb1rgXiQWtZZrCOcTdHpK7lKTWAf/rF4vyNVADFAzoi1oh4WQPQNj/e12FlCbbayoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132502; c=relaxed/simple;
	bh=7mJ3AlnsNNiU2ma87DNFFyrwA7WxPEtf2oQDp38H3BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZuWRplBiFekJaRQvaN0Q0JPbjyvUKaVsNJUN6jd7X5rt6NVa/BN/WKmh2qchwAkdkaz5Hb6atwTn4Q9/LeG55qsboPpLVYO4MaNuA2/RTHkbXnNHEEdR2E4On7LoL3hB1rRjJ8BeWjnvs9j5H+ig6pxoYC7AjWvPXp/ho3bJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4s032zv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4s032zv"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so8731325e9.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749132498; x=1749737298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+jDDEi2gvL6Z5SDqJg9se6JakrqpioE8lTQPpLgXCw=;
        b=g4s032zvKZo3zqNvz/ecWSxxUMfZoc0Mrxwl3QmdbIuVFZ1kFeDbbtzVg4IWyBvbqt
         e0zr9qjrcXk/23y+Yt83TXDHH/liFUnXxURoJ6SxGpC0zytvd8K0pZ29OY/veugcrTca
         ZtAne8BTKSdXY/r21qcuNihHww/xUgKHzkPsyEvAxHdYipjsC12YDf3EQycZ0yUYI8Fy
         +gAd8jI6454B9knXEIkkFuLbNUWcBEfgNYDfxvurOyYVFkVFbOz+DFt4vfBnhpIKw1oc
         golG02UNDabyNi8e1c782UsJj/bbIaWqqRbSK+xxfuihP4PjUWQS4tyJit9hG+P8OPIY
         UBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132498; x=1749737298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+jDDEi2gvL6Z5SDqJg9se6JakrqpioE8lTQPpLgXCw=;
        b=Nrra9UedBnkL57ykD1ZTKyZHmEgBumbWGYiSZEk7J5O4cj4uaGuVM+7Gdyn/d3OYRV
         31geArekHlqLJSIiDDAZ1x2MQXksGLYnYmCvyQ0AyzymytTQBUHmbeb1mvbzDQcojzw6
         +1d3ioJjOCXv3IDfRdAuC/s5BGLYl6SLBbsV0JjeFEI2rzWx73ynYE9xKLsDjSTCJx3c
         FR5un4zhjjph786wc0AwbokLQdfqhCqdMQmQWw+wX7W4qunw0Kb/s0Zc3smcbwTZ/1RJ
         pwiRV5oM9Zi/hH7bm9HeTRSjui8DGCJUuMSaN1VRKI+tky3+keRk+dZLOCtsGtEjoQAC
         mP2g==
X-Gm-Message-State: AOJu0YwfdLTbUQMHRgUxCV5k5lkpO5E+w+m5f/xwF3X6p/5eK/Iv8vmW
	6ziJ1pj1bBTUN9R7dpELHz7Ybtm0b/fQ4vCdZjAEyiCIKjU1RYG0HXepfv2SWVn5rWg=
X-Gm-Gg: ASbGncvOF5+f0lr+37v4FukPWld6kNAmqOv142DuYe7Yc2PCoIG4/2eNBiFJiEHLwMN
	IjoJiMByjVC6yKkNbOAE9lKGKBfavzqR7iacrxTyCxAvX3IhaaMQNWfHQ8RPQ59oy0vIcuLRLtt
	d8cwyVaIxPv5pBYpdZJiR58fQUfmzL3qZnwFpDNHLKzjb69n2ApNiCyWtubBI6to9L/tWQjYebD
	fCT6AN10IxoNbwDoEc5mmJna1vf5HD9yk2pKP7Da62GFQF4nlZgBmRhijbJCQf7y16JTN4bKsrd
	T+ZABXvWLFr1UEAhOvArQq4wcmR1Tx/E742lqsaRPfHhNg==
X-Google-Smtp-Source: AGHT+IG1/aipCAHq0KybU2vO8pjedc7fepl1HCCMjSzvSsghjm/SyCW+XVIa11LITjlg2BoTFC7nmQ==
X-Received: by 2002:a05:600c:8b26:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-451f889179amr36953445e9.10.1749132498320;
        Thu, 05 Jun 2025 07:08:18 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm8827305e9.27.2025.06.05.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:08:17 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v4 06/10] t/unit-tests: convert reftable table test to use clar
Date: Thu,  5 Jun 2025 15:06:40 +0100
Message-ID: <20250605140644.239199-7-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605140644.239199-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt reftable table test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
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

