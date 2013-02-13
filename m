From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Makefile: don't run rm without any files
Date: Wed, 13 Feb 2013 07:57:48 -0800
Message-ID: <1360771068-505-1-git-send-email-kraai@ftbfs.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 16:58:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5ej6-0006oO-7N
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 16:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934264Ab3BMP6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 10:58:03 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:58288 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759821Ab3BMP6C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 10:58:02 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1U5eib-00008e-A9; Wed, 13 Feb 2013 07:57:57 -0800
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216264>

From: Matt Kraai <matt.kraai@amo.abbott.com>

"rm -f -r" fails on QNX when not passed any files to remove.  This breaks
the clean target, since dep_dirs is empty.  Avoid this by merging two rm
command lines.

Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5a2e02d..c2e3666 100644
--- a/Makefile
+++ b/Makefile
@@ -2414,8 +2414,7 @@ clean: profile-clean
 		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
-	$(RM) -r bin-wrappers
-	$(RM) -r $(dep_dirs)
+	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
-- 
1.8.1.3.570.g3074c9d
