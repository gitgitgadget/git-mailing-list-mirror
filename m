From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH] gitk: adding a horizontal scrollbar to the diff window.
Date: Sun, 24 Feb 2008 21:08:42 +0100
Organization: -no organization-
Message-ID: <20080224200842.GA8052@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 21:09:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTNAH-0000dG-Si
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 21:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbYBXUIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 15:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbYBXUIs
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 15:08:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:63887 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbYBXUIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 15:08:47 -0500
Received: from scotty.home (p54862986.dip0.t-ipconnect.de [84.134.41.134])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1JTN9P3zBl-0005hC; Sun, 24 Feb 2008 21:08:44 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.8/8.13.8/Debian-3) with ESMTP id m1OK8g3X012083;
	Sun, 24 Feb 2008 21:08:42 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.8/8.13.8/Submit) id m1OK8g4S012080;
	Sun, 24 Feb 2008 21:08:42 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
X-Mailer: Mutt 1.5.16 http://www.mutt.org/
X-Editor: GNU Emacs 22.1.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C
	F986 E4FC D563
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on scotty.home
X-Virus-Scanned: ClamAV 0.92.1/5972/Sun Feb 24 20:03:09 2008 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX19anfJcPkV/jfjiSMa95V6U0RUflnv4TrVLxlR
 evyDl2LjBq9T/mGVK1RiVyldYKV/SlzYsrSgxhUZSPrTnerF5H
 nKwPeNNDxk/cOZrjpv3lcNvB2skJin4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74957>

This patch makes the "unvisible horizontal scroll" feature of
the diff window visible by adding a horizontal scrollbar at the
bottom of that window.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 gitk-git/gitk |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f1f21e9..a7087a9 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -857,14 +857,17 @@ proc makewindow {} {
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
+	-xscrollcommand ".bleft.xsb set" \
 	-yscrollcommand scrolltext -wrap none
     if {$have_tk85} {
 	$ctext conf -tabstyle wordprocessor
     }
-    scrollbar .bleft.sb -command "$ctext yview"
+    scrollbar .bleft.ysb -command "$ctext yview"
+    scrollbar .bleft.xsb -command "$ctext xview" -orient horizontal
     pack .bleft.top -side top -fill x
     pack .bleft.mid -side top -fill x
-    pack .bleft.sb -side right -fill y
+    pack .bleft.ysb -side right -fill y
+    pack .bleft.xsb -side bottom -fill x
     pack $ctext -side left -fill both -expand 1
     lappend bglist $ctext
     lappend fglist $ctext
@@ -5604,7 +5607,7 @@ proc searchmarkvisible {doall} {
 proc scrolltext {f0 f1} {
     global searchstring
 
-    .bleft.sb set $f0 $f1
+    .bleft.ysb set $f0 $f1
     if {$searchstring ne {}} {
 	searchmarkvisible 0
     }
-- 
1.5.4.2.198.g3f625


-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			

Please note that according to the German law on data retention,
information on every electronic information exchange with me is
retained for a period of six months.
Bundesgesetzblatt:
http://www.bgblportal.de/BGBL/bgbl1f/bgbl107s3198.pdf
