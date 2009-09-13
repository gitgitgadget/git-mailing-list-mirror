From: mr.gaffo@gmail.com
Subject: [PATCH JGit 08/19] changed signature to allow a IOException
Date: Sun, 13 Sep 2009 13:44:24 -0500
Message-ID: <1252867475-858-9-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4k-0003Gw-TV
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbZIMSo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbZIMSo4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:44:56 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:19834 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbZIMSos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:48 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549191and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IuebGfPN7o/dazBvDuQ6Y/sBs1IzQ/oAWYuHu9BQ5Og=;
        b=RNIudajNroFhbkiiHcC45HRNjyWElU2of3oGsw+hUdEPZYLMfgVeTiLhHIg1iZYYFY
         rGuMx+WdxEukb9/390HIL4dfVwlJzSOJAf+FYHS3yRBDOq2qcbZeu4yh0l2QVfktZfxU
         NzkTYj2xmOXDvM7pE21rgeN0oWVUvtAsojOU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wvtesURNhA00/WFemiubOsV31b1G1SPMysjaopU/Fc2mLqg9vAI5ZDmDnfNeWWqjnl
         lVcZU6rhbDG3cWMbhns28e8kxoNR0m95s/S9iLyoavbqsAJf6rnbQoom29DcFslF5267
         Z5KonIkNHk0WQ2n/0eIhTW3mF7/diueXpFntQ=
Received: by 10.100.130.11 with SMTP id c11mr5531014and.97.1252867491629;
        Sun, 13 Sep 2009 11:44:51 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128393>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../jgit/lib/AlternateRepositoryDatabase.java      |    2 +-
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |    3 ++-
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
index 5cb0579..70ce505 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
@@ -132,7 +132,7 @@ protected void closeAlternates(final ObjectDatabase[] alt) {
 	}
 
 	@Override
-	public void updateInfoCache() {
+	public void updateInfoCache() throws IOException {
 		odb.updateInfoCache();
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
index 68ff523..5ded7bb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
@@ -78,8 +78,9 @@ protected ObjectDatabase() {
 	 * Creates the caches that are typically done by 
 	 * update-server-info, namely objects/info/packs and 
 	 * info/refs
+	 * @throws IOException 
 	 */
-	public abstract void updateInfoCache();
+	public abstract void updateInfoCache() throws IOException;
 	
 	/**
 	 * Does this database exist yet?
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index a90ae00..95618b9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -516,7 +516,7 @@ boolean tryAgain(final long currLastModified) {
 	}
 
 	@Override
-	public void updateInfoCache() {
-		new UpdateDirectoryInfoCache(this.listLocalPacks(), this.infoDirectory).execute();
+	public void updateInfoCache() throws IOException {
+		new UpdateDirectoryInfoCache(this.listLocalPacks(), new File(this.infoDirectory, "packs")).execute();
 	}
 }
-- 
1.6.4.2
