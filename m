Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403B224B11
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828688; cv=none; b=BfDT3Qath2vCkx1WF8jg551LIV43FRL+GHMA6XZpr5fvJm/TIjJsIrBceytKLiP3U0cJP/aPbvisCnot0rQ0YU1r46hPH/M7djmRRTaiqoeo9ORMqqtrl0hCgR0ggqUQtU3k2p82C4BN7apbq/oaH+O1gCXU3Cc4xE8kjCgKksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828688; c=relaxed/simple;
	bh=1FZfB0g+UOaKic+El1pzn2W8Tv+IBADKWJjqYr07AME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7CPTMtmft72yKWyJ+bFnL6kUOYgoZiHkL/Vh596NQO6spncezxiWmmgWryJTwTEzlYRLApKoPCTjua5OC7Si3OYxww2P1Ah6KEWi6YpEqOaJuc1FXka1BD2SkxRGxYTj+5UyGTKQtz8g3bP6mrgXTHCc/l/HFTeXMWgn7GTeC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fGARfbG9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WRqGQ3XL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fGARfbG9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WRqGQ3XL"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 859D713801FF
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 06 Feb 2025 02:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828685;
	 x=1738915085; bh=/cM5CG8zzSNhr2D6Xa1rJmjaeZik3d4yPTN7w7G6jSA=; b=
	fGARfbG945AteK8/zpkBLIHRwzBNxw2gFZNpgPhppfBAueqCKZ4CQTWQIirxPGZ6
	uygWZ4+YJUZM2dciDmrasaH/p3qSNPQ2SJUqCZtR3uJEZyew7v9+3G6CX4w0J1Ga
	5Ku/+0stIMoVn775npIk1YQd4o/dkI5wevyLQJ9ZEiZ+x7ZZRiPz9JvxJSpyMgBw
	9rFhBAJ36YRXC1kKNsBhVHP9ztumAJD2aWslnraX3aVXfbRX/6Bgpe/PHExlCSMQ
	9xNSzwa7VLPfMf6TH2IkADeQL7CbLSVvzB6cEfrjiIFuejZXBCJBn2QgGsshY/jY
	oS8iaWlK6fhOwb768X4tig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828685; x=
	1738915085; bh=/cM5CG8zzSNhr2D6Xa1rJmjaeZik3d4yPTN7w7G6jSA=; b=W
	RqGQ3XLxH9nveJByNDu2FoiDkuG4wFqH7RS5bTQRJG+40visiNweMsQCPWqDRmyS
	n+7fFV6e5eGjQ4VHFiNJe4tH8vFfMdH1EfZI7V2HniO/5FL5Fh6u6DdUyFBtqZOG
	YG6tDkUK3teqES4eDHgBVKfw37pKsRcpJR8hxrhJl7smhwskvWt0F7c7/QGeFBPX
	SsJNhMRpwoft/ojsjGrp6pkYXbgPU5TADwANXeVcVMJw4qgA5zfe0w+hxvsP/v1i
	AFkX9CIZ022CNC/9wSx2igBM0XKex3kttGVkX5svVTiVJBbuNv4pH7qTLwZJh9QW
	Q0fLl1C/56KfpSFR9eKdA==
X-ME-Sender: <xms:jWukZ8HNQ9vIS-WH_94aSTueEvlxN2dHmK1Ki2xoh75d7TReQ7K0vA>
    <xme:jWukZ1UdnJrUCuI4sHNlNh9KkQ8YJbiPKvgkIca7PL9FQJ6qUIjnj3trYvmr-a1m6
    YEBMlXttFxXyKg96A>
X-ME-Received: <xmr:jWukZ2Izj85Kdtbl6E7soKLu-kGGqY9ihJZHe5phj_M23MFu5Zla9nuL2HgYpbSO27eYuMOCCm_zlH-stuRu_rxaEMuQsVkSL1c7hXKQjYG5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhi
    dqqdetfeejfedqtdegucdlhedtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthej
    redtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhsse
    hpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleegjefhvdffhfffleeuudekteelleff
    ffdvtddtudetudehgfdvlefhffeffefgnecuffhomhgrihhnpehvudgpohhnlhihpggvgi
    htvghnshhiohhnshdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jWukZ-FYXjp783t-YIsgyanBh2tADelY0oijSunA6MiqipjBCHVRtA>
    <xmx:jWukZyXCteftk-kg1H0E90mvTMNWXohBkpMSNpseawNAYzZWfb83Aw>
    <xmx:jWukZxOE04WYZJk1ZN1nr9R0i2u49EDUrBqeR_AnsgQEm1k9CTJI7Q>
    <xmx:jWukZ53f2bHZuLq2rhpCufgMjygR1bStP1bg-j-l97RmwJuc6Rk4Jw>
    <xmx:jWukZ1c_OdJHKUFYLyLgzmaNzMw6kyftWGfHNP23vvOTWiPa6DOmSBqn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2bd02d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:57:57 +0100
Subject: [PATCH 01/16] path: refactor `repo_common_path()` family of
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-1-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
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

Refactor the commondir family of functions accordingly and adapt all
callers.

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

