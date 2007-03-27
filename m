From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH 2/2] Improve look-and-feel of the gitk tool.
Date: Tue, 27 Mar 2007 14:36:59 +0400
Message-ID: <20070327103659.GY14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Mar 27 12:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW939-0005Eg-3G
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbXC0KhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 06:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786AbXC0KhH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:37:07 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:55059 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbXC0KhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:37:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:Content-Disposition:Content-Transfer-Encoding:Sender:X-Spam-Status:Subject;
	b=K0LDXnCVZKOAwqBvbzR2vmeUaPeL6G5GJmXZTg56OhzXaWEXqsZkTmCJ5Q5m6u1Gf0QXk2jWkF1RWOBPTgkAD/qnJfS4DM8WdqwWPx1Zwd9LWmce4HpfHuivMZjZYAwU1IXM3Ro/n3SfH94wP5TdK+rdXLhpD2R7IOxVizP3ODI=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW932-000Dbb-1F; Tue, 27 Mar 2007 14:37:04 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43256>

Made the default buttons on the dialog active and focused upon the
dialog appearence.

Bound 'Escape' and 'Return' keys to the dialog dismissal where it
was appropriate: mainly for dialogs with only one button and no
editable fields.

Unified the look of the "About gitk" and "Key bindings" dialogs.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 gitk |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/gitk b/gitk
index f54ff27..0173660 100755
--- a/gitk
+++ b/gitk
@@ -938,12 +938,15 @@ Gitk - a commit viewer for git
 Copyright =A9 2005-2006 Paul Mackerras
=20
 Use and redistribute under the terms of the GNU General Public License=
} \
-	    -justify center -aspect 400
-    pack $w.m -side top -fill x -padx 20 -pady 20
+	    -justify center -aspect 400 -border 2 -bg white -relief groove
+    pack $w.m -side top -fill x -padx 2 -pady 2
     $w.m configure -font $uifont
-    button $w.ok -text Close -command "destroy $w"
+    button $w.ok -text Close -command "destroy $w" -default active
     pack $w.ok -side bottom
     $w.ok configure -font $uifont
+    bind $w <Visibility> "focus $w.ok"
+    bind $w <Key-Escape> "destroy $w"
+    bind $w <Key-Return> "destroy $w"
 }
=20
 proc keys {} {
@@ -994,12 +997,15 @@ f		Scroll diff view to next file
 <Ctrl-minus>	Decrease font size
 <F5>		Update
 } \
-	    -justify left -bg white -border 2 -relief sunken
-    pack $w.m -side top -fill both
+	    -justify left -bg white -border 2 -relief groove
+    pack $w.m -side top -fill both -padx 2 -pady 2
     $w.m configure -font $uifont
-    button $w.ok -text Close -command "destroy $w"
+    button $w.ok -text Close -command "destroy $w" -default active
     pack $w.ok -side bottom
     $w.ok configure -font $uifont
+    bind $w <Visibility> "focus $w.ok"
+    bind $w <Key-Escape> "destroy $w"
+    bind $w <Key-Return> "destroy $w"
 }
=20
 # Procedures for manipulating the file list window at the
@@ -5892,14 +5898,15 @@ proc doprefs {} {
     grid x $top.hunksepbut $top.hunksep -sticky w
=20
     frame $top.buts
-    button $top.buts.ok -text "OK" -command prefsok
+    button $top.buts.ok -text "OK" -command prefsok -default active
     $top.buts.ok configure -font $uifont
-    button $top.buts.can -text "Cancel" -command prefscan
+    button $top.buts.can -text "Cancel" -command prefscan -default nor=
mal
     $top.buts.can configure -font $uifont
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - - -pady 10 -sticky ew
+    bind $top <Visibility> "focus $top.buts.ok"
 }
=20
 proc choosecolor {v vi w x cmd} {
--=20
1.5.0.3-dirty
