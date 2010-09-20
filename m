From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: [PATCH] contrib/ciabot: git-describe commit instead of HEAD
Date: Mon, 20 Sep 2010 11:31:22 +0200
Message-ID: <1284975082-25994-1-git-send-email-sven.eckelmann@gmx.de>
Cc: esr@thyrsus.com, gitster@pobox.com,
	Sven Eckelmann <sven.eckelmann@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 11:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxchp-0006YO-FG
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 11:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab0ITJa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 05:30:27 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:44163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755959Ab0ITJa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 05:30:26 -0400
Received: (qmail invoked by alias); 20 Sep 2010 09:30:24 -0000
Received: from vpnclient-194-208.hrz.tu-chemnitz.de (EHLO sven-desktop.lazhur.ath.cx) [134.109.194.208]
  by mail.gmx.net (mp061) with SMTP; 20 Sep 2010 11:30:24 +0200
X-Authenticated: #15668376
X-Provags-ID: V01U2FsdGVkX19xQwkTT+FxK8Qqv/2wV5b38iUXcwplsWmaYvnajA
	/rqEabqZUL8346
X-Mailer: git-send-email 1.7.2.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156605>

For each commit a shorter version of the name will be generated. This is
either the truncated hash or the output of git-describe. The
call to git-describe was only made with an empty shell variable instead
of an actual commit hash. Thus it only described the current HEAD and
not each commit we want to submit to cia.vc.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
I send this patch already two weeks ago and got no reaction. This is a
resent in case it was forgotton.

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
