From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 7/6] BROKEN: Add a zero line context test for
	diff.DiffFormatter
Date: Sat, 2 May 2009 17:05:40 -0700
Message-ID: <20090503000540.GN23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 03 02:05:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0PDH-0006tg-UH
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 02:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbZECAFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 20:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754948AbZECAFl
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 20:05:41 -0400
Received: from george.spearce.org ([209.20.77.23]:44955 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbZECAFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 20:05:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D0ADE38081; Sun,  3 May 2009 00:05:40 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118151>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This test currently fails because it shows the difference between
 the way CGit and JGit number a zero context line patch.

 Either we hack JGit to match CGit here, or we modify the test
 vector, or CGit agrees there's a bug and fixes their code, and we
 modify the test vector.

 .../org/spearce/jgit/diff/testContext0.out         |   18 ++++++++++++++++++
 .../spearce/jgit/diff/DiffFormatterReflowTest.java |    6 ++++++
 2 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext0.out

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext0.out b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext0.out
new file mode 100644
index 0000000..d36e3fa
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext0.out
@@ -0,0 +1,18 @@
+diff --git a/X b/X
+index a3648a1..2d44096 100644
+--- a/X
++++ b/X
+@@ -2,0 +3 @@
++c
+@@ -17,2 +17,0 @@
+-r
+-s
+@@ -23,2 +22,6 @@
+-x
+-y
++0
++1
++2
++3
++4
++5
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/diff/DiffFormatterReflowTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/DiffFormatterReflowTest.java
index f47282c..5d2ee40 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/diff/DiffFormatterReflowTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/DiffFormatterReflowTest.java
@@ -74,6 +74,12 @@ public void testNegativeContextFails() throws IOException {
 		}
 	}
 
+	public void testContext0() throws IOException {
+		init("X");
+		fmt.setContext(0);
+		assertFormatted();
+	}
+
 	public void testContext1() throws IOException {
 		init("X");
 		fmt.setContext(1);
-- 
1.6.3.rc4.190.g4648
