From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 07/12]  Switch to using 'p4_build_cmd'
Date: Sun, 10 Aug 2008 19:26:30 +0100
Message-ID: <1218392795-4084-8-git-send-email-wildfire@progsoc.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-3-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-4-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-5-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-6-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-7-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:38:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFo1-0003hs-1s
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbYHJShM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbYHJShL
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:37:11 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:47910 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbYHJShK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:37:10 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFmn-00023O-P1; Mon, 11 Aug 2008 04:37:09 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015F-Oj; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-7-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.2
X-Spam-Score-Int: -21
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91866>

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d36b0c6..2b6ea74 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -72,9 +72,7 @@ def read_pipe_lines(c):
 
 def p4_read_pipe_lines(c):
     """Specifically invoke p4 on the command supplied. """
-    real_cmd = "%s %s" % ("p4", c)
-    if verbose:
-        print real_cmd
+    real_cmd = p4_build_cmd(c)
     return read_pipe_lines(real_cmd)
 
 def system(cmd):
@@ -85,9 +83,7 @@ def system(cmd):
 
 def p4_system(cmd):
     """Specifically invoke p4 as the system command. """
-    real_cmd = "%s %s" % ("p4", cmd)
-    if verbose:
-        print real_cmd
+    real_cmd = p4_build_cmd(cmd)
     return system(real_cmd)
 
 def isP4Exec(kind):
@@ -172,7 +168,7 @@ def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
-    cmd = "p4 -G %s" % cmd
+    cmd = p4_build_cmd("-G %s" % (cmd))
     if verbose:
         sys.stderr.write("Opening pipe: %s\n" % cmd)
 
-- 
1.5.6.3
