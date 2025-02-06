Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C192253FC
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828694; cv=none; b=BrBEZBiYJjcGyi+8Eccg7R3mzCDrS8aApGk7x77E6/tVJEPqKvbRFQmzDUn36oKwubJ06eANzo4oiuArEkfNwW70qnZoEcwzuumobSHagV//GTzt1U1HHkh18KHqpep7PmCOiVb0FBNWe6A44yQjHpf5JnfkpHFoWfLBqA6Bvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828694; c=relaxed/simple;
	bh=ViZMc/pRs/fpT6l9pjTymHrUO7Id/gL6B10VRnTpq3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTvxOio5JfDFFZGNAvotYCkfF1S6QLoZ81rIyE2CLBGw/P7gXA/haEC/PFDU+4DBO1Pz6lI4vaGN2pbpFKvF9dhM3a0qdsHqEflBjn2jpvTDr/7lafuh/rNnNvKooxv5Vtqy08vmPxumHmVMj0b9e759J68OVHqPWy/zUZ6pGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hPBwW2uu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oPbTi+C3; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hPBwW2uu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPbTi+C3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B74113801FF
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Feb 2025 02:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828691;
	 x=1738915091; bh=hfVpV8iNxRWGZfUFIsEOv0fI9sr0r7amRtXuChrpOYg=; b=
	hPBwW2uudeCMZ7dcsK0pe9LJUwtAxp5TuFUIPG4ND5ouzb+U6bPIiobHbGwIWobR
	ZlkkxCi67FVfZD+liXIjRVxurNUHi/08heZfv1gdLsh85XYuJPDQG5QB5xVpjIdv
	nkmUBFMZlL8HvX9Wb5M1qo/4RSl+JqUs9PON/SriJKXAGc6YFFD8T1ivsp2E28ta
	+gxOH8xIXWZiTr6Tkx0K478olWS8y9zbLfXdZJas5JRHPyPa04oFRWTpCQXBICKj
	3tTo/ZiBXLS9IBh1A08PxajNRjorhHu9d2yZDX/goZGCbhyOObStlHr84h8GyR7s
	g8TMwh4E1MXqiehVPLDDEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828691; x=
	1738915091; bh=hfVpV8iNxRWGZfUFIsEOv0fI9sr0r7amRtXuChrpOYg=; b=o
	PbTi+C3otOfqT/FG2RQoAzEPG71c78U1bZwgzeHPj2ofJG/vvh9BXOTB90959Q+y
	eJy96E2JqhJ2cXNm8OB8saYsajVRR9WNkxCaKOIqs2YFM39QUL2rPv1EohtnAY5y
	6IWPa0pODuZT1SdwPzVZQjStGjGkz7y8EQms6wlmGCGZPEdXF5wiUcZAw56Uf4Rl
	GfsJGdJOSiH34WV6nmdqX4OiZg94yFdplpN+DqWTPhDvMsCO2CVI5Tuir9OyYzJY
	XegGgZQ+LiK8jmoRk6xzyBqfp14URnH1f11U3snCLAlzOoGQjqDHgVnFk7QpYjiq
	Fqsq/hptOo0QAy7I7Eo1w==
X-ME-Sender: <xms:k2ukZ-R9R6cdb0t7bpxkCpr-c19c4nQ3wa4kgbfyxS4Zk-VfZ1QQhA>
    <xme:k2ukZzyOsYKbY2w-fBlbf2pO2JnBrCbaIQLVlZyIzhpMgc8AD8NbWHikZ6jhuuDrB
    NcARgcRLU4DEuvf3A>
X-ME-Received: <xmr:k2ukZ73PE0rWd3znPqdLUYZuM5qefZ8bJ4zKr27WT64KsOzJxIarchZp3-e8H8eHUfrGqHNB1k5EknnPGgHAFtvnNO8jC9zo7Jq8CyVpD65P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k2ukZ6CtMgQi1JMgG2MyjXDp7PidZrGzNukMmD2IGplBWjL-x5LQ8g>
    <xmx:k2ukZ3hxVV3nhPqgytTzFjpUtQxm4CRvnJ03Mg1xJP1IfPbQ1eBCvg>
    <xmx:k2ukZ2q82ayYvov90dHsA3O8wQpP6nrGzEMyPLEPwsmgc9cF0z2A5w>
    <xmx:k2ukZ6gGUkg3cb9ZwZbkJRmjRLPAriQ2g5OfSsCuYYufym9BCnDtOA>
    <xmx:k2ukZ_bM1Ze-q7Vi4nSO4uF00QAbUIXiR9RGSH4FMk1yetcHLp00UHGH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34b0ed44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:04 +0100
