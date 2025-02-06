Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36A225799
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828696; cv=none; b=L/9xA9QeBqqkOryuMUUNixBfZykflH6tsaEOqTwxlUwYjkV1y0NTYK9iBBx57ISKY2A5byGbUE5E0MDm7e7FfDLU8Yh3qeCm+fAdpGV+U/ZAUK0BkR6vue626ZueB7hZSf6qRd+8DYE5Hhym25j06MmTiAO1dTwLnJHWUzrN5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828696; c=relaxed/simple;
	bh=S2jnAs0WG2BcYPknT7AkP4iii7Eq/N5d+JyV7OdBtEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7PJzUXWfFd5vKpwOnz9iRvQy4gi0dWxBp8iCnVRLDKrhPgfJAS0CdXiSaGLhUGKtFJgqepj/y4vb+oJGW8CpYlNn7vTtT7vmTXJo8+JPJM66A4fzSlOqG2YPMGzhjggfeuQcJizNj4Qb69ZnfjH5w6gmBVMXx3Kckw3bn/2UB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jmgyzdJ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EGvjNDuh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jmgyzdJ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EGvjNDuh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 387C41140189
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Feb 2025 02:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828693;
	 x=1738915093; bh=0p2ekoRFFEEqPsbGSpx/HwSVhwc6L+MFqtGUQNDzSBw=; b=
	jmgyzdJ1x71AYdTh7PPMWmoMbGSmACL18jZx092MEXhGBHutj+cQG7jJ2Kejz2Z+
	dWdfPLYeRti6AoF2Gi6XUoPjkJieaH0zIiwcWnot6hiB8iYPJkVuLRuUv0gxgAV6
	e92ESgogguUYrjbMXO8MhXNbl9HGLeeokwMa0zpy/ixJqUHraT22wnL9a1r1GOH6
	LnqGHWvAmAg9nPqDJqbOdZTZhve7u54vjryoIIeB8VfMTw7/w9Zbh46x1MLULajv
	IiIrTRG02hm5LbKbVXUSsUDC2XY53VOAMWk4H2/WDjNa+Ve0muH1Of4qeS6KSDsx
	+b72bg9/NOfupQyBlTP5Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828693; x=
	1738915093; bh=0p2ekoRFFEEqPsbGSpx/HwSVhwc6L+MFqtGUQNDzSBw=; b=E
	GvjNDuhE3WtBFVkShQ2/hGXP2eXg2qQTGKbPYzhEiIKz7PdotX68JccaqHolvZIE
	CUwxzG11ssoTKT0+8v7Ab5U6NBra2xImaXpyGAZG8CJv7P3kCLYrmBGvYgTfz/i0
	k2BrJkp0WsXD8ARL4r2jl94/K3ugEX6D3iruYjnc4/Y/WJFDqGr/f0eLi8lDtc/7
	LDrE/I2Y4LlC/Q6/peliv85EgkoZfUTgyEbiIV9d7luY+Jbdjapz3dLTg1Jd73xj
	kEJpuVIFWdCAD+9PWNUsPfA6Tk6mp3orz7xF8m+zXaSKq2KBsLlUdDoXXM7WzICj
	9ERqTH9hh1jsgXHhEQ+rQ==
X-ME-Sender: <xms:lWukZ7j_7_hXWxapooOBnlZwQ6zdSLthi7Pc4MLtsJMHPrRDquC5Gw>
    <xme:lWukZ4BNhTMrIm91C5zU0zls6hIOHmM0Srzd-U8X9PssEIEiz6y08yl7fPPyjDMAA
    2eZenGfHMq7wzswIg>
X-ME-Received: <xmr:lWukZ7FXwxypp8oGAOcdFu8wPlSrTNYgR_xnOIp0e7Hn6l6LTHiFeuAqM2zT9Cf_bhSFwMyCIlN9GKRKNz-MKBKwVKUNoZIkKx3-Jl9GYyi1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lWukZ4TIBFpzOwEkClAwGGj7XnwhysE4tNeGKW7oABw6e1-KXeAQ2A>
    <xmx:lWukZ4y8Iy5BDhg2veXUAtCrtUxfPU1KazaeDKEWDzw51s1uZi_1PQ>
    <xmx:lWukZ-6rk3pO_3PLBbfKznFog1nOIYHIwDeW58LTiO-LNHhYtibwOA>
    <xmx:lWukZ9yZXTPA-YmzhfWf4S0aLwINq30bJLsHWoJNveSYlVWKKg_CKg>
    <xmx:lWukZ1rgkqVsRGUqM91V94sSDmEaPgg74r4E1N-z39l2PXGx6WJGKgXf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e009c0fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:06 +0100
