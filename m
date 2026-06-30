Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CC940682A
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820081; cv=none; b=k3P6amI7Iv/+9841k1k6lrVllIybcHI4XUGgove8edkZ7PWajxCqWbz+m4siqh5gyUI5KUM702VlS7tuclXOseQGC0nf2mfDLnrSLj1h5IYuDAzy/CbizGkkCy2vcPqsfm7Ewu3xOQAqKb2RpPwSQzAiFZnuxfFv6GXfk2eRduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820081; c=relaxed/simple;
	bh=GkUHoDFB9Yc9fRUUgEV6MgbZTSB5mkTUFMvNKlfrB/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7/U5XKXuQwDnFpisyr5wG9aZ3LsIFLwHCYiHKRyFhHEZxgcanVlfhk+4L+YvGsRaDALdDtoPom7LSJBmK1+WGjGNM4elDm9v9aWAHz6Agr9xYSLvr10MmxknEGe0vLLwsCDfneCVccZJ7sC+upnDVFVjusqRmdM816XtMaiUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=df6ZdVZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kt+mbESx; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="df6ZdVZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kt+mbESx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C590C1D00132
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:47:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 30 Jun 2026 07:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820079;
	 x=1782906479; bh=pE7XfFDQOPNF/dv9FFPTz8czgl54VFDQPD1lwf4A2s0=; b=
	df6ZdVZJojQxz0YIjhxtPoZLOE8F3dhwCLQB9jzYn4C5f/IGzp3/Ux3heWdt8HwZ
	7VxgDKFbcc10c/EzXjNCtZIJcZp6xPLFva4gphdJFgQOSPb3hIXkinXrBYanm0Xi
	M5N25g9P9vTSaald9Pc+QcKeBXJD4zrusmUFbASJop7xyfBx/GxMxkeWKkRSFxGc
	sP3ZRW1FvbGqyETpjBtuZHarLm/ufC6z3mDeL8F1u/1A3L1cYYbLm0udY/QyGg+F
	Of65SOXM+ofnLBKSp3TjU1jl+0uMcAtz6yxO0QdO3r2WYDNy2K4NM60t6ypr0LWx
	Wa/O1RWDC1FfvCVTjdKkLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820079; x=
	1782906479; bh=pE7XfFDQOPNF/dv9FFPTz8czgl54VFDQPD1lwf4A2s0=; b=K
	t+mbESx3dTVH1ZGVlcOGvQrTX5DfdpNZvLFx0GMzLOWOft7Zb9T7zIU/nJ8gZNqP
	EYDerDBDRzaxwFGb3A58tyaOobnGyZcCILQbh9KCpUuSv59t3sKEJFJrFVdK2FDv
	5UWuym29FIxKJvm5eOZG8ySl2J1QePi1oJTxcCCGq3TzzjL9w2amsXNkyMbdNzfy
	JJUoqEfsIvynjek5N19qJ5X95zzzeo249Du9F3uxSetWYKRcD+dM7CYhZZlnRLt2
	wxlyy3VnB0uNWape3ZvrB83Yhe1EFj7L/meIf1R15YoTyJ2gNLftDJeneRmFcb/b
	ilhieX6t7eVRyFLcyN7Eg==
X-ME-Sender: <xms:76xDaogwSoXwyDkv-7jqzTrQnIQgGkz0PbxRSEVwBIPDiOZyyDS64g>
    <xme:76xDan_uMLzJmwQISyPHna9k3OjI8p9f3-9t0r-7xEmBcFLz1IvRqO9CwhwytiurN
    j-qZ34fMnnXuRAz--h4mVBFIBLcMtj-dz-_RYppRmFw1GQxRlbXxg>
X-ME-Received: <xmr:76xDalsRUpL69avPY0oYG7zRlsCjjoVO_HTY29iBNJdYbvn9LhfcgYmSJU5ga4erHX2FIt9CwCkyZ1bBZgwGtH8oYVPvTqTHRXEayisVPlN5Qg>
X-ME-Proxy-Cause: dmFkZTFDZ8EBIRkLTKt14TuSGr1p9PVZekTad1c/wqf+J4rUdU57yUeNCpU56+znu8nsjb
    fYDR646+CJ3TGFv8kQTHR4VNBrT/tkMeSXjzT67aaHpKiIdg7Ex7ASQFMr3pvovOMeWRc2
    b+Hb+9BEYhuDH+pmqgJy7oGhS1oPcxj3Hy28pR4Uz81T3ewRUNKEnbf7HExREqmx77S7CO
    8q4+s9ohDmUs11CzmmSQpKP0fvZO9hDzS3HZYuZIL2rRpsr/my7MnY/OfRKNFc3m22a8aE
    0HfNWlTaLhp/UB/uVY+/uRI7kUgfffb/QcAn+DT1zAl/2aW3MU8z9wRoF8TwRTtj2Jqplb
    xgVWR6mSTKKo7Q10XlnLyWort4FC252i8Zze5nakiq8+LZSdtwMAViLnoo8lEmIVjQfqNy
    Nu/tcVrhpUxD2hV/27XWlUCJog3frLNNC87ruTm/wBosBquVpmnJn+7SC0VDiJ2n1IeQee
    JVgOokV/n4s7+xd1PeVsIBU1DVmB/2wO3gjuYIvDt7NMkysK1HGkhz+2jvZBwaeS4q9aMI
    7QWBETQ0+hG8I5FnbXJCgKp/36uJk7DeTyTIImCOMb5vuWwLndiJmAaLMHB+6wiBbo0smW
    dNxVpHCIkx6JmMW1HUrzIM1N1g0P0zWXzn832GagKB66ryvegwPgsUfNh17g
