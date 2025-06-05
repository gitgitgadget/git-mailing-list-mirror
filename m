Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B242749EE
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132507; cv=none; b=qtm7By9BuKml48jh4Y2PjKAS8A8g8xbfbDAijI1+doEknyBD1Unf8yERhXtNRrPrIhNpggXBF691Orzf2N9PGQkPcqDjdqC2kN+a02KT9kkZYmzt8EYnAvwgXZTG53/K4Hx9luQtY/rp7VgdWvBlg8eB2N5IOoct0Y7RTqO/ZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132507; c=relaxed/simple;
	bh=MaoxF7+gD5++Zv6rsD7QiBk4h1sYSXXHVS5g0ZuZRXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZAX1QoTN+NpBBbd9TnCxzJh5gpPzWZQhIIgt88MsYFHcdCVuRaSNefChhTMoRjWhB5ditizkxQsqOm/D3fijR+RhJa7BQ0jz1NLOVClvqbESsU/CD+OaH/k2jXBJvWTHsVrUKcI/vWeluOMbyMB37kxbHb21ZzAl9dPRCGzc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loX2iDf8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loX2iDf8"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a3798794d3so784212f8f.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 07:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749132502; x=1749737302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUP5mvXKUkZF3jCVPZlJ1afSceoBoHtYQZgRYkYJQlg=;
        b=loX2iDf8x80Qyd16oQCgNjVdqgUWqgCSYD0gApDrPGIXs+H+9UEcPnCP9aSoMntUXc
         BvRpho3xbfb0ztIz/19CofSUObXZB6ws2To7HgSpu0Jk5YL1eS57cEM3BpniEjOuqtRv
         knd+EvF2VfL+KlCe6Kslo4Q9CPDj8UNMDi8C+GLwaBO1Ig0je3yOXDpaD7KbyjgnwItX
         SxyS3En0F6Wp4LZ53zhUTRG2Xki6HFAQ25lveBxKI9WuUw5u2KERIpJ8jgg6x5yx8bS4
         /0LbT4vls3kW00lJMh4ZHk9DgW3MbO8dFJAMUNcJYF6Bak9Wh/TuZNQ1oTo1LoahlX8J
         yINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132502; x=1749737302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUP5mvXKUkZF3jCVPZlJ1afSceoBoHtYQZgRYkYJQlg=;
        b=q23jrTOdKbhMusXXN4J4ORg18if1MX5y4+tgA5hBC4mqLI7ggSZZcRvykwvga9xMbT
         1NqbJLOpxyvY+xAK83xj7y6wES27dPciv95DUouGksYOGQptu00Mt379FWMs6Uio0iwf
         idn87ZjLCLLSZ5hl2rOVl49Bh79Om3cYK0ZbpKXmMHvpRPRHBeTO7eJjTx+uS5oRmnCV
         2Mt+HQQzKFMELNZ5rhcZYZeKdMBEKQAal9OAYvMEmF+Xo5nUhtKNHcki//VRfwe9ZK1A
         WwKlckXxW+1f9UCLDC/8HZUS9AAOKaKhmzHNntommeqCYxgAOKC0NNDo2g9pCAz4MzuE
         z4XA==
X-Gm-Message-State: AOJu0YwX9HAoa+3ZF4pC40N/fQgjM3PbN3TDnUOjUgPyqeHJTQI/1gjN
	mIqlf8AvSTz2+1gHXju1dQiqUH4jU5x9PUfjDb1EyMRGz8/hI7Q75a3qYMI5jHxhKGY=
X-Gm-Gg: ASbGncuXcqoQH2Zd997ydBMs8JwmNluAwdENM/6AuiwYSaHzBUj06WyzDUL9PVYPY/k
	k1ePccfNHNvyYSKzXS8Lb87GrCkLkEVR4Z4qwT7jSnGJo2xipxCrgKXmRkDzGHBYU6Awt7hIPti
	5OfKVWY/8wK2O6E1X9RimuU0h8S/hbwfxLLBJqvqisoWtPmfb2Ss5crc0E/YWX39WKOu0DaKicc
	Z/Aq3cmjeIy6y/la6Fv2+ETogC+x1hGzXWfAUO9hAsKJmuMNviL1tJX3SuekIlkDN5bC6kSV8N2
	W08GmwXo6kTjiSwsU0A1IwThfGv0+haNzcwEUX7bJ9vhIA==
X-Google-Smtp-Source: AGHT+IEqTG3RH79muoAz1eIxB8OVPfx51L/80SKaEbHQ0rre5ZbAxHvRmB3EPx8j+Ai3sZqw/YdmFQ==
X-Received: by 2002:a05:6000:430a:b0:3a3:7593:81a1 with SMTP id ffacd0b85a97d-3a51d967d6emr5783915f8f.43.1749132501917;
        Thu, 05 Jun 2025 07:08:21 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm8827305e9.27.2025.06.05.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:08:21 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v4 07/10] t/unit-tests: convert reftable readwrite test to use clar
