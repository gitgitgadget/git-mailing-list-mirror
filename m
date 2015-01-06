From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [RFC PATCH 2/2] gitk: Show the rev(s) the user specified on the command line in the window title.
Date: Tue,  6 Jan 2015 12:52:00 -0500
Message-ID: <1420566720-25238-3-git-send-email-marcnarc@xiplink.com>
References: <1420566720-25238-1-git-send-email-marcnarc@xiplink.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 19:00:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8YQr-0001Lb-9S
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 19:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbbAFSAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 13:00:09 -0500
Received: from domain.not.configured ([192.252.130.194]:21612 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932277AbbAFSAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 13:00:08 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jan 2015 13:00:07 EST
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id C567B604AB;
	Tue,  6 Jan 2015 12:52:12 -0500 (EST)
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1420566720-25238-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262078>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

I often open multiple gitk windows in the same working directory to examine
other branches or refs in the repo.  This change allows me to distinguish
which window is showing what.

This is an RFC because it doesn't behave great with views.  I don't use views
at all, so this doesn't bother me.  I'm not too sure what should be displayed
if the user changes views -- probably the view name, but I'm not sure how to
get a that in the code.

		M.

 gitk | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 03de545..b8463fd 100755
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
2.2.1
