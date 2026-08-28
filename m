Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A63A83BF
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957537; cv=none; b=M6rbODn81lPLGzYZJGPYjFORZSyLzyr4KVF6RQf9wy69Y9Xpq4NoC6axXhYxIh/iKhE3UOZ0e/HD2QKzJKmNIvncN/Fj3Ik+Q3pvKkTaXKsEv9NGnW9pcfwGoqh73WjddS0Tfdv05g2FLOnMWj+64PscKLDL7ualM+KdzHaJsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957537; c=relaxed/simple;
	bh=5vSm8Ccsc7qzuXj8Tisg48sLvFlxN9+dOgWR2Jz+Xfg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md6aoeOt6bJfC44+AJwIhE6otYGdUMDkmf6IkPEsMx6Un0UTxnlbJZHw0AJZ4NGbThlISfpKs1hPXZZoov2N61UXeUXhqDKmqEY/qwO2lG+GDT5IXbL1k8d4OdW/Ey2WEITeE2Liy50S7Juv7v8zdDhiSK/B9TxbYD3tV35Y0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qE4oKLXe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVs2mdEd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qE4oKLXe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVs2mdEd"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id AE8341D00045;
	Fri, 28 Aug 2026 18:52:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 28 Aug 2026 18:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787957534; x=
	1788043934; bh=ObWOmkgCIUxahEnTajfZVMNChQYSKAccomMwN69dooM=; b=q
	E4oKLXeRv6BJKcQVqVvtECSYZ4aO6mxCe+Hn+geilvG1v7P+dd+WtDfjHvtwfjGt
	3RxBjXzbh3qCrgGl7XCP1yF5pkAGPmMl7lO3UwyY3s54+P7quzaHwXRICHSFsiLV
	VywthlRhiD/YSIJqqkx2JUOVsxnuh7fwY4a9CqLFLARDXIF8h6RcKPPNyk3gIX/z
	jXnbFOH0gapJZHE6/q5TMdphFloY3TLmy5ndJllhHDXYVDctwDYcs88dmVMzj1cE
	Bh2zQGDf4O0aZPbBCfyWk/3A0fOm/R1JLeYiLA/L6IV7tBxKLvAA2CX6RE6csfcZ
	Iy99Cx7qB7br2OP56zWrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787957534; x=1788043934; bh=ObWOmkgCIUxahEnTajfZVMNChQYS
	KAccomMwN69dooM=; b=SVs2mdEdcDJ/anzyFijv88yYl+7jBy6XKtZYwIG12Tbm
	EEvQ8sVx0Oq2ZUr8AXeMLRvjrkmpENPwkVJSd89txGvtrz9ydSuqXNqjxJGeDcRJ
	v/bCMhU8ZCV8kLI62mC4dN/biasqYwnAoB0/v3kfMRX4BhjZVzbGHrz7O6U1F1Qs
	jQ1UwqTCZsimXOCqS0klSaZgn0x8ennZCKg/W5EcDUlMRR+uA2ndAqR01fZDT5GI
	taHe5DvxwG94pDGR4OyTZ2BcYZ5nZpo15EPWbkFxZ6j+fOLBd0CkfagKtDVQ/Uy8
	GibRYklVp0s8QXwQwOeamd84l0b3Y5FiMBUAHjUOtA==
X-ME-Sender: <xms:HhGSaju2EwkIP3cWmSncNY_jFABqZ68GqHF2FauJWFakGTK5MUc8SQ>
    <xme:HhGSaqc4FZRI2mqk2gJFumT8r5jgF8NwdtCdQV2T_8DRW5ZBq-MtXMi5aPYCQoWLN
    cYWmXN4pqb8IKcsH9DAQvZkgoDRL2pA3hhe2bcZX8SPFBzrUe7zfGs>