Subject: [PATCH 08/16] path: drop `git_path_buf()` in favor of
 `repo_git_path_replace()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-8-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Remove `git_path_buf()` in favor of `repo_git_path_replace()`. The
latter does essentially the same, with the only exception that it does
not rely on `the_repository` but takes the repo as separate parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/worktree.c       |  2 +-
 compat/precompose_utf8.c |  6 +++---
 notes-merge.c            |  4 ++--
 object-file.c            |  4 ++--
 path.h                   | 16 ----------------
 setup.c                  | 33 ++++++++++++++++-----------------
 6 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c84e6aa2cb..7959b10d26 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -457,7 +457,7 @@ static int add_worktree(const char *path, const char *refname,
 		BUG("How come '%s' becomes empty after sanitization?", sb.buf);
 	strbuf_reset(&sb);
 	name = sb_name.buf;
-	git_path_buf(&sb_repo, "worktrees/%s", name);
+	repo_git_path_replace(the_repository, &sb_repo, "worktrees/%s", name);
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index f7cc7b3be5..12e38e0ea3 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -50,15 +50,15 @@ void probe_utf8_pathname_composition(void)
 	int output_fd;
 	if (precomposed_unicode != -1)
 		return; /* We found it defined in the global config, respect it */
-	git_path_buf(&path, "%s", auml_nfc);
+	repo_git_path_replace(the_repository, &path, "%s", auml_nfc);
 	output_fd = open(path.buf, O_CREAT|O_EXCL|O_RDWR, 0600);
 	if (output_fd >= 0) {
 		close(output_fd);
-		git_path_buf(&path, "%s", auml_nfd);
+		repo_git_path_replace(the_repository, &path, "%s", auml_nfd);
 		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
 		git_config_set("core.precomposeunicode",
 			       precomposed_unicode ? "true" : "false");
-		git_path_buf(&path, "%s", auml_nfc);
+		repo_git_path_replace(the_repository, &path, "%s", auml_nfc);
 		if (unlink(path.buf))
 			die_errno(_("failed to unlink '%s'"), path.buf);
 	}
diff --git a/notes-merge.c b/notes-merge.c
index c997c0c1e3..8c22a171c1 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -695,7 +695,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 	const char *msg = strstr(buffer, "\n\n");
 	int baselen;
 
-	git_path_buf(&path, NOTES_MERGE_WORKTREE);
+	repo_git_path_replace(the_repository, &path, NOTES_MERGE_WORKTREE);
 	if (o->verbosity >= 3)
 		printf("Committing notes in notes merge worktree at %s\n",
 			path.buf);
@@ -757,7 +757,7 @@ int notes_merge_abort(struct notes_merge_options *o)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 
-	git_path_buf(&buf, NOTES_MERGE_WORKTREE);
+	repo_git_path_replace(the_repository, &buf, NOTES_MERGE_WORKTREE);
 	if (o->verbosity >= 3)
 		printf("Removing notes merge worktree at %s/*\n", buf.buf);
 	ret = remove_dir_recursively(&buf, REMOVE_DIR_KEEP_TOPLEVEL);
diff --git a/object-file.c b/object-file.c
index 335cc2a5da..dc9fcaf3e9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -476,14 +476,14 @@ int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 	 * restrictive except to remove write permission.
 	 */
 	int mode = 0444;
-	git_path_buf(temp_filename, "objects/%s", pattern);
+	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
 	fd = git_mkstemp_mode(temp_filename->buf, mode);
 	if (0 <= fd)
 		return fd;
 
 	/* slow path */
 	/* some mkstemp implementations erase temp_filename on failure */
-	git_path_buf(temp_filename, "objects/%s", pattern);
+	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
 	safe_create_leading_directories(temp_filename->buf);
 	return xmkstemp_mode(temp_filename->buf, mode);
 }
diff --git a/path.h b/path.h
index df16dd23bd..904eeac068 100644
--- a/path.h
+++ b/path.h
@@ -256,22 +256,6 @@ static inline const char *git_common_path(const char *fmt, ...)
 	return pathname->buf;
 }
 
-/*
- * Construct a path into the main repository's (the_repository) git directory
- * and place it in the provided buffer `buf`, the contents of the buffer will
- * be overridden.
- */
-__attribute__((format (printf, 2, 3)))
-static inline char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
-{
-	va_list args;
-	strbuf_reset(buf);
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, buf, fmt, args);
-	va_end(args);
-	return buf->buf;
-}
-
 /*
  * Return a statically allocated path into the main repository's
  * (the_repository) git directory.
diff --git a/setup.c b/setup.c
index 74b5ba5325..30889386f7 100644
--- a/setup.c
+++ b/setup.c
@@ -2264,7 +2264,7 @@ static int is_reinit(void)
 	char junk[2];
 	int ret;
 
-	git_path_buf(&buf, "HEAD");
+	repo_git_path_replace(the_repository, &buf, "HEAD");
 	ret = !access(buf.buf, R_OK) || readlink(buf.buf, junk, sizeof(junk) - 1) != -1;
 	strbuf_release(&buf);
 	return ret;
@@ -2316,8 +2316,7 @@ static int create_default_files(const char *template_path,
 				int init_shared_repository)
 {
 	struct stat st1;
-	struct strbuf buf = STRBUF_INIT;
-	char *path;
+	struct strbuf path = STRBUF_INIT;
 	int reinit;
 	int filemode;
 	const char *work_tree = repo_get_work_tree(the_repository);
@@ -2358,14 +2357,14 @@ static int create_default_files(const char *template_path,
 	initialize_repository_version(fmt->hash_algo, fmt->ref_storage_format, reinit);
 
 	/* Check filemode trustability */
-	path = git_path_buf(&buf, "config");
+	repo_git_path_replace(the_repository, &path, "config");
 	filemode = TEST_FILEMODE;
-	if (TEST_FILEMODE && !lstat(path, &st1)) {
+	if (TEST_FILEMODE && !lstat(path.buf, &st1)) {
 		struct stat st2;
-		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
-				!lstat(path, &st2) &&
+		filemode = (!chmod(path.buf, st1.st_mode ^ S_IXUSR) &&
+				!lstat(path.buf, &st2) &&
 				st1.st_mode != st2.st_mode &&
-				!chmod(path, st1.st_mode));
+				!chmod(path.buf, st1.st_mode));
 		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
 			filemode = 0;
 	}
@@ -2384,24 +2383,24 @@ static int create_default_files(const char *template_path,
 
 	if (!reinit) {
 		/* Check if symlink is supported in the work tree */
-		path = git_path_buf(&buf, "tXXXXXX");
-		if (!close(xmkstemp(path)) &&
-		    !unlink(path) &&
-		    !symlink("testing", path) &&
-		    !lstat(path, &st1) &&
+		repo_git_path_replace(the_repository, &path, "tXXXXXX");
+		if (!close(xmkstemp(path.buf)) &&
+		    !unlink(path.buf) &&
+		    !symlink("testing", path.buf) &&
+		    !lstat(path.buf, &st1) &&
 		    S_ISLNK(st1.st_mode))
-			unlink(path); /* good */
+			unlink(path.buf); /* good */
 		else
 			git_config_set("core.symlinks", "false");
 
 		/* Check if the filesystem is case-insensitive */
-		path = git_path_buf(&buf, "CoNfIg");
-		if (!access(path, F_OK))
+		repo_git_path_replace(the_repository, &path, "CoNfIg");
+		if (!access(path.buf, F_OK))
 			git_config_set("core.ignorecase", "true");
 		probe_utf8_pathname_composition();
 	}
 
-	strbuf_release(&buf);
+	strbuf_release(&path);
 	return reinit;
 }
 

-- 
2.48.1.538.gc4cfc42d60.dirty

