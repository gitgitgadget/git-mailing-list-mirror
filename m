From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/5] hg-to-git: rewrite "git-frotz" to "git frotz"
Date: Sun,  6 Jul 2008 05:15:19 +0200
Message-ID: <5b692cd189e0afbd4b0e372f1671aa343dfb0d78.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
 <89a68bb21125c4ff706412cde5c04f5d96658789.1215313871.git.vmiklos@frugalware.org>
 <ca2e01fa1446afa551f5a6a36242a03d79cb685c.1215313871.git.vmiklos@frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 05:16:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFKjr-0000sb-3g
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 05:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbYGFDPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 23:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbYGFDPR
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 23:15:17 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57916 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbYGFDPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 23:15:11 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 79B761DDC5E;
	Sun,  6 Jul 2008 05:15:08 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 9C2741A9CF2; Sun,  6 Jul 2008 05:15:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
In-Reply-To: <ca2e01fa1446afa551f5a6a36242a03d79cb685c.1215313871.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87487>

This is not just nice but necessary since git-frotz is no longer in
PATH.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 contrib/hg-to-git/hg-to-git.py |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 130b1c4..61540ef 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -152,7 +152,7 @@ for cset in range(1, int(tip) + 1):
 
 if not hgvers.has_key("0"):
     print 'creating repository'
-    os.system('git-init-db')
+    os.system('git init-db')
 
 # loop through every hg changeset
 for cset in range(int(tip) + 1):
@@ -194,10 +194,10 @@ for cset in range(int(tip) + 1):
     if cset != 0:
         if hgbranch[str(cset)] == "branch-" + str(cset):
             print 'creating new branch', hgbranch[str(cset)]
-            os.system('git-checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
+            os.system('git checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
         else:
             print 'checking out branch', hgbranch[str(cset)]
-            os.system('git-checkout %s' % hgbranch[str(cset)])
+            os.system('git checkout %s' % hgbranch[str(cset)])
 
     # merge
     if mparent:
@@ -206,7 +206,7 @@ for cset in range(int(tip) + 1):
         else:
             otherbranch = hgbranch[parent]
         print 'merging', otherbranch, 'into', hgbranch[str(cset)]
-        os.system(getgitenv(user, date) + 'git-merge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))
+        os.system(getgitenv(user, date) + 'git merge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))
 
     # remove everything except .git and .hg directories
     os.system('find . \( -path "./.hg" -o -path "./.git" \) -prune -o ! -name "." -print | xargs rm -rf')
@@ -215,9 +215,9 @@ for cset in range(int(tip) + 1):
     os.system('hg update -C %d' % cset)
 
     # add new files
-    os.system('git-ls-files -x .hg --others | git-update-index --add --stdin')
+    os.system('git ls-files -x .hg --others | git update-index --add --stdin')
     # delete removed files
-    os.system('git-ls-files -x .hg --deleted | git-update-index --remove --stdin')
+    os.system('git ls-files -x .hg --deleted | git update-index --remove --stdin')
 
     # commit
     os.system(getgitenv(user, date) + 'git commit --allow-empty -a -F %s' % filecomment)
@@ -225,20 +225,20 @@ for cset in range(int(tip) + 1):
 
     # tag
     if tag and tag != 'tip':
-        os.system(getgitenv(user, date) + 'git-tag %s' % tag)
+        os.system(getgitenv(user, date) + 'git tag %s' % tag)
 
     # delete branch if not used anymore...
     if mparent and len(hgchildren[str(cset)]):
         print "Deleting unused branch:", otherbranch
-        os.system('git-branch -d %s' % otherbranch)
+        os.system('git branch -d %s' % otherbranch)
 
     # retrieve and record the version
-    vvv = os.popen('git-show --quiet --pretty=format:%H').read()
+    vvv = os.popen('git show --quiet --pretty=format:%H').read()
     print 'record', cset, '->', vvv
     hgvers[str(cset)] = vvv
 
 if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
-    os.system('git-repack -a -d')
+    os.system('git repack -a -d')
 
 # write the state for incrementals
 if state:
-- 
1.5.6.1.322.ge904b.dirty
