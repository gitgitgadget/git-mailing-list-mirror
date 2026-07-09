Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F0A39A4D8
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615795; cv=none; b=seMpi/Y1uyFC/rYwITZW0e3+Vm2PKqullt+bKPRg11EX9IqnPCihgCa6udnVfmttEOZODGWNwKsyjpTKPOjLE7WqHauLCJ7Vatq5eOyeC+ESXItRh1YTvuWSpbIe/ve1msk5jOphepVmP/BjJ7d6gzEdIYZpwfL6JypdfTs6sZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615795; c=relaxed/simple;
	bh=MOOP3NamdNGqq2/P3Nvk3w5+Yp+EgaNHFzqKKe22HWo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T5hddCs00zNmHP+zoWtaqfhAVuyq/D2btytJezd02YYNJBU9m+KXyIlhvgvsOraj5emnTKR+W8d/kkNLhbdJhOJRrQXtZ/toDXvGrs0LxOP/5GYNRDqaGCoGSdNxbRAmDboLxaIjZC7w/D1auVaq+8jinL7Kl0x3yK+l9q302Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kj7UP14K; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj7UP14K"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so22537a12.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615793; x=1784220593; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j5NcUFgo9JNI0BwQouU4K9XaENHC6e+p5G7vvE9b01s=;
        b=kj7UP14K4rygDEMQ5EnzEAe6m85C25O8e3N/j3xw8M1YxoLUhBVRFMrPISPD3t3Xth
         W7a4qUdCCcSsNZahqMzZLkUWLi712bhRRo36k5BZ8f+frrg3d26ugtd862z/nl/OGHV9
         JGzKfKqJfJPGArztQ2QoyP0aHTf4Y/C5hzD66xwikuTWDoyZL2ROwVAXLQE8FPIrbEcA
         IUvHRMTCM+0SVxx+Hc4yOzBscrmqu3xtPCuNWsH4mvYvJyFQdaKipbaqbqiyslNjU985
         ip2QTyQHlro6Enz1X0/yRCgBnMVt5DN7b2GqpYc2RY3SWXRuNSwRuNJYFiQ/dnQntV0a
         IUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615793; x=1784220593;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5NcUFgo9JNI0BwQouU4K9XaENHC6e+p5G7vvE9b01s=;
        b=M42hc2+ZkqQxlKEDEwNmDL3huIEZufYk0vuRvYAVNdLJh4/Zj/M/+Qeq+DQKk6rLix
         UBLCRGMzwmvc/io2jd/xvjen5wUeu+sK0oqzdpwEUqmfep/aNrTVhTuyqHxDK1kTRw7v
         pmky4ciHGKCHP5q1SlstJnoam4LEi7K4o4S9Le66blP1OwlgsZQcAXtvFW6PNCGBzHJS
         TGHkC4B3ZC2O6EJ5CXtJo/GQ58Xxb1TxESx2A3RW8/N9Vxx9IOygsE6VSrKNuhMvHjgT
         PE8pNtdhadkLzNebCuyl2greED4VYg8lYBO7aq9GkhVSfmK1p/HT/dfsszmpf6JIiOB6
         F1lw==
X-Gm-Message-State: AOJu0Yz056lxl8aD0Eq+V2QAQOyLnIf6SqeTJEZFce3LLkdOmhKnTO0m
	B1fEg1TbwlTlhxelookeCS6o8pHYw4sk8iOwnFV6Yo1jg96CeEjBQnAT83WQMQ==
X-Gm-Gg: AfdE7clGgSQmKUdEa2QXqfz4pwxnfwFQ1cSRzEvHMUnTpGRWeVskZM7KMWJG5iSeljx
	Mi6WaomBN3OdHjJA0D8w/5Py5tHZGp+Uu9otP9XyXXhbB3aJo4s6mwxEYAmBVcif6dkUrcSUqB+
	sEC/VdKmAYD6Ae0Zr6eqJ+8wedC6Wqjlr84wExof2N08l6USL1ch3IRJydFUYpjEQUnjmKyx7xU
	pKf5OiDgp+fmot6ZjsPOa1Rp3Px/F2bzUIattoyGkgXOAtumpjptqWE1NBvcaysIhTFVqrQTIkk
	u/MurjsK5Sgv8wB3huxxNu+P2eZbSJBcDSQh3f7iXefeDF2yp2UT/neLzUQd3HsOtz4ZVI1gh35
	frEU/Iw5RiwiOwDwAshPqnJ6kDVCVogM4gl1IMDoWm/JTJppNw6Gby8S6GMeqW6CAg8x6C1kCYZ
	0p2Bv4K5VVo7yW3zTOTle6A22dEg==
