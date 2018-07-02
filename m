Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531EA1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753020AbeGBAZe (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38558 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeGBAZM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:12 -0400
Received: by mail-it0-f67.google.com with SMTP id v83-v6so9852006itc.3
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6j5dHkLBwrdVvwrsoLeBmTxTHKAVWUTofQxOwYnHYcQ=;
        b=bmfn0W0zj1aJadtCwXxAN57TmIvM85VfbS6gFKYKgf6ujIOoE/W5c7D/olbgo5Q7HU
         E0SUfzVXWRq85yTzx5thcWbcaqbb69+pCYGdFykKnLUXsMgZxqZuadhgfTXGZGh5LlLW
         cPgeXEnPnBr1lHNKR3qwRnnp590xMoCihKRLaJ3j2DjDnIlIwed5woiE9i7l7WJWTbeA
         nJxtOcOXW0RRfSSep8rNnTQCeFQJGhZG+fgtN0AjnaAZjixp/eLiSJLuPNSEEgfe+NqR
         AbCQ+Hl46QU/O1hLf73lKmJjHexZllt3+HKRLWv2DVrio7TbMJaQ2nmU1EzW41OuBnTH
         Pacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=6j5dHkLBwrdVvwrsoLeBmTxTHKAVWUTofQxOwYnHYcQ=;
        b=U/jz7Ue6mz8ElIBg5FiEUEKLHKb6RIX+iq+C5ydKr7TsFvpbNVVZjvMRhdAkR64Dmf
         pHG82RQJk8wmEPlT5vZhNUEKV9o6TMBxjRz0gYOrVWtMApyKqFF2rEk/dlSzbHx4nJt8
         lmr/E3w+ms+0rUQw9Ju5lyY3kyxS5zKoS5IIwvn45xDBSIhTQbFE+svQzFWTQz6U7vli
         4hmbI/QSaUDbr0wVXPR0X+stfpewqmtxj9R6Kr4wiyL93z0deEUuewZPheM7KhacAaP4
         0ON+z5bkCIzweNouV2j57RMEnIi45/PwWge4XPSwt2fqGLd8oad2VpF/RFeXZMR2+wPO
         qDeg==
X-Gm-Message-State: APt69E2z0vLJMVRmadM0cPBMFASnrvYhbTwEhJYszjxV0MNEg6vx5V/1
        uzXUwAmd+sratgeZA/Y0Q4mwpw==
X-Google-Smtp-Source: AAOMgpc60/x1RPEhepEod9eufhgC2U6fBO8kNKMfKekj82WGRGn68wGdAoeVHlR2Hkma4O6oBGaFRw==
X-Received: by 2002:a24:cb83:: with SMTP id u125-v6mr8583754itg.76.1530491111710;
        Sun, 01 Jul 2018 17:25:11 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:11 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 23/25] t7000-t7999: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:24:03 -0400
Message-Id: <20180702002405.3042-24-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7001-mv.sh                  |  2 +-
 t/t7201-co.sh                  | 40 +++++++++++++-------------
 t/t7400-submodule-basic.sh     |  2 +-
 t/t7406-submodule-update.sh    |  6 ++--
 t/t7408-submodule-reference.sh |  2 +-
 t/t7501-commit.sh              | 52 +++++++++++++++++-----------------
 t/t7506-status-submodule.sh    | 10 +++----
 7 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index cc3fd2baf2..9e59e5a5dd 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -509,7 +509,7 @@ test_expect_success 'moving nested submodules' '
 		touch nested_level1 &&
 		git init &&
 		git add . &&
-		git commit -m "nested level 1"
+		git commit -m "nested level 1" &&
 		git submodule add ../sub_nested_nested &&
 		git commit -m "add nested level 2"
 	) &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 8d8a63a24b..94cb039a03 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -528,10 +528,10 @@ test_expect_success 'checkout with --merge' '
 	cat sample >filf &&
 	git checkout -m -- fild file filf &&
 	(
-		echo "<<<<<<< ours"
-		echo ourside
-		echo "======="
-		echo theirside
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "=======" &&
+		echo theirside &&
 		echo ">>>>>>> theirs"
 	) >merged &&
 	test_cmp expect fild &&
@@ -549,12 +549,12 @@ test_expect_success 'checkout with --merge, in diff3 -m style' '
 	cat sample >filf &&
 	git checkout -m -- fild file filf &&
 	(
-		echo "<<<<<<< ours"
-		echo ourside
-		echo "||||||| base"
-		echo original
-		echo "======="
-		echo theirside
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "||||||| base" &&
+		echo original &&
+		echo "=======" &&
+		echo theirside &&
 		echo ">>>>>>> theirs"
 	) >merged &&
 	test_cmp expect fild &&
@@ -572,10 +572,10 @@ test_expect_success 'checkout --conflict=merge, overriding config' '
 	cat sample >filf &&
 	git checkout --conflict=merge -- fild file filf &&
 	(
-		echo "<<<<<<< ours"
-		echo ourside
-		echo "======="
-		echo theirside
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "=======" &&
+		echo theirside &&
 		echo ">>>>>>> theirs"
 	) >merged &&
 	test_cmp expect fild &&
