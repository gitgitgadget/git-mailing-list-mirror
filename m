From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git gui: remove warning when deleting correctly merged
	remote branch
Date: Mon, 15 Jun 2009 23:19:56 +0200
Message-ID: <20090615211956.GB8065@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 23:20:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJbB-00049K-PN
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935121AbZFOVT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935120AbZFOVT4
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:19:56 -0400
Received: from darksea.de ([83.133.111.250]:49776 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935117AbZFOVT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:19:56 -0400
Received: (qmail 16858 invoked from network); 15 Jun 2009 23:19:43 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 15 Jun 2009 23:19:43 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121624>

If the user wants to delete a remote branch and selects the correct
"merged into" we should not warn that "Recovering deleted branches is
difficult". For local branches we do the same already.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-gui/lib/remote_branch_delete.tcl |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
index 4e02fc0..31e0947 100644
--- a/git-gui/lib/remote_branch_delete.tcl
+++ b/git-gui/lib/remote_branch_delete.tcl
@@ -208,13 +208,15 @@ method _delete {} {
 		return
 	}
 
-	if {[tk_messageBox \
-		-icon warning \
-		-type yesno \
-		-title [wm title $w] \
-		-parent $w \
-		-message [mc "Recovering deleted branches is difficult.\n\nDelete the selected branches?"]] ne yes} {
-		return
+	if {$checktype ne {head}} {
+		if {[tk_messageBox \
+			-icon warning \
+			-type yesno \
+			-title [wm title $w] \
+			-parent $w \
+			-message [mc "Recovering deleted branches is difficult.\n\nDelete the selected branches?"]] ne yes} {
+			return
+		}
 	}
 
 	destroy $w
-- 
1.6.3.1.169.g33fd


----- End forwarded message -----
