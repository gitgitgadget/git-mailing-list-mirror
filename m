Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35CC1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbeGBAYu (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:24:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55973 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbeGBAYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:49 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so9850661itl.5
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=3c7qkdS5wIaafbe8JZVGVZL0nXjaMbZFQJrOVihIQYM=;
        b=u+9jwKIXSYqjY4UZy6CCIkiWob7bIR5NIRqqm5NwinlZwx+WZqK+hACphqCNaipdRJ
         uXjJC3ALSjBuozbd5wDb0MHJPRlD8TP5YLfvR75X9bzSgFPP/5fcpczoHPNPf5NTT+nB
         ZMd8c5UKanwN3/8dUpOKVv+qI4+Z3HeWf1mEw2+I8lt5liNkfnVtbmRE1Dp5rCWCZ2eB
         adcRCiaBuH/H3WMRoDF0G/Y0VMketMCWL/g1r7gZEKHuAezFIXoG2Gk302x0roZ/yLUO
         vn37tt5rZO5DEp1UXbGURSmUMsC3eVSH0gghSgG9/XGHqRea7F8HE48pAuDgc1MqWw4P
         oKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=3c7qkdS5wIaafbe8JZVGVZL0nXjaMbZFQJrOVihIQYM=;
        b=Grz73j0pY1vZPwSkqkY61dyIylAGadCSikwLgcM0th98pvlhuYIKtUikl5t9qf4w3a
         P/E7a7aXjk8mH9HHaBQzYlQ2Dx2s4OkOnMgtBY2mGvqBULO/YJH+kOFKmCKsf7HqNXyp
         vZ/wwC5eXcIWDnWtQ1l+2RN3XPm9JU8DTcDR+ZK5F5wAjxsuzcZ6zEkFmBJ5xzT9sWhx
         qMbS21WPiWjTM3digdYF62CbWTLlZFVfXssJVZL/Tsu63ZWPooPA2ZCs6BG/QSHfKfdA
         K4+69dzG6+9WaesoHM+XPw66fbr25WPZAkUFNsZES7wOxkGYHi9e3cF134gZMw89HPWK
         yBYw==
X-Gm-Message-State: APt69E2YJHj3hOr7Erv23MjrWpeSby/QYfP9X89AOsj8fP75814ZXPR3
        aB31LUxFfCCmCmHrnrbbAEO1Tw==
X-Google-Smtp-Source: AAOMgpfhNGcbn057/ttf2ze+1yBXdwD5nwYpuoM8c802BJ09lCE5t1Rsa7deiSLKiUuBf2ddz1d6CQ==
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr7971358itk.62.1530491088168;
        Sun, 01 Jul 2018 17:24:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:47 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/25] fix buggy tests, modernize tests, fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:23:40 -0400
Message-Id: <20180702002405.3042-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes several buggy tests which went undetected due to
broken &&-chains in subshells, modernizes some tests to take advantage
of test functions (test_might_fail(), test_write_lines(), etc.), and
fixes a lot of broken &&-chains in subshells. It applies atop
'master'. Happily, there are no broken &&-chains in subshells in any
in-flight topic.

It is split out from an earlier series[1] which additionally extended
--chain-lint to work within subshells. I decided to make this an
independent series because these (hopefully) non-controversial changes
all stand on their own merit, and because I don't want to flood the list
repeatedly with this lengthy series as I re-roll the "extend
--chain-lint to work in subshells" functionality from [1].

To ease review burden, I largely avoided noisy modernizations and
cleanups, and limited changes to merely adding "&&" even when some other
transformation would have made the fix nicer overall. (For example, I
resisted the urge to replace a series of 'echo' statements with a simple
here-doc.)

Changes since [1]:

* Found and fixed more &&-chain breakage, and converted a couple more
  'unset' instances (which were hidden behind a MINGW prerequisite) to
  sane_unset().

* Rewrote commit messages to sell changes on their own merit rather than
  leaning on --chain-lint as a crutch. (junio, jrnieder)

* Changed a modernization/cleanup to use "! non-git-command" rather than
  test_must_fail(), moving it to its own patch in the process. (j6t)

* Changed "printf '%s\n'" idiom to test_write_lines(). (junio)

* Incorporated Stefan's fix[2] for a broken 't/lib-submodule-update'
  test since my interpretation of the problem was incorrect.

