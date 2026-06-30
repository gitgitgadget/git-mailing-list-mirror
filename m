Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71823FC5A
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820092; cv=none; b=cv/vSp8SrqoZOrTU1FTf9qs9m+FP9KEdtW9JSZTuboY9tIZdtTglDSLtieDXYuoJzlw1iOSfZLXFjSIZUCKEk0g6xdXDuP0VUj79hybJorOLJJ6RhdlB2uOZD1veRX1e4XPScLQKIF4ell0PO2gQUTEW/ZPPUCK4oCcYVYk7y3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820092; c=relaxed/simple;
	bh=GXDxPSSmXvjqnbNfC413icjhksyY3/5v1pL5+JZQzZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fnAKOOIcO2LEYFZNR87DI65gy5q+53vaFmmlOZwSBKrj7z8PYgL+Px64SMT5j/BuvPMOD2qA0R8tSgoph43SVktBZcl0osuRKJ63mWwsl0TyKnEuUZ4Km6j9OVO38fgF7XxIiyg+JusKCkUh04X3lFL6fBZmXBzTPE/M0Q5yAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WJjR7PnG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F/nC3iKG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WJjR7PnG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F/nC3iKG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1963E1D0012C
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 07:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820089;
	 x=1782906489; bh=2bKPc9ZVYATGL+tro385Y97ERjw/lRWu7YC4i+aLsPw=; b=
	WJjR7PnGxDpHdcV1nT407cF+ut3j6fLBDKj6fjYy9EiUiKcIAKG7MWMfZw43EFOh
	fOsgHLvlmZMgpwpJ5+DCWg36tP/HYCq9uQVzV5/yJQ66YNyI4h8aiAbGB2Jj+71o
	Usd8TxVOyKwTmrMbpha7SKY75+5rHy8N7f3Pvc2rnmXcLIFlG2JHzn5POOflttI2
	l1z9onNCbkSsdnkFHS4rB9FL8iGWb7x6ghqKHXs1NTP6wtEVSnkLkl+awhCiYjMX
	TAFxc9/fFB6AziL7IcUNSHdPR6/ScmhidPN1Ftw/dF9kcgez0ZbcXLcsMaArX6US
	bcGJ+qDXBrGmQBpIuifGSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820089; x=
	1782906489; bh=2bKPc9ZVYATGL+tro385Y97ERjw/lRWu7YC4i+aLsPw=; b=F
	/nC3iKG4p+Onk7MtHnVGIWv1XGuOijvS/aegwcH4JdQDsZNblOqJJUSd8Jn0N0ya
	t4qQr1ylK7HfMzIb5Rs65DLl/rrEpErgkZVb61GiPCxIpxuGYlRn6sE+O6mWSHss
	gNvmyXZDpJFoZJ0dD7LgLIfkqjTyg+b1f7BFQPsF9ZcG66BTsVVJiUeDjaF8577s
	L+EZYzKWV/tKjeBjzDp85iKzUldphLyNWgtvvedBxfawfuXQe/X3B/KRUKAUPC5r
	YiNQLli5Ym8MuAgOcufTX9tvq47gJRZi7y17nZAM5ZBOCZk4hHrXQl0S54fGDE78
	Slu2c6G1j/N58dU0dnuhg==
X-ME-Sender: <xms:-axDatNBpVVeluAKod4huB5DSH4PWw7_KI1NMZCn5i3V6BxQmgp3hw>
    <xme:-axDam6tpD85fScVcbd9asiD3wK9gr2Tmv_3gVp36XZfPQ_Uprj_6bm-QQ9C1d2dD
    1b9f4L7ZISPUv6Uf6tI61sjc3EPHXT5P6SgVCSgbRkXl5VmnnEw>
X-ME-Received: <xmr:-axDah4Xec4WHrOuaLhEhtQhGAFmQQjoLg3dwmGgFbPI1LaCZIUqrr1nA2OYbS1XBnDeIKdVTM48s8D_y32fSDSKV77m7xEHuYybmJPVWuVDvA>
X-ME-Proxy-Cause: dmFkZTEHKyD9k4hs6CMGZE9u/eOfhZPMS1hUt9aCAd0rwwggXlz1iqnecuSzSLoVYUhX8e
    yViKLJTXKCJk/U1aXM/giAOkhFYoWbRlfYSxDxDo+mkMwSHMhQC6FrDuORj7dRnjikTX2Y
    6HzH0qqQDLq1N0uEFeKjsP6t6uvLFVrcZJHz3hVqO+fHSH1qcCA0IF2x8AH65bcoBH3YYB
    kd4l8sQp/7kAcAYFOEUcuxccPu31t/xT7Q7P5JpFqS/TjE2iMbdJUZamt/+5h73tfY9WzG
    lSKmirUZ4Kl7n7yUMsjNbgBjgs+74oUdDnMYKJ8cSam58SE772CzVaP7Z8Oa58nsNS44JR
    SI78tR9uDx7ozfH6os4o8IpJ0pC+X3CY1wofbwCL2NaLycYjkVYEsX1KuHv3Az9Xd+/dyi
    8bcUe8Zq/xqO512wS2jwAZxSpe9CvBhtjDodOlrIhLg3rWRmZIAb3Db2XKpj9pTAfz9FgG
    rhg9FfhsnWBccJ8GscjC/Q46REtNwGd8ermgE8CPNfN+BhkoJCTwrESdRi66bzttCHvuyy
    bq3n+LBTPxIIRzpHWTKG615xcY87WF1BECjFO69EQgjl4Y6pSVP6xnNS0zKK8gypC+s7M8
    wLXt8o/U5HszRnW8/AUA5Xf9VKp7OrDrlxYQi46uCqGbhKA8+2vOpWNDVLzw
