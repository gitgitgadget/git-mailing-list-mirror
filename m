From: Johan Herland <johan@herland.net>
Subject: [PATCH/RFC 2/7] Cleanup: Remove unnecessary if-else clause
Date: Wed, 25 Mar 2009 22:38:30 +0100
Message-ID: <200903252238.30928.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
 <200903252236.03010.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:40:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmapo-0006Np-BT
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZCYVie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbZCYVie
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:38:34 -0400
Received: from mx.getmail.no ([84.208.15.66]:36479 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751889AbZCYVid (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:38:33 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH30098Z0478F00@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:38:31 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300BP8047R300@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:38:31 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.212528
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <200903252236.03010.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114673>

Signed-off-by: Johan Herland <johan@herland.net>
---
 path.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/path.c b/path.c
index e332b50..28e50d3 100644
--- a/path.c
+++ b/path.c
@@ -322,16 +322,10 @@ int adjust_shared_perm(const char *path)
 		return -1;
 	mode = st.st_mode;
 
-	if (shared_repository) {
-		int tweak = shared_repository;
-		if (!(mode & S_IWUSR))
-			tweak &= ~0222;
-		mode |= tweak;
-	} else {
-		/* Preserve old PERM_UMASK behaviour */
-		if (mode & S_IWUSR)
-			mode |= S_IWGRP;
-	}
+	int tweak = shared_repository;
+	if (!(mode & S_IWUSR))
+		tweak &= ~0222;
+	mode |= tweak;
 
 	if (S_ISDIR(mode)) {
 		mode |= FORCE_DIR_SET_GID;
-- 
1.6.2.1.473.g92672