X-ME-Received: <xmr:HhGSakYfLF7kfr9TzZKO61oswpvU9YPJH9bVO2sZOCblDXFBOVuJ12EueIap0bTG9K9SsvI57-3ikLTDD4WIZ5oxEF7d8jLfrQ>
X-ME-Proxy-Cause: dmFkZTFrpTwiHSUIsRhuhIiyrg7KUJfh8QuYcswElzTZ4rtsLKaTl9LXy9loZ6Dem46BTd
    Msc70tAIzbu2UrQ72NkrqLHHtw7kFWJpBZWHuRjpPNQabzm6J0mQ1IPakv6Qo2b/eqSuSe
    qKgkf1OnRlOBC9OntmJixzclU6NABD+p3iN/TntlCnhtUXXFTSQVGyaHm90KPuo3Iu5GOA
    AusCH1lf7XL1OY3nD/SbcdRFcM7KIzNYdQDjHDcgPiigF2sbk+c39sl9gLJeQwDL5Tfn4s
    dV0Dijl7kJPRsJ5E8bzvsG4oNuvqC0mt5ebla5FPqk3FV5qddScKupypraISBWl61wLPEV
    2+WhGRldy6iRaG27VmAy4y1fGwEVNEzKdsnME+WE4wJXnHILbcrDOWYYDbqQoNlZCggHlV
    ieQ6Y3UxALsc4PTqzrMx3dldyYFTstE2KTQyj4N+tW4GdfJU0cE5+TyAeiqYWHhYat+m55
    7XmwUYuh0jj/zQ1HnXE5KPHT05lEI3yn8nXzUbd+vOzcFQYFo1El4Tw/KWQWO//8hoRi9a
    +k+FpFyoMp/32KfYaqo+QHYPXaioUQFXrAoPpcYb6X1KbJ4XGMnpsju4P7mubXz93pLCbT
    FaZh1T5LH+bRLxsk19FVDkKDDJlwHLO4MgTlnZCl1B9lWkdE0JEHiCkPJeLQ
X-ME-Proxy: <xmx:HhGSatV9RG0ar0NWXWyqt0vbaKH89rQRHWO2H1BMIuGy0ZLvdRKowQ>
    <xmx:HhGSamhvWa-oMbNkgaDZr9gFXqvCZ1ydcpjP984-Hh2hWb_rUGW41Q>
    <xmx:HhGSarXKo4RheDdTg7c8IXI1NTdyhqLWXuplkanXi9t7g_w4qywZzw>
    <xmx:HhGSatOfTFITkrMQV_VoCamo1HMPIdP3UdSsWeSeEE_qHoygufnP4w>
    <xmx:HhGSavF9HwbJLPR7T1Q8EsAVQCEOKb0Z77OTfOa7jyyQh3FXsQt1kcJD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:52:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/8] checkout: extract option validation and pathspec helpers
Date: Fri, 28 Aug 2026 15:52:02 -0700
Message-ID: <20260828225206.310500-5-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260828225206.310500-1-gitster@pobox.com>
References: <xmqqh5kd3lm3.fsf@gitster.g>
 <20260828225206.310500-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkout_main() function handles initialization, option parsing,
option validation, and pathspec resolution.

Extract option validation and pathspec handling logic into static
helper functions:

  - init_checkout_opts() initializes default checkout options and
    repo settings.

  - validate_path_options() validates patch context and
    index/worktree flags.

  - prepare_common_options() prepares progress, merge, and force
    options.

  - parse_pathspec_from_file_options() parses and validates
    pathspecs read from a file.

Call these helpers from checkout_main().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 171 +++++++++++++++++++++++++--------------------
 1 file changed, 96 insertions(+), 75 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e3d23256e2..8d567def7e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1846,6 +1846,98 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 	return newopts;
 }
 
+static void init_checkout_opts(struct checkout_opts *opts, const char *prefix)
+{
+	opts->overwrite_ignore = 1;
+	opts->prefix = prefix;
+	opts->show_progress = -1;
+
+	repo_config(the_repository, git_checkout_config, opts);
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
+
+	opts->track = BRANCH_TRACK_UNSPECIFIED;
+}
+
+static void validate_path_options(struct checkout_opts *opts)
+{
+	if (opts->patch_context < -1)
+		die(_("'%s' cannot be negative"), "--unified");
+	if (opts->patch_interhunk_context < -1)
+		die(_("'%s' cannot be negative"), "--inter-hunk-context");
+
+	if (!opts->patch_mode) {
+		if (opts->patch_context != -1)
+			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
+		if (opts->patch_interhunk_context != -1)
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+		if (!opts->auto_advance)
+			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
+	}
+
+	if (opts->overlay_mode == 1 && opts->patch_mode)
+		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
+
+	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
+		if (opts->checkout_index < 0)
+			opts->checkout_index = 0;
+		if (opts->checkout_worktree < 0)
+			opts->checkout_worktree = 0;
+	} else {
+		if (opts->checkout_index < 0)
+			opts->checkout_index = -opts->checkout_index - 1;
+		if (opts->checkout_worktree < 0)
+			opts->checkout_worktree = -opts->checkout_worktree - 1;
+	}
+	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
+		BUG("these flags should be non-negative by now");
+}
+
+static void prepare_common_options(struct checkout_opts *opts)
+{
+	if (opts->show_progress < 0) {
+		if (opts->quiet)
+			opts->show_progress = 0;
+		else
+			opts->show_progress = isatty(2);
+	}
+
+	/* --conflicts implies --merge */
+	if (opts->merge == -1)
+		opts->merge = opts->conflict_style >= 0;
+
+	if (opts->force) {
+		opts->discard_changes = 1;
+		opts->ignore_unmerged_opt = "--force";
+		opts->ignore_unmerged = 1;
+	}
+}
+
+static void parse_pathspec_from_file_options(struct checkout_opts *opts,
+					     const char *prefix)
+{
+	if (opts->pathspec_from_file) {
+		if (opts->pathspec.nr)
+			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
+
+		if (opts->force_detach)
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--detach");
+
+		if (opts->patch_mode)
+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
+
+		parse_pathspec_file(&opts->pathspec, 0,
+				    0,
+				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
+	} else if (opts->pathspec_file_nul) {
+		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
+	}
+
+	opts->pathspec.recursive = 1;
+}
+
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
 			 enum checkout_command which_command)
