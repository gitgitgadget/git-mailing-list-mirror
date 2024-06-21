Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCCB13D615
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971067; cv=none; b=kcr3u72w8JW70TucZ97/G6ShjhW0VdHf5r+Im2YKM/ovbGdXpaOF/p1acW7kJA1U+7q3FbCT2DvdQFFGaeTgQ19DJ8YKzh4DLnEBf0uPk6A/e3YAqKJsrJvQcLjbvaPYvu3GeCTrqfmX+3I1T1r0aV0Q1dYAsu2zq5oXeG2l/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971067; c=relaxed/simple;
	bh=OoTJemVyRW8TYKBFpN6Ub/xGbZfeKzeqkPJkF1PsYCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+IcmRwx2Q43cAwTRTOKIerdF+9n66iJnSaI9qBKOYz06TGGAZuPdB48/Vzz7VZ4q4+EQy3fkXK/WVvToSNnl5M5DE1kQuwcvcBIE/0gkXuJWYjMBu4lp2IJm+MhICMGb2eUV4gDtREH1aV74ix9uE6A4sNKclL2fuvuomYrUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRlPDGUd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRlPDGUd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9f9a3866fso1827715ad.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971064; x=1719575864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkNsc81pvogY8LbTicFd/ENZaZm51YQcpZbMFUuPyPE=;
        b=lRlPDGUdH8XANB7NyjMj0ldXLINf4rtudXZjSpjOnD0UUFKa4u2j1iSRsON7HHVAkN
         Kk7GzK8ih9i4pmPi3zNAtHw6t6jZ0T7epbY7sa57LbEggSrF2FyIWQyEz3eeqVnR42d7
         BzPktEUcDpmEuXGYHsghxMwAzR944tzpQHcNz/0Z3O/LQ0Cqq4w3pPPxVOmKnAqDOoR6
         AZNNUdYbtLu75/Ue0dclkbQrTMLbef/fIHq+GH+C4IKRoFceeRV0r76pIncYE4v1sMTY
         n8UCTm+WOG3jb/Dbk6r5SMSutfhTqibAesIMUaOWmI5BNcLZRtA7xtaqBWflekZI9uwh
         vsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971064; x=1719575864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkNsc81pvogY8LbTicFd/ENZaZm51YQcpZbMFUuPyPE=;
        b=kRqCViiK9ji2cuCGDRQkasE7sVQluKkfR27D4oC01BVdnPfhN5noH7Dto147aJ4t2p
         7vfypMon0SLDmh5cE7RXeRb/M3634pvSigNRnaiUSAK7Nh+2Wyb2bJIWqgzDSV/V3Ruq
         W9qEi8W/qNqh6CHNO+r9zB33i90XaYyGrWgOBLyyT+IVOoKCO43jUC3wWKfxbgInRfb/
         SVc4ZTgyr6XunCbFL3kpjwqIfVVdAo8+hlFsvWvsT24jG+ebxllIn6Wwe8eil0skYPxu
         JMfO3/eGy6raPdiTYmB5ItyRYR5kpPWwQfWYzQzB9g9eo83LwfLID1Cj+ferVCJ2cR0x
         /waw==
X-Gm-Message-State: AOJu0YzLgKGm9VXrvayPDamaHrMSJMG+bn7MOhjaixri7Y/51TK/A6zb
	6P8EnaRA4B7LtQDptvKd67hPnAFmogrU89egzLt94jL94J7t1jBV4pm+XA==
X-Google-Smtp-Source: AGHT+IGI0854vK911Vp33pBNJJ7EPMLXQk6V6VmsMUZMpXhhw5q+9gMtFTYJuPQ7kPseJGaD7fJjAA==
X-Received: by 2002:a17:902:ce88:b0:1f6:1a86:37ba with SMTP id d9443c01a7336-1f9a8d35971mr123143815ad.2.1718971063876;
        Fri, 21 Jun 2024 04:57:43 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:57:43 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/11] t: move reftable/record_test.c to the unit testing framework
Date: Fri, 21 Jun 2024 17:20:56 +0530
Message-ID: <20240621115708.3626-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621115708.3626-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/record_test.c exercises the functions defined in
reftable/record.{c, h}. Migrate reftable/record_test.c to the
unit testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework.
While at it, change the type of index variable 'i' to 'size_t'
from 'int'. This is because 'i' is used in comparison against
'ARRAY_SIZE(x)' which is of type 'size_t'.

