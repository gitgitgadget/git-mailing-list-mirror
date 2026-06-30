Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6204071D1
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820107; cv=none; b=bNfBagMcjrG6sQSdUOqUyodRZWpNSryESCU3zKRuQFlYreZ6TGi1XpXRI85lT5bvE85qBMCfE0sJUnyLIh3Q6mGXm/3+REPWzjG9o7sTlDPvoeTyLBJgLo8FbErjssHnoEhu5kiWEKbStkb9/8ZDiEusYxDFUYOzbWL1cJq4X98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820107; c=relaxed/simple;
	bh=FT7HxEjSjea0pyCAgCWJahaV7Gf/XfJp+MsVXrfsA6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsPOzc2B6AjXkLq+QXdY6s+oNdxP4RQvFek+BuRWwlw1JX7XkN3hHj+yd+/KPdaWkUk1MttmA7RTuEnbkEv7HPykRrA6VzxchhP95FspHTJI6+Tc/WFgqAFIvju421t85xisI8Vl3ruJe/W3YFryYha/fYJ6QxOmCgzbpMcOIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qdTAaiza; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7G8cLER; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qdTAaiza";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7G8cLER"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BF4891D0012F
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Jun 2026 07:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820105;
	 x=1782906505; bh=eos7kjQS9+d4WSp7YRNe+hc+dAoe11DlFJikSdMtZwM=; b=
	qdTAaiza/D0PDiZPuLAbOzbNAgkxz4d6UNaiK6iwWDOfVuX3sPW1qTLz+jPre/Mu
	R8CNWpyMaLJeXceRed7EFKElagTXGKFAtgeNQ9KQDhY766dUx4InHbJJGNWphF8X
	o7LUqf5O4A7pU2so4oclI1qrLL5iK5mg1kpnRsTmdEQb3dEVYTM3piUOc+ApXFtO
	H5ONnIxD8NxfQchrmv1aULm/kQBwlWb7A07Se3j0CjwIukR8W+41M1XluYCWVREM
	cE8ry8kqTUr0zZZoN8nfgZyg8itBIJKujTG/miWu1AIFcIAjNtXyEfmpPOD7Z+J3
	VaH7sPwtq7dOUoebFLa0sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820105; x=
	1782906505; bh=eos7kjQS9+d4WSp7YRNe+hc+dAoe11DlFJikSdMtZwM=; b=J
	7G8cLER8QJRzlGqEPPUTxi9Nsvr4IuuISFKwmmKXz2DWeKnWvzQHZwnhYmd0rCIW
	PRL9uycMNWqKx8Z/kxMyDraWuMt6qSun757cgni13wOQDCUU1oWhK6VtrbAeipK7
	UQjOuByms6IWNCXlmyeKQxSL+ID881EiOEjlulwucsa70JOYbjMFY1r705HHBob3
	sYOMTGjDawSIMQd5GoBKScbGLQ1kg4nOrJqNs/saJjKCBX8e1MBKipa6eJwBLLgk
	mtolNADsDq2nodLrlLNVDnygRzogHSXrK2sC70FvbtQNP4g0seCo5abfKcSQcLtD
	aZCFB6sH9vbqxjT1uYVoA==
X-ME-Sender: <xms:Ca1Daq9xLBDTtNHEzP7ua_MZF-daTjegUHqRHGbePKwa0Z4w7L9mOQ>
    <xme:Ca1Dahq2Awdu4zXzdN9_pP3ktv4SwqWDybrCACQ4eBWtUZ9GhXqz5iaWaQPYo4rDw
    -ds1lfOPCWYk53jhWWgpx1mqrFXewwPoPgJIvX4CHYMmBETjrTX>
X-ME-Received: <xmr:Ca1DalpQSjoX9-ZawnBx83b2zehtFyPUDrpVFUyRuKceONef0BgVeIeow7COs3t3LB01aoH3lsfnEqg1Y46-mpivQnG64BdJLWj7zXreolBK_g>
X-ME-Proxy-Cause: dmFkZTGHZZrzDncJSxGWUtqWZRm6WAHJlEub0zXZX5/nl2teckctucImEhnBOHbfTWUgcK
    3ry7TRV1EZ3Y4sRbWv32Atv2F9ZYfJEpenlyQ+aNfdHvZEu8+vgtQ0LVQGN4mNh2YrOwrJ
    iXrURqUPWXdntWXNRuHBwA9Ij48F2DUR9KyPODjEw37XGoVRXI3Izs67PqKCV5cHkNoxS3
    MFs5/SXUMfC4CmvqTqnf5f+mSz8w1D3Bxlkvmcz6TiYGqsCutb3vNPgluRQoGyUCio7pLX
    tCV2Ma/Za/GAlItes3e477JbsdlxBDvoY8P1dWcl5SLO6azQ17eH6UVsgjHtmEvUBhjhns
    PkrZQoHzn53Irjh0xvKw44//YicZoatyMD7ancxAN0cEjm4TYuZVdaxZlR6cGLcGC4KoGA
    QxG4t4mWcqR3c4hFNEoiXAc8shVbtGz2GUNKIstG4Om02nu0Y6ZtO2wU+N0e9ONc7QJSXr
    7RSPmnoZJgwKjXl42ohKUlWRp1E/XAic+ZKker2sth6q0ZG2COQI1tmWn/0veyTuxm6TR6
    Hp5u+3oDni665+nPIp2RYmgdclx/YFpakKxAWV4KkqA+Avj0H/OhFQ+cOOPqAVwTSCat0B
    C12pJEsgq4WyVk8GHgCGC/nccVURfZoMJ8eTKe73d1nOIkIKK+LbaHb0GGbQ
