Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FAD81F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfBFAVd (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:21:33 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:54740 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBFAVc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:21:32 -0500
Received: by mail-it1-f202.google.com with SMTP id v3so1508743itf.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CkLq877M7gqmsyY2awwRgNsUA7LY0Mw06Lhm4BRXyzI=;
        b=EvklAtIOkp6giSNwSshJqMYhPUBWS5s2BRsz88LNXoyk1otroUCUI6f+as9TuIo+nW
         WYnjsO8ZTXzFxUIku8lepwDGNx9FUg8zmqTAhmWlksGgg/1n2JRlOj9Bu8pt+wr8M+Xx
         7JBKqWIRruTKpedSpTTiENupEht9Ph1brIBZLAaU4ncQg2gBxRCb4SX2Z0z6TX3QKiu4
         pEZU87vUX/4EL3yGRpgmtf6iRTTvCWRva/wXaFvkju5JJbD/Y6peCCsOE4FL0TpQOrEw
         llQ8xa2Zm9aBhKDiaSAUCrEeQq1s0d6BN1pGWAa8RR0uyfCyLMWfYBuhinB0Xq9fp/sv
         hL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CkLq877M7gqmsyY2awwRgNsUA7LY0Mw06Lhm4BRXyzI=;
        b=gTyjIXuE4LX+nfgVcBv+pTZU56nN1SBmhYg9RvcWHWJMBlcM68Gwm0UiyFAzmfEtbT
         FxBLMNgF7yR/xIeMq5fuuSMnhdtqax0BKcmpm+aWuZuILqlbyRcWmrRtRHmbNDUlBvqB
         dxSvXlxQpwUDe0mvkY04nn7IuAVNAoPl/m2Fk5t9AQObdrxOKiwrupClQYtfFSBCbOjT
         WvJBCatr4AGp+DaBKGdoGCcmz87crV1Ia+j+1LuM7ivRBEC1NnIVYBD8Cso8zZ4x+rbN
         feMynikzjYhs4BcbWLGfskqvYUya6t6f4FH4L7M5FX5lY9w/a2aHg5xf2Jw80yQuc9tS
         XfyA==
X-Gm-Message-State: AHQUAuZggtD/dARykLnB3iheHrVLPUwlqzfgoUxGsLw9zIKKvCdsPhJ0
        M0H9TzAtdBA4sInK58QTUsarhw1k0wg49Sq842ehNuch6EwB2k8Astm7EZabZc61ogWJ0sy0rjj
        rRUO+mS84n4BYaQld+3Ykbm1Bjb8ctdNDYQVnNzodbvET/VDCO3sGJM42JTqzbzzAvHYsONZ0hw
        ys
X-Google-Smtp-Source: AHgI3IaZu/m1ijmy9sD5+H6X8LXfJSGbvZTVFLw6qmaRrgl7bqxTdizN9VMKw+Yk2g8UdrymfXhvbzr+i1dpOhDsi2oP
X-Received: by 2002:a24:254b:: with SMTP id g72mr309894itg.19.1549412491477;
 Tue, 05 Feb 2019 16:21:31 -0800 (PST)
Date:   Tue,  5 Feb 2019 16:21:16 -0800
In-Reply-To: <cover.1549411880.git.jonathantanmy@google.com>
Message-Id: <9b9061985202ec022cc562637d7f62ea599e7d8c.1549411880.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1549411880.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 2/8] tests: always test fetch of unreachable with v0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
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

