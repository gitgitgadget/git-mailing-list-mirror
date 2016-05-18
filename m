From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 21/21] t5523: use test_i18ngrep for negation
Date: Wed, 18 May 2016 15:27:54 +0000
Message-ID: <1463585274-9027-22-git-send-email-vascomalmeida@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:31:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33RL-0001pD-P8
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbcERPbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:31:11 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:59103 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932634AbcERPbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:31:09 -0400
Received: (qmail 22031 invoked from network); 18 May 2016 15:31:07 -0000
Received: (qmail 4276 invoked from network); 18 May 2016 15:31:07 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 18 May 2016 15:31:02 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294964>

Replace the first form by the second one:
	! grep expected actual
	test_i18ngrep ! expected actual

The latter syntax is supported by test_i18ngrep defined in
t/test-lib.sh.

Although the test already passes whether GETTEXT_POSION is enabled, use
the i18n grep variant for the sake of consistency and also to make
obvious that those strings are subject to i18n.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t5523-push-upstream.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 4a7b98b..d6981ba 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -83,7 +83,7 @@ test_expect_success 'progress messages do not go to non-tty' '
 
 	# skip progress messages, since stderr is non-tty
 	git push -u upstream master >out 2>err &&
-	! grep "Writing objects" err
+	test_i18ngrep ! "Writing objects" err
 '
 
 test_expect_success 'progress messages go to non-tty (forced)' '
@@ -98,15 +98,15 @@ test_expect_success TTY 'push -q suppresses progress' '
 	ensure_fresh_upstream &&
 
 	test_terminal git push -u -q upstream master >out 2>err &&
-	! grep "Writing objects" err
+	test_i18ngrep ! "Writing objects" err
 '
 
 test_expect_success TTY 'push --no-progress suppresses progress' '
 	ensure_fresh_upstream &&
 
 	test_terminal git push -u --no-progress upstream master >out 2>err &&
-	! grep "Unpacking objects" err &&
-	! grep "Writing objects" err
+	test_i18ngrep ! "Unpacking objects" err &&
+	test_i18ngrep ! "Writing objects" err
 '
 
 test_expect_success TTY 'quiet push' '
-- 
2.7.3
