Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BA48425A
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632976; cv=none; b=JmH9c/pWi51GfhEV1IjZautcgy32NKL2gdvwKfJgJZAounPkGheWQQaD9HhXUZlhK9+VDfnPRyJe2Limbp5vdA2wWhhiAIqq+eUlPf3IqxXgNAdn5pOBTJR6MnO601GemPORK3WTv3aWrCgW2OG/DYT3C2aWh5AWXqBdMNcejMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632976; c=relaxed/simple;
	bh=bU2CU0iTLk8/txdYNlrSCQgEfQOdLya3TIhPEepvV3Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gdaLOCZIwbH/ZXrULHshNaM6UpbSI8K98PwsWnZOQzgbcmsLe0rIMXepSugG+pf8ENIbX6ttd1m7poMgOudqJYmZ0grYCUe3KHiDXTJW52cL78cWRshgO74GN9qW25xr9miuDekwfZJ9C9MldMmBAMUXEBnN60WYAXJbn8HlmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT7jGt5x; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT7jGt5x"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6acbf97e9a1so485252eaf.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632964; x=1787237764; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=699DE3jqHYq0tQflRVXFP2Cazc5yXLl9qVDVRV3qOF4=;
        b=TT7jGt5x5q554op9/mlIheXx1xOXeLFuzzxalMR41WDymitdCt5OPn8jGaU2b1H4up
         rMz6y2u+FFH1U8C54P18gQf7Fs/GX5qoxrpkZgqTIbSBo0w96icAt5PXlqzE0s0BWLvJ
         GoaWBTQE7yrLZskCiSf1desibygPFj5Kenw3OjjB/Tw1INmrQYTdGy8BgCkIJ9PYa6QO
         UkcY9n0kugIHPCws93evjV5wALnLS4wd+w8cANYV3lMUfbfZIKNlBuHxFhCMv2K9hs1b
         JXtubArki4bRWM7rtlNP1hI2IRkV9EurwDlQCALwSn3dNImvLmXeXuRF6ETmNzTKFsTP
         cWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632964; x=1787237764;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=699DE3jqHYq0tQflRVXFP2Cazc5yXLl9qVDVRV3qOF4=;
        b=Gy+Fca5yxwLVehtGf9cs9OHBw75CRl2MOSe11hgEcF9veHuLXXdBPRmdimtt8On2Nr
         UuqJGrF4S/+D7qTmQyVxiRiHCmtZMWv0BFuWq8FHO1T5D+7hqIfrYNxvKtyikrBVdAiG
         YMcBd0plv1g2dKHWes9OFHT5qWDAb3njjfUx/zzLLdBhMtY+QWk4cBdPAbBwtUzp+cQZ
         Wje3Jtb46AHoKJQfwEHQ6pQRc0Rv3I1e1FxVSNw5XSFOUl37tnD+E0UQQ7OilBf5pMar
         V3lxwXphoRFhX228uF4D3SNSt9wfZOR6SugRugZNd/AT56/GEN6cneG4E7lPggHgJxWw
         uZsA==
X-Gm-Message-State: AOJu0YwoySkTEVgP+H3/pPnARPa5Vyp9WLi5jDz9IU8s/B73S4p/VuM7
	+pA+Gx8qGAwzEu3fFGoewOGfESKj98PPrZ/8RVx+N/pM/z2YxgDX/xXXeQLNVQ==
X-Gm-Gg: AR+sD11/Wcwd3H7Aksn7FkTbLSk6n4c0GFxmNcFhEn1XfC/rBPvjvgsKCwwDRmHC6J+
	K+4JIIf8D5F3MX1GTnyGzLYBJ0+34b2GEzyeQyKj2nI8wvAQwsOpdIvUBtiO8Sw9pqVfIlYkuxd
	5srsPtop478gyYMpSwOXh73SogsDsuJ3xpCdQ2Jhbzb7YUwPJ6uX2cyCvrNTSV7b5ho7bsalFzm
	DVgLAU0+hMakDuA0tkTd7Ll2//ZahiqmbeHwuBVKOkDVfbavpWFqKW3gG1BO1sIA/bl4NN5eB4P
	ZUQMiJo7cdlEA4Qu8bqtJW5KrYLOjBZcQ4m6Y7hcD4Jeo+jsvjx+XMFyRpE2u26X939DGOEWyF6
	bJN1D6ik269+4+FWZqBDR4+FxcdzoSrwBLY5zuz89FxLJy+G1s6FvOuTiFDVqcepbsonba3sCTv
	GKoUa3dwnX0t3cyv6mRGMvGZdoYJY9bYZVz5faNF5+Jd84juWcwAXR5uOnJbF+MjC1
X-Received: by 2002:a05:6820:1505:b0:6ae:4d57:a5fe with SMTP id 006d021491bc7-6b0c4353409mr5393311eaf.20.1786632963337;
        Thu, 13 Aug 2026 07:56:03 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0c4745340sm2485040eaf.12.2026.08.13.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:02 -0700 (PDT)
Message-Id: <cfbf6c9567a360f35b27873f66f71a5c94e6a597.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:44 +0000
Subject: [PATCH v3 06/13] delta: widen `create_delta()` and `diff_delta()` to
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 96ecee393e..08c6d294cc 100644
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
index 12075c54c5..42a211905d 100644
--- a/delta.h
+++ b/delta.h
@@ -42,8 +42,8 @@ size_t sizeof_delta_index(struct delta_index *index);
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
index bcc331af3e..7cbedeb507 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -318,8 +318,8 @@ size_t sizeof_delta_index(struct delta_index *index)
 
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

