Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208C212D8A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867249; cv=none; b=oHaP8SiIvDjVgQxlhE2e2DvVEg/zy0aC9eoRN15SdkvRkoVuGCkntPcYiJF/HDTbE/5SQBha1jbPpLjsRzIoeXfL2+HIoS6VblgRMwXXYH6rFPSBxW5DojwXNgjik/G6ZceCpFnF42s8SD7x2yhKwvpWGPLQH840xBZ1JdxXjs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867249; c=relaxed/simple;
	bh=+/2V45lDDRWJCjJWIGucUt7rRa+mq39Li9yjstzQ27Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHaiXxnObFKg6oP69/iciofwxtU+TfZP2nSA6hUi4QWXmfV2I49rGJ5pKaJ9ibFSy+59OlysZGZGib4HZbmfqGf4jril/7jFq0LErKlGTB0IYFhRhIb5YHEyro5rIcEIpwp6sEk0zSi6RqHCe8NbcTN2MhoxMyykpwRToCQMXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYd2UbaR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYd2UbaR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso38603205e9.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748867246; x=1749472046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk0RKo5HdnsWuDKgi6uWWowFrPcywcjbX+7YYjZBKRo=;
        b=SYd2UbaRqeJWC0oDhvtZL96PdO8P1x6964+MLFz/EzEmWfZs135UA1TODLb0ODZujB
         E5xXoTgeEjvVOzNcPfhcGP05420isNgDkUHsKDiv+68d4PKoiBzWEjhWYU5aNTTsft6B
         Ju5t0CcQjkkZXb06BJN7WXthikLCiF2M89KvA56/vHU9UNa9MOwwqyEcLp3oLqoU2Lq+
         OcK0dQVhCRm7RUEaRya7sSbYA2Wx6rwE8GNhHMfr9SqoT+keo0jgEG4S10fVW3YXQvMN
         lM1Hcx7ifEOYWQUcWZ1KYVRgAzuyS5jyvW7XMT/Gp4jEY7UimGg0gEBOqPXzR1BTiQ6l
         cMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748867246; x=1749472046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk0RKo5HdnsWuDKgi6uWWowFrPcywcjbX+7YYjZBKRo=;
        b=kqY5E0nxXhgE3nkHbs5s1psQbserCQAmpWkduRw38xWRlz9MVaLeK7MWL7eglhlXWZ
         4t8zpEuMmQMS/UAEC+yFdfUAlMbAa/rBcAuuQr0Ua41C7lxqY/T2cR87JQm+a0kt8g+a
         wuV524+fv2e8x/I1g89EOHnlxmIc+l4nTI80qnYzMyBLaDERachCYPHZvuM9cnhw8QkH
         PTgsWLM27SCJGHp1DLU5Ej9ePSvkSPH7vlsJcNeLiCLlUv5UQ2dzga8GfUSMWluHaOn1
         dugn1LaGRSLgIP5ZryuLpwb8hAdqscqwu9LXvAKU89HyHkABnY0sIclCFY3BFNmFXi9/
         1c9Q==
X-Gm-Message-State: AOJu0Yy9p4pdTaYTEZ1RQRN5zEpPLab0xxaqKEKCM8uR/TGOf0LEYnYG
	XiEqIKcwnzvE9NF/IJ63RBYu3UBwf9LPwDh0FCwgcZdAUDfCyXwdpk+QDyqXu8l/4rE=
X-Gm-Gg: ASbGncuLNd84PGzOcbPr0cNsNDd1ZU9WooQ34PY6ZdYOwOxRNSJmABZ70UxyPH+gWdR
	VIYXFkArW0JaPKm5MXdqbXRB3oveAQyfZUGPPqGCB7ARliz3j8w/+/mLsdoeAnnDa/eO2eMpzMf
	TtYUo8BDfyHwuEsgddXAacgekqBvsE3q2eNYde9DMQk8D/OJkej9OgL5cuiIndQx8a0AWhB8E3j
	0u2E5sv/1sWKDG2IOjI7AhCxt8eWCp4IZPQFF4gHV3iEcLNFHZBoFr8CUYHXdcezhhAzTLvHRbG
	BnYySFZPIKkpVFQEr+vNpOBTeJaDt9U0Gw/IhBnZ4ldDduz6imz9KSpIzFfr55OkbA==
X-Google-Smtp-Source: AGHT+IHxfh7ZSVzgV1Jf9bzuIw3Q+zI/6gFaUU2JHt7+IY721gDfKcWxHkK1LJuKxpSy3dhWwZh1YA==
X-Received: by 2002:a05:600c:4590:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-450d87fd9c9mr116546295e9.4.1748867245596;
        Mon, 02 Jun 2025 05:27:25 -0700 (PDT)
Received: from localhost.localdomain ([105.113.90.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451d30a227csm51034145e9.0.2025.06.02.05.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:27:25 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 06/10] t/unit-tests: convert reftable table test to use clar
Date: Mon,  2 Jun 2025 13:25:54 +0100
Message-ID: <20250602122559.208780-7-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602122559.208780-1-kuforiji98@gmail.com>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
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
 ...{t-reftable-table.c => u-reftable-table.c} | 73 +++++++++----------
 3 files changed, 38 insertions(+), 44 deletions(-)
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
index 7e1eb533d0..25ea672e6a 100644
--- a/t/unit-tests/t-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -1,12 +1,12 @@
 #include "test-lib.h"
-#include "lib-reftable.h"
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

