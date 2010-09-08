From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: [PATCH] contrib/ciabot: git-describe commit instead of HEAD
Date: Thu,  9 Sep 2010 01:13:18 +0200
Message-ID: <1283987598-27255-1-git-send-email-sven.eckelmann@gmx.de>
Cc: esr@thyrsus.com, gitster@pobox.com,
	Sven Eckelmann <sven.eckelmann@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 01:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtTpO-0001Jq-O0
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 01:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab0IHXNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 19:13:12 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:59161 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S932095Ab0IHXNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 19:13:09 -0400
Received: (qmail invoked by alias); 08 Sep 2010 23:13:07 -0000
Received: from unknown (EHLO sven-desktop.lazhur.ath.cx) [89.246.216.118]
  by mail.gmx.net (mp072) with SMTP; 09 Sep 2010 01:13:07 +0200
X-Authenticated: #15668376
X-Provags-ID: V01U2FsdGVkX180Sc1bfrA0LXuanCRXgq/UBrHjZWbfM7xCKPbTo5
	B1y8wlbUZG6qQr
X-Mailer: git-send-email 1.7.2.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155822>

For each commit a shorter version of the name will be generated. This is
either the truncated hash or the output of git-describe. The
call to git-describe was only made with an empty shell variable instead
of an actual commit hash. Thus it only described the current HEAD and
not each commit we want to submit to cia.vc.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 contrib/ciabot/ciabot.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
index d0627e0..9775dff 100755
--- a/contrib/ciabot/ciabot.py
+++ b/contrib/ciabot/ciabot.py
@@ -122,7 +122,7 @@ def report(refname, merged):
     branch = os.path.basename(refname)
 
     # Compute a shortnane for the revision
-    rev = do("git describe ${merged} 2>/dev/null") or merged[:12]
+    rev = do("git describe '"+ merged +"' 2>/dev/null") or merged[:12]
 
     # Extract the neta-information for the commit
     rawcommit = do("git cat-file commit " + merged)
-- 
1.7.2.3