X-ME-Proxy: <xmx:-axDau1McXC4bJNRB4jpJ8ZoY6IMKygisnNt4p49KF0Ypgk9Nk_cYw>
    <xmx:-axDalWk-7yPYVLc-CXCi66_pGVRxW5UPycgB4rhc9HEwh5jqu3GdQ>
    <xmx:-axDah5D0IIVp1m_ktpN7rrAceiJmT_SstQYaCR6HiKzpkq5XS8AYg>
    <xmx:-axDakKRoMHXBVV5Cly-wHLUgeJuZWOx84begwzuQVCu5i4eM25Ggw>
    <xmx:-axDap-xtozjbf4PUKPgVdgrBJOFLRGqDALCOpKUjvkgdiYETJrzvY4U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 89a947fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:45 +0200
Subject: [PATCH 06/13] setup: embed repository format in discovery
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-6-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

All functions related to repository discovery receive both a `struct
repository_discovery` and `struct repository_format` as input, and the
expectation is that both will be populated. Refactor this so that the
repository format is part of the discovery result.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 60 +++++++++++++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/setup.c b/setup.c
index 06768de23f..0185257b2c 100644
--- a/setup.c
+++ b/setup.c
@@ -1091,14 +1091,18 @@ static void apply_and_export_relative_gitdir(struct repository *repo, const char
 }
 
 struct repo_discovery {
+	struct repository_format format;
 	char *gitdir;
 	char *worktree;
 };
 
-#define REPO_DISCOVERY_INIT { 0 }
+#define REPO_DISCOVERY_INIT { \
+	.format = REPOSITORY_FORMAT_INIT, \
+}
 
 static void repo_discovery_release(struct repo_discovery *r)
 {
+	clear_repository_format(&r->format);
 	free(r->gitdir);
 	free(r->worktree);
 }
