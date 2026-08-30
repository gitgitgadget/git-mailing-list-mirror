Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841A31A065
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122925; cv=none; b=qQcwpXNidkXpllM9jyIeAXzbd5wJ57MksyXetDvxLqnKnqFs0Au+vkqnLfaWiSKsbqd3RQiYrCXUudL8doeqKzZ6+GyKHd28kCGjjjOB3eeizSbdmP0Q6txHa+2YPW/1yXXGy91SHM7Rz7U+3ly3ps7s0KZMK6KCS2XZrAT4E6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122925; c=relaxed/simple;
	bh=5vSm8Ccsc7qzuXj8Tisg48sLvFlxN9+dOgWR2Jz+Xfg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtSe2wvI5vhLuP8jMphKiRWNt/Q1QI1NeDIN9frlbceesIHdCF+iD6r2Ls3qa+3X8cOWZ/yPG21vtmDobzFoWGZ1k5k7oZVhLxVF9L26Kvn84KrhZ9dgQTx+nToiIG2uHoQgUMByCAmqhP4dw1anXJ6xL2lumrgdKZG6kxUVeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tp4b1xQp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPwq6XRS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tp4b1xQp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPwq6XRS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9978A14000A1;
	Sun, 30 Aug 2026 16:48:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 30 Aug 2026 16:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788122922; x=
	1788209322; bh=ObWOmkgCIUxahEnTajfZVMNChQYSKAccomMwN69dooM=; b=T
	p4b1xQpuTfPzeANW+SzBiZ5okRpgf9oge9az1uLtrFg0v9HsFA3HVwLkbu+hAtEZ
	hANJQ7aDH1qFD5k9YHuf2PozmVaSz+MN1EFauzJWWHxHb+St0FN1+X3ImQ2QV0o0
	rOFcUK9VXK50FekjmUO6svbyRguvvVFQex8JgM9q58YCo2wat5Y3pE9nvf8MxOT3
	lQwzSdsICXENShzHQyyBdT7R6nGzHYoGK14k/HKJAMVX6qUSU3Um+HVOiSptwChI
	olIjEPvz5cgZIAdGKG6dITLHywc2jAnd/23qzJB+LPRMwW23Lxu6Cbe8ArgrzxD+
	0C0v0J5bgbStBPGR355qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788122922; x=1788209322; bh=ObWOmkgCIUxahEnTajfZVMNChQYS
	KAccomMwN69dooM=; b=JPwq6XRSrrcskRORqjViuhzZF+9XQzsGzjpO9esJGV8z
	pLfn5eNNv6orhCBJWbzIHx4wrTk7ZSF2cq2fsF4m7pR11qEbS5yFFe4FTRL0Buix
	YB50WEnP4BWkP6LTLkC8B3d2tHsfAwP61phfI5QZ4hh1d089Xf2tA1RKAPqcF0HJ
	8XKL70K8jQgMKnriA5dWF3ne5blURffUPFJ2hHc/X5i6+L8VOz/MeD52YUser1oT
	NeAjijRINd1YH3Oh7+EgAiA+CExSvuz+IvnhlETKVrTaB52SAuzpUqz4Y7M+fQV6
	T4GwXK22yqxpqTd6V1ryfhp4NDXf47T75P0wIAGWxA==
X-ME-Sender: <xms:KpeUaoxSasD6mDQIkyfbRQdtqNdvp02c3o4zCN-AzBF5NzwxPi75-g>
    <xme:KpeUaiSNEs358n8IWFbgNDHLxXotYJOlzv0Fux_pu_Rmhd07ulUysFn8u1emzOeQJ
    e0KyoN1kSdBgtUDTY0-ayAPLT6mrF7ReV0hGHM_lOIYVUOloJGG2A>
X-ME-Received: <xmr:KpeUan9mLYW_uzdF2VJwZWRvx3pG2V81j4z2bqn7mA2JXwQQuGxxGCjZIy-eCN_O8ea9RpLgmOnEAUZenkNUPZaFO700F9FJ1w>
X-ME-Proxy-Cause: dmFkZTGpxBreKong0VtR4qC+o1j65EClxmMKtlNb51ZMOKkI04uXcAfuEsFsLLc+HbJj8e
    0uh5su56pJDxkDNagV0UC6S6uMVhaFZ5jIBZtwvmdengJmUhCxcdsNjG/XEMam3+verCk7
    H+yUAW193Pbb3PboqDdPE/X+dfwuUuh2WZmN90YifjKjFoJ/OdNwHqTxOnRMHKgE6nqZwD
    pOQh6dMLhuJEriX8QtN7iSSj4zlM3sswf6gW+Yby+7EWb/cJnyEE9EV6EcsgdIp0VBsK2F
    PlRVcO5jVI2l+wZNp7rE7xBEphaLUgejJ5SSXParYGKyF4xabIUgL1OXOhxq+EnrXoy+qt
    2bpwpc9O1rCE1HmJlouIaDOFzqNQpJZF1AGveFrIvsmrPjK9xPgMb8qBpS0wTm7DifBr85
    hQnMIdPIZC1QBIM2QhXo1ccnQdkubM/7OLGdNy2PCdfItdOxTo7RDT73HJ2HnZlzpN52Of
    pg0qgIGslSOQLHB/Qvq5KaOE/L0WeoTBTY+SDjTBNZITMbkV7ZS0rbkOQiWNAAE2m7oa0A
    lNAvH9q3DvKWalbuzcREB51MxjgJzvJpsEzrHC2AwUJOEwV9/3fHhz2WqK3VqT03DqUS9F
    mywikY6MbRnEFwU7ukYEN4JlMfMcxZfd7Q5vgnWTOh75qvIQ188B5vmkYyzg
X-ME-Proxy: <xmx:KpeUahoHWUUWxoziif_chT3px7JzvVJPvRCxy37PBF-gzxAFD7kqXQ>
    <xmx:KpeUasnfB4W8-FcY2uovtcukUKIfjU8zUBwkItzmSBUnsoQcqF4-XQ>
    <xmx:KpeUagLKTPDD9l7o_MmdnKXsqAMmWmKzVbarFNlB0_ojVVKH-8fWuw>
    <xmx:KpeUapyBnB90DJ_perxytA1RHochUqfiw6I2R0VVUh3vXqDdXeEV7Q>
    <xmx:KpeUasKW982045V0v66S9Ih4IaXd9ruleoW-AaiSlJdgU58w7YOTNK-Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:48:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 4/8] checkout: extract option validation and pathspec helpers
Date: Sun, 30 Aug 2026 13:48:31 -0700
Message-ID: <20260830204835.1040408-5-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260830204835.1040408-1-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com>
 <20260830204835.1040408-1-gitster@pobox.com>
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