@@ -1887,17 +1979,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		BUG("no such checkout variant %d", which_command);
 	}
 
-	opts->overwrite_ignore = 1;
-	opts->prefix = prefix;
-	opts->show_progress = -1;
-
-	repo_config(the_repository, git_checkout_config, opts);
-	if (the_repository->gitdir) {
-		prepare_repo_settings(the_repository);
-		the_repository->settings.command_requires_full_index = 0;
-	}
-
-	opts->track = BRANCH_TRACK_UNSPECIFIED;
+	init_checkout_opts(opts, prefix);
 
 	if (!opts->accept_pathspec && !opts->accept_ref)
 		BUG("make up your mind, you need to take _something_");
@@ -1907,57 +1989,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, options,
 			     usagestr, parseopt_flags);
 
-	if (opts->patch_context < -1)
-		die(_("'%s' cannot be negative"), "--unified");
-	if (opts->patch_interhunk_context < -1)
-		die(_("'%s' cannot be negative"), "--inter-hunk-context");
-
-	if (!opts->patch_mode) {
-		if (opts->patch_context != -1)
-			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
-		if (opts->patch_interhunk_context != -1)
-			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
-		if (!opts->auto_advance)
-			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
-	}
-
-	if (opts->show_progress < 0) {
-		if (opts->quiet)
-			opts->show_progress = 0;
-		else
-			opts->show_progress = isatty(2);
-	}
-
-	/* --conflicts implies --merge */
-	if (opts->merge == -1)
-		opts->merge = opts->conflict_style >= 0;
-
-	if (opts->force) {
-		opts->discard_changes = 1;
-		opts->ignore_unmerged_opt = "--force";
-		opts->ignore_unmerged = 1;
-	}
+	validate_path_options(opts);
+	prepare_common_options(opts);
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
 		die(_("options '-%c', '-%c', and '%s' cannot be used together"),
 			cb_option, toupper(cb_option), "--orphan");
 
-	if (opts->overlay_mode == 1 && opts->patch_mode)
-		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
-
-	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
-		if (opts->checkout_index < 0)
-			opts->checkout_index = 0;
-		if (opts->checkout_worktree < 0)
-			opts->checkout_worktree = 0;
-	} else {
-		if (opts->checkout_index < 0)
-			opts->checkout_index = -opts->checkout_index - 1;
-		if (opts->checkout_worktree < 0)
-			opts->checkout_worktree = -opts->checkout_worktree - 1;
-	}
-	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
-		BUG("these flags should be non-negative by now");
 	/*
 	 * convenient shortcut: "git restore --staged [--worktree]" equals
 	 * "git restore --staged [--worktree] --source HEAD"
@@ -2048,24 +2086,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			    argv[0]);
 	}
 
-	if (opts->pathspec_from_file) {
-		if (opts->pathspec.nr)
-			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
-
-		if (opts->force_detach)
-			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--detach");
-
-		if (opts->patch_mode)
-			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
-
-		parse_pathspec_file(&opts->pathspec, 0,
-				    0,
-				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
-	} else if (opts->pathspec_file_nul) {
-		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
-	}
-
-	opts->pathspec.recursive = 1;
+	parse_pathspec_from_file_options(opts, prefix);
 
 	if (!opts->pathspec.nr) {
 		if (opts->accept_pathspec && !opts->empty_pathspec_ok &&
-- 
2.55.0-884-g76cf8659c2

