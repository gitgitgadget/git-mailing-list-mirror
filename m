Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9CD3BFAF5
	for <git@vger.kernel.org>; Tue, 26 May 2026 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775036; cv=none; b=rzIN1DX0bRT4ZE1pkrk1M1+xIKCDUiLHibYUdVlqm942WGxXrFX6NJm8aUjWxgEfJ4St+f/yK4RfaaxZ2yjOJWWcGLcMcMhomPkYCYjjHQ62GTjKAwpLUqPmE9EWOIXAH2ZejmLPzlFMlRknc51510+C4720eVxbdj9sHuenV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775036; c=relaxed/simple;
	bh=xHP637TQlqvDKtvrKPC/94Fg6hrDMSAG/5nbEiwlQ94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXvNDsi3Y6wUETajNocRgCTCL32V6XfaFwjobkDyLAw67sKqnDtoY9WEWPYVXyQ4kgUc2ydm1VcyeKpWbPTuxZ+gOvdg16hVc1r8VT9xnL+eg3idDEBg/n41qBn6o+a8RQvx61EmwDj8KDg96D/QJj1I1V9oeyvCBlyoLqI1DcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EmliudJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gzLYYytz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EmliudJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gzLYYytz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ECFB41D000EE;
	Tue, 26 May 2026 01:57:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 01:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779775030;
	 x=1779861430; bh=0RUnJTySf9RjQpFcVUaoJtDOKYJNZAI9mrgKZYgFkDY=; b=
	EmliudJrIBIwoFVBpH0ISiW/7kfoPbPbi4f/yJLp22Y5wR2XzUsZECnTCr8u9Aax
	wPS+IOQCKBeIQD+1g4Ynue7XAh4j/t27OqoCOK+cAPaHsO+UxFDz5lqsoe7Wmiyc
	2piBlDs6+W0sNAam22UWnuR51OD0SYAu4zuFa9giGGU5yB0F4Qi4nK9D70zU+vh5
	cIWb6sqs0T06BTMvwtncKQYlJ2VznbveUm9OMoOTn9NvKv56LZ8+uZTdsIHbnDl5
	l7Up1ZJHqUL1zz3SbI5KSVlHlErYZVIBhJKsEDyMprISSHc7jeXkC3SO0pMIwYoS
	zmOOAPVnSrLv0r5Zf0st0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779775030; x=
	1779861430; bh=0RUnJTySf9RjQpFcVUaoJtDOKYJNZAI9mrgKZYgFkDY=; b=g
	zLYYytz0LO7b/Dw9g8Jrq1iFZm+kXqN4dTn+ZysS1soseywpfkw2DXHi/YXdQFQj
	6pAmRDOVqAy07oig1vatvV53MYuMcDHjl5CdvCjo63+2nyZESUl8QAyYDEegGN2p
	FrVoUU/+Wr2dGTPwdZXrmKc4FgQnAomJAjCaY58DmsStYhn4H0FgJkpV/j2rT1Mh
	MSj+CqttzvadVZGk/WDNUia2KZPDhiKfLzFqodUMSA0ADZB8vPxBMNY83Nw2VK8M
	ye0PiYZZ+Lt/2U5tPuf5EKL5R9Gpq66udUO2mI0FgbwTAOxsXiXUtoAMgLSJ5+zH
	WURKuTkUPxPNPk0MF5KQw==
X-ME-Sender: <xms:NjYVapc5e8b9AzrXWGH9vOe-CdXB6ZFQs23zXKfYc4bC9l4_fryn9Q>
    <xme:NjYVauomO_Mpj0oteHAclIJoRbjFG0BpnbPfcqxJ2-gLMt9eJdAasImkEJwztzEtj
    xPraRHcbNjTgnHL0_-ZZZbCx6K5fZRzI5ZpTBl8hMmkOSPBzVib-Q>
