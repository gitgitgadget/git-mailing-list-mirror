Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529E212D8A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867260; cv=none; b=frwzpxzJV3BP+lZji/0Gc86+zLWG4U03rd6eW6XtSvPbQiwGUa6tAW0EEpEHNKFluIg5Fxjlw4Q44bpUNNFcZH/22nWKFpR4abP031gurg5jaHdYCDHZFi0XoocfC71Cshs++CB35qYNr6dxeyWoJvINSiKjqswAfA1bQOE6DQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867260; c=relaxed/simple;
	bh=Q5tq16SP2swEqigCsUDhR5lyCffysZp8u0sj2oKVktU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUbrc9x3G0vRZWlEf1qZlo0pjXj/AEeNPnBpGwdnqw+DBUP/LO41YUS6s2HPitdClv6jCbvzl/9FelxxZ8easwRN3tsTXQgAVfC1AJJxKjkbIyy2bl+vDnGcWCsmQTUMsSEgVKTLazBL1YpMs18XgcUpuIE9P02ZIkZUz+IynQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzEBt1b0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzEBt1b0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so46508955e9.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748867256; x=1749472056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAadhuCaF6eCAucbnteJs4ylO5GAu43QlyUYc7TfMjc=;
        b=OzEBt1b0/RKkGuhlVb99S8H75UQYEUyVlvF+QvuXHlxmnONJfFClWOTn6+ukWklLaD
         sN7U6COuiYmSpHgKposYpQnbti9we7Kunji7nTVsgOHZQ9/gTP5XdWRnmZELhNjFkwa+
         Z5/I1p7hSAh6s+tE+MrbxRP+Z22uZ5hp5EkB7UWSQXUUDgJLB2/2N/w/fO5dRNs+aNJf
         +lGcKZHObp1eFM7QB4M8GHBpNekKy258BN10flo2KA8C9xEQPqY0aJe9lX759uBinnA1
         xM1LppGnGgS4V2Bj3iqelhuUfpblg8Q8MBWBz3DK2dgQFOV/p+gSEIKirN9zaM+Sq0gk
         MNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748867256; x=1749472056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAadhuCaF6eCAucbnteJs4ylO5GAu43QlyUYc7TfMjc=;
        b=cmTRj9mRM/sSpUetY8WAsyJ2Jc91t97ti7+6Go5jR9aRbGgzEZlNn5y0a6uMD34yoi
         x6xOSl3pbfmIqspjksK2PJEIQYWk6VWzSGUWPwbJkKvaHpLZeRCHKKinuQk/MjZNsH8Q
         8Mtsle8jhyO30TRM78t4bJR0hsW8lpUUbk+epDgDdFyUsYZrJoK8W6uWdrelhwY1xxLV
         8WOsGKA8gzOSlKtZ5EhAaqbSEZ3nSp/vcQ4ncmssGyKfX7Vo04hKaPnuZTd36XTPNf/z
         TKMWm/vD2TTLGRgU9aWGd2q9JEju9onwNeOH2wLHTw7CF8KchU0l0XbmTMA+YeiTpaa6
         /yUg==
X-Gm-Message-State: AOJu0YzT8JePgO1NrcPBaArCn+gAeFrljUP35g5UmpyzgPiqiW0gT7mE
	RfcFoefUucI0YMwR4Smaax1gpZibm+FXehMUdNlrTG8O82goSlXcBYq1nQ+A+kPDh6o=
X-Gm-Gg: ASbGnct6Na42Sajkz9WoJahAxdso0felrLZ/CePx8FcZ3TAVJvhWzvCsAqlqAze3cjV
	ZI/28xNUlaVh5XS9OnmJllYVbrrp7Rskc6ST4QfSobz3JHpjKYbjWcanZvX7rKtFsWUmAUAvQsk
	co4u2U/k9EHw4mr6AuOs+cFYKMRagEHWtLL6xBHlNJtSTWUyBLB3ae/mvUnAnnPxxKpgHFOpKeX
	hO2LzJx9drNydhpB77JYeLeqke8fpHrOGIvTBaptNWrmRXTwgU8m/WK6+6i0tZO6mYdB14OxtIc
	3tyg1wTmBrj2NoXfHHLdH+5SIXARTD+3wcioW7nBla5Y84aDQH9e0OAqNREsxLjPkUFrPDkbCth
	KAxWCVxMXqew=
