Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6643C10BA
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408921; cv=none; b=uMyF3qo4wHUk4r8pOUbXjuMfeluwm9sPjLzNEpUN4wdbuuhORddsWQBamY22TI6Kd2NbDJ+/pdUjyK5iephOK9lUiPjYSySCIJkq+qqes1vIol2SlWz5bdtddAtbTy9WotS37AIdPZ41B1caKl9G4nhwuiLBurCJwWzdOZBvumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408921; c=relaxed/simple;
	bh=PqIHg+4TiNDhOrlYoj9lJVw5wYgYYLH/4CIeQ7ueKcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I77L2MEmfitBV/zMsoPAknpUwJvmSr/1aZz0x97mqqJiNZjx62SEd8yLfFcNJOknmxd0+gUvZoFfM7HBL8D6/EheA/kHNey6lzLYilxZjeih6cRVHbD/A+6r/Cm6kRoAvVF+1zOd5H7emdtmiapC4+Mf9UPVibmSUaw+Wlh6CUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OOf8SdRG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o+AP6N81; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OOf8SdRG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o+AP6N81"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 179087A01B7;
	Tue,  7 Jul 2026 03:21:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 03:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408913;
	 x=1783495313; bh=8kBY6Xcul0OOaS/jMaUfFKU8itP7XN86L0atYYS+w0s=; b=
	OOf8SdRGtMBPO4KtXV/QyuCbX1ZKnI9WQESwSqWIQQzTTyfFcZIOvnRItOM85V3p
	2+Rl5dTtwlaug/BFZOjA+OjXgiFuRIqMEX506uhJiZ7+l+oUsMpT5Prb39kt6To/
	tSvuKIofh7a8zk81I9Z/zPpBMaqB7gTjPBDqGmY85cYQxbj/7W9RUVWEc0k63382
	avDuFkfUlbIqJMrFuFllfYLzD0Qu5BEUvZT0AvEqQyW99qDrT2ZRIMcH2vZBB8sH
	742Z/UwYVYo10JpC6WzRlAmmUbBw1r2mguUU34PEvf32290OOoGRK8jPWoMqSZY/
	eV9a1kCCj2UwEdYz5/lalA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408913; x=
	1783495313; bh=8kBY6Xcul0OOaS/jMaUfFKU8itP7XN86L0atYYS+w0s=; b=o
	+AP6N81yZ18MZ0cpzvFV/SlegEnd8c79zkIeoFD/ajVAK5Y5NldjkPSRFQGinanV
	lcbnwzvZLMJ38R85+TabWP+KitRdn2kycaAHuE5lSu62BRpmjSkGZY8RN17g8oMW
	cQq+4PD+WGemd4nJEYrTASJsaoHyRAV6pDXEizLNea9bFuRcnv0XZ/2rG7nZFo+Q
	8xBmb7c6tYaJHbm2nlVrgf/17ePv4v0MofNAUqwjKcwwoMR+v/FqiU9RPO9q8RSW
	AXvstnVEBR3EHZlwRmgE9+9fQULP/kaKqjFDv8pytQddEfHuc6retGi9ua5WT9yu
	ij8d1YcU5tInNEq0Ob3RA==
X-ME-Sender: <xms:EalMamn3kkTkXHsOGuvBmtXcn2VfmPM5aW-mSTQQpYDh7AgmeaThmQ>
    <xme:EalMalSleRH0eAQtpwQPq4Dyk76x0wFchS_HUnHFUM7IsRHmitF6MU_szvf3M_zMH
    1ybnNG87rYWcSfKCNhSYcygc_Oda3Cw1fo2vGHuBqfFIxUtXwNt>
X-ME-Received: <xmr:EalMaiDlQjEbxYlkThyHN-6--EBLtOeWKSTIns8nHark4_swY8N38isvvtPUlDp5FacdLcRuAH6k6gfDfe53LLWyAzHD9pVeap7LKCyWWw>
X-ME-Proxy-Cause: dmFkZTGKAvr14F7nvXdoZbk+j5UECdqZ46XceDm8fH4HU55Wn3MF1zUU7dUev/9PgWnxje
    s4i3lCinxH3UEfctPt/BZm/TsXb8ELLDCH3cAyfPcp6p7gf3Hh8dQEgHm9Ok0f8pOKye7W
    wbxmHyV/dcuiqcq3ICLKHqkGWRJEYoV0elNG3mmEVsH/wT5MLP8wjFwZ3+E86FATxcwzc6
    x/DdHPALJarIGIyobmY3X1TnUFcNFIjUQHBeClc56excJmH4VX/yYW4TR4fTS+jQHkWni2
    f/7bEMW7v1Ep7GBiFspOW3bEdoGMz61GV7Lrfw+vkXQZAXaDlRB3fMW72NE2obS1xVLlQz
    SuvVR2QFR255p1faKEyxwx4r0DZOKUgGTeYzGjcvlhdoyofY+fXUa3Z8ncTWbwYFNix7pf
    AxNhZl3OzDpBM+exwxxXpvTDSCkvZCHrTzS2TWbc5KllOR2FROsLkfRiwIQFYcK/G/6xRm
    SW0mibAPum+1rzeelcpmhdI7w9cD16l2SFllb77mT+BBDNSOBgciqbeA5siWk8Bs2g3lhJ
    4oTJvEej3vFlhREzX+HPZwsJj8+BUvTi565QTTKxfYllN8uUtjYMRhqEgmLJLkUWApdt6R
    O3v2bd5011LURj0TFHNzTEy5fehKxyH7JHaeNFN7I/14eIROfD6+OcM2eLxg
X-ME-Proxy: <xmx:EalMakTSoPUh9GGD4druJETQx4WtnZR2T3YakauQr_byBILioPrVvQ>
    <xmx:EalMaooadEtFFlcefne92ksYqbsls9qzDrDx7gw22RSICKA39OGSeA>
    <xmx:EalMauzJEJ6rjrMYdFBAUG-I1iN33U81159-6VllfDvd-9l3TUp4kQ>
    <xmx:EalMalIL852XEpa2txLKc7Yf-OS7xBYjMCPLt6v9eebwbbE-6bW0FA>
    <xmx:EalMapTAV7wFdphM9axI58KxdkBjxun7ThLyvGlT_d2YG5D81jHfETLM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57ceffd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:28 +0200
Subject: [PATCH v2 09/13] setup: propagate prefix via repository discovery
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-9-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index f8e4cf100b..d1db0a4ca0 100644
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
2.55.0.141.g00534a21ce.dirty

