From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/10] Expose DirCacheEntry.getFileMode as a utility function
Date: Thu, 22 Jan 2009 15:28:03 -0800
Message-ID: <1232666890-23488-4-git-send-email-spearce@spearce.org>
References: <1232666890-23488-1-git-send-email-spearce@spearce.org>
 <1232666890-23488-2-git-send-email-spearce@spearce.org>
 <1232666890-23488-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:29:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ8zX-0007uv-5y
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 00:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298AbZAVX2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 18:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758115AbZAVX2S
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 18:28:18 -0500
Received: from george.spearce.org ([209.20.77.23]:55224 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbZAVX2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 18:28:14 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5B6A538239; Thu, 22 Jan 2009 23:28:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 85F6838211;
	Thu, 22 Jan 2009 23:28:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.399.g0d272
In-Reply-To: <1232666890-23488-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106792>

Its easier to get the FileMode object in some applications than to
get the raw mode and convert it to the FileMode in the application
code.  Its slower, but sometimes you just have to have the proper
FileMode singleton.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/dircache/DirCacheEntry.java   |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
index cc683d7..355cd3e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCacheEntry.java
@@ -295,6 +295,15 @@ public int getRawMode() {
 	}
 
 	/**
+	 * Obtain the {@link FileMode} for this entry.
+	 * 
+	 * @return the file mode singleton for this entry.
+	 */
+	public FileMode getFileMode() {
+		return FileMode.fromBits(getRawMode());
+	}
+
+	/**
 	 * Set the file mode for this entry.
 	 *
 	 * @param mode
-- 
1.6.1.399.g0d272
