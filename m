Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7021DE8AA
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270119; cv=none; b=IcTWNFBGeSyBJ8Q9jj+YHMOisTZLyiq2V8gBPvQQKB+oghNreiFT3SaUQWor7GvJYRmmJJNspF3QLRC+t6DxjFFiNbxfaavtKtfjsFEuPtW9sr//602/CgjkCkJct+5l8tEfYWYte4shVISNVpjA2J0SWsbfQuWgViSgxg/kC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270119; c=relaxed/simple;
	bh=2RBqCSZVOHA0Z1rq+EJDqLvzAxt4/8BKXvfcjwiX2/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqz1qrMKEKi9ve++eFBBXZZ/r0/xqOBYIf/WAeGmp6nOBsdCHyh3sLTacHtdu4ovVQ35Wd0PLtO3v5zo7jH8Xbb6u14dL6qPgynb6kbUkWvU1E1t/Pwk61x6f/LFQLts4YUM2timyvweQZP41HiATpQ0jeqHAjpzXd6xKl68+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti0WeBvM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti0WeBvM"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0062e9c80so2375789a12.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732270116; x=1732874916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=Ti0WeBvM1VCSRHUlSxKljzswI3iWWESJmKCT5LfVangPCXaf7tTdw3lwKE3BDl+HFE
         xRXKCp+Qv4hS59bY2Nn9ZK3c0fIxS979iwqtIW87OTxGJqZh9BE3NuTaUomj9MB60R8r
         8Kug9twBsnTCZQhpWkbuzsdv7OUUU5N8OKKd7zvKtT0KHEav9hP8Il/+fxk39eGzqrzC
         /afrkyCdABbo0e/WSS6x5YWTVXz9Jm2CBGCgbWT3gRMl3E5SMwkL9zsZiSHEQ/QhwRP2
         +gtc1dvhzaV9yfUqKBDvz5uU6BYrSSokbTpijmP2VoeOeE/ZCxiMtYvR5cpIwMwZ9qTj
         ObiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270116; x=1732874916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=ZvySktYgsY63CMCrLNMPlwtCTciugC1K5dxJjK6cuVqHaWd89JcCt2f9L5iHzG4uOH
         0X7qWTx5H/1nDlfcxPlflTZKgz11mKZ4+rJb37pvgKN0NWOEnBD7n2DHcw78iziH9dpM
         c7h61yfsOyqyDljEZT6erm0lP21EyPVlztFRMOgrrRtqadPmUOII+alyPbibM7MTJSnY
         T0f5vepFrt9bPzzPdbYRcSdtCU/UcllZFfsJeTbdZyu4cR++xOXZ3nDDQaJZKBrH47cE
         e1u7PA9xWp2nOx8kcQVyDijigSIWSDg/cKWuWlQALxTTAHKxfFcWu6AyVlxil01aiSSz
         b2Uw==
X-Gm-Message-State: AOJu0YwKXLlzw8VOVrTZ1VL/F9q7zWZVBq0X5QDqMpeHQJ/fHtprNuFI
	ljN5z0VuCrGVh6PUhPUrAYeDim6d1JfUzcdJH+MYE5v64V4xyyADNvx0SNUl
X-Gm-Gg: ASbGnctP/P8w81a8FK9AhVmYqEZxKFoAqSof4OIreuZtjHnI1Cs/kKqvgTnBsKQeuk+
	1RaMkjDmR0uHENH00sp7KW5DzJ5Iv8fE7HQ8LQsijwBb8UIrcTOqDV0jNq7HsxwbxgQDRVdGcQw
	bvQbR9JEX1ytKcUJvHw9F4Z3+jymQzLdbws/vaupEoDSOFqdI8R9eEhuq4iNj53+Ni3Q5rCw53E
	rGRHAnyEEBTtbNbEHgNF4cw5zsLrIGKnrMlheJGylmZJ7qzBnuih6g5PWjhY9I=
X-Google-Smtp-Source: AGHT+IEmXMk/sb2iK8AoxZeA4uv9OANMRz3zVgZlJWmKgPj4Km7cRKxA8K11LAmNEPTf9FG2JwdMkQ==
X-Received: by 2002:a05:6402:26c9:b0:5cb:dd06:90d5 with SMTP id 4fb4d7f45d1cf-5d0207945c7mr1621737a12.26.1732270115716;
        Fri, 22 Nov 2024 02:08:35 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0b50sm756849a12.30.2024.11.22.02.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:08:35 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v8 04/10] packfile: pass down repository to `odb_pack_name`
