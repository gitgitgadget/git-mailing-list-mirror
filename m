From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [PATCH v2 2/2] Ensure consistent usage of mergetool.keepBackup in git-gui
Date: Thu,  9 Apr 2009 17:45:11 +0200
Message-ID: <7a755d80914df2ebc1a7dc349ed215bae9ffec34.1239291673.git.ferry.huberts@pelagic.nl>
References: <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 17:47:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrwSx-0001r7-CV
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 17:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935631AbZDIPpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 11:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935637AbZDIPpQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 11:45:16 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:54499 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S935631AbZDIPpO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 11:45:14 -0400
Received: from localhost.localdomain (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 1242958BDA2;
	Thu,  9 Apr 2009 17:45:12 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl>
In-Reply-To: <20090409153033.GN23604@spearce.org>
References: <20090409153033.GN23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116175>

In several places merge.keepBackup is used i.s.o.
mergetool.keepBackup. This patch makes it all
consistent for git-gui

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 git-gui/git-gui.sh        |    2 +-
 git-gui/lib/mergetool.tcl |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index e018e07..e4e643a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -699,7 +699,7 @@ proc apply_config {} {
 
 set default_config(branch.autosetupmerge) true
 set default_config(merge.tool) {}
-set default_config(merge.keepbackup) true
+set default_config(mergetool.keepbackup) true
 set default_config(merge.diffstat) true
 set default_config(merge.summary) false
 set default_config(merge.verbosity) 2
diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index eb2b4b5..b7263b3 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -382,7 +382,7 @@ proc merge_tool_finish {fd} {
 		delete_temp_files $mtool_tmpfiles
 		ui_status [mc "Merge tool failed."]
 	} else {
-		if {[is_config_true merge.keepbackup]} {
+		if {[is_config_true mergetool.keepbackup]} {
 			file rename -force -- $backup "$mtool_target.orig"
 		}
 
-- 
1.6.0.6
