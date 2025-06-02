Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC68212D8A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867240; cv=none; b=rNXDWMSLdGkXmf9xn8EiFEAXrFcNb+H00KQzphv6Ypdr6wryQEUz+/IOFaU9/JZo8YHi1luZqvfDi9HTzOreWvr1BhGnAWO/n26EYq5MND3X2APozy25g+QOgUd7y+YIk7KG9MddmsdsRzb0WUHEJU4cvEiHcPowCad33W4W9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867240; c=relaxed/simple;
	bh=6VTaAK2iTrZ/K4cwhRQz8rSc11pf+rIMwGtW0ieMiz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+cOJux0c5GvuPFUn8mV4p5KE2/179Nc5FnbyDiYq4FSv6YiRECQ9rNfjZuYsj8YvmHHknwUzenX020wm3uJc5+I24Mu34C0kK49pwyB7DiX2PF+2PPYKUd9CVq8tQipzTEOy8Cwr6lF2riIhUQipRGLBO7C8KDZYjriN2T6nQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5KKeLox; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5KKeLox"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442f9043f56so25420625e9.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748867235; x=1749472035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iu8ej31vV2bH0mzcMo1dSiWY71FwCNBwS0PM8CQv8Ok=;
        b=T5KKeLoxN9qGbreeLzIQJm8DUqas4aes9XK5I3eX6aFv8WReu+/KbUZgrX/Y4xfIi6
         4a3HKV/PAD8YHcA3u4muePyGhOkdsGL5oCK5O+Kt3JMHuAOolXxUYCkdXnNyMHH4fhkg
         zuHNAll0UEawRVWCGA+q9DqtobFaO0Kp9yLNz9WLrTYPWBO+3uSKgtzKBqkrjW5MdIqu
         ngCgPcFqRMC/NuPcinIeK3vutLVe5m+GT8hZaqWcyANFMU9vXMGSOEh71rWPaelFLQGt
         WBggH7Fv10GHoC0SjXgBI8u4lGBs/BqjPpFIDO4cWkZvj54cGVGiz2QwdocERG07Eca/
         K4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748867235; x=1749472035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iu8ej31vV2bH0mzcMo1dSiWY71FwCNBwS0PM8CQv8Ok=;
        b=n1AXY/mvgbiN9sVKY1NATRRw45yWHLjMsCmEyc4WusEc2hvv/m34mXwBSbxunYGioi
         vYwQVhoslV+bDgvYLZw53B1zRkSz99MKKXiJLGa5nV0V52tuuwJtuQCuU8jL/7Nhvj6u
         iYc3n8My2zwbbSU5KxKPxxpSmXsl206DGsBPiGdzOntgKF7nd2BuuFAac+4MbBjfdd4m
         zCdVcHuq5P/ZllcPLmxuJVsAQ96LucxFlRoMW2mU3YdKS4wFdhPCd1F0XQathaj1MVT+
         sNpb/3ywg2cZjpbGWWct4Aa+d2oSeJKIE+RpRHPpjt7piEE2JZW/EdO6x+X6ueZquCxU
         61og==
X-Gm-Message-State: AOJu0YwHnhS/VFYXQUCKC0Oe+cpVDvfa9YcbyKR/q2fMiA6/O2lZvCgQ
	VIvSbio+GvbAQhUg+cvX4JXUaCtc9YHA4Jr/GkQGJusHCrxAh/DdRiBKnjtZQmL7WE4=
X-Gm-Gg: ASbGncv93Ur06C2/PmvbzPdsHLadH5Ak6I/uwZvysWj7j6CPQzClzsl+PZlmsKrGnRG
	W20NnUUb4VUfdY9p/3hSMHeCxH6ZTqHx8tB1dgz51kNBcmjFwGGo47IFTDavArmGcBin46BEkYV
	bANpeGF+I1kxhsguFLcZ+YxsfKOnC4IqumIVK2Aygc6HCteHd6ZT6wazun91kW2/rQwTMT6iM/W
	lX41eiDFddcaIhw+yR6mikrFlUUogs7FHj+XN0I/H1pcFiYaR4KJDYdstU5gJxXiKRTV6eh7tPS
	LkoLoUsgQnaHlHXLhW1pPGzmrSk6hm83p3hfc3MQcjijoGbZQLzcy9xn+clnDYkM+A==
X-Google-Smtp-Source: AGHT+IFAQ1cas6of0BWWr6wLpCZkcF0chM7fdTueYl36VLFPS+ljjUNP1D1XPD++ANU6RmEFA1wqAw==
X-Received: by 2002:a05:600c:4e10:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-451191fd314mr72499865e9.4.1748867234311;
        Mon, 02 Jun 2025 05:27:14 -0700 (PDT)
