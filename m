Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BE2DA768
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737578; cv=none; b=LV1Jt62xlKGKGPEo2c4QOFnEWoSiYGoFQtNsTPbQu/dw4RnOpKHAzFWInwsohz6nWYqTdLgbZtK55+NPivhhiJYiLPh23cC/sgmtzq1piw+tILj9T6zzDhyve4hkl6YNvJEV50gF3GOgAegBKbKInDsq9EvGx5DnpRB+JzK6vGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737578; c=relaxed/simple;
	bh=XUL8rd2crTr+8BO6M1uTnQ/qk4POV0WSiVnl3mzxWCM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=hRWLMjHH683aVy9BHrWtGzj33AO4ZobCk7I1JAoIPwmlrbOUpAojgD0V7fIGrJs0CPTnH4/mm76YhWjsL3nZQ2eDyh01hHC2nRf41/ajY3DZwtUcyvRB5o4k7BMa1kOe9Bv0VO6HFineZhuMowwIqKHh3Olfda07K6WAqa03ew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNHEuCU/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNHEuCU/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c5389c3cd2so97906285a.0
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770737575; x=1771342375; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S/kYCfGnTPS1ne7UNzSIoDvF/ewYpFxCy0eAg0oMZac=;
        b=ZNHEuCU/Gg/4MHpVK5Eyprse9+dMTnsVRGgeaCkPojMhYPnqUbhAJsjCFVYv+L6JAQ
         JfBcsGWw8zCaPR6zRo6fXfD4azJfw7lzSdyxBVUi+22w+Znl2hiYnCDshOwzhFq4u41i
         NRBF5U07wK7PZHNtGrqhC/5grc/vbDy6QS9bJN2dv+Ztjj1eYg86AKiE+S2bVE3fWhO+
         Ya6e35VOY5SOIkamL4WbK/w3SxJjQjRnf3vBdRtO3F2iClYMGrwxjLPVPt06sYch3IEd
         /L32OhNxiTRyjfJ695AOOm4YiboSHlgOFb984KNFEH5AmoHDtNkDpRoq0T6FI4PqFKOc
         8UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770737575; x=1771342375;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/kYCfGnTPS1ne7UNzSIoDvF/ewYpFxCy0eAg0oMZac=;
        b=WFbOiXPDFkSzHQIe/aKK+jxaPUOHY6FrssKkrePwxGfehMLCRNm4wKGNgGjsPUIUvJ
         ryADmnUEgUirxSILBVwoyafYCd3AnUOUCKShVOF1Mmi9C1mLHAAjjv9Nru3tNuITtorY
         ogIzHz9n2tmkz1cnNFjuG3uYS76bX2Ep2jDXsRs7TNbOnG2QNkdctjbEDc0M7mpkBlMB
         wNSnHTCqOLwjmw8S/7szDFNG2w0EqnxWnZJJCmde9+YP6bh6+AoSAlsPZYWUPM/pcZhR
         wUa99DCvo45tXWxE62+WF83Yoi/qTCTCVFXgkUD/8JxgX3HN/59YPEvr6u+XbzvxLQgu
         /DAA==
X-Gm-Message-State: AOJu0YxMTc3iogb/jOlHjZdI3s/xi+G8QyWJOegxHbp9p0/brPi67+eO
	iqPII2+x/f3nQOwTmRnD7fnX9rDCWBTyRzgIfjGq6fSJg9LgJxl1CYX855DXgg==
X-Gm-Gg: AZuq6aIxfOKuLfpKqqTdKPuVxHFDg2i31AXfVYhT091weBQJZzZM0FSsuVGFoIc1OXt
	gCrph4UgjhRUp36sg+xh2JULA2XcVofiBTW4YYizQds1UEuCZkQkWNdI1byZt/JddecmeqN00CU
	3Oj8zeWrRlkz3/ZEIGHYLEllF53NJcSgPRR3eTTAmudcfPMIenNP8DYVsibWH0R6EosheTjeEq9
	i6YwytNvpDwZE/QLWNS4Mv8XIRhyEwiOkxNys+ne7LgTeA6suitqOGDkLVYGOK7wt6ulClAtBPR
	SPP0KDVOH/zjdP6nCvMfX3SVC2A4sq2I5PNEKO/23a/tKhz9LMzOkUuKCgfd4TMd4J/U96dt38s
	vbsoQ3KhgkeiTph5sOJLdx5Q96YlMOAcNTEZiSadF2wz2NF4/+Y5WzUKHc9vbkQe9zHho+Y/MZI
	gKoC+iYg45gJk+miZ670TIWmA=
