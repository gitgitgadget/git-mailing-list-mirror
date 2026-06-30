Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FA406834
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820090; cv=none; b=WqxEsddEWabUMxlflPAonR15azdZq1lP/iuAYi9p7pyT1JND/LqqswpsqvMHFlJNS8TXEgX2aVMSi3xPg+P6M6K4BTJZ3CIZ9sKD+FuMeVszFTRKku4SGEFi790oozbBRzdg/Qw6ADyLLQBAZFZyamwRiwDRmMaf744oMP/iHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820090; c=relaxed/simple;
	bh=vVNJYKX6t2/Cqh8OBfEBYhMnGfjJUXl562ApIRSmSjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DU40MIWb0/Ut6Bm55VP8AYU5PwaNUR3791a2T+5uPrTau1HQcCS0UsRihLCKZuPGe+fQ1UdakQKvFi2J/UtfvC5KhsBQWpXBc6i8lfK8fpkNR5zDrj35sVrcRiEw/DdDpC3ZPJSnzD4eSXfGYRxJ8y+jGFDvNYTlkU8iu1b6/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n5iy/P6Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4RTgpIA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n5iy/P6Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4RTgpIA"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AADE1D000CC
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 30 Jun 2026 07:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820088;
	 x=1782906488; bh=Ou4ojP/KC2qLcxXeolvDM11+l96JqoHIafyPOs/1Xi4=; b=
	n5iy/P6Z+/E/0UvEMKZ5t7OK1habTDY49NyyvhDkXwcnnujkm22mlHYQE4bDA7Hn
	aW7qC1TR0yvJ9VdLSuf+gXaRyyo7E+2GGH2JuOZ4VtXIVdlBqbUcpcpKJjhojX13
	306FR29Scowz1WXkhVXO4cXq1cHDlOhz+/u4xD5Z2FRce5w6EKQbd6FzcwNmY4AW
	5r/vrmI5TmruHnYlChQKWwIzqVPUL4n+N2P7QtYdFVsN/mDEIxa2arxDDjG++KMS
	J2x5yCPHP9JSztREwEs/+ywLvARqvpssKyymHAR5n5VNIALfvq16AU7ozakcGIGp
	WWxSUWTgVpzK1Pd9Abx6Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820088; x=
	1782906488; bh=Ou4ojP/KC2qLcxXeolvDM11+l96JqoHIafyPOs/1Xi4=; b=F
	4RTgpIAKvY6rUfHbozx5J1XFken0AFcI/FD2t7xiQU7Fx58Pq4iA+Fi5WlnvkKlT
	fyvUf2+j1vyp5A/A5Rzn5/rUExmP/ZObmVijkI6Qz90ZNaeabpoRHwIU9nIQ5Vg3
	3hPxMflByz2wn+hvPbTwmsD6JXvFV2PZzn+na3EKBFayL4n9Ox7qfAF7/8xd+eb8
	JVvrnLMEmm72zE7fmBn1A1HpJGV205GviFcxezC18olXjFXZ0QZ6cpBWQmakdlU0
	QDmrdDPd60KBiQtuNeDD0ZRpkPq2wZYoSoHxjbE3Y6cueYdODxJ8s556lkN1YC5t
	SDrZ3E0Bygr2YF/PE7kfQ==
X-ME-Sender: <xms:96xDamO2FGYZs8dsPQMntSIrnFxvEJ0C30E5qqkwbsAXiO-tIAWaMg>
    <xme:96xDar6ukradiYeT-3JZc9l5s-QYyDRwCdOhpzMQwXbIuL_DRmcWgNgaxWm1rxZyP
    OE7ybnrKojliDIVDWFNud4XWEYVKRO_k-IOLiXfZbLUiEyb9sK9KsY>