@@ -1127,7 +1131,6 @@ static void repo_discovery_set_worktree(struct repo_discovery *r,
 static const char *repo_discover_explicit_gitdir(struct repo_discovery *discovery,
 						 const char *gitdirenv,
 						 struct strbuf *cwd,
-						 struct repository_format *repo_fmt,
 						 int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
@@ -1152,7 +1155,7 @@ static const char *repo_discover_explicit_gitdir(struct repo_discovery *discover
 		die(_("not a git repository: '%s'"), gitdirenv);
 	}
 
-	if (read_and_verify_repository_format(repo_fmt, gitdirenv, nongit_ok)) {
+	if (read_and_verify_repository_format(&discovery->format, gitdirenv, nongit_ok)) {
 		free(gitfile);
 		return NULL;
 	}
@@ -1165,22 +1168,22 @@ static const char *repo_discover_explicit_gitdir(struct repo_discovery *discover
 		 * bogus where we have both "core.worktree" and "core.bare", so
 		 * we have to exlicitly unset the configuration.
 		 */
-		FREE_AND_NULL(repo_fmt->work_tree);
+		FREE_AND_NULL(discovery->format.work_tree);
 		repo_discovery_set_worktree(discovery, work_tree_env);
-	} else if (repo_fmt->is_bare > 0) {
+	} else if (discovery->format.is_bare > 0) {
 		/* #18, #26 */
 		repo_discovery_set_gitdir(discovery, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
-	} else if (repo_fmt->work_tree) { /* #6, #14 */
-		if (is_absolute_path(repo_fmt->work_tree)) {
-			repo_discovery_set_worktree(discovery, repo_fmt->work_tree);
+	} else if (discovery->format.work_tree) { /* #6, #14 */
+		if (is_absolute_path(discovery->format.work_tree)) {
+			repo_discovery_set_worktree(discovery, discovery->format.work_tree);
 		} else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
 				die_errno(_("cannot chdir to '%s'"), gitdirenv);
-			if (chdir(repo_fmt->work_tree))
-				die_errno(_("cannot chdir to '%s'"), repo_fmt->work_tree);
+			if (chdir(discovery->format.work_tree))
+				die_errno(_("cannot chdir to '%s'"), discovery->format.work_tree);
 			core_worktree = xgetcwd();
 			if (chdir(cwd->buf))
 				die_errno(_("cannot come back to cwd"));
@@ -1222,14 +1225,13 @@ static const char *repo_discover_explicit_gitdir(struct repo_discovery *discover
 static const char *repo_discover_implicit_gitdir(struct repo_discovery *discovery,
 						 const char *gitdir,
 						 struct strbuf *cwd, int offset,
-						 struct repository_format *repo_fmt,
 						 int *nongit_ok)
 {
-	if (read_and_verify_repository_format(repo_fmt, gitdir, nongit_ok))
+	if (read_and_verify_repository_format(&discovery->format, gitdir, nongit_ok))
 		return NULL;
 
 	/* --work-tree is set without --git-dir; use discovered one */
-	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || repo_fmt->work_tree) {
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || discovery->format.work_tree) {
 		char *to_free = NULL;
 		const char *ret;
 
@@ -1238,13 +1240,13 @@ static const char *repo_discover_implicit_gitdir(struct repo_discovery *discover
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
 		ret = repo_discover_explicit_gitdir(discovery, gitdir, cwd,
-						    repo_fmt, nongit_ok);
+						    nongit_ok);
 		free(to_free);
 		return ret;
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
-	if (repo_fmt->is_bare > 0) {
+	if (discovery->format.is_bare > 0) {
 		repo_discovery_set_gitdir(discovery, gitdir, (offset != cwd->len));
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
@@ -1269,25 +1271,24 @@ static const char *repo_discover_implicit_gitdir(struct repo_discovery *discover
 /* #16.1, #17.1, #20.1, #21.1, #22.1 (see t1510) */
 static const char *repo_discover_bare_gitdir(struct repo_discovery *discovery,
 					     struct strbuf *cwd, int offset,
-					     struct repository_format *repo_fmt,
 					     int *nongit_ok)
 {
 	int root_len;
 
-	if (read_and_verify_repository_format(repo_fmt, ".", nongit_ok))
+	if (read_and_verify_repository_format(&discovery->format, ".", nongit_ok))
 		return NULL;
 
 	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
 
 	/* --work-tree is set without --git-dir; use discovered one */
-	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || repo_fmt->work_tree) {
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || discovery->format.work_tree) {
 		static const char *gitdir;
 
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
 		return repo_discover_explicit_gitdir(discovery, gitdir, cwd,
-						     repo_fmt, nongit_ok);
+						     nongit_ok);
 	}
 
 	if (offset != cwd->len) {
@@ -1936,7 +1937,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	struct repo_discovery discovery = REPO_DISCOVERY_INIT;
 	const char *prefix = NULL;
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
 	 * We may have read an incomplete configuration before
@@ -1962,19 +1962,19 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	switch (repo_discovery_find_dir(&dir, &gitdir, &report, 1)) {
 	case GIT_DIR_EXPLICIT:
 		prefix = repo_discover_explicit_gitdir(&discovery, gitdir.buf, &cwd,
-						       &repo_fmt, nongit_ok);
+						       nongit_ok);
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
 		prefix = repo_discover_implicit_gitdir(&discovery, gitdir.buf, &cwd, dir.len,
-						       &repo_fmt, nongit_ok);
+						       nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
 		prefix = repo_discover_bare_gitdir(&discovery, &cwd, dir.len,
-						   &repo_fmt, nongit_ok);
+						   nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
 		if (!nongit_ok)
@@ -2078,21 +2078,21 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			if (ref_backend_uri) {
 				char *format;
 
-				free(repo_fmt.ref_storage_payload);
+				free(discovery.format.ref_storage_payload);
 
-				parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
-				repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
-				if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+				parse_reference_uri(ref_backend_uri, &format, &discovery.format.ref_storage_payload);
+				discovery.format.ref_storage_format = ref_storage_format_by_name(format);
+				if (discovery.format.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 					die(_("unknown ref storage format: '%s'"), format);
 
 				free(format);
 			}
 
-			if (apply_repository_format(repo, &repo_fmt,
+			if (apply_repository_format(repo, &discovery.format,
 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 				die("%s", err.buf);
 
-			clear_repository_format(&repo_fmt);
+			clear_repository_format(&discovery.format);
 			strbuf_release(&err);
 		}
 	}
@@ -2118,8 +2118,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
 	strbuf_release(&report);
-	clear_repository_format(&repo_fmt);
-
 	return prefix;
 }
 

-- 
2.55.0.795.g602f6c329a.dirty

