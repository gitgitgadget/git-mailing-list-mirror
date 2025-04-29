Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1588253949
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949228; cv=none; b=htfyAH0yHufuIZH+SezVSYmWncyBynRve+lZK2JEHNQRXRipqD53AfrQMyu6CbHRXTcpV3QGXSRP9ZTGNiOtwKld3qdGqqoFStu26w0g5dZrvZefXJOwcmQOKaN+22qWH2bCwVAiqSDBKZARSIdjq/J5LAd+MQlX4/H8FqkgmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949228; c=relaxed/simple;
	bh=5cM3ecwQ1SkOPejhQ61jaXjpw7bJEGXNMD65m22rQAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq2FF3qgEZaPZNXGh7xvhKL3PI4riEgh9XBMSNeamB5WxIWjF6ZHrnmrKtwr+QlGEiALyelsbZ1OxGotxuSvpdc/cAnrRsigL95utzlNDSwb44FT8P2+l4WTThOl9aFsmYilYL/unXCaRr5Pf8g4TGY0dtDBzJOf0i8QoERpP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EysKVEE2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EysKVEE2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c30d9085aso4655406f8f.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949224; x=1746554024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+SyYg+t+ZFpF+ucxXLTfF5NTk0n2//bZ9EWgFgN4v0=;
        b=EysKVEE2j2uZbi+gShuDeQgDVmSt0jhJ+dgptMrA69wAny1TqJMTqXzVtzN8V5RTzn
         NyyEpWkZglO2brcTMUR+BG8voolE4QRWzrO8Ibep1vtLqS0ulnVYa++YqpJXEB2otRMR
         eXOJNBK6cUykrNOHBkCPPbTSO3qf2cAk1L7DluwvXPaIejfK3ZdxQCnYK15c8OVfN9QR
         ITeNsYc6Hc/K4Xnx6au5GlbsXyVLD3TwazAtTHI1Y3a6L4nGFOk2nHmZlPxXtx+WQsoc
         LHRHr04zIIU61CmhUAoz4FNOzzSa/Y6neVeoS0MqTZJXnXOuKp7Pa8BFoa1+0n4m5YNe
         IIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949224; x=1746554024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+SyYg+t+ZFpF+ucxXLTfF5NTk0n2//bZ9EWgFgN4v0=;
        b=cWiSD4f/Ps8swH4kwFhVLKVDf90fZHIIVg8RbQ7iC3NCfuGwymJ6CVxX+x6gLn8XeF
         yg0/sAAolaVcPHeNE89AtKyvZpf/naSlvfTNrqOlsY9WC6fZv0IbyeXcCYsh002eCoVH
         v7z+Erd/jyRtoUg+WugRdho417PaOZTeX3w2iY0Nzm5TJZb3s8FDqRUS1/j2BTh9Y9gM
         isbBmOZIj4YOALG+GUtFYA7NqMy+wJIrnc8nMuvmPirWGmCHX+vI93xfbpqt+mpQLGIl
         aSrOx7TwXs9JW/CD16ThKzXR2t9ohVwDW5+7Gxy0hYt1i/nLHg3lmAc0eCFv2SZe3VsO
         EfCg==
X-Gm-Message-State: AOJu0YzSEp5wMaYwV4VWDwDRD72fl/3HAGWFKuVaAQqKLWWB/jNgvS/A
	VhzlJBBGpCoa48GrLet7l95JkTgpg/tpCeR6pqPfixmcPQeLaw31mdMvLliIJ+dEYg==
X-Gm-Gg: ASbGncu4xQgz7jjrIlXfDVDs8SI3HpOITdSnn+GiK1kpxXuy7z0oXG+0J/fb6ywd8cz
	DwMzCKqgOB8YR1m4WQGOcMG5DWrksiG4Bq24qo9oW2Bq5xG4YcpqyUhIShFjdIaBrn5Vu9VwhMe
	6zwPMyECgAvfDwI5qhyolUn1iIK+zQaXhldRYtjq5bFJ3Q5IcVnxVMgOOY2gzptYBxqNXe3P7YP
	jyD2rBdx76CC2jt+HlaWBuqiwf4SPQFfxq2SfggRCX0dT6mm9XeILLT1xtJgcNZGc5wv8UO/nvP
	/a3U0CoTB1AMXCIucp7idgksoGm5YXDndnM=
