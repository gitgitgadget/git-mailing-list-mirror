From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] mergetool: Use merge.tool config option.
Date: Sun, 18 Mar 2007 12:13:11 -0400
Message-ID: <11742343911678-git-send-email-jbowes@dangerouslyinc.com>
Cc: junkio@cox.net, tytso@mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 17:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSy1d-0003Xh-0p
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 17:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbXCRQOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbXCRQOH
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 12:14:07 -0400
Received: from ms-smtp-05.southeast.rr.com ([24.25.9.104]:37040 "EHLO
	ms-smtp-05.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753231AbXCRQOD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2007 12:14:03 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-05.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l2IGE1EM014967;
	Sun, 18 Mar 2007 12:14:01 -0400 (EDT)
X-Mailer: git-send-email 1.5.0.3
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42503>

If no merge program was supplied on the commandline, and the config option
merge.tool was set to a valid value, then mergetool would unset $merge_tool
and instead try to find an installed merge program. This patch removes the code
that unset $merge_tool, so the merge.tool config option will always be used, if
set.

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 git-mergetool.sh |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 52386a5..19788a1 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -288,10 +288,6 @@ done
 
 if test -z "$merge_tool"; then
     merge_tool=`git-config merge.tool`
-    if test $merge_tool = kdiff3 -o $merge_tool = tkdiff -o \
-	$merge_tool = xxdiff -o $merge_tool = meld ; then
-	unset merge_tool
-    fi
 fi
 
 if test -z "$merge_tool" ; then
-- 
1.5.0.3
