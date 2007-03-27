From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH 4/4] Do not break git-gui messages into multiple lines.
Date: Tue, 27 Mar 2007 14:31:55 +0400
Message-ID: <20070327103155.GR14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Mar 27 12:32:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW8yK-0002mG-85
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbXC0KcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbXC0KcI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:32:08 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:51513 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbXC0KcG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:32:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=hCfGWDFMAOWpIfmjh1eTmet/FNHfFH6kEFObqOr4tMjQnFErOZQHEr8AYdXou/BcWuIMb+ZvOMwq5MYXRx2OTmBMZxLIwZkIFQTbCfR3C05ybPN7EkVRd2l0QUGRCiMASxQ6LnlcvEZ65fXJ46Ep/p/rA/pfw2q0E29BssYIYcw=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW8y8-000Dac-1J; Tue, 27 Mar 2007 14:32:00 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-3.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43253>

Many git-gui messages were broken into a multiple lines to make
good paragraph width. Unfortunately in reality it breaks the paragraph
width completely, because the dialog window width does not coincide
with the paragraph width created by the current font.

Tcl/Tk's standard dialog boxes are breaking the long lines
automatically, so it is better to make long lines and let the
interpreter do the job.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git-gui/git-gui.sh |   64 ++++++++++++++-------------------------------------
 1 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 7c2ec6b..5b53891 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -735,12 +735,9 @@ proc handle_empty_diff {} {
 
 [short_path $path] has no changes.
 
-The modification date of this file was updated
-by another application, but the content within
-the file was not changed.
+The modification date of this file was updated by another application, but the content within the file was not changed.
 
-A rescan will be automatically started to find
-other files which may have the same state."
+A rescan will be automatically started to find other files which may have the same state."
 
 	clear_diff
 	display_file $path __
@@ -1041,8 +1038,7 @@ proc load_last_commit {} {
 	if {[llength $PARENT] == 0} {
 		error_popup {There is nothing to amend.
 
-You are about to create the initial commit.
-There is no commit before this to amend.
+You are about to create the initial commit.  There is no commit before this to amend.
 }
 		return
 	}
@@ -1051,10 +1047,7 @@ There is no commit before this to amend.
 	if {$curType eq {merge}} {
 		error_popup {Cannot amend while merging.
 
-You are currently in the middle of a merge that
-has not been fully completed.  You cannot amend
-the prior commit unless you first abort the
-current merge activity.
+You are currently in the middle of a merge that has not been fully completed.  You cannot amend the prior commit unless you first abort the current merge activity.
 }
 		return
 	}
@@ -1144,9 +1137,7 @@ proc commit_tree {} {
 	} elseif {$commit_type ne $curType || $HEAD ne $curHEAD} {
 		info_popup {Last scanned state does not match repository state.
 
-Another Git program has modified this repository
-since the last scan.  A rescan must be performed
-before another commit can be created.
+Another Git program has modified this repository since the last scan.  A rescan must be performed before another commit can be created.
 
 The rescan will be automatically started now.
 }
@@ -1167,8 +1158,7 @@ The rescan will be automatically started now.
 		U? {
 			error_popup "Unmerged files cannot be committed.
 
-File [short_path $path] has merge conflicts.
-You must resolve them and add the file before committing.
+File [short_path $path] has merge conflicts.  You must resolve them and add the file before committing.
 "
 			unlock_index
 			return
@@ -1284,8 +1274,7 @@ proc commit_committree {fd_wt curHEAD msg} {
 		if {$tree_id eq $old_tree} {
 			info_popup {No changes to commit.
 
-No files were modified by this commit and it
-was not a merge commit.
+No files were modified by this commit and it was not a merge commit.
 
 A rescan will be automatically started now.
 }
@@ -2408,9 +2397,7 @@ proc switch_branch {new_branch} {
 	} elseif {$commit_type ne $curType || $HEAD ne $curHEAD} {
 		info_popup {Last scanned state does not match repository state.
 
-Another Git program has modified this repository
-since the last scan.  A rescan must be performed
-before the current branch can be changed.
+Another Git program has modified this repository since the last scan.  A rescan must be performed before the current branch can be changed.
 
 The rescan will be automatically started now.
 }
@@ -2501,12 +2488,9 @@ Staying on branch '$current_branch'."
 	if {[catch {git symbolic-ref HEAD "refs/heads/$new_branch"} err]} {
 		error_popup "Failed to set current branch.
 
-This working directory is only partially switched.
-We successfully updated your files, but failed to
-update an internal Git file.
+This working directory is only partially switched.  We successfully updated your files, but failed to update an internal Git file.
 
-This should not have occurred.  [appname] will now
-close and give up.
+This should not have occurred.  [appname] will now close and give up.
 
 $err"
 		do_quit
@@ -2823,8 +2807,7 @@ proc can_merge {} {
 	if {[string match amend* $commit_type]} {
 		info_popup {Cannot merge while amending.
 
-You must finish amending this commit before
-starting any type of merge.
+You must finish amending this commit before starting any type of merge.
 }
 		return 0
 	}
@@ -2838,9 +2821,7 @@ starting any type of merge.
 	if {$commit_type ne $curType || $HEAD ne $curHEAD} {
 		info_popup {Last scanned state does not match repository state.
 
-Another Git program has modified this repository
-since the last scan.  A rescan must be performed
-before a merge can be performed.
+Another Git program has modified this repository since the last scan.  A rescan must be performed before a merge can be performed.
 
 The rescan will be automatically started now.
 }
@@ -2859,9 +2840,7 @@ The rescan will be automatically started now.
 
 File [short_path $path] has merge conflicts.
 
-You must resolve them, add the file, and commit to
-complete the current merge.  Only then can you
-begin another merge.
+You must resolve them, add the file, and commit to complete the current merge.  Only then can you begin another merge.
 "
 			unlock_index
 			return 0
@@ -2871,9 +2850,7 @@ begin another merge.
 
 File [short_path $path] is modified.
 
-You should complete the current commit before
-starting a merge.  Doing so will help you abort
-a failed merge, should the need arise.
+You should complete the current commit before starting a merge.  Doing so will help you abort a failed merge, should the need arise.
 "
 			unlock_index
 			return 0
@@ -2949,13 +2926,11 @@ proc finish_merge {revcnt w ok} {
 
 Your merge of $revcnt branches has failed.
 
-There are file-level conflicts between the
-branches which must be resolved manually.
+There are file-level conflicts between the branches which must be resolved manually.
 
 The working directory will now be reset.
 
-You can attempt this merge again
-by merging only one branch at a time." $w
+You can attempt this merge again by merging only one branch at a time." $w
 
 			set fd [open "| git read-tree --reset -u HEAD" r]
 			fconfigure $fd -blocking 0 -translation binary
@@ -3068,8 +3043,7 @@ You must finish amending this commit.
 
 	if {[ask_popup "Abort $op?
 
-Aborting the current $op will cause
-*ALL* uncommitted changes to be lost.
+Aborting the current $op will cause *ALL* uncommitted changes to be lost.
 
 Continue with aborting the current $op?"] eq {yes}} {
 		set fd [open "| git read-tree --reset -u HEAD" r]
@@ -6076,9 +6050,7 @@ if {[is_enabled multicommit]} {
 		if {[ask_popup \
 			"This repository currently has $objects_current loose objects.
 
-To maintain optimal performance it is strongly
-recommended that you compress the database
-when more than $object_limit loose objects exist.
+To maintain optimal performance it is strongly recommended that you compress the database when more than $object_limit loose objects exist.
 
 Compress the database now?"] eq yes} {
 			do_gc
-- 
1.5.0.3-dirty
