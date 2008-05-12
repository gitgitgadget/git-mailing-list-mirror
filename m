From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 18/24] Added InvalidPatternException and PathNotInProjectDirectoryException
Date: Mon, 12 May 2008 22:13:36 +0200
Message-ID: <1210623222-24908-19-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSi-00086f-6R
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265AbYELUOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:30 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757610AbYELUO2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:28 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40228 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655AbYELUNy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:54 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id DA491DECFD0E
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:53 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JvePB-00016x-00; Mon, 12 May 2008 22:13:53 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/ojzDT5helxuS6JMYeYvPZCKN/H4uNZvW+Jx0l
	Sc78XeSiLNIUmkI10ZLyp8QIwIEKUbUlUT/6RxcWwwOodk5trK
	hV7MHfiptaQcZpPsCB0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81934>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/errors/InvalidPatternException.java       |   44 ++++++++++++=
++++++++
 .../errors/PathNotInProjectDirectoryException.java |   25 +++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/Invali=
dPatternException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/PathNo=
tInProjectDirectoryException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatter=
nException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidP=
atternException.java
new file mode 100644
index 0000000..d09f0c9
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/InvalidPatternExcept=
ion.java
@@ -0,0 +1,44 @@
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
diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/PathNotInProj=
ectDirectoryException.java b/org.spearce.jgit/src/org/spearce/jgit/erro=
rs/PathNotInProjectDirectoryException.java
new file mode 100644
index 0000000..a406aef
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/PathNotInProjectDire=
ctoryException.java
@@ -0,0 +1,25 @@
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
+ */
+public class PathNotInProjectDirectoryException extends
+		IllegalArgumentException {
+}
--=20
1.5.4.3