Date: Thu,  5 Jun 2025 15:06:41 +0100
Message-ID: <20250605140644.239199-8-kuforiji98@gmail.com>
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

Adapt reftable readwrite test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                      |   2 +-
 t/meson.build                                 |   2 +-
 ...ble-readwrite.c => u-reftable-readwrite.c} | 405 ++++++++----------
 3 files changed, 179 insertions(+), 230 deletions(-)
 rename t/unit-tests/{t-reftable-readwrite.c => u-reftable-readwrite.c} (68%)

diff --git a/Makefile b/Makefile
index 0227fdb3e1..d86ef5a142 100644
--- a/Makefile
+++ b/Makefile
@@ -1368,6 +1368,7 @@ CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-pq
+CLAR_TEST_SUITES += u-reftable-readwrite
 CLAR_TEST_SUITES += u-reftable-table
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
@@ -1382,7 +1383,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
 
-UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
diff --git a/t/meson.build b/t/meson.build
index 46d3a8580b..5189176472 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -12,6 +12,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-block.c',
   'unit-tests/u-reftable-merged.c',
   'unit-tests/u-reftable-pq.c',
+  'unit-tests/u-reftable-readwrite.c',
   'unit-tests/u-reftable-table.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
@@ -60,7 +61,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
 ]
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/u-reftable-readwrite.c
similarity index 68%
rename from t/unit-tests/t-reftable-readwrite.c
rename to t/unit-tests/u-reftable-readwrite.c
index 4c49129439..9aac74a011 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/u-reftable-readwrite.c
@@ -8,8 +8,8 @@ license that can be found in the LICENSE file or at
 
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
-#include "test-lib.h"
-#include "lib-reftable.h"
+#include "unit-test.h"
+#include "lib-reftable-clar.h"
 #include "reftable/basics.h"
 #include "reftable/blocksource.h"
 #include "reftable/reftable-error.h"
@@ -19,24 +19,24 @@ license that can be found in the LICENSE file or at
 
 static const int update_index = 5;
 
-static void t_buffer(void)
+void test_reftable_readwrite__buffer(void)
 {
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
 	struct reftable_block_data out = { 0 };
 	int n;
 	uint8_t in[] = "hello";
-	check(!reftable_buf_add(&buf, in, sizeof(in)));
+	cl_assert_equal_i(reftable_buf_add(&buf, in, sizeof(in)), 0);
 	block_source_from_buf(&source, &buf);
-	check_int(block_source_size(&source), ==, 6);
+	cl_assert_equal_i(block_source_size(&source), 6);
 	n = block_source_read_data(&source, &out, 0, sizeof(in));
-	check_int(n, ==, sizeof(in));
-	check(!memcmp(in, out.data, n));
+	cl_assert_equal_i(n, sizeof(in));
+	cl_assert(!memcmp(in, out.data, n));
 	block_source_release_data(&out);
 
 	n = block_source_read_data(&source, &out, 1, 2);
-	check_int(n, ==, 2);
-	check(!memcmp(out.data, "el", 2));
+	cl_assert_equal_i(n, 2);
+	cl_assert(!memcmp(out.data, "el", 2));
 
 	block_source_release_data(&out);
 	block_source_close(&source);
@@ -55,41 +55,41 @@ static void write_table(char ***names, struct reftable_buf *buf, int N,
 	int i;
 
 	REFTABLE_CALLOC_ARRAY(*names, N + 1);
-	check(*names != NULL);
+	cl_assert(*names != NULL);
 	REFTABLE_CALLOC_ARRAY(refs, N);
-	check(refs != NULL);
+	cl_assert(refs != NULL);
 	REFTABLE_CALLOC_ARRAY(logs, N);
-	check(logs != NULL);
+	cl_assert(logs != NULL);
 
 	for (i = 0; i < N; i++) {
 		refs[i].refname = (*names)[i] = xstrfmt("refs/heads/branch%02d", i);
 		refs[i].update_index = update_index;
 		refs[i].value_type = REFTABLE_REF_VAL1;
-		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(refs[i].value.val1, i,
+				     REFTABLE_HASH_SHA1);
 	}
 
 	for (i = 0; i < N; i++) {
 		logs[i].refname = (*names)[i];
 		logs[i].update_index = update_index;
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
-		t_reftable_set_hash(logs[i].value.update.new_hash, i,
-				    REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(logs[i].value.update.new_hash, i,
+				     REFTABLE_HASH_SHA1);
 		logs[i].value.update.message = (char *) "message";
 	}
 
-	t_reftable_write_to_buf(buf, refs, N, logs, N, &opts);
+	cl_reftable_write_to_buf(buf, refs, N, logs, N, &opts);
 
 	reftable_free(refs);
 	reftable_free(logs);
 }
 
-static void t_log_buffer_size(void)
+void test_reftable_readwrite__log_buffer_size(void)
 {
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_write_options opts = {
 		.block_size = 4096,
 	};
-	int err;
 	int i;
 	struct reftable_log_record
 		log = { .refname = (char *) "refs/heads/master",
@@ -102,7 +102,8 @@ static void t_log_buffer_size(void)
 					   .time = 0x5e430672,
 					   .message = (char *) "commit: 9\n",
 				   } } };
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      &opts);
 
 	/* This tests buffer extension for log compression. Must use a random
 	   hash, to ensure that the compressed part is larger than the original.
@@ -112,22 +113,19 @@ static void t_log_buffer_size(void)
 		log.value.update.new_hash[i] = (uint8_t)(git_rand(0) % 256);
 	}
 	reftable_writer_set_limits(w, update_index, update_index);
-	err = reftable_writer_add_log(w, &log);
-	check(!err);
-	err = reftable_writer_close(w);
-	check(!err);
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
+	cl_assert_equal_i(reftable_writer_close(w), 0);
 	reftable_writer_free(w);
 	reftable_buf_release(&buf);
 }
 
-static void t_log_overflow(void)
+void test_reftable_readwrite__log_overflow(void)
 {
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	char msg[256] = { 0 };
 	struct reftable_write_options opts = {
 		.block_size = ARRAY_SIZE(msg),
 	};
-	int err;
 	struct reftable_log_record log = {
 		.refname = (char *) "refs/heads/master",
 		.update_index = update_index,
@@ -144,21 +142,22 @@ static void t_log_overflow(void)
 			},
 		},
 	};
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      &opts);
 
 	memset(msg, 'x', sizeof(msg) - 1);
 	reftable_writer_set_limits(w, update_index, update_index);
-	err = reftable_writer_add_log(w, &log);
-	check_int(err, ==, REFTABLE_ENTRY_TOO_BIG_ERROR);
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), REFTABLE_ENTRY_TOO_BIG_ERROR);
 	reftable_writer_free(w);
 	reftable_buf_release(&buf);
 }
 
-static void t_log_write_limits(void)
+void test_reftable_readwrite__log_write_limits(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      &opts);
 	struct reftable_log_record log = {
 		.refname = (char *)"refs/head/master",
 		.update_index = 0,
@@ -174,29 +173,25 @@ static void t_log_write_limits(void)
 			},
 		},
 	};
-	int err;
 
 	reftable_writer_set_limits(w, 1, 1);
 
 	/* write with update_index (0) below set limits (1, 1) */
