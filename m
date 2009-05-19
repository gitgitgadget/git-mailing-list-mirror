From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/6] Allow non-ASCII ref names when writing the packed-refs file
Date: Wed, 20 May 2009 01:13:16 +0200
Message-ID: <1242774798-23639-5-git-send-email-robin.rosenberg@dewire.com>
References: <20090507155117.GS30527@spearce.org>
 <1242774798-23639-1-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-3-git-send-email-robin.rosenberg@dewire.com>
 <1242774798-23639-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed May 20 01:13:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6YV9-0003FB-4p
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 01:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbZESXNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 19:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472AbZESXN3
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 19:13:29 -0400
Received: from mail.dewire.com ([83.140.172.130]:25877 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755419AbZESXN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 19:13:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C6C5E145D125;
	Wed, 20 May 2009 01:13:25 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bSXYzKmdFUAv; Wed, 20 May 2009 01:13:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.11])
	by dewire.com (Postfix) with ESMTP id A8118145D128;
	Wed, 20 May 2009 01:13:22 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242774798-23639-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119572>

Previously we crashed. Now we encode using UTF-8. This may possibly
change the encoding in the packed-refs file as we try to be smart about
reading the file when converting to Java strings.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/RefWriter.java        |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java
index 2d39713..0a1bac8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java
@@ -145,7 +145,7 @@ public void writePackedRefs() throws IOException {
 				w.write('\n');
 			}
 		}
-		writeFile(Constants.PACKED_REFS, Constants.encodeASCII(w.toString()));
+		writeFile(Constants.PACKED_REFS, Constants.encode(w.toString()));
 	}
 
 	/**
-- 
1.6.3.dirty
