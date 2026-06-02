Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD1F3F6614
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420259; cv=none; b=R+evlQ3KBM2DF/m40csRaiKR/Lk7Wf6DoODdMyAhtvpti0YQOVQ31LWMx1h96zO4v1fHW+cgtebowwDNi9IOO8aNdfo8OWcDoq2l8rKSChK0brGxHizuomj7RndzsPBF22T8JPfgxcDUoJ2VUimyOBdlFXaxPpXyGvRDl+eUEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420259; c=relaxed/simple;
	bh=23nR3R05VC9NGVtrS6IFRiL4Y6Ve6VlZj2xDnwPXLdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3H6nAiaeyZ4tGwxfCYmLsNo6D6CXhVUCVm6Q5m+CaDQtlg+waR+b8HAM/RdfxOn6CDuajWRL5M32r1G1iPoMtfNOB75Xvlmx+rFmH30Sf3bv61esLlsr4NaL/cotcogwJXfycnBRB0j3T5sDhAoxHa4pBs6NJ6EJL3x18WKIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faivMuqG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faivMuqG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2538430f8f.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420256; x=1781025056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQdz8OzE9HTCsMAo40059iOYVs3OsJHDGb5DCGfSdoU=;
        b=faivMuqGCuWhN8iUqW8OJSj1RMBvvcgobNhHZpwTzM/FXDuFYVBXeWN1GHANUenk4e
         iuK88RCKTJ7GSHP7I2DTMAh3NPyi8SRgm1XnIw598lxD0955D9uREA83vWiiQaXoKC1Q
         bmiCzoplCOaWb3mHLE+KD/8D/LXPNryY812vONCuvMzhtg0gV7ZEEtApnirG6GJQq2uI
         ePN3e91nImQhRj0LUCXDFnZf8BpK6MnKy7i5l39lxWWerHmYzWK+wYiAY2ygrRfWsph6
         a7nuJ1fpkh3GpTyV+2TfrrcUX7szeVyCP8uoeiWCtMJI/V/PVehb4On+Rvnj2avIdexS
         ceFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420256; x=1781025056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQdz8OzE9HTCsMAo40059iOYVs3OsJHDGb5DCGfSdoU=;
        b=jS+wgiOHFz78DTqQFZZ5YoXkG/FXSzJ9U/AJf7IM94LcYk/UmoC/V6yZpe3PWL/gUD
         dWslJIoVcaElr7yzv9dRjLjNP9NTqF46W+8AaGbgcCwfQccT82JNPT/nUpfqe2caMnqN
         c0+u/j2u37MtAiXmx61ePvFX3ufHhyn9RHZpKaRgo0xuAh3YvV0d3fgLOXEXJ7s/Qmt1
         OeL5KBn3zS+ck6wZNEfSbQ7eNh1/QgW3zQgIHvN+smabtXLhWAC5khR6CU6j/lS1Y2QJ
         75gMfKL6BRqKUXkP0U8M+z3u+x7NB95PyynJpM5bssCu8Wcy6aMJJuu+tu2/p6gf3A6t
         IYNQ==
X-Gm-Message-State: AOJu0Yw/Zioh/AFAPJIMhEMubnweCM5B7EKynnePj5Y8fNngF6sQ0U1n
	+kCjiZ1K/EwfG9ak1cKLXZBNEmYI94izanblG1N41EQal+PGYkWg9UmhD8RiQAQh
X-Gm-Gg: Acq92OH+JmVzvVABhPiBqlKk6oF7QQUmE8+MqmdKHTOcg/u3EINJyqyHpReGKcdH3PH
	Rcabw2lAti7jfrsy0eQ2lkKsocr4+FKDdZQulezAar8F/UXG77f1UkxXdZG0d/odNGtiTOECVhl
	VhS5fAf2I2LDcxT3/jTMtbU6Z5M/voqN9NJkVHTsd4Iah0EUY437FAzv2sV10HeOTBwV/901uWo
	i2ApUR7XvbbvaE3d+M3LmEITDKJiGumVS3G1YO6A98uoqAqPdRFFAjnczR3S6ahcTu9yQI20bob
	rnQWKDtxf0Fe11hxIarB2T2N/JCiNbesaFO9JLfkmsmsEanUuOoorvTeQmwcwRXHMnbZQ5CiW3E
	90D3I0WnoPzHufQT3TMl4DsXvynMsWXKELpLmcOzSe4k03XAr42nBeGRkhtdjO9ehB+OHyHgCKj
	tLgwULPax84zn89UwxdDZe49HK8lqFEgBhgQLp5RRBhrscxcIqzw04uiyvTDwBJ6ZhrLgG7FY=
