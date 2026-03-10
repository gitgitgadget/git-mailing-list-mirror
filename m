Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771FA38D68D
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144466; cv=none; b=piVtJY9U6FpmtZ3cFofrGMTo739Y8UsdDYJNSX52ITf/BzIirr3aagB0zofmlrUSPn9hAgziM3/QAw5A2lMQRicw1yvvzLTYnuwrpRK362/Wu/7zxjY1Qzcxxo6mHx/0j9ayLf0G5bRiOUomdSPwGfiDZkSsBQx2Ykmxi0eSpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144466; c=relaxed/simple;
	bh=9aXu3UkuXuGwYWQH1s3luxrKbg+0SW7fyLyK1egmWB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fxu6DSHqAh3NISn2b8ImAfmwhlNSB43pwKvXCI/e8ZTb4GYTxecm9YkUJU/aLJxi08g4AoFxxtBoy9s37jyZZANR/kAlbuKZSKVTkHEmwwkCo7b5ICDjPWy6pCKXFR5rZUel/hkfDm28+5+BGfF8T/7C6YI9LLx+wKku4opMnu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9iCztnf; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9iCztnf"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7982c3b7da9so115779407b3.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144464; x=1773749264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PqGnKHW+FF4sFcvedluCKsOIvn17qdvQw9JoH1r86Y=;
        b=B9iCztnf6wvvektHNZ60l4dL+pxv18ab3EbgwTMtWMAcM5XK/1ZoeTPasKrItBn1RS
         XqE9KNtklUNf62uNFqqGXeb82Ufooxykse0CBM5Mib2fhV6xeXy3RAgvByAzeE3U0DWL
         8VeSCuv5pbviqmxi8K8BzTaycbQ+QDbhrlF67klpeYjy53Z0FUWU8i3+gv7xP8Rd87ih
         WUN4k+m3gGGMWm+mZHoOyXPKNGTHJ6bdzZcdDXJ+C6pEHNy9vKfr6Zd3S+ZS4EaaZzdH
         W0xFTlYZdNm9QaDPEnsf6H2krWKiTK/BdJUYZadbiXUZAb/+EBXZntO7E1Ry0DNR7x4A
         vtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144464; x=1773749264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/PqGnKHW+FF4sFcvedluCKsOIvn17qdvQw9JoH1r86Y=;
        b=HkvXh5YL9qzElpq52uUJiYd+mCt/GgivmpDeygvKjkE0BKf6Hfi1xUz2G+s/2wSLSM
         p/Rr8Uo6HRFSS2j5zZ699Y+jZJaHDJNh/keCDq/oop+UeWBgzDQI3AWaRxdN2uBpjv06
         nQW7RWRgdz0APHK2KtdyFFUoWAkqYXo5pRa/rgYcaszIpX8YsE1iOnGgnHrk3uXxU2/S
         Y5G5ceUsbVJN7r99SsL8Rex9vCfJruVPOtF03wetNtDm/5Psf4rlGbRW8EV32UoklUHc
         57++nWh3NO3UtCXkhDSBCCvjn18Tl9EhmVp8nGzyVFzfeajvJrvX9QkxPKtPTRHe38JE
         U2dw==
X-Gm-Message-State: AOJu0YxqtpNwbx4hj86oCaDq3AFqmmgd41lanE7SoPFxldiBoHR2nVm5
	y2lbt4H+L05UhHS+kuSpHMdYfzsMhbKZdJizdfXaX4aymXAqYIKucCBJDSwfzasj3uQ=
X-Gm-Gg: ATEYQzx7i+RTzSciGF8VHEOYVVeeaUKbx/HjxJrJw43cN8rpI2Yl6io/h+1IYB5tGrd
	VAyqg6A3w8rDE7H5tf9vTZQ4O62j1Ld1Hr7ojWwrrVZLRx0aWQDq+YJhSnDvUVqfTLBbw/mQOMj
	zkpHC9BFIi5HJ8PkKmFA7Kcv+USYgEtcKRLVjszHIaCkGuMNMJ3FmN4SVT8uhY1PWxr5+SR0t7T
	mxi5ZbTxnf263B5nezVQAzhwkDxdEG91HRjn/Ihu3o4vjO1EYD7Qx6nPMjxRLsB2NIdNMdqUA41
	8Rq0CKYrdpTL/Szw+DmBgnaR2/cVVLcMBzNjmAFlXExjh6e+i0kYqXD7iyhmeonZ9WXJXU+1vvh
	GCvzEob7I51snrJbc6Ld0rMdSmwx8hCG9YbBJYwBeDngz4c5lxWGDkZkSN63xf/0m7e3lO5z/Gi
	VDAer7U/UUuYTw5YESBBXiFSmHxOo=
