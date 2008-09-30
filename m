From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/8] Dispose of allocated colors on finalize()
Date: Wed,  1 Oct 2008 01:53:42 +0200
Message-ID: <1222818823-22780-3-git-send-email-robin.rosenberg@dewire.com>
References: <1222818823-22780-1-git-send-email-robin.rosenberg@dewire.com>
 <1222818823-22780-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 01:56:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkp4V-00040Q-0H
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbYI3Xyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYI3Xyy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:54:54 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:45830 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbYI3Xyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:54:51 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 605C738690; Wed,  1 Oct 2008 01:54:50 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 02A8738467; Wed,  1 Oct 2008 01:54:50 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id DB8FA37E43;
	Wed,  1 Oct 2008 01:54:49 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1222818823-22780-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97174>

---
 .../egit/ui/internal/history/SWTPlotRenderer.java  |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
index 23ec255..a58b3bf 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
@@ -45,6 +45,17 @@ SWTPlotRenderer(final Display d) {
 		sys_darkblue = d.getSystemColor(SWT.COLOR_DARK_BLUE);
 	}
 
+	@Override
+	protected void finalize() throws Throwable {
+		sys_black.dispose();
+		sys_blue.dispose();
+		sys_gray.dispose();
+		sys_darkblue.dispose();
+		sys_yellow.dispose();
+		sys_green.dispose();
+		sys_white.dispose();
+	}
+	
 	void paint(final Event event) {
 		g = event.gc;
 		cellX = event.x;
-- 
1.6.0.1.310.gf789d0.dirty
