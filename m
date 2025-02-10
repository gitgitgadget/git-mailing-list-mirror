Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7F25E475
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215021; cv=none; b=JAkmDqCU9/s1ju/d9Ukdpvmiy4O9jnOKACMVdztRkome3t461c39BV6BM14CZN6mArfcCPR81T7zzbc3HPnHgIwpBxv8pCBUxGfb1ef4DNQCTsgFP1WsZTtylXsitAJH6Ea9wHFYFmZduWPxkR7e2ykZ0Ewh8z8nsUqXYCVEPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215021; c=relaxed/simple;
	bh=XRNpoVgZN7Y85Fd7LH50hhO+VUq1rIsufxKiAwrj0js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASFYcvkdeUCGdHatiXzEoO4hFWiH9o6Ca+5Nmdn1mwM5wDPLj++54UHP0NR0EFglml92V1c4xnPEraeCLT6ntmcpVYrU6+pcOqZOdOuVgje2I2uBXBwufZVhWV3/ikf+Gc7cZ2SM4M5r+1tkJ3zj1EB/Ko+E9m+tSYdH2SgsyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=UChm0vDk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="UChm0vDk"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso6599865e9.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739215017; x=1739819817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kpm+O33Q6Fi/GRTYgnu9cj2/JwIwx7aVh5WZd6m8X+Q=;
        b=UChm0vDkb/sKg63DDuL92ayDzUz2BVjjm0IS7eXZgLfNOxuhezRGrznYh0j/K9gQgc
         0K9aB9ueIu9QEZEU2b/IUyuuXdDUgydHZbJu0O8vW+KXYzLeIcbsyWHkQOWDrSSAfYva
         62XPAfW02DlNIJXAMnRMmLUk6XnSpSIz7ORSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215017; x=1739819817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kpm+O33Q6Fi/GRTYgnu9cj2/JwIwx7aVh5WZd6m8X+Q=;
        b=sakM6E/w4mCLIV+B2B+RcN5HaO1WTtIMF6Qv9f1Qct3ShSL2FkqVMYkJ+85Isr3yx/
         2ROpf3V7QSlVrXYDz4tvSpTCapu3R9fEC7N2UPdNWtRCZBslem9tBGY7Ql7iNUyA+Lbj
         7PLs8WGRclZtQtAj6ffrVNJZNBO69GEIcpMfPdq0Bs99JzU8u3Te48RcvsockhO595O9
         Z9/1pLYRx39WNEUF3PRDYSAwvGgdC4xxYxAUcyVeNYPB8742qXZ1+NlfGi1fM06O9yxH
         415vHqEKdFONyMS0gudbsxB768U2nqvdLJFy/J8kTWXvXKvLvixRXjCRep6kYaflLAWB
         rbpg==
X-Gm-Message-State: AOJu0YxBRVaiED4c7rOD8nO3kZwlcUQmaeX6i00Q6kHIVEER3aDGmFCi
	1zyvrGMEjgcNk5v5+xCClKyNQGOG9d9yj/v3JgLj6gtZ4WCTvBhzfgAbNxlYnfvxnGU9kWLSNm9
	PDlLlSw==
X-Gm-Gg: ASbGncvT5YMv8HTDOSPhnzqVc+jHdZvA2vK8ITU8uO6zLYA9vpI3dBGkuAHk0zFsl7/
	G07BNT/0GiV7EorpVBDsgu2KSvLCDU3ABHZPLRRiM++TSMvEVHbpoTuUJ/NsBNy/PDoCzJnzFJj
	nX/W3h40wPFUgmsmyPL/OjLcAAZSjIeQyutADzVS9/mrDA9gUimn7Te3r6vUqile+KeiFbb/mZe
	/6XeoQ7MsnWEceknPO62YJ650txWfS18HMG5XYJ1aUVwhPuWSrD90oh/J6jRg0gx6JXXFZzefjC
	x4SOUH0FFd6D9Fz7liKxNAWQfkzZqM4RJQ==
