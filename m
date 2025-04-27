Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242091C695
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745780075; cv=none; b=Q1Ajy0RUUTZQaZ1PlqxvXIATGcHOT52y6r9hJJFURaT0HKBy7Be2zkTQJwNdAlJ9SuvTMARdA5V+BUbIlvXrr0qLgwo4TDFBQsgopAa0lKu5oP69miE0gwSMW3rakeKnTWCVwBkuIngtCFBIDgptBu8h0fH6oq+ISuekEOv7+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745780075; c=relaxed/simple;
	bh=Bl3iR3aZdmb1Anb85v5dcX/KOgmmkfE+kS3JQJwL//E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJOGhzluk/lvl1Ad8EGoglu8MG+MzkVrvZH8oJszYJPfQ6JZ0N0itspcShcfYUdnHcRYQGSc7CZvY0973K2xZ1Ms0nqjBq6p51RchMqWtLJgTXu3PQ68eo0JpC1ZoxhJQuj/ZyRTFYCZLaykEi8pCX1IA+T1frJh5bWa0Q7A6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icoam7ag; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icoam7ag"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c266c1389so2819197f8f.1
        for <git@vger.kernel.org>; Sun, 27 Apr 2025 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745780071; x=1746384871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwKU63SNDESTRCzbSgGxo044oeD3AblgHYFMSu/wh78=;
        b=icoam7ag2E8O5xai3R6kWorOP15jSlDhwVpp8GmqpeK6x0kA7R0EBWZmt8HvD2CaN2
         2zCucELHSxPQsZT8HStHlt22ZtcjWmJJJf1UqAz8awJEV3y5GnVls3a1qG57oisyzn97
         SllxkRrzlSH3K9JEu7qM0HlC+8lH2ItEs/Smeb2Q1l4p/slvH0DYBbg3KFNsiBDUA45r
         HBRt1Gw0L0QI6P//0LE7ClETMJXfymAJ4RVJKcrrfLfJx7saTNYmU1JBjpT54KKVavya
         sSyFPSLUveBEVc24ZZgo1z15QHnSgILG0XAilTtjMNCIgRfcpUYRwhi7bMK/ZxVX53BV
         z4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745780071; x=1746384871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwKU63SNDESTRCzbSgGxo044oeD3AblgHYFMSu/wh78=;
        b=EY6je5Mz5REQ8sk9WC75hynPGf3uI7w7wq1ioPEshJ3BGR7c0WhQ2m5r8i/l87Y2fy
         m55hMdLFzHgThDYx05D1z5aBpJ4/mVDNvSLhwAXD7Jw7Zpa+8xZGAe4wy1r93bS5EZrT
         MkmmdlNq5YwGclHRZYpiuZ06xgoyUMqHgDgI7XFnUWYHFh4cNce3KzurWiLkQ+tR/oj0
         VdPxPP/+Kmve205cCuBPSZUeVl131h+v2wYem5GOL7WmSa+/Jm8RLXl12okHp8erIhnH
         pWSWSOi67uUVY96sRnvbwVlUlB1S2yN+ameQemkgKLrxr/FQ0WEcK0hNzWVTbhF+im2n
         bLzw==
X-Gm-Message-State: AOJu0YwfqAELN1blpwImx4WAJrq8KA5oN1XxVhME1hjVsxH6iObKKgoE
	0Ze/LjJV38GQqanovVxR0YFFDpnrgumlMOuaa+Rs7fxMzq6yHzUVl6eeDKd8XywqoA==
X-Gm-Gg: ASbGncuhRXZmtOgm96Si+3ApNnxayqCY0TR4WUgW0QMSRcxAxi7N5dn0uD1RtnL+/e8
	U+QqwO14MioAPOHOQaDxwazgY+tjHXfLyAJ6QztvpIQDGzY5graLHHF4kplbZzmWEGPQkdWpMU4
	DQZ/M07lgzM/AvSfJc1MoANGuSqsYkAd/086dHk1OLQfrepT+NLIWDzlus4D1XLHqF2E8T7M/Qq
	7etMSfmAduzs2aI640tBnGBE7lD1/2YhQ/uSY0FRxPEsD10DXeaisEMXxlR1Nzic2YYQTRZ/Bdh
	GJz4AKdExXifzJ6J2yR1LUy5Su4OlrCJe0a3
X-Google-Smtp-Source: AGHT+IFhcvfUR9A2bpfilGriok+gHvizlWGkqQL6txEA/MIjs8+wbxiX8KICU+16t6TRMVFVFLw1xw==
X-Received: by 2002:a05:6000:2282:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-3a074e3cf36mr7703551f8f.33.1745780071081;
        Sun, 27 Apr 2025 11:54:31 -0700 (PDT)
