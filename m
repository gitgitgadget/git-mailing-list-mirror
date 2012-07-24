From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 2/7] i18n: rebase: mark strings for translation
Date: Tue, 24 Jul 2012 14:59:30 +0800
Message-ID: <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:00:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StZ6R-0001di-9a
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 09:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab2GXHAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 03:00:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59967 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2GXHAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 03:00:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so12207178pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 00:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=U5LS+vOdGeE4Mmjirgdgzg62wv4Uuq9gxwfyfYluYqI=;
        b=kbljyR+ap02b0XIDF7gVWHrEMmstrEg5AtBRxBviFljUMCGuu8gvenDGw1C9TUZK87
         2jVgaxI4oZFTH2YaPlC6kZR2qAFC8W46desa1DJqPjWtG+3FUgQA2DWA+6XMygAogwix
         tPZSEy1xdhrMGQG/BBPPk3XSOLvLz+THGAtPCNSlCGLgHdknEneQq+jSNkOIv/mDoe65
         XmrfxNAny+a0XnDsJNdMfbpjK3Nnl47k1lsbsmL7CVFZ7aHet+Hk5mDMpjyRFwPkMth7
         KQiqurTpHHnvILyliU3qEOVqCFhIr5cb6TRMgtGsYVlroGwu/Ooxj2zdE/UCQx4KKyqv
         W28Q==
Received: by 10.68.231.39 with SMTP id td7mr42231364pbc.3.1343113208421;
        Tue, 24 Jul 2012 00:00:08 -0700 (PDT)
Received: from jx.bj.ossxp.com.bj.ossxp.com ([123.116.228.123])
        by mx.google.com with ESMTPS id tj4sm11577579pbc.33.2012.07.24.00.00.02
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 00:00:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.17.gcb766d3
In-Reply-To: <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202012>

Mark strings in git-rebase.sh for translation.

Some test scripts are affected by this update, and would fail if are
tested with GETTEXT_POISON switch turned on. Use i18n-specific test
functions, such as test_i18ngrep in the related test scripts will fix
these issues.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 git-rebase.sh             | 62 ++++++++++++++++++++++++-----------------------
 t/t3400-rebase.sh         |  8 +++---
 t/t3406-rebase-message.sh |  2 +-
 3 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1cd06..f07269 100755
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
@@ -72,11 +73,11 @@ cd_to_toplevel
 LF='
 '
 ok_to_skip_pre_rebase=
-resolvemsg="
-When you have resolved this problem run \"git rebase --continue\".
-If you would prefer to skip this patch, instead run \"git rebase --skip\".
-To check out the original branch and stop rebasing run \"git rebase --abort\".
-"
+resolvemsg=$(gettext '
+When you have resolved this problem run "git rebase --continue".
+If you would prefer to skip this patch, instead run "git rebase --skip".
+To check out the original branch and stop rebasing run "git rebase --abort".
+')
 unset onto
 cmd=
 strategy=
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
@@ -367,15 +368,16 @@ esac
 # Make sure no rebase is in progress
 if test -n "$in_progress"
 then
-	die '
-It seems that there is already a '"${state_dir##*/}"' directory, and
+	state_dir_base=${state_dir##*/}
+	die "$(eval_gettext "
+It seems that there is already a \$state_dir_base directory, and
 I wonder if you are in the middle of another rebase.  If that is the
 case, please try
 	git rebase (--continue | --abort | --skip)
 If that is not the case, please
-	rm -fr '"$state_dir"'
+	rm -fr \"\$state_dir\"
 and run me again.  I am stopping in case you still have something
-valuable there.'
+valuable there.")"
 fi
 
 if test -n "$rebase_root" && test -z "$onto"
@@ -413,7 +415,7 @@ then
 		;;
 	esac
 	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
-	die "invalid upstream $upstream_name"
+	die "$(eval_gettext "invalid upstream \$upstream_name")"
 	upstream_arg="$upstream_name"
 else
 	if test -z "$onto"
@@ -437,19 +439,19 @@ case "$onto_name" in
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
 
@@ -472,7 +474,7 @@ case "$#" in
 	then
 		head_name="detached HEAD"
 	else
-		die "fatal: no such branch: $1"
+		die "$(eval_gettext "fatal: no such branch: \$branch_name")"
 	fi
 	;;
 0)
@@ -492,7 +494,7 @@ case "$#" in
 	;;
 esac
 
-require_clean_work_tree "rebase" "Please commit or stash them."
+require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
 
 # Now we are rebasing commits $upstream..$orig_head (or with --root,
 # everything leading up to $orig_head) on top of $onto
@@ -510,10 +512,10 @@ then
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
 
@@ -524,7 +526,7 @@ if test -n "$diffstat"
 then
 	if test -n "$verbose"
 	then
-		echo "Changes from $mb to $onto:"
+		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
 	fi
 	# We want color (if set), but no pager
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
@@ -533,7 +535,7 @@ fi
 test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
-say "First, rewinding head to replay your work on top of it..."
+say "$(gettext "First, rewinding head to replay your work on top of it...")"
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
@@ -541,7 +543,7 @@ git update-ref ORIG_HEAD $orig_head
 # we just fast-forwarded.
 if test "$mb" = "$orig_head"
 then
-	say "Fast-forwarded $branch_name to $onto_name."
+	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
 	move_to_original_branch
 	exit 0
 fi
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
index 68983..6eb28 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -64,7 +64,7 @@ test_expect_success 'rebase -n overrides config rebase.stat config' '
 
 test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
-	grep "invalid-ref" err
+	test_i18ngrep "invalid-ref" err
 '
 
 test_done
-- 
1.7.12.rc0.17.gcb766d3