X-Received: by 2002:a05:620a:2913:b0:8b2:e5da:d317 with SMTP id af79cd13be357-8caf0d3d1ffmr1957874485a.54.1770737575000;
        Tue, 10 Feb 2026 07:32:55 -0800 (PST)
Received: from [127.0.0.1] ([20.98.23.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee8662sm1152107785a.37.2026.02.10.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 07:32:54 -0800 (PST)
Message-Id: <pull.2045.git.1770737573475.gitgitgadget@gmail.com>
From: "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 15:32:53 +0000
Subject: [PATCH] add: support pre-add hook
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
Cc: Chandra Kethi-Reddy <chandrakr@pm.me>,
    Chandra Kethi-Reddy <chandrakr@pm.me>

From: Chandra Kethi-Reddy <chandrakr@pm.me>

git has no hook that fires during 'git add'.  Users who want to
validate files before staging must wrap 'git add' in a shell alias
or wait for pre-commit, which fires after staging is already done.

Add a pre-add hook that runs after pathspec validation and before
any files are staged.  If the hook exits non-zero, 'git add' aborts
without modifying the index.  The hook receives GIT_INDEX_FILE in
its environment, following the same convention as pre-commit.

The hook is bypassed with '--no-verify' (long flag only, since '-n'
is already '--dry-run' in 'git add').  It is not invoked for
--interactive, --patch, --edit, or --dry-run modes, nor by
'git commit -a' which stages files through its own code path in
builtin/commit.c.

The implementation calls run_hooks_opt() directly rather than the
run_commit_hook() wrapper, which sets GIT_EDITOR=: and is not
relevant for 'git add'.  When no hook is installed, there is no
performance impact.

Disclosure: developed with guidance from Claude Code (Anthropic)
and Codex CLI (OpenAI) for development, review and standards
compliance. The contributor handtyped and reviewed all tests, code,
and documentation.

Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
---
    add: support pre-add hook

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2045%2Fshatachandra%2Fpre-add-hooks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2045/shatachandra/pre-add-hooks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2045

 Documentation/git-add.adoc  |  10 ++-
 Documentation/githooks.adoc |  17 ++++++
 builtin/add.c               |  14 +++++
 t/t3706-pre-add-hook.sh     | 117 ++++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 t/t3706-pre-add-hook.sh

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 6192daeb03..c60e0c65a5 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 [synopsis]
 git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
-	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
+	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize] [--no-verify]
 	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	[--] [<pathspec>...]
 
@@ -42,6 +42,9 @@ use the `--force` option to add ignored files. If you specify the exact
 filename of an ignored file, `git add` will fail with a list of ignored
 files. Otherwise it will silently ignore the file.
 
+A pre-add hook can be run to inspect or reject the add operation before
+it stages files. See linkgit:githooks[5] for details.
+
 Please see linkgit:git-commit[1] for alternative ways to add content to a
 commit.
 
@@ -163,6 +166,10 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
 
+`--no-verify`::
+	Bypass the pre-add hook if it exists. See linkgit:githooks[5] for
+	more information about hooks.
+
 `--ignore-errors`::
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
@@ -451,6 +458,7 @@ linkgit:git-reset[1]
 linkgit:git-mv[1]
 linkgit:git-commit[1]
 linkgit:git-update-index[1]
+linkgit:githooks[5]
 
 GIT
 ---
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 056553788d..51156822bc 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -94,6 +94,23 @@ and is invoked after the patch is applied and a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git am`.
 
+pre-add
+~~~~~~~
+
+This hook is invoked by linkgit:git-add[1], and can be bypassed with the
+`--no-verify` option. This hook is not invoked for `--interactive`, `--patch`,
+`--edit`, or `--dry-run`. It takes no parameters, and is invoked after pathspec
+validation and before any files are staged. Exiting with a non-zero status
+from this script causes the `git add` command to abort without modifying the
+index.
+
+This hook is invoked with the environment variable `GIT_INDEX_FILE`
+which points to the index file. This allows the hook to inspect what
+files would be staged before the operation proceeds.
+
+This hook is not invoked by `git commit -a` or `git commit --include` which
+still can run the pre-commit hook, providing a control point at commit time.
+
 pre-commit
 ~~~~~~~~~~
 
diff --git a/builtin/add.c b/builtin/add.c
index 32709794b3..7747b41d10 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -25,6 +25,7 @@
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "hook.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -36,6 +37,7 @@ static int take_worktree_changes;
 static int add_renormalize;
 static int pathspec_file_nul;
 static int include_sparse;
+static int no_verify;
 static const char *pathspec_from_file;
 
 static int chmod_pathspec(struct repository *repo,
@@ -271,6 +273,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	OPT_BOOL( 0 , "no-verify", &no_verify, N_("bypass pre-add hook")),
 	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
 		   N_("override the executable bit of the listed files")),
@@ -576,6 +579,17 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
+	if (!show_only && !no_verify) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
+		strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s",
+			     repo_get_index_file(repo));
+		if (run_hooks_opt(repo, "pre-add", &opt)) {
+			exit_status = 1;
+			goto finish;
+		}
+	}
+
 	transaction = odb_transaction_begin(repo->objects);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
diff --git a/t/t3706-pre-add-hook.sh b/t/t3706-pre-add-hook.sh
new file mode 100644
index 0000000000..e64ee51b25
--- /dev/null
+++ b/t/t3706-pre-add-hook.sh
@@ -0,0 +1,117 @@
+#!/bin/sh
+
+test_description='pre-add hook tests
+
+These tests run git add with and without pre-add hooks to ensure functionality. Largely derived from t7503 (pre-commit and pre-merge-commit hooks) and t5571 (pre-push hooks).'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'with no hook' '
+	test_when_finished "rm -f actual" &&
+	echo content >file &&
+	git add file &&
+	test_path_is_missing actual
+'
+
+test_expect_success POSIXPERM 'with non-executable hook' '
+	test_when_finished "rm -f actual" &&
+	test_hook pre-add <<-\EOF &&
+	echo should-not-run >>actual
+	exit 1
+	EOF
+	chmod -x .git/hooks/pre-add &&
+
+	echo content >file &&
+	git add file &&
+	test_path_is_missing actual
+'
+
+test_expect_success '--no-verify with no hook' '
+	echo content >file &&
+	git add --no-verify file &&
+	test_path_is_missing actual
+'
+
+test_expect_success 'with succeeding hook' '
+	test_when_finished "rm -f actual expected" &&
+	echo "pre-add" >expected &&
+	test_hook pre-add <<-\EOF &&
+	echo pre-add >>actual
+	EOF
+
+	echo content >file &&
+	git add file &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with failing hook' '
+	test_when_finished "rm -f actual" &&
+	test_hook pre-add <<-\EOF &&
+	echo pre-add-rejected >>actual
+	exit 1
+	EOF
+
+	echo content >file &&
+	test_must_fail git add file
+'
+
+test_expect_success '--no-verify with failing hook' '
+	test_when_finished "rm -f actual" &&
+	test_hook pre-add <<-\EOF &&
+	echo should-not-run >>actual
+	exit 1
+	EOF
+
+	echo content >file &&
+	git add --no-verify file &&
+	test_path_is_missing actual
+'
+
+test_expect_success 'hook receives GIT_INDEX_FILE environment variable' '
+	test_when_finished "rm -f actual expected" &&
+	echo "hook-saw-env" >expected &&
+	test_hook pre-add <<-\EOF &&
+	if test -z "$GIT_INDEX_FILE"
+	then
+		echo hook-missing-env >>actual
+	else
+		echo hook-saw-env >>actual
+	fi
+	EOF
+
+	echo content >file &&
+	git add file &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with --dry-run (show-only) the hook is not invoked' '
+	test_when_finished "rm -f actual" &&
+	test_hook pre-add <<-\EOF &&
+	echo should-not-run >>actual
+	exit 1
+	EOF
+
+	echo content >file &&
+	git add --dry-run file &&
+	test_path_is_missing actual
+'
+
+test_expect_success 'hook is invoked with git add -u' '
+	test_when_finished "rm -f actual expected file" &&
+	echo "initial" >file &&
+	git add file &&
+	git commit -m "initial" &&
+	echo "pre-add" >expected &&
+	test_hook pre-add <<-\EOF &&
+	echo pre-add >>actual
+	EOF
+
+	echo modified >file &&
+	git add -u &&
+	test_cmp expected actual
+'
+
+test_done

base-commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09
-- 
gitgitgadget
