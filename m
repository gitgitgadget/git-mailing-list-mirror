Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330C272E58
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132527; cv=none; b=DyP9ACrMmxk0gIrK+HQ0dK3/NdK/Q4PF7fSImvduMUtsah4vz5dVbQ7s+rI3RWZaWQdumg7j8LCKiEE1Sf8AYfZ9WlmaeNKI91K39IWUOYtc3la2Df8daydRubCPtyldht3H2nZY5rhT9LdgwFxeKjjQtFgzPcyO6/kD4B2aINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132527; c=relaxed/simple;
	bh=2BBVAs08HCQfmctlXDVVRd9uH5rWWYx5YUhhtbZbDi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSwa7Pzw8kWu37Ovlk21l377ZiFcdAP4geClFIGHGveScfipSrZI/kazdRB32Y0/y48gyAXiMo/aA/fdK0Qq/61hffobMhqgyyZ164mhf22w1RnZjzHEv+w526P1Vo418LwGaHWpYtbbLqvrLiaMnhVjexxU84P0suGfPWUuaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3vojFX5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3vojFX5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso10232805e9.0
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749132523; x=1749737323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HIMb7RGY9AEc37n5etDhn29o6szr6hVnI0m0ID/ZYQ=;
        b=I3vojFX5BY37QQORvGjIDhZGeEU4krQxBFJKW9ISwS7/pmihC2FWZzGiYtciNc5Xra
         Ler7ucwnbZ68XExIO7PSfm4xNMfwshGM362xBU4tM9PGVndhLoS6UPojBsQR8CyOF4WB
         rqpA2Fad1b5XranzzoHNjs4BwzXl3cXx5UrpCSoIFGWQebJWxg+1441YL0i5YXFIU+vA
         eQrb23JOwslvcHpmrPORpXfbmi4qiW7z9tGlYVmWJAgPAkNpCRbCNFm3UFE8VqOlZrre
         64eJowT5L+pxt2K0pOLLVhtQjUzWG/N7TgCDTjUWZ6XwpN6utI/HlVDVM20OtTJDWCOy
         waAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132523; x=1749737323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HIMb7RGY9AEc37n5etDhn29o6szr6hVnI0m0ID/ZYQ=;
        b=Nn1PYpCOBZiQmv+waVy0rWFaCXmXcXEL2R67aE/UZzsAivvCvmhGl0wF39SeSc17z5
         uDtg273RNIZ2DVLbvD4jrNJ4tPoMPQuPj4qrLCsxkWm2SdJWAswGF5TSxVqk4L5Ug9TS
         QlxSEY6nUp4ALR99XNdZjDn7fBSmWGzZwgAWAfK4kBqrQxZOmm1/InxIn6D18xaXt45A
         opTm9WJlaZfMJZpSVFzfUGgQMf8sqc5KyyTapJWp3Q2Yz6i2pUUmz2ycUUhhBdbKTvNL
         JjyobnexZYGMdlzjm5BV29ulJUDSXkYIpdwSbwz9e2ty6sRM33JFrAF1wconqOKQ+9jv
         hzUQ==
X-Gm-Message-State: AOJu0Yxsvi5lo/PwncnPhagGytWm7cCZ1Wx703TVLAmLrAI6qkOREDsV
	RqeJxEMY733AcbSgZ17LGwPl4mjdoRYJ4PjGBbYI3out6ivCsIIh6f/hi5l6ppkwUCE=
X-Gm-Gg: ASbGnct5GTPlH3vcuFLjy4+Y08CfIimRlv7ojCEMUFn3LyP4+wD0kNCmGu23lXnEztD
	xSey6SNUhgjiYV5DUNviHa8ZsNHYxoERezf7lMeL0zVJ/xTNp18Az8lVQycfF4dH7n9M/MpSARg
	Oo09xMRsU65TOIyMmsV1Fnl8Z5jYjdLyysbGMK+//Bao714R5FqFKhB8B2+Vpu7moalQxo0aDfm
	12n1sbRIeqXm2TRNsOFeCmogxy06Hqwh2d+TXacaU8YU+UCr1nM1sQswM1hEoHhGOZh2yyuj4rV
	f+go/BKgPry1jIwyFoDKbCnb0iAhOCIQMHS8xG7+6CkrZA==
