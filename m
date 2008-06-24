From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 3/4] Added a method to get the non-relative name from the tree walker
Date: Tue, 24 Jun 2008 23:36:31 +0200
Message-ID: <1214343392-5341-4-git-send-email-robin.rosenberg@dewire.com>
References: <20080622233525.GJ11793@spearce.org>
 <1214343392-5341-1-git-send-email-robin.rosenberg@dewire.com>
 <1214343392-5341-2-git-send-email-robin.rosenberg@dewire.com>
 <1214343392-5341-3-git-send-email-robin.rosenberg@dewire.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Florian Koeberle <florianskarten@web.de>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 00:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHM8-0008Lh-Qb
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbYFXWuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754691AbYFXWuJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:50:09 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:55703 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753726AbYFXWt7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 18:49:59 -0400
Received: from localhost.localdomain (213.67.100.250) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 483EBD680054AA45; Tue, 24 Jun 2008 23:40:31 +0200
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1214343392-5341-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86170>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   21 ++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 42f8b25..a5eb4d9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -499,6 +499,17 @@ public class TreeWalk {
 	}
 
 	/**
+	 * Get the current entry's name.
+	 * <p>
+	 *
+	 * @return name of the current entry only.
+	 * @see #getPathString()
+	 */
+	public String getName() {
+		return nameOf(currentHead);
+	}
+
+	/**
 	 * Test if the supplied path matches the current entry's path.
 	 * <p>
 	 * This method tests that the supplied path is exactly equal to the current
@@ -659,4 +670,14 @@ public class TreeWalk {
 					+ Constants.CHARACTER_ENCODING, uee);
 		}
 	}
+
+	private static String nameOf(final AbstractTreeIterator t) {
+		try {
+			return new String(t.path, t.pathOffset, t.pathLen - t.pathOffset,
+					Constants.CHARACTER_ENCODING);
+		} catch (UnsupportedEncodingException uee) {
+			throw new RuntimeException("JVM doesn't support "
+					+ Constants.CHARACTER_ENCODING, uee);
+		}
+	}
 }
-- 
1.5.5.1.178.g1f811
