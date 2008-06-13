From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 14/24] Added class AddRulesFactory.
Date: Fri, 13 Jun 2008 20:35:11 +0200
Message-ID: <1213382121-19786-14-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAT-0005zA-3S
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbYFMSgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:36:09 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbYFMSgH
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:36:07 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41970 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYFMSfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:31 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id B4C62DFAF701
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:30 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7W-0000eI-00; Fri, 13 Jun 2008 20:35:30 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18C9sKxPSqfuLrkjvtU92aJW4rN+YS4gt3Drsm1
	2lKvzFwgGE5K+kCQpKpi90Abds2K1+heQtyDZuHhdqA4gaU9hJ
	wT3p7XiM0bgBqeqET56w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84925>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/AddRulesFactory.java       |  127 ++++++++++++=
++++++++
 1 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/AddRulesFactory.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRu=
lesFactory.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/=
AddRulesFactory.java
new file mode 100644
index 0000000..767b5c7
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/AddRulesFact=
ory.java
@@ -0,0 +1,127 @@
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
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.List;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.PathNotInProjectDirectoryException;
+import static org.spearce.jgit.lib.Constants.REPOSITORY_DIRECTORY_NAME=
;
+
+/**
+ * This class is designed to serve the needs of someone who want to im=
plement a
+ * git-add command and needs to determine the files to add.
+ *=20
+ */
+public class AddRulesFactory {
+	private final RuleListToObjectConverter converter =3D new RuleListToO=
bjectConverter();
+
+	private final IgnoreRuleListFactory ignoreRuleListFactory =3D new Ign=
oreRuleListFactory();
+
+	private final AddRuleListFactory addRuleListFactory =3D new AddRuleLi=
stFactory();
+
+	/**
+	 * @param workTreeDirectory
+	 *            The directory with the files of the project under versi=
on
+	 *            control.
+	 * @param workingDirectory
+	 *            a directory within the workTreeDirectory.
+	 * @param filePatternsOfAddCommand
+	 *            the file patterns passed to the add command.
+	 * @return a {@link Rules} containing the specified rules, the .gitig=
nore
+	 *         and the .git/info/exclude rules.
+	 * @throws InvalidPatternException
+	 *             if a pattern is invalid.
+	 * @throws PathNotInProjectDirectoryException
+	 *             if the directory workingDirectory is not in workTreeDi=
rectory
+	 * @throws IOException
+	 *             for some reasons.
+	 */
+	public Rules createRules(File workTreeDirectory, File workingDirector=
y,
+			List<String> filePatternsOfAddCommand)
+			throws InvalidPatternException, PathNotInProjectDirectoryException,
+			IOException {
+		final Rule gitDirectoryIgnoreRule =3D createGitDirectoryIgnoreRule()=
;
+		final File gitDirectory =3D new File(workTreeDirectory,
+				REPOSITORY_DIRECTORY_NAME);
+		final List<Rule> ignoreRuleListFromFiles =3D createExcludeRules(
+				workTreeDirectory, gitDirectory);
+		final List<Rule> includeRules =3D addRuleListFactory.createRuleList(
+				workTreeDirectory, workingDirectory, filePatternsOfAddCommand);
+		final List<Rule> ruleList =3D new ArrayList<Rule>();
+
+		ruleList.add(gitDirectoryIgnoreRule);
+		ruleList.addAll(ignoreRuleListFromFiles);
+		ruleList.addAll(includeRules);
+		ruleList.add(new Rule(true, FilePattern.MATCH_ALWAYS));
+
+		return converter.createIgnoreRules(ruleList.iterator());
+	}
+
+	private List<Rule> createExcludeRules(File projectDirectory,
+			File gitDirectory) throws InvalidPatternException {
+		final List<File> possibleIgnoreFiles =3D new ArrayList<File>(2);
+		possibleIgnoreFiles.add(new File(projectDirectory, ".gitignore"));
+		possibleIgnoreFiles.add(new File(new File(gitDirectory, "info"),
+				"exclude"));
+
+		final List<File> ignoreFiles =3D new ArrayList<File>();
+		for (File possibleIgnoreFile : possibleIgnoreFiles) {
+			if (possibleIgnoreFile.isFile()) {
+				ignoreFiles.add(possibleIgnoreFile);
+			}
+		}
+
+		try {
+			return ignoreRuleListFactory.createIgnoreRuleList(ignoreFiles);
+		} catch (FileNotFoundException e) {
+			throw new RuntimeException("unexpected removal of ignore files", e)=
;
+		}
+	}
+
+	private Rule createGitDirectoryIgnoreRule() throws InvalidPatternExce=
ption {
+		final FilePattern gitDirectoryPattern =3D new FilePathPattern(
+				REPOSITORY_DIRECTORY_NAME, true, true);
+		final Rule gitDirectoryIgnoreRule =3D new Rule(true, gitDirectoryPat=
tern);
+		return gitDirectoryIgnoreRule;
+	}
+}
--=20
1.5.4.3
