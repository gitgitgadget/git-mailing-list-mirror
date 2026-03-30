Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF43D4123
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876693; cv=none; b=LH6MDZcjMLvC2uF4jHwHY17RWGqiHXD2lWTto/HQlGOUnbBMpYowdKon7HBwA2LxdCN4KP2JbVwltO6ls89V0czp7t56mE9MO8Qh21cJyXG4KFNyzB5v5LtCWW5iN1LsTP0Z+tlsg1NV69CjtpvdOymNJ1xmaIgfsIWCNXS900w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876693; c=relaxed/simple;
	bh=zfSlmPQaYGsI1JYuBgpkn8TNVhT/JZhNjPsn9rtS04g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6EfL4gYgRLQHBYQKE3dY8mMoo/Asvi/4tlF6KuZ9iR3AY2uikws3M995sfyiQCTBu+0xt9yjN2btkWGvmuzpVwkslCvvy8qqaEf3dO/gFWQAaKgGZ1cnIklW9yhDFaKce3+d+JvPdhF0kqE9u0yPb7myUvJNWAAZn9ggU9KZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=khC57B3n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vBNwY3/6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="khC57B3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vBNwY3/6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BAB1D1D00026
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 09:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876691;
	 x=1774963091; bh=T56MLqkAdyubhM8Tn3M8vHjcaP8NF4/k/fz0D2EA3G4=; b=
	khC57B3nwg9hULltRrn+5Iu60IKAdqXdJGM6CHxHi8+Yo0sfatQ8Z1iqv3mX/E0L
	AQfklUk8WpujZlg1d0NwQsF3BKVV/BP7ldZkOGKJiwimMxG4m7XuIFFkj41Gf2no
	do7HmZJWlm2Ymk8Dp0WZmawLgsZgDWzKCTx8+G5AxGrYU2ya+0xZT+NM1YwIx81J
	KhJrgBhkUI9mdhO4eNiW99o/CWwc1IvR6sv6podwkcP9wpHC5wEmmygobBkGgGVX
	qHmR4mtCg53Nunhx3QRyLJ6OyQ5H9GHept3Tu0ABt6ISdIZxfK/HTFSqdurIjbQY
	aZxF/uXFM4UFSUWFkSkD7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876691; x=
	1774963091; bh=T56MLqkAdyubhM8Tn3M8vHjcaP8NF4/k/fz0D2EA3G4=; b=v
	BNwY3/6siMSHTtM/aixpYRRv8HSWCr7kXiK4zjrzeC7aAXu+Oj/bfn6S5rutfJoz
	jhLWm1nj2nwamVj6y1ETiGiaxLXLES0Cn8e4UNp/Y/hlBCSwmeo9DF+kUzxEKu5N
	RQhrTjUc4Uh7DDKPQU2Di/TaA9//RagWVgKyffx9cGSPbCgZtTxZBJ8RtOYghSGF
	uFGV5cCh8Do2U4Sg5Uqrrcd9Lwki1BRAtXGlbaLDPfYq5CKzb+bGfV+u6UGrwS/x
	zYhPHzr/fMKSApF2ukPSk2XK4GL0hjU3eMAVO5BFs8NCsx4/5waW7X3R43h6rdux
	lyxlK+qEYxD1nY32WldOg==
X-ME-Sender: <xms:E3jKaYU0vtS12dMLgwH8mH8S1bbrajWvBR4FfI0zhM_Ge_XTWMLkuA>
    <xme:E3jKaTjvZ9-PCFburL1nrhEwJFHysTgprAGScwZsWuQAQtVfToqCh3y3U8CEDz43v
    1U3IWSCdg96PYB2rnEpyLj4d5oRoP5UhKnoJ2BxvwReamvnM5J1zg>
X-ME-Received: <xmr:E3jKaSCW7xOhi5ry9ICmmnLzdiD00EknpC0eA7KCi-DXnP3OS1fy-lT_lQqPEUXUKe8fGIEiKI9C6EkDHpe4ORgcbQ1aDhvSXC2rqJA6k6tIyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:E3jKaccs2UuWSSwOz5SyFqgaOoXgApJEAVDfyRlOevvWP9PdCiMPPA>
    <xmx:E3jKaSfQS-Rii8ElTrJWqos7AJJOi3sPIsQNPamAyOXpdUy_5LPffg>
    <xmx:E3jKaYiX6ciFc2r2YaWKdGyVAhIYNPQMkkB_wwY7u_2ngb3VOdzZbA>
    <xmx:E3jKaWS--BlErQDT9IXHUDg2JwUpDt9hDy2u3_5Fm08B4edfV04xQg>
    <xmx:E3jKafk7nkBPcPrkaPr6C74q2X6vukTzgdGTIIMkZ0_L77xrh0zoaCxV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 093047ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:32 +0200
Subject: [PATCH 10/18] setup: stop using `the_repository` in
 `set_git_work_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-10-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `set_git_work_tree()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Similar as with the preceding commit, we track whether the worktree has