X-ME-Received: <xmr:NjYVav7VW7Woon-o2p3pB4MiS8p3FK4wxlfL4p7TXQ6xVHzcIMccCKqE4U3rjvL8ZsA0_jW5wMM5a3tl-iH-x9TjtNkTim-T_R5RpQhHWw>
X-ME-Proxy-Cause: dmFkZTENDWPlIMehrI0p5s3nwkhC94E3+Vziz2RDPzn8dE1M2zUbfRmFf4UZfcnyV6gcS+
    CxVZxxC3667h+nAhR6pqpNggMXlVeZYl4wzEaI+cHAj5vReVVsTehM35WU8cFIvMy7RAR2
    sq0fQV5df/lYICvHIopy1DHD/0D9dQZ+yGFyfl6DCWWUsVYBztrbDdiCcnBYzMAu7+IeCJ
    IjvSOmbtjdbu+S0zT14pNcqslKmSRNuzmYU57jfQ53GS85OjSTswjgKmMrEguMgZ2qBqI0
    mjGPmHfCy62a9sJdy7nxYZhhmNtd2tZhnvvTcAoLqkPtY+35gVYtxanNVk7O0FGv4PbDXb
    fc8aKUNXW3eraxJaSwCrCgBJmwiEPo+trzHtyA8bWyApjuSSa+Fu0dlCBQHsWT3kUNc09E
    90n/I6Td3XED1n4c22aSGQuNbjsWaY3pe2wQza2ht9rU+LNLqBrNY1QUIAl4o1+wY0qp3r
    1cf7jO7Eh/1JyBPmnXjv2kw66xm1sSYVcxSokrA4a6z8NCDimzDIuMXZAv5ocKzo4hr1TJ
    N38aN6zqcRXl8+4GKXWl25QcHsldu8yMsOqN5ggRSVa5emMMaug3r63Hj9sDM4Gkq8YFA6
    V26okIAolceI3VH9FnEOXBCcJbCnLQ5eO908OmMiFtJQLYq/SpPHC6fKvvTw
X-ME-Proxy: <xmx:NjYVasrUTi1YJpc3-AvTvNz93eURlhV4pEClq9H065jkAdFc5ao3Tw>
    <xmx:NjYVapiRV94AXlFHb5lHG_CNet67CuzMfHleNTwgV-NhxJQWr-avwA>
    <xmx:NjYVauIOyWqD4vQz8vVy5WTzpXfwDIW7WdXWw8WZt7NBjwUnDA7cXw>
    <xmx:NjYVahBsJT2vFLgDRXuFYEpYEvtWE-XwgWA_KoQiLG96__xn2AD9QQ>
    <xmx:NjYVauxRtn7qr-UfY5dRsFzwDHODMRD62fAN02r_qWyhJXGLAA-uPTIm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:57:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3da64203 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 May 2026 05:57:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 May 2026 07:56:58 +0200
Subject: [PATCH v2 3/8] setup: deduplicate logic to apply repository format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-pks-setup-centralize-odb-creation-v2-3-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

After having discovered the repository format we then apply it to the
repository so that it knows to use the proper repository extensions. The
logic to apply the format is duplicated across three callsites, which
makes it rather painfull to add new extensions.

Introduce a new function `apply_repository_format()` that takes a repo
and applies a given format to it and adapt all callsites to use it.
While at it, rename `check_repository_format()` to clarify that it
doesn't only _check_ the format, but that it also applies it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 31 +++++++-------------
 setup.c      | 93 ++++++++++++++++++++++++++++++++----------------------------
 setup.h      |  9 ++++++
 3 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/repository.c b/repository.c
index db57b8308b..58a13f7c4f 100644
--- a/repository.c
+++ b/repository.c
@@ -262,8 +262,8 @@ void repo_set_worktree(struct repository *repo, const char *path)
 	trace2_def_repo(repo);
 }
 
