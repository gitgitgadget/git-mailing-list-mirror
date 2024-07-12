Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A35182A0
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763481; cv=none; b=Une1TSUiq6pYSBaT/jvKLccHAysSSzghnPR4Nu7JcxmkcIpec8onZ/D3T9UVRH8ZOLOkMX5Z7vZHEdMlEkjwl00x1Zb2M4TNl538mw6EF4Q8PNO9FVY7hC5VYR5rLjNsbFTSC+QRf6xG1vrt6S5YCA+CwkbtmNSBdawkC4QDn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763481; c=relaxed/simple;
	bh=Ud1CcjKOs+sEQrYwDefKahcPEB3Uedzcz0eHMFs8log=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RouwHXXEGBiP/EVPMDE4L2Be0mv1JYojeL7yhJZce3RmkjzVIPxmrg8lqpKWXgX6L4zdhD3sXX8tIt1P6x1dq7o/pbAN4mLPja9KTB1gRq+CzC4PSiU0hV+CG3SlEPXWGZhQYJM87Tw7ilNsJsbxXuVVExSr3xN0D49nVk0Kot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kubTuX1x; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kubTuX1x"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b702be5e4so159465b3a.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 22:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720763478; x=1721368278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM7SAR5JILsoFVvosMlVXxM2q2+Fn8FnYkBHmSnMvrI=;
        b=kubTuX1x7KN+FN5TxOmsBLxxiKq0BfDY2JBUr824ZWEJe/qCbnA+HGzjyU8AYPcNhp
         6hwOE4tK8+tWAX3lE+I5xsOCNvOIbkZeghT1daqjfJv1nZsnBL0WUwvCrsGPgVoe1DZG
         EkbHEXhHqJvlOq74N8KxImt2+SyR3rgPq16/188y1mAmBOl0Y4PXSK2fRHbuiZkrvp0X
         28KCF0G1vOVO9EqCnsO/vsENdbVkGqNyXrj0clbF1rHO/6RY2iisEjy9xmvCtzgkeqxq
         ug4+fbEE4GOPaVAobGaz9U8VtGEdUzpULTkEZnRkTF5L2nHKqdmPVXtjVoAabumpalcF
         tYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763478; x=1721368278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cM7SAR5JILsoFVvosMlVXxM2q2+Fn8FnYkBHmSnMvrI=;
        b=GRj/JCzJYfL7gMdy8gRDNrwY6W5wvP8FpYmqedGPGnILGRTEu+Q/UylBMxaJF6fbhx
         OvIF5a31rQBnvo+1fNClxxtCW0MlwUhdnm8xjl/ai2CjLHhBwU6AkuNl7f7T6PnHjmgD
         td3AZFoMXk5sKhIBkZwb+tbu1DIlMyyD1ATAGpFqoatqklMI3XRoE1geCYr/wcLvsHkc
         mPPPVUxLk72maqgBIlCuOuP5yr590tAjFAzDvehSxWbbRDiNduJd29mJ0pbLtB5rZCWb
         LsYAVTanE4LjYnkpIV32AoOEYT1HYsslBb7Qqp606A1cgNQ4fcGu9k9rMwMAV4D52qXs
         5Lsg==
X-Gm-Message-State: AOJu0YxicXdk0DzzgbAquyg40XvlZnvL3lW13MXmhExp2B9PYMJAM5Q6
	touQpwZjbnua9bauAFb7CIw8obIYmjurSQcs6HW0kkxBVCzPmkScw+zIYQ==
X-Google-Smtp-Source: AGHT+IHSX2BFpgemwXVsO+IaaIi8NkVkCcCLjzJ/iMZ3M65EQo88AJDylZ4l+uTZ5fzmbKfNec6wuA==
X-Received: by 2002:a05:6a00:4b12:b0:704:2f65:4996 with SMTP id d2e1a72fcca58-70b43543af1mr12681934b3a.11.1720763477841;
        Thu, 11 Jul 2024 22:51:17 -0700 (PDT)
Received: from Ubuntu.. ([117.96.148.106])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b4397f475sm6604651b3a.150.2024.07.11.22.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:51:17 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 1/7] t: move reftable/merged_test.c to the unit testing framework
Date: Fri, 12 Jul 2024 11:08:57 +0530
Message-ID: <20240712055041.6476-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240712055041.6476-1-chandrapratap3519@gmail.com>
References: <20240711040854.4602-1-chandrapratap3519@gmail.com>
 <20240712055041.6476-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/merged_test.c exercises the functions defined in
reftable/merged.{c, h}. Migrate reftable/merged_test.c to the unit
testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework and renaming the tests according to unit-tests' naming
conventions.

