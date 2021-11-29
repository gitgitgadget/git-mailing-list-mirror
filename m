Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD3CC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhK2XNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E149DC043CC2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c4so40046074wrd.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Bk4GOjxgMvBSHn0D9lmAsXRFCpFAmS9hU2Ro9ah3t/o=;
        b=n6Ha4jNvFjkAv+U5Im/mRuYsGQHJNhA8n31iobLAbW0n8S4F6dgPTWKrSek4PZZtLm
         QJLl1CIl5jvYhg3mmoTvzt6jVqLdNiBwZUShrPpCkqMD9xn2ZKMMZxlWE+dFFMekQmwA
         in0rjvS4uDsf4lt6QHYo4japQIx0MbeCXxNN2EISH2/Bej+iOTB2UC+M/2giU28mfJfZ
         CfI2F0klkyJ0VLrbpEvdwZ3nuiXpZuikOVOt+WzfBK4ZpBjhkHvtgxqUlgRWTxUUz8ZQ
         igJqjYMyh53+Dzrs9xhqAcoCvumST9H0SlTgmApfzt89iYyBboaStP2xeHcLw76CwRbD
         QT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Bk4GOjxgMvBSHn0D9lmAsXRFCpFAmS9hU2Ro9ah3t/o=;
        b=oxj/0UkxbhCe9Fc6Jvlr9tt532YOl9LPOSBRKhVQ81pMcD1j9cwcisslDAEsNKIn/J
         wFc/3QdAxn/xstIfoCj8jBxfCtVsu56gLKCAkrvuu783kk4J/cojccDMvTsh5Rmbnfcy
         +FIZ+ai1UJB2fZvOSYB7LfaXjKOG5Qv4h2YzXKLi1I0BisUzaewctAjl4iCnJKDqxZWp
         Z0BAWh6ID7pjoBwVvtw8m9ouPgfrdS7i0s/FhWbvoU0CqraCQNkJBxYaYpE3SwcQcDfW
         VQi+5JrdG5L91nnqIaH/vq4pIDTIJxi359RcqvKEw+RF8iWroxz+gMWiqB0a5YQtwHwG
         43pg==
X-Gm-Message-State: AOAM532wNScLut6m0sghKb6tKBJroMWURyfeThjG9ZORdBR5yn6U9uO7
        qexfenPqRUzstNqlNLqMe+ulhc+5urI=
X-Google-Smtp-Source: ABdhPJywo4HkMelpPJ6v8p9G74E+CABCBW14EDUM+6JgnbJtEBgLdz/4QdwWmOSi6yQFPXLSX9BsXw==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr35560108wrx.329.1638225436242;
        Mon, 29 Nov 2021 14:37:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y142sm569233wmc.40.2021.11.29.14.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:15 -0800 (PST)
Message-Id: <a45b3f088025795d11a78055f90b8632d435d74f.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:04 +0000
Subject: [PATCH v4 01/11] t2501: add various tests for removing the current
 working directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Numerous commands will remove directories left empty as a "convenience"
after removing files within them.  That is normally fine, but removing
the current working directory can be rather inconvenient since it can
cause confusion for the user when they run subsequent commands.  For
example, after one git process has removed the current working
directory, git status/log/diff will all abort with the message:

    fatal: Unable to read current working directory: No such file or directory

We also have code paths that, when a file needs to be placed where a
directory is (due to e.g. checkout, merge, reset, whatever), will check
if this is okay and error out if not.  These rules include:
  * all tracked files under that directory are intended to be removed by
    the operation
  * none of the tracked files under that directory have uncommitted
    modification
  * there are no untracked files under that directory
However, if we end up remove the current working directory, we can cause
user confusion when they run subsequent commands, so we would prefer if
there was a fourth rule added to this list: avoid removing the current
working directory.

Since there are several code paths that can result in the current
working directory being removed, add several tests of various different
codepaths.  To make it clearer what the difference between the current
behavior and the behavior at the end of the series, code both of them
into the tests and have the appropriate behavior be selected by a flag.
Subsequent commits will toggle the flag from current to desired
behavior.

