From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/12] Add a simple toString to FormatError to facilitate debugging
Date: Fri, 12 Dec 2008 14:05:49 -0800
Message-ID: <1229119558-1293-4-git-send-email-spearce@spearce.org>
References: <1229119558-1293-1-git-send-email-spearce@spearce.org>
 <1229119558-1293-2-git-send-email-spearce@spearce.org>
 <1229119558-1293-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGB9-0004x0-53
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457AbYLLWGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbYLLWGG
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:06 -0500
Received: from george.spearce.org ([209.20.77.23]:50668 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbYLLWGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:00 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 13C4A38222; Fri, 12 Dec 2008 22:06:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5D78338211;
	Fri, 12 Dec 2008 22:05:59 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102951>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/patch/FormatError.java    |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java
index e6f0a03..ab75c63 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FormatError.java
@@ -92,4 +92,18 @@ public String getLineText() {
 		final int eol = RawParseUtils.nextLF(buf, offset);
 		return RawParseUtils.decode(Constants.CHARSET, buf, offset, eol);
 	}
+
+	@Override
+	public String toString() {
+		final StringBuilder r = new StringBuilder();
+		r.append(getSeverity().name().toLowerCase());
+		r.append(": at offset ");
+		r.append(getOffset());
+		r.append(": ");
+		r.append(getMessage());
+		r.append("\n");
+		r.append("  in ");
+		r.append(getLineText());
+		return r.toString();
+	}
 }
-- 
1.6.1.rc2.306.ge5d5e
