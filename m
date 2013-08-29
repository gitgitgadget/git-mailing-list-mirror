From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/4] git-remote-mediawiki: no need to update private ref in non-dumb push
Date: Thu, 29 Aug 2013 20:58:24 +0200
Message-ID: <1377802704-30881-4-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqsixvfvdk.fsf@anie.imag.fr>
 <1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 20:59:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7RF-0007NW-JB
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343Ab3H2S7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:59:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57200 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235Ab3H2S7U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:59:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TIwY2Q019055
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 20:58:36 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VF7QS-00039X-LK; Thu, 29 Aug 2013 20:58:36 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VF7QS-00083G-Bg; Thu, 29 Aug 2013 20:58:36 +0200
X-Mailer: git-send-email 1.8.4.12.g98a4f55.dirty
In-Reply-To: <1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 20:58:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TIwY2Q019055
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378407517.68931@LsRMIWQdCAJvd80DcBQsBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233339>

We used to update the private ref ourselves, but this update is now done
by default (since 664059fb62).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index cdc278c..0b920cd 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1214,7 +1214,6 @@ sub mw_push_revision {
 		}
 		if (!$dumb_push) {
 			run_git(qq(notes --ref=${remotename}/mediawiki add -f -m "mediawiki_revision: ${mw_revision}" ${sha1_commit}));
-			run_git(qq(update-ref -m "Git-MediaWiki push" refs/mediawiki/${remotename}/master ${sha1_commit} ${sha1_child}));
 		}
 	}
 
-- 
1.8.4.12.g98a4f55.dirty