X-Google-Smtp-Source: AGHT+IHkDeO2tRT2U8ZGZL9oBhZ9m6CWhsja1CgWWhZAvYsHTbYgEo31IT/xy1W/qj19UvzcxBfemA==
X-Received: by 2002:a05:600c:6287:b0:442:e0e0:250 with SMTP id 5b1f17b1804b1-451f0b2606fmr64048125e9.29.1749132522606;
        Thu, 05 Jun 2025 07:08:42 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm8827305e9.27.2025.06.05.07.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:08:41 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v4 10/10] t/unit-tests: finalize migration of reftable-related tests
Date: Thu,  5 Jun 2025 15:06:44 +0100
Message-ID: <20250605140644.239199-11-kuforiji98@gmail.com>
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

The old `lib-reftable.{c,h}` implemented helper functions for our
homegrown unit-testing framework. As part of migrating reftable-related
tests to the Clar framework, Clar-specific versions of these functions
in `lib-reftable-clar.{c,h}` were introduced.

Now that all test files using these helpers have been converted to Clar,
we can safely remove the original `lib-reftable.{c,h}` and rename the
Clar- specific versions back to `lib-reftable.{c,h}`. This restores a
clean and consistent naming scheme for shared test utilities.

Finally, update our build system to reflect the changes made and remove
redundant code related to the reftable tests and our old homegrown
unit-testing setup. `test-lib.{c,h}` remains unchanged in our build
system as some files particularly `t/helper/test-example-tap.c` depends
on it in order to run, and removing that would be beyond the scope of
this patch.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                            |   8 +--
 t/Makefile                          |   1 -
 t/meson.build                       |  21 +-----
 t/unit-tests/lib-reftable-clar.c    | 101 ----------------------------
 t/unit-tests/lib-reftable-clar.h    |  20 ------
 t/unit-tests/lib-reftable.c         |  35 +++++-----
 t/unit-tests/lib-reftable.h         |  15 ++---
 t/unit-tests/u-reftable-basics.c    |   2 +-
 t/unit-tests/u-reftable-block.c     |   2 +-
 t/unit-tests/u-reftable-merged.c    |   2 +-
 t/unit-tests/u-reftable-pq.c        |   2 +-
 t/unit-tests/u-reftable-readwrite.c |   2 +-
 t/unit-tests/u-reftable-record.c    |   2 +-
 t/unit-tests/u-reftable-stack.c     |   4 +-
 t/unit-tests/u-reftable-table.c     |   2 +-
 15 files changed, 39 insertions(+), 180 deletions(-)
 delete mode 100644 t/unit-tests/lib-reftable-clar.c
 delete mode 100644 t/unit-tests/lib-reftable-clar.h

diff --git a/Makefile b/Makefile
index 8ed8f234f4..25e6558b7b 100644
--- a/Makefile
+++ b/Makefile
@@ -1380,13 +1380,11 @@ CLAR_TEST_SUITES += u-urlmatch-normalization
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
-CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
-CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
-UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
@@ -3971,4 +3969,4 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 	$(OBJCOPY) --localize-hidden $^ $@
 
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
-	$(AR) $(ARFLAGS) $@ $^
\ No newline at end of file
+	$(AR) $(ARFLAGS) $@ $^
diff --git a/t/Makefile b/t/Makefile
index 791e0a0978..757674e727 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -125,7 +125,6 @@ check-meson:
 	@mkdir -p mesontmp && \
 	printf "%s\n" \
 		"integration_tests t[0-9][0-9][0-9][0-9]-*.sh" \
