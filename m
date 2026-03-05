Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36439E172
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714260; cv=none; b=O371Rk+x8iYUHgXIbJJ9PylD+2CBeVeJBbQa8leJZOUFvXN19EeJmmAyfttCeyRP7zUFixnR3xf7CueqP76NBj0JH3Vh1lvNnN2+v/io3VskuDtw5PSNr2O1m2Mkzlp9uOd0yE9EtYZ+eJo4ytkYdhURt030agq5AoY3hw5YIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714260; c=relaxed/simple;
	bh=R4ys6k0nAJuMcoL89T1XoLFCP6BebzXz7OvtDXOG5Xg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tpEhEWVeCoZCldAxRPu2Z8aR4tysltq063urb7w6gaf9vKkzsE0+qGmPdEk9h9v/MOOazy/+NzBRJHlGTJoFzg2gydLTpawHjJ4Jmve1q/OWW25E2IGrt4YMEgLzuNG8d0xhTdXGtwOul5PZD1wUK38Xpyn/57k07qfcUWoDu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVOPguI+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVOPguI+"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c7377119453so831869a12.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 04:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772714255; x=1773319055; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YYaJ+PanpKWDs7E3Ken0KAEXVfCBuzPH3BL7mgMqpY=;
        b=JVOPguI+m/1x5ELl2XbTzuZIewCfwkY0q4SjbbhvqzVRsPM2CE3GWLUvUMUzuEy/cN
         c3TDTxvyEpRw3XuUPFeuhrrJqMzxtTzPXICZpDUQ74vCrpGcEIWKxTiXvBVKC5Bvv13h
         LO9Chr68u0zzvShrDgfd2r4mjbr92tgmzwbJ4gyKUwPVU8GPz2P8GqDfoPp23jWhNGir
         jJqDSgW7u/zQuDqqsTsQUjHbdN/C7lGzofl/Q52kmygIK+0R0CAX1I4pP/c1C3vWK8Jr
         bj2tVNMGChFVpj+2Fd2vHYPDOKiO01Pl2N689dH/WgcC7I0gzzepUYQHQXzilKleYUCN
         dMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714255; x=1773319055;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YYaJ+PanpKWDs7E3Ken0KAEXVfCBuzPH3BL7mgMqpY=;
        b=gChsFWA3ZAmjlYvsP13Igf7wz/PDTt5weWs0H6J7xZBPjnBKYLoe18wlNBYwRLaQMO
         HTg7qmbAdD2Bl5T75evYaKtJ8LgBTtyJQqJf0lgcOS7oDG4UE5/liVbM6SaIsG+XiSK3
         yJAElFBSY7nYAyhOfbqCzucUJhBa5u246dKteckcjgW46emYE0XczozHQxYjWgA0mFef
         87xtr+0Hhr9YotFfXNBAslhRvmjvjT2zf4dDnHJuakUWPlRwXN3nv8MWw8GlI+PPHUwi
         B4lR+o1xCoh0/vwAHZrg4K4JQsj7vzPymJMG7EZThLcoFL46Apb31fczxG3TN7sNOZfy
         KsCQ==
X-Gm-Message-State: AOJu0YxzO+G864eoNoGpzL1KhwsOZJvweCyFdfMv7PUWjSxu4aCwId1+
	32lGC53jlGZmY+JGe75EnnkIgEHkIRzgeBEq1WTlgtmAMGH+aHgp5PVal8jXjg==
X-Gm-Gg: ATEYQzy/DsbRn20MWQJzxcTv+EUieVRe0T4wdDz9SUkYYMW+802KM3m2/yVsxxnvMhi
	wiNWWihgnpeNwlKXx3ZNcxUXoW2mtjcSL8sUjNVMunxi23P7FfbNUB/nUSyypc66PHXgsFTLfEf
	yJZlSBPljTfPTWtloo60vaPOuo5mHW1p4CVq+w/04awEUQU8oAnTxjqdWhyHtycmObkZlbWFjKT
	wflM295UeNDEbRSpbhP8+kXWhnV54KCV5UY8s5Icfg3RomRcRxyJYnG4Qrb+t+MxObZ1ijZ8dxe
	K3F2411qp4+uUdFJlcp2UHG1adspE/q02jQt4bvKP6bFTt7yXyVtODKiZEcoCn91gYnwdqu6vAz
	fE6D6y7MSNcpoZ5LEdhlJqwP9IVMV45YKWYD1A3OmGrXI+phrvGbBXy3i7DhfYPeC16GsW3gDsh
	vWcUgOu/zKa6K9Nrt7C1DgEw==
