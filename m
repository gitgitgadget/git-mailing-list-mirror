From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Remove throws IOException from UnpackedObjectLoader.getCachedBytes
Date: Wed, 22 Apr 2009 20:36:19 -0700
Message-ID: <1240457783-21434-2-git-send-email-spearce@spearce.org>
References: <1240457783-21434-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 05:38:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwplT-0005xI-0D
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 05:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbZDWDg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 23:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbZDWDg0
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 23:36:26 -0400
Received: from george.spearce.org ([209.20.77.23]:46497 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbZDWDgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 23:36:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id AAE8B38221; Thu, 23 Apr 2009 03:36:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3866B38211;
	Thu, 23 Apr 2009 03:36:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240457783-21434-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117285>

The UnpackedObjectLoader always fully materializes itself during the
object's constructor.  Thus the cached bytes are always ready on any
invocation of getCachedBytes(), and this method will never fail.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/UnpackedObjectLoader.java |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
index 7552b42..1352b72 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectLoader.java
@@ -201,7 +201,7 @@ public long getSize() {
 	}
 
 	@Override
-	public byte[] getCachedBytes() throws IOException {
+	public byte[] getCachedBytes() {
 		return bytes;
 	}
 
-- 
1.6.3.rc1.205.g37f8
