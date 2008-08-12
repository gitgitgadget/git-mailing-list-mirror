From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 18/26] Add JUnit tests for new DirCache API
Date: Mon, 11 Aug 2008 18:08:05 -0700
Message-ID: <1218503293-14057-19-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
 <1218503293-14057-8-git-send-email-spearce@spearce.org>
 <1218503293-14057-9-git-send-email-spearce@spearce.org>
 <1218503293-14057-10-git-send-email-spearce@spearce.org>
 <1218503293-14057-11-git-send-email-spearce@spearce.org>
 <1218503293-14057-12-git-send-email-spearce@spearce.org>
 <1218503293-14057-13-git-send-email-spearce@spearce.org>
 <1218503293-14057-14-git-send-email-spearce@spearce.org>
 <1218503293-14057-15-git-send-email-spearce@spearce.org>
 <1218503293-14057-16-git-send-email-spearce@spearce.org>
 <1218503293-14057-17-git-send-email-spearce@spearce.org>
 <1218503293-14057-18-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPV-0006OQ-Sj
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbYHLBIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbYHLBIt
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:49 -0400
Received: from george.spearce.org ([209.20.77.23]:38610 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYHLBI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:27 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9F78538376; Tue, 12 Aug 2008 01:08:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A33CC38375;
	Tue, 12 Aug 2008 01:08:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-18-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92041>

These tests excerise the file reading and writing routines, as well as
the two forms of editing the cache (through builder and editor).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/dircache/DirCacheBasicTest.java   |  185 +++++++++++++
 .../jgit/dircache/DirCacheBuilderIteratorTest.java |   91 +++++++
 .../spearce/jgit/dircache/DirCacheBuilderTest.java |  253 ++++++++++++++++++
 .../spearce/jgit/dircache/DirCacheFindTest.java    |   86 ++++++
 .../jgit/dircache/DirCacheIteratorTest.java        |  273 ++++++++++++++++++++
 .../spearce/jgit/dircache/DirCacheTreeTest.java    |  150 +++++++++++
 6 files changed, 1038 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderIteratorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheFindTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
new file mode 100644
index 0000000..b3097ac
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
@@ -0,0 +1,185 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.dircache;
+
+import java.io.File;
+
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class DirCacheBasicTest extends RepositoryTestCase {
+	public void testReadMissing_RealIndex() throws Exception {
+		final File idx = new File(db.getDirectory(), "index");
+		assertFalse(idx.exists());
+
+		final DirCache dc = DirCache.read(db);
+		assertNotNull(dc);
+		assertEquals(0, dc.getEntryCount());
+	}
+
+	public void testReadMissing_TempIndex() throws Exception {
+		final File idx = new File(db.getDirectory(), "tmp_index");
+		assertFalse(idx.exists());
+
+		final DirCache dc = DirCache.read(idx);
+		assertNotNull(dc);
+		assertEquals(0, dc.getEntryCount());
+	}
+
+	public void testLockMissing_RealIndex() throws Exception {
+		final File idx = new File(db.getDirectory(), "index");
+		final File lck = new File(db.getDirectory(), "index.lock");
+		assertFalse(idx.exists());
+		assertFalse(lck.exists());
+
+		final DirCache dc = DirCache.lock(db);
+		assertNotNull(dc);
+		assertFalse(idx.exists());
+		assertTrue(lck.exists());
+		assertEquals(0, dc.getEntryCount());
+
+		dc.unlock();
+		assertFalse(idx.exists());
+		assertFalse(lck.exists());
+	}
+
+	public void testLockMissing_TempIndex() throws Exception {
+		final File idx = new File(db.getDirectory(), "tmp_index");
+		final File lck = new File(db.getDirectory(), "tmp_index.lock");
+		assertFalse(idx.exists());
+		assertFalse(lck.exists());
+
+		final DirCache dc = DirCache.lock(idx);
+		assertNotNull(dc);
+		assertFalse(idx.exists());
+		assertTrue(lck.exists());
+		assertEquals(0, dc.getEntryCount());
+
+		dc.unlock();
+		assertFalse(idx.exists());
+		assertFalse(lck.exists());
+	}
+
+	public void testWriteEmptyUnlock_RealIndex() throws Exception {
+		final File idx = new File(db.getDirectory(), "index");
+		final File lck = new File(db.getDirectory(), "index.lock");
+		assertFalse(idx.exists());
+		assertFalse(lck.exists());
+
+		final DirCache dc = DirCache.lock(db);
+		assertEquals(0, lck.length());
+		dc.write();
+		assertEquals(12 + 20, lck.length());
+
+		dc.unlock();
+		assertFalse(idx.exists());
+		assertFalse(lck.exists());
+	}
+
+	public void testWriteEmptyCommit_RealIndex() throws Exception {
+		final File idx = new File(db.getDirectory(), "index");
+		final File lck = new File(db.getDirectory(), "index.lock");
+		assertFalse(idx.exists());
+		assertFalse(lck.exists());
+
+		final DirCache dc = DirCache.lock(db);
+		assertEquals(0, lck.length());
+		dc.write();
+		assertEquals(12 + 20, lck.length());
+
+		assertTrue(dc.commit());
+		assertTrue(idx.exists());
+		assertFalse(lck.exists());
+		assertEquals(12 + 20, idx.length());
+	}
+
+	public void testWriteEmptyReadEmpty_RealIndex() throws Exception {
+		final File idx = new File(db.getDirectory(), "index");
+		final File lck = new File(db.getDirectory(), "index.lock");
+		assertFalse(idx.exists());
+		assertFalse(lck.exists());
+		{
+			final DirCache dc = DirCache.lock(db);
+			dc.write();
+			assertTrue(dc.commit());
+			assertTrue(idx.exists());
+		}
+		{
+			final DirCache dc = DirCache.read(db);
+			assertEquals(0, dc.getEntryCount());
+		}
+	}
+
+	public void testWriteEmptyLockEmpty_RealIndex() throws Exception {
+		final File idx = new File(db.getDirectory(), "index");
+		final File lck = new File(db.getDirectory(), "index.lock");
+		assertFalse(idx.exists());
+		assertFalse(lck.exists());
+		{
+			final DirCache dc = DirCache.lock(db);
+			dc.write();
+			assertTrue(dc.commit());
+			assertTrue(idx.exists());
+		}
+		{
+			final DirCache dc = DirCache.lock(db);
+			assertEquals(0, dc.getEntryCount());
+			assertTrue(idx.exists());
+			assertTrue(lck.exists());
+			dc.unlock();
+		}
+	}
+
+	public void testBuildThenClear() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a.b", "a/b", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++)
+			ents[i] = new DirCacheEntry(paths[i]);
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		assertEquals(paths.length, dc.getEntryCount());
+		dc.clear();
+		assertEquals(0, dc.getEntryCount());
+	}
+
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderIteratorTest.java
new file mode 100644
index 0000000..cbcdeb5
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderIteratorTest.java
@@ -0,0 +1,91 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.dircache;
+
+import java.util.Collections;
+
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.filter.PathFilterGroup;
+
+public class DirCacheBuilderIteratorTest extends RepositoryTestCase {
+	public void testPathFilterGroup_DoesNotSkipTail() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final FileMode mode = FileMode.REGULAR_FILE;
+		final String[] paths = { "a.", "a/b", "a/c", "a/d", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++) {
+			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(mode);
+		}
+		{
+			final DirCacheBuilder b = dc.builder();
+			for (int i = 0; i < ents.length; i++)
+				b.add(ents[i]);
+			b.finish();
+		}
+
+		final int expIdx = 2;
+		final DirCacheBuilder b = dc.builder();
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.addTree(new DirCacheBuildIterator(b));
+		tw.setRecursive(true);
+		tw.setFilter(PathFilterGroup.createFromStrings(Collections
+				.singleton(paths[expIdx])));
+
+		assertTrue("found " + paths[expIdx], tw.next());
+		final DirCacheIterator c = tw.getTree(0, DirCacheIterator.class);
+		assertNotNull(c);
+		assertEquals(expIdx, c.cachePos);
+		assertSame(ents[expIdx], c.getDirCacheEntry());
+		assertEquals(paths[expIdx], tw.getPathString());
+		assertEquals(mode.getBits(), tw.getRawMode(0));
+		assertSame(mode, tw.getFileMode(0));
+		b.add(c.getDirCacheEntry());
+
+		assertFalse("no more entries", tw.next());
+
+		b.finish();
+		assertEquals(ents.length, dc.getEntryCount());
+		for (int i = 0; i < ents.length; i++)
+			assertSame(ents[i], dc.getEntry(i));
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderTest.java
new file mode 100644
index 0000000..2cf1d92
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBuilderTest.java
@@ -0,0 +1,253 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.dircache;
+
+import java.io.File;
+
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class DirCacheBuilderTest extends RepositoryTestCase {
+	public void testBuildEmpty() throws Exception {
+		{
+			final DirCache dc = DirCache.lock(db);
+			final DirCacheBuilder b = dc.builder();
+			assertNotNull(b);
+			b.finish();
+			dc.write();
+			assertTrue(dc.commit());
+		}
+		{
+			final DirCache dc = DirCache.read(db);
+			assertEquals(0, dc.getEntryCount());
+		}
+	}
+
+	public void testBuildOneFile_FinishWriteCommit() throws Exception {
+		final String path = "a-file-path";
+		final FileMode mode = FileMode.REGULAR_FILE;
+		final long lastModified = 1218123387057L;
+		final int length = 1342;
+		final DirCacheEntry entOrig;
+		{
+			final DirCache dc = DirCache.lock(db);
+			final DirCacheBuilder b = dc.builder();
+			assertNotNull(b);
+
+			entOrig = new DirCacheEntry(path);
+			entOrig.setFileMode(mode);
+			entOrig.setLastModified(lastModified);
+			entOrig.setLength(length);
+
+			assertNotSame(path, entOrig.getPathString());
+			assertEquals(path, entOrig.getPathString());
+			assertEquals(ObjectId.zeroId(), entOrig.getObjectId());
+			assertEquals(mode.getBits(), entOrig.getRawMode());
+			assertEquals(0, entOrig.getStage());
+			assertEquals(lastModified, entOrig.getLastModified());
+			assertEquals(length, entOrig.getLength());
+			assertFalse(entOrig.isAssumeValid());
+			b.add(entOrig);
+
+			b.finish();
+			assertEquals(1, dc.getEntryCount());
+			assertSame(entOrig, dc.getEntry(0));
+
+			dc.write();
+			assertTrue(dc.commit());
+		}
+		{
+			final DirCache dc = DirCache.read(db);
+			assertEquals(1, dc.getEntryCount());
+
+			final DirCacheEntry entRead = dc.getEntry(0);
+			assertNotSame(entOrig, entRead);
+			assertEquals(path, entRead.getPathString());
+			assertEquals(ObjectId.zeroId(), entOrig.getObjectId());
+			assertEquals(mode.getBits(), entOrig.getRawMode());
+			assertEquals(0, entOrig.getStage());
+			assertEquals(lastModified, entOrig.getLastModified());
+			assertEquals(length, entOrig.getLength());
+			assertFalse(entOrig.isAssumeValid());
+		}
+	}
+
+	public void testBuildOneFile_Commit() throws Exception {
+		final String path = "a-file-path";
+		final FileMode mode = FileMode.REGULAR_FILE;
+		final long lastModified = 1218123387057L;
+		final int length = 1342;
+		final DirCacheEntry entOrig;
+		{
+			final DirCache dc = DirCache.lock(db);
+			final DirCacheBuilder b = dc.builder();
+			assertNotNull(b);
+
+			entOrig = new DirCacheEntry(path);
+			entOrig.setFileMode(mode);
+			entOrig.setLastModified(lastModified);
+			entOrig.setLength(length);
+
+			assertNotSame(path, entOrig.getPathString());
+			assertEquals(path, entOrig.getPathString());
+			assertEquals(ObjectId.zeroId(), entOrig.getObjectId());
+			assertEquals(mode.getBits(), entOrig.getRawMode());
+			assertEquals(0, entOrig.getStage());
+			assertEquals(lastModified, entOrig.getLastModified());
+			assertEquals(length, entOrig.getLength());
+			assertFalse(entOrig.isAssumeValid());
+			b.add(entOrig);
+
+			assertTrue(b.commit());
+			assertEquals(1, dc.getEntryCount());
+			assertSame(entOrig, dc.getEntry(0));
+			assertFalse(new File(db.getDirectory(), "index.lock").exists());
+		}
+		{
+			final DirCache dc = DirCache.read(db);
+			assertEquals(1, dc.getEntryCount());
+
+			final DirCacheEntry entRead = dc.getEntry(0);
+			assertNotSame(entOrig, entRead);
+			assertEquals(path, entRead.getPathString());
+			assertEquals(ObjectId.zeroId(), entOrig.getObjectId());
+			assertEquals(mode.getBits(), entOrig.getRawMode());
+			assertEquals(0, entOrig.getStage());
+			assertEquals(lastModified, entOrig.getLastModified());
+			assertEquals(length, entOrig.getLength());
+			assertFalse(entOrig.isAssumeValid());
+		}
+	}
+
+	public void testFindSingleFile() throws Exception {
+		final String path = "a-file-path";
+		final DirCache dc = DirCache.read(db);
+		final DirCacheBuilder b = dc.builder();
+		assertNotNull(b);
+
+		final DirCacheEntry entOrig = new DirCacheEntry(path);
+		assertNotSame(path, entOrig.getPathString());
+		assertEquals(path, entOrig.getPathString());
+		b.add(entOrig);
+		b.finish();
+
+		assertEquals(1, dc.getEntryCount());
+		assertSame(entOrig, dc.getEntry(0));
+		assertEquals(0, dc.findEntry(path));
+
+		assertEquals(-1, dc.findEntry("@@-before"));
+		assertEquals(0, real(dc.findEntry("@@-before")));
+
+		assertEquals(-2, dc.findEntry("a-zoo"));
+		assertEquals(1, real(dc.findEntry("a-zoo")));
+
+		assertSame(entOrig, dc.getEntry(path));
+	}
+
+	public void testAdd_InGitSortOrder() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a.b", "a/b", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++)
+			ents[i] = new DirCacheEntry(paths[i]);
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		assertEquals(paths.length, dc.getEntryCount());
+		for (int i = 0; i < paths.length; i++) {
+			assertSame(ents[i], dc.getEntry(i));
+			assertEquals(paths[i], dc.getEntry(i).getPathString());
+			assertEquals(i, dc.findEntry(paths[i]));
+			assertSame(ents[i], dc.getEntry(paths[i]));
+		}
+	}
+
+	public void testAdd_ReverseGitSortOrder() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a.b", "a/b", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++)
+			ents[i] = new DirCacheEntry(paths[i]);
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = ents.length - 1; i >= 0; i--)
+			b.add(ents[i]);
+		b.finish();
+
+		assertEquals(paths.length, dc.getEntryCount());
+		for (int i = 0; i < paths.length; i++) {
+			assertSame(ents[i], dc.getEntry(i));
+			assertEquals(paths[i], dc.getEntry(i).getPathString());
+			assertEquals(i, dc.findEntry(paths[i]));
+			assertSame(ents[i], dc.getEntry(paths[i]));
+		}
+	}
+
+	public void testBuilderClear() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a.b", "a/b", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++)
+			ents[i] = new DirCacheEntry(paths[i]);
+		{
+			final DirCacheBuilder b = dc.builder();
+			for (int i = 0; i < ents.length; i++)
+				b.add(ents[i]);
+			b.finish();
+		}
+		assertEquals(paths.length, dc.getEntryCount());
+		{
+			final DirCacheBuilder b = dc.builder();
+			b.finish();
+		}
+		assertEquals(0, dc.getEntryCount());
+	}
+
+	private static int real(int eIdx) {
+		if (eIdx < 0)
+			eIdx = -(eIdx + 1);
+		return eIdx;
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheFindTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheFindTest.java
new file mode 100644
index 0000000..0eb0302
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheFindTest.java
@@ -0,0 +1,86 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.dircache;
+
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class DirCacheFindTest extends RepositoryTestCase {
+	public void testEntriesWithin() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a/b", "a/c", "a/d", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++)
+			ents[i] = new DirCacheEntry(paths[i]);
+		final int aFirst = 1;
+		final int aLast = 3;
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		assertEquals(paths.length, dc.getEntryCount());
+		for (int i = 0; i < ents.length; i++)
+			assertSame(ents[i], dc.getEntry(i));
+
+		{
+			final DirCacheEntry[] aContents = dc.getEntriesWithin("a");
+			assertNotNull(aContents);
+			assertEquals(aLast - aFirst + 1, aContents.length);
+			for (int i = aFirst, j = 0; i <= aLast; i++, j++)
+				assertSame(ents[i], aContents[j]);
+		}
+		{
+			final DirCacheEntry[] aContents = dc.getEntriesWithin("a/");
+			assertNotNull(aContents);
+			assertEquals(aLast - aFirst + 1, aContents.length);
+			for (int i = aFirst, j = 0; i <= aLast; i++, j++)
+				assertSame(ents[i], aContents[j]);
+		}
+
+		assertNotNull(dc.getEntriesWithin("a."));
+		assertEquals(0, dc.getEntriesWithin("a.").length);
+
+		assertNotNull(dc.getEntriesWithin("a0b"));
+		assertEquals(0, dc.getEntriesWithin("a0b.").length);
+
+		assertNotNull(dc.getEntriesWithin("zoo"));
+		assertEquals(0, dc.getEntriesWithin("zoo.").length);
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
new file mode 100644
index 0000000..7d4e6bb
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheIteratorTest.java
@@ -0,0 +1,273 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.dircache;
+
+import java.util.Collections;
+
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.filter.PathFilterGroup;
+
+public class DirCacheIteratorTest extends RepositoryTestCase {
+	public void testEmptyTree_NoTreeWalk() throws Exception {
+		final DirCache dc = DirCache.read(db);
+		assertEquals(0, dc.getEntryCount());
+
+		final DirCacheIterator i = new DirCacheIterator(dc);
+		i.next();
+		assertTrue(i.eof());
+	}
+
+	public void testEmptyTree_WithTreeWalk() throws Exception {
+		final DirCache dc = DirCache.read(db);
+		assertEquals(0, dc.getEntryCount());
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.addTree(new DirCacheIterator(dc));
+		assertFalse(tw.next());
+	}
+
+	public void testNoSubtree_NoTreeWalk() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++)
+			ents[i] = new DirCacheEntry(paths[i]);
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		final DirCacheIterator i = new DirCacheIterator(dc);
+		int pathIdx = 0;
+		for (;;) {
+			i.next();
+			if (i.eof())
+				break;
+			assertEquals(pathIdx, i.cachePos);
+			assertSame(ents[pathIdx], i.getDirCacheEntry());
+			pathIdx++;
+		}
+		assertEquals(pathIdx, paths.length);
+	}
+
+	public void testNoSubtree_WithTreeWalk() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a0b" };
+		final FileMode[] modes = { FileMode.EXECUTABLE_FILE, FileMode.GITLINK };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++) {
+			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(modes[i]);
+		}
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		final DirCacheIterator i = new DirCacheIterator(dc);
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.addTree(i);
+		int pathIdx = 0;
+		while (tw.next()) {
+			assertSame(i, tw.getTree(0, DirCacheIterator.class));
+			assertEquals(pathIdx, i.cachePos);
+			assertSame(ents[pathIdx], i.getDirCacheEntry());
+			assertEquals(paths[pathIdx], tw.getPathString());
+			assertEquals(modes[pathIdx].getBits(), tw.getRawMode(0));
+			assertSame(modes[pathIdx], tw.getFileMode(0));
+			pathIdx++;
+		}
+		assertEquals(pathIdx, paths.length);
+	}
+
+	public void testSingleSubtree_NoRecursion() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a/b", "a/c", "a/d", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++) {
+			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(FileMode.REGULAR_FILE);
+		}
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		final String[] expPaths = { "a.", "a", "a0b" };
+		final FileMode[] expModes = { FileMode.REGULAR_FILE, FileMode.TREE,
+				FileMode.REGULAR_FILE };
+		final int expPos[] = { 0, -1, 4 };
+
+		final DirCacheIterator i = new DirCacheIterator(dc);
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.addTree(i);
+		tw.setRecursive(false);
+		int pathIdx = 0;
+		while (tw.next()) {
+			assertSame(i, tw.getTree(0, DirCacheIterator.class));
+			assertEquals(expModes[pathIdx].getBits(), tw.getRawMode(0));
+			assertSame(expModes[pathIdx], tw.getFileMode(0));
+			assertEquals(expPaths[pathIdx], tw.getPathString());
+
+			if (expPos[pathIdx] >= 0) {
+				assertEquals(expPos[pathIdx], i.cachePos);
+				assertSame(ents[expPos[pathIdx]], i.getDirCacheEntry());
+			} else {
+				assertSame(FileMode.TREE, tw.getFileMode(0));
+			}
+
+			pathIdx++;
+		}
+		assertEquals(pathIdx, expPaths.length);
+	}
+
+	public void testSingleSubtree_Recursive() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final FileMode mode = FileMode.REGULAR_FILE;
+		final String[] paths = { "a.", "a/b", "a/c", "a/d", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++) {
+			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(mode);
+		}
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		final DirCacheIterator i = new DirCacheIterator(dc);
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.addTree(i);
+		tw.setRecursive(true);
+		int pathIdx = 0;
+		while (tw.next()) {
+			final DirCacheIterator c = tw.getTree(0, DirCacheIterator.class);
+			assertNotNull(c);
+			assertEquals(pathIdx, c.cachePos);
+			assertSame(ents[pathIdx], c.getDirCacheEntry());
+			assertEquals(paths[pathIdx], tw.getPathString());
+			assertEquals(mode.getBits(), tw.getRawMode(0));
+			assertSame(mode, tw.getFileMode(0));
+			pathIdx++;
+		}
+		assertEquals(pathIdx, paths.length);
+	}
+
+	public void testTwoLevelSubtree_Recursive() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final FileMode mode = FileMode.REGULAR_FILE;
+		final String[] paths = { "a.", "a/b", "a/c/e", "a/c/f", "a/d", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++) {
+			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(mode);
+		}
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.reset();
+		tw.addTree(new DirCacheIterator(dc));
+		tw.setRecursive(true);
+		int pathIdx = 0;
+		while (tw.next()) {
+			final DirCacheIterator c = tw.getTree(0, DirCacheIterator.class);
+			assertNotNull(c);
+			assertEquals(pathIdx, c.cachePos);
+			assertSame(ents[pathIdx], c.getDirCacheEntry());
+			assertEquals(paths[pathIdx], tw.getPathString());
+			assertEquals(mode.getBits(), tw.getRawMode(0));
+			assertSame(mode, tw.getFileMode(0));
+			pathIdx++;
+		}
+		assertEquals(pathIdx, paths.length);
+	}
+
+	public void testTwoLevelSubtree_FilterPath() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final FileMode mode = FileMode.REGULAR_FILE;
+		final String[] paths = { "a.", "a/b", "a/c/e", "a/c/f", "a/d", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++) {
+			ents[i] = new DirCacheEntry(paths[i]);
+			ents[i].setFileMode(mode);
+		}
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		final TreeWalk tw = new TreeWalk(db);
+		for (int victimIdx = 0; victimIdx < paths.length; victimIdx++) {
+			tw.reset();
+			tw.addTree(new DirCacheIterator(dc));
+			tw.setFilter(PathFilterGroup.createFromStrings(Collections
+					.singleton(paths[victimIdx])));
+			tw.setRecursive(tw.getFilter().shouldBeRecursive());
+			assertTrue(tw.next());
+			final DirCacheIterator c = tw.getTree(0, DirCacheIterator.class);
+			assertNotNull(c);
+			assertEquals(victimIdx, c.cachePos);
+			assertSame(ents[victimIdx], c.getDirCacheEntry());
+			assertEquals(paths[victimIdx], tw.getPathString());
+			assertEquals(mode.getBits(), tw.getRawMode(0));
+			assertSame(mode, tw.getFileMode(0));
+			assertFalse(tw.next());
+		}
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java
new file mode 100644
index 0000000..b37095d
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.dircache;
+
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class DirCacheTreeTest extends RepositoryTestCase {
+	public void testEmptyCache_NoCacheTree() throws Exception {
+		final DirCache dc = DirCache.read(db);
+		assertNull(dc.getCacheTree(false));
+	}
+
+	public void testEmptyCache_CreateEmptyCacheTree() throws Exception {
+		final DirCache dc = DirCache.read(db);
+		final DirCacheTree tree = dc.getCacheTree(true);
+		assertNotNull(tree);
+		assertSame(tree, dc.getCacheTree(false));
+		assertSame(tree, dc.getCacheTree(true));
+		assertEquals("", tree.getNameString());
+		assertEquals("", tree.getPathString());
+		assertEquals(0, tree.getChildCount());
+		assertEquals(0, tree.getEntrySpan());
+		assertFalse(tree.isValid());
+	}
+
+	public void testEmptyCache_Clear_NoCacheTree() throws Exception {
+		final DirCache dc = DirCache.read(db);
+		final DirCacheTree tree = dc.getCacheTree(true);
+		assertNotNull(tree);
+		dc.clear();
+		assertNull(dc.getCacheTree(false));
+		assertNotSame(tree, dc.getCacheTree(true));
+	}
+
+	public void testSingleSubtree() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a/b", "a/c", "a/d", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++)
+			ents[i] = new DirCacheEntry(paths[i]);
+		final int aFirst = 1;
+		final int aLast = 3;
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		assertNull(dc.getCacheTree(false));
+		final DirCacheTree root = dc.getCacheTree(true);
+		assertNotNull(root);
+		assertSame(root, dc.getCacheTree(true));
+		assertEquals("", root.getNameString());
+		assertEquals("", root.getPathString());
+		assertEquals(1, root.getChildCount());
+		assertEquals(dc.getEntryCount(), root.getEntrySpan());
+		assertFalse(root.isValid());
+
+		final DirCacheTree aTree = root.getChild(0);
+		assertNotNull(aTree);
+		assertSame(aTree, root.getChild(0));
+		assertEquals("a", aTree.getNameString());
+		assertEquals("a/", aTree.getPathString());
+		assertEquals(0, aTree.getChildCount());
+		assertEquals(aLast - aFirst + 1, aTree.getEntrySpan());
+		assertFalse(aTree.isValid());
+	}
+
+	public void testTwoLevelSubtree() throws Exception {
+		final DirCache dc = DirCache.read(db);
+
+		final String[] paths = { "a.", "a/b", "a/c/e", "a/c/f", "a/d", "a0b" };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++)
+			ents[i] = new DirCacheEntry(paths[i]);
+		final int aFirst = 1;
+		final int aLast = 4;
+		final int acFirst = 2;
+		final int acLast = 3;
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+		b.finish();
+
+		assertNull(dc.getCacheTree(false));
+		final DirCacheTree root = dc.getCacheTree(true);
+		assertNotNull(root);
+		assertSame(root, dc.getCacheTree(true));
+		assertEquals("", root.getNameString());
+		assertEquals("", root.getPathString());
+		assertEquals(1, root.getChildCount());
+		assertEquals(dc.getEntryCount(), root.getEntrySpan());
+		assertFalse(root.isValid());
+
+		final DirCacheTree aTree = root.getChild(0);
+		assertNotNull(aTree);
+		assertSame(aTree, root.getChild(0));
+		assertEquals("a", aTree.getNameString());
+		assertEquals("a/", aTree.getPathString());
+		assertEquals(1, aTree.getChildCount());
+		assertEquals(aLast - aFirst + 1, aTree.getEntrySpan());
+		assertFalse(aTree.isValid());
+
+		final DirCacheTree acTree = aTree.getChild(0);
+		assertNotNull(acTree);
+		assertSame(acTree, aTree.getChild(0));
+		assertEquals("c", acTree.getNameString());
+		assertEquals("a/c/", acTree.getPathString());
+		assertEquals(0, acTree.getChildCount());
+		assertEquals(acLast - acFirst + 1, acTree.getEntrySpan());
+		assertFalse(acTree.isValid());
+	}
+}
-- 
1.6.0.rc2.22.g71b99
