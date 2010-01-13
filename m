From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 5/5] gitk: Use consistent font for all text input fields
Date: Wed, 13 Jan 2010 20:40:22 +0000
Message-ID: <1263415222-5911-5-git-send-email-mark@pogo.org.uk>
References: <alpine.NEB.2.01.1001132030010.15349@jrf.vwaro.pbz>
 <1263415222-5911-1-git-send-email-mark@pogo.org.uk>
 <1263415222-5911-2-git-send-email-mark@pogo.org.uk>
 <1263415222-5911-3-git-send-email-mark@pogo.org.uk>
 <1263415222-5911-4-git-send-email-mark@pogo.org.uk>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:41:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVA1C-0003qp-Jq
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118Ab0AMUka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328Ab0AMUk1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:40:27 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58970 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755322Ab0AMUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:40:25 -0500
Received: from cpc1-acto2-0-0-cust60.4-2.cable.virginmedia.com ([82.28.218.61] helo=stax.localdomain)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NVA0t-00030S-GJ; Wed, 13 Jan 2010 20:40:23 +0000
Received: from mark by stax.localdomain with local (Exim 4.69)
	(envelope-from <mark@stax.localdomain>)
	id 1NVA0s-0001Y0-TT; Wed, 13 Jan 2010 20:40:22 +0000
X-Mailer: git-send-email 1.6.6.5.ge408
In-Reply-To: <1263415222-5911-4-git-send-email-mark@pogo.org.uk>
X-SA-Exim-Connect-IP: 82.28.218.61
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136881>

Instead of setting the font for specific widgets, set the font for the
widget type. If themed widgets are not available, this is via the X
resources. If themed widgets are available, the theme font is used.

The exception is the SHA1 ID which is forced to use the fixed-width
font, even where themed widgets are used.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 54f4fb3..1f5f456 100755
--- a/gitk
+++ b/gitk
@@ -1877,7 +1877,8 @@ proc setoptions {} {
     option add *Menubutton.font uifont startupFile
     option add *Label.font uifont startupFile
     option add *Message.font uifont startupFile
-    option add *Entry.font uifont startupFile
+    option add *Entry.font textfont startupFile
+    option add *Text.font textfont startupFile
     option add *Labelframe.font uifont startupFile
     option add *Spinbox.font textfont startupFile
     option add *Listbox.font mainfont startupFile
@@ -2176,7 +2177,7 @@ proc makewindow {} {
     set findstring {}
     set fstring .tf.lbar.findstring
     lappend entries $fstring
-    ${NS}::entry $fstring -width 30 -font textfont -textvariable findstring
+    ${NS}::entry $fstring -width 30 -textvariable findstring
     trace add variable findstring write find_change
     set findtype [mc "Exact"]
     set findtypemenu [makedroplist .tf.lbar.findtype \
@@ -2219,7 +2220,7 @@ proc makewindow {} {
     pack .bleft.top.search -side left -padx 5
     set sstring .bleft.top.sstring
     set searchstring ""
-    ${NS}::entry $sstring -width 20 -font textfont -textvariable searchstring
+    ${NS}::entry $sstring -width 20 -textvariable searchstring
     lappend entries $sstring
     trace add variable searchstring write incrsearch
     pack $sstring -side left -expand 1 -fill x
@@ -4039,7 +4040,7 @@ proc vieweditor {top n title} {
 	} elseif {$type eq "path"} {
 	    ${NS}::label $top.l -text $title
 	    pack $top.l -in $top -side top -pady [list 3 0] -anchor w -padx 3
-	    text $top.t -width 40 -height 5 -background $bgcolor -font uifont
+	    text $top.t -width 40 -height 5 -background $bgcolor
 	    if {[info exists viewfiles($n)]} {
 		foreach f $viewfiles($n) {
 		    $top.t insert end $f
-- 
1.6.6.5.ge408
