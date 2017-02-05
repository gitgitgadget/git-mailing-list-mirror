Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758521FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 20:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbdBEU03 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 15:26:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35899 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753023AbdBEU0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 15:26:24 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so17898964wmd.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+dPmb+1U2htUf1CGO2PpNhcvM876JHmGGgjR8xATg4=;
        b=eG4pSCbdt60/rJXP+ffGKMRgK4A65sKhZJBWnNp/UABD+8+EM2fkG/OCC1qph0clgR
         swTpJEMJlcQY54ssT7u3Z5/trHrYQeFnX7MqMUSYEHNL/zym5y0VPbPPstQ3Z/J/0eny
         scDFMzjVb/MymdLxe/8KzVTsfcxu6HMJP3oHwmRzvLwgaPBatm+IUQftEUTr1E7vYCYL
         JzKI7/YVvxnfmgi85tO9fIktUjrtawzIJI8q8hAwFf7XEhYHl1TPWQu77Y6LbFzqaFiF
         GrmlaNhLlJ53L40Kv7oKgyQghsjFH2RTGfEgFv3z4AJmhFfft50vY75zOKTwNbsU2Xe1
         sc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+dPmb+1U2htUf1CGO2PpNhcvM876JHmGGgjR8xATg4=;
        b=s+FBg2lJiwyuVFAU8eUiOT2gDN1RbTjz3UIlYeTreZ8C4O/HBtzi65pnlHHcdeHZDI
         c0glFOwONeF27xDda3a7CIDer+z67nVysM5CJ2t9MeEPj0BAm14wekwwRq+4HVTVggsB
         35gJi4sJl/8DH0O/bHliCXlcuClCyb1eK3r5/KI6fxDwybtctkFXv7WqXZFcSaYYO3fi
         CjyNE6aedtJA+CC8I3GbdbHmSIgvFfQU2ytSwxxy6q6gX1PecWJTOI0snliA4aVvjkz7
         kcItsHvm4qwJxn/af8EGABp4ykqpDZv4W/lX2YRh0LkeOsNkW0aIRkZXk7AswHHKpXVa
         iWsA==
X-Gm-Message-State: AMke39lLdfYZufNl1x+GaSpD6ARkiIwhA7eyu7EE0uHf87+jto7NlxB+KFSpVUXYzoQhrg==
X-Received: by 10.28.173.140 with SMTP id w134mr5553268wme.56.1486326377621;
        Sun, 05 Feb 2017 12:26:17 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 186sm8974169wmw.24.2017.02.05.12.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 12:26:16 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/5] stash: support pathspec argument
Date:   Sun,  5 Feb 2017 20:26:37 +0000
Message-Id: <20170205202642.14216-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc0.208.g81c5d00b20.dirty
In-Reply-To: <20170129201604.30445-1-t.gummerer@gmail.com>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio for the review in the previous round.

Changes since v2:

- $IFS should now be supported by using "$@" everywhere instead of using
  a $files variable.
- Added a new patch showing the old behaviour of git stash create is
  preserved.
- Rephrased the documentation
- Simplified the option parsing in save_stash, by leaving the
  actual parsing to push_stash instead.

Interdiff below:

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 8306bac397..be55e456fa 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
-	     [--] [<paths>...]
+	     [--] [<pathspec>...]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
@@ -51,19 +51,21 @@ OPTIONS
 -------
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
-push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<paths>...]::
+push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash' and roll them
-	back both in the working tree and in the index.
+	back to HEAD (in the working tree and in the index).
 	The <message> part is optional and gives
 	the description along with the stashed state.  For quickly making
 	a snapshot, you can omit _both_ "save" and <message>, but giving
 	only <message> does not trigger this action to prevent a misspelled
 	subcommand from making an unwanted stash.
 +
