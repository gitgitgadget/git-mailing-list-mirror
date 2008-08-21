From: imyousuf@gmail.com
Subject: [JGit Patch v2 4/7] Use test resources from classpath
Date: Thu, 21 Aug 2008 09:13:11 +0600
Message-ID: <1219288394-1241-4-git-send-email-imyousuf@gmail.com>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-2-git-send-email-imyousuf@gmail.com>
 <1219288394-1241-3-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 05:15:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0du-0007f6-GP
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbYHUDOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754616AbYHUDOA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:14:00 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:37841 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbYHUDN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:13:59 -0400
Received: by ey-out-2122.google.com with SMTP id 6so14267eyi.37
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 20:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4VrHNqmCar6kOh6CE0mSvg6bYuwcnqaAhN0k3jRsxpE=;
        b=XZ9FcQQauKyq2jxh1mogDqzJ2Be9ilpOpEWPvMfsvg9NE24LWqZoy+Pt9lQh9Rixwz
         aX21/ibDfAgkZgCUhGM+/JJylEbFbjgi62asmQamqnU1yzH70hm0SIBPlZjfIp/ibsRh
         vnnac1aAxiRxXnVa7OKie531xjN/R+CspNAa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HMyQ+aasOLUcarbobx9IJeLCFan9lWVKQwRpymoCziOtBS6Bm850zK2oGQdnEtnz3u
         iBM+7Zw/mjmgR20OpULOWnJ0d2c7Q4abfnPNyQe6sBUipfKQgpE6mwJLD3fVeYthypzj
         tQooCYW8PxyYu20Zog32lLg4QL00e6m0uQ3BE=
Received: by 10.210.71.13 with SMTP id t13mr1150434eba.112.1219288437706;
        Wed, 20 Aug 2008 20:13:57 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id 33sm2389331nfu.7.2008.08.20.20.13.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 20:13:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1219288394-1241-3-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93101>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Searched and fixed usage of resources, all tests are now passing and using
classpath resources.

A utility class for test classes are created. One of its operation turns
classpath resources to File and it is used by all test classes to locate
test resources.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../dircache/DirCacheCGitCompatabilityTest.java    |    3 +-
 .../tst/org/spearce/jgit/lib/PackIndexV1Test.java  |    9 +++--
 .../tst/org/spearce/jgit/lib/PackIndexV2Test.java  |    5 ++-
 .../org/spearce/jgit/lib/PackReverseIndexTest.java |    5 +--
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    3 +-
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    7 ++--
 .../org/spearce/jgit/transport/IndexPackTest.java  |    6 ++--
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   35 ++++++++++++-------
 8 files changed, 43 insertions(+), 30 deletions(-)
 copy org.spearce.jgit/src/org/spearce/jgit/util/FS_POSIX_Java5.java => org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java (70%)

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
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/FS_POSIX_Java5.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
similarity index 70%
copy from org.spearce.jgit/src/org/spearce/jgit/util/FS_POSIX_Java5.java
copy to org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index d62b210..161ff78 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/FS_POSIX_Java5.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Imran M Yousuf <imyousuf@smartitengineering.com>
  *
  * All rights reserved.
  *
@@ -38,17 +38,26 @@
 package org.spearce.jgit.util;
 
 import java.io.File;
+import java.net.URL;
 
-class FS_POSIX_Java5 extends FS {
-	public boolean supportsExecute() {
-		return false;
-	}
-
-	public boolean canExecute(final File f) {
-		return false;
-	}
-
-	public boolean setExecute(final File f, final boolean canExec) {
-		return false;
-	}
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
 }
-- 
1.5.6