Also, move strbuf_add_void() and noop_flush() from
reftable/test_framework.c to the ported test. This is because
both these functions are used in the merged tests and
reftable/test_framework.{c, h} is not #included in the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |   2 +-
 reftable/reftable-tests.h                     |   1 -
 t/helper/test-reftable.c                      |   1 -
 .../unit-tests/t-reftable-merged.c            | 113 +++++++++---------
 4 files changed, 60 insertions(+), 57 deletions(-)
 rename reftable/merged_test.c => t/unit-tests/t-reftable-merged.c (84%)

diff --git a/Makefile b/Makefile
index 3eab701b10..e5d1b53991 100644
--- a/Makefile
+++ b/Makefile
@@ -1340,6 +1340,7 @@ UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
+UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-strvec
@@ -2679,7 +2680,6 @@ REFTABLE_OBJS += reftable/writer.o
 
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
-REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 114cc3d053..d5e03dcc1b 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -11,7 +11,6 @@ license that can be found in the LICENSE file or at
 
 int basics_test_main(int argc, const char **argv);
 int block_test_main(int argc, const char **argv);
-int merged_test_main(int argc, const char **argv);
 int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9160bc5da6..0357718fa8 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -10,7 +10,6 @@ int cmd__reftable(int argc, const char **argv)
 	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
-	merged_test_main(argc, argv);
 	stack_test_main(argc, argv);
 	return 0;
 }
diff --git a/reftable/merged_test.c b/t/unit-tests/t-reftable-merged.c
similarity index 84%
rename from reftable/merged_test.c
rename to t/unit-tests/t-reftable-merged.c
index a9d6661c13..78a864a54f 100644
--- a/reftable/merged_test.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -6,20 +6,25 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "merged.h"
-
-#include "system.h"
+#include "test-lib.h"
+#include "reftable/blocksource.h"
+#include "reftable/constants.h"
+#include "reftable/merged.h"
+#include "reftable/reader.h"
+#include "reftable/reftable-generic.h"
+#include "reftable/reftable-merged.h"
+#include "reftable/reftable-writer.h"
+
+static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
+{
+	strbuf_add(b, data, sz);
+	return sz;
+}
 
-#include "basics.h"
-#include "blocksource.h"
-#include "constants.h"
-#include "reader.h"
-#include "record.h"
-#include "test_framework.h"
-#include "reftable-merged.h"
-#include "reftable-tests.h"
-#include "reftable-generic.h"
-#include "reftable-writer.h"
+static int noop_flush(void *arg)
+{
+	return 0;
+}
 
 static void write_test_table(struct strbuf *buf,
 			     struct reftable_ref_record refs[], int n)
@@ -49,12 +54,12 @@ static void write_test_table(struct strbuf *buf,
 	for (i = 0; i < n; i++) {
 		uint64_t before = refs[i].update_index;
 		int n = reftable_writer_add_ref(w, &refs[i]);
-		EXPECT(n == 0);
-		EXPECT(before == refs[i].update_index);
+		check_int(n, ==, 0);
+		check_int(before, ==, refs[i].update_index);
 	}
 
 	err = reftable_writer_close(w);
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_writer_free(w);
 }
@@ -76,11 +81,11 @@ static void write_test_log_table(struct strbuf *buf,
 
 	for (i = 0; i < n; i++) {
 		int err = reftable_writer_add_log(w, &logs[i]);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_writer_close(w);
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_writer_free(w);
 }
@@ -105,12 +110,12 @@ merged_table_from_records(struct reftable_ref_record **refs,
 
 		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
 					  "name");
-		EXPECT_ERR(err);
+		check(!err);
 		reftable_table_from_reader(&tabs[i], (*readers)[i]);
 	}
 
 	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
-	EXPECT_ERR(err);
+	check(!err);
 	return mt;
 }
 
@@ -122,7 +127,7 @@ static void readers_destroy(struct reftable_reader **readers, size_t n)
 	reftable_free(readers);
 }
 
