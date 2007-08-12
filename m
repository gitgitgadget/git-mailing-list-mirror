From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - dont warn when deleting synonym for current head
Date: Sun, 12 Aug 2007 17:03:03 -0400
Message-ID: <1186952583887-git-send-email-mdl123@verizon.net>
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 23:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKKak-0001Tr-6E
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 23:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938213AbXHLVDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 17:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938164AbXHLVDL
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 17:03:11 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:45580 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938183AbXHLVDK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 17:03:10 -0400
Received: from fal-l07294-lp.us.ray.com ([71.246.233.117])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMO002W4IH4GG1D@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 12 Aug 2007 16:03:05 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc4.80.ge600
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55726>

Selecting "remove this branch" on a branch equal to HEAD yielded a
warning that this branch is not in any other: it is, it is on HEAD.
Curiosly, this warning was not triggered for any other deletion and
so is at best misleading. Get rid of it.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 769c79a..055cdc7 100755
--- a/gitk
+++ b/gitk
@@ -6171,12 +6171,6 @@ proc rmbranch {} {
 	error_popup "Cannot delete the currently checked-out branch"
 	return
     }
-    set dheads [descheads $id]
-    if {$dheads eq $headids($head)} {
-	# the stuff on this branch isn't on any other branch
-	if {![confirm_popup "The commits on branch $head aren't on any other\
-			branch.\nReally delete branch $head?"]} return
-    }
     nowbusy rmbranch
     update
     if {[catch {exec git branch -D $head} err]} {
-- 
1.5.3.rc4.80.ge600
