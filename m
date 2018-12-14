Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86FB820A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 13:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeLNNF4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 08:05:56 -0500
Received: from mail.javad.com ([54.86.164.124]:53910 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbeLNNF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 08:05:56 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 743B03FC94;
        Fri, 14 Dec 2018 12:56:20 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=sorganov@gmail.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <sorganov@gmail.com>)
        id 1gXn0s-0003AC-OT; Fri, 14 Dec 2018 15:56:18 +0300
Message-Id: <ccfe8ae38301b6ee1b0924fbf00eb5d20242ea5d.1544764226.git.sorganov@gmail.com>
In-Reply-To: <cover.1544762343.git.sorganov@gmail.com>
References: <cover.1544762343.git.sorganov@gmail.com>
From:   Sergey Organov <sorganov@gmail.com>
Date:   Fri, 14 Dec 2018 07:53:51 +0300
Subject: [PATCH v2 3/4] t3502: validate '-m 1' argument is now accepted for
 non-merge commits
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t3502-cherry-pick-merge.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index b160271..3259bd5 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -40,12 +40,12 @@ test_expect_success 'cherry-pick -m complains of bogus numbers' '
 	test_expect_code 129 git cherry-pick -m 0 b
 '
 
-test_expect_success 'cherry-pick a non-merge with -m should fail' '
+test_expect_success 'cherry-pick explicit first parent of a non-merge' '
 
 	git reset --hard &&
 	git checkout a^0 &&
-	test_expect_code 128 git cherry-pick -m 1 b &&
-	git diff --exit-code a --
+	git cherry-pick -m 1 b &&
+	git diff --exit-code c --
 
 '
 
@@ -84,12 +84,12 @@ test_expect_success 'cherry pick a merge relative to nonexistent parent should f
 
 '
 
-test_expect_success 'revert a non-merge with -m should fail' '
+test_expect_success 'revert explicit first parent of a non-merge' '
 
 	git reset --hard &&
 	git checkout c^0 &&
-	test_must_fail git revert -m 1 b &&
-	git diff --exit-code c
+	git revert -m 1 b &&
+	git diff --exit-code a
 
 '
 
-- 
2.10.0.1.g57b01a3

