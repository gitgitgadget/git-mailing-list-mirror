From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: restore pane sizes when using ttk widgets
Date: 17 Apr 2009 22:33:29 +0100
Message-ID: <87vdp39d92.fsf_-_@users.sourceforge.net>
References: <873ac8m8jg.fsf@users.sourceforge.net>
	<18920.32172.162401.593355@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 23:35:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luvio-0003OJ-Hm
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 23:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbZDQVdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 17:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbZDQVdj
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 17:33:39 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:46104 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922AbZDQVdi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 17:33:38 -0400
Received: from [172.23.170.141] (helo=anti-virus02-08)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Luvgm-00045S-7T; Fri, 17 Apr 2009 22:33:36 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Luvgg-0004qE-Mi; Fri, 17 Apr 2009 22:33:30 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 4075851836; Fri, 17 Apr 2009 22:33:30 +0100 (BST)
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
In-Reply-To: <18920.32172.162401.593355@cargo.ozlabs.ibm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116790>


  This patch applies the saved pane sizes for the ttk widgets. The
  ttk paned window does not have a paneconfigure subcommand but we
  can set the sash position once the widget gets mapped.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 053b1a0..8c6a239 100755
--- a/gitk
+++ b/gitk
@@ -2326,6 +2326,17 @@ proc makewindow {} {
         set ::BM "2"
     }
 
+    if {$use_ttk} {
+        bind .ctop <Map> {
+            bind %W <Map> {}
+            %W sashpos 0 $::geometry(topheight)
+        }
+        bind .pwbottom <Map> {
+            bind %W <Map> {}
+            %W sashpos 0 $::geometry(botwidth)
+        }
+    }
+
     bind .pwbottom <Configure> {resizecdetpanes %W %w}
     pack .ctop -fill both -expand 1
     bindall <1> {selcanvline %W %x %y}
-- 
1.6.2.2.1669.g7eaf8