-static int read_and_verify_repository_format(struct repository_format *format,
-					     const char *commondir)
+static int read_repository_format_from_commondir(struct repository_format *format,
+						 const char *commondir)
 {
 	int ret = 0;
 	struct strbuf sb = STRBUF_INIT;
@@ -272,11 +272,6 @@ static int read_and_verify_repository_format(struct repository_format *format,
 	read_repository_format(format, sb.buf);
 	strbuf_reset(&sb);
 
-	if (verify_repository_format(format, &sb) < 0) {
-		warning("%s", sb.buf);
-		ret = -1;
-	}
-
 	strbuf_release(&sb);
 	return ret;
 }
@@ -290,6 +285,8 @@ int repo_init(struct repository *repo,
 	      const char *worktree)
 {
 	struct repository_format format = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
+
 	memset(repo, 0, sizeof(*repo));
 
 	initialize_repository(repo);
@@ -297,21 +294,13 @@ int repo_init(struct repository *repo,
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
 
-	if (read_and_verify_repository_format(&format, repo->commondir))
+	if (read_repository_format_from_commondir(&format, repo->commondir))
 		goto error;
 
-	repo_set_hash_algo(repo, format.hash_algo);
-	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
-	repo_set_ref_storage_format(repo, format.ref_storage_format,
-				    format.ref_storage_payload);
-	repo->repository_format_worktree_config = format.worktree_config;
-	repo->repository_format_relative_worktrees = format.relative_worktrees;
-	repo->repository_format_precious_objects = format.precious_objects;
-	repo->repository_format_submodule_path_cfg = format.submodule_path_cfg;
-
-	/* take ownership of format.partial_clone */
-	repo->repository_format_partial_clone = format.partial_clone;
-	format.partial_clone = NULL;
+	if (apply_repository_format(repo, &format, &err) < 0) {
+		warning("%s", err.buf);
+		goto error;
+	}
 
 	if (worktree)
 		repo_set_worktree(repo, worktree);
@@ -320,10 +309,12 @@ int repo_init(struct repository *repo,
 		repo_read_loose_object_map(repo);
 
 	clear_repository_format(&format);
+	strbuf_release(&err);
 	return 0;
 
 error:
 	clear_repository_format(&format);
+	strbuf_release(&err);
 	repo_clear(repo);
 	return -1;
 }
diff --git a/setup.c b/setup.c
index 252b443117..c5015923f1 100644
--- a/setup.c
+++ b/setup.c
@@ -750,8 +750,7 @@ static int check_repo_format(const char *var, const char *value,
 	return read_worktree_config(var, value, ctx, vdata);
 }
 
-static int check_repository_format_gently(struct repository *repo,
-					  const char *gitdir,
+static int check_repository_format_gently(const char *gitdir,
 					  struct repository_format *candidate,
 					  int *nongit_ok)
 {
@@ -765,7 +764,7 @@ static int check_repository_format_gently(struct repository *repo,
 	strbuf_release(&sb);
 
 	/*
-	 * For historical use of check_repository_format() in git-init,
+	 * For historical use of check_and_apply_repository_format() in git-init,
 	 * we treat a missing config as a silent "ok", even when nongit_ok
 	 * is unset.
 	 */
@@ -782,8 +781,6 @@ static int check_repository_format_gently(struct repository *repo,
 		die("%s", err.buf);
 	}
 
-	repo->repository_format_precious_objects = candidate->precious_objects;
-
 	string_list_clear(&candidate->unknown_extensions, 0);
 	string_list_clear(&candidate->v1_only_extensions, 0);
 
@@ -1140,7 +1137,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		die(_("not a git repository: '%s'"), gitdirenv);
 	}
 
-	if (check_repository_format_gently(repo, gitdirenv, repo_fmt, nongit_ok)) {
+	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
 		free(gitfile);
 		return NULL;
 	}
@@ -1217,7 +1214,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 					    struct repository_format *repo_fmt,
 					    int *nongit_ok)
 {
-	if (check_repository_format_gently(repo, gitdir, repo_fmt, nongit_ok))
+	if (check_repository_format_gently(gitdir, repo_fmt, nongit_ok))
 		return NULL;
 
 	/* --work-tree is set without --git-dir; use discovered one */
@@ -1265,7 +1262,7 @@ static const char *setup_bare_git_dir(struct repository *repo,
 {
 	int root_len;
 
-	if (check_repository_format_gently(repo, ".", repo_fmt, nongit_ok))
+	if (check_repository_format_gently(".", repo_fmt, nongit_ok))
 		return NULL;
 
 	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
@@ -1757,6 +1754,32 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
+int apply_repository_format(struct repository *repo,
+			    const struct repository_format *format,
+			    struct strbuf *err)
+{
+	if (verify_repository_format(format, err) < 0)
+		return -1;
+
+	repo_set_hash_algo(repo, format->hash_algo);
+	repo_set_compat_hash_algo(repo, format->compat_hash_algo);
+	repo_set_ref_storage_format(repo,
+				    format->ref_storage_format,
+				    format->ref_storage_payload);
+	repo->repository_format_worktree_config =
+		format->worktree_config;
+	repo->repository_format_submodule_path_cfg =
+		format->submodule_path_cfg;
+	repo->repository_format_relative_worktrees =
+		format->relative_worktrees;
+	repo->repository_format_partial_clone =
+		xstrdup_or_null(format->partial_clone);
+	repo->repository_format_precious_objects =
+		format->precious_objects;
+
+	return 0;
+}
+
 /*
  * Check the repository format version in the path found in repo_get_git_dir(repo),
  * and die if it is a version we don't understand. Generally one would
@@ -1765,26 +1788,20 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
  *
  * If successful and fmt is not NULL, fill fmt with data.
  */
-static void check_repository_format(struct repository *repo, struct repository_format *fmt)
+static void check_and_apply_repository_format(struct repository *repo,
+					      struct repository_format *fmt)
 {
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
+
 	if (!fmt)
 		fmt = &repo_fmt;
-	check_repository_format_gently(repo, repo_get_git_dir(repo), fmt, NULL);
+
+	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
+	if (apply_repository_format(repo, fmt, &err) < 0)
+		die("%s", err.buf);
 	startup_info->have_repository = 1;
-	repo_set_hash_algo(repo, fmt->hash_algo);
-	repo_set_compat_hash_algo(repo, fmt->compat_hash_algo);
-	repo_set_ref_storage_format(repo,
-				    fmt->ref_storage_format,
-				    fmt->ref_storage_payload);
-	repo->repository_format_worktree_config =
-		fmt->worktree_config;
-	repo->repository_format_submodule_path_cfg =
-		fmt->submodule_path_cfg;
-	repo->repository_format_relative_worktrees =
-		fmt->relative_worktrees;
-	repo->repository_format_partial_clone =
-		xstrdup_or_null(fmt->partial_clone);
+
 	clear_repository_format(&repo_fmt);
 }
 
@@ -1862,7 +1879,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 
 	if (is_git_directory(".")) {
 		set_git_dir(repo, ".", 0);
-		check_repository_format(repo, NULL);
+		check_and_apply_repository_format(repo, NULL);
 		return path;
 	}
 
@@ -2020,25 +2037,15 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env_internal(repo, gitdir, false);
 		}
+
 		if (startup_info->have_repository) {
-			repo_set_hash_algo(repo, repo_fmt.hash_algo);
-			repo_set_compat_hash_algo(repo,
-						  repo_fmt.compat_hash_algo);
-			repo_set_ref_storage_format(repo,
-						    repo_fmt.ref_storage_format,
-						    repo_fmt.ref_storage_payload);
-			repo->repository_format_worktree_config =
-				repo_fmt.worktree_config;
-			repo->repository_format_relative_worktrees =
-				repo_fmt.relative_worktrees;
-			repo->repository_format_submodule_path_cfg =
-				repo_fmt.submodule_path_cfg;
-			/* take ownership of repo_fmt.partial_clone */
-			repo->repository_format_partial_clone =
-				repo_fmt.partial_clone;
-			repo_fmt.partial_clone = NULL;
-			repo->repository_format_precious_objects =
-				repo_fmt.precious_objects;
+			struct strbuf err = STRBUF_INIT;
+
+			if (apply_repository_format(repo, &repo_fmt, &err) < 0)
+				die("%s", err.buf);
+
+			clear_repository_format(&repo_fmt);
+			strbuf_release(&err);
 		}
 	}
 	/*
@@ -2814,7 +2821,7 @@ int init_db(struct repository *repo,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format(repo, &repo_fmt);
+	check_and_apply_repository_format(repo, &repo_fmt);
 
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
diff --git a/setup.h b/setup.h
index 9409326fe4..5ed92f53fa 100644
--- a/setup.h
+++ b/setup.h
@@ -221,6 +221,15 @@ void clear_repository_format(struct repository_format *format);
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
+/*
+ * Apply the given repository format to the repo. This initializes extensions
+ * and basic data structures required for normal operation. Returns 0 on
+ * success, a negative error code otherwise.
+ */
+int apply_repository_format(struct repository *repo,
+			    const struct repository_format *format,
+			    struct strbuf *err);
+
 const char *get_template_dir(const char *option_template);
 
 #define INIT_DB_QUIET      (1 << 0)

-- 
2.54.0.926.g75ba10bac6.dirty

