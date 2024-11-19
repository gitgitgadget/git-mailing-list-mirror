Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD31D042D
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030628; cv=none; b=uSXOjMgHwmiM3rvqP3G0C9PgP8gAj6d7kylQCeui3qSAUzmiszyTUdNLRNDl1Ma4N6pTK1KcE9JHB+MLKusdtGyLhlC2KK9SpePmirdLJHmpL55E1ujyIwjJ1YoNV2vQKCo7sDU3Qwazy9/zCu0wIHOBFWaVuIz2bpV9Aw1JRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030628; c=relaxed/simple;
	bh=nvMdXLRFqIklwPwvUKKFJCAc1KDQnhCh9LXOQ42dykU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FgzGFs3ravlpOhcdgZu/+F252nJq4RToFlOXXarxB2CdwP+Jcar8OqLuRC4qvk6/ISJkmivZBdrajYdIDpqrxyma3JfpUofAAHMZjSNT/qICTy7Q5nX5vwBBwsjs5HoMrZJKnfwldoQD3ZzThO4qt5Q1JePjjBXiNWWyUWapwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0bs4u7f; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0bs4u7f"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e8522445dso548505566b.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030625; x=1732635425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QONasBt7Lh9rZxjHgidwnq6zhlpab2XHkPCYDl4vQAA=;
        b=H0bs4u7f7mWpSckDPLdkG6zMC4ZXgfsIi/wiOYM6MGSdUajIApcV5436DjgscHotkF
         OoWOH2XJMKUJg8bRrwhBta2fdKhTu+YuiNNiC3jCVbOyA5NuiVCGfMGswqYa+WpXLK+3
         tRFXEL+Z27gxjM+K/OeGnpwl/tiXf9M7ACf/Rw9PKBgit69w0mNtMWYlPeExBvRTqPpy
         npTxI2fE9h/+hjnPFkRvFmWGsKWz5510qZqrMGHhwjR3tEo7ziEEb2F2oYvhRa/3GEXz
         o++zmsC8fIkXPyBy9JAVYXpzoxM8u8qoeCoPuzeY82ltRPkisvRXRqCo3lvb3XxKptjG
         dDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030625; x=1732635425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QONasBt7Lh9rZxjHgidwnq6zhlpab2XHkPCYDl4vQAA=;
        b=jqOOVMtV5DdXkkwO5ePU9NnY0Z7jKJdFtv3zPdu0W2IfOx/9aI6CeUz8XRIk3NL5ob
         3b6EcyayHaWAA1a4mOzJG/oGgXNF4L0/s+Zm3m5NqP0TlDcCdjEJMdujV/OoZ1WiJjPc
         ILbvi6FUUsr+f8oIPV1ye9yEN+EB1rx/Bm74vp1GF5enDqEXvKrsMtQAu3HOBa8+XSmg
         CmYtucX/jPhAiZk34C0vzZoF6zwZunssGFqpqto1mkAgRh6sd5ECY/cce7SnHTBZ+gI2
         VgvulIrp9rSXgBlCnA2i40LNKKn78RQ7JBX1TZKEWbtCfcBRavVgEWd1ncmYa5yxrnDE
         rpRw==
X-Gm-Message-State: AOJu0YyNcWwP8BSDFzQrDAPRioZPLovvAXlHz6zN4Ms8QQS/Ea5M+rB/
	yMos1cpjDL/iPlJf/eK9SGiwwZ/JoI+gL8tx+trYgVtFaQGLSgLJ461RrZMc
X-Google-Smtp-Source: AGHT+IEP7nnkJ/Bb/5p6fBYiUbCXW1d/sXEYwKDcYFd8mZts+6THi6npCQ152cELV/znDPnMv/pqqg==
X-Received: by 2002:a17:906:f588:b0:aa1:e60e:6fe7 with SMTP id a640c23a62f3a-aa4833f6579mr1636134466b.11.1732030625114;
        Tue, 19 Nov 2024 07:37:05 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:37:04 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:47 +0100