X-Google-Smtp-Source: AGHT+IHdnTmuyafE2JRM3bxlAVPoijUDWrS1QXFLioz63iwMoCQOSRAvuBGdJYYS78UGBl3JOKJ2XQ==
X-Received: by 2002:a05:600c:3593:b0:438:e231:d342 with SMTP id 5b1f17b1804b1-4392497dbe7mr101402985e9.1.1739215017178;
        Mon, 10 Feb 2025 11:16:57 -0800 (PST)
Received: from able.tailbefcf.ts.net ([91.151.136.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439492affe2sm21407905e9.28.2025.02.10.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:16:55 -0800 (PST)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: git@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] rebase: add `--update-refs=interactive`
Date: Mon, 10 Feb 2025 23:16:44 +0400
Message-ID: <20250210191650.316329-1-intelfx@intelfx.name>
X-Mailer: git-send-email 2.48.1.5.g9188e14f140
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rebase-heavy workflows involving multiple interdependent feature
branches, typing out `--update-refs` quickly becomes tiring, which
can be mitigated with setting the `rebase.updateRefs` git-config option
to perform update-refs by default.

However, the utility of `rebase.updateRefs` is somewhat limited because
you rarely want it in a non-interactive rebase (as it does not give you
the chance to review the update-refs candidates, likely leading to
updating refs that you didn't want updated -- I made quite an amount
of mess by setting this option and subsequently forgetting about it).

Try to find a middle ground by introducing a third value,
`--update-refs=interactive` (and `rebase.updateRefs=interactive`)
which means `--update-refs` when starting an interactive rebase and
`--no-update-refs` otherwise. This option is primarily intended to be
used in the gitconfig, but is also accepted on the command line
for completeness.

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 Documentation/config/rebase.txt |  7 +++-
 Documentation/git-rebase.txt    |  8 +++-
 builtin/rebase.c                | 72 +++++++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index c6187ab28b..d8bbaba69a 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -24,7 +24,12 @@ rebase.autoStash::
 	Defaults to false.
 
 rebase.updateRefs::
-	If set to true enable `--update-refs` option by default.
+	If set to true, enable the `--update-refs` option of
+	linkgit:git-rebase[1] by default. When set to 'interactive',
+	only enable `--update-refs` by default for interactive mode
+	(equivalent to `--update-refs=interactive`).
+	This option can be overridden by specifying any form of
+	`--update-refs` on the command line.
 
 rebase.missingCommitsCheck::
 	If set to "warn", git rebase -i will print a warning if some
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b18cdbc023..ae6939588d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -647,12 +647,18 @@ rebase --continue` is invoked. Currently, you cannot pass
 
 --update-refs::
 --no-update-refs::
+--update-refs=interactive::
 	Automatically force-update any branches that point to commits that
 	are being rebased. Any branches that are checked out in a worktree
 	are not updated in this way.
 +
+If `--update-refs=interactive` is specified, the behavior is equivalent to
+`--update-refs` if the rebase is interactive and `--no-update-refs` otherwise.
+(This is mainly useful as a configuration setting, although it might also be
+of use in aliases.)
++
 If the configuration variable `rebase.updateRefs` is set, then this option
-can be used to override and disable this setting.
+can be used to override or disable the configuration.
 +
 See also INCOMPATIBLE OPTIONS below.
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6c9eaf3788..57b456599b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -129,10 +129,17 @@ struct rebase_options {
 	int reschedule_failed_exec;
 	int reapply_cherry_picks;
 	int fork_point;
-	int update_refs;
+	// UPDATE_REFS_{UNKNOWN,NO,ALWAYS} numeric values must never
+	// change as post-option-parsing code works with {,config_}update_refs
+	// as if they were ints
+	enum {
+		UPDATE_REFS_UNKNOWN = -1,
+		UPDATE_REFS_NO = 0,
+		UPDATE_REFS_ALWAYS = 1,
+		UPDATE_REFS_INTERACTIVE,
+	} update_refs, config_update_refs;
 	int config_autosquash;
 	int config_rebase_merges;
-	int config_update_refs;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -150,8 +157,8 @@ struct rebase_options {
 		.autosquash = -1,                       \
 		.rebase_merges = -1,                    \
 		.config_rebase_merges = -1,             \
-		.update_refs = -1,                      \
-		.config_update_refs = -1,               \
+		.update_refs = UPDATE_REFS_UNKNOWN,     \
+		.config_update_refs = UPDATE_REFS_UNKNOWN, \
 		.strategy_opts = STRING_LIST_INIT_NODUP,\
 	}
 
@@ -412,6 +419,18 @@ static void imply_merge(struct rebase_options *opts, const char *option)
 	}
 }
 
+static int coerce_update_refs(const struct rebase_options *opts, int update_refs)
+{
+	/* coerce "=interactive" into "no" rather than "not set" when not interactive
+	 * this way, `git -c rebase.updateRefs=yes rebase --update-refs=interactive [without -i]`
+	 * will not inherit the "yes" from the config */
+	if (update_refs == UPDATE_REFS_INTERACTIVE)
+		return (opts->flags & REBASE_INTERACTIVE_EXPLICIT)
+		       ? UPDATE_REFS_ALWAYS
+		       : UPDATE_REFS_NO;
+	return update_refs;
+}
+
 /* Returns the filename prefixed by the state_dir */
 static const char *state_dir_path(const char *filename, struct rebase_options *opts)
 {
@@ -779,6 +798,17 @@ static void parse_rebase_merges_value(struct rebase_options *options, const char
 		die(_("Unknown rebase-merges mode: %s"), value);
 }
 
+static int parse_update_refs_value(const char *value, const char *desc)
+{
+	int v = git_parse_maybe_bool(value);
+	if (v >= 0)
+		return v ? UPDATE_REFS_ALWAYS : UPDATE_REFS_NO;
+	else if (!strcmp("interactive", value))
+		return UPDATE_REFS_INTERACTIVE;
+
+	die(_("bad %s value '%s'; valid values are boolean or \"interactive\""), desc, value);
+}
+
 static int rebase_config(const char *var, const char *value,
 			 const struct config_context *ctx, void *data)
 {
@@ -821,7 +851,8 @@ static int rebase_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "rebase.updaterefs")) {
-		opts->config_update_refs = git_config_bool(var, value);
+		opts->config_update_refs = parse_update_refs_value(value,
+			"rebase.updateRefs");
 		return 0;
 	}
 
@@ -1042,6 +1073,19 @@ static int parse_opt_rebase_merges(const struct option *opt, const char *arg, in
 	return 0;
 }
 
+static int parse_opt_update_refs(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *options = opt->value;
+
+	if (arg)
+		options->update_refs = parse_update_refs_value(arg,
+			"--update-refs");
+	else
+		options->update_refs = unset ? UPDATE_REFS_NO : UPDATE_REFS_ALWAYS;
+
+	return 0;
+}
+
 static void NORETURN error_on_missing_default_upstream(void)
 {
 	struct branch *current_branch = branch_get(NULL);
@@ -1187,9 +1231,11 @@ int cmd_rebase(int argc,
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
-		OPT_BOOL(0, "update-refs", &options.update_refs,
-			 N_("update branches that point to commits "
-			    "that are being rebased")),
+		OPT_CALLBACK_F(0, "update-refs", &options,
+			N_("(bool|interactive)"),
+			N_("update branches that point to commits "
+			   "that are being rebased"),
+			PARSE_OPT_OPTARG, parse_opt_update_refs),
 		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
@@ -1528,6 +1574,16 @@ int cmd_rebase(int argc,
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
+	/* coerce --update-refs=interactive into yes or no.
+	 * we do it here because there's just too much code below that handles
+	 * {,config_}update_refs in one way or another and modifying it to
+	 * account for the new state would be too invasive.
+	 * all further code uses {,config_}update_refs as a tristate. */
+	options.update_refs =
+		coerce_update_refs(&options, options.update_refs);
+	options.config_update_refs =
+		coerce_update_refs(&options, options.config_update_refs);
+
 	if (options.git_am_opts.nr || options.type == REBASE_APPLY) {
 		/* all am options except -q are compatible only with --apply */
 		for (i = options.git_am_opts.nr - 1; i >= 0; i--)
-- 
2.48.1.5.g9188e14f140

