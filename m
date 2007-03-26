From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH 3/5] Chase remaining default font errors in the gitk dialogs.
Date: Mon, 26 Mar 2007 11:38:34 +0400
Message-ID: <20070326073834.GG44578@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 09:38:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVjn3-0005BH-94
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 09:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbXCZHil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 03:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933644AbXCZHil
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 03:38:41 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:54685 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933641AbXCZHik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 03:38:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=epDCGm6D2ojiutUuNNlJ7OCNJzK0k1mFO9AzRgUAlUX+ZOS917G2w78j91gr62dmtg3Gpx/Vs5z6y9l/LCtkH9Uu2C+a8lHlyMr4omvN1mYRlPEbcsvhEXpZP/SKnp4XyXZzidfmVPOTSZ/3gJdZQEumkSYh/hvEkLVfG9z4tAo=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HVjmo-000BdC-QF for git@vger.kernel.org; Mon, 26 Mar 2007 11:38:39 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43123>

The dialog activated by the "View/New view..." menu entry was fixed
to respect the default UI font for its elements.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 gitk |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index e4d3bf4..f54ff27 100755
--- a/gitk
+++ b/gitk
@@ -1465,20 +1465,21 @@ proc vieweditor {top n title} {
     toplevel $top
     wm title $top $title
     label $top.nl -text "Name" -font $uifont
-    entry $top.name -width 20 -textvariable newviewname($n)
+    entry $top.name -width 20 -textvariable newviewname($n) -font $uifont
     grid $top.nl $top.name -sticky w -pady 5
-    checkbutton $top.perm -text "Remember this view" -variable newviewperm($n)
+    checkbutton $top.perm -text "Remember this view" -variable newviewperm($n) \
+	-font $uifont
     grid $top.perm - -pady 5 -sticky w
     message $top.al -aspect 1000 -font $uifont \
 	-text "Commits to include (arguments to git rev-list):"
     grid $top.al - -sticky w -pady 5
     entry $top.args -width 50 -textvariable newviewargs($n) \
-	-background white
+	-background white -font $uifont
     grid $top.args - -sticky ew -padx 5
     message $top.l -aspect 1000 -font $uifont \
 	-text "Enter files and directories to include, one per line:"
     grid $top.l - -sticky w
-    text $top.t -width 40 -height 10 -background white
+    text $top.t -width 40 -height 10 -background white -font $uifont
     if {[info exists viewfiles($n)]} {
 	foreach f $viewfiles($n) {
 	    $top.t insert end $f
@@ -1489,8 +1490,10 @@ proc vieweditor {top n title} {
     }
     grid $top.t - -sticky ew -padx 5
     frame $top.buts
-    button $top.buts.ok -text "OK" -command [list newviewok $top $n]
-    button $top.buts.can -text "Cancel" -command [list destroy $top]
+    button $top.buts.ok -text "OK" -command [list newviewok $top $n] \
+	-font $uifont
+    button $top.buts.can -text "Cancel" -command [list destroy $top] \
+	-font $uifont
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
-- 
1.5.0.3-dirty
