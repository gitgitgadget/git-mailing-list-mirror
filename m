From: David Fries <david@fries.net>
Subject: [PATCH 1/3] gitk: improve dark background, s/black/$fgcolor/
Date: Thu, 22 Jul 2010 18:10:36 -0500
Message-ID: <20100722231036.GA25144@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 01:10:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc4ua-0004qm-Rd
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 01:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab0GVXKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 19:10:39 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:47492 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0GVXKi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 19:10:38 -0400
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o6MNAaah025195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 22 Jul 2010 18:10:37 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id o6MNAa2G025194
	for git@vger.kernel.org; Thu, 22 Jul 2010 18:10:36 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (SpacedOut.fries.net [127.0.0.1]); Thu, 22 Jul 2010 18:10:37 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151494>

Replace most uses of black with $fgcolor as items such as a black
outline on the tag or tag lines with a black background doesn't show
up.  Use $fgcolor instead to make it contrast with the background.
---
 gitk-git/gitk |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1b0e09a..8ca7182 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6270,7 +6270,7 @@ proc drawtags {id x xt y1} {
 	set xt [expr {$xt + $delta + $wid + $lthickness + $linespc}]
     }
     set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
-	       -width $lthickness -fill black -tags tag.$id]
+	       -width $lthickness -fill $fgcolor -tags tag.$id]
     $canv lower $t
     foreach tag $marks x $xvals wid $wvals {
 	set xl [expr {$x + $delta}]
@@ -6280,7 +6280,7 @@ proc drawtags {id x xt y1} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
-		       -width 1 -outline black -fill yellow -tags tag.$id]
+		       -width 1 -outline $fgcolor -fill yellow -tags tag.$id]
 	    $canv bind $t <1> [list showtag $tag 1]
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
@@ -6295,7 +6295,7 @@ proc drawtags {id x xt y1} {
 	    }
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
-		-width 1 -outline black -fill $col -tags tag.$id
+		-width 1 -outline $fgcolor -fill $col -tags tag.$id
 	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
 	        set rwid [font measure mainfont $remoteprefix]
 		set xi [expr {$x + 1}]
@@ -8215,6 +8215,7 @@ proc linehover {} {
     global hoverx hovery hoverid hovertimer
     global canv linespc lthickness
     global commitinfo
+    global fgcolor
 
     set text [lindex $commitinfo($hoverid) 0]
     set ymax [lindex [$canv cget -scrollregion] 3]
@@ -8227,7 +8228,7 @@ proc linehover {} {
     set x1 [expr {$x + [font measure mainfont $text] + 2 * $lthickness}]
     set y1 [expr {$y + $linespc + 2 * $lthickness}]
     set t [$canv create rectangle $x0 $y0 $x1 $y1 \
-	       -fill \#ffff80 -outline black -width 1 -tags hover]
+	       -fill \#ffff80 -outline $fgcolor -width 1 -tags hover]
     $canv raise $t
     set t [$canv create text $x $y -anchor nw -text $text -tags hover \
 	       -font mainfont]
-- 
1.7.1