Subject: [PATCH v2 08/10] midx: pass down `hash_algo` to
 `get_midx_filename[_ext]`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-8-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7687; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nvMdXLRFqIklwPwvUKKFJCAc1KDQnhCh9LXOQ42dykU=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCYTB/EvN/bwgnXZ7bjwIDlA6HO0RZPi/z/J
 DrZDixWOmSJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywmAAKCRA+1Z8kjkaM
 f6xODACLrM2e7AHqwGI1ahzrwmp3fZU+tjh3P7PzdO/77MkochS7QFRCGFtGr3+IIfayI9nFHpc
 kvZmsFclVDoIYszFBjwF6zwZ+uOiLUUlfX/znWc1I8pEOIfxYeDHVEC/fhkUkwZTBSzRD7SeaHm
 fyaJFQ9Vc60hWBrDfbacel+mGMYCVRd9LNKqNiVOhHNs3pjKohBnwt/ka00r0ZBCAJqPPERYFap
 y6pwiEtmmkUZsjKe+x+oeJ3xji7gynQx4hLj0TVOOUmPxJce0dYhVRTIXs5AYbcRjQPeygBOCFg
 DWu75l/CetbB1N1IehYkDOQx7S/D0H+H94guQiZDQz8bIwFHmn/ZwY6nwGvBZSfZQKpa1eJQ3lY
 8gNcXjv4UPcZqVqH59DVjNEnwWbR4NRoHdlFpHM+RTUqUoZxnsxU6ihp32RNr/VPeWERhQfitSe
 1WMFWE3JWc7qSTabsixdmhl2SBbxVng8ql0PuKAN+nC0dMGnmiLTEzqHVgUtL6rZjLb+U=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The function `get_midx_filename_ext` uses `hash_to_hex` which internally
uses the global variable `the_repository`. To remove this dependency,
pass down the `hash_algo` to both `get_midx_filename` and
`get_midx_filename_ext`. This adds `the_repository` variable usage to
`midx-write.c`, which will be resolved in a future commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c    | 15 +++++++--------
 midx.c          | 16 +++++++++-------
 midx.h          |  7 +++++--
 pack-bitmap.c   |  6 +++---
 pack-revindex.c |  2 +-
 5 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 1bc2f5256916e69924245951f654c1047ffeab84..2f0c09211282fa651af8f9a342f0564729468306 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -991,8 +991,8 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
 		const unsigned char *hash = get_midx_checksum(m);
 
-		get_midx_filename_ext(&from, m->object_dir, hash,
-				      midx_exts[i].non_split);
+		get_midx_filename_ext(m->repo->hash_algo, &from, m->object_dir,
+				      hash, midx_exts[i].non_split);
 		get_split_midx_filename_ext(&to, m->object_dir, hash,
 					    midx_exts[i].split);
 
@@ -1012,9 +1012,8 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	return ret;
 }
 
