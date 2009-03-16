From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 08/10] Drop unused end parameters in hunk parsing code
Date: Mon, 16 Mar 2009 21:14:41 +0100
Message-ID: <1237234483-3405-9-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-5-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-6-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-7-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-8-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJFf-0007z8-1f
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759307AbZCPUPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759251AbZCPUPf
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:15:35 -0400
Received: from mail.dewire.com ([83.140.172.130]:5296 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758879AbZCPUPa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:15:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 319C6138AD60;
	Mon, 16 Mar 2009 21:15:27 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nkm+yooukS2J; Mon, 16 Mar 2009 21:15:22 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id F0934138AD61;
	Mon, 16 Mar 2009 21:14:45 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-8-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113369>

Is this safe, or should they actually be used?
---
 .../org/spearce/jgit/patch/CombinedHunkHeader.java |    2 +-
 .../src/org/spearce/jgit/patch/HunkHeader.java     |    2 +-
 .../src/org/spearce/jgit/patch/Patch.java          |    8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java
index 83ea681..b1aef91 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.java
@@ -90,7 +90,7 @@ public OldImage getOldImage(final int nthParent) {
 	}
 
 	@Override
-	void parseHeader(final int end) {
+	void parseHeader() {
 		// Parse "@@@ -55,12 -163,13 +163,15 @@@ protected boolean"
 		//
 		final byte[] buf = file.buf;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index e3ce546..e9c55e3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -161,7 +161,7 @@ public int getLinesContext() {
 		return nContext;
 	}
 
-	void parseHeader(final int end) {
+	void parseHeader() {
 		// Parse "@@ -236,9 +236,9 @@ protected boolean"
 		//
 		final byte[] buf = file.buf;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 9c2a8d6..4b2121e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -222,7 +222,7 @@ private int parseDiffGit(final byte[] buf, final int start, final int end) {
 		final FileHeader fh = new FileHeader(buf, start);
 		int ptr = fh.parseGitFileName(start + DIFF_GIT.length, end);
 		if (ptr < 0)
-			return skipFile(buf, start, end);
+			return skipFile(buf, start);
 
 		ptr = fh.parseGitHeaders(ptr, end);
 		ptr = parseHunks(fh, ptr, end);
@@ -236,7 +236,7 @@ private int parseDiffCombined(final byte[] hdr, final byte[] buf,
 		final CombinedFileHeader fh = new CombinedFileHeader(buf, start);
 		int ptr = fh.parseGitFileName(start + hdr.length, end);
 		if (ptr < 0)
-			return skipFile(buf, start, end);
+			return skipFile(buf, start);
 
 		ptr = fh.parseGitHeaders(ptr, end);
 		ptr = parseHunks(fh, ptr, end);
@@ -255,7 +255,7 @@ private int parseTraditionalPatch(final byte[] buf, final int start,
 		return ptr;
 	}
 
-	private static int skipFile(final byte[] buf, int ptr, final int end) {
+	private static int skipFile(final byte[] buf, int ptr) {
 		ptr = nextLF(buf, ptr);
 		if (match(buf, ptr, OLD_NAME) >= 0)
 			ptr = nextLF(buf, ptr);
@@ -282,7 +282,7 @@ private int parseHunks(final FileHeader fh, int c, final int end) {
 
 			if (isHunkHdr(buf, c, end) == fh.getParentCount()) {
 				final HunkHeader h = fh.newHunkHeader(c);
-				h.parseHeader(end);
+				h.parseHeader();
 				c = h.parseBody(this, end);
 				h.endOffset = c;
 				fh.addHunk(h);
-- 
1.6.1.285.g35d8b
