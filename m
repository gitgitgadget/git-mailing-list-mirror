From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/23] Add MutableObjectId.clear() to set the id to zeroId
Date: Wed, 24 Dec 2008 18:10:58 -0800
Message-ID: <1230171079-17156-3-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjG-00029A-4f
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbYLYCL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbYLYCLZ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:25 -0500
Received: from george.spearce.org ([209.20.77.23]:59406 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYLYCLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:22 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 941E138222; Thu, 25 Dec 2008 02:11:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A159D38210;
	Thu, 25 Dec 2008 02:11:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103867>

This makes it easier to set any MutableObjectId to the same value
as the zeroId.  Its logical to ask for a ".clear()" invocation when
you are writing application code, and its more efficient for the
JIT if we do 5 zero writes then to perform a copy from the zeroId
singleton.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/MutableObjectId.java  |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
index 5b16345..fadebab 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
@@ -66,6 +66,15 @@ MutableObjectId(MutableObjectId src) {
 		this.w5 = src.w5;
 	}
 
+	/** Make this id match {@link ObjectId#zeroId()}. */
+	public void clear() {
+		w1 = 0;
+		w2 = 0;
+		w3 = 0;
+		w4 = 0;
+		w5 = 0;
+	}
+
 	/**
 	 * Convert an ObjectId from raw binary representation.
 	 * 
-- 
1.6.1.rc4.301.g5497a
