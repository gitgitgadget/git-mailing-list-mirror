From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Refactor merge strategies into separate includable file.
Date: Sun, 06 Nov 2005 10:26:07 -0600
Message-ID: <E1EYnLL-00028e-CY@jdl.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 17:28:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYnLm-0004bB-Mn
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 17:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVKFQ0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 11:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVKFQ0P
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 11:26:15 -0500
Received: from mail.jdl.com ([66.118.10.122]:27836 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751049AbVKFQ0O (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 11:26:14 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EYnLL-00028e-CY
	for git@vger.kernel.org; Sun, 06 Nov 2005 10:26:08 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11217>


Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

 Documentation/git-merge.txt        |    2 ++
 Documentation/git-pull.txt         |   36 +-----------------------------------
 Documentation/merge-strategies.txt |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/merge-strategies.txt

applies-to: 2a5577073c7747c11ad79f414603e68c5d95cf6b
ceda5bc3b5cb502edb3c0596aeede1a0ab9d4295
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3e058db..b3ef19b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -34,6 +34,8 @@ include::merge-pull-opts.txt[]
 	least one <remote>.  Specifying more than one <remote>
 	obviously means you are trying an Octopus.
 
+include::merge-strategies.txt[]
+
 
 SEE ALSO
 --------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ec10a2f..7ebb08d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -31,42 +31,8 @@ include::pull-fetch-param.txt[]
 
 include::merge-pull-opts.txt[]
 
+include::merge-strategies.txt[]
 
-MERGE STRATEGIES
-----------------
-
-resolve::
-	This can only resolve two heads (i.e. the current branch
-	and another branch you pulled from) using 3-way merge
-	algorithm.  It tries to carefully detect criss-cross
-	merge ambiguities and is considered generally safe and
-	fast.  This is the default merge strategy when pulling
-	one branch.
-
-recursive::
-	This can only resolve two heads using 3-way merge
-	algorithm.  When there are more than one common
-	ancestors that can be used for 3-way merge, it creates a
-	merged tree of the common ancestores and uses that as
-	the reference tree for the 3-way merge.  This has been
-	reported to result in fewer merge conflicts without
-	causing mis-merges by tests done on actual merge commits
-	taken from Linux 2.6 kernel development history.
-	Additionally this can detect and handle merges involving
-	renames.
-
-octopus::
-	This resolves more than two-head case, but refuses to do
-	complex merge that needs manual resolution.  It is
-	primarily meant to be used for bundling topic branch
-	heads together.  This is the default merge strategy when
-	pulling more than one branch.
-
-ours::
-	This resolves any number of heads, but the result of the
-	merge is always the current branch head.  It is meant to
-	be used to supersede old development history of side
-	branches.
 
 
 EXAMPLES
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
new file mode 100644
index 0000000..3ec56d2
--- /dev/null
+++ b/Documentation/merge-strategies.txt
@@ -0,0 +1,35 @@
+MERGE STRATEGIES
+----------------
+
+resolve::
+	This can only resolve two heads (i.e. the current branch
+	and another branch you pulled from) using 3-way merge
+	algorithm.  It tries to carefully detect criss-cross
+	merge ambiguities and is considered generally safe and
+	fast.  This is the default merge strategy when pulling
+	one branch.
+
+recursive::
+	This can only resolve two heads using 3-way merge
+	algorithm.  When there are more than one common
+	ancestors that can be used for 3-way merge, it creates a
+	merged tree of the common ancestores and uses that as
+	the reference tree for the 3-way merge.  This has been
+	reported to result in fewer merge conflicts without
+	causing mis-merges by tests done on actual merge commits
+	taken from Linux 2.6 kernel development history.
+	Additionally this can detect and handle merges involving
+	renames.
+
+octopus::
+	This resolves more than two-head case, but refuses to do
+	complex merge that needs manual resolution.  It is
+	primarily meant to be used for bundling topic branch
+	heads together.  This is the default merge strategy when
+	pulling more than one branch.
+
+ours::
+	This resolves any number of heads, but the result of the
+	merge is always the current branch head.  It is meant to
+	be used to supersede old development history of side
+	branches.
---
0.99.9.GIT
