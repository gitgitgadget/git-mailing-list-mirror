From: imyousuf@gmail.com
Subject: [JGit Patch 4/6] Use test resources from classpath
Date: Thu, 21 Aug 2008 08:47:26 +0600
Message-ID: <1219286848-22758-4-git-send-email-imyousuf@gmail.com>
References: <1219286848-22758-1-git-send-email-imyousuf@gmail.com>
 <1219286848-22758-2-git-send-email-imyousuf@gmail.com>
 <1219286848-22758-3-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 04:49:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0FC-0002OQ-OV
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 04:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbYHUCsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 22:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbYHUCsq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 22:48:46 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:35905 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbYHUCsm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 22:48:42 -0400
Received: by ey-out-2122.google.com with SMTP id 6so13458eyi.37
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 19:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6tvRpLAawz3rNfa/NBzOotIFAzYJjUDmieKCTrr5IBg=;
        b=jL3brnXYjsNPyyVwpnHBINgV0Sx1R1dilqK8OYKlBUcFYL8MI+rmtBtpWVyX4IxTKr
         lQQtgBu3ym3NM2DlIDLi0XbY9qaUFnh8+zYO3Z5ENo3Q2Tdt6eDJwIIXqS204HR49yZS
         W9wjdW/qQyCX2Fw2AwFxQgg8qEsbHxt+Pia2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wus0Lt9FpEqxsRqGIP0vzrNQgEKcOjxYKsfDTvoJBXnASLqx6ZBWMukibMZPmkDgI8
         m2ZnxwJSQAVvzoKLh/nQ6vrxo3aWYsmuUsxW/ft/I43MAzqvE8OkqGKV7qL0VLcOQE9E
         QQxUhrhwK1shc5inJdwDaHU+BZFeFEJOudsek=
Received: by 10.210.113.16 with SMTP id l16mr1124155ebc.27.1219286920548;
        Wed, 20 Aug 2008 19:48:40 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id h1sm2372344nfh.19.2008.08.20.19.48.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 19:48:39 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1219286848-22758-3-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93094>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Searched and fixed usage of resources, all tests are now passing and using
classpath resources.

A utility class for test classes are created. One of its operation turns
classpath resources to File and it is used by all test classes to locate
test resources.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../dircache/DirCacheCGitCompatabilityTest.java    |    3 +-
 .../tst/org/spearce/jgit/lib/PackIndexV1Test.java  |    9 ++-
 .../tst/org/spearce/jgit/lib/PackIndexV2Test.java  |    5 +-
 .../org/spearce/jgit/lib/PackReverseIndexTest.java |    5 +-
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    3 +-
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    7 +-
 .../org/spearce/jgit/transport/IndexPackTest.java  |    6 +-
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   63 ++++++++++++++++++++
 8 files changed, 84 insertions(+), 17 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
