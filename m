Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371C1E3DFC
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504691; cv=none; b=nWDebicGb+BkzPlSXGp5wt1MyMSrerAxcdj86GdlshrNk66snfFq+996QD7kxEfLzc8FH9OyOdtTIw3ceDLoqY8uvt2Sn2OFVOHkJ6EGraDeCW4a5g//dKgUdZE6hX1+xq2c/5TRvT9tLtzHA4RYwKzI8ObcVc8MW2TgN0sgMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504691; c=relaxed/simple;
	bh=n28m+GQYfjSixgZq1JJew40wDnLGtMFxYB//OXbMhHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHQ4YEzJkKz/LtJ13vlaevcYTLQLUut6d9HH02+SKPCrWvPXI39HR/cPZbJoZkadtRLsmYYVV4/c8WIiTD7+bmp+P7NbnnaggJ8XqDSESjU+aJVRtGXKbBo+xq2uwcSRangkfkWyHjN9nHZh7e66t0bBG+pNWSk7f1/qkH9dyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFND+L2D; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFND+L2D"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99cc265e0aso620548766b.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504687; x=1730109487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVYj84C5UlH3WT4p2T1nxT/NluhMqbJySawoGAMESzM=;
        b=QFND+L2D6uHrBFOwm9SxmEVhoB8Lvts8CSgn159OesEMI2GsWyZsqlhpAjznEg1VCN
         csY6I9BRL/Y7PEDZ5E/wD9Ld5wUyk3pypLv6eQ9vfXrGNqkJnOmuxHlXYku5QiGMeCz2
         0C+wxaQYpnfEhf840cOH1KXTObxyi7Pg3VsQxB+Hq9I5FTbRYhj0+RkDp0o64bl7GFfa
         FdxQxgPjaZzBI9vkDzRfF/osKiqzq5XZLeuqzD0S6zL0VrSQEKATKuf/NMfOkUHIvseL
         F6g51Fq1zQw5nn10FgspL9h/6kpALnpdYh50tfSpPg5XooVdMbAzjjZravUA3Vo3igDG
         6TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504687; x=1730109487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVYj84C5UlH3WT4p2T1nxT/NluhMqbJySawoGAMESzM=;
        b=xU3PBqcu0+wZ9W8frWmLgxROB6Sw+Avac2+423bL/67L+GSGPW0oqEMAfeQWElpbkT
         MAn+KjyQbUwxZTijJYNPGhCo5vWRpzSQgW/wm3tXQjTRiJYngy0DKknhL3SQE73hZ5nC
         y8C42mvBBIDbMbUcb3ZPJqlgYeReenck+XDE69uiO87VXu+dyFdZyucbjrlgSE4FMlfu
         xHkSBpemkKbvLmpx0YuepP5WZDJQ8utPHNAfpDHqzQA+HXzG8lYpLS6sLJ5XW6Pck9W4
         DhCgpvtJt1pmQmr7gDsQNt531yRllCBiMwSRT18lTJZhqqbxAax7Uijf5f6BsoJd3rWE
         PQvg==
X-Gm-Message-State: AOJu0YzvQ+1FwR4f7eTKPDeVJaLkffWfMUxSjo8YEG7yXCXl4a+FxDXJ
	Bv43E+rt1IbiKX2W/IvdPsbrw3L9bHO+6eBTFgRzIjLgo4ufCWiv62yD90Q2
X-Google-Smtp-Source: AGHT+IGq1oarNVrSY2w+XsaDMkmnQ8pXYstc46Wn4oQ2DmlkvBJlm1MI66IBxXjgaveq0Z+m8KLsPw==
X-Received: by 2002:a17:907:94c8:b0:a99:fb75:3ed7 with SMTP id a640c23a62f3a-a9a69a69349mr1078075966b.17.1729504686828;
        Mon, 21 Oct 2024 02:58:06 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:06 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 01/20] packfile: pass down repository to `odb_pack_name`
