Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1F154C05
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926215; cv=none; b=aZl5RX6un5uN2s5OLVAyl4Z8C9x/SF2k2SHMp8OyS18uc2KtC8VtRILu8j56qn3rdFOEpBLzf41QDEIHqwrdeKQ6Ajqc8KMbdd7jSx2mhfXMngPzZITB9V06hfx2jGy/EIq1J8XWRXZCj4x+myJYVpPOcodpBHaf4rmKki/dus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926215; c=relaxed/simple;
	bh=n4swT6VImwZIwgIwCpNcmZGkCr+TrMMXqvn+aOzfOrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcMGk45WApLxAkQYan56RZZWjdCtZ4PK9kG5wfCoBpBrshrUeIzJdmQM+4cvP9ryr47gbNglS3ARyaKxUCdavYjJiu6mgqNabt0VqCtwjXHDmOJ7e1eZr5S2qsjbWpUaRTQzYpN0yfdEck6SXdN81Sn57SHnk5SIF3HAvANTEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gvOrYRQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIGbZZxM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gvOrYRQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIGbZZxM"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01D75114015B;
	Fri,  7 Feb 2025 06:03:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 06:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926212;
	 x=1739012612; bh=PatNX+wwBADwLRk8mmu/I1TpAYTBjjPgRPa1U/f0wIQ=; b=
	gvOrYRQkTxeLtXhEwkwr74veaSJMsO8Jnz1Bx40QI8dHd5LSn108qIyxah+Tg6CZ
	9GUyYkvcgeepnqR92NocGtzLyJEFs8QNHbclXqxGRH2ocGybCmL3EPdoqZvPNeCS
	Qp4TalK6f98kHITZ+eCiOG+TAKN9Rqs2gT6tYFkHSd7IG+IvIaxhd8ecJ5Fx7yHd
	Y3tYkWPMBWoMjgua2LgCiVBCAvNnW3pCYUACkBDf2W/SS+XWtlnOOMGJUCL6c+Q1
	fHP68yUccJMZPXSY5n5fH0MH38/rSCfcWX5WzJpp00g/wcnyD+aG2Ua07r583KMe
	/FY8Saea6k8J39jgYuK8sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926212; x=
	1739012612; bh=PatNX+wwBADwLRk8mmu/I1TpAYTBjjPgRPa1U/f0wIQ=; b=K
	IGbZZxM6M9HRqFG/D74ukAZL/oEVCOf2IFxrvqWMVZtD+RCqtzuocHPQO4eU51Wj
	VdfA0CzxYQTNs9y7sPp7nn0rmT/h8Q8hhDDAq/APY0HjLhVchQmApZSHUG0ZY67u
	8BIeUrQRLwpIy0/cZ4zJs4dikNUGEC39YhvFXCGQHmXIRhw2S5S4BnlWjZO80O6M
	sL6cT6YGewl4Fyi49XtVBEj6bc1MjDZoxAxLTG8yk+wdKy0AZo/72pYY6+ps8Dw8
	wiwJob98xRbELgWrQU/3h1ntNSY/XlSU8swdiAmh2yRYVvwrKYMvDCkFcJWR14Uc
	7T3Rt8NkZP01tIhNKI3Yw==
X-ME-Sender: <xms:hOilZwxvSdEZxpeYRaHaKG6WKAXGn7pjTaWWPB8zAlbRv8FvCYHIiQ>
    <xme:hOilZ0QsDyU8UkLuKlzaEMcfz_a9lXi6EQjIAq3Hb2RUjL11W7_dYFHedkm76_WY5
    2B49OssDGJfzpeYmA>
X-ME-Received: <xmr:hOilZyVJSye2ZmHN_ZA6ZHogtDsfSpmyLTTIyRpz9ZHAtvgdZHLiBcKhJNC-5kgqqH8bOW_hZqSyztLczz7MubLergxwW9OeSNc0B30z3JPK_udB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepleegjefhvdffhfffleeuudekteelleffffdvtddt
    udetudehgfdvlefhffeffefgnecuffhomhgrihhnpehvudgpohhnlhihpggvgihtvghnsh
    hiohhnshdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:hOilZ-jOxCcum5OtRmhYMfEc-Qxyz4M5halPs1L8rIdLHXEZp3uDYg>
    <xmx:hOilZyBN1OqdDPgqdV5AITagyB_bt5lTQh61BJ9tvX2uOWFW8fXimg>
    <xmx:hOilZ_IyFhTrp_zcfxXFdjyZdqnfrEVi68YgTIGgJshGwQ_bnTC9Ew>
    <xmx:hOilZ5Cu7sTnxVbnezIeF4eQasG3Qp5pR9-isCZU2qVsnIgrgql2uw>
    <xmx:hOilZ9NEI_H8XO_v4WUANk7ejNglDQnLOi09oStS86dVuGlq1HsYJyP7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da068f83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:26 +0100
