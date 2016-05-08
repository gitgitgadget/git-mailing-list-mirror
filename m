From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 2/5] git-gui i18n: internationalize use of colon punctuation
Date: Sun,  8 May 2016 10:52:55 +0000
Message-ID: <1462704778-4722-2-git-send-email-vascomalmeida@sapo.pt>
References: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 12:54:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azMLy-0006aR-Ai
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 12:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbcEHKyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 06:54:14 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:43901 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750798AbcEHKyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 06:54:13 -0400
Received: (qmail 23191 invoked from network); 8 May 2016 10:54:10 -0000
Received: (qmail 14520 invoked from network); 8 May 2016 10:54:10 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 May 2016 10:54:09 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293960>

Internationalize use of colon punctuation ':' in options window, windows
titles, database statistics window. Some languages might use a different
style, for instance French uses "User Name :" (space before colon).

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 lib/branch_delete.tcl | 2 +-
 lib/database.tcl      | 2 +-
 lib/error.tcl         | 2 +-
 lib/option.tcl        | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
index 867938e..9aef0c9 100644
--- a/lib/branch_delete.tcl
+++ b/lib/branch_delete.tcl
@@ -128,7 +128,7 @@ method _delete {} {
 		set b [lindex $i 0]
 		set o [lindex $i 1]
 		if {[catch {git branch -D $b} err]} {
-			append failed " - $b: $err\n"
+			append failed [mc " - %s:" $b] " $err\n"
 		}
 	}
 
diff --git a/lib/database.tcl b/lib/database.tcl
index 1f187ed..8bd4b8e 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -54,7 +54,7 @@ proc do_stats {} {
 			set value "$value[lindex $s 2]"
 		}
 
-		${NS}::label $w.stat.l_$name -text "$label:" -anchor w
+		${NS}::label $w.stat.l_$name -text [mc "%s:" $label] -anchor w
 		${NS}::label $w.stat.v_$name -text $value -anchor w
 		grid $w.stat.l_$name $w.stat.v_$name -sticky we -padx {0 5}
 	}
diff --git a/lib/error.tcl b/lib/error.tcl
index c0fa69a..9b7d229 100644
--- a/lib/error.tcl
+++ b/lib/error.tcl
@@ -113,7 +113,7 @@ proc hook_failed_popup {hook msg {is_fatal 1}} {
 
 	bind $w <Visibility> "grab $w; focus $w"
 	bind $w <Key-Return> "destroy $w"
-	wm title $w [strcat "[appname] ([reponame]): " [mc "error"]]
+	wm title $w [mc "%s (%s): error" [appname] [reponame]]
 	wm deiconify $w
 	tkwait window $w
 }
diff --git a/lib/option.tcl b/lib/option.tcl
index b5b6b2f..e43971b 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -179,7 +179,7 @@ proc do_options {} {
 			i-* {
 				regexp -- {-(\d+)\.\.(\d+)$} $type _junk min max
 				${NS}::frame $w.$f.$optid
-				${NS}::label $w.$f.$optid.l -text "$text:"
+				${NS}::label $w.$f.$optid.l -text [mc "%s:" $text]
 				pack $w.$f.$optid.l -side left -anchor w -fill x
 				tspinbox $w.$f.$optid.v \
 					-textvariable ${f}_config_new($name) \
@@ -194,7 +194,7 @@ proc do_options {} {
 			c -
 			t {
 				${NS}::frame $w.$f.$optid
-				${NS}::label $w.$f.$optid.l -text "$text:"
+				${NS}::label $w.$f.$optid.l -text [mc "%s:" $text]
 				${NS}::entry $w.$f.$optid.v \
 					-width 20 \
 					-textvariable ${f}_config_new($name)
@@ -217,7 +217,7 @@ proc do_options {} {
 			s {
 				set opts [eval [lindex $option 3]]
 				${NS}::frame $w.$f.$optid
-				${NS}::label $w.$f.$optid.l -text "$text:"
+				${NS}::label $w.$f.$optid.l -text [mc "%s:" $text]
 				if {$use_ttk} {
 					ttk::combobox $w.$f.$optid.v \
 						-textvariable ${f}_config_new($name) \
@@ -279,7 +279,7 @@ proc do_options {} {
 			[font configure $font -size]
 
 		${NS}::frame $w.global.$name
-		${NS}::label $w.global.$name.l -text "$text:"
+		${NS}::label $w.global.$name.l -text [mc "%s:" $text]
 		${NS}::button $w.global.$name.b \
 			-text [mc "Change Font"] \
 			-command [list \
-- 
2.7.3
