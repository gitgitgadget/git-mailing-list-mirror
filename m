Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D44AA412
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365868; cv=none; b=iLG1ZJFfW7UflbwA6v/pPV/Hh1EV4a5yWvY72zY2tZs2/RQVwQPWNKj1L/u2Tia1pPwqTVvQtgc/U71tUZSuyUeN7Z9hbALSq5wJyEiC0VjhqvxZ9/ulsoHES5kdsI9ZagAZPfhUd22eQ/AkfXh+6onU3HBn4yin/YcQ4GorJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365868; c=relaxed/simple;
	bh=bFnvqylmT42e+Hu7wuTa9jJ7Ve6XQocN3j8G47ejEE4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=f0LK/5tmtfFMpu6kx//U9ZnNEYMYsaPuZtOk4QVGOWznNKsQTCRM1ZWvoQxTaQS6NzEpbbG7uAFXduTloZsPQjTv5lfygnhUY8NwAt/tEovLC/LhKKtYDXWKP7Hsckk9YFszRE26YuYb3uSG8oOBCfV9Htc7gJrD5N7wX/XPpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmxGISIi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmxGISIi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d9201076b3so15724145ad.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365865; x=1788970665; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dDszVDoN4Ub8RVlm4K88dFqZr/vNPtk0XJYrVSRUXRg=;
        b=BmxGISIiku19d0goQNMy+SLiTP2g1znghYs6yBkZEN4M9wAMU9PFeBbp//k2e93pjv
         7TKUXxHBiHO/IK5zbfgZEDOQhFyzuWfVuwamW/yKj0dvs2mFgcFaFbS3V+F9jdXFJOvr
         YlIaDFCrP4zenCmCH/dxIizSRxieRw45SxmXIaYglvaG/jnLODtnZ2ZHO7EASok+m/nS
         bvR3D1TmmNML+fBaJnzjnB3zJmrmrC4YuApfydaysL+v1kM4hVZ1R/kGt2Ij1NEmk0b1
         s1dhBvpgyj/30Y/FP7vqFPwrs3qbB4y83qUhfMLKJe8+6INPoGWK/GMDBOHJBXUQHQlz
         YvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365865; x=1788970665;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dDszVDoN4Ub8RVlm4K88dFqZr/vNPtk0XJYrVSRUXRg=;
        b=KgHOfADjT+mbKSkYc/60c58WFf22DlEmlQBum0gO99c8ntXOWiYugx3MI6dp42wCwL
         /Biz+GYUyovRlT2bY6PBbbp35C75FkWlPr2mqoDWFe8NcEHVBOeQPy90QZJUFQZ6wxpV
         YXtXD7T3u6y31rTJcZAWP9lMp/iPO8UNW6cHXYr52tDwtEIr0brdE7emgEcUCFTjBIWY
         diLSP13eWjIz7Ps17bXCPm+vDJ1WvJtKtL5kGWNaC0WzE13MNLQafmbUXfBaEokHw0vi
         ubY/K/h/LrEd9LS0jQH1tTzf4w4O+icI+s6keudGNogeL1pSdTkvcoU8mEKgz0G5ISnp
         +M+g==
X-Gm-Message-State: AFuF++n+z4O6rnAUeT5YCr+pRD+jx54VgLTrzOKuhnF6A/hwiBUV9hT3
	EO4tjgWd2BZRGz+O178mapBH3zr762gZU0R3LAPv8duC8HrRhp9dcfXZSJH/SA==