X-ME-Received: <xmr:96xDai6GvdzRs79U_B9H7xrBxDkAq4e8PkcBYavJN4yCudBXcfRe8_1rBMsCPK4-BOa05Up8OuRuFL0amQA-efOcgPk6zgWEqofOitfDHkH6EQ>
X-ME-Proxy-Cause: dmFkZTFMj0npvFJ5xMu5TnTZGwl/kjNgIE3c+0+JrvywJVsBHvwNH0JmEkV9/sHb7KtHci
    MWHt4fCw++BHgU20LsJIOXEGWWe7laoLapVct5ezFWgUrSK246UxYzIlrE931fJU7zptCb
    Kt8ycW9gOfxVEBILBMqaO/gR7ZjX830aRvEzgMVkDX71WFJ1OAahhczPptAaL8l+tOR3ej
    9r8uWRRiGNgTXQd7Q16Bn4Ti/3nvp69LgGzwNNdE7d9Zs6RyP3ilqh9SA/M1mBNs2+qPBf
    vwS5f4zH1TbnYNSv0Awptv9a5rucDDTqwCIXVp+kgUqtQvSOo6yzZiVbOAfdN362M5E2OY
    1Lpws/AKRc8SMI8Lqwlr4bHyzLrh/dyQX/DyAYl4Txx72CxvbDy5sqo37XgkDhhalA5pUX
    /K+kvgLwV+m4x6jI4An1H3nHTCpM77zfQeuG6moECF1+WkyfpQygZT6WEhW1LO3HLinr58
    SuIyZ2/92vrA6LoV5znVVqBQLnXcORPWGzDfFTpAS7+Kd2ds4/Q/GF7lamL+OwpYCoSrYq
    BnD7aWneMt0158h6OLcopaGwpwt0cqrE52vK9j07lVFEoBIeGisOpLKm1EXYOS2oBl8k8c
    J4wp3+JU4UeiJIIbRnrxkRS/txMnPcXcygJIBGnVFSi+rkzMBCw2Uo6d33dw
X-ME-Proxy: <xmx:96xDar32HELw-JOJxHO5HuazKrFKHRASZb4zIPFzQLet7r9j1fXOXQ>
    <xmx:96xDauXRYykyifoJTjIMYKL9BYkZ-IHTiiLTQXj03-4NTjlgPDHWmA>
    <xmx:96xDam4J2yRNn7OL_fh-BsLCGzNvtU-4nZsMmjVFwXBbJEZyHoxygw>
    <xmx:96xDalLhIqAiBekvahqBFss508NvA50MxVFdhffyn_Rbxi3yZ2nz2Q>
    <xmx:-KxDam9v4BIgSX8z0DL8dmoEQ1CjG3xRf3NAwnjx1HdaCcMTqpH1_mhv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 38553d71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:44 +0200
Subject: [PATCH 05/13] setup: introduce explicit repository discovery
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-5-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When setting up the global repository we intermix repository discovery
and repository configuration: we repeatedly call `set_git_work_tree()`
and `apply_and_export_relative_gitdir()` until we're happy with the
result. The result of this is then a partially-configured repository
that we use for further setup.

This process is quite hard to follow, as it's never quite clear which
parts of the repository have been configured already and which haven't.
Furthermore, it means that the repository configuration is distributed
across many different places instead of having it neatly contained in a
single location. Ultimately, this is the reason that we cannot use a
central function like `repo_init()`.

Refactor the logic so that we stop partially-configuring a repository
and instead populate a new `struct repo_discovery`. This allow us to
essentially split repository setup into two phases:

  - The first phase only figures out parameters required to configure
    the repository.

  - The second phase then takes these parameters and applies them to the
    repository.

Like this, we'll never end up with a partially-configured repository and
can eventually extend `repo_init()` to handle the full initialization
for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 155 ++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 98 insertions(+), 57 deletions(-)

diff --git a/setup.c b/setup.c
index dd8514b822..06768de23f 100644
--- a/setup.c
+++ b/setup.c
@@ -1090,14 +1090,47 @@ static void apply_and_export_relative_gitdir(struct repository *repo, const char
 	strbuf_release(&realpath);
 }
 