X-Received: by 2002:a17:903:2f8b:b0:2ae:3bb2:a8cb with SMTP id d9443c01a7336-2ae6ab1ff0bmr59226435ad.40.1772714254842;
        Thu, 05 Mar 2026 04:37:34 -0800 (PST)
Received: from [127.0.0.1] ([4.155.99.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b416bsm228480685ad.61.2026.03.05.04.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:37:34 -0800 (PST)
Message-Id: <pull.2045.v5.git.1772714253412.gitgitgadget@gmail.com>
In-Reply-To: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com>
References: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com>
From: "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 12:37:33 +0000
Subject: [PATCH v5] add: support pre-add hook
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Adrian Ratiu <adrian.ratiu@collabora.com>,
    Chandra Kethi-Reddy <chandrakr@pm.me>,
    Chandra Kethi-Reddy <chandrakr@pm.me>

From: Chandra Kethi-Reddy <chandrakr@pm.me>

"git add" has no hook that lets users inspect what is about to be
staged. Users who want to reject certain paths or content must
wrap the command in a shell alias or wait for pre-commit, which
fires too late to prevent staging.

Introduce a "pre-add" hook so that users can inspect or reject
proposed index updates at staging time.

  $1 -- index path used by this invocation (may not exist yet)
  $2 -- lockfile path containing proposed staged index state

Hook authors can inspect the result with ordinary Git commands:

  GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD

Both files should be treated as read-only. Exiting with non-zero
status rejects the update and leaves the index unchanged.

The hook accepts or rejects the entire proposed update. Per-path
filtering is not supported.

The hook is bypassed with "--no-verify" and is not invoked for
--interactive, --patch, --edit, or --dry-run, nor by "git commit -a"
which stages through its own code path.

Signed-off-by: Chandra Kethi-Reddy <chandrakr@pm.me>
---
    add: support pre-add hook
    
    
    Summary
    =======
    
     * v5 switches from find_hook() to hook_exists() for early hook
       detection so hooks configured via core.hooksPath are discovered
     * Add a tests exercises config-based hook discovery
     * Fixed Windows CI failures with correct path formatting in the
       relevant test
    
    
    Notes
    =====
    
     * This design intentionally trades ODB prevention for correctness of
       hook inputs: blobs may already be written to object storage when the
       hook runs, but hook rejection still leaves the on-disk index
       unchanged
     * AI Disclosure: Codex and Claude Code CLI were used to assist
       drafting. All tests, code, and docs were committed by hand.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2045%2Fshatachandra%2Fpre-add-hooks-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2045/shatachandra/pre-add-hooks-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2045

Range-diff vs v4:

 1:  9383395bb0 ! 1:  fc58c4cba2 add: support pre-add hook
     @@ builtin/add.c: int cmd_add(int argc,
       		string_list_clear(&only_match_skip_worktree, 0);
       	}
       
     -+	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
     ++	if (!show_only && !no_verify && hook_exists(repo, "pre-add")) {
      +		run_pre_add = 1;
      +		orig_index_path = absolute_pathdup(repo_get_index_file(repo));
      +	}
     @@ t/t3706-pre-add-hook.sh (new)
      +	git commit -m "initial"
      +'
      +
     ++test_expect_success 'hook found via core.hooksPath' '
     ++	test_when_finished "git reset --hard &&
     ++			    rm -rf custom-hooks &&
     ++			    git config --unset core.hooksPath" &&
     ++	mkdir custom-hooks &&
     ++	write_script custom-hooks/pre-add <<-\EOF &&
     ++	echo invoked >hook-ran
     ++	EOF
     ++	git config core.hooksPath custom-hooks &&
     ++	echo changed >>file &&
     ++	git add file &&
     ++	test_path_is_file hook-ran &&
     ++	rm -f hook-ran
     ++'
     ++
      +test_expect_success 'hook receives index-path and lockfile-path arguments' '
      +	test_when_finished "git reset --hard &&
      +			    rm -f staged expect-count arg-count arg-one arg-two \
     @@ t/t3706-pre-add-hook.sh (new)
      +	EOF
      +	echo changed >>file &&
      +	GIT_INDEX_FILE=alt-index git add file &&
     -+	echo "$PWD/alt-index" >expect-index &&
     ++	test-tool path-utils absolute_path alt-index >expect-index &&
      +	test_cmp expect-index arg-one &&
     -+	echo "$PWD/alt-index.lock" >expect-lockpath &&
     ++	test-tool path-utils absolute_path alt-index.lock >expect-lockpath &&
      +	test_cmp expect-lockpath arg-two
      +'
      +


 Documentation/git-add.adoc  |  10 +-
 Documentation/githooks.adoc |  30 ++++
 builtin/add.c               |  38 ++++-
 read-cache-ll.h             |   3 +
 read-cache.c                |   9 +-
 t/meson.build               |   1 +
 t/t3706-pre-add-hook.sh     | 304 ++++++++++++++++++++++++++++++++++++
 7 files changed, 388 insertions(+), 7 deletions(-)
 create mode 100755 t/t3706-pre-add-hook.sh

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 6192daeb03..a3ff4ced83 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
 	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
-	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	[--no-verify] [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	[--] [<pathspec>...]
 
 DESCRIPTION
@@ -42,10 +42,11 @@ use the `--force` option to add ignored files. If you specify the exact
 filename of an ignored file, `git add` will fail with a list of ignored
 files. Otherwise it will silently ignore the file.
 
+A `pre-add` hook can be used to reject `git add` (see linkgit:githooks[5]).
+
 Please see linkgit:git-commit[1] for alternative ways to add content to a
 commit.
 
-
 OPTIONS
 -------
 `<pathspec>...`::
@@ -163,6 +164,10 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
 
+`--no-verify`::
+	Bypass the `pre-add` hook if it exists. See linkgit:githooks[5] for
+	more information about hooks.
+
 `--ignore-errors`::
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
@@ -451,6 +456,7 @@ linkgit:git-reset[1]
 linkgit:git-mv[1]
 linkgit:git-commit[1]
 linkgit:git-update-index[1]
+linkgit:githooks[5]
 
 GIT
 ---
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 056553788d..90945a590e 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -94,6 +94,36 @@ and is invoked after the patch is applied and a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git am`.
 
+pre-add
+~~~~~~~
+
+This hook is invoked by linkgit:git-add[1], and can be bypassed with the
+`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
+`--edit`, or `--dry-run`.
+
+It takes two arguments: the path to the index file for this invocation
+of `git add`, and the path to the lockfile containing the proposed
+index after staging. If no index exists yet, the first argument names
+a path that does not exist and should be treated as an empty index.
+
+The hook is invoked after the index has been updated in memory and
+written to the lockfile, but before it is committed to the final index
+path. Exiting with a non-zero status causes `git add` to reject the
+proposed state, roll back the lockfile, and leave the index unchanged.
+Exiting with zero status allows the index update to be committed. The
+hook accepts or rejects the entire proposed update; per-path filtering
+is not supported. Both files should be treated as read-only by the hook.
+
+Hook authors may set `GIT_INDEX_FILE="$1"` to inspect the current index
+state and `GIT_INDEX_FILE="$2"` to inspect the proposed index state.
+
+This hook can be used to prevent staging of files based on names, content,
+or sizes (e.g., to block `.env` files, secret keys, or large files).
+
+This hook is not invoked by `git commit -a` or `git commit --include`
+which still can run the `pre-commit` hook, providing a control point at
+commit time.
+
 pre-commit
 ~~~~~~~~~~
 
diff --git a/builtin/add.c b/builtin/add.c
index 32709794b3..f35994ff0f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -25,6 +25,8 @@
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "hook.h"
+#include "abspath.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -36,6 +38,7 @@ static int take_worktree_changes;
 static int add_renormalize;
 static int pathspec_file_nul;
 static int include_sparse;
+static int no_verify;
 static const char *pathspec_from_file;
 
 static int chmod_pathspec(struct repository *repo,
@@ -271,6 +274,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	OPT_BOOL( 0 , "no-verify", &no_verify, N_("bypass pre-add hook")),
 	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
 		   N_("override the executable bit of the listed files")),
@@ -391,6 +395,8 @@ int cmd_add(int argc,
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
 	struct odb_transaction *transaction;
+	int run_pre_add = 0;
+	char *orig_index_path = NULL;
 
 	repo_config(repo, add_config, NULL);
 
@@ -576,6 +582,11 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
+	if (!show_only && !no_verify && hook_exists(repo, "pre-add")) {
+		run_pre_add = 1;
+		orig_index_path = absolute_pathdup(repo_get_index_file(repo));
+	}
+
 	transaction = odb_transaction_begin(repo->objects);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
@@ -598,9 +609,30 @@ int cmd_add(int argc,
 	odb_transaction_commit(transaction);
 
 finish:
-	if (write_locked_index(repo->index, &lock_file,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die(_("unable to write new index file"));
+	if (run_pre_add && repo->index->cache_changed) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
+		if (write_locked_index(repo->index, &lock_file,
+				SKIP_INDEX_CHANGE_HOOK))
+			die(_("unable to write proposed index"));
+
+		strvec_push(&opt.args, orig_index_path);
+		strvec_push(&opt.args, get_lock_file_path(&lock_file));
+		if (run_hooks_opt(repo, "pre-add", &opt)) {
+			rollback_lock_file(&lock_file); /* hook rejected */
+			exit_status = 1;
+		} else if (commit_lock_file(&lock_file)) {
+			die(_("unable to write new index file"));
+		} else {
+			emit_post_index_change(repo->index);
+		}
+	} else {
+		if (write_locked_index(repo->index, &lock_file,
+				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+			die(_("unable to write new index file"));
+	}
+
+	free(orig_index_path);
 
 	free(ps_matched);
 	dir_clear(&dir);
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 71b49d9af4..eed1d74d99 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -284,6 +284,9 @@ int is_index_unborn(struct index_state *);
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
 #define SKIP_IF_UNCHANGED	(1 << 1)
+#define SKIP_INDEX_CHANGE_HOOK	(1 << 2)
+
+void emit_post_index_change(struct index_state *istate);
 
 /*
  * Write the index while holding an already-taken lock. Close the lock,
diff --git a/read-cache.c b/read-cache.c
index 0c07c3aef7..dfe8d8e4d7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3161,13 +3161,18 @@ static int do_write_locked_index(struct index_state *istate,
 	else
 		ret = close_lock_file_gently(lock);
 
+	if (!(flags & SKIP_INDEX_CHANGE_HOOK))
+		emit_post_index_change(istate);
+	return ret;
+}
+
+void emit_post_index_change(struct index_state *istate)
+{
 	run_hooks_l(the_repository, "post-index-change",
 		    istate->updated_workdir ? "1" : "0",
 		    istate->updated_skipworktree ? "1" : "0", NULL);
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
-
-	return ret;
 }
 
 static int write_split_index(struct index_state *istate,
diff --git a/t/meson.build b/t/meson.build
index f80e366cff..2419a9adbb 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -415,6 +415,7 @@ integration_tests = [
   't3703-add-magic-pathspec.sh',
   't3704-add-pathspec-file.sh',
   't3705-add-sparse-checkout.sh',
+  't3706-pre-add-hook.sh',
   't3800-mktag.sh',
   't3900-i18n-commit.sh',
   't3901-i18n-patch.sh',
diff --git a/t/t3706-pre-add-hook.sh b/t/t3706-pre-add-hook.sh
new file mode 100755
index 0000000000..352b79e5d6
--- /dev/null
+++ b/t/t3706-pre-add-hook.sh
@@ -0,0 +1,304 @@
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
+test_expect_success 'setup for path-based tests' '
+	git add file &&
+	git commit -m "initial"
+'
+
+test_expect_success 'hook found via core.hooksPath' '
+	test_when_finished "git reset --hard &&
+			    rm -rf custom-hooks &&
+			    git config --unset core.hooksPath" &&
+	mkdir custom-hooks &&
+	write_script custom-hooks/pre-add <<-\EOF &&
+	echo invoked >hook-ran
+	EOF
+	git config core.hooksPath custom-hooks &&
+	echo changed >>file &&
+	git add file &&
+	test_path_is_file hook-ran &&
+	rm -f hook-ran
+'
+
+test_expect_success 'hook receives index-path and lockfile-path arguments' '
+	test_when_finished "git reset --hard &&
+			    rm -f staged expect-count arg-count arg-one arg-two \
+			    expect-index expect-lockpath" &&
+	echo staged >staged &&
+	cat >expect-count <<-\EOF &&
+	2
+	EOF
+	test_hook pre-add <<-\EOF &&
+	echo "$#" >arg-count &&
+	echo "$1" >arg-one &&
+	echo "$2" >arg-two &&
+	test "$1" != "$2" &&
+	test -r "$2"
+	EOF
+	git add staged &&
+	test_cmp expect-count arg-count &&
+	printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-index &&
+	test_cmp expect-index arg-one &&
+	sed "s/$/.lock/" expect-index >expect-lockpath &&
+	test_cmp expect-lockpath arg-two
+'
+
+test_expect_success 'hook rejection leaves final index unchanged' '
+	test_when_finished "git reset --hard && rm -f reject index.before" &&
+	cp .git/index index.before &&
+	test_hook pre-add <<-\EOF &&
+	exit 1
+	EOF
+	echo reject >reject &&
+	test_must_fail git add reject &&
+	test_cmp_bin index.before .git/index &&
+	test_path_is_missing .git/index.lock
+'
+
+test_expect_success 'missing pre-existing index path treated as empty' '
+	test_when_finished "git reset --hard &&
+			    rm -f newfile arg-one after.raw after expect-index" &&
+	rm -f .git/index &&
+	test_hook pre-add <<-\EOF &&
+	echo "$1" >arg-one &&
+	test ! -e "$1" &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >after.raw &&
+	sort after.raw >after
+	EOF
+	echo newfile >newfile &&
+	git add newfile &&
+	printf "%s/index\n" "$(git rev-parse --absolute-git-dir)" >expect-index &&
+	test_cmp expect-index arg-one &&
+	grep "^newfile$" after &&
+	grep "^file$" after
+'
+
+test_expect_success 'hook respects GIT_INDEX_FILE' '
+	test_when_finished "git reset --hard &&
+			    rm -f arg-one arg-two expect-index expect-lockpath \
+			    alt-index alt-index.lock" &&
+	test_hook pre-add <<-\EOF &&
+	echo "$1" >arg-one &&
+	echo "$2" >arg-two
+	EOF
+	echo changed >>file &&
+	GIT_INDEX_FILE=alt-index git add file &&
+	test-tool path-utils absolute_path alt-index >expect-index &&
+	test_cmp expect-index arg-one &&
+	test-tool path-utils absolute_path alt-index.lock >expect-lockpath &&
+	test_cmp expect-lockpath arg-two
+'
+
+test_expect_success 'setup for mixed-result tests' '
+	echo "*.ignored" >.gitignore &&
+	git add .gitignore &&
+	git commit -m "add gitignore"
+'
+
+test_expect_success 'mixed-result add invokes pre-add hook' '
+	test_when_finished "git reset --hard &&
+			    rm -f bad.ignored index.before hook-ran proposed" &&
+	echo changed >>file &&
+	echo ignored >bad.ignored &&
+	cp .git/index index.before &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >proposed &&
+	grep "^file$" proposed &&
+	echo invoked >hook-ran &&
+	exit 1
+	EOF
+	test_must_fail git add file bad.ignored &&
+	test_path_is_file hook-ran &&
+	test_cmp_bin index.before .git/index &&
+	test_path_is_missing .git/index.lock
+'
+
+test_expect_success 'mixed-result add stages tracked update on approve' '
+	test_when_finished "git reset --hard &&
+			    rm -f bad.ignored hook-ran staged proposed" &&
+	echo changed >>file &&
+	echo ignored >bad.ignored &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >proposed &&
+	grep "^file$" proposed &&
+	echo invoked >hook-ran
+	EOF
+	test_must_fail git add file bad.ignored &&
+	test_path_is_file hook-ran &&
+	git diff --cached --name-only HEAD >staged &&
+	grep "^file$" staged &&
+	test_path_is_missing .git/index.lock
+'
+
+test_expect_success 'post-index-change fires after pre-add approval' '
+	test_when_finished "git reset --hard &&
+			    rm -f hook-order expect lockfile-present" &&
+	test_hook pre-add <<-\EOF &&
+	echo pre >>hook-order
+	EOF
+	test_hook post-index-change <<-\EOF &&
+	if test -f ".git/index.lock"
+	then
+		echo locked >lockfile-present
+	fi
+	echo post >>hook-order
+	EOF
+	echo updated >>file &&
+	git add file &&
+	cat >expect <<-\EOF &&
+	pre
+	post
+	EOF
+	test_cmp expect hook-order &&
+	test_path_is_missing lockfile-present
+'
+
+test_expect_success 'post-index-change is suppressed on pre-add rejection' '
+	test_when_finished "git reset --hard &&
+			    rm -f index.before hook-order expect" &&
+	cp .git/index index.before &&
+	test_hook pre-add <<-\EOF &&
+	echo pre >>hook-order &&
+	exit 1
+	EOF
+	test_hook post-index-change <<-\EOF &&
+	echo post >>hook-order
+	EOF
+	echo reject >>file &&
+	test_must_fail git add file &&
+	echo pre >expect &&
+	test_cmp expect hook-order &&
+	test_cmp_bin index.before .git/index &&
+	test_path_is_missing .git/index.lock
+'
+
+test_expect_success '--dry-run does not invoke hook' '
+	test_when_finished "rm -f hook-ran dry" &&
+	test_hook pre-add <<-\EOF &&
+	echo invoked >hook-ran
+	EOF
+	echo dry >dry &&
+	git add --dry-run dry &&
+	test_path_is_missing hook-ran
+'
+
+test_expect_success 'hook runs for git add -u' '
+	test_when_finished "git reset --hard && rm -f hook-ran" &&
+	test_hook pre-add <<-\EOF &&
+	echo invoked >hook-ran
+	EOF
+	echo changed >>file &&
+	git add -u &&
+	test_path_is_file hook-ran
+'
+
+test_expect_success 'hook example: block .env files' '
+	test_when_finished "git reset --hard &&
+			    rm -f .env safe.txt new-paths" &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached --name-only HEAD >new-paths &&
+	while read path
+	do
+		case "$path" in
+		*.env)
+			echo "error: $path must not be staged" >&2
+			exit 1
+			;;
+		esac
+	done <new-paths
+	EOF
+	echo "DB_PASS=secret" >.env &&
+	test_must_fail git add .env &&
+	echo "safe content" >safe.txt &&
+	git add safe.txt
+'
+
+test_expect_success 'hook example: block secrets in content' '
+	test_when_finished "git reset --hard && rm -f config.txt secret" &&
+	test_hook pre-add <<-\EOF &&
+	GIT_INDEX_FILE="$2" git diff --cached HEAD >secret &&
+	if grep -q "API_KEY=" secret ||
+	   grep -q "SECRET_KEY=" secret ||
+	   grep -q "PRIVATE_KEY=" secret
+	then
+		echo "error: staged content contains secrets" >&2
+		exit 1
+	fi
+	EOF
+	echo "API_KEY=sksksk-live-12345" >config.txt &&
+	test_must_fail git add config.txt &&
+	echo "LOG_LEVEL=debug" >config.txt &&
+	git add config.txt
+'
+
+test_done

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