X-Gm-Gg: AYBFou13iED5rIR3ju4JGClNVK41+cftGDQ0lomP5bJBVBT0sYFiaToSrpzkozkVXf4
	9qqUi74UwaR5jakOITvo3/aoVja79/1Zw4lVGsN/f0rhW/7AsrSnzVp9yIwmncZdw20air8ytyL
	+DGrKt695w1VVPzVMyzhpv4rJhqkMkQBEWHmdCJIObiYqHlX+gFKhrTrvOPkwoaKdiJIqi/dQiD
	+UzBTDuUArABeqyoT7TQ5oVjno4sIoSIEnkb9zQKuHd/pZM9bHpVzwh4NkIMYS/+gxDc7+n2uR/
	GadoYgG6x3rjIauaE02kkhH5bZ/WRkzojn9Poy/1vwJXG2fVwjsjQv73+ry6+sAuAMSU6SfaGv6
	aVn8O52L9k+x0lKaeCN9x8c9RbTcw3va8+pleyZoqDgIvBjd38My4SY5T7wI3+o+8p52ktrcZL4
	RUQZTbTqjGMjwhSWQEpvWGGHSZ2UWMOWrSw1/+JibjVMlMuMHcX9Kchi3ysXYyoj67
X-Received: by 2002:a17:902:e787:b0:2d9:4358:73ab with SMTP id d9443c01a7336-2daec775fd0mr105020265ad.19.1788365864277;
        Wed, 02 Sep 2026 09:17:44 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.161.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b78e5dsm7153117eec.19.2026.09.02.09.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:17:43 -0700 (PDT)
Message-Id: <pull.2215.git.1788365862670.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 02 Sep 2026 16:17:42 +0000
Subject: [PATCH] hooks: introduce 'hooks.allowNoVerify' configuration
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

Introduce 'hooks.allowNoVerify' as an opt-in workflow guardrail to
prevent accidental bypass of hooks with '--no-verify' when set to false.
Authoritative enforcement remains server-side.

