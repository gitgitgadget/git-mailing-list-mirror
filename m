From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 1/3] Add test cases dedicated to the WindowCache
Date: Sun, 19 Apr 2009 20:30:07 +0200
Message-ID: <1240165809-16703-2-git-send-email-robin.rosenberg@dewire.com>
References: <200904181905.55119.robin.rosenberg.lists@dewire.com>
 <1240165809-16703-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 19 20:32:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvbo9-0000re-2o
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 20:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbZDSSaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 14:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbZDSSaT
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 14:30:19 -0400
Received: from mail.dewire.com ([83.140.172.130]:19115 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277AbZDSSaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 14:30:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0C363149165A;
	Sun, 19 Apr 2009 20:30:13 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BaFWQOoYFgj0; Sun, 19 Apr 2009 20:30:11 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 66DED8026F8;
	Sun, 19 Apr 2009 20:30:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240165809-16703-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116908>

Fails like this in the debugger (expected), but runs ok outside the debugger.

Breakpoints in the following places. Wait a second or two everytime it stops

WindowCacheTest [line: 101] - testObjectMovedToNewPack()
WindowedFile [line: 283] - cacheOpen()

java.io.FileNotFoundException: /home/me/SW/EGIT/org.spearce.jgit.test/trash/trash1240071609317.0/.git/objects/pack/pack-fc4dadd6673a2740f43468f868ba5dd39fdeba69.pack (Filen eller katalogen finns inte)
	at java.io.RandomAccessFile.open(Native Method)
	at java.io.RandomAccessFile.<init>(RandomAccessFile.java:212)
	at org.spearce.jgit.lib.WindowedFile.cacheOpen(WindowedFile.java:283)
	at org.spearce.jgit.lib.WindowCache.getImpl(WindowCache.java:249)
	at org.spearce.jgit.lib.WindowCache.get(WindowCache.java:222)
	at org.spearce.jgit.lib.WindowCursor.pin(WindowCursor.java:148)
	at org.spearce.jgit.lib.WindowCursor.copy(WindowCursor.java:82)
	at org.spearce.jgit.lib.WindowedFile.read(WindowedFile.java:176)
	at org.spearce.jgit.lib.WindowedFile.readFully(WindowedFile.java:203)
	at org.spearce.jgit.lib.PackFile.reader(PackFile.java:311)
	at org.spearce.jgit.lib.PackFile.get(PackFile.java:147)
	at org.spearce.jgit.lib.Repository.openObjectInPacks(Repository.java:312)
	at org.spearce.jgit.lib.Repository.openObject(Repository.java:294)
	at org.spearce.jgit.revwalk.RevWalk.parseAny(RevWalk.java:702)
	at org.spearce.jgit.lib.WindowCacheTest.testObjectMovedToNewPack(WindowCacheTest.java:115)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
	at java.lang.reflect.Method.invoke(Method.java:597)
	at junit.framework.TestCase.runTest(TestCase.java:164)
	at junit.framework.TestCase.runBare(TestCase.java:130)
	at junit.framework.TestResult$1.protect(TestResult.java:106)
	at junit.framework.TestResult.runProtected(TestResult.java:124)
	at junit.framework.TestResult.run(TestResult.java:109)
	at junit.framework.TestCase.run(TestCase.java:120)
	at org.eclipse.jdt.internal.junit.runner.junit3.JUnit3TestReference.run(JUnit3TestReference.java:130)
	at org.eclipse.jdt.internal.junit.runner.TestExecution.run(TestExecution.java:38)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:460)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:673)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.run(RemoteTestRunner.java:386)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.main(RemoteTestRunner.java:196)
---
 .../tst/org/spearce/jgit/lib/WindowCacheTest.java  |  125 ++++++++++++++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