Date: Fri, 22 Nov 2024 11:08:23 +0100
Message-ID: <67d71eab836ea5fd27a5af3394b51fbd593b4355.1732269840.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732269840.git.karthik.188@gmail.com>
References: <cover.1732269840.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `odb_pack_name` currently relies on the global variable
`the_repository`. To eliminate global variable usage in `packfile.c`, we
should progressively shift the dependency on the_repository to higher
layers.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c    | 8 ++++----
 builtin/index-pack.c     | 4 ++--
 builtin/pack-redundant.c | 2 +-
 http.c                   | 2 +-
 packfile.c               | 9 ++++-----
 packfile.h               | 3 ++-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index da7e2d613b..3ccc4c5722 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -806,7 +806,7 @@ static char *keep_pack(const char *curr_index_name)
 	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	odb_pack_name(&name, pack_data->hash, "keep");
+	odb_pack_name(pack_data->repo, &name, pack_data->hash, "keep");
 	keep_fd = odb_pack_keep(name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
@@ -814,11 +814,11 @@ static char *keep_pack(const char *curr_index_name)
 	if (close(keep_fd))
 		die_errno("failed to write keep file");
 
-	odb_pack_name(&name, pack_data->hash, "pack");
+	odb_pack_name(pack_data->repo, &name, pack_data->hash, "pack");
 	if (finalize_object_file(pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
-	odb_pack_name(&name, pack_data->hash, "idx");
+	odb_pack_name(pack_data->repo, &name, pack_data->hash, "idx");
 	if (finalize_object_file(curr_index_name, name.buf))
 		die("cannot store index file");
 	free((void *)curr_index_name);
@@ -832,7 +832,7 @@ static void unkeep_all_packs(void)
 
 	for (k = 0; k < pack_id; k++) {
 		struct packed_git *p = all_packs[k];
-		odb_pack_name(&name, p->hash, "keep");
+		odb_pack_name(p->repo, &name, p->hash, "keep");
 		unlink_or_warn(name.buf);
 	}
 	strbuf_release(&name);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index be2f99625e..eaefb41761 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1479,7 +1479,7 @@ static void write_special_file(const char *suffix, const char *msg,
 	if (pack_name)
 		filename = derive_filename(pack_name, "pack", suffix, &name_buf);
 	else
-		filename = odb_pack_name(&name_buf, hash, suffix);
+		filename = odb_pack_name(the_repository, &name_buf, hash, suffix);
 
 	fd = odb_pack_keep(filename);
 	if (fd < 0) {
@@ -1507,7 +1507,7 @@ static void rename_tmp_packfile(const char **final_name,
 {
 	if (!*final_name || strcmp(*final_name, curr_name)) {
 		if (!*final_name)
-			*final_name = odb_pack_name(name, hash, ext);
+			*final_name = odb_pack_name(the_repository, name, hash, ext);
 		if (finalize_object_file(curr_name, *final_name))
 			die(_("unable to rename temporary '*.%s' file to '%s'"),
 			    ext, *final_name);
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index d2c1c4e5ec..bc61990a93 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
+		       odb_pack_name(pl->pack->repo, &idx_name, pl->pack->hash, "idx"),
 		       pl->pack->pack_name);
 		pl = pl->next;
 	}
diff --git a/http.c b/http.c
index 6744e18409..420f1566f0 100644
--- a/http.c
+++ b/http.c
@@ -2581,7 +2581,7 @@ struct http_pack_request *new_direct_http_pack_request(
 
 	preq->url = url;
 
-	odb_pack_name(&preq->tmpfile, packed_git_hash, "pack");
+	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
 	strbuf_addstr(&preq->tmpfile, ".temp");
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
diff --git a/packfile.c b/packfile.c
index c96ebc4c69..1015dac6db 100644
--- a/packfile.c
+++ b/packfile.c
@@ -25,13 +25,12 @@
 #include "pack-revindex.h"
 #include "promisor-remote.h"
 
-char *odb_pack_name(struct strbuf *buf,
-		    const unsigned char *hash,
-		    const char *ext)
+char *odb_pack_name(struct repository *r, struct strbuf *buf,
+		    const unsigned char *hash, const char *ext)
 {
 	strbuf_reset(buf);
-	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(the_repository),
-		    hash_to_hex(hash), ext);
+	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(r),
+		    hash_to_hex_algop(hash, r->hash_algo), ext);
 	return buf->buf;
 }
 
diff --git a/packfile.h b/packfile.h
index aee69d1a0b..51187f2393 100644
--- a/packfile.h
+++ b/packfile.h
@@ -29,7 +29,8 @@ struct pack_entry {
  *
  * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
  */
-char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+char *odb_pack_name(struct repository *r, struct strbuf *buf,
+		    const unsigned char *hash, const char *ext);
 
 /*
  * Return the basename of the packfile, omitting any containing directory
-- 
2.47.0

