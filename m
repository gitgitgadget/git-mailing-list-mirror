From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 02/12]  Utilise the new 'p4_read_pipe_lines' command
Date: Sun, 10 Aug 2008 19:26:25 +0100
Message-ID: <1218392795-4084-3-git-send-email-wildfire@progsoc.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFx1-00060R-3J
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbYHJSqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbYHJSqU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:46:20 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:41054 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbYHJSqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:46:18 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFkW-00022F-4X; Mon, 11 Aug 2008 04:34:41 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015A-KH; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.2
X-Spam-Score-Int: -21
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91875>

 Now that we have the new command, we can utilise it and then
 eventually, isolate any changes required to the one place.

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index fc2a60d..3deaa42 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -371,7 +371,7 @@ def originP4BranchesExist():
 
 def p4ChangesForPaths(depotPaths, changeRange):
     assert depotPaths
-    output = read_pipe_lines("p4 changes " + ' '.join (["%s...%s" % (p, changeRange)
+    output = p4_read_pipe_lines("changes " + ' '.join (["%s...%s" % (p, changeRange)
                                                         for p in depotPaths]))
 
     changes = []
@@ -519,7 +519,7 @@ class P4Submit(Command):
         # remove lines in the Files section that show changes to files outside the depot path we're committing into
         template = ""
         inFilesSection = False
-        for line in read_pipe_lines("p4 change -o"):
+        for line in p4_read_pipe_lines("change -o"):
             if line.endswith("\r\n"):
                 line = line[:-2] + "\n"
             if inFilesSection:
-- 
1.5.6.3
