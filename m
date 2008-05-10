From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 18/22] Added InvalidPatternException and PathNotInProjectDirectoryException
Date: Sat, 10 May 2008 15:00:36 +0200
Message-ID: <1210424440-13886-19-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juojl-0008FZ-0y
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbYEJNBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:01:33 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755542AbYEJNBa
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:01:30 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44629 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbYEJNAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:52 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1B125DE99D15
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:51 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juoh0-000860-00; Sat, 10 May 2008 15:00:50 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+TF8AcgFiuCFJUWgEh2djrYsGwINyShJ33h48p
	qUR8ppE+smCHCbEw7+mf6dbVWIbj1+xhnhAWpWAZ2v6zT61cKs
	KHCQ8Q7kGsvlBok+xdJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81680>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/errors/InvalidPatternException.java       |   48 ++++++++++++=
++++++++
 .../errors/PathNotInProjectDirectoryException.java |   28 +++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/Invali=
dPatternException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/PathNo=
tInProjectDirectoryException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatter=
nException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidP=
atternException.java
new file mode 100644
index 0000000..8cd2a31
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatternExcept=
ion.java
@@ -0,0 +1,48 @@
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
+package org.spearce.jgit.errors;
+
+/**
+ * Thrown when a pattern passed in an argument was wrong.
+ *=20
+ * @author Florian Koeberle
+ *=20
+ */
+public class InvalidPatternException extends Exception {
+	private static final long serialVersionUID =3D -606889225458579931L;
+
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
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/PathNotInProj=
ectDirectoryException.java b/org.spearce.jgit/src/org/spearce/jgit/erro=
rs/PathNotInProjectDirectoryException.java
new file mode 100644
index 0000000..1b7b903
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/PathNotInProjectDire=
ctoryException.java
@@ -0,0 +1,28 @@
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
+package org.spearce.jgit.errors;
+
+/**
+ * Thrown when a path wasn't in the project directory, but expected to=
 be.
+ *=20
+ * @author Florian K=C3=B6berle
+ *=20
+ */
+public class PathNotInProjectDirectoryException extends
+		IllegalArgumentException {
+	private static final long serialVersionUID =3D 1650325142579844202L;
+}
--=20
1.5.2.5
