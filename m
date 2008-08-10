From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 05/12]  Add a single command that will be used to construct the 'p4' command
Date: Sun, 10 Aug 2008 19:26:28 +0100
Message-ID: <1218392795-4084-6-git-send-email-wildfire@progsoc.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-3-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-4-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-5-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFnm-0003cT-9U
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbYHJShB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbYHJShA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:37:00 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:47901 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbYHJSg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:36:59 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFmi-00023E-ER; Mon, 11 Aug 2008 04:36:58 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015D-Mg; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-5-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.2
X-Spam-Score-Int: -21
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91864>

 Rather than having three locations where the 'p4' command is built up,
 refactor this into the one place. This will, eventually, allow us to
 have one place where we modify the evironment or pass extra
 command-line options to the 'p4' binary.

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2ed36ec..b4acf76 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -16,6 +16,17 @@ from sets import Set;
 
 verbose = False
 
+
+def p4_build_cmd(cmd):
+    """Build a suitable p4 command line.
+
+    This consolidates building and returning a p4 command line into one
+    location. It means that hooking into the environment, or other configuration
+    can be done more easily.
+    """
+    real_cmd = "%s %s" % ("p4", cmd)
+    return real_cmd
+
 def die(msg):
     if verbose:
         raise Exception(msg)
-- 
1.5.6.3
