From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] git-gui: do not use obsolete `git merge $msg HEAD $branch'
Date: Wed, 16 Dec 2015 22:44:08 +0100
Message-ID: <5671DB28.8020901@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 22:44:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Jrs-0007np-TU
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 22:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966065AbbLPVoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 16:44:13 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:7734 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbbLPVoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 16:44:12 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pLVMs05DYz5tlH;
	Wed, 16 Dec 2015 22:44:08 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 389F753B1;
	Wed, 16 Dec 2015 22:44:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282594>

Use the modern `git merge' invocation pattern.

Since both `git merge' and `git fmt-merge-msg' obey the merge.log
configuration, instruct the former not to generate the log summary to
avoid that it appears twice in the commit message.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 lib/merge.tcl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/merge.tcl b/lib/merge.tcl
index 460d32f..f512456 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -115,8 +115,9 @@ method _start {} {
 	set cmd [list git]
 	lappend cmd merge
 	lappend cmd --strategy=recursive
+	lappend cmd --no-log
+	lappend cmd -m
 	lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
-	lappend cmd HEAD
 	lappend cmd $name
 
 	ui_status [mc "Merging %s and %s..." $current_branch $stitle]
-- 
2.6.2.337.ga235d84
