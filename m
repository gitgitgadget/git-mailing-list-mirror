Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245C1D0178
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678162; cv=none; b=VfGeTnp5a5SapTMYQXNNxZYVMIjxyQy3OISyZ0c7B9wWrz6meF7ig1V7DWvqibRESRVGowlqIj0tLDA+RlqItj6juxiVpYaA+2Qw2G99hQk/1uLv7LcgIJli+KTPdzrNIFY+GBGjAf46UsanrQJyeWYhHLSaXzsmuChshoxadok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678162; c=relaxed/simple;
	bh=6eD+Fs/1XLAFVgEBqJx5YXrP/RCCPFYolV7PC8QDMFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kzbrz96gEpWy6N5xHONOvN3rB9vq3ZKWzMJQX86jclsdVEBdtUNg6Xp0QzsEeRKHWDh70WBnMN4be5NmKcuRzR0csYnjK4qwbA9s3cqyOGe003CLFBHHauq/nag01mq/DOIepTOaHTjbxZLVlA3MCx+xyxN1bdl/9BUd8ZE4qCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwqCDcjW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwqCDcjW"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so2769746a12.0
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678159; x=1732282959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcTfw82KIr+vKuSMMtY7/tmwLIlUaHwt9I0LRAzDh2o=;
        b=OwqCDcjWwIK5GaXaqmufC1crtoLmUN0ZLMzhG4qYs2IYRSw3SOJ0XH1M/uuBnlWHII
         Fi/BdYAvzuwkEv2ZJFV/1M4z9k5gn9MAbxefaxVsyTeqV9lzPbb2+ODgaM7JtWqfefF3
         LAPfRgO/9id1zEARkBykDXHW38NNnGsEroTrTqAvR4nY5v0FXjyOhu9bMl2RUIJ+QEs0
         3zKXJFduM2T6JQatagTHFqm34Bxi69arUWligr+kBgmYz/WNYJjSsuCTX8GOZUqRNzLR
         yuwY/ULUDUOqiPCqO+4fRbNP2h9s0vXTHy2y9iuYCbhaB731YDiSsyXI5nTD42wuDCD/
         rtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678159; x=1732282959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcTfw82KIr+vKuSMMtY7/tmwLIlUaHwt9I0LRAzDh2o=;
        b=vGH3FWTLBg6UAA6SiRI519TsRUrEHskyT/qVvxsQTgmDFGJokOqubpzmQ0CMVTRQn8
         Vf1Hd9Q+nsddu3CZKgmxgAErQRhXciAM/Z6Is+aZOc+HY395SEBUs3d33Qz1lPlr1qJp
         /Zr0/twV/lCr3Qnndduaf8bBlOmiiQJvZIgv2fUWLLh0EVtDATfG57odJmb227rPo3A1
         MGSRbpblX12/PGeYgvCa6qXCHNVOCv7PPGDa7662eHAhzwSBH7F6zh4mnPJ92SUOoJ+n
         X7YFOwZyS/B21IZJt3v6R8dVMibiu3kEbD7rlswiXexXawB1XwA3gsWoDQtbLnAd7bfO
         k+dg==
X-Gm-Message-State: AOJu0YzpEp+sFZAqXhT5tMhfJzlf7kJ6/VimrpYwWb37XXxz8fXNLvzE
	MQsbH4lJhrLGJlRiahJptu57uYhX+TQqEV5B3jv3T70tL46vei89
X-Google-Smtp-Source: AGHT+IFtfuFJllY0Jawz0JStTvX43Hkr6kO6gQlQuWAUrgJeuJbkCoMH9rwXSJi7AO5U5JEJvWed6w==
X-Received: by 2002:a17:907:608a:b0:a99:6791:5449 with SMTP id a640c23a62f3a-aa483553e12mr224969466b.52.1731678158910;
        Fri, 15 Nov 2024 05:42:38 -0800 (PST)
Received: from [10.82.5.93] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26a69sm180753966b.34.2024.11.15.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:42:38 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 15 Nov 2024 14:42:19 +0100
Subject: [PATCH 6/8] midx: pass down `hash_algo` to
 `get_midx_filename[_ext]`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-6-761f8a2c7775@gmail.com>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, peff@peff.net
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7696; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=6eD+Fs/1XLAFVgEBqJx5YXrP/RCCPFYolV7PC8QDMFA=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnN0/ISDPH61t8guTdy4Ulzy5AyEpuTzTT4tB7k
 exqCc4ekcCJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzdPyAAKCRA+1Z8kjkaM
 f6GhC/44w8XkrwVMlbb9UeqSWyZOeq+Ru/MM5/pxTQCqJmOjKc6hHECN2Qez57t+viZAl8AUpah
 Dy1+zDDoyiD9XwH/h3T/opMVrDCOqkG1bsJ/mEy1cHyRGd7bY4sBnoqT/ujbavXDsncWXqopOMj
 jS+ixN/eBKE2qWgDD7iZ0fvKEKdMK0IKqMQ/1CxD0IBD29YsgxFdm+nOtgkJsCnYJiL0+ih8Bro
 ZP4kNwnud7VALIwDMhHbfIZ2JzUN2vTPDkabQrPWae03zH1BXyEw8LLyuhfNaTB/ovdALjbcxAd
 RFdL8W6/fvqvthalKBthok4dGhccfKaHYm3dKwa671T4WGZbiVmpcpTbpHNVmFlz14SyrL7R13M
 kWOSinPXpvfsUetYzCVTdG4AeAI/SE0kHWgDo4hKdIQAPv7ub0ZhNZyXsLQ+5du444bSSrcl5zr
 0+VjJ1VEtbSkf5KaokUBrycDSJWmxbHFtdTEAMzmb4ka2qrosJwimYPgpXgNf0FZsEeWE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The function `get_midx_filename_ext` uses `hash_to_hex` which internally
uses the global variable `the_repository`. To remove this dependency, we
pass down the `hash_algo` to both `get_midx_filename` and
`get_midx_filename_ext`. While we add `the_repository` usage to
`midx-write.c` for this reason, we'll resolve this in a future commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c    | 15 +++++++--------
 midx.c          | 16 +++++++++-------
 midx.h          |  7 +++++--
 pack-bitmap.c   |  6 +++---
 pack-revindex.c |  2 +-
 5 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 5af29899bbe279c7c3ff4bc2c65330620ce37ee2..7c1563845993075d622f59faeb25462180434abd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -990,8 +990,8 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
 		const unsigned char *hash = get_midx_checksum(m);
 
-		get_midx_filename_ext(&from, m->object_dir, hash,
-				      midx_exts[i].non_split);
+		get_midx_filename_ext(m->repo->hash_algo, &from, m->object_dir,
+				      hash, midx_exts[i].non_split);
 		get_split_midx_filename_ext(&to, m->object_dir, hash,
 					    midx_exts[i].split);
 
@@ -1011,9 +1011,8 @@ static int link_midx_to_chain(struct multi_pack_index *m)
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
@@ -1038,7 +1037,7 @@ static void clear_midx_files(const char *object_dir,
 	}
 
 	if (incremental)
-		get_midx_filename(&buf, object_dir);
+		get_midx_filename(r->hash_algo, &buf, object_dir);
 	else
 		get_midx_chain_filename(&buf, object_dir);
 
@@ -1082,7 +1081,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			    "%s/pack/multi-pack-index.d/tmp_midx_XXXXXX",
 			    object_dir);
 	else
-		get_midx_filename(&midx_name, object_dir);
+		get_midx_filename(r->hash_algo, &midx_name, object_dir);
 	if (safe_create_leading_directories(midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
@@ -1473,7 +1472,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
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

