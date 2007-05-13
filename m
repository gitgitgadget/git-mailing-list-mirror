From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Write refs when creating tags
Date: Mon, 14 May 2007 01:39:15 +0200
Message-ID: <11790995573817-git-send-email-robin.rosenberg@dewire.com>
References: <11790995572233-git-send-email-robin.rosenberg@dewire.com>
 <11790995571082-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 14 01:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNyG-00061r-R1
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543AbXEMX7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758505AbXEMX7S
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:59:18 -0400
Received: from [83.140.172.130] ([83.140.172.130]:23499 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758543AbXEMX7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:59:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DB666802C04;
	Mon, 14 May 2007 01:33:00 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06019-09; Mon, 14 May 2007 01:33:00 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 66CE2802E1B;
	Mon, 14 May 2007 01:32:59 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id B15AC28917; Mon, 14 May 2007 01:39:17 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <11790995571082-git-send-email-robin.rosenberg@dewire.com>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47198>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java |    4 ++--
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
index d5c6b54..d2a1b2b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tag.java
@@ -128,9 +128,9 @@ public class Tag {
 		if (tagger!=null || message!=null || type!=null) {
 			ObjectId tagid = new ObjectWriter(objdb).writeTag(this);
 			setTagId(tagid);
-			objdb.writeRef("refs/heads/"+getTag(),tagid);
+			objdb.writeRef("refs/tags/"+getTag(),tagid);
 		} else {
-			objdb.writeRef("refs/heads/"+getTag(),objId);
+			objdb.writeRef("refs/tags/"+getTag(),objId);
 		}
 	}
 
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
index 115e391..2f76907 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0003_Basic.java
@@ -331,7 +331,7 @@ public class T0003_Basic extends RepositoryTestCase {
 		t.tag();
 		assertEquals("6759556b09fbb4fd8ae5e315134481cc25d46954", t.getTagId().toString());
 
-		Tag mapTag = db.mapTag("6759556b09fbb4fd8ae5e315134481cc25d46954");
+		Tag mapTag = db.mapTag("test020");
 		assertEquals("blob", mapTag.getType());
 		assertEquals("test020 tagged\n", mapTag.getMessage());
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
@@ -365,7 +365,7 @@ public class T0003_Basic extends RepositoryTestCase {
 		t.tag();
 		assertEquals("b0517bc8dbe2096b419d42424cd7030733f4abe5", t.getTagId().toString());
 
-		Tag mapTag = db.mapTag("b0517bc8dbe2096b419d42424cd7030733f4abe5");
+		Tag mapTag = db.mapTag("test021");
 		assertEquals("tree", mapTag.getType());
 		assertEquals("test021 tagged\n", mapTag.getMessage());
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
@@ -392,7 +392,7 @@ public class T0003_Basic extends RepositoryTestCase {
 		t.tag();
 		assertEquals("0ce2ebdb36076ef0b38adbe077a07d43b43e3807", t.getTagId().toString());
 
-		Tag mapTag = db.mapTag("0ce2ebdb36076ef0b38adbe077a07d43b43e3807");
+		Tag mapTag = db.mapTag("test022");
 		assertEquals("commit", mapTag.getType());
 		assertEquals("test022 tagged\n", mapTag.getMessage());
 		assertEquals(new PersonIdent(jauthor, 1154236443000L, -4 * 60), mapTag.getAuthor());
-- 
1.5.1.1
