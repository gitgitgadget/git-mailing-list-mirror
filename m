From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [gitk] [PATCH] 2/2 Merging master into dev
Date: 06 Nov 2009 23:28:01 +0000
Message-ID: <87vdhnutby.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 07 00:28:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6YE5-0004SS-IA
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 00:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759939AbZKFX2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 18:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759937AbZKFX2E
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 18:28:04 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:38309 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759932AbZKFX2E (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 18:28:04 -0500
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N6YDq-0001TQ-SU; Fri, 06 Nov 2009 23:28:02 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1N6YDp-0007FC-Nc; Fri, 06 Nov 2009 23:28:01 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 71B7013D310; Fri,  6 Nov 2009 23:28:01 +0000 (GMT)
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132347>


commit 2e67e0332adb6896df6e6a7d4d8aeff179d2b657
Author: Pat Thoyts <patthoyts@users.sourceforge.net>
Date:   Fri Nov 6 22:19:09 2009 +0000

    Default to the system colours on Windows
    
    Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

diff --git a/gitk b/gitk
index 6360077..e591d61 100755
--- a/gitk
+++ b/gitk
@@ -10726,7 +10726,7 @@ proc doprefs {} {
     ${NS}::label $top.cdisp -text [mc "Colors: press to choose"]
     grid $top.cdisp - -sticky w -pady 10
     label $top.ui -padx 40 -relief sunk -background $uicolor
-    button $top.uibut -text [mc "Interface"] -font optionfont \
+    ${NS}::button $top.uibut -text [mc "Interface"] \
        -command [list choosecolor uicolor {} $top.ui [mc "interface"] setui]
     grid x $top.uibut $top.ui -sticky w
     label $top.bg -padx 40 -relief sunk -background $bgcolor
@@ -11334,13 +11334,20 @@ if {[tk windowingsystem] eq "aqua"} {
 }
 
 set colors {green red blue magenta darkgrey brown orange}
-set uicolor grey85
-set bgcolor white
-set fgcolor black
+if {[tk windowingsystem] eq "win32"} {
+    set uicolor SystemButtonFace
+    set bgcolor SystemWindow
+    set fgcolor SystemButtonText
+    set selectbgcolor SystemHighlight
+} else {
+    set uicolor grey85
+    set bgcolor white
+    set fgcolor black
+    set selectbgcolor gray85
+}
 set diffcolors {red "#00a000" blue}
 set diffcontext 3
 set ignorespace 0
-set selectbgcolor gray85
 set markbgcolor "#e0e0ff"
 
 set circlecolors {white blue gray blue blue}
