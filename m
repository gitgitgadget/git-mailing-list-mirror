From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 09/10] Drop unused File arguments in IndexTreeWalker and WorkdirCheckout
Date: Mon, 16 Mar 2009 21:14:42 +0100
Message-ID: <1237234483-3405-10-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-5-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-6-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-7-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-8-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-9-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:17:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJFe-0007z8-CA
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754AbZCPUPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759178AbZCPUPe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:15:34 -0400
Received: from mail.dewire.com ([83.140.172.130]:5292 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758705AbZCPUP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:15:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E58B9138AD6C;
	Mon, 16 Mar 2009 21:15:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1GiOkMrUDHqi; Mon, 16 Mar 2009 21:15:25 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 3EAAF138AD63;
	Mon, 16 Mar 2009 21:14:46 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-9-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113370>

---
 .../src/org/spearce/jgit/lib/IndexTreeWalker.java  |    8 ++++----
 .../src/org/spearce/jgit/lib/WorkDirCheckout.java  |    5 ++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
index 5c7909a..e2078e1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
@@ -104,10 +104,10 @@ public IndexTreeWalker(GitIndex index, Tree mainTree, Tree newTree, File root, I
 	 * @throws IOException
 	 */
 	public void walk() throws IOException {
-		walk(mainTree, newTree, "");
+		walk(mainTree, newTree);
 	}
 
-	private void walk(Tree tree, Tree auxTree, String curDir) throws IOException {
+	private void walk(Tree tree, Tree auxTree) throws IOException {
 		TreeIterator mi = new TreeIterator(tree, TreeIterator.Order.POSTORDER);
 		TreeIterator ai = new TreeIterator(auxTree, TreeIterator.Order.POSTORDER);
 		TreeEntry m = mi.hasNext() ? mi.next() : null;
@@ -124,7 +124,7 @@ private void walk(Tree tree, Tree auxTree, String curDir) throws IOException {
 			Entry     pi = cmpmi >= 0 && cmpai >= 0 ? i : null;
 
 			if (pi != null)
-				visitEntry(pm, pa, pi, root);
+				visitEntry(pm, pa, pi);
 			else
 				finishVisitTree(pm, pa, curIndexPos, root);
 
@@ -135,7 +135,7 @@ private void walk(Tree tree, Tree auxTree, String curDir) throws IOException {
 	}
 
 	private void visitEntry(TreeEntry t1, TreeEntry t2,
-			Entry i, File root) throws IOException {
+			Entry i) throws IOException {
 
 		assert t1 != null || t2 != null || i != null : "Needs at least one entry";
 		assert root != null : "Needs workdir";
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
index d3da74a..8435223 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkDirCheckout.java
@@ -259,7 +259,7 @@ public void visitEntry(TreeEntry treeEntry, TreeEntry auxEntry,
 				if (treeEntry instanceof Tree || auxEntry instanceof Tree) {
 					throw new IllegalArgumentException("Can't pass me a tree!");
 				}
-				processEntry(treeEntry, auxEntry, indexEntry, file);
+				processEntry(treeEntry, auxEntry, indexEntry);
 			}
 	
 			@Override
@@ -294,8 +294,7 @@ else if (file.isDirectory()) {
 		conflicts.removeAll(removed);
 	}
 
-	void processEntry(TreeEntry h, TreeEntry m, Entry i,
-			File file) throws IOException {
+	void processEntry(TreeEntry h, TreeEntry m, Entry i) throws IOException {
 				ObjectId iId = (i == null ? null : i.getObjectId());
 				ObjectId mId = (m == null ? null : m.getId());
 				ObjectId hId = (h == null ? null : h.getId());
-- 
1.6.1.285.g35d8b
