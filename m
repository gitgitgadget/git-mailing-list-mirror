From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] Demonstrate issue #8733.
Date: Wed, 14 Mar 2007 22:34:59 +0100
Message-ID: <20070314213459.13492.77212.stgit@gandelf.nowhere.earth>
References: <20070314213020.13492.24840.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 22:35:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRb8O-0007OK-Df
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbXCNVfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbXCNVfB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:35:01 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58713 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422669AbXCNVfA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:35:00 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 78C238B13;
	Wed, 14 Mar 2007 22:34:59 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 3DDC81F094;
	Wed, 14 Mar 2007 22:34:59 +0100 (CET)
In-Reply-To: <20070314213020.13492.24840.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42237>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/t1003-branch-delete.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/t/t1003-branch-delete.sh b/t/t1003-branch-delete.sh
new file mode 100755
index 0000000..8625cc5
--- /dev/null
+++ b/t/t1003-branch-delete.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Catalin Marinas
+#
+
+test_description='Branch deletion.'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'Create a new branch' \
+    '
+    stg branch --create new &&
+    git rev-parse new~0
+    '
+
+test_expect_success \
+    'Delete the new branch' \
+    'stg branch --delete new'
+
+test_expect_failure \
+    'Check the deleted branch is gone' \
+    'git rev-parse new~0'
+
+test_expect_success \
+    'Rename master branch, and create a new branch' \
+    '
+    git branch -m master a &&
+    stg branch --create b
+    '
+
+test_expect_success \
+    'Delete the new branch' \
+    'stg branch --delete b'
+
+test_expect_failure \
+    'Check the deleted branch is gone' \
+    'git rev-parse b~0'
+
+test_done
