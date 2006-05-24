From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] gitk: Replace "git-" commands with "git "
Date: Wed, 24 May 2006 10:57:40 +0300
Message-ID: <20060524105740.2cb97585.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 09:56:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FioDg-0005VR-Qx
	for gcvg-git@gmane.org; Wed, 24 May 2006 09:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWEXHzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 03:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWEXHzu
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 03:55:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:34966 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932653AbWEXHzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 03:55:49 -0400
Received: by nf-out-0910.google.com with SMTP id l35so19839nfa
        for <git@vger.kernel.org>; Wed, 24 May 2006 00:55:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=UBS9EJ5yqZcSY5hXtFJ4JvY5OGcPiu/cRiRaqgAm5cJ1YZKG7LCAxJXBJfuCPxPmc5eCxth6GPXLFz3BzkYkSeNaWx08hNMuANEiv4w2D+WOT1uUDSIwnaDFka1ouqSzmeMk5wh7q4aJbJwN2o1G71wiUbAUEge60hZ9J55YDZI=
Received: by 10.48.237.18 with SMTP id k18mr5443978nfh;
        Wed, 24 May 2006 00:55:47 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id l38sm583808nfc.2006.05.24.00.55.46;
        Wed, 24 May 2006 00:55:47 -0700 (PDT)
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20671>

git-* commands work only if gitexecdir is in PATH.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

NOTE: This is for the gitk repository.

cad90165494784f29aec40bca2c1e2bbc39e7a76
 gitk |   52 ++++++++++++++++++++++++++--------------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

