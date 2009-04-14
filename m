From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: persist and restore the window state with the geometry
Date: 14 Apr 2009 22:09:53 +0100
Message-ID: <873acbndr2.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 23:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltpv0-0000ll-VB
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 23:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbZDNVKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 17:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbZDNVKM
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 17:10:12 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:60192 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751744AbZDNVKL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 17:10:11 -0400
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1LtptR-0004YZ-A9; Tue, 14 Apr 2009 22:10:09 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1LtptH-0006OI-7A; Tue, 14 Apr 2009 22:09:59 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 77ABB51836; Tue, 14 Apr 2009 22:09:54 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116573>


  This patch records the window state and if the window was maximized
  this state is re-applied.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index a7294a1..edb3ba2 100755
--- a/gitk
+++ b/gitk
@@ -2251,6 +2251,10 @@ proc makewindow {} {
 	}
     }
 
+    if {[info exists geometry(state)] && $geometry(state) eq "zoomed"} {
+        wm state . $geometry(state)
+    }
+
     if {[tk windowingsystem] eq {aqua}} {
         set M1B M1
         set ::BM "3"
@@ -2540,6 +2544,7 @@ proc savestuff {w} {
 	puts $f [list set perfile_attrs $perfile_attrs]
 
 	puts $f "set geometry(main) [wm geometry .]"
+	puts $f "set geometry(state) [wm state .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
         puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash coord 0]\""
-- 
1.6.2.2.1669.g7eaf8