Subject: [PATCH v2 01/16] path: refactor `repo_common_path()` family of
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-1-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

The functions provided by the "path" subsystem to derive repository
paths for the commondir, gitdir, worktrees and submodules are quite
inconsistent. Some functions have a `strbuf_` prefix, others have
different return values, some don't provide a variant working on top of
`strbuf`s.

We're thus about to refactor all of these family of functions so that
they follow a common pattern:

  - `repo_*_path()` returns an allocated string.

  - `repo_*_path_append()` appends the path to the caller-provided
    buffer while returning a constant pointer to the buffer. This
    clarifies whether the buffer is being appended to or rewritten,
    which otherwise wasn't immediately obvious.

  - `repo_*_path_replace()` replaces contents of the buffer with the
    computed path, again returning a pointer to the buffer contents.

The returned constant pointer isn't being used anywhere yet, but it will
be used in subsequent commits. Its intent is to allow calling patterns
like the following somewhat contrived example:

    if (!stat(&st, repo_common_path_replace(repo, &buf, ...)) &&
        !unlink(repo_common_path_replace(repo, &buf, ...)))
            ...

Refactor the commondir family of functions accordingly and adapt all
callers.

Note that `repo_common_pathv()` is converted into an internal
implementation detail. It is only used to implement `the_repository`
compatibility shims and will eventually be removed from the public
interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c    |  6 +++---
 path.c     | 32 ++++++++++++++++++++++++++++----
 path.h     | 30 +++++++++++++++++-------------
 refs.c     |  4 ++--
 setup.c    |  4 ++--
 worktree.c |  5 ++---
 6 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/loose.c b/loose.c
