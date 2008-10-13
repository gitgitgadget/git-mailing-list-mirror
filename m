From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/8] Expose DirCacheEntry.getFileMode as a utility function
Date: Mon, 13 Oct 2008 14:10:11 -0700
Message-ID: <1223932217-4771-3-git-send-email-spearce@spearce.org>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org>
 <1223932217-4771-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpUhV-0001zY-7e
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176AbYJMVKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756070AbYJMVKX
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:10:23 -0400
Received: from george.spearce.org ([209.20.77.23]:39770 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbYJMVKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:10:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E1E953826E; Mon, 13 Oct 2008 21:10:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3842D3826E;
	Mon, 13 Oct 2008 21:10:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.706.g340fc
In-Reply-To: <1223932217-4771-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98150>

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
1.6.0.2.706.g340fc