X-Received: by 2002:a05:600c:4e52:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490b50801b0mr10827635e9.14.1780420256068;
        Tue, 02 Jun 2026 10:10:56 -0700 (PDT)
Received: from pop-os.localdomain ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e239f4sm122904265e9.7.2026.06.02.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:10:55 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 4/8] environment: move "pack_compression_level" into `struct repo_config_values`
Date: Tue,  2 Jun 2026 18:09:17 +0100
Message-ID: <20260602170921.35869-5-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260602170921.35869-1-belkid98@gmail.com>
References: <20260601154211.82370-1-belkid98@gmail.com>
 <20260602170921.35869-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `pack_compression_level` configuration is currently stored in the
global variable `pack_compression_level`, which makes it shared across
repository instances within a single process.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. `pack_compression_level` is parsed
eagerly because it influences packfile compression, a core operation
where a lazy parse could cause inconsistent behavior and hamper
libification. This preserves the existing eager‑parsing behavior while
tying the value to the repository from which it was read, avoiding
cross‑repository state leakage and continuing the effort to reduce
reliance on global configuration state.

Update all references to use `repo_config_values()`.

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
index 82bc6dcc00..070a5af3e4 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -965,6 +965,7 @@ static int store_object(
 	unsigned long hdrlen, deltalen;
 	struct git_hash_ctx c;
 	git_zstream s;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
 				      dat->len);
@@ -1005,7 +1006,7 @@ static int store_object(
 	} else
 		delta = NULL;
 
-	git_deflate_init(&s, pack_compression_level);
+	git_deflate_init(&s, cfg->pack_compression_level);
 	if (delta) {
 		s.next_in = delta;
 		s.avail_in = deltalen;
@@ -1032,7 +1033,7 @@ static int store_object(
 		if (delta) {
 			FREE_AND_NULL(delta);
 
-			git_deflate_init(&s, pack_compression_level);
+			git_deflate_init(&s, cfg->pack_compression_level);
 			s.next_in = (void *)dat->buf;
 			s.avail_in = dat->len;
 			s.avail_out = git_deflate_bound(&s, s.avail_in);
@@ -1115,6 +1116,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	struct git_hash_ctx c;
 	git_zstream s;
 	struct hashfile_checkpoint checkpoint;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int status = Z_OK;
 
 	/* Determine if we should auto-checkpoint. */
@@ -1134,7 +1136,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 
 	crc32_begin(pack_file);
 
-	git_deflate_init(&s, pack_compression_level);
+	git_deflate_init(&s, cfg->pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(out_buf, out_sz, OBJ_BLOB, len);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dd2480a73d..8ccbe7e178 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -386,8 +386,9 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	git_zstream stream;
 	void *in, *out;
 	unsigned long maxsize;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&stream, pack_compression_level);
+	git_deflate_init(&stream, cfg->pack_compression_level);
 	maxsize = git_deflate_bound(&stream, size);
 
 	in = *pptr;
@@ -413,8 +414,9 @@ static unsigned long write_large_blob_data(struct odb_read_stream *st, struct ha
 	unsigned char ibuf[1024 * 16];
 	unsigned char obuf[1024 * 16];
 	unsigned long olen = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&stream, pack_compression_level);
+	git_deflate_init(&stream, cfg->pack_compression_level);
 
 	for (;;) {
 		ssize_t readlen;
@@ -5003,6 +5005,7 @@ int cmd_pack_objects(int argc,
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	struct option pack_objects_options[] = {
 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
@@ -5084,7 +5087,7 @@ int cmd_pack_objects(int argc,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
-		OPT_INTEGER(0, "compression", &pack_compression_level,
+		OPT_INTEGER(0, "compression", &cfg->pack_compression_level,
 			    N_("pack compression level")),
 		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
 			 N_("do not hide commits by grafts")),
@@ -5243,10 +5246,10 @@ int cmd_pack_objects(int argc,
 
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
index 7c122ac419..37def5cc59 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1437,8 +1437,9 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
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

