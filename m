Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5E2D7D3A
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673398; cv=none; b=PFsANXdynqr2VVBc0W8s8pJwckxoX10cBMWCNb65SyuBDwictzkAAuuZ0WbMWEu/gdzSRX/IZzcW68aaQUV95ZtDAWMhgAAi2woZwKMWy2pZdjrR2FXHUR1/ynVIQVMvDyAl7c3DDkIBeKAasM2+ipvOhtVTfvh5YROu51XEM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673398; c=relaxed/simple;
	bh=dRc6RrO7YljffAN88hpVG0O80S28HBhG2hPlX3qIwOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DvTV/lbIynqp7yjnlEgAF6kKX66gHbc7bGsbmsHICaUO0YhjQFwxeGzHle8JpT5H8+pvz0qKrUApKN/N1bUhGNrVe3jBKZ2v0+K/+Unw+jzzberx1h3cAldedUH7+K3rmkOG+s95IpJW3KQZvnZVmrfg3nlVWI8i4FcxCKKdnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HHX9wbTG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCgAzydk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HHX9wbTG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCgAzydk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 135F11400113;
	Mon, 20 Apr 2026 04:23:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 04:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673396;
	 x=1776759796; bh=LFKsLN8kNvI1nDVvOhDk6fPHa1rj2EcJcuNWfoPBN3Y=; b=
	HHX9wbTGRaG1iquj6kYVKQ9cQAJVba3Xwcy86MnphRv8QgsZf5iz3AbM9yj/ILP+
	aM+MP+0bQOulYbfKMZCVwd6ThfPnfaFyVbiwWb/f8FDiuGEvwpkvMt59VtZdeBXU
	0ip8nb+e3kX2YmxJ9t3xIukt+E01lK3lIvBqI+YW//UpQfodWoSD276JZL/53H9d
	SyPJodEViTLVrwy9HbmMuv8fCvMkJQ7aa7/nz0hpfMRHIPT0QP7SOTDyKnk4Zeva
	iQH3F2rm0WqMSaCnUx+XUGpeHWDQPzxiZIimNJFavRLsNLPlXVFrzTGffLndY/Ng
	lS3elABzVODfa9E7bOqFrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673396; x=
	1776759796; bh=LFKsLN8kNvI1nDVvOhDk6fPHa1rj2EcJcuNWfoPBN3Y=; b=i
	CgAzydkvW3rq0oDlPplIz8ynMLmcQ+rFSyCugYgYEmkvBuIneJkUx5U+Fqv1mbwx
	X2hfGOqvmeSQ5c97U05DOgrxUhnSapCkBSEGWjnKiHxkI5nwJSkH8QwV5p83q8nb
	xNW2/svj2z3gSj7ntWosDTMx8iNdaDTnxgo945bUUMMrAyIxFuRYpeB/vr4cpeab
	RPYYbIvMHVP11rp+CxqpWYmY2vNAmMZezfYSoH6heyoD0TVzoeKu09Wrf0KBYasi
	wMLVhAqMS98O2NAIfgxWFgSeqnAbsX8l2jrIAQZK3dWGDFrGD2PvX3QaeiePrmW5
	TBTuwSlhAh2p5OwW3hUFA==
X-ME-Sender: <xms:c-LlaREc1sfTw1J4qpC57heQS9wXsWRgRB0NjP9lhOzPbhuXyUE9ug>
    <xme:c-LladX5O3Tv0nGLi3Ypji746Ap3y8ousW4Y0qMABZ8JIJisvfh2jMevH-cppUnh_
    P4O3yhptsHuUIY-KLZn03xg-6OBFrxQb3jr1k2ojzrMpw17D1yROg>
X-ME-Received: <xmr:c-LlaYLLRNTP2zg93r8Hhj2KONC8habWvYmnO9BZnNppqDjaq1hla5DKaQFGPnP5qZkPUZyOxrfLrRAfU0uNqfJPGeGWNkJ_Wx8OO3T7uS26>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:c-LlaV-AGWGS1ArVjhodHzKzL-mo5VKhumvB-0g9JtMOA4KTbbJlKA>
    <xmx:dOLlaTI4Bqi52et_JO6US-RKmUkfj9qq8AtZ7GvZl3J-LUY7qzgv9Q>
    <xmx:dOLlaSkn0ZnVygnhGT6tWoTCCMWEBLc1ouLwvACIli6CXAkwWTvlCw>
    <xmx:dOLlafOV85aBKOt1psjpZe_lfLVWgVFz1iQjyrXwUeWohOQkJtmNqw>
    <xmx:dOLlaek6aohJi12EXdf-uqaYOxmYm_72xMuUIYD3hjEFczpOSJfUI1_D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6082771 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:40 +0200
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
Message-Id: <20260420-pks-setup-wo-the-repository-v1-10-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

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
index 80dd94b261..fa9bb39cdf 100644
--- a/setup.c
+++ b/setup.c
@@ -1143,7 +1143,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
 	if (work_tree_env)
-		set_git_work_tree(work_tree_env);
+		set_git_work_tree(repo, work_tree_env);
 	else if (is_bare_repository_cfg > 0) {
 		if (git_work_tree_cfg) {
 			/* #22.2, #30 */
@@ -1158,7 +1158,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	}
 	else if (git_work_tree_cfg) { /* #6, #14 */
 		if (is_absolute_path(git_work_tree_cfg))
-			set_git_work_tree(git_work_tree_cfg);
+			set_git_work_tree(repo, git_work_tree_cfg);
 		else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
@@ -1168,7 +1168,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 			core_worktree = xgetcwd();
 			if (chdir(cwd->buf))
 				die_errno(_("cannot come back to cwd"));
-			set_git_work_tree(core_worktree);
+			set_git_work_tree(repo, core_worktree);
 			free(core_worktree);
 		}
 	}
@@ -1179,7 +1179,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		return NULL;
 	}
 	else /* #2, #10 */
-		set_git_work_tree(".");
+		set_git_work_tree(repo, ".");
 
 	/* set_git_work_tree() must have been called by now */
 	worktree = repo_get_work_tree(repo);
@@ -1239,7 +1239,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	}
 
 	/* #0, #1, #5, #8, #9, #12, #13 */
-	set_git_work_tree(".");
+	set_git_work_tree(repo, ".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
 	if (offset >= cwd->len)
@@ -1830,29 +1830,27 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
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
2.54.0.rc2.529.gd9106f7525.dirty

