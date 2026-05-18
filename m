Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E83E6DCF
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096694; cv=none; b=HEwtMnVQD9DXrcEYnPtz+NH6mUde0JdKezIY5ubyfQXwDXkph6eKKdfdLiLmkQ7dSDbIKt2lG1BIXrO2p0z4ZDic9+qbvNS9mwoxF11ZAfu1OOgWRS8Hm/uaFr/4Nwl42xe9IUcVH45gsIrFAe9d7aSgCXCbHePyBxy8xQ0AvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096694; c=relaxed/simple;
	bh=FX4Id6xG+9n8R8O4htcCkYIppAje2co3rGhTeyqiM/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sUztpkgku1Rfq7EaKlBb4ad6iGPw+SVB//figkZ4CRD5QmBr6/qvT0jcGuhGrhG4MW0P/SCr8P94yhSgeRvDwBlgFwp/h4cag2HRbHuA7MTQIZRJK8qGh8T5z/4QbewvfDbps8VER8qTamn9W6Ltl6Fo0/XCT4LWZQeDC0FApUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OJ1UcKPN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AeYCED0O; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJ1UcKPN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AeYCED0O"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 46C611D00013;
	Mon, 18 May 2026 05:31:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 18 May 2026 05:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096692;
	 x=1779183092; bh=Gqte4wDDQ1WxTPdHIQezyvyG30pppUJVHtFZwRGnB4Y=; b=
	OJ1UcKPNmSYTSXa4VeyjzqZCuS4KnRO6Aw8Eaq3T3sO2CI8gKTbfFxTyluOBv8mR
	Si8wRNm5DERH5HmV2HYblutc4aQpdJRQ8hKd3ERwKfxFeXP67DyfbVJEzG9pCS1X
	83DG7hkaLutLpolJOtbI5u0WSF+htIIdSFLCa+8kE0j6y6fuJ/ryX8SLnRA4UP1w
	WbK0cWkWNDU8bc8LjViW3cJdRg+fVY63HY7UwOCjXecDRWDbItF0eV07QZR/vSBJ
	/+nKfSVbp3IECFVROzDAG2McJjdxIwQrS9Z/DmS0uatVZKT21zALFomcvcdl0z3s
	G2R3+Kh6Q8ZuiNC/FCFjjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096692; x=
	1779183092; bh=Gqte4wDDQ1WxTPdHIQezyvyG30pppUJVHtFZwRGnB4Y=; b=A
	eYCED0OFI0MpQpGBfZ1WeaeXNwOpF8R1et1F+bw8tWIsSUEnG5cEoWPOsQ3vw/V2
	MrmYLRyuzM7M2V9FW4AhNAko+Y/m/WbNQLImo/f1Ofh4p/lmqndUiJsWuR4jECs3
	Itl0ywZCqa0uIVFrq76NBJ7nUwLCUJ7weIhOocl0sYdEe7h0Ljpnvk4yqEg500bo
	xI+1M+/ZVGGhOEFfCqCBjra92Qz8jrG3yo0qLK4bLzjvBvXKydmumAi1+FljxOne
	GVBzPS/vtUGUVM5vCH+HJP0BT3hm7/UiaUKnA9+Up1HPZOIIQN3jqecwqOHLt8Gb
	m2GyADQXVHbUnw6WosT4A==
X-ME-Sender: <xms:dNwKasJpYLdcu6R3fv-1fNaIRHYEhUBDpS2mnQ2XSRnrv6bZkno2kA>
    <xme:dNwKajA6FoknApXA8kA4XsxKYpdGhtwfuo_KBeaezLbd_4SoHOJWvvcEtCmf4bD26
    fOKxl_PMOpkOYehIC40W76MqCNCeZDSgd7MyTVwYNFRAKP_Ex53BQ>
X-ME-Received: <xmr:dNwKalB5ED7n0z-KXnFzmEmB0UPc3xp1W840ZL8lxp37NEIuTbqHWKwo5QHXkOQMs_CfgbjBW1E9xATAcQ4E5YyDlIttNwmy98CvZy-hWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dNwKalCxYvUlDPLeNAflgb7tZHlCkflx2vbyk2KuUXN4JbqBfPacdQ>
    <xmx:dNwKagocKTHZHl7RNmcBf7ZV7iVzRpH76EBDSAMNiFGI_QIWZtA8Lg>
    <xmx:dNwKavlF5mZYtounUQntWPIJpRucDRmcCvGeyQH-WmUIojCJiQJPvQ>
    <xmx:dNwKagzJrngm-adV-km3yhDRZ9uueyBN3rGmMlxZNmspdoDjaZ-mUw>
    <xmx:dNwKaiUWyd1Dlehh7cLiJr4JSa7fjSlURtBgCso37vFfu0N0PtGqZ-fD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d16d295 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:31:01 +0200
Subject: [PATCH v2 10/18] setup: stop using `the_repository` in
 `set_git_work_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-10-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
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

