Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953A620248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfBYVy2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:54:28 -0500
Received: from mail-ot1-f73.google.com ([209.85.210.73]:33377 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfBYVy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:54:26 -0500
Received: by mail-ot1-f73.google.com with SMTP id e25so5680024otp.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v0z5HsQ6sVSwduN28MRdgbHtAkcKr34agxgiNpUctpk=;
        b=nZ9MFBSh9bv5L2eNRtAIkDjtkOJLZiMkL8GGWcnUuTfXsHjXbmhn682a/b8Ueg3h4L
         UaoheRcWoJ/vl2Ig62wfVkoxBaEsZGqhDkEYo8xBr3jcldNAdLIjEgfLOJzgNJsAI3K5
         pgI/BKhN8/2qxDgTRAHeCB5LnyUNl6qgyBI9NeEPBSrv8R91Xm012LS47VV2mM3rujJ4
         3hgiuYZCOb2LAjOtj5IcojoURSdyqx0mb6C0I6DVIoUtRynP5AJUfp0YzqviqkCy6eDu
         RZWRWHSlIj1tL3mKt3B1LTtJZOR/nMoK3SDRmdMuMgryBNr3QXuhBBjIY0uXMx8Esg81
         WfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v0z5HsQ6sVSwduN28MRdgbHtAkcKr34agxgiNpUctpk=;
        b=Dlm739AZBc+9pawDd9yAd4pS3Ymo6MJOcbRWLpSQS8a9+eEzOZar+8YuMjGnYtOOEx
         VW8ONdN9z6DlefjWgOBc5HicY1VGUj3jbblFkJ7mo4DrrYBp6igcbXuqFGqlr2LrR2Lr
         luPvNVA4fanJ0EmGEgDhRPimanF2r31c0DGlVTPYsExe+E6+NlDXoau+4AsxCrwUYl2E
         1GyRM9NRSqXZ0KpFrAtWwXJbsN1FYYTQtYWDESLAdpyPcsyfv5jPdBILORVfgiQNXcFc
         69vv+IDS6/BKdSQyNoWE9LySuVjO++KalT1gFWOc2Tq9j2Lfl6r4+gyCQhs86FtlDGE3
         1d6w==
X-Gm-Message-State: AHQUAua9/Ec6JZfNCF1KbQ1zycQ+5YBNKLDP9JFSbAMQmuxU8JOsYGAW
        drSZi0ddhgM0Fl4bsG3aIo9uUuPynJJId9dq0rIwMB0kdvgiQvYvq2cJGqhr/ZsqjfMNXo6w5Om
        6412Hm5edZQ35Jps7qEWqojcl3AYxr+zo639hb7u1BrFb55LQeLptByroYEXqeM9BbzAHlZeiPv
        Hy
X-Google-Smtp-Source: AHgI3IbOBZVMYBrdmwuUgNa4fqnXXpgKus18yooQLTWQohRlmoBTecTxCfaEb1IQcC2ARUI+tjS+AeBK0jYFCKAWPrH9
X-Received: by 2002:a9d:635a:: with SMTP id y26mr12514635otk.53.1551131665383;
 Mon, 25 Feb 2019 13:54:25 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:54:08 -0800
In-Reply-To: <cover.1551131153.git.jonathantanmy@google.com>
Message-Id: <227a88aa8ca40663700b434284d3fa3876464dc8.1551131153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1551131153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 3/8] tests: always test fetch of unreachable with v0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests check that fetching an unreachable object fails, but protocol
v2 allows such fetches. Unset GIT_TEST_PROTOCOL_VERSION so that these
tests are always run using protocol v0.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index a852684e16..f02ae3b797 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -307,7 +307,10 @@ test_expect_success 'test allowreachablesha1inwant with unreachable' '
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
-	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
+	# Some protocol versions (e.g. 2) support fetching
+	# unadvertised objects, so restrict this test to v0.
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
+		git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
 '
 
 test_expect_success 'test allowanysha1inwant with unreachable' '
@@ -326,7 +329,10 @@ test_expect_success 'test allowanysha1inwant with unreachable' '
 
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

