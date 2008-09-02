From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/3] Add a tiny "jgit version" program
Date: Tue,  2 Sep 2008 09:28:12 -0700
Message-ID: <1220372892-15423-3-git-send-email-spearce@spearce.org>
References: <1220372892-15423-1-git-send-email-spearce@spearce.org>
 <1220372892-15423-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 18:29:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaYkw-0006j9-EU
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 18:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbYIBQ2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbYIBQ2T
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 12:28:19 -0400
Received: from george.spearce.org ([209.20.77.23]:44745 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYIBQ2O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 12:28:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9944238376; Tue,  2 Sep 2008 16:28:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DD94238359;
	Tue,  2 Sep 2008 16:28:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.207.g020e5
In-Reply-To: <1220372892-15423-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94679>

Displays the current version of the JAR.  This is probably the same
as the library code since they are currently packaged together but
may in the future represent only the version of the CLI (.pgm).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Version.java          |   52 ++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Version.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 39ae664..e2e7938 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -12,6 +12,7 @@ org.spearce.jgit.pgm.RevList
 org.spearce.jgit.pgm.Rm
 org.spearce.jgit.pgm.ShowRev
 org.spearce.jgit.pgm.Tag
+org.spearce.jgit.pgm.Version
 
 org.spearce.jgit.pgm.debug.MakeCacheTree
 org.spearce.jgit.pgm.debug.ReadDirCache
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Version.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Version.java
new file mode 100644
index 0000000..e4cd707
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Version.java
@@ -0,0 +1,52 @@
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
+package org.spearce.jgit.pgm;
+
+@Command(common = true, usage = "Display the version of jgit")
+class Version extends TextBuiltin {
+	@Override
+	protected void run() throws Exception {
+		final Package pkg = getClass().getPackage();
+		if (pkg == null || pkg.getImplementationVersion() == null)
+			throw die("Cannot read package information.");
+
+		out.print("jgit version ");
+		out.print(pkg.getImplementationVersion());
+		out.println();
+	}
+}
-- 
1.6.0.1.207.g020e5