-		"unit_test_programs unit-tests/t-*.c" \
 		"clar_test_suites unit-tests/u-*.c" | \
 	while read -r variable pattern; do \
 		awk "/^$$variable = \[\$$/ {flag=1 ; next } /^]$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047,\$$/, \"\"); print }" meson.build >mesontmp/meson.txt && \
diff --git a/t/meson.build b/t/meson.build
index fcbb659263..be96a9639f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -28,7 +28,7 @@ clar_sources = [
   'unit-tests/clar/clar.c',
   'unit-tests/unit-test.c',
   'unit-tests/lib-oid.c',
-  'unit-tests/lib-reftable-clar.c'
+  'unit-tests/lib-reftable.c'
 ]
 
 clar_decls_h = custom_target(
@@ -62,25 +62,6 @@ clar_unit_tests = executable('unit-tests',
 )
 test('unit-tests', clar_unit_tests)
 
-unit_test_programs = [
-]
-
-foreach unit_test_program : unit_test_programs
-  unit_test_name = fs.stem(unit_test_program)
-  unit_test = executable(unit_test_name,
-    sources: [
-      'unit-tests/test-lib.c',
-      'unit-tests/lib-reftable.c',
-      unit_test_program,
-    ],
-    dependencies: [libgit_commonmain],
-  )
-  test(unit_test_name, unit_test,
-    workdir: meson.current_source_dir(),
-    timeout: 0,
-  )
-endforeach
-
 subdir('helper')
 
 integration_tests = [
diff --git a/t/unit-tests/lib-reftable-clar.c b/t/unit-tests/lib-reftable-clar.c
deleted file mode 100644
index 64e40a106e..0000000000
--- a/t/unit-tests/lib-reftable-clar.c
+++ /dev/null
@@ -1,101 +0,0 @@
-#include "unit-test.h"
-#include "lib-reftable-clar.h"
-#include "hex.h"
-#include "parse-options.h"
-#include "reftable/constants.h"
-#include "reftable/writer.h"
-#include "strbuf.h"
-#include "string-list.h"
-#include "strvec.h"
-
-void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
-{
-	memset(p, (uint8_t)i, hash_size(id));
-}
-
-static ssize_t strbuf_writer_write(void *b, const void *data, size_t sz)
-{
-	strbuf_add(b, data, sz);
-	return sz;
-}
-
-static int strbuf_writer_flush(void *arg UNUSED)
-{
-	return 0;
-}
-
-struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
-						 struct reftable_write_options *opts)
-{
-	struct reftable_writer *writer;
-	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
-				      buf, opts);
-	cl_assert(!ret);
-	return writer;
-}
-
-void cl_reftable_write_to_buf(struct reftable_buf *buf,
-			     struct reftable_ref_record *refs,
-			     size_t nrefs,
-			     struct reftable_log_record *logs,
-			     size_t nlogs,
-			     struct reftable_write_options *_opts)
-{
-	struct reftable_write_options opts = { 0 };
-	const struct reftable_stats *stats;
-	struct reftable_writer *writer;
-	uint64_t min = 0xffffffff;
-	uint64_t max = 0;
-	int ret;
-
-	if (_opts)
-		opts = *_opts;
-
-	for (size_t i = 0; i < nrefs; i++) {
-		uint64_t ui = refs[i].update_index;
-		if (ui > max)
-			max = ui;
-		if (ui < min)
-			min = ui;
-	}
-	for (size_t i = 0; i < nlogs; i++) {
-		uint64_t ui = logs[i].update_index;
-		if (ui > max)
-			max = ui;
-		if (ui < min)
-			min = ui;
-	}
-
-	writer = cl_reftable_strbuf_writer(buf, &opts);
-	ret = reftable_writer_set_limits(writer, min, max);
-	cl_assert_equal_i(ret, 0);
-
-	if (nrefs) {
-		ret = reftable_writer_add_refs(writer, refs, nrefs);
-		cl_assert_equal_i(ret, 0);
-	}
-
-	if (nlogs) {
-		ret = reftable_writer_add_logs(writer, logs, nlogs);
-		cl_assert_equal_i(ret, 0);
-	}
-
-	ret = reftable_writer_close(writer);
-	cl_assert_equal_i(ret, 0);
-
-	stats = reftable_writer_stats(writer);
-	for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++) {
-		size_t off = i * (opts.block_size ? opts.block_size
-						  : DEFAULT_BLOCK_SIZE);
-		if (!off)
-			off = header_size(opts.hash_id == REFTABLE_HASH_SHA256 ? 2 : 1);
-		cl_assert(buf->buf[off] == 'r');
-	}
-
-	if (nrefs)
-		cl_assert(stats->ref_stats.blocks > 0);
-	if (nlogs)
-		cl_assert(stats->log_stats.blocks > 0);
-
-	reftable_writer_free(writer);
-}
diff --git a/t/unit-tests/lib-reftable-clar.h b/t/unit-tests/lib-reftable-clar.h
deleted file mode 100644
index b562648973..0000000000
--- a/t/unit-tests/lib-reftable-clar.h
+++ /dev/null
@@ -1,20 +0,0 @@
-#include "git-compat-util.h"
-#include "clar/clar.h"
-#include "clar-decls.h"
-#include "git-compat-util.h"
-#include "reftable/reftable-writer.h"
-#include "strbuf.h"
-
-struct reftable_buf;
-
-void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
-
-struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
-						  struct reftable_write_options *opts);
-
-void cl_reftable_write_to_buf(struct reftable_buf *buf,
-			     struct reftable_ref_record *refs,
-			     size_t nrecords,
-			     struct reftable_log_record *logs,
-			     size_t nlogs,
-			     struct reftable_write_options *opts);
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index 8a69612266..fdb5b11a20 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -1,12 +1,14 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
+#include "unit-test.h"
 #include "lib-reftable.h"
