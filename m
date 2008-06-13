From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 24/24] Added the test class AddCommandIterationTest.
Date: Fri, 13 Jun 2008 20:35:21 +0200
Message-ID: <1213382121-19786-24-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAW-0005zA-Mc
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbYFMSgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:36:25 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYFMSgX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:36:23 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43464 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbYFMSfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:36 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id F2563E184EED
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:35 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7b-0000eI-00; Fri, 13 Jun 2008 20:35:35 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/u8asWzHremPlh1qpEGAqKKZjhCqv3kuz2hZLx
	e41xCpHW4VSlL+R3TuDXa6CS5EjypYU6KR5Or7/MH2H92IKou0
	w+gnx0ouQdOIIMQ9uO0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84929>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../treewalk/rules/AddCommandIterationTest.java    |  339 ++++++++++++=
++++++++
 1 files changed, 339 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk=
/rules/AddCommandIterationTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/=
AddCommandIterationTest.java b/org.spearce.jgit.test/tst/org/spearce/jg=
it/treewalk/rules/AddCommandIterationTest.java
new file mode 100644
index 0000000..a17fc18
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/rules/AddComm=
andIterationTest.java
@@ -0,0 +1,339 @@
+/*
+ * Copyright (C) 2008, Florian K=C3=B6berle <florianskarten@web.de>
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
+package org.spearce.jgit.treewalk.rules;
+
+import java.io.File;
+import java.io.IOException;
+import java.io.PrintWriter;
+import java.util.ArrayList;
+import java.util.Arrays;
+import java.util.Collections;
+import java.util.HashSet;
+import java.util.Iterator;
+import java.util.List;
+import java.util.NoSuchElementException;
+import java.util.Set;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.PathNotInProjectDirectoryException;
+import org.spearce.jgit.lib.AbstractTestCase;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.WorkTree;
+import org.spearce.jgit.treewalk.LightFileTreeIterable;
+
+public class AddCommandIterationTest extends AbstractTestCase {
+
+	private WorkTree workTree;
+
+	private AddRulesFactory factory;
+
+	private Iterable<File> createIterable(File workingDirectory,
+			List<String> filePatternsOfAddCommand)
+			throws PathNotInProjectDirectoryException, InvalidPatternException,
+			IOException {
+		final Rules rules =3D factory.createRules(workTree.getDirectory(),
+				workingDirectory, filePatternsOfAddCommand);
+		return new LightFileTreeIterable(workTree.getDirectory(), rules, fal=
se);
+	}
+
+	@Override
+	protected void setUp() throws Exception {
+		super.setUp();
+		final File projectDirectory =3D createTemporaryDirectory();
+		this.workTree =3D Repository.createWorkTree(projectDirectory);
+		this.factory =3D new AddRulesFactory();
+	}
+
+	public void testNoPattern() throws Exception {
+		createFile("a.txt");
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				Collections.<String> emptyList());
+		final Set<File> expectedPaths =3D Collections.emptySet();
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPaths, iterable);
+	}
+
+	public void testTreePattern1() throws Exception {
+		final Set<File> expectedFiles =3D new HashSet<File>();
+		createFile("a.txt");
+		expectedFiles.add(createFile("a", "a.txt"));
+		expectedFiles.add(createFile("a", "a", "a.txt"));
+		expectedFiles.add(createFile("a", "b", "a.txt"));
+		createFile("a", "b", "a.c");
+
+		final File directoryA =3D new File(workTree.getDirectory(), "a");
+
+		final Iterable<File> iterable =3D createIterable(directoryA, Arrays
+				.asList("*.txt"));
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedFiles, iterable);
+	}
+
+	public void testTreePattern2() throws Exception {
+		final Set<File> expectedFiles =3D new HashSet<File>();
+		createFile("a.txt");
+		expectedFiles.add(createFile("a", "a.txt"));
+		expectedFiles.add(createFile("a", "a", "a.txt"));
+		expectedFiles.add(createFile("a", "b", "a.txt"));
+		createFile("a", "b", "a.c");
+
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				Arrays.asList("a" + File.separator + "*.txt"));
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedFiles, iterable);
+	}
+
+	public void testSelectCompleteSubdirectory() throws Exception {
+		final Set<File> expectedPaths =3D new HashSet<File>();
+		final File directoryA =3D new File(workTree.getDirectory(), "a");
+		final File directoryAA =3D new File(directoryA, "a");
+		final File directoryAB =3D new File(directoryA, "b");
+		createFile("a.txt");
+		expectedPaths.add(directoryA);
+		expectedPaths.add(directoryAA);
+		expectedPaths.add(createFile("a", "a.txt"));
+		expectedPaths.add(createFile("a", "a", "a.txt"));
+		expectedPaths.add(directoryAB);
+		expectedPaths.add(createFile("a", "b", "a.txt"));
+		expectedPaths.add(createFile("a", "b", "a.c"));
+
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				Arrays.asList("a"));
+
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPaths, iterable);
+	}
+
+	public void testSelectTwoSubdirectories() throws Exception {
+		final Set<File> expectedPaths =3D new HashSet<File>();
+		final File directoryA =3D new File(workTree.getDirectory(), "a");
+		final File directoryAA =3D new File(directoryA, "a");
+		final File directoryAB =3D new File(directoryA, "b");
+		createFile("a.txt");
+		createFile("a", "a.txt");
+		expectedPaths.add(directoryAA);
+		expectedPaths.add(createFile("a", "a", "a.txt"));
+		expectedPaths.add(directoryAB);
+		expectedPaths.add(createFile("a", "b", "a.txt"));
+		expectedPaths.add(createFile("a", "b", "a.c"));
+
+		final List<String> patternList =3D new ArrayList<String>(2);
+		patternList.add("a" + File.separator + "a");
+		patternList.add("a" + File.separator + "b");
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				patternList);
+
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPaths, iterable);
+	}
+
+	public void testTwoDifferentSelects() throws Exception {
+		final Set<File> expectedPaths =3D new HashSet<File>();
+		final File directoryA =3D new File(workTree.getDirectory(), "a");
+		final File directoryAA =3D new File(directoryA, "a");
+		createFile("a.txt");
+		createFile("a", "a.txt");
+		expectedPaths.add(directoryAA);
+		expectedPaths.add(createFile("a", "a", "a.txt"));
+		expectedPaths.add(createFile("a", "b", "a.txt"));
+		expectedPaths.add(createFile("a", "b", "c", "a.txt"));
+		createFile("a", "b", "a.c");
+
+		final List<String> patternList =3D new ArrayList<String>(2);
+		patternList.add("a" + File.separator + "a");
+		patternList.add("a" + File.separator + "b" + File.separator + "*.txt=
");
+
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				patternList);
+
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPaths, iterable);
+	}
+
+	public void testRealisticExample() throws Exception {
+		final Set<File> expectedPaths =3D new HashSet<File>();
+
+		// write the .gitignore file
+		final File dotGitIgnoreFile =3D createFile(".gitignore");
+		final PrintWriter dotGitIgnoreFilePrinter =3D new PrintWriter(
+				dotGitIgnoreFile);
+		try {
+			dotGitIgnoreFilePrinter.println("/alpha/config.xml");
+			dotGitIgnoreFilePrinter.println("*.class");
+			dotGitIgnoreFilePrinter.println("!/alpha/test/ressources/");
+			dotGitIgnoreFilePrinter.println("*~");
+		} finally {
+			dotGitIgnoreFilePrinter.close();
+		}
+
+		// write the .git/info/exclude file
+		final File repositoryDirectory =3D workTree.getRepository()
+				.getDirectory();
+		final File infoDirectory =3D new File(repositoryDirectory, "info");
+		infoDirectory.mkdir();
+		final File infoExcludeFile =3D new File(infoDirectory, "exclude");
+		final PrintWriter infoExcludeFilePrinter =3D new PrintWriter(
+				infoExcludeFile);
+		try {
+			infoExcludeFilePrinter.println("/alpha/test/ressources/mytest.txt")=
;
+		} finally {
+			infoExcludeFilePrinter.close();
+		}
+
+		createFile("alpha", "config.xml");
+		expectedPaths.add(createFile("alpha", "src", "Main.java"));
+		createFile("alpha", "src", "Main.class");
+		expectedPaths.add(createFile("alpha", "test", "ressources",
+				"Example.class"));
+		expectedPaths
+				.add(createFile("alpha", "test", "ressources", "input.txt"));
+		createFile("alpha", "test", "ressources", "input.txt~");
+		createFile("alpha", "test", "ressources", "mytest.txt");
+
+		final File alphaDirectory =3D new File(workTree.getDirectory(), "alp=
ha");
+		final File srcDirectory =3D new File(alphaDirectory, "src");
+		final File testDirectory =3D new File(alphaDirectory, "test");
+		final File ressources =3D new File(testDirectory, "ressources");
+
+		expectedPaths.add(alphaDirectory);
+		expectedPaths.add(srcDirectory);
+		expectedPaths.add(testDirectory);
+		expectedPaths.add(ressources);
+
+		final List<String> patternList =3D new ArrayList<String>(2);
+		patternList.add("alpha");
+
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				patternList);
+
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPaths, iterable);
+	}
+
+	public void testSingleFile() throws Exception {
+		createFile("a.txt");
+		createFile("a", "a.txt");
+		createFile("a", "a", "a.txt");
+		final File expectedFile =3D createFile("a", "b", "a.txt");
+		createFile("a", "b", "a.c");
+
+		final String pattern =3D "a" + File.separator + "b" + File.separator
+				+ "a.txt";
+		final Iterable<File> iterable =3D createIterable(workTree.getDirecto=
ry(),
+				Arrays.asList(pattern));
+		final Set<File> expectedPaths =3D Collections.singleton(expectedFile=
);
+		assertIsValidIterable(iterable);
+		assertIterableReturnsSet(expectedPaths, iterable);
+	}
+
+	/**
+	 * Tests if the specified {@link Iterable} returns the specified set =
of
+	 * {@link File}s. The assertion will fail if the {@link Iterable} ret=
urns
+	 * to much, to less files. It will also fail if the {@link Iterable} =
returns
+	 * a file twice.
+	 *=20
+	 * @param expectedContent
+	 *            the expected set of files.
+	 * @param iterable
+	 *            the {@link Iterable} to test.
+	 */
+	private void assertIterableReturnsSet(Set<File> expectedContent,
+			Iterable<File> iterable) {
+		final Set<File> returnedFiles =3D new HashSet<File>();
+		final List<File> doubleReturnedFiles =3D new ArrayList<File>();
+
+		final Iterator<File> iterator =3D iterable.iterator();
+		while (iterator.hasNext()) {
+			final File file =3D iterator.next();
+			if (!returnedFiles.add(file)) {
+				doubleReturnedFiles.add(file);
+			}
+		}
+		final Set<File> missingFiles =3D new HashSet<File>();
+		for (File file : expectedContent) {
+			if (!returnedFiles.contains(file)) {
+				missingFiles.add(file);
+			}
+		}
+		if (!missingFiles.isEmpty()) {
+			fail(String.format("missing paths: %s", missingFiles));
+		}
+
+		final Set<File> unexpectedFiles =3D new HashSet<File>();
+		for (File file : returnedFiles) {
+			if (!expectedContent.contains(file)) {
+				unexpectedFiles.add(file);
+			}
+		}
+		if (!unexpectedFiles.isEmpty()) {
+			fail(String.format("unexpected paths: %s", unexpectedFiles));
+		}
+
+		if (!doubleReturnedFiles.isEmpty()) {
+			fail(String.format("multiple times returned paths: %s",
+					doubleReturnedFiles));
+		}
+
+	}
+
+	private static void assertIsValidIterable(Iterable<File> iterable) {
+		final Iterator<File> iterator =3D iterable.iterator();
+		while (iterator.hasNext()) {
+			iterator.next();
+		}
+		try {
+			iterator.next();
+			fail();
+		} catch (NoSuchElementException e) {
+			// expected
+		}
+	}
+
+	private File createFile(String... path) throws IOException {
+		File file =3D workTree.getDirectory();
+		for (int i =3D 0; i < path.length; i++) {
+			file =3D new File(file, path[i]);
+			if (i =3D=3D path.length - 1) {
+				file.getParentFile().mkdirs();
+				file.createNewFile();
+				break;
+			}
+		}
+		return file;
+	}
+}
--=20
1.5.4.3