Received: from localhost.localdomain ([105.113.90.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451d30a227csm51034145e9.0.2025.06.02.05.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:27:13 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 04/10] t/unit-tests: convert reftable merged test to use clar
Date: Mon,  2 Jun 2025 13:25:52 +0100
Message-ID: <20250602122559.208780-5-kuforiji98@gmail.com>
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

Adapt reftable merged test file to use clar testing framework by using
clar assertions where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                      |   2 +-
 t/meson.build                                 |   2 +-
 ...-reftable-merged.c => u-reftable-merged.c} | 162 ++++++++----------
 3 files changed, 72 insertions(+), 94 deletions(-)
 rename t/unit-tests/{t-reftable-merged.c => u-reftable-merged.c} (77%)

diff --git a/Makefile b/Makefile
index d01dfd179b..fb0ef10ff2 100644
--- a/Makefile
+++ b/Makefile
@@ -1366,6 +1366,7 @@ CLAR_TEST_SUITES += u-oidtree
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
+CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1379,7 +1380,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
 
-UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
diff --git a/t/meson.build b/t/meson.build
index b1d9dea9e7..d25dfb0c92 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -10,6 +10,7 @@ clar_test_suites = [
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-basics.c',
   'unit-tests/u-reftable-block.c',
+  'unit-tests/u-reftable-merged.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -57,7 +58,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-merged.c',
   'unit-tests/t-reftable-pq.c',
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/u-reftable-merged.c
similarity index 77%
rename from t/unit-tests/t-reftable-merged.c
rename to t/unit-tests/u-reftable-merged.c
index 18c3251a56..e5b9dda4f4 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/u-reftable-merged.c
@@ -6,8 +6,8 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "test-lib.h"
-#include "lib-reftable.h"
+#include "unit-test.h"
+#include "lib-reftable-clar.h"
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/merged.h"
@@ -29,21 +29,21 @@ merged_table_from_records(struct reftable_ref_record **refs,
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(*tables, n);
-	check(*tables != NULL);
+	cl_assert(*tables != NULL);
 	REFTABLE_CALLOC_ARRAY(*source, n);
-	check(*source != NULL);
+	cl_assert(*source != NULL);
 
 	for (size_t i = 0; i < n; i++) {
-		t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
+		cl_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
 		block_source_from_buf(&(*source)[i], &buf[i]);
 
 		err = reftable_table_new(&(*tables)[i], &(*source)[i],
 					 "name");
-		check(!err);
+		cl_assert(!err);
 	}
 
 	err = reftable_merged_table_new(&mt, *tables, n, REFTABLE_HASH_SHA1);
-	check(!err);
+	cl_assert(!err);
 	return mt;
 }
 
@@ -54,7 +54,7 @@ static void tables_destroy(struct reftable_table **tables, const size_t n)
 	reftable_free(tables);
 }
 
