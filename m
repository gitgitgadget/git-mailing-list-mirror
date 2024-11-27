Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A7201254
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724938; cv=none; b=r4ZYexQP6A+ITDx+jDSc/UEzdeh+xlUG/XUB8CrWUMLyT7tRX7PWwnzAWEB7L1gtgUNCodCGmpdkNmMQ10zGaXYAQFp8y2kqsSuW1wQYvOJqai+Wud94MR7gKI608Z8utjfdTkzwqlOmBxR5fhweTrpbDVbpTYmowVpZXi3N/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724938; c=relaxed/simple;
	bh=n19tvsNW1npTe5NQigUJDHmot0AeqiD8X2PFNQEfTMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZoWlnpCkOl189ul9gxbBKJWddrbchirTDmI1INcQolhi40lh4DW+HVJTRvEEEiS7rDPtKLbbJnJKNxhqWaZ1qbQHxJseW8pvQEQG5dgG+8yePATRdUOB+o5tAMPOpNqMi1ONU7BxuCbvm+S0nR0sXZVxsnxcaVEjKnStrnpLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQHCRm7b; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQHCRm7b"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so57273541fa.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724934; x=1733329734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhNLTWXd1NC9bu1omIgB7Do6rMNk3uMqDdx7Y//kVQs=;
        b=TQHCRm7bwjKo/+JBGmeUUXs20/Y9OD+WsfPEu/4Mpjw9sCKjF7cgAwJUhG8VtG8ufP
         VILOFrPQfTpwNr9heXPJYsgSPu8iyDQsYN2QAtruiK3m53EKL4B5rMF98baDl37SJFxF
         HLC1WsT2Wn9wnKhwNHZhA4FMSNRZGd6rj5LZ4w1MuHAfOhwEuzqBQJ+kzXEQJYWcEttu
         OFQU/Ttui1j6ifOVBe+Zmoha6wEhA0LL5mFd3mlcdXO/SXEd86+1a2/7FYRt2ALxuRpU
         nzOjtbbsc+rHwEfCtBwYVGLvdGuhHqX/v/mAFJK3o9kfxF1Wo4oJDkAFL/GiybrgKQan
         FmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724934; x=1733329734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhNLTWXd1NC9bu1omIgB7Do6rMNk3uMqDdx7Y//kVQs=;
        b=XeyuquovrViNLe0OIUnwlJACm5NA/nPS2RkFjSkMIScTQbH1AovwlUJPQbjb5+Reaj
         BCuBvdayJ32tG6reLClANUtIB7ucQgQ8rKLVp/6iZAytOLT5YXB+h9uUk2ev8q1sun/i
         wfKaLl3n2pP15rT+23CPe9X8HDY9ecE4cX2LnEn1Z0t6Fh5go/a0JwLqh1ZSGttyLziM
         JW1qoovmUxF1H6oc4p74YK0XF65HkT9yrQhHwQDRJOFDK1WwrVsNk2O/4/EtICnykKUW
         tqLfYI4kssWKDtJ+EQdjKy/RXcAfdDpzegMmtjE+M3Y4jHETgc2JpAINdnewYxNw1wfX
         emsw==
X-Gm-Message-State: AOJu0YzsIokJ+VHA1VazTf6Q6w3+OtZkBCK6W5Zjmm039+xDgp9u4KaQ
	4OuSQr/RXHJwjuq4nHCBQNhIVkaa7gyOth4qzi1U0ZReiicytSwg
X-Gm-Gg: ASbGncuTMyiiqMzIJ8d/Kv9+O0CejGTsuVoEe1AQTNgl0cCtyVBfioQtntDkg77bURH
	pph27hzpa7o3xisdxRyoCwEalCN9FObF/nVp4u7+J+gQUJa59MriRZTeIePQz0GE0gjVj1OZQVY
	6BbCFSta1kq5e+JUnMTGHsnK3fKVP3Ei+G1AYrAnpFdD8Nstmdt51GTAfPFITIcno1nnfVtxPYw
	Oq0WAljkczsEF4W2AIjHXRmVGNGUu29AoWUkrmesqbUoHmZ34o7LgcuSwQ0ag==
