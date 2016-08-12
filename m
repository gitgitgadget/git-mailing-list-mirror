Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4A12018E
	for <e@80x24.org>; Fri, 12 Aug 2016 12:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbcHLMAS (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 08:00:18 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:37608 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751574AbcHLMAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 08:00:17 -0400
Received: (qmail 32324 invoked from network); 12 Aug 2016 12:00:15 -0000
Received: (qmail 7023 invoked from network); 12 Aug 2016 12:00:15 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 Aug 2016 12:00:10 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/3] t5520: become resilient to GETTEXT_POISON
Date:	Fri, 12 Aug 2016 11:59:01 +0000
Message-Id: <1471003142-1739-2-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471003142-1739-1-git-send-email-vascomalmeida@sapo.pt>
References: <1471003142-1739-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use test_i18ngrep function instead of grep for grepping strings.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 6ad37b5..5518445 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -270,7 +270,7 @@ test_expect_success '--rebase with conflicts shows advice' '
 	test_tick &&
 	git commit -m "Create conflict" seq.txt &&
 	test_must_fail git pull --rebase . seq 2>err >out &&
-	grep "When you have resolved this problem" out
+	test_i18ngrep "When you have resolved this problem" out
 '
 
 test_expect_success 'failed --rebase shows advice' '
@@ -284,7 +284,7 @@ test_expect_success 'failed --rebase shows advice' '
 	git checkout -f -b fails-to-rebase HEAD^ &&
 	test_commit v2-without-cr file "2" file2-lf &&
 	test_must_fail git pull --rebase . diverging 2>err >out &&
-	grep "When you have resolved this problem" out
+	test_i18ngrep "When you have resolved this problem" out
 '
 
 test_expect_success '--rebase fails with multiple branches' '
-- 
2.7.4

