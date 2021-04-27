Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD60C43460
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B0613B1
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhD0VTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:14 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:41448 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239132AbhD0VTH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:07 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 16A5780591;
        Tue, 27 Apr 2021 17:18:23 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v3 04/30] subtree: t7900: use consistent formatting
Date:   Tue, 27 Apr 2021 15:17:22 -0600
Message-Id: <20210427211748.2607474-5-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427211748.2607474-1-lukeshu@lukeshu.com>
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

The formatting in t7900-subtree.sh isn't even consistent throughout the
file.  Fix that; make it consistent throughout the file.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - Also normalize on `test X` instead of `[ X ]`.
 - Also normalize on `>FILENAME` with no spaces.
 - Fix a few if statements with `if` and `then` on the same line
   that I missed in v1.
v3:
 - Consistently put the `do` of a loop on its own line.

 contrib/subtree/t/t7900-subtree.sh | 70 +++++++++++++++---------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index a6351d9195..2319c3fd1c 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -11,11 +11,9 @@ and split subcommands of git subtree.
 
 TEST_DIRECTORY=$(pwd)/../../../t
 export TEST_DIRECTORY
+. "$TEST_DIRECTORY"/test-lib.sh
 
-. ../../../t/test-lib.sh
-
-subtree_test_create_repo()
-{
+subtree_test_create_repo () {
 	test_create_repo "$1" &&
 	(
 		cd "$1" &&
@@ -23,26 +21,24 @@ subtree_test_create_repo()
 	)
 }
 
-create()
-{
+create () {
 	echo "$1" >"$1" &&
 	git add "$1"
 }
 
-check_equal()
-{
+check_equal () {
 	test_debug 'echo'
 	test_debug "echo \"check a:\" \"{$1}\""
 	test_debug "echo \"      b:\" \"{$2}\""
-	if [ "$1" = "$2" ]; then
+	if test "$1" = "$2"
+	then
 		return 0
 	else
 		return 1
 	fi
 }
 
-undo()
-{
+undo () {
 	git reset --hard HEAD~
 }
 
@@ -50,15 +46,18 @@ undo()
 # The original set of commits changed only one file each.
 # A multi-file change would imply that we pruned commits
 # too aggressively.
-join_commits()
-{
+join_commits () {
 	commit=
 	all=
-	while read x y; do
-		if [ -z "$x" ]; then
+	while read x y
+	do
+		if test -z "$x"
+		then
 			continue
-		elif [ "$x" = "commit:" ]; then
-			if [ -n "$commit" ]; then
+		elif test "$x" = "commit:"
+		then
+			if test -n "$commit"
+			then
 				echo "$commit $all"
 				all=
 			fi
@@ -70,7 +69,7 @@ join_commits()
 	echo "$commit $all"
 }
 
-test_create_commit() (
+test_create_commit () (
 	repo=$1 &&
 	commit=$2 &&
 	cd "$repo" &&
@@ -81,8 +80,7 @@ test_create_commit() (
 	git commit -m "$commit" || error "Could not commit"
 )
 
-last_commit_message()
-{
+last_commit_message () {
 	git log --pretty=format:%s -1
 }
 
@@ -111,7 +109,8 @@ test_expect_success 'no pull from non-existent subtree' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		test_must_fail git subtree pull --prefix="sub dir" ./"sub proj" HEAD
-	)'
+	)
+'
 
 test_expect_success 'add subproj as subtree into sub dir/ with --prefix' '
 	subtree_test_create_repo "$test_count" &&
@@ -274,8 +273,8 @@ test_expect_success 'split requires option --prefix' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
-		echo "You must provide the --prefix option." > expected &&
-		test_must_fail git subtree split > actual 2>&1 &&
+		echo "You must provide the --prefix option." >expected &&
+		test_must_fail git subtree split >actual 2>&1 &&
 		test_debug "printf '"expected: "'" &&
 		test_debug "cat expected" &&
 		test_debug "printf '"actual: "'" &&
@@ -293,8 +292,8 @@ test_expect_success 'split requires path given by option --prefix must exist' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
-		echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" > expected &&
-		test_must_fail git subtree split --prefix=non-existent-directory > actual 2>&1 &&
+		echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" >expected &&
+		test_must_fail git subtree split --prefix=non-existent-directory >actual 2>&1 &&
 		test_debug "printf '"expected: "'" &&
 		test_debug "cat expected" &&
 		test_debug "printf '"actual: "'" &&
@@ -325,7 +324,7 @@ test_expect_success 'split sub dir/ with --rejoin' '
 		git subtree split --prefix="sub dir" --annotate="*" --rejoin &&
 		check_equal "$(last_commit_message)" "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
 	)
- '
+'
 
 test_expect_success 'split sub dir/ with --rejoin from scratch' '
 	subtree_test_create_repo "$test_count" &&
@@ -340,7 +339,7 @@ test_expect_success 'split sub dir/ with --rejoin from scratch' '
 		git subtree split --prefix="sub dir" --rejoin &&
 		check_equal "$(last_commit_message)" "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
 	)
- '
+'
 
 test_expect_success 'split sub dir/ with --rejoin and --message' '
 	subtree_test_create_repo "$test_count" &&
@@ -893,7 +892,8 @@ test_expect_success 'verify one file change per commit' '
 		x= &&
 		git log --pretty=format:"commit: %H" | join_commits |
 		(
-			while read commit a b; do
+			while read commit a b
+			do
 				test_debug "echo Verifying commit $commit"
 				test_debug "echo a: $a"
 				test_debug "echo b: $b"
@@ -921,18 +921,18 @@ test_expect_success 'push split to subproj' '
 	test_create_commit "$test_count" "sub dir"/main-sub2 &&
 	(
 		cd $test_count/"sub proj" &&
-                git branch sub-branch-1 &&
-                cd .. &&
+		git branch sub-branch-1 &&
+		cd .. &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD
 	) &&
 	test_create_commit "$test_count" "sub dir"/main-sub3 &&
-        (
+	(
 		cd "$test_count" &&
-	        git subtree push ./"sub proj" --prefix "sub dir" sub-branch-1 &&
-                cd ./"sub proj" &&
-                git checkout sub-branch-1 &&
-         	check_equal "$(last_commit_message)" "sub dir/main-sub3"
+		git subtree push ./"sub proj" --prefix "sub dir" sub-branch-1 &&
+		cd ./"sub proj" &&
+		git checkout sub-branch-1 &&
+		check_equal "$(last_commit_message)" "sub dir/main-sub3"
 	)
 '
 
-- 
2.31.1