X-ME-Proxy: <xmx:Ca1DanmTQh3xx9gF9nsmllkllhKwPAjPJ_Ob55k45-5yzdA_t8tkeg>
    <xmx:Ca1DavF1iMhEhxZ7ilc-paD7E__KvMHieG9KS24uH_AmIDN-GaJuvw>
    <xmx:Ca1Daoqq53USPqGpbari_LxYWru2dNm65At89FDZ1zvZYKfpSegalw>
    <xmx:Ca1Daj6iEklyyGOta4_AYk9XbPKwI21aS-iRGkiY8FHxHSdAuAORMg>
    <xmx:Ca1Daiuz1oeKJullbZ5GswlbdnZkDNhSWhamoT2yuTHPKIv1ntZ32k1m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46f074fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:51 +0200
Subject: [PATCH 12/13] setup: pass worktree to `init_db()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-12-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding commits we have refactored how we discover and set up
repositories so that we cannot end up with partially-configured repos.
Instead, we apply the gitdir, worktree and repository format in a single
location, only.

Initializing a new repository has the same antipattern though: while
most of the information for the new repository is passed via parameters,
the work tree is instead propagated by configuring the repository's work
tree.

Refactor the code so that we also pass the work tree as an explicit
parameter. Like this, configuration fo the repository happens in a
single spot, too, just as with repository discovery.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   |  8 ++++----
 builtin/init-db.c | 34 ++++++++++------------------------
 setup.c           |  7 ++++++-
 setup.h           |  4 +++-
 4 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d60d1b60bc..9d08cd8722 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1116,7 +1116,6 @@ int cmd_clone(int argc,
 			die_errno(_("could not create work tree dir '%s'"),
 				  work_tree);
 		junk_work_tree = work_tree;
-		set_git_work_tree(the_repository, work_tree);
 	}
 
 	if (real_git_dir) {
@@ -1186,9 +1185,10 @@ int cmd_clone(int argc,
 	 * repository, and reference backends may persist that information into
 	 * their on-disk data structures.
 	 */
-	init_db(the_repository, git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
-		ref_storage_format, NULL,
-		do_not_override_repo_unix_permissions, INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
+	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
+		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
+		do_not_override_repo_unix_permissions,
+		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 566732c9f4..e96b1283b7 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -231,39 +231,25 @@ int cmd_init_db(int argc,
 	if (!bare) {
 		const char *git_dir_parent = strrchr(git_dir, '/');
 
-		if (work_tree) {
-			set_git_work_tree(the_repository, work_tree);
-		} else {
-			char *work_tree_cfg = NULL;
-
+		if (!work_tree) {
 			if (git_dir_parent) {
 				char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
-				work_tree_cfg = real_pathdup(rel, 1);
+				work_tree = real_pathdup(rel, 1);
 				free(rel);
+			} else {
+				work_tree = xgetcwd();
 			}
-
-			if (!work_tree_cfg)
-				work_tree_cfg = xgetcwd();
-
-			set_git_work_tree(the_repository, work_tree_cfg);
-
-			free(work_tree_cfg);
 		}
 
-		if (access(repo_get_work_tree(the_repository), X_OK))
-			die_errno (_("Cannot access work tree '%s'"),
-				   repo_get_work_tree(the_repository));
-	}
-	else {
-		if (real_git_dir)
-			die(_("--separate-git-dir incompatible with bare repository"));
-		if (work_tree)
-			set_git_work_tree(the_repository, work_tree);
+		if (access(work_tree, X_OK))
+			die_errno (_("Cannot access work tree '%s'"), work_tree);
+	} else if (real_git_dir) {
+		die(_("--separate-git-dir incompatible with bare repository"));
 	}
 
 	flags |= INIT_DB_EXIST_OK;
-	ret = init_db(the_repository, git_dir, real_git_dir, template_dir, hash_algo,
-		      ref_storage_format, initial_branch,
+	ret = init_db(the_repository, git_dir, real_git_dir, work_tree,
+		      template_dir, hash_algo, ref_storage_format, initial_branch,
 		      init_shared_repository, flags);
 
 	free(template_dir_to_free);
diff --git a/setup.c b/setup.c
index 4f37a7b642..40e26862ca 100644
--- a/setup.c
+++ b/setup.c
@@ -2823,7 +2823,9 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 }
 
 int init_db(struct repository *repo,
-	    const char *git_dir, const char *real_git_dir,
+	    const char *git_dir,
+	    const char *real_git_dir,
+	    const char *worktree,
 	    const char *template_dir, int hash,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch,
@@ -2852,6 +2854,9 @@ int init_db(struct repository *repo,
 		git_dir = repo_get_git_dir(repo);
 	}
 
+	if (worktree)
+		set_git_work_tree(repo, worktree);
+
 	/*
 	 * Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
diff --git a/setup.h b/setup.h
index c01a244fe9..bf3e3f3ea6 100644
--- a/setup.h
+++ b/setup.h
@@ -263,7 +263,9 @@ const char *get_template_dir(const char *option_template);
 #define INIT_DB_SKIP_REFDB (1 << 2)
 
 int init_db(struct repository *repo,
-	    const char *git_dir, const char *real_git_dir,
+	    const char *git_dir,
+	    const char *real_git_dir,
+	    const char *worktree,
 	    const char *template_dir, int hash_algo,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,

-- 
2.55.0.795.g602f6c329a.dirty

