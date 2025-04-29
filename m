Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218E250C0C
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949266; cv=none; b=KgEW3h0jagsoDdGFRg6k7saD8IxDnXBXce66fD28l/szFO4UCtRrX08HZcJYe/a2MBqJW1amY2hkt79LFXrJ7UYnExbvFzSF3QajR9vCBCEkJzh+JkJ3HdPaujzpFMOqm9+Zv9JJ8Ik6OZjm9YMKAaLFOPRnIEdqK+0KkFRWD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949266; c=relaxed/simple;
	bh=T+j/GCnu/exU2xUG/jWdQV+MBqFS6Ub5iBEJytTBEdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU9axReGoVdsFNFZ2+jUL8/r2tVnIzA9Nt3bKenL0yV+0EhuRScKvRdDktoqi0oD+p6dJp3wk/ls4tcWy0xgShjjoKVMrC0Y/WuCDrlFQnlUWH5HzpYSCCN1w2diUAFxe+gM+Hu1kKZmknSOPieq0iMh6DxTPwyrlXqyC7HLzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7EXKhc2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7EXKhc2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c14016868so6446956f8f.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949263; x=1746554063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQAN7CLCgbo+qM5MJThDD9+Nh4zEK4LiycVllr4abTY=;
        b=Y7EXKhc2Sp9pUedpSAzPl8zZwDJxCLYhHRyUG0ULy3aCFm2UouVlK3R1aWpUEIJNVK
         avEJf8wspG7UAHJOhtr8FKqDanPXyJuZdo+UDI3kzDA7Hp81tNzAmFxvV61C5PR69psX
         TdlKQjl5lPXW8JvCAsrPrYtsYmUHgyGztINzm3ovyXXv+f6Be1GYq+ayJRNJpbMw8Qg1
         tbRNrmg4nWkINeUn4x7CznfS8XIybm7Ke7R1+JOzLRfFfwAdCJCiJ/TykVK9HLPW1jeg
         lUHDxLaJurdDBcDFEuGN/vAXa9AXuB4QED3E9pQzm+gPfG8p3pTNlfUkMTl+dLKYm52I
         OPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949263; x=1746554063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQAN7CLCgbo+qM5MJThDD9+Nh4zEK4LiycVllr4abTY=;
        b=xQidPLhZcDXHDJGcMayVhMz4GoGHpYsyizNb3b8l9rxZi5QpwzpWvxVX7yOSdvU+NG
         1H1KBLqaeUWNUszvtIlJaGf8PNrYatXXzKm2nHYiD0vRS8Qswyc6PbyB2YNg1BmSVYfP
         A9e120k2HiNUAuM8JXdOYyV3LVeadc/H9lKuSN3hFv6U/QAAJVPbRQwbIciXKs3QeAaG
         SZG+rzeiala6cW7wUGchvxbw/CB0onrzWAiT+MkoPGs8Xj2qkqL7FlQQAL1GivEya47b
         u0KwomDqLoVmrWspIbwFH7bkJ/vqFGLPjZYF8J3w1D6VNvgeUxm/SajJFFNTsv0s0ANJ
         iJMw==
X-Gm-Message-State: AOJu0YxrfNFnSdSPXT/j+JU52MIZwZw3cg7uZEjMArgnP75xfL6VvpfB
	uqwdjjNi2IqRk9WzS4YyyJ2bioEi2OjUswj128T17KBdU8UsYvYGMors/aM4beVJog==
X-Gm-Gg: ASbGncudKng8+r3FjdM+f04AwzRoXynxKK8h7+i9K1JI9U3vTfyQycv2EoWhJYS4T5M
	FciEKNE4LOz+dZiP3WRKR571NFIt60jXkCwyod0k7vgAIRcVjjMWIMHZVrep9+P6VzogXz2VtOo
	qk4tphpEs0TjNzO4xo8iuHHNyTel82JUpjwIdrt/OAm8ANidTCgVACzX/G1Fv4cnLIxCHo34u7D
	cv9Hy+qV1KKuKBvZPvVhkh3Irg+T9gUwSROF+kDsJPz8J2X9w9pJOPjBjovGZmYmGMhobiPgPrn
	Jc62A1pYU6yO1oFH4uiMnV0xx0uj3jGSMO4=
X-Google-Smtp-Source: AGHT+IGW5cVTmnMg+ByAomgB7jcZR3g6ILl/kRUM/m9gllwhsGk2IvU61tro4N5GUXYM/l68j8uL2Q==
X-Received: by 2002:a05:6000:3113:b0:39e:f89b:85e2 with SMTP id ffacd0b85a97d-3a08f779579mr287036f8f.26.1745949262609;
        Tue, 29 Apr 2025 10:54:22 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm14261782f8f.26.2025.04.29.10.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:54:22 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 10/10] t/unit-tests: adapt lib-reftable{c,h} helper functions to clar
Date: Tue, 29 Apr 2025 18:53:02 +0100
Message-ID: <20250429175302.23724-11-kuforiji98@gmail.com>
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
framework, which requires them. This change migrates the helper
functions back into `lib-reftable.{c,h}`.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                    |  4 +-
 t/meson.build               |  4 +-
 t/unit-tests/lib-reftable.c | 26 +++++------
 t/unit-tests/lib-reftable.h |  6 +--
 t/unit-tests/unit-test.c    | 93 -------------------------------------
 t/unit-tests/unit-test.h    | 16 -------
 6 files changed, 20 insertions(+), 129 deletions(-)

diff --git a/Makefile b/Makefile
index 0b42893611..7e646e16ee 100644
--- a/Makefile
+++ b/Makefile
@@ -1379,12 +1379,12 @@ CLAR_TEST_SUITES += u-urlmatch-normalization
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
-CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
-UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
diff --git a/t/meson.build b/t/meson.build
index 8fa00fc9ef..7c305a90b5 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -26,8 +26,9 @@ clar_test_suites = [
 
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
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 6c2a4e6aa8..5af645048a 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -1,103 +1,10 @@
 #include "unit-test.h"
 #include "hex.h"
 #include "parse-options.h"
-#include "reftable/constants.h"
-#include "reftable/writer.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "strvec.h"
 
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
-	cl_assert(ret == 0);
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
-	reftable_writer_set_limits(writer, min, max);
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
-
 static const char * const unit_test_usage[] = {
 	N_("unit-test [<options>]"),
 	NULL,
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
index fe0aebd876..85e5d6a948 100644
--- a/t/unit-tests/unit-test.h
+++ b/t/unit-tests/unit-test.h
@@ -1,24 +1,8 @@
 #include "git-compat-util.h"
 #include "clar/clar.h"
 #include "clar-decls.h"
-#include "git-compat-util.h"
-#include "reftable/reftable-writer.h"
 #include "strbuf.h"
 
-struct reftable_buf;
-
-void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
-
-struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
-						 struct reftable_write_options *opts);
-
-void cl_reftable_write_to_buf(struct reftable_buf *buf,
-			     struct reftable_ref_record *refs,
-			     size_t nrecords,
-			     struct reftable_log_record *logs,
-			     size_t nlogs,
-			     struct reftable_write_options *opts);
-
 #define cl_failf(fmt, ...) do { \
 	char desc[4096]; \
 	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
-- 
2.43.0

