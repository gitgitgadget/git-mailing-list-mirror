From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/8] Test that diff can read from stdin
Date: Thu, 19 Feb 2009 12:13:36 +0100
Message-ID: <54ce919e5c1f9c295018ea6e4a0cf2aeaf465591.1235041345.git.trast@student.ethz.ch>
References: <cover.1235041345.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6sv-0000Pm-An
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbZBSLOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbZBSLN7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:13:59 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16533 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbZBSLN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:13:57 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
X-Mailer: git-send-email 1.6.2.rc1.266.gce6c4
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 11:13:52.0368 (UTC) FILETIME=[2576BF00:01C99283]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110677>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same as v1.

 t/t4002-diff-basic.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index cc3681f..18695ce 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -258,4 +258,12 @@ test_expect_success \
     git diff-tree -r -R $tree_A $tree_B >.test-b &&
     cmp -s .test-a .test-b'
 
+test_expect_success \
+    'diff can read from stdin' \
+    'test_must_fail git diff --no-index -- MN - < NN |
+        grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
+    test_must_fail git diff --no-index -- MN NN |
+        grep -v "^index" >.test-b &&
+    test_cmp .test-a .test-b'
+
 test_done
-- 
1.6.2.rc1.266.gce6c4
