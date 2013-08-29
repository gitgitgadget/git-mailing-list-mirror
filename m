From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/4] git-remote-mediawiki: add test and check Makefile targets
Date: Thu, 29 Aug 2013 20:58:21 +0200
Message-ID: <1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqsixvfvdk.fsf@anie.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 21:00:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7SJ-00088i-3V
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490Ab3H2TA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:00:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57222 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096Ab3H2TA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:00:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TIwRhC018972
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 20:58:27 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VF7QL-00039O-MS; Thu, 29 Aug 2013 20:58:29 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VF7QL-000831-CH; Thu, 29 Aug 2013 20:58:29 +0200
X-Mailer: git-send-email 1.8.4.12.g98a4f55.dirty
In-Reply-To: <vpqsixvfvdk.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 20:58:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TIwRhC018972
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378407507.70178@lRN7Hp4aPHnWkdS6pscyJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233340>

There are a few level 4 and 2 perlcritic issues in the current code. We
make level 5 fatal, and keep level 2 as warnings.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index 76fcd4d..f206f96 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -24,6 +24,11 @@ INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
 
 all: build
 
+test: all
+	$(MAKE) -C t
+
+check: perlcritic test
+
 install_pm:
 	install $(GIT_MEDIAWIKI_PM) $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
 
@@ -41,4 +46,7 @@ clean:
 	rm $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
 
 perlcritic:
-	perlcritic -2 *.perl
+	perlcritic -5 $(SCRIPT_PERL)
+	-perlcritic -2 $(SCRIPT_PERL)
+
+.PHONY: all test check install_pm install clean perlcritic
-- 
1.8.4.12.g98a4f55.dirty
