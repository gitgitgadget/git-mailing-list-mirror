From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 02/24] Added the interface FilePattern.
Date: Fri, 13 Jun 2008 20:34:59 +0200
Message-ID: <1213382121-19786-2-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7E8O-0005Da-Ry
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbYFMSf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:35:28 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYFMSf1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:35:27 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33475 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbYFMSfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:25 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id B912DE3F1F1D
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:24 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7Q-0000eI-00; Fri, 13 Jun 2008 20:35:24 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18WgAZea+6q/EHLVc12NgqEOwJacXxMMOBSGq40
	uPZURSMgsXoS/zOOV4UOB+zIzVgx4YnM+kvRXEKplxXI5OHJ9Y
	ZFVp5MrQt+5rO5atMe7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84908>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../spearce/jgit/treewalk/rules/FilePattern.java   |  128 ++++++++++++=
++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/FilePattern.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/FileP=
attern.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/File=
Pattern.java
new file mode 100644
index 0000000..86cba6b
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/FilePattern.=
java
@@ -0,0 +1,128 @@
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
+/**
+ * A {@link FilePattern} can be used to check if files in a directory =
matches a
+ * pattern. It provides with the {@link #getPatternForSubDirectory(Str=
ing)}
+ * method {@link FilePattern}s for sub directories.
+ *=20
+ * Implementations of this interface should be immutable.
+ *=20
+ */
+interface FilePattern {
+	/**
+	 * Contains the only instance of {@link FilePatternMatchAlways}.
+	 */
+	public static final FilePattern MATCH_ALWAYS =3D new FilePatternMatch=
Always();
+
+	/**
+	 * Contains the only instance of {@link FilePatternMatchNever}.
+	 */
+	public static final FilePattern MATCH_NEVER =3D new FilePatternMatchN=
ever();
+
+	/**
+	 * @param fileName
+	 *            the name of the file or directory
+	 * @param fileIsDirectory
+	 *            determines if the file is a directory.
+	 * @return true if the pattern matches.
+	 */
+	boolean match(String fileName, boolean fileIsDirectory);
+
+	/**
+	 *=20
+	 * @param directoryName
+	 *            the name of a subdirectory.
+	 * @return a pattern which can be used to match files in sub director=
ies. A
+	 *         user may check if the returned value is {@link #MATCH_NEVE=
R} in
+	 *         order to do some performance optimizations.
+	 *=20
+	 */
+	FilePattern getPatternForSubDirectory(String directoryName);
+
+	/**
+	 * @return true if {@link #getPatternForSubDirectory(String)} returns=
 true
+	 *         for every value.
+	 */
+	boolean isSameForSubDirectories();
+
+	/**
+	 * This implementation does always match.
+	 */
+	public static final class FilePatternMatchAlways implements FilePatte=
rn {
+
+		private FilePatternMatchAlways() {
+			// declared to make the constructor private
+		}
+
+		public FilePattern getPatternForSubDirectory(String directoryName) {
+			return MATCH_ALWAYS;
+		}
+
+		public boolean match(String fileName, boolean fileIsDirectory) {
+			return true;
+		}
+
+		public boolean isSameForSubDirectories() {
+			return true;
+		}
+	}
+
+	/**
+	 * This implementation does never match.
+	 */
+	public static final class FilePatternMatchNever implements FilePatter=
n {
+		private FilePatternMatchNever() {
+			// declared to make the constructor private
+		}
+
+		public FilePattern getPatternForSubDirectory(String directoryName) {
+			return MATCH_NEVER;
+		}
+
+		public boolean match(String fileName, boolean fileIsDirectory) {
+			return false;
+		}
+
+		public boolean isSameForSubDirectories() {
+			return true;
+		}
+	}
+
+}
--=20
1.5.4.3