Subject: [PATCH 10/16] path: drop `git_common_path()` in favor of
 `repo_common_path()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-10-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Remove `git_common_path()` in favor of the `repo_common_path()` family
of functions, which makes the implicit dependency on `the_repository` go
away.

Note that `git_common_path()` used to return a string allocated via
`get_pathname()`, which uses a rotating set of statically allocated
buffers. Consequently, callers didn't have to free the returned string.
The same isn't true for `repo_common_path()`, so we also have to add
logic to free the returned strings.

This refactoring also allows us to remove `repo_common_pathv()` from the
public interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/worktree.c | 16 ++++++++++++----
 path.c             |  8 ++++----
 path.h             | 19 -------------------
 worktree.c         | 32 ++++++++++++++++++++++++--------
 4 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2cea9441a6..761e302a36 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -151,7 +151,7 @@ static int delete_git_dir(const char *id)
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
-	strbuf_addstr(&sb, git_common_path("worktrees/%s", id));
+	repo_common_path_append(the_repository, &sb, "worktrees/%s", id);
 	ret = remove_dir_recursively(&sb, 0);
 	if (ret < 0 && errno == ENOTDIR)
 		ret = unlink(sb.buf);
@@ -1102,6 +1102,7 @@ static int lock_worktree(int ac, const char **av, const char *prefix,
 		OPT_END()
 	};
 	struct worktree **worktrees, *wt;
+	char *path;
 
 	ac = parse_options(ac, av, prefix, options, git_worktree_lock_usage, 0);
 	if (ac != 1)
@@ -1122,9 +1123,11 @@ static int lock_worktree(int ac, const char **av, const char *prefix,
 		die(_("'%s' is already locked"), av[0]);
 	}
 
-	write_file(git_common_path("worktrees/%s/locked", wt->id),
-		   "%s", reason);
+	path = repo_common_path(the_repository, "worktrees/%s/locked", wt->id);
+	write_file(path, "%s", reason);
+
 	free_worktrees(worktrees);
+	free(path);
 	return 0;
 }
 
@@ -1135,6 +1138,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix,
 		OPT_END()
 	};
 	struct worktree **worktrees, *wt;
+	char *path;
 	int ret;
 
 	ac = parse_options(ac, av, prefix, options, git_worktree_unlock_usage, 0);
@@ -1149,8 +1153,12 @@ static int unlock_worktree(int ac, const char **av, const char *prefix,
 		die(_("The main working tree cannot be locked or unlocked"));
 	if (!worktree_lock_reason(wt))
 		die(_("'%s' is not locked"), av[0]);
-	ret = unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id));
+
+	path = repo_common_path(the_repository, "worktrees/%s/locked", wt->id);
+	ret = unlink_or_warn(path);
+
 	free_worktrees(worktrees);
+	free(path);
 	return ret;
 }
 
diff --git a/path.c b/path.c
index d721507be8..f6b795d75f 100644
--- a/path.c
+++ b/path.c
@@ -634,10 +634,10 @@ const char *repo_submodule_path_replace(struct repository *repo,
 	return buf->buf;
 }
 
-void repo_common_pathv(const struct repository *repo,
-		       struct strbuf *sb,
-		       const char *fmt,
-		       va_list args)
+static void repo_common_pathv(const struct repository *repo,
+			      struct strbuf *sb,
+			      const char *fmt,
+			      va_list args)
 {
 	strbuf_addstr(sb, repo->commondir);
 	if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
diff --git a/path.h b/path.h
index 904eeac068..496f27fdfd 100644
--- a/path.h
+++ b/path.h
@@ -233,29 +233,10 @@ struct strbuf *get_pathname(void);
 #  include "repository.h"
 
 /* Internal implementation details that should not be used. */
-void repo_common_pathv(const struct repository *repo,
-		       struct strbuf *buf,
-		       const char *fmt,
-		       va_list args);
 void repo_git_pathv(struct repository *repo,
 		    const struct worktree *wt, struct strbuf *buf,
 		    const char *fmt, va_list args);
 
-/*
- * Return a statically allocated path into the main repository's
- * (the_repository) common git directory.
- */
-__attribute__((format (printf, 1, 2)))
-static inline const char *git_common_path(const char *fmt, ...)
-{
-	struct strbuf *pathname = get_pathname();
-	va_list args;
-	va_start(args, fmt);
-	repo_common_pathv(the_repository, pathname, fmt, args);
-	va_end(args);
-	return pathname->buf;
-}
-
 /*
  * Return a statically allocated path into the main repository's
  * (the_repository) git directory.
diff --git a/worktree.c b/worktree.c
index 3b94535963..d5d07d7a84 100644
--- a/worktree.c
+++ b/worktree.c
@@ -183,7 +183,7 @@ char *get_worktree_git_dir(const struct worktree *wt)
 	else if (!wt->id)
 		return xstrdup(repo_get_common_dir(the_repository));
 	else
-		return xstrdup(git_common_path("worktrees/%s", wt->id));
+		return repo_common_path(the_repository, "worktrees/%s", wt->id);
 }
 
 static struct worktree *find_worktree_by_suffix(struct worktree **list,
@@ -314,6 +314,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 {
 	struct strbuf wt_path = STRBUF_INIT;
 	struct strbuf realpath = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	char *path = NULL;
 	int err, ret = -1;
 
@@ -343,7 +344,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 	if (!is_absolute_path(wt->path)) {
 		strbuf_addf_gently(errmsg,
 				   _("'%s' file does not contain absolute path to the working tree location"),
-				   git_common_path("worktrees/%s/gitdir", wt->id));
+				   repo_common_path_replace(the_repository, &buf, "worktrees/%s/gitdir", wt->id));
 		goto done;
 	}
 
@@ -365,14 +366,16 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 		goto done;
 	}
 
-	strbuf_realpath(&realpath, git_common_path("worktrees/%s", wt->id), 1);
+	strbuf_realpath(&realpath, repo_common_path_replace(the_repository, &buf, "worktrees/%s", wt->id), 1);
 	ret = fspathcmp(path, realpath.buf);
 
 	if (ret)
 		strbuf_addf_gently(errmsg, _("'%s' does not point back to '%s'"),
-				   wt->path, git_common_path("worktrees/%s", wt->id));
+				   wt->path, repo_common_path_replace(the_repository, &buf,
+								      "worktrees/%s", wt->id));
 done:
 	free(path);
+	strbuf_release(&buf);
 	strbuf_release(&wt_path);
 	strbuf_release(&realpath);
 	return ret;
@@ -384,11 +387,13 @@ void update_worktree_location(struct worktree *wt, const char *path_,
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf dotgit = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
+	char *wt_gitdir;
 
 	if (is_main_worktree(wt))
 		BUG("can't relocate main worktree");
 
-	strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id), 1);
+	wt_gitdir = repo_common_path(the_repository, "worktrees/%s/gitdir", wt->id);
+	strbuf_realpath(&gitdir, wt_gitdir, 1);
 	strbuf_realpath(&path, path_, 1);
 	strbuf_addf(&dotgit, "%s/.git", path.buf);
 	if (fspathcmp(wt->path, path.buf)) {
@@ -400,6 +405,7 @@ void update_worktree_location(struct worktree *wt, const char *path_,
 	strbuf_release(&path);
 	strbuf_release(&dotgit);
 	strbuf_release(&gitdir);
+	free(wt_gitdir);
 }
 
 int is_worktree_being_rebased(const struct worktree *wt,
@@ -585,6 +591,7 @@ static void repair_gitfile(struct worktree *wt,
 	struct strbuf backlink = STRBUF_INIT;
 	char *dotgit_contents = NULL;
 	const char *repair = NULL;
+	char *path = NULL;
 	int err;
 
 	/* missing worktree can't be repaired */
@@ -596,7 +603,8 @@ static void repair_gitfile(struct worktree *wt,
 		goto done;
 	}
 
-	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
+	path = repo_common_path(the_repository, "worktrees/%s", wt->id);
+	strbuf_realpath(&repo, path, 1);
 	strbuf_addf(&dotgit, "%s/.git", wt->path);
 	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
 	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
@@ -626,6 +634,7 @@ static void repair_gitfile(struct worktree *wt,
 
 done:
 	free(dotgit_contents);
+	free(path);
 	strbuf_release(&repo);
 	strbuf_release(&dotgit);
 	strbuf_release(&gitdir);
@@ -657,11 +666,13 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf dotgit = STRBUF_INIT;
 	int is_relative_path;
+	char *path = NULL;
 
 	if (is_main_worktree(wt))
 		goto done;
 
-	strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id), 1);
+	path = repo_common_path(the_repository, "worktrees/%s/gitdir", wt->id);
+	strbuf_realpath(&gitdir, path, 1);
 
 	if (strbuf_read_file(&dotgit, gitdir.buf, 0) < 0)
 		goto done;
@@ -680,6 +691,7 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
 done:
 	strbuf_release(&gitdir);
 	strbuf_release(&dotgit);
+	free(path);
 }
 
 void repair_worktrees_after_gitdir_move(const char *old_path)
@@ -871,7 +883,11 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 	ssize_t read_result;
 
 	*wtpath = NULL;
-	strbuf_realpath(&repo, git_common_path("worktrees/%s", id), 1);
+
+	path = repo_common_path(the_repository, "worktrees/%s", id);
+	strbuf_realpath(&repo, path, 1);
+	FREE_AND_NULL(path);
+
 	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
 	if (!is_directory(repo.buf)) {
 		strbuf_addstr(reason, _("not a valid directory"));

-- 
2.48.1.538.gc4cfc42d60.dirty

