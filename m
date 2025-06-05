Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35657272E58
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132518; cv=none; b=feh8d3YQFK0mCTJAosTkmnztebaepno0yS60y9iqAXKVNkTrKbFZcUBE+Go5iVGKkf5T83Gkpjpo8QlIBeGxffNI4eun+b41fuYHU48kp0w8hRJTQwlkUFHC0uhd0rteVyT7Qr5ZjlAUZZAX1VAwVVFM7SIhuJ1vFEs12XMgF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132518; c=relaxed/simple;
	bh=DJFVkgeF13Fes+Okib0J6+1rRUDg8HKEJUhSQLs0Nss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8OhPWWpzIvcSqiBu7RFP5j//lH0S/2Nn3EeftqlV+r5xz00dRNUi6kobjx8InfbcxwjkriEWQatEwd3g/3OnauvM8NVaRwDq+2N0v4lcKX+9YHjGWqy+wf5/bSp7yd49tbG9hJ2A55X/MC0xjONpB3NoTb/4vBc0SrNtvQLrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CReOhe1R; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CReOhe1R"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso611259f8f.3
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749132514; x=1749737314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpSyhDaieC0V8Wfk+mqUqupjL2oWUdYYp9iFUVRWspw=;
        b=CReOhe1RNE1HxniGUONSDgJqJKSaL5gSMrDuFN3H4c9Fz+nh4tHDKNty9481cITgwM
         Bo/7zDZeodhV6431MgoNtFAcaw/QvRDgEPv/gGCtwSMa35210Kw7PHFg29uein35tDiz
         iapyAceN7yTZS4JLF6oVPDauMBrpscvY8cN5Sr1MzAu05gbiQXK80i875g1hSkivWC0u
         XjLIQHJPPMv72tJagXiTpGHJ3WtvEB5XEp9ee4DznmHVFYbImT0Zr89SXwCFqvlw2zim
         OcRqTE1fdE2heIJdTeO5AdgetL6jkyBdK5DYOPVvfFBWxKUznwa95UUmW/OVGaD+LD4E
         1zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132514; x=1749737314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpSyhDaieC0V8Wfk+mqUqupjL2oWUdYYp9iFUVRWspw=;
        b=GuHOgCkGM0+cpVtyrUhZvfaMSqwoSoyAd+4vWP0goMkvSrlwne0QsUMoLGpQcnSDkO
         FApCUPErj4JVLxhQyP3MwXPpy+sHBZcnwmcOE81z0DqsJ2EKZc5wsWGNtFZrvyGK3SBr
         FWuj34dYfT+PTKuG+P+48xryRJagtjgl6f2RCcn98TpRCuQ4Rhtw2B1z0CyEwaObNL5L
         Muk2CdyNwp7YlfeBap/tglyS5v/0cKFbEJKp/zPYPkGrzZW/PpDtX9EDNamOiXsQhEAf
         QPTyaFV5+an3Q1f7FJ83OXUJ1BYIptYHPpb11qR+VppZrjgm7OVPGLgZdgleXKPdDP21
         wGUg==
X-Gm-Message-State: AOJu0Yyz+I28FA4jPpnpdCh8mik/soOthJ691S/o+5SrYfIvcS560qjd
	BRsRHsJ+cdi9CyyTLkZ/oarpb7qUFZNITLyJ15Bd+9vY0zlzaeh7srZfnAlYZzaFvM4=
X-Gm-Gg: ASbGncvOGy637rdyqOjtBMP9Tly0kFwrPg2rOGqN3r546LKJ5Po2/FX8tu2ZLrRCFDy
	Ngpx5Cse8o69XF31Lqr+lMV/cOdKulIE2RUaO1RjCgZKqoM4e21wk/xLzEXxAmGCyFDRHdLO9wO
	vQePwGFEmlMiSlwJnMVQC9U16/FB9u/ZQOj2tq7gB1kZ+bO4V3jkh5ADdVbIHJERBHDuCw6p73A
	YG9OFeIfb01YNMyrHvpy0NwgweXt0/CNPukp41XHsjsOZk7zmXZnxYr55KMNqPLq91zKdbaAVdp
	TlktJT0X+7O7V4e59n6MWp4uA/oqusmmOlQD9ivG2RkGvg==
X-Google-Smtp-Source: AGHT+IGu//1QlN7Quqq1KbF3jciv8r0YvfyKkA+yGVLRs1scfZvH2ca9mW5ljib0bj0BYu/uq5vvrA==
X-Received: by 2002:a05:6000:310e:b0:3a3:64fb:304d with SMTP id ffacd0b85a97d-3a51d8f68c3mr5707191f8f.12.1749132513900;
        Thu, 05 Jun 2025 07:08:33 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm8827305e9.27.2025.06.05.07.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:08:33 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v4 08/10] t/unit-tests: convert reftable record test to use clar
