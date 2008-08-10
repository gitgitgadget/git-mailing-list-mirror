From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 03/12]  Have a command that specifically invokes 'p4' (via system)
Date: Sun, 10 Aug 2008 19:26:26 +0100
Message-ID: <1218392795-4084-4-git-send-email-wildfire@progsoc.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-3-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:47:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFx1-00060R-OY
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbYHJSqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbYHJSqY
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:46:24 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:41055 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbYHJSqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:46:24 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFlZ-00022O-Qg; Mon, 11 Aug 2008 04:35:47 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015B-Kk; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-3-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.2
X-Spam-Score-Int: -21
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91874>

 Similiar to our 'p4_read_pipe_lines' command, we can isolate
 specific changes to the invocation method in the one location
 with this change.

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3deaa42..08acd51 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -70,6 +70,13 @@ def system(cmd):
     if os.system(cmd) != 0:
         die("command failed: %s" % cmd)
 
+def p4_system(cmd):
+    """Specifically invoke p4 as the system command. """
+    real_cmd = "%s %s" % ("p4", cmd)
+    if verbose:
+        print real_cmd
+    return system(real_cmd)
+
 def isP4Exec(kind):
     """Determine if a Perforce 'kind' should have execute permission
 
-- 
1.5.6.3
