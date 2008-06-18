From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT Patch] Added the package fnmatch and two exceptions.
Date: Wed, 18 Jun 2008 12:22:30 +0200
Message-ID: <1213784550-11726-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 12:23:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8upP-0002IB-4h
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 12:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYFRKWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 06:22:51 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbYFRKWv
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 06:22:51 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:40736 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbYFRKWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 06:22:48 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 0CF38E216471
	for <git@vger.kernel.org>; Wed, 18 Jun 2008 12:22:46 +0200 (CEST)
Received: from [84.150.114.112] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K8uoO-0004yx-00; Wed, 18 Jun 2008 12:22:44 +0200
X-Mailer: git-send-email 1.5.5.1
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18GUSGqFZh68n27Zvd+hdePudVYQBHQUyCWfizE
	5mcI07JHSZX8VfRyNcwSa5GRhiSCqiWXLQtMJIHAZ145jBOCzK
	k7pcaNPP+XZRRvNY2DQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85372>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../spearce/jgit/fnmatch/FileNameMatcherTest.java  |  726 ++++++++++++=
++++++++
 .../jgit/errors/InvalidPatternException.java       |   65 ++
 .../jgit/errors/NoClosingBracketException.java     |   69 ++
 .../src/org/spearce/jgit/fnmatch/AbstractHead.java |   74 ++
 .../org/spearce/jgit/fnmatch/CharacterHead.java    |   53 ++
 .../org/spearce/jgit/fnmatch/FileNameMatcher.java  |  351 ++++++++++
 .../src/org/spearce/jgit/fnmatch/GroupHead.java    |  220 ++++++
 .../src/org/spearce/jgit/fnmatch/Head.java         |   50 ++
 .../src/org/spearce/jgit/fnmatch/LastHead.java     |   56 ++
 .../jgit/fnmatch/RestrictedWildCardHead.java       |   52 ++
 .../src/org/spearce/jgit/fnmatch/WildCardHead.java |   49 ++
 11 files changed, 1765 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/fnmatch/=