Also, use set_hash() which is defined locally in the test file
instead of set_test_hash() which is defined by
reftable/test_framework.{c, h}. This is fine to do as both these
functions are similarly implemented, and
reftable/test_framework.{c, h} is not #included in the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |   2 +-
 t/helper/test-reftable.c                      |   1 -
 .../unit-tests/t-reftable-record.c            | 106 ++++++++----------
 3 files changed, 50 insertions(+), 59 deletions(-)
 rename reftable/record_test.c => t/unit-tests/t-reftable-record.c (77%)

diff --git a/Makefile b/Makefile
index f25b2e80a1..def3700b4d 100644
--- a/Makefile
+++ b/Makefile
@@ -1338,6 +1338,7 @@ UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
+UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-strvec
@@ -2678,7 +2679,6 @@ REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
-REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9160bc5da6..aa6538a8da 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -5,7 +5,6 @@
 int cmd__reftable(int argc, const char **argv)
 {
 	/* test from simple to complex. */
-	record_test_main(argc, argv);
 	block_test_main(argc, argv);
 	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
diff --git a/reftable/record_test.c b/t/unit-tests/t-reftable-record.c
similarity index 77%
rename from reftable/record_test.c
rename to t/unit-tests/t-reftable-record.c
index 58290bdba3..1b357e6c7f 100644
--- a/reftable/record_test.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -6,13 +6,9 @@
   https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "record.h"
-
-#include "system.h"
-#include "basics.h"
-#include "constants.h"
-#include "test_framework.h"
-#include "reftable-tests.h"
+#include "test-lib.h"
+#include "reftable/constants.h"
+#include "reftable/record.h"
 
 static void test_copy(struct reftable_record *rec)
 {
@@ -24,9 +20,9 @@ static void test_copy(struct reftable_record *rec)
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
-	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
+	check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
 
-	puts("testing print coverage:\n");
+	test_msg("testing print coverage:");
 	reftable_record_print(&copy, GIT_SHA1_RAWSZ);
 
 	reftable_record_release(&copy);
@@ -43,8 +39,8 @@ static void test_varint_roundtrip(void)
 			      4096,
 			      ((uint64_t)1 << 63),
 			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
-	int i = 0;
-	for (i = 0; i < ARRAY_SIZE(inputs); i++) {
+
+	for (size_t i = 0; i < ARRAY_SIZE(inputs); i++) {
 		uint8_t dest[10];
 
 		struct string_view out = {
@@ -55,29 +51,26 @@ static void test_varint_roundtrip(void)
 		int n = put_var_int(&out, in);
 		uint64_t got = 0;
 
-		EXPECT(n > 0);
+		check_int(n, >, 0);
 		out.len = n;
 		n = get_var_int(&got, &out);
-		EXPECT(n > 0);
+		check_int(n, >, 0);
 
-		EXPECT(got == in);
+		check_int(got, ==, in);
 	}
 }
 
 static void set_hash(uint8_t *h, int j)
 {
-	int i = 0;
-	for (i = 0; i < hash_size(GIT_SHA1_FORMAT_ID); i++) {
+	for (int i = 0; i < hash_size(GIT_SHA1_FORMAT_ID); i++)
 		h[i] = (j >> i) & 0xff;
-	}
 }
 
 static void test_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
-	int i = 0;
 
-	for (i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
+	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_REF,
 		};
@@ -109,17 +102,17 @@ static void test_reftable_ref_record_roundtrip(void)
 
 		test_copy(&in);
 
-		EXPECT(reftable_record_val_type(&in) == i);
+		check_int(reftable_record_val_type(&in), ==, i);
 
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
-		EXPECT(n > 0);
+		check_int(n, >, 0);
 
 		/* decode into a non-zero reftable_record to test for leaks. */
 		m = reftable_record_decode(&out, key, i, dest, GIT_SHA1_RAWSZ, &scratch);
-		EXPECT(n == m);
+		check_int(n, ==, m);
 
-		EXPECT(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
+		check(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
 						 GIT_SHA1_RAWSZ));
 		reftable_record_release(&in);
 
@@ -143,16 +136,15 @@ static void test_reftable_log_record_equal(void)
 		}
 	};
 
-	EXPECT(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
 	in[1].update_index = in[0].update_index;
-	EXPECT(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
 	reftable_log_record_release(&in[0]);
 	reftable_log_record_release(&in[1]);
 }
 
 static void test_reftable_log_record_roundtrip(void)
 {
-	int i;
 	struct reftable_log_record in[] = {
 		{
 			.refname = xstrdup("refs/heads/master"),
@@ -180,12 +172,12 @@ static void test_reftable_log_record_roundtrip(void)
 		}
 	};
 	struct strbuf scratch = STRBUF_INIT;
+	set_hash(in[0].value.update.new_hash, 1);
+	set_hash(in[0].value.update.old_hash, 2);
+	set_hash(in[2].value.update.new_hash, 3);
+	set_hash(in[2].value.update.old_hash, 4);
 
-	set_test_hash(in[0].value.update.new_hash, 1);
-	set_test_hash(in[0].value.update.old_hash, 2);
-	set_test_hash(in[2].value.update.new_hash, 3);
-	set_test_hash(in[2].value.update.old_hash, 4);
-	for (i = 0; i < ARRAY_SIZE(in); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
 		struct strbuf key = STRBUF_INIT;
 		uint8_t buffer[1024] = { 0 };
@@ -217,13 +209,13 @@ static void test_reftable_log_record_roundtrip(void)
 		reftable_record_key(&rec, &key);
 
 		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
-		EXPECT(n >= 0);
+		check_int(n, >=, 0);
 		valtype = reftable_record_val_type(&rec);
 		m = reftable_record_decode(&out, key, valtype, dest,
 					   GIT_SHA1_RAWSZ, &scratch);
-		EXPECT(n == m);
+		check_int(n, ==, m);
 
-		EXPECT(reftable_log_record_equal(&in[i], &out.u.log,
+		check(reftable_log_record_equal(&in[i], &out.u.log,
 						 GIT_SHA1_RAWSZ));
 		reftable_log_record_release(&in[i]);
 		strbuf_release(&key);
@@ -252,14 +244,14 @@ static void test_key_roundtrip(void)
 	strbuf_addstr(&key, "refs/tags/bla");
 	extra = 6;
 	n = reftable_encode_key(&restart, dest, last_key, key, extra);
-	EXPECT(!restart);
-	EXPECT(n > 0);
+	check(!restart);
+	check_int(n, >, 0);
 
 	strbuf_addstr(&roundtrip, "refs/heads/master");
 	m = reftable_decode_key(&roundtrip, &rt_extra, dest);
-	EXPECT(n == m);
-	EXPECT(0 == strbuf_cmp(&key, &roundtrip));
-	EXPECT(rt_extra == extra);
+	check_int(n, ==, m);
+	check(!strbuf_cmp(&key, &roundtrip));
+	check_int(rt_extra, ==, extra);
 
 	strbuf_release(&last_key);
 	strbuf_release(&key);
@@ -289,9 +281,8 @@ static void test_reftable_obj_record_roundtrip(void)
 		},
 	};
 	struct strbuf scratch = STRBUF_INIT;
-	int i = 0;
 
-	for (i = 0; i < ARRAY_SIZE(recs); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(recs); i++) {
 		uint8_t buffer[1024] = { 0 };
 		struct string_view dest = {
 			.buf = buffer,
@@ -311,13 +302,13 @@ static void test_reftable_obj_record_roundtrip(void)
 		test_copy(&in);
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
-		EXPECT(n > 0);
+		check_int(n, >, 0);
 		extra = reftable_record_val_type(&in);
 		m = reftable_record_decode(&out, key, extra, dest,
 					   GIT_SHA1_RAWSZ, &scratch);
-		EXPECT(n == m);
+		check_int(n, ==, m);
 
-		EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
 		strbuf_release(&key);
 		reftable_record_release(&out);
 	}
@@ -352,16 +343,16 @@ static void test_reftable_index_record_roundtrip(void)
 	reftable_record_key(&in, &key);
 	test_copy(&in);
 
-	EXPECT(0 == strbuf_cmp(&key, &in.u.idx.last_key));
+	check(!strbuf_cmp(&key, &in.u.idx.last_key));
 	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
-	EXPECT(n > 0);
+	check_int(n, >, 0);
 
 	extra = reftable_record_val_type(&in);
 	m = reftable_record_decode(&out, key, extra, dest, GIT_SHA1_RAWSZ,
 				   &scratch);
-	EXPECT(m == n);
+	check_int(m, ==, n);
 
-	EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
+	check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
 
 	reftable_record_release(&out);
 	strbuf_release(&key);
@@ -369,14 +360,15 @@ static void test_reftable_index_record_roundtrip(void)
 	strbuf_release(&in.u.idx.last_key);
 }
 
-int record_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_reftable_log_record_equal);
-	RUN_TEST(test_reftable_log_record_roundtrip);
-	RUN_TEST(test_reftable_ref_record_roundtrip);
-	RUN_TEST(test_varint_roundtrip);
-	RUN_TEST(test_key_roundtrip);
-	RUN_TEST(test_reftable_obj_record_roundtrip);
-	RUN_TEST(test_reftable_index_record_roundtrip);
-	return 0;
+	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
+	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
+	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
+	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
+	TEST(test_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
+	TEST(test_reftable_obj_record_roundtrip(), "record operations work on obj record");
+	TEST(test_reftable_index_record_roundtrip(), "record operations work on index record");
+
+	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

