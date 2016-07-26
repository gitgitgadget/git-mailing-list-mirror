Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC88203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 12:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbcGZM70 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 08:59:26 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:54145 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751462AbcGZM7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 08:59:25 -0400
Received: (qmail 7174 invoked from network); 26 Jul 2016 12:59:22 -0000
Received: (qmail 23190 invoked from network); 26 Jul 2016 12:59:22 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 26 Jul 2016 12:59:20 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t5510: skip tests under GETTEXT_POISON build
Date:	Tue, 26 Jul 2016 12:58:54 +0000
Message-Id: <1469537934-16676-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469439068-2724-1-git-send-email-vascomalmeida@sapo.pt>
References: <1469439068-2724-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Skip tests when running under GETTEXT_POISON build and run them with
C_LOCALE_OUTPUT prerequisite.

These tests are irrelevant under GETTEXT_POISON because they test text
output alignment which GETTEXT_POISON turns useless.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t5510-fetch.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6bd4853..668c54b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -688,7 +688,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
-test_expect_success 'fetch aligned output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
 	(
@@ -703,7 +703,7 @@ test_expect_success 'fetch aligned output' '
 	test_cmp expect actual
 '
 
-test_expect_success 'fetch compact output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 	git clone . compact &&
 	test_commit extraaa &&
 	(
-- 
2.7.4

