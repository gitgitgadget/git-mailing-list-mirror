Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAAC219A70
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867269; cv=none; b=a5699Dt8wPa0WJCQQmZUhB7fzQ11Ca99EH8wl7zfHFbYQy1kdmIK46Q9EC0ig2dFwLn9PkZjcqOkn1/101wqREoLbKdUK1wJDitwhlCdL7Sg8TSGbGPmc54Ua4n9rn6R1ll8mLPhJvWbt+bGmu+wGE7O3XDh57FI6xNaIfdSAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867269; c=relaxed/simple;
	bh=aXvGpYwr0VPJuwDX9y4CXkKLTcuXC9bftDC1j+qyxSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sY/7YGuwiEUK824jTg0zQkmqs8R3iO0nqZFjYuOHmTvFVuFObeRSXWBxeSaiM6Q+WTL6BSznv1NOcpr+f/VpgF8/0qWUyPfP2bP0iP95kSE481NiKvPxm3FG046EqHxn5bHqWSfn45KRYe8dd9uwkHNFiw5iIR3IWRldfXL4aEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyD1Gjfs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyD1Gjfs"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so46510885e9.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748867265; x=1749472065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66hZWb7Nl04NenJfGSR0mqoXuLUXaCZYrYNbGTV/3tY=;
        b=jyD1GjfsxjfaWjW0WdxN46G6VVw0Ajg92LdH6SAHytgygiG/mosUfprlPKiADyOGr4
         3b5USR5aw+eQCJcCQ7vimQemu3zCFEzGgA0TY6dSxR5p5uxMdUay/8P1IN4Clz9uwyV8
         QjAGNmhkPRyn4CyRu9rB/R070fq50UlOTLATlnEPbbAVVOwrpophKjuW9RN8pM8+hv+S
         ha5bjWDKDIZRqSFV2alCiW+OzXhY153ZJPYNvGSvdIX3uVovtjj6mbXhTnFV11WhhbUE
         K+kxJefopLYYrlfFWa9DSAzcr5Pd0q3PtHHwU/atH0ZNhXpQP/j+qNwIEX8MNE/y7RjX
         1OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748867265; x=1749472065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66hZWb7Nl04NenJfGSR0mqoXuLUXaCZYrYNbGTV/3tY=;
        b=CI5yLWGuWmxzxwdfCdCX4AhRe/JfLxgh68g6U6F9GJJSYFqDe24w97qOHYKL8rVn5l
         VHb7xMQ6T9xlyRWuppcNneaod2r1W1brNOssX3stmzj863yxki0HGmZh9OwO/4ql8iju
         1Uzs7X9RTOeYzI7PfY5GBPt6MmRs1TwyAbYtEooeLquo3qbb9p17rWJBFOhNTJAk2mWJ
         CTo6qesvL8pJCSXVQyH3LSx1Rm9pwCqgDLAMwzFvEUolgB4Oj/JUUYz38yBqiNIWaHWU
         VCill4JTwZISllSSgQVH7j0B7de2yzlD4suadWgm8oEMLGp+ImUrojKhZ4Fwv2C9IooF
         KoMw==
X-Gm-Message-State: AOJu0Yzau3EWjBIFu/2SbRVpo4g5Qo9VcqNxbpsoc6yhGbzEE7gyLxdS
	JQkR9ZAz5gwvvTadfQrpWJPhzmsBgEVKIpS3ZWnnT1m/2rWGVaGP4ja0kJ20DbEBkK0=
X-Gm-Gg: ASbGncuqfRQvmaaZgNzWpWXSGc7CEvS41Ma28Qz24PFsdWfCn5Pl7uvJA7gE4sQYC3P
	KnLeINQArV2pI53YZfFoQFHb84LavcNESeAG/G41ukm/LqpzbuvrTBoPKAGil3T/p5NjhR7irpN
	LgF2bbQjF8dr4W+00ptRbj5oc/qBu4hb+1Xo6Z25O3Lps93onpLRvDHiCSB7DiFJKkE0jEpAzi4
	v+6aYIqp1VOu4DIwlYMfLedrF/5dSgd3LPo6ymALh9TyLh6sdUyquwZJ+8vZEdWx/CNQ+O0MLcW
	JisOLRZGr/mdYchqlzNUF2gf98i358RXR7efIhTJ1Uj+zE8+kcCKmV9qfNbaorH2O7Wu+I/9TMQ
	E
X-Google-Smtp-Source: AGHT+IGvKsysc7UyRwgXs2PjuQxXPn9WiEPUm9p+p+oQ9Eg6fh24IUhRrNrA0yjDAGQvhnCjV8o3nw==
X-Received: by 2002:a05:600c:8509:b0:442:d9f2:c74e with SMTP id 5b1f17b1804b1-450d6580594mr109547295e9.23.1748867265162;
        Mon, 02 Jun 2025 05:27:45 -0700 (PDT)
Received: from localhost.localdomain ([105.113.90.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451d30a227csm51034145e9.0.2025.06.02.05.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:27:44 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 10/10] t/unit-tests: finalize migration of reftable-related tests
Date: Mon,  2 Jun 2025 13:25:58 +0100
Message-ID: <20250602122559.208780-11-kuforiji98@gmail.com>
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

The old `lib-reftable.{c,h}` implemented helper functions for our
homegrown unit-testing framework. As part of migrating reftable-related
tests to the Clar framework, Clar-specific versions of these functions
in `lib-reftable-clar.{c,h}` were introduced.

Now that all test files using these helpers have been converted to Clar, we
can safely remove the original `lib-reftable.{c,h}` and rename the Clar-
specific versions back to `lib-reftable.{c,h}`. This restores a clean and
consistent naming scheme for shared test utilities.

Finally, update our build system to reflect the changes made and remove
redundant code related to the reftable tests and our old homegrown
unit-testing setup.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                            |   6 +-
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
 15 files changed, 38 insertions(+), 179 deletions(-)
 delete mode 100644 t/unit-tests/lib-reftable-clar.c
 delete mode 100644 t/unit-tests/lib-reftable-clar.h

diff --git a/Makefile b/Makefile
index 8ed8f234f4..8d8f2d574d 100644
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
index 5d1419b801..bb0603464c 100644
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
index e5b9dda4f4..656de01d6e 100644
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
index b3d64f55de..5526c55739 100644
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
index f1c6a04429..d72b049a18 100644
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
index 137a7ab815..e00e6e1881 100644
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
index 8d6cfba22c..60ceecbc72 100644
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
@@ -480,7 +480,7 @@ void test_reftable_stack__add(void)
 	struct reftable_buf path = REFTABLE_BUF_INIT;
 	struct stat stat_result;
 	size_t i, N = ARRAY_SIZE(refs);
-	int err;
+	int err = 0;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	cl_assert(!err);
diff --git a/t/unit-tests/u-reftable-table.c b/t/unit-tests/u-reftable-table.c
index 25ea672e6a..5a00b4826e 100644
--- a/t/unit-tests/u-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -1,5 +1,5 @@
 #include "test-lib.h"
-#include "lib-reftable-clar.h"
+#include "lib-reftable.h"
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/iter.h"
-- 
2.43.0

