From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH 2/3] Added definitions for a few words:
Date: Wed, 03 May 2006 23:18:59 -0500
Message-ID: <E1FbVIp-0004UB-1f@jdl.com>
X-From: git-owner@vger.kernel.org Thu May 04 06:19:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbVIx-00032y-D1
	for gcvg-git@gmane.org; Thu, 04 May 2006 06:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWEDETC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 00:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWEDETB
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 00:19:01 -0400
Received: from jdl.com ([66.118.10.122]:62187 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751201AbWEDETA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 00:19:00 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FbVIp-0004UB-1f
	for git@vger.kernel.org; Wed, 03 May 2006 23:19:00 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19548>


    fast forward
    pickaxe
    refspec
    tracking branch

Wild hack allows "link:git-" prefix to reference commands too.

Signed-off-by: Jon Loeliger <jdl@jdl.com>


---

Yep, this pickaxe entry is b0rked.
Apply the next patch too.


 Documentation/glossary.txt     |   33 +++++++++++++++++++++++++++++++++
 Documentation/sort_glossary.pl |    2 +-
 2 files changed, 34 insertions(+), 1 deletions(-)

b63f925f5f88549581324257d3b2030163389a98
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 075c078..86196c4 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -68,6 +68,14 @@ ent::
 	`http://en.wikipedia.org/wiki/Ent_(Middle-earth)` for an in-depth
 	explanation.
 
+fast forward::
+	A fast-forward is a special type of merge where you have
+	a revision and you are "merging" another branch's changes
+	that happen to be a descendant of what you have.
+	In such these cases, you do not make a new merge commit but
+	instead just update to his revision. This will happen
+	frequently on a tracking branch of a remote repository.
+
 fetch::
 	Fetching a branch means to get the branch's head ref from a
 	remote repository, to find out which objects are missing from
@@ -160,6 +168,12 @@ parent::
 	A commit object contains a (possibly empty) list of the logical
 	predecessor(s) in the line of development, i.e. its parents.
 
+pickaxe:: The term pickaxe refers to an option to the diffcore routines
+	that help select changes that add or delete a given text string.
+	With the --pickaxe-all option, it can be used to view the
+	full changeset that introduced or removed, say, a particular
+	line of text.  See gitlink:git-diff[1].
+
 plumbing::
 	Cute name for core git.
 
@@ -193,6 +207,18 @@ ref::
 	A 40-byte hex representation of a SHA1 pointing to a particular
 	object. These may be stored in `$GIT_DIR/refs/`.
 
+refspec::
+	A refspec is used by fetch and push to describe the mapping
+	between remote ref and local ref.  They are combined with
+	a colon in the format <src>:<dst>, preceded by an optional
+	plus sign, +.  For example:
+	`git fetch $URL refs/heads/master:refs/heads/origin`
+	means "grab the master branch head from the $URL and store
+	it as my origin branch head".
+	And `git push $URL refs/heads/master:refs/heads/to-upstream`
+	means "publish my master branch head as to-upstream master head
+	at $URL".   See also gitlink:git-push[1]
+
 repository::
 	A collection of refs together with an object database containing
 	all objects, which are reachable from the refs, possibly accompanied
@@ -217,6 +243,13 @@ SCM::
 SHA1::
 	Synonym for object name.
 
+tracking branch::
+	A regular git branch that is used to follow changes from
+	another repository.  A tracking branch should not contain
+	direct modifications or made commits made locally.
+	A tracking branch can usually be identified as the
+	right-hand-side ref in a Pull: refspec.
+
 tree object::
 	An object containing a list of file names and modes along with refs
 	to the associated blob and/or tree objects. A tree is equivalent
diff --git a/Documentation/sort_glossary.pl b/Documentation/sort_glossary.pl
index e57dc78..e0bc552 100644
--- a/Documentation/sort_glossary.pl
+++ b/Documentation/sort_glossary.pl
@@ -48,7 +48,7 @@ This list is sorted alphabetically:
 ';
 
 @keys=sort {uc($a) cmp uc($b)} keys %terms;
-$pattern='(\b'.join('\b|\b',reverse @keys).'\b)';
+$pattern='(\b(?<!link:git-)'.join('\b|\b(?<!link:git-)',reverse @keys).'\b)';
 foreach $key (@keys) {
 	$terms{$key}=~s/$pattern/sprintf "<<ref_".no_spaces($1).",$1>>";/eg;
 	print '[[ref_'.no_spaces($key).']]'.$key."::\n"
-- 
1.3.1.g3d990