=46ileNameMatcherTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/Invali=
dPatternException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/NoClos=
ingBracketException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/fnmatch/Abstr=
actHead.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/fnmatch/Chara=
cterHead.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/fnmatch/FileN=
ameMatcher.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/fnmatch/Group=
Head.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/fnmatch/Head.=
java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/fnmatch/LastH=
ead.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/fnmatch/Restr=
ictedWildCardHead.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/fnmatch/WildC=
ardHead.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/fnmatch/FileNam=
eMatcherTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/fnmatch/=
=46ileNameMatcherTest.java
new file mode 100644
index 0000000..f8634dc
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/fnmatch/FileNameMatche=
rTest.java
@@ -0,0 +1,726 @@
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
+package org.spearce.jgit.fnmatch;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.fnmatch.FileNameMatcher;
+
+import junit.framework.TestCase;
+
+public class FileNameMatcherTest extends TestCase {
+
+	private void assertMatch(final String pattern, final String input,
+			final boolean matchExpected, final boolean appendCanMatchExpected)
+			throws InvalidPatternException {
+		final FileNameMatcher matcher =3D new FileNameMatcher(pattern, null)=
;
+		matcher.append(input);
+		assertEquals(matchExpected, matcher.isMatch());
+		assertEquals(appendCanMatchExpected, matcher.canAppendMatch());
+	}
+
+	private void assertFileNameMatch(final String pattern, final String i=
nput,
+			final char excludedCharacter, final boolean matchExpected,
+			final boolean appendCanMatchExpected)
+			throws InvalidPatternException {
+		final FileNameMatcher matcher =3D new FileNameMatcher(pattern,
+				new Character(excludedCharacter));
+		matcher.append(input);
+		assertEquals(matchExpected, matcher.isMatch());
+		assertEquals(appendCanMatchExpected, matcher.canAppendMatch());
+	}
+
+	public void testVerySimplePatternCase0() throws Exception {
+		assertMatch("", "", true, false);
+	}
+
+	public void testVerySimplePatternCase1() throws Exception {
+		assertMatch("ab", "a", false, true);
+	}
+
+	public void testVerySimplePatternCase2() throws Exception {
+		assertMatch("ab", "ab", true, false);
+	}
+
+	public void testVerySimplePatternCase3() throws Exception {
+		assertMatch("ab", "ac", false, false);
+	}
+
+	public void testVerySimplePatternCase4() throws Exception {
+		assertMatch("ab", "abc", false, false);
+	}
+
+	public void testVerySimpleWirdcardCase0() throws Exception {
+		assertMatch("?", "a", true, false);
+	}
+
+	public void testVerySimpleWildCardCase1() throws Exception {
+		assertMatch("??", "a", false, true);
+	}
+
+	public void testVerySimpleWildCardCase2() throws Exception {
+		assertMatch("??", "ab", true, false);
+	}
+
+	public void testVerySimpleWildCardCase3() throws Exception {
+		assertMatch("??", "abc", false, false);
+	}
+
+	public void testVerySimpleStarCase0() throws Exception {
+		assertMatch("*", "", true, true);
+	}
+
+	public void testVerySimpleStarCase1() throws Exception {
+		assertMatch("*", "a", true, true);
+	}
+
+	public void testVerySimpleStarCase2() throws Exception {
+		assertMatch("*", "ab", true, true);
+	}
+
+	public void testSimpleStarCase0() throws Exception {
+		assertMatch("a*b", "a", false, true);
+	}
+
+	public void testSimpleStarCase1() throws Exception {
+		assertMatch("a*c", "ac", true, true);
+	}
+
+	public void testSimpleStarCase2() throws Exception {
+		assertMatch("a*c", "ab", false, true);
+	}
+
+	public void testSimpleStarCase3() throws Exception {
+		assertMatch("a*c", "abc", true, true);
+	}
+
+	public void testManySolutionsCase0() throws Exception {
+		assertMatch("a*a*a", "aaa", true, true);
+	}
+
+	public void testManySolutionsCase1() throws Exception {
+		assertMatch("a*a*a", "aaaa", true, true);
+	}
+
+	public void testManySolutionsCase2() throws Exception {
+		assertMatch("a*a*a", "ababa", true, true);
+	}
+
+	public void testManySolutionsCase3() throws Exception {
+		assertMatch("a*a*a", "aaaaaaaa", true, true);
+	}
+
+	public void testManySolutionsCase4() throws Exception {
+		assertMatch("a*a*a", "aaaaaaab", false, true);
+	}
+
+	public void testVerySimpleGroupCase0() throws Exception {
+		assertMatch("[ab]", "a", true, false);
+	}
+
+	public void testVerySimpleGroupCase1() throws Exception {
+		assertMatch("[ab]", "b", true, false);
+	}
+
+	public void testVerySimpleGroupCase2() throws Exception {
+		assertMatch("[ab]", "ab", false, false);
+	}
+
+	public void testVerySimpleGroupRangeCase0() throws Exception {
+		assertMatch("[b-d]", "a", false, false);
+	}
+
+	public void testVerySimpleGroupRangeCase1() throws Exception {
+		assertMatch("[b-d]", "b", true, false);
+	}
+
+	public void testVerySimpleGroupRangeCase2() throws Exception {
+		assertMatch("[b-d]", "c", true, false);
+	}
+
+	public void testVerySimpleGroupRangeCase3() throws Exception {
+		assertMatch("[b-d]", "d", true, false);
+	}
+
+	public void testVerySimpleGroupRangeCase4() throws Exception {
+		assertMatch("[b-d]", "e", false, false);
+	}
+
+	public void testVerySimpleGroupRangeCase5() throws Exception {
+		assertMatch("[b-d]", "-", false, false);
+	}
+
+	public void testTwoGroupsCase0() throws Exception {
+		assertMatch("[b-d][ab]", "bb", true, false);
+	}
+
+	public void testTwoGroupsCase1() throws Exception {
+		assertMatch("[b-d][ab]", "ca", true, false);
+	}
+
+	public void testTwoGroupsCase2() throws Exception {
+		assertMatch("[b-d][ab]", "fa", false, false);
+	}
+
+	public void testTwoGroupsCase3() throws Exception {
+		assertMatch("[b-d][ab]", "bc", false, false);
+	}
+
+	public void testTwoRangesInOneGroupCase0() throws Exception {
+		assertMatch("[b-ce-e]", "a", false, false);
+	}
+
+	public void testTwoRangesInOneGroupCase1() throws Exception {
+		assertMatch("[b-ce-e]", "b", true, false);
+	}
+
+	public void testTwoRangesInOneGroupCase2() throws Exception {
+		assertMatch("[b-ce-e]", "c", true, false);
+	}
+
+	public void testTwoRangesInOneGroupCase3() throws Exception {
+		assertMatch("[b-ce-e]", "d", false, false);
+	}
+
+	public void testTwoRangesInOneGroupCase4() throws Exception {
+		assertMatch("[b-ce-e]", "e", true, false);
+	}
+
+	public void testTwoRangesInOneGroupCase5() throws Exception {
+		assertMatch("[b-ce-e]", "f", false, false);
+	}
+
+	public void testIncompleteRangesInOneGroupCase0() throws Exception {
+		assertMatch("a[b-]", "ab", true, false);
+	}
+
+	public void testIncompleteRangesInOneGroupCase1() throws Exception {
+		assertMatch("a[b-]", "ac", false, false);
+	}
+
+	public void testIncompleteRangesInOneGroupCase2() throws Exception {
+		assertMatch("a[b-]", "a-", true, false);
+	}
+
+	public void testCombinedRangesInOneGroupCase0() throws Exception {
+		assertMatch("[a-c-e]", "b", true, false);
+	}
+
+	/**
+	 * The c belongs to the range a-c. "-e" is no valid range so d should=
 not
+	 * match.
+	 *=20
+	 * @throws Exception
+	 *             for some reasons
+	 */
+	public void testCombinedRangesInOneGroupCase1() throws Exception {
+		assertMatch("[a-c-e]", "d", false, false);
+	}
+
+	public void testCombinedRangesInOneGroupCase2() throws Exception {
+		assertMatch("[a-c-e]", "e", true, false);
+	}
+
+	public void testInversedGroupCase0() throws Exception {
+		assertMatch("[!b-c]", "a", true, false);
+	}
+
+	public void testInversedGroupCase1() throws Exception {
+		assertMatch("[!b-c]", "b", false, false);
+	}
+
+	public void testInversedGroupCase2() throws Exception {
+		assertMatch("[!b-c]", "c", false, false);
+	}
+
+	public void testInversedGroupCase3() throws Exception {
+		assertMatch("[!b-c]", "d", true, false);
+	}
+
+	public void testAlphaGroupCase0() throws Exception {
+		assertMatch("[[:alpha:]]", "d", true, false);
+	}
+
+	public void testAlphaGroupCase1() throws Exception {
+		assertMatch("[[:alpha:]]", ":", false, false);
+	}
+
+	public void testAlphaGroupCase2() throws Exception {
+		// \u00f6 =3D 'o' with dots on it
+		assertMatch("[[:alpha:]]", "\u00f6", true, false);
+	}
+
+	public void test2AlphaGroupsCase0() throws Exception {
+		// \u00f6 =3D 'o' with dots on it
+		assertMatch("[[:alpha:]][[:alpha:]]", "a\u00f6", true, false);
+		assertMatch("[[:alpha:]][[:alpha:]]", "a1", false, false);
+	}
+
+	public void testAlnumGroupCase0() throws Exception {
+		assertMatch("[[:alnum:]]", "a", true, false);
+	}
+
+	public void testAlnumGroupCase1() throws Exception {
+		assertMatch("[[:alnum:]]", "1", true, false);
+	}
+
+	public void testAlnumGroupCase2() throws Exception {
+		assertMatch("[[:alnum:]]", ":", false, false);
+	}
+
+	public void testBlankGroupCase0() throws Exception {
+		assertMatch("[[:blank:]]", " ", true, false);
+	}
+
+	public void testBlankGroupCase1() throws Exception {
+		assertMatch("[[:blank:]]", "\t", true, false);
+	}
+
+	public void testBlankGroupCase2() throws Exception {
+		assertMatch("[[:blank:]]", "\r", false, false);
+	}
+
+	public void testBlankGroupCase3() throws Exception {
+		assertMatch("[[:blank:]]", "\n", false, false);
+	}
+
+	public void testBlankGroupCase4() throws Exception {
+		assertMatch("[[:blank:]]", "a", false, false);
+	}
+
+	public void testCntrlGroupCase0() throws Exception {
+		assertMatch("[[:cntrl:]]", "a", false, false);
+	}
+
+	public void testCntrlGroupCase1() throws Exception {
+		assertMatch("[[:cntrl:]]", String.valueOf((char) 7), true, false);
+	}
+
+	public void testDigitGroupCase0() throws Exception {
+		assertMatch("[[:digit:]]", "0", true, false);
+	}
+
+	public void testDigitGroupCase1() throws Exception {
+		assertMatch("[[:digit:]]", "5", true, false);
+	}
+
+	public void testDigitGroupCase2() throws Exception {
+		assertMatch("[[:digit:]]", "9", true, false);
+	}
+
+	public void testDigitGroupCase3() throws Exception {
+		// \u06f9 =3D EXTENDED ARABIC-INDIC DIGIT NINE
+		assertMatch("[[:digit:]]", "\u06f9", true, false);
+	}
+
+	public void testDigitGroupCase4() throws Exception {
+		assertMatch("[[:digit:]]", "a", false, false);
+	}
+
+	public void testDigitGroupCase5() throws Exception {
+		assertMatch("[[:digit:]]", "]", false, false);
+	}
+
+	public void testGraphGroupCase0() throws Exception {
+		assertMatch("[[:graph:]]", "]", true, false);
+	}
+
+	public void testGraphGroupCase1() throws Exception {
+		assertMatch("[[:graph:]]", "a", true, false);
+	}
+
+	public void testGraphGroupCase2() throws Exception {
+		assertMatch("[[:graph:]]", ".", true, false);
+	}
+
+	public void testGraphGroupCase3() throws Exception {
+		assertMatch("[[:graph:]]", "0", true, false);
+	}
+
+	public void testGraphGroupCase4() throws Exception {
+		assertMatch("[[:graph:]]", " ", false, false);
+	}
+
+	public void testGraphGroupCase5() throws Exception {
+		// \u00f6 =3D 'o' with dots on it
+		assertMatch("[[:graph:]]", "\u00f6", true, false);
+	}
+
+	public void testLowerGroupCase0() throws Exception {
+		assertMatch("[[:lower:]]", "a", true, false);
+	}
+
+	public void testLowerGroupCase1() throws Exception {
+		assertMatch("[[:lower:]]", "h", true, false);
+	}
+
+	public void testLowerGroupCase2() throws Exception {
+		assertMatch("[[:lower:]]", "A", false, false);
+	}
+
+	public void testLowerGroupCase3() throws Exception {
+		assertMatch("[[:lower:]]", "H", false, false);
+	}
+
+	public void testLowerGroupCase4() throws Exception {
+		// \u00e4 =3D small 'a' with dots on it
+		assertMatch("[[:lower:]]", "\u00e4", true, false);
+	}
+
+	public void testLowerGroupCase5() throws Exception {
+		assertMatch("[[:lower:]]", ".", false, false);
+	}
+
+	public void testPrintGroupCase0() throws Exception {
+		assertMatch("[[:print:]]", "]", true, false);
+	}
+
+	public void testPrintGroupCase1() throws Exception {
+		assertMatch("[[:print:]]", "a", true, false);
+	}
+
+	public void testPrintGroupCase2() throws Exception {
+		assertMatch("[[:print:]]", ".", true, false);
+	}
+
+	public void testPrintGroupCase3() throws Exception {
+		assertMatch("[[:print:]]", "0", true, false);
+	}
+
+	public void testPrintGroupCase4() throws Exception {
+		assertMatch("[[:print:]]", " ", true, false);
+	}
+
+	public void testPrintGroupCase5() throws Exception {
+		// \u00f6 =3D 'o' with dots on it
+		assertMatch("[[:print:]]", "\u00f6", true, false);
+	}
+
+	public void testPunctGroupCase0() throws Exception {
+		assertMatch("[[:punct:]]", ".", true, false);
+	}
+
+	public void testPunctGroupCase1() throws Exception {
+		assertMatch("[[:punct:]]", "@", true, false);
+	}
+
+	public void testPunctGroupCase2() throws Exception {
+		assertMatch("[[:punct:]]", " ", false, false);
+	}
+
+	public void testPunctGroupCase3() throws Exception {
+		assertMatch("[[:punct:]]", "a", false, false);
+	}
+
+	public void testSpaceGroupCase0() throws Exception {
+		assertMatch("[[:space:]]", " ", true, false);
+	}
+
+	public void testSpaceGroupCase1() throws Exception {
+		assertMatch("[[:space:]]", "\t", true, false);
+	}
+
+	public void testSpaceGroupCase2() throws Exception {
+		assertMatch("[[:space:]]", "\r", true, false);
+	}
+
+	public void testSpaceGroupCase3() throws Exception {
+		assertMatch("[[:space:]]", "\n", true, false);
+	}
+
+	public void testSpaceGroupCase4() throws Exception {
+		assertMatch("[[:space:]]", "a", false, false);
+	}
+
+	public void testUpperGroupCase0() throws Exception {
+		assertMatch("[[:upper:]]", "a", false, false);
+	}
+
+	public void testUpperGroupCase1() throws Exception {
+		assertMatch("[[:upper:]]", "h", false, false);
+	}
+
+	public void testUpperGroupCase2() throws Exception {
+		assertMatch("[[:upper:]]", "A", true, false);
+	}
+
+	public void testUpperGroupCase3() throws Exception {
+		assertMatch("[[:upper:]]", "H", true, false);
+	}
+
+	public void testUpperGroupCase4() throws Exception {
+		// \u00c4 =3D 'A' with dots on it
+		assertMatch("[[:upper:]]", "\u00c4", true, false);
+	}
+
+	public void testUpperGroupCase5() throws Exception {
+		assertMatch("[[:upper:]]", ".", false, false);
+	}
+
+	public void testXDigitGroupCase0() throws Exception {
+		assertMatch("[[:xdigit:]]", "a", true, false);
+	}
+
+	public void testXDigitGroupCase1() throws Exception {
+		assertMatch("[[:xdigit:]]", "d", true, false);
+	}
+
+	public void testXDigitGroupCase2() throws Exception {
+		assertMatch("[[:xdigit:]]", "f", true, false);
+	}
+
+	public void testXDigitGroupCase3() throws Exception {
+		assertMatch("[[:xdigit:]]", "0", true, false);
+	}
+
+	public void testXDigitGroupCase4() throws Exception {
+		assertMatch("[[:xdigit:]]", "5", true, false);
+	}
+
+	public void testXDigitGroupCase5() throws Exception {
+		assertMatch("[[:xdigit:]]", "9", true, false);
+	}
+
+	public void testXDigitGroupCase6() throws Exception {
+		assertMatch("[[:xdigit:]]", "=DB=B9", false, false);
+	}
+
+	public void testXDigitGroupCase7() throws Exception {
+		assertMatch("[[:xdigit:]]", ".", false, false);
+	}
+
+	public void testWordroupCase0() throws Exception {
+		assertMatch("[[:word:]]", "g", true, false);
+	}
+
+	public void testWordroupCase1() throws Exception {
+		// \u00f6 =3D 'o' with dots on it
+		assertMatch("[[:word:]]", "\u00f6", true, false);
+	}
+
+	public void testWordroupCase2() throws Exception {
+		assertMatch("[[:word:]]", "5", true, false);
+	}
+
+	public void testWordroupCase3() throws Exception {
+		assertMatch("[[:word:]]", "_", true, false);
+	}
+
+	public void testWordroupCase4() throws Exception {
+		assertMatch("[[:word:]]", " ", false, false);
+	}
+
+	public void testWordroupCase5() throws Exception {
+		assertMatch("[[:word:]]", ".", false, false);
+	}
+
+	public void testMixedGroupCase0() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", "A", true, false);
+	}
+
+	public void testMixedGroupCase1() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", "C", true, false);
+	}
+
+	public void testMixedGroupCase2() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", "e", true, false);
+	}
+
+	public void testMixedGroupCase3() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", "3", true, false);
+	}
+
+	public void testMixedGroupCase4() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", "4", true, false);
+	}
+
+	public void testMixedGroupCase5() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", "5", true, false);
+	}
+
+	public void testMixedGroupCase6() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", "B", false, false);
+	}
+
+	public void testMixedGroupCase7() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", "2", false, false);
+	}
+
+	public void testMixedGroupCase8() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", "6", false, false);
+	}
+
+	public void testMixedGroupCase9() throws Exception {
+		assertMatch("[A[:lower:]C3-5]", ".", false, false);
+	}
+
+	public void testSpecialGroupCase0() throws Exception {
+		assertMatch("[[]", "[", true, false);
+	}
+
+	public void testSpecialGroupCase1() throws Exception {
+		assertMatch("[]]", "]", true, false);
+	}
+
+	public void testSpecialGroupCase2() throws Exception {
+		assertMatch("[]a]", "]", true, false);
+	}
+
+	public void testSpecialGroupCase3() throws Exception {
+		assertMatch("[a[]", "[", true, false);
+	}
+
+	public void testSpecialGroupCase4() throws Exception {
+		assertMatch("[a[]", "a", true, false);
+	}
+
+	public void testSpecialGroupCase5() throws Exception {
+		assertMatch("[!]]", "]", false, false);
+	}
+
+	public void testSpecialGroupCase6() throws Exception {
+		assertMatch("[!]]", "x", true, false);
+	}
+
+	public void testSpecialGroupCase7() throws Exception {
+		assertMatch("[:]]", ":]", true, false);
+	}
+
+	public void testSpecialGroupCase8() throws Exception {
+		assertMatch("[:]]", ":", false, true);
+	}
+
+	public void testSpecialGroupCase9() throws Exception {
+		try {
+			assertMatch("[[:]", ":", true, true);
+			fail("InvalidPatternException expected");
+		} catch (InvalidPatternException e) {
+			// expected
+		}
+	}
+
+	public void testUnsupportedGroupCase0() throws Exception {
+		try {
+			assertMatch("[[=3Da=3D]]", "b", false, false);
+			fail("InvalidPatternException expected");
+		} catch (InvalidPatternException e) {
+			assertTrue(e.getMessage().contains("[=3Da=3D]"));
+		}
+	}
+
+	public void testUnsupportedGroupCase1() throws Exception {
+		try {
+			assertMatch("[[.a.]]", "b", false, false);
+			fail("InvalidPatternException expected");
+		} catch (InvalidPatternException e) {
+			assertTrue(e.getMessage().contains("[.a.]"));
+		}
+	}
+
+	public void testFilePathSimpleCase() throws Exception {
+		assertFileNameMatch("a/b", "a/b", '/', true, false);
+	}
+
+	public void testFilePathCase0() throws Exception {
+		assertFileNameMatch("a*b", "a/b", '/', false, false);
+	}
+
+	public void testFilePathCase1() throws Exception {
+		assertFileNameMatch("a?b", "a/b", '/', false, false);
+	}
+
+	public void testFilePathCase2() throws Exception {
+		assertFileNameMatch("a*b", "a\\b", '\\', false, false);
+	}
+
+	public void testFilePathCase3() throws Exception {
+		assertFileNameMatch("a?b", "a\\b", '\\', false, false);
+	}
+
+	public void testReset() throws Exception {
+		final String pattern =3D "helloworld";
+		final FileNameMatcher matcher =3D new FileNameMatcher(pattern, null)=
;
+		matcher.append("helloworld");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		matcher.reset();
+		matcher.append("hello");
+		assertEquals(false, matcher.isMatch());
+		assertEquals(true, matcher.canAppendMatch());
+		matcher.append("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		matcher.append("to much");
+		assertEquals(false, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		matcher.reset();
+		matcher.append("helloworld");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+	}
+
+	public void testCreateMatcherForSuffix() throws Exception {
+		final String pattern =3D "helloworld";
+		final FileNameMatcher matcher =3D new FileNameMatcher(pattern, null)=
;
+		matcher.append("hello");
+		final FileNameMatcher childMatcher =3D matcher.createMatcherForSuffi=
x();
+		assertEquals(false, matcher.isMatch());
+		assertEquals(true, matcher.canAppendMatch());
+		assertEquals(false, childMatcher.isMatch());
+		assertEquals(true, childMatcher.canAppendMatch());
+		matcher.append("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		assertEquals(false, childMatcher.isMatch());
+		assertEquals(true, childMatcher.canAppendMatch());
+		childMatcher.append("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		assertEquals(true, childMatcher.isMatch());
+		assertEquals(false, childMatcher.canAppendMatch());
+		childMatcher.reset();
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		assertEquals(false, childMatcher.isMatch());
+		assertEquals(true, childMatcher.canAppendMatch());
+		childMatcher.append("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(false, matcher.canAppendMatch());
+		assertEquals(true, childMatcher.isMatch());
+		assertEquals(false, childMatcher.canAppendMatch());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatter=
nException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidP=
atternException.java
new file mode 100644
index 0000000..02f67fe
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatternExcept=
ion.java
@@ -0,0 +1,65 @@
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
+package org.spearce.jgit.errors;
+
+/**
+ * Thrown when a pattern passed in an argument was wrong.
+ *=20
+ */
+public class InvalidPatternException extends Exception {
+	private final String pattern;
+
+	/**
+	 * @param message
+	 *            explains what was wrong with the pattern.
+	 * @param pattern
+	 *            the invalid pattern.
+	 */
+	public InvalidPatternException(String message, String pattern) {
+		super(message);
+		this.pattern =3D pattern;
+	}
+
+	/**
+	 * @return the invalid pattern.
+	 */
+	public String getPattern() {
+		return pattern;
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBrac=
ketException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/NoClos=
ingBracketException.java
new file mode 100644
index 0000000..1a93906
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBracketExce=
ption.java
@@ -0,0 +1,69 @@
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
+package org.spearce.jgit.errors;
+
+/**
+ * Thrown when a pattern contains a character group which is open to t=
he right
+ * side or a character class which is open to the right side.
+ */
+public class NoClosingBracketException extends InvalidPatternException=
 {
+
+	/**
+	 * @param indexOfOpeningBracket
+	 *            the position of the [ character which has no ] characte=
r.
+	 * @param openingBracket
+	 *            the unclosed bracket.
+	 * @param closingBracket
+	 *            the missing closing bracket.
+	 * @param pattern
+	 *            the invalid pattern.
+	 */
+	public NoClosingBracketException(final int indexOfOpeningBracket,
+			final String openingBracket, final String closingBracket,
+			final String pattern) {
+		super(createMessage(indexOfOpeningBracket, openingBracket,
+				closingBracket), pattern);
+	}
+
+	private static String createMessage(final int indexOfOpeningBracket,
+			final String openingBracket, final String closingBracket) {
+		return String.format("No closing %s found for %s at index %s.",
+				closingBracket, openingBracket, new Integer(
+						indexOfOpeningBracket));
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/AbstractHead=
=2Ejava b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/AbstractHead.ja=
va
new file mode 100644
index 0000000..1e9a0ca
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/AbstractHead.java
@@ -0,0 +1,74 @@
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
+package org.spearce.jgit.fnmatch;
+
+import java.util.List;
+
+abstract class AbstractHead implements Head {
+	private List<Head> newHeads =3D null;
+
+	private final boolean star;
+
+	protected abstract boolean matches(char c);
+
+	AbstractHead(boolean star) {
+		this.star =3D star;
+	}
+
+	/**
+	 *=20
+	 * @param newHeads
+	 *            a list of {@link Head}s which will not be modified.
+	 */
+	public final void setNewHeads(List<Head> newHeads) {
+		if (this.newHeads !=3D null)
+			throw new IllegalStateException("Property is already non null");
+		this.newHeads =3D newHeads;
+	}
+
+	public List<Head> getNextHeads(char c) {
+		if (matches(c))
+			return newHeads;
+		else
+			return FileNameMatcher.EMPTY_HEAD_LIST;
+	}
+
+	boolean isStar() {
+		return star;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/CharacterHea=
d.java b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/CharacterHead.ja=
va
new file mode 100644
index 0000000..01c3403
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/CharacterHead.java
@@ -0,0 +1,53 @@
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
+package org.spearce.jgit.fnmatch;
+
+final class CharacterHead extends AbstractHead {
+	private final char expectedCharacter;
+
+	protected CharacterHead(final char expectedCharacter) {
+		super(false);
+		this.expectedCharacter =3D expectedCharacter;
+	}
+
+	@Override
+	protected final boolean matches(final char c) {
+		return c =3D=3D expectedCharacter;
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/FileNameMatc=
her.java b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/FileNameMatche=
r.java
new file mode 100644
index 0000000..30a5930
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/FileNameMatcher.jav=
a
@@ -0,0 +1,351 @@
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
+package org.spearce.jgit.fnmatch;
+
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.List;
+import java.util.ListIterator;
+import java.util.regex.Matcher;
+import java.util.regex.Pattern;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.NoClosingBracketException;
+
+/**
+ * This class can be used to match filenames against fnmatch like patt=
erns. It
+ * is not thread save.
+ * <p>
+ * Supported are the wildcard characters * and ? and groups with:
+ * <ul>
+ * <li> characters e.g. [abc]</li>
+ * <li> ranges e.g. [a-z]</li>
+ * <li> the following character classes
+ * <ul>
+ * <li>[:alnum:]</li>
+ * <li>[:alpha:]</li>
+ * <li>[:blank:]</li>
+ * <li>[:cntrl:]</li>
+ * <li>[:digit:]</li>
+ * <li>[:graph:]</li>
+ * <li>[:lower:]</li>
+ * <li>[:print:]</li>
+ * <li>[:punct:]</li>
+ * <li>[:space:]</li>
+ * <li>[:upper:]</li>
+ * <li>[:word:]</li>
+ * <li>[:xdigit:]</li>
+ * </ul>
+ * e. g. [[:xdigit:]] </li>
+ * </ul>
+ * </p>
+ */
+public class FileNameMatcher {
+	static final List<Head> EMPTY_HEAD_LIST =3D Collections.emptyList();
+
+	private static final Pattern characterClassStartPattern =3D Pattern
+			.compile("\\[[.:=3D]");
+
+	private List<Head> headsStartValue;
+
+	private List<Head> heads;
+
+	/**
+	 * {{@link #extendStringToMatchByOneCharacter(char)} needs a list for=
 the
+	 * new heads, allocating a new array would be bad for the performance=
, as
+	 * the method gets called very often.
+	 *=20
+	 */
+	private List<Head> listForLocalUseage;
+
+	/**
+	 *=20
+	 * @param headsStartValue
+	 *            must be a list which will never be modified.
+	 */
+	private FileNameMatcher(final List<Head> headsStartValue) {
+		this.headsStartValue =3D headsStartValue;
+		this.heads =3D new ArrayList<Head>(headsStartValue.size());
+		this.heads.addAll(this.headsStartValue);
+		this.listForLocalUseage =3D new ArrayList<Head>(headsStartValue.size=
());
+	}
+
+	/**
+	 * @param patternString
+	 *            must contain a pattern which fnmatch would accept.
+	 * @param invalidWildgetCharacter
+	 *            if this parameter isn't null then this character will n=
ot
+	 *            match at wildcards(* and ? are wildcards).
+	 * @throws InvalidPatternException
+	 *             if the patternString contains a invalid fnmatch patter=
n.
+	 */
+	public FileNameMatcher(final String patternString,
+			final Character invalidWildgetCharacter)
+			throws InvalidPatternException {
+		this(createHeadsStartValues(patternString, invalidWildgetCharacter))=
;
+	}
+
+	private static List<Head> createHeadsStartValues(
+			final String patternString, final Character invalidWildgetCharacter=
)
+			throws InvalidPatternException {
+
+		final List<AbstractHead> allHeads =3D parseHeads(patternString,
+				invalidWildgetCharacter);
+
+		List<Head> nextHeadsSuggestion =3D new ArrayList<Head>(2);
+		nextHeadsSuggestion.add(LastHead.INSTANCE);
+		for (int i =3D allHeads.size() - 1; i >=3D 0; i--) {
+			final AbstractHead head =3D allHeads.get(i);
+
+			// explanation:
+			// a and * of the pattern "a*b"
+			// need *b as newHeads
+			// that's why * extends the list for it self and it's left neighbor=
=2E
+			if (head.isStar()) {
+				nextHeadsSuggestion.add(head);
+				head.setNewHeads(nextHeadsSuggestion);
+			} else {
+				head.setNewHeads(nextHeadsSuggestion);
+				nextHeadsSuggestion =3D new ArrayList<Head>(2);
+				nextHeadsSuggestion.add(head);
+			}
+		}
+		return nextHeadsSuggestion;
+	}
+
+	private static int findGroupEnd(final int indexOfStartBracket,
+			final String pattern) throws InvalidPatternException {
+		int firstValidCharClassIndex =3D indexOfStartBracket + 1;
+		int firstValidEndBracketIndex =3D indexOfStartBracket + 2;
+
+		if (indexOfStartBracket + 1 >=3D pattern.length())
+			throw new NoClosingBracketException(indexOfStartBracket, "[", "]",
+					pattern);
+
+		if (pattern.charAt(firstValidCharClassIndex) =3D=3D '!') {
+			firstValidCharClassIndex++;
+			firstValidEndBracketIndex++;
+		}
+
+		final Matcher charClassStartMatcher =3D characterClassStartPattern
+				.matcher(pattern);
+
+		int groupEnd =3D -1;
+		while (groupEnd =3D=3D -1) {
+
+			final int possibleGroupEnd =3D pattern.indexOf(']',
+					firstValidEndBracketIndex);
+			if (possibleGroupEnd =3D=3D -1)
+				throw new NoClosingBracketException(indexOfStartBracket, "[",
+						"]", pattern);
+
+			final boolean foundCharClass =3D charClassStartMatcher
+					.find(firstValidCharClassIndex);
+
+			if (foundCharClass
+					&& charClassStartMatcher.start() < possibleGroupEnd) {
+
+				final String classStart =3D charClassStartMatcher.group(0);
+				final String classEnd =3D classStart.charAt(1) + "]";
+
+				final int classStartIndex =3D charClassStartMatcher.start();
+				final int classEndIndex =3D pattern.indexOf(classEnd,
+						classStartIndex + 2);
+
+				if (classEndIndex =3D=3D -1)
+					throw new NoClosingBracketException(classStartIndex,
+							classStart, classEnd, pattern);
+
+				firstValidCharClassIndex =3D classEndIndex + 2;
+				firstValidEndBracketIndex =3D firstValidCharClassIndex;
+			} else {
+				groupEnd =3D possibleGroupEnd;
+			}
+		}
+		return groupEnd;
+	}
+
+	private static List<AbstractHead> parseHeads(final String pattern,
+			final Character invalidWildgetCharacter)
+			throws InvalidPatternException {
+
+		int currentIndex =3D 0;
+		List<AbstractHead> heads =3D new ArrayList<AbstractHead>();
+		while (currentIndex < pattern.length()) {
+			final int groupStart =3D pattern.indexOf('[', currentIndex);
+			if (groupStart =3D=3D -1) {
+				final String patternPart =3D pattern.substring(currentIndex);
+				heads.addAll(createSimpleHeads(patternPart,
+						invalidWildgetCharacter));
+				currentIndex =3D pattern.length();
+			} else {
+				final String patternPart =3D pattern.substring(currentIndex,
+						groupStart);
+				heads.addAll(createSimpleHeads(patternPart,
+						invalidWildgetCharacter));
+
+				final int groupEnd =3D findGroupEnd(groupStart, pattern);
+				final String groupPart =3D pattern.substring(groupStart + 1,
+						groupEnd);
+				heads.add(new GroupHead(groupPart, pattern));
+				currentIndex =3D groupEnd + 1;
+			}
+		}
+		return heads;
+	}
+
+	private static List<AbstractHead> createSimpleHeads(
+			final String patternPart, final Character invalidWildgetCharacter) =
{
+		final List<AbstractHead> heads =3D new ArrayList<AbstractHead>(
+				patternPart.length());
+		for (int i =3D 0; i < patternPart.length(); i++) {
+			final char c =3D patternPart.charAt(i);
+			switch (c) {
+			case '*': {
+				final AbstractHead head =3D createWildCardHead(
+						invalidWildgetCharacter, true);
+				heads.add(head);
+				break;
+			}
+			case '?': {
+				final AbstractHead head =3D createWildCardHead(
+						invalidWildgetCharacter, false);
+				heads.add(head);
+				break;
+			}
+			default:
+				final CharacterHead head =3D new CharacterHead(c);
+				heads.add(head);
+			}
+		}
+		return heads;
+	}
+
+	private static AbstractHead createWildCardHead(
+			final Character invalidWildgetCharacter, final boolean star) {
+		if (invalidWildgetCharacter !=3D null)
+			return new RestrictedWildCardHead(invalidWildgetCharacter
+					.charValue(), star);
+		else
+			return new WildCardHead(star);
+	}
+
+	private void extendStringToMatchByOneCharacter(final char c) {
+		final List<Head> newHeads =3D listForLocalUseage;
+		newHeads.clear();
+		List<Head> lastAddedHeads =3D null;
+		for (int i =3D 0; i < heads.size(); i++) {
+			final Head head =3D heads.get(i);
+			final List<Head> headsToAdd =3D head.getNextHeads(c);
+			// Why the next performance optimization isn't wrong:
+			// Some times two heads return the very same list.
+			// We save future effort if we don't add these heads again.
+			// This is the case with the heads "a" and "*" of "a*b" which
+			// both can return the list ["*","b"]
+			if (headsToAdd !=3D lastAddedHeads) {
+				newHeads.addAll(headsToAdd);
+				lastAddedHeads =3D headsToAdd;
+			}
+		}
+		listForLocalUseage =3D heads;
+		heads =3D newHeads;
+	}
+
+	/**
+	 *=20
+	 * @param stringToMatch
+	 *            extends the string which is matched against the pattern=
s of
+	 *            this class.
+	 */
+	public void append(final String stringToMatch) {
+		for (int i =3D 0; i < stringToMatch.length(); i++) {
+			final char c =3D stringToMatch.charAt(i);
+			extendStringToMatchByOneCharacter(c);
+		}
+	}
+
+	/**
+	 * Resets this matcher to it's state right after construction.
+	 */
+	public void reset() {
+		heads.clear();
+		heads.addAll(headsStartValue);
+	}
+
+	/**
+	 *=20
+	 * @return a {@link FileNameMatcher} instance which uses the same pat=
tern
+	 *         like this matcher, but has the current state of this match=
er as
+	 *         reset and start point.
+	 */
+	public FileNameMatcher createMatcherForSuffix() {
+		final List<Head> copyOfHeads =3D new ArrayList<Head>(heads.size());
+		copyOfHeads.addAll(heads);
+		return new FileNameMatcher(copyOfHeads);
+	}
+
+	/**
+	 *=20
+	 * @return true, if the string currently being matched does match.
+	 */
+	public boolean isMatch() {
+		final ListIterator<Head> headIterator =3D heads
+				.listIterator(heads.size());
+		while (headIterator.hasPrevious()) {
+			final Head head =3D headIterator.previous();
+			if (head =3D=3D LastHead.INSTANCE) {
+				return true;
+			}
+		}
+		return false;
+	}
+
+	/**
+	 *=20
+	 * @return false, if the string being matched will not match when the=
 string
+	 *         gets extended.
+	 */
+	public boolean canAppendMatch() {
+		for (int i =3D 0; i < heads.size(); i++) {
+			if (heads.get(i) !=3D LastHead.INSTANCE) {
+				return true;
+			}
+		}
+		return false;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/GroupHead.ja=
va b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/GroupHead.java
new file mode 100644
index 0000000..9f72010
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/GroupHead.java
@@ -0,0 +1,220 @@
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
+package org.spearce.jgit.fnmatch;
+
+import java.util.ArrayList;
+import java.util.List;
+import java.util.regex.Matcher;
+import java.util.regex.Pattern;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+
+final class GroupHead extends AbstractHead {
+	private final List<CharacterPattern> characterClasses;
+
+	private static final Pattern REGEX_PATTERN =3D Pattern
+			.compile("([^-][-][^-]|\\[[.:=3D].*?[.:=3D]\\])");
+
+	private final boolean inverse;
+
+	GroupHead(String pattern, final String wholePattern)
+			throws InvalidPatternException {
+		super(false);
+		this.characterClasses =3D new ArrayList<CharacterPattern>();
+		this.inverse =3D pattern.startsWith("!");
+		if (inverse) {
+			pattern =3D pattern.substring(1);
+		}
+		final Matcher matcher =3D REGEX_PATTERN.matcher(pattern);
+		while (matcher.find()) {
+			final String characterClass =3D matcher.group(0);
+			if (characterClass.length() =3D=3D 3 && characterClass.charAt(1) =3D=
=3D '-') {
+				final char start =3D characterClass.charAt(0);
+				final char end =3D characterClass.charAt(2);
+				characterClasses.add(new CharacterRange(start, end));
+			} else if (characterClass.equals("[:alnum:]")) {
+				characterClasses.add(LetterPattern.INSTANCE);
+				characterClasses.add(DigitPattern.INSTANCE);
+			} else if (characterClass.equals("[:alpha:]")) {
+				characterClasses.add(LetterPattern.INSTANCE);
+			} else if (characterClass.equals("[:blank:]")) {
+				characterClasses.add(new OneCharacterPattern(' '));
+				characterClasses.add(new OneCharacterPattern('\t'));
+			} else if (characterClass.equals("[:cntrl:]")) {
+				characterClasses.add(new CharacterRange('\u0000', '\u001F'));
+				characterClasses.add(new OneCharacterPattern('\u007F'));
+			} else if (characterClass.equals("[:digit:]")) {
+				characterClasses.add(DigitPattern.INSTANCE);
+			} else if (characterClass.equals("[:graph:]")) {
+				characterClasses.add(new CharacterRange('\u0021', '\u007E'));
+				characterClasses.add(LetterPattern.INSTANCE);
+				characterClasses.add(DigitPattern.INSTANCE);
+			} else if (characterClass.equals("[:lower:]")) {
+				characterClasses.add(LowerPattern.INSTANCE);
+			} else if (characterClass.equals("[:print:]")) {
+				characterClasses.add(new CharacterRange('\u0020', '\u007E'));
+				characterClasses.add(LetterPattern.INSTANCE);
+				characterClasses.add(DigitPattern.INSTANCE);
+			} else if (characterClass.equals("[:punct:]")) {
+				characterClasses.add(PunctPattern.INSTANCE);
+			} else if (characterClass.equals("[:space:]")) {
+				characterClasses.add(WhitespacePattern.INSTANCE);
+			} else if (characterClass.equals("[:upper:]")) {
+				characterClasses.add(UpperPattern.INSTANCE);
+			} else if (characterClass.equals("[:xdigit:]")) {
+				characterClasses.add(new CharacterRange('0', '9'));
+				characterClasses.add(new CharacterRange('a', 'f'));
+				characterClasses.add(new CharacterRange('A', 'F'));
+			} else if (characterClass.equals("[:word:]")) {
+				characterClasses.add(new OneCharacterPattern('_'));
+				characterClasses.add(LetterPattern.INSTANCE);
+				characterClasses.add(DigitPattern.INSTANCE);
+			} else {
+				final String message =3D String.format(
+						"The character class %s is not supported.",
+						characterClass);
+				throw new InvalidPatternException(message, wholePattern);
+			}
+
+			pattern =3D matcher.replaceFirst("");
+			matcher.reset(pattern);
+		}
+		// pattern contains now no ranges
+		for (int i =3D 0; i < pattern.length(); i++) {
+			final char c =3D pattern.charAt(i);
+			characterClasses.add(new OneCharacterPattern(c));
+		}
+	}
+
+	@Override
+	protected final boolean matches(final char c) {
+		for (CharacterPattern pattern : characterClasses) {
+			if (pattern.matches(c)) {
+				return !inverse;
+			}
+		}
+		return inverse;
+	}
+
+	private interface CharacterPattern {
+		/**
+		 * @param c
+		 *            the character to test
+		 * @return returns true if the character matches a pattern.
+		 */
+		boolean matches(char c);
+	}
+
+	private static final class CharacterRange implements CharacterPattern=
 {
+		private final char start;
+
+		private final char end;
+
+		CharacterRange(char start, char end) {
+			this.start =3D start;
+			this.end =3D end;
+		}
+
+		public final boolean matches(char c) {
+			return start <=3D c && c <=3D end;
+		}
+	}
+
+	private static final class DigitPattern implements CharacterPattern {
+		static final GroupHead.DigitPattern INSTANCE =3D new DigitPattern();
+
+		public final boolean matches(char c) {
+			return Character.isDigit(c);
+		}
+	}
+
+	private static final class LetterPattern implements CharacterPattern =
{
+		static final GroupHead.LetterPattern INSTANCE =3D new LetterPattern(=
);
+
+		public final boolean matches(char c) {
+			return Character.isLetter(c);
+		}
+	}
+
+	private static final class LowerPattern implements CharacterPattern {
+		static final GroupHead.LowerPattern INSTANCE =3D new LowerPattern();
+
+		public final boolean matches(char c) {
+			return Character.isLowerCase(c);
+		}
+	}
+
+	private static final class UpperPattern implements CharacterPattern {
+		static final GroupHead.UpperPattern INSTANCE =3D new UpperPattern();
+
+		public final boolean matches(char c) {
+			return Character.isUpperCase(c);
+		}
+	}
+
+	private static final class WhitespacePattern implements CharacterPatt=
ern {
+		static final GroupHead.WhitespacePattern INSTANCE =3D new Whitespace=
Pattern();
+
+		public final boolean matches(char c) {
+			return Character.isWhitespace(c);
+		}
+	}
+
+	private static final class OneCharacterPattern implements CharacterPa=
ttern {
+		private char expectedCharacter;
+
+		OneCharacterPattern(final char c) {
+			this.expectedCharacter =3D c;
+		}
+
+		public final boolean matches(char c) {
+			return this.expectedCharacter =3D=3D c;
+		}
+	}
+
+	private static final class PunctPattern implements CharacterPattern {
+		static final GroupHead.PunctPattern INSTANCE =3D new PunctPattern();
+
+		private static String punctCharacters =3D "-!\"#$%&'()*+,./:;<=3D>?@=
[\\]_`{|}~";
+
+		public boolean matches(char c) {
+			return punctCharacters.indexOf(c) !=3D -1;
+		}
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/Head.java b/=
org.spearce.jgit/src/org/spearce/jgit/fnmatch/Head.java
new file mode 100644
index 0000000..498f96c
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/Head.java
@@ -0,0 +1,50 @@
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
+package org.spearce.jgit.fnmatch;
+
+import java.util.List;
+
+interface Head {
+	/**
+	 *=20
+	 * @param c
+	 *            the character which decides which heads are returned.
+	 * @return a list of heads based on the input.
+	 */
+	public abstract List<Head> getNextHeads(char c);
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/LastHead.jav=
a b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/LastHead.java
new file mode 100644
index 0000000..d3c9813
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/LastHead.java
@@ -0,0 +1,56 @@
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
+package org.spearce.jgit.fnmatch;
+
+import java.util.List;
+
+final class LastHead implements Head {
+	static final Head INSTANCE =3D new LastHead();
+
+	/**
+	 * Don't call this constructor, use {@link #INSTANCE}
+	 */
+	private LastHead() {
+		// defined because of javadoc and visibility modifier.
+	}
+
+	public List<Head> getNextHeads(char c) {
+		return FileNameMatcher.EMPTY_HEAD_LIST;
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/RestrictedWi=
ldCardHead.java b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/Restric=
tedWildCardHead.java
new file mode 100644
index 0000000..9d8d277
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/RestrictedWildCardH=
ead.java
@@ -0,0 +1,52 @@
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
+package org.spearce.jgit.fnmatch;
+
+final class RestrictedWildCardHead extends AbstractHead {
+	private final char excludedCharacter;
+
+	RestrictedWildCardHead(final char excludedCharacter, final boolean st=
ar) {
+		super(star);
+		this.excludedCharacter =3D excludedCharacter;
+	}
+
+	@Override
+	protected final boolean matches(final char c) {
+		return c !=3D excludedCharacter;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/fnmatch/WildCardHead=
=2Ejava b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/WildCardHead.ja=
va
new file mode 100644
index 0000000..570e374
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/fnmatch/WildCardHead.java
@@ -0,0 +1,49 @@
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
+package org.spearce.jgit.fnmatch;
+
+final class WildCardHead extends AbstractHead {
+	WildCardHead(boolean star) {
+		super(star);
+	}
+
+	@Override
+	protected final boolean matches(final char c) {
+		return true;
+	}
+}
--=20
1.5.4.3
