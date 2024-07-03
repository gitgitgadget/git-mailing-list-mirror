Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8A1849C9
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026737; cv=none; b=kRsOjqZZfePrejB4BiJDtaLKpBaR5gQ/kPGZmtzcjEo2XO9gLWvVmfCHCSDfuzMbaIxpC+O00ek/n5wkU2ZToABpq6z5nm+n8YOS4vJnbFcfgzBbGGxALSo78x8qyBXX3G7EiE1JlZrv3m3a3MxTD0dHkLKNv/AIz7yoFvhGMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026737; c=relaxed/simple;
	bh=4zV6rA+j1h407V4JjTbeK6Ln96j9ayCLZyPa3wAGyN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCvqsMv5izICa0QzgDljyisWSwg8UoR6MJa55PXfMDc5UIOZnsOFo4c8UH8Qq/IegFBu0CiekgyaQyKxRDEuk11vp0ErPXiJ8alXVEv0jTOHiQz+h1KpVUs2cHiBnsuJGaSLkWp/bqpAlAYSrlXVkRciDsEhyYjR4fPZFnRI8cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR4YC9kQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR4YC9kQ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-706524adf91so4570211b3a.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026735; x=1720631535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZvhuI93G22Gy3kkwGg3fg10wud/QD0owA06PJDlkgQ=;
        b=BR4YC9kQlPnEDJ8SNjgo3WHN1BKYv6q1UjcoX9sI10Rj+tX3fJySa4M+1on8RCtK6P
         Si3+TgNz1LUgZ/92XVbzleyJq4+N7vhSxNTqkkBu0JYDIhlX6DDqlulZ4Trdzw6j0ctQ
         QJxygz7x9BkAWLoCSnzUH8NVgrXtaOuUNB1BW1LA93SZvi6gqLepQB88GhYpGJCxbF2k
         0XGNbbGzBdvY8LF5tPyirYOeaSYr+wOB4ALsbmZDeq4sBFTrLieDLK5ztH2pZgDDvtBO
         lddUo1Eq+hrkPABmvOLguyQXkxWpcoYJ2V/liPJeIG4+3te2P38zflLwBImUjiOPq6Fs
         GNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026735; x=1720631535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZvhuI93G22Gy3kkwGg3fg10wud/QD0owA06PJDlkgQ=;
        b=Pj7VP0N3Zrya+vFniWNG1pTz+ZBrJ3zPBFs63GeraWmWUQJJhYnKy/5OaB6xOO8iEu
         39UGURHddr+Tm0mH6gZgCNfN66PvXO0x9OWU6FpePzWJk8R0sbeWLUeZkm9KMH09AmER
         VFqCYfSpcz7ESGur9QT17jOYaej5FIojfyff7d6OO0HgW/WLzxo9W1bvYZOyGv2oxPCZ
         YJvUrdBAzG0X1Gl8/Mj/LQHZ7xFz5an1DKeN/OTtliFIsGeUqkMRx0oBjXMhwH0V8Gue
         P+lry2csLPi/En7n1Gn4E6Ei5ScOHAmshyTVwstYlJR4qssaS3cBvf5ZeyVWGv+1oRj/
         Q2/w==
X-Gm-Message-State: AOJu0Yyo+xlED8aRuxc/Vjf1rv6VCO77BlgeR0+LJs4UErnW/IM3l+6R
	xozHHhjtHAFJaqs6uazlEunFtimUEe40ii9c4VWlPuIo1XuuSHIjncy5pQ==
X-Google-Smtp-Source: AGHT+IFGYa4HqjmL60bplzygw9QoJZmSJU/3MhI9F4WjVtHkHyG5ljybn+o6lKlUKIZWmQNKalvT3w==
X-Received: by 2002:a05:6a00:9290:b0:70a:efd7:ad9b with SMTP id d2e1a72fcca58-70aefd7b02amr2263520b3a.17.1720026734740;
        Wed, 03 Jul 2024 10:12:14 -0700 (PDT)
Received: from Ubuntu.. ([223.176.57.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70803ecf966sm10678860b3a.124.2024.07.03.10.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:12:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 1/5] t: move reftable/merged_test.c to the unit testing framework
Date: Wed,  3 Jul 2024 22:31:41 +0530
Message-ID: <20240703171131.3929-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240703171131.3929-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
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
 t/helper/test-reftable.c                      |   1 -
 .../unit-tests/t-reftable-merged.c            | 112 +++++++++---------
 3 files changed, 60 insertions(+), 55 deletions(-)
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
index a9d6661c13..1718489f06 100644
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
+static void t_merged_between(void)
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
+static void t_merged(void)
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
@@ -426,23 +431,23 @@ static void test_default_write_opts(void)
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
@@ -451,11 +456,12 @@ static void test_default_write_opts(void)
 
 /* XXX test refs_for(oid) */
 
-int merged_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_merged_logs);
-	RUN_TEST(test_merged_between);
-	RUN_TEST(test_merged);
-	RUN_TEST(test_default_write_opts);
-	return 0;
+	TEST(t_merged_logs(), "merged table with log records");
+	TEST(t_merged_between(), "seek ref in a merged table");
+	TEST(t_merged(), "merged table with multiple updates to same ref");
+	TEST(t_default_write_opts(), "merged table with default write opts");
+
+	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

