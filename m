From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 22/39] t5523: use test_i18ngrep for negation
Date: Wed,  1 Jun 2016 16:41:12 +0000
Message-ID: <1464799289-7639-23-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:44:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Fz-0005CT-To
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbcFAQo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:44:26 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:47091 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755889AbcFAQoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:44:25 -0400
Received: (qmail 12773 invoked from network); 1 Jun 2016 16:44:23 -0000
Received: (qmail 29182 invoked from network); 1 Jun 2016 16:44:23 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:44:18 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296120>

Replace the first form with the second one:

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
