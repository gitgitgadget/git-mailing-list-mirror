Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E536AB4A
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355958; cv=none; b=ZBbUr6O6xrgnbinoLSrwplXx7aswHXx1V43bpahEXJnCUDX1BZbu1nKN5BxpKLL/fPAgOrIuzuUTu7pVQ3Nkd/zKWU0mR57ET2wkaOPJyWNkytlNUWvRNJkDXpHFxBtXZIIzOXXevS7zNA8k84RLofrmmRjOtKAaNzPrEJwAev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355958; c=relaxed/simple;
	bh=9aXu3UkuXuGwYWQH1s3luxrKbg+0SW7fyLyK1egmWB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1tu7g78cjk8VwAqOpzDBZjP7Ou2drremultii2+3s2Mu9bbuGGIhoe5snzuLKxN9KaW7qbK1Ew2/WQEZD6bqbNLQ2IqmIjLb9z9nWMbQbQQovtYUHkyYztvP4G10qAj5sSZORYJRXgkdNxFShvp9zXu/zzOSufE1kRCIpyus9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBpm6nLL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBpm6nLL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so13785885e9.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355955; x=1774960755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PqGnKHW+FF4sFcvedluCKsOIvn17qdvQw9JoH1r86Y=;
        b=BBpm6nLLJ0jwKgw80B8riHXZt+bAqcw+AD6jI/HAFOjr+AhlxegfMUyb2sWJ49ZoCJ
         zConSKZWfra8B6TINh2rxkWRhE56jpWLFC11NTS9FAEJcKhkHScwxFDjnknSTNdku5mf
         qLkDIrz85YFBDkpCpAlkZK6HgAcNL0bLQw4+mUkGVI8HoOCYNElbi3gXKwziv8HH74Ge
         8JE832O1uIpndkRFN2KAfo/kcfEo2qScVWMNE3cF72240gWUGg62TENr2GwsveCbhvf+
         MnMRAR0y5/cjZobBb+8C7GblJvIPR0dVDs+5K+YKceWkaBFLAT1I6nbePXOzs33W71/F
         Bsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355955; x=1774960755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/PqGnKHW+FF4sFcvedluCKsOIvn17qdvQw9JoH1r86Y=;
        b=kbfbzCba58GM/0DDGij9Hu6IvqMMppd8qND6oOTOLy3fVQpB5oBImaNEWUZR2Wt80r
         z8EhbQ7duJZLl1ATvYLYo/QZ+eKuICqHAGmWfX0fEqlGQG57ereMnCsKq9q3n3DI2Glq
         g5H/gK6RUIWeWYLuu4l3kNvkyksIt8cTNiId4RrSVSKTDX36eaC8NFE5ZqMHJzNt08Dk
         YwLYHibMLiMNGYjcqeA1iotjawGteFYpwm7JX5BpbDnfEUkvG5JbcEf/8Z8bF8GIm5fx
         iHHzpfllyx0zUsZKJ+OcVYzpGYQRMay3Pw49A2CRfbW90F8Vcm9QcZY+CqRQQ/izjgXk
         e8cQ==
X-Gm-Message-State: AOJu0YyVEfM4KfVDpJZzC0VkhBHkBmqlag/iZAz8L3pbURONN3c+ae1N
	9Dey4fMOq91LQjo6YtRFf003gBZSO1YJmljQvLcaZTWmW5HRTEZyuJ4uCDxJmfPGusk=
X-Gm-Gg: ATEYQzz/pLOP+WlNjFKbENrYdeo7EeZ+RfoWdtG4Vvh3NQbKEctsO6ScEep1GFqXw/+
	P0y85CPaxmlDdMjmOTMvtGZ/vcc2Ajel9jAFApArLZCkVjNYGB0RtMR2P+z74H0Khv0HXWheTyp
	61Q3eoLNjm+h920acvf600wsWSsGoj/78uf+tg3A7PgjmJWhZwuNQtBRa4dyLWZtdBeS7af5Nyn
	+YZvvk2yaOvoVGPjO/i+ZTPmHpId67Mzx6cApWa1Lq9Fiugnb0ieGU4XVqwsfNwMWEY30H5l/kK
	RxU9vjhIoxBIRvZ/LX9n85rr9cIEHO3JLnOn5WVq5xvHEQbb8QPCofo55H9K9+fNeuD/Z98O1QZ
	ZJ232LCK2gaVd003ofkUz7Grc3H/o+mlx84cay5DuxZAg9hk4jnON4JoAH4qxY7oXHhZqqm4Pim
	Ib/D3p+Nh/r1HvLGWYAUvq9KCBAM0doNzaDHwzle/vR1f7/gd6OTseNfFCmg091mtKc1oLIlibz
	d4=
X-Received: by 2002:a05:600c:8b31:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-486fee304c4mr228793775e9.29.1774355954657;
        Tue, 24 Mar 2026 05:39:14 -0700 (PDT)
Received: from pop-os.localdomain ([102.88.113.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fd2c4esm32049815e9.4.2026.03.24.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:39:14 -0700 (PDT)
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
Subject: [PATCH v2 3/8] environment: move `zlib_compression_level` into repo_config_values
Date: Tue, 24 Mar 2026 13:37:45 +0100
Message-ID: <20260324123750.157143-4-belkid98@gmail.com>
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