-static const char *setup_explicit_git_dir(struct repository *repo,
-					  const char *gitdirenv,
-					  struct strbuf *cwd,
-					  struct repository_format *repo_fmt,
-					  int *nongit_ok)
+struct repo_discovery {
+	char *gitdir;
+	char *worktree;
+};
+
+#define REPO_DISCOVERY_INIT { 0 }
+
+static void repo_discovery_release(struct repo_discovery *r)
+{
+	free(r->gitdir);
+	free(r->worktree);
+}
+
+static void repo_discovery_set_gitdir(struct repo_discovery *r,
+				      const char *gitdir,
+				      int make_realpath)
+{
+	free(r->gitdir);
+	if (make_realpath) {
+		struct strbuf realpath = STRBUF_INIT;
+		strbuf_realpath(&realpath, gitdir, 1);
+		r->gitdir = strbuf_detach(&realpath, NULL);
+	} else {
+		r->gitdir = xstrdup(gitdir);
+	}
+}
+
+static void repo_discovery_set_worktree(struct repo_discovery *r,
+					const char *worktree)
+{
+	free(r->worktree);
+	r->worktree = real_pathdup(worktree, 1);
+}
+
+static const char *repo_discover_explicit_gitdir(struct repo_discovery *discovery,
+						 const char *gitdirenv,
+						 struct strbuf *cwd,
+						 struct repository_format *repo_fmt,
+						 int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
-	const char *worktree;
 	char *gitfile;
 	int offset;
 
@@ -1133,15 +1166,15 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		 * we have to exlicitly unset the configuration.
 		 */
 		FREE_AND_NULL(repo_fmt->work_tree);
-		set_git_work_tree(repo, work_tree_env);
+		repo_discovery_set_worktree(discovery, work_tree_env);
 	} else if (repo_fmt->is_bare > 0) {
 		/* #18, #26 */
-		apply_and_export_relative_gitdir(repo, gitdirenv, 0);
+		repo_discovery_set_gitdir(discovery, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	} else if (repo_fmt->work_tree) { /* #6, #14 */
 		if (is_absolute_path(repo_fmt->work_tree)) {
-			set_git_work_tree(repo, repo_fmt->work_tree);
+			repo_discovery_set_worktree(discovery, repo_fmt->work_tree);
 		} else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
@@ -1151,49 +1184,46 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 			core_worktree = xgetcwd();
 			if (chdir(cwd->buf))
 				die_errno(_("cannot come back to cwd"));
-			set_git_work_tree(repo, core_worktree);
+			repo_discovery_set_worktree(discovery, core_worktree);
 			free(core_worktree);
 		}
 	} else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
-		apply_and_export_relative_gitdir(repo, gitdirenv, 0);
+		repo_discovery_set_gitdir(discovery, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	} else { /* #2, #10 */
-		set_git_work_tree(repo, ".");
+		repo_discovery_set_worktree(discovery, ".");
 	}
 