-	err = reftable_writer_add_log(w, &log);
-	check_int(err, ==, 0);
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
 
 	/* write with update_index (1) in the set limits (1, 1) */
 	log.update_index = 1;
-	err = reftable_writer_add_log(w, &log);
-	check_int(err, ==, 0);
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
 
 	/* write with update_index (3) above set limits (1, 1) */
 	log.update_index = 3;
-	err = reftable_writer_add_log(w, &log);
-	check_int(err, ==, REFTABLE_API_ERROR);
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), REFTABLE_API_ERROR);
 
 	reftable_writer_free(w);
 	reftable_buf_release(&buf);
 }
 
-static void t_log_write_read(void)
+void test_reftable_readwrite__log_write_read(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 256,
@@ -207,13 +202,14 @@ static void t_log_write_read(void)
 	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
 	const struct reftable_stats *stats = NULL;
-	int N = 2, err, i, n;
+	int N = 2, i;
 	char **names;
+	int err;
 
 	names = reftable_calloc(N + 1, sizeof(*names));
-	check(names != NULL);
+	cl_assert(names != NULL);
 
 	reftable_writer_set_limits(w, 0, N);
 
@@ -225,8 +221,7 @@ static void t_log_write_read(void)
 		ref.refname = name;
 		ref.update_index = i;
 
-		err = reftable_writer_add_ref(w, &ref);
-		check(!err);
+		cl_assert_equal_i(reftable_writer_add_ref(w, &ref), 0);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -235,60 +230,57 @@ static void t_log_write_read(void)
 		log.refname = names[i];
 		log.update_index = i;
 		log.value_type = REFTABLE_LOG_UPDATE;
-		t_reftable_set_hash(log.value.update.old_hash, i,
-				    REFTABLE_HASH_SHA1);
-		t_reftable_set_hash(log.value.update.new_hash, i + 1,
-				    REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(log.value.update.old_hash, i,
+				     REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(log.value.update.new_hash, i + 1,
+				     REFTABLE_HASH_SHA1);
 
-		err = reftable_writer_add_log(w, &log);
-		check(!err);
+		cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
 	}
 
-	n = reftable_writer_close(w);
-	check_int(n, ==, 0);
+	cl_assert_equal_i(reftable_writer_close(w), 0);
 
 	stats = reftable_writer_stats(w);
-	check_int(stats->log_stats.blocks, >, 0);
+	cl_assert(stats->log_stats.blocks > 0);
 	reftable_writer_free(w);
 	w = NULL;
 
 	block_source_from_buf(&source, &buf);
 
 	err = reftable_table_new(&table, &source, "file.log");
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_table_init_ref_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_iterator_seek_ref(&it, names[N - 1]);
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_iterator_next_ref(&it, &ref);
-	check(!err);
+	cl_assert(!err);
 
 	/* end of iteration. */
-	err = reftable_iterator_next_ref(&it, &ref);
-	check_int(err, >, 0);
+	cl_assert(reftable_iterator_next_ref(&it, &ref) > 0);
 
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
 	err = reftable_table_init_log_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_log(&it, "");
-	check(!err);
+	cl_assert(!err);
 
 	for (i = 0; ; i++) {
 		int err = reftable_iterator_next_log(&it, &log);
 		if (err > 0)
 			break;
-		check(!err);
-		check_str(names[i], log.refname);
-		check_int(i, ==, log.update_index);
+		cl_assert(!err);
+		cl_assert_equal_s(names[i], log.refname);
+		cl_assert_equal_i(i, log.update_index);
 		reftable_log_record_release(&log);
 	}
 
-	check_int(i, ==, N);
+	cl_assert_equal_i(i, N);
 	reftable_iterator_destroy(&it);
 
 	/* cleanup. */
@@ -297,7 +289,7 @@ static void t_log_write_read(void)
 	reftable_table_decref(table);
 }
 
-static void t_log_zlib_corruption(void)
+void test_reftable_readwrite__log_zlib_corruption(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 256,
@@ -306,10 +298,12 @@ static void t_log_zlib_corruption(void)
 	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      &opts);
 	const struct reftable_stats *stats = NULL;
 	char message[100] = { 0 };
-	int err, i, n;
+	int i;
+	int err;
 	struct reftable_log_record log = {
 		.refname = (char *) "refname",
 		.value_type = REFTABLE_LOG_UPDATE,
@@ -329,14 +323,11 @@ static void t_log_zlib_corruption(void)
 
 	reftable_writer_set_limits(w, 1, 1);
 
-	err = reftable_writer_add_log(w, &log);
-	check(!err);
-
-	n = reftable_writer_close(w);
-	check_int(n, ==, 0);
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
+	cl_assert_equal_i(reftable_writer_close(w), 0);
 
 	stats = reftable_writer_stats(w);
-	check_int(stats->log_stats.blocks, >, 0);
+	cl_assert(stats->log_stats.blocks > 0);
 	reftable_writer_free(w);
 	w = NULL;
 
@@ -346,12 +337,12 @@ static void t_log_zlib_corruption(void)
 	block_source_from_buf(&source, &buf);
 
 	err = reftable_table_new(&table, &source, "file.log");
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_table_init_log_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_log(&it, "refname");
-	check_int(err, ==, REFTABLE_ZLIB_ERROR);
+	cl_assert_equal_i(err, REFTABLE_ZLIB_ERROR);
 
 	reftable_iterator_destroy(&it);
 
@@ -360,7 +351,7 @@ static void t_log_zlib_corruption(void)
 	reftable_buf_release(&buf);
 }
 
-static void t_table_read_write_sequential(void)
+void test_reftable_readwrite__table_read_write_sequential(void)
 {
 	char **names;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
@@ -376,24 +367,24 @@ static void t_table_read_write_sequential(void)
 	block_source_from_buf(&source, &buf);
 
 	err = reftable_table_new(&table, &source, "file.ref");
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_table_init_ref_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_ref(&it, "");
-	check(!err);
+	cl_assert(!err);
 
 	for (j = 0; ; j++) {
 		struct reftable_ref_record ref = { 0 };
 		int r = reftable_iterator_next_ref(&it, &ref);
-		check_int(r, >=, 0);
+		cl_assert(r >= 0);
 		if (r > 0)
 			break;
-		check_str(names[j], ref.refname);
-		check_int(update_index, ==, ref.update_index);
+		cl_assert_equal_s(names[j], ref.refname);
+		cl_assert_equal_i(update_index, ref.update_index);
 		reftable_ref_record_release(&ref);
 	}
-	check_int(j, ==, N);
+	cl_assert_equal_i(j, N);
 
 	reftable_iterator_destroy(&it);
 	reftable_table_decref(table);
@@ -401,42 +392,42 @@ static void t_table_read_write_sequential(void)
 	free_names(names);
 }
 
-static void t_table_write_small_table(void)
+void test_reftable_readwrite__table_write_small_table(void)
 {
 	char **names;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int N = 1;
 	write_table(&names, &buf, N, 4096, REFTABLE_HASH_SHA1);
-	check_int(buf.len, <, 200);
+	cl_assert(buf.len < 200);
 	reftable_buf_release(&buf);
 	free_names(names);
 }
 
-static void t_table_read_api(void)
+void test_reftable_readwrite__table_read_api(void)
 {
 	char **names;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int N = 50;
 	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
-	int err;
 	struct reftable_log_record log = { 0 };
 	struct reftable_iterator it = { 0 };
+	int err;
 
 	write_table(&names, &buf, N, 256, REFTABLE_HASH_SHA1);
 
 	block_source_from_buf(&source, &buf);
 
 	err = reftable_table_new(&table, &source, "file.ref");
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_table_init_ref_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_ref(&it, names[0]);
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_iterator_next_log(&it, &log);
-	check_int(err, ==, REFTABLE_API_ERROR);
+	cl_assert_equal_i(err, REFTABLE_API_ERROR);
 
 	reftable_buf_release(&buf);
 	free_names(names);
@@ -464,42 +455,43 @@ static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
 	block_source_from_buf(&source, &buf);
 
 	err = reftable_table_new(&table, &source, "file.ref");
-	check(!err);
-	check_int(hash_id, ==, reftable_table_hash_id(table));
+	cl_assert(!err);
+	cl_assert_equal_i(hash_id, reftable_table_hash_id(table));
 
 	if (!index) {
 		table->ref_offsets.index_offset = 0;
 	} else {
-		check_int(table->ref_offsets.index_offset, >, 0);
+		cl_assert(table->ref_offsets.index_offset > 0);
 	}
 
 	for (i = 1; i < N; i++) {
 		err = reftable_table_init_ref_iterator(table, &it);
-		check(!err);
+		cl_assert(!err);
 		err = reftable_iterator_seek_ref(&it, names[i]);
-		check(!err);
+		cl_assert(!err);
 		err = reftable_iterator_next_ref(&it, &ref);
-		check(!err);
-		check_str(names[i], ref.refname);
-		check_int(REFTABLE_REF_VAL1, ==, ref.value_type);
-		check_int(i, ==, ref.value.val1[0]);
+		cl_assert(!err);
+		cl_assert_equal_s(names[i], ref.refname);
+		cl_assert_equal_i(REFTABLE_REF_VAL1, ref.value_type);
+		cl_assert_equal_i(i, ref.value.val1[0]);
 
 		reftable_ref_record_release(&ref);
 		reftable_iterator_destroy(&it);
 	}
 
-	check(!reftable_buf_addstr(&pastLast, names[N - 1]));
-	check(!reftable_buf_addstr(&pastLast, "/"));
+	cl_assert_equal_i(reftable_buf_addstr(&pastLast, names[N - 1]),
+					      0);
+	cl_assert_equal_i(reftable_buf_addstr(&pastLast, "/"), 0);
 
 	err = reftable_table_init_ref_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_ref(&it, pastLast.buf);
 	if (err == 0) {
 		struct reftable_ref_record ref = { 0 };
 		int err = reftable_iterator_next_ref(&it, &ref);
-		check_int(err, >, 0);
+		cl_assert(err > 0);
 	} else {
-		check_int(err, >, 0);
+		cl_assert(err > 0);
 	}
 
 	reftable_buf_release(&pastLast);
@@ -510,17 +502,17 @@ static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
 	reftable_table_decref(table);
 }
 
-static void t_table_read_write_seek_linear(void)
+void test_reftable_readwrite__table_read_write_seek_linear(void)
 {
 	t_table_read_write_seek(0, REFTABLE_HASH_SHA1);
 }
 
-static void t_table_read_write_seek_linear_sha256(void)
+void test_reftable_readwrite__table_read_write_seek_linear_sha256(void)
 {
 	t_table_read_write_seek(0, REFTABLE_HASH_SHA256);
 }
 
-static void t_table_read_write_seek_index(void)
+void test_reftable_readwrite__table_read_write_seek_index(void)
 {
 	t_table_read_write_seek(1, REFTABLE_HASH_SHA1);
 }
@@ -538,14 +530,16 @@ static void t_table_refs_for(int indexed)
 	struct reftable_table *table;
 	struct reftable_block_source source = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
+							      &opts);
 	struct reftable_iterator it = { 0 };
