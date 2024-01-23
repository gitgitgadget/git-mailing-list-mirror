Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22185C63
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035876; cv=none; b=QvMuqKGG/IYVXG3iwvIFVhDf/D7xNDOH9d8GkvgNsEZGLHJuFR9CEh6U0YOzS1ySoom2jXVheLIE6lghFACW1/3o7fxWHzXLtWq8tcwURJ4nW/r9shM5W8Bsh8ILywC0lQqEpYn+WmemwNhUO0+2+N1bbTf+BUUSWMM2C4cynfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035876; c=relaxed/simple;
	bh=CVmfnezLEmPTGP4RpOmsULLi6cpS9J6tmc+Aphz0hls=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=swE3CV7dbRwLXx1tK4ktoQfLqryYggKVCGXh3zYlbrLorMfjjKGoGxwgoHjGdI0U8XADB2Bu3GQ3hpkXRGTHxgQZoLPkE5gXdD6SjxDuB8Ofc+A2+b3cWylyrWHWBtapankvlXTS/kV+iPi3Q+7cJK9zU1PJZEH6lpAQiA3hK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT6PoHFg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT6PoHFg"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ffd5620247so27980127b3.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706035873; x=1706640673; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wgwVV0VS8Ir7AMxIVWVedMleQeXvqwUCBd41dAteoWM=;
        b=KT6PoHFgr42gsisjiSWGRR+sBasSi6remFoqyW2LVcnZcKksXiMtuCFEmSqbQsQooO
         3W99t5cDmCfk8BtgB0+mxc0Qer7P5HMjt0+W5KLZtuOgJ3binXfJi8duHiCT9tcaC0xT
         OlqAghfoJsTyk0aeGGmF7Wye6HXBk7UUP9w4bWHxIXfC3wj7Xdj9kg12kqxLpZzfOQg5
         BdIopDljZ9X+jVZtBMN3YrYp/lUMt7Is18N14yzRd5NbJCbPtBapniOVEKnACPwLIdCw
         mt2IfO1uZjYg7v4jZzx3wyR4cX3l/YlQHLs6oTwx72cIYC8eU+83h4DJlrbLMnz4VGrU
         3qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035873; x=1706640673;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgwVV0VS8Ir7AMxIVWVedMleQeXvqwUCBd41dAteoWM=;
        b=FgbDc2+F2YRcSxTMSckD9zp2/oBzSFda7GT3su85Y7BJ7gUdItjEQY+PvbgwP464xu
         s6nZlWUuvFQ8ZsvNTA1u8xHOHSmUl+oVPWmAHdtUfL09CxHSc0AJe1FtEbAVKdPAosB1
         e8Z5s+okUpUHPU9J2SmV/l+iITmIwaVH0dAO2jpgm5OVnXeRA2NrWx7shcASy4frajHa
         5Wy/EmVSrPNDypod16in9cAcEH+W7t/oZ05pFCkBOo3vo9T83+CM1BXZ/R2i3yVlRWnF
         3HhmeqCC71FHy+hUjFddtSGAU5aUAY+u7RKBFm0Q4iFUC24hOdkrGgon3TvBXdD6oLOD
         8u7A==
X-Gm-Message-State: AOJu0YzFcoEO/leVoGuAQNP2NnE7OFtl13FAHPXWeZ8BmgewlxHyXr6M
	LnBxALVA4xrh4E5rwnlEOly6rhOY+mDRGBFjh75n1BfbX+XJ1anS+ZVYbafR
X-Google-Smtp-Source: AGHT+IH4588W9fbqig+EGU6nKKNGlnpdKIdwz88e3CXulTmLJe/98xcRkKZEYwHfJolmFfBpn8Vy3g==
X-Received: by 2002:a5b:ac5:0:b0:dc2:6618:df9a with SMTP id a5-20020a5b0ac5000000b00dc26618df9amr4401750ybr.11.1706035873349;
        Tue, 23 Jan 2024 10:51:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ma5-20020a0562145b0500b00686a22aeafasm756862qvb.18.2024.01.23.10.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 10:51:13 -0800 (PST)
Message-ID: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jan 2024 18:51:10 +0000
Subject: [PATCH] reftable: honor core.fsync
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

While the reffiles backend honors configured fsync settings, the
reftable backend does not. Address this by fsyncing reftable files using
the write-or-die api's fsync_component() in two places: when we
add additional entries into the table, and when we close the reftable
writer.

This commits adds a flush function pointer as a new member of
reftable_writer because we are not sure that the first argument to the
*write function pointer always contains a file descriptor. In the case of
strbuf_add_void, the first argument is a buffer. This way, we can pass
in a corresponding flush function that knows how to flush depending on
which writer is being used.

