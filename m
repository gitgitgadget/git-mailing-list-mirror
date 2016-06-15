From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 31/32] refs: tests for lmdb backend
Date: Wed, 24 Feb 2016 17:59:03 -0500
Message-ID: <1456354744-8022-32-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:00:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPi-00040K-3t
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759256AbcBXW75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:57 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34486 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759202AbcBXW7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:54 -0500
Received: by mail-qk0-f182.google.com with SMTP id x1so13258144qkc.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7JI3uqVH2Gkbkhvvw6Zcno8le/aj7YpY1P2qBTPlPnE=;
        b=V414iSJKWBZ2eTatQWTI8uslLJ0lN0gJ1msYHtDZ2R3oJFEXpuqXwMhI9WfjDeF4pO
         nfKSqDAKdVmw5OUMcX1ItvO/6jEPcmagiGXK3wWsBwOajMU1pWO+5Jx0hbktOPjk1Rmb
         pFlH6wqSlCv2IRX8QMg5POjwJxCmOZ5i8onLJZDxQQF5f4YRaHiK5OM4wqwoN5YRqhg8
         V5RpPE/dyBB2kqkEFQIkeoPDo6wePxcCbXxxInwlaXuhzot4YC/aOr5S1+EHPITZrILo
         8vq7XOjb7fDU0LOiF+Jmm0YuRRvmObtY/ExCYumLgg6RahNMq2BcfbIgqnYhEE3HEVFa
         4tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7JI3uqVH2Gkbkhvvw6Zcno8le/aj7YpY1P2qBTPlPnE=;
        b=j9pXaMY0MJwLB3gxgIE19lfgPxgMopvFiCMbwIMx5AtlcSVtbLu6602gWCJFRnuEmr
         re0MSOl7nU3KDEuEHM107qFkCItpaeoqdr0pWzLtWz+k906lK8ON8GresJ+dAugs8eW5
         4INVOMi7XUm6Dbf6Oru45YjjZKdjlO/uF0oZj6GOCW/GTERCmaqXjczw73Dn7DUr5Sik
         +O2Ty2dkvaLO3SdStJVk5+93hxy/yl/ZWvwQCKuA1Hlf2fBoPcCuRErI28U7XInx4VRJ
         b3Vypx/gk/CCLAPD6JmJS91Te0iIcaWaskC6NViGS2qqELwJhsPxv+RAQLz7UKqhAG5w
         Puag==
X-Gm-Message-State: AG10YOQ78v7fN4Y6hMM1Br01Qotub8YrEFBu2lrED5LiE75R+qgTBOBT+z8ZFWrI77fHQA==
X-Received: by 10.55.212.130 with SMTP id s2mr20728827qks.74.1456354789477;
        Wed, 24 Feb 2016 14:59:49 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:48 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287257>

Add tests for the database backend.

Signed-off-by: David Turner <dturner@twopensource.com>
Helped-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 t/t1460-refs-lmdb-backend.sh        | 1109 +++++++++++++++++++++++++++++++++++
 t/t1470-refs-lmdb-backend-reflog.sh |  359 ++++++++++++
 t/t1480-refs-lmdb-submodule.sh      |   85 +++
 t/test-lib.sh                       |    1 +
 4 files changed, 1554 insertions(+)
 create mode 100755 t/t1460-refs-lmdb-backend.sh
 create mode 100755 t/t1470-refs-lmdb-backend-reflog.sh
 create mode 100755 t/t1480-refs-lmdb-submodule.sh

