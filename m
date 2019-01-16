Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357E21F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfAPWm2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:42:28 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39318 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbfAPWm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:42:28 -0500
Received: by mail-qt1-f201.google.com with SMTP id u20so7206560qtk.6
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CkLq877M7gqmsyY2awwRgNsUA7LY0Mw06Lhm4BRXyzI=;
        b=X3J5Fi3U5arcWdQ1/HVF1b4N1mLjJneOjiMyeBddlAVYtSn9K22BFkOQVY7m4EqndR
         FdjxtkQxNwrwlMduWffFDDjSlTKMy2TNVxUGu4kT9cKySDouApcFAoa3DGzX9tlCq++a
         omyK6Y4RWnWNZxEnHAd4/dRSEiPtyZ+dgZULbb+iRYPHpon6PxFDkTVMQuliGHkun8b4
         aHOSxYXZ0ZRylX92SNc4vqkzWtJu8KGmUOibi6aBTARw1O+6n4zfLnUJ8S2ifLEwHxEf
         bnQyZh66eeNc7im102hyT6EPI63ykCi4XPp9wNFsMMNMvmQQkeM9d11Yb75HjObKkoyF
         UUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CkLq877M7gqmsyY2awwRgNsUA7LY0Mw06Lhm4BRXyzI=;
        b=OY8+OJ/sOjcl2I6oC0Jxr/85brVFT1NdV87VbzPIUoc1J8OOvRhU2wcbbBs25rC2rS
         otwGQy14GqJ0hhKO+YTe+X2TcZjouISR3lQL3dr09a7UKDmaf01txXx7YTkH5EZLHeCx
         /gSzndUe3ZGi3t/3ZoMZFB+6DgzdeoOYms6UxwqFHicCm0kXBdLVamWNdhXbVBtYcR1D
         4x4bWIXHEw9NaO4O3/aNsgzWE/HF6uoI2PYVSlGTdpwooMJksPrPbK1pls85DllEU/R4
         vFTkmcsZPuPOIbxxsqhsXXbFlFvctuLCblb8PuQ71P50y4qfj2mdmzuN7ryPQMSbnkJD
         ffPw==
X-Gm-Message-State: AJcUukd50JzgzcJAYoWdn8SR6PlCMpW6c8weY80ms5N6lpWduOFL1DR+
        G7k4n7zw9TFj0OO5uG/RgOUOEIlkRq6bATcDUJA+4wjTg6Vf5ZAAN27wgfkY0T2ikIV0dMpoC//
        wV2O5everFpIbGxJm4x00+qYMIV9wBJOJJ5iKavZHY13QWmgmGVQs7bFY5uLW+r3b5SSlwY8gaQ
        cr
X-Google-Smtp-Source: ALg8bN5jZ6PgrMadZYG7GIn+VurUuU4gcBSp52sm0oTmVdbNT+FjsWOK0kYmCyyv0U6ypXswxH6mkVlhwsm6xE91SNqi
X-Received: by 2002:aed:376a:: with SMTP id i97mr6551181qtb.0.1547678546864;
 Wed, 16 Jan 2019 14:42:26 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:42:10 -0800
In-Reply-To: <cover.1547677183.git.jonathantanmy@google.com>
Message-Id: <0484d242fa689ad0fd0d342216d9e729ca35ba24.1547677183.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547677183.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 2/8] tests: always test fetch of unreachable with v0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests check that fetching an unreachable object fails, but protocol
v2 allows such fetches. Unset GIT_TEST_PROTOCOL_VERSION so that these
tests are always run using protocol v0.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5500-fetch-pack.sh       |  4 +++-
 t/t5516-fetch-push.sh       | 22 +++++++++++++++++-----
 t/t5551-http-fetch-smart.sh | 10 ++++++++--
 t/t7406-submodule-update.sh |  5 ++++-
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 49c540b1e1..0ef4d6f20c 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -636,7 +636,9 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
 	test_commit -C server 6 &&
 
 	git init client &&
-	test_must_fail git -C client fetch-pack ../server \
+	# Some protocol versions (e.g. 2) support fetching
+	# unadvertised objects, so restrict this test to v0.
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION= git -C client fetch-pack ../server \
 		$(git -C server rev-parse refs/heads/master^) 2>err &&
 	test_i18ngrep "Server does not allow request for unadvertised object" err
 '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 37e8e80893..4bfbb79654 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1147,8 +1147,12 @@ test_expect_success 'fetch exact SHA1' '
 		git prune &&
 		test_must_fail git cat-file -t $the_commit &&
 
+		# Some protocol versions (e.g. 2) support fetching
+		# unadvertised objects, so restrict this test to v0.
+
 		# fetching the hidden object should fail by default
-		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
+		test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+			git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
 		test_i18ngrep "Server does not allow request for unadvertised object" err &&
 		test_must_fail git rev-parse --verify refs/heads/copy &&
 
@@ -1204,7 +1208,10 @@ do
 		mk_empty shallow &&
 		(
 			cd shallow &&
-			test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
+			# Some protocol versions (e.g. 2) support fetching
+			# unadvertised objects, so restrict this test to v0.
+			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+				git fetch --depth=1 ../testrepo/.git $SHA1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch --depth=1 ../testrepo/.git $SHA1 &&
 			git cat-file commit $SHA1
@@ -1232,15 +1239,20 @@ do
 		mk_empty shallow &&
 		(
 			cd shallow &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3 &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_1 &&
+			# Some protocol versions (e.g. 2) support fetching
+			# unadvertised objects, so restrict this test to v0.
+			test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
+				git fetch ../testrepo/.git $SHA1_3 &&
+			test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
+				git fetch ../testrepo/.git $SHA1_1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch ../testrepo/.git $SHA1_1 &&
 			git cat-file commit $SHA1_1 &&
 			test_must_fail git cat-file commit $SHA1_2 &&
 			git fetch ../testrepo/.git $SHA1_2 &&
 			git cat-file commit $SHA1_2 &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3
+			test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
+				git fetch ../testrepo/.git $SHA1_3
 		)
 	'
 done
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 8f620e0a35..d2661eb338 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -308,7 +308,10 @@ test_expect_success 'test allowreachablesha1inwant with unreachable' '
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
-	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
+	# Some protocol versions (e.g. 2) support fetching
+	# unadvertised objects, so restrict this test to v0.
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+		git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
 '
 
 test_expect_success 'test allowanysha1inwant with unreachable' '
@@ -327,7 +330,10 @@ test_expect_success 'test allowanysha1inwant with unreachable' '
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
-	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)" &&
+	# Some protocol versions (e.g. 2) support fetching
+	# unadvertised objects, so restrict this test to v0.
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+		git -C test_reachable.git fetch origin "$(git rev-parse HEAD)" &&
 
 	git -C "$server" config uploadpack.allowanysha1inwant 1 &&
 	git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index e87164aa8f..c973278300 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -943,7 +943,10 @@ test_expect_success 'submodule update clone shallow submodule outside of depth'
 		cd super3 &&
 		sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
 		mv -f .gitmodules.tmp .gitmodules &&
-		test_must_fail git submodule update --init --depth=1 2>actual &&
+		# Some protocol versions (e.g. 2) support fetching
+		# unadvertised objects, so restrict this test to v0.
+		test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+			git submodule update --init --depth=1 2>actual &&
 		test_i18ngrep "Direct fetching of that commit failed." actual &&
 		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
 		git submodule update --init --depth=1 >actual &&
-- 
2.19.0.271.gfe8321ec05.dirty