been initialized already via a global variable so that we can die in
case the repository is re-initialized with a different worktree path.
Store this info in the `struct repository` instead so that we correctly
handle this per repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   |  2 +-
 builtin/init-db.c |  6 +++---
 repository.h      |  1 +
 setup.c           | 24 +++++++++++-------------
 setup.h           |  2 +-
 5 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 91b9a105a4..16cd7b029b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1114,7 +1114,7 @@ int cmd_clone(int argc,
 			die_errno(_("could not create work tree dir '%s'"),
 				  work_tree);
 		junk_work_tree = work_tree;
-		set_git_work_tree(work_tree);
+		set_git_work_tree(the_repository, work_tree);
 	}
 
 	if (real_git_dir) {
diff --git a/builtin/init-db.c b/builtin/init-db.c
index bb853e69f5..e626b0d8b7 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -237,9 +237,9 @@ int cmd_init_db(int argc,
 		if (!git_work_tree_cfg)
 			git_work_tree_cfg = xgetcwd();
 		if (work_tree)
-			set_git_work_tree(work_tree);
+			set_git_work_tree(the_repository, work_tree);
 		else
-			set_git_work_tree(git_work_tree_cfg);
+			set_git_work_tree(the_repository, git_work_tree_cfg);
 		if (access(repo_get_work_tree(the_repository), X_OK))
 			die_errno (_("Cannot access work tree '%s'"),
 				   repo_get_work_tree(the_repository));
@@ -248,7 +248,7 @@ int cmd_init_db(int argc,
 		if (real_git_dir)
 			die(_("--separate-git-dir incompatible with bare repository"));
 		if (work_tree)
-			set_git_work_tree(work_tree);
+			set_git_work_tree(the_repository, work_tree);
 	}
 
 	flags |= INIT_DB_EXIST_OK;
diff --git a/repository.h b/repository.h
index abeef3129e..7ae3d34484 100644
--- a/repository.h
+++ b/repository.h
@@ -113,6 +113,7 @@ struct repository {
 	 * A NULL value indicates that there is no working directory.
 	 */
 	char *worktree;
+	bool worktree_initialized;
 	bool worktree_config_is_bogus;
 
 	/*
diff --git a/setup.c b/setup.c
index 64a030c6cd..2a917e3a5b 100644
--- a/setup.c
+++ b/setup.c
@@ -1149,7 +1149,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
 	if (work_tree_env)
-		set_git_work_tree(work_tree_env);
+		set_git_work_tree(repo, work_tree_env);
 	else if (is_bare_repository_cfg > 0) {
 		if (git_work_tree_cfg) {
 			/* #22.2, #30 */
@@ -1164,7 +1164,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	}
 	else if (git_work_tree_cfg) { /* #6, #14 */
 		if (is_absolute_path(git_work_tree_cfg))
-			set_git_work_tree(git_work_tree_cfg);
+			set_git_work_tree(repo, git_work_tree_cfg);
 		else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
@@ -1174,7 +1174,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 			core_worktree = xgetcwd();
 			if (chdir(cwd->buf))
 				die_errno(_("cannot come back to cwd"));
-			set_git_work_tree(core_worktree);
+			set_git_work_tree(repo, core_worktree);
 			free(core_worktree);
 		}
 	}
@@ -1185,7 +1185,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		return NULL;
 	}
 	else /* #2, #10 */
-		set_git_work_tree(".");
+		set_git_work_tree(repo, ".");
 
 	/* set_git_work_tree() must have been called by now */
 	worktree = repo_get_work_tree(repo);
@@ -1245,7 +1245,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	}
 
 	/* #0, #1, #5, #8, #9, #12, #13 */
-	set_git_work_tree(".");
+	set_git_work_tree(repo, ".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
 	if (offset >= cwd->len)
@@ -1836,29 +1836,27 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	return NULL;
 }
 
-static int git_work_tree_initialized;
-
 /*
  * Note.  This works only before you used a work tree.  This was added
  * primarily to support git-clone to work in a new repository it just
  * created, and is not meant to flip between different work trees.
  */
-void set_git_work_tree(const char *new_work_tree)
+void set_git_work_tree(struct repository *repo, const char *new_work_tree)
 {
-	if (git_work_tree_initialized) {
+	if (repo->worktree_initialized) {
 		struct strbuf realpath = STRBUF_INIT;
 
 		strbuf_realpath(&realpath, new_work_tree, 1);
 		new_work_tree = realpath.buf;
-		if (strcmp(new_work_tree, the_repository->worktree))
+		if (strcmp(new_work_tree, repo->worktree))
 			die("internal error: work tree has already been set\n"
 			    "Current worktree: %s\nNew worktree: %s",
-			    the_repository->worktree, new_work_tree);
+			    repo->worktree, new_work_tree);
 		strbuf_release(&realpath);
 		return;
 	}
-	git_work_tree_initialized = 1;
-	repo_set_worktree(the_repository, new_work_tree);
+	repo->worktree_initialized = 1;
+	repo_set_worktree(repo, new_work_tree);
 }
 
 const char *setup_git_directory_gently(int *nongit_ok)
diff --git a/setup.h b/setup.h
index 8fed365637..1a37089fa0 100644
--- a/setup.h
+++ b/setup.h
@@ -96,7 +96,7 @@ static inline int discover_git_directory(struct strbuf *commondir,
 	return 0;
 }
 
-void set_git_work_tree(const char *tree);
+void set_git_work_tree(struct repository *repo, const char *tree);
 
 /* Flags that can be passed to `enter_repo()`. */
 enum {

-- 
2.53.0.1185.g05d4b7b318.dirty

