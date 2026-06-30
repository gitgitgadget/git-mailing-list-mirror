Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5F40628A
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820079; cv=none; b=cXyq2ucYSV/WsgSM+9UuV8O+o8KrgKJShWk3v/IY9W7odK9ZA4Jj/Gh7cxwTNlItPN05w6XKDkI5mwGrQqYQ725o6b0FguLOPffpBuvVEXpK4Nxry12YbcG0Eah4mpy9C2V8U7leWeVbIWUPYMNX9/ZUkGT0r6seUDknJr0wf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820079; c=relaxed/simple;
	bh=OsScr0ArvJ0SCN6ydMwYuYzYTVQRGYMVN8AvXmtZ5e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9TjIgg2U7dePnI5X2KhZoTINmr8fyA2ycTUfaw/g9q+b2PfTIzggK1mZufHxELnrRfxK+Z6zFfVHZBU3H1qEQGlAKWIkvR32KHPLkql2cc012gh2OUSt4m8Hxkjjv6WC8jSNzLert83ym/6SrFW/t0WZ2/1RFhJ29FO6Bf7gl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MLxRwd73; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j26FYboR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MLxRwd73";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j26FYboR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D01EC1D000CC
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:47:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 30 Jun 2026 07:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820077;
	 x=1782906477; bh=99mKdLsjiP/yqAnmTzXF4NZ898m96FD/NlJp4o1nf4s=; b=
	MLxRwd73kZFHRRUfXY3w1db9mbDcYoClidYzBQvksj/q8USmfruaiHOt0sy/SZaP
	ZjTZNbjFD2CeA4S0ByYVHqQioeeEAgldo3oRKAZ5SxtkYX8T9wauARnCi7AtFGvu
	R6FDynC3k6E7ypnh/6wbc7Z+F+J1dW91r8R2pc8a1Aim/o5x5St3Hz7zap2WAgFd
	AuL2TPoGv1JH7c64R0AONDp7Xp+alLXpajJf+JjXAgg3Oe5jFreQmCJcrI1WA83B
	FTIY9WDI/+cgc4HIkT3IxwQCl+QqWO/j1378nc8Hh67dqsObZ+z56UBA/hgYG9kS
	Dyv+M835HmFD9yJbeq7T5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820077; x=
	1782906477; bh=99mKdLsjiP/yqAnmTzXF4NZ898m96FD/NlJp4o1nf4s=; b=j
	26FYboRcLk1ivVqnBwlEv0IF8znu/rU1Tume0jI0UYsL3k6ISMbzUmQdtIyzj6hf
	itbvPwexhTVJXYx9oII7+GtMrJ/qoXTe3XQxxk7UIKr7+i/dwLCIAebkamFJ+MZa
	DqJwWsb+aAazHfDO1tRvJZ4y+7ljGLHqKSNSxeduKHxD4MzfvPzAAsRfHdEy8cbn
	jFWhx72ilGg7J6tpBzXKs3fY5JzzykUiunZeHiAuGKrM7SMAn1+xfqGgqwhosIzq
	TABzjtu8kGEC+iiZkF5fdbfwNmMvVvbwIanAGV7lW3nes6etpk/0zn6295Aplh3R
	4fMmQhYd9Pa9ZrYW9BXPQ==
X-ME-Sender: <xms:7axDamjUA4m0uhvjskW4AloCABIVpKhCDA769OqRqcQFv_xTZPYwZA>
    <xme:7axDat_09m2VF9G1K7Q8oQZJBaaixHkMAi5L94c6YRuzMsXYxsRjC2uKv4G1bAyvI
    wiSz8ehZgxCYqM1u57sw7W4uBRnC8LhUXOKJbFwdMO91FfAGs0KkA>
