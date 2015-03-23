From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 2/2] gitk: Show the rev(s) the user specified on the command line in the window title.
Date: Mon, 23 Mar 2015 10:18:17 -0400
Message-ID: <1427120297-26314-2-git-send-email-marcnarc@xiplink.com>
References: <1420566720-25238-1-git-send-email-marcnarc@xiplink.com>
 <1427120297-26314-1-git-send-email-marcnarc@xiplink.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 15:27:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya3K9-0007tz-3r
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 15:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbbCWO1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 10:27:20 -0400
Received: from domain.not.configured ([192.252.130.194]:9924 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752218AbbCWO1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 10:27:18 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id ECD6661B6B;
	Mon, 23 Mar 2015 10:17:56 -0400 (EDT)
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1427120297-26314-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266141>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

I often open multiple gitk windows in the same working directory to examine
other branches or refs in the repo.  This change allows me to distinguish
which window is showing what.

		M.

 gitk | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index b859879..379b13a 100755
--- a/gitk
+++ b/gitk
@@ -488,7 +488,7 @@ proc reset_pending_select {selid} {
 }
 
 proc getcommits {selid} {
-    global canv curview need_redisplay viewactive
+    global appname canv curview need_redisplay viewactive vrevs
 
     initlayout
     if {[start_rev_list $curview]} {
@@ -498,6 +498,11 @@ proc getcommits {selid} {
     } else {
 	show_status [mc "No commits selected"]
     }
+    set rev "$vrevs($curview)"
+    if {$rev eq ""} {
+	set rev "HEAD"
+    }
+    wm title . "[reponame]: $rev - $appname"
 }
 
 proc updatecommits {} {
-- 
2.3.3
