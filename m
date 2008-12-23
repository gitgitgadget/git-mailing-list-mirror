From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] Permit subclass of ObjectId (e.g. RevObject) when calling PackWriter
Date: Tue, 23 Dec 2008 14:56:44 -0800
Message-ID: <1230073007-17337-3-git-send-email-spearce@spearce.org>
References: <1230073007-17337-1-git-send-email-spearce@spearce.org>
 <1230073007-17337-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 23:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFGCz-0004pX-Ac
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 23:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbYLWW4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 17:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYLWW4w
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 17:56:52 -0500
Received: from george.spearce.org ([209.20.77.23]:51449 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbYLWW4t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 17:56:49 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id CB41638197; Tue, 23 Dec 2008 22:56:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3A9AE38197;
	Tue, 23 Dec 2008 22:56:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230073007-17337-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103852>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 32bf738..32394f2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -436,8 +436,9 @@ public void preparePack(final Iterator<RevObject> objectsSource)
 	 * @throws IOException
 	 *             when some I/O problem occur during reading objects.
 	 */
-	public void preparePack(final Collection<ObjectId> interestingObjects,
-			final Collection<ObjectId> uninterestingObjects,
+	public void preparePack(
+			final Collection<? extends ObjectId> interestingObjects,
+			final Collection<? extends ObjectId> uninterestingObjects,
 			final boolean thin, final boolean ignoreMissingUninteresting)
 			throws IOException {
 		ObjectWalk walker = setUpWalker(interestingObjects,
@@ -727,8 +728,8 @@ private void writeChecksum() throws IOException {
 	}
 
 	private ObjectWalk setUpWalker(
-			final Collection<ObjectId> interestingObjects,
-			final Collection<ObjectId> uninterestingObjects,
+			final Collection<? extends ObjectId> interestingObjects,
+			final Collection<? extends ObjectId> uninterestingObjects,
 			final boolean thin, final boolean ignoreMissingUninteresting)
 			throws MissingObjectException, IOException,
 			IncorrectObjectTypeException {
-- 
1.6.1.rc4.301.g5497a
