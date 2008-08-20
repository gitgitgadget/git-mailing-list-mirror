From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Install templates with the user and group of the installing personality
Date: Wed, 20 Aug 2008 17:36:25 +0200
Message-ID: <1219246585-31993-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 17:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVpkd-0003OU-EG
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 17:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYHTPgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 11:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbYHTPgb
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 11:36:31 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16188 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbYHTPga (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 11:36:30 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KVpjW-0005f4-HM; Wed, 20 Aug 2008 17:36:26 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 467CB54D; Wed, 20 Aug 2008 17:36:26 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id EF978FA49; Wed, 20 Aug 2008 17:36:25 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc2.31.g4f33a
X-Spam-Score: -1.8 (-)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_50=0.001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92992>

If 'make install' was run with sufficient privileges, then the installed
templates, which are copied using 'tar', would receive the user and group
of whoever built git. This instructs 'tar' to ignore the user and group
that are recorded in the archive.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 I hope this tar option 'o' is universal enough. Even my ancient AIX 4.3.3
 box has it.

 -- Hannes

 templates/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/Makefile b/templates/Makefile
index 9f3f1fc..cc3fc30 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -48,4 +48,4 @@ clean:
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xf -)
+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
-- 
1.6.0.rc2.31.g4f33a
