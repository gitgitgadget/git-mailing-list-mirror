Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9494ACC76
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369800; cv=none; b=M2H9ypLKs/p7VPDlTyxztGNz94I80NAupYQoJ+qHS/7EYYYaOcRePCUHPlxHUyrIqYp1kDfTdjCzCi1/EKnZoVnbnb8n0BIuXSAqUhJYJQIKC0oP6Xx8xW8vJ0npn4RhUKtdtIV2B137w1SzlJ/EmbtDzGIsSN3TsP0DwI405qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369800; c=relaxed/simple;
	bh=2YBLr+5jR23R+hb1mfVULbUOnVTwHUiY/YoqCH81Mjw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NlK8vVom75VRXw7gV3EIidWLzaZmRVE0ZjRGGTIpUMiQAu7/C31+RrT9VSLnYrHz0+5DXee9vo4SUxUGIJXRctOJRyTg3F/1E8RVTiPMP7veBkJoWEoeEax/Anm/sykciXVhgab3j1tcE76DAuWIvxXX8RhHYJmFJ5H/jKxd/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTwrnc1+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTwrnc1+"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so1419901a12.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788369798; x=1788974598; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7lmk8fqv9b5R+bJupWDrCebAgOyeCLKyvhLyMG3hxWo=;
        b=UTwrnc1+VbsuCdoqxKDvZAqrdRf30EJ4EMdBb3UYcSl0+8C9gQdPkn723LqTsrzXrp
         2ZQhXjomvQaKSGPiz2iAlgIv+NlljBA7e+2eV5QuAcuA3PIJRG6cuLa8hYKTOTk97TnN
         P4rVR1PXK0x6m9msoDRNQXPMUNbxtUHjzLryu3Qj9LpSdEOT8UP9T/TZ4fBgdrruKUhu
         igVZUQwSOZwptOTuXKfd5bmke6zSv3F7Ixwxkpcp9tqrHusIApDZQUS7Wk4LOUjyy6IP
         w8+hRxHTMoedt6ycJam1I+9Zkr4FHfQahVGUl7U2dvL6dwPsFi+/TxgGv22rVNKrIM69
         qkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369798; x=1788974598;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lmk8fqv9b5R+bJupWDrCebAgOyeCLKyvhLyMG3hxWo=;
        b=GnJrukpywHrbCfRSSWBOd/pg1y8V2cP4+63rj5qrYRrVRY7n6c/TW3aAr2BxCYe9aX
         eACqped/YmEZYb9tXq62JvPBK9b/OFzojaccG2U4Txl4G0emYDRBJvQTfdFrJTKmpNlP
         KaBfAkjgOeq787iuV+d7crNsMaLUVFubFxs6ayTCAdW5CzqPCnp9IBQaUywnQwbFrPk5
         yRJGO0ZN+FIXH5bpJlUVdiutEFDxwZoc37h3ZT+Bkz2sXRQGAILwtW/s7/o0oi3NduAi
         XFvIjmgVZVgwxXBd1ymC4DnQqG3asDQDBE8ogbv6DNiy3NpopKZfyI9uB9SIz3Yo/e62
         74sQ==
X-Gm-Message-State: AFuF++mjAGx11P6EjGVxsVRV0STyZReRqtI8IJCn3bNzOpmjQQfHle8A
	nbgE1PhPtnA6YQitnqysDdtnKjCCvuCL1I8TROhybhXqxfSdw/8pHOBy91fang==
