From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: [PATCH] gitk: make diff and tree display work reliably again
Date: Sat, 9 Aug 2008 12:04:43 +0200
Message-ID: <217ad8e755d8d51e2ec0f06b4bffa0864976f7e4.1218277122.git.christian@jaeger.mine.nu>
References: <42d19ab224653b2e6988d7209a8d3e87e19858f8.1218207346.git.christian@jaeger.mine.nu> <200808091313.52528.angavrilov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 12:26:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRlek-0002yr-Qy
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 12:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbYHIKZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 06:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYHIKZk
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 06:25:40 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:38589 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751177AbYHIKZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 06:25:39 -0400
Received: (qmail 11370 invoked by uid 1000); 9 Aug 2008 10:25:37 -0000
In-Reply-To: <200808091313.52528.angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91762>

This reverts parts of the commit e439e092b8ee5248e92ed4cb4400f9dbed70f689.

gitk would not show diffs (or trees when choosing tree view) about
half of the times it is started, it would only show the commit
messages. Sometimes it took dozens of times to get it to show a diff
again, then show it again the next 3 starts, then the next 2 starts
not, then the next 2 starts would show it again, and so on.

The problem has been observed on Linux 2.6.26 x86_64 (Core 2 Duo),
Debian lenny, tk8.4 8.4.19-2. (Playing with frequency scaling settings
didn't show a difference; switching off one core made it more
reproducible.)

Signed-off-by: Christian Jaeger <christian@jaeger.mine.nu>
---
 gitk-git/gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d093a39..216a3ce 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4145,7 +4145,7 @@ proc readdifffiles {fd serial inst} {
 	set isdiff 0
     }
     # we only need to see one line and we don't really care what it says...
-    stop_instance $inst
+    close $fd
 
     if {$serial != $lserial} {
 	return 0
-- 
1.6.0.rc2.1.g42d19