X-Google-Smtp-Source: AGHT+IHBByJ6ZNyN/HlVzYpBJSJ4heRv165tc9Wsuw5gvmizUQSGBgAIO4QCYa5MPumjqud0OK5aUQ==
X-Received: by 2002:a5d:64ed:0:b0:3a4:f51c:21a9 with SMTP id ffacd0b85a97d-3a4f7ab12a5mr9963540f8f.52.1748867255824;
        Mon, 02 Jun 2025 05:27:35 -0700 (PDT)
Received: from localhost.localdomain ([105.113.90.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451d30a227csm51034145e9.0.2025.06.02.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:27:35 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 08/10] t/unit-tests: convert reftable record test to use clar
Date: Mon,  2 Jun 2025 13:25:56 +0100
Message-ID: <20250602122559.208780-9-kuforiji98@gmail.com>
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

Adapt reftable record test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                      |   1 -
 t/meson.build                                 |   1 -
 ...-reftable-record.c => u-reftable-record.c} | 217 ++++++++----------
 3 files changed, 99 insertions(+), 120 deletions(-)
 rename t/unit-tests/{t-reftable-record.c => u-reftable-record.c} (63%)

diff --git a/Makefile b/Makefile
index d86ef5a142..3b41342ddb 100644
--- a/Makefile
+++ b/Makefile
@@ -1383,7 +1383,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
 
-UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/meson.build b/t/meson.build
index 5189176472..297937f307 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -61,7 +61,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
 ]
 
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/u-reftable-record.c
similarity index 63%
rename from t/unit-tests/t-reftable-record.c
rename to t/unit-tests/u-reftable-record.c
index 553a007664..137a7ab815 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/u-reftable-record.c
@@ -6,7 +6,8 @@
   https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "test-lib.h"
+#include "unit-test.h"
+#include "lib-reftable-clar.h"
 #include "reftable/basics.h"
 #include "reftable/constants.h"
 #include "reftable/record.h"
@@ -17,16 +18,16 @@ static void t_copy(struct reftable_record *rec)
 	uint8_t typ;
 
 	typ = reftable_record_type(rec);
-	check(!reftable_record_init(&copy, typ));
+	cl_assert(reftable_record_init(&copy, typ) == 0);
 	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
-	check(reftable_record_equal(rec, &copy, REFTABLE_HASH_SIZE_SHA1));
+	cl_assert(reftable_record_equal(rec, &copy, REFTABLE_HASH_SIZE_SHA1) != 0);
 
 	reftable_record_release(&copy);
 }
 
-static void t_varint_roundtrip(void)
+void test_reftable_record__varint_roundtrip(void)
 {
 	uint64_t inputs[] = { 0,
 			      1,
@@ -49,16 +50,16 @@ static void t_varint_roundtrip(void)
 		int n = put_var_int(&out, in);
 		uint64_t got = 0;
 
-		check_int(n, >, 0);
+		cl_assert(n > 0);
 		out.len = n;
 		n = get_var_int(&got, &out);
-		check_int(n, >, 0);
+		cl_assert(n > 0);
 
-		check_int(got, ==, in);
+		cl_assert_equal_i(got, in);
 	}
 }
 
-static void t_varint_overflow(void)
+void test_reftable_record__varint_overflow(void)
 {
 	unsigned char buf[] = {
 		0xFF, 0xFF, 0xFF, 0xFF,
@@ -70,8 +71,7 @@ static void t_varint_overflow(void)
 		.len = sizeof(buf),
 	};
 	uint64_t value;
-	int err = get_var_int(&value, &view);
-	check_int(err, ==, -1);
+	cl_assert_equal_i(get_var_int(&value, &view), -1);
 }
 
 static void set_hash(uint8_t *h, int j)
@@ -80,7 +80,7 @@ static void set_hash(uint8_t *h, int j)
 		h[i] = (j >> i) & 0xff;
 }
 
