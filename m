From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH 1/5] Consistently use user-defined UI font everywhere in GUI tools.
Date: Mon, 26 Mar 2007 11:37:15 +0400
Message-ID: <20070326073715.GE44578@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 09:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVjlf-0004Si-8j
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 09:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbXCZHhY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 26 Mar 2007 03:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbXCZHhY
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 03:37:24 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:59561 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583AbXCZHhX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 03:37:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Message-ID:MIME-Version:Content-Type:Content-Disposition:Content-Transfer-Encoding:Sender:X-Spam-Status:Subject;
	b=Ya7hrmKg6lyKuu6XCb/ZENLpHbhujmRrHyvZiX5ZWJQsg19rCVN7xxMCDKYq1ADQ2dwxE7e9EteJ62qpTUSSVNCE18d+hqPL1/Q/cvOsnH27PjVXPwR3dLBunjLh89V16F0hVHkcP0Yc6MN/gOCSSHtmrYNNX1x4zy9NPMp7/Z0=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HVjlY-000Bcq-8e for git@vger.kernel.org; Mon, 26 Mar 2007 11:37:22 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-0.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50,
	LONGWORDS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43121>

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git-gui/git-gui.sh |   64 ++++++++++++++++++++++++++++++++++++--------=
-------
 gitk               |   14 +++++++++++
 2 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 60e79ca..8157184 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -242,6 +242,8 @@ proc error_popup {msg} {
 	if {[reponame] ne {}} {
 		append title " ([reponame])"
 	}
+	option add *Dialog.msg.font font_ui
+	option add *Button.font font_ui
 	set cmd [list tk_messageBox \
 		-icon error \
 		-type ok \
@@ -258,6 +260,8 @@ proc warn_popup {msg} {
 	if {[reponame] ne {}} {
 		append title " ([reponame])"
 	}
+	option add *Dialog.msg.font font_ui
+	option add *Button.font font_ui
 	set cmd [list tk_messageBox \
 		-icon warning \
 		-type ok \
@@ -274,6 +278,8 @@ proc info_popup {msg {parent .}} {
 	if {[reponame] ne {}} {
 		append title " ([reponame])"
 	}
+	option add *Dialog.msg.font font_ui
+	option add *Button.font font_ui
 	tk_messageBox \
 		-parent $parent \
 		-icon info \
@@ -287,6 +293,8 @@ proc ask_popup {msg} {
 	if {[reponame] ne {}} {
 		append title " ([reponame])"
 	}
+	option add *Dialog.msg.font font_ui
+	option add *Button.font font_ui
 	return [tk_messageBox \
 		-parent . \
 		-icon question \
@@ -2116,7 +2124,10 @@ proc do_create_branch {} {
 		-value head \
 		-variable create_branch_revtype \
 		-font font_ui
-	eval tk_optionMenu $w.from.head_m create_branch_head $all_heads
+	set lbranchm [eval tk_optionMenu $w.from.head_m create_branch_head \
+		$all_heads]
+	$lbranchm configure -font font_ui
+	$w.from.head_m configure -font font_ui
 	grid $w.from.head_r $w.from.head_m -sticky w
 	set all_trackings [all_tracking_branches]
 	if {$all_trackings ne {}} {
@@ -2126,9 +2137,11 @@ proc do_create_branch {} {
 			-value tracking \
 			-variable create_branch_revtype \
 			-font font_ui
-		eval tk_optionMenu $w.from.tracking_m \
+		set tbranchm [eval tk_optionMenu $w.from.tracking_m \
 			create_branch_trackinghead \
-			$all_trackings
+			$all_trackings]
+		$tbranchm configure -font font_ui
+		$w.from.tracking_m configure -font font_ui
 		grid $w.from.tracking_r $w.from.tracking_m -sticky w
 	}
 	set all_tags [load_all_tags]
@@ -2139,9 +2152,11 @@ proc do_create_branch {} {
 			-value tag \
 			-variable create_branch_revtype \
 			-font font_ui
-		eval tk_optionMenu $w.from.tag_m \
+		set tagsm [eval tk_optionMenu $w.from.tag_m \
 			create_branch_tag \
-			$all_tags
+			$all_tags]
+		$tagsm configure -font font_ui
+		$w.from.tag_m configure -font font_ui
 		grid $w.from.tag_r $w.from.tag_m -sticky w
 	}
 	radiobutton $w.from.exp_r \
@@ -2335,7 +2350,11 @@ proc do_delete_branch {} {
 		-value head \
 		-variable delete_branch_checktype \
 		-font font_ui
-	eval tk_optionMenu $w.validate.head_m delete_branch_head $all_heads
+	set mergedlocalm [eval tk_optionMenu $w.validate.head_m \
+		delete_branch_head \
+		$all_heads]
+	$mergedlocalm configure -font font_ui
+	$w.validate.head_m configure -font font_ui
 	grid $w.validate.head_r $w.validate.head_m -sticky w
 	set all_trackings [all_tracking_branches]
 	if {$all_trackings ne {}} {
@@ -2345,9 +2364,11 @@ proc do_delete_branch {} {
 			-value tracking \
 			-variable delete_branch_checktype \
 			-font font_ui
-		eval tk_optionMenu $w.validate.tracking_m \
+		set mergedtrackm [eval tk_optionMenu $w.validate.tracking_m \
 			delete_branch_trackinghead \
-			$all_trackings
+			$all_trackings]
+		$mergedtrackm configure -font font_ui
+		$w.validate.tracking_m configure -font font_ui
 		grid $w.validate.tracking_r $w.validate.tracking_m -sticky w
 	}
 	radiobutton $w.validate.always_r \
@@ -2721,7 +2742,10 @@ proc do_push_anywhere {} {
 			-value remote \
 			-variable push_urltype \
 			-font font_ui
-		eval tk_optionMenu $w.dest.remote_m push_remote $all_remotes
+		set remmenu [eval tk_optionMenu $w.dest.remote_m push_remote \
+			$all_remotes]
+		$remmenu configure -font font_ui
+		$w.dest.remote_m configure -font font_ui
 		grid $w.dest.remote_r $w.dest.remote_m -sticky w
 		if {[lsearch -sorted -exact $all_remotes origin] !=3D -1} {
 			set push_remote origin
@@ -4686,9 +4710,11 @@ proc do_options {} {
 		frame $w.global.$name
 		label $w.global.$name.l -text "$text:" -font font_ui
 		pack $w.global.$name.l -side left -anchor w -fill x
-		eval tk_optionMenu $w.global.$name.family \
+		set fontmenu [eval tk_optionMenu $w.global.$name.family \
 			global_config_new(gui.$font^^family) \
-			$all_fonts
+			$all_fonts]
+		$w.global.$name.family configure -font font_ui
+		$fontmenu configure -font font_ui
 		spinbox $w.global.$name.size \
 			-textvariable global_config_new(gui.$font^^size) \
 			-from 2 -to 80 -increment 1 \
@@ -5083,18 +5109,18 @@ set ui_comm {}
 # -- Menu Bar
 #
 menu .mbar -tearoff 0
-.mbar add cascade -label Repository -menu .mbar.repository
-.mbar add cascade -label Edit -menu .mbar.edit
+.mbar add cascade -label Repository -menu .mbar.repository -font font_=
ui
+.mbar add cascade -label Edit -menu .mbar.edit -font font_ui
 if {[is_enabled branch]} {
-	.mbar add cascade -label Branch -menu .mbar.branch
+	.mbar add cascade -label Branch -menu .mbar.branch -font font_ui
 }
 if {[is_enabled multicommit] || [is_enabled singlecommit]} {
-	.mbar add cascade -label Commit -menu .mbar.commit
+	.mbar add cascade -label Commit -menu .mbar.commit -font font_ui
 }
 if {[is_enabled transport]} {
-	.mbar add cascade -label Merge -menu .mbar.merge
-	.mbar add cascade -label Fetch -menu .mbar.fetch
-	.mbar add cascade -label Push -menu .mbar.push
+	.mbar add cascade -label Merge -menu .mbar.merge -font font_ui
+	.mbar add cascade -label Fetch -menu .mbar.fetch -font font_ui
+	.mbar add cascade -label Push -menu .mbar.push -font font_ui
 }
 . configure -menu .mbar
=20
@@ -5370,7 +5396,7 @@ if {[is_MacOSX]} {
=20
 # -- Help Menu
 #
-.mbar add cascade -label Help -menu .mbar.help
+.mbar add cascade -label Help -menu .mbar.help -font font_ui
 menu .mbar.help
=20
 if {![is_MacOSX]} {
diff --git a/gitk b/gitk
index 1cd2a8f..e4d3bf4 100755
--- a/gitk
+++ b/gitk
@@ -648,8 +648,10 @@ proc makewindow {} {
     frame .bright.mode
     radiobutton .bright.mode.patch -text "Patch" \
 	-command reselectline -variable cmitmode -value "patch"
+    .bright.mode.patch configure -font $uifont
     radiobutton .bright.mode.tree -text "Tree" \
 	-command reselectline -variable cmitmode -value "tree"
+    .bright.mode.tree configure -font $uifont
     grid .bright.mode.patch .bright.mode.tree -sticky ew
     pack .bright.mode -side top -fill x
     set cflist .bright.cfiles
@@ -922,6 +924,7 @@ proc bindall {event action} {
 }
=20
 proc about {} {
+    global uifont
     set w .about
     if {[winfo exists $w]} {
 	raise $w
@@ -937,11 +940,14 @@ Copyright =A9 2005-2006 Paul Mackerras
 Use and redistribute under the terms of the GNU General Public License=
} \
 	    -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
+    $w.m configure -font $uifont
     button $w.ok -text Close -command "destroy $w"
     pack $w.ok -side bottom
+    $w.ok configure -font $uifont
 }
=20
 proc keys {} {
+    global uifont
     set w .keys
     if {[winfo exists $w]} {
 	raise $w
@@ -990,8 +996,10 @@ f		Scroll diff view to next file
 } \
 	    -justify left -bg white -border 2 -relief sunken
     pack $w.m -side top -fill both
+    $w.m configure -font $uifont
     button $w.ok -text Close -command "destroy $w"
     pack $w.ok -side bottom
+    $w.ok configure -font $uifont
 }
=20
 # Procedures for manipulating the file list window at the
@@ -5813,6 +5821,7 @@ proc doprefs {} {
     global maxwidth maxgraphpct diffopts
     global oldprefs prefstop showneartags
     global bgcolor fgcolor ctext diffcolors
+    global uifont
=20
     set top .gitkprefs
     set prefstop $top
@@ -5826,6 +5835,7 @@ proc doprefs {} {
     toplevel $top
     wm title $top "Gitk preferences"
     label $top.ldisp -text "Commit list display options"
+    $top.ldisp configure -font $uifont
     grid $top.ldisp - -sticky w -pady 10
     label $top.spacer -text " "
     label $top.maxwidthl -text "Maximum graph width (lines)" \
@@ -5838,6 +5848,7 @@ proc doprefs {} {
     grid x $top.maxpctl $top.maxpct -sticky w
=20
     label $top.ddisp -text "Diff display options"
+    $top.ddisp configure -font $uifont
     grid $top.ddisp - -sticky w -pady 10
     label $top.diffoptl -text "Options for diff program" \
 	-font optionfont
@@ -5850,6 +5861,7 @@ proc doprefs {} {
     grid x $top.ntag -sticky w
=20
     label $top.cdisp -text "Colors: press to choose"
+    $top.cdisp configure -font $uifont
     grid $top.cdisp - -sticky w -pady 10
     label $top.bg -padx 40 -relief sunk -background $bgcolor
     button $top.bgbut -text "Background" -font optionfont \
@@ -5878,7 +5890,9 @@ proc doprefs {} {
=20
     frame $top.buts
     button $top.buts.ok -text "OK" -command prefsok
+    $top.buts.ok configure -font $uifont
     button $top.buts.can -text "Cancel" -command prefscan
+    $top.buts.can configure -font $uifont
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
--=20
1.5.0.3-dirty