-	/* set_git_work_tree() must have been called by now */
-	worktree = repo_get_work_tree(repo);
-
-	/* both repo_get_work_tree() and cwd are already normalized */
-	if (!strcmp(cwd->buf, worktree)) { /* cwd == worktree */
-		apply_and_export_relative_gitdir(repo, gitdirenv, 0);
+	/* both the worktree and cwd are already normalized */
+	if (!strcmp(cwd->buf, discovery->worktree)) { /* cwd == worktree */
+		repo_discovery_set_gitdir(discovery, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	}
 
-	offset = dir_inside_of(cwd->buf, worktree);
-	if (offset >= 0) {	/* cwd inside worktree? */
-		apply_and_export_relative_gitdir(repo, gitdirenv, 1);
-		if (chdir(worktree))
-			die_errno(_("cannot chdir to '%s'"), worktree);
+	offset = dir_inside_of(cwd->buf, discovery->worktree);
+	if (offset >= 0) {	/* cwd inside discovery->worktree? */
+		repo_discovery_set_gitdir(discovery, gitdirenv, 1);
+		if (chdir(discovery->worktree))
+			die_errno(_("cannot chdir to '%s'"), discovery->worktree);
 		strbuf_addch(cwd, '/');
 		free(gitfile);
 		return cwd->buf + offset;
 	}
 
 	/* cwd outside worktree */
-	apply_and_export_relative_gitdir(repo, gitdirenv, 0);
+	repo_discovery_set_gitdir(discovery, gitdirenv, 0);
 	free(gitfile);
 	return NULL;
 }
 
-static const char *setup_discovered_git_dir(struct repository *repo,
-					    const char *gitdir,
-					    struct strbuf *cwd, int offset,
-					    struct repository_format *repo_fmt,
-					    int *nongit_ok)
+static const char *repo_discover_implicit_gitdir(struct repo_discovery *discovery,
+						 const char *gitdir,
+						 struct strbuf *cwd, int offset,
+						 struct repository_format *repo_fmt,
+						 int *nongit_ok)
 {
 	if (read_and_verify_repository_format(repo_fmt, gitdir, nongit_ok))
 		return NULL;
@@ -1207,23 +1237,24 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 			gitdir = to_free = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
-		ret = setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
+		ret = repo_discover_explicit_gitdir(discovery, gitdir, cwd,
+						    repo_fmt, nongit_ok);
 		free(to_free);
 		return ret;
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
 	if (repo_fmt->is_bare > 0) {
-		apply_and_export_relative_gitdir(repo, gitdir, (offset != cwd->len));
+		repo_discovery_set_gitdir(discovery, gitdir, (offset != cwd->len));
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
 		return NULL;
 	}
 
 	/* #0, #1, #5, #8, #9, #12, #13 */
-	set_git_work_tree(repo, ".");
+	repo_discovery_set_worktree(discovery, ".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
-		apply_and_export_relative_gitdir(repo, gitdir, 0);
+		repo_discovery_set_gitdir(discovery, gitdir, 0);
 	if (offset >= cwd->len)
 		return NULL;
 
@@ -1236,10 +1267,10 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 }
 
 /* #16.1, #17.1, #20.1, #21.1, #22.1 (see t1510) */
-static const char *setup_bare_git_dir(struct repository *repo,
-				      struct strbuf *cwd, int offset,
-				      struct repository_format *repo_fmt,
-				      int *nongit_ok)
+static const char *repo_discover_bare_gitdir(struct repo_discovery *discovery,
+					     struct strbuf *cwd, int offset,
+					     struct repository_format *repo_fmt,
+					     int *nongit_ok)
 {
 	int root_len;
 
@@ -1255,7 +1286,8 @@ static const char *setup_bare_git_dir(struct repository *repo,
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
-		return setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
+		return repo_discover_explicit_gitdir(discovery, gitdir, cwd,
+						     repo_fmt, nongit_ok);
 	}
 
 	if (offset != cwd->len) {
@@ -1263,10 +1295,10 @@ static const char *setup_bare_git_dir(struct repository *repo,
 			die_errno(_("cannot come back to cwd"));
 		root_len = offset_1st_component(cwd->buf);
 		strbuf_setlen(cwd, offset > root_len ? offset : root_len);
-		apply_and_export_relative_gitdir(repo, cwd->buf, 0);
+		repo_discovery_set_gitdir(discovery, cwd->buf, 0);
 	}
 	else
-		apply_and_export_relative_gitdir(repo, ".", 0);
+		repo_discovery_set_gitdir(discovery, ".", 0);
 	return NULL;
 }
 
@@ -1525,10 +1557,10 @@ static int is_implicit_bare_repo(const char *path)
  * the discovered .git/ directory, if any. If `gitdir` is not absolute, it
  * is relative to `dir` (i.e. *not* necessarily the cwd).
  */
-static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
-							  struct strbuf *gitdir,
-							  struct strbuf *report,
-							  int die_on_error)
+static enum discovery_result repo_discovery_find_dir(struct strbuf *dir,
+						     struct strbuf *gitdir,
+						     struct strbuf *report,
+						     int die_on_error)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
@@ -1695,7 +1727,7 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 		return GIT_DIR_CWD_FAILURE;
 
 	cwd_len = dir.len;
-	result = setup_git_directory_gently_1(&dir, gitdir, NULL, 0);
+	result = repo_discovery_find_dir(&dir, gitdir, NULL, 0);
 	if (result <= 0) {
 		strbuf_release(&dir);
 		return result;
@@ -1902,6 +1934,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 {
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
+	struct repo_discovery discovery = REPO_DISCOVERY_INIT;
 	const char *prefix = NULL;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
@@ -1926,20 +1959,22 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		die_errno(_("Unable to read current working directory"));
 	strbuf_addbuf(&dir, &cwd);
 
-	switch (setup_git_directory_gently_1(&dir, &gitdir, &report, 1)) {
+	switch (repo_discovery_find_dir(&dir, &gitdir, &report, 1)) {
 	case GIT_DIR_EXPLICIT:
-		prefix = setup_explicit_git_dir(repo, gitdir.buf, &cwd, &repo_fmt, nongit_ok);
+		prefix = repo_discover_explicit_gitdir(&discovery, gitdir.buf, &cwd,
+						       &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		prefix = setup_discovered_git_dir(repo, gitdir.buf, &cwd, dir.len,
-						  &repo_fmt, nongit_ok);
+		prefix = repo_discover_implicit_gitdir(&discovery, gitdir.buf, &cwd, dir.len,
+						       &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		prefix = setup_bare_git_dir(repo, &cwd, dir.len, &repo_fmt, nongit_ok);
+		prefix = repo_discover_bare_gitdir(&discovery, &cwd, dir.len,
+						   &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
 		if (!nongit_ok)
@@ -1980,13 +2015,13 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	case GIT_DIR_CWD_FAILURE:
 	case GIT_DIR_INVALID_FORMAT:
 		/*
-		 * As a safeguard against setup_git_directory_gently_1 returning
+		 * As a safeguard against repo_discovery_find_dir returning
 		 * these values, fallthrough to BUG. Otherwise it is possible to
 		 * set startup_info->have_repository to 1 when we did nothing to
 		 * find a repository.
 		 */
 	default:
-		BUG("unhandled setup_git_directory_gently_1() result");
+		BUG("unhandled repo_discovery_find_dir() result");
 	}
 
 	/*
@@ -2005,10 +2040,10 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		startup_info->have_repository = 1;
 
 	/*
-	 * Not all paths through the setup code will call 'apply_and_export_relative_gitdir()' (which
-	 * directly sets up the environment) so in order to guarantee that the
-	 * environment is in a consistent state after setup, explicitly setup
-	 * the environment if we have a repository.
+	 * Not all paths through the setup code will have recorded a gitdir
+	 * above, so in order to guarantee that the environment is in a
+	 * consistent state after setup, explicitly set up the gitdir and
+	 * environment if we have a repository.
 	 *
 	 * NEEDSWORK: currently we allow bogus GIT_DIR values to be set in some
 	 * code paths so we also need to explicitly setup the environment if
@@ -2019,7 +2054,12 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
-		if (!repo->gitdir) {
+		if (discovery.worktree)
+			set_git_work_tree(repo, discovery.worktree);
+
+		if (discovery.gitdir) {
+			apply_and_export_relative_gitdir(repo, discovery.gitdir, 0);
+		} else {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
@@ -2074,6 +2114,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 	setup_original_cwd(repo);
 
+	repo_discovery_release(&discovery);
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
 	strbuf_release(&report);

-- 
2.55.0.795.g602f6c329a.dirty

