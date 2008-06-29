From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/21] Indicate the protocol jgit doesn't support push over
Date: Sun, 29 Jun 2008 03:59:21 -0400
Message-ID: <1214726371-93520-12-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
 <1214726371-93520-7-git-send-email-spearce@spearce.org>
 <1214726371-93520-8-git-send-email-spearce@spearce.org>
 <1214726371-93520-9-git-send-email-spearce@spearce.org>
 <1214726371-93520-10-git-send-email-spearce@spearce.org>
 <1214726371-93520-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrn-0000I1-OO
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYF2IAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbYF2IAy
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36787 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYF2IAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpR-0004Nv-8F; Sun, 29 Jun 2008 04:00:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id A314A20FBAE; Sun, 29 Jun 2008 04:00:09 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 833FD20FBD3;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-11-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86774>

Not all of jgit's protocols will support push, as it may take time
to build their implementations or simply prove impractical.  Some
users may not understand what a walking transport is, but they can
understand that http isn't supported for push.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/WalkTransport.java  |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
index 29dd661..e208b12 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
@@ -59,7 +59,7 @@ abstract class WalkTransport extends Transport {
 
 	@Override
 	public PushConnection openPush() throws NotSupportedException {
-		throw new NotSupportedException(
-				"Push is not supported by object walking transports");
+		final String s = getURI().getScheme();
+		throw new NotSupportedException("Push not supported over " + s + ".");
 	}
 }
-- 
1.5.6.74.g8a5e
