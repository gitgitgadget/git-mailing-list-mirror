Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246D3F7E8F
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355961; cv=none; b=LPLJF3Z8xrvis0sg8BHZVchBeh6jtKvt6TihDDy7FWf2rn+uSl/+/45YkFLtWm3KUL6gF/WT6OgtBUj2rW/N3ZSJireFpwLvE/SAaEOYpVIQph/L03tLcOWBLtrqZ8wgLB5KQk342caG/hKxFDhu9nIuIpiv4tqiGmGOgLRDCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355961; c=relaxed/simple;
	bh=bZgtZ9fiwUwaG/d8Olw11F08tXJ4byL5+rG/zJUgg44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hc6ubqjsNm6n5jU7r+YdnWLDCSgGi/XCFmiksw2X0NAcMEoj8i5BYae3bEyuUKyFzZuslscYuxjsO1rU9aH87HBBTylY58ebH2Ry0HGO5Ay0wn7fEuoZPDnY8UWRIP3RO4tGM3L/HliLc25NGsTpTEhr2v60Kd38KRYYvzbpk/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO3PiR9g; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO3PiR9g"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso44117105e9.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355958; x=1774960758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBlUR26oK1nfW3HUFqG0jlWKdzWwvWvqp9olabMp8c0=;
        b=OO3PiR9gxNw492RCZ1dU8JI7iH/XL0cn60IfMCorEaPeZJTP8fpM2yqeN8xKwBpwIc
         Pth58QeYdh75N1wMLHzSazlgcsLIqB4NUZTPB3IREpKyvXwGt062S2ybreSpJjiK93Ju
         B8cFW8E9lDgwjCG/FbUzweOkpdaCAcvL2sMvSIYQetglu0AqF0EMD5WxJubJYj/AV+dp
         SxpPJJijgEV5ZKmCB7QZ5RtBcDmZ10ucm9gNdhco6k461FdoxQBjEapcBl3EagGsEUR7
         oJZz/uwpGMT5zcfHEw3N97Xtyet7auNvly6Ji0upZXKpRNMZ2D6JTYAXYx3tHptZ6tC+
         9rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355958; x=1774960758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wBlUR26oK1nfW3HUFqG0jlWKdzWwvWvqp9olabMp8c0=;
        b=TdfFpw4/8jOh+vaD1fQnweM/w2jAih7KPitL6CCBFfTddT7/qYZqeVkQEYX7JnCjJn
         8oKc0EboJxHQ9U8F4N8ZNKPvMiG3DxqDZS4ul122onF6CXMavn0DV/SGI/NhN9XvLaOz
         va3kku5NHJvXlrW1uzPH4IJ/SyH4IJOu3iViT4w36CsPrMDi3oW0iS/OgNOGqb2GpETF
         jhpfLCb2dm4hzT/HLSvJm6Bw8b8z1Hi33YR8ud4COtqvYNTRQoZacLA6otG61DaDHjP6
         g4W+XQb/7MUn/wDxvD1/C8FS9jk1vHBpivp1zsjAsE6AFgPVDYr0IjNuEO48fG+oHDYa
         5cxg==
X-Gm-Message-State: AOJu0YxPGfFKot3+bQ7N9FQEhyfx3tjutgWeiIyEDq6wFx4I1RU0/1iV
	oKO8zDega2NNLaE6iN7ZYApom6HEBNYJVTfKAnXCWbGlKvs4HVwpcAsht/oUlmHc
X-Gm-Gg: ATEYQzwSg7a4wlfkpXTG8zHY0AiGUJWovoSkqXnVAv27Xkc41RYWh8g40kvXwR06ckC
	SrQMErA0zDDLczsI+pR77BJP2gCOmmlmBXz9Vdq02DXrIlhCvNJf3FTeyg95NDltQthaZ3XiAMK
	7VS1vbLY7oqaADJFJ8/BIGTGvccmcYiz8iYtfiim9Kvw65SZSf4tK0hwXz46jXyKSOzqlbpOcs7
	T+IMTW5XeM28fakbzVoCqeraqtPjcud0Svuqt7uskuNy2Vvdd5UDHElFoR6PIeFoviUWpRRWp2m
	+5IqYPzR/3NqYy0+VY5YExTX81LvTcYcNw58SZWHLzHVzXuAm6Zr2ih1F+JbvzekvkYOS7chWxV
	6EY+s/6HdSKsCkw/LYPkztPsEfiLQK5p9gZPpzifZbT1qCq+y1HevfPRTZ/xs0NY3kl7pW8PTEx
	1nLD2cQrbppYX3noEqGCmCsI9OBN41CBQ4uz3s4SmcM2lqU8xeNibIo+bVWHq+2LMd
X-Received: by 2002:a05:600c:548e:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-486ff029336mr216184315e9.33.1774355957355;
        Tue, 24 Mar 2026 05:39:17 -0700 (PDT)
