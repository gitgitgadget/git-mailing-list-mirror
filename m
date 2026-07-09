Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F639A815
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615794; cv=none; b=ej1/tl+gVJ0ApqD8ji+aVdK0zW2l7t9lruoDPaxpYi24CCjSvz8+CUiUoBPgEnEkZzhSCEzM1DYtF3Ax9FqCGTDWZW9bb+gUfxEYC56IqwDgj0mUvZ0AOWXD+OIWaUnzqpf+lYaI5xD2JZg+/w+/67bFcol7vpROYWkm503x1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615794; c=relaxed/simple;
	bh=sP9qAe7WrMd13MY2FDHGde0MSwlVeEHqyHkcBKpvkkA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uZvkwN+aa2qw+E9Ui3UMwv3bm1jeBgtlVoG3jSc2UzdlC52FVF2xPCpVbHF2pX1sVAIqdBj6KGjBdCad3E2RGtx1+eAwWWtMgR3X2VMXaz8rkVBPti9GRN3eN11JC1kQsZX2v6VQyg/8+ztyivEs6b89PqRq1GVZVle4wYs67Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb2K/Lqj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb2K/Lqj"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so32359a12.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615792; x=1784220592; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mPzfvwHS7RuNGPQNpY/ahNHkovUbbRfIhDsVIWy39aU=;
        b=mb2K/LqjOzfESOjHxi0CJyBBJkp3XixqCdyN9h+dGYRAZ5tQeNedLw0IpTUBckT28K
         gJuTafyMcBz1yJwsQHzqWJbqMj/QpvGdVNZ8IHJhWJY57txww8a1wA2Omqn3avQlgYWJ
         lCMEy/C5JR8lbH5ELFgRDELd/JMx3XSUkcOIgLc5DTDcB3kS9ASOfK7trOedqGQr/N0d
         uzWWab6eC32Ifez+jkb40L2p42On5XMttmFzaHZ7La9IoPXhXftW5bGgkf/6mQ6/+B9u
         /UP84cwbgv/rFXftg6UA09ZoDrZ6WDVoJ3N/Lw80BEzO8WDnPku+/SLfoOwtCgdMEl7l
         JHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615792; x=1784220592;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPzfvwHS7RuNGPQNpY/ahNHkovUbbRfIhDsVIWy39aU=;
        b=HvLfQTrxQvlWaSoaH1RzQj9TZgTDns9Qz0+XFjP109p4aOLBhJ84/vJ7qHxuOoUxtj
         hBNgfmzp+oLeyOvwXjE7KMrV8VYoW1jeblHv7M9IYwOh/XR9lRers3eVvG0FP34urrnq
         M5aQkjhUn4aGaeg2Z1TCk5ClptjsPDAZ/tNtOwOXnNYX51ErOym3CjnmktCeFw+WVKLj
         KdlvwpNEmbuYJt05iwH4yj3xL7lPs2Cwn5fkj5tgiCSkP55iIKcLZuuz0cxmjqN5gHGl
         EjAb97IF2kC/xD+KnOX9DldBjVTcxQMXuwrejsYQQbH2kROeCHBiJMOZnFfAU5vF/SwD
         +ymA==
X-Gm-Message-State: AOJu0YwO8aN3EwVxtByH/Y+AUeqpHaQrLmyyKh10bwD08ioGbvs85pav
	ei0Hvq/XkBQjUGIbxDPFehREw7bGbfrOLbrWn1EBtygdOlhw35K0aVedzvB8jQ==
X-Gm-Gg: AfdE7cn1aBnckzxJac/pWKFoWGhC84v0Y7LEP37MBDBE8HyzbtkYXdPk4glCnzj1rEj
	zLP3K86Mjn1uaQ7oyFEf6yZUV1QrpXBwzwEQrNTgUUEUv/rl8krXGJ1RhDkKHhcNK52UJSHJBux
	HxXOZiRyzv9nenimrhmYj1BupcGzrDC5P2m6K3zZBNQpofzuNPv3t7TXdVt0M1SRZvWJXfwRL77
	cqdRu+y6n1ScFSoBEArzgl7uM7LdtnzzRcrVSooBnrqZB0VzBbaeiIVJJ2YJCpY8A5iItFG55+f
	oTox5e9R4crf8FU6bDI5GTweGYpv1phqRwcHBj/tPBDJV6rlvQ57h71/FJFcxOQaWzR6nEjeWU7
	42+q9SBAGgd9ddA0/zNSvIDvr5VQDCiHFPdqVE3hBxUSSUzDdxHu/JlVHa0yBRbToQfnXaNpugu
	s5ya31/57R4tZn50g=
