From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/2] Make Git property page cope with empty repositories and not yet born branches
Date: Wed,  8 Apr 2009 17:49:40 +0200
Message-ID: <1239205781-28009-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:51:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lra3k-0002tO-Cm
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbZDHPtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbZDHPtw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:49:52 -0400
Received: from mail.dewire.com ([83.140.172.130]:6896 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbZDHPtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 11:49:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6290E14915DA;
	Wed,  8 Apr 2009 17:49:45 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ddf77u9ON-aq; Wed,  8 Apr 2009 17:49:44 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 8B6EE14915D6;
	Wed,  8 Apr 2009 17:49:44 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116089>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../preferences/GitProjectPropertyPage.java        |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java
index 4c97cc8..d3afd97 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java
@@ -94,7 +94,13 @@ private void fillValues(Repository repository) throws IOException {
 
 		final ObjectId objectId = repository
 				.resolve(repository.getFullBranch());
-		id.setText(objectId.name());
+		if (objectId == null) {
+			if (repository.getAllRefs().size() == 0)
+				id.setText("None (empty repository)");
+			else
+				id.setText("None (unborn branch)");
+		} else
+			id.setText(objectId.name());
 	}
 
 	/**
-- 
1.6.2.2.446.gfbdc0
