From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Expose RawParseUtils.match to application callers
Date: Tue, 30 Sep 2008 18:31:26 -0700
Message-ID: <1222824690-7632-2-git-send-email-spearce@spearce.org>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 03:33:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkqam-0006Nd-Bk
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 03:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbYJABbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 21:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbYJABbk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 21:31:40 -0400
Received: from george.spearce.org ([209.20.77.23]:51624 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbYJABbf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 21:31:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A66AB3838D; Wed,  1 Oct 2008 01:31:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E906D3835F;
	Wed,  1 Oct 2008 01:31:30 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.569.g798a2a
In-Reply-To: <1222824690-7632-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97181>

This utility can be useful when parsing a buffer directly, such as
for a commit or tag object's header lines.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index dbc2e83..2ab3bfe 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -61,7 +61,18 @@
 			digits[i] = (byte) (i - '0');
 	}
 
-	private static final int match(final byte[] b, int ptr, final byte[] src) {
+	/**
+	 * Determine if b[ptr] matches src.
+	 * 
+	 * @param b
+	 *            the buffer to scan.
+	 * @param ptr
+	 *            first position within b, this should match src[0].
+	 * @param src
+	 *            the buffer to test for equality with b.
+	 * @return ptr += src.length if b[ptr..src.length] == src; else -1.
+	 */
+	public static final int match(final byte[] b, int ptr, final byte[] src) {
 		if (ptr + src.length >= b.length)
 			return -1;
 		for (int i = 0; i < src.length; i++, ptr++)
-- 
1.6.0.2.569.g798a2a
