From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/7] Silence FindBugs "dubious use of GC" in PackFile.mmap
Date: Mon,  4 May 2009 16:30:43 -0700
Message-ID: <1241479848-20687-2-git-send-email-spearce@spearce.org>
References: <1241479848-20687-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Matthias Sohn <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue May 05 01:31:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M17ci-0005qi-Qc
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 01:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbZEDXav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 19:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbZEDXau
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 19:30:50 -0400
Received: from george.spearce.org ([209.20.77.23]:52543 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZEDXat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 19:30:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A0AE23819E; Mon,  4 May 2009 23:30:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1ED8E38195;
	Mon,  4 May 2009 23:30:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc4.206.g03e16
In-Reply-To: <1241479848-20687-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118270>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../findBugs/FindBugsExcludeFilter.xml             |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml b/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml
index 526eb01..2af9348 100644
--- a/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml
+++ b/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml
@@ -6,4 +6,13 @@
        <Method name="refreshPackedRefs" />
        <Bug pattern="DM_STRING_CTOR" />
      </Match>
+
+     <!-- Silence PackFile.mmap calls GC, we need to force it to remove stale
+          memory mapped segments if the JVM heap is out of address space.
+       -->
+     <Match>
+       <Class name="org.spearce.jgit.lib.PackFile" />
+       <Method name="mmap" />
+       <Bug pattern="DM_GC" />
+     </Match>
 </FindBugsFilter>
-- 
1.6.3.rc4.206.g03e16