index 43b23f6..b052686 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
@@ -50,6 +50,7 @@
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.RepositoryTestCase;
 import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class DirCacheCGitCompatabilityTest extends RepositoryTestCase {
 	private final File index = pathOf("gitgit.index");
@@ -138,7 +139,7 @@ assertEquals(ObjectId
 	}
 
 	private File pathOf(final String name) {
-		return new File("tst", name);
+		return JGitTestUtil.getTestResourceFile(name);
 	}
 
 	private Map<String, CGitIndexRecord> readLsFiles() throws Exception {
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
index 49235ca..645e054 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
@@ -40,18 +40,19 @@
 import java.io.File;
 
 import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class PackIndexV1Test extends PackIndexTest {
 	@Override
 	public File getFileForPack34be9032() {
-		return new File(new File("tst"),
-				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
+		return JGitTestUtil.getTestResourceFile(
+                    "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
 	}
 
 	@Override
 	public File getFileForPackdf2982f28() {
-		return new File(new File("tst"),
-				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx");
+		return JGitTestUtil.getTestResourceFile(
+                    "pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx");
 	}
 
 	/**
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
index c986c49..d95937c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
@@ -40,17 +40,18 @@
 import java.io.File;
 
 import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class PackIndexV2Test extends PackIndexTest {
 	@Override
 	public File getFileForPack34be9032() {
-		return new File(new File("tst"),
+		return JGitTestUtil.getTestResourceFile(
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2");
 	}
 
 	@Override
 	public File getFileForPackdf2982f28() {
-		return new File(new File("tst"),
+		return JGitTestUtil.getTestResourceFile(
 				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2");
 	}
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
index 52d1282..c66818f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
@@ -37,10 +37,9 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.File;
-
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.lib.PackIndex.MutableEntry;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class PackReverseIndexTest extends RepositoryTestCase {
 
@@ -54,7 +53,7 @@
 	public void setUp() throws Exception {
 		super.setUp();
 		// index with both small (< 2^31) and big offsets
-		idx = PackIndex.open(new File(new File("tst"),
+		idx = PackIndex.open(JGitTestUtil.getTestResourceFile(
 				"pack-huge.idx"));
 		reverseIdx = new PackReverseIndex(idx);
 	}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index 4dd4b2a..87ec091 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -57,6 +57,7 @@
 import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.transport.IndexPack;
 import org.spearce.jgit.util.CountingOutputStream;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class PackWriterTest extends RepositoryTestCase {
 
@@ -239,7 +240,7 @@ public void testWritePack2DeltasCRC32Copy() throws IOException {
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
 		final File crc32Idx = new File(packDir,
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
-		copyFile(new File(new File("tst"),
+		copyFile(JGitTestUtil.getTestResourceFile(
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2"),
 				crc32Idx);
 		db.openPack(crc32Pack, crc32Idx);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 14e7179..310690a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -47,6 +47,7 @@
 import java.io.Reader;
 
 import junit.framework.TestCase;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public abstract class RepositoryTestCase extends TestCase {
 
@@ -145,13 +146,13 @@ public void run() {
 		final File tst = new File("tst");
 		final File packDir = new File(db.getObjectsDirectory(), "pack");
 		for (int k = 0; k < packs.length; k++) {
-			copyFile(new File(tst, packs[k] + ".pack"), new File(packDir,
+			copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".pack"), new File(packDir,
 					packs[k] + ".pack"));
-			copyFile(new File(tst, packs[k] + ".idx"), new File(packDir,
+			copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".idx"), new File(packDir,
 					packs[k] + ".idx"));
 		}
 
-		copyFile(new File(tst, "packed-refs"), new File(trash_git,"packed-refs"));
+		copyFile(JGitTestUtil.getTestResourceFile("packed-refs"), new File(trash_git,"packed-refs"));
 
 		db.scanForPacks();
 	}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
index ffa9142..46bd969 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
@@ -47,7 +47,7 @@
 import org.spearce.jgit.lib.PackFile;
 import org.spearce.jgit.lib.RepositoryTestCase;
 import org.spearce.jgit.lib.TextProgressMonitor;
-import org.spearce.jgit.transport.IndexPack;
+import org.spearce.jgit.util.JGitTestUtil;
 
 /**
  * Test indexing of git packs. A pack is read from a stream, copied
@@ -63,7 +63,7 @@
 	 * @throws IOException
 	 */
 	public void test1() throws  IOException {
-		File packFile = new File("tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
+		File packFile = JGitTestUtil.getTestResourceFile("pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
 		final InputStream is = new FileInputStream(packFile);
 		try {
 			IndexPack pack = new IndexPack(db, is, new File(trash, "tmp_pack1"));
@@ -89,7 +89,7 @@ public void test1() throws  IOException {
 	 * @throws IOException
 	 */
 	public void test2() throws  IOException {
-		File packFile = new File("tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack");
+		File packFile = JGitTestUtil.getTestResourceFile("pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack");
 		final InputStream is = new FileInputStream(packFile);
 		try {
 			IndexPack pack = new IndexPack(db, is, new File(trash, "tmp_pack2"));
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
new file mode 100644
index 0000000..161ff78
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2008, Imran M Yousuf <imyousuf@smartitengineering.com>
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
+package org.spearce.jgit.util;
+
+import java.io.File;
+import java.net.URL;
+
+/**
+ *
+ * @author imyousuf
+ */
+public abstract class JGitTestUtil {
+    public static final String CLASSPATH_TO_RESOURCES =
+        "/org/spearce/jgit/test/resources/";
+    private JGitTestUtil() {
+        throw new AssertionError();
+    }
+    
+    public static File getTestResourceFile(String fileName) {
+        if(fileName == null || fileName.length() <= 0) {
+            return null;
+        }
+        URL url = JGitTestUtil.class.getResource(
+            new StringBuilder(CLASSPATH_TO_RESOURCES)
+                .append(fileName).toString());
+        return new File(url.getPath());
+    }
+}
-- 
1.5.6
