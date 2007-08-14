From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH] gitk: Make the date/time display configurable
Date: Tue, 14 Aug 2007 22:02:04 +0200
Message-ID: <11871217241055-git-send-email-arjen@yaph.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Arjen Laarhoven <arjen@yaph.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:15:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL2np-0004ut-LN
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 22:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbXHNUP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 16:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756025AbXHNUPZ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 16:15:25 -0400
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:2212 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbXHNUPY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 16:15:24 -0400
X-Greylist: delayed 779 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2007 16:15:24 EDT
Received: from libellus.local (aragorndsl.demon.nl [82.161.19.32])
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id l7EK1u2q002137;
	Tue, 14 Aug 2007 22:02:02 +0200 (CEST)
	(envelope-from arjen@yaph.org)
Received: by libellus.local (Postfix, from userid 501)
	id 6CF8016B828; Tue, 14 Aug 2007 22:02:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc4.67.gf9286
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55855>

The new 'datetimeformat' configuration variable in ~/.gitk can be set
to a Tcl 'clock format' format string to modify the display of dates
and times.

http://www.tcl.tk/man/tcl8.4/TclCmd/clock.htm has a list of allowed
fields.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 gitk |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index f74ce51..98bee51 100755
--- a/gitk
+++ b/gitk
@@ -967,7 +967,7 @@ proc savestuff {w} {
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth showneartags showlocalchanges
     global viewname viewfiles viewargs viewperm nextviewnum
-    global cmitmode wrapcomment
+    global cmitmode wrapcomment datetimeformat
     global colors bgcolor fgcolor diffcolors selectbgcolor
 
     if {$stuffsaved} return
@@ -985,6 +985,7 @@ proc savestuff {w} {
 	puts $f [list set wrapcomment $wrapcomment]
 	puts $f [list set showneartags $showneartags]
 	puts $f [list set showlocalchanges $showlocalchanges]
+	puts $f [list set datetimeformat $datetimeformat]
 	puts $f [list set bgcolor $bgcolor]
 	puts $f [list set fgcolor $fgcolor]
 	puts $f [list set colors $colors]
@@ -7249,8 +7250,9 @@ proc prefsok {} {
 }
 
 proc formatdate {d} {
+    global datetimeformat
     if {$d ne {}} {
-	set d [clock format $d -format "%Y-%m-%d %H:%M:%S"]
+	set d [clock format $d -format $datetimeformat]
     }
     return $d
 }
@@ -7563,6 +7565,7 @@ set showneartags 1
 set maxrefs 20
 set maxlinelen 200
 set showlocalchanges 1
+set datetimeformat "%Y-%m-%d %H:%M:%S"
 
 set colors {green red blue magenta darkgrey brown orange}
 set bgcolor white
-- 
1.5.3.rc4.67.gf9286
