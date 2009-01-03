From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Allow non-ASCII ref names when writing packs
Date: Sat,  3 Jan 2009 23:04:35 +0100
Message-ID: <1231020275-7637-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jan 03 23:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJEdB-000149-Tt
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 23:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbZACWEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 17:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbZACWEm
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 17:04:42 -0500
Received: from mail.dewire.com ([83.140.172.130]:13104 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbZACWEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 17:04:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8A3361484F5B;
	Sat,  3 Jan 2009 23:04:36 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id thY9DQbSyYBy; Sat,  3 Jan 2009 23:04:36 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id F199A8006AF;
	Sat,  3 Jan 2009 23:04:35 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104481>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/transport/PacketLineOut.java  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Disovered this bug when trying to clone a local repo with some "funny" 
ref names. C Git handles them so jgit should too.

-- robin

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineOut.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineOut.java
index aae4be5..cb6d89a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineOut.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineOut.java
@@ -54,7 +54,7 @@ PacketLineOut(final OutputStream i) {
 	}
 
 	void writeString(final String s) throws IOException {
-		writePacket(Constants.encodeASCII(s));
+		writePacket(Constants.encode(s));
 	}
 
 	void writePacket(final byte[] packet) throws IOException {
-- 
1.6.1.rc3.56.gd0306
