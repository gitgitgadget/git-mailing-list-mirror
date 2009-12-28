From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 5/5] gitk: Use consistent font for all text input fields
Date: Mon, 28 Dec 2009 20:04:03 +0000
Message-ID: <1262030643-12952-5-git-send-email-mark@pogo.org.uk>
References: <1262030643-12952-1-git-send-email-mark@pogo.org.uk>
 <1262030643-12952-2-git-send-email-mark@pogo.org.uk>
 <1262030643-12952-3-git-send-email-mark@pogo.org.uk>
 <1262030643-12952-4-git-send-email-mark@pogo.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 21:31:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPMFJ-0006Za-CR
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 21:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbZL1UbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 15:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbZL1UbE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 15:31:04 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58974 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750988AbZL1UbB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 15:31:01 -0500
X-Greylist: delayed 1610 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2009 15:31:00 EST
Received: from host86-131-13-173.range86-131.btcentralplus.com ([86.131.13.173] helo=vega)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NPLp3-0001rv-Us; Mon, 28 Dec 2009 20:04:10 +0000
Received: from mark by vega with local (Exim 4.69)
	(envelope-from <mark@vega>)
	id 1NPLoy-0003Nf-QK; Mon, 28 Dec 2009 20:04:04 +0000
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262030643-12952-4-git-send-email-mark@pogo.org.uk>
X-SA-Exim-Connect-IP: 86.131.13.173
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135756>

Instead of setting the font for specific widgets, set the font for the
widget type. If themed widgets are not available, this is via the X
resources. If themed widgets are available, the theme font is used.

The exception is the SHA1 ID which is forced to use the fixed-width
font, even where themed widgets are used.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk-git/gitk |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5008753..13da663 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1874,7 +1874,8 @@ proc setoptions {} {
     option add *Menubutton.font uifont startupFile
     option add *Label.font uifont startupFile
     option add *Message.font uifont startupFile
-    option add *Entry.font uifont startupFile
+    option add *Entry.font textfont startupFile
+    option add *Text.font textfont startupFile
     option add *Labelframe.font uifont startupFile
     option add *Spinbox.font textfont startupFile
     option add *Listbox.font mainfont startupFile
@@ -2173,7 +2174,7 @@ proc makewindow {} {
     set findstring {}
     set fstring .tf.lbar.findstring
     lappend entries $fstring
-    ${NS}::entry $fstring -width 30 -font textfont -textvariable findstring
+    ${NS}::entry $fstring -width 30 -textvariable findstring
     trace add variable findstring write find_change
     set findtype [mc "Exact"]
     set findtypemenu [makedroplist .tf.lbar.findtype \
@@ -2216,7 +2217,7 @@ proc makewindow {} {
     pack .bleft.top.search -side left -padx 5
     set sstring .bleft.top.sstring
     set searchstring ""
-    ${NS}::entry $sstring -width 20 -font textfont -textvariable searchstring
+    ${NS}::entry $sstring -width 20 -textvariable searchstring
     lappend entries $sstring
     trace add variable searchstring write incrsearch
     pack $sstring -side left -expand 1 -fill x
@@ -4036,7 +4037,7 @@ proc vieweditor {top n title} {
 	} elseif {$type eq "path"} {
 	    ${NS}::label $top.l -text $title
 	    pack $top.l -in $top -side top -pady [list 3 0] -anchor w -padx 3
-	    text $top.t -width 40 -height 5 -background $bgcolor -font uifont
+	    text $top.t -width 40 -height 5 -background $bgcolor
 	    if {[info exists viewfiles($n)]} {
 		foreach f $viewfiles($n) {
 		    $top.t insert end $f
-- 
1.6.6