X-ME-Received: <xmr:7axDajsI3U1VerjAEU33v3Izmki8aB3ienghdcVQ2ohhretqb6ii765Xy2qsuIHR58gGRuF84VIphISxuAhxhUNLBe_3BFSWbtQsIUX2jvMGfw>
X-ME-Proxy-Cause: dmFkZTFDZ8EBIRkLTKt14TuSGr1p9PVZekTad1c/wqf+J4rUdU57yUeNCpU56+znu8nsjb
    fYDR646+CJ3TGFv8kQTHR4VNBrT/tkMeSXjzT67aaHpKiIdg7Ex7ASQFMr3pvovOMeWRc2
    b+Hb+9BEYhuDH+pmqgJy7oGhS1oPcxj3Hy28pR4Uz81T3ewRUNKEnbf7HExREqmx77S7CO
    8q4+s9ohDmUs11CzmmSQpKP0fvZO9hDzS3HZYuZIL2rRpsr/my7MnY/OfRKNFc3m22a8aE
    0HfNWlTaLhp/UB/uVY+/uRI7kUgfffb/QcAn+DT1zAl/2aW3MU8z9wRoF8TwRTtj2JqpC9
    2NktzmTgFjNZ70CP0Y6fFp40QHmv4UVdMxQeOwcpzaPngO3fumehT3a0v7zMBYuGv3uSGr
    nGYbb4VnD9DtEA5Obire0/UyMxfabtBfw7Wk0pr/O8BCi3D4MQ3d1mnjpBa4AX7SiIPurk
    SqYE0FRPX3O9Ouad2eXDZC0lea8gU7t6RxUyz83ewLcD4FQ3zLqxEyqRLVcJIJXKAnbnIV
    /VESu2MimtPSABSv0n/7VPliNe82rxn0zPMBskuHNs6iRfiSbn14jGKs2EHXlecdsqvYAi
    OhGigMI4GAqBzmefjyvKnXHQqwoKUfwABPUYOcQ1xeh7uodvBFYja902hRjg
X-ME-Proxy: <xmx:7axDakYEW-XGE5i5ieyvyLNp8bfDOCTVnZb1KPUh6m5Wv5M5RY9EQA>
    <xmx:7axDajqrRLPecfaXXThoAT2WyNbiYBkRDEMueynk47zHvvRn0Ams3A>
    <xmx:7axDap_wNe3ssCorMxwCdQDqu52V86PrGlcdOs9bDo5RdfsxfbSXjg>
    <xmx:7axDai9XuTmErkb5azdLqS7Cu0S5vVLKsa_P8RJ9wWlBefeBaDe-mQ>
    <xmx:7axDajjx0INM-2j7x3lzu2bQuo8xTrTCZ2pjUK84ydQyJukFZiSEfVB1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:47:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0501115 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:47:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:40 +0200
