From: Max Kirillov <max@max630.net>
Subject: [PATCH 1/3] gitk refactor: remove boilerplate for configuration variables
Date: Thu, 11 Sep 2014 08:21:26 +0300
Message-ID: <1410412888-10187-2-git-send-email-max@max630.net>
References: <1410412888-10187-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 07:22:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRwpn-0002YO-4D
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 07:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbaIKFWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 01:22:07 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:51632
	"EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752011AbaIKFWF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 01:22:05 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-02.prod.phx3.secureserver.net with 
	id phMx1o00J5B68XE01hN3bG; Wed, 10 Sep 2014 22:22:04 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <1410412888-10187-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256835>

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 88 ++++++++++++++++----------------------------------------------------
 1 file changed, 20 insertions(+), 68 deletions(-)

diff --git a/gitk b/gitk
index 6fb6cb3..6069afe 100755
--- a/gitk
+++ b/gitk
@@ -2805,23 +2805,11 @@ proc doprogupdate {} {
 }
 
 proc savestuff {w} {
-    global canv canv2 canv3 mainfont textfont uifont tabstop
-    global stuffsaved findmergefiles maxgraphpct
-    global maxwidth showneartags showlocalchanges
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
-    global cmitmode wrapcomment datetimeformat limitdiffs
-    global colors uicolor bgcolor fgcolor diffcolors diffcontext selectbgcolor
-    global uifgcolor uifgdisabledcolor
-    global headbgcolor headfgcolor headoutlinecolor remotebgcolor
-    global tagbgcolor tagfgcolor tagoutlinecolor
-    global reflinecolor filesepbgcolor filesepfgcolor
-    global mergecolors foundbgcolor currentsearchhitbgcolor
-    global linehoverbgcolor linehoverfgcolor linehoveroutlinecolor circlecolors
-    global mainheadcirclecolor workingfilescirclecolor indexcirclecolor
-    global linkfgcolor circleoutlinecolor
-    global autoselect autosellen extdifftool perfile_attrs markbgcolor use_ttk
-    global hideremotes want_ttk maxrefs visiblerefs
+    global use_ttk
+    global stuffsaved
     global config_file config_file_tmp
+    global config_variables
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -2833,59 +2821,10 @@ proc savestuff {w} {
 	if {$::tcl_platform(platform) eq {windows}} {
 	    file attributes $config_file_tmp -hidden true
 	}
-	puts $f [list set mainfont $mainfont]
-	puts $f [list set textfont $textfont]
-	puts $f [list set uifont $uifont]
-	puts $f [list set tabstop $tabstop]
-	puts $f [list set findmergefiles $findmergefiles]
-	puts $f [list set maxgraphpct $maxgraphpct]
-	puts $f [list set maxwidth $maxwidth]
-	puts $f [list set cmitmode $cmitmode]
-	puts $f [list set wrapcomment $wrapcomment]
-	puts $f [list set autoselect $autoselect]
-	puts $f [list set autosellen $autosellen]
-	puts $f [list set showneartags $showneartags]
-	puts $f [list set maxrefs $maxrefs]
-	puts $f [list set visiblerefs $visiblerefs]
-	puts $f [list set hideremotes $hideremotes]
-	puts $f [list set showlocalchanges $showlocalchanges]
-	puts $f [list set datetimeformat $datetimeformat]
-	puts $f [list set limitdiffs $limitdiffs]
-	puts $f [list set uicolor $uicolor]
-	puts $f [list set want_ttk $want_ttk]
-	puts $f [list set bgcolor $bgcolor]
-	puts $f [list set fgcolor $fgcolor]
-	puts $f [list set uifgcolor $uifgcolor]
-	puts $f [list set uifgdisabledcolor $uifgdisabledcolor]
-	puts $f [list set colors $colors]
-	puts $f [list set diffcolors $diffcolors]
-	puts $f [list set mergecolors $mergecolors]
-	puts $f [list set markbgcolor $markbgcolor]
-	puts $f [list set diffcontext $diffcontext]
-	puts $f [list set selectbgcolor $selectbgcolor]
-	puts $f [list set foundbgcolor $foundbgcolor]
-	puts $f [list set currentsearchhitbgcolor $currentsearchhitbgcolor]
-	puts $f [list set extdifftool $extdifftool]
-	puts $f [list set perfile_attrs $perfile_attrs]
-	puts $f [list set headbgcolor $headbgcolor]
-	puts $f [list set headfgcolor $headfgcolor]
-	puts $f [list set headoutlinecolor $headoutlinecolor]
-	puts $f [list set remotebgcolor $remotebgcolor]
-	puts $f [list set tagbgcolor $tagbgcolor]
-	puts $f [list set tagfgcolor $tagfgcolor]
-	puts $f [list set tagoutlinecolor $tagoutlinecolor]
-	puts $f [list set reflinecolor $reflinecolor]
-	puts $f [list set filesepbgcolor $filesepbgcolor]
-	puts $f [list set filesepfgcolor $filesepfgcolor]
-	puts $f [list set linehoverbgcolor $linehoverbgcolor]
-	puts $f [list set linehoverfgcolor $linehoverfgcolor]
-	puts $f [list set linehoveroutlinecolor $linehoveroutlinecolor]
-	puts $f [list set mainheadcirclecolor $mainheadcirclecolor]
-	puts $f [list set workingfilescirclecolor $workingfilescirclecolor]
-	puts $f [list set indexcirclecolor $indexcirclecolor]
-	puts $f [list set circlecolors $circlecolors]
-	puts $f [list set linkfgcolor $linkfgcolor]
-	puts $f [list set circleoutlinecolor $circleoutlinecolor]
+	foreach var_name $config_variables {
+	    upvar #0 $var_name var
+	    puts $f [list set $var_name $var]
+	}
 
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(state) [wm state .]"
@@ -12649,6 +12588,19 @@ catch {
     source $config_file
 }
 
+set config_variables {
+    mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
+    cmitmode wrapcomment autoselect autosellen showneartags maxrefs visiblerefs
+    hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk
+    bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors mergecolors
+    markbgcolor diffcontext selectbgcolor foundbgcolor currentsearchhitbgcolor
+    extdifftool perfile_attrs headbgcolor headfgcolor headoutlinecolor
+    remotebgcolor tagbgcolor tagfgcolor tagoutlinecolor reflinecolor
+    filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
+    linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
+    indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
+}
+
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
 eval font create mainfontbold [fontflags mainfont 1]
-- 
2.0.1.1697.g73c6810