X-Received: by 2002:a05:6a20:9395:b0:3bf:c07b:a9ae with SMTP id adf61e73a8af0-3c0bd31306amr9401697637.58.1783615793429;
        Thu, 09 Jul 2026 09:49:53 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6594f6a9sm33262595c88.5.2026.07.09.09.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:52 -0700 (PDT)
Message-Id: <8353bc03c175d1eb3618e96832f62562bf6b9976.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:34 +0000
Subject: [PATCH 07/12] packfile, git-zlib: widen `use_pack()` and zstream
 avail fields to `size_t`
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

Bundling the two widenings: four call sites pass `&stream.avail_in`
directly to `use_pack()`, and widening either type fencepost alone would
force a bridge variable at each. Doing both together is the simpler end
state and is the prerequisite for the `do_compress()` widening in the
next commit, which is what lets `write_no_reuse_object()` lose its last
`cast_size_t_to_ulong()` shim.

The unsigned-long locals widened at the other `use_pack()` callers
(avail / remaining / left) hold pack-window sizes bounded by
`core.packedGitWindowSize`, so the change is type consistency rather
than a new >4GB capability. `git_zstream.avail_in`/`avail_out` likewise
reach zlib's `uInt` fields only after `zlib_buf_cap()`'s 1 GiB cap, so
the wrapper already accepted `size_t`-shaped inputs in practice.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 8 ++++----
 git-zlib.h             | 4 ++--
 pack-check.c           | 4 ++--
 packfile.c             | 4 ++--
 packfile.h             | 3 ++-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 315ea0ed7e..cedda6ba9c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -488,7 +488,7 @@ static void copy_pack_data(struct hashfile *f,
 		off_t len)
 {
 	unsigned char *in;
-	unsigned long avail;
+	size_t avail;
 
 	while (len) {
 		in = use_pack(p, w_curs, offset, &avail);
@@ -2261,7 +2261,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		struct object_id base_ref;
 		struct object_entry *base_entry;
 		unsigned long used, used_0;
-		unsigned long avail;
+		size_t avail;
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
@@ -2773,8 +2773,8 @@ size_t oe_get_size_slow(struct packing_data *pack,
 	struct pack_window *w_curs;
 	unsigned char *buf;
 	enum object_type type;
-	unsigned long used, avail;
-	size_t size;
+	unsigned long used;
+	size_t avail, size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
 		size_t sz;
diff --git a/git-zlib.h b/git-zlib.h
index 44380e8ad3..0b24b15bd0 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -5,8 +5,8 @@
 
 typedef struct git_zstream {
 	struct z_stream_s z;
-	unsigned long avail_in;
-	unsigned long avail_out;
+	size_t avail_in;
+	size_t avail_out;
 	size_t total_in;
 	size_t total_out;
 	unsigned char *next_in;
diff --git a/pack-check.c b/pack-check.c
index 5adfb3f272..befb860472 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -34,7 +34,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	uint32_t data_crc = crc32(0, NULL, 0);
 
 	do {
-		unsigned long avail;
+		size_t avail;
 		void *data = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = len;
@@ -71,7 +71,7 @@ static int verify_packfile(struct repository *r,
 
 	r->hash_algo->init_fn(&ctx);
 	do {
-		unsigned long remaining;
+		size_t remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (!pack_sig_ofs)
diff --git a/packfile.c b/packfile.c
index 1d1b23b6cc..629fe46a6a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -620,7 +620,7 @@ static int in_window(struct repository *r, struct pack_window *win,
 unsigned char *use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
 		off_t offset,
-		unsigned long *left)
+		size_t *left)
 {
 	struct pack_window *win = *w_cursor;
 
@@ -960,7 +960,7 @@ int unpack_object_header(struct packed_git *p,
 			 size_t *sizep)
 {
 	unsigned char *base;
-	unsigned long left;
+	size_t left;
 	unsigned long used;
 	enum object_type type;
 
diff --git a/packfile.h b/packfile.h
index 2329a69701..3cff8bdcb9 100644
--- a/packfile.h
+++ b/packfile.h
@@ -240,7 +240,8 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
 struct object_database;
 
-unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t,
+			size_t *);
 void close_pack_windows(struct packed_git *);
 void close_pack(struct packed_git *);
 void unuse_pack(struct pack_window **);
-- 
gitgitgadget

