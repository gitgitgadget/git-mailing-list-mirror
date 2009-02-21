From: ferry.huberts@pelagic.nl
Subject: [EGIT] [PATCH 2/2] Make sure to set up the default (pull) remote branch for master
Date: Sat, 21 Feb 2009 16:17:48 +0100
Message-ID: <e26eb3c2a7a0ce2b96252f00c17a62913d741579.1235228532.git.ferry.huberts@pelagic.nl>
References: <cover.1235228532.git.ferry.huberts@pelagic.nl>
 <80065b1339c7b235b19fa1f5a40a58dca335ae91.1235228532.git.ferry.huberts@pelagic.nl>
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 16:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Latdw-0002Vg-Cd
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 16:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbZBUPSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 10:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbZBUPR6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 10:17:58 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:55609 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753193AbZBUPRz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Feb 2009 10:17:55 -0500
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 6903458BDD0;
	Sat, 21 Feb 2009 16:17:53 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <80065b1339c7b235b19fa1f5a40a58dca335ae91.1235228532.git.ferry.huberts@pelagic.nl>
In-Reply-To: <cover.1235228532.git.ferry.huberts@pelagic.nl>
References: <cover.1235228532.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110960>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

This is to make sure that the git plugin sets up a clone
in the same fashion as the CLI git clone command.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 .../org/spearce/egit/core/op/CloneOperation.java   |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
index f9ff6a3..ad786cb 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
@@ -32,6 +32,7 @@
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryConfig;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.WorkDirCheckout;
 import org.spearce.jgit.transport.FetchResult;
@@ -158,6 +159,11 @@ private void doInit(final IProgressMonitor monitor)
 		local.getConfig().setBoolean("core", null, "bare", false);
 		
 		remoteConfig.update(local.getConfig());
+
+		/* setup the default (pull) remote branch for master */
+		local.getConfig().setString(RepositoryConfig.BRANCH_SECTION, Constants.MASTER, "remote", remoteName);
+		local.getConfig().setString(RepositoryConfig.BRANCH_SECTION, Constants.MASTER, "merge", Constants.R_HEADS + Constants.MASTER);
+
 		local.getConfig().save();
 	}
 
-- 
1.6.0.6
