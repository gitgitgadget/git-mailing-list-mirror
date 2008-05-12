From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 09/24] Added the class Rule.
Date: Mon, 12 May 2008 22:13:27 +0200
Message-ID: <1210623222-24908-10-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSl-00086f-AS
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbYELUOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:42 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbYELUOk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:40 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40185 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbYELUNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:46 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id A2A25DECFCE9
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:45 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP3-00016x-00; Mon, 12 May 2008 22:13:45 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/ziJLOlMX/ck8Cuo2gXZ+yCbrtu1hV0Hof4ogM
	A0Dpj2ykW+RDG3hv0Eai8zKhqEX6U2GNIiMVJq1i+9NJfQ7Q5H
	FRP3ugIlS2f6PNYPHAJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81937>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/treewalk/rules/Rule.java  |   65 ++++++++++++=
++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/Rule.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rule.=
java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rule.java
new file mode 100644
index 0000000..fe3b45c
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rule.java
@@ -0,0 +1,65 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.treewalk.rules;
+
+/**
+ * A Rule defines what to do with a files which match a specified
+ * {@link FilePattern}.
+ */
+public class Rule {
+	private boolean ignoreAtMatch;
+
+	private FilePattern pattern;
+
+	/**
+	 *=20
+	 * @param ignoreAtMatch
+	 *            defines if the rules ignores or accepts at a match.
+	 * @param pattern
+	 *            the pattern used to test if a file matches.
+	 */
+	Rule(boolean ignoreAtMatch, FilePattern pattern) {
+		this.ignoreAtMatch =3D ignoreAtMatch;
+		this.pattern =3D pattern;
+	}
+
+	FilePattern getPattern() {
+		return pattern;
+	}
+
+	boolean isIgnoreAtMatch() {
+		return ignoreAtMatch;
+	}
+
+	Rule getRuleForSubDirectory(String directoryName) {
+		final FilePattern subPattern =3D pattern
+				.getPatternForSubDirectory(directoryName);
+		if (subPattern =3D=3D pattern) {
+			return this;
+		}
+		return new Rule(ignoreAtMatch, subPattern);
+	}
+
+	boolean canMatchAtThisDirectoryLevel() {
+		return pattern.canMatchAtThisDirectoryLevel();
+	}
+
+	boolean isSameForSubDirectories() {
+		return pattern.isSameForSubDirectories();
+	}
+
+}
--=20
1.5.4.3
