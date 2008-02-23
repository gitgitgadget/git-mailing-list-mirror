From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 03/10] WorkdirCheckout: more test for names that are close
Date: Sun, 24 Feb 2008 00:50:36 +0100
Message-ID: <1203810643-28819-4-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:52:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4AP-0001IU-AN
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbYBWXvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYBWXvS
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:51:18 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11202 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbYBWXuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:50:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 10FB680069D;
	Sun, 24 Feb 2008 00:50:54 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gn3Tsk1sAZYO; Sun, 24 Feb 2008 00:50:52 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 556E780280D;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id EE2E929316; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74891>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/ReadTreeTest.java     |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
index 7ac48c9..6faedc7 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReadTreeTest.java
@@ -477,7 +477,21 @@ public class ReadTreeTest extends RepositoryTestCase {
 		
 		assertNoConflicts();
 	}
-	
+
+	public void testCloseNameConflictsX0() throws IOException {
+		setupCase(mkmap("a/a", "a/a-c"), mkmap("a/a","a/a", "b.b/b.b","b.b/b.bs"), mkmap("a/a", "a/a-c") );
+		checkout();
+		go();
+		assertNoConflicts();
+	}
+
+	public void testCloseNameConflicts1() throws IOException {
+		setupCase(mkmap("a/a", "a/a-c"), mkmap("a/a","a/a", "a.a/a.a","a.a/a.a"), mkmap("a/a", "a/a-c") );
+		checkout();
+		go();
+		assertNoConflicts();
+	}
+
 	private void checkout() throws IOException {
 		readTree = new WorkDirCheckout(db, trash, head, index, merge);
 		readTree.checkout();
-- 
1.5.4.2
