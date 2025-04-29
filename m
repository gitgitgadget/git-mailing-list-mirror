Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA2253326
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949232; cv=none; b=hr4noGkj6s0JtEhV3njgSTklC9aKjzGKrXEvsBLJPJ0I/97daEEzF8iQyuUg/llrDqGLPv1JfM5AgHgxQWEKzDXjjsFbuE+4g0CGheWfvSA6HzkIDfeXyeIrDGtvLuKS94MuPm5P9ukEx8A4NjGnN2NIQ30IeCbJGH0LJ6du6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949232; c=relaxed/simple;
	bh=1iP4cLCSbDH5yUFNAUW6AviqhlGr2jKlrNCSKEH4Zd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI8nEGY4hGx4wAbHpqWBAWbyt87qUlJJyZw9nvBzLo/IhXlN1T6cVbRK24/6IhHTtGU/aQJ8pmmsOgwKY/Z35yPMf05TUIYbVtIBFpW1qbOsOyTMlUMuFlJLLb51n6/ISt1Mikp2HVdQ7/cuLBXK8jxgR+svEm7lqcphnUUngiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpVlqL5f; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpVlqL5f"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4262808f8f.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949228; x=1746554028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdW+mxe6SsADit7pX9jOVI6HyyfVdTgYq+ZJjE8cOYQ=;
        b=hpVlqL5f4Tk5LqOE3eF2oWs+A0rb6gyGRcMSeVOenaMunfQIkm4/3A5qLEgMhcZiqA
         tb164heFDJpvv6yH1PNeW7r2WCRohZ8qQJUt8fM/oQcvRzYu9HnPFhhVzXehBEstX+/t
         bvwvREicr/SwCKo4iJN9TEL5MeUPC/k1UhrMoa0Ia/h2aWwoJ8Gdnr73DGmVAcVwy39s
         jDJJn/KviwK73P8vraibiYuK9lhDARKr/nt03Jlg6IQ/WMPq3dUeYAjmKpl8lzAagA5g
         ltXvTJwDfu7cCgduea+2Um/itZXq5E7m/GhdslgNf5iA6D1kKlzxwyEIhxhQ4eOTICrv
         qCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949228; x=1746554028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdW+mxe6SsADit7pX9jOVI6HyyfVdTgYq+ZJjE8cOYQ=;
        b=Ms+4m0ZWP80r8iVakHG4HJTwGOew2ujU/fX31tTJmdbqSqd0CcGkvct3lI9oSzF5Sq
         hLZAMflZBEKg9u24e6+8VJBNYTI1/ZLP5XJDQ6lCHP1yhh2kPFl2+iv7k8a3E6dL1Brm
         OR6boI5IVpgBphTVprYJXqyFCn9a8+qEAWprGoN4YB9dAzvkstdTShnLzipBbwU68dkF
         xfTCVWJmToQYPm6VW2oXVwNKQaNRx9lWBsiQ72tBj2Snb7c0VMtLsNBVnD947zmgT32V
         OEKAckIFy52TB0XUiTK2Sl10A3bjxhUM7Ec4ep4wI3a+KVN8BxsXyP0ei26RXQiR89ad
         abrA==
X-Gm-Message-State: AOJu0YyUmVo+8r551uxcMaAj8PikPYbgmKmWYjhq1PEa8bRhCaMNBnc4
	tWQpEy48bdxga3s4i8i/mJkZ9TmmIOownLJpMsLPp+kESYBp9qzMDmWjRKczII/TXw==
X-Gm-Gg: ASbGnctla0sVYYgjtVkoA8EzzwysAx3bnruR5DAa8jyrEKcbkGECYtIkLcc3zQEcr2m
	SxijFZDwLoQJYMyYS45g/tCaYcUohemQ83vcT9qj89nekVuwB7BQD+t8rEJxo9HzME2JMLanigw
	xoBH+CraurmQF31qc5ro90p1a3vkzP9Wjzb0etX4DtBJDaSU/WcEXCnzZJK5q9lYNwxUiAhjo4F
	zx4YYqJtHomdGup9tRBqIi9+ETlmKoUxEDfr82W8EAGEMGEngLVA/Z4F/Vp1Dc8skdtHQQfuBzL
	/DT/37txkgeiQOUbY2rlcKvcWi8S664xksI=
X-Google-Smtp-Source: AGHT+IEIbUDLhNlj3ygD+ikHwy8orWKLUEmxyLqtVX1An3KjmqFmpN2YF9Xe4Hl906qbKUfH13Lyyw==
X-Received: by 2002:a5d:598c:0:b0:3a0:7a5d:bbff with SMTP id ffacd0b85a97d-3a08f752666mr292872f8f.7.1745949227876;
        Tue, 29 Apr 2025 10:53:47 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm14261782f8f.26.2025.04.29.10.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:53:47 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 04/10] t/unit-tests: convert reftable merged test to use clar