-static void test_merged_between(void)
+static void t_merged_single_record(void)
 {
 	struct reftable_ref_record r1[] = { {
 		.refname = (char *) "b",
@@ -150,11 +155,11 @@ static void test_merged_between(void)
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
 	err = reftable_iterator_seek_ref(&it, "a");
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_iterator_next_ref(&it, &ref);
-	EXPECT_ERR(err);
-	EXPECT(ref.update_index == 2);
+	check(!err);
+	check_int(ref.update_index, ==, 2);
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 2);
@@ -165,7 +170,7 @@ static void test_merged_between(void)
 	reftable_free(bs);
 }
 
-static void test_merged(void)
+static void t_merged_refs(void)
 {
 	struct reftable_ref_record r1[] = {
 		{
@@ -230,9 +235,9 @@ static void test_merged(void)
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
 	err = reftable_iterator_seek_ref(&it, "a");
-	EXPECT_ERR(err);
-	EXPECT(reftable_merged_table_hash_id(mt) == GIT_SHA1_FORMAT_ID);
-	EXPECT(reftable_merged_table_min_update_index(mt) == 1);
+	check(!err);
+	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
+	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_ref_record ref = { NULL };
@@ -245,9 +250,9 @@ static void test_merged(void)
 	}
 	reftable_iterator_destroy(&it);
 
-	EXPECT(ARRAY_SIZE(want) == len);
+	check_int(ARRAY_SIZE(want), ==, len);
 	for (i = 0; i < len; i++) {
-		EXPECT(reftable_ref_record_equal(want[i], &out[i],
+		check(reftable_ref_record_equal(want[i], &out[i],
 						 GIT_SHA1_RAWSZ));
 	}
 	for (i = 0; i < len; i++) {
@@ -283,16 +288,16 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 
 		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
 					  "name");
-		EXPECT_ERR(err);
+		check(!err);
 		reftable_table_from_reader(&tabs[i], (*readers)[i]);
 	}
 
 	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
-	EXPECT_ERR(err);
+	check(!err);
 	return mt;
 }
 
-static void test_merged_logs(void)
+static void t_merged_logs(void)
 {
 	struct reftable_log_record r1[] = {
 		{
@@ -362,9 +367,9 @@ static void test_merged_logs(void)
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
 	err = reftable_iterator_seek_log(&it, "a");
-	EXPECT_ERR(err);
-	EXPECT(reftable_merged_table_hash_id(mt) == GIT_SHA1_FORMAT_ID);
-	EXPECT(reftable_merged_table_min_update_index(mt) == 1);
+	check(!err);
+	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
+	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_log_record log = { NULL };
@@ -377,19 +382,19 @@ static void test_merged_logs(void)
 	}
 	reftable_iterator_destroy(&it);
 
-	EXPECT(ARRAY_SIZE(want) == len);
+	check_int(ARRAY_SIZE(want), ==, len);
 	for (i = 0; i < len; i++) {
-		EXPECT(reftable_log_record_equal(want[i], &out[i],
+		check(reftable_log_record_equal(want[i], &out[i],
 						 GIT_SHA1_RAWSZ));
 	}
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
 	err = reftable_iterator_seek_log_at(&it, "a", 2);
-	EXPECT_ERR(err);
+	check(!err);
 	reftable_log_record_release(&out[0]);
 	err = reftable_iterator_next_log(&it, &out[0]);
-	EXPECT_ERR(err);
-	EXPECT(reftable_log_record_equal(&out[0], &r3[0], GIT_SHA1_RAWSZ));
+	check(!err);
+	check(reftable_log_record_equal(&out[0], &r3[0], GIT_SHA1_RAWSZ));
 	reftable_iterator_destroy(&it);
 
 	for (i = 0; i < len; i++) {
@@ -405,7 +410,7 @@ static void test_merged_logs(void)
 	reftable_free(bs);
 }
 
-static void test_default_write_opts(void)
+static void t_default_write_opts(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
@@ -426,36 +431,36 @@ static void test_default_write_opts(void)
 	reftable_writer_set_limits(w, 1, 1);
 
 	err = reftable_writer_add_ref(w, &rec);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_writer_close(w);
-	EXPECT_ERR(err);
+	check(!err);
 	reftable_writer_free(w);
 
 	block_source_from_strbuf(&source, &buf);
 
 	err = reftable_new_reader(&rd, &source, "filename");
-	EXPECT_ERR(err);
+	check(!err);
 
 	hash_id = reftable_reader_hash_id(rd);
-	EXPECT(hash_id == GIT_SHA1_FORMAT_ID);
+	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
 
 	reftable_table_from_reader(&tab[0], rd);
 	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_reader_free(rd);
 	reftable_merged_table_free(merged);
 	strbuf_release(&buf);
 }
 
-/* XXX test refs_for(oid) */
 
-int merged_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_merged_logs);
-	RUN_TEST(test_merged_between);
-	RUN_TEST(test_merged);
-	RUN_TEST(test_default_write_opts);
-	return 0;
+	TEST(t_default_write_opts(), "merged table with default write opts");
+	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
+	TEST(t_merged_refs(), "merged table with multiple updates to same ref");
+	TEST(t_merged_single_record(), "ref ocurring in only one record can be fetched");
+
+	return test_done();
 }
-- 
2.45.GIT

