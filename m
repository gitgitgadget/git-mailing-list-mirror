Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D72DE710
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367432; cv=none; b=KfN+TC5MhuTLPBmZg0V1XUOTxOkejRPkEChC2rcOhQykjsbrPg3iC0x2nybkPNowuCPFPwwYxobA3Vb+u6mtNkFZ4qOzKUIf1OXiKpp/4NT9fXZc7nWMsBlEdacxrKIE8V3tAAzcmslKQs4a/4ZD+5Ildwp38AOGD9TVThHtg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367432; c=relaxed/simple;
	bh=mOk/kW3PTD55IQfNkWz+zxDt3DK33hyvFv75mrAE5SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHzCMD1nD81cBg5clMz+9swHN/3lCAIlfEXEuHjv4HZuSh87pFAReGeWQaX/jvBd8+O1muobv2kYuZ0QZ0Hs2vbeUo9bT9V6rrkTBEdr2GWaHMY/ASIXOx7ZXTMxMOpI0gT2F3VY4lEmpYFoWaoRdXvkLjgNKtFww4fZzZEza8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSo5m6m5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSo5m6m5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45610582d07so7571135e9.0
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753367428; x=1753972228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGjGcwt6684iQBtnzSM86Jyqo3OF8KQoJVfhl7UpVKo=;
        b=cSo5m6m5YazdBnpcJMzsHdTEr4j2p/C/1dWHxCZQnjx3Um5KO1YBFAc3J9mpbLBZTu
         klsJ0S4nmpT6+e3Fp1TmhGP9VDSkUksDnJH/SbLNv8YlFn1tdO+TG1WlTt6NiTEEJAIY
         lb5UusGU0c+adVRWu2Ud+1MjAG6Q662bwak1zMBpaPT7CB+mxM1Y3uqDt3vwajyb5BPs
         +YGmPD7UJL0ZGw2oGHE1nKQscFLDZj9Zqzwlx9afDInV+QUvpQa0d20EIsW0yuaEkQpi
         ph56JpjKvQN9rFo28YWv8TLfaY0Se97GpqynlDXUvTnCItjjISP+L3m7ekRTolGB6ONC
         MS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367428; x=1753972228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGjGcwt6684iQBtnzSM86Jyqo3OF8KQoJVfhl7UpVKo=;
        b=mwIL1zf1DmW3sh72vcu2uThqXxJOGjcq3HeZvYafOchpVxR/YTunLa0b4myWAuDr/F
         y5qc9FOQxQIKomUStPVtDdawCubu52qPytROKsNlxqIxyWzRYROvNBHTKBovYpgFkHSe
         b4gvY4Gj6wKGuFKoe3aLDuloTX/LKKfSHH8imIqQwxyi6VhSmAm4EMOgzvVd/z69ssBQ
         d33rqWxfPm9qhB+Bv51LKQbfkMRjLBsTzucVyBd4jr2PAUDGAiPROZPZhNXa+XVONWrN
         +nQ4YJBJls4KS6A2/ENfly/1Qz+AudFj+Fcb1eHtLuJtnWbfG9W8ZflaX00GHvWO4sHO
         Cr5g==
X-Gm-Message-State: AOJu0YyCV5JUl9o0uOJbZsymdd33hT4vIva7NcwWzckK20qP77se1Uv6
	Bh06eNufWiGui9LPDksRQavqqFk9dt3+6g8/lBsihAPYHANDZdMYDebdQwMyf/Isq9PWCVFv
X-Gm-Gg: ASbGncsqCcD39tzYbHsrGSsIeoU/SM38qBxQeypywR03ZDO/FFrVz9TOtrMPHqNBDMJ
	J+6Hwol68paAnZCpdWTMh7Vaf0SKwewlf9aNmlWLwtKNDYNLbyklI7kP18y2AjrQZ1F+wsX0gR5
	R2JKchpOjqPgeyfMtCWKwFxAZCqEcy2d0pJeWuG8WNbzgZnlIt7x6pu5hwinUtptnQvopdGiSS9
	KLUncGJZPiDT7DJ/cfg4heqwm7V2dLm+9rZ+NPrDKn3Wd7en3XyvOvYTGLg3EWQk437UA5rMk5g
	UTvSz9ZE4SxfbIfxLJe/HFvLddQ5ei70qxnVdXZd2ZubicegWIrn3UodS3IJ9YhCYKQ1ERauJXh
	um211Yci8556/VwDk
X-Google-Smtp-Source: AGHT+IE34z+qAbn11x/xHbGegXMsPoh32TRL71vsKjjUEF5zyzL8VcnsR9/TTfhqr6Aku0hvrDuxHg==
X-Received: by 2002:a05:600c:870a:b0:456:11db:2f0f with SMTP id 5b1f17b1804b1-45868d1bd9emr73683035e9.16.1753367427955;
        Thu, 24 Jul 2025 07:30:27 -0700 (PDT)
Received: from localhost.localdomain ([105.113.77.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec63d29sm22792135e9.1.2025.07.24.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:30:27 -0700 (PDT)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 06/10] t/unit-tests: convert reftable table test to use clar
Date: Thu, 24 Jul 2025 15:28:33 +0100
Message-ID: <20250724142837.67149-7-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724142837.67149-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
 <20250724142837.67149-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kuforiji <kuforiji98@gmail.com>

Adapt reftable table test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                                      |  2 +-
 t/meson.build                                 |  5 +-
 ...{t-reftable-table.c => u-reftable-table.c} | 75 +++++++++----------
 3 files changed, 38 insertions(+), 44 deletions(-)
 rename t/unit-tests/{t-reftable-table.c => u-reftable-table.c} (75%)

diff --git a/Makefile b/Makefile
index 3cccc73073..e4b90052be 100644
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

