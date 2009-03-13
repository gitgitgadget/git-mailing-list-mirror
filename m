From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/3] Add lookupBlob to RevWalk
Date: Fri, 13 Mar 2009 11:11:50 -0700
Message-ID: <1236967912-15088-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 19:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiBsq-00077Q-UB
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 19:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbZCMSLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 14:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbZCMSLz
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 14:11:55 -0400
Received: from george.spearce.org ([209.20.77.23]:57843 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZCMSLy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 14:11:54 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D108B3814F; Fri, 13 Mar 2009 18:11:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5BB7A3814F;
	Fri, 13 Mar 2009 18:11:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.288.gc3f22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113215>

Its useful if you want to get a handle on a blob object.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index 316f722..e47f9d9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -510,6 +510,25 @@ public void setTreeFilter(final TreeFilter newFilter) {
 	}
 
 	/**
+	 * Locate a reference to a blob without loading it.
+	 * <p>
+	 * The blob may or may not exist in the repository. It is impossible to tell
+	 * from this method's return value.
+	 * 
+	 * @param id
+	 *            name of the blob object.
+	 * @return reference to the blob object. Never null.
+	 */
+	public RevBlob lookupBlob(final AnyObjectId id) {
+		RevBlob c = (RevBlob) objects.get(id);
+		if (c == null) {
+			c = new RevBlob(id);
+			objects.add(c);
+		}
+		return c;
+	}
+
+	/**
 	 * Locate a reference to a tree without loading it.
 	 * <p>
 	 * The tree may or may not exist in the repository. It is impossible to tell
-- 
1.6.2.288.gc3f22
