From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 04/10] Split a big test in ReadTreeTest into smaller tests
Date: Sun, 24 Feb 2008 00:50:37 +0100
Message-ID: <1203810643-28819-5-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-4-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:52:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4AS-0001IU-JZ
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbYBWXvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbYBWXva
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:51:30 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11225 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754613AbYBWXu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:50:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 19C048027FE;
	Sun, 24 Feb 2008 00:50:58 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vy9gfb6GPwIf; Sun, 24 Feb 2008 00:50:54 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 5DD56802814;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id EFF94293A8; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74894>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/ReadTreeTest.java     |   84 +++++++++++++------
 1 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
index 6faedc7..70c1396 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
@@ -273,50 +273,55 @@ public class ReadTreeTest extends RepositoryTestCase {
 	 *19   D	    0       F											  Update
 	 */
 	
-	public void testDirectoryFileConflicts() throws Exception {
+	public void testDirectoryFileConflicts_1() throws Exception {
 		// 1
 		doit(mk("DF/DF"), mk("DF"), mk("DF/DF"));
 		assertNoConflicts();
 		assertUpdated("DF");
 		assertRemoved("DF/DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_2() throws Exception {
 		// 2
 		setupCase(mk("DF/DF"), mk("DF"), mk("DF/DF"));
 		writeTrashFile("DF/DF", "different");
 		go();
 		assertConflict("DF/DF");
 		
+	}
+
+	public void testDirectoryFileConflicts_3() throws Exception {
 		// 3 - the first to break!
-		tearDown();
-		setUp();
 		doit(mk("DF/DF"), mk("DF/DF"), mk("DF"));
 		assertUpdated("DF/DF");
 		assertRemoved("DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_4() throws Exception {
 		// 4 (basically same as 3, just with H and M different)
-		tearDown();
-		setUp();
 		doit(mk("DF/DF"), mkmap("DF/DF", "foo"), mk("DF"));
 		assertUpdated("DF/DF");
 		assertRemoved("DF");
 		
+	}
+
+	public void testDirectoryFileConflicts_5() throws Exception {
 		// 5
-		tearDown();
-		setUp();
 		doit(mk("DF/DF"), mk("DF"), mk("DF"));
 		assertRemoved("DF/DF");
 		
+	}
+
+	public void testDirectoryFileConflicts_6() throws Exception {
 		// 6
-		tearDown();
-		setUp();
 		setupCase(mk("DF/DF"), mk("DF"), mk("DF"));
 		writeTrashFile("DF", "different");
 		go();
 		assertRemoved("DF/DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_7() throws Exception {
 		// 7
-		tearDown();
-		setUp();
 		doit(mk("DF"), mk("DF"), mk("DF/DF"));
 		assertUpdated("DF");
 		assertRemoved("DF/DF");
@@ -334,29 +339,40 @@ public class ReadTreeTest extends RepositoryTestCase {
 		assertConflict("DF/DF/DF/DF/DF");
 		assertUpdated("DF/DF");
 
+	}
+
+	// 8 ?
+
+	public void testDirectoryFileConflicts_9() throws Exception {
 		// 9
-		tearDown();
-		setUp();
 		doit(mk("DF"), mkmap("DF", "QP"), mk("DF/DF"));
 		assertRemoved("DF/DF");
 		assertUpdated("DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_10() throws Exception {
 		// 10
 		cleanUpDF();
 		doit(mk("DF"), mk("DF/DF"), mk("DF/DF"));
 		assertNoConflicts();
 		
+	}
+
+	public void testDirectoryFileConflicts_11() throws Exception {
 		// 11
-		cleanUpDF();
 		doit(mk("DF"), mk("DF/DF"), mkmap("DF/DF", "asdf"));
 		assertConflict("DF/DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_12() throws Exception {
 		// 12
 		cleanUpDF();
 		doit(mk("DF"), mk("DF/DF"), mk("DF"));
 		assertRemoved("DF");
 		assertUpdated("DF/DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_13() throws Exception {
 		// 13
 		cleanUpDF();
 		setupCase(mk("DF"), mk("DF/DF"), mk("DF"));
@@ -364,29 +380,39 @@ public class ReadTreeTest extends RepositoryTestCase {
 		go();
 		assertConflict("DF");
 		assertUpdated("DF/DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_14() throws Exception {
 		// 14
 		cleanUpDF();
 		doit(mk("DF"), mk("DF/DF"), mkmap("DF", "Foo"));
 		assertConflict("DF");
 		assertUpdated("DF/DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_15() throws Exception {
 		// 15
 		doit(mkmap(), mk("DF/DF"), mk("DF"));
 		assertRemoved("DF");
 		assertUpdated("DF/DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_15b() throws Exception {
 		// 15, take 2, just to check multi-leveled
 		doit(mkmap(), mk("DF/DF/DF/DF"), mk("DF"));
 		assertRemoved("DF");
 		assertUpdated("DF/DF/DF/DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_16() throws Exception {
 		// 16
 		cleanUpDF();
 		doit(mkmap(), mk("DF"), mk("DF/DF/DF"));
 		assertRemoved("DF/DF/DF");
 		assertUpdated("DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_17() throws Exception {
 		// 17
 		cleanUpDF();
 		setupCase(mkmap(), mk("DF"), mk("DF/DF/DF"));
@@ -394,13 +420,17 @@ public class ReadTreeTest extends RepositoryTestCase {
 		go();
 		assertConflict("DF/DF/DF");
 		assertUpdated("DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_18() throws Exception {
 		// 18
 		cleanUpDF();
 		doit(mk("DF/DF"), mk("DF/DF/DF/DF"), null);
 		assertRemoved("DF/DF");
 		assertUpdated("DF/DF/DF/DF");
-		
+	}
+
+	public void testDirectoryFileConflicts_19() throws Exception {
 		// 19
 		cleanUpDF();
 		doit(mk("DF/DF/DF/DF"), mk("DF/DF/DF"), null);
-- 
1.5.4.2