-	int N = 50, n, j, err, i;
+	int N = 50, j, i;
+	int err;
 
 	want_names = reftable_calloc(N + 1, sizeof(*want_names));
-	check(want_names != NULL);
+	cl_assert(want_names != NULL);
 
-	t_reftable_set_hash(want_hash, 4, REFTABLE_HASH_SHA1);
+	cl_reftable_set_hash(want_hash, 4, REFTABLE_HASH_SHA1);
 
 	for (i = 0; i < N; i++) {
 		uint8_t hash[REFTABLE_HASH_SIZE_SHA1];
@@ -561,24 +555,22 @@ static void t_table_refs_for(int indexed)
 		ref.refname = name;
 
 		ref.value_type = REFTABLE_REF_VAL2;
-		t_reftable_set_hash(ref.value.val2.value, i / 4,
-				    REFTABLE_HASH_SHA1);
-		t_reftable_set_hash(ref.value.val2.target_value, 3 + i / 4,
-				    REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(ref.value.val2.value, i / 4,
+				     REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(ref.value.val2.target_value,
+				     3 + i / 4, REFTABLE_HASH_SHA1);
 
 		/* 80 bytes / entry, so 3 entries per block. Yields 17
 		 */
 		/* blocks. */
-		n = reftable_writer_add_ref(w, &ref);
-		check_int(n, ==, 0);
+		cl_assert_equal_i(reftable_writer_add_ref(w, &ref), 0);
 
 		if (!memcmp(ref.value.val2.value, want_hash, REFTABLE_HASH_SIZE_SHA1) ||
 		    !memcmp(ref.value.val2.target_value, want_hash, REFTABLE_HASH_SIZE_SHA1))
 			want_names[want_names_len++] = xstrdup(name);
 	}
 
-	n = reftable_writer_close(w);
-	check_int(n, ==, 0);
+	cl_assert_equal_i(reftable_writer_close(w), 0);
 
 	reftable_writer_free(w);
 	w = NULL;
@@ -586,29 +578,29 @@ static void t_table_refs_for(int indexed)
 	block_source_from_buf(&source, &buf);
 
 	err = reftable_table_new(&table, &source, "file.ref");
-	check(!err);
+	cl_assert(!err);
 	if (!indexed)
 		table->obj_offsets.is_present = 0;
 
 	err = reftable_table_init_ref_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_ref(&it, "");
-	check(!err);
+	cl_assert(!err);
 	reftable_iterator_destroy(&it);
 
 	err = reftable_table_refs_for(table, &it, want_hash);
-	check(!err);
+	cl_assert(!err);
 
 	for (j = 0; ; j++) {
 		int err = reftable_iterator_next_ref(&it, &ref);
-		check_int(err, >=, 0);
+		cl_assert(err >= 0);
 		if (err > 0)
 			break;
-		check_int(j, <, want_names_len);
-		check_str(ref.refname, want_names[j]);
+		cl_assert(j < want_names_len);
+		cl_assert_equal_s(ref.refname, want_names[j]);
 		reftable_ref_record_release(&ref);
 	}
-	check_int(j, ==, want_names_len);
+	cl_assert_equal_i(j, want_names_len);
 
 	reftable_buf_release(&buf);
 	free_names(want_names);
@@ -616,21 +608,21 @@ static void t_table_refs_for(int indexed)
 	reftable_table_decref(table);
 }
 
-static void t_table_refs_for_no_index(void)
+void test_reftable_readwrite__table_refs_for_no_index(void)
 {
 	t_table_refs_for(0);
 }
 
-static void t_table_refs_for_obj_index(void)
+void test_reftable_readwrite__table_refs_for_obj_index(void)
 {
 	t_table_refs_for(1);
 }
 
-static void t_write_empty_table(void)
+void test_reftable_readwrite__write_empty_table(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_block_source source = { 0 };
 	struct reftable_table *table = NULL;
 	struct reftable_ref_record rec = { 0 };
@@ -639,43 +631,41 @@ static void t_write_empty_table(void)
 
 	reftable_writer_set_limits(w, 1, 1);
 
-	err = reftable_writer_close(w);
-	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
+	cl_assert_equal_i(reftable_writer_close(w), REFTABLE_EMPTY_TABLE_ERROR);
 	reftable_writer_free(w);
 
-	check_uint(buf.len, ==, header_size(1) + footer_size(1));
+	cl_assert_equal_i(buf.len, header_size(1) + footer_size(1));
 
 	block_source_from_buf(&source, &buf);
 
 	err = reftable_table_new(&table, &source, "filename");
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_table_init_ref_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_ref(&it, "");
-	check(!err);
+	cl_assert(!err);
 
 	err = reftable_iterator_next_ref(&it, &rec);
-	check_int(err, >, 0);
+	cl_assert(err > 0);
 
 	reftable_iterator_destroy(&it);
 	reftable_table_decref(table);
 	reftable_buf_release(&buf);
 }
 
-static void t_write_object_id_min_length(void)
+void test_reftable_readwrite__write_object_id_min_length(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 75,
 	};
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
 		.value_type = REFTABLE_REF_VAL1,
 		.value.val1 = {42},
 	};
