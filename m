Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45FBF2018E
	for <e@80x24.org>; Fri, 12 Aug 2016 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbcHLMA3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 08:00:29 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:37585 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751574AbcHLMA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 08:00:28 -0400
Received: (qmail 13780 invoked from network); 12 Aug 2016 12:00:20 -0000
Received: (qmail 8295 invoked from network); 12 Aug 2016 12:00:20 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 Aug 2016 12:00:15 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/3] t7411: become resilient to GETTEXT_POISON
Date:	Fri, 12 Aug 2016 11:59:02 +0000
Message-Id: <1471003142-1739-3-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471003142-1739-1-git-send-email-vascomalmeida@sapo.pt>
References: <1471003142-1739-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The concerned test greps the error message in git_parse_source() which
contains "bad config line %d in submodule-blob %s".

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t7411-submodule-config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 400e2b1..47562ce 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -89,7 +89,7 @@ test_expect_success 'error message contains blob reference' '
 			HEAD b \
 			HEAD submodule \
 				2>actual_err &&
-		grep "submodule-blob $sha1:.gitmodules" actual_err >/dev/null
+		test_i18ngrep "submodule-blob $sha1:.gitmodules" actual_err >/dev/null
 	)
 '
 
-- 
2.7.4

