From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 2/2]  Utilise our new p4_read_pipe and p4_write_pipe wrappers
Date: Thu, 14 Aug 2008 23:40:39 +0100
Message-ID: <1218753639-32716-2-git-send-email-wildfire@progsoc.org>
References: <g829vo@ger.gmane.org>
 <1218753639-32716-1-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, torarvid@gmail.com,
	Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 00:51:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlfA-0001w3-Nd
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbYHNWuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbYHNWuV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:50:21 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:38619 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYHNWuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:50:20 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <wildfire@progsoc.uts.edu.au>)
	id 1KTle5-0004Gq-Nv; Fri, 15 Aug 2008 08:50:19 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <wildfire@progsoc.uts.edu.au>)
	id 1KTlUl-0008W3-Cm; Thu, 14 Aug 2008 23:40:39 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218753639-32716-1-git-send-email-wildfire@progsoc.org>
In-Reply-To: <g829vo@ger.gmane.org>
References: <g829vo@ger.gmane.org>
X-Spam-Score: -2.3
X-Spam-Score-Int: -22
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92431>


Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3e9df70..12fa9d3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -141,7 +141,7 @@ def setP4ExecBit(file, mode):
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
-    result = read_pipe("p4 opened %s" % file)
+    result = p4_read_pipe("opened %s" % file)
     match = re.match(".*\((.+)\)\r?$", result)
     if match:
         return match.group(1)
@@ -681,7 +681,7 @@ class P4Submit(Command):
             submitTemplate = self.prepareLogMessage(template, logMessage)
             if os.environ.has_key("P4DIFF"):
                 del(os.environ["P4DIFF"])
-            diff = read_pipe("p4 diff -du ...")
+            diff = p4_read_pipe("diff -du ...")
 
             newdiff = ""
             for newFile in filesToAdd:
@@ -719,7 +719,7 @@ class P4Submit(Command):
             if self.isWindows:
                 submitTemplate = submitTemplate.replace("\r\n", "\n")
 
-            write_pipe("p4 submit -i", submitTemplate)
+            p4_write_pipe("submit -i", submitTemplate)
         else:
             fileName = "submit.txt"
             file = open(fileName, "w+")
-- 
1.5.6.3
