Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA21208E3
	for <e@80x24.org>; Thu,  7 Sep 2017 14:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbdIGOCt (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 10:02:49 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50912 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755385AbdIGOCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 10:02:41 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LtDGF-1dS98O06ih-012nGU; Thu, 07
 Sep 2017 16:02:31 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] t7004: move limited stack prereq to test-lib
Date:   Thu,  7 Sep 2017 16:02:20 +0200
Message-Id: <7917efead45441d5b3cb18b4d1608d5112445f62.1504792601.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.603.gf58147c36e
In-Reply-To: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
References: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
In-Reply-To: <cover.1504792601.git.git@grubix.eu>
References: <cover.1504792601.git.git@grubix.eu>
X-Provags-ID: V03:K0:gpAIELu8ERZvUUmf6TD5D01+kzKGKC/PdAE4PFTtH60kMREqLmu
 dkVO84GEWQVJya+DULhwWi3O4Bonm9mgfvvOAiltOn+YO1vrPicwytbVhH7f2QjKBIl1WH3
 GplpqS1McCgWWfZMV42iS8pspKIGm36fZsWXN4NYfoOi7vu85C4dwP9OGvDqn80rUUZ+3P4
 TnETqHPdvFlW0DVQqZJ2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sk8bzu4e/zk=:k5W+jGMfyW9O1Vfeo0cCCT
 jNmtmrL6Xus7jctH5Q0uvwZwVDJ9RxcmYcGPkaOSZOAsb9IpDtsI4d5sLkP3hZJcntq455r5T
 XDD3LDxJUHItsp/5mzVxiBeYbXFkBuDljz1veLVLCJxGuIKv4q2BDqJUOl5bzZFhwuToR+OnP
 oPh100+iKBneu2QVrUgp8DGfjoLoPd+kqgVT6InhNf87H+RDRRos1fAm8fZyDZ2rsDroanb/p
 9BR3AHVjQAeI+qQQ+3MMCyX6FIuquVtmLuk56B0g8qtM3Lw4aUJp6A+w5byHCs3RxfS42Yjzv
 voFVM9SnP326bTw5wHqxo230kVUrW76wmVq/ksZ1AwZFZJK/2cnxgBj681FrulgpWt/UV+NjV
 VdvItbKIZv3qbsPfinMmmTGpCwODIUoaHmmWKULEYHU9EAE2kyv2oBAmZArPgKWMrmzOn08Pw
 wPB7qI/7CAThmV337JHj4cdCksgLM6m9Q7IdutB40ZXC3ChecVz1kbgD3WzA4f3N4Jm+mn+52
 oq6wZHmqvn6m6S2klT/KSCnjJNa2J0nOIPOV5j6An0cEkXJZ8ItqeCkEwMMGu5JHq6bF/P6by
 QExb5ZNHvOM6pZZLgTVAnpJQkY+LDzpaBAFvGGIuZfSW6dxX7a6w3tufql6yC61frdDLKGPlP
 KslkTshVdwhgTwg25RjLDZ2D+OYlvE/5mf0ZBabCsfJrqzq+IkkzJ7YumNBPxnhN12QshjlxS
 os3ZOHM2PJoSy1CEHfhm18km34lDIpLlv1qLrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lazy prerequisite  ULIMIT_STACK_SIZE is used only in t7004 so far.

Move it to test-lib.sh so that it can be used in other tests (which it will
be in a follow-up commit).

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/t7004-tag.sh | 6 ------
 t/test-lib.sh  | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index dbcd6f623c..5bf5ace56b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1863,12 +1863,6 @@ test_expect_success 'version sort with very long prerelease suffix' '
 	git tag -l --sort=version:refname
 '
 
-run_with_limited_stack () {
-	(ulimit -s 128 && "$@")
-}
-
-test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
-
 # we require ulimit, this excludes Windows
 test_expect_success ULIMIT_STACK_SIZE '--contains and --no-contains work in a deep repo' '
 	>expect &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5fbd8d4a90..f22c1b260a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1167,6 +1167,12 @@ run_with_limited_cmdline () {
 
 test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
 
+run_with_limited_stack () {
+	(ulimit -s 128 && "$@")
+}
+
+test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
+
 build_option () {
 	git version --build-options |
 	sed -ne "s/^$1: //p"
-- 
2.14.1.603.gf58147c36e