X-Gm-Gg: AYBFou30jePiA37QhBC62uopNNpnhn8R57RQsEISjsaOgdYQ6OdVsNTBWnMY4LFBl4N
	QkxkyLJMG8g905+eCjuSLGfQGItI3tjxDNIJaaYcOtK3/vxxzulccG7U6zVJgHcgzQxr60MAX9/
	6e75QAvmbZQCyBP7kdpF2igQx+Z0ZVQv3xBYA/eDC36KBKqF0vLT+/20UsdODP56ieTMfsbM6es
	wPdOUj86eOqq03TKm+nMS+bzX+wDMR50Y+7ErpTmFis3kqSfYW7Pd62csMKM8G2LTvtskA5qtCb
	2lKXTviPD4yQdfIw7qKqHhZ9wls670H50ZX2TLhXPPv/xXbgRHC8Sj5YArRQd8QWxAYhsextjkU
	VysiieYZ39edo3/NsFf3v42Qns0TB3pbPlqoAzIpdQPmAXObNWbaeb2d5Wyy+FMKtF7/Yq1VEKZ
	F2FTpLsq8DuXMiTQ3vBYDqJwGYFMzhXcLmeuM9GIw1edM2lp6q1D53T+DjKg+eow==
X-Received: by 2002:a17:90b:1811:b0:398:9beb:5c18 with SMTP id 98e67ed59e1d1-39aee178ab7mr8494777a91.19.1788369797412;
        Wed, 02 Sep 2026 10:23:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.69.160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430eb22012sm7582145c88.12.2026.09.02.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:23:15 -0700 (PDT)
Message-Id: <pull.2215.v3.git.1788369794965.gitgitgadget@gmail.com>
In-Reply-To: <pull.2215.git.1788365862670.gitgitgadget@gmail.com>
References: <pull.2215.git.1788365862670.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 02 Sep 2026 17:23:14 +0000
Subject: [PATCH v3] hooks: introduce 'hooks.allowNoVerify' configuration
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
inadvertently skipping local checks.

To address concerns regarding false senses of security without breaking
legitimate emergency escape hatches, allow configuring the variable to
'true' (the default), 'warn', or 'false'. In 'warn' mode, Git permits
the bypass while emitting a warning to standard error, ensuring
visibility without interrupting urgent workflows.

When set to 'false', Git aborts execution and provides actionable advice
explaining that the setting is an ergonomic workflow guardrail. To avoid
trapping developers during broken hook scripts or critical hotfixes,
the guardrail can be overridden by passing '-c hooks.allowNoVerify=true'
or by setting the 'GIT_ALLOW_NO_VERIFY=1' environment variable. This
prevents developers from having to resort to destructive workarounds
such as removing hook files or clearing execute permissions.

Centralize the option verification logic across all affected commands into
validate_no_verify() in hook.c.

Signed-off-by: Alessio Attilio <alessio.attilio@protonmail.com>
---
    hooks: introduce 'hooks.allowNoVerify' configuration
    
    Introduce 'hooks.allowNoVerify' as an opt-in workflow guardrail
    (default: true) to prevent accidental bypass of hooks via '--no-verify'.
    This setting is intended for workflows and managed environments to avoid
    inadvertent bypasses, without altering Git's server-side security model.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2215%2Fkairosci%2Fhooks-allownoverify-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2215/kairosci/hooks-allownoverify-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2215