Date: Tue, 29 Apr 2025 18:52:56 +0100
Message-ID: <20250429175302.23724-5-kuforiji98@gmail.com>
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

Adapt reftable merged test file to use clar testing framework by using
clar assertions where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                         |   2 +-
 t/meson.build                    |   2 +-
 t/unit-tests/t-reftable-merged.c | 546 -------------------------------
 t/unit-tests/u-reftable-merged.c | 515 +++++++++++++++++++++++++++++
 4 files changed, 517 insertions(+), 548 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-merged.c
 create mode 100644 t/unit-tests/u-reftable-merged.c

diff --git a/Makefile b/Makefile
index 239c575dad..2b1642465a 100644
--- a/Makefile
+++ b/Makefile
@@ -1364,6 +1364,7 @@ CLAR_TEST_SUITES += u-oidtree
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
+CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1376,7 +1377,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
diff --git a/t/meson.build b/t/meson.build
index e0d723e74b..70a783ba80 100644
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
@@ -56,7 +57,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-merged.c',
   'unit-tests/t-reftable-pq.c',
   'unit-tests/t-reftable-reader.c',
   'unit-tests/t-reftable-readwrite.c',
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
deleted file mode 100644
index 60836f80d6..0000000000
--- a/t/unit-tests/t-reftable-merged.c
+++ /dev/null
@@ -1,546 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "test-lib.h"
-#include "lib-reftable.h"
-#include "reftable/blocksource.h"
-#include "reftable/constants.h"
-#include "reftable/merged.h"
-#include "reftable/reader.h"
-#include "reftable/reftable-error.h"
-#include "reftable/reftable-merged.h"
-#include "reftable/reftable-writer.h"
-
-static struct reftable_merged_table *
-merged_table_from_records(struct reftable_ref_record **refs,
-			  struct reftable_block_source **source,
-			  struct reftable_reader ***readers, const size_t *sizes,
-			  struct reftable_buf *buf, const size_t n)
-{
-	struct reftable_merged_table *mt = NULL;
-	struct reftable_write_options opts = {
-		.block_size = 256,
-	};
-	int err;
-
-	REFTABLE_CALLOC_ARRAY(*readers, n);
-	check(*readers != NULL);
-	REFTABLE_CALLOC_ARRAY(*source, n);
-	check(*source != NULL);
-
-	for (size_t i = 0; i < n; i++) {
-		t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
-		block_source_from_buf(&(*source)[i], &buf[i]);
-
-		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
-					  "name");
-		check(!err);
-	}
-
-	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
-	check(!err);
-	return mt;
-}
-
-static void readers_destroy(struct reftable_reader **readers, const size_t n)
-{
-	for (size_t i = 0; i < n; i++)
-		reftable_reader_decref(readers[i]);
-	reftable_free(readers);
-}
-
-static void t_merged_single_record(void)
-{
-	struct reftable_ref_record r1[] = { {
-		.refname = (char *) "b",
-		.update_index = 1,
-		.value_type = REFTABLE_REF_VAL1,
-		.value.val1 = { 1, 2, 3, 0 },
-	} };
-	struct reftable_ref_record r2[] = { {
-		.refname = (char *) "a",
-		.update_index = 2,
-		.value_type = REFTABLE_REF_DELETION,
-	} };
-	struct reftable_ref_record r3[] = { {
-		.refname = (char *) "c",
-		.update_index = 3,
-		.value_type = REFTABLE_REF_DELETION,
-	} };
-
-	struct reftable_ref_record *refs[] = { r1, r2, r3 };
-	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
-	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
-	struct reftable_block_source *bs = NULL;
-	struct reftable_reader **readers = NULL;
-	struct reftable_merged_table *mt =
-		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_iterator it = { 0 };
-	int err;
-
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
-	check(!err);
-	err = reftable_iterator_seek_ref(&it, "a");
-	check(!err);
-
-	err = reftable_iterator_next_ref(&it, &ref);
-	check(!err);
-	check(reftable_ref_record_equal(&r2[0], &ref, REFTABLE_HASH_SIZE_SHA1));
-	reftable_ref_record_release(&ref);
-	reftable_iterator_destroy(&it);
-	readers_destroy(readers, 3);
-	reftable_merged_table_free(mt);
-	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
-		reftable_buf_release(&bufs[i]);
-	reftable_free(bs);
-}
-
-static void t_merged_refs(void)
-{
-	struct reftable_ref_record r1[] = {
-		{
-			.refname = (char *) "a",
-			.update_index = 1,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 1 },
-		},
-		{
-			.refname = (char *) "b",
-			.update_index = 1,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 1 },
-		},
-		{
-			.refname = (char *) "c",
-			.update_index = 1,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 1 },
-		}
-	};
-	struct reftable_ref_record r2[] = { {
-		.refname = (char *) "a",
-		.update_index = 2,
-		.value_type = REFTABLE_REF_DELETION,
-	} };
-	struct reftable_ref_record r3[] = {
-		{
-			.refname = (char *) "c",
-			.update_index = 3,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 2 },
-		},
-		{
-			.refname = (char *) "d",
-			.update_index = 3,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 1 },
-		},
-	};
-
-	struct reftable_ref_record *want[] = {
-		&r2[0],
-		&r1[1],
-		&r3[0],
-		&r3[1],
-	};
-
-	struct reftable_ref_record *refs[] = { r1, r2, r3 };
-	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
-	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
-	struct reftable_block_source *bs = NULL;
-	struct reftable_reader **readers = NULL;
-	struct reftable_merged_table *mt =
-		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
-	struct reftable_iterator it = { 0 };
-	int err;
-	struct reftable_ref_record *out = NULL;
-	size_t len = 0;
-	size_t cap = 0;
-	size_t i;
-
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
-	check(!err);
-	err = reftable_iterator_seek_ref(&it, "a");
-	check(!err);
-	check_int(reftable_merged_table_hash_id(mt), ==, REFTABLE_HASH_SHA1);
-	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
-	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
-
-	while (len < 100) { /* cap loops/recursion. */
-		struct reftable_ref_record ref = { 0 };
-		int err = reftable_iterator_next_ref(&it, &ref);
-		if (err > 0)
-			break;
-
-		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
-		out[len++] = ref;
-	}
-	reftable_iterator_destroy(&it);
-
-	check_int(ARRAY_SIZE(want), ==, len);
-	for (i = 0; i < len; i++)
-		check(reftable_ref_record_equal(want[i], &out[i],
-						 REFTABLE_HASH_SIZE_SHA1));
-	for (i = 0; i < len; i++)
-		reftable_ref_record_release(&out[i]);
-	reftable_free(out);
-
-	for (i = 0; i < 3; i++)
-		reftable_buf_release(&bufs[i]);
-	readers_destroy(readers, 3);
-	reftable_merged_table_free(mt);
-	reftable_free(bs);
-}
-
-static void t_merged_seek_multiple_times(void)
-{
-	struct reftable_ref_record r1[] = {
-		{
-			.refname = (char *) "a",
-			.update_index = 1,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 1 },
-		},
-		{
-			.refname = (char *) "c",
-			.update_index = 1,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 2 },
-		}
-	};
-	struct reftable_ref_record r2[] = {
-		{
-			.refname = (char *) "b",
-			.update_index = 2,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 3 },
-		},
-		{
-			.refname = (char *) "d",
-			.update_index = 2,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 4 },
-		},
-	};
-	struct reftable_ref_record *refs[] = {
-		r1, r2,
-	};
-	size_t sizes[] = {
-		ARRAY_SIZE(r1), ARRAY_SIZE(r2),
-	};
-	struct reftable_buf bufs[] = {
-		REFTABLE_BUF_INIT, REFTABLE_BUF_INIT,
-	};
-	struct reftable_block_source *sources = NULL;
-	struct reftable_reader **readers = NULL;
-	struct reftable_ref_record rec = { 0 };
-	struct reftable_iterator it = { 0 };
-	struct reftable_merged_table *mt;
-
-	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
-
-	for (size_t i = 0; i < 5; i++) {
-		int err = reftable_iterator_seek_ref(&it, "c");
-		check(!err);
-
-		err = reftable_iterator_next_ref(&it, &rec);
-		check(!err);
-		err = reftable_ref_record_equal(&rec, &r1[1], REFTABLE_HASH_SIZE_SHA1);
-		check(err == 1);
-
-		err = reftable_iterator_next_ref(&it, &rec);
-		check(!err);
-		err = reftable_ref_record_equal(&rec, &r2[1], REFTABLE_HASH_SIZE_SHA1);
-		check(err == 1);
-
-		err = reftable_iterator_next_ref(&it, &rec);
-		check(err > 0);
-	}
-
-	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
-		reftable_buf_release(&bufs[i]);
-	readers_destroy(readers, ARRAY_SIZE(refs));
-	reftable_ref_record_release(&rec);
-	reftable_iterator_destroy(&it);
-	reftable_merged_table_free(mt);
-	reftable_free(sources);
-}
-
-static void t_merged_seek_multiple_times_without_draining(void)
-{
-	struct reftable_ref_record r1[] = {
-		{
-			.refname = (char *) "a",
-			.update_index = 1,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 1 },
-		},
-		{
-			.refname = (char *) "c",
-			.update_index = 1,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 2 },
-		}
-	};
-	struct reftable_ref_record r2[] = {
-		{
-			.refname = (char *) "b",
-			.update_index = 2,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 3 },
-		},
-		{
-			.refname = (char *) "d",
-			.update_index = 2,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 4 },
-		},
-	};
-	struct reftable_ref_record *refs[] = {
-		r1, r2,
-	};
-	size_t sizes[] = {
-		ARRAY_SIZE(r1), ARRAY_SIZE(r2),
-	};
-	struct reftable_buf bufs[] = {
-		REFTABLE_BUF_INIT, REFTABLE_BUF_INIT,
-	};
-	struct reftable_block_source *sources = NULL;
-	struct reftable_reader **readers = NULL;
-	struct reftable_ref_record rec = { 0 };
-	struct reftable_iterator it = { 0 };
-	struct reftable_merged_table *mt;
-	int err;
-
-	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
-	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
-
-	err = reftable_iterator_seek_ref(&it, "b");
-	check(!err);
-	err = reftable_iterator_next_ref(&it, &rec);
-	check(!err);
-	err = reftable_ref_record_equal(&rec, &r2[0], REFTABLE_HASH_SIZE_SHA1);
-	check(err == 1);
-
-	err = reftable_iterator_seek_ref(&it, "a");
-	check(!err);
-	err = reftable_iterator_next_ref(&it, &rec);
-	check(!err);
-	err = reftable_ref_record_equal(&rec, &r1[0], REFTABLE_HASH_SIZE_SHA1);
-	check(err == 1);
-
-	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
-		reftable_buf_release(&bufs[i]);
-	readers_destroy(readers, ARRAY_SIZE(refs));
-	reftable_ref_record_release(&rec);
-	reftable_iterator_destroy(&it);
-	reftable_merged_table_free(mt);
-	reftable_free(sources);
-}
-
-static struct reftable_merged_table *
-merged_table_from_log_records(struct reftable_log_record **logs,
-			      struct reftable_block_source **source,
-			      struct reftable_reader ***readers, const size_t *sizes,
-			      struct reftable_buf *buf, const size_t n)
-{
-	struct reftable_merged_table *mt = NULL;
-	struct reftable_write_options opts = {
-		.block_size = 256,
-		.exact_log_message = 1,
-	};
-	int err;
-
-	REFTABLE_CALLOC_ARRAY(*readers, n);
-	check(*readers != NULL);
-	REFTABLE_CALLOC_ARRAY(*source, n);
-	check(*source != NULL);
-
-	for (size_t i = 0; i < n; i++) {
-		t_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
-		block_source_from_buf(&(*source)[i], &buf[i]);
-
-		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
-					  "name");
-		check(!err);
-	}
-
-	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
-	check(!err);
-	return mt;
-}
-
-static void t_merged_logs(void)
-{
-	struct reftable_log_record r1[] = {
-		{
-			.refname = (char *) "a",
-			.update_index = 2,
-			.value_type = REFTABLE_LOG_UPDATE,
-			.value.update = {
-				.old_hash = { 2 },
-				/* deletion */
-				.name = (char *) "jane doe",
-				.email = (char *) "jane@invalid",
-				.message = (char *) "message2",
-			}
-		},
-		{
-			.refname = (char *) "a",
-			.update_index = 1,
-			.value_type = REFTABLE_LOG_UPDATE,
-			.value.update = {
-				.old_hash = { 1 },
-				.new_hash = { 2 },
-				.name = (char *) "jane doe",
-				.email = (char *) "jane@invalid",
-				.message = (char *) "message1",
-			}
-		},
-	};
-	struct reftable_log_record r2[] = {
-		{
-			.refname = (char *) "a",
-			.update_index = 3,
-			.value_type = REFTABLE_LOG_UPDATE,
-			.value.update = {
-				.new_hash = { 3 },
-				.name = (char *) "jane doe",
-				.email = (char *) "jane@invalid",
-				.message = (char *) "message3",
-			}
-		},
-	};
-	struct reftable_log_record r3[] = {
-		{
-			.refname = (char *) "a",
-			.update_index = 2,
-			.value_type = REFTABLE_LOG_DELETION,
-		},
-	};
-	struct reftable_log_record *want[] = {
-		&r2[0],
-		&r3[0],
-		&r1[1],
-	};
-
-	struct reftable_log_record *logs[] = { r1, r2, r3 };
-	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
-	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
-	struct reftable_block_source *bs = NULL;
-	struct reftable_reader **readers = NULL;
-	struct reftable_merged_table *mt = merged_table_from_log_records(
-		logs, &bs, &readers, sizes, bufs, 3);
-	struct reftable_iterator it = { 0 };
-	int err;
-	struct reftable_log_record *out = NULL;
-	size_t len = 0;
-	size_t cap = 0;
-	size_t i;
-
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
-	check(!err);
-	err = reftable_iterator_seek_log(&it, "a");
-	check(!err);
-	check_int(reftable_merged_table_hash_id(mt), ==, REFTABLE_HASH_SHA1);
-	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
-	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
-
-	while (len < 100) { /* cap loops/recursion. */
-		struct reftable_log_record log = { 0 };
-		int err = reftable_iterator_next_log(&it, &log);
-		if (err > 0)
-			break;
-
-		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
-		out[len++] = log;
-	}
-	reftable_iterator_destroy(&it);
-
-	check_int(ARRAY_SIZE(want), ==, len);
-	for (i = 0; i < len; i++)
-		check(reftable_log_record_equal(want[i], &out[i],
-						 REFTABLE_HASH_SIZE_SHA1));
-
-	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
-	check(!err);
-	err = reftable_iterator_seek_log_at(&it, "a", 2);
-	check(!err);
-	reftable_log_record_release(&out[0]);
-	err = reftable_iterator_next_log(&it, &out[0]);
-	check(!err);
-	check(reftable_log_record_equal(&out[0], &r3[0], REFTABLE_HASH_SIZE_SHA1));
-	reftable_iterator_destroy(&it);
-
-	for (i = 0; i < len; i++)
-		reftable_log_record_release(&out[i]);
-	reftable_free(out);
-
-	for (i = 0; i < 3; i++)
-		reftable_buf_release(&bufs[i]);
-	readers_destroy(readers, 3);
-	reftable_merged_table_free(mt);
-	reftable_free(bs);
-}
-
-static void t_default_write_opts(void)
-{
-	struct reftable_write_options opts = { 0 };
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	struct reftable_ref_record rec = {
-		.refname = (char *) "master",
-		.update_index = 1,
-	};
-	int err;
-	struct reftable_block_source source = { 0 };
-	uint32_t hash_id;
-	struct reftable_reader *rd = NULL;
-	struct reftable_merged_table *merged = NULL;
-
-	reftable_writer_set_limits(w, 1, 1);
-
-	err = reftable_writer_add_ref(w, &rec);
-	check(!err);
-
-	err = reftable_writer_close(w);
-	check(!err);
-	reftable_writer_free(w);
-
-	block_source_from_buf(&source, &buf);
-
-	err = reftable_reader_new(&rd, &source, "filename");
-	check(!err);
-
-	hash_id = reftable_reader_hash_id(rd);
-	check_int(hash_id, ==, REFTABLE_HASH_SHA1);
-
-	err = reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA256);
-	check_int(err, ==, REFTABLE_FORMAT_ERROR);
-	err = reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA1);
-	check(!err);
-
-	reftable_reader_decref(rd);
-	reftable_merged_table_free(merged);
-	reftable_buf_release(&buf);
-}
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
diff --git a/t/unit-tests/u-reftable-merged.c b/t/unit-tests/u-reftable-merged.c
new file mode 100644
index 0000000000..48c8f9f6b5
--- /dev/null
+++ b/t/unit-tests/u-reftable-merged.c
@@ -0,0 +1,515 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "unit-test.h"
+#include "lib-reftable.h"
+#include "reftable/blocksource.h"
+#include "reftable/constants.h"
+#include "reftable/merged.h"
+#include "reftable/reader.h"
+#include "reftable/reftable-error.h"
+#include "reftable/reftable-merged.h"
+#include "reftable/reftable-writer.h"
+
+static struct reftable_merged_table *
+merged_table_from_records(struct reftable_ref_record **refs,
+			  struct reftable_block_source **source,
+			  struct reftable_reader ***readers, const size_t *sizes,
+			  struct reftable_buf *buf, const size_t n)
+{
+	struct reftable_merged_table *mt = NULL;
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	int err;
+
+	REFTABLE_CALLOC_ARRAY(*readers, n);
+	cl_assert(*readers != NULL);
+	REFTABLE_CALLOC_ARRAY(*source, n);
+	cl_assert(*source != NULL);
+
+	for (size_t i = 0; i < n; i++) {
+		cl_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
+		block_source_from_buf(&(*source)[i], &buf[i]);
+
+		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
+					  "name");
+		cl_assert(err == 0);
+	}
+
+	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
+	cl_assert(err == 0);
+	return mt;
+}
+
+static void readers_destroy(struct reftable_reader **readers, const size_t n)
+{
+	for (size_t i = 0; i < n; i++)
+		reftable_reader_decref(readers[i]);
+	reftable_free(readers);
+}
+
+void test_reftable_merged__merged_single_record(void)
+{
+	struct reftable_ref_record r1[] = { {
+		.refname = (char *) "b",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_VAL1,
+		.value.val1 = { 1, 2, 3, 0 },
+	} };
+	struct reftable_ref_record r2[] = { {
+		.refname = (char *) "a",
+		.update_index = 2,
+		.value_type = REFTABLE_REF_DELETION,
+	} };
+	struct reftable_ref_record r3[] = { {
+		.refname = (char *) "c",
+		.update_index = 3,
+		.value_type = REFTABLE_REF_DELETION,
+	} };
+
+	struct reftable_ref_record *refs[] = { r1, r2, r3 };
+	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
+	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
+	struct reftable_block_source *bs = NULL;
+	struct reftable_reader **readers = NULL;
+	struct reftable_merged_table *mt =
+		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	int err;
+
+	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	cl_assert(err == 0);
+	err = reftable_iterator_seek_ref(&it, "a");
+	cl_assert(err == 0);
+
+	err = reftable_iterator_next_ref(&it, &ref);
+	cl_assert(err == 0);
+	cl_assert(reftable_ref_record_equal(&r2[0], &ref, REFTABLE_HASH_SIZE_SHA1) != 0);
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	readers_destroy(readers, 3);
+	reftable_merged_table_free(mt);
+	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
+		reftable_buf_release(&bufs[i]);
+	reftable_free(bs);
+}
+
+void test_reftable_merged__merged_refs(void)
+{
+	struct reftable_ref_record r1[] = {
+		{
+			.refname = (char *) "a",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 1 },
+		},
+		{
+			.refname = (char *) "b",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 1 },
+		},
+		{
+			.refname = (char *) "c",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 1 },
+		}
+	};
+	struct reftable_ref_record r2[] = { {
+		.refname = (char *) "a",
+		.update_index = 2,
+		.value_type = REFTABLE_REF_DELETION,
+	} };
+	struct reftable_ref_record r3[] = {
+		{
+			.refname = (char *) "c",
+			.update_index = 3,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 2 },
+		},
+		{
+			.refname = (char *) "d",
+			.update_index = 3,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 1 },
+		},
+	};
+
+	struct reftable_ref_record *want[] = {
+		&r2[0],
+		&r1[1],
+		&r3[0],
+		&r3[1],
+	};
+
+	struct reftable_ref_record *refs[] = { r1, r2, r3 };
+	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
+	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
+	struct reftable_block_source *bs = NULL;
+	struct reftable_reader **readers = NULL;
+	struct reftable_merged_table *mt =
+		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
+	struct reftable_iterator it = { 0 };
+	int err;
+	struct reftable_ref_record *out = NULL;
+	size_t len = 0;
+	size_t cap = 0;
+	size_t i;
+
+	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	cl_assert(err == 0);
+	err = reftable_iterator_seek_ref(&it, "a");
+	cl_assert(err == 0);
+	cl_assert_equal_i(reftable_merged_table_hash_id(mt), REFTABLE_HASH_SHA1);
+	cl_assert_equal_i(reftable_merged_table_min_update_index(mt), 1);
+	cl_assert_equal_i(reftable_merged_table_max_update_index(mt), 3);
+
+	while (len < 100) { /* cap loops/recursion. */
+		struct reftable_ref_record ref = { 0 };
+		int err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0)
+			break;
+
+		cl_assert(REFTABLE_ALLOC_GROW(out, len + 1, cap) == 0);
+		out[len++] = ref;
+	}
+	reftable_iterator_destroy(&it);
+
+	cl_assert_equal_i(ARRAY_SIZE(want), len);
+	for (i = 0; i < len; i++)
+		cl_assert(reftable_ref_record_equal(want[i], &out[i],
+											REFTABLE_HASH_SIZE_SHA1) != 0);
+	for (i = 0; i < len; i++)
+		reftable_ref_record_release(&out[i]);
+	reftable_free(out);
+
+	for (i = 0; i < 3; i++)
+		reftable_buf_release(&bufs[i]);
+	readers_destroy(readers, 3);
+	reftable_merged_table_free(mt);
+	reftable_free(bs);
+}
+
+void test_reftable_merged__merged_seek_multiple_times(void)
+{
+	struct reftable_ref_record r1[] = {
+		{
+			.refname = (char *) "a",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 1 },
+		},
+		{
+			.refname = (char *) "c",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 2 },
+		}
+	};
+	struct reftable_ref_record r2[] = {
+		{
+			.refname = (char *) "b",
+			.update_index = 2,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 3 },
+		},
+		{
+			.refname = (char *) "d",
+			.update_index = 2,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 4 },
+		},
+	};
+	struct reftable_ref_record *refs[] = {
+		r1, r2,
+	};
+	size_t sizes[] = {
+		ARRAY_SIZE(r1), ARRAY_SIZE(r2),
+	};
+	struct reftable_buf bufs[] = {
+		REFTABLE_BUF_INIT, REFTABLE_BUF_INIT,
+	};
+	struct reftable_block_source *sources = NULL;
+	struct reftable_reader **readers = NULL;
+	struct reftable_ref_record rec = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_merged_table *mt;
+
+	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+
+	for (size_t i = 0; i < 5; i++) {
+		int err = reftable_iterator_seek_ref(&it, "c");
+		cl_assert(err == 0);
+
+		cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
+		cl_assert_equal_i(reftable_ref_record_equal(&rec, &r1[1],
+													REFTABLE_HASH_SIZE_SHA1), 1);
+
+		cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
+		cl_assert_equal_i(reftable_ref_record_equal(&rec, &r2[1],
+													REFTABLE_HASH_SIZE_SHA1), 1);
+
+		cl_assert(reftable_iterator_next_ref(&it, &rec) > 0);
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
+		reftable_buf_release(&bufs[i]);
+	readers_destroy(readers, ARRAY_SIZE(refs));
+	reftable_ref_record_release(&rec);
+	reftable_iterator_destroy(&it);
+	reftable_merged_table_free(mt);
+	reftable_free(sources);
+}
+
+void test_reftable_merged__merged_seek_multiple_times_no_drain(void)
+{
+	struct reftable_ref_record r1[] = {
+		{
+			.refname = (char *) "a",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 1 },
+		},
+		{
+			.refname = (char *) "c",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 2 },
+		}
+	};
+	struct reftable_ref_record r2[] = {
+		{
+			.refname = (char *) "b",
+			.update_index = 2,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 3 },
+		},
+		{
+			.refname = (char *) "d",
+			.update_index = 2,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 4 },
+		},
+	};
+	struct reftable_ref_record *refs[] = {
+		r1, r2,
+	};
+	size_t sizes[] = {
+		ARRAY_SIZE(r1), ARRAY_SIZE(r2),
+	};
+	struct reftable_buf bufs[] = {
+		REFTABLE_BUF_INIT, REFTABLE_BUF_INIT,
+	};
+	struct reftable_block_source *sources = NULL;
+	struct reftable_reader **readers = NULL;
+	struct reftable_ref_record rec = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_merged_table *mt;
+
+	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+
+	cl_assert(reftable_iterator_seek_ref(&it, "b") == 0);
+	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
+	cl_assert_equal_i(reftable_ref_record_equal(&rec, &r2[0],
+												REFTABLE_HASH_SIZE_SHA1), 1);
+
+	cl_assert(reftable_iterator_seek_ref(&it, "a") == 0);
+	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
+	cl_assert_equal_i(reftable_ref_record_equal(&rec, &r1[0],
+												REFTABLE_HASH_SIZE_SHA1), 1);
+
+	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
+		reftable_buf_release(&bufs[i]);
+	readers_destroy(readers, ARRAY_SIZE(refs));
+	reftable_ref_record_release(&rec);
+	reftable_iterator_destroy(&it);
+	reftable_merged_table_free(mt);
+	reftable_free(sources);
+}
+
+static struct reftable_merged_table *
+merged_table_from_log_records(struct reftable_log_record **logs,
+			      struct reftable_block_source **source,
+			      struct reftable_reader ***readers, const size_t *sizes,
+			      struct reftable_buf *buf, const size_t n)
+{
+	struct reftable_merged_table *mt = NULL;
+	struct reftable_write_options opts = {
+		.block_size = 256,
+		.exact_log_message = 1,
+	};
+	int err;
+
+	REFTABLE_CALLOC_ARRAY(*readers, n);
+	cl_assert(*readers != NULL);
+	REFTABLE_CALLOC_ARRAY(*source, n);
+	cl_assert(*source != NULL);
+
+	for (size_t i = 0; i < n; i++) {
+		cl_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
+		block_source_from_buf(&(*source)[i], &buf[i]);
+
+		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
+					  "name");
+		cl_assert(err == 0);
+	}
+
+	cl_assert(reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1) == 0);
+	return mt;
+}
+
+void test_reftable_merged__merged_logs(void)
+{
+	struct reftable_log_record r1[] = {
+		{
+			.refname = (char *) "a",
+			.update_index = 2,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value.update = {
+				.old_hash = { 2 },
+				/* deletion */
+				.name = (char *) "jane doe",
+				.email = (char *) "jane@invalid",
+				.message = (char *) "message2",
+			}
+		},
+		{
+			.refname = (char *) "a",
+			.update_index = 1,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value.update = {
+				.old_hash = { 1 },
+				.new_hash = { 2 },
+				.name = (char *) "jane doe",
+				.email = (char *) "jane@invalid",
+				.message = (char *) "message1",
+			}
+		},
+	};
+	struct reftable_log_record r2[] = {
+		{
+			.refname = (char *) "a",
+			.update_index = 3,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value.update = {
+				.new_hash = { 3 },
+				.name = (char *) "jane doe",
+				.email = (char *) "jane@invalid",
+				.message = (char *) "message3",
+			}
+		},
+	};
+	struct reftable_log_record r3[] = {
+		{
+			.refname = (char *) "a",
+			.update_index = 2,
+			.value_type = REFTABLE_LOG_DELETION,
+		},
+	};
+	struct reftable_log_record *want[] = {
+		&r2[0],
+		&r3[0],
+		&r1[1],
+	};
+
+	struct reftable_log_record *logs[] = { r1, r2, r3 };
+	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
+	struct reftable_buf bufs[3] = { REFTABLE_BUF_INIT, REFTABLE_BUF_INIT, REFTABLE_BUF_INIT };
+	struct reftable_block_source *bs = NULL;
+	struct reftable_reader **readers = NULL;
+	struct reftable_merged_table *mt = merged_table_from_log_records(
+		logs, &bs, &readers, sizes, bufs, 3);
+	struct reftable_iterator it = { 0 };
+	struct reftable_log_record *out = NULL;
+	size_t len = 0;
+	size_t cap = 0;
+	size_t i;
+
+	cl_assert(merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG) == 0);
+	cl_assert(reftable_iterator_seek_log(&it, "a") == 0);
+	cl_assert_equal_i(reftable_merged_table_hash_id(mt), REFTABLE_HASH_SHA1);
+	cl_assert_equal_i(reftable_merged_table_min_update_index(mt), 1);
+	cl_assert_equal_i(reftable_merged_table_max_update_index(mt), 3);
+
+	while (len < 100) { /* cap loops/recursion. */
+		struct reftable_log_record log = { 0 };
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err > 0)
+			break;
+
+		cl_assert(REFTABLE_ALLOC_GROW(out, len + 1, cap) == 0);
+		out[len++] = log;
+	}
+	reftable_iterator_destroy(&it);
+
+	cl_assert_equal_i(ARRAY_SIZE(want), len);
+	for (i = 0; i < len; i++)
+		cl_assert(reftable_log_record_equal(want[i], &out[i],
+											REFTABLE_HASH_SIZE_SHA1) != 0);
+
+	cl_assert(merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG) == 0);
+	cl_assert(reftable_iterator_seek_log_at(&it, "a", 2) == 0);
+	reftable_log_record_release(&out[0]);
+	cl_assert(reftable_iterator_next_log(&it, &out[0]) == 0);
+	cl_assert(reftable_log_record_equal(&out[0], &r3[0],
+										REFTABLE_HASH_SIZE_SHA1) != 0);
+	reftable_iterator_destroy(&it);
+
+	for (i = 0; i < len; i++)
+		reftable_log_record_release(&out[i]);
+	reftable_free(out);
+
+	for (i = 0; i < 3; i++)
+		reftable_buf_release(&bufs[i]);
+	readers_destroy(readers, 3);
+	reftable_merged_table_free(mt);
+	reftable_free(bs);
+}
+
+void test_reftable_merged__default_write_opts(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_ref_record rec = {
+		.refname = (char *) "master",
+		.update_index = 1,
+	};
+	int err;
+	struct reftable_block_source source = { 0 };
+	uint32_t hash_id;
+	struct reftable_reader *rd = NULL;
+	struct reftable_merged_table *merged = NULL;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	cl_assert(reftable_writer_add_ref(w, &rec) == 0);
+
+	cl_assert(reftable_writer_close(w) == 0);
+	reftable_writer_free(w);
+
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&rd, &source, "filename") == 0);
+
+	hash_id = reftable_reader_hash_id(rd);
+	cl_assert_equal_i(hash_id, REFTABLE_HASH_SHA1);
+
+	err = reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA256);
+	cl_assert_equal_i(err, REFTABLE_FORMAT_ERROR);
+	cl_assert(reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA1) == 0);
+
+	reftable_reader_decref(rd);
+	reftable_merged_table_free(merged);
+	reftable_buf_release(&buf);
+}
-- 
2.43.0

