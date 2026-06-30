Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F283F20E7
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820100; cv=none; b=Bp2LpSWsuDhCsZKeysS7PsiU/mdK39mSun4pmzpi9As1gCjUXH6xxpMq3c6fvXY/AEPIE2YTcKitDFxxo1Am8N6jiCJpEyTd0rgc1aRNF8ceBOn8H15NTqLsoT7VvxEFzicF176Eb/AwtQKpvbj1qVcTASPN4no6u40f+MriTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820100; c=relaxed/simple;
	bh=nMRKVHeSNwsKW4Pwl8dHgthFDdzzLuFLz9nnG8TwfF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AY7XwSSYMVbFBAxHuf1RVUKa9tk584EFmgNwGZVGeD/Pk300WT9R8icMT7Qn6IQG6Lu6MOeaYnphtjxQgXrUkwyU1oKaPXoM9COE614nSNxbecc2aAxZXXZlWfYmHyeN6jpklEsLsrOT1ZhEHNHpA83yyloXMcn7d0eo7h6I6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cw1H325L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fiAgir+E; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cw1H325L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fiAgir+E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E5EC91D000D6
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 30 Jun 2026 07:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820097;
	 x=1782906497; bh=/wO+B4JJLKL/dLqzdfTShFsjvnvGcpE74lD4khSHULc=; b=
	Cw1H325LZTr6ybfeR46Qt4+fsvbwO331KI844QgA0atSfPcihjZNBRpWGlBrc1Bv
	obIBrnB2RABGBVncq8rhHoNtD0CQCasvunYkAam+Kk/JxE13XYJOIWPcpdPwQ8h4
	96OYonYgb772z2E2jAtnYYmb7Lya29fj7bTZiyTlmFeO2bMPZ/yYQfXU/C8XR+6h
	RFjUXz+ORR7Sv/lf2lQH2o5P7ryIx2yJCoT2DfJLxjn6M6ayq1TDypg9TljEvojl
	OHn7NIMXz12Rl1lM364hp1orjsOTnpaJc0h0yKfMyd8V30zTZUph64l9COkZ7fTr
	1k7Z5ICvIDeL6IyrKBDCQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820097; x=
	1782906497; bh=/wO+B4JJLKL/dLqzdfTShFsjvnvGcpE74lD4khSHULc=; b=f
	iAgir+ERGjpGPxRKfCGXUDLjOzM76wU+DF50z+7xW8AcG9qxRachVSeFXMC5M2e2
	ezTTrAUQfUtAutHE0z9CiYNjS0tpVaPtMpRBj//7ac9PXOHh8GH7HDK1VK1cY92A
	DF7+TjHTG1HLDHLGQlMd6Ytc7v2Nko+8TR36IYfZDRi6jw/Lx89oOghCo44M67li
	2vVzGHHmvvrUyOFOzRO4/pywbA8CWEwyyK8S0MkSTEl+YrIjQ6EpEnts9WBmo9LH
	D9uugHBjBYJJZRuecLh/PdAPMDxaeYvFs3pt7ZRFSl64ZiFIQXVZMQbs0tU4pj43
	QWOMDg4qujRZL02EAATjQ==
X-ME-Sender: <xms:Aa1DagCb0YBJpibLzxc7ilgyatKBK1v9z6q8jb53ZK_aGt-4RUuXyw>
    <xme:Aa1Dakhqo4py4e8wFs0PMy0yHm2a8Cx0mbLZD1QsSs8g_RTLvc3j_J-S5Zryl7grP
    p9m731OxU9XeOOAClGZTV9nE0ku5R56YLpW7YcDEKs2cAyUfmMQeJE>
