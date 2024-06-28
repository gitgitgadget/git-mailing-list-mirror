Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FF6F2F3
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556632; cv=none; b=VuhGSXfwAxmd5OelelawyBjnEkcdqJKyh+46Kyl9/gPxYYUclcllIxH69zZ7sxd5fRvK+sGbPohjwHLEwb7WN3WfNHOONTj0zHz97myM9Gjl5dyvconJrikLn8mul1XpEZ9/GEbPiZgIevvK/FnG35gMEYqld6b5+phgzNaVZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556632; c=relaxed/simple;
	bh=rM10OPjnjPmmEnkDmTs2flSLjlbb4PWlOMbAXE5cdTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzTkqRps8ECMTcAY/j+X2IToFvaFzuXrFP8VH0zOQGYPsFS0SSoVxD004Zg2NkyAB4uuYJtGS4u6GZzmMttQu+2VZY9pM9ebzhg9NVHyYZEg9BAKlBwJlyWBtY/MSBEIN0U7qnvGxKVR78QGnz1SP/7+lb/1w9fGFoByu3N+N7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWd79IHp; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWd79IHp"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7f624e70870so25139f.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556629; x=1720161429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhwFF2AyHrTE3R8oWcTDImuVlgx5DS6vICN5X78OEis=;
        b=aWd79IHpKHiQj8SxYgVNeF7Iby3X2pMz8o9IzJR/WCDOqKHggom4w44Zqj+O/6oC/g
         JrG8hU8MK0dIaenvVzKQxTlemSNtPFYE4dcaPPQVaNe/7pby6fxns6ns7efHG3HM2QaM
         /MXe9VQ/JJnPlLy9uHbxItahTiMNpe4XTRvgg53CgrP9+8yDouVjaE6uSylvaaQx5pjl
         oFNzILG9cbrWTQOjwQCODMTlLF9+DDeIqVTOpHZ+hXq744+7f0IZ6cXot03vug1fywzy
         mV3HAUsOlXuRIjvK96afYCYp3GjpFzSedZhbpFgzS0uj3O0ZprlswxkL/+/NDTzwnSwG
         9Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556629; x=1720161429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhwFF2AyHrTE3R8oWcTDImuVlgx5DS6vICN5X78OEis=;
        b=Tgyv1YhI8d55U5OlgaH7MksJkcFuXMPZV0tmFDH8n/Cb9W+Qg0wC66rqklrcCKzYq7
         oCaVBnG32pB0XrVxmfvShnh19H/gy9qkbDbik8A9fDlAl0eNkFB4gAAc7OAJq/Sm8dPU
         5RW8yRmxhzf2qWqs5cNoJk7rbMgL4ommofH4I+mJZ2xK8PV8EpfHSo6iGyn3u1ChtoAM
         bWwM5XIwoDz7ROGSTFd3aL3AmCsUB1C0X3+a2zGGVCcXiZqAdFaTi20HQjaU6Tl4RgL4
         V8dYHfyJ0QGHghp5iUgJ2+N32Yzr6Gy4/f1+slNRXM8jtCZ7PkO2tLhrqLDNsUQuIJ2q
         FA0A==
X-Gm-Message-State: AOJu0YwkVgItwZNKxiUoyEhrhPbZN9GkmNTdfowz47jAUtIW2iIqlh8I
	5ZwVdiSyVYR7SSOTo52NRIdtdWnFUQ0RKYgBvJJLYlktC4z6Fdt34e6RnsKAPKw=
X-Google-Smtp-Source: AGHT+IFMaGO+a6jAX9ZijJ4U+GlCMd71vAvrL5lrBVEuq2SXjuQ3mI5ExaQwHnhYz0bLSi6Ki7HqXg==
X-Received: by 2002:a05:6602:6d87:b0:7e1:8bc1:57d3 with SMTP id ca18e2360f4ac-7f3a7588598mr1874636339f.19.1719556629162;
        Thu, 27 Jun 2024 23:37:09 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:08 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 01/11] t: move reftable/record_test.c to the unit testing framework
Date: Fri, 28 Jun 2024 11:49:31 +0530
Message-ID: <20240628063625.4092-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com>
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

Get rid of reftable_record_print() from the tests as well, because
it clutters the test framework's output and we have no way of
verifying the output.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |   2 +-
 t/helper/test-reftable.c                      |   1 -
 .../unit-tests/t-reftable-record.c            | 107 ++++++++----------
 3 files changed, 49 insertions(+), 61 deletions(-)
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
index 58290bdba3..9305919e1e 100644
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
@@ -24,10 +20,7 @@ static void test_copy(struct reftable_record *rec)
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
 
 static void test_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
-	int i = 0;
 
-	for (i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
+	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_REF,
 		};
@@ -109,17 +99,17 @@ static void test_reftable_ref_record_roundtrip(void)
 
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
 
 static void test_reftable_log_record_roundtrip(void)
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
@@ -217,13 +206,13 @@ static void test_reftable_log_record_roundtrip(void)
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
@@ -252,14 +241,14 @@ static void test_key_roundtrip(void)
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
@@ -311,13 +299,13 @@ static void test_reftable_obj_record_roundtrip(void)
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
@@ -352,16 +340,16 @@ static void test_reftable_index_record_roundtrip(void)
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

