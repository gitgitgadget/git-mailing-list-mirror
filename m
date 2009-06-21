From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Cleanup Transport.applyConfig to use setter methods more consistently
Date: Sat, 20 Jun 2009 18:21:55 -0700
Message-ID: <1245547316-10299-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 03:23:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIBlv-0004JE-1a
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 03:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbZFUBVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 21:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbZFUBVz
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 21:21:55 -0400
Received: from george.spearce.org ([209.20.77.23]:39665 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbZFUBVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 21:21:54 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5FBD9381FF; Sun, 21 Jun 2009 01:21:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6B48B3819E;
	Sun, 21 Jun 2009 01:21:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.416.g04d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121958>

This just struck me as odd that we sometimes used a setter method,
and sometimes used direct assignment to the field.  Now we use the
setter method if it is available.  The fetch and push refspecs do
not have setters, so must still be done by direct field assignment.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/Transport.java  |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 1068f50..c36ccdd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -568,9 +568,9 @@ public void setRemoveDeletedRefs(final boolean remove) {
 	 */
 	public void applyConfig(final RemoteConfig cfg) {
 		setOptionUploadPack(cfg.getUploadPack());
-		fetch = cfg.getFetchRefSpecs();
+		setOptionReceivePack(cfg.getReceivePack());
 		setTagOpt(cfg.getTagOpt());
-		optionReceivePack = cfg.getReceivePack();
+		fetch = cfg.getFetchRefSpecs();
 		push = cfg.getPushRefSpecs();
 	}
 
-- 
1.6.3.2.416.g04d0