X-ME-Received: <xmr:Aa1Das9x5qvJNq6n3ahDmVtpL5qWXalvcsQeaCG2oXE_SD0YnkSP8gfh5PNgGF4iIrOxhJvGlUiK7muXcjriH96NZxtgPyl77gkY9boOXjqhfw>
X-ME-Proxy-Cause: dmFkZTFDZ8EBIRkLTKt14TuSGr1p9PVZekTad1c/wqf+J4rUdU57yUeNCpU56+znu8nsjb
    fYDR646+CJ3TGFv8kQTHR4VNBrT/tkMeSXjzT67aaHpKiIdg7Ex7ASQFMr3pvovOMeWRc2
    b+Hb+9BEYhuDH+pmqgJy7oGhS1oPcxj3Hy28pR4Uz81T3ewRUNKEnbf7HExREqmx77S7CO
    8q4+s9ohDmUs11CzmmSQpKP0fvZO9hDzS3HZYuZIL2rRpsr/my7MnY/OfRKNFc3m22a8aE
    0HfNWlTaLhp/UB/uVY+/uRI7kUgfffb/QcAn+DT1zAl/2aW3MU8z9wRoF8TwRTtj2JqpI1
    SgmBFvwRdqFGZQ2O0jzlyp4OmX6oNrwuGWkXFoNsKMK2/KNNiMqB3NocJHdojY2nk1/ScW
    UiOUTPpTprmncnHcV/jbHSAJ692augDJbCH985MAB1t/6FYDfA+BkFJTtpJWS0N5MW6nrb
    dU7WU01fXng1QE0sPOV2iAqyoCLhWESsNBUeeb41DJqX/UlX4iEr1NTDP70S9gl162dlMu
    QNMLjAbcH5JX1KbQaSjXlLa0flYdbRqu9JsXxTc7i5LKIlBFl6omCQUbDjwefnMtPh1HoN
    1RXgLSENkIbb6dTX51d1S8/a+4Gv1TzDF1ixNhAST6vczKu/zHXxUOerD1Sg
X-ME-Proxy: <xmx:Aa1Dao9kV0l7imhERE2XOASNN88_N8q1_AwKI211dixN_Tg4e0Treg>
    <xmx:Aa1DatA3DTbDPHKs6UYIbyRfsDqVUCD_650YE6ma9klrCQPYYOKNcA>
    <xmx:Aa1DagythMahlPk86c2rnKvoLvB6O6SNFemmmRKz2kU0pCqRidklsA>
    <xmx:Aa1DaqQVmoFvQ2rfgScAWlHvzY1zji3r4ksf9hkQcO4zfiOFOR1SdA>
    <xmx:Aa1Daj7L8FDRk9pEHxG_j6MJyhfRWAah5DcXnKe3ffgfQxWnhb9LU2tf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c541ea66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:48 +0200
Subject: [PATCH 09/13] setup: propagate prefix via repository discovery
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-9-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding commits we have started to propagate all information
required for the configuration of the repository via a new `struct
repo_discovery`. The only exception is the repository's prefix, which we
still return via the return parameter.

This is conceptually fine, but somewhat inconsistent. Refactor this to
instead propagate the prefix via the repository discovery, too.

While at it, drop a static variable in `repo_discover_bare_gitdir()`.
We apply its value to the repository discovery anyway, so we don't have
to keep it around afterwards anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 101 +++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 45 insertions(+), 56 deletions(-)

diff --git a/setup.c b/setup.c
index 971024e5a6..fc73276149 100644
--- a/setup.c
+++ b/setup.c
@@ -1094,6 +1094,7 @@ struct repo_discovery {
 	struct repository_format format;
 	char *gitdir;
 	char *worktree;
+	char *prefix;
 };
 
 #define REPO_DISCOVERY_INIT { \
@@ -1105,6 +1106,7 @@ static void repo_discovery_release(struct repo_discovery *r)
 	clear_repository_format(&r->format);
 	free(r->gitdir);
 	free(r->worktree);
