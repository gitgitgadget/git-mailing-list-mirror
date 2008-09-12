From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] gitk: Add untranslated error messages to translation.
Date: Fri, 12 Sep 2008 11:39:43 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200809121139.43501.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 11:41:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke59D-0000va-Kh
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 11:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbYILJj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 05:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbYILJj5
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 05:39:57 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:41169 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYILJj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 05:39:56 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m8C9dW75018661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 12 Sep 2008 11:39:33 +0200
Received: from [192.168.0.101] (e176218255.adsl.alicedsl.de [85.176.218.255])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m8C9dULO011642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Sep 2008 11:39:32 +0200
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95695>

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
 gitk |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/gitk b/gitk
index 2eaa2ae..ccf6952 100755
--- a/gitk
+++ b/gitk
@@ -269,7 +269,7 @@ proc parseviewrevs {view revs} {
 		lappend badrev $line
 	    }
 	}		    
-	error_popup "Error parsing revisions: $err"
+	error_popup "[mc "Error parsing revisions:"] $err"
 	return {}
     }
     set ret {}
@@ -324,7 +324,7 @@ proc start_rev_list {view} {
 	if {[catch {
 	    set str [exec sh -c $viewargscmd($view)]
 	} err]} {
-	    error_popup "Error executing --argscmd command: $err"
+	    error_popup "[mc "Error executing --argscmd command:"] $err"
 	    return 0
 	}
 	set args [concat $args [split $str "\n"]]
@@ -500,7 +500,7 @@ proc updatecommits {} {
 	set fd [open [concat | git log --no-color -z --pretty=raw --parents \
 			  --boundary $args "--" $vfilelimit($view)] r]
     } err]} {
-	error_popup "Error executing git log: $err"
+	error_popup "[mc "Error executing git log:"] $err"
 	return
     }
     if {$viewactive($view) == 0} {
@@ -2936,7 +2936,7 @@ proc save_file_from_commit {filename output what} {
 	if {[string match "fatal: bad revision *" $err]} {
 	    return $nullfile
 	}
-	error_popup "Error getting \"$filename\" from $what: $err"
+	error_popup "[mc "Error getting \"%s\" from %s:" $filename $what] $err"
 	return {}
     }
     return $output
@@ -2993,7 +2993,7 @@ proc external_diff {} {
 	set gitktmpdir [file join [file dirname $gitdir] \
 			    [format ".gitk-tmp.%s" [pid]]]
 	if {[catch {file mkdir $gitktmpdir} err]} {
-	    error_popup "Error creating temporary directory $gitktmpdir: $err"
+	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
 	    unset gitktmpdir
 	    return
 	}
@@ -3002,7 +3002,7 @@ proc external_diff {} {
     incr diffnum
     set diffdir [file join $gitktmpdir $diffnum]
     if {[catch {file mkdir $diffdir} err]} {
-	error_popup "Error creating temporary directory $diffdir: $err"
+	error_popup "[mc "Error creating temporary directory %s:" $diffdir] $err"
 	return
     }
 
@@ -3015,7 +3015,7 @@ proc external_diff {} {
 		     [list $difffromfile $difftofile]]
         if {[catch {set fl [open $cmd r]} err]} {
             file delete -force $diffdir
-            error_popup [mc "$extdifftool: command failed: $err"]
+            error_popup "$extdifftool: [mc "command failed:"] $err"
         } else {
             fconfigure $fl -blocking 0
             filerun $fl [list delete_at_eof $fl $diffdir]
@@ -3040,7 +3040,7 @@ proc external_blame {parent_idx} {
     }
 
     if {[catch {exec git gui blame $base_commit $flist_menu_file &} err]} {
-	error_popup [mc "git gui blame: command failed: $err"]
+	error_popup "[mc "git gui blame: command failed:"] $err"
     }
 }
 
@@ -3049,7 +3049,7 @@ proc delete_at_eof {f dir} {
     while {[gets $f line] >= 0} {}
     if {[eof $f]} {
 	if {[catch {close $f} err]} {
-	    error_popup "External diff viewer failed: $err"
+	    error_popup "[mc "External diff viewer failed:"] $err"
 	}
 	file delete -force $dir
 	return 0
-- 
1.6.0.rc1.34.g0fe8c