Subject: [PATCH 01/13] setup: rename `check_repository_format_gently()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-1-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `check_repository_format_gently()` receives a format as
input. An unknowing reader may thus suspect that this function actually
checks the passed-in format for consistency. While the function indeed
checks the repository format, it actually serves two purposes:

  - It reads the repository's format and populates the passed-in format
    with that information.

  - It then indeed checks whether the format is consistent.

Rename the function to `read_and_verify_repository_format()` to clarify
its functionality. While at it, reorder the parameters so that the
format comes first to better match other functions that pass around the
format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/setup.c b/setup.c
index 951ab9eedb..118416e350 100644
--- a/setup.c
+++ b/setup.c
@@ -749,9 +749,9 @@ static int check_repo_format(const char *var, const char *value,
 	return read_worktree_config(var, value, ctx, vdata);
 }
 
-static int check_repository_format_gently(const char *gitdir,
-					  struct repository_format *candidate,
-					  int *nongit_ok)
+static int read_and_verify_repository_format(struct repository_format *format,
+					     const char *gitdir,
+					     int *nongit_ok)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -759,7 +759,7 @@ static int check_repository_format_gently(const char *gitdir,
 
 	has_common = get_common_dir(&sb, gitdir);
 	strbuf_addstr(&sb, "/config");
-	read_repository_format(candidate, sb.buf);
+	read_repository_format(format, sb.buf);
 	strbuf_release(&sb);
 
 	/*
@@ -767,10 +767,10 @@ static int check_repository_format_gently(const char *gitdir,
 	 * we treat a missing config as a silent "ok", even when nongit_ok
 	 * is unset.
 	 */
-	if (candidate->version < 0)
+	if (format->version < 0)
 		return 0;
 
-	if (verify_repository_format(candidate, &err) < 0) {
+	if (verify_repository_format(format, &err) < 0) {
 		if (nongit_ok) {
 			warning("%s", err.buf);
 			strbuf_release(&err);
@@ -780,37 +780,37 @@ static int check_repository_format_gently(const char *gitdir,
 		die("%s", err.buf);
 	}
 
-	string_list_clear(&candidate->unknown_extensions, 0);
-	string_list_clear(&candidate->v1_only_extensions, 0);
+	string_list_clear(&format->unknown_extensions, 0);
+	string_list_clear(&format->v1_only_extensions, 0);
 
-	if (candidate->worktree_config) {
+	if (format->worktree_config) {
 		/*
 		 * pick up core.bare and core.worktree from per-worktree
 		 * config if present
 		 */
 		strbuf_addf(&sb, "%s/config.worktree", gitdir);
-		git_config_from_file(read_worktree_config, sb.buf, candidate);
+		git_config_from_file(read_worktree_config, sb.buf, format);
 		strbuf_release(&sb);
 		has_common = 0;
 	}
 
 	if (startup_info->force_bare_repository) {
-		candidate->is_bare = 1;
-		FREE_AND_NULL(candidate->work_tree);
+		format->is_bare = 1;
+		FREE_AND_NULL(format->work_tree);
 	} else if (has_common) {
 		/*
 		 * When sharing a common dir with another repository (e.g. a
 		 * linked worktree), do not let this repository's config
 		 * dictate bareness; it is inherited from the main worktree.
 		 */
-		candidate->is_bare = -1;
+		format->is_bare = -1;
 
 		/*
 		 * Furthermore, "core.worktree" is supposed to be ignored when
 		 * we have a commondir configured, unless it comes from the
 		 * per-worktree configuration.
 		 */
-		FREE_AND_NULL(candidate->work_tree);
+		FREE_AND_NULL(format->work_tree);
 	}
 
 	return 0;
@@ -1141,7 +1141,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		die(_("not a git repository: '%s'"), gitdirenv);
 	}
 
-	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
+	if (read_and_verify_repository_format(repo_fmt, gitdirenv, nongit_ok)) {
 		free(gitfile);
 		return NULL;
 	}
@@ -1218,7 +1218,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 					    struct repository_format *repo_fmt,
 					    int *nongit_ok)
 {
-	if (check_repository_format_gently(gitdir, repo_fmt, nongit_ok))
+	if (read_and_verify_repository_format(repo_fmt, gitdir, nongit_ok))
 		return NULL;
 
 	/* --work-tree is set without --git-dir; use discovered one */
@@ -1266,7 +1266,7 @@ static const char *setup_bare_git_dir(struct repository *repo,
 {
 	int root_len;
 
-	if (check_repository_format_gently(".", repo_fmt, nongit_ok))
+	if (read_and_verify_repository_format(repo_fmt, ".", nongit_ok))
 		return NULL;
 
 	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
@@ -1874,7 +1874,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 		struct strbuf err = STRBUF_INIT;
 
 		set_git_dir(repo, ".", 0);
-		check_repository_format_gently(".", &fmt, NULL);
+		read_and_verify_repository_format(&fmt, ".", NULL);
 		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 			die("%s", err.buf);
 		startup_info->have_repository = 1;
@@ -2836,7 +2836,7 @@ int init_db(struct repository *repo,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
 	repository_format_configure(&repo_fmt, hash, ref_storage_format);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);

-- 
2.55.0.795.g602f6c329a.dirty

