From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 21/38] t4153: fix negated test_i18ngrep call
Date: Tue,  7 Jun 2016 11:52:20 +0000
Message-ID: <1465300357-7557-22-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:55:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFb6-0007sf-3q
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbcFGLyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:54:52 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:33076 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161140AbcFGLyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:54:51 -0400
Received: (qmail 28053 invoked from network); 7 Jun 2016 11:54:49 -0000
Received: (qmail 19886 invoked from network); 7 Jun 2016 11:54:49 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:54:47 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296653>

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
2.7.3
