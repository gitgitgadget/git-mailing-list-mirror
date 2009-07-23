From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH] Fixed Windows compatiblity bug in T0003_Basic.test027_UnpackedRefHigherPriorityThanPacked
Date: Thu, 23 Jul 2009 15:38:46 +0400
Message-ID: <1248349126-3192-1-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 13:39:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTwdd-0003VG-Qu
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 13:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbZGWLiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 07:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbZGWLiw
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 07:38:52 -0400
Received: from mail.intellij.net ([213.182.181.98]:54823 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbZGWLiv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 07:38:51 -0400
Received: (qmail 8604 invoked by uid 89); 23 Jul 2009 11:38:47 -0000
Received: by simscan 1.1.0 ppid: 8491, pid: 8596, t: 0.0065s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 23 Jul 2009 11:38:46 -0000
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123866>

On Windows println outputs "\r\n" sequence, so test fails since '\r' is
assumed to be a part of reference. This patch fixes test by printing '\n'
explictly instead of using system line separtory through println.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
index b9e8d1d..df55b4f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -507,7 +507,8 @@ assertEquals(ObjectId.fromString("00b1f73724f493096d1ffa0b0f1f1482dbb8c936"),
 	public void test027_UnpackedRefHigherPriorityThanPacked() throws IOException {
 		PrintWriter writer = new PrintWriter(new FileWriter(new File(db.getDirectory(), "refs/heads/a"))); 
 		String unpackedId = "7f822839a2fe9760f386cbbbcb3f92c5fe81def7";
-		writer.println(unpackedId);
+		writer.print(unpackedId);
+		writer.print('\n');
 		writer.close();
 
 		ObjectId resolved = db.resolve("refs/heads/a");
-- 
1.6.1.2
