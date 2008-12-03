From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] gitk: Ensure that "Reset branch" menu entry is enabled
Date: Wed,  3 Dec 2008 13:43:20 +0100
Message-ID: <1228308200-28693-1-git-send-email-j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rf9-0006Gd-BQ
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYLCNTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbYLCNTv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:19:51 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31207 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbYLCNTu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:19:50 -0500
X-Greylist: delayed 2181 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Dec 2008 08:19:49 EST
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1L7r4b-0002xn-DE; Wed, 03 Dec 2008 13:43:24 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 30409A865; Wed,  3 Dec 2008 13:43:21 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 06BF0FA46; Wed,  3 Dec 2008 13:43:20 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Consider this sequence of events: 1. Detach HEAD and fire
	up gitk 2. Call the context menu on some commit. Notice that the last menu
	entry says "Detached HEAD: can't reset" and it is disabled. 3. Now checkout
	some regular branch (e.g. 'master') using the context menu. 4. Call the context
	menu again on some commit. [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102252>

Consider this sequence of events:

1. Detach HEAD and fire up gitk
2. Call the context menu on some commit. Notice that the last menu entry
   says "Detached HEAD: can't reset" and it is disabled.
3. Now checkout some regular branch (e.g. 'master') using the context menu.
4. Call the context menu again on some commit.

Previously, at this point the last menu entry said "Reset master branch
to here", but it was still disabled. With this fix it is now enabled again.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index f7f1776..6c4022a 100755
--- a/gitk
+++ b/gitk
@@ -7950,7 +7950,7 @@ proc rowmenu {x y id} {
     if {$id ne $nullid && $id ne $nullid2} {
 	set menu $rowctxmenu
 	if {$mainhead ne {}} {
-	    $menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead]
+	    $menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead] -state normal
 	} else {
 	    $menu entryconfigure 7 -label [mc "Detached head: can't reset" $mainhead] -state disabled
 	}
-- 
1.6.1.rc1