cad90165494784f29aec40bca2c1e2bbc39e7a76
diff --git a/gitk b/gitk
index bd8d4f1..7427856 100755
--- a/gitk
+++ b/gitk
@@ -34,10 +34,10 @@ proc start_rev_list {view} {
 	set order "--date-order"
     }
     if {[catch {
-	set fd [open [concat | git-rev-list --header $order \
+	set fd [open [concat | git rev-list --header $order \
 			  --parents --boundary --default HEAD $args] r]
     } err]} {
-	puts stderr "Error executing git-rev-list: $err"
+	puts stderr "Error executing git rev-list: $err"
 	exit 1
     }
     set commfd($view) $fd
@@ -94,10 +94,10 @@ proc getcommitlines {fd view}  {
 	    }
 	    if {[string range $err 0 4] == "usage"} {
 		set err "Gitk: error reading commits$fv:\
-			bad arguments to git-rev-list."
+			bad arguments to git rev-list."
 		if {$viewname($view) eq "Command line"} {
 		    append err \
-			"  (Note: arguments to gitk are passed to git-rev-list\
+			"  (Note: arguments to gitk are passed to git rev-list\
 			 to allow selection of commits to be displayed.)"
 		}
 	    } else {
@@ -148,7 +148,7 @@ proc getcommitlines {fd view}  {
 	    if {[string length $shortcmit] > 80} {
 		set shortcmit "[string range $shortcmit 0 80]..."
 	    }
-	    error_popup "Can't parse git-rev-list output: {$shortcmit}"
+	    error_popup "Can't parse git rev-list output: {$shortcmit}"
 	    exit 1
 	}
 	set id [lindex $ids 0]
@@ -217,7 +217,7 @@ proc doupdate {} {
 }
 
 proc readcommit {id} {
-    if {[catch {set contents [exec git-cat-file commit $id]}]} return
+    if {[catch {set contents [exec git cat-file commit $id]}]} return
     parsecommit $id $contents 0
 }
 
@@ -276,8 +276,8 @@ proc parsecommit {id contents listed} {
 	set headline $comment
     }
     if {!$listed} {
-	# git-rev-list indents the comment by 4 spaces;
-	# if we got this via git-cat-file, add the indentation
+	# git rev-list indents the comment by 4 spaces;
+	# if we got this via git cat-file, add the indentation
 	set newcomment {}
 	foreach line [split $comment "\n"] {
 	    append newcomment "    "
@@ -337,14 +337,14 @@ proc readrefs {} {
 	    set type {}
 	    set tag {}
 	    catch {
-		set commit [exec git-rev-parse "$id^0"]
+		set commit [exec git rev-parse "$id^0"]
 		if {"$commit" != "$id"} {
 		    set tagids($name) $commit
 		    lappend idtags($commit) $name
 		}
 	    }		
 	    catch {
-	        set tagcontents($name) [exec git-cat-file tag "$id"]
+	        set tagcontents($name) [exec git cat-file tag "$id"]
 	    }
 	} elseif { $type == "heads" } {
 	    set headids($name) $id
@@ -1287,7 +1287,7 @@ proc vieweditor {top n title} {
     checkbutton $top.perm -text "Remember this view" -variable newviewperm($n)
     grid $top.perm - -pady 5 -sticky w
     message $top.al -aspect 1000 -font $uifont \
-	-text "Commits to include (arguments to git-rev-list):"
+	-text "Commits to include (arguments to git rev-list):"
     grid $top.al - -sticky w -pady 5
     entry $top.args -width 50 -textvariable newviewargs($n) \
 	-background white
@@ -2941,7 +2941,7 @@ proc findpatches {} {
     }
 
     if {[catch {
-	set f [open [list | git-diff-tree --stdin -s -r -S$findstring \
+	set f [open [list | git diff-tree --stdin -s -r -S$findstring \
 			 << $inputids] r]
     } err]} {
 	error_popup "Error starting search process: $err"
@@ -2973,7 +2973,7 @@ proc readfindproc {} {
 	return
     }
     if {![regexp {^[0-9a-f]{40}} $line id]} {
-	error_popup "Can't parse git-diff-tree output: $line"
+	error_popup "Can't parse git diff-tree output: $line"
 	stopfindproc
 	return
     }
@@ -3038,10 +3038,10 @@ proc findfiles {} {
 	if {$l == $findstartline} break
     }
 
-    # start off a git-diff-tree process if needed
+    # start off a git diff-tree process if needed
     if {$diffsneeded ne {}} {
 	if {[catch {
-	    set df [open [list | git-diff-tree -r --stdin << $diffsneeded] r]
+	    set df [open [list | git diff-tree -r --stdin << $diffsneeded] r]
 	} err ]} {
 	    error_popup "Error starting search process: $err"
 	    return
@@ -3071,7 +3071,7 @@ proc readfilediffs {df} {
 	    if {[catch {close $df} err]} {
 		stopfindproc
 		bell
-		error_popup "Error in git-diff-tree: $err"
+		error_popup "Error in git diff-tree: $err"
 	    } elseif {[info exists findid]} {
 		set id $findid
 		stopfindproc
@@ -3098,7 +3098,7 @@ proc donefilediff {} {
     if {[info exists fdiffid]} {
 	while {[lindex $fdiffsneeded $fdiffpos] ne $fdiffid
 	       && $fdiffpos < [llength $fdiffsneeded]} {
-	    # git-diff-tree doesn't output anything for a commit
+	    # git diff-tree doesn't output anything for a commit
 	    # which doesn't change anything
 	    set nullid [lindex $fdiffsneeded $fdiffpos]
 	    set treediffs($nullid) {}
@@ -3526,7 +3526,7 @@ proc gettree {id} {
     catch {unset diffmergeid}
     if {![info exists treefilelist($id)]} {
 	if {![info exists treepending]} {
-	    if {[catch {set gtf [open [concat | git-ls-tree -r $id] r]}]} {
+	    if {[catch {set gtf [open [concat | git ls-tree -r $id] r]}]} {
 		return
 	    }
 	    set treepending $id
@@ -3574,7 +3574,7 @@ proc showfile {f} {
 	return
     }
     set blob [lindex $treeidlist($diffids) $i]
-    if {[catch {set bf [open [concat | git-cat-file blob $blob] r]} err]} {
+    if {[catch {set bf [open [concat | git cat-file blob $blob] r]} err]} {
 	puts "oops, error reading blob $blob: $err"
 	return
     }
@@ -3616,7 +3616,7 @@ proc mergediff {id l} {
     set diffids $id
     # this doesn't seem to actually affect anything...
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [concat | git-diff-tree --no-commit-id --cc $id]
+    set cmd [concat | git diff-tree --no-commit-id --cc $id]
     if {[catch {set mdf [open $cmd r]} err]} {
 	error_popup "Error getting merge diffs: $err"
 	return
@@ -3728,7 +3728,7 @@ proc gettreediffs {ids} {
     set treepending $ids
     set treediff {}
     if {[catch \
-	 {set gdtf [open [concat | git-diff-tree --no-commit-id -r $ids] r]} \
+	 {set gdtf [open [concat | git diff-tree --no-commit-id -r $ids] r]} \
 	]} return
     fconfigure $gdtf -blocking 0
     fileevent $gdtf readable [list gettreediffline $gdtf $ids]
@@ -3764,7 +3764,7 @@ proc getblobdiffs {ids} {
     global nextupdate diffinhdr treediffs
 
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [concat | git-diff-tree --no-commit-id -r -p -C $ids]
+    set cmd [concat | git diff-tree --no-commit-id -r -p -C $ids]
     if {[catch {set bdf [open $cmd r]} err]} {
 	puts "error getting diffs: $err"
 	return
@@ -4301,7 +4301,7 @@ proc mkpatchgo {} {
     set oldid [$patchtop.fromsha1 get]
     set newid [$patchtop.tosha1 get]
     set fname [$patchtop.fname get]
-    if {[catch {exec git-diff-tree -p $oldid $newid >$fname &} err]} {
+    if {[catch {exec git diff-tree -p $oldid $newid >$fname &} err]} {
 	error_popup "Error creating patch: $err"
     }
     catch {destroy $patchtop}
@@ -4868,11 +4868,11 @@ proc tcl_encoding {enc} {
 # defaults...
 set datemode 0
 set diffopts "-U 5 -p"
-set wrcomcmd "git-diff-tree --stdin -p --pretty"
+set wrcomcmd "git diff-tree --stdin -p --pretty"
 
 set gitencoding {}
 catch {
-    set gitencoding [exec git-repo-config --get i18n.commitencoding]
+    set gitencoding [exec git repo-config --get i18n.commitencoding]
 }
 if {$gitencoding == ""} {
     set gitencoding "utf-8"
@@ -4928,7 +4928,7 @@ if {$i >= 0} {
     set revtreeargs [lrange $revtreeargs 0 [expr {$i - 1}]]
 } elseif {$revtreeargs ne {}} {
     if {[catch {
-	set f [eval exec git-rev-parse --no-revs --no-flags $revtreeargs]
+	set f [eval exec git rev-parse --no-revs --no-flags $revtreeargs]
 	set cmdline_files [split $f "\n"]
 	set n [llength $cmdline_files]
 	set revtreeargs [lrange $revtreeargs 0 end-$n]
-- 
1.3.3.g40505-dirty
