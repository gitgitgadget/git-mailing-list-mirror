Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6768E2018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbdEKNsS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:58245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932338AbdEKNrz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:47:55 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfVzj-1dOyQG0Qax-00P7V9; Thu, 11
 May 2017 15:47:51 +0200
Date:   Thu, 11 May 2017 15:47:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/11] Revert "Revert "Don't create the $GIT_DIR/branches
 directory on init""
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <32d64bd3716c6f7a24877535330b7ac754eb117c.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r3y5wKoQTXmZQbroM503IXQGv8aH8F4xKdm6otZmV9fnQnLbqnM
 MFLWSBzV6RWEHoYiH6sSf1A0tpl1W6rgVFHZcA98rr5oN1V+nnBoOnoAlxod/kr/4DJDAcA
 KoRb/3jYaQZM2b1z4NDYy9jVX+UTgn47LfzLSMi7fNeZouGncUDSF4qkI18PRg+R8C6CA1F
 QmmBzYSyrC470l8SN1RVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oOjj8Zn+vks=:E2IPBmsMNKW83JLN7C9Ddf
 EH5MHxoEjblg787y7w+/NQFb4al7cVe6clyTXrkJWAqZhxP4n8OaTvndCWTgmMg0osfKPa2eM
 l41W+B7sGQDgPS7C/30aTrzQApTj2UOKaCo9D7DP+JWwEsQlJCAiQmFWklmC+vMdVllgFzb2G
 JXaG8u8yNhLDb+LC+da60y8cTd9otPzRUr9C1zswKJYo90CGSvq8+0Ow35wcNTS2OHa5Iced5
 jtH5bF2V9RcMP2rAyzaHPh+ERKYR19r27VjOd62hWQKXcHbJybRIaS/gvLiIXw6PlxuqAww6q
 aaMANhrSuLbgOitiY28qTlNtRVj8A9qBBD7oAw1JJmig618+DOtgs39W6yVWd1GJzqDdCXLRf
 /C5uKDqg7cMvIzvbA0MIHhXeb6TNrzzfzb31lXQK3uERdwzLJZMrLzuM05HMXKMGM/Owr9ogL
 n1vGiD2DAMtk3qCVHGEqL+5q8yzSIHb+E1cfVOdDgQEhw8eM4rsPnXUZEg9v/G5NXC+Qn/pTy
 hBzFXv3ximfxB8BA3b/b17lP48IviYTSTgtjnPsR9Gaj+4Ydc+RIlwM8lIDgbs9TfeB1t2hig
 yh7QmecGbhgDtE8EGx/2Ay+s16u9BhN1jOkWBpZEoVZwDAX/TU2NA1cAAp1pd4gIsOSo7UhMN
 JujDopicJ1KzlrLZu5Q9mDeaChO6a/h2uxlfu4/Wpqfa3XofhkoWodL9FfJo3gLVCE/NvBMAd
 RR0VXe3dx0220yi9uURRrq6QpdrS8teSInObJVk7Zy7KiBQhdvU+dIP8XADoTg6UFVCvwmrv0
 pe3WpKc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A long, long, long time ago, we stored the "upstream" information of
branches in files inside the .git/branches/ directory. We don't do this
anymore, though. Since 5751f49010e (Move remote parsing into a library
file out of builtin-push., 2007-05-12), to be precise.

This is sort of a sibling to 75c384efb52 (Do not create $GIT_DIR/remotes/
directory anymore., 2006-12-19).

The tests t5505-remote and t5516-fetch-push need to be adjusted now, as
they expect to find a .git/branches/ directory.

This reverts c8a58ac5a52 (Revert "Don't create the $GIT_DIR/branches
directory on init", 2009-10-31).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh     | 2 ++
 t/t5516-fetch-push.sh | 4 ++++
 templates/branches--  | 1 -
 3 files changed, 6 insertions(+), 1 deletion(-)
 delete mode 100644 templates/branches--

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a6c0178f3af..4fd66760c75 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -830,6 +830,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	(
 		cd six &&
 		git remote rm origin &&
+		mkdir -p .git/branches &&
 		echo "$origin_url" >.git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
@@ -844,6 +845,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)'
 	(
 		cd seven &&
 		git remote rm origin &&
+		mkdir .git/branches &&
 		echo "quux#foom" > .git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 177897ea0b1..457f648ad91 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -866,6 +866,7 @@ test_expect_success 'fetch with branches' '
 	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
+	mkdir -p testrepo/.git/branches &&
 	echo ".." > testrepo/.git/branches/branch1 &&
 	(
 		cd testrepo &&
@@ -879,6 +880,7 @@ test_expect_success 'fetch with branches' '
 
 test_expect_success 'fetch with branches containing #' '
 	mk_empty testrepo &&
+	mkdir -p testrepo/.git/branches &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
 	(
 		cd testrepo &&
@@ -893,6 +895,7 @@ test_expect_success 'fetch with branches containing #' '
 test_expect_success 'push with branches' '
 	mk_empty testrepo &&
 	git checkout second &&
+	mkdir -p .git/branches &&
 	echo "testrepo" > .git/branches/branch1 &&
 	git push branch1 &&
 	(
@@ -905,6 +908,7 @@ test_expect_success 'push with branches' '
 
 test_expect_success 'push with branches containing #' '
 	mk_empty testrepo &&
+	mkdir -p .git/branches &&
 	echo "testrepo#branch3" > .git/branches/branch2 &&
 	git push branch2 &&
 	(
diff --git a/templates/branches-- b/templates/branches--
deleted file mode 100644
index fae88709a63..00000000000
--- a/templates/branches--
+++ /dev/null
@@ -1 +0,0 @@
-: this is just to ensure the directory exists.
-- 
2.12.2.windows.2.800.gede8f145e06


