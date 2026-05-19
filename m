Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E04779BD
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184368; cv=none; b=Rtk0dNY8bgQ0ZEmK9x8zU5vyYVgvfvTcpEHf19UYirtjfUHx7/A1VhyB0bhi/CAv7rXsnG4WwRnABptgh/Ka69j6a64Gd1Ca6FtLjx3Q55gEdN4u5ZfP4cmuqYuWLORa2L163ayzLZJqyeO0n1Ha4U5OMrHXPzEi89ZazKoSN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184368; c=relaxed/simple;
	bh=FX4Id6xG+9n8R8O4htcCkYIppAje2co3rGhTeyqiM/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRw3EgSONYOSrAw5YC56wVKegGAcv0k0Ct7vV+6bS9pOSocvqtNZ5DdreuN/eeGgeglWoWIXx6ceuLI9FwOP5YJbGoOpb9os/+YFqrvX+3FApx/RbwJkYDZ64fc5Saf1H8NwY8I3EQoBHbCuLghCOHpP1tTv8s6HX2KqyGFoxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GkznA3Ml; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=njfVmN8n; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GkznA3Ml";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="njfVmN8n"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 43B117A00EA;
	Tue, 19 May 2026 05:52:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 05:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184359;
	 x=1779270759; bh=Gqte4wDDQ1WxTPdHIQezyvyG30pppUJVHtFZwRGnB4Y=; b=
	GkznA3MlkIfoJs2C/HaClM4WnbVmleY+9yQwFHe/uWiBe0jOkxdbxmrlAUb3ASa4
	hFZnoC0PNp82vYDhwE5wofOBbPBm0yofb3WM2UiMd8K+vmTz6CTyZ8osKLvYnU+4
	3UYnRzq3HKFB56o25UEGX4h1tmoNNUszZ4M43nuVLnep0uuK9jiVT2lkz4mpZeB6
	KhbOM+Ku0az6yitWk5rYEVyJRbTSo5DoJVl2+b8+zIyQrZ4EmSNUfYMzeRFM2VLw
	M8iR1dkOIRzs0hY8xhEMKndXuW3uzcd/g+w9gBAqjiwkTbgmf+qzmCxvrqeOShSl
	SZWS01K/c3Vh66QyR7E1Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184359; x=
	1779270759; bh=Gqte4wDDQ1WxTPdHIQezyvyG30pppUJVHtFZwRGnB4Y=; b=n
	jfVmN8nHkEaLsFPzFzSLDJQgAo60AGhEvZJgH1YG+uEJQmudBvdHHMDHoEJSYMhj
	zqHy9NBNeciNZLWdMTfJbzLDPXmijivhzAze1ZSKVcixus7kfd95oxAzNe/zyFv7
	k8R0//G7jAwL9swXi0uQ6qbW+2ASZ6JjxjRxHwC6CZyLXv78J7tcUtpoXmk+aEz5
	509HvrJQDeTzf1SduT8h8XI3xkiQ9S/LSdLuaHN279X43EiB4xr7O4FOnY3E0hTG
	FuCKor8ZCvA3VQHY4/j9JPqlUcxlDz0SLODIlXxmM6bvfcFxOW4JfQd4UFhOCpJX
	3zWjL4lN2cZ/hYOkJeaJA==
X-ME-Sender: <xms:5zIMariqmgRUHShgpt0-EWSEUt4j-HpBz7BWIQDmP7W-1fAAo2z4nQ>
    <xme:5zIMau7mCPhJwOCHNBOp0B8892yiCtAgKaK3VFKQKf7IwGm7ZPsD5uPTSaQJbkeql
    DlTa5G8vr-1Ic_ZnzWK7LAdZWzyjKNRrot8c01gEuW8NsWia11Vdw>
X-ME-Received: <xmr:5zIMaja6voWHXoZl97a-vwX4d-volkuMvEhq1WgBAMxYEvy0x8MkKvkUOlQIChE4fYYeIuGk58A1_bAH_vq5USJ1g0V8yBiP9AKWIyJoOR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtrghtsehmrghloh
    hnrdguvghvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5zIMaj736lABrhaNW0dxElKJM3N4It5meHTpkjZqjFeumplkAfRhoQ>
    <xmx:5zIMamC2anSklJQFZXCBaR095_1H_ogs0AKKKd6ztn2VQGlFXitsNw>
    <xmx:5zIMapdAxtX1WFBRpi-iYy493CsofnFv3fJDaakOM0mo4mBHKtfTCQ>
    <xmx:5zIMalJy3vbRoHjh77payXBx-lsh5gvKvO9z-bSdcUGFvgp6vUah5w>
    <xmx:5zIMamICk9Y9KhN3eM9dFKLhTSSHcgFmJ2INnpbEQ76gbyzFJPi2geWF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9a541bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:14 +0200
Subject: [PATCH v3 10/18] setup: stop using `the_repository` in
 `set_git_work_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-10-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

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
index 09f6d97658..8844e3d481 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1116,7 +1116,7 @@ int cmd_clone(int argc,
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
index 832451fc61..d391aff8ab 100644
--- a/repository.h
+++ b/repository.h
@@ -114,6 +114,7 @@ struct repository {
 	 * A NULL value indicates that there is no working directory.
 	 */
 	char *worktree;
+	bool worktree_initialized;
 	bool worktree_config_is_bogus;
 
 	/*
diff --git a/setup.c b/setup.c
index 50324f8f37..796ac5792f 100644
--- a/setup.c
+++ b/setup.c
@@ -1152,7 +1152,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
 	if (work_tree_env)
-		set_git_work_tree(work_tree_env);
+		set_git_work_tree(repo, work_tree_env);
 	else if (is_bare_repository_cfg > 0) {
 		if (git_work_tree_cfg) {
 			/* #22.2, #30 */
@@ -1167,7 +1167,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	}
 	else if (git_work_tree_cfg) { /* #6, #14 */
 		if (is_absolute_path(git_work_tree_cfg))
-			set_git_work_tree(git_work_tree_cfg);
+			set_git_work_tree(repo, git_work_tree_cfg);
 		else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
@@ -1177,7 +1177,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 			core_worktree = xgetcwd();
 			if (chdir(cwd->buf))
 				die_errno(_("cannot come back to cwd"));
-			set_git_work_tree(core_worktree);
+			set_git_work_tree(repo, core_worktree);
 			free(core_worktree);
 		}
 	}
@@ -1188,7 +1188,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		return NULL;
 	}
 	else /* #2, #10 */
-		set_git_work_tree(".");
+		set_git_work_tree(repo, ".");
 
 	/* set_git_work_tree() must have been called by now */
 	worktree = repo_get_work_tree(repo);
@@ -1248,7 +1248,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	}
 
 	/* #0, #1, #5, #8, #9, #12, #13 */
-	set_git_work_tree(".");
+	set_git_work_tree(repo, ".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
 	if (offset >= cwd->len)
@@ -1839,29 +1839,27 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
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
+	repo->worktree_initialized = true;
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
2.54.0.771.g3ed373ac14.dirty