Range-diff vs v2:

 1:  4e594568de ! 1:  cc98af8a9a hooks: introduce 'hooks.allowNoVerify' configuration
     @@ Commit message
          as an authoritative security boundary; authoritative policy enforcement
          belongs on the server (such as via pre-receive hooks). However,
          developers often invoke '--no-verify' out of habit or muscle memory,
     -    accidentally skipping local checks.
     +    inadvertently skipping local checks.
      
     -    To address both 'security theatre' concerns and avoid breaking legitimate
     -    emergency escape hatches ('big red button'), this implementation:
     +    To address concerns regarding false senses of security without breaking
     +    legitimate emergency escape hatches, allow configuring the variable to
     +    'true' (the default), 'warn', or 'false'. In 'warn' mode, Git permits
     +    the bypass while emitting a warning to standard error, ensuring
     +    visibility without interrupting urgent workflows.
      
     -    1. Introduces granular values:
     -       - 'true' (or 'always', default): '--no-verify' is permitted normally.
     -       - 'warn': '--no-verify' is permitted, but prints a warning to stderr.
     -       - 'false' (or 'never', 'error'): '--no-verify' is disallowed by default.
     +    When set to 'false', Git aborts execution and provides actionable advice
     +    explaining that the setting is an ergonomic workflow guardrail. To avoid
     +    trapping developers during broken hook scripts or critical hotfixes,
     +    the guardrail can be overridden by passing '-c hooks.allowNoVerify=true'
     +    or by setting the 'GIT_ALLOW_NO_VERIFY=1' environment variable. This
     +    prevents developers from having to resort to destructive workarounds
     +    such as removing hook files or clearing execute permissions.
      
     -    2. Preserves the emergency break-glass escape hatch:
     -       When configured to 'false', Git does not create a dead-end. It outputs
     -       actionable advice explaining that the setting is a workflow guardrail
     -       against accidental bypass, and documents how to override it in an
     -       emergency via 'GIT_ALLOW_NO_VERIFY=1' or '-c hooks.allowNoVerify=true'.
     -       This eliminates the need for developers to resort to destructive local
     -       hacks like deleting hooks or chmod -x.
     -
     -    3. Centralizes the validation logic in 'hook.c' and 'hook.h' via
     -       validate_no_verify().
     +    Centralize the option verification logic across all affected commands into
     +    validate_no_verify() in hook.c.
      
          Signed-off-by: Alessio Attilio <alessio.attilio@protonmail.com>
      
     @@ Documentation/config/hooks.adoc (new)
      +Allowed values are:
      ++
      +--
     -+* `true` (or `always`): `--no-verify` is permitted normally. This is the default.
     ++* `true`: `--no-verify` is permitted normally. This is the default.
      +* `warn`: `--no-verify` is permitted, but Git prints a warning on stderr.
     -+* `false` (or `never`, `error`): `--no-verify` is disallowed and Git aborts
     ++* `false`: `--no-verify` is disallowed and Git aborts
      +  with a fatal error accompanied by advice explaining how to override it.
      +--
      ++
     @@ hook.c: int run_hooks_l(struct repository *r, const char *hook_name, ...)
      +		return;
      +
      +	maybe_bool = git_parse_maybe_bool(val);
     -+	if (maybe_bool == 1 || !strcasecmp(val, "always")) {
     ++	if (maybe_bool == 1) {
      +		return;
      +	} else if (!strcasecmp(val, "warn")) {
      +		warning(_("bypassing hooks with '%s' is discouraged by 'hooks.allowNoVerify'"), opt);
      +		return;
     -+	} else if (maybe_bool == 0 || !strcasecmp(val, "never") || !strcasecmp(val, "error")) {
     ++	} else if (maybe_bool == 0) {
      +		advise(_("this repository disallows '%s' as a workflow guardrail against accidental bypass.\n"
      +			 "In an emergency (e.g. broken hook or urgent hotfix), you can override it with:\n"
      +			 "  git -c hooks.allowNoVerify=true <command>\n"
     @@ hook.c: int run_hooks_l(struct repository *r, const char *hook_name, ...)
      +		warning(_("unknown value for 'hooks.allowNoVerify': '%s'"), val);
      +	}
      +}
     -+
      
       ## hook.h ##
      @@ hook.h: int run_hooks(struct repository *r, const char *hook_name);
     @@ hook.h: int run_hooks(struct repository *r, const char *hook_name);
      +void validate_no_verify(struct repository *r, const char *opt);
      +
       #endif
     -+
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
     @@ t/t7599-hooks-allownoverify.sh (new)
      +	test_grep "bypassing hooks with .--no-verify. is discouraged" err
      +'
      +
     -+test_expect_success 'hooks.allowNoVerify=never disallows --no-verify' '
     -+	test_config hooks.allowNoVerify never &&
     ++test_expect_success 'hooks.allowNoVerify=0 disallows --no-verify' '
     ++	test_config hooks.allowNoVerify 0 &&
      +	echo "change14" >>init.t &&
      +	git add init.t &&
     -+	test_must_fail git commit --no-verify -m "fail never" 2>err &&
     -+	test_grep "hooks.allowNoVerify" err
     -+'
     -+
     -+test_expect_success 'hooks.allowNoVerify=error disallows --no-verify' '
     -+	test_config hooks.allowNoVerify error &&
     -+	echo "change15" >>init.t &&
     -+	git add init.t &&
     -+	test_must_fail git commit --no-verify -m "fail error" 2>err &&
     ++	test_must_fail git commit --no-verify -m "fail 0" 2>err &&
      +	test_grep "hooks.allowNoVerify" err
      +'
      +
     -+test_expect_success 'hooks.allowNoVerify=always allows --no-verify' '
     ++test_expect_success 'hooks.allowNoVerify=1 allows --no-verify' '
      +	test_when_finished "rm -f pre-commit.log" &&
     -+	test_config hooks.allowNoVerify always &&
     -+	echo "change16" >>init.t &&
     ++	test_config hooks.allowNoVerify 1 &&
     ++	echo "change15" >>init.t &&
      +	git add init.t &&
     -+	git commit --no-verify -m "commit always" &&
     ++	git commit --no-verify -m "commit 1" &&
      +	test_path_is_missing pre-commit.log
      +'
      +
      +test_done
     -+


 Documentation/config.adoc       |   2 +
 Documentation/config/hooks.adoc |  24 ++++
 Documentation/git.adoc          |   5 +
 builtin/am.c                    |   3 +
 builtin/commit.c                |   4 +
 builtin/merge.c                 |   2 +
 builtin/push.c                  |   3 +
 builtin/rebase.c                |   3 +
 hook.c                          |  29 +++++
 hook.h                          |  12 ++
 t/meson.build                   |   1 +
 t/t7599-hooks-allownoverify.sh  | 208 ++++++++++++++++++++++++++++++++
 12 files changed, 296 insertions(+)
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
index 0000000000..d94ac4b9b5
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
+* `true`: `--no-verify` is permitted normally. This is the default.
+* `warn`: `--no-verify` is permitted, but Git prints a warning on stderr.
+* `false`: `--no-verify` is disallowed and Git aborts
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
index d10eef4763..f972c66bd2 100644
--- a/hook.c
+++ b/hook.c
@@ -858,3 +858,32 @@ int run_hooks_l(struct repository *r, const char *hook_name, ...)
 
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
+	if (maybe_bool == 1) {
+		return;
+	} else if (!strcasecmp(val, "warn")) {
+		warning(_("bypassing hooks with '%s' is discouraged by 'hooks.allowNoVerify'"), opt);
+		return;
+	} else if (maybe_bool == 0) {
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
diff --git a/hook.h b/hook.h
index 27bb1aeb2e..b9e0b6703c 100644
--- a/hook.h
+++ b/hook.h
@@ -280,4 +280,16 @@ int run_hooks(struct repository *r, const char *hook_name);
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
index 0000000000..f02c0b1709
--- /dev/null
+++ b/t/t7599-hooks-allownoverify.sh
@@ -0,0 +1,208 @@
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
+test_expect_success 'hooks.allowNoVerify=0 disallows --no-verify' '
+	test_config hooks.allowNoVerify 0 &&
+	echo "change14" >>init.t &&
+	git add init.t &&
+	test_must_fail git commit --no-verify -m "fail 0" 2>err &&
+	test_grep "hooks.allowNoVerify" err
+'
+
+test_expect_success 'hooks.allowNoVerify=1 allows --no-verify' '
+	test_when_finished "rm -f pre-commit.log" &&
+	test_config hooks.allowNoVerify 1 &&
+	echo "change15" >>init.t &&
+	git add init.t &&
+	git commit --no-verify -m "commit 1" &&
+	test_path_is_missing pre-commit.log
+'
+
+test_done

base-commit: 1630431f326e15fcde608827b5ff38422528eb59
-- 
gitgitgadget
