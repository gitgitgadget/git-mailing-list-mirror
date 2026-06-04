Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4440802C
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570280; cv=none; b=fYruNqcDIo1SYkqBRy8k5MkJ6AKqOpSgKgbgOm6+IMLVvHag6QH6uhOObVPZhDx5VCQ21N7+IGEkFxlQtdbDVF7vS8FtqeOz2lvcMPKQPOh7lfshqD8nb7sTLDE2udvs8X7O9Oo9+SIhvv0ztM2hVZR3M4pi1UzNMxdSWPV5MJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570280; c=relaxed/simple;
	bh=PzMuDHn1B0CdosbC/Rj+xWK3XMum6/7dK0OSho1k74Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a521b3ovN61BAKJznAE9sYrelppqdctsjCaYU/RuCvoTj1bVBPvlc4hc3UNs6QtlxXHj437E08KKMrd3cVHggWNCk8eyR9EtxILVfhLUF2JZxuW6o9qhJ9/ZbHeZYZ/0yrCrjcdembMdZVFKaieKyWAuRCF/fJ+fpiQvKcUUjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZrsf/cR; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZrsf/cR"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304d8362a58so328509eec.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780570278; x=1781175078; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaBlM4cNgc8Fuapm5M5sRNaI1m419/QRUqlVg3CVfj4=;
        b=fZrsf/cRV3ihao47Q29L7TMLzNKigi7bu89iAgGxlaoagiN8f7Dm7F/SWh83wXcmdI
         N9QaXEP2gzRGlE9BWV0Ze2MssSCzlnD30h1ZMHkeWjsb+0svSObCh9ivmQgkY7wzsR7B
         9DNlxH6EIQ71dnWshMftrM3H/78v622JE/m7pE+1AR/fq95oJ+qvqRgKb41FrvCmpCbT
         4GV3zQ3oJhZNiSkF/6EEOayL9O+PKfvFgtYUWtdzzG0N9G6S0KUE9kJQEExw+f4ri2a4
         oKkj5gTY/Kmnv/CSLuydTsQt2JGASFSkLdZA/P/x0V35UlQDgnsJ4jNw6JSzopSUIEwP
         HWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570278; x=1781175078;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaBlM4cNgc8Fuapm5M5sRNaI1m419/QRUqlVg3CVfj4=;
        b=Vjm5DV4vk3ejS8Fi84ef9Kprk1nq0EFiwob6MKdT6dkYVePauel0RGduDtSozgZ0m0
         gHk7BuaaZgUt9THv/oaPoD9/ZDuR+vwbkIaL5o/LXsx+nNrO7mwmEF9uQB6TiblwbJtn
         2UvlgAlM0oP7/T3tJIEdlqGPwTMgKoNFML38cM/e6mH3TrU3NREogRJ+Sc75nUvm6cuL
         MjGFln++chpHKA7GWHCE+GbKZsN2w4du8mqe2tIY0bduToABgvTNpRVMb6fd1/ooBRP2
         0kwrMXU2VqBNDLcUoo4azh9Tn7v/bwyosRf4GLTtZcuw4V4BR8GGVSSp1LucRq0y/Cn0
         NL+g==
X-Gm-Message-State: AOJu0YzV3w0JrBWoToVEOed7mwvU7+F+tor4RzbQPeEIt9QiJ1t87ugG
	jTnSdKABvv4mqm4cWpJOhN+mDnZ1KnkMqTA02h7f+fgo5U+OX4CQ3du5pPkd+A==
X-Gm-Gg: Acq92OEm6xKYLVmu+D2Dnym1ZTkAM9xU2J+U5ZGaOjgop90KaSNDIKEqe0gzXEDdScl
	JWZ5k+Chs7a20bCXsFv4xi5V1phy4mMBJv+zlHbmgs/2ryOOvSEZY7dE3WUKhwpkRlaU6gZPa7r
	+/UfO3MimiQJzqtYpvT7tWzWBCry1hmR/hdzpGFTeXyYndglbolPZi6he/8v9qJ0/bl9BjFH6pV
	g1FINqkfoBmcBxSXeQDAgu7RkGpXIEap07igrBnVtv9MEH8udok2KvL7LsMUJt/Xk/uIbds1K8k
	iyPMo6lFGz7F6e5iQAVXl2d5WQOrEDx1sC/4Xeud1Reo54TWGiCAIaV+16FXcGF4tQhPWxvOD/d
	gjBhCWYulzSXB4gIipa6HPWkG6+K11j615w12HyqiWe8z88GaqU1EN8lUZB2Vz3diFiLVFF5002
	j6x7P4Knge0pjPdo87pBnqSLztb9s5nCrm+jTtjw==
X-Received: by 2002:a05:7301:78c5:b0:2d2:d5a3:e97c with SMTP id 5a478bee46e88-30761f575d1mr858566eec.12.1780570278204;
        Thu, 04 Jun 2026 03:51:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea9226sm4704102eec.19.2026.06.04.03.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:51:17 -0700 (PDT)
Message-Id: <1fd7646ca14f7ec392c85fab10255f08d0d79368.1780570273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 10:51:07 +0000
Subject: [PATCH 2/7] patch-delta: use size_t for sizes
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`patch_delta()` takes the source and delta sizes by value and writes
back the reconstructed target size through an `unsigned long *`.  That
datatype cannot represent a value that exceeds 4 GiB on systems where
`unsigned long` is 32-bit (notably 64-bit Windows builds), though, even
though the delta encoding itself, the on-disk layout, and the in-memory
buffers happily carry such sizes. A `size_t` companion to
`get_delta_hdr_size()`, `get_delta_hdr_size_sz()`, was introduced in
17fa077596 (delta, packfile: use size_t for delta header sizes,
2026-05-08) precisely so that `patch_delta()` could be widened without
changing the on-the-wire decoding helper's signature.

