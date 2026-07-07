Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097E3D648F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408916; cv=none; b=lLpu6aChvT8KqxrFsSmgfpKmMdCx1iitA03dGPlJWgg1h1VpiF5lIU8e84fuvQkDxPzrNDjnIUfhyTaJodsmG0ELFd7Y5N4aLGMZe/y21nXKvvnU2MeKiX93yLnoFAMz/Yt3uBhlPenjnDhJ5E/u/KFiWXCB8iyLXV3czhqfy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408916; c=relaxed/simple;
	bh=Yx+icAC60PGdA2vorv9uOVNPRaxY3Da6InarO/Otjk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SRWv7mvovAv+iwaaTzlDtArfJcTQxtJFuFiI8CxiZOCK9xFArFRZvBuAZSLr7Dt2f8hpSTc7beob7hfdqELP8ojUOK2jUG6MLC7yE1i1EjHCvRq3dtvRTswxRCQ9Oy00y+pMmpX1hKQpV6g8fztJvTNwG0J1+4LK1qVZKOBCUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f/O9lexB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nOIbLkKQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f/O9lexB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nOIbLkKQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FFEC7A01C4;
	Tue,  7 Jul 2026 03:21:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 03:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408905;
	 x=1783495305; bh=RvXYW8fuJCWj9QasRQh/tiZkhNztOS1xYTbYuJrtsqE=; b=
	f/O9lexBnWUzg1A+uo/oxGHZmZDCrdBrHYmZik50FPc5oq3kSq9uKYlNnoWrT3R0
	vaUO78aAbPRCxT1yYamXTM3j6jzOeWx2EOjT6Ep3CuWRGCKEWoiKwneCMSjK3C8J
	nwlQkNXuA/Yg4FdqSbFQuJPL21D0J4ttBHHfz+Ii10TZmdXOZ1jfUxWjQXb1WCvZ
	8JHliy3HhNmPMmF/BQjNMiUWp14nsPttK1KI9H8PRRGXHineTLkdygkpxvsJvGDG
	UmcgC0l/jcAFTwHsTWlxVyMaJvYI3Ub9nZZLAW5yuuoRmDrJYRN145pzK5zAkHGE
	Nm5MQd9NnNlNPsIBGKfocg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408905; x=
	1783495305; bh=RvXYW8fuJCWj9QasRQh/tiZkhNztOS1xYTbYuJrtsqE=; b=n
	OIbLkKQ6PL9rd1sd9I58Pcc/d27Ya+icwWcPyo3zx2Yg0ReTMqZEp3M6veuE39jn
	XiDugfq0dJM/1vDUUCYwzRJ8GcWzzHBKU6wTjBmiNo6dNCKVbU6i1N8pw5neQleR
	572IjwitUIBMpQLIP3hu+KKioC0w+OeWPRBbmowoh0/kpZx07/L5FrtYRXF0a4Jp
	xzgCsdI0+D5HKucs2uvrEaHUFL5DLr+fIf5N+SDf7RDYOoZTTkkgITNAc9IPXjCt
	I6fwzKenxg9PW0CH/CtEvbgXSLDZ5R8BklvCAapSqDyhJKzZjOPy/FgUR/2eB6ap
	IS0cJtPC+R2Esq2wb5/eQ==
X-ME-Sender: <xms:CalMaqHOOLKWPtqyOnMKNwb0RT1ra_lEKF5pXOGR0Uwk5oVY9RwGRw>
    <xme:CalMaiyYErjEIVPF7h2Bcozrg4cL5nElVhHUIKy81lIg_xhtig6KBUDakrzGyqkOu
    as65qKUHEasgDGlhWHu0afE3_qyFCfQrDlv6Xira7Hd50uWubunFCU>
X-ME-Received: <xmr:CalMahhbsLnQbi9-VWiCHk898lzlUGI3X8YKNPmdLCUZ1mXilqxZdI809APDppmSiucs8f02yO9wG85dkKiI4cnrxenxkgthxdmKAwYzlw>
X-ME-Proxy-Cause: dmFkZTGomioUiHYnWpDoPUhdAmR9I7dqVaEHetQ5+YM1W+jDtBm0Kde/Fy3ikeFpi8hzA0
    oBzpzCZlTaRL43+aE5094ahYwDC3jzOH1vcT19QLr0ETwXdRhRCcAtLgAOrEmLMKXMMNvA
    l8kQIXQEwRkhR9TvHCqCIE9rePoXRNYhOVXPI3h5LS1k0B40dHXVFkJmTH0Kl3XUcgfpLL
    L6ieIXUbr19e92eAiOuNGzkxuZJsl7xoQeE1qCZcbuKTBYR2/o6iXOm6ZeKjNTcG1ZI1kl
    bhUOGyGZD1As9R+Za/xgdLezrYw/x85BTHjMsoUJg4kwBdWLTuf6f8AUD2TD3Cu671WLOT
    TMP2df4sXAnQlRNSxp5+PSP+CrEF8jxiisBpw0MSBz53RkSelX2KMjkIl4HBTGC+//1K5d
    Dto+sbE9VEUNf9YG1DVHJ2zWGtacm0WHliRqrwdGoV59bTarPV0ZKxXF+R6z2LXfCoi+VH
    uq7FqepGtdrEpYf+22yCzRlP4zse2dENOalzMGDGZ2hPyt9S62dJBG4BSJM2F+6EvzetS7
    Rml3SCjfV7r2SJJX0/zL/gTvjLn29eKWX07iQjgBumJl1U/+mYBi3ooydpHstocALwbOH9
    7h7OGnfT63adfWE2C4n4UIVZqFsm6FVEJJPE0gMVAFL7gnq0227FPSO5wu7w
X-ME-Proxy: <xmx:CalMatzc2DQUhaYTfqkmvy02NyUtPtdayHTVGi2orf7Gz1rvi9XO4Q>
    <xmx:CalMakIt9SO55K2EvgYjGYZCIdMgj4D0LrB1qBSgVj-OQaSh8IV-4w>
    <xmx:CalMakQSd5Xt9QwBMmDPJ1qcuML0F5hAvPbHNqSQlMkSuodqABEHDA>
    <xmx:CalMasrontopzsnvbnwYCd5CeK-vT-XAVDrujbNiwEhIUahnX6mIuQ>
    <xmx:CalMamyxs9YReLgIWiXJWT0Z369WJJ0X3_bNk0piH0w1be_457cOL_zf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 089c07a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:25 +0200
Subject: [PATCH v2 06/13] setup: embed repository format in discovery
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-6-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index f713d024f7..b755693572 100644
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
 		 * we have to explicitly unset the configuration.
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
2.55.0.141.g00534a21ce.dirty