X-Google-Smtp-Source: AGHT+IEEveiI27v2KWj5JuTExYbq9T5i7DPkAOYJOgA2bZpZKwiMn6apgQhog95lr9dj2FcptCx9IQ==
X-Received: by 2002:a05:651c:1142:b0:2fa:fcf0:7c2a with SMTP id 38308e7fff4ca-2ffd6050a56mr30147731fa.24.1732724933941;
        Wed, 27 Nov 2024 08:28:53 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:5640:4a6:5555:68ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54e15c169sm420042366b.67.2024.11.27.08.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:53 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 27 Nov 2024 17:28:32 +0100
Subject: [PATCH v3 7/8] midx: pass down `hash_algo` to functions using
 global variables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-7-c5a99f85009b@gmail.com>
References: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
In-Reply-To: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, 
 shejialuo@gmail.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9860; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=n19tvsNW1npTe5NQigUJDHmot0AeqiD8X2PFNQEfTMQ=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnR0i9H9j6MkbPF1+TJTfNLMBvQz+fH8VdGo6Q+
 6bIRuwr4bGJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0dIvQAKCRA+1Z8kjkaM
 f0BFC/44m3p4ooCW0Z/rkLApOfkPEpQhuCfhrf8Rs3BNkYLfFKDTz8GgJZzSotlnQJPCdbbwIe3
 ZLbUrrVN8E0pP2sOHCV7Uo8E3KAsoCOlnG2TdE0FGeUnm3kXI1VKN3Bd33nSJpVUXH7UQBAjJYJ
 /5AdFM+sEH2FhOtY+qVjZeF4TGJVUGODUuSDwtcSAQ5+es4BZiqGUQ+Q0BmCjEGWY8zenL9ju3f
 2YBj28aIk0TmQmNj48BfHbRB6yeRejNFaY/eX5L96Zwb4/5Z8ldOzHlcfon2bYGYoF4Wcv0HsCi
 DB2e3rMTlcgqHP9MitVkT2vnvEz5S/0eVCOjq9J9PrbEO2dCVS8cTUvOpPEa5D+w0LYAntjFN66
 Kekss1YHjy5uvubcEPO0TREUwiPTAYicN5O+ID/IVfqiC73d97CoTCmkrd55djI8fHOAusZ/rlW
 rOzUAl7iASq0ePtpsNxD+ssDqueSmB8BcJ8JW4iyCA2dwsdXd3hWhcejyZgdR7pTEPF2c=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The functions `get_split_midx_filename_ext()`, `get_midx_filename()` and
`get_midx_filename_ext()` use `hash_to_hex()` which internally uses the
`the_hash_algo` global variable.

Remove this dependency on global variables by passing down the
`hash_algo` through to the functions mentioned and instead calling
`hash_to_hex_algop()` along with the obtained `hash_algo`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c    | 22 +++++++++++-----------
 midx.c          | 26 +++++++++++++++-----------
 midx.h          | 10 +++++++---
 pack-bitmap.c   |  6 +++---
 pack-revindex.c |  2 +-
 5 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 1bc2f5256916e69924245951f654c1047ffeab84..bcd1d50eb0f5c292c904a38f13279b1ebec9c855 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -991,9 +991,10 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
 		const unsigned char *hash = get_midx_checksum(m);
 
