Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005C01FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbcFQUZJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:25:09 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35402 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964855AbcFQUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:32 -0400
Received: (qmail 2366 invoked from network); 17 Jun 2016 20:24:30 -0000
Received: (qmail 7777 invoked from network); 17 Jun 2016 20:24:30 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:29 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 21/38] t4153: fix negated test_i18ngrep call
Date:	Fri, 17 Jun 2016 20:21:10 +0000
Message-Id: <1466194887-18236-22-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The function test_i18ngrep fakes success when run under GETTEXT_POISON.
Hence, running in the following manner will always fail under gettext
poison:

	! test_i18ngrep expected actual

Use correct syntax: test_i18ngrep ! expected actual

For other instance of this issue see 41ca19b ("tests: fix negated
test_i18ngrep calls", 2014-08-13).

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t4153-am-resume-override-opts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index 7c013d8..8ea22d1 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -53,7 +53,7 @@ test_expect_success '--no-quiet overrides --quiet' '
 	# Applying side1 will be quiet.
 	test_must_fail git am --quiet side[123].eml >out &&
 	test_path_is_dir .git/rebase-apply &&
-	! test_i18ngrep "^Applying: " out &&
+	test_i18ngrep ! "^Applying: " out &&
 	echo side1 >file &&
 	git add file &&
 
-- 
2.6.6

