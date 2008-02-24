From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Refresh history when "Refresh" is clicked in the history viewer.
Date: Sun, 24 Feb 2008 18:18:17 -0500
Message-ID: <1203895097-3742-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 22:20:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTOGb-0003R6-5p
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 22:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYBXVTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 16:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753661AbYBXVTS
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 16:19:18 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1188 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753254AbYBXVTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 16:19:17 -0500
Received: (qmail 32911 invoked by uid 0); 24 Feb 2008 18:21:29 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.85762 secs); 24 Feb 2008 21:21:29 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.203.41)
  by cvxbsd.convex.com.br with SMTP; 24 Feb 2008 21:21:28 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74964>

---
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 2fc7afa..268a6ba 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -1207,8 +1207,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	}
 
 	public void refresh() {
-		// TODO Auto-generated method stub
-
+		if (historyRefreshJob.cancel()) {
+			System.out.println("rescheduling");
+			historyRefreshJob.schedule();
+		} else {
+			System.out.println("failed to cancel?");
+		}
 	}
 
 	public Object getAdapter(Class adapter) {
-- 
1.5.4.1