X-Google-Smtp-Source: AGHT+IHAqoEMoRSQGRmR/bA3j/HGV3Is9rTcsHTAUcc4bidZ7iKoEQvFhljj+NHK6qX51jYZCkki1w==
X-Received: by 2002:a05:6000:18a7:b0:39c:2688:6edd with SMTP id ffacd0b85a97d-3a08f766bc4mr279321f8f.15.1745949223744;
        Tue, 29 Apr 2025 10:53:43 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm14261782f8f.26.2025.04.29.10.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:53:43 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 03/10] t/unit-tests: convert reftable block test to use clar
Date: Tue, 29 Apr 2025 18:52:55 +0100
Message-ID: <20250429175302.23724-4-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429175302.23724-1-kuforiji98@gmail.com>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt reftable block test file to use clar testing framework by using
clar assertions where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                        |   2 +-
 t/meson.build                   |   2 +-
 t/unit-tests/t-reftable-block.c | 383 --------------------------------
 t/unit-tests/u-reftable-block.c | 373 +++++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+), 385 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-block.c
 create mode 100644 t/unit-tests/u-reftable-block.c

diff --git a/Makefile b/Makefile
index 7b12bb078c..239c575dad 100644
--- a/Makefile
+++ b/Makefile
@@ -1363,6 +1363,7 @@ CLAR_TEST_SUITES += u-oidmap
 CLAR_TEST_SUITES += u-oidtree
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-basics
+CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1375,7 +1376,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-reader
diff --git a/t/meson.build b/t/meson.build
index 8a42b595d9..e0d723e74b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -9,6 +9,7 @@ clar_test_suites = [
   'unit-tests/u-oidtree.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-basics.c',
+  'unit-tests/u-reftable-block.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -55,7 +56,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
   'unit-tests/t-reftable-pq.c',
   'unit-tests/t-reftable-reader.c',
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
deleted file mode 100644
index 22040aeefa..0000000000
--- a/t/unit-tests/t-reftable-block.c
+++ /dev/null
@@ -1,383 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "test-lib.h"
-#include "reftable/block.h"
-#include "reftable/blocksource.h"
-#include "reftable/constants.h"
-#include "reftable/reftable-error.h"
-#include "strbuf.h"
-
-static void t_ref_block_read_write(void)
-{
-	const int header_off = 21; /* random */
-	struct reftable_record recs[30];
-	const size_t N = ARRAY_SIZE(recs);
-	const size_t block_size = 1024;
-	struct reftable_block block = { 0 };
-	struct block_writer bw = {
-		.last_key = REFTABLE_BUF_INIT,
-	};
-	struct reftable_record rec = {
-		.type = BLOCK_TYPE_REF,
-	};
-	size_t i = 0;
-	int ret;
-	struct block_reader br = { 0 };
-	struct block_iter it = BLOCK_ITER_INIT;
-	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
-
-	REFTABLE_CALLOC_ARRAY(block.data, block_size);
-	check(block.data != NULL);
-	block.len = block_size;
-	block_source_from_buf(&block.source ,&buf);
-	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
-				header_off, hash_size(REFTABLE_HASH_SHA1));
-	check(!ret);
-
-	rec.u.ref.refname = (char *) "";
-	rec.u.ref.value_type = REFTABLE_REF_DELETION;
-	ret = block_writer_add(&bw, &rec);
-	check_int(ret, ==, REFTABLE_API_ERROR);
-
-	for (i = 0; i < N; i++) {
-		rec.u.ref.refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
-		rec.u.ref.value_type = REFTABLE_REF_VAL1;
-		memset(rec.u.ref.value.val1, i, REFTABLE_HASH_SIZE_SHA1);
-
-		recs[i] = rec;
-		ret = block_writer_add(&bw, &rec);
-		rec.u.ref.refname = NULL;
-		rec.u.ref.value_type = REFTABLE_REF_DELETION;
-		check_int(ret, ==, 0);
-	}
-
-	ret = block_writer_finish(&bw);
-	check_int(ret, >, 0);
-
-	block_writer_release(&bw);
-
-	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
-
-	block_iter_seek_start(&it, &br);
-
-	for (i = 0; ; i++) {
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, >=, 0);
-		if (ret > 0) {
-			check_int(i, ==, N);
-			break;
-		}
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
-	}
-
-	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
-		reftable_record_key(&recs[i], &want);
-
-		ret = block_iter_seek_key(&it, &br, &want);
-		check_int(ret, ==, 0);
-
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
-
-		want.len--;
-		ret = block_iter_seek_key(&it, &br, &want);
-		check_int(ret, ==, 0);
-
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
-	}
-
-	block_reader_release(&br);
-	block_iter_close(&it);
-	reftable_record_release(&rec);
-	reftable_block_done(&br.block);
-	reftable_buf_release(&want);
-	reftable_buf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_record_release(&recs[i]);
-}
-
-static void t_log_block_read_write(void)
-{
-	const int header_off = 21;
-	struct reftable_record recs[30];
-	const size_t N = ARRAY_SIZE(recs);
-	const size_t block_size = 2048;
-	struct reftable_block block = { 0 };
-	struct block_writer bw = {
-		.last_key = REFTABLE_BUF_INIT,
-	};
-	struct reftable_record rec = {
-		.type = BLOCK_TYPE_LOG,
-	};
-	size_t i = 0;
-	int ret;
-	struct block_reader br = { 0 };
-	struct block_iter it = BLOCK_ITER_INIT;
-	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
-
-	REFTABLE_CALLOC_ARRAY(block.data, block_size);
-	check(block.data != NULL);
-	block.len = block_size;
-	block_source_from_buf(&block.source ,&buf);
-	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
-				header_off, hash_size(REFTABLE_HASH_SHA1));
-	check(!ret);
-
-	for (i = 0; i < N; i++) {
-		rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
-		rec.u.log.update_index = i;
-		rec.u.log.value_type = REFTABLE_LOG_UPDATE;
-
-		recs[i] = rec;
-		ret = block_writer_add(&bw, &rec);
-		rec.u.log.refname = NULL;
-		rec.u.log.value_type = REFTABLE_LOG_DELETION;
-		check_int(ret, ==, 0);
-	}
-
-	ret = block_writer_finish(&bw);
-	check_int(ret, >, 0);
-
-	block_writer_release(&bw);
-
-	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
-
-	block_iter_seek_start(&it, &br);
-
-	for (i = 0; ; i++) {
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, >=, 0);
-		if (ret > 0) {
-			check_int(i, ==, N);
-			break;
-		}
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
-	}
-
-	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
-		reftable_buf_reset(&want);
-		check(!reftable_buf_addstr(&want, recs[i].u.log.refname));
-
-		ret = block_iter_seek_key(&it, &br, &want);
-		check_int(ret, ==, 0);
-
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
-
-		want.len--;
-		ret = block_iter_seek_key(&it, &br, &want);
-		check_int(ret, ==, 0);
-
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
-	}
-
-	block_reader_release(&br);
-	block_iter_close(&it);
-	reftable_record_release(&rec);
-	reftable_block_done(&br.block);
-	reftable_buf_release(&want);
-	reftable_buf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_record_release(&recs[i]);
-}
-
-static void t_obj_block_read_write(void)
-{
-	const int header_off = 21;
-	struct reftable_record recs[30];
-	const size_t N = ARRAY_SIZE(recs);
-	const size_t block_size = 1024;
-	struct reftable_block block = { 0 };
-	struct block_writer bw = {
-		.last_key = REFTABLE_BUF_INIT,
-	};
-	struct reftable_record rec = {
-		.type = BLOCK_TYPE_OBJ,
-	};
-	size_t i = 0;
-	int ret;
-	struct block_reader br = { 0 };
-	struct block_iter it = BLOCK_ITER_INIT;
-	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
-
-	REFTABLE_CALLOC_ARRAY(block.data, block_size);
-	check(block.data != NULL);
-	block.len = block_size;
-	block_source_from_buf(&block.source, &buf);
-	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
-				header_off, hash_size(REFTABLE_HASH_SHA1));
-	check(!ret);
-
-	for (i = 0; i < N; i++) {
-		uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
-		DUP_ARRAY(allocated, bytes, ARRAY_SIZE(bytes));
-
-		rec.u.obj.hash_prefix = allocated;
-		rec.u.obj.hash_prefix_len = 5;
-
-		recs[i] = rec;
-		ret = block_writer_add(&bw, &rec);
-		rec.u.obj.hash_prefix = NULL;
-		rec.u.obj.hash_prefix_len = 0;
-		check_int(ret, ==, 0);
-	}
-
-	ret = block_writer_finish(&bw);
-	check_int(ret, >, 0);
-
-	block_writer_release(&bw);
-
-	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
-
-	block_iter_seek_start(&it, &br);
-
-	for (i = 0; ; i++) {
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, >=, 0);
-		if (ret > 0) {
-			check_int(i, ==, N);
-			break;
-		}
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
-	}
-
-	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
-		reftable_record_key(&recs[i], &want);
-
-		ret = block_iter_seek_key(&it, &br, &want);
-		check_int(ret, ==, 0);
-
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
-	}
-
-	block_reader_release(&br);
-	block_iter_close(&it);
-	reftable_record_release(&rec);
-	reftable_block_done(&br.block);
-	reftable_buf_release(&want);
-	reftable_buf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_record_release(&recs[i]);
-}
-
-static void t_index_block_read_write(void)
-{
-	const int header_off = 21;
-	struct reftable_record recs[30];
-	const size_t N = ARRAY_SIZE(recs);
-	const size_t block_size = 1024;
-	struct reftable_block block = { 0 };
-	struct block_writer bw = {
-		.last_key = REFTABLE_BUF_INIT,
-	};
-	struct reftable_record rec = {
-		.type = BLOCK_TYPE_INDEX,
-		.u.idx.last_key = REFTABLE_BUF_INIT,
-	};
-	size_t i = 0;
-	int ret;
-	struct block_reader br = { 0 };
-	struct block_iter it = BLOCK_ITER_INIT;
-	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
-
-	REFTABLE_CALLOC_ARRAY(block.data, block_size);
-	check(block.data != NULL);
-	block.len = block_size;
-	block_source_from_buf(&block.source, &buf);
-	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
-				header_off, hash_size(REFTABLE_HASH_SHA1));
-	check(!ret);
-
-	for (i = 0; i < N; i++) {
-		char buf[128];
-
-		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
-
-		reftable_buf_init(&recs[i].u.idx.last_key);
-		recs[i].type = BLOCK_TYPE_INDEX;
-		check(!reftable_buf_addstr(&recs[i].u.idx.last_key, buf));
-		recs[i].u.idx.offset = i;
-
-		ret = block_writer_add(&bw, &recs[i]);
-		check_int(ret, ==, 0);
-	}
-
-	ret = block_writer_finish(&bw);
-	check_int(ret, >, 0);
-
-	block_writer_release(&bw);
-
-	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
-
-	block_iter_seek_start(&it, &br);
-
-	for (i = 0; ; i++) {
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, >=, 0);
-		if (ret > 0) {
-			check_int(i, ==, N);
-			break;
-		}
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
-	}
-
-	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
-		reftable_record_key(&recs[i], &want);
-
-		ret = block_iter_seek_key(&it, &br, &want);
-		check_int(ret, ==, 0);
-
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
-
-		want.len--;
-		ret = block_iter_seek_key(&it, &br, &want);
-		check_int(ret, ==, 0);
-
-		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
-	}
-
-	block_reader_release(&br);
-	block_iter_close(&it);
-	reftable_record_release(&rec);
-	reftable_block_done(&br.block);
-	reftable_buf_release(&want);
-	reftable_buf_release(&buf);
-	for (i = 0; i < N; i++)
-		reftable_record_release(&recs[i]);
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_index_block_read_write(), "read-write operations on index blocks work");
-	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
-	TEST(t_obj_block_read_write(), "read-write operations on obj blocks work");
-	TEST(t_ref_block_read_write(), "read-write operations on ref blocks work");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
new file mode 100644
index 0000000000..af24901230
--- /dev/null
+++ b/t/unit-tests/u-reftable-block.c
@@ -0,0 +1,373 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "unit-test.h"
+#include "reftable/block.h"
+#include "reftable/blocksource.h"
+#include "reftable/constants.h"
+#include "reftable/reftable-error.h"
+#include "strbuf.h"
+
+void test_reftable_block__index_read_write(void)
+{
+	const int header_off = 21; /* random */
+	struct reftable_record recs[30];
+	const size_t N = ARRAY_SIZE(recs);
+	const size_t block_size = 1024;
+	struct reftable_block block = { 0 };
+	struct block_writer bw = {
+		.last_key = REFTABLE_BUF_INIT,
+	};
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_REF,
+	};
+	size_t i = 0;
+	int ret;
+	struct block_reader br = { 0 };
+	struct block_iter it = BLOCK_ITER_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
+
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	cl_assert(block.data != NULL);
+	block.len = block_size;
+	block_source_from_buf(&block.source ,&buf);
+	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
+				header_off, hash_size(REFTABLE_HASH_SHA1));
+	cl_assert(ret == 0);
+
+	rec.u.ref.refname = (char *) "";
+	rec.u.ref.value_type = REFTABLE_REF_DELETION;
+	ret = block_writer_add(&bw, &rec);
+	cl_assert_equal_i(ret, REFTABLE_API_ERROR);
+
+	for (i = 0; i < N; i++) {
+		rec.u.ref.refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
+		rec.u.ref.value_type = REFTABLE_REF_VAL1;
+		memset(rec.u.ref.value.val1, i, REFTABLE_HASH_SIZE_SHA1);
+
+		recs[i] = rec;
+		ret = block_writer_add(&bw, &rec);
+		rec.u.ref.refname = NULL;
+		rec.u.ref.value_type = REFTABLE_REF_DELETION;
+		cl_assert_equal_i(ret, 0);
+	}
+
+	ret = block_writer_finish(&bw);
+	cl_assert(ret > 0);
+
+	block_writer_release(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+
+	block_iter_seek_start(&it, &br);
+
+	for (i = 0; ; i++) {
+		ret = block_iter_next(&it, &rec);
+		cl_assert(ret >= 0);
+		if (ret > 0) {
+			cl_assert_equal_i(i, N);
+			break;
+		}
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+	}
+
+	for (i = 0; i < N; i++) {
+		block_iter_reset(&it);
+		reftable_record_key(&recs[i], &want);
+
+		ret = block_iter_seek_key(&it, &br, &want);
+		cl_assert_equal_i(ret, 0);
+
+		ret = block_iter_next(&it, &rec);
+		cl_assert_equal_i(ret, 0);
+
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+
+		want.len--;
+		ret = block_iter_seek_key(&it, &br, &want);
+		cl_assert_equal_i(ret, 0);
+
+		ret = block_iter_next(&it, &rec);
+		cl_assert_equal_i(ret, 0);
+		cl_assert_equal_i(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+	}
+
+	block_reader_release(&br);
+	block_iter_close(&it);
+	reftable_record_release(&rec);
+	reftable_block_done(&br.block);
+	reftable_buf_release(&want);
+	reftable_buf_release(&buf);
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+}
+
+void test_reftable_block__log_read_write(void)
+{
+	const int header_off = 21;
+	struct reftable_record recs[30];
+	const size_t N = ARRAY_SIZE(recs);
+	const size_t block_size = 2048;
+	struct reftable_block block = { 0 };
+	struct block_writer bw = {
+		.last_key = REFTABLE_BUF_INIT,
+	};
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_LOG,
+	};
+	size_t i = 0;
+	int ret;
+	struct block_reader br = { 0 };
+	struct block_iter it = BLOCK_ITER_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
+
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	cl_assert(block.data != NULL);
+	block.len = block_size;
+	block_source_from_buf(&block.source ,&buf);
+	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
+				header_off, hash_size(REFTABLE_HASH_SHA1));
+	cl_assert(ret == 0);
+
+	for (i = 0; i < N; i++) {
+		rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
+		rec.u.log.update_index = i;
+		rec.u.log.value_type = REFTABLE_LOG_UPDATE;
+
+		recs[i] = rec;
+		ret = block_writer_add(&bw, &rec);
+		rec.u.log.refname = NULL;
+		rec.u.log.value_type = REFTABLE_LOG_DELETION;
+		cl_assert_equal_i(ret, 0);
+	}
+
+	ret = block_writer_finish(&bw);
+	cl_assert(ret > 0);
+
+	block_writer_release(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+
+	block_iter_seek_start(&it, &br);
+
+	for (i = 0; ; i++) {
+		ret = block_iter_next(&it, &rec);
+		cl_assert(ret >= 0);
+		if (ret > 0) {
+			cl_assert_equal_i(i, N);
+			break;
+		}
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+	}
+
+	for (i = 0; i < N; i++) {
+		block_iter_reset(&it);
+		reftable_buf_reset(&want);
+		cl_assert(reftable_buf_addstr(&want, recs[i].u.log.refname) == 0);
+
+		ret = block_iter_seek_key(&it, &br, &want);
+		cl_assert_equal_i(ret, 0);
+
+		ret = block_iter_next(&it, &rec);
+		cl_assert_equal_i(ret, 0);
+
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+
+		want.len--;
+		ret = block_iter_seek_key(&it, &br, &want);
+		cl_assert_equal_i(ret, 0);
+
+		ret = block_iter_next(&it, &rec);
+		cl_assert_equal_i(ret, 0);
+		cl_assert_equal_i(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+	}
+
+	block_reader_release(&br);
+	block_iter_close(&it);
+	reftable_record_release(&rec);
+	reftable_block_done(&br.block);
+	reftable_buf_release(&want);
+	reftable_buf_release(&buf);
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+}
+
+void test_reftable_block__obj_read_write(void)
+{
+	const int header_off = 21;
+	struct reftable_record recs[30];
+	const size_t N = ARRAY_SIZE(recs);
+	const size_t block_size = 1024;
+	struct reftable_block block = { 0 };
+	struct block_writer bw = {
+		.last_key = REFTABLE_BUF_INIT,
+	};
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_OBJ,
+	};
+	size_t i = 0;
+	int ret;
+	struct block_reader br = { 0 };
+	struct block_iter it = BLOCK_ITER_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
+
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	cl_assert(block.data != NULL);
+	block.len = block_size;
+	block_source_from_buf(&block.source, &buf);
+	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
+				header_off, hash_size(REFTABLE_HASH_SHA1));
+	cl_assert(ret == 0);
+
+	for (i = 0; i < N; i++) {
+		uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
+		DUP_ARRAY(allocated, bytes, ARRAY_SIZE(bytes));
+
+		rec.u.obj.hash_prefix = allocated;
+		rec.u.obj.hash_prefix_len = 5;
+
+		recs[i] = rec;
+		ret = block_writer_add(&bw, &rec);
+		rec.u.obj.hash_prefix = NULL;
+		rec.u.obj.hash_prefix_len = 0;
+		cl_assert_equal_i(ret, 0);
+	}
+
+	ret = block_writer_finish(&bw);
+	cl_assert(ret > 0);
+
+	block_writer_release(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+
+	block_iter_seek_start(&it, &br);
+
+	for (i = 0; ; i++) {
+		ret = block_iter_next(&it, &rec);
+		cl_assert(ret >= 0);
+		if (ret > 0) {
+			cl_assert_equal_i(i, N);
+			break;
+		}
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+	}
+
+	for (i = 0; i < N; i++) {
+		block_iter_reset(&it);
+		reftable_record_key(&recs[i], &want);
+
+		ret = block_iter_seek_key(&it, &br, &want);
+		cl_assert_equal_i(ret, 0);
+
+		ret = block_iter_next(&it, &rec);
+		cl_assert_equal_i(ret, 0);
+
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+	}
+
+	block_reader_release(&br);
+	block_iter_close(&it);
+	reftable_record_release(&rec);
+	reftable_block_done(&br.block);
+	reftable_buf_release(&want);
+	reftable_buf_release(&buf);
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+}
+
+void test_reftable_block__ref_read_write(void)
+{
+	const int header_off = 21;
+	struct reftable_record recs[30];
+	const size_t N = ARRAY_SIZE(recs);
+	const size_t block_size = 1024;
+	struct reftable_block block = { 0 };
+	struct block_writer bw = {
+		.last_key = REFTABLE_BUF_INIT,
+	};
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_INDEX,
+		.u.idx.last_key = REFTABLE_BUF_INIT,
+	};
+	size_t i = 0;
+	int ret;
+	struct block_reader br = { 0 };
+	struct block_iter it = BLOCK_ITER_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
+
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	cl_assert(block.data != NULL);
+	block.len = block_size;
+	block_source_from_buf(&block.source, &buf);
+	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
+				header_off, hash_size(REFTABLE_HASH_SHA1));
+	cl_assert(ret == 0);
+
+	for (i = 0; i < N; i++) {
+		char buf[128];
+
+		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
+
+		reftable_buf_init(&recs[i].u.idx.last_key);
+		recs[i].type = BLOCK_TYPE_INDEX;
+		cl_assert(reftable_buf_addstr(&recs[i].u.idx.last_key, buf) == 0);
+		recs[i].u.idx.offset = i;
+
+		ret = block_writer_add(&bw, &recs[i]);
+		cl_assert_equal_i(ret, 0);
+	}
+
+	ret = block_writer_finish(&bw);
+	cl_assert(ret > 0);
+
+	block_writer_release(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+
+	block_iter_seek_start(&it, &br);
+
+	for (i = 0; ; i++) {
+		ret = block_iter_next(&it, &rec);
+		cl_assert(ret >= 0);
+		if (ret > 0) {
+			cl_assert_equal_i(i, N);
+			break;
+		}
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+	}
+
+	for (i = 0; i < N; i++) {
+		block_iter_reset(&it);
+		reftable_record_key(&recs[i], &want);
+
+		ret = block_iter_seek_key(&it, &br, &want);
+		cl_assert_equal_i(ret, 0);
+
+		ret = block_iter_next(&it, &rec);
+		cl_assert_equal_i(ret, 0);
+
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+
+		want.len--;
+		ret = block_iter_seek_key(&it, &br, &want);
+		cl_assert_equal_i(ret, 0);
+
+		ret = block_iter_next(&it, &rec);
+		cl_assert_equal_i(ret, 0);
+		cl_assert_equal_i(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
+	}
+
+	block_reader_release(&br);
+	block_iter_close(&it);
+	reftable_record_release(&rec);
+	reftable_block_done(&br.block);
+	reftable_buf_release(&want);
+	reftable_buf_release(&buf);
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+}
-- 
2.43.0

