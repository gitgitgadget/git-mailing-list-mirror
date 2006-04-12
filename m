From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/3] Add testcase for branch -r problem
Date: Wed, 12 Apr 2006 23:21:15 +0200
Message-ID: <20060412212115.14579.89747.stgit@gandelf.nowhere.earth>
References: <20060412211633.14579.98008.stgit@gandelf.nowhere.earth>
X-From: git-owner@vger.kernel.org Wed Apr 12 23:19:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTmkA-0004mx-4c
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 23:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWDLVTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWDLVTK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 17:19:10 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:33501 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932314AbWDLVTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Apr 2006 17:19:09 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 1FC986D00A
	for <git@vger.kernel.org>; Wed, 12 Apr 2006 23:19:08 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FTmt4-0008PA-E2
	for git@vger.kernel.org; Wed, 12 Apr 2006 23:28:30 +0200
To: git@vger.kernel.org
In-Reply-To: <20060412211633.14579.98008.stgit@gandelf.nowhere.earth>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18640>

From:  <>


---

 TODO              |    1 +
 t/t1000-branch.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index a9a8b1f..365ecd4 100644
--- a/TODO
+++ b/TODO
@@ -26,3 +26,4 @@ Bugs:
 
 - the following commands break in subdirs:
   - refresh (ml: "Running StGIT in subdirectories")
+- branch renaming leaves junk behind
diff --git a/t/t1000-branch.sh b/t/t1000-branch.sh
new file mode 100755
index 0000000..4c790f5
--- /dev/null
+++ b/t/t1000-branch.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson
+#
+
+test_description='dummy test.
+
+Only to test the testing environment.
+'
+
+. ./test-lib.sh
+
+test_stg_init
+
+test_expect_success \
+    'Create an stgit branch from scratch' \
+    'stg branch -c foo &&
+     stg new p1 -m "p1"
+'
+
+test_expect_failure \
+    'Rename the current stgit branch' \
+    'stg branch -r foo bar
+'
+
+test_expect_success \
+    'Rename an stgit branch' \
+    'stg branch -c buz &&
+     stg branch -r foo bar &&
+     test -z `find .git -name foo`
+'
+
+test_done
