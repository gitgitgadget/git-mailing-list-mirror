From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 03/10] Avoid a nullpointerexception on shutdown
Date: Sun, 11 Mar 2007 19:15:32 +0100
Message-ID: <20070311181531.18012.59242.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYT-0006DB-4J
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933941AbXCKSNt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933944AbXCKSNt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:13:49 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1601 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933941AbXCKSNs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:13:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6243D802E25;
	Sun, 11 Mar 2007 19:08:33 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26000-10; Sun, 11 Mar 2007 19:08:33 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 1B2E6802841;
	Sun, 11 Mar 2007 19:08:33 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 3B65E291DB;
	Sun, 11 Mar 2007 19:15:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id BEp43-y+pk9r; Sun, 11 Mar 2007 19:15:36 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 47B56291D8;
	Sun, 11 Mar 2007 19:15:32 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41952>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index d1591f0..0e53036 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -232,6 +232,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 			ILazyTreeContentProvider {
 
 		public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
+			if (newInput == null)
+				return;
 			System.out.println("inputChanged(" + viewer + "," + oldInput + ","
 					+ newInput);
 			RepositoryProvider provider = RepositoryProvider
