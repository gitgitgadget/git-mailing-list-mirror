From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 2/8] Cleanup malformed test cases
Date: Mon,  1 Dec 2008 00:40:29 +0100
Message-ID: <1228088435-23722-3-git-send-email-robin.rosenberg@dewire.com>
References: <20081127214916.GD23984@spearce.org>
 <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 01 00:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6vvg-0001xS-LQ
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 00:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbYK3Xkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 18:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbYK3Xks
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 18:40:48 -0500
Received: from mail.dewire.com ([83.140.172.130]:25200 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbYK3Xko (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 18:40:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 96A381471C21;
	Mon,  1 Dec 2008 00:40:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ow7+xF0RJR3f; Mon,  1 Dec 2008 00:40:40 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 2B157147CE86;
	Mon,  1 Dec 2008 00:40:37 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228088435-23722-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101992>

These were abusing setup, resulting in lost resources. To
fix this we can abuse tearDown too.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index e5bce4d..3c02955 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -309,6 +309,7 @@ public void testWritePack4ThinPack() throws IOException {
 	public void testWritePack2SizeDeltasVsNoDeltas() throws Exception {
 		testWritePack2();
 		final int sizePack2NoDeltas = cos.getCount();
+		tearDown();
 		setUp();
 		testWritePack2DeltasReuseRefs();
 		final int sizePack2DeltasRefs = cos.getCount();
@@ -327,6 +328,7 @@ public void testWritePack2SizeDeltasVsNoDeltas() throws Exception {
 	public void testWritePack2SizeOffsetsVsRefs() throws Exception {
 		testWritePack2DeltasReuseRefs();
 		final int sizePack2DeltasRefs = cos.getCount();
+		tearDown();
 		setUp();
 		testWritePack2DeltasReuseOffsets();
 		final int sizePack2DeltasOffsets = cos.getCount();
@@ -344,6 +346,7 @@ public void testWritePack2SizeOffsetsVsRefs() throws Exception {
 	public void testWritePack4SizeThinVsNoThin() throws Exception {
 		testWritePack4();
 		final int sizePack4 = cos.getCount();
+		tearDown();
 		setUp();
 		testWritePack4ThinPack();
 		final int sizePack4Thin = cos.getCount();
-- 
1.6.0.3.640.g6331a
