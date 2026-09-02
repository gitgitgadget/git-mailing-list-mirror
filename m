Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F324A64F3
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366930; cv=none; b=AkHhblIXbBcJPyIvMOmSCfTH2QGialuIqbaHxmFo/KWswvHcGO2vrbGEJowXucVvic7zW28BgXOagX6NSrQbGKnejcEBiB+NNZzCf2vEFwA1v/HN4mtxOqc1V14j7c5uPwP6o8XpGy7I26Wh3ERuTWuon6EX7d4ooikhie6ji4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366930; c=relaxed/simple;
	bh=i2CY1f/uJF+scIXB3uJqTF+ACeMTxEdX3zZW9/Dmjp8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fkPPvPdOSNwev7d1/SN+9GTt2WxBs0W+qOTxtPJGZeM0KDu7kTtj7rA2WZFDrBGCVkAnUYPS3iQuHSaVl97gOGUngSt3EXxa0vDs87YoxfHodTm22qAD2BzoFNNyeO2rkyZOLQcgJjlpD761HtVt6B0bjA6AY4dkHK3+SB64G6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4ItFh5E; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4ItFh5E"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1264239a91.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788366927; x=1788971727; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SNYspNvwGnv0/AwiOEgxiVa9iXeuutvVcKTlv74T+l4=;
        b=A4ItFh5Euh/F+ZwabDwhZMbIuR4mDeEXEbtOrG9gZxre/XweOMv0OlBPqZf5oHcM+/
         AhiIclo+hR6ZjXlwXrbGe+Fmzf74B4OkjJbIECii2N7TPVkCOctierKHx+1ghxOjj+Aa
         4f/lE1LZIk4jpNqjeXEbACkedGN/wdLjqOQUS4b8p5NhDD/PrbpYxtR21TKE+Pdjj2YM
         rVJjpqbuNZedAnzC9+POHFBgRB6HcfZkrFG7ueKi8N8gqcmtHplCK+zKOacvo+opgUQZ
         Nv6XdGWbd4O9fdhw7g8LiTXKbILbyyb9rCce9mMdXj22yWHZaJLGt4FHm/HDDvCJZ0hd
         kVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366927; x=1788971727;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SNYspNvwGnv0/AwiOEgxiVa9iXeuutvVcKTlv74T+l4=;
        b=KhgxxZMVJ1DLv0PI0odmy7FCHx9V8sWd2zEU0zUEK2dAk2Q3Jb6ezu5R/FdwMHdaen
         uM5bAkNNg/6vpUGF52rMdXYnV3BPz6OxpzchgwRXCnBTU2EjOns88JOhzZSGWFppjzWE
         4fH0jCwriiu7nGz0G8EUYizgBNht62IwXnKcyRE/h6BErwBQtb/Q2VZqSz9vdDbCGzhZ
         JQh/1Pp6T512Oz1AhJx3p5Gt/jUawFKoJGBpSpQpNMyuZG/W+ujDdJ6aZncDYk7U/jnO
         tAEN/SHoRuetg7xBexq7SzuSuF623hpVsCYCObEOPsnv+faDacJ95JRWLOLH3HGqFG3d
         Kd4g==
X-Gm-Message-State: AFuF++k971BzcyOPNcP5HBHSG0Sv+1NFVXnQojt0kQffaDAXTDEZEIga
	sOpiKiqEJFb4Hvzor95h40Dj2tCVpNpoohHKpAIxf2b9il+kslDGwyAsm9X77w==
X-Gm-Gg: AYBFou3yA/5M5R1o0Jj7Mfus/UEJcJFQz1nmTwaNiL0t4r3TeXXlRxKenMM63ZnqNzo
	x9PDwfSskUimLRV6QM9rXJc0lxWoA/BsapxOTri5cODCBLongrZWaIOHagEnc5OFFH75EYf2mFu
	VHvhJw1JtaLTjh+Db4sQ2Abu0PUmrq6e/Sd4RCPILlxm7n39mlP5nlRNdB2spd1tpehthw4XJG7
	RBeKshmfep2qW63LrcniYgn91NVmj8Sisx4QF5e7+g46CodZjqF8G1h2OXrYhmAehnPsjBXQpwN
	H/S+Lj1ewosyNPyKqIeYSHTBtpB+s3mXyyjiFa2jzwoixq/I1KAfppNCJO7DDMK6L7wSwRPkSho
	/FEVKFuq4Q3RVl2c61+16umsoPLMOjpl6JjKtnZ2gpjXU+4jQ7cErU1g0c4oK49u7sRRlh7zNGD
	lJbO2o8kIuUU+dLNkw2KxfZZvQs5pGGUrWUOo1HbtkpfTq/yKigSeq2Gp1+U1upg==
X-Received: by 2002:a17:90a:e7cc:b0:396:b98b:a3c2 with SMTP id 98e67ed59e1d1-39aedf1b1ecmr8284998a91.8.1788366926654;
        Wed, 02 Sep 2026 09:35:26 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.67.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-331d6eaeb06sm5053719eec.9.2026.09.02.09.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:35:25 -0700 (PDT)
