From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: [PATCH 2/2] Use NullProgressMonitor.INSTANCE and indent for loop
Date: Wed,  6 May 2009 21:37:04 +0100
Message-ID: <1241642224-6914-2-git-send-email-alex.blewitt@gmail.com>
References: <1241642224-6914-1-git-send-email-alex.blewitt@gmail.com>
Cc: git@vger.kernel.org, Alex Blewitt <alex.blewitt@gmail.com>
To: spearce@spearce.org, robin.rosenberg@dewire.com
X-From: git-owner@vger.kernel.org Wed May 06 22:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1nsE-0005T9-1C
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbZEFUhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbZEFUhG
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:37:06 -0400
Received: from server.bandlem.com ([217.155.97.60]:37067 "EHLO
	apple.int.bandlem.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756777AbZEFUhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 16:37:05 -0400
Received: by apple.int.bandlem.com (Postfix, from userid 1000)
	id 57AAAE25E4; Wed,  6 May 2009 21:37:04 +0100 (BST)
X-Mailer: git-send-email 1.6.2.2
In-Reply-To: <1241642224-6914-1-git-send-email-alex.blewitt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118381>

---
 .../src/org/spearce/jgit/lib/PackWriter.java       |   25 ++++++++++---------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 3d7004d..a35f61d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -230,8 +230,8 @@ public PackWriter(final Repository repo, final ProgressMonitor monitor) {
 	public PackWriter(final Repository repo, final ProgressMonitor imonitor,
 			final ProgressMonitor wmonitor) {
 		this.db = repo;
-		initMonitor = (imonitor == null ? new NullProgressMonitor() : imonitor);
-		writeMonitor = (wmonitor == null ? new NullProgressMonitor() : wmonitor);
+		initMonitor = imonitor == null ? NullProgressMonitor.INSTANCE : imonitor;
+		writeMonitor = wmonitor == null ? NullProgressMonitor.INSTANCE : wmonitor;
 		this.deflater = new Deflater(db.getConfig().getCore().getCompression());
 		outputVersion = repo.getConfig().getCore().getPackIndexVersion();
 	}
@@ -829,17 +829,18 @@ private ObjectWalk setUpWalker(
 			RevObject o = walker.parseAny(id);
 			walker.markStart(o);
 		}
-		if (uninterestingObjects != null)
-		for (ObjectId id : uninterestingObjects) {
-			final RevObject o;
-			try {
-				o = walker.parseAny(id);
-			} catch (MissingObjectException x) {
-				if (ignoreMissingUninteresting)
-					continue;
-				throw x;
+		if (uninterestingObjects != null) {
+			for (ObjectId id : uninterestingObjects) {
+				final RevObject o;
+				try {
+					o = walker.parseAny(id);
+				} catch (MissingObjectException x) {
+					if (ignoreMissingUninteresting)
+						continue;
+					throw x;
+				}
+				walker.markUninteresting(o);
 			}
-			walker.markUninteresting(o);
 		}
 		return walker;
 	}
-- 
1.6.2.2
