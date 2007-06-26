From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-merge-ff: fast-forward only merge
Date: Tue, 26 Jun 2007 16:01:10 +1200
Message-ID: <1182830470640-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 06:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I32Et-0005QP-Ut
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 06:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbXFZEBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 00:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbXFZEBO
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 00:01:14 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:33964 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbXFZEBO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 00:01:14 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I32Eo-0007iE-Nj; Tue, 26 Jun 2007 16:01:10 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id A81C6CB9E8; Tue, 26 Jun 2007 16:01:10 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50945>

This is primarily so that there is an easy switch to 'git-pull' to
be sure to fast forward only.
---
 Documentation/merge-strategies.txt |    5 +++++
 Makefile                           |    2 +-
 git-merge-ff.sh                    |    8 ++++++++
 3 files changed, 14 insertions(+), 1 deletions(-)
 create mode 100644 git-merge-ff.sh

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 7df0266..00739bc 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -33,3 +33,8 @@ ours::
 	merge is always the current branch head.  It is meant to
 	be used to supersede old development history of side
 	branches.
+
+ff::
+	This is a degenerate merge strategy that always fails, which
+	means that the only time the target branch will change is if
+	there was no merge ("fast-forward" merge only).
diff --git a/Makefile b/Makefile
index 29243c6..6311eb5 100644
--- a/Makefile
+++ b/Makefile
@@ -208,7 +208,7 @@ SCRIPT_SH = \
 	git-tag.sh git-verify-tag.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
-	git-merge-resolve.sh git-merge-ours.sh \
+	git-merge-resolve.sh git-merge-ours.sh git-merge-ff.sh \
 	git-lost-found.sh git-quiltimport.sh
 
 SCRIPT_PERL = \
diff --git a/git-merge-ff.sh b/git-merge-ff.sh
new file mode 100644
index 0000000..b0e0f85
--- /dev/null
+++ b/git-merge-ff.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Sam Vilain
+#
+# A degenerate merge strategy that only allows fast-forwarding.
+#
+
+exit 1;
-- 
1.5.2.1.1131.g3b90
