Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CDB3BB690
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328636; cv=none; b=bj6n0Hho6xMXwVHS3/gdQKkr/+w1YOnwReR4g9LskBkpgs7tubKerJb9dH53Cw1xAVUYMQ+wAtghZzkBGPw9n44Prb0kmOUl55g1GIx38rLseNlWRqm8/ROK6/sxfxsbJDK9ebsCCuoIN4KdEoDnvU56L72iKCNBuLodMCdlQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328636; c=relaxed/simple;
	bh=hsmtoeno9Nb9d1TJVk2/gEQA4Ox2uDANB27T6nVtw9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtcdQUJH+ICA+7sVIdQ6w2c02nDdXR2NVmHqPXHzQn5cFhGBKKdFBh85+sqgi3WjYi43lAJVYpKBY4kpzxjukblSgKjWvyGrtFiigWob8wXFbrLZWFW6JJEHkafmNhNuc0asWWwn9Q99DgXBhu7Y5tvDhFt4GympMFIaKkME/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAolWkMz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAolWkMz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso93859245e9.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328634; x=1780933434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdLGNxdy1VSlUDHrXPxm2Clw8ESgWIZ/1fNeAgrwmVk=;
        b=qAolWkMzgrheTvZlpf1SQFv5nKUKua/zGxXqVv1Y3fouzV+lp8NNc/beEyEuHbC3RI
         amuMO4xNmVl7cuGpfy/IL5TKnG+hjkQDGw7NwO2CEgbc4c+vmWWZ717+Ro1sJoyUy3b/
         dgEz6hxdz7rzfZk+TiywRgQfATBFpbVlEX8x+2K4hx7QRnPZNoQ86v9fRESShN9CRQfj
         82dvQt87XJCGlt6+aIkj4cf+74TFweS5t+RFFAqGWv8yn9eHe8KeWP2staLxI82is3tv
         ewjEo4QK+2fZYoAsd3HCW0S7I4zZxHgSx8Z2rWPJY+WfMyC3HYaUEWMEYwNGjHAZvrgT
         yZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328634; x=1780933434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CdLGNxdy1VSlUDHrXPxm2Clw8ESgWIZ/1fNeAgrwmVk=;
        b=oOOIWWR0BRnH0R699W5XYyB4iD42DcxJbwyFRRktCsPU8BwXqZg4IPHBmbL3s0k03X
         19XuIlU7GuRtmexM6P/x3v0iGJxSMfjUiy/MbarP1Rxm/QybyA6oC2+qFVys5vSDvRdr
         3+vtciXSDlxVR23nLYRf4o5nj2TaTpQW8tV2lTy3MzvYqU5LvqBnVqs01hEGWLyXQgYX
         3lIkDudBp67UAMsAAo2twtcFVfvcW3gFQ+Jbu1XAeTNCMAzjSM/gPKHS0fTfh33Eckht
         4MMVvWvqsm0TzrpWABOJqSki+U6ojb07Vaz6spFKEem2K448xBS7mfOlwdPLDRjf6iBX
         L/XA==
X-Gm-Message-State: AOJu0YygSS/TfmAyPjjm3Sl962lAcHkhdoS1Gtk797UzMMNgsdwtwwUK
	pN8IWDFyJgmxFd9d8G1wyXr7/ExD/8+9pCxKCuzHLgkITxEkEhFZNzJIwbp7REdR
X-Gm-Gg: Acq92OH7sKsFDCymsrAPI2DjVMUszCMa3k/il7QFD+qN2J/XJUbjZUM43UzJmZe4aVY
	ZytGTaeuhQ9cMR67K6BYPI+8mBQrS1fOXmKXau4/2EZQ3OeGIcpdMPVS/ynbVKlc2kNKuqvoON8
	R/c8fbT8B5ktX770+NWR4PWen0LaFznmtnT3gbCiAuXA5uRXtSw9Krvf8mc6UbLAx//2aiwo/2A
	85upZMHdcRASEP4VfEo0u8sL6gx7UeqGOWF+67uFxoqGZChzHQXw1cUaQ3eFA2F7q/VLnJEdXW6
	79q9yBZJsfXOYXtq5PVmejfzk+XBmC8TQn8YlzLkhNCvNOINlBBNIKS9mooWYjy7xMqX3p3hmmi
	GPvfwVgSg568ZiQ5sY7mHwlcv4jl1ieNjTfbPo+H8fseRdlvve/WZ+aU+CeO119rA1UaDa9BoJm
	ZwhpQUdOkBP1tX3/DVbF3shLaWQf96Vqx++YpPzi9WioEAQv4vtFOTYbBXBqhJOYw0Fw==
X-Received: by 2002:a05:600c:4f05:b0:490:50e8:45c3 with SMTP id 5b1f17b1804b1-490a28cf434mr215990235e9.0.1780328633708;
        Mon, 01 Jun 2026 08:43:53 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e07:e310:19bb:fe0b:a332:fe8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e81ef4sm350485e9.12.2026.06.01.08.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:43:53 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 3/8] environment: move `zlib_compression_level` into `struct repo_config_values`
Date: Mon,  1 Jun 2026 16:42:06 +0100
Message-ID: <20260601154211.82370-4-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260601154211.82370-1-belkid98@gmail.com>
References: <20260423160832.114816-1-belkid98@gmail.com>
 <20260601154211.82370-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `zlib_compression_level` configuration is currently stored in the
global variable `zlib_compression_level`, which makes it shared across
repository instances within a single process.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. `zlib_compression_level` is parsed
eagerly because it determines compression behaviour for objects and
packs – core operations where a lazy parse could lead to unpredictable
results and hinder libification. This preserves the existing
eager‑parsing behavior while tying the value to the repository it
was read from, avoiding cross‑repository state leakage and continuing
the effort to reduce reliance on global configuration state.

Update all references to use `repo_config_values()`.

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
index ca7784dc2c..3942d3e0d0 100644
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
index 397e38b41c..7d17b0bf3f 100644
--- a/diff.c
+++ b/diff.c
@@ -3589,8 +3589,9 @@ static unsigned char *deflate_it(char *data,
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
index d143fe2845..8ac107a56e 100644
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
index 2acc9522df..7c122ac419 100644
--- a/object-file.c
+++ b/object-file.c
@@ -906,6 +906,7 @@ static int start_loose_object_common(struct odb_source *source,
 	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	int fd;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	fd = create_tmpfile(source->odb->repo, tmp_file, filename);
 	if (fd < 0) {
@@ -921,7 +922,7 @@ static int start_loose_object_common(struct odb_source *source,
 	}
 
 	/*  Setup zlib stream for compression */
-	git_deflate_init(stream, zlib_compression_level);
+	git_deflate_init(stream, cfg->zlib_compression_level);
 	stream->next_out = buf;
 	stream->avail_out = buflen;
 	algo->init_fn(c);
-- 
2.53.0.155.g9f36b15afa

