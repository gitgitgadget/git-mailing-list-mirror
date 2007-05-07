From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 5/6] user-manual: miscellaneous editing
Date: Mon,  7 May 2007 01:14:01 -0400
Message-ID: <26482.7893967324$1178514875@news.gmane.org>
References: <11785148422793-git-send-email->
 <11785148433801-git-send-email->
 <11785148442263-git-send-email->
 <1178514845119-git-send-email->
 <11785148452962-git-send-email->
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 07:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkvYO-0008WF-0k
	for gcvg-git@gmane.org; Mon, 07 May 2007 07:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbXEGFOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 01:14:16 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXEGFOQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 01:14:16 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53670 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995AbXEGFOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 01:14:10 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HkvXz-0005a1-0H; Mon, 07 May 2007 01:14:07 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11785148452962-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46414>

=46rom: J. Bruce Fields <bfields@citi.umich.edu>

I cherry-picked some additional miscellaneous fixes from those suggeste=
d
by Santi B=C3=A9jar, including fixes to:

	- correct discussion of repository/HEAD->repository shortcut
	- add mention of git-mergetool
	- add mention of --track
	- mention "-f" as well as "+" for fetch

Cc: Santi B=C3=A9jar <sbejar@gmail.com>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   82 +++++++++++++++++++++++----------=
-------
 1 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index c292b4d..67f5b9b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -57,7 +57,7 @@ Managing branches
 -----------------
=20
 -----------------------------------------------
-$ git branch	     # list all branches in this repo
+$ git branch	     # list all local branches in this repo
 $ git checkout test  # switch working directory to branch "test"
 $ git branch new     # create branch "new" starting at current HEAD
 $ git branch -d new  # delete branch "new"
@@ -496,8 +496,8 @@ git branch <branch> <start-point>::
 	including using a branch name or a tag name
 git branch -d <branch>::
 	delete the branch <branch>; if the branch you are deleting
-	points to a commit which is not reachable from this branch,
-	this command will fail with a warning.
+	points to a commit which is not reachable from the current
+	branch, this command will fail with a warning.
 git branch -D <branch>::
 	even if the branch points to a commit not reachable
 	from the current branch, you may know that that commit
@@ -602,13 +602,9 @@ shorthand:
 The full name is occasionally useful if, for example, there ever
 exists a tag and a branch with the same name.
=20
-As another useful shortcut, if the repository "origin" posesses only
-a single branch, you can refer to that branch as just "origin".
-
-More generally, if you have defined a remote repository named
-"example", you can refer to the branch in that repository as
-"example".  And for a repository with multiple branches, this will
-refer to the branch designated as the "HEAD" branch.
+As another useful shortcut, the "HEAD" of a repository can be referred
+to just using the name of that repository.  So, for example, "origin"
+is usually a shortcut for the HEAD branch in the repository "origin".
=20
 For the complete list of paths which git checks for references, and
 the order it uses to decide which to choose when there are multiple
@@ -832,10 +828,10 @@ $ git tag stable-1 1b2e1d63ff
=20
 You can use stable-1 to refer to the commit 1b2e1d63ff.
=20
-This creates a "lightweight" tag.  If the tag is a tag you wish to
-share with others, and possibly sign cryptographically, then you
-should create a tag object instead; see the gitlink:git-tag[1] man
-page for details.
+This creates a "lightweight" tag.  If you would also like to include a
+comment with the tag, and possibly sign it cryptographically, then you
+should create a tag object instead; see the gitlink:git-tag[1] man pag=
e
+for details.
=20
 [[browsing-revisions]]
 Browsing revisions
@@ -1176,6 +1172,8 @@ $ git diff --cached # difference between HEAD and=
 the index; what
 $ git diff	    # difference between the index file and your
 		    # working directory; changes that would not
 		    # be included if you ran "commit" now.
+$ git diff HEAD	    # difference between HEAD and working tree; what
+		    # would be committed if you ran "commit -a" now.
 $ git status	    # a brief per-file summary of the above.
 -------------------------------------------------
=20
@@ -1223,8 +1221,6 @@ If you examine the resulting commit using gitk, y=
ou will see that it
 has two parents, one pointing to the top of the current branch, and
 one to the top of the other branch.
=20
-In more detail:
-
 [[resolving-a-merge]]
 Resolving a merge
 -----------------
@@ -1361,6 +1357,9 @@ $ gitk --merge
 These will display all commits which exist only on HEAD or on
 MERGE_HEAD, and which touch an unmerged file.
=20
+You may also use gitlink:git-mergetool, which lets you merge the
+unmerged files using external tools such as emacs or kdiff3.
+
 Each time you resolve the conflicts in a file and update the index:
=20
 -------------------------------------------------
@@ -1705,9 +1704,16 @@ so often you can accomplish the above with just
 $ git pull
 -------------------------------------------------
=20
-See the descriptions of the branch.<name>.remote and
-branch.<name>.merge options in gitlink:git-config[1] to learn
-how to control these defaults depending on the current branch.
+See the descriptions of the branch.<name>.remote and branch.<name>.mer=
ge
+options in gitlink:git-config[1] to learn how to control these default=
s
+depending on the current branch.  Also note that the --track option to
+gitlink:git-branch[1] and gitlink:git-checkout[1] can be used to
+automatically set the default remote branch to pull from at the time
+that a branch is created:
+
+-------------------------------------------------
+$ git checkout --track -b origin/maint maint
+-------------------------------------------------
=20
 In addition to saving you keystrokes, "git pull" also helps you by
 producing a default commit message documenting the branch and
