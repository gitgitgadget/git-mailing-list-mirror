From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 06/10] Add a utility method for shortening long ref names to short ones.
Date: Thu, 28 May 2009 00:08:53 +0200
Message-ID: <1243462137-24133-7-git-send-email-robin.rosenberg@dewire.com>
References: <20090520221651.GR30527@spearce.org>
 <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-4-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-5-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 28 00:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RJk-0005Vu-RT
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158AbZE0WJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757961AbZE0WJi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:09:38 -0400
Received: from mail.dewire.com ([83.140.172.130]:25360 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756692AbZE0WJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:09:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 64797145D131;
	Thu, 28 May 2009 00:09:36 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mXp-eIEgyy1j; Thu, 28 May 2009 00:09:35 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 65803145D133;
	Thu, 28 May 2009 00:09:00 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120120>

refs/heads/x -> x etc.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 9bed1b7..55dae27 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -1074,4 +1074,19 @@ public void scanForRepoChanges() throws IOException {
 		getAllRefs(); // This will look for changes to refs
 		getIndex(); // This will detect changes in the index
 	}
+
+	/**
+	 * @param refName
+	 * 
+	 * @return a more user friendly ref name
+	 */
+	public String shortenRefName(String refName) {
+		if (refName.startsWith(Constants.R_HEADS))
+			return refName.substring(Constants.R_HEADS.length());
+		if (refName.startsWith(Constants.R_TAGS))
+			return refName.substring(Constants.R_TAGS.length());
+		if (refName.startsWith(Constants.R_REMOTES))
+			return refName.substring(Constants.R_REMOTES.length());
+		return refName;
+	}
 }
-- 
1.6.3.dirty