index 897ba389da..51ef490f93 100644
--- a/loose.c
+++ b/loose.c
@@ -75,7 +75,7 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 	insert_loose_map(dir, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
 	insert_loose_map(dir, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
 
-	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
+	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
 	fp = fopen(path.buf, "rb");
 	if (!fp) {
 		strbuf_release(&path);
@@ -133,7 +133,7 @@ int repo_write_loose_object_map(struct repository *repo)
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
-	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
+	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
 	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
 	iter = kh_begin(map);
 	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
@@ -174,7 +174,7 @@ static int write_one_object(struct repository *repo, const struct object_id *oid
 	struct stat st;
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 
-	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
+	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
 	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
 
 	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
diff --git a/path.c b/path.c
index 07964f5d32..273b649e00 100644
--- a/path.c
+++ b/path.c
@@ -414,7 +414,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
 	else if (!wt->id)
 		strbuf_addstr(buf, repo->commondir);
 	else
-		strbuf_git_common_path(buf, repo, "worktrees/%s", wt->id);
+		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
 }
 
 void repo_git_pathv(const struct repository *repo,
@@ -596,14 +596,38 @@ void repo_common_pathv(const struct repository *repo,
 	strbuf_cleanup_path(sb);
 }
 
-void strbuf_git_common_path(struct strbuf *sb,
-			    const struct repository *repo,
-			    const char *fmt, ...)
+char *repo_common_path(const struct repository *repo,
+		       const char *fmt, ...)
+{
+	struct strbuf sb = STRBUF_INIT;
+	va_list args;
+	va_start(args, fmt);
+	repo_common_pathv(repo, &sb, fmt, args);
+	va_end(args);
+	return strbuf_detach(&sb, NULL);
+}
+
+const char *repo_common_path_append(const struct repository *repo,
+				    struct strbuf *sb,
+				    const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	repo_common_pathv(repo, sb, fmt, args);
+	va_end(args);
+	return sb->buf;
+}
+
+const char *repo_common_path_replace(const struct repository *repo,
+				     struct strbuf *sb,
+				     const char *fmt, ...)
 {
 	va_list args;
+	strbuf_reset(sb);
 	va_start(args, fmt);
 	repo_common_pathv(repo, sb, fmt, args);
 	va_end(args);
+	return sb->buf;
 }
 
 static struct passwd *getpw_str(const char *username, size_t len)
diff --git a/path.h b/path.h
index 5f6c85e5f8..3c75495e1a 100644
--- a/path.h
+++ b/path.h
@@ -25,22 +25,20 @@ char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
- * The `strbuf_git_common_path` family of functions will construct a path into a
+ * The `repo_common_path` family of functions will construct a path into a
  * repository's common git directory, which is shared by all worktrees.
  */
-
-/*
- * Constructs a path into the common git directory of repository `repo` and
- * append it in the provided buffer `sb`.
- */
-void strbuf_git_common_path(struct strbuf *sb,
-			    const struct repository *repo,
-			    const char *fmt, ...)
+char *repo_common_path(const struct repository *repo,
+		       const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+const char *repo_common_path_append(const struct repository *repo,
+				    struct strbuf *sb,
+				    const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+const char *repo_common_path_replace(const struct repository *repo,
+				     struct strbuf *sb,
+				     const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
-void repo_common_pathv(const struct repository *repo,
-		       struct strbuf *buf,
-		       const char *fmt,
-		       va_list args);
 
 /*
  * The `repo_git_path` family of functions will construct a path into a repository's
@@ -243,6 +241,12 @@ struct strbuf *get_pathname(void);
 #  include "strbuf.h"
 #  include "repository.h"
 
+/* Internal implementation detail that should not be used. */
+void repo_common_pathv(const struct repository *repo,
+		       struct strbuf *buf,
+		       const char *fmt,
+		       va_list args);
+
 /*
  * Return a statically allocated path into the main repository's
  * (the_repository) common git directory.
diff --git a/refs.c b/refs.c
index f4094a326a..daf6a84205 100644
--- a/refs.c
+++ b/refs.c
@@ -2184,8 +2184,8 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 
 	if (wt->id) {
 		struct strbuf common_path = STRBUF_INIT;
-		strbuf_git_common_path(&common_path, wt->repo,
-				      "worktrees/%s", wt->id);
+		repo_common_path_append(wt->repo, &common_path,
+					"worktrees/%s", wt->id);
 		refs = ref_store_init(wt->repo, wt->repo->ref_storage_format,
 				      common_path.buf, REF_STORE_ALL_CAPS);
 		strbuf_release(&common_path);
diff --git a/setup.c b/setup.c
index 8a488f3e7c..74b5ba5325 100644
--- a/setup.c
+++ b/setup.c
@@ -792,7 +792,7 @@ int upgrade_repository_format(int target_version)
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	int ret;
 
-	strbuf_git_common_path(&sb, the_repository, "config");
+	repo_common_path_append(the_repository, &sb, "config");
 	read_repository_format(&repo_fmt, sb.buf);
 	strbuf_release(&sb);
 
@@ -2242,7 +2242,7 @@ void initialize_repository_version(int hash_algo,
 		struct strbuf config = STRBUF_INIT;
 		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
-		strbuf_git_common_path(&config, the_repository, "config");
+		repo_common_path_append(the_repository, &config, "config");
 		read_repository_format(&repo_fmt, config.buf);
 
 		if (repo_fmt.v1_only_extensions.nr)
diff --git a/worktree.c b/worktree.c
index 248bbb39d4..f8d6e7127f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -104,7 +104,7 @@ struct worktree *get_linked_worktree(const char *id,
 	if (!id)
 		die("Missing linked worktree name");
 
-	strbuf_git_common_path(&path, the_repository, "worktrees/%s/gitdir", id);
+	repo_common_path_append(the_repository, &path, "worktrees/%s/gitdir", id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
 		/* invalid gitdir file */
 		goto done;
@@ -731,8 +731,7 @@ static ssize_t infer_backlink(const char *gitfile, struct strbuf *inferred)
 	id++; /* advance past '/' to point at <id> */
 	if (!*id)
 		goto error;
-	strbuf_reset(inferred);
-	strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
+	repo_common_path_replace(the_repository, inferred, "worktrees/%s", id);
 	if (!is_directory(inferred->buf))
 		goto error;
 

-- 
2.48.1.538.gc4cfc42d60.dirty