Received: from localhost.localdomain ([105.113.116.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cc74sm9150175f8f.11.2025.04.27.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 11:54:30 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 1/9] t/unit-tests: adapt lib-reftable{c,h} helper functions to clar
Date: Sun, 27 Apr 2025 19:53:43 +0100
Message-ID: <20250427185351.82520-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427185351.82520-1-kuforiji98@gmail.com>
References: <20250427185351.82520-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
required for the reftable-related test files to run efficeintly. In the
current implementation these functions are designed to conform with our
homegrown unit-testing structure. So in other to convert the reftable
test files, there is need for a clar specific implementation of these
helper functions.

type cast `for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++)`
Adapt functions in lib-reftable.{c,h} to use clar. These functions
conform with the clar testing framework and become available for all
reftable-related test files implemented using the clar testing
framework, which requires them. This will be used by subsequent commits.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                    |  4 ++--
 t/meson.build               |  4 ++--
 t/unit-tests/lib-reftable.c | 26 +++++++++++++-------------
 t/unit-tests/lib-reftable.h |  6 +++---
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index 13f9062a05..1a0f8c30cd 100644
--- a/Makefile
+++ b/Makefile
@@ -1371,8 +1371,9 @@ CLAR_TEST_SUITES += u-urlmatch-normalization
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
-CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
@@ -1384,7 +1385,6 @@ UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
-UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
diff --git a/t/meson.build b/t/meson.build
index bfb744e886..0102894b6f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -18,8 +18,9 @@ clar_test_suites = [
 
 clar_sources = [
   'unit-tests/clar/clar.c',
+  'unit-tests/lib-oid.c',
+  'unit-tests/lib-reftable.c',
   'unit-tests/unit-test.c',
-  'unit-tests/lib-oid.c'
 ]
 
 clar_decls_h = custom_target(
@@ -69,7 +70,6 @@ foreach unit_test_program : unit_test_programs
   unit_test = executable(unit_test_name,
     sources: [
       'unit-tests/test-lib.c',
-      'unit-tests/lib-reftable.c',
       unit_test_program,
     ],
     dependencies: [libgit_commonmain],
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index 8a69612266..414364166f 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -1,12 +1,12 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "lib-reftable.h"
-#include "test-lib.h"
+#include "unit-test.h"
 #include "reftable/constants.h"
 #include "reftable/writer.h"
 #include "strbuf.h"
 
-void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
+void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
 {
 	memset(p, (uint8_t)i, hash_size(id));
 }
@@ -22,17 +22,17 @@ static int strbuf_writer_flush(void *arg UNUSED)
 	return 0;
 }
 
-struct reftable_writer *t_reftable_strbuf_writer(struct reftable_buf *buf,
+struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
 						 struct reftable_write_options *opts)
 {
 	struct reftable_writer *writer;
 	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
 				      buf, opts);
-	check(!ret);
+	cl_assert(ret == 0);
 	return writer;
 }
 
-void t_reftable_write_to_buf(struct reftable_buf *buf,
+void cl_reftable_write_to_buf(struct reftable_buf *buf,
 			     struct reftable_ref_record *refs,
 			     size_t nrefs,
 			     struct reftable_log_record *logs,
@@ -64,35 +64,35 @@ void t_reftable_write_to_buf(struct reftable_buf *buf,
 			min = ui;
 	}
 
-	writer = t_reftable_strbuf_writer(buf, &opts);
+	writer = cl_reftable_strbuf_writer(buf, &opts);
 	reftable_writer_set_limits(writer, min, max);
 
 	if (nrefs) {
 		ret = reftable_writer_add_refs(writer, refs, nrefs);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 	}
 
 	if (nlogs) {
 		ret = reftable_writer_add_logs(writer, logs, nlogs);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 	}
 
 	ret = reftable_writer_close(writer);
-	check_int(ret, ==, 0);
+	cl_assert_equal_i(ret, 0);
 
 	stats = reftable_writer_stats(writer);
-	for (size_t i = 0; i < stats->ref_stats.blocks; i++) {
+	for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++) {
 		size_t off = i * (opts.block_size ? opts.block_size
 						  : DEFAULT_BLOCK_SIZE);
 		if (!off)
 			off = header_size(opts.hash_id == REFTABLE_HASH_SHA256 ? 2 : 1);
-		check_char(buf->buf[off], ==, 'r');
+		cl_assert(buf->buf[off] == 'r');
 	}
 
 	if (nrefs)
-		check_int(stats->ref_stats.blocks, >, 0);
+		cl_assert(stats->ref_stats.blocks > 0);
 	if (nlogs)
-		check_int(stats->log_stats.blocks, >, 0);
+		cl_assert(stats->log_stats.blocks > 0);
 
 	reftable_writer_free(writer);
 }
diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftable.h
index e4c360fa7e..2958db5dc0 100644
--- a/t/unit-tests/lib-reftable.h
+++ b/t/unit-tests/lib-reftable.h
@@ -6,12 +6,12 @@
 
 struct reftable_buf;
 
-void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
+void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
 
-struct reftable_writer *t_reftable_strbuf_writer(struct reftable_buf *buf,
+struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
 						 struct reftable_write_options *opts);
 
-void t_reftable_write_to_buf(struct reftable_buf *buf,
+void cl_reftable_write_to_buf(struct reftable_buf *buf,
 			     struct reftable_ref_record *refs,
 			     size_t nrecords,
 			     struct reftable_log_record *logs,
-- 
2.43.0