-static void t_reftable_ref_record_comparison(void)
+void test_reftable_record__ref_record_comparison(void)
 {
 	struct reftable_record in[3] = {
 		{
@@ -102,21 +102,21 @@ static void t_reftable_ref_record_comparison(void)
 	};
 	int cmp;
 
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
 
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
+	cl_assert(cmp > 0);
 
 	in[1].u.ref.value_type = in[0].u.ref.value_type;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
 }
 
-static void t_reftable_ref_record_compare_name(void)
+void test_reftable_record__ref_record_compare_name(void)
 {
 	struct reftable_ref_record recs[3] = {
 		{
@@ -130,12 +130,12 @@ static void t_reftable_ref_record_compare_name(void)
 		},
 	};
 
-	check_int(reftable_ref_record_compare_name(&recs[0], &recs[1]), <, 0);
-	check_int(reftable_ref_record_compare_name(&recs[1], &recs[0]), >, 0);
-	check_int(reftable_ref_record_compare_name(&recs[0], &recs[2]), ==, 0);
+	cl_assert(reftable_ref_record_compare_name(&recs[0], &recs[1]) < 0);
+	cl_assert(reftable_ref_record_compare_name(&recs[1], &recs[0]) > 0);
+	cl_assert_equal_i(reftable_ref_record_compare_name(&recs[0], &recs[2]), 0);
 }
 
-static void t_reftable_ref_record_roundtrip(void)
+void test_reftable_record__ref_record_roundtrip(void)
 {
 	struct reftable_buf scratch = REFTABLE_BUF_INIT;
 
@@ -172,19 +172,19 @@ static void t_reftable_ref_record_roundtrip(void)
 
 		t_copy(&in);
 
-		check_int(reftable_record_val_type(&in), ==, i);
-		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
+		cl_assert_equal_i(reftable_record_val_type(&in), i);
+		cl_assert_equal_i(reftable_record_is_deletion(&in),  i == REFTABLE_REF_DELETION);
 
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
-		check_int(n, >, 0);
+		cl_assert(n > 0);
 
 		/* decode into a non-zero reftable_record to test for leaks. */
 		m = reftable_record_decode(&out, key, i, dest, REFTABLE_HASH_SIZE_SHA1, &scratch);
-		check_int(n, ==, m);
+		cl_assert_equal_i(n, m);
 
-		check(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
-						 REFTABLE_HASH_SIZE_SHA1));
+		cl_assert(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
+											REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_record_release(&in);
 
 		reftable_buf_release(&key);
@@ -194,7 +194,7 @@ static void t_reftable_ref_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
-static void t_reftable_log_record_comparison(void)
+void test_reftable_record__log_record_comparison(void)
 {
 	struct reftable_record in[3] = {
 		{
@@ -215,21 +215,21 @@ static void t_reftable_log_record_comparison(void)
 	};
 	int cmp;
 
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
+	cl_assert(cmp > 0);
 	/* comparison should be reversed for equal keys, because
 	 * comparison is now performed on the basis of update indices */
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check_int(cmp, <, 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp < 0);
 
 	in[1].u.log.update_index = in[0].u.log.update_index;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
 }
 
-static void t_reftable_log_record_compare_key(void)
+void test_reftable_record__log_record_compare_key(void)
 {
 	struct reftable_log_record logs[3] = {
 		{
@@ -246,19 +246,19 @@ static void t_reftable_log_record_compare_key(void)
 		},
 	};
 
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
-	check_int(reftable_log_record_compare_key(&logs[1], &logs[0]), >, 0);
+	cl_assert(reftable_log_record_compare_key(&logs[0], &logs[1]) < 0);
+	cl_assert(reftable_log_record_compare_key(&logs[1], &logs[0]) > 0);
 
 	logs[1].update_index = logs[0].update_index;
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
+	cl_assert(reftable_log_record_compare_key(&logs[0], &logs[1]) < 0);
 
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), >, 0);
-	check_int(reftable_log_record_compare_key(&logs[2], &logs[0]), <, 0);
+	cl_assert(reftable_log_record_compare_key(&logs[0], &logs[2]) > 0);
+	cl_assert(reftable_log_record_compare_key(&logs[2], &logs[0]) < 0);
 	logs[2].update_index = logs[0].update_index;
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), ==, 0);
+	cl_assert_equal_i(reftable_log_record_compare_key(&logs[0], &logs[2]), 0);
 }
 