Received: from pop-os.localdomain ([102.88.113.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fd2c4esm32049815e9.4.2026.03.24.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:39:16 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 4/8] environment: move "pack_compression_level" into `struct repo_config_values`
Date: Tue, 24 Mar 2026 13:37:46 +0100
Message-ID: <20260324123750.157143-5-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260324123750.157143-1-belkid98@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `pack_compression_level` configuration is currently stored in the
global variable `pack_compression_level`, which makes it shared across
repository instances within a single process.

Store it instead in `repo_config_values` so the value is associated
with the repository from which it was read. This preserves existing
behavior while avoiding cross-repository state leakage and is another
step toward eliminating repository-dependent global state.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/fast-import.c  |  8 +++++---
 builtin/pack-objects.c | 17 ++++++++++-------
 environment.c          |  8 +++++---
 environment.h          |  2 +-
 object-file.c          |  3 ++-
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b8a7757cfd..6475cdae85 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -963,6 +963,7 @@ static int store_object(
 	unsigned long hdrlen, deltalen;
 	struct git_hash_ctx c;
 	git_zstream s;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
 				      dat->len);
@@ -1001,7 +1002,7 @@ static int store_object(
 	} else
 		delta = NULL;
 
-	git_deflate_init(&s, pack_compression_level);
+	git_deflate_init(&s, cfg->pack_compression_level);
 	if (delta) {
 		s.next_in = delta;
 		s.avail_in = deltalen;
@@ -1028,7 +1029,7 @@ static int store_object(
 		if (delta) {
 			FREE_AND_NULL(delta);
 
-			git_deflate_init(&s, pack_compression_level);
+			git_deflate_init(&s, cfg->pack_compression_level);
 			s.next_in = (void *)dat->buf;
 			s.avail_in = dat->len;
 			s.avail_out = git_deflate_bound(&s, s.avail_in);
@@ -1111,6 +1112,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	struct git_hash_ctx c;
 	git_zstream s;
 	struct hashfile_checkpoint checkpoint;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int status = Z_OK;
 
 	/* Determine if we should auto-checkpoint. */
@@ -1130,7 +1132,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 
 	crc32_begin(pack_file);
 
-	git_deflate_init(&s, pack_compression_level);
+	git_deflate_init(&s, cfg->pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(out_buf, out_sz, OBJ_BLOB, len);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c1ee4d5ed7..7c5bc96916 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -383,8 +383,9 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	git_zstream stream;
 	void *in, *out;
 	unsigned long maxsize;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&stream, pack_compression_level);
+	git_deflate_init(&stream, cfg->pack_compression_level);
 	maxsize = git_deflate_bound(&stream, size);
 
 	in = *pptr;
@@ -410,8 +411,9 @@ static unsigned long write_large_blob_data(struct odb_read_stream *st, struct ha
 	unsigned char ibuf[1024 * 16];
 	unsigned char obuf[1024 * 16];
 	unsigned long olen = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&stream, pack_compression_level);
+	git_deflate_init(&stream, cfg->pack_compression_level);
 
 	for (;;) {
 		ssize_t readlen;
@@ -4868,6 +4870,7 @@ int cmd_pack_objects(int argc,
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	struct option pack_objects_options[] = {
 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
@@ -4951,7 +4954,7 @@ int cmd_pack_objects(int argc,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
-		OPT_INTEGER(0, "compression", &pack_compression_level,
+		OPT_INTEGER(0, "compression", &cfg->pack_compression_level,
 			    N_("pack compression level")),
 		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
 			 N_("do not hide commits by grafts")),
@@ -5110,10 +5113,10 @@ int cmd_pack_objects(int argc,
 
 	if (!reuse_object)
 		reuse_delta = 0;
-	if (pack_compression_level == -1)
-		pack_compression_level = Z_DEFAULT_COMPRESSION;
-	else if (pack_compression_level < 0 || pack_compression_level > Z_BEST_COMPRESSION)
-		die(_("bad pack compression level %d"), pack_compression_level);
+	if (cfg->pack_compression_level == -1)
+		cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
+	else if (cfg->pack_compression_level < 0 || cfg->pack_compression_level > Z_BEST_COMPRESSION)
+		die(_("bad pack compression level %d"), cfg->pack_compression_level);
 
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
diff --git a/environment.c b/environment.c
index 5b0e88b65c..d0d3a4b7d2 100644
--- a/environment.c
+++ b/environment.c
@@ -52,7 +52,6 @@ char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
@@ -390,7 +389,7 @@ int git_default_core_config(const char *var, const char *value,
 		if (!zlib_compression_seen)
 			cfg->zlib_compression_level = level;
 		if (!pack_compression_seen)
-			pack_compression_level = level;
+			cfg->pack_compression_level = level;
 		return 0;
 	}
 
@@ -662,6 +661,8 @@ static int git_default_attr_config(const char *var, const char *value)
 int git_default_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	if (starts_with(var, "core."))
 		return git_default_core_config(var, value, ctx, cb);
 
@@ -701,7 +702,7 @@ int git_default_config(const char *var, const char *value,
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
 			die(_("bad pack compression level %d"), level);
-		pack_compression_level = level;
+		cfg->pack_compression_level = level;
 		pack_compression_seen = 1;
 		return 0;
 	}
@@ -721,4 +722,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->trust_ctime = 1;
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
+	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 }
diff --git a/environment.h b/environment.h
index 93201620af..514576b67a 100644
--- a/environment.h
+++ b/environment.h
@@ -94,6 +94,7 @@ struct repo_config_values {
 	int trust_ctime;
 	int check_stat;
 	int zlib_compression_level;
+	int pack_compression_level;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -171,7 +172,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
 
 extern int precomposed_unicode;
diff --git a/object-file.c b/object-file.c
index 8b719a915c..87179fc667 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1420,8 +1420,9 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 	int status = Z_OK;
 	int write_object = (flags & INDEX_WRITE_OBJECT);
 	off_t offset = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&s, pack_compression_level);
+	git_deflate_init(&s, cfg->pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
 	s.next_out = obuf + hdrlen;
-- 
2.53.0.155.g9f36b15afa

