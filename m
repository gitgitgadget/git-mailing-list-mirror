From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 2/7] i18n: rebase: mark messages for translation
Date: Wed, 25 Jul 2012 22:53:08 +0800
Message-ID: <051a48c40cd144e36c4cd5798376d56bdc4705bf.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
 <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227806.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:53:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su2yJ-0006xB-LB
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 16:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933417Ab2GYOxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 10:53:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40079 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933416Ab2GYOxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 10:53:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1526654pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=C2yhg3t3z3F8oQauqnHwepdDLZnWZzjtdnFHyMC85Ts=;
        b=lme/s0Zb4NQLJEAskjhs4kkQ23hez6MsFn83TFZxbI1PM2b8a4pkD6sNujnqBOJ6hJ
         eZaaZokObmYLYm1s3ZUbLbYrrOVL1BV9oPT4hwKxOkY2zpMQQB241xFTa6SgByj1DKxe
         U2YNHi6bkLwwdOofrIrtRKB1xfwmdcuGKEn9qHweb9pepXno7Ec0tdyiyz8gnElEZhcA
         C23NdPDSacqICDjaAeG9njN57a0SRgzbXZCnzPmxBVIEf61pQdr/K0+in8Pa3ZbqDrXi
         2CP0PiwPN/BoQ26QYDeoopp+2yu2Ic2ql+yhwN8iVzdxYy8afgfHQ263nPbxoOIw4mh9
         QqCA==
Received: by 10.68.221.106 with SMTP id qd10mr55031835pbc.42.1343228026421;
        Wed, 25 Jul 2012 07:53:46 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1886775pbb.49.2012.07.25.07.53.38
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 07:53:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227806.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202159>

Mark messages in git-rebase.sh for translation.  While doing this
Jonathan noticed that the comma usage and sentence structure of the
resolvemsg was not quite right, so correct that and its cousins in
git-am.sh and t/t0201-gettext-fallbacks.sh at the same time.

Some tests would start to fail with GETTEXT_POISON turned on after
this update.  Use test_i18ncmp and test_i18ngrep where appropriate
to mark strings that should only be checked in the C locale output
to avoid such issues.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 git-am.sh                    |  6 ++---
 git-rebase.sh                | 64 +++++++++++++++++++++++---------------------
 t/t0201-gettext-fallbacks.sh |  8 +++---
 t/t3400-rebase.sh            |  8 +++---
 t/t3406-rebase-message.sh    |  9 ++++++-
 5 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c02e6..8961a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -102,9 +102,9 @@ stop_here_user_resolve () {
 	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
-    eval_gettextln "When you have resolved this problem run \"\$cmdline --resolved\".
-If you would prefer to skip this patch, instead run \"\$cmdline --skip\".
-To restore the original branch and stop patching run \"\$cmdline --abort\"."
+    eval_gettextln "When you have resolved this problem, run \"\$cmdline --resolved\".
+If you prefer to skip this patch, run \"\$cmdline --skip\" instead.
+To restore the original branch and stop patching, run \"\$cmdline --abort\"."
 
     stop_here $1
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index 1cd06..8710d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -65,6 +65,7 @@ abort!             abort and check out the original branch
 skip!              skip current patch and continue
 "
 . git-sh-setup
+. git-sh-i18n
 set_reflog_action rebase
 require_work_tree_exists
 cd_to_toplevel
@@ -73,9 +74,9 @@ LF='
 '
 ok_to_skip_pre_rebase=
 resolvemsg="
-When you have resolved this problem run \"git rebase --continue\".
-If you would prefer to skip this patch, instead run \"git rebase --skip\".
-To check out the original branch and stop rebasing run \"git rebase --abort\".
+$(gettext 'When you have resolved this problem, run "git rebase --continue".
+If you prefer to skip this patch, run "git rebase --skip" instead.
+To check out the original branch and stop rebasing, run "git rebase --abort".')
 "
 unset onto
 cmd=
@@ -161,7 +162,7 @@ move_to_original_branch () {
 		git symbolic-ref \
 			-m "rebase finished: returning to $head_name" \
 			HEAD $head_name ||
-		die "Could not move back to $head_name"
+		die "$(gettext "Could not move back to $head_name")"
 		;;
 	esac
 }
@@ -180,12 +181,12 @@ run_pre_rebase_hook () {
 	   test -x "$GIT_DIR/hooks/pre-rebase"
 	then
 		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} ||
-		die "The pre-rebase hook refused to rebase."
+		die "$(gettext "The pre-rebase hook refused to rebase.")"
 	fi
 }
 
 test -f "$apply_dir"/applying &&
-	die 'It looks like git-am is in progress. Cannot rebase.'
+	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
 
 if test -d "$apply_dir"
 then
@@ -316,12 +317,12 @@ test $# -gt 2 && usage
 if test -n "$cmd" &&
    test "$interactive_rebase" != explicit
 then
-	die "--exec option must be used with --interactive option"
+	die "$(gettext -- "--exec option must be used with --interactive option")"
 fi
 
 if test -n "$action"
 then
-	test -z "$in_progress" && die "No rebase in progress?"
+	test -z "$in_progress" && die "$(gettext "No rebase in progress?")"
 	# Only interactive rebase uses detailed reflog messages
 	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
 	then
@@ -334,11 +335,11 @@ case "$action" in
 continue)
 	# Sanity check
 	git rev-parse --verify HEAD >/dev/null ||
