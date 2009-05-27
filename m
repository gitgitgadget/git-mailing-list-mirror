From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 02/10] Add a toString for debugging to RemoteRefUpdate
Date: Thu, 28 May 2009 00:08:49 +0200
Message-ID: <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com>
References: <20090520221651.GR30527@spearce.org>
 <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 28 00:09:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RJH-0005L4-FV
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757024AbZE0WJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756792AbZE0WJF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:09:05 -0400
Received: from mail.dewire.com ([83.140.172.130]:25337 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756669AbZE0WJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:09:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DB8D5145B3FE;
	Thu, 28 May 2009 00:09:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jEXMq+B7024r; Thu, 28 May 2009 00:09:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id D7F62145D12E;
	Thu, 28 May 2009 00:08:59 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120114>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

---
 .../spearce/jgit/transport/RemoteRefUpdate.java    |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
index 9b054eb..8af7d50 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
@@ -299,7 +299,8 @@ public Status getStatus() {
 
 	/**
 	 * Check whether update was fast-forward. Note that this result is
-	 * meaningful only after successful update (when status is {@link Status#OK}).
+	 * meaningful only after successful update (when status is {@link Status#OK}
+	 * ).
 	 *
 	 * @return true if update was fast-forward; false otherwise.
 	 */
@@ -341,4 +342,14 @@ protected void updateTrackingRef(final RevWalk walk) throws IOException {
 		else
 			trackingRefUpdate.update(walk);
 	}
+
+	@Override
+	public String toString() {
+		return "RemoteRefUpdate[remoteName=" + remoteName + ", " + status
+				+ ", " + (expectedOldObjectId!=null?expectedOldObjectId.abbreviate(localDb).name() :"(null)")
+				+ "..." + (newObjectId != null ? newObjectId.abbreviate(localDb).name() : "(null)")
+				+ (fastForward ? ", fastForward" : "")
+				+ ", srcRef=" + srcRef + (forceUpdate ? ", forceUpdate" : "") + ", message=" + (message != null ? "\""
+				+ message + "\"" : "null") + ", " + localDb.getDirectory() + "]";
+	}
 }
-- 
1.6.3.dirty