Message-Id: <pull.2215.v2.git.1788366925041.gitgitgadget@gmail.com>
In-Reply-To: <pull.2215.git.1788365862670.gitgitgadget@gmail.com>
References: <pull.2215.git.1788365862670.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 02 Sep 2026 16:35:25 +0000
Subject: [PATCH v2] hooks: introduce 'hooks.allowNoVerify' configuration
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Alessio Attilio <hello@kairosci.dev>,
    Alessio Attilio <alessio.attilio@protonmail.com>

From: Alessio Attilio <alessio.attilio@protonmail.com>

Introduce the 'hooks.allowNoVerify' configuration variable to control
whether the '--no-verify' (or '-n') command-line option is permitted
during operations executing client-side hooks (commit, push, merge,
rebase, am).

Client-side hooks execute in the user's local repository and cannot serve
as an authoritative security boundary; authoritative policy enforcement
belongs on the server (such as via pre-receive hooks). However,
developers often invoke '--no-verify' out of habit or muscle memory,
accidentally skipping local checks.

To address both 'security theatre' concerns and avoid breaking legitimate
emergency escape hatches ('big red button'), this implementation:

1. Introduces granular values:
   - 'true' (or 'always', default): '--no-verify' is permitted normally.
   - 'warn': '--no-verify' is permitted, but prints a warning to stderr.
   - 'false' (or 'never', 'error'): '--no-verify' is disallowed by default.

2. Preserves the emergency break-glass escape hatch:
   When configured to 'false', Git does not create a dead-end. It outputs
   actionable advice explaining that the setting is a workflow guardrail
   against accidental bypass, and documents how to override it in an
   emergency via 'GIT_ALLOW_NO_VERIFY=1' or '-c hooks.allowNoVerify=true'.
   This eliminates the need for developers to resort to destructive local
   hacks like deleting hooks or chmod -x.

3. Centralizes the validation logic in 'hook.c' and 'hook.h' via
   validate_no_verify().

Signed-off-by: Alessio Attilio <alessio.attilio@protonmail.com>
---
    hooks: introduce 'hooks.allowNoVerify' configuration
    
    Introduce 'hooks.allowNoVerify' as an opt-in workflow guardrail
    (default: true) to prevent accidental bypass of hooks via '--no-verify'.
    This setting is intended for workflows and managed environments to avoid
    inadvertent bypasses, without altering Git's server-side security model.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2215%2Fkairosci%2Fhooks-allownoverify-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2215/kairosci/hooks-allownoverify-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2215