X-Received: by 2002:a05:690c:f08:b0:799:394:bd49 with SMTP id 00721157ae682-7990394c6a0mr43535787b3.57.1773144464191;
        Tue, 10 Mar 2026 05:07:44 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:f56b:22db:e23b:9613])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a54a46esm14838847b3.15.2026.03.10.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:07:43 -0700 (PDT)
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
Subject: [PATCH v1 3/8] environment: move `zlib_compression_level` into repo_config_values
Date: Tue, 10 Mar 2026 13:06:24 +0100
Message-ID: <aebbcef3d1202001c5094d10587a86fda63cdfa2.1773127785.git.belkid98@gmail.com>
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

The `zlib_compression_level` configuration is currently stored in the
global variable `zlib_compression_level`, which makes it shared across
repository instances within a single process.

Store it instead in `repo_config_values` so the value is associated
with the repository from which it was read. This preserves existing
behavior while avoiding cross-repository state leakage and continues
the effort to reduce reliance on global configuration state.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/index-pack.c | 3 ++-
 diff.c               | 3 ++-
 environment.c        | 6 +++---
 environment.h        | 2 +-
 http-push.c          | 3 ++-
 object-file.c        | 3 ++-
 6 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b67fb0256c..dd82eed76f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1416,8 +1416,9 @@ static int write_compressed(struct hashfile *f, void *in, unsigned int size)
 	git_zstream stream;
 	int status;
 	unsigned char outbuf[4096];
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&stream, zlib_compression_level);
+	git_deflate_init(&stream, cfg->zlib_compression_level);
 	stream.next_in = in;
 	stream.avail_in = size;
 
diff --git a/diff.c b/diff.c
index 501648a5c4..4bc0297873 100644
--- a/diff.c
+++ b/diff.c
@@ -3365,8 +3365,9 @@ static unsigned char *deflate_it(char *data,
 	int bound;
 	unsigned char *deflated;
 	git_zstream stream;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&stream, zlib_compression_level);
+	git_deflate_init(&stream, cfg->zlib_compression_level);
 	bound = git_deflate_bound(&stream, size);
 	deflated = xmalloc(bound);
 	stream.next_out = deflated;
diff --git a/environment.c b/environment.c
index 8542ac3141..5b0e88b65c 100644
--- a/environment.c
+++ b/environment.c
@@ -52,7 +52,6 @@ char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
 int use_fsync = -1;
@@ -377,7 +376,7 @@ int git_default_core_config(const char *var, const char *value,
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
 			die(_("bad zlib compression level %d"), level);
-		zlib_compression_level = level;
+		cfg->zlib_compression_level = level;
 		zlib_compression_seen = 1;
 		return 0;
 	}
@@ -389,7 +388,7 @@ int git_default_core_config(const char *var, const char *value,
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
 			die(_("bad zlib compression level %d"), level);
 		if (!zlib_compression_seen)
-			zlib_compression_level = level;
+			cfg->zlib_compression_level = level;
 		if (!pack_compression_seen)
 			pack_compression_level = level;
 		return 0;
@@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
 	cfg->trust_ctime = 1;
 	cfg->check_stat = 1;
+	cfg->zlib_compression_level = Z_BEST_SPEED;
 }
diff --git a/environment.h b/environment.h
index 1d3e2e4f23..93201620af 100644
--- a/environment.h
+++ b/environment.h
@@ -93,6 +93,7 @@ struct repo_config_values {
 	int apply_sparse_checkout;
 	int trust_ctime;
 	int check_stat;
+	int zlib_compression_level;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -170,7 +171,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern int zlib_compression_level;
 extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
 
diff --git a/http-push.c b/http-push.c
index 9ae6062198..c6bf9ff387 100644
--- a/http-push.c
+++ b/http-push.c
@@ -369,13 +369,14 @@ static void start_put(struct transfer_request *request)
 	int hdrlen;
 	ssize_t size;
 	git_zstream stream;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	unpacked = odb_read_object(the_repository->objects, &request->obj->oid,
 				   &type, &len);
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 
 	/* Set it up */
-	git_deflate_init(&stream, zlib_compression_level);
+	git_deflate_init(&stream, cfg->zlib_compression_level);
 	size = git_deflate_bound(&stream, len + hdrlen);
 	strbuf_grow(&request->buffer.buf, size);
 	request->buffer.posn = 0;
diff --git a/object-file.c b/object-file.c
index 3094140055..8b719a915c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -891,6 +891,7 @@ static int start_loose_object_common(struct odb_source *source,
 	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	int fd;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	fd = create_tmpfile(source->odb->repo, tmp_file, filename);
 	if (fd < 0) {
@@ -906,7 +907,7 @@ static int start_loose_object_common(struct odb_source *source,
 	}
 
 	/*  Setup zlib stream for compression */
-	git_deflate_init(stream, zlib_compression_level);
+	git_deflate_init(stream, cfg->zlib_compression_level);
 	stream->next_out = buf;
 	stream->avail_out = buflen;
 	algo->init_fn(c);
-- 
2.53.0.155.g9f36b15afa

