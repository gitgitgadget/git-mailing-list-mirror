From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Documentation/git-archimport: document -o, -a, f, -D options
Date: Sun, 18 Dec 2005 17:23:50 -0800
Message-ID: <20051219012350.GA5741@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 19 02:25:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo9kq-0001Xb-KA
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 02:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVLSBXw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 20:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbVLSBXw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 20:23:52 -0500
Received: from hand.yhbt.net ([66.150.188.102]:52895 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1030209AbVLSBXv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 20:23:51 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 18E5A7DC0C1; Sun, 18 Dec 2005 17:23:51 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13807>

Also, ensure usage help switches are in the same order.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 Documentation/git-archimport.txt |   23 ++++++++++++++++++++++-
 git-archimport.perl              |    5 +++--
 2 files changed, 25 insertions(+), 3 deletions(-)

53a88811af9db5cb6287fe0fe9a7d03ab62652c7
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index fcda012..a2bd788 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -8,7 +8,8 @@ git-archimport - Import an Arch reposito
 
 SYNOPSIS
 --------
-`git-archimport` [ -h ] [ -v ] [ -T ] [ -t tempdir ] 
+`git-archimport` [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ]
+                 [ -D depth ] [ -t tempdir ] 
                  <archive/branch> [ <archive/branch> ]
 
 DESCRIPTION
@@ -63,6 +64,26 @@ OPTIONS
 	Many tags. Will create a tag for every commit, reflecting the commit 
 	name in the Arch repository.
 
+-f::
+	Use the fast patchset import strategy.  This can be significantly
+	faster for large trees, but cannot handle directory renames or
+	permissions changes.  The default strategy is slow and safe.
+
+-o::
+	Use this for compatibility with old-style branch names used by
+	earlier versions of git-archimport.  Old-style branch names
+	were category--branch, whereas new-style branch names are
+	archive,category--branch--version.
+
+-D <depth>::
+	Follow merge ancestry and attempt to import trees that have been
+	merged from.  Specify a depth greater than 1 if patch logs have been
+	pruned.
+
+-a::
+	Attempt to auto-register archives at http://mirrors.sourcecontrol.net
+	This is particularly useful with the -D option.
+
 -t <tmpdir>::
 	Override the default tempdir.
 
diff --git a/git-archimport.perl b/git-archimport.perl
index aab4e38..841738d 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -9,7 +9,8 @@
 
 =head1 Invocation
 
-    git-archimport [ -h ] [ -v ] [ -T ] [ -t tempdir ] <archive>/<branch> [ <archive>/<branch> ]
+    git-archimport [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ] 
+    	[ -D depth] [ -t tempdir ] <archive>/<branch> [ <archive>/<branch> ]
 
 Imports a project from one or more Arch repositories. It will follow branches
 and repositories within the namespaces defined by the <archive/branch>
@@ -74,7 +75,7 @@ our($opt_h,$opt_f,$opt_v,$opt_T,$opt_t,$
 sub usage() {
     print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from Arch
-       [ -f ] [ -o ] [ -h ] [ -v ] [ -T ] [ -a ] [ -D depth  ] [ -t tempdir ]
+       [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ] [ -D depth ] [ -t tempdir ]
        repository/arch-branch [ repository/arch-branch] ...
 END
     exit(1);
-- 
0.99.9.GIT
