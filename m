From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/7] Fix FindBugs load known null value
Date: Mon,  4 May 2009 16:30:45 -0700
Message-ID: <1241479848-20687-4-git-send-email-spearce@spearce.org>
References: <1241479848-20687-1-git-send-email-spearce@spearce.org>
 <1241479848-20687-2-git-send-email-spearce@spearce.org>
 <1241479848-20687-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Matthias Sohn <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue May 05 01:31:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M17dM-00068Y-7V
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 01:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348AbZEDXbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 19:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756306AbZEDXbB
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 19:31:01 -0400
Received: from george.spearce.org ([209.20.77.23]:52551 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbZEDXau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 19:30:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 441E0381A7; Mon,  4 May 2009 23:30:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BDADB38195;
	Mon,  4 May 2009 23:30:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc4.206.g03e16
In-Reply-To: <1241479848-20687-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118276>

We know its null, so use the null constant instead of the null
variable here.  Either way is pretty clear to the reader, but
this form makes FindBugs be quiet.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index bcbdbb0..d3c43da 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -314,9 +314,8 @@ private static boolean inList(final PackFile[] list, final PackFile pack) {
 
 	private PackFile[] packs() {
 		PackFile[] r = packList.get();
-		if (r == null) {
-			r = scanPacks(r);
-		}
+		if (r == null)
+			r = scanPacks(null);
 		return r;
 	}
 
-- 
1.6.3.rc4.206.g03e16