* Converted a subshell 'echo' sequence to write_script().

* Dropped patches which existed primarily to pacify --chain-lint; they
  are no longer needed since I re-wrote the "linter" to detect &&-chain
  breakage itself (by pure textual inspection) rather than by
  incorporating subshell bodies into the main &&-chain:

  t0001: use "{...}" block around "||" expression rather than subshell
  t3303: use standard here-doc tag "EOF" to avoid fooling --chain-lint
  t9104: use "{...}" block around "||" expression rather than subshell
  t9401: drop unnecessary nested subshell

* Dropped a patch which pretty much duplicated Junio's 037714252f
  (tests: clean after SANITY tests, 2018-06-15), which graduated to
  'master':

  t7508: use test_when_finished() instead of managing exit code manually

An interdiff against [1] is below, although I stripped out all the noisy
"printf '%s\n'" to test_write_lines() differences, of which there were a
lot, since they drowned out the other more significant changes.

Thanks to Elijah, Hannes, Jonathan Nieder, Jonathan Tan, Junio, Luke,
Peff, and Stefan for comments on [1].

[1]: https://public-inbox.org/git/20180626073001.6555-1-sunshine@sunshineco.com/
[2]: https://public-inbox.org/git/20180627183057.254467-1-sbeller@google.com/

Eric Sunshine (25):
  t: use test_might_fail() instead of manipulating exit code manually
  t: use test_write_lines() instead of series of 'echo' commands
  t: use sane_unset() rather than 'unset' with broken &&-chain
  t: drop unnecessary terminating semicolon in subshell
  t/lib-submodule-update: fix "absorbing" test
  t5405: use test_must_fail() instead of checking exit code manually
  t5406: use write_script() instead of birthing shell script manually
  t5505: modernize and simplify hard-to-digest test
  t6036: fix broken "merge fails but has appropriate contents" tests
  t7201: drop pointless "exit 0" at end of subshell
  t7400: fix broken "submodule add/reconfigure --force" test
  t7810: use test_expect_code() instead of hand-rolled comparison
  t9001: fix broken "invoke hook" test
  t9814: simplify convoluted check that command correctly errors out
  t0000-t0999: fix broken &&-chains
  t1000-t1999: fix broken &&-chains
  t2000-t2999: fix broken &&-chains
  t3000-t3999: fix broken &&-chains
  t3030: fix broken &&-chains
  t4000-t4999: fix broken &&-chains
  t5000-t5999: fix broken &&-chains
  t6000-t6999: fix broken &&-chains
  t7000-t7999: fix broken &&-chains
  t9000-t9999: fix broken &&-chains
  t9119: fix broken &&-chains

 t/lib-submodule-update.sh                     |   5 +-
 t/t0000-basic.sh                              |   2 +-
 t/t0001-init.sh                               |   4 +-
 t/t0003-attributes.sh                         |  24 +-
 t/t0021-conversion.sh                         |   4 +-
 t/t0090-cache-tree.sh                         |   2 +-
 t/t1004-read-tree-m-u-wf.sh                   |   8 +-
 t/t1005-read-tree-reset.sh                    |  10 +-
 t/t1008-read-tree-overlay.sh                  |   2 +-
 t/t1020-subdirectory.sh                       |   2 +-
 t/t1050-large.sh                              |   6 +-
 t/t1300-config.sh                             |   2 +-
 t/t1411-reflog-show.sh                        |   6 +-
 t/t1507-rev-parse-upstream.sh                 |   6 +-
 t/t1512-rev-parse-disambiguation.sh           |   6 +-
 t/t1700-split-index.sh                        |   2 +-
 t/t2016-checkout-patch.sh                     |  24 +-
 t/t2103-update-index-ignore-missing.sh        |   2 +-
 t/t2202-add-addremove.sh                      |  14 +-
 t/t3000-ls-files-others.sh                    |   2 +-
 t/t3006-ls-files-long.sh                      |   2 +-
 t/t3008-ls-files-lazy-init-name-hash.sh       |   8 +-
 t/t3030-merge-recursive.sh                    | 340 +++++++++---------
 t/t3050-subprojects-fetch.sh                  |   8 +-
 t/t3102-ls-tree-wildcards.sh                  |   2 +-
 t/t3210-pack-refs.sh                          |   4 +-
 t/t3301-notes.sh                              |   8 +-
 t/t3400-rebase.sh                             |   8 +-
 t/t3402-rebase-merge.sh                       |   4 +-
 t/t3404-rebase-interactive.sh                 |   6 +-
 t/t3418-rebase-continue.sh                    |   4 +-
 t/t3700-add.sh                                |   8 +-
 t/t3701-add-interactive.sh                    |  16 +-
 t/t3904-stash-patch.sh                        |   8 +-
 t/t4001-diff-rename.sh                        |   2 +-
 t/t4010-diff-pathspec.sh                      |   4 +-
 t/t4012-diff-binary.sh                        |   6 +-
 t/t4024-diff-optimize-common.sh               |  16 +-
 t/t4025-hunk-header.sh                        |   8 +-
 t/t4041-diff-submodule-option.sh              |   4 +-
 t/t4060-diff-submodule-option-diff-format.sh  |   2 +-
 t/t4121-apply-diffs.sh                        |   2 +-
 t/t5300-pack-object.sh                        |   2 +-
 t/t5302-pack-index.sh                         |   2 +-
 t/t5400-send-pack.sh                          |   4 +-
 t/t5401-update-hooks.sh                       |   4 +-
 t/t5405-send-pack-rewind.sh                   |   3 +-
 t/t5406-remote-rejects.sh                     |   5 +-
 t/t5500-fetch-pack.sh                         |   2 +-
 t/t5505-remote.sh                             |  10 +-
 t/t5512-ls-remote.sh                          |   4 +-
 t/t5516-fetch-push.sh                         |  10 +-
 t/t5517-push-mirror.sh                        |  10 +-
 t/t5526-fetch-submodules.sh                   |   2 +-
 t/t5531-deep-submodule-push.sh                |   2 +-
 t/t5543-atomic-push.sh                        |   2 +-
 t/t5601-clone.sh                              |   2 +-
 t/t5605-clone-local.sh                        |   2 +-
 t/t5801-remote-helpers.sh                     |   2 +-
 t/t6010-merge-base.sh                         |   2 +-
 t/t6029-merge-subtree.sh                      |  16 +-
 t/t6036-recursive-corner-cases.sh             |  14 +-
 t/t6042-merge-rename-corner-cases.sh          |   8 +-
 t/t6043-merge-rename-directories.sh           |   2 +-
 t/t7001-mv.sh                                 |   2 +-
 t/t7105-reset-patch.sh                        |  12 +-
 t/t7201-co.sh                                 |  41 ++-
 t/t7301-clean-interactive.sh                  |  41 ++-
 t/t7400-submodule-basic.sh                    |  12 +-
 t/t7406-submodule-update.sh                   |   6 +-
 t/t7408-submodule-reference.sh                |   2 +-
 t/t7501-commit.sh                             |  56 +--
 t/t7506-status-submodule.sh                   |  10 +-
 t/t7610-mergetool.sh                          |   8 +-
 t/t7810-grep.sh                               |   7 +-
 t/t9001-send-email.sh                         |  10 +-
 t/t9100-git-svn-basic.sh                      |   2 +-
 t/t9101-git-svn-props.sh                      |   2 +-
 t/t9119-git-svn-info.sh                       | 120 +++----
 t/t9122-git-svn-author.sh                     |   6 +-
 t/t9129-git-svn-i18n-commitencoding.sh        |   2 +-
 t/t9130-git-svn-authors-file.sh               |   4 +-
 t/t9134-git-svn-ignore-paths.sh               |   6 +-
 t/t9137-git-svn-dcommit-clobber-series.sh     |   2 +-
 t/t9138-git-svn-authors-prog.sh               |   6 +-
 t/t9146-git-svn-empty-dirs.sh                 |  20 +-
 t/t9147-git-svn-include-paths.sh              |   6 +-
 t/t9152-svn-empty-dirs-after-gc.sh            |   2 +-
 t/t9164-git-svn-dcommit-concurrent.sh         |   2 +-
 ...65-git-svn-fetch-merge-branch-of-branch.sh |   2 +-
 t/t9200-git-cvsexportcommit.sh                |   6 +-
 t/t9302-fast-import-unpack-limit.sh           |   2 +-
 t/t9400-git-cvsserver-server.sh               |   8 +-
 t/t9600-cvsimport.sh                          |   2 +-
 t/t9806-git-p4-options.sh                     |   2 +-
 t/t9810-git-p4-rcs.sh                         |   2 +-
 t/t9811-git-p4-label-import.sh                |   2 +-
 t/t9814-git-p4-rename.sh                      |  18 +-
 t/t9815-git-p4-submit-fail.sh                 |   2 +-
 t/t9830-git-p4-symlink-dir.sh                 |   2 +-
 t/t9831-git-p4-triggers.sh                    |   2 +-
 t/t9902-completion.sh                         |   4 +-
 t/t9903-bash-prompt.sh                        |   2 +-
 103 files changed, 567 insertions(+), 589 deletions(-)