-static void t_reftable_log_record_roundtrip(void)
+void test_reftable_record__log_record_roundtrip(void)
 {
 	struct reftable_log_record in[] = {
 		{
@@ -292,9 +292,9 @@ static void t_reftable_log_record_roundtrip(void)
 	set_hash(in[2].value.update.new_hash, 3);
 	set_hash(in[2].value.update.old_hash, 4);
 
-	check(!reftable_log_record_is_deletion(&in[0]));
-	check(reftable_log_record_is_deletion(&in[1]));
-	check(!reftable_log_record_is_deletion(&in[2]));
+	cl_assert(reftable_log_record_is_deletion(&in[0]) == 0);
+	cl_assert(reftable_log_record_is_deletion(&in[1]) != 0);
+	cl_assert(reftable_log_record_is_deletion(&in[2]) == 0);
 
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = REFTABLE_BLOCK_TYPE_LOG };
@@ -328,14 +328,14 @@ static void t_reftable_log_record_roundtrip(void)
 		reftable_record_key(&rec, &key);
 
 		n = reftable_record_encode(&rec, dest, REFTABLE_HASH_SIZE_SHA1);
-		check_int(n, >=, 0);
+		cl_assert(n >= 0);
 		valtype = reftable_record_val_type(&rec);
 		m = reftable_record_decode(&out, key, valtype, dest,
 					   REFTABLE_HASH_SIZE_SHA1, &scratch);
-		check_int(n, ==, m);
+		cl_assert_equal_i(n, m);
 
-		check(reftable_log_record_equal(&in[i], &out.u.log,
-						 REFTABLE_HASH_SIZE_SHA1));
+		cl_assert(reftable_log_record_equal(&in[i], &out.u.log,
+											REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_log_record_release(&in[i]);
 		reftable_buf_release(&key);
 		reftable_record_release(&out);
@@ -344,7 +344,7 @@ static void t_reftable_log_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
-static void t_key_roundtrip(void)
+void test_reftable_record__key_roundtrip(void)
 {
 	uint8_t buffer[1024] = { 0 };
 	struct string_view dest = {
@@ -359,25 +359,25 @@ static void t_key_roundtrip(void)
 	int n, m;
 	uint8_t rt_extra;
 
-	check(!reftable_buf_addstr(&last_key, "refs/heads/master"));
-	check(!reftable_buf_addstr(&key, "refs/tags/bla"));
+	cl_assert(reftable_buf_addstr(&last_key, "refs/heads/master") == 0);
+	cl_assert(reftable_buf_addstr(&key, "refs/tags/bla") == 0);
 	extra = 6;
 	n = reftable_encode_key(&restart, dest, last_key, key, extra);
-	check(!restart);
-	check_int(n, >, 0);
+	cl_assert(restart == 0);
+	cl_assert(n > 0);
 
-	check(!reftable_buf_addstr(&roundtrip, "refs/heads/master"));
+	cl_assert(reftable_buf_addstr(&roundtrip, "refs/heads/master") == 0);
 	m = reftable_decode_key(&roundtrip, &rt_extra, dest);
-	check_int(n, ==, m);
-	check(!reftable_buf_cmp(&key, &roundtrip));
-	check_int(rt_extra, ==, extra);
+	cl_assert_equal_i(n, m);
+	cl_assert(reftable_buf_cmp(&key, &roundtrip) == 0);
+	cl_assert_equal_i(rt_extra, extra);
 
 	reftable_buf_release(&last_key);
 	reftable_buf_release(&key);
 	reftable_buf_release(&roundtrip);
 }
 
-static void t_reftable_obj_record_comparison(void)
+void test_reftable_record__obj_record_comparison(void)
 {
 
 	uint8_t id_bytes[] = { 0, 1, 2, 3, 4, 5, 6 };
@@ -405,21 +405,21 @@ static void t_reftable_obj_record_comparison(void)
 	};
 	int cmp;
 
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
 
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
+	cl_assert(cmp > 0);
 
 	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
 }
 
-static void t_reftable_obj_record_roundtrip(void)
+void test_reftable_record__obj_record_roundtrip(void)
 {
 	uint8_t testHash1[REFTABLE_HASH_SIZE_SHA1] = { 1, 2, 3, 4, 0 };
 	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
@@ -460,17 +460,17 @@ static void t_reftable_obj_record_roundtrip(void)
 		int n, m;
 		uint8_t extra;
 
-		check(!reftable_record_is_deletion(&in));
+		cl_assert(reftable_record_is_deletion(&in) == 0);
 		t_copy(&in);
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
-		check_int(n, >, 0);
+		cl_assert(n > 0);
 		extra = reftable_record_val_type(&in);
 		m = reftable_record_decode(&out, key, extra, dest,
 					   REFTABLE_HASH_SIZE_SHA1, &scratch);
-		check_int(n, ==, m);
+		cl_assert_equal_i(n, m);
 
-		check(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_buf_release(&key);
 		reftable_record_release(&out);
 	}
@@ -478,7 +478,7 @@ static void t_reftable_obj_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
-static void t_reftable_index_record_comparison(void)
+void test_reftable_record__index_record_comparison(void)
 {
 	struct reftable_record in[3] = {
 		{
@@ -499,28 +499,28 @@ static void t_reftable_index_record_comparison(void)
 	};
 	int cmp;
 
-	check(!reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master"));
-	check(!reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"));
-	check(!reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch"));
+	cl_assert(reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master") == 0);
+	cl_assert(reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master") == 0);
+	cl_assert(reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch") == 0);
 
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
 
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
+	cl_assert(cmp > 0);
 
 	in[1].u.idx.offset = in[0].u.idx.offset;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
 
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
 		reftable_record_release(&in[i]);
 }
 
-static void t_reftable_index_record_roundtrip(void)
+void test_reftable_record__index_record_roundtrip(void)
 {
 	struct reftable_record in = {
 		.type = REFTABLE_BLOCK_TYPE_INDEX,
@@ -543,43 +543,24 @@ static void t_reftable_index_record_roundtrip(void)
 	int n, m;
 	uint8_t extra;
 
-	check(!reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master"));
+	cl_assert(reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master") == 0);
 	reftable_record_key(&in, &key);
 	t_copy(&in);
 
-	check(!reftable_record_is_deletion(&in));
-	check(!reftable_buf_cmp(&key, &in.u.idx.last_key));
+	cl_assert(reftable_record_is_deletion(&in) == 0);
+	cl_assert(reftable_buf_cmp(&key, &in.u.idx.last_key) == 0);
 	n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
-	check_int(n, >, 0);
+	cl_assert(n > 0);
 
 	extra = reftable_record_val_type(&in);
 	m = reftable_record_decode(&out, key, extra, dest, REFTABLE_HASH_SIZE_SHA1,
 				   &scratch);
-	check_int(m, ==, n);
+	cl_assert_equal_i(m, n);
 
-	check(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1));
+	cl_assert(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1) != 0);
 
 	reftable_record_release(&out);
 	reftable_buf_release(&key);
 	reftable_buf_release(&scratch);
 	reftable_buf_release(&in.u.idx.last_key);
 }
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
-	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
-	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
-	TEST(t_reftable_obj_record_comparison(), "comparison operations work on obj record");
-	TEST(t_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
-	TEST(t_reftable_log_record_compare_key(), "reftable_log_record_compare_key works");
-	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
-	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
-	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
-	TEST(t_varint_overflow(), "get_var_int notices an integer overflow");
-	TEST(t_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
-	TEST(t_reftable_obj_record_roundtrip(), "record operations work on obj record");
-	TEST(t_reftable_index_record_roundtrip(), "record operations work on index record");
-
-	return test_done();
-}
-- 
2.43.0

