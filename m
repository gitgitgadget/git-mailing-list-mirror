Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A44372
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906587; cv=none; b=tdxoN18byINM9NbLI2iDsl97L05SQLGgjDxUSTxMxLw5nQ8+I+Q/pdw55aqnTQOjo3bKx7xnug4I98LykCZ/Rwi1Ob+Ri9ppDkfRIN97p/LMarja8gReDp7wITL92CcOAIZYnqTpgvF8BZeDYyjkj0NQYmqIKFUHlr+dVMUTvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906587; c=relaxed/simple;
	bh=VXCWbeiCCoefQu0q2nmRqyFjKs1quAyIAr5aLF3k41s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBUDpO7EsZzBcvls+ehaffd3jPtw2KBkLssRmQ1+RoQSt6JQMiaTZbhBlekj5gZ2R5+cS8sOMw6lSSi6BxT2CKgzWyT4i/GRKcmNnMSP2kc2kxQCrJGqJJCVw2s1KKb6gJ4ukqHgZpnO9XIokjXLUHxyNM8lt5/UCw054bBwuMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKkjsR4F; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKkjsR4F"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-701eea2095eso2282542a34.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906584; x=1720511384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STMmRfRGoeqyn5QIqse7yydo3Sk24pkDDI1BQ45TBx8=;
        b=ZKkjsR4F8kC8823LrXp3YzxhyixuDwRlv1+rapxNvFblNcsvx0mEZiCvjZkIZjLEa0
         CDzTBZQNVZuo2YhuRas3NXItBd1fYNa20Hf4fYpYT1MSNfP6K7aPqE43tHHv8R4rC9vW
         qBKU+M5Zcz6gP/I5GdaoJVclFZw4b97N34V+DZYtJxP3pP7EZYdDgOSa4jUHxUT/AvVq
         qswwYE5XMBnEwOqPV+DqevFaYBBrEj8IdoZFQN9+dEq3xJfAWGwwXgtS6TSvlI69rBRE
         kQtWn8XiPRM67S9gzVW7PWZhBofwAacAOELN2pfSYZJvN6P8/vjbkqnuIZTrhIYW4u9x
         4vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906584; x=1720511384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STMmRfRGoeqyn5QIqse7yydo3Sk24pkDDI1BQ45TBx8=;
        b=CjkQZ4ZlbJS5lfgtd6C42lRCsrxHlfisRSEggXWzDjmB/TKNGv3Eut3iWiSpaaVMD+
         a4UJK0RVidAghZvUcSZ2Vm8ID2G8GzObuQ+q3+Hu+9TQcRL9J2yO7Ttn+vA5wsCim9R/
         8XvRMykIwJsSqJuKpS8IKAszRpC35JerbMTNQB8TtitUR/3hqC2G+Xb8y1tf+1K4Xv3i
         f8zpJEJ7GPCf4n/8KnG3lXlWVSoMQuQ+BpI4tIrvZ1Lmlu5HY3G0BZtRFwCTmZz6mFyg
         JHNgu4iY4xG/8UxfY6DCYh90JLmouRpb7+lPcd7QhEMVAa7eK7oDR0HxA2Lo+XwM4/Cl
         Tz9w==
X-Gm-Message-State: AOJu0YxZojuSpXWe4gi6Q2G6AhZbusc+PGz0US34VxyS/DIZp1r3+yg5
	Tdi2x5+tr+Vsp2HaQnR939d/UqZSkx93AE1KvGkM05K32BxROiEdyzBzv/VuMX4=
X-Google-Smtp-Source: AGHT+IG1GFm56a2fBK2EcVbcTY58jPphEQ1YuOhzIDXNeTfCrlFqCDfKKbyf0F/S5pCmIJ/D3Zj9AQ==
X-Received: by 2002:a05:6830:90:b0:702:65e:12ec with SMTP id 46e09a7af769-702075f4b98mr9125181a34.9.1719906584005;
        Tue, 02 Jul 2024 00:49:44 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:49:43 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 01/11] t: move reftable/record_test.c to the unit testing framework
Date: Tue,  2 Jul 2024 12:52:14 +0530
Message-ID: <20240702074906.5587-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240702074906.5587-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
 <20240702074906.5587-1-chandrapratap3519@gmail.com>
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
framework, and renaming the tests to fit unit-tests' naming scheme.

While at it, change the type of index variable 'i' to 'size_t'
from 'int'. This is because 'i' is used in comparison against
'ARRAY_SIZE(x)' which is of type 'size_t'.

Also, use set_hash() which is defined locally in the test file
instead of set_test_hash() which is defined by
reftable/test_framework.{c, h}. This is fine to do as both these
functions are similarly implemented, and
reftable/test_framework.{c, h} is not #included in the ported test.

Get rid of reftable_record_print() from the tests as well, because
it clutters the test framework's output and we have no way of
verifying the output.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |   2 +-
 t/helper/test-reftable.c                      |   1 -
 .../unit-tests/t-reftable-record.c            | 131 ++++++++----------
 3 files changed, 61 insertions(+), 73 deletions(-)
 rename reftable/record_test.c => t/unit-tests/t-reftable-record.c (72%)

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
similarity index 72%
rename from reftable/record_test.c
rename to t/unit-tests/t-reftable-record.c
index 58290bdba3..e799464c36 100644
--- a/reftable/record_test.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -6,15 +6,11 @@
   https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "record.h"
