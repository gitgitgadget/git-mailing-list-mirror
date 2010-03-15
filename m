From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] Revert "git-gui (Win): make starting via "Git GUI Here" on .git/ possible"
Date: Tue, 16 Mar 2010 00:20:25 +0100
Message-ID: <1268695225-8915-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Markus Heidelberg <markus.heidelberg@web.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:19:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJZd-0003aE-6l
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937157Ab0COXTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 19:19:44 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:34248 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937130Ab0COXTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 19:19:43 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3B67C154CE143;
	Tue, 16 Mar 2010 00:19:42 +0100 (CET)
Received: from [91.19.1.188] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NrJZW-0001qL-00; Tue, 16 Mar 2010 00:19:42 +0100
X-Mailer: git-send-email 1.7.0.2.201.gbb6c1
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19fCKjHgnwPun5Tb43N3lRH+l+1hfqo6+PEiYkz
	BLDr/GxJAVYovecae3R4nDUfyGZ3K6nlfe43m4bJDSQY6VBEFR
	AIe2ltf6NGqu4I3U8Kew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142274>

This reverts commit b01d4326040ec6b9d98baba32091c9458fc809d4.

This workaround for the Windows Explorer is not necessary anymore,
because git-gui has learnt to deal with the .git directory in commit
87cd09f4 (git-gui: work from the .git dir, 2010-01-23).
---
 windows/git-gui.sh |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/windows/git-gui.sh b/windows/git-gui.sh
index 66bbb2f..53c3a94 100644
--- a/windows/git-gui.sh
+++ b/windows/git-gui.sh
@@ -3,12 +3,7 @@
 exec wish "$0" -- "$@"
 
 if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
-	set workdir [lindex $argv 1]
-	cd $workdir
-	if {[lindex [file split $workdir] end] eq {.git}} {
-		# Workaround for Explorer right click "Git GUI Here" on .git/
-		cd ..
-	}
+	cd [lindex $argv 1]
 	set argv [lrange $argv 2 end]
 	incr argc -2
 }
-- 
1.7.0.2.201.gbb6c1
