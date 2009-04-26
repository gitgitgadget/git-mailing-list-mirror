From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Skip unnecessary test in ObjectChecker
Date: Sun, 26 Apr 2009 16:36:15 +0200
Message-ID: <1240756575-24113-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Apr 27 12:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly5UX-0002m2-5G
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 16:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbZDZOgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 10:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbZDZOgY
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 10:36:24 -0400
Received: from mail.dewire.com ([83.140.172.130]:15676 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728AbZDZOgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 10:36:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C9E4A14A8B38;
	Sun, 26 Apr 2009 16:36:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QT4eOLcJ1LYv; Sun, 26 Apr 2009 16:36:17 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E990714A8B37;
	Sun, 26 Apr 2009 16:36:16 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.1.g4f9e8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117651>

The check for duplicate names unnecessarily checks for end of buffer.
Previous tests took care of that.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/ObjectChecker.java    |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
index 75e3c77..5a3da39 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
@@ -254,14 +254,10 @@ private static boolean duplicateName(final byte[] raw,
 
 			final int nextNamePos = nextPtr;
 			for (;;) {
-				if (nextPtr == sz)
-					return false;
 				final byte c = raw[nextPtr++];
 				if (c == 0)
 					break;
 			}
-			if (nextNamePos + 1 == nextPtr)
-				return false;
 
 			final int cmp = pathCompare(raw, thisNamePos, thisNameEnd,
 					FileMode.TREE.getBits(), nextNamePos, nextPtr - 1, nextMode);
-- 
1.6.3.rc2.1.g4f9e8.dirty