Date: Thu,  5 Jun 2025 15:06:42 +0100
Message-ID: <20250605140644.239199-9-kuforiji98@gmail.com>
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

Adapt reftable record test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                      |   1 -
 t/meson.build                                 |   1 -
 ...-reftable-record.c => u-reftable-record.c} | 250 +++++++++---------
 3 files changed, 130 insertions(+), 122 deletions(-)
 rename t/unit-tests/{t-reftable-record.c => u-reftable-record.c} (62%)

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
similarity index 62%
rename from t/unit-tests/t-reftable-record.c
rename to t/unit-tests/u-reftable-record.c
index 553a007664..650b0aa0d3 100644
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
@@ -17,16 +18,17 @@ static void t_copy(struct reftable_record *rec)
 	uint8_t typ;
 
 	typ = reftable_record_type(rec);
-	check(!reftable_record_init(&copy, typ));
+	cl_assert_equal_i(reftable_record_init(&copy, typ), 0);
 	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
-	check(reftable_record_equal(rec, &copy, REFTABLE_HASH_SIZE_SHA1));
+	cl_assert(reftable_record_equal(rec, &copy,
+					REFTABLE_HASH_SIZE_SHA1) != 0);
 
 	reftable_record_release(&copy);
 }
 
-static void t_varint_roundtrip(void)
+void test_reftable_record__varint_roundtrip(void)
 {
 	uint64_t inputs[] = { 0,
 			      1,
@@ -49,16 +51,16 @@ static void t_varint_roundtrip(void)
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
@@ -70,8 +72,7 @@ static void t_varint_overflow(void)
 		.len = sizeof(buf),
 	};
 	uint64_t value;
-	int err = get_var_int(&value, &view);
-	check_int(err, ==, -1);
+	cl_assert_equal_i(get_var_int(&value, &view), -1);
 }
 
 static void set_hash(uint8_t *h, int j)
@@ -80,7 +81,7 @@ static void set_hash(uint8_t *h, int j)
 		h[i] = (j >> i) & 0xff;
 }
 
