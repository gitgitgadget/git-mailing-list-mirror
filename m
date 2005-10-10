From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach git-status about spaces in file names also on MacOSX
Date: Mon, 10 Oct 2005 22:13:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510102212230.8106@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Oct 10 22:14:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP41m-00033s-CO
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVJJUNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJJUNj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:13:39 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8069 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751198AbVJJUNj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:13:39 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ED53513F09B; Mon, 10 Oct 2005 22:13:37 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D398B9E398; Mon, 10 Oct 2005 22:13:37 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B914F9DFD4; Mon, 10 Oct 2005 22:13:37 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8FDBD13F09B; Mon, 10 Oct 2005 22:13:37 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9918>


Not that I really understand what Kai's original patch really does, but on
my iBook, sed does not understand '\t' and consequently cuts of every file
name at the first "t" (or backslash...).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-status.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

applies-to: b7dbad9daef37a781daa3942e9258797f23fa635
ab97728bc4bebd99406cefa55de8530b1fe35620
diff --git a/git-status.sh b/git-status.sh
index 6e2783a..fbdd377 100755
--- a/git-status.sh
+++ b/git-status.sh
@@ -45,10 +45,10 @@ then
 	sed -e '
 		s/^:// 
 		h
-		s/^[^\t]*//
+		s/^[^	]*//
 		s/ /\\ /g
 		x
-		s/\t.*$//
+		s/	.*$//
 		G
 		s/\n/ /' |
 	report "Updated but not checked in" "will commit"
@@ -71,10 +71,10 @@ git-diff-files |
 sed -e '
 	s/^:// 
 	h
-	s/^[^\t]*//
+	s/^[^	]*//
 	s/ /\\ /g
 	x
-	s/\t.*$//
+	s/	.*$//
 	G
 	s/\n/ /' |
 report "Changed but not updated" "use git-update-index to mark for commit"
---
0.99.8.GIT