Date: Mon, 21 Oct 2024 11:57:44 +0200
Message-ID: <c8cc21c2eeb9d1e0bc261143e642eff38fe33888.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
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
layers. Let's remove its usage from this function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c    |  8 ++++----
 builtin/index-pack.c     |  4 ++--
 builtin/pack-redundant.c |  2 +-
 http.c                   | 15 +++++++++------
 packfile.c               | 27 ++++++++++++++-------------
 packfile.h               | 13 ++++++++-----
 6 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 1e7ab67f6e..7ad950627c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -805,7 +805,7 @@ static char *keep_pack(const char *curr_index_name)
 	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	odb_pack_name(&name, pack_data->hash, "keep");
+	odb_pack_name(the_repository, &name, pack_data->hash, "keep");
 	keep_fd = odb_pack_keep(name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
@@ -813,11 +813,11 @@ static char *keep_pack(const char *curr_index_name)
 	if (close(keep_fd))
 		die_errno("failed to write keep file");
 
-	odb_pack_name(&name, pack_data->hash, "pack");
+	odb_pack_name(the_repository, &name, pack_data->hash, "pack");
 	if (finalize_object_file(pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
-	odb_pack_name(&name, pack_data->hash, "idx");
+	odb_pack_name(the_repository, &name, pack_data->hash, "idx");
 	if (finalize_object_file(curr_index_name, name.buf))
 		die("cannot store index file");
 	free((void *)curr_index_name);
@@ -831,7 +831,7 @@ static void unkeep_all_packs(void)
 
 	for (k = 0; k < pack_id; k++) {
 		struct packed_git *p = all_packs[k];
-		odb_pack_name(&name, p->hash, "keep");
+		odb_pack_name(the_repository, &name, p->hash, "keep");
 		unlink_or_warn(name.buf);
 	}
 	strbuf_release(&name);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9d23b41b3a..97afc69625 100644
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
index 5809613002..60f806e672 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -688,7 +688,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       sha1_pack_index_name(pl->pack->hash),
+		       sha1_pack_index_name(the_repository, pl->pack->hash),
 		       pl->pack->pack_name);
 		pl = pl->next;
 	}
diff --git a/http.c b/http.c
index d59e59f66b..309669c203 100644
--- a/http.c
+++ b/http.c
@@ -2388,7 +2388,7 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
 	strbuf_addf(&buf, "objects/pack/pack-%s.idx", hash_to_hex(hash));
 	url = strbuf_detach(&buf, NULL);
 
-	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(hash));
+	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(the_repository, hash));
 	tmp = strbuf_detach(&buf, NULL);
 
 	if (http_get_file(url, tmp, NULL) != HTTP_OK) {
@@ -2407,8 +2407,10 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	char *tmp_idx = NULL;
 	int ret;
 
-	if (has_pack_index(sha1)) {
-		new_pack = parse_pack_index(sha1, sha1_pack_index_name(sha1));
+	if (has_pack_index(the_repository, sha1)) {
+		new_pack = parse_pack_index(the_repository, sha1,
+					    sha1_pack_index_name(the_repository,
+								 sha1));
 		if (!new_pack)
 			return -1; /* parse_pack_index() already issued error message */
 		goto add_pack;
@@ -2418,7 +2420,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	if (!tmp_idx)
 		return -1;
 
-	new_pack = parse_pack_index(sha1, tmp_idx);
+	new_pack = parse_pack_index(the_repository, sha1, tmp_idx);
 	if (!new_pack) {
 		unlink(tmp_idx);
 		free(tmp_idx);
@@ -2429,7 +2431,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	ret = verify_pack_index(new_pack);
 	if (!ret) {
 		close_pack_index(new_pack);
-		ret = finalize_object_file(tmp_idx, sha1_pack_index_name(sha1));
+		ret = finalize_object_file(tmp_idx, sha1_pack_index_name(the_repository, sha1));
 	}
 	free(tmp_idx);
 	if (ret)
@@ -2563,7 +2565,8 @@ struct http_pack_request *new_direct_http_pack_request(
 
 	preq->url = url;
 
-	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(packed_git_hash));
+	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(the_repository,
+							      packed_git_hash));
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
 		error("Unable to open local file %s for pack",
diff --git a/packfile.c b/packfile.c
index df4ba67719..e4569ea29d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -25,26 +25,25 @@
 #include "pack-revindex.h"
 #include "promisor-remote.h"
 
-char *odb_pack_name(struct strbuf *buf,
-		    const unsigned char *hash,
-		    const char *ext)
+char *odb_pack_name(struct repository *repo, struct strbuf *buf,
+		    const unsigned char *hash, const char *ext)
 {
 	strbuf_reset(buf);
-	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(the_repository),
+	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(repo),
 		    hash_to_hex(hash), ext);
 	return buf->buf;
 }
 
-char *sha1_pack_name(const unsigned char *sha1)
+char *sha1_pack_name(struct repository *repo, const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
-	return odb_pack_name(&buf, sha1, "pack");
+	return odb_pack_name(repo, &buf, sha1, "pack");
 }
 
-char *sha1_pack_index_name(const unsigned char *sha1)
+char *sha1_pack_index_name(struct repository *repo, const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
-	return odb_pack_name(&buf, sha1, "idx");
+	return odb_pack_name(repo, &buf, sha1, "idx");
 }
 
 static unsigned int pack_used_ctr;
@@ -237,14 +236,16 @@ static struct packed_git *alloc_packed_git(int extra)
 	return p;
 }
 
-struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
+struct packed_git *parse_pack_index(struct repository *repo,
+				    unsigned char *sha1,
+				    const char *idx_path)
 {
-	const char *path = sha1_pack_name(sha1);
+	const char *path = sha1_pack_name(repo, sha1);
 	size_t alloc = st_add(strlen(path), 1);
 	struct packed_git *p = alloc_packed_git(alloc);
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
-	hashcpy(p->hash, sha1, the_repository->hash_algo);
+	hashcpy(p->hash, sha1, repo->hash_algo);
 	if (check_packed_git_idx(idx_path, p)) {
 		free(p);
 		return NULL;
@@ -2151,10 +2152,10 @@ int has_object_kept_pack(const struct object_id *oid, unsigned flags)
 	return find_kept_pack_entry(the_repository, oid, flags, &e);
 }
 
-int has_pack_index(const unsigned char *sha1)
+int has_pack_index(struct repository *repo, const unsigned char *sha1)
 {
 	struct stat st;
-	if (stat(sha1_pack_index_name(sha1), &st))
+	if (stat(sha1_pack_index_name(repo, sha1), &st))
 		return 0;
 	return 1;
 }
diff --git a/packfile.h b/packfile.h
index 0f78658229..507ac602b5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -29,21 +29,22 @@ struct pack_entry {
  *
  * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
  */
-char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+char *odb_pack_name(struct repository *repo, struct strbuf *buf,
+		    const unsigned char *sha1, const char *ext);
 
 /*
  * Return the name of the (local) packfile with the specified sha1 in
  * its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-char *sha1_pack_name(const unsigned char *sha1);
+char *sha1_pack_name(struct repository *repo, const unsigned char *sha1);
 
 /*
  * Return the name of the (local) pack index file with the specified
  * sha1 in its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-char *sha1_pack_index_name(const unsigned char *sha1);
+char *sha1_pack_index_name(struct repository *repo, const unsigned char *sha1);
 
 /*
  * Return the basename of the packfile, omitting any containing directory
@@ -51,7 +52,9 @@ char *sha1_pack_index_name(const unsigned char *sha1);
  */
 const char *pack_basename(struct packed_git *p);
 
-struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
+struct packed_git *parse_pack_index(struct repository *repo,
+				    unsigned char *sha1,
+				    const char *idx_path);
 
 typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
 				      const char *file_name, void *data);
@@ -193,7 +196,7 @@ int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsi
 int has_object_pack(const struct object_id *oid);
 int has_object_kept_pack(const struct object_id *oid, unsigned flags);
 
-int has_pack_index(const unsigned char *sha1);
+int has_pack_index(struct repository *repo, const unsigned char *sha1);
 
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
-- 
2.47.0