Also add a few tests suggested during the review of earlier rounds of
this patch series.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 342 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 342 insertions(+)
 create mode 100755 t/t2501-cwd-empty.sh

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
new file mode 100755
index 00000000000..fd83fe921d5
--- /dev/null
+++ b/t/t2501-cwd-empty.sh
@@ -0,0 +1,342 @@
+#!/bin/sh
+
+test_description='Test handling of the current working directory becoming empty'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit init &&
+
+	git branch fd_conflict &&
+
+	mkdir -p foo/bar &&
+	test_commit foo/bar/baz &&
+
+	git revert HEAD &&
+	git tag reverted &&
+
+	git checkout fd_conflict &&
+	mkdir dirORfile &&
+	test_commit dirORfile/foo &&
+
+	git rm -r dirORfile &&
+	echo not-a-directory >dirORfile &&
+	git add dirORfile &&
+	git commit -m dirORfile &&
+
+	git switch -c df_conflict HEAD~1 &&
+	test_commit random_file &&
+
+	git switch -c undo_fd_conflict fd_conflict &&
+	git revert HEAD
+'
+
+test_incidental_dir_removal () {
+	works=$1 &&
+	shift &&
+
+	test_when_finished "git reset --hard" &&
+
+	git checkout foo/bar/baz^{commit} &&
+	test_path_is_dir foo/bar &&
+
+	(
+		cd foo &&
+		"$@" &&
+
+		# Although we want pwd & git status to pass, test for existing
+		# rather than desired behavior.
+		if test "$works" == "success"
+		then
+			test-tool getcwd &&
+			git status --porcelain
+		else
+			! test-tool getcwd &&
+			test_might_fail git status --porcelain
+		fi
+	) &&
+	test_path_is_missing foo/bar/baz &&
+	test_path_is_missing foo/bar &&
+
+	# Although we want dir to be present, test for existing rather
+	# than desired behavior.
+	if test "$works" == "success"
+	then
+		test_path_is_dir foo
+	else
+		test_path_is_missing foo
+	fi
+}
+
+test_required_dir_removal () {
+	works=$1 &&
+	shift &&
+
+	git checkout df_conflict^{commit} &&
+	test_when_finished "git clean -fdx" &&
+
+	(
+		cd dirORfile &&
+
+		# We'd like for the command to fail (much as it would if there
+		# was an untracked file there), and for the index and worktree
+		# to be left clean with pwd and git status working afterwards.
+		# But test for existing rather than desired behavior.
+		if test "$works" == "success"
+		then
+			test_must_fail "$@" 2>../error &&
+			grep "Refusing to remove.*current working directory" ../error &&
+
+			git diff --exit-code HEAD &&
+
+			test-tool getcwd &&
+			git status --porcelain
+		else
+			"$@" &&
+			! test-tool getcwd &&
+			test_might_fail git status --porcelain
+		fi
+	) &&
+
+	# Although we want dirORfile to be present, test for existing rather
+	# than desired behavior.
+	if test "$works" == "success"
+	then
+		test_path_is_dir dirORfile
+	else
+		test_path_is_file dirORfile
+	fi
+}
+
+test_expect_success 'checkout does not clean cwd incidentally' '
+	test_incidental_dir_removal failure git checkout init
+'
+
+test_expect_success 'checkout fails if cwd needs to be removed' '
+	test_required_dir_removal failure git checkout fd_conflict
+'
+
+test_expect_success 'reset --hard does not clean cwd incidentally' '
+	test_incidental_dir_removal failure git reset --hard init
+'
+
+test_expect_success 'reset --hard fails if cwd needs to be removed' '
+	test_required_dir_removal failure git reset --hard fd_conflict
+'
+
+test_expect_success 'merge does not clean cwd incidentally' '
+	test_incidental_dir_removal failure git merge reverted
+'
+
+# This file uses some simple merges where
+#   Base: 'dirORfile/' exists
+#   Side1: random other file changed
+#   Side2: 'dirORfile/' removed, 'dirORfile' added
+# this should resolve cleanly, but merge-recursive throws merge conflicts
+# because it's dumb.  Add a special test for checking merge-recursive (and
+# merge-ort), then after this just hard require ort for all remaining tests.
+#
+test_expect_success 'merge fails if cwd needs to be removed; recursive friendly' '
+	git checkout foo/bar/baz &&
+	test_when_finished "git clean -fdx" &&
+
+	mkdir dirORfile &&
+	(
+		cd dirORfile &&
+
+		# We would rather this failed, but we test for existing
+		# rather than desired behavior
+		git merge fd_conflict 2>../error
+	) &&
+
+	## Here is the behavior we would rather have:
+	#test_path_is_dir dirORfile &&
+	#grep "Refusing to remove the current working directory" error
+	## But instead we test for existing behavior
+	test_path_is_file dirORfile &&
+	test_must_be_empty error
+'
+
+GIT_TEST_MERGE_ALGORITHM=ort
+
+test_expect_success 'merge fails if cwd needs to be removed' '
+	test_required_dir_removal failure git merge fd_conflict
+'
+
+test_expect_success 'cherry-pick does not clean cwd incidentally' '
+	test_incidental_dir_removal failure git cherry-pick reverted
+'
+
+test_expect_success 'cherry-pick fails if cwd needs to be removed' '
+	test_required_dir_removal failure git cherry-pick fd_conflict
+'
+
+test_expect_success 'rebase does not clean cwd incidentally' '
+	test_incidental_dir_removal failure git rebase reverted
+'
+
+test_expect_success 'rebase fails if cwd needs to be removed' '
+	test_required_dir_removal failure git rebase fd_conflict
+'
+
+test_expect_success 'revert does not clean cwd incidentally' '
+	test_incidental_dir_removal failure git revert HEAD
+'
+
+test_expect_success 'revert fails if cwd needs to be removed' '
+	test_required_dir_removal failure git revert undo_fd_conflict
+'
+
+test_expect_success 'rm does not clean cwd incidentally' '
+	test_incidental_dir_removal failure git rm bar/baz.t
+'
+
+test_expect_success 'apply does not remove cwd incidentally' '
+	git diff HEAD HEAD~1 >patch &&
+	test_incidental_dir_removal failure git apply ../patch
+'
+
+test_incidental_untracked_dir_removal () {
+	works=$1 &&
+	shift &&
+
+	test_when_finished "git reset --hard" &&
+
+	git checkout foo/bar/baz^{commit} &&
+	mkdir -p untracked &&
+	mkdir empty
+	>untracked/random &&
+
+	(
+		cd untracked &&
+		"$@" &&
+
+		# Although we want pwd & git status to pass, test for existing
+		# rather than desired behavior.
+		if test "$works" == "success"
+		then
+			test-tool getcwd &&
+			git status --porcelain
+		else
+			! test-tool getcwd &&
+			test_might_fail git status --porcelain
+		fi
+	) &&
+	test_path_is_missing empty &&
+	test_path_is_missing untracked/random &&
+
+	# Although we want dir to be present, test for existing rather
+	# than desired behavior.
+	if test "$works" == "success"
+	then
+		test_path_is_dir untracked
+	else
+		test_path_is_missing untracked
+	fi
+}
+
+test_expect_success 'clean does not remove cwd incidentally' '
+	test_incidental_untracked_dir_removal failure \
+		git -C .. clean -fd -e warnings . >warnings
+'
+
+test_expect_success 'stash does not remove cwd incidentally' '
+	test_incidental_untracked_dir_removal failure \
+		git stash --include-untracked
+'
+
+test_expect_success '`rm -rf dir` only removes a subset of dir' '
+	test_when_finished "rm -rf a/" &&
+
+	mkdir -p a/b/c &&
+	>a/b/c/untracked &&
+	>a/b/c/tracked &&
+	git add a/b/c/tracked &&
+
+	(
+		cd a/b &&
+		git rm -rf ../b
+	) &&
+
+	test_path_is_dir a/b &&
+	test_path_is_missing a/b/c/tracked &&
+	test_path_is_file a/b/c/untracked
+'
+
+test_expect_success '`rm -rf dir` even with only tracked files will remove something else' '
+	test_when_finished "rm -rf a/" &&
+
+	mkdir -p a/b/c &&
+	>a/b/c/tracked &&
+	git add a/b/c/tracked &&
+
+	(
+		cd a/b &&
+		git rm -rf ../b
+	) &&
+
+	test_path_is_missing a/b/c/tracked &&
+	## We would prefer if a/b was still present, though empty, since it
+	## was the current working directory
+	#test_path_is_dir a/b
+	## But the current behavior is that it not only deletes the directory
+	## a/b as requested, but also goes and deletes a
+	test_path_is_missing a
+'
+
+test_expect_success 'git version continues working from a deleted dir' '
+	mkdir tmp &&
+	(
+		cd tmp &&
+		rm -rf ../tmp &&
+		git version
+	)
+'
+
+test_submodule_removal () {
+	path_status=$1 &&
+	shift &&
+
+	test_status=
+	test "$path_status" = dir && test_status=test_must_fail
+
+	# Actually, while path_status == dir && test_status=test_must_fail
+	# reflect our desired behavior, current behavior is:
+	path_status=missing
+	test_status=
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf .git/modules/my_submodule" &&
+
+	git checkout foo/bar/baz &&
+
+	git init my_submodule &&
+	touch my_submodule/file &&
+	git -C my_submodule add file &&
+	git -C my_submodule commit -m "initial commit" &&
+	git submodule add ./my_submodule &&
+	git commit -m "Add the submodule" &&
+
+	(
+		cd my_submodule &&
+		$test_status "$@"
+	) &&
+
+	test_path_is_${path_status} my_submodule
+}
+
+test_expect_success 'rm -r with -C leaves submodule if cwd inside' '
+	test_submodule_removal dir git -C .. rm -r my_submodule/
+'
+
+test_expect_success 'rm -r leaves submodule if cwd inside' '
+	test_submodule_removal dir \
+		git --git-dir=../.git --work-tree=.. rm -r ../my_submodule/
+'
+
+test_expect_success 'rm -rf removes submodule even if cwd inside' '
+	test_submodule_removal missing \
+		git --git-dir=../.git --work-tree=.. rm -rf ../my_submodule/
+'
+
+test_done
-- 
gitgitgadget

