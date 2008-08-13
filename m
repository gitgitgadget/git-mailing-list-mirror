From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH] Allow EGit to handle linked resources at any depth
Date: Tue, 12 Aug 2008 20:24:09 -0700
Message-ID: <1218597849-24412-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:25:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT6z4-00060l-8N
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbYHMDYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 23:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbYHMDYL
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:24:11 -0400
Received: from george.spearce.org ([209.20.77.23]:35584 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYHMDYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:24:11 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id BD06B38376; Wed, 13 Aug 2008 03:24:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1E050381FD;
	Wed, 13 Aug 2008 03:24:10 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.242.gb31c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92171>

We already were handling linked resources that appear anywhere
in the project, but Eclipse didn't know we were willing to do
that sort of magic in our provider code as we did not override
the correct method for it in GitProvider.

We now support linked folders which are at any level.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/egit/core/GitProvider.java     |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
index fcab971..a16aca9 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
@@ -41,6 +41,11 @@ public class GitProvider extends RepositoryProvider {
 		return true;
 	}
 
+	@Override
+	public boolean canHandleLinkedResourceURI() {
+		return true;
+	}
+
 	public synchronized IMoveDeleteHook getMoveDeleteHook() {
 		if (hook == null) {
 			hook = new GitMoveDeleteHook(getData());
-- 
1.6.0.rc2.242.gb31c