-static void clear_midx_files(const char *object_dir,
-			     const char **hashes,
-			     uint32_t hashes_nr,
+static void clear_midx_files(struct repository *r, const char *object_dir,
+			     const char **hashes, uint32_t hashes_nr,
 			     unsigned incremental)
 {
 	/*
@@ -1039,7 +1038,7 @@ static void clear_midx_files(const char *object_dir,
 	}
 
 	if (incremental)
-		get_midx_filename(&buf, object_dir);
+		get_midx_filename(r->hash_algo, &buf, object_dir);
 	else
 		get_midx_chain_filename(&buf, object_dir);
 
@@ -1083,7 +1082,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			    "%s/pack/multi-pack-index.d/tmp_midx_XXXXXX",
 			    object_dir);
 	else
-		get_midx_filename(&midx_name, object_dir);
+		get_midx_filename(r->hash_algo, &midx_name, object_dir);
 	if (safe_create_leading_directories(midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
@@ -1474,7 +1473,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(object_dir, keep_hashes,
+	clear_midx_files(r, object_dir, keep_hashes,
 			 ctx.num_multi_pack_indexes_before + 1,
 			 ctx.incremental);
 
diff --git a/midx.c b/midx.c
index 98ee84d4a8bf388906634ad695ff39acdaa2c6d5..9bed4185ff4d44602aedfe0329dd840ff9e85435 100644
--- a/midx.c
+++ b/midx.c
@@ -28,17 +28,19 @@ const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 	return m->data + m->data_len - m->repo->hash_algo->rawsz;
 }
 
-void get_midx_filename(struct strbuf *out, const char *object_dir)
+void get_midx_filename(const struct git_hash_algo *hash_algo,
+		       struct strbuf *out, const char *object_dir)
 {
-	get_midx_filename_ext(out, object_dir, NULL, NULL);
+	get_midx_filename_ext(hash_algo, out, object_dir, NULL, NULL);
 }
 
-void get_midx_filename_ext(struct strbuf *out, const char *object_dir,
+void get_midx_filename_ext(const struct git_hash_algo *hash_algo,
+			   struct strbuf *out, const char *object_dir,
 			   const unsigned char *hash, const char *ext)
 {
 	strbuf_addf(out, "%s/pack/multi-pack-index", object_dir);
 	if (ext)
-		strbuf_addf(out, "-%s.%s", hash_to_hex(hash), ext);
+		strbuf_addf(out, "-%s.%s", hash_to_hex_algop(hash, hash_algo), ext);
 }
 
 static int midx_read_oid_fanout(const unsigned char *chunk_start,
@@ -379,7 +381,7 @@ struct multi_pack_index *load_multi_pack_index(struct repository *r,
 	struct strbuf midx_name = STRBUF_INIT;
 	struct multi_pack_index *m;
 
-	get_midx_filename(&midx_name, object_dir);
+	get_midx_filename(r->hash_algo, &midx_name, object_dir);
 
 	m = load_multi_pack_index_one(r, object_dir,
 				      midx_name.buf, local);
@@ -822,7 +824,7 @@ void clear_midx_file(struct repository *r)
 {
 	struct strbuf midx = STRBUF_INIT;
 
-	get_midx_filename(&midx, r->objects->odb->path);
+	get_midx_filename(r->hash_algo, &midx, r->objects->odb->path);
 
 	if (r->objects && r->objects->multi_pack_index) {
 		close_midx(r->objects->multi_pack_index);
@@ -891,7 +893,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		struct stat sb;
 		struct strbuf filename = STRBUF_INIT;
 
-		get_midx_filename(&filename, object_dir);
+		get_midx_filename(r->hash_algo, &filename, object_dir);
 
 		if (!stat(filename.buf, &sb)) {
 			error(_("multi-pack-index file exists, but failed to parse"));
diff --git a/midx.h b/midx.h
index 78efa28d35371795fa33c68660278182debb60ab..7620820d4d0272926af9e4eeb68bfb73404c7ec2 100644
--- a/midx.h
+++ b/midx.h
@@ -7,6 +7,7 @@ struct object_id;
 struct pack_entry;
 struct repository;
 struct bitmapped_pack;
+struct git_hash_algo;
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -89,8 +90,10 @@ struct multi_pack_index {
 #define MIDX_EXT_MIDX "midx"
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
-void get_midx_filename(struct strbuf *out, const char *object_dir);
-void get_midx_filename_ext(struct strbuf *out, const char *object_dir,
+void get_midx_filename(const struct git_hash_algo *hash_algo,
+		       struct strbuf *out, const char *object_dir);
+void get_midx_filename_ext(const struct git_hash_algo *hash_algo,
+			   struct strbuf *out, const char *object_dir,
 			   const unsigned char *hash, const char *ext);
 void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir);
 void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0cb1b56c9d5a55936ba53e2ff904ffe46cdcbafc..7b62d099cab5729a60a36b3ad15276fdc351aa97 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -375,8 +375,8 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
 	struct strbuf buf = STRBUF_INIT;
-	get_midx_filename_ext(&buf, midx->object_dir, get_midx_checksum(midx),
-			      MIDX_EXT_BITMAP);
+	get_midx_filename_ext(midx->repo->hash_algo, &buf, midx->object_dir,
+			      get_midx_checksum(midx), MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
 }
@@ -415,7 +415,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
-		get_midx_filename(&buf, midx->object_dir);
+		get_midx_filename(midx->repo->hash_algo, &buf, midx->object_dir);
 		trace2_data_string("bitmap", bitmap_repo(bitmap_git),
 				   "ignoring extra midx bitmap file", buf.buf);
 		close(fd);
diff --git a/pack-revindex.c b/pack-revindex.c
index 22d3c2346488de6279b6f26a69fe611106c1365a..d3832478d99edffae17db0bbe85aa981c1a3ad30 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -383,7 +383,7 @@ int load_midx_revindex(struct multi_pack_index *m)
 	trace2_data_string("load_midx_revindex", the_repository,
 			   "source", "rev");
 
-	get_midx_filename_ext(&revindex_name, m->object_dir,
+	get_midx_filename_ext(m->repo->hash_algo, &revindex_name, m->object_dir,
 			      get_midx_checksum(m), MIDX_EXT_REV);
 
 	ret = load_revindex_from_disk(revindex_name.buf,

-- 
2.47.0