diff --git a/t/t1460-refs-lmdb-backend.sh b/t/t1460-refs-lmdb-backend.sh
new file mode 100755
index 0000000..31442e7
--- /dev/null
+++ b/t/t1460-refs-lmdb-backend.sh
@@ -0,0 +1,1109 @@
+#!/bin/sh
+#
+# Copyright (c) 2015 Twitter, Inc
+# Copyright (c) 2006 Shawn Pearce
+# This test is based on t1400-update-ref.sh
+#
+
+test_description='Test lmdb refs backend'
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+if ! test_have_prereq LMDB
+then
+	skip_all="Skipping lmdb refs backend tests, lmdb backend not built"
+	test_done
+fi
+
+raw_ref() {
+	test-refs-lmdb-backend "$1"
+}
+
+delete_ref() {
+	test-refs-lmdb-backend -d "$1"
+}
+
+write_ref() {
+	test-refs-lmdb-backend "$1" "$2"
+}
+
+raw_reflog() {
+	test-refs-lmdb-backend -l "$1"
+}
+
+delete_all_reflogs() {
+	test-refs-lmdb-backend -c
+}
+
+append_reflog() {
+	test-refs-lmdb-backend -a "$1"
+}
+
+Z=$_z40
+
+test_expect_success setup '
+	git init --ref-storage=lmdb &&
+	for name in A B C D E F
+	do
+		test_tick &&
+		T=$(git write-tree) &&
+		sha1=$(echo $name | git commit-tree $T) &&
+		eval $name=$sha1
+	done
+'
+
+m=refs/heads/master
+n_dir=refs/heads/gu
+n=$n_dir/fixes
+
+test_expect_success \
+	"create $m" \
+	"git update-ref $m $A &&
+	 test $A"' = $(raw_ref '"$m"')'
+test_expect_success \
+	"create $m" \
+	"git update-ref $m $B $A &&
+	 test $B"' = $(raw_ref '"$m"')'
+test_expect_success "fail to delete $m with stale ref" '
+	test_must_fail git update-ref -d $m $A &&
+	test $B = "$(raw_ref $m)"
+'
+test_expect_success "delete $m" '
+	git update-ref -d $m $B &&
+	! raw_ref $m
+'
+delete_ref $m
+
+test_expect_success "delete $m without oldvalue verification" "
+	git update-ref $m $A &&
+	test $A = \$(raw_ref $m) &&
+	git update-ref -d $m &&
+	! raw_ref $m
+"
+delete_ref $m
+
+test_expect_success \
+	"fail to create $n" \
+	"git update-ref $n_dir $A &&
+	 test_must_fail git update-ref $n $A >out 2>err"
+
+delete_ref $n_dir
+rm -f out err
+
+test_expect_success \
+	"create $m (by HEAD)" \
+	"git update-ref HEAD $A &&
+	 test $A"' = $(raw_ref '"$m"')'
+test_expect_success \
+	"create $m (by HEAD)" \
+	"git update-ref HEAD $B $A &&
+	 test $B"' = $(raw_ref '"$m"')'
+test_expect_success "fail to delete $m (by HEAD) with stale ref" '
+	test_must_fail git update-ref -d HEAD $A &&
+	test $B = $(raw_ref '"$m"')
+'
+test_expect_success "delete $m (by HEAD)" '
+	git update-ref -d HEAD $B &&
+	! raw_ref $m
+'
+delete_ref $m
+
+test_expect_success \
+	"create $m (by HEAD)" \
+	"git update-ref HEAD $A &&
+	 test $A"' = $(raw_ref '"$m"')'
+test_expect_success \
+	"pack refs" \
+	"git pack-refs --all"
+test_expect_success \
+	"move $m (by HEAD)" \
+	"git update-ref HEAD $B $A &&
+	 test $B"' = $(raw_ref '"$m"')'
+test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
+	git update-ref -d HEAD $B &&
+	! raw_ref $m
+'
+delete_ref $m
+
+OLD_HEAD=$(raw_ref HEAD)
+test_expect_success "delete symref without dereference" '
+	git update-ref --no-deref -d HEAD &&
+	! raw_ref HEAD
+'
+write_ref HEAD "$OLD_HEAD"
+
+test_expect_success "delete symref without dereference when the referred ref is packed" '
+	echo foo >foo.c &&
+	git add foo.c &&
+	git commit -m foo &&
+	git pack-refs --all &&
+	git update-ref --no-deref -d HEAD &&
+	! raw_ref HEAD
+'
+write_ref HEAD "$OLD_HEAD"
+delete_ref $m
+
+test_expect_success 'update-ref -d is not confused by self-reference' '
+	git symbolic-ref refs/heads/self refs/heads/self &&
+	test_when_finished "delete_ref refs/heads/self" &&
+	test_must_fail git update-ref -d refs/heads/self
+'
+
+test_expect_success 'update-ref --no-deref -d can delete self-reference' '
+	git symbolic-ref refs/heads/self refs/heads/self &&
+	test_when_finished "delete_ref refs/heads/self" &&
+	git update-ref --no-deref -d refs/heads/self
+'
+
+test_expect_success 'update-ref --no-deref -d can delete reference to bad ref' '
+	test-refs-lmdb-backend refs/heads/bad "" &&
+	test_when_finished "delete_ref refs/heads/bad" &&
+	git symbolic-ref refs/heads/ref-to-bad refs/heads/bad &&
+	test_when_finished "delete_ref refs/heads/ref-to-bad" &&
+	raw_ref refs/heads/ref-to-bad &&
+	git update-ref --no-deref -d refs/heads/ref-to-bad &&
+	! raw_ref refs/heads/ref-to-bad
+'
+
+test_expect_success '(not) create HEAD with old sha1' "
+	test_must_fail git update-ref HEAD $A $B
+"
+test_expect_success "(not) prior created .git/$m" "
+	! raw_ref $m
+"
+delete_ref $m
+
+test_expect_success \
+	"create HEAD" \
+	"git update-ref HEAD $A"
+test_expect_success '(not) change HEAD with wrong SHA1' "
+	test_must_fail git update-ref HEAD $B $Z
+"
+test_expect_success "(not) changed .git/$m" "
+	! test $B"' = $(raw_ref '"$m"')
+'
+
+: a repository with working tree always has reflog these days...
+delete_all_reflogs
+: | append_reflog $m
+delete_ref $m
+
+test_expect_success \
+	"create $m (logged by touch)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
+	 git update-ref HEAD '"$A"' -m "Initial Creation" &&
+	 test '"$A"' = $(raw_ref '"$m"')'
+test_expect_success \
+	"update $m (logged by touch)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:31" \
+	 git update-ref HEAD'" $B $A "'-m "Switch" &&
+	 test '"$B"' = $(raw_ref '"$m"')'
+test_expect_success \
+	"set $m (logged by touch)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:41" \
+	 git update-ref HEAD'" $A &&
+	 test $A"' = $(raw_ref '"$m"')'
+
+cat >expect <<EOF
+$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
+$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
+EOF
+test_expect_success \
+	"verifying $m's log" \
+	"raw_reflog $m >actual &&
+	 test_cmp expect actual"
+delete_ref $m
+delete_all_reflogs
+: | append_reflog $m
+rm -f actual expect
+
+test_expect_success \
+	'enable core.logAllRefUpdates' \
+	'git config core.logAllRefUpdates true &&
+	 test true = $(git config --bool --get core.logAllRefUpdates)'
+
+test_expect_success \
+	"create $m (logged by config)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:32" \
+	 git update-ref HEAD'" $A "'-m "Initial Creation" &&
+	 test '"$A"' = $(raw_ref '"$m"')'
+test_expect_success \
+	"update $m (logged by config)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:33" \
+	 git update-ref HEAD'" $B $A "'-m "Switch" &&
+	 test '"$B"' = $(raw_ref '"$m"')'
+test_expect_success \
+	"set $m (logged by config)" \
+	'GIT_COMMITTER_DATE="2005-05-26 23:43" \
+	 git update-ref HEAD '"$A &&
+	 test $A"' = $(raw_ref '"$m"')'
+
+cat >expect <<EOF
+$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
+$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
+EOF
+test_expect_success \
+	"verifying $m's log" \
+	'raw_reflog $m >actual &&
+	test_cmp expect actual'
+delete_ref $m
+rm -f expect
+
+git update-ref $m $D
+git reflog expire --expire=all $m
+
+append_reflog $m <<EOF
+0000000000000000000000000000000000000000 $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
+$C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150350 -0500
+$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
+$F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
+$Z $E $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 -0500
+EOF
+
+ed="Thu, 26 May 2005 18:32:00 -0500"
+gd="Thu, 26 May 2005 18:33:00 -0500"
+ld="Thu, 26 May 2005 18:43:00 -0500"
+test_expect_success \
+	'Query "master@{May 25 2005}" (before history)' \
+	'rm -f o e &&
+	 git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
+	 test '"$C"' = $(cat o) &&
+	 test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
+test_expect_success \
+	"Query master@{2005-05-25} (before history)" \
+	'rm -f o e &&
+	 git rev-parse --verify master@{2005-05-25} >o 2>e &&
+	 test '"$C"' = $(cat o) &&
+	 echo test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
+test_expect_success \
+	'Query "master@{May 26 2005 23:31:59}" (1 second before history)' \
+	'rm -f o e &&
+	 git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
+	 test '"$C"' = $(cat o) &&
+	 test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"'
+test_expect_success \
+	'Query "master@{May 26 2005 23:32:00}" (exactly history start)' \
+	'rm -f o e &&
+	 git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
+	 test '"$C"' = $(cat o) &&
+	 test "" = "$(cat e)"'
+test_expect_success \
+	'Query "master@{May 26 2005 23:32:30}" (first non-creation change)' \
+	'rm -f o e &&
+	 git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
+	 test '"$A"' = $(cat o) &&
+	 test "" = "$(cat e)"'
+test_expect_success \
+	'Query "master@{2005-05-26 23:33:01}" (middle of history with gap)' \
+	'rm -f o e &&
+	 git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
+	 test '"$B"' = $(cat o) &&
+	 test "warning: Log for ref '"$m has gap after $gd"'." = "$(cat e)"'
+test_expect_success \
+	'Query "master@{2005-05-26 23:38:00}" (middle of history)' \
+	'rm -f o e &&
+	 git rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
+	 test '"$Z"' = $(cat o) &&
+	 test "" = "$(cat e)"'
+test_expect_success \
+	'Query "master@{2005-05-26 23:43:00}" (exact end of history)' \
+	'rm -f o e &&
+	 git rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
+	 test '"$E"' = $(cat o) &&
+	 test "" = "$(cat e)"'
+test_expect_success \
+	'Query "master@{2005-05-28}" (past end of history)' \
+	'rm -f o e &&
+	 git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
+	 test '"$D"' = $(cat o) &&
+	 test "warning: Log for ref '"$m unexpectedly ended on $ld"'." = "$(cat e)"'
+
+
+git reflog expire --expire=all $m
+delete_ref $m
+
+test_expect_success \
+    'creating initial files' \
+    'echo TEST >F &&
+     git add F &&
+	 GIT_AUTHOR_DATE="2005-05-26 23:30" \
+	 GIT_COMMITTER_DATE="2005-05-26 23:30" git commit -m add -a &&
+	 h_TEST=$(git rev-parse --verify HEAD) &&
+	 echo The other day this did not work. >M &&
+	 echo And then Bob told me how to fix it. >>M &&
+	 echo OTHER >F &&
+	 GIT_AUTHOR_DATE="2005-05-26 23:41" \
+	 GIT_COMMITTER_DATE="2005-05-26 23:41" git commit -F M -a &&
+	 h_OTHER=$(git rev-parse --verify HEAD) &&
+	 GIT_AUTHOR_DATE="2005-05-26 23:44" \
+	 GIT_COMMITTER_DATE="2005-05-26 23:44" git commit --amend &&
+	 h_FIXED=$(git rev-parse --verify HEAD) &&
+	 echo Merged initial commit and a later commit. >M &&
+	 echo $h_TEST >.git/MERGE_HEAD &&
+	 GIT_AUTHOR_DATE="2005-05-26 23:45" \
+	 GIT_COMMITTER_DATE="2005-05-26 23:45" git commit -F M &&
+	 h_MERGED=$(git rev-parse --verify HEAD) &&
+	 rm -f M'
+
+cat >expect <<EOF
+$Z $h_TEST $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	commit (initial): add
+$h_TEST $h_OTHER $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000	commit: The other day this did not work.
+$h_OTHER $h_FIXED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151040 +0000	commit (amend): The other day this did not work.
+$h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	commit (merge): Merged initial commit and a later commit.
+EOF
+test_expect_success \
+	'git commit logged updates' \
+	"raw_reflog $m >actual &&
+	test_cmp expect actual"
+unset h_TEST h_OTHER h_FIXED h_MERGED
+
+test_expect_success \
+	'git cat-file blob master:F (expect OTHER)' \
+	'test OTHER = $(git cat-file blob master:F)'
+test_expect_success \
+	'git cat-file blob master@{2005-05-26 23:30}:F (expect TEST)' \
+	'test TEST = $(git cat-file blob "master@{2005-05-26 23:30}:F")'
+test_expect_success \
+	'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
+	'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
+
+a=refs/heads/a
+b=refs/heads/b
+c=refs/heads/c
+E='""'
+F='%s\0'
+pws='path with space'
+
+test_expect_success 'stdin test setup' '
+	echo "$pws" >"$pws" &&
+	git add -- "$pws" &&
+	git commit -m "$pws"
+'
+
+test_expect_success '-z fails without --stdin' '
+	test_must_fail git update-ref -z $m $m $m 2>err &&
+	grep "usage: git update-ref" err
+'
+
+test_expect_success 'stdin works with no input' '
+	>stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse --verify -q $m
+'
+
+test_expect_success 'stdin fails on empty line' '
+	echo "" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: empty command in input" err
+'
+
+test_expect_success 'stdin fails on only whitespace' '
+	echo " " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command:  " err
+'
+
+test_expect_success 'stdin fails on leading whitespace' '
+	echo " create $a $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command:  create $a $m" err
+'
+
+test_expect_success 'stdin fails on unknown command' '
+	echo "unknown $a" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: unknown command: unknown $a" err
+'
+
+test_expect_success 'stdin fails on unbalanced quotes' '
+	echo "create $a \"master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: badly quoted argument: \\\"master" err
+'
+
+test_expect_success 'stdin fails on invalid escape' '
+	echo "create $a \"ma\zter\"" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: badly quoted argument: \\\"ma\\\\zter\\\"" err
+'
+
+test_expect_success 'stdin fails on junk after quoted argument' '
+	echo "create \"$a\"master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"master" err
+'
+
+test_expect_success 'stdin fails create with no ref' '
+	echo "create " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: create: missing <ref>" err
+'
+
+test_expect_success 'stdin fails create with no new value' '
+	echo "create $a" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: create $a: missing <newvalue>" err
+'
+
+test_expect_success 'stdin fails create with too many arguments' '
+	echo "create $a $m $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: create $a: extra input:  $m" err
+'
+
+test_expect_success 'stdin fails update with no ref' '
+	echo "update " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: update: missing <ref>" err
+'
+
+test_expect_success 'stdin fails update with no new value' '
+	echo "update $a" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: update $a: missing <newvalue>" err
+'
+
+test_expect_success 'stdin fails update with too many arguments' '
+	echo "update $a $m $m $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: update $a: extra input:  $m" err
+'
+
+test_expect_success 'stdin fails delete with no ref' '
+	echo "delete " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: delete: missing <ref>" err
+'
+
+test_expect_success 'stdin fails delete with too many arguments' '
+	echo "delete $a $m $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: delete $a: extra input:  $m" err
+'
+
+test_expect_success 'stdin fails verify with too many arguments' '
+	echo "verify $a $m $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: verify $a: extra input:  $m" err
+'
+
+test_expect_success 'stdin fails option with unknown name' '
+	echo "option unknown" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: option unknown: unknown" err
+'
+
+test_expect_success 'stdin fails with duplicate refs' '
+	cat >stdin <<-EOF &&
+	create $a $m
+	create $b $m
+	create $a $m
+	EOF
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+'
+
+test_expect_success 'stdin create ref works' '
+	echo "create $a $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin succeeds with quoted argument' '
+	git update-ref -d $a &&
+	echo "create $a \"$m\"" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin succeeds with escaped character' '
+	git update-ref -d $a &&
+	echo "create $a \"ma\\163ter\"" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin update ref creates with zero old value' '
+	echo "update $b $m $Z" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git update-ref -d $b
+'
+
+test_expect_success 'stdin update ref creates with empty old value' '
+	echo "update $b $m $E" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin create ref works with path with space to blob' '
+	echo "create refs/blobs/pws \"$m:$pws\"" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse "$m:$pws" >expect &&
+	git rev-parse refs/blobs/pws >actual &&
+	test_cmp expect actual &&
+	git update-ref -d refs/blobs/pws
+'
+
+test_expect_success 'stdin update ref fails with wrong old value' '
+	echo "update $c $m $m~1" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: cannot lock the ref '"'"'$c'"'"'" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin update ref fails with bad old value' '
+	echo "update $c $m does-not-exist" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin create ref fails with bad new value' '
+	echo "create $c does-not-exist" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin create ref fails with zero new value' '
+	echo "create $c " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: create $c: zero <newvalue>" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin update ref works with right old value' '
+	echo "update $b $m~1 $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete ref fails with wrong old value' '
+	echo "delete $a $m~1" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: cannot lock the ref '"'"'$a'"'"'" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete ref fails with zero old value' '
+	echo "delete $a " >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: delete $a: zero <oldvalue>" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin update symref works option no-deref' '
+	git symbolic-ref refs/TESTSYMREF $b &&
+	cat >stdin <<-EOF &&
+	option no-deref
+	update refs/TESTSYMREF $a $b
+	EOF
+	git update-ref --stdin <stdin &&
+	git rev-parse refs/TESTSYMREF >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete symref works option no-deref' '
+	git symbolic-ref refs/TESTSYMREF $b &&
+	cat >stdin <<-EOF &&
+	option no-deref
+	delete refs/TESTSYMREF $b
+	EOF
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/TESTSYMREF &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete ref works with right old value' '
+	echo "delete $b $m~1" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $b
+'
+
+test_expect_success 'stdin update/create/verify combination works' '
+	cat >stdin <<-EOF &&
+	update $a $m
+	create $b $m
+	verify $c
+	EOF
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin verify succeeds for correct value' '
+	git rev-parse $m >expect &&
+	echo "verify $m $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin verify succeeds for missing reference' '
+	echo "verify refs/heads/missing $Z" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/heads/missing
+'
+
+test_expect_success 'stdin verify treats no value as missing' '
+	echo "verify refs/heads/missing" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/heads/missing
+'
+
+test_expect_success 'stdin verify fails for wrong value' '
+	git rev-parse $m >expect &&
+	echo "verify $m $m~1" >stdin &&
+	test_must_fail git update-ref --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin verify fails for mistaken null value' '
+	git rev-parse $m >expect &&
+	echo "verify $m $Z" >stdin &&
+	test_must_fail git update-ref --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin verify fails for mistaken empty value' '
+	M=$(git rev-parse $m) &&
+	test_when_finished "git update-ref $m $M" &&
+	git rev-parse $m >expect &&
+	echo "verify $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin update refs works with identity updates' '
+	cat >stdin <<-EOF &&
+	update $a $m $m
+	update $b $m $m
+	update $c $Z $E
+	EOF
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin update refs fails with wrong old value' '
+	git update-ref $c $m &&
+	cat >stdin <<-EOF &&
+	update $a $m $m
+	update $b $m $m
+	update $c  ''
+	EOF
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: cannot lock the ref '"'"'$c'"'"'" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git rev-parse $c >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin delete refs works with packed and loose refs' '
+	git pack-refs --all &&
+	git update-ref $c $m~1 &&
+	cat >stdin <<-EOF &&
+	delete $a $m
+	update $b $Z $m
+	update $c $E $m~1
+	EOF
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $a &&
+	test_must_fail git rev-parse --verify -q $b &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z works on empty input' '
+	>stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse --verify -q $m
+'
+
+test_expect_success 'stdin -z fails on empty line' '
+	echo "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command: " err
+'
+
+test_expect_success 'stdin -z fails on empty command' '
+	printf $F "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: empty command in input" err
+'
+
+test_expect_success 'stdin -z fails on only whitespace' '
+	printf $F " " >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command:  " err
+'
+
+test_expect_success 'stdin -z fails on leading whitespace' '
+	printf $F " create $a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: whitespace before command:  create $a" err
+'
+
+test_expect_success 'stdin -z fails on unknown command' '
+	printf $F "unknown $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: unknown $a" err
+'
+
+test_expect_success 'stdin -z fails create with no ref' '
+	printf $F "create " >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: create: missing <ref>" err
+'
+
+test_expect_success 'stdin -z fails create with no new value' '
+	printf $F "create $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: create $a: unexpected end of input when reading <newvalue>" err
+'
+
+test_expect_success 'stdin -z fails create with too many arguments' '
+	printf $F "create $a" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails update with no ref' '
+	printf $F "update " >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update: missing <ref>" err
+'
+
+test_expect_success 'stdin -z fails update with too few args' '
+	printf $F "update $a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
+'
+
+test_expect_success 'stdin -z emits warning with empty new value' '
+	git update-ref $a $m &&
+	printf $F "update $a" "" "" >stdin &&
+	git update-ref -z --stdin <stdin 2>err &&
+	grep "warning: update $a: missing <newvalue>, treating as zero" err &&
+	test_must_fail git rev-parse --verify -q $a
+'
+
+test_expect_success 'stdin -z fails update with no new value' '
+	printf $F "update $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update $a: unexpected end of input when reading <newvalue>" err
+'
+
+test_expect_success 'stdin -z fails update with no old value' '
+	printf $F "update $a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
+'
+
+test_expect_success 'stdin -z fails update with too many arguments' '
+	printf $F "update $m" "$m" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails delete with no ref' '
+	printf $F "delete " >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: delete: missing <ref>" err
+'
+
+test_expect_success 'stdin -z fails delete with no old value' '
+	printf $F "delete $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: delete $a: unexpected end of input when reading <oldvalue>" err
+'
+
+test_expect_success 'stdin -z fails delete with too many arguments' '
+	printf $F "delete $m" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails verify with too many arguments' '
+	printf $F "verify $m" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails verify with no old value' '
+	printf $F "verify $a" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: verify $a: unexpected end of input when reading <oldvalue>" err
+'
+
+test_expect_success 'stdin -z fails option with unknown name' '
+	printf $F "option unknown" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: option unknown: unknown" err
+'
+
+test_expect_success 'stdin -z fails with duplicate refs' '
+	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+'
+
+test_expect_success 'stdin -z create ref works' '
+	printf $F "create $a" "$m" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z update ref creates with zero old value' '
+	printf $F "update $b" "$m" "$Z" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git update-ref -d $b
+'
+
+test_expect_success 'stdin -z update ref creates with empty old value' '
+	printf $F "update $b" "$m" "" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z create ref works with path with space to blob' '
+	printf $F "create refs/blobs/pws" "$m:$pws" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse "$m:$pws" >expect &&
+	git rev-parse refs/blobs/pws >actual &&
+	test_cmp expect actual &&
+	git update-ref -d refs/blobs/pws
+'
+
+test_expect_success 'stdin -z update ref fails with wrong old value' '
+	printf $F "update $c" "$m" "$m~1" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: cannot lock the ref '"'"'$c'"'"'" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z update ref fails with bad old value' '
+	printf $F "update $c" "$m" "does-not-exist" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z create ref fails when ref exists' '
+	git update-ref $c $m &&
+	git rev-parse "$c" >expect &&
+	printf $F "create $c" "$m~1" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: cannot lock the ref '"'"'$c'"'"'" err &&
+	git rev-parse "$c" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z create ref fails with bad new value' '
+	git update-ref -d "$c" &&
+	printf $F "create $c" "does-not-exist" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z create ref fails with empty new value' '
+	printf $F "create $c" "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: create $c: missing <newvalue>" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z update ref works with right old value' '
+	printf $F "update $b" "$m~1" "$m" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete ref fails with wrong old value' '
+	printf $F "delete $a" "$m~1" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: cannot lock the ref '"'"'$a'"'"'" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete ref fails with zero old value' '
+	printf $F "delete $a" "$Z" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: delete $a: zero <oldvalue>" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z update symref works option no-deref' '
+	git symbolic-ref refs/TESTSYMREF $b &&
+	printf $F "option no-deref" "update refs/TESTSYMREF" "$a" "$b" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse refs/TESTSYMREF >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete symref works option no-deref' '
+	git symbolic-ref refs/TESTSYMREF $b &&
+	printf $F "option no-deref" "delete refs/TESTSYMREF" "$b" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/TESTSYMREF &&
+	git rev-parse $m~1 >expect &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete ref works with right old value' '
+	printf $F "delete $b" "$m~1" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $b
+'
+
+test_expect_success 'stdin -z update/create/verify combination works' '
+	printf $F "update $a" "$m" "" "create $b" "$m" "verify $c" "" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z verify succeeds for correct value' '
+	git rev-parse $m >expect &&
+	printf $F "verify $m" "$m" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z verify succeeds for missing reference' '
+	printf $F "verify refs/heads/missing" "$Z" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/heads/missing
+'
+
+test_expect_success 'stdin -z verify treats no value as missing' '
+	printf $F "verify refs/heads/missing" "" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/heads/missing
+'
+
+test_expect_success 'stdin -z verify fails for wrong value' '
+	git rev-parse $m >expect &&
+	printf $F "verify $m" "$m~1" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z verify fails for mistaken null value' '
+	git rev-parse $m >expect &&
+	printf $F "verify $m" "$Z" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z verify fails for mistaken empty value' '
+	M=$(git rev-parse $m) &&
+	test_when_finished "git update-ref $m $M" &&
+	git rev-parse $m >expect &&
+	printf $F "verify $m" "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z update refs works with identity updates' '
+	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$Z" "" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z update refs fails with wrong old value' '
+	git update-ref $c $m &&
+	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$m" "$Z" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: cannot lock the ref '"'"'$c'"'"'" err &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual &&
+	git rev-parse $b >actual &&
+	test_cmp expect actual &&
+	git rev-parse $c >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z delete refs works with packed and loose refs' '
+	git pack-refs --all &&
+	git update-ref $c $m~1 &&
+	printf $F "delete $a" "$m" "update $b" "$Z" "$m" "update $c" "" "$m~1" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $a &&
+	test_must_fail git rev-parse --verify -q $b &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_done
diff --git a/t/t1470-refs-lmdb-backend-reflog.sh b/t/t1470-refs-lmdb-backend-reflog.sh
new file mode 100755
index 0000000..83bfba0
--- /dev/null
+++ b/t/t1470-refs-lmdb-backend-reflog.sh
@@ -0,0 +1,359 @@
+#!/bin/sh
+#
+# Copyright (c) 2015 Twitter, Inc
+# Copyright (c) 2007 Junio C Hamano
+#
+
+test_description='Test prune and reflog expiration'
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+if ! test_have_prereq LMDB
+then
+	skip_all="Skipping lmdb refs backend tests, lmdb backend not built"
+	test_done
+fi
+
+raw_reflog() {
+	cat .git/logs/$1 2>/dev/null || test-refs-lmdb-backend -l "$1"
+}
+
+append_reflog() {
+	test-refs-lmdb-backend -a "$1"
+}
+
+check_have () {
+	gaah= &&
+	for N in "$@"
+	do
+		eval "o=\$$N" && git cat-file -t $o || {
+			echo Gaah $N
+			gaah=$N
+			break
+		}
+	done &&
+	test -z "$gaah"
+}
+
+check_fsck () {
+	output=$(git fsck --full)
+	case "$1" in
+	'')
+		test -z "$output" ;;
+	*)
+		echo "$output" | grep "$1" ;;
+	esac
+}
+
+corrupt () {
+	aa=${1%??????????????????????????????????????} zz=${1#??}
+	mv .git/objects/$aa/$zz .git/$aa$zz
+}
+
+recover () {
+	aa=${1%??????????????????????????????????????} zz=${1#??}
+	mkdir -p .git/objects/$aa
+	mv .git/$aa$zz .git/objects/$aa/$zz
+}
+
+check_dont_have () {
+	gaah= &&
+	for N in "$@"
+	do
+		eval "o=\$$N"
+		git cat-file -t $o && {
+			echo Gaah $N
+			gaah=$N
+			break
+		}
+	done
+	test -z "$gaah"
+}
+
+test_expect_success setup '
+	git init --ref-storage=lmdb &&
+	mkdir -p A/B &&
+	echo rat >C &&
+	echo ox >A/D &&
+	echo tiger >A/B/E &&
+	git add . &&
+
+	test_tick && git commit -m rabbit &&
+	H=`git rev-parse --verify HEAD` &&
+	A=`git rev-parse --verify HEAD:A` &&
+	B=`git rev-parse --verify HEAD:A/B` &&
+	C=`git rev-parse --verify HEAD:C` &&
+	D=`git rev-parse --verify HEAD:A/D` &&
+	E=`git rev-parse --verify HEAD:A/B/E` &&
+	check_fsck &&
+
+	test_chmod +x C &&
+	git add C &&
+	test_tick && git commit -m dragon &&
+	L=`git rev-parse --verify HEAD` &&
+	check_fsck &&
+
+	rm -f C A/B/E &&
+	echo snake >F &&
+	echo horse >A/G &&
+	git add F A/G &&
+	test_tick && git commit -a -m sheep &&
+	F=`git rev-parse --verify HEAD:F` &&
+	G=`git rev-parse --verify HEAD:A/G` &&
+	I=`git rev-parse --verify HEAD:A` &&
+	J=`git rev-parse --verify HEAD` &&
+	check_fsck &&
+
+	rm -f A/G &&
+	test_tick && git commit -a -m monkey &&
+	K=`git rev-parse --verify HEAD` &&
+	check_fsck &&
+
+	check_have A B C D E F G H I J K L &&
+
+	git prune &&
+
+	check_have A B C D E F G H I J K L &&
+
+	check_fsck &&
+
+	raw_reflog refs/heads/master >reflog &&
+	test_when_finished rm -f reflog &&
+	test_line_count = 4 reflog
+'
+
+test_expect_success rewind '
+	test_tick && git reset --hard HEAD~2 &&
+	test -f C &&
+	test -f A/B/E &&
+	! test -f F &&
+	! test -f A/G &&
+
+	check_have A B C D E F G H I J K L &&
+
+	git prune &&
+
+	check_have A B C D E F G H I J K L &&
+
+	raw_reflog refs/heads/master >reflog &&
+	test_when_finished rm -f reflog &&
+	test_line_count = 5 reflog
+'
+
+test_expect_success 'corrupt and check' '
+
+	corrupt $F &&
+	check_fsck "missing blob $F"
+
+'
+
+test_expect_success 'reflog expire --dry-run should not touch reflog' '
+
+	git reflog expire --dry-run \
+		--expire=$(($test_tick - 10000)) \
+		--expire-unreachable=$(($test_tick - 10000)) \
+		--stale-fix \
+		--all &&
+
+	raw_reflog refs/heads/master >reflog &&
+	test_when_finished rm -f reflog &&
+	test_line_count = 5 reflog &&
+
+	check_fsck "missing blob $F"
+'
+
+test_expect_success 'reflog expire' '
+
+	git reflog expire --verbose \
+		--expire=$(($test_tick - 10000)) \
+		--expire-unreachable=$(($test_tick - 10000)) \
+		--stale-fix \
+		--all &&
+
+	echo git reflog expire --verbose \
+		--expire=$(($test_tick - 10000)) \
+		--expire-unreachable=$(($test_tick - 10000)) \
+		--stale-fix \
+		--all &&
+
+	raw_reflog refs/heads/master >reflog &&
+	test_when_finished rm -f reflog &&
+	test_line_count = 2 reflog &&
+
+	check_fsck "dangling commit $K"
+'
+
+test_expect_success 'prune and fsck' '
+
+	git prune &&
+	check_fsck &&
+
+	check_have A B C D E H L &&
+	check_dont_have F G I J K
+
+'
+
+test_expect_success 'recover and check' '
+
+	recover $F &&
+	check_fsck "dangling blob $F"
+
+'
+
+test_expect_success 'delete' '
+	echo 1 > C &&
+	test_tick &&
+	git commit -m rat C &&
+
+	echo 2 > C &&
+	test_tick &&
+	git commit -m ox C &&
+
+	echo 3 > C &&
+	test_tick &&
+	git commit -m tiger C &&
+
+	HEAD_entry_count=$(git reflog | wc -l) &&
+	master_entry_count=$(git reflog show master | wc -l) &&
+
+	test $HEAD_entry_count = 5 &&
+	test $master_entry_count = 5 &&
+
+
+	git reflog delete master@{1} &&
+	git reflog show master > output &&
+	test $(($master_entry_count - 1)) = $(wc -l < output) &&
+	test $HEAD_entry_count = $(git reflog | wc -l) &&
+	! grep ox < output &&
+
+	master_entry_count=$(wc -l < output) &&
+
+	git reflog delete HEAD@{1} &&
+	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
+	test $master_entry_count = $(git reflog show master | wc -l) &&
+
+	HEAD_entry_count=$(git reflog | wc -l) &&
+
+	git reflog delete master@{07.04.2005.15:15:00.-0700} &&
+	git reflog show master > output &&
+	test $(($master_entry_count - 1)) = $(wc -l < output) &&
+	! grep dragon < output
+
+'
+
+test_expect_success 'rewind2' '
+
+	test_tick && git reset --hard HEAD~2 &&
+	raw_reflog refs/heads/master >reflog &&
+	test_when_finished rm -f reflog &&
+	test_line_count = 4 reflog
+'
+
+test_expect_success '--expire=never' '
+
+	git reflog expire --verbose \
+		--expire=never \
+		--expire-unreachable=never \
+		--all &&
+	raw_reflog refs/heads/master >reflog &&
+	test_when_finished rm -f reflog &&
+	test_line_count = 4 reflog
+'
+
+test_expect_success 'gc.reflogexpire=never' '
+
+	git config gc.reflogexpire never &&
+	git config gc.reflogexpireunreachable never &&
+	git reflog expire --verbose --all &&
+	raw_reflog refs/heads/master >reflog &&
+	test_when_finished rm -f reflog &&
+	test_line_count = 4 reflog
+'
+
+test_expect_success 'gc.reflogexpire=false' '
+
+	git config gc.reflogexpire false &&
+	git config gc.reflogexpireunreachable false &&
+	git reflog expire --verbose --all &&
+	raw_reflog refs/heads/master >reflog &&
+	test_when_finished rm -f reflog &&
+	test_line_count = 4 reflog &&
+
+	git config --unset gc.reflogexpire &&
+	git config --unset gc.reflogexpireunreachable
+
+'
+
+test_expect_success 'checkout should not delete log for packed ref' '
+	test $(git reflog master | wc -l) = 4 &&
+	git branch foo &&
+	git pack-refs --all &&
+	git checkout foo &&
+	test $(git reflog master | wc -l) = 4
+'
+
+test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
+	test_when_finished "git branch -d one || git branch -d one/two" &&
+
+	git branch one/two master &&
+	echo "one/two@{0} branch: Created from master" >expect &&
+	git log -g --format="%gd %gs" one/two >actual &&
+	test_cmp expect actual &&
+	git branch -d one/two &&
+
+	# now logs/refs/heads/one is a stale directory, but
+	# we should move it out of the way to create "one" reflog
+	git branch one master &&
+	echo "one@{0} branch: Created from master" >expect &&
+	git log -g --format="%gd %gs" one >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
+	test_when_finished "git branch -d one || git branch -d one/two" &&
+
+	git branch one/two master &&
+	echo "one/two@{0} branch: Created from master" >expect &&
+	git log -g --format="%gd %gs" one/two >actual &&
+	test_cmp expect actual &&
+	git branch -d one/two &&
+
+	# same as before, but we only create a reflog for "one" if
+	# it already exists, which it does not
+	git -c core.logallrefupdates=false branch one master &&
+	: >expect &&
+	git log -g --format="%gd %gs" one >actual &&
+	test_cmp expect actual
+'
+
+# Triggering the bug detected by this test requires a newline to fall
+# exactly BUFSIZ-1 bytes from the end of the file. We don't know
+# what that value is, since it's platform dependent. However, if
+# we choose some value N, we also catch any D which divides N evenly
+# (since we will read backwards in chunks of D). So we choose 8K,
+# which catches glibc (with an 8K BUFSIZ) and *BSD (1K).
+#
+# Each line is 114 characters, so we need 75 to still have a few before the
+# last 8K. The 89-character padding on the final entry lines up our
+# newline exactly.
+test_expect_success 'parsing reverse reflogs at BUFSIZ boundaries' '
+	git checkout -b reflogskip &&
+	z38=00000000000000000000000000000000000000 &&
+	ident="abc <xyz> 0000000001 +0000" &&
+	for i in $(test_seq 1 75); do
+		printf "$z38%02d $z38%02d %s\t" $i $(($i+1)) "$ident" &&
+		if test $i = 75; then
+			for j in $(test_seq 1 89); do
+				printf X
+			done
+		else
+			printf X
+		fi &&
+		printf "\n"
+	done | append_reflog refs/heads/reflogskip &&
+	git rev-parse reflogskip@{73} >actual &&
+	echo ${z38}03 >expect &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t1480-refs-lmdb-submodule.sh b/t/t1480-refs-lmdb-submodule.sh
new file mode 100755
index 0000000..57a5fd2
--- /dev/null
+++ b/t/t1480-refs-lmdb-submodule.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Twitter, Inc
+# Based on t5531-deep-submodule-push.sh
+
+test_description='Test lmdb refs backend'
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+if ! test_have_prereq LMDB
+then
+	skip_all="Skipping lmdb refs backend tests, lmdb backend not built"
+	test_done
+fi
+
+test_expect_success setup '
+	mkdir pub.git &&
+	GIT_DIR=pub.git git init --bare &&
+	GIT_DIR=pub.git git config receive.fsckobjects true &&
+	mkdir work &&
+	(
+		cd work &&
+		git init --ref-storage=lmdb &&
+		git config push.default matching &&
+		mkdir -p gar/bage &&
+		(
+			cd gar/bage &&
+			git init --ref-storage=lmdb  &&
+			git config push.default matching &&
+			>junk &&
+			git add junk &&
+			git commit -m "Initial junk"
+		) &&
+		git add gar/bage &&
+		git commit -m "Initial superproject"
+	)
+'
+
+test_expect_success 'submodules have same ref storage' '
+	git init --ref-storage=lmdb test &&
+	(
+		cd test &&
+		git submodule add ../work/gar/bage w
+	) &&
+	(
+		cd test/w &&
+		git config extensions.refstorage >cfg &&
+		echo lmdb >expect &&
+		test_cmp cfg expect
+	)
+'
+
+test_expect_success 'push with correct backend' '
+	(
+		cd work/gar/bage &&
+		>junk2 &&
+		git add junk2 &&
+		git commit -m "Second junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Second commit for gar/bage" &&
+		git push --recurse-submodules=check ../pub.git master
+	)
+'
+
+test_expect_success 'commit with different backend fails' '
+	(
+		cd work/gar/bage &&
+		test_commit junk3 &&
+		# manually convert to files-backend
+		gitdir="$(git rev-parse --git-dir)" &&
+		mkdir -p "$gitdir/refs/heads" &&
+		git rev-parse HEAD >"$gitdir/refs/heads/master" &&
+		git config --local --unset extensions.refStorage &&
+		rm -r "$gitdir/refs.lmdb"
+	) &&
+	(
+		cd work &&
+		test_must_fail git add gar/bage
+	)
+'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0b47eb6..ce40770 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -960,6 +960,7 @@ test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+test -n "$USE_LIBLMDB" && test_set_prereq LMDB
 
 # Can we rely on git's output in the C locale?
 if test -n "$GETTEXT_POISON"
-- 
2.4.2.767.g62658d5-twtrsrc
