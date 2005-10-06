From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH]: gitk: different shape for other refs
Date: Wed, 05 Oct 2005 21:44:58 -0400
Message-ID: <1128563098.32103.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 06 03:47:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENKp8-0003E2-H0
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 03:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJFBpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 21:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVJFBpG
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 21:45:06 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:3548 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750700AbVJFBpF
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 21:45:05 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ENKoh-0003PD-Ie
	for git@vger.kernel.org; Wed, 05 Oct 2005 21:45:03 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1ENKod-0000kG-2s; Wed, 05 Oct 2005 21:44:59 -0400
To: Paul Mackerras <paulus@samba.org>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9754>

Hello!

It's not unfriendly to distinguish heads and other refs only by color.
Not everybody can distinguish green and blue.  This patch changes the
shape used for other refs to "tabs" with five corners.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -939,15 +939,17 @@ proc drawtags {id x xt y1} {
 	    $canv bind $t <1> [list showtag $tag 1]
 	    set rowtextx($idline($id)) [expr {$xr + $linespc}]
 	} else {
-	    # draw a head or other ref
 	    if {[incr nheads -1] >= 0} {
-		set col green
+		# draw a head
+		set xl [expr $xl - $delta/2]
+		$canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
+		    -width 1 -outline black -fill green -tags tag.$id
 	    } else {
-		set col "#ddddff"
+		# draw other ref
+		$canv create polygon $x [expr $yt + $delta] $xl $yt \
+		    $xr $yt $xr $yb $x $yb \
+		    -width 1 -outline black -fill "#ddddff" -tags tag.$id
 	    }
-	    set xl [expr $xl - $delta/2]
-	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
-		-width 1 -outline black -fill $col -tags tag.$id
 	}
 	set t [$canv create text $xl $y1 -anchor w -text $tag \
 		   -font $mainfont -tags tag.$id]


-- 
Regards,
Pavel Roskin