-	int err;
 	int i;
 
 	reftable_writer_set_limits(w, 1, 1);
@@ -686,30 +676,27 @@ static void t_write_object_id_min_length(void)
 		char name[256];
 		snprintf(name, sizeof(name), "ref%05d", i);
 		ref.refname = name;
-		err = reftable_writer_add_ref(w, &ref);
-		check(!err);
+		cl_assert_equal_i(reftable_writer_add_ref(w, &ref), 0);
 	}
 
-	err = reftable_writer_close(w);
-	check(!err);
-	check_int(reftable_writer_stats(w)->object_id_len, ==, 2);
+	cl_assert_equal_i(reftable_writer_close(w), 0);
+	cl_assert_equal_i(reftable_writer_stats(w)->object_id_len, 2);
 	reftable_writer_free(w);
 	reftable_buf_release(&buf);
 }
 
-static void t_write_object_id_length(void)
+void test_reftable_readwrite__write_object_id_length(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 75,
 	};
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
 		.value_type = REFTABLE_REF_VAL1,
 		.value.val1 = {42},
 	};
-	int err;
 	int i;
 
 	reftable_writer_set_limits(w, 1, 1);
@@ -721,44 +708,39 @@ static void t_write_object_id_length(void)
 		snprintf(name, sizeof(name), "ref%05d", i);
 		ref.refname = name;
 		ref.value.val1[15] = i;