X-Received: by 2002:a05:6a20:9595:b0:3c0:9c19:65ac with SMTP id adf61e73a8af0-3c0bd3799cbmr9865947637.68.1783615791844;
        Thu, 09 Jul 2026 09:49:51 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483941csm33073334eec.7.2026.07.09.09.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:51 -0700 (PDT)
Message-Id: <e1ae83ba0378ad5d4278e220584a3fbc37a1dc4e.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:33 +0000
Subject: [PATCH 06/12] delta: widen `create_delta()` and `diff_delta()` to
 `size_t`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Last stop in the delta-encoding API widening for >4 GiB blobs on
Windows: with `create_delta_index()` done in the prior commit and
`create_delta()`/`diff_delta()` finished here, every byte count that
crosses delta.h is now `size_t`. The struct fields they store into have
been `size_t` since the diff-delta struct widening.

The API change must move with all callers in the same commit (the build
only passes when every `&delta_size` matches the new `size_t*`). Caller
updates are kept minimal:

  * builtin/pack-objects.c `get_delta()` and `try_delta()`: widen only
    the local `delta_size` variable; the surrounding unsigned-long
    locals and their `cast_size_t_to_ulong()` shims are out of scope
    here and will be cleaned up in their own commits.

  * builtin/fast-import.c, diff.c, t/helper/test-pack-deltas.c:
    keep the local unsigned-long delta size (each feeds a still-
    unsigned-long downstream consumer: zlib's `avail_in`,
    `deflate_it()`, the test helper's own `do_compress()`), and bridge
    via a temporary `size_t` plus `cast_size_t_to_ulong()`. The new
    casts are paid back in later topics that widen those consumers.

  * t/helper/test-delta.c: widen the local outright (no downstream
    consumer beyond the test's own `out_size`, which is already
    `size_t`).

Note that GCC struggles a bit to figure out that `deltalen` is always
initialized before it is used; To help it along, we initialize it to 0.
This work-around will go away in a later patch series when `deltalen`
can be widened to `size_t`.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-import.c       |  6 ++++--
 builtin/pack-objects.c      |  6 ++++--
 delta.h                     | 10 +++++-----
 diff-delta.c                |  4 ++--
 diff.c                      |  4 +++-
 t/helper/test-delta.c       |  2 +-
 t/helper/test-pack-deltas.c |  5 +++--
 7 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index aa656c5195..1c6e5366c2 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -962,7 +962,7 @@ static int store_object(
 	struct object_entry *e;
 	unsigned char hdr[96];
 	struct object_id oid;
-	unsigned long hdrlen, deltalen;
+	unsigned long hdrlen, deltalen = 0;
 	struct git_hash_ctx c;
 	git_zstream s;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
@@ -998,11 +998,13 @@ static int store_object(
 
 	if (last && last->data.len && last->data.buf && last->depth < max_depth
 		&& dat->len > the_hash_algo->rawsz) {
+		size_t deltalen_st;
 
 		delta_count_attempts_by_type[type]++;
 		delta = diff_delta(last->data.buf, last->data.len,
 			dat->buf, dat->len,
-			&deltalen, dat->len - the_hash_algo->rawsz);
+			&deltalen_st, dat->len - the_hash_algo->rawsz);
+		deltalen = cast_size_t_to_ulong(deltalen_st);
 	} else
 		delta = NULL;
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 63ceeb736f..315ea0ed7e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -353,7 +353,8 @@ static void index_commit_for_bitmap(struct commit *commit)
 
 static void *get_delta(struct object_entry *entry)
 {
-	unsigned long size, base_size, delta_size;
+	unsigned long size, base_size;
+	size_t delta_size;
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
 	size_t size_st = 0, base_size_st = 0;
@@ -2808,7 +2809,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
-	unsigned long trg_size, src_size, delta_size, sizediff, max_size, sz;
+	unsigned long trg_size, src_size, sizediff, max_size, sz;
+	size_t delta_size;
 	unsigned ref_depth;
 	enum object_type type;
 	void *delta_buf;
diff --git a/delta.h b/delta.h
index a19586d789..59ccaaa0e0 100644
--- a/delta.h
+++ b/delta.h
@@ -42,8 +42,8 @@ unsigned long sizeof_delta_index(struct delta_index *index);
  */
 void *
 create_delta(const struct delta_index *index,
-	     const void *buf, unsigned long bufsize,
-	     unsigned long *delta_size, unsigned long max_delta_size);
+	     const void *buf, size_t bufsize,
+	     size_t *delta_size, size_t max_delta_size);
 
 /*
  * diff_delta: create a delta from source buffer to target buffer
@@ -54,9 +54,9 @@ create_delta(const struct delta_index *index,
  * updated with its size.  The returned buffer must be freed by the caller.
  */
 static inline void *
-diff_delta(const void *src_buf, unsigned long src_bufsize,
-	   const void *trg_buf, unsigned long trg_bufsize,
-	   unsigned long *delta_size, unsigned long max_delta_size)
+diff_delta(const void *src_buf, size_t src_bufsize,
+	   const void *trg_buf, size_t trg_bufsize,
+	   size_t *delta_size, size_t max_delta_size)
 {
 	struct delta_index *index = create_delta_index(src_buf, src_bufsize);
 	if (index) {
diff --git a/diff-delta.c b/diff-delta.c
index c93ac42594..15210e8381 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -318,8 +318,8 @@ unsigned long sizeof_delta_index(struct delta_index *index)
 
 void *
 create_delta(const struct delta_index *index,
-	     const void *trg_buf, unsigned long trg_size,
-	     unsigned long *delta_size, unsigned long max_size)
+	     const void *trg_buf, size_t trg_size,
+	     size_t *delta_size, size_t max_size)
 {
 	unsigned int i, val;
 	off_t outpos, moff;
diff --git a/diff.c b/diff.c
index 2a9d0d8687..69eb2f76a4 100644
--- a/diff.c
+++ b/diff.c
@@ -3647,9 +3647,11 @@ static void emit_binary_diff_body(struct diff_options *o,
 	delta = NULL;
 	deflated = deflate_it(two->ptr, two->size, &deflate_size);
 	if (one->size && two->size) {
+		size_t delta_size_st = 0;
 		delta = diff_delta(one->ptr, one->size,
 				   two->ptr, two->size,
-				   &delta_size, deflate_size);
+				   &delta_size_st, deflate_size);
+		delta_size = cast_size_t_to_ulong(delta_size_st);
 		if (delta) {
 			void *to_free = delta;
 			orig_size = delta_size;
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 8223a60229..d807afef75 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -32,7 +32,7 @@ int cmd__delta(int argc, const char **argv)
 		die_errno("unable to read '%s'", argv[3]);
 
 	if (argv[1][1] == 'd') {
-		unsigned long delta_size;
+		size_t delta_size;
 		out_buf = diff_delta(from.buf, from.len,
 				     data.buf, data.len,
 				     &delta_size, 0);
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 840797cf0d..5e0f726842 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -49,7 +49,7 @@ static void write_ref_delta(struct hashfile *f,
 {
 	unsigned char header[MAX_PACK_OBJECT_HEADER];
 	unsigned long delta_size, compressed_size, hdrlen;
-	size_t size, base_size;
+	size_t size, base_size, delta_size_st = 0;
 	enum object_type type;
 	void *base_buf, *delta_buf;
 	void *buf = odb_read_object(the_repository->objects,
@@ -65,7 +65,8 @@ static void write_ref_delta(struct hashfile *f,
 		die("unable to read %s", oid_to_hex(base));
 
 	delta_buf = diff_delta(base_buf, base_size,
-			       buf, size, &delta_size, 0);
+			       buf, size, &delta_size_st, 0);
+	delta_size = cast_size_t_to_ulong(delta_size_st);
 
 	compressed_size = do_compress(&delta_buf, delta_size);
 
-- 
gitgitgadget

