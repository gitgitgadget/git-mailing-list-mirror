Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F0346E7A
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144470; cv=none; b=IaTD9t13OgSxSeWd7xPGd1vcVuOGmXBW7FZ75cg68zmt/e9fQC4P5f7DPudI3xYLWsAKjPKDAVXEN7HP8+wtTcr8cQ+tafcRYg7El/JfSVOmp8wxwkNiumnSA0nD7T5GCYWd9SWUQsUDNqH4zrwbfK6/L6K4/801MxMebhe1d3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144470; c=relaxed/simple;
	bh=e2K5H1p4Syh9DCbXe3tvpupKdEMHTEfUUMQFKQWVc3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la5PFQZmuBJ3VDAv4GkEsXl6aqTA8F2Rynq7iYUzeprpdf97Eyx05zYyxoNqhm1Qik5X/Fyeqeiy79UzQty7IaGYnimOnRMokMuQTzhEGp7cIqoWmWKm4LPkO6WwZqOSqmVLg+LPap5fxDz2U0CynKkksPkcD5gr6pAsiKF72P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzZypvg1; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzZypvg1"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so12499934d50.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144468; x=1773749268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYWL1sD/ZPqnlcrlHOE+BqD5EeDdnHGsmY+M4jezEww=;
        b=dzZypvg1Hg1VZYF5jnGobtcVp5ttzwDGYGX/cRqTpjE9qdHZraIDW+kDVHog3nTIcy
         GQP4dutHhatH+gD/0SlvuuWuTDLzZN0jV8N/XcYh+m5lArGJZNMkeP9XVC6m3YguszI/
         iC6EomhDX1ho09c6etl+4a8ldZKn/WcizRnbsIjcR6fyOE2OYl3s2RCTTIsSDZvD0q2i
         HjCaNsQwaZiSaZXwV+sD8sVeVVgWeNh5IIBof7W760H2lBROQxkUmO1RhsIZiQkZX00v
         MjN2T3ObHONzIWVcPMge5+z1oIcU4xdyM/JI/c6disWSmdtBihvgSyvHwyeyGCe132Gf
         dkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144468; x=1773749268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYWL1sD/ZPqnlcrlHOE+BqD5EeDdnHGsmY+M4jezEww=;
        b=Jf7ld5fbropJxw0TMN5ZqvM0pbdlKCKpj1zRRt3xWol4uK/HiUC2h8WFKgLxzAUvNJ
         RpTVvim3vpXSR49Kik5SOAg1KyMonn47bm8n5FkGCjzjD3ZOdFug++oQjuQW3HJjpMol
         nO5B12O0Ys075uP825kMEShHJcPAikaBL4h/0uBA0Nsr7lBqXRu/apFawL4Ol+s7zZJM
         okzuBpIbf8J9VQDe2rWp2A9Rb5qATFgbfBUF3MkH7y5RctVF+TnBx9+yNOR+ET68ZXNP
         WR2zWfzehycvnlCKJVLn38jdJ8FeeaF/+3RlbPGJwGiLaSNIHS0Zz49lFasy9E+hpG0Z
         OUnA==
X-Gm-Message-State: AOJu0Yw3vEZjX9YKIBCnCU2DVd7auZazB1q2zjPeY5q60EVWJ2zNlAX/
	jEE6u9r6980fdFtSGIs8gjStwWlIsDT9w6teSG4FYCAJeOFVNTGFNfM295U+cVSPnvY=
X-Gm-Gg: ATEYQzxqHu6Ql/JmGgzN66JhT58d/zaIAnfWO2pMPzI8uSM3lGl8me1WmNd5MI+vGDi
	MyoY61t+sSpbQnOxNopF3SOOECWvIXPDZYaxHtKCMiRNdPLT788aTvEH25Zr1wN81KBmPOHVvd1
	8iq/cMz/YFsClvSqAI3FvvnRdwThnZ4+B6cogGYk7hV/xGYvO0kXS4dV8cYKtqYWfKZbNJJ/W0K
	xl/AVkbMfEhMOwt60W7MI1O7hGTaJr5S4atskXDjhcqAW5k/wGvy6eQzHJjD2RP4dW5kiFE5isc
	/NSWrPtR0HI+/1PDQM2UhBnS/5vBFPyeIUzAY1G1di2PSfQtghzGiypDaYGdhsjBHbuzhSRTrWk
	zW+NCrjj9RrXt8anrKBxBATnvJmzZg2tktEOlNzhaFKyLcw/bZ+u5DlIyNzJCPpr/UOikJsTe88
	r02foX3OgskqSTw6a0UTznXtNjFQo=
X-Received: by 2002:a05:690c:d85:b0:798:8024:f714 with SMTP id 00721157ae682-798dd67a17cmr134671447b3.20.1773144468293;
        Tue, 10 Mar 2026 05:07:48 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:f56b:22db:e23b:9613])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a54a46esm14838847b3.15.2026.03.10.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:07:47 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 4/8] environment: move "pack_compression_level" into `struct repo_config_values`
Date: Tue, 10 Mar 2026 13:06:25 +0100
Message-ID: <98bc36bb3ed8f5028442499f1b0d9731049e0b26.1773127785.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <cover.1773127785.git.belkid98@gmail.com>
References: <cover.1773127785.git.belkid98@gmail.com>
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
 builtin/fast-import.c  | 8 +++++---
 builtin/pack-objects.c | 8 ++++++--
 environment.c          | 8 +++++---
 environment.h          | 2 +-
 object-file.c          | 3 ++-
 5 files changed, 19 insertions(+), 10 deletions(-)

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
index c1ee4d5ed7..f5164486ea 100644
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
@@ -4868,6 +4870,8 @@ int cmd_pack_objects(int argc,
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+	int pack_compression_level = cfg->pack_compression_level;
 
 	struct option pack_objects_options[] = {
 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
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

