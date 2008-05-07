From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Documentation: improve "add", "pull" and "format-patch"
 examples
Date: Wed, 7 May 2008 06:29:28 +0200
Message-ID: <20080507062928.45452d1b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, Jeff
X-From: git-owner@vger.kernel.org Wed May 07 06:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtbDg-0003I1-3S
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 06:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbYEGEYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 00:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbYEGEYl
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 00:24:41 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:58041 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbYEGEYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 00:24:38 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 076D01AB2BE;
	Wed,  7 May 2008 06:24:36 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id EDAA01AB2B0;
	Wed,  7 May 2008 06:24:34 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81403>

Before this patch in "git-add.txt" and "git-format-patch.txt", the
commands used in the examples were "git-CMD" instead of "git CMD".
This patch fixes that.

In "git-pull.txt" only the last example had the code sample in an
asciidoc "Listing Block", and in the other two files, none.
This patch fixes that by putting all code samples in listing
blocks.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-add.txt          |   24 ++++++----
 Documentation/git-format-patch.txt |   67 +++++++++++++++++-----------
 Documentation/git-pull.txt         |   86 ++++++++++++++++++++++--------------
 3 files changed, 108 insertions(+), 69 deletions(-)

	This is a small patch series to improve examples in man pages.
	The 2 patches are both independent from each other and from my
	other documentation patch series.

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 35e67a0..2eabbc8 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -98,21 +98,27 @@ those in info/exclude.  See link:repository-layout.html[repository layout].
 
 EXAMPLES
 --------
-git-add Documentation/\\*.txt::
 
-	Adds content from all `\*.txt` files under `Documentation`
-	directory and its subdirectories.
+* Adds content from all `\*.txt` files under `Documentation` directory
+and its subdirectories:
++
+------------
+$ git add Documentation/\\*.txt
+------------
 +
 Note that the asterisk `\*` is quoted from the shell in this
 example; this lets the command to include the files from
 subdirectories of `Documentation/` directory.
 
-git-add git-*.sh::
-
-	Considers adding content from all git-*.sh scripts.
-	Because this example lets shell expand the asterisk
-	(i.e. you are listing the files explicitly), it does not
-	consider `subdir/git-foo.sh`.
+* Considers adding content from all git-*.sh scripts:
++
+------------
+$ git add git-*.sh
+------------
++
+Because this example lets shell expand the asterisk (i.e. you are
+listing the files explicitly), it does not consider
+`subdir/git-foo.sh`.
 
 Interactive mode
 ----------------
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 2336b3e..ca528f9 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -175,32 +175,47 @@ and file suffix, and number patches when outputting more than one.
 EXAMPLES
 --------
 
-git-format-patch -k --stdout R1..R2 | git-am -3 -k::
-	Extract commits between revisions R1 and R2, and apply
-	them on top of the current branch using `git-am` to
-	cherry-pick them.
-
-git-format-patch origin::
-	Extract all commits which are in the current branch but
-	not in the origin branch.  For each commit a separate file
-	is created in the current directory.
-
-git-format-patch \--root origin::
-	Extract all commits that lead to 'origin' since the
-	inception of the project.
-
-git-format-patch -M -B origin::
-	The same as the previous one.  Additionally, it detects
-	and handles renames and complete rewrites intelligently to
-	produce a renaming patch.  A renaming patch reduces the
-	amount of text output, and generally makes it easier to
-	review it.  Note that the "patch" program does not
-	understand renaming patches, so use it only when you know
-	the recipient uses git to apply your patch.
-
-git-format-patch -3::
-	Extract three topmost commits from the current branch
-	and format them as e-mailable patches.
+* Extract commits between revisions R1 and R2, and apply them on top of
+the current branch using `git-am` to cherry-pick them:
++
+------------
+$ git format-patch -k --stdout R1..R2 | git-am -3 -k
+------------
+
+* Extract all commits which are in the current branch but not in the
+origin branch:
++
+------------
+$ git format-patch origin
+------------
++
+For each commit a separate file is created in the current directory.
+
+* Extract all commits that lead to 'origin' since the inception of the
+project:
++
+------------
+$ git format-patch \--root origin
+------------
+
+* The same as the previous one:
++
+------------
+$ git format-patch -M -B origin
+------------
++
+Additionally, it detects and handles renames and complete rewrites
+intelligently to produce a renaming patch.  A renaming patch reduces
+the amount of text output, and generally makes it easier to review it.
+Note that the "patch" program does not understand renaming patches, so
+use it only when you know the recipient uses git to apply your patch.
+
+* Extract three topmost commits from the current branch and format them
+as e-mailable patches:
++
+------------
+$ git format-patch -3
+------------
 
 See Also
 --------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 3405ca0..66304f0 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -111,40 +111,58 @@ rules apply:
 EXAMPLES
 --------
 