X-ME-Proxy: <xmx:76xDauam4lp3W8lexLUI1lH9UwEgbQmFxGYyGJxWN9DNb2gEjKBA_A>
    <xmx:76xDalqpoEVQUJEDNJXYTrt0LfWpz1ehhR4golm_3aO6Dd8BXqHzVA>
    <xmx:76xDaj_kMeqtGBDmJWw-EhpAvRGvYEh3jMSLnA4RThhbNOFxE0sbTw>
    <xmx:76xDak_SYaXusnDlLWGLgMwerVVDYyIHen-i-0T4kNzG8xs5j0S2EQ>
    <xmx:76xDath7Bhsjm4HSFmYCf54LO5LsOGQwJxVWJ-yrjTWpkyctzRHIEHpj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:47:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b980b1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:47:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:41 +0200
Subject: [PATCH 02/13] setup: mark bogus worktree in
 `apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-2-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When a repository is configured to have both "core.worktree" and
"core.bare" we emit a warning and mark the worktree configuration as
bogus so that the next call to `setup_work_tree()` will cause us to die.
This allows us to still use the misconfigured repository, at least as
long as we don't try to use its worktree.

This condition is handled in `setup_explicit_git_dir()`. In a subsequent
commit we'll refactor this function so that it doesn't receive a repo as
input anymore though, and consequently we cannot set the "bogus" bit
anymore.

Move the logic into `apply_repository_format()` instead to prepare for
this. While at it, fix up formatting a bit.

Note that this change requires us to also explicitly unset the value of
"core.worktree" in case we have the "GIT_WORK_TREE" environment variable
set. This is because the environment variable overrides the repository's
configuration, and we don't want to warn or die in case the work tree
has been configured explicitly regardless of whether or not "core.bare"
is set.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/setup.c b/setup.c
index 118416e350..f54eac5e5a 100644
--- a/setup.c
+++ b/setup.c
@@ -1147,24 +1147,24 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	}
 
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
-	if (work_tree_env)
+	if (work_tree_env) {
+		/*
+		 * The environment variable overrides "core.worktree". This
+		 * also has the consequence that we don't want to flag cases as
+		 * bogus where we have both "core.worktree" and "core.bare", so
+		 * we have to exlicitly unset the configuration.
+		 */
+		FREE_AND_NULL(repo_fmt->work_tree);
 		set_git_work_tree(repo, work_tree_env);
-	else if (repo_fmt->is_bare > 0) {
-		if (repo_fmt->work_tree) {
-			/* #22.2, #30 */
-			warning("core.bare and core.worktree do not make sense");
-			repo->worktree_config_is_bogus = true;
-		}
-
+	} else if (repo_fmt->is_bare > 0) {
 		/* #18, #26 */
 		set_git_dir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
-	}
-	else if (repo_fmt->work_tree) { /* #6, #14 */
-		if (is_absolute_path(repo_fmt->work_tree))
+	} else if (repo_fmt->work_tree) { /* #6, #14 */
+		if (is_absolute_path(repo_fmt->work_tree)) {
 			set_git_work_tree(repo, repo_fmt->work_tree);
-		else {
+		} else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
 				die_errno(_("cannot chdir to '%s'"), gitdirenv);
@@ -1176,15 +1176,14 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 			set_git_work_tree(repo, core_worktree);
 			free(core_worktree);
 		}
-	}
-	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
+	} else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
 		set_git_dir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
-	}
-	else /* #2, #10 */
+	} else { /* #2, #10 */
 		set_git_work_tree(repo, ".");
+	}
 
 	/* set_git_work_tree() must have been called by now */
 	worktree = repo_get_work_tree(repo);
@@ -1768,6 +1767,12 @@ int apply_repository_format(struct repository *repo,
 	if (verify_repository_format(format, err) < 0)
 		return -1;
 
+	if (format->is_bare > 0 && format->work_tree) {
+		/* #22.2, #30 */
+		warning("core.bare and core.worktree do not make sense");
+		repo->worktree_config_is_bogus = true;
+	}
+
 	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
 		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
 		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));

-- 
2.55.0.795.g602f6c329a.dirty

