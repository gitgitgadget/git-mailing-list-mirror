Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A2437DE8B
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963345; cv=none; b=utBT9vvv/rHxOi39BWYPq4RzIgWAn+vm1Sq8ZfIzsGMp4b/sOb10DfbVDBtAQ2zg3fMKksP+Wi9FSrfvj1v0ISux3Az1C1YnsQDeYFFF1TFiy3jvBift759fyqO5z2uwr+IzH9iAIjhG0hG/T7dY/FIUDc/SdVaehY3gqtOlZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963345; c=relaxed/simple;
	bh=hsmtoeno9Nb9d1TJVk2/gEQA4Ox2uDANB27T6nVtw9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ga3cO07iEIFTF8n+zG98yhBkjKE0S/le1Q+tMg+9EyqjhLyDfqMA61uEYV+ytAcCIu3Pff7Td9hi19w4a17Jamd0CaWRPy5xvkW+xzvhhkvS3FAZkCEAM4Ffcag6tsdYG99HJ6McGn7yQ1k8AEo+YpDc6mtrVDuBYATmY+TcU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z26xzZEu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z26xzZEu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4890098abbaso51288085e9.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963342; x=1777568142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdLGNxdy1VSlUDHrXPxm2Clw8ESgWIZ/1fNeAgrwmVk=;
        b=Z26xzZEu4gdImMOiflfQAeM0CugBvRPSMJtN68C+FZCUx9bPuc5764G+iYu5QJXjBb
         6qlI9MSJUUTj4ji+XBYiSB2B0q/zE1M/cPRXnXtmdwXUmz1et9Tt14jJ7TPNiHJOtpk2
         Pw9qpgqRHkyQ3ZuKNv52jNnz63nIM70yAZhyab/UEuRWNOfTMtnXSd6dIu+i3pnemNBJ
         hiVDwz+l0KZslZtcsvUhRphBW2wei4Qb4nyO2XHb+iyBd6hWGEnholrGGDN0t/G9Xxd1
         9DhzUWi/vtLxkJ3+PRjH/tCY3zQ9ZGcCilSojWVnwv5hFMsaD3xAcDK1xPkCwt6dRR/Z
         mRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963342; x=1777568142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CdLGNxdy1VSlUDHrXPxm2Clw8ESgWIZ/1fNeAgrwmVk=;
        b=Z6zmgCibGxo2lTzmD2cd5/FSQiyqFeJr7eBplUP4ExAl8PscnMwVMKvl7uJuxyYWcG
         ZaUze04d0BOpcs0jU9Bemghw18bMwg5CB1qt190z+m91Kzssn+8aBgxuEPcp16tgnPDT
         AynnEPZc2TwUItzd7GkUk+ddVL9jxDBT2c92yaK4bjkkWLbyyfN1D8cjE4P1F01UOySk
         3bevbyNVohvjY2gJ6inceAK2vn5y+FMD9C1OK7Yj9AvyxfLRUJAu8njMX5ifieY61GXI
         TU5Qm+qdBbKvCIKQPtJs/8HbSDjAsNbbBSZhgwi+2TBB6y/ApEafktLPjJC95W+6b1hj
         n7tg==
X-Gm-Message-State: AOJu0YwlJzXCFR2xc/dvWC0fisNe7uedcP4GyL1djvlvjc2SmvSNAiTf
	E7hCYcxqGRykdlQylVPaTSVxBfsanNp88lAZBRrK/pj9tjIyNxHa7giHyZU5loox
X-Gm-Gg: AeBDieuynxGazH8Ll0mMs6J6gbAJ9p/0dwiSF+R9t356Wh+Mw6ATwePtEINN7H1Bhop
	PmEHuB67tXKrta/vf3x0OJNXdd/v+7GwRwNZYDebc0zaepqclcvFbVXhPWUhB9YNxOa/yNI3xaj
	GK3jTLPgqdoo1f+lp1739VLHVthNiE0rEQWJCm8GCfR4smjLYYJtQWcxSbcBsGfFLMr4Mv+FWtM
	gimdQs3xtB0iI8UuspFgA3ENYfGpwVSU0UU1H2TJKTlPS0VZvqDhYQf/iYxHGH3z9tbtqcZCheO
	nTJp8qJZ5Ktx/+08BPuO6a+AzMN0hcvn1jjxJ2X4mQ/iVEfv72f/ZmhGF1yOO4Dni/kCA1NfToU
	5sN93Xh/MDVViPey7l/LkVFQPO5FP3cc2jMdzsLfauWxhQXfF+/TOt88M9W9TzkgBcaNND772BI
	EbsV+1mNuqcCM2Ialqsp1Oi1YZh15/oQW1LtP80Rcz3xsnC/jjgtGQ9yoDDWBS/s9JrJWHUw==
X-Received: by 2002:a05:600c:4fc7:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-488fb78894bmr366811145e9.26.1776963342243;
        Thu, 23 Apr 2026 09:55:42 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm353431995e9.13.2026.04.23.09.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:55:41 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 3/8] environment: move `zlib_compression_level` into `struct repo_config_values`
Date: Thu, 23 Apr 2026 17:54:27 +0100
Message-ID: <20260423165432.143598-4-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423165432.143598-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423165432.143598-1-belkid98@gmail.com>
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