Signed-off-by: Alessio Attilio <alessio.attilio@protonmail.com>
---
    hooks: introduce 'hooks.allowNoVerify' configuration
    
    Introduce 'hooks.allowNoVerify' as an opt-in workflow guardrail
    (default: true) to prevent accidental bypass of hooks via '--no-verify'.
    This setting is intended for workflows and managed environments to avoid
    inadvertent bypasses, without altering Git's server-side security model.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2215%2Fkairosci%2Fhooks-allownoverify-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2215/kairosci/hooks-allownoverify-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2215

 Documentation/config.adoc       |   2 +
 Documentation/config/hooks.adoc |  10 +++
 builtin/am.c                    |   5 ++
 builtin/commit.c                |   8 ++
 builtin/merge.c                 |   6 ++
 builtin/push.c                  |   6 ++
 builtin/rebase.c                |  10 +++
 t/meson.build                   |   1 +
 t/t7599-hooks-allownoverify.sh  | 149 ++++++++++++++++++++++++++++++++
 9 files changed, 197 insertions(+)
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
index 0000000000..ce46645a1e
--- /dev/null
+++ b/Documentation/config/hooks.adoc
@@ -0,0 +1,10 @@
+`hooks.allowNoVerify`::
+	A boolean to specify whether `--no-verify` (or `-n`) command-line
+	option is permitted in commands such as `git commit` and `git push`.
+	When set to `false`, attempting to bypass hooks with `--no-verify`
+	will cause Git to abort immediately with a fatal error. Defaults to
+	`true`.
++
+Note that this setting serves as an opt-in workflow guardrail against
+accidental bypasses (for example in managed environments or CI runners),
+and does not replace authoritative server-side hook enforcement.
diff --git a/builtin/am.c b/builtin/am.c
index e9623b8307..8b82d4c1b6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2320,6 +2320,7 @@ int cmd_am(int argc,
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_type resume_mode = RESUME_FALSE;
 	int in_progress;
+	int allow_no_verify = 1;
 	int ret = 0;
 
 	const char * const usage[] = {
@@ -2448,6 +2449,7 @@ int cmd_am(int argc,
 	show_usage_with_options_if_asked(argc, argv, usage, options);
 
 	repo_config(the_repository, git_default_config, NULL);
+	repo_config_get_bool(the_repository, "hooks.allownoverify", &allow_no_verify);
 
 	am_state_init(&state);
 
@@ -2457,6 +2459,9 @@ int cmd_am(int argc,
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (state.no_verify && !allow_no_verify)
+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
+
 	if (binary >= 0)
 		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
 				"it will be removed. Please do not use it anymore."));
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..c59f7ded6e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -127,6 +127,7 @@ static struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
+static int allow_no_verify = 1;
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static const char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static const char *sign_commit, *pathspec_from_file;
@@ -1316,6 +1317,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	finalize_deferred_config(s);
 
+	if (no_verify && !allow_no_verify)
+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
+
 	if (force_author && !strchr(force_author, '>'))
 		force_author = find_author_by_nickname(force_author);
 
@@ -1691,6 +1695,10 @@ static int git_commit_config(const char *k, const char *v,
 							       &is_bool);
 		return 0;
 	}
+	if (!strcmp(k, "hooks.allownoverify")) {
+		allow_no_verify = git_config_bool(k, v);
+		return 0;
+	}
 
 	return git_status_config(k, v, ctx, s);
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index 5b4eb23a83..77fd6fc57e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -96,6 +96,7 @@ static int signoff;
 static const char *sign_commit;
 static int autostash;
 static int no_verify;
+static int allow_no_verify = 1;
 static char *into_name;
 
 static struct strategy all_strategy[] = {
@@ -727,6 +728,9 @@ static int git_merge_config(const char *k, const char *v,
 	} else if (!strcmp(k, "commit.gpgsign")) {
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
+	} else if (!strcmp(k, "hooks.allownoverify")) {
+		allow_no_verify = git_config_bool(k, v);
+		return 0;
 	} else if (!strcmp(k, "gpg.mintrustlevel")) {
 		check_trust_level = 0;
 	} else if (!strcmp(k, "merge.autostash")) {
@@ -1408,6 +1412,8 @@ int cmd_merge(int argc,
 		parse_branch_merge_options(branch_mergeoptions);
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if (no_verify && !allow_no_verify)
+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
 	if (shortlog_len < 0)
 		shortlog_len = (merge_log_config > 0) ? merge_log_config : 0;
 
diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..216603bb4f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -63,6 +63,7 @@ static int verbosity;
 static int progress = -1;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static enum transport_family family;
+static int allow_no_verify = 1;
 
 static struct push_cas_option cas;
 
@@ -543,6 +544,9 @@ static int git_push_config(const char *k, const char *v,
 		else
 			*flags &= ~TRANSPORT_PUSH_FORCE_IF_INCLUDES;
 		return 0;
+	} else if (!strcmp(k, "hooks.allownoverify")) {
+		allow_no_verify = git_config_bool(k, v);
+		return 0;
 	}
 
 	return git_default_config(k, v, ctx, NULL);
@@ -746,6 +750,8 @@ int cmd_push(int argc,
 	packet_trace_identity("push");
 	repo_config(the_repository, git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+	if ((flags & TRANSPORT_PUSH_NO_HOOK) && !allow_no_verify)
+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
 	push_options = (push_options_cmdline.nr
 		? &push_options_cmdline
 		: &push_options_config);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 10a306310c..eb996f0aa1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -790,6 +790,8 @@ static void parse_rebase_merges_value(struct rebase_options *options, const char
 		die(_("Unknown rebase-merges mode: %s"), value);
 }
 
+static int allow_no_verify = 1;
+
 static int rebase_config(const char *var, const char *value,
 			 const struct config_context *ctx, void *data)
 {
@@ -820,6 +822,11 @@ static int rebase_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "hooks.allownoverify")) {
+		allow_no_verify = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.rebasemerges")) {
 		opts->config_rebase_merges = git_parse_maybe_bool(value);
 		if (opts->config_rebase_merges < 0) {
@@ -1299,6 +1306,9 @@ int cmd_rebase(int argc,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
+	if (ok_to_skip_pre_rebase && !allow_no_verify)
+		die(_("the use of '--no-verify' is disabled by 'hooks.allowNoVerify'"));
+
 	if (options.trailer_args.nr) {
 		if (validate_trailer_args(&options.trailer_args))
 			die(NULL);
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
index 0000000000..eed99c128b
--- /dev/null
+++ b/t/t7599-hooks-allownoverify.sh
@@ -0,0 +1,149 @@
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
+test_done

base-commit: 1630431f326e15fcde608827b5ff38422528eb59
-- 
gitgitgadget
