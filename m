From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/12] Add tests to cover more methods of BinaryHunk
Date: Fri, 12 Dec 2008 14:05:48 -0800
Message-ID: <1229119558-1293-3-git-send-email-spearce@spearce.org>
References: <1229119558-1293-1-git-send-email-spearce@spearce.org>
 <1229119558-1293-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGB8-0004x0-Db
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbYLLWGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbYLLWGD
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:03 -0500
Received: from george.spearce.org ([209.20.77.23]:50665 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYLLWGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:00 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id C471F38221; Fri, 12 Dec 2008 22:05:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1835D38210;
	Fri, 12 Dec 2008 22:05:59 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102949>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/PatchTest.java      |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index 5850364..ebd23b4 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -199,10 +199,18 @@ assertTrue(fh.getNewName().startsWith(
 			assertTrue(fh.getHunks().isEmpty());
 			assertTrue(fh.hasMetaDataChanges());
 
-			assertNotNull(fh.getForwardBinaryHunk());
-			assertNotNull(fh.getReverseBinaryHunk());
-			assertEquals(binsizes[i], fh.getForwardBinaryHunk().getSize());
-			assertEquals(0, fh.getReverseBinaryHunk().getSize());
+			final BinaryHunk fwd = fh.getForwardBinaryHunk();
+			final BinaryHunk rev = fh.getReverseBinaryHunk();
+			assertNotNull(fwd);
+			assertNotNull(rev);
+			assertEquals(binsizes[i], fwd.getSize());
+			assertEquals(0, rev.getSize());
+
+			assertSame(fh, fwd.getFileHeader());
+			assertSame(fh, rev.getFileHeader());
+
+			assertSame(BinaryHunk.Type.LITERAL_DEFLATED, fwd.getType());
+			assertSame(BinaryHunk.Type.LITERAL_DEFLATED, rev.getType());
 		}
 
 		final FileHeader fh = p.getFiles().get(4);
-- 
1.6.1.rc2.306.ge5d5e