@@ -1830,14 +1836,14 @@ Now, assume your personal repository is in the =
directory ~/proj.  We
 first create a new clone of the repository:
=20
 -------------------------------------------------
-$ git clone --bare proj-clone.git
+$ git clone --bare proj.git
 -------------------------------------------------
=20
-The resulting directory proj-clone.git will contains a "bare" git
+The resulting directory proj.git will contains a "bare" git
 repository--it is just the contents of the ".git" directory, without
 a checked-out copy of a working directory.
=20
-Next, copy proj-clone.git to the server where you plan to host the
+Next, copy proj.git to the server where you plan to host the
 public repository.  You can use scp, rsync, or whatever is most
 convenient.
=20
@@ -1863,7 +1869,7 @@ adjustments to give web clients some extra inform=
ation they need:
 -------------------------------------------------
 $ mv proj.git /home/you/public_html/proj.git
 $ cd proj.git
-$ git update-server-info
+$ git --bare update-server-info
 $ chmod a+x hooks/post-update
 -------------------------------------------------
=20
@@ -1930,7 +1936,7 @@ As with git-fetch, you may also set up configurat=
ion options to
 save typing; so, for example, after
=20
 -------------------------------------------------
-$ cat >.git/config <<EOF
+$ cat >>.git/config <<EOF
 [remote "public-repo"]
 	url =3D ssh://yourserver.com/~you/proj.git
 EOF
@@ -2312,9 +2318,15 @@ descendant of the old head, you may force the up=
date with:
 $ git fetch git://example.com/proj.git +master:refs/remotes/example/ma=
ster
 -------------------------------------------------
=20
-Note the addition of the "+" sign.  Be aware that commits that the
-old version of example/master pointed at may be lost, as we saw in
-the previous section.
+Note the addition of the "+" sign.  Alternatively, you can use the "-f=
"
+flag to force updates of all the fetched branches, as in:
+
+-------------------------------------------------
+$ git fetch -f origin
+-------------------------------------------------
+
+Be aware that commits that the old version of example/master pointed a=
t
+may be lost, as we saw in the previous section.
=20
 [[remote-branch-configuration]]
 Configuring remote branches
@@ -2400,7 +2412,7 @@ approximated by the SHA1 hash of the object itsel=
f.  Objects may refer
 to other objects (by referencing their SHA1 hash), and so you can
 build up a hierarchy of objects.
=20
-All objects have a statically determined "type" aka "tag", which is
+All objects have a statically determined "type" which is
 determined at object creation time, and which identifies the format of
 the object (i.e. how it is used, and how it can refer to other
 objects).  There are currently four different object types: "blob",
@@ -2423,7 +2435,7 @@ the time of the commit). In addition, a "commit" =
refers to one or more
 that directory hierarchy.
=20
 As a special case, a commit object with no parents is called the "root=
"
-object, and is the point of an initial project commit.  Each project
+commit, and is the point of an initial project commit.  Each project
 must have at least one root, and while you can tie several different
 root objects together into one project by creating a commit object whi=
ch
 has two or more separate roots as its ultimate parents, that's probabl=
y
@@ -2542,7 +2554,7 @@ that the tree is "good" or that the merge informa=
tion makes sense.
 The parents do not have to actually have any relationship with the
 result, for example.
=20
-Note on commits: unlike real SCM's, commits do not contain
+Note on commits: unlike some SCM's, commits do not contain
 rename information or file mode change information.  All of that is
 implicit in the trees involved (the result tree, and the result trees
 of the parents), and describing that makes no sense in this idiotic
@@ -2609,7 +2621,7 @@ The "index" aka "Current Directory Cache"
 -----------------------------------------
=20
 The index is a simple binary file, which contains an efficient
-representation of a virtual directory content at some random time.  It
+representation of the contents of a virtual directory.  It
 does so by a simple array that associates a set of names, dates,
 permissions and content (aka "blob") objects together.  The cache is
 always kept ordered by name, and names are unique (with a few very
@@ -2912,7 +2924,7 @@ since the tree object information is always the f=
irst line in a commit
 object.
=20
 Once you know the three trees you are going to merge (the one "origina=
l"
-tree, aka the common case, and the two "result" trees, aka the branche=
s
+tree, aka the common tree, and the two "result" trees, aka the branche=
s
 you want to merge), you do a "merge" read into the index. This will
 complain if it has to throw away your old index contents, so you shoul=
d
 make sure that you've committed those - in fact you would normally
@@ -2966,14 +2978,14 @@ obviously the final outcome is what is in `HEAD=
`.  What the
 above example shows is that file `hello.c` was changed from
 `$orig` to `HEAD` and `$orig` to `$target` in a different way.
 You could resolve this by running your favorite 3-way merge
-program, e.g.  `diff3` or `merge`, on the blob objects from
-these three stages yourself, like this:
+program, e.g.  `diff3`, `merge`, or git's own merge-file, on
+the blob objects from these three stages yourself, like this:
=20
 ------------------------------------------------
 $ git-cat-file blob 263414f... >hello.c~1
 $ git-cat-file blob 06fa6a2... >hello.c~2
 $ git-cat-file blob cc44c73... >hello.c~3
-$ merge hello.c~2 hello.c~1 hello.c~3
+$ git merge-file hello.c~2 hello.c~1 hello.c~3
 ------------------------------------------------
=20
 This would leave the merge result in `hello.c~2` file, along
--=20
1.5.1.1.98.gedb4f