-		err = reftable_writer_add_ref(w, &ref);
-		check(!err);
+		cl_assert(reftable_writer_add_ref(w, &ref) == 0);
 	}
 
-	err = reftable_writer_close(w);
-	check(!err);
-	check_int(reftable_writer_stats(w)->object_id_len, ==, 16);
+	cl_assert_equal_i(reftable_writer_close(w), 0);
+	cl_assert_equal_i(reftable_writer_stats(w)->object_id_len, 16);
 	reftable_writer_free(w);
 	reftable_buf_release(&buf);
 }
 
-static void t_write_empty_key(void)
+void test_reftable_readwrite__write_empty_key(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record ref = {
 		.refname = (char *) "",
 		.update_index = 1,
 		.value_type = REFTABLE_REF_DELETION,
 	};
-	int err;
 
 	reftable_writer_set_limits(w, 1, 1);
-	err = reftable_writer_add_ref(w, &ref);
-	check_int(err, ==, REFTABLE_API_ERROR);
-
-	err = reftable_writer_close(w);
-	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
+	cl_assert_equal_i(reftable_writer_add_ref(w, &ref), REFTABLE_API_ERROR);
+	cl_assert_equal_i(reftable_writer_close(w),
+			  REFTABLE_EMPTY_TABLE_ERROR);
 	reftable_writer_free(w);
 	reftable_buf_release(&buf);
 }
 
