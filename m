X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Oops, get the commit first, then the tree.
Date: Sun, 3 Dec 2006 01:45:45 +0100
Message-ID: <200612030145.45567.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 00:43:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33070>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqfSA-00050i-G4 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 01:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424900AbWLCAn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 19:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424899AbWLCAn2
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 19:43:28 -0500
Received: from [83.140.172.130] ([83.140.172.130]:23405 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1424898AbWLCAn2 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 19:43:28 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 6F77E80281C; Sun,  3 Dec 2006 01:39:40 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 08364-05; Sun,  3 Dec
 2006 01:39:40 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 2AFFC80019B; Sun,  3 Dec 2006 01:39:40 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

This made the eclipse plugin unable to connect to Git.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java 
b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index bfdcd3e..2344817 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -168,7 +168,8 @@ public class Repository {
     }
 
     public Tree mapTree(final String revstr) throws IOException {
-	final ObjectId id = resolve(revstr);
+	Commit commit = mapCommit(revstr);
+	final ObjectId id = commit.getTreeId();
 	return id != null ? mapTree(id) : null;
     }
 
-- 
1.4.4.gf05d