-		die "Cannot read HEAD"
+		die "$(gettext "Cannot read HEAD")"
 	git update-index --ignore-submodules --refresh &&
 	git diff-files --quiet --ignore-submodules || {
-		echo "You must edit all merge conflicts and then"
-		echo "mark them as resolved using git add"
+		echo "$(gettext "You must edit all merge conflicts and then
+mark them as resolved using git add")"
 		exit 1
 	}
 	read_basic_state
@@ -355,7 +356,7 @@ abort)
 	case "$head_name" in
 	refs/*)
 		git symbolic-ref -m "rebase: aborting" HEAD $head_name ||
-		die "Could not move back to $head_name"
+		die "$(eval_gettext "Could not move back to \$head_name")"
 		;;
 	esac
 	output git reset --hard $orig_head
@@ -367,15 +368,18 @@ esac
 # Make sure no rebase is in progress
 if test -n "$in_progress"
 then
-	die '
-It seems that there is already a '"${state_dir##*/}"' directory, and
-I wonder if you are in the middle of another rebase.  If that is the
+	state_dir_base=${state_dir##*/}
+	cmd_live_rebase="git rebase (--continue | --abort | --skip)"
+	cmd_clear_stale_rebase="rm -fr \"$state_dir\""
+	die "
+$(eval_gettext 'It seems that there is already a $state_dir_base directory, and
+I wonder if you ware in the middle of another rebase.  If that is the
 case, please try
-	git rebase (--continue | --abort | --skip)
+	$cmd_live_rebase
 If that is not the case, please
-	rm -fr '"$state_dir"'
+	$cmd_clear_stale_rebase
 and run me again.  I am stopping in case you still have something
-valuable there.'
+valuable there.')"
 fi
 
 if test -n "$rebase_root" && test -z "$onto"
@@ -413,7 +417,7 @@ then
 		;;
 	esac
 	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
-	die "invalid upstream $upstream_name"
+	die "$(eval_gettext "invalid upstream \$upstream_name")"
 	upstream_arg="$upstream_name"
 else
 	if test -z "$onto"
@@ -437,19 +441,19 @@ case "$onto_name" in
 	then
 		case "$onto" in
 		?*"$LF"?*)
-			die "$onto_name: there are more than one merge bases"
+			die "$(eval_gettext "\$onto_name: there are more than one merge bases")"
 			;;
 		'')
-			die "$onto_name: there is no merge base"
+			die "$(eval_gettext "\$onto_name: there is no merge base")"
 			;;
 		esac
 	else
-		die "$onto_name: there is no merge base"
+		die "$(eval_gettext "\$onto_name: there is no merge base")"
 	fi
 	;;
 *)
 	onto=$(git rev-parse --verify "${onto_name}^0") ||
-	die "Does not point to a valid commit: $onto_name"
+	die "$(eval_gettext "Does not point to a valid commit: \$onto_name")"
 	;;
 esac
 
@@ -472,7 +476,7 @@ case "$#" in
 	then
 		head_name="detached HEAD"
 	else
-		die "fatal: no such branch: $1"
+		die "$(eval_gettext "fatal: no such branch: \$branch_name")"
 	fi
 	;;
 0)
@@ -492,7 +496,7 @@ case "$#" in
 	;;
 esac
 
