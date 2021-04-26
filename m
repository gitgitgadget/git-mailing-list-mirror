Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5822C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DD0600D1
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhDZRsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:48:36 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:39098 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237545AbhDZRs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:48:26 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id B731680590;
        Mon, 26 Apr 2021 13:47:43 -0400 (EDT)
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
Subject: [PATCH v2 09/30] subtree: t7900: rename last_commit_message to last_commit_subject
Date:   Mon, 26 Apr 2021 11:45:04 -0600
Message-Id: <20210426174525.3937858-10-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174525.3937858-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210426174525.3937858-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

t7900-subtree.sh defines a helper function named last_commit_message.
However, it only returns the subject line of the commit message, not the
entire commit message.  So rename it, to make the name less confusing.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/t/t7900-subtree.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 1c717fcb96..5c2510f1f5 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -33,7 +33,7 @@ test_create_commit () (
 	git commit -m "$commit" || error "Could not commit"
 )
 
-last_commit_message () {
+last_commit_subject () {
 	git log --pretty=format:%s -1
 }
 
@@ -74,7 +74,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --prefix' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" FETCH_HEAD &&
-		test "$(last_commit_message)" = "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
+		test "$(last_commit_subject)" = "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
@@ -87,7 +87,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --prefix and --me
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" --message="Added subproject" FETCH_HEAD &&
-		test "$(last_commit_message)" = "Added subproject"
+		test "$(last_commit_subject)" = "Added subproject"
 	)
 '
 
@@ -100,7 +100,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --prefix as -P an
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add -P "sub dir" -m "Added subproject" FETCH_HEAD &&
-		test "$(last_commit_message)" = "Added subproject"
+		test "$(last_commit_subject)" = "Added subproject"
 	)
 '
 
@@ -113,7 +113,7 @@ test_expect_success 'add subproj as subtree into sub dir/ with --squash and --pr
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree add --prefix="sub dir" --message="Added subproject with squash" --squash FETCH_HEAD &&
-		test "$(last_commit_message)" = "Added subproject with squash"
+		test "$(last_commit_subject)" = "Added subproject with squash"
 	)
 '
 
@@ -136,7 +136,7 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix' '
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		test "$(last_commit_message)" = "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+		test "$(last_commit_subject)" = "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
@@ -155,7 +155,7 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix and -
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" --message="Merged changes from subproject" FETCH_HEAD &&
-		test "$(last_commit_message)" = "Merged changes from subproject"
+		test "$(last_commit_subject)" = "Merged changes from subproject"
 	)
 '
 
@@ -174,7 +174,7 @@ test_expect_success 'merge new subproj history into sub dir/ with --squash and -
 		cd "$test_count" &&
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" --message="Merged changes from subproject using squash" --squash FETCH_HEAD &&
-		test "$(last_commit_message)" = "Merged changes from subproject using squash"
+		test "$(last_commit_subject)" = "Merged changes from subproject using squash"
 	)
 '
 
@@ -209,7 +209,7 @@ test_expect_success 'merge new subproj history into subdir/ with a slash appende
 		cd "$test_count" &&
 		git fetch ./subproj HEAD &&
 		git subtree merge --prefix=subdir/ FETCH_HEAD &&
-		test "$(last_commit_message)" = "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+		test "$(last_commit_subject)" = "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
@@ -275,7 +275,7 @@ test_expect_success 'split sub dir/ with --rejoin' '
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
 		git subtree split --prefix="sub dir" --annotate="*" --rejoin &&
-		test "$(last_commit_message)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
+		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
 	)
 '
 
@@ -290,7 +290,7 @@ test_expect_success 'split sub dir/ with --rejoin from scratch' '
 		git commit -m"sub dir file" &&
 		split_hash=$(git subtree split --prefix="sub dir" --rejoin) &&
 		git subtree split --prefix="sub dir" --rejoin &&
-		test "$(last_commit_message)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
+		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
 	)
 '
 
@@ -313,7 +313,7 @@ test_expect_success 'split sub dir/ with --rejoin and --message' '
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		git subtree split --prefix="sub dir" --message="Split & rejoin" --annotate="*" --rejoin &&
-		test "$(last_commit_message)" = "Split & rejoin"
+		test "$(last_commit_subject)" = "Split & rejoin"
 	)
 '
 
@@ -878,7 +878,7 @@ test_expect_success 'push split to subproj' '
 		git subtree push ./"sub proj" --prefix "sub dir" sub-branch-1 &&
 		cd ./"sub proj" &&
 		git checkout sub-branch-1 &&
-		test "$(last_commit_message)" = "sub dir/main-sub3"
+		test "$(last_commit_subject)" = "sub dir/main-sub3"
 	)
 '
 
-- 
2.31.1