-static void t_reftable_ref_record_comparison(void)
+void test_reftable_record__ref_record_comparison(void)
 {
 	struct reftable_record in[3] = {
 		{
@@ -102,21 +103,23 @@ static void t_reftable_ref_record_comparison(void)
 	};
 	int cmp;
 
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
+	cl_assert(!cmp);
 
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
+	cl_assert(reftable_record_equal(&in[1], &in[2],
+					REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
+	cl_assert(cmp > 0);
 
 	in[1].u.ref.value_type = in[0].u.ref.value_type;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1],
+					REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
+	cl_assert(!cmp);
 }
 
-static void t_reftable_ref_record_compare_name(void)
+void test_reftable_record__ref_record_compare_name(void)
 {
 	struct reftable_ref_record recs[3] = {
 		{
@@ -130,12 +133,15 @@ static void t_reftable_ref_record_compare_name(void)
 		},
 	};
 
-	check_int(reftable_ref_record_compare_name(&recs[0], &recs[1]), <, 0);
-	check_int(reftable_ref_record_compare_name(&recs[1], &recs[0]), >, 0);
-	check_int(reftable_ref_record_compare_name(&recs[0], &recs[2]), ==, 0);
+	cl_assert(reftable_ref_record_compare_name(&recs[0],
+						   &recs[1]) < 0);
+	cl_assert(reftable_ref_record_compare_name(&recs[1],
+						   &recs[0]) > 0);
+	cl_assert_equal_i(reftable_ref_record_compare_name(&recs[0],
+							   &recs[2]), 0);
 }
 
-static void t_reftable_ref_record_roundtrip(void)
+void test_reftable_record__ref_record_roundtrip(void)
 {
 	struct reftable_buf scratch = REFTABLE_BUF_INIT;
 
@@ -172,19 +178,21 @@ static void t_reftable_ref_record_roundtrip(void)
 
 		t_copy(&in);
 
-		check_int(reftable_record_val_type(&in), ==, i);
-		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
+		cl_assert_equal_i(reftable_record_val_type(&in), i);
+		cl_assert_equal_i(reftable_record_is_deletion(&in),
+				  i == REFTABLE_REF_DELETION);
 
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
+		cl_assert(reftable_ref_record_equal(&in.u.ref,
+						    &out.u.ref,
+						    REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_record_release(&in);
 
 		reftable_buf_release(&key);
@@ -194,7 +202,7 @@ static void t_reftable_ref_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
-static void t_reftable_log_record_comparison(void)
+void test_reftable_record__log_record_comparison(void)
 {
 	struct reftable_record in[3] = {
 		{
@@ -215,21 +223,24 @@ static void t_reftable_log_record_comparison(void)
 	};
 	int cmp;
 
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
+	cl_assert_equal_i(reftable_record_equal(&in[0], &in[1],
+						REFTABLE_HASH_SIZE_SHA1), 0);
+	cl_assert_equal_i(reftable_record_equal(&in[1], &in[2],
+						REFTABLE_HASH_SIZE_SHA1), 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
+	cl_assert(cmp > 0);
 	/* comparison should be reversed for equal keys, because
 	 * comparison is now performed on the basis of update indices */
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check_int(cmp, <, 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
+	cl_assert(cmp < 0);
 
 	in[1].u.log.update_index = in[0].u.log.update_index;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	cl_assert(reftable_record_equal(&in[0], &in[1],
+					REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
 }
 
-static void t_reftable_log_record_compare_key(void)
+void test_reftable_record__log_record_compare_key(void)
 {
 	struct reftable_log_record logs[3] = {
 		{
@@ -246,19 +257,24 @@ static void t_reftable_log_record_compare_key(void)
 		},
 	};
 
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
-	check_int(reftable_log_record_compare_key(&logs[1], &logs[0]), >, 0);
+	cl_assert(reftable_log_record_compare_key(&logs[0],
+						  &logs[1]) < 0);
+	cl_assert(reftable_log_record_compare_key(&logs[1],
+						  &logs[0]) > 0);
 
 	logs[1].update_index = logs[0].update_index;
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
+	cl_assert(reftable_log_record_compare_key(&logs[0],
+						  &logs[1]) < 0);
 
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), >, 0);
-	check_int(reftable_log_record_compare_key(&logs[2], &logs[0]), <, 0);
+	cl_assert(reftable_log_record_compare_key(&logs[0],
+						  &logs[2]) > 0);
+	cl_assert(reftable_log_record_compare_key(&logs[2],
+						  &logs[0]) < 0);
 	logs[2].update_index = logs[0].update_index;
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), ==, 0);
+	cl_assert_equal_i(reftable_log_record_compare_key(&logs[0], &logs[2]), 0);
 }
 
-static void t_reftable_log_record_roundtrip(void)
+void test_reftable_record__log_record_roundtrip(void)
 {
 	struct reftable_log_record in[] = {
 		{
@@ -292,9 +308,9 @@ static void t_reftable_log_record_roundtrip(void)
 	set_hash(in[2].value.update.new_hash, 3);
 	set_hash(in[2].value.update.old_hash, 4);
 
-	check(!reftable_log_record_is_deletion(&in[0]));
-	check(reftable_log_record_is_deletion(&in[1]));
-	check(!reftable_log_record_is_deletion(&in[2]));
+	cl_assert_equal_i(reftable_log_record_is_deletion(&in[0]), 0);
+	cl_assert(reftable_log_record_is_deletion(&in[1]) != 0);
+	cl_assert_equal_i(reftable_log_record_is_deletion(&in[2]), 0);
 
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = REFTABLE_BLOCK_TYPE_LOG };
@@ -328,14 +344,14 @@ static void t_reftable_log_record_roundtrip(void)
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
+						    REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_log_record_release(&in[i]);
 		reftable_buf_release(&key);
 		reftable_record_release(&out);
@@ -344,7 +360,7 @@ static void t_reftable_log_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
-static void t_key_roundtrip(void)
+void test_reftable_record__key_roundtrip(void)
 {
 	uint8_t buffer[1024] = { 0 };
 	struct string_view dest = {
@@ -359,25 +375,28 @@ static void t_key_roundtrip(void)
 	int n, m;
 	uint8_t rt_extra;
 
-	check(!reftable_buf_addstr(&last_key, "refs/heads/master"));
-	check(!reftable_buf_addstr(&key, "refs/tags/bla"));
+	cl_assert_equal_i(reftable_buf_addstr(&last_key,
+					      "refs/heads/master"), 0);
+	cl_assert_equal_i(reftable_buf_addstr(&key,
+					      "refs/tags/bla"), 0);
 	extra = 6;
 	n = reftable_encode_key(&restart, dest, last_key, key, extra);
-	check(!restart);
-	check_int(n, >, 0);
+	cl_assert(!restart);
+	cl_assert(n > 0);
 
-	check(!reftable_buf_addstr(&roundtrip, "refs/heads/master"));
+	cl_assert_equal_i(reftable_buf_addstr(&roundtrip,
+					      "refs/heads/master"), 0);
 	m = reftable_decode_key(&roundtrip, &rt_extra, dest);
-	check_int(n, ==, m);
-	check(!reftable_buf_cmp(&key, &roundtrip));
-	check_int(rt_extra, ==, extra);
+	cl_assert_equal_i(n, m);
+	cl_assert_equal_i(reftable_buf_cmp(&key, &roundtrip), 0);
+	cl_assert_equal_i(rt_extra, extra);
 
 	reftable_buf_release(&last_key);
 	reftable_buf_release(&key);
 	reftable_buf_release(&roundtrip);
 }
 
-static void t_reftable_obj_record_comparison(void)
+void test_reftable_record__obj_record_comparison(void)
 {
 
 	uint8_t id_bytes[] = { 0, 1, 2, 3, 4, 5, 6 };
@@ -405,21 +424,23 @@ static void t_reftable_obj_record_comparison(void)
 	};
 	int cmp;
 
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert_equal_i(reftable_record_equal(&in[0], &in[1],
+						REFTABLE_HASH_SIZE_SHA1), 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
+	cl_assert(!cmp);
 
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
+	cl_assert_equal_i(reftable_record_equal(&in[1], &in[2],
+						REFTABLE_HASH_SIZE_SHA1), 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
+	cl_assert(cmp > 0);
 
 	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
+	cl_assert(!cmp);
 }
 
-static void t_reftable_obj_record_roundtrip(void)
+void test_reftable_record__obj_record_roundtrip(void)
 {
 	uint8_t testHash1[REFTABLE_HASH_SIZE_SHA1] = { 1, 2, 3, 4, 0 };
 	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
@@ -460,17 +481,18 @@ static void t_reftable_obj_record_roundtrip(void)
 		int n, m;
 		uint8_t extra;
 
-		check(!reftable_record_is_deletion(&in));
+		cl_assert_equal_i(reftable_record_is_deletion(&in), 0);
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
+		cl_assert(reftable_record_equal(&in, &out,
+						REFTABLE_HASH_SIZE_SHA1) != 0);
 		reftable_buf_release(&key);
 		reftable_record_release(&out);
 	}
@@ -478,7 +500,7 @@ static void t_reftable_obj_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
-static void t_reftable_index_record_comparison(void)
+void test_reftable_record__index_record_comparison(void)
 {
 	struct reftable_record in[3] = {
 		{
@@ -499,28 +521,33 @@ static void t_reftable_index_record_comparison(void)
 	};
 	int cmp;
 
-	check(!reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master"));
-	check(!reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"));
-	check(!reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch"));
+	cl_assert_equal_i(reftable_buf_addstr(&in[0].u.idx.last_key,
+					      "refs/heads/master"), 0);
+	cl_assert_equal_i(reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"), 0);
+	cl_assert(reftable_buf_addstr(&in[2].u.idx.last_key,
+				      "refs/heads/branch") == 0);
 
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert_equal_i(reftable_record_equal(&in[0], &in[1],
+						REFTABLE_HASH_SIZE_SHA1), 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
+	cl_assert(!cmp);
 
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
+	cl_assert_equal_i(reftable_record_equal(&in[1], &in[2],
+						REFTABLE_HASH_SIZE_SHA1), 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
+	cl_assert(cmp > 0);
 
 	in[1].u.idx.offset = in[0].u.idx.offset;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
+	cl_assert(reftable_record_equal(&in[0], &in[1],
+					REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
+	cl_assert(!cmp);
 
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
 		reftable_record_release(&in[i]);
 }
 
-static void t_reftable_index_record_roundtrip(void)
+void test_reftable_record__index_record_roundtrip(void)
 {
 	struct reftable_record in = {
 		.type = REFTABLE_BLOCK_TYPE_INDEX,
@@ -543,43 +570,26 @@ static void t_reftable_index_record_roundtrip(void)
 	int n, m;
 	uint8_t extra;
 
-	check(!reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master"));
+	cl_assert_equal_i(reftable_buf_addstr(&in.u.idx.last_key,
+					      "refs/heads/master"), 0);
 	reftable_record_key(&in, &key);
 	t_copy(&in);
 
-	check(!reftable_record_is_deletion(&in));
-	check(!reftable_buf_cmp(&key, &in.u.idx.last_key));
+	cl_assert_equal_i(reftable_record_is_deletion(&in), 0);
+	cl_assert_equal_i(reftable_buf_cmp(&key, &in.u.idx.last_key), 0);
 	n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
-	check_int(n, >, 0);
+	cl_assert(n > 0);
 
 	extra = reftable_record_val_type(&in);
-	m = reftable_record_decode(&out, key, extra, dest, REFTABLE_HASH_SIZE_SHA1,
-				   &scratch);
-	check_int(m, ==, n);
+	m = reftable_record_decode(&out, key, extra, dest,
+				   REFTABLE_HASH_SIZE_SHA1, &scratch);
+	cl_assert_equal_i(m, n);
 
-	check(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1));
+	cl_assert(reftable_record_equal(&in, &out,
+					REFTABLE_HASH_SIZE_SHA1) != 0);
 
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