new file mode 100644
index 0000000..0cd55c9
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
@@ -0,0 +1,125 @@
+package org.spearce.jgit.lib;
+
+import java.io.ByteArrayInputStream;
+import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevWalk;
+
+public class WindowCacheTest extends RepositoryTestCase {
+
+	public void setUp() throws Exception {
+		WindowCacheConfig windowCacheConfig = new WindowCacheConfig();
+		windowCacheConfig.setPackedGitOpenFiles(1);
+		WindowCache.reconfigure(windowCacheConfig);
+		super.setUp();
+	}
+
+	protected void tearDown() throws Exception {
+		super.tearDown();
+		WindowCacheConfig windowCacheConfig = new WindowCacheConfig();
+		WindowCache.reconfigure(windowCacheConfig);
+	}
+
+	/*
+	 * Add pack, find objects in new pack Replace packs, find objects in another
+	 * pack than original, don't choke on lost pack
+	 */
+	public void testObjectInNewPack() throws IncorrectObjectTypeException,
+			IOException {
+		Repository extra = createNewEmptyRepo();
+		RevObject o1 = writeBlob(extra, db,
+				"nihuioijoisuoiudyosyudoiuyusyuoiyewData");
+		PackWriter packWriter = new PackWriter(extra, new TextProgressMonitor());
+		packWriter.addObject(o1);
+		ObjectId name = packWriter.computeName();
+		File packFileName = fullPackFileName(db, name, ".pack");
+		FileOutputStream pos = new FileOutputStream(packFileName);
+		packWriter.writePack(pos);
+		pos.close();
+		File idxfname = fullPackFileName(db, name, ".idx");
+		FileOutputStream ios = new FileOutputStream(idxfname);
+		packWriter.writeIndex(ios);
+		ios.close();
+		assertEquals(o1.name(), new RevWalk(db).parseAny(o1).name());
+	}
+
+	/*
+	 * Add pack, find objects in new pack Replace packs, find objects in another
+	 * pack than original, don't choke on lost pack
+	 */
+	public void testObjectMovedToNewPack() throws IncorrectObjectTypeException,
+			IOException {
+		Repository extra = createNewEmptyRepo();
+		RevObject o1 = writeBlob(extra, db,
+				"nihuioijoisuoiudyosyudoiuyusyuoiyewData1");
+		PackWriter packWriter1 = new PackWriter(extra,
+				new TextProgressMonitor());
+		packWriter1.addObject(o1);
+		ObjectId name1 = packWriter1.computeName();
+		File packFileName1 = fullPackFileName(db, name1, ".pack");
+		FileOutputStream pos1 = new FileOutputStream(packFileName1);
+		packWriter1.writePack(pos1);
+		pos1.close();
+		File idxfname1 = fullPackFileName(db, name1, ".idx");
+		FileOutputStream ios1 = new FileOutputStream(idxfname1);
+		packWriter1.writeIndex(ios1);
+		ios1.close();
+		assertEquals(o1.name(), new RevWalk(db).parseAny(o1).name());
+
+		// Ok, lets repack this repo
+		// create an additional object
+		RevObject o2 = writeBlob(extra, db,
+				"nihuioijoisuoiudyosyudoiuyusyuoiyewData2");
+		PackWriter packWriter2 = new PackWriter(extra,
+				new TextProgressMonitor());
+		packWriter2.addObject(o1);
+		packWriter2.addObject(o2);
+		ObjectId name2 = packWriter2.computeName();
+		File packFileName2 = fullPackFileName(db, name2, ".pack");
+		FileOutputStream pos2 = new FileOutputStream(packFileName2);
+		packWriter2.writePack(pos2);
+		pos2.close();
+		File idxfname2 = fullPackFileName(db, name2, ".idx");
+		FileOutputStream ios2 = new FileOutputStream(idxfname2);
+		packWriter2.writeIndex(ios2);
+		ios2.close();
+		assertEquals(o2.name(), new RevWalk(db).parseAny(o2).name());
+
+		WindowCacheConfig windowCacheConfig = new WindowCacheConfig();
+		windowCacheConfig.setPackedGitOpenFiles(1);
+		WindowCache.reconfigure(windowCacheConfig);
+		packFileName1.delete();
+		idxfname1.delete();
+
+		// Now here is the interesting thing. Will git figure the new
+		// object exists in the new pack, and not the old one.
+		assertEquals(o1.name(), new RevWalk(db).parseAny(o1).name());
+	}
+
+	private File fullPackFileName(Repository repository, ObjectId hash,
+			String suffix) {
+		return new File(new File(repository.getObjectsDirectory(), "pack"),
+				"pack-" + hash.name() + suffix);
+	}
+
+	private RevObject writeBlob(final Repository repo, final Repository notIn,
+			final String data) throws IOException {
+		RevWalk revWalk = new RevWalk(repo);
+		byte[] bytes = data.getBytes(Constants.CHARACTER_ENCODING);
+		ObjectId id = new ObjectWriter(repo).writeBlob(bytes.length,
+				new ByteArrayInputStream(bytes));
+		try {
+			assertNull(
+					"Oops, We want new objects that we do not have yet, for this test!",
+					new RevWalk(notIn).parseAny(id));
+		} catch (MissingObjectException e) {
+			// Ok
+		}
+		return revWalk.lookupBlob(id);
+	}
+}
-- 
1.6.2.2.446.gfbdc0