-		get_midx_filename_ext(&from, m->object_dir, hash,
-				      midx_exts[i].non_split);
-		get_split_midx_filename_ext(&to, m->object_dir, hash,
+		get_midx_filename_ext(m->repo->hash_algo, &from, m->object_dir,
+				      hash, midx_exts[i].non_split);
+		get_split_midx_filename_ext(m->repo->hash_algo, &to,
+					    m->object_dir, hash,
 					    midx_exts[i].split);
 
 		if (link(from.buf, to.buf) < 0 && errno != ENOENT) {
@@ -1012,9 +1013,8 @@ static int link_midx_to_chain(struct multi_pack_index *m)
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
@@ -1039,7 +1039,7 @@ static void clear_midx_files(const char *object_dir,
 	}
 
 	if (incremental)
-		get_midx_filename(&buf, object_dir);
+		get_midx_filename(r->hash_algo, &buf, object_dir);
 	else
 		get_midx_chain_filename(&buf, object_dir);
 
@@ -1083,7 +1083,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			    "%s/pack/multi-pack-index.d/tmp_midx_XXXXXX",
 			    object_dir);
 	else
-		get_midx_filename(&midx_name, object_dir);
+		get_midx_filename(r->hash_algo, &midx_name, object_dir);
 	if (safe_create_leading_directories(midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
@@ -1440,8 +1440,8 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		if (link_midx_to_chain(ctx.base_midx) < 0)
 			return -1;
 
-		get_split_midx_filename_ext(&final_midx_name, object_dir,
-					    midx_hash, MIDX_EXT_MIDX);
+		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
+					    object_dir, midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
 			error_errno(_("unable to rename new multi-pack-index layer"));
@@ -1474,7 +1474,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(object_dir, keep_hashes,
+	clear_midx_files(r, object_dir, keep_hashes,
 			 ctx.num_multi_pack_indexes_before + 1,
 			 ctx.incremental);
 
diff --git a/midx.c b/midx.c
index 98ee84d4a8bf388906634ad695ff39acdaa2c6d5..f45ea842cd6eda23d2eadc9deaae43839aef24c1 100644
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
@@ -234,11 +236,13 @@ void get_midx_chain_filename(struct strbuf *buf, const char *object_dir)
 	strbuf_addstr(buf, "/multi-pack-index-chain");
 }
 
-void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
+void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
+				 struct strbuf *buf, const char *object_dir,
 				 const unsigned char *hash, const char *ext)
 {
 	get_midx_chain_dirname(buf, object_dir);
-	strbuf_addf(buf, "/multi-pack-index-%s.%s", hash_to_hex(hash), ext);
+	strbuf_addf(buf, "/multi-pack-index-%s.%s",
+		    hash_to_hex_algop(hash, hash_algo), ext);
 }
 
 static int open_multi_pack_index_chain(const struct git_hash_algo *hash_algo,
@@ -326,8 +330,8 @@ static struct multi_pack_index *load_midx_chain_fd_st(struct repository *r,
 		valid = 0;
 
 		strbuf_reset(&buf);
-		get_split_midx_filename_ext(&buf, object_dir, layer.hash,
-					    MIDX_EXT_MIDX);
+		get_split_midx_filename_ext(r->hash_algo, &buf, object_dir,
+					    layer.hash, MIDX_EXT_MIDX);
 		m = load_multi_pack_index_one(r, object_dir, buf.buf, local);
 
 		if (m) {
@@ -379,7 +383,7 @@ struct multi_pack_index *load_multi_pack_index(struct repository *r,
 	struct strbuf midx_name = STRBUF_INIT;
 	struct multi_pack_index *m;
 
-	get_midx_filename(&midx_name, object_dir);
+	get_midx_filename(r->hash_algo, &midx_name, object_dir);
 
 	m = load_multi_pack_index_one(r, object_dir,
 				      midx_name.buf, local);
@@ -822,7 +826,7 @@ void clear_midx_file(struct repository *r)
 {
 	struct strbuf midx = STRBUF_INIT;
 
-	get_midx_filename(&midx, r->objects->odb->path);
+	get_midx_filename(r->hash_algo, &midx, r->objects->odb->path);
 
 	if (r->objects && r->objects->multi_pack_index) {
 		close_midx(r->objects->multi_pack_index);
@@ -891,7 +895,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		struct stat sb;
 		struct strbuf filename = STRBUF_INIT;
 
-		get_midx_filename(&filename, object_dir);
+		get_midx_filename(r->hash_algo, &filename, object_dir);
 
 		if (!stat(filename.buf, &sb)) {
 			error(_("multi-pack-index file exists, but failed to parse"));
diff --git a/midx.h b/midx.h
index 78efa28d35371795fa33c68660278182debb60ab..9d1374cbd58d016bb82338337b2a4e5ba7234092 100644
--- a/midx.h
+++ b/midx.h
@@ -7,6 +7,7 @@ struct object_id;
 struct pack_entry;
 struct repository;
 struct bitmapped_pack;
+struct git_hash_algo;
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -89,12 +90,15 @@ struct multi_pack_index {
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
-void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
+void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
+				 struct strbuf *buf, const char *object_dir,
 				 const unsigned char *hash, const char *ext);
 
 struct multi_pack_index *load_multi_pack_index(struct repository *r,
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
2.47.1