This patch does not contain tests as they will need to wait for another
patch to start to exercise the reftable backend. At that point, the
tests will be added to observe that fsyncs are happening when the
reftable is in use.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    reftable: honor core.fsync
    
    While the reffiles backend honors configured fsync settings, the
    reftable backend does not. Address this by fsyncing reftable files using
    the write-or-die api's fsync_component() in two places: when we add
    additional entries into the table, and when we close the reftable
    writer.
    
    This commits adds a flush function pointer as a new member of
    reftable_writer because we are not sure that the first argument to the
    *write function pointer always contains a file descriptor. In the case
    of strbuf_add_void, the first argument is a buffer. This way, we can
    pass in a corresponding flush function that knows how to flush depending
    on which writer is being used.
    
    This patch does not contain tests as they will need to wait for another
    patch to exercise the reftable backend in test. At that point, the tests
    will be added to observe that fsyncs are happening when the reftable is
    in use.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1654%2Fjohn-cai%2Fjc%2Ffsync-reftable-write-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1654/john-cai/jc/fsync-reftable-write-v1
Pull-Request: https://github.com/git/git/pull/1654

 reftable/merged_test.c     |  6 +++---
 reftable/readwrite_test.c  | 24 ++++++++++++------------
 reftable/refname_test.c    |  2 +-
 reftable/reftable-writer.h |  1 +
 reftable/stack.c           | 16 +++++++++++++---
 reftable/test_framework.c  |  5 +++++
 reftable/test_framework.h  |  2 ++
 reftable/writer.c          |  8 ++++++++
 reftable/writer.h          |  1 +
 9 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 46908f738f7..bf090b474ed 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -42,7 +42,7 @@ static void write_test_table(struct strbuf *buf,
 		}
 	}
 
-	w = reftable_new_writer(&strbuf_add_void, buf, &opts);
+	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
 	reftable_writer_set_limits(w, min, max);
 
 	for (i = 0; i < n; i++) {
@@ -70,7 +70,7 @@ static void write_test_log_table(struct strbuf *buf,
 		.exact_log_message = 1,
 	};
 	struct reftable_writer *w = NULL;
-	w = reftable_new_writer(&strbuf_add_void, buf, &opts);
+	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
 	reftable_writer_set_limits(w, update_index, update_index);
 
 	for (i = 0; i < n; i++) {
@@ -412,7 +412,7 @@ static void test_default_write_opts(void)
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 
 	struct reftable_ref_record rec = {
 		.refname = "master",
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index b8a32240164..6b99daeaf2a 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -51,7 +51,7 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 		.hash_id = hash_id,
 	};
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
 	struct reftable_ref_record ref = { NULL };
 	int i = 0, n;
 	struct reftable_log_record log = { NULL };
@@ -130,7 +130,7 @@ static void test_log_buffer_size(void)
 					   .message = "commit: 9\n",
 				   } } };
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 
 	/* This tests buffer extension for log compression. Must use a random
 	   hash, to ensure that the compressed part is larger than the original.
@@ -171,7 +171,7 @@ static void test_log_overflow(void)
 					   .message = msg,
 				   } } };
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 
 	uint8_t hash1[GIT_SHA1_RAWSZ]  = {1}, hash2[GIT_SHA1_RAWSZ] = { 2 };
 
@@ -202,7 +202,7 @@ static void test_log_write_read(void)
 	struct reftable_block_source source = { NULL };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	const struct reftable_stats *stats = NULL;
 	reftable_writer_set_limits(w, 0, N);
 	for (i = 0; i < N; i++) {
@@ -294,7 +294,7 @@ static void test_log_zlib_corruption(void)
 	struct reftable_block_source source = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	const struct reftable_stats *stats = NULL;
 	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
 	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
@@ -535,7 +535,7 @@ static void test_table_refs_for(int indexed)
 
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 
 	struct reftable_iterator it = { NULL };
 	int j;
@@ -628,7 +628,7 @@ static void test_write_empty_table(void)
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_block_source source = { NULL };
 	struct reftable_reader *rd = NULL;
 	struct reftable_ref_record rec = { NULL };
@@ -666,7 +666,7 @@ static void test_write_object_id_min_length(void)
 	};
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
 		.value_type = REFTABLE_REF_VAL1,
@@ -701,7 +701,7 @@ static void test_write_object_id_length(void)
 	};
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
 		.value_type = REFTABLE_REF_VAL1,
@@ -735,7 +735,7 @@ static void test_write_empty_key(void)
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_ref_record ref = {
 		.refname = "",
 		.update_index = 1,
@@ -758,7 +758,7 @@ static void test_write_key_order(void)
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_ref_record refs[2] = {
 		{
 			.refname = "b",
@@ -801,7 +801,7 @@ static void test_write_multiple_indices(void)
 	struct reftable_reader *reader;
 	int err, i;
 
-	writer = reftable_new_writer(&strbuf_add_void, &writer_buf, &opts);
+	writer = reftable_new_writer(&strbuf_add_void, &noop_flush, &writer_buf, &opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (i = 0; i < 100; i++) {
 		struct reftable_ref_record ref = {
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
index 699e1aea412..b9cc62554ea 100644
--- a/reftable/refname_test.c
+++ b/reftable/refname_test.c
@@ -30,7 +30,7 @@ static void test_conflict(void)
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_ref_record rec = {
 		.refname = "a/b",
 		.value_type = REFTABLE_REF_SYMREF,
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index db8de197f6c..7c7cae5f99b 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -88,6 +88,7 @@ struct reftable_stats {
 /* reftable_new_writer creates a new writer */
 struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
