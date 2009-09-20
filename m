From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH RESEND] git gui: make current branch default in "remote
	delete branch" merge check
Date: Sun, 20 Sep 2009 11:47:34 +0200
Message-ID: <20090920094734.GA10551@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 20 11:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpJ1C-0000fn-NO
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 11:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbZITJrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 05:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754246AbZITJrc
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 05:47:32 -0400
Received: from darksea.de ([83.133.111.250]:48213 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754215AbZITJrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 05:47:32 -0400
Received: (qmail 25469 invoked from network); 20 Sep 2009 11:47:34 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 20 Sep 2009 11:47:34 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128843>

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-gui/lib/remote_branch_delete.tcl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
index 4e02fc0..9b119a7 100644
--- a/git-gui/lib/remote_branch_delete.tcl
+++ b/git-gui/lib/remote_branch_delete.tcl
@@ -248,6 +248,8 @@ method _write_url        {args} { set urltype url    }
 method _write_check_head {args} { set checktype head }
 
 method _write_head_list {args} {
+	global current_branch
+
 	$head_m delete 0 end
 	foreach abr $head_list {
 		$head_m insert end radiobutton \
@@ -256,7 +258,11 @@ method _write_head_list {args} {
 			-variable @check_head
 	}
 	if {[lsearch -exact -sorted $head_list $check_head] < 0} {
-		set check_head {}
+		if {[lsearch -exact -sorted $head_list $current_branch] < 0} {
+			set check_head {}
+		} else {
+			set check_head $current_branch
+		}
 	}
 }
 
-- 
1.6.5.rc1.10.g20f34