+	free(r->prefix);
 }
 
 static void repo_discovery_set_gitdir(struct repo_discovery *r,
@@ -1128,10 +1130,10 @@ static void repo_discovery_set_worktree(struct repo_discovery *r,
 	r->worktree = real_pathdup(worktree, 1);
 }
 
-static const char *repo_discover_explicit_gitdir(struct repo_discovery *discovery,
-						 const char *gitdirenv,
-						 struct strbuf *cwd,
-						 int *nongit_ok)
+static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
+					  const char *gitdirenv,
+					  struct strbuf *cwd,
+					  int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
 	char *gitfile;
@@ -1149,16 +1151,13 @@ static const char *repo_discover_explicit_gitdir(struct repo_discovery *discover
 	if (!is_git_directory(gitdirenv)) {
 		if (nongit_ok) {
 			*nongit_ok = 1;
-			free(gitfile);
-			return NULL;
+			goto out;
 		}
 		die(_("not a git repository: '%s'"), gitdirenv);
 	}
 
-	if (read_and_verify_repository_format(&discovery->format, gitdirenv, nongit_ok)) {
-		free(gitfile);
-		return NULL;
-	}
+	if (read_and_verify_repository_format(&discovery->format, gitdirenv, nongit_ok))
+		goto out;
 
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
 	if (work_tree_env) {
@@ -1173,8 +1172,7 @@ static const char *repo_discover_explicit_gitdir(struct repo_discovery *discover
 	} else if (discovery->format.is_bare > 0) {
 		/* #18, #26 */
 		repo_discovery_set_gitdir(discovery, gitdirenv, 0);
-		free(gitfile);
-		return NULL;
+		goto out;
 	} else if (discovery->format.work_tree) { /* #6, #14 */
 		if (is_absolute_path(discovery->format.work_tree)) {
 			repo_discovery_set_worktree(discovery, discovery->format.work_tree);
@@ -1193,8 +1191,7 @@ static const char *repo_discover_explicit_gitdir(struct repo_discovery *discover
 	} else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
 		repo_discovery_set_gitdir(discovery, gitdirenv, 0);
-		free(gitfile);
-		return NULL;
+		goto out;
 	} else { /* #2, #10 */
 		repo_discovery_set_worktree(discovery, ".");
 	}
@@ -1202,8 +1199,7 @@ static const char *repo_discover_explicit_gitdir(struct repo_discovery *discover
 	/* both the worktree and cwd are already normalized */
 	if (!strcmp(cwd->buf, discovery->worktree)) { /* cwd == worktree */
 		repo_discovery_set_gitdir(discovery, gitdirenv, 0);
-		free(gitfile);
-		return NULL;
+		goto out;
 	}
 
 	offset = dir_inside_of(cwd->buf, discovery->worktree);
@@ -1211,38 +1207,37 @@ static const char *repo_discover_explicit_gitdir(struct repo_discovery *discover
 		repo_discovery_set_gitdir(discovery, gitdirenv, 1);
 		if (chdir(discovery->worktree))
 			die_errno(_("cannot chdir to '%s'"), discovery->worktree);
-		strbuf_addch(cwd, '/');
-		free(gitfile);
-		return cwd->buf + offset;
+		discovery->prefix = xstrfmt("%s/", cwd->buf + offset);
+		goto out;
 	}
 
 	/* cwd outside worktree */
 	repo_discovery_set_gitdir(discovery, gitdirenv, 0);
+
+out:
 	free(gitfile);
-	return NULL;
 }
 
-static const char *repo_discover_implicit_gitdir(struct repo_discovery *discovery,
-						 const char *gitdir,
-						 struct strbuf *cwd, int offset,
-						 int *nongit_ok)
+static void repo_discover_implicit_gitdir(struct repo_discovery *discovery,
+					  const char *gitdir,
+					  struct strbuf *cwd, int offset,
+					  int *nongit_ok)
 {
 	if (read_and_verify_repository_format(&discovery->format, gitdir, nongit_ok))
-		return NULL;
+		return;
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || discovery->format.work_tree) {
 		char *to_free = NULL;
-		const char *ret;
 
 		if (offset != cwd->len && !is_absolute_path(gitdir))
 			gitdir = to_free = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
-		ret = repo_discover_explicit_gitdir(discovery, gitdir, cwd,
-						    nongit_ok);
+		repo_discover_explicit_gitdir(discovery, gitdir, cwd,
+					      nongit_ok);
 		free(to_free);
-		return ret;
+		return;
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
@@ -1250,7 +1245,7 @@ static const char *repo_discover_implicit_gitdir(struct repo_discovery *discover
 		repo_discovery_set_gitdir(discovery, gitdir, (offset != cwd->len));
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
-		return NULL;
+		return;
 	}
 
 	/* #0, #1, #5, #8, #9, #12, #13 */
@@ -1258,37 +1253,34 @@ static const char *repo_discover_implicit_gitdir(struct repo_discovery *discover
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		repo_discovery_set_gitdir(discovery, gitdir, 0);
 	if (offset >= cwd->len)
-		return NULL;
+		return;
 
 	/* Make "offset" point past the '/' (already the case for root dirs) */
 	if (offset != offset_1st_component(cwd->buf))
 		offset++;
-	/* Add a '/' at the end */
-	strbuf_addch(cwd, '/');
-	return cwd->buf + offset;
+	discovery->prefix = xstrfmt("%s/", cwd->buf + offset);
 }
 
 /* #16.1, #17.1, #20.1, #21.1, #22.1 (see t1510) */
-static const char *repo_discover_bare_gitdir(struct repo_discovery *discovery,
-					     struct strbuf *cwd, int offset,
-					     int *nongit_ok)
+static void repo_discover_bare_gitdir(struct repo_discovery *discovery,
+				      struct strbuf *cwd, int offset,
+				      int *nongit_ok)
 {
 	int root_len;
 
 	if (read_and_verify_repository_format(&discovery->format, ".", nongit_ok))
-		return NULL;
+		return;
 
 	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || discovery->format.work_tree) {
-		static const char *gitdir;
-
-		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
+		char *gitdir = offset == cwd->len ? xstrdup(".") : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
-		return repo_discover_explicit_gitdir(discovery, gitdir, cwd,
-						     nongit_ok);
+		repo_discover_explicit_gitdir(discovery, gitdir, cwd, nongit_ok);
+		free(gitdir);
+		return;
 	}
 
 	if (offset != cwd->len) {
@@ -1297,10 +1289,9 @@ static const char *repo_discover_bare_gitdir(struct repo_discovery *discovery,
 		root_len = offset_1st_component(cwd->buf);
 		strbuf_setlen(cwd, offset > root_len ? offset : root_len);
 		repo_discovery_set_gitdir(discovery, cwd->buf, 0);
-	}
-	else
+	} else {
 		repo_discovery_set_gitdir(discovery, ".", 0);
-	return NULL;
+	}
 }
 
 static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_len)
@@ -1936,7 +1927,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	struct repo_discovery discovery = REPO_DISCOVERY_INIT;
-	const char *prefix = NULL;
 
 	/*
 	 * We may have read an incomplete configuration before
@@ -1961,20 +1951,19 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 	switch (repo_discovery_find_dir(&dir, &gitdir, &report, 1)) {
 	case GIT_DIR_EXPLICIT:
-		prefix = repo_discover_explicit_gitdir(&discovery, gitdir.buf, &cwd,
-						       nongit_ok);
+		repo_discover_explicit_gitdir(&discovery, gitdir.buf, &cwd,
+					      nongit_ok);
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		prefix = repo_discover_implicit_gitdir(&discovery, gitdir.buf, &cwd, dir.len,
-						       nongit_ok);
+		repo_discover_implicit_gitdir(&discovery, gitdir.buf, &cwd, dir.len,
+					      nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		prefix = repo_discover_bare_gitdir(&discovery, &cwd, dir.len,
-						   nongit_ok);
+		repo_discover_bare_gitdir(&discovery, &cwd, dir.len, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
 		if (!nongit_ok)
@@ -2103,10 +2092,10 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	 * out where the repository is, i.e. a preparation
 	 * for calling repo_config_get_bool().
 	 */
-	if (prefix) {
-		prefix = precompose_string_if_needed(prefix);
+	if (discovery.prefix) {
+		const char *prefix = precompose_string_if_needed(discovery.prefix);
 		repo->prefix = xstrdup(prefix);
-		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
+		setenv(GIT_PREFIX_ENVIRONMENT, repo->prefix, 1);
 	} else {
 		FREE_AND_NULL(repo->prefix);
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);

-- 
2.55.0.795.g602f6c329a.dirty

