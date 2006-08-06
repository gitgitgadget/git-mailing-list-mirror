From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Fixes to packed delta format reading.
Date: Sun, 06 Aug 2006 20:40:38 +0200
Message-ID: <20060806184038.7591.12898.stgit@lathund.dewire.com>
References: <20060806183748.7591.61536.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Aug 06 20:41:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9nYO-0007Ej-1G
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 20:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWHFSkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 14:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWHFSko
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 14:40:44 -0400
Received: from [83.140.172.130] ([83.140.172.130]:34110 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1750796AbWHFSko
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 14:40:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 9064FAE521F
	for <git@vger.kernel.org>; Sun,  6 Aug 2006 20:38:35 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13338-07 for <git@vger.kernel.org>; Sun,  6 Aug 2006 20:38:35 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id 7A34080264C
	for <git@vger.kernel.org>; Sun,  6 Aug 2006 20:38:35 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 40AC727EDE
	for <git@vger.kernel.org>; Sun,  6 Aug 2006 20:40:38 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060806183748.7591.61536.stgit@lathund.dewire.com>
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24989>

From: Robin Rosenberg <robin.rosenberg@dewire.com>


---

 .../src/org/spearce/jgit/lib/PatchDeltaStream.java |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PatchDeltaStream.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PatchDeltaStream.java
index 808e854..11a7679 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PatchDeltaStream.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PatchDeltaStream.java
@@ -105,7 +105,7 @@ public class PatchDeltaStream extends In
                             + " load delta base for patching.");
                     }
                     shift += n;
-                    expBaseLen += n;
+                    expBaseLen -= n;
                 }
             }
             finally
@@ -269,7 +269,7 @@ public class PatchDeltaStream extends In
         throws IOException
     {
         int r;
-        while ((r = read(buf, o, len)) > 0)
+        while ((r = deltaStream.read(buf, o, len)) > 0)
         {
             o += r;
             len -= r;