-static void t_write_key_order(void)
+void test_reftable_readwrite__write_key_order(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record refs[2] = {
 		{
 			.refname = (char *) "b",
@@ -776,24 +758,21 @@ static void t_write_key_order(void)
 			},
 		}
 	};
-	int err;
 
 	reftable_writer_set_limits(w, 1, 1);
-	err = reftable_writer_add_ref(w, &refs[0]);
-	check(!err);
-	err = reftable_writer_add_ref(w, &refs[1]);
-	check_int(err, ==, REFTABLE_API_ERROR);
+	cl_assert_equal_i(reftable_writer_add_ref(w, &refs[0]), 0);
+	cl_assert_equal_i(reftable_writer_add_ref(w, &refs[1]),
+			  REFTABLE_API_ERROR);
 
 	refs[0].update_index = 2;
-	err = reftable_writer_add_ref(w, &refs[0]);
-	check_int(err, ==, REFTABLE_API_ERROR);
+	cl_assert_equal_i(reftable_writer_add_ref(w, &refs[0]), REFTABLE_API_ERROR);
 
 	reftable_writer_close(w);
 	reftable_writer_free(w);
 	reftable_buf_release(&buf);
 }
 
-static void t_write_multiple_indices(void)
+void test_reftable_readwrite__write_multiple_indices(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 100,
@@ -805,9 +784,10 @@ static void t_write_multiple_indices(void)
 	struct reftable_writer *writer;
 	struct reftable_table *table;
 	char buf[128];
-	int err, i;
+	int i;
+	int err;
 
-	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
+	writer = cl_reftable_strbuf_writer(&writer_buf, &opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (i = 0; i < 100; i++) {
 		struct reftable_ref_record ref = {
@@ -819,8 +799,7 @@ static void t_write_multiple_indices(void)
 		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
 		ref.refname = buf;
 
-		err = reftable_writer_add_ref(writer, &ref);
-		check(!err);
+		cl_assert_equal_i(reftable_writer_add_ref(writer, &ref), 0);
 	}
 
 	for (i = 0; i < 100; i++) {
@@ -836,8 +815,7 @@ static void t_write_multiple_indices(void)
 		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
 		log.refname = buf;
 
-		err = reftable_writer_add_log(writer, &log);
-		check(!err);
+		cl_assert_equal_i(reftable_writer_add_log(writer, &log), 0);
 	}
 
 	reftable_writer_close(writer);
@@ -847,22 +825,22 @@ static void t_write_multiple_indices(void)
 	 * for each of the block types.
 	 */
 	stats = reftable_writer_stats(writer);
-	check_int(stats->ref_stats.index_offset, >, 0);
-	check_int(stats->obj_stats.index_offset, >, 0);
-	check_int(stats->log_stats.index_offset, >, 0);
+	cl_assert(stats->ref_stats.index_offset > 0);
+	cl_assert(stats->obj_stats.index_offset > 0);
+	cl_assert(stats->log_stats.index_offset > 0);
 
 	block_source_from_buf(&source, &writer_buf);
 	err = reftable_table_new(&table, &source, "filename");
-	check(!err);
+	cl_assert(!err);
 
 	/*
 	 * Seeking the log uses the log index now. In case there is any
 	 * confusion regarding indices we would notice here.
 	 */
 	err = reftable_table_init_log_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_log(&it, "");
-	check(!err);
+	cl_assert(!err);
 
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
@@ -870,7 +848,7 @@ static void t_write_multiple_indices(void)
 	reftable_buf_release(&writer_buf);
 }
 
-static void t_write_multi_level_index(void)
+void test_reftable_readwrite__write_multi_level_index(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 100,
@@ -883,7 +861,7 @@ static void t_write_multi_level_index(void)
 	struct reftable_table *table;
 	int err;
 
-	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
+	writer = cl_reftable_strbuf_writer(&writer_buf, &opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (size_t i = 0; i < 200; i++) {
 		struct reftable_ref_record ref = {
@@ -896,8 +874,7 @@ static void t_write_multi_level_index(void)
 		snprintf(buf, sizeof(buf), "refs/heads/%03" PRIuMAX, (uintmax_t)i);
 		ref.refname = buf;
 
-		err = reftable_writer_add_ref(writer, &ref);
-		check(!err);
+		cl_assert_equal_i(reftable_writer_add_ref(writer, &ref), 0);
 	}
 	reftable_writer_close(writer);
 
@@ -906,19 +883,19 @@ static void t_write_multi_level_index(void)
 	 * multi-level index.
 	 */
 	stats = reftable_writer_stats(writer);
-	check_int(stats->ref_stats.max_index_level, ==, 2);
+	cl_assert_equal_i(stats->ref_stats.max_index_level, 2);
 
 	block_source_from_buf(&source, &writer_buf);
 	err = reftable_table_new(&table, &source, "filename");
-	check(!err);
+	cl_assert(!err);
 
 	/*
 	 * Seeking the last ref should work as expected.
 	 */
 	err = reftable_table_init_ref_iterator(table, &it);
-	check(!err);
+	cl_assert(!err);
 	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
-	check(!err);
+	cl_assert(!err);
 
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
@@ -927,7 +904,7 @@ static void t_write_multi_level_index(void)
 	reftable_buf_release(&buf);
 }
 
-static void t_corrupt_table_empty(void)
+void test_reftable_readwrite__corrupt_table_empty(void)
 {
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
@@ -936,50 +913,22 @@ static void t_corrupt_table_empty(void)
 
 	block_source_from_buf(&source, &buf);
 	err = reftable_table_new(&table, &source, "file.log");
-	check_int(err, ==, REFTABLE_FORMAT_ERROR);
+	cl_assert_equal_i(err, REFTABLE_FORMAT_ERROR);
 }
 
-static void t_corrupt_table(void)
+void test_reftable_readwrite__corrupt_table(void)
 {
 	uint8_t zeros[1024] = { 0 };
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	struct reftable_block_source source = { 0 };
 	struct reftable_table *table;
 	int err;
-	check(!reftable_buf_add(&buf, zeros, sizeof(zeros)));
+
+	cl_assert(!reftable_buf_add(&buf, zeros, sizeof(zeros)));
 
 	block_source_from_buf(&source, &buf);
 	err = reftable_table_new(&table, &source, "file.log");
-	check_int(err, ==, REFTABLE_FORMAT_ERROR);
+	cl_assert_equal_i(err, REFTABLE_FORMAT_ERROR);
 
 	reftable_buf_release(&buf);
 }
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_buffer(), "strbuf works as blocksource");
-	TEST(t_corrupt_table(), "read-write on corrupted table");
-	TEST(t_corrupt_table_empty(), "read-write on an empty table");
-	TEST(t_log_buffer_size(), "buffer extension for log compression");
-	TEST(t_log_overflow(), "log overflow returns expected error");
-	TEST(t_log_write_limits(), "writer limits for writing log records");
-	TEST(t_log_write_read(), "read-write on log records");
-	TEST(t_log_zlib_corruption(), "reading corrupted log record returns expected error");
-	TEST(t_table_read_api(), "read on a table");
-	TEST(t_table_read_write_seek_index(), "read-write on a table with index");
-	TEST(t_table_read_write_seek_linear(), "read-write on a table without index (SHA1)");
-	TEST(t_table_read_write_seek_linear_sha256(), "read-write on a table without index (SHA256)");
-	TEST(t_table_read_write_sequential(), "sequential read-write on a table");
-	TEST(t_table_refs_for_no_index(), "refs-only table with no index");
-	TEST(t_table_refs_for_obj_index(), "refs-only table with index");
-	TEST(t_table_write_small_table(), "write_table works");
-	TEST(t_write_empty_key(), "write on refs with empty keys");
-	TEST(t_write_empty_table(), "read-write on empty tables");
-	TEST(t_write_key_order(), "refs must be written in increasing order");
-	TEST(t_write_multi_level_index(), "table with multi-level index");
-	TEST(t_write_multiple_indices(), "table with indices for multiple block types");
-	TEST(t_write_object_id_length(), "prefix compression on writing refs");
-	TEST(t_write_object_id_min_length(), "prefix compression on writing refs");
-
-	return test_done();
-}
-- 
2.43.0