-static void t_merged_single_record(void)
+void test_reftable_merged__single_record(void)
 {
 	struct reftable_ref_record r1[] = { {
 		.refname = (char *) "b",
@@ -85,13 +85,14 @@ static void t_merged_single_record(void)
 	int err;
 
 	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_ref(&it, "a");
-	check(!err);
+	cl_assert(err == 0);
 
 	err = reftable_iterator_next_ref(&it, &ref);
-	check(!err);
-	check(reftable_ref_record_equal(&r2[0], &ref, REFTABLE_HASH_SIZE_SHA1));
+	cl_assert(err == 0);
+	cl_assert(reftable_ref_record_equal(&r2[0], &ref,
+					    REFTABLE_HASH_SIZE_SHA1) != 0);
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	tables_destroy(tables, 3);
@@ -101,7 +102,7 @@ static void t_merged_single_record(void)
 	reftable_free(bs);
 }
 
-static void t_merged_refs(void)
+void test_reftable_merged__refs(void)
 {
 	struct reftable_ref_record r1[] = {
 		{
@@ -165,12 +166,12 @@ static void t_merged_refs(void)
 	size_t i;
 
 	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_ref(&it, "a");
-	check(!err);
-	check_int(reftable_merged_table_hash_id(mt), ==, REFTABLE_HASH_SHA1);
-	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
-	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
+	cl_assert(err == 0);
+	cl_assert_equal_i(reftable_merged_table_hash_id(mt), REFTABLE_HASH_SHA1);
+	cl_assert_equal_i(reftable_merged_table_min_update_index(mt), 1);
+	cl_assert_equal_i(reftable_merged_table_max_update_index(mt), 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_ref_record ref = { 0 };
@@ -178,15 +179,15 @@ static void t_merged_refs(void)
 		if (err > 0)
 			break;
 
-		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
+		cl_assert(REFTABLE_ALLOC_GROW(out, len + 1, cap) == 0);
 		out[len++] = ref;
 	}
 	reftable_iterator_destroy(&it);
 
-	check_int(ARRAY_SIZE(want), ==, len);
+	cl_assert_equal_i(ARRAY_SIZE(want), len);
 	for (i = 0; i < len; i++)
-		check(reftable_ref_record_equal(want[i], &out[i],
-						 REFTABLE_HASH_SIZE_SHA1));
+		cl_assert(reftable_ref_record_equal(want[i], &out[i],
+						    REFTABLE_HASH_SIZE_SHA1) != 0);
 	for (i = 0; i < len; i++)
 		reftable_ref_record_release(&out[i]);
 	reftable_free(out);
@@ -198,7 +199,7 @@ static void t_merged_refs(void)
 	reftable_free(bs);
 }
 
-static void t_merged_seek_multiple_times(void)
+void test_reftable_merged__seek_multiple_times(void)
 {
 	struct reftable_ref_record r1[] = {
 		{
@@ -248,20 +249,17 @@ static void t_merged_seek_multiple_times(void)
 
 	for (size_t i = 0; i < 5; i++) {
 		int err = reftable_iterator_seek_ref(&it, "c");
-		check(!err);
+		cl_assert(err == 0);
 
-		err = reftable_iterator_next_ref(&it, &rec);
-		check(!err);
-		err = reftable_ref_record_equal(&rec, &r1[1], REFTABLE_HASH_SIZE_SHA1);
-		check(err == 1);
+		cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
+		cl_assert_equal_i(reftable_ref_record_equal(&rec, &r1[1],
+							    REFTABLE_HASH_SIZE_SHA1), 1);
 
-		err = reftable_iterator_next_ref(&it, &rec);
-		check(!err);
-		err = reftable_ref_record_equal(&rec, &r2[1], REFTABLE_HASH_SIZE_SHA1);
-		check(err == 1);
+		cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
+		cl_assert_equal_i(reftable_ref_record_equal(&rec, &r2[1],
+							    REFTABLE_HASH_SIZE_SHA1), 1);
 
-		err = reftable_iterator_next_ref(&it, &rec);
-		check(err > 0);
+		cl_assert(reftable_iterator_next_ref(&it, &rec) > 0);
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
@@ -273,7 +271,7 @@ static void t_merged_seek_multiple_times(void)
 	reftable_free(sources);
 }
 
-static void t_merged_seek_multiple_times_without_draining(void)
+void test_reftable_merged__seek_multiple_times_no_drain(void)
 {
 	struct reftable_ref_record r1[] = {
 		{
@@ -317,24 +315,19 @@ static void t_merged_seek_multiple_times_without_draining(void)
 	struct reftable_ref_record rec = { 0 };
 	struct reftable_iterator it = { 0 };
 	struct reftable_merged_table *mt;
-	int err;
 
 	mt = merged_table_from_records(refs, &sources, &tables, sizes, bufs, 2);
 	merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
 
-	err = reftable_iterator_seek_ref(&it, "b");
-	check(!err);
-	err = reftable_iterator_next_ref(&it, &rec);
-	check(!err);
-	err = reftable_ref_record_equal(&rec, &r2[0], REFTABLE_HASH_SIZE_SHA1);
-	check(err == 1);
+	cl_assert(reftable_iterator_seek_ref(&it, "b") == 0);
+	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
+	cl_assert_equal_i(reftable_ref_record_equal(&rec, &r2[0],
+						    REFTABLE_HASH_SIZE_SHA1), 1);
 
-	err = reftable_iterator_seek_ref(&it, "a");
-	check(!err);
-	err = reftable_iterator_next_ref(&it, &rec);
-	check(!err);
-	err = reftable_ref_record_equal(&rec, &r1[0], REFTABLE_HASH_SIZE_SHA1);
-	check(err == 1);
+	cl_assert(reftable_iterator_seek_ref(&it, "a") == 0);
+	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
+	cl_assert_equal_i(reftable_ref_record_equal(&rec, &r1[0],
+						    REFTABLE_HASH_SIZE_SHA1), 1);
 
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
 		reftable_buf_release(&bufs[i]);
@@ -359,25 +352,25 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(*tables, n);
-	check(*tables != NULL);
+	cl_assert(*tables != NULL);
 	REFTABLE_CALLOC_ARRAY(*source, n);
-	check(*source != NULL);
+	cl_assert(*source != NULL);
 
 	for (size_t i = 0; i < n; i++) {
-		t_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
+		cl_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
 		block_source_from_buf(&(*source)[i], &buf[i]);
 
 		err = reftable_table_new(&(*tables)[i], &(*source)[i],
 					 "name");
-		check(!err);
+		cl_assert(!err);
 	}
 
 	err = reftable_merged_table_new(&mt, *tables, n, REFTABLE_HASH_SHA1);
-	check(!err);
+	cl_assert(!err);
 	return mt;
 }
 
-static void t_merged_logs(void)
+void test_reftable_merged__logs(void)
 {
 	struct reftable_log_record r1[] = {
 		{
@@ -439,19 +432,19 @@ static void t_merged_logs(void)
 	struct reftable_merged_table *mt = merged_table_from_log_records(
 		logs, &bs, &tables, sizes, bufs, 3);
 	struct reftable_iterator it = { 0 };
-	int err;
 	struct reftable_log_record *out = NULL;
 	size_t len = 0;
 	size_t cap = 0;
 	size_t i;
+	int err;
 
 	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_LOG);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_log(&it, "a");
-	check(!err);
-	check_int(reftable_merged_table_hash_id(mt), ==, REFTABLE_HASH_SHA1);
-	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
-	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
+	cl_assert(!err);
+	cl_assert_equal_i(reftable_merged_table_hash_id(mt), REFTABLE_HASH_SHA1);
+	cl_assert_equal_i(reftable_merged_table_min_update_index(mt), 1);
+	cl_assert_equal_i(reftable_merged_table_max_update_index(mt), 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_log_record log = { 0 };
@@ -459,24 +452,24 @@ static void t_merged_logs(void)
 		if (err > 0)
 			break;
 
-		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
+		cl_assert(REFTABLE_ALLOC_GROW(out, len + 1, cap) == 0);
 		out[len++] = log;
 	}
 	reftable_iterator_destroy(&it);
 
-	check_int(ARRAY_SIZE(want), ==, len);
+	cl_assert_equal_i(ARRAY_SIZE(want), len);
 	for (i = 0; i < len; i++)
-		check(reftable_log_record_equal(want[i], &out[i],
-						 REFTABLE_HASH_SIZE_SHA1));
+		cl_assert(reftable_log_record_equal(want[i], &out[i],
+						    REFTABLE_HASH_SIZE_SHA1) != 0);
 
 	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_LOG);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_log_at(&it, "a", 2);
-	check(!err);
+	cl_assert(!err);
 	reftable_log_record_release(&out[0]);
-	err = reftable_iterator_next_log(&it, &out[0]);
-	check(!err);
-	check(reftable_log_record_equal(&out[0], &r3[0], REFTABLE_HASH_SIZE_SHA1));
+	cl_assert(reftable_iterator_next_log(&it, &out[0]) == 0);
+	cl_assert(reftable_log_record_equal(&out[0], &r3[0],
+					    REFTABLE_HASH_SIZE_SHA1) != 0);
 	reftable_iterator_destroy(&it);
 
 	for (i = 0; i < len; i++)
@@ -490,11 +483,11 @@ static void t_merged_logs(void)
 	reftable_free(bs);
 }
 
-static void t_default_write_opts(void)
+void test_reftable_merged__default_write_opts(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record rec = {
 		.refname = (char *) "master",
 		.update_index = 1,
@@ -507,40 +500,25 @@ static void t_default_write_opts(void)
 
 	reftable_writer_set_limits(w, 1, 1);
 
-	err = reftable_writer_add_ref(w, &rec);
-	check(!err);
+	cl_assert(reftable_writer_add_ref(w, &rec) == 0);
 
-	err = reftable_writer_close(w);
-	check(!err);
+	cl_assert(reftable_writer_close(w) == 0);
 	reftable_writer_free(w);
 
 	block_source_from_buf(&source, &buf);
 
 	err = reftable_table_new(&table, &source, "filename");
-	check(!err);
+	cl_assert(!err);
 
 	hash_id = reftable_table_hash_id(table);
-	check_int(hash_id, ==, REFTABLE_HASH_SHA1);
+	cl_assert_equal_i(hash_id, REFTABLE_HASH_SHA1);
 
 	err = reftable_merged_table_new(&merged, &table, 1, REFTABLE_HASH_SHA256);
-	check_int(err, ==, REFTABLE_FORMAT_ERROR);
+	cl_assert_equal_i(err, REFTABLE_FORMAT_ERROR);
 	err = reftable_merged_table_new(&merged, &table, 1, REFTABLE_HASH_SHA1);
-	check(!err);
+	cl_assert(!err);
 
 	reftable_table_decref(table);
 	reftable_merged_table_free(merged);
 	reftable_buf_release(&buf);
 }
-
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_default_write_opts(), "merged table with default write opts");
-	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
-	TEST(t_merged_refs(), "merged table with multiple updates to same ref");
-	TEST(t_merged_seek_multiple_times(), "merged table can seek multiple times");
-	TEST(t_merged_seek_multiple_times_without_draining(), "merged table can seek multiple times without draining");
-	TEST(t_merged_single_record(), "ref occurring in only one record can be fetched");
-
-	return test_done();
-}
-- 
2.43.0