-require_clean_work_tree "rebase" "Please commit or stash them."
+require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
 
 # Now we are rebasing commits $upstream..$orig_head (or with --root,
 # everything leading up to $orig_head) on top of $onto
@@ -510,10 +514,10 @@ then
 	then
 		# Lazily switch to the target branch if needed...
 		test -z "$switch_to" || git checkout "$switch_to" --
-		say "Current branch $branch_name is up to date."
+		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
 		exit 0
 	else
-		say "Current branch $branch_name is up to date, rebase forced."
+		say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
 	fi
 fi
 
@@ -524,7 +528,7 @@ if test -n "$diffstat"
 then
 	if test -n "$verbose"
 	then
-		echo "Changes from $mb to $onto:"
+		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
 	fi
 	# We want color (if set), but no pager
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
@@ -533,7 +537,7 @@ fi
 test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
-say "First, rewinding head to replay your work on top of it..."
+say "$(gettext "First, rewinding head to replay your work on top of it...")"
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
@@ -541,7 +545,7 @@ git update-ref ORIG_HEAD $orig_head
 # we just fast-forwarded.
 if test "$mb" = "$orig_head"
 then
-	say "Fast-forwarded $branch_name to $onto_name."
+	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
 	move_to_original_branch
 	exit 0
 fi
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.sh
index 52b1c..5d80a 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -51,16 +51,16 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate v
 test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate variables with spaces' '
     cmdline="git am" &&
     export cmdline;
-    printf "When you have resolved this problem run git am --resolved." >expect &&
-    eval_gettext "When you have resolved this problem run \$cmdline --resolved." >actual
+    printf "When you have resolved this problem, run git am --resolved." >expect &&
+    eval_gettext "When you have resolved this problem, run \$cmdline --resolved." >actual
     test_i18ncmp expect actual
 '
 
 test_expect_success 'eval_gettext: our eval_gettext() fallback can interpolate variables with spaces and quotes' '
     cmdline="git am" &&
     export cmdline;
-    printf "When you have resolved this problem run \"git am --resolved\"." >expect &&
-    eval_gettext "When you have resolved this problem run \"\$cmdline --resolved\"." >actual
+    printf "When you have resolved this problem, run \"git am --resolved\"." >expect &&
+    eval_gettext "When you have resolved this problem, run \"\$cmdline --resolved\"." >actual
     test_i18ncmp expect actual
 '
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 7788a..1de0e 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -68,24 +68,24 @@ test_expect_success 'rebase against master' '
 
 test_expect_success 'rebase against master twice' '
 	git rebase master >out &&
-	grep "Current branch my-topic-branch is up to date" out
+	test_i18ngrep "Current branch my-topic-branch is up to date" out
 '
 
 test_expect_success 'rebase against master twice with --force' '
 	git rebase --force-rebase master >out &&
-	grep "Current branch my-topic-branch is up to date, rebase forced" out
+	test_i18ngrep "Current branch my-topic-branch is up to date, rebase forced" out
 '
 
 test_expect_success 'rebase against master twice from another branch' '
 	git checkout my-topic-branch^ &&
 	git rebase master my-topic-branch >out &&
-	grep "Current branch my-topic-branch is up to date" out
+	test_i18ngrep "Current branch my-topic-branch is up to date" out
 '
 
 test_expect_success 'rebase fast-forward to master' '
 	git checkout my-topic-branch^ &&
 	git rebase my-topic-branch >out &&
-	grep "Fast-forwarded HEAD to my-topic-branch" out
+	test_i18ngrep "Fast-forwarded HEAD to my-topic-branch" out
 '
 
 test_expect_success 'the rebase operation should not have destroyed author information' '
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 68983..e6a9a 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -62,9 +62,16 @@ test_expect_success 'rebase -n overrides config rebase.stat config' '
         ! grep "^ fileX |  *1 +$" diffstat.txt
 '
 
+# Output to stderr:
+#
+#     "Does not point to a valid commit: invalid-ref"
+#
+# NEEDSWORK: This "grep" is fine in real non-C locales, but
+# GETTEXT_POISON poisons the refname along with the enclosing
+# error message.
 test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
-	grep "invalid-ref" err
+	test_i18ngrep "invalid-ref" err
 '
 
 test_done
-- 
1.7.12.rc0.16.gf4916ac