-git pull, git pull origin::
-	Update the remote-tracking branches for the repository
-	you cloned from, then merge one of them into your
-	current branch.  Normally the branch merged in is
-	the HEAD of the remote repository, but the choice is
-	determined by the branch.<name>.remote and
-	branch.<name>.merge options; see linkgit:git-config[1]
-	for details.
-
-git pull origin next::
-	Merge into the current branch the remote branch `next`;
-	leaves a copy of `next` temporarily in FETCH_HEAD, but
-	does not update any remote-tracking branches.
-
-git pull . fixes enhancements::
-	Bundle local branch `fixes` and `enhancements` on top of
-	the current branch, making an Octopus merge.  This `git pull .`
-	syntax is equivalent to `git merge`.
-
-git pull -s ours . obsolete::
-	Merge local branch `obsolete` into the current branch,
-	using `ours` merge strategy.
-
-git pull --no-commit . maint::
-	Merge local branch `maint` into the current branch, but
-	do not make a commit automatically.  This can be used
-	when you want to include further changes to the merge,
-	or want to write your own merge commit message.
+* Update the remote-tracking branches for the repository
+  you cloned from, then merge one of them into your
+  current branch:
++
+------------------------------------------------
+$ git pull, git pull origin
+------------------------------------------------
++
+Normally the branch merged in is the HEAD of the remote repository,
+but the choice is determined by the branch.<name>.remote and
+branch.<name>.merge options; see linkgit:git-config[1] for details.
+
+* Merge into the current branch the remote branch `next`:
++
+------------------------------------------------
+$ git pull origin next
+------------------------------------------------
++
+This leaves a copy of `next` temporarily in FETCH_HEAD, but
+does not update any remote-tracking branches.
+
+* Bundle local branch `fixes` and `enhancements` on top of
+  the current branch, making an Octopus merge:
++
+------------------------------------------------
+$ git pull . fixes enhancements
+------------------------------------------------
++
+This `git pull .` syntax is equivalent to `git merge`.
+
+* Merge local branch `obsolete` into the current branch, using `ours`
+  merge strategy:
++
+------------------------------------------------
+$ git pull -s ours . obsolete
+------------------------------------------------
+
+* Merge local branch `maint` into the current branch, but do not make
+  a commit automatically:
++
+------------------------------------------------
+$ git pull --no-commit . maint
+------------------------------------------------
++
+This can be used when you want to include further changes to the
+merge, or want to write your own merge commit message.
 +
 You should refrain from abusing this option to sneak substantial
 changes into a merge commit.  Small fixups like bumping
 release/version name would be acceptable.
 
-Command line pull of multiple branches from one repository::
+* Command line pull of multiple branches from one repository:
 +
 ------------------------------------------------
 $ git checkout master
@@ -152,12 +170,12 @@ $ git fetch origin +pu:pu maint:tmp
 $ git pull . tmp
 ------------------------------------------------
 +
-This updates (or creates, as necessary) branches `pu` and `tmp`
-in the local repository by fetching from the branches
-(respectively) `pu` and `maint` from the remote repository.
+This updates (or creates, as necessary) branches `pu` and `tmp` in
+the local repository by fetching from the branches (respectively)
+`pu` and `maint` from the remote repository.
 +
-The `pu` branch will be updated even if it is does not
-fast-forward; the others will not be.
+The `pu` branch will be updated even if it is does not fast-forward;
+the others will not be.
 +
 The final command then merges the newly fetched `tmp` into master.
 
-- 
1.5.5.1.126.g9ca01