Widen `patch_delta()`'s three size parameters to `size_t` and switch
its internal use of `get_delta_hdr_size()` to the `_sz` variant.
Then propagate the wider type through the callers.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c                  |  2 +-
 builtin/index-pack.c     |  4 ++--
 builtin/unpack-objects.c |  2 +-
 delta.h                  |  6 +++---
 packfile.c               |  4 +---
 patch-delta.c            | 12 ++++++------
 t/helper/test-delta.c    | 10 ++++++----
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/apply.c b/apply.c
index 249248d4f2..3cf544e9a9 100644
--- a/apply.c
+++ b/apply.c
@@ -3232,7 +3232,7 @@ static int apply_binary_fragment(struct apply_state *state,
 				 struct patch *patch)
 {
 	struct fragment *fragment = patch->fragments;
-	unsigned long len;
+	size_t len;
 	void *dst;
 
 	if (!fragment)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index cf0bd8280d..3c4474e681 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -71,7 +71,7 @@ struct base_data {
 	/* Not initialized by make_base(). */
 	struct list_head list;
 	void *data;
-	unsigned long size;
+	size_t size;
 };
 
 /*
@@ -1048,7 +1048,7 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 {
 	void *delta_data, *result_data;
 	struct base_data *result;
-	unsigned long result_size;
+	size_t result_size;
 
 	if (show_stat) {
 		int i = delta_obj - objects;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 59e9b8711e..e7a50c493c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -314,7 +314,7 @@ static void resolve_delta(unsigned nr, enum object_type type,
 			  void *delta, unsigned long delta_size)
 {
 	void *result;
-	unsigned long result_size;
+	size_t result_size;
 
 	result = patch_delta(base, base_size,
 			     delta, delta_size,
diff --git a/delta.h b/delta.h
index fad68cfc45..bb149dc82b 100644
--- a/delta.h
+++ b/delta.h
@@ -75,9 +75,9 @@ diff_delta(const void *src_buf, unsigned long src_bufsize,
  * *trg_bufsize is updated with its size.  On failure a NULL pointer is
  * returned.  The returned buffer must be freed by the caller.
  */
-void *patch_delta(const void *src_buf, unsigned long src_size,
-		  const void *delta_buf, unsigned long delta_size,
-		  unsigned long *dst_size);
+void *patch_delta(const void *src_buf, size_t src_size,
+		  const void *delta_buf, size_t delta_size,
+		  size_t *dst_size);
 
 /* the smallest possible delta size is 4 bytes */
 #define DELTA_SIZE_MIN	4
diff --git a/packfile.c b/packfile.c
index 89366abfe3..e202f48837 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1964,10 +1964,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			      (uintmax_t)curpos, p->pack_name);
 			data = NULL;
 		} else {
-			unsigned long sz;
 			data = patch_delta(base, base_size, delta_data,
-					   delta_size, &sz);
-			size = sz;
+					   delta_size, &size);
 
 			/*
 			 * We could not apply the delta; warn the user, but
diff --git a/patch-delta.c b/patch-delta.c
index b5c8594db6..44cda97994 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -12,13 +12,13 @@
 #include "git-compat-util.h"
 #include "delta.h"
 
-void *patch_delta(const void *src_buf, unsigned long src_size,
-		  const void *delta_buf, unsigned long delta_size,
-		  unsigned long *dst_size)
+void *patch_delta(const void *src_buf, size_t src_size,
+		  const void *delta_buf, size_t delta_size,
+		  size_t *dst_size)
 {
 	const unsigned char *data, *top;
 	unsigned char *dst_buf, *out, cmd;
-	unsigned long size;
+	size_t size;
 
 	if (delta_size < DELTA_SIZE_MIN)
 		return NULL;
@@ -27,12 +27,12 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 	top = (const unsigned char *) delta_buf + delta_size;
 
 	/* make sure the orig file size matches what we expect */
-	size = get_delta_hdr_size(&data, top);
+	size = get_delta_hdr_size_sz(&data, top);
 	if (size != src_size)
 		return NULL;
 
 	/* now the result size */
-	size = get_delta_hdr_size(&data, top);
+	size = get_delta_hdr_size_sz(&data, top);
 	dst_buf = xmallocz(size);
 
 	out = dst_buf;
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 52ea00c937..8223a60229 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -21,7 +21,7 @@ int cmd__delta(int argc, const char **argv)
 	int fd;
 	struct strbuf from = STRBUF_INIT, data = STRBUF_INIT;
 	char *out_buf;
-	unsigned long out_size;
+	size_t out_size;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p")))
 		usage(usage_str);
@@ -31,11 +31,13 @@ int cmd__delta(int argc, const char **argv)
 	if (strbuf_read_file(&data, argv[3], 0) < 0)
 		die_errno("unable to read '%s'", argv[3]);
 
-	if (argv[1][1] == 'd')
+	if (argv[1][1] == 'd') {
+		unsigned long delta_size;
 		out_buf = diff_delta(from.buf, from.len,
 				     data.buf, data.len,
-				     &out_size, 0);
-	else
+				     &delta_size, 0);
+		out_size = delta_size;
+	} else
 		out_buf = patch_delta(from.buf, from.len,
 				      data.buf, data.len,
 				      &out_size);
-- 
gitgitgadget