-- 
2.18.0.203.gfac676dfb9


Interdiff since [1]:

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 8a2edee1cb..e90ec79087 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -959,7 +959,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		)
 	'
 	# ... absorbing a .git directory.
-	test_expect_failure "$command: replace submodule containing a .git directory with a directory must fail" '
+	test_expect_success "$command: replace submodule containing a .git directory with a directory must fail" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -967,9 +967,8 @@ test_submodule_forced_switch_recursing_with_args () {
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
 			rm -rf .git/modules/sub1 &&
-			test_must_fail $command replace_sub1_with_directory &&
+			$command replace_sub1_with_directory &&
 			test_superproject_content origin/replace_sub1_with_directory &&
-			test_submodule_content sub1 origin/modify_sub1 &&
 			test_git_directory_exists sub1
 		)
 	'
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 4c865051e7..ca85aae51e 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -408,7 +408,7 @@ is_hidden () {
 test_expect_success MINGW '.git hidden' '
 	rm -rf newdir &&
 	(
-		unset GIT_DIR GIT_WORK_TREE
+		sane_unset GIT_DIR GIT_WORK_TREE &&
 		mkdir newdir &&
 		cd newdir &&
 		git init &&
@@ -420,7 +420,7 @@ test_expect_success MINGW '.git hidden' '
 test_expect_success MINGW 'bare git dir not hidden' '
 	rm -rf newdir &&
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
 		mkdir newdir &&
 		cd newdir &&
 		git --bare init
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index e74b185b6c..cf96016844 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 
 test_expect_success 'multi-read' '
 	read_tree_must_succeed initial master side &&
-	(echo a && echo b/c) >expect &&
+	test_write_lines a b/c >expect &&
 	git ls-files >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index afa27ffe2d..724b4b9bc0 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -231,9 +231,9 @@ test_expect_success 'timeout if packed-refs.lock exists' '
 test_expect_success 'retry acquiring packed-refs.lock' '
 	LOCK=.git/packed-refs.lock &&
 	>"$LOCK" &&
-	test_when_finished "wait; rm -f $LOCK" &&
+	test_when_finished "wait && rm -f $LOCK" &&
 	{
-		( sleep 1 ; rm -f $LOCK ) &
+		( sleep 1 && rm -f $LOCK ) &
 	} &&
 	git -c core.packedrefstimeout=3000 pack-refs --all --prune
 '
diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index 7e76018296..6b44ce1493 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -127,17 +127,17 @@ test_expect_success setup '
 
 	for n in $sample
 	do
-		( zs $n ; echo a ) >file-a$n &&
-		( echo b; zs $n; echo ) >file-b$n &&
-		( printf c; zs $n ) >file-c$n &&
-		( echo d; zs $n ) >file-d$n &&
+		( zs $n && echo a ) >file-a$n &&
+		( echo b && zs $n && echo ) >file-b$n &&
+		( printf c && zs $n ) >file-c$n &&
+		( echo d && zs $n ) >file-d$n &&
 
 		git add file-a$n file-b$n file-c$n file-d$n &&
 
-		( zs $n ; echo A ) >file-a$n &&
-		( echo B; zs $n; echo ) >file-b$n &&
-		( printf C; zs $n ) >file-c$n &&
-		( echo D; zs $n ) >file-d$n &&
+		( zs $n && echo A ) >file-a$n &&
+		( echo B && zs $n && echo ) >file-b$n &&
+		( printf C && zs $n ) >file-c$n &&
+		( echo D && zs $n ) >file-d$n &&
 
 		expect_pattern $n || return 1
 
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index 350d2e6ea5..ff06f99649 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -6,8 +6,9 @@ test_description='remote push rejects are reported by client'
 
 test_expect_success 'setup' '
 	mkdir .git/hooks &&
-	(echo "#!/bin/sh" && echo "exit 1") >.git/hooks/update &&
-	chmod +x .git/hooks/update &&
+	write_script .git/hooks/update <<-\EOF &&
+	exit 1
+	EOF
 	echo 1 >file &&
 	git add file &&
 	git commit -m 1 &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index b141145fc2..f604ef7a72 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -886,7 +886,7 @@ test_expect_success 'submodule update properly revives a moved submodule' '
 	 git commit -am "pre move" &&
 	 H2=$(git rev-parse --short HEAD) &&
 	 git status | sed "s/$H/XXX/" >expect &&
-	 H=$(cd submodule2; git rev-parse HEAD) &&
+	 H=$(cd submodule2 && git rev-parse HEAD) &&
 	 git rm --cached submodule2 &&
 	 rm -rf submodule2 &&
 	 mkdir -p "moved/sub module" &&
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 954948812c..5f91c0d68b 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -21,7 +21,7 @@ test_expect_success 'empty directories exist' '
 		do
 			if ! test -d "$i"
 			then
-				echo >&2 "$i does not exist"
+				echo >&2 "$i does not exist" &&
 				exit 1
 			fi
 		done
@@ -38,7 +38,7 @@ test_expect_success 'option automkdirs set to false' '
 		do
 			if test -d "$i"
 			then
-				echo >&2 "$i exists"
+				echo >&2 "$i exists" &&
 				exit 1
 			fi
 		done
@@ -63,7 +63,7 @@ test_expect_success 'git svn mkdirs recreates empty directories' '
 		do
 			if ! test -d "$i"
 			then
-				echo >&2 "$i does not exist"
+				echo >&2 "$i does not exist" &&
 				exit 1
 			fi
 		done
@@ -148,7 +148,7 @@ test_expect_success 'git svn gc-ed files work' '
 			do
 				if ! test -d "$i"
 				then
-					echo >&2 "$i does not exist"
+					echo >&2 "$i does not exist" &&
 					exit 1
 				fi
 			done
diff --git a/t/t9152-svn-empty-dirs-after-gc.sh b/t/t9152-svn-empty-dirs-after-gc.sh
index 301e779709..89f285d082 100755
--- a/t/t9152-svn-empty-dirs-after-gc.sh
+++ b/t/t9152-svn-empty-dirs-after-gc.sh
@@ -30,7 +30,7 @@ test_expect_success 'git svn mkdirs recreates empty directories after git svn gc
 		do
 			if ! test -d "$i"
 			then
-				echo >&2 "$i does not exist"
+				echo >&2 "$i does not exist" &&
 				exit 1
 			fi
 		done
diff --git a/t/t9302-fast-import-unpack-limit.sh b/t/t9302-fast-import-unpack-limit.sh
index a04de14677..bb1c39cfcc 100755
--- a/t/t9302-fast-import-unpack-limit.sh
+++ b/t/t9302-fast-import-unpack-limit.sh
@@ -80,7 +80,7 @@ test_expect_success 'lookups after checkpoint works' '
 		do
 			if test $n -gt 30
 			then
-				echo >&2 "checkpoint did not update branch"
+				echo >&2 "checkpoint did not update branch" &&
 				exit 1
 			else
 				n=$(($n + 1))
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 4207e9caa5..a5e5dca753 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -328,7 +328,7 @@ test_expect_success 'cvs update (subdirectories)' \
   '(for dir in A A/B A/B/C A/D E; do
       mkdir $dir &&
       echo "test file in $dir" >"$dir/file_in_$(echo $dir|sed -e "s#/# #g")"  &&
-      git add $dir;
+      git add $dir
    done) &&
    git commit -q -m "deep sub directory structure" &&
    git push gitcvs.git >/dev/null &&
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 80aac5ab16..60baa06e27 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -9,11 +9,11 @@ test_expect_success 'start p4d' '
 '
 
 # We rely on this behavior to detect for p4 move availability.
-test_expect_success 'p4 help unknown returns 1' '
+test_expect_success '"p4 help unknown" errors out' '
 	(
 		cd "$cli" &&
 		p4 help client &&
-		test_must_fail p4 help nosuchcommand
+		! p4 help nosuchcommand
 	)
 '
