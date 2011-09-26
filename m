From: Peter Stuge <peter@stuge.se>
Subject: [PATCH] gitweb: Add js=1 before an URI fragment to fix line number links
Date: Mon, 26 Sep 2011 20:10:42 +0200
Message-ID: <1317060642-25488-1-git-send-email-peter@stuge.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 20:17:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8FkA-00014w-IS
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 20:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab1IZSR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 14:17:26 -0400
Received: from foo.stuge.se ([212.116.89.98]:53293 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751447Ab1IZSRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 14:17:25 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Sep 2011 14:17:25 EDT
Received: (qmail 8745 invoked from network); 26 Sep 2011 18:10:42 -0000
Received: from localhost (HELO stuge.se) (127.0.0.1)
  by localhost with SMTP; 26 Sep 2011 18:10:42 -0000
X-Mailer: git-send-email 1.7.4.1.343.ga91df.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182146>

Signed-off-by: Peter Stuge <peter@stuge.se>
---
 gitweb/static/js/javascript-detection.js |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static/js/javascript-detection.js
index 93dd2bd..003acd1 100644
--- a/gitweb/static/js/javascript-detection.js
+++ b/gitweb/static/js/javascript-detection.js
@@ -16,7 +16,7 @@
  * and other reasons to not add 'js=1' param at the end of link
  * @constant
  */
-var jsExceptionsRe = /[;?]js=[01]$/;
+var jsExceptionsRe = /[;?]js=[01](#.*)?$/;
 
 /**
  * Add '?js=1' or ';js=1' to the end of every link in the document
@@ -33,9 +33,9 @@ function fixLinks() {
 	var allLinks = document.getElementsByTagName("a") || document.links;
 	for (var i = 0, len = allLinks.length; i < len; i++) {
 		var link = allLinks[i];
-		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01]$/;
-			link.href +=
-				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1';
+		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01](#.*)?$/;
+			link.href = link.href.replace(/(#|$)/,
+				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1$1');
 		}
 	}
 }
-- 
1.7.4.1.343.ga91df.dirty
