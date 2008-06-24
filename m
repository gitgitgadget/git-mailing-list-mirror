From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 1/4] LsTree: Do not use the default first empty tree in the walker
Date: Tue, 24 Jun 2008 23:20:24 +0200
Message-ID: <1214342427-2077-1-git-send-email-robin.rosenberg@dewire.com>
References: <20080622233525.GJ11793@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Florian Koeberle <florianskarten@web.de>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 23:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBG0z-0000NM-81
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbYFXVY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 17:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbYFXVY2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 17:24:28 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:34083 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752278AbYFXVY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 17:24:27 -0400
Received: from localhost.localdomain (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A97950028D2DAE; Tue, 24 Jun 2008 23:24:26 +0200
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <20080622233525.GJ11793@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86149>

In f0ef5e1ef09d346432fead17bc82d78b7cfbd621 an empty tree
was added to all TreeWalkers.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/LsTree.java           |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
index 1bc7bbd..05ec8c3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/LsTree.java
@@ -65,6 +65,7 @@ class LsTree extends TextBuiltin {
 		else if (argi + 1 < args.length)
 			throw die("too many arguments");
 
+		walk.reset(); // drop the first empty tree, which we do not need here
 		final String n = args[argi];
 		if (is_WorkDir(n))
 			walk.addTree(new FileTreeIterator(new File(n)));
-- 
1.5.5.1.178.g1f811