Range-diff vs v1:

 1:  853636dad0 ! 1:  4e594568de hooks: introduce 'hooks.allowNoVerify' configuration
     @@ Metadata
       ## Commit message ##
          hooks: introduce 'hooks.allowNoVerify' configuration
      
     -    Introduce 'hooks.allowNoVerify' as an opt-in workflow guardrail to
     -    prevent accidental bypass of hooks with '--no-verify' when set to false.
     -    Authoritative enforcement remains server-side.
     +    Introduce the 'hooks.allowNoVerify' configuration variable to control
     +    whether the '--no-verify' (or '-n') command-line option is permitted
     +    during operations executing client-side hooks (commit, push, merge,
     +    rebase, am).
     +
     +    Client-side hooks execute in the user's local repository and cannot serve
     +    as an authoritative security boundary; authoritative policy enforcement
     +    belongs on the server (such as via pre-receive hooks). However,
     +    developers often invoke '--no-verify' out of habit or muscle memory,
     +    accidentally skipping local checks.
     +
     +    To address both 'security theatre' concerns and avoid breaking legitimate
     +    emergency escape hatches ('big red button'), this implementation:
     +
     +    1. Introduces granular values:
     +       - 'true' (or 'always', default): '--no-verify' is permitted normally.
     +       - 'warn': '--no-verify' is permitted, but prints a warning to stderr.
     +       - 'false' (or 'never', 'error'): '--no-verify' is disallowed by default.
     +
     +    2. Preserves the emergency break-glass escape hatch:
     +       When configured to 'false', Git does not create a dead-end. It outputs
     +       actionable advice explaining that the setting is a workflow guardrail
     +       against accidental bypass, and documents how to override it in an
     +       emergency via 'GIT_ALLOW_NO_VERIFY=1' or '-c hooks.allowNoVerify=true'.
     +       This eliminates the need for developers to resort to destructive local
     +       hacks like deleting hooks or chmod -x.
     +
     +    3. Centralizes the validation logic in 'hook.c' and 'hook.h' via
     +       validate_no_verify().
      
          Signed-off-by: Alessio Attilio <alessio.attilio@protonmail.com>
      
     @@ Documentation/config.adoc: include::config/help.adoc[]
       ## Documentation/config/hooks.adoc (new) ##
      @@
      +`hooks.allowNoVerify`::
     -+	A boolean to specify whether `--no-verify` (or `-n`) command-line
     -+	option is permitted in commands such as `git commit` and `git push`.
     -+	When set to `false`, attempting to bypass hooks with `--no-verify`
     -+	will cause Git to abort immediately with a fatal error. Defaults to
     -+	`true`.
     ++	Specifies whether the `--no-verify` (or `-n`) command-line option
     ++	is permitted in commands that run client-side hooks, such as `git commit`,
     ++	`git push`, `git merge`, `git rebase`, and `git am`.
      ++
     -+Note that this setting serves as an opt-in workflow guardrail against
     -+accidental bypasses (for example in managed environments or CI runners),
     -+and does not replace authoritative server-side hook enforcement.
     ++Allowed values are:
     +++
     ++--
     ++* `true` (or `always`): `--no-verify` is permitted normally. This is the default.
     ++* `warn`: `--no-verify` is permitted, but Git prints a warning on stderr.
     ++* `false` (or `never`, `error`): `--no-verify` is disallowed and Git aborts
     ++  with a fatal error accompanied by advice explaining how to override it.
     ++--
     +++
     ++In an emergency (for example, when a local hook crashes or during a critical
     ++production hotfix), this guardrail can be overridden without modifying
     ++configuration files by setting the `GIT_ALLOW_NO_VERIFY=1` environment variable
     ++or by passing `-c hooks.allowNoVerify=true` on the command line.
     +++
     ++NOTE: Client-side hooks execute in the developer's environment and belong to
     ++the user. This configuration serves strictly as an ergonomic workflow guardrail
     ++against accidental bypasses (such as muscle-memory `-n` or automated scripts),
     ++and must not be relied upon as a security boundary. Authoritative enforcement
     ++must always be implemented server-side (for example, via `pre-receive` hooks).
      
     - ## builtin/am.c ##
     -@@ builtin/am.c: int cmd_am(int argc,
     - 	int patch_format = PATCH_FORMAT_UNKNOWN;
     - 	enum resume_type resume_mode = RESUME_FALSE;
     - 	int in_progress;
     -+	int allow_no_verify = 1;
     - 	int ret = 0;
     - 
     - 	const char * const usage[] = {
     -@@ builtin/am.c: int cmd_am(int argc,
     - 	show_usage_with_options_if_asked(argc, argv, usage, options);
     - 
     - 	repo_config(the_repository, git_default_config, NULL);
     -+	repo_config_get_bool(the_repository, "hooks.allownoverify", &allow_no_verify);
     - 
     - 	am_state_init(&state);
     + ## Documentation/git.adoc ##
     +@@ Documentation/git.adoc: on some performance improvements or features). This variable currently
     + only affects clones and fetches; it is not yet used for pushes (but may
     + be in the future).
       
     ++`GIT_ALLOW_NO_VERIFY`::
     ++	If this Boolean environment variable is set to true (e.g. `1`), permits the use
     ++	of `--no-verify` (or `-n`) even when `hooks.allowNoVerify` is set to `false`.
     ++	This serves as an emergency override mechanism for workflows when hooks fail unexpectedly.
     ++
     + `GIT_OPTIONAL_LOCKS`::
     + 	If this Boolean environment variable is set to false, Git will complete any requested operation without
     + 	performing any optional sub-operations that require taking a lock.
     +
     + ## builtin/am.c ##
      @@ builtin/am.c: int cmd_am(int argc,
       
       	argc = parse_options(argc, argv, prefix, options, usage, 0);
       
     -+	if (state.no_verify && !allow_no_verify)
     -+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
     ++	if (state.no_verify)
     ++		validate_no_verify(the_repository, "--no-verify");
      +
       	if (binary >= 0)
       		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
       				"it will be removed. Please do not use it anymore."));
      
       ## builtin/commit.c ##
     -@@ builtin/commit.c: static struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
     - static int edit_flag = -1; /* unspecified */
     - static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
     - static int config_commit_verbose = -1; /* unspecified */
     -+static int allow_no_verify = 1;
     - static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
     - static const char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
     - static const char *sign_commit, *pathspec_from_file;
     +@@
     + #include "environment.h"
     + #include "diff.h"
     + #include "commit.h"
     ++#include "hook.h"
     + #include "add-interactive.h"
     + #include "gettext.h"
     + #include "revision.h"
      @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
       	argc = parse_options(argc, argv, prefix, options, usage, 0);
       	finalize_deferred_config(s);
       
     -+	if (no_verify && !allow_no_verify)
     -+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
     ++	if (no_verify)
     ++		validate_no_verify(the_repository, "--no-verify");
      +
       	if (force_author && !strchr(force_author, '>'))
       		force_author = find_author_by_nickname(force_author);
       
     -@@ builtin/commit.c: static int git_commit_config(const char *k, const char *v,
     - 							       &is_bool);
     - 		return 0;
     - 	}
     -+	if (!strcmp(k, "hooks.allownoverify")) {
     -+		allow_no_verify = git_config_bool(k, v);
     -+		return 0;
     -+	}
     - 
     - 	return git_status_config(k, v, ctx, s);
     - }
      
       ## builtin/merge.c ##
     -@@ builtin/merge.c: static int signoff;
     - static const char *sign_commit;
     - static int autostash;
     - static int no_verify;
     -+static int allow_no_verify = 1;
     - static char *into_name;
     - 
     - static struct strategy all_strategy[] = {
     -@@ builtin/merge.c: static int git_merge_config(const char *k, const char *v,
     - 	} else if (!strcmp(k, "commit.gpgsign")) {
     - 		sign_commit = git_config_bool(k, v) ? "" : NULL;
     - 		return 0;
     -+	} else if (!strcmp(k, "hooks.allownoverify")) {
     -+		allow_no_verify = git_config_bool(k, v);
     -+		return 0;
     - 	} else if (!strcmp(k, "gpg.mintrustlevel")) {
     - 		check_trust_level = 0;
     - 	} else if (!strcmp(k, "merge.autostash")) {
      @@ builtin/merge.c: int cmd_merge(int argc,
       		parse_branch_merge_options(branch_mergeoptions);
       	argc = parse_options(argc, argv, prefix, builtin_merge_options,
       			builtin_merge_usage, 0);
     -+	if (no_verify && !allow_no_verify)
     -+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
     ++	if (no_verify)
     ++		validate_no_verify(the_repository, "--no-verify");
       	if (shortlog_len < 0)
       		shortlog_len = (merge_log_config > 0) ? merge_log_config : 0;
       
      
       ## builtin/push.c ##
     -@@ builtin/push.c: static int verbosity;
     - static int progress = -1;
     - static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
     - static enum transport_family family;
     -+static int allow_no_verify = 1;
     - 
     - static struct push_cas_option cas;
     - 
     -@@ builtin/push.c: static int git_push_config(const char *k, const char *v,
     - 		else
     - 			*flags &= ~TRANSPORT_PUSH_FORCE_IF_INCLUDES;
     - 		return 0;
     -+	} else if (!strcmp(k, "hooks.allownoverify")) {
     -+		allow_no_verify = git_config_bool(k, v);
     -+		return 0;
     - 	}
     - 
     - 	return git_default_config(k, v, ctx, NULL);
     +@@
     + #include "environment.h"
     + #include "gettext.h"
     + #include "hex.h"
     ++#include "hook.h"
     + #include "refspec.h"
     + #include "run-command.h"
     + #include "remote.h"
      @@ builtin/push.c: int cmd_push(int argc,
       	packet_trace_identity("push");
       	repo_config(the_repository, git_push_config, &flags);
       	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
     -+	if ((flags & TRANSPORT_PUSH_NO_HOOK) && !allow_no_verify)
     -+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
     ++	if (flags & TRANSPORT_PUSH_NO_HOOK)
     ++		validate_no_verify(the_repository, "--no-verify");
       	push_options = (push_options_cmdline.nr
       		? &push_options_cmdline
       		: &push_options_config);
      
       ## builtin/rebase.c ##
     -@@ builtin/rebase.c: static void parse_rebase_merges_value(struct rebase_options *options, const char
     - 		die(_("Unknown rebase-merges mode: %s"), value);
     - }
     - 
     -+static int allow_no_verify = 1;
     -+
     - static int rebase_config(const char *var, const char *value,
     - 			 const struct config_context *ctx, void *data)
     - {
     -@@ builtin/rebase.c: static int rebase_config(const char *var, const char *value,
     - 		return 0;
     - 	}
     - 
     -+	if (!strcmp(var, "hooks.allownoverify")) {
     -+		allow_no_verify = git_config_bool(var, value);
     -+		return 0;
     -+	}
     -+
     - 	if (!strcmp(var, "rebase.rebasemerges")) {
     - 		opts->config_rebase_merges = git_parse_maybe_bool(value);
     - 		if (opts->config_rebase_merges < 0) {
      @@ builtin/rebase.c: int cmd_rebase(int argc,
       			     builtin_rebase_options,
       			     builtin_rebase_usage, 0);
       
     -+	if (ok_to_skip_pre_rebase && !allow_no_verify)
     -+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
     ++	if (ok_to_skip_pre_rebase)
     ++		validate_no_verify(the_repository, "--no-verify");
      +
       	if (options.trailer_args.nr) {
       		if (validate_trailer_args(&options.trailer_args))
       			die(NULL);
      
     + ## hook.c ##
     +@@ hook.c: int run_hooks_l(struct repository *r, const char *hook_name, ...)
     + 
     + 	return run_hooks_opt(r, hook_name, &opt);
     + }
     ++
     ++void validate_no_verify(struct repository *r, const char *opt)
     ++{
     ++	const char *val = NULL;
     ++	int maybe_bool;
     ++
     ++	if (git_env_bool("GIT_ALLOW_NO_VERIFY", 0))
     ++		return;
     ++
     ++	if (!r || repo_config_get_value(r, "hooks.allownoverify", &val))
     ++		return;
     ++
     ++	maybe_bool = git_parse_maybe_bool(val);
     ++	if (maybe_bool == 1 || !strcasecmp(val, "always")) {
     ++		return;
     ++	} else if (!strcasecmp(val, "warn")) {
     ++		warning(_("bypassing hooks with '%s' is discouraged by 'hooks.allowNoVerify'"), opt);
     ++		return;
     ++	} else if (maybe_bool == 0 || !strcasecmp(val, "never") || !strcasecmp(val, "error")) {
     ++		advise(_("this repository disallows '%s' as a workflow guardrail against accidental bypass.\n"
     ++			 "In an emergency (e.g. broken hook or urgent hotfix), you can override it with:\n"
     ++			 "  git -c hooks.allowNoVerify=true <command>\n"
     ++			 "or:\n"
     ++			 "  GIT_ALLOW_NO_VERIFY=1 git <command>"), opt);
     ++		die(_("the use of '%s' is disabled by 'hooks.allowNoVerify'"), opt);
     ++	} else {
     ++		warning(_("unknown value for 'hooks.allowNoVerify': '%s'"), val);
     ++	}
     ++}
     ++
     +
     + ## hook.h ##
     +@@ hook.h: int run_hooks(struct repository *r, const char *hook_name);
     +  */
     + LAST_ARG_MUST_BE_NULL
     + int run_hooks_l(struct repository *r, const char *hook_name, ...);
     ++
     ++/**
     ++ * Check if the use of '--no-verify' (or '-n') is permitted according to
     ++ * the 'hooks.allowNoVerify' configuration and 'GIT_ALLOW_NO_VERIFY' environment
     ++ * variable.
     ++ *
     ++ * If permitted, this function returns normally (or emits a warning if configured
     ++ * to 'warn'). If disallowed, it outputs advice on how to override the workflow
     ++ * guardrail in an emergency, then aborts with die().
     ++ */
     ++void validate_no_verify(struct repository *r, const char *opt);
     ++
     + #endif
     ++
     +
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
         't7526-commit-pathspec-file.sh',
     @@ t/t7599-hooks-allownoverify.sh (new)
      +	test_grep "hooks.allowNoVerify" err
      +'
      +
     ++test_expect_success 'CLI -c hooks.allowNoVerify=true overrides local false' '
     ++	test_config hooks.allowNoVerify false &&
     ++	echo "change10" >>init.t &&
     ++	git add init.t &&
     ++	git -c hooks.allowNoVerify=true commit --no-verify -m "override false with CLI true"
     ++'
     ++
     ++test_expect_success 'hooks.allowNoVerify=false provides emergency override advice' '
     ++	test_config hooks.allowNoVerify false &&
     ++	echo "change11" >>init.t &&
     ++	git add init.t &&
     ++	test_must_fail git commit --no-verify -m "fail advice" 2>err &&
     ++	test_grep "GIT_ALLOW_NO_VERIFY=1" err &&
     ++	test_grep "git -c hooks.allowNoVerify=true" err
     ++'
     ++
     ++test_expect_success 'GIT_ALLOW_NO_VERIFY=1 permits git commit --no-verify even when configured to false' '
     ++	test_when_finished "rm -f pre-commit.log" &&
     ++	test_config hooks.allowNoVerify false &&
     ++	echo "change12" >>init.t &&
     ++	git add init.t &&
     ++	GIT_ALLOW_NO_VERIFY=1 git commit --no-verify -m "emergency commit" &&
     ++	test_path_is_missing pre-commit.log
     ++'
     ++
     ++test_expect_success 'GIT_ALLOW_NO_VERIFY=1 permits git push --no-verify even when configured to false' '
     ++	test_when_finished "rm -f pre-push.log" &&
     ++	test_config hooks.allowNoVerify false &&
     ++	GIT_ALLOW_NO_VERIFY=1 git push --no-verify origin main &&
     ++	test_path_is_missing pre-push.log
     ++'
     ++
     ++test_expect_success 'hooks.allowNoVerify=warn permits --no-verify and warns on stderr' '
     ++	test_when_finished "rm -f pre-commit.log err" &&
     ++	test_config hooks.allowNoVerify warn &&
     ++	echo "change13" >>init.t &&
     ++	git add init.t &&
     ++	git commit --no-verify -m "commit with warn" 2>err &&
     ++	test_path_is_missing pre-commit.log &&
     ++	test_grep "bypassing hooks with .--no-verify. is discouraged" err
     ++'
     ++
     ++test_expect_success 'hooks.allowNoVerify=never disallows --no-verify' '
     ++	test_config hooks.allowNoVerify never &&
     ++	echo "change14" >>init.t &&
     ++	git add init.t &&
     ++	test_must_fail git commit --no-verify -m "fail never" 2>err &&
     ++	test_grep "hooks.allowNoVerify" err
     ++'
     ++
     ++test_expect_success 'hooks.allowNoVerify=error disallows --no-verify' '
     ++	test_config hooks.allowNoVerify error &&
     ++	echo "change15" >>init.t &&
     ++	git add init.t &&
     ++	test_must_fail git commit --no-verify -m "fail error" 2>err &&
     ++	test_grep "hooks.allowNoVerify" err
     ++'
     ++
     ++test_expect_success 'hooks.allowNoVerify=always allows --no-verify' '
     ++	test_when_finished "rm -f pre-commit.log" &&
     ++	test_config hooks.allowNoVerify always &&
     ++	echo "change16" >>init.t &&
     ++	git add init.t &&
     ++	git commit --no-verify -m "commit always" &&
     ++	test_path_is_missing pre-commit.log
     ++'
     ++
      +test_done
     ++


 Documentation/config.adoc       |   2 +
 Documentation/config/hooks.adoc |  24 ++++
 Documentation/git.adoc          |   5 +
 builtin/am.c                    |   3 +
 builtin/commit.c                |   4 +
 builtin/merge.c                 |   2 +
 builtin/push.c                  |   3 +
 builtin/rebase.c                |   3 +
 hook.c                          |  30 +++++
 hook.h                          |  13 ++
 t/meson.build                   |   1 +
 t/t7599-hooks-allownoverify.sh  | 217 ++++++++++++++++++++++++++++++++
 12 files changed, 307 insertions(+)
 create mode 100644 Documentation/config/hooks.adoc
 create mode 100755 t/t7599-hooks-allownoverify.sh

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index f67dcd2f8e..2ba351e6ee 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -508,6 +508,8 @@ include::config/help.adoc[]
 
 include::config/hook.adoc[]
 
+include::config/hooks.adoc[]
+
 include::config/http.adoc[]
 
 include::config/i18n.adoc[]
diff --git a/Documentation/config/hooks.adoc b/Documentation/config/hooks.adoc
new file mode 100644
index 0000000000..07830c5147
--- /dev/null
+++ b/Documentation/config/hooks.adoc
@@ -0,0 +1,24 @@
+`hooks.allowNoVerify`::
+	Specifies whether the `--no-verify` (or `-n`) command-line option
+	is permitted in commands that run client-side hooks, such as `git commit`,
+	`git push`, `git merge`, `git rebase`, and `git am`.
++
+Allowed values are:
++
+--
+* `true` (or `always`): `--no-verify` is permitted normally. This is the default.
+* `warn`: `--no-verify` is permitted, but Git prints a warning on stderr.
+* `false` (or `never`, `error`): `--no-verify` is disallowed and Git aborts
+  with a fatal error accompanied by advice explaining how to override it.
+--
++
+In an emergency (for example, when a local hook crashes or during a critical
+production hotfix), this guardrail can be overridden without modifying
+configuration files by setting the `GIT_ALLOW_NO_VERIFY=1` environment variable
+or by passing `-c hooks.allowNoVerify=true` on the command line.
++
+NOTE: Client-side hooks execute in the developer's environment and belong to
+the user. This configuration serves strictly as an ergonomic workflow guardrail
+against accidental bypasses (such as muscle-memory `-n` or automated scripts),
+and must not be relied upon as a security boundary. Authoritative enforcement
+must always be implemented server-side (for example, via `pre-receive` hooks).
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 8a5cdd3b3d..1b3af061a3 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -1018,6 +1018,11 @@ on some performance improvements or features). This variable currently
 only affects clones and fetches; it is not yet used for pushes (but may
 be in the future).
 
+`GIT_ALLOW_NO_VERIFY`::
+	If this Boolean environment variable is set to true (e.g. `1`), permits the use
+	of `--no-verify` (or `-n`) even when `hooks.allowNoVerify` is set to `false`.
+	This serves as an emergency override mechanism for workflows when hooks fail unexpectedly.
+
 `GIT_OPTIONAL_LOCKS`::
 	If this Boolean environment variable is set to false, Git will complete any requested operation without
 	performing any optional sub-operations that require taking a lock.
diff --git a/builtin/am.c b/builtin/am.c
index e9623b8307..c79b9a82f0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2457,6 +2457,9 @@ int cmd_am(int argc,
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (state.no_verify)
+		validate_no_verify(the_repository, "--no-verify");
+
 	if (binary >= 0)
 		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
 				"it will be removed. Please do not use it anymore."));
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..ef28c2cb9e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -19,6 +19,7 @@
 #include "environment.h"
 #include "diff.h"
 #include "commit.h"
+#include "hook.h"
 #include "add-interactive.h"
 #include "gettext.h"
 #include "revision.h"
@@ -1316,6 +1317,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	finalize_deferred_config(s);
 
+	if (no_verify)
+		validate_no_verify(the_repository, "--no-verify");
+
 	if (force_author && !strchr(force_author, '>'))
 		force_author = find_author_by_nickname(force_author);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 5b4eb23a83..0e6c2d4345 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1408,6 +1408,8 @@ int cmd_merge(int argc,
 		parse_branch_merge_options(branch_mergeoptions);
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if (no_verify)
+		validate_no_verify(the_repository, "--no-verify");
 	if (shortlog_len < 0)
 		shortlog_len = (merge_log_config > 0) ? merge_log_config : 0;
 
diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..98830da7f7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -12,6 +12,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "hook.h"
 #include "refspec.h"
 #include "run-command.h"
 #include "remote.h"
@@ -746,6 +747,8 @@ int cmd_push(int argc,
 	packet_trace_identity("push");
 	repo_config(the_repository, git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+	if (flags & TRANSPORT_PUSH_NO_HOOK)
+		validate_no_verify(the_repository, "--no-verify");
 	push_options = (push_options_cmdline.nr
 		? &push_options_cmdline
 		: &push_options_config);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 10a306310c..dff28f0119 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1299,6 +1299,9 @@ int cmd_rebase(int argc,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
+	if (ok_to_skip_pre_rebase)
+		validate_no_verify(the_repository, "--no-verify");
+
 	if (options.trailer_args.nr) {
 		if (validate_trailer_args(&options.trailer_args))
 			die(NULL);
diff --git a/hook.c b/hook.c
index d10eef4763..daed1b1c4b 100644
--- a/hook.c
+++ b/hook.c
@@ -858,3 +858,33 @@ int run_hooks_l(struct repository *r, const char *hook_name, ...)
 
 	return run_hooks_opt(r, hook_name, &opt);
 }
+
+void validate_no_verify(struct repository *r, const char *opt)
+{
+	const char *val = NULL;
+	int maybe_bool;
+
+	if (git_env_bool("GIT_ALLOW_NO_VERIFY", 0))
+		return;
+
+	if (!r || repo_config_get_value(r, "hooks.allownoverify", &val))
+		return;
+
+	maybe_bool = git_parse_maybe_bool(val);
+	if (maybe_bool == 1 || !strcasecmp(val, "always")) {
+		return;
+	} else if (!strcasecmp(val, "warn")) {
+		warning(_("bypassing hooks with '%s' is discouraged by 'hooks.allowNoVerify'"), opt);
+		return;
+	} else if (maybe_bool == 0 || !strcasecmp(val, "never") || !strcasecmp(val, "error")) {
+		advise(_("this repository disallows '%s' as a workflow guardrail against accidental bypass.\n"
+			 "In an emergency (e.g. broken hook or urgent hotfix), you can override it with:\n"
+			 "  git -c hooks.allowNoVerify=true <command>\n"
+			 "or:\n"
+			 "  GIT_ALLOW_NO_VERIFY=1 git <command>"), opt);
+		die(_("the use of '%s' is disabled by 'hooks.allowNoVerify'"), opt);
+	} else {
+		warning(_("unknown value for 'hooks.allowNoVerify': '%s'"), val);
+	}
+}
+
diff --git a/hook.h b/hook.h
index 27bb1aeb2e..0590ceee2d 100644
--- a/hook.h
+++ b/hook.h
@@ -280,4 +280,17 @@ int run_hooks(struct repository *r, const char *hook_name);
  */
 LAST_ARG_MUST_BE_NULL
 int run_hooks_l(struct repository *r, const char *hook_name, ...);
+
+/**
+ * Check if the use of '--no-verify' (or '-n') is permitted according to
+ * the 'hooks.allowNoVerify' configuration and 'GIT_ALLOW_NO_VERIFY' environment
+ * variable.
+ *
+ * If permitted, this function returns normally (or emits a warning if configured
+ * to 'warn'). If disallowed, it outputs advice on how to override the workflow
+ * guardrail in an emergency, then aborts with die().
+ */
+void validate_no_verify(struct repository *r, const char *opt);
+
 #endif
+
diff --git a/t/meson.build b/t/meson.build
index 7f53cca7d1..ce6ca1f6bf 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -945,6 +945,7 @@ integration_tests = [
   't7526-commit-pathspec-file.sh',
   't7527-builtin-fsmonitor.sh',
   't7528-signed-commit-ssh.sh',
+  't7599-hooks-allownoverify.sh',
   't7600-merge.sh',
   't7601-merge-pull-config.sh',
   't7602-merge-octopus-many.sh',
diff --git a/t/t7599-hooks-allownoverify.sh b/t/t7599-hooks-allownoverify.sh
new file mode 100755
index 0000000000..5a7dcf1d6e
--- /dev/null
+++ b/t/t7599-hooks-allownoverify.sh
@@ -0,0 +1,217 @@
+#!/bin/sh
+
+test_description='support hooks.allowNoVerify configuration to disallow --no-verify'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup test repository and hooks' '
+	test_commit init &&
+	test_hook --setup pre-commit <<-\HOOK_EOF &&
+	echo "pre-commit executed" >>pre-commit.log
+	if test -f fail-pre-commit
+	then
+		exit 1
+	fi
+	exit 0
+	HOOK_EOF
+	test_hook --setup pre-push <<-\HOOK_EOF &&
+	echo "pre-push executed" >>pre-push.log
+	if test -f fail-pre-push
+	then
+		exit 1
+	fi
+	exit 0
+	HOOK_EOF
+	git init --bare remote.git &&
+	git remote add origin remote.git &&
+	git push -u origin main &&
+	rm -f pre-commit.log pre-push.log
+'
+
+test_expect_success 'default: --no-verify is permitted for git commit' '
+	test_when_finished "rm -f pre-commit.log" &&
+	echo "change1" >>init.t &&
+	git add init.t &&
+	git commit --no-verify -m "commit with no-verify (default)" &&
+	test_path_is_missing pre-commit.log
+'
+
+test_expect_success 'default: -n is permitted for git commit' '
+	test_when_finished "rm -f pre-commit.log" &&
+	echo "change2" >>init.t &&
+	git add init.t &&
+	git commit -n -m "commit with -n (default)" &&
+	test_path_is_missing pre-commit.log
+'
+
+test_expect_success 'default: --no-verify is permitted for git push' '
+	test_when_finished "rm -f pre-push.log" &&
+	rm -f pre-push.log &&
+	git push --no-verify origin main &&
+	test_path_is_missing pre-push.log
+'
+
+test_expect_success 'explicit hooks.allowNoVerify=true allows --no-verify' '
+	test_when_finished "rm -f pre-commit.log" &&
+	test_config hooks.allowNoVerify true &&
+	echo "change3" >>init.t &&
+	git add init.t &&
+	git commit --no-verify -m "commit with no-verify allowed" &&
+	test_path_is_missing pre-commit.log
+'
+
+test_expect_success 'hooks.allowNoVerify=false disallows git commit --no-verify' '
+	test_config hooks.allowNoVerify false &&
+	echo "change4" >>init.t &&
+	git add init.t &&
+	test_must_fail git commit --no-verify -m "should fail" 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'hooks.allowNoVerify=false disallows git commit -n' '
+	test_config hooks.allowNoVerify false &&
+	echo "change5" >>init.t &&
+	git add init.t &&
+	test_must_fail git commit -n -m "should fail" 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'hooks.allowNoVerify=false disallows git push --no-verify' '
+	test_config hooks.allowNoVerify false &&
+	test_must_fail git push --no-verify origin main 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'hooks.allowNoVerify=false disallows git merge --no-verify' '
+	test_config hooks.allowNoVerify false &&
+	git checkout -b branch-merge main &&
+	echo "merge change" >merge_file &&
+	git add merge_file &&
+	git commit -m "merge commit" &&
+	git checkout main &&
+	test_must_fail git merge --no-verify branch-merge -m "merge fail" 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'hooks.allowNoVerify=false disallows git rebase --no-verify' '
+	test_config hooks.allowNoVerify false &&
+	test_must_fail git rebase --no-verify main branch-merge 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'hooks.allowNoVerify=false still runs hooks when --no-verify is not used' '
+	test_when_finished "rm -f pre-commit.log" &&
+	test_config hooks.allowNoVerify false &&
+	echo "change6" >>init.t &&
+	git add init.t &&
+	git commit -m "normal commit" &&
+	test_path_is_file pre-commit.log
+'
+
+test_expect_success 'hooks.allowNoVerify=false enforces hook execution (hook failure prevents commit)' '
+	test_when_finished "rm -f fail-pre-commit pre-commit.log" &&
+	test_config hooks.allowNoVerify false &&
+	touch fail-pre-commit &&
+	echo "change7" >>init.t &&
+	git add init.t &&
+	test_must_fail git commit -m "failing hook" &&
+	test_must_fail git commit --no-verify -m "cannot bypass" 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'hooks.allowNoVerify=false still runs pre-push hook on git push' '
+	test_when_finished "rm -f pre-push.log" &&
+	test_config hooks.allowNoVerify false &&
+	git push origin main &&
+	test_path_is_file pre-push.log
+'
+
+test_expect_success 'CLI -c hooks.allowNoVerify=false overrides local true' '
+	test_config hooks.allowNoVerify true &&
+	echo "change8" >>init.t &&
+	git add init.t &&
+	test_must_fail git -c hooks.allowNoVerify=false commit --no-verify -m "override" 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'local hooks.allowNoVerify=false overrides global true' '
+	test_config_global hooks.allowNoVerify true &&
+	test_config hooks.allowNoVerify false &&
+	echo "change9" >>init.t &&
+	git add init.t &&
+	test_must_fail git commit --no-verify -m "local override" 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'CLI -c hooks.allowNoVerify=true overrides local false' '
+	test_config hooks.allowNoVerify false &&
+	echo "change10" >>init.t &&
+	git add init.t &&
+	git -c hooks.allowNoVerify=true commit --no-verify -m "override false with CLI true"
+'
+
+test_expect_success 'hooks.allowNoVerify=false provides emergency override advice' '
+	test_config hooks.allowNoVerify false &&
+	echo "change11" >>init.t &&
+	git add init.t &&
+	test_must_fail git commit --no-verify -m "fail advice" 2>err &&
+	test_grep "GIT_ALLOW_NO_VERIFY=1" err &&
+	test_grep "git -c hooks.allowNoVerify=true" err
+'
+
+test_expect_success 'GIT_ALLOW_NO_VERIFY=1 permits git commit --no-verify even when configured to false' '
+	test_when_finished "rm -f pre-commit.log" &&
+	test_config hooks.allowNoVerify false &&
+	echo "change12" >>init.t &&
+	git add init.t &&
+	GIT_ALLOW_NO_VERIFY=1 git commit --no-verify -m "emergency commit" &&
+	test_path_is_missing pre-commit.log
+'
+
+test_expect_success 'GIT_ALLOW_NO_VERIFY=1 permits git push --no-verify even when configured to false' '
+	test_when_finished "rm -f pre-push.log" &&
+	test_config hooks.allowNoVerify false &&
+	GIT_ALLOW_NO_VERIFY=1 git push --no-verify origin main &&
+	test_path_is_missing pre-push.log
+'
+
+test_expect_success 'hooks.allowNoVerify=warn permits --no-verify and warns on stderr' '
+	test_when_finished "rm -f pre-commit.log err" &&
+	test_config hooks.allowNoVerify warn &&
+	echo "change13" >>init.t &&
+	git add init.t &&
+	git commit --no-verify -m "commit with warn" 2>err &&
+	test_path_is_missing pre-commit.log &&
+	test_grep "bypassing hooks with .--no-verify. is discouraged" err
+'
+
+test_expect_success 'hooks.allowNoVerify=never disallows --no-verify' '
+	test_config hooks.allowNoVerify never &&
+	echo "change14" >>init.t &&
+	git add init.t &&
+	test_must_fail git commit --no-verify -m "fail never" 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'hooks.allowNoVerify=error disallows --no-verify' '
+	test_config hooks.allowNoVerify error &&
+	echo "change15" >>init.t &&
+	git add init.t &&
+	test_must_fail git commit --no-verify -m "fail error" 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'hooks.allowNoVerify=always allows --no-verify' '
+	test_when_finished "rm -f pre-commit.log" &&
+	test_config hooks.allowNoVerify always &&
+	echo "change16" >>init.t &&
+	git add init.t &&
+	git commit --no-verify -m "commit always" &&
+	test_path_is_missing pre-commit.log
+'
+
+test_done
+

base-commit: 1630431f326e15fcde608827b5ff38422528eb59
-- 
gitgitgadget
