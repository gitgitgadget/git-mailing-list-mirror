From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v3 6/6] Add diff.DiffFormatter to create Git style
	unified patch scripts
Date: Sat, 2 May 2009 17:29:38 -0700
Message-ID: <20090503002938.GQ23604@spearce.org>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org> <1241230127-28279-2-git-send-email-spearce@spearce.org> <1241230127-28279-3-git-send-email-spearce@spearce.org> <1241230127-28279-4-git-send-email-spearce@spearce.org> <1241230127-28279-5-git-send-email-spearce@spearce.org> <1241230127-28279-6-git-send-email-spearce@spearce.org> <1241230127-28279-7-git-send-email-spearce@spearce.org> <20090503000329.GM23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 03 02:29:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0PaV-0003mz-Mg
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 02:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbZECA3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 20:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbZECA3k
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 20:29:40 -0400
Received: from george.spearce.org ([209.20.77.23]:36508 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbZECA3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 20:29:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 06E6638081; Sun,  3 May 2009 00:29:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090503000329.GM23604@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118155>

From: Johannes E. Schindelin <johannes.schindelin@gmx.de>

Currently the formatter can only copy an existing FileHeader, one
that has been parsed from an existing patch script.  This makes
it only useful for increasing or decreasing the number of lines
of context, assuming we already have both the old and new content
images to match.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  "Shawn O. Pearce" <spearce@spearce.org> wrote:
  >  There's a quirk about setContext(0) differing in JGit and CGit,
  >  see the thread I just posted a short while ago.

  v3 fixes this issue, thanks to Junio's comments.

  This includes 7/6, which now passes, and makes 8/6 obsolete.

 .../tst-rsrc/org/spearce/jgit/diff/E.patch         |    6 +
 .../tst-rsrc/org/spearce/jgit/diff/E_PostImage     |    1 +
 .../tst-rsrc/org/spearce/jgit/diff/X.patch         |   24 +++
 .../tst-rsrc/org/spearce/jgit/diff/X_PostImage     |   28 +++
 .../tst-rsrc/org/spearce/jgit/diff/X_PreImage      |   25 +++
 .../tst-rsrc/org/spearce/jgit/diff/Y.patch         |    8 +
 .../tst-rsrc/org/spearce/jgit/diff/Y_PostImage     |    1 +
 .../tst-rsrc/org/spearce/jgit/diff/Y_PreImage      |    1 +
 .../tst-rsrc/org/spearce/jgit/diff/Z.patch         |    8 +
 .../tst-rsrc/org/spearce/jgit/diff/Z_PostImage     |    1 +
 .../tst-rsrc/org/spearce/jgit/diff/Z_PreImage      |    1 +
 .../org/spearce/jgit/diff/testContext0.out         |   18 ++
 .../org/spearce/jgit/diff/testContext1.out         |   24 +++
 .../org/spearce/jgit/diff/testContext10.out        |   37 ++++
 .../org/spearce/jgit/diff/testContext100.out       |   37 ++++
 .../org/spearce/jgit/diff/testContext3.out         |   30 +++
 .../org/spearce/jgit/diff/testContext5.out         |   34 +++
 .../spearce/jgit/diff/DiffFormatterReflowTest.java |  176 ++++++++++++++++
 .../src/org/spearce/jgit/diff/DiffFormatter.java   |  214 ++++++++++++++++++++
 .../src/org/spearce/jgit/diff/RawText.java         |   12 +
 20 files changed, 686 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E.patch
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E_PostImage
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E_PreImage
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X.patch
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X_PostImage
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X_PreImage
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y.patch
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y_PostImage
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y_PreImage
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z.patch
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z_PostImage
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z_PreImage
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext0.out
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext1.out
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext10.out
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext100.out
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext3.out
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext5.out
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/diff/DiffFormatterReflowTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E.patch b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E.patch
new file mode 100644
index 0000000..9b8fa98
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E.patch
@@ -0,0 +1,6 @@
+diff --git a/E b/E
+index e69de29..7898192 100644
+--- a/E
++++ b/E
+@@ -0,0 +1 @@
++a
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E_PostImage b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E_PostImage
new file mode 100644
index 0000000..7898192
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E_PostImage
@@ -0,0 +1 @@
+a
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E_PreImage b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/E_PreImage
new file mode 100644
index 0000000..e69de29
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X.patch b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X.patch
new file mode 100644
index 0000000..e5363eb
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X.patch
@@ -0,0 +1,24 @@
+diff --git a/X b/X
+index a3648a1..2d44096 100644
+--- a/X
++++ b/X
+@@ -2,2 +2,3 @@ a
+ b
++c
+ d
+@@ -16,4 +17,2 @@ p
+ q
+-r
+-s
+ t
+@@ -22,4 +21,8 @@ v
+ w
+-x
+-y
++0
++1
++2
++3
++4
++5
+ z
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X_PostImage b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X_PostImage
new file mode 100644
index 0000000..2d44096
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X_PostImage
@@ -0,0 +1,28 @@
+a
+b
+c
+d
+e
+f
+g
+h
+i
+j
+k
+l
+m
+n
+o
+p
+q
+t
+u
+v
+w
+0
+1
+2
+3
+4
+5
+z
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X_PreImage b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X_PreImage
new file mode 100644
index 0000000..a3648a1
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/X_PreImage
@@ -0,0 +1,25 @@
+a
+b
+d
+e
+f
+g
+h
+i
+j
+k
+l
+m
+n
+o
+p
+q
+r
+s
+t
+u
+v
+w
+x
+y
+z
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y.patch b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y.patch
new file mode 100644
index 0000000..a2c9a0b
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y.patch
@@ -0,0 +1,8 @@
+diff --git a/Y b/Y
+index 2e65efe..7898192 100644
+--- a/Y
++++ b/Y
+@@ -1 +1 @@
+-a
+\ No newline at end of file
++a
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y_PostImage b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y_PostImage
new file mode 100644
index 0000000..7898192
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y_PostImage
@@ -0,0 +1 @@
+a
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y_PreImage b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y_PreImage
new file mode 100644
index 0000000..2e65efe
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Y_PreImage
@@ -0,0 +1 @@
+a
\ No newline at end of file
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z.patch b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z.patch
new file mode 100644
index 0000000..35a06d6
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z.patch
@@ -0,0 +1,8 @@
+diff --git a/Z b/Z
+index 7898192..2e65efe 100644
+--- a/Z
++++ b/Z
+@@ -1 +1 @@
+-a
++a
+\ No newline at end of file
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z_PostImage b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z_PostImage
new file mode 100644
index 0000000..2e65efe
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z_PostImage
@@ -0,0 +1 @@
+a
\ No newline at end of file
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z_PreImage b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z_PreImage
new file mode 100644
index 0000000..7898192
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/Z_PreImage
@@ -0,0 +1 @@
+a
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
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext1.out b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext1.out
new file mode 100644
index 0000000..d0d847d
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext1.out
@@ -0,0 +1,24 @@
+diff --git a/X b/X
+index a3648a1..2d44096 100644
+--- a/X
++++ b/X
+@@ -2,2 +2,3 @@
+ b
++c
+ d
+@@ -16,4 +17,2 @@
+ q
+-r
+-s
+ t
+@@ -22,4 +21,8 @@
+ w
+-x
+-y
++0
++1
++2
++3
++4
++5
+ z
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext10.out b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext10.out
new file mode 100644
index 0000000..1d4f242
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext10.out
@@ -0,0 +1,37 @@
+diff --git a/X b/X
+index a3648a1..2d44096 100644
+--- a/X
++++ b/X
+@@ -1,25 +1,28 @@
+ a
+ b
++c
+ d
+ e
+ f
+ g
+ h
+ i
+ j
+ k
+ l
+ m
+ n
+ o
+ p
+ q
+-r
+-s
+ t
+ u
+ v
+ w
+-x
+-y
++0
++1
++2
++3
++4
++5
+ z
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext100.out b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext100.out
new file mode 100644
index 0000000..1d4f242
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext100.out
@@ -0,0 +1,37 @@
+diff --git a/X b/X
+index a3648a1..2d44096 100644
+--- a/X
++++ b/X
+@@ -1,25 +1,28 @@
+ a
+ b
++c
+ d
+ e
+ f
+ g
+ h
+ i
+ j
+ k
+ l
+ m
+ n
+ o
+ p
+ q
+-r
+-s
+ t
+ u
+ v
+ w
+-x
+-y
++0
++1
++2
++3
++4
++5
+ z
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext3.out b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext3.out
new file mode 100644
index 0000000..2564016
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext3.out
@@ -0,0 +1,30 @@
+diff --git a/X b/X
+index a3648a1..2d44096 100644
+--- a/X
++++ b/X
+@@ -1,5 +1,6 @@
+ a
+ b
++c
+ d
+ e
+ f
+@@ -14,12 +15,14 @@
+ o
+ p
+ q
+-r
+-s
+ t
+ u
+ v
+ w
+-x
+-y
++0
++1
++2
++3
++4
++5
+ z
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext5.out b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext5.out
new file mode 100644
index 0000000..3073c5f
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/diff/testContext5.out
@@ -0,0 +1,34 @@
+diff --git a/X b/X
+index a3648a1..2d44096 100644
+--- a/X
++++ b/X
+@@ -1,7 +1,8 @@
+ a
+ b
++c
+ d
+ e
+ f
+ g
+ h
+@@ -12,14 +13,16 @@
+ m
+ n
+ o
+ p
+ q
+-r
+-s
+ t
+ u
+ v
+ w
+-x
+-y
++0
++1
++2
++3
++4
++5
+ z
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/diff/DiffFormatterReflowTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/DiffFormatterReflowTest.java
new file mode 100644
index 0000000..5d2ee40
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/DiffFormatterReflowTest.java
@@ -0,0 +1,176 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.diff;
+
+import java.io.ByteArrayOutputStream;
+import java.io.IOException;
+import java.io.InputStream;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.patch.FileHeader;
+import org.spearce.jgit.patch.Patch;
+import org.spearce.jgit.util.RawParseUtils;
+
+public class DiffFormatterReflowTest extends TestCase {
+	private RawText a;
+
+	private RawText b;
+
+	private FileHeader file;
+
+	private ByteArrayOutputStream out;
+
+	private DiffFormatter fmt;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		out = new ByteArrayOutputStream();
+		fmt = new DiffFormatter();
+	}
+
+	public void testNegativeContextFails() throws IOException {
+		init("X");
+		try {
+			fmt.setContext(-1);
+			fail("accepted negative context");
+		} catch (IllegalArgumentException e) {
+			// pass
+		}
+	}
+
+	public void testContext0() throws IOException {
+		init("X");
+		fmt.setContext(0);
+		assertFormatted();
+	}
+
+	public void testContext1() throws IOException {
+		init("X");
+		fmt.setContext(1);
+		assertFormatted();
+	}
+
+	public void testContext3() throws IOException {
+		init("X");
+		fmt.setContext(3);
+		assertFormatted();
+	}
+
+	public void testContext5() throws IOException {
+		init("X");
+		fmt.setContext(5);
+		assertFormatted();
+	}
+
+	public void testContext10() throws IOException {
+		init("X");
+		fmt.setContext(10);
+		assertFormatted();
+	}
+
+	public void testContext100() throws IOException {
+		init("X");
+		fmt.setContext(100);
+		assertFormatted();
+	}
+
+	public void testEmpty1() throws IOException {
+		init("E");
+		assertFormatted("E.patch");
+	}
+
+	public void testNoNewLine1() throws IOException {
+		init("Y");
+		assertFormatted("Y.patch");
+	}
+
+	public void testNoNewLine2() throws IOException {
+		init("Z");
+		assertFormatted("Z.patch");
+	}
+
+	private void init(final String name) throws IOException {
+		a = new RawText(readFile(name + "_PreImage"));
+		b = new RawText(readFile(name + "_PostImage"));
+		file = parseTestPatchFile(name + ".patch").getFiles().get(0);
+	}
+
+	private void assertFormatted() throws IOException {
+		assertFormatted(getName() + ".out");
+	}
+
+	private void assertFormatted(final String name) throws IOException {
+		fmt.format(out, file, a, b);
+		final String exp = RawParseUtils.decode(readFile(name));
+		assertEquals(exp, RawParseUtils.decode(out.toByteArray()));
+	}
+
+	private byte[] readFile(final String patchFile) throws IOException {
+		final InputStream in = getClass().getResourceAsStream(patchFile);
+		if (in == null) {
+			fail("No " + patchFile + " test vector");
+			return null; // Never happens
+		}
+		try {
+			final byte[] buf = new byte[1024];
+			final ByteArrayOutputStream temp = new ByteArrayOutputStream();
+			int n;
+			while ((n = in.read(buf)) > 0)
+				temp.write(buf, 0, n);
+			return temp.toByteArray();
+		} finally {
+			in.close();
+		}
+	}
+
+	private Patch parseTestPatchFile(final String patchFile) throws IOException {
+		final InputStream in = getClass().getResourceAsStream(patchFile);
+		if (in == null) {
+			fail("No " + patchFile + " test vector");
+			return null; // Never happens
+		}
+		try {
+			final Patch p = new Patch();
+			p.parse(in);
+			return p;
+		} finally {
+			in.close();
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java b/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
new file mode 100644
index 0000000..9a81901
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
@@ -0,0 +1,214 @@
+/*
+ * Copyright (C) 2008, Johannes E. Schindelin <johannes.schindelin@gmx.de>
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.diff;
+
+import static org.spearce.jgit.lib.Constants.encodeASCII;
+
+import java.io.IOException;
+import java.io.OutputStream;
+import java.util.List;
+
+import org.spearce.jgit.patch.FileHeader;
+
+/**
+ * Format an {@link EditList} as a Git style unified patch script.
+ */
+public class DiffFormatter {
+	private static final byte[] noNewLine = encodeASCII("\\ No newline at end of file\n");
+
+	private int context;
+
+	/** Create a new formatter with a default level of context. */
+	public DiffFormatter() {
+		setContext(3);
+	}
+
+	/**
+	 * Change the number of lines of context to display.
+	 * 
+	 * @param lineCount
+	 *            number of lines of context to see before the first
+	 *            modification and after the last modification within a hunk of
+	 *            the modified file.
+	 */
+	public void setContext(final int lineCount) {
+		if (lineCount < 0)
+			throw new IllegalArgumentException("context must be >= 0");
+		context = lineCount;
+	}
+
+	/**
+	 * Format a patch script, reusing a previously parsed FileHeader.
+	 * <p>
+	 * This formatter is primarily useful for editing an existing patch script
+	 * to increase or reduce the number of lines of context within the script.
+	 * All header lines are reused as-is from the supplied FileHeader.
+	 * 
+	 * @param out
+	 *            stream to write the patch script out to.
+	 * @param head
+	 *            existing file header containing the header lines to copy.
+	 * @param a
+	 *            text source for the pre-image version of the content. This
+	 *            must match the content of {@link FileHeader#getOldId()}.
+	 * @param b
+	 *            text source for the post-image version of the content. This
+	 *            must match the content of {@link FileHeader#getNewId()}.
+	 * @throws IOException
+	 *             writing to the supplied stream failed.
+	 */
+	public void format(final OutputStream out, final FileHeader head,
+			final RawText a, final RawText b) throws IOException {
+		// Reuse the existing FileHeader as-is by blindly copying its
+		// header lines, but avoiding its hunks. Instead we recreate
+		// the hunks from the text instances we have been supplied.
+		//
+		final int start = head.getStartOffset();
+		int end = head.getEndOffset();
+		if (!head.getHunks().isEmpty())
+			end = head.getHunks().get(0).getStartOffset();
+		out.write(head.getBuffer(), start, end - start);
+
+		formatEdits(out, a, b, head.toEditList());
+	}
+
+	private void formatEdits(final OutputStream out, final RawText a,
+			final RawText b, final EditList edits) throws IOException {
+		for (int curIdx = 0; curIdx < edits.size();) {
+			Edit curEdit = edits.get(curIdx);
+			final int endIdx = findCombinedEnd(edits, curIdx);
+			final Edit endEdit = edits.get(endIdx);
+
+			int aCur = Math.max(0, curEdit.getBeginA() - context);
+			int bCur = Math.max(0, curEdit.getBeginB() - context);
+			final int aEnd = Math.min(a.size(), endEdit.getEndA() + context);
+			final int bEnd = Math.min(b.size(), endEdit.getEndB() + context);
+
+			writeHunkHeader(out, aCur, aEnd, bCur, bEnd);
+
+			while (aCur < aEnd || bCur < bEnd) {
+				if (aCur < curEdit.getBeginA() || endIdx + 1 < curIdx) {
+					writeLine(out, ' ', a, aCur);
+					aCur++;
+					bCur++;
+
+				} else if (aCur < curEdit.getEndA()) {
+					writeLine(out, '-', a, aCur++);
+
+				} else if (bCur < curEdit.getEndB()) {
+					writeLine(out, '+', b, bCur++);
+				}
+
+				if (end(curEdit, aCur, bCur) && ++curIdx < edits.size())
+					curEdit = edits.get(curIdx);
+			}
+		}
+	}
+
+	private void writeHunkHeader(final OutputStream out, int aCur, int aEnd,
+			int bCur, int bEnd) throws IOException {
+		out.write('@');
+		out.write('@');
+		writeRange(out, '-', aCur + 1, aEnd - aCur);
+		writeRange(out, '+', bCur + 1, bEnd - bCur);
+		out.write(' ');
+		out.write('@');
+		out.write('@');
+		out.write('\n');
+	}
+
+	private static void writeRange(final OutputStream out, final char prefix,
+			final int begin, final int cnt) throws IOException {
+		out.write(' ');
+		out.write(prefix);
+		switch (cnt) {
+		case 0:
+			// If the range is empty, its beginning number must be the
+			// line just before the range, or 0 if the range is at the
+			// start of the file stream. Here, begin is always 1 based,
+			// so an empty file would produce "0,0".
+			//
+			out.write(encodeASCII(begin - 1));
+			out.write(',');
+			out.write('0');
+			break;
+
+		case 1:
+			// If the range is exactly one line, produce only the number.
+			//
+			out.write(encodeASCII(begin));
+			break;
+
+		default:
+			out.write(encodeASCII(begin));
+			out.write(',');
+			out.write(encodeASCII(cnt));
+			break;
+		}
+	}
+
+	private static void writeLine(final OutputStream out, final char prefix,
+			final RawText text, final int cur) throws IOException {
+		out.write(prefix);
+		text.writeLine(out, cur);
+		out.write('\n');
+		if (cur + 1 == text.size() && text.isMissingNewlineAtEnd())
+			out.write(noNewLine);
+	}
+
+	private int findCombinedEnd(final List<Edit> edits, final int i) {
+		int end = i + 1;
+		while (end < edits.size()
+				&& (combineA(edits, end) || combineB(edits, end)))
+			end++;
+		return end - 1;
+	}
+
+	private boolean combineA(final List<Edit> e, final int i) {
+		return e.get(i).getBeginA() - e.get(i - 1).getEndA() <= 2 * context;
+	}
+
+	private boolean combineB(final List<Edit> e, final int i) {
+		return e.get(i).getBeginB() - e.get(i - 1).getEndB() <= 2 * context;
+	}
+
+	private static boolean end(final Edit edit, final int a, final int b) {
+		return edit.getEndA() <= a && edit.getEndB() <= b;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java b/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
index 1d10082..e10ee46 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
@@ -140,6 +140,18 @@ public void writeLine(final OutputStream out, final int i)
 		out.write(content, start, end - start);
 	}
 
+	/**
+	 * Determine if the file ends with a LF ('\n').
+	 * 
+	 * @return true if the last line has an LF; false otherwise.
+	 */
+	public boolean isMissingNewlineAtEnd() {
+		final int end = lines.get(lines.size() - 1);
+		if (end == 0)
+			return true;
+		return content[end - 1] != '\n';
+	}
+
 	private IntList computeHashes() {
 		final IntList r = new IntList(lines.size());
 		r.add(0);
-- 
1.6.3.rc4.190.g4648