-#include "test-lib.h"
+#include "hex.h"
+#include "parse-options.h"
 #include "reftable/constants.h"
 #include "reftable/writer.h"
 #include "strbuf.h"
+#include "string-list.h"
+#include "strvec.h"
 
-void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
+void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
 {
 	memset(p, (uint8_t)i, hash_size(id));
 }
@@ -22,17 +24,17 @@ static int strbuf_writer_flush(void *arg UNUSED)
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
+	cl_assert(!ret);
 	return writer;
 }
 
-void t_reftable_write_to_buf(struct reftable_buf *buf,
+void cl_reftable_write_to_buf(struct reftable_buf *buf,
 			     struct reftable_ref_record *refs,
 			     size_t nrefs,
 			     struct reftable_log_record *logs,
@@ -64,35 +66,36 @@ void t_reftable_write_to_buf(struct reftable_buf *buf,
 			min = ui;
 	}
 
-	writer = t_reftable_strbuf_writer(buf, &opts);
-	reftable_writer_set_limits(writer, min, max);
+	writer = cl_reftable_strbuf_writer(buf, &opts);
+	ret = reftable_writer_set_limits(writer, min, max);
+	cl_assert(!ret);
 
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
index e4c360fa7e..d7e6d3136f 100644
--- a/t/unit-tests/lib-reftable.h
+++ b/t/unit-tests/lib-reftable.h
@@ -1,21 +1,20 @@
-#ifndef LIB_REFTABLE_H
-#define LIB_REFTABLE_H
-
+#include "git-compat-util.h"
+#include "clar/clar.h"
+#include "clar-decls.h"
 #include "git-compat-util.h"
 #include "reftable/reftable-writer.h"
+#include "strbuf.h"
 
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
 			     size_t nlogs,
 			     struct reftable_write_options *opts);
-
-#endif
diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
index f105c22d15..a0471083e7 100644
--- a/t/unit-tests/u-reftable-basics.c
+++ b/t/unit-tests/u-reftable-basics.c
@@ -7,7 +7,7 @@ license that can be found in the LICENSE file or at
 */
 
 #include "unit-test.h"
-#include "lib-reftable-clar.h"
+#include "lib-reftable.h"
 #include "reftable/basics.h"
 
 struct integer_needle_lesseq_args {
diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
index 97a1348563..f4bded7d26 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -7,7 +7,7 @@ license that can be found in the LICENSE file or at
 */
 
 #include "unit-test.h"
-#include "lib-reftable-clar.h"
+#include "lib-reftable.h"
 #include "reftable/block.h"
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
diff --git a/t/unit-tests/u-reftable-merged.c b/t/unit-tests/u-reftable-merged.c
index 62b02baa14..54cb7fc2a7 100644
--- a/t/unit-tests/u-reftable-merged.c
+++ b/t/unit-tests/u-reftable-merged.c
@@ -7,7 +7,7 @@ license that can be found in the LICENSE file or at
 */
 
 #include "unit-test.h"
-#include "lib-reftable-clar.h"
+#include "lib-reftable.h"
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/merged.h"
diff --git a/t/unit-tests/u-reftable-pq.c b/t/unit-tests/u-reftable-pq.c
index d55792ca6f..f8a28f6e07 100644
--- a/t/unit-tests/u-reftable-pq.c
+++ b/t/unit-tests/u-reftable-pq.c
@@ -7,7 +7,7 @@ license that can be found in the LICENSE file or at
 */
 
 #include "unit-test.h"
-#include "lib-reftable-clar.h"
+#include "lib-reftable.h"
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 #include "strbuf.h"
diff --git a/t/unit-tests/u-reftable-readwrite.c b/t/unit-tests/u-reftable-readwrite.c
index 9aac74a011..4d8c4be5f1 100644
--- a/t/unit-tests/u-reftable-readwrite.c
+++ b/t/unit-tests/u-reftable-readwrite.c
@@ -9,7 +9,7 @@ license that can be found in the LICENSE file or at
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "unit-test.h"
-#include "lib-reftable-clar.h"
+#include "lib-reftable.h"
 #include "reftable/basics.h"
 #include "reftable/blocksource.h"
 #include "reftable/reftable-error.h"
diff --git a/t/unit-tests/u-reftable-record.c b/t/unit-tests/u-reftable-record.c
index 650b0aa0d3..6c8c0d5374 100644
--- a/t/unit-tests/u-reftable-record.c
+++ b/t/unit-tests/u-reftable-record.c
@@ -7,7 +7,7 @@
 */
 
 #include "unit-test.h"
-#include "lib-reftable-clar.h"
+#include "lib-reftable.h"
 #include "reftable/basics.h"
 #include "reftable/constants.h"
 #include "reftable/record.h"
diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
index 0e3e3f4f4a..e4ea57138e 100644
--- a/t/unit-tests/u-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -10,7 +10,7 @@ license that can be found in the LICENSE file or at
 
 #include "unit-test.h"
 #include "dir.h"
-#include "lib-reftable-clar.h"
+#include "lib-reftable.h"
 #include "reftable/merged.h"
 #include "reftable/reftable-error.h"
 #include "reftable/stack.h"
@@ -497,7 +497,7 @@ void test_reftable_stack__add(void)
 	struct reftable_buf path = REFTABLE_BUF_INIT;
 	struct stat stat_result;
 	size_t i, N = ARRAY_SIZE(refs);
-	int err;
+	int err = 0;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	cl_assert(!err);
diff --git a/t/unit-tests/u-reftable-table.c b/t/unit-tests/u-reftable-table.c
index 839107d8a4..14fae8b199 100644
--- a/t/unit-tests/u-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -1,5 +1,5 @@
 #include "unit-test.h"
-#include "lib-reftable-clar.h"
+#include "lib-reftable.h"
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/iter.h"
-- 
2.43.0