-If the paths argument is given in 'git stash push', only these files
-are put in the new 'stash'.  In addition only the indicated files are
-changed in the working tree to match the index.
+When pathspec is given to 'git stash push', the new stash records the
+modified states only for the files that match the pathspec.  The index
+entries and working tree files are then rolled back to the state in
+HEAD only for these files, too, leaving files that do not match the
+pathspec intact.
 +
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
diff --git a/git-stash.sh b/git-stash.sh
index 0072a38b4c..46367d40aa 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -41,7 +41,7 @@ no_changes () {
 untracked_files () {
 	excl_opt=--exclude-standard
 	test "$untracked" = "all" && excl_opt=
-	git ls-files -o -z $excl_opt -- $1
+	git ls-files -o -z $excl_opt -- "$@"
 }
 
 clear_stash () {
@@ -59,13 +59,12 @@ create_stash () {
 	stash_msg=
 	untracked=
 	new_style=
-	files=
 	while test $# != 0
 	do
 		case "$1" in
 		-m|--message)
 			shift
-			stash_msg="$1"
+			stash_msg=${1?"-m needs an argument"}
 			new_style=t
 			;;
 		-u|--include-untracked)
@@ -75,7 +74,6 @@ create_stash () {
 			;;
 		--)
 			shift
-			files="$@"
 			new_style=t
 			break
 			;;
@@ -106,6 +104,10 @@ create_stash () {
 	if test -z "$new_style"
 	then
 		stash_msg="$*"
+		while test $# != 0
+		do
+			shift
+		done
 	fi
 
 	git update-index -q --refresh
@@ -141,7 +143,7 @@ create_stash () {
 		# Untracked files are stored by themselves in a parentless commit, for
 		# ease of unpacking later.
 		u_commit=$(
-			untracked_files $files | (
+			untracked_files "$@" | (
 				GIT_INDEX_FILE="$TMPindex" &&
 				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
@@ -164,7 +166,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- $files >"$TMP-stagenames" &&
+			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
@@ -178,7 +180,7 @@ create_stash () {
 
 		# find out what the user wants
 		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- $files &&
+			git add--interactive --patch=stash -- "$@" &&
 
 		# state of the working tree
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
@@ -268,7 +270,7 @@ push_stash () {
 			;;
 		-m|--message)
 			shift
-			stash_msg=$1
+			stash_msg=${1?"-m needs an argument"}
 			;;
 		--help)
 			show_help
@@ -300,8 +302,6 @@ push_stash () {
 		shift
 	done
 
-	files="$*"
-
 	if test -n "$patch_mode" && test -n "$untracked"
 	then
 		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
@@ -316,14 +316,14 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash -m "$stash_msg" -u "$untracked" -- $files
+	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
 	if test -z "$patch_mode"
 	then
-		if test -n "$files"
+		if test $# != 0
 		then
 			git ls-files -z -- "$@" | xargs -0 git reset --
 			git ls-files -z --modified -- "$@" | xargs -0 git checkout HEAD --
@@ -334,7 +334,7 @@ push_stash () {
 		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
 		if test -n "$untracked"
 		then
-			git clean --force --quiet -d $CLEAN_X_OPTION -- $files
+			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
 		fi
 
 		if test "$keep_index" = "t" && test -n "$i_tree"
@@ -357,24 +357,6 @@ save_stash () {
 	while test $# != 0
 	do
 		case "$1" in
-		-k|--keep-index)
-			push_options="-k $push_options"
-			;;
-		--no-keep-index)
-			push_options="--no-keep-index $push_options"
-			;;
-		-p|--patch)
-			push_options="-p $push_options"
-			;;
-		-q|--quiet)
-			push_options="-q $push_options"
-			;;
-		-u|--include-untracked)
-			push_options="-u $push_options"
-			;;
-		-a|--all)
-			push_options="-a $push_options"
-			;;
 		--help)
 			show_help
 			;;
@@ -383,20 +365,8 @@ save_stash () {
 			break
 			;;
 		-*)
-			option="$1"
-			# TRANSLATORS: $option is an invalid option, like
-			# `--blah-blah'. The 7 spaces at the beginning of the
-			# second line correspond to "error: ". So you should line
-			# up the second line with however many characters the
-			# translation of "error: " takes in your language. E.g. in
-			# English this is:
-			#
-			#    $ git stash save --blah-blah 2>&1 | head -n 2
-			#    error: unknown option for 'stash save': --blah-blah
-			#           To provide a message, use git stash save -- '--blah-blah'
-			eval_gettextln "error: unknown option for 'stash save': \$option
-       To provide a message, use git stash save -- '\$option'"
-			usage
+			# pass all options through to push_stash
+			push_options="$push_options $1"
 			;;
 		*)
 			break
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ca4c44aa9c..461fe46045 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -784,7 +784,7 @@ test_expect_success 'push -m shows right message' '
 	test_cmp expect actual
 '
 
-test_expect_success 'deprecated version of stash create stores correct message' '
+test_expect_success 'create stores correct message' '
 	>foo &&
 	git add foo &&
 	STASH_ID=$(git stash create "create test message") &&
@@ -793,6 +793,15 @@ test_expect_success 'deprecated version of stash create stores correct message'
 	test_cmp expect actual
 '
 
+test_expect_success 'create with multiple arguments for the message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create test untracked) &&
+	echo "On master: test untracked" >expect &&
+	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'new style stash create stores correct message' '
 	>foo &&
 	git add foo &&
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index f372fc8ca8..9a98e31a3e 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -185,4 +185,30 @@ test_expect_success 'stash save --all is stash poppable' '
 	test -s .gitignore
 '
 
+test_expect_success 'stash push --include-untracked with pathspec' '
+	>foo &&
+	>bar &&
+	git stash push --include-untracked -- foo &&
+	test_path_is_file bar &&
+	test_path_is_missing foo &&
+	git stash pop &&
+	test_path_is_file bar &&
+	test_path_is_file foo
+'
+
+test_expect_success 'stash push with $IFS character' '
+	>"foo	bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash push --include-untracked -- foo* &&
+	test_path_is_missing "foo	bar" &&
+	test_path_is_missing foo &&
+	test_path_is_file bar &&
+	git stash pop &&
+	test_path_is_file "foo	bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_done

Thomas Gummerer (5):
  Documentation/stash: remove mention of git reset --hard
  stash: introduce push verb
  stash: add test for the create command line arguments
  stash: introduce new format create
  stash: teach 'push' (and 'create') to honor pathspec

 Documentation/git-stash.txt        |  17 ++++-
 git-stash.sh                       | 124 +++++++++++++++++++++++++++++++++----
 t/t3903-stash.sh                   |  78 +++++++++++++++++++++++
 t/t3905-stash-include-untracked.sh |  26 ++++++++
 4 files changed, 230 insertions(+), 15 deletions(-)

-- 
2.12.0.rc0.208.g81c5d00b20.dirty