+		    int (*flush_func)(void *),
 		    void *writer_arg, struct reftable_write_options *opts);
 
 /* Set the range of update indices for the records we will add. When writing a
diff --git a/reftable/stack.c b/reftable/stack.c
index 7ffeb3ee107..ab295341cc4 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -8,6 +8,7 @@ license that can be found in the LICENSE file or at
 
 #include "stack.h"
 
+#include "../write-or-die.h"
 #include "system.h"
 #include "merged.h"
 #include "reader.h"
@@ -16,7 +17,6 @@ license that can be found in the LICENSE file or at
 #include "reftable-record.h"
 #include "reftable-merged.h"
 #include "writer.h"
-
 #include "tempfile.h"
 
 static int stack_try_add(struct reftable_stack *st,
@@ -47,6 +47,13 @@ static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
 	return write_in_full(*fdp, data, sz);
 }
 
+static int reftable_fd_flush(void *arg)
+{
+	int *fdp = (int *)arg;
+
+	return fsync_component(FSYNC_COMPONENT_REFERENCE, *fdp);
+}
+
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 		       struct reftable_write_options config)
 {
@@ -545,6 +552,9 @@ int reftable_addition_commit(struct reftable_addition *add)
 		goto done;
 	}
 
+	fsync_component_or_die(FSYNC_COMPONENT_REFERENCE, lock_file_fd,
+			       get_tempfile_path(add->lock_file));
+
 	err = rename_tempfile(&add->lock_file, add->stack->list_file);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -639,7 +649,7 @@ int reftable_addition_add(struct reftable_addition *add,
 			goto done;
 		}
 	}
-	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
+	wr = reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,
 				 &add->stack->config);
 	err = write_table(wr, arg);
 	if (err < 0)
@@ -731,7 +741,7 @@ static int stack_compact_locked(struct reftable_stack *st, int first, int last,
 	strbuf_addstr(temp_tab, ".temp.XXXXXX");
 
 	tab_fd = mkstemp(temp_tab->buf);
-	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
+	wr = reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd, &st->config);
 
 	err = stack_write_compact(st, wr, first, last, config);
 	if (err < 0)
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
index 04044fc1a0f..4066924eee4 100644
--- a/reftable/test_framework.c
+++ b/reftable/test_framework.c
@@ -20,3 +20,8 @@ ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
 	strbuf_add(b, data, sz);
 	return sz;
 }
+
+int noop_flush(void *arg)
+{
+	return 0;
+}
diff --git a/reftable/test_framework.h b/reftable/test_framework.h
index ee44f735aea..687390f9c23 100644
--- a/reftable/test_framework.h
+++ b/reftable/test_framework.h
@@ -56,4 +56,6 @@ void set_test_hash(uint8_t *p, int i);
  */
 ssize_t strbuf_add_void(void *b, const void *data, size_t sz);
 
+int noop_flush(void *);
+
 #endif
diff --git a/reftable/writer.c b/reftable/writer.c
index ee4590e20f8..92935baa703 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -121,6 +121,7 @@ static struct strbuf reftable_empty_strbuf = STRBUF_INIT;
 
 struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
+		    int (*flush_func)(void *),
 		    void *writer_arg, struct reftable_write_options *opts)
 {
 	struct reftable_writer *wp =
@@ -136,6 +137,7 @@ reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 	wp->write = writer_func;
 	wp->write_arg = writer_arg;
 	wp->opts = *opts;
+	wp->flush = flush_func;
 	writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
 
 	return wp;
@@ -603,6 +605,12 @@ int reftable_writer_close(struct reftable_writer *w)
 	put_be32(p, crc32(0, footer, p - footer));
 	p += 4;
 
+	err = w->flush(w->write_arg);
+	if (err < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
 	err = padded_write(w, footer, footer_size(writer_version(w)), 0);
 	if (err < 0)
 		goto done;
diff --git a/reftable/writer.h b/reftable/writer.h
index 09b88673d97..8d0df9cc528 100644
--- a/reftable/writer.h
+++ b/reftable/writer.h
@@ -16,6 +16,7 @@ license that can be found in the LICENSE file or at
 
 struct reftable_writer {
 	ssize_t (*write)(void *, const void *, size_t);
+	int (*flush)(void *);
 	void *write_arg;
 	int pending_padding;
 	struct strbuf last_key;

base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
-- 
gitgitgadget