+#include "test-lib.h"
+#include "reftable/constants.h"
+#include "reftable/record.h"
 
-#include "system.h"
-#include "basics.h"
-#include "constants.h"
-#include "test_framework.h"
-#include "reftable-tests.h"
-
-static void test_copy(struct reftable_record *rec)
+static void t_copy(struct reftable_record *rec)
 {
 	struct reftable_record copy;
 	uint8_t typ;
@@ -24,15 +20,12 @@ static void test_copy(struct reftable_record *rec)
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
-	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
-
-	puts("testing print coverage:\n");
-	reftable_record_print(&copy, GIT_SHA1_RAWSZ);
+	check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
 
 	reftable_record_release(&copy);
 }
 
-static void test_varint_roundtrip(void)
+static void t_varint_roundtrip(void)
 {
 	uint64_t inputs[] = { 0,
 			      1,
@@ -43,8 +36,8 @@ static void test_varint_roundtrip(void)
 			      4096,
 			      ((uint64_t)1 << 63),
 			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
-	int i = 0;
-	for (i = 0; i < ARRAY_SIZE(inputs); i++) {
+
+	for (size_t i = 0; i < ARRAY_SIZE(inputs); i++) {
 		uint8_t dest[10];
 
 		struct string_view out = {
@@ -55,29 +48,26 @@ static void test_varint_roundtrip(void)
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
 
-static void test_reftable_ref_record_roundtrip(void)
+static void t_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
-	int i = 0;
 
-	for (i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
+	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_REF,
 		};
@@ -107,19 +97,19 @@ static void test_reftable_ref_record_roundtrip(void)
 		}
 		in.u.ref.refname = xstrdup("refs/heads/master");
 
-		test_copy(&in);
+		t_copy(&in);
 
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
 
@@ -130,7 +120,7 @@ static void test_reftable_ref_record_roundtrip(void)
 	strbuf_release(&scratch);
 }
 
-static void test_reftable_log_record_equal(void)
+static void t_reftable_log_record_equal(void)
 {
 	struct reftable_log_record in[2] = {
 		{
@@ -143,16 +133,15 @@ static void test_reftable_log_record_equal(void)
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
 
-static void test_reftable_log_record_roundtrip(void)
+static void t_reftable_log_record_roundtrip(void)
 {
-	int i;
 	struct reftable_log_record in[] = {
 		{
 			.refname = xstrdup("refs/heads/master"),
@@ -180,12 +169,12 @@ static void test_reftable_log_record_roundtrip(void)
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
@@ -212,18 +201,18 @@ static void test_reftable_log_record_roundtrip(void)
 
 		rec.u.log = in[i];
 
-		test_copy(&rec);
+		t_copy(&rec);
 
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
@@ -233,7 +222,7 @@ static void test_reftable_log_record_roundtrip(void)
 	strbuf_release(&scratch);
 }
 
-static void test_key_roundtrip(void)
+static void t_key_roundtrip(void)
 {
 	uint8_t buffer[1024] = { 0 };
 	struct string_view dest = {
@@ -252,21 +241,21 @@ static void test_key_roundtrip(void)
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
 	strbuf_release(&roundtrip);
 }
 
-static void test_reftable_obj_record_roundtrip(void)
+static void t_reftable_obj_record_roundtrip(void)
 {
 	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
 	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
@@ -289,9 +278,8 @@ static void test_reftable_obj_record_roundtrip(void)
 		},
 	};
 	struct strbuf scratch = STRBUF_INIT;
-	int i = 0;
 
-	for (i = 0; i < ARRAY_SIZE(recs); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(recs); i++) {
 		uint8_t buffer[1024] = { 0 };
 		struct string_view dest = {
 			.buf = buffer,
@@ -308,16 +296,16 @@ static void test_reftable_obj_record_roundtrip(void)
 		int n, m;
 		uint8_t extra;
 
-		test_copy(&in);
+		t_copy(&in);
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
@@ -325,7 +313,7 @@ static void test_reftable_obj_record_roundtrip(void)
 	strbuf_release(&scratch);
 }
 
-static void test_reftable_index_record_roundtrip(void)
+static void t_reftable_index_record_roundtrip(void)
 {
 	struct reftable_record in = {
 		.type = BLOCK_TYPE_INDEX,
@@ -350,18 +338,18 @@ static void test_reftable_index_record_roundtrip(void)
 
 	strbuf_addstr(&in.u.idx.last_key, "refs/heads/master");
 	reftable_record_key(&in, &key);
-	test_copy(&in);
+	t_copy(&in);
 
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
@@ -369,14 +357,15 @@ static void test_reftable_index_record_roundtrip(void)
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
+	TEST(t_reftable_log_record_equal(), "reftable_log_record_equal works");
+	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
+	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
+	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
+	TEST(t_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
+	TEST(t_reftable_obj_record_roundtrip(), "record operations work on obj record");
+	TEST(t_reftable_index_record_roundtrip(), "record operations work on index record");
+
+	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