@@ -593,12 +593,12 @@ test_expect_success 'checkout --conflict=diff3' '
 	cat sample >filf &&
 	git checkout --conflict=diff3 -- fild file filf &&
 	(
-		echo "<<<<<<< ours"
-		echo ourside
-		echo "||||||| base"
-		echo original
-		echo "======="
-		echo theirside
+		echo "<<<<<<< ours" &&
+		echo ourside &&
+		echo "||||||| base" &&
+		echo original &&
+		echo "=======" &&
+		echo theirside &&
 		echo ">>>>>>> theirs"
 	) >merged &&
 	test_cmp expect fild &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 401adaed32..76cf522a08 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -818,7 +818,7 @@ test_expect_success '../bar/a/b/c works with relative local path - ../foo/bar.gi
 		cp pristine-.git-config .git/config &&
 		cp pristine-.gitmodules .gitmodules &&
 		mkdir -p a/b/c &&
-		(cd a/b/c; git init) &&
+		(cd a/b/c && git init) &&
 		git config remote.origin.url ../foo/bar.git &&
 		git submodule add ../bar/a/b/c ./a/b/c &&
 		git submodule init &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 9e0d31700e..f604ef7a72 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -865,9 +865,9 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	 (cd submodule/subsubmodule &&
 	  git log > ../../expected
 	 ) &&
-	 (cd .git/modules/submodule/modules/subsubmodule
+	 (cd .git/modules/submodule/modules/subsubmodule &&
 	  git log > ../../../../../actual
-	 )
+	 ) &&
 	 test_cmp actual expected
 	)
 '
@@ -886,7 +886,7 @@ test_expect_success 'submodule update properly revives a moved submodule' '
 	 git commit -am "pre move" &&
 	 H2=$(git rev-parse --short HEAD) &&
 	 git status | sed "s/$H/XXX/" >expect &&
-	 H=$(cd submodule2; git rev-parse HEAD) &&
+	 H=$(cd submodule2 && git rev-parse HEAD) &&
 	 git rm --cached submodule2 &&
 	 rm -rf submodule2 &&
 	 mkdir -p "moved/sub module" &&
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 08d9add05e..34ac28c056 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -148,7 +148,7 @@ test_expect_success 'preparing second superproject with a nested submodule plus
 		cd supersuper &&
 		echo "I am super super." >file &&
 		git add file &&
-		git commit -m B-super-super-initial
+		git commit -m B-super-super-initial &&
 		git submodule add "file://$base_dir/super" subwithsub &&
 		git commit -m B-super-super-added &&
 		git submodule update --init --recursive &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 282ff42331..51646d8019 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -411,8 +411,8 @@ test_expect_success 'sign off (1)' '
 	git commit -s -m "thank you" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
-		echo thank you
-		echo
+		echo thank you &&
+		echo &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
@@ -430,9 +430,9 @@ test_expect_success 'sign off (2)' '
 $existing" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
-		echo thank you
-		echo
-		echo $existing
+		echo thank you &&
+		echo &&
+		echo $existing &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
@@ -450,9 +450,9 @@ test_expect_success 'signoff gap' '
 $alt" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
 	(
-		echo welcome
-		echo
-		echo $alt
+		echo welcome &&
+		echo &&
+		echo $alt &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
@@ -470,11 +470,11 @@ We have now
 $alt" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
 	(
-		echo welcome
-		echo
-		echo We have now
-		echo $alt
-		echo
+		echo welcome &&
+		echo &&
+		echo We have now &&
+		echo $alt &&
+		echo &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
@@ -491,11 +491,11 @@ non-trailer line
 Myfooter: x" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
 	(
-		echo subject
-		echo
-		echo non-trailer line
-		echo Myfooter: x
-		echo
+		echo subject &&
+		echo &&
+		echo non-trailer line &&
+		echo Myfooter: x &&
+		echo &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expected &&
 	test_cmp expected actual &&
@@ -508,10 +508,10 @@ non-trailer line
 Myfooter: x" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
 	(
-		echo subject
-		echo
-		echo non-trailer line
-		echo Myfooter: x
+		echo subject &&
+		echo &&
+		echo non-trailer line &&
+		echo Myfooter: x &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expected &&
 	test_cmp expected actual
@@ -524,10 +524,10 @@ test_expect_success 'multiple -m' '
 	git commit -m "one" -m "two" -m "three" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
-		echo one
-		echo
-		echo two
-		echo
+		echo one &&
+		echo &&
+		echo two &&
+		echo &&
 		echo three
 	) >expected &&
 	test_cmp expected actual
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index b4b74dbe29..943708fb04 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -193,9 +193,9 @@ test_expect_success 'status with added and untracked file in modified submodule
 
 test_expect_success 'setup .git file for sub' '
 	(cd sub &&
-	 rm -f new-file
+	 rm -f new-file &&
 	 REAL="$(pwd)/../.real" &&
-	 mv .git "$REAL"
+	 mv .git "$REAL" &&
 	 echo "gitdir: $REAL" >.git) &&
 	 echo .real >>.gitignore &&
 	 git commit -m "added .real to .gitignore" .gitignore
@@ -209,12 +209,12 @@ test_expect_success 'status with added file in modified submodule with .git file
 
 test_expect_success 'status with a lot of untracked files in the submodule' '
 	(
-		cd sub
+		cd sub &&
 		i=0 &&
 		while test $i -lt 1024
 		do
-			>some-file-$i
-			i=$(( $i + 1 ))
+			>some-file-$i &&
+			i=$(( $i + 1 )) || exit 1
 		done
 	) &&
 	git status --porcelain sub 2>err.actual &&
-- 
2.18.0.203.gfac676dfb9

