From: Jeff King <peff@peff.net>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Wed, 3 Aug 2011 20:13:29 -0600
Message-ID: <20110804021329.GB32579@sigill.intra.peff.net>
References: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com>
 <20110804014143.GA32579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>, git@vger.kernel.org,
	rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 04:13:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QonRK-0007mM-B0
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 04:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab1HDCNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 22:13:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57026
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097Ab1HDCNc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 22:13:32 -0400
Received: (qmail 13023 invoked by uid 107); 4 Aug 2011 02:14:06 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 22:14:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 20:13:29 -0600
Content-Disposition: inline
In-Reply-To: <20110804014143.GA32579@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178656>

On Wed, Aug 03, 2011 at 07:41:43PM -0600, Jeff King wrote:

> Look for the example mentioning "pax header" here:
> 
>   http://www.kernel.org/pub/software/scm/git/docs/git-archive.html

BTW, I noticed while looking at this that the HTML versions of the
examples are quite hard to read, as they are formatted in a
proportional-width font. I never noticed because I always just read the
roff-formatted manpages in a monospaced-terminal. We should probably do
this:

-- >8 --
Subject: docs: put listed example commands in backticks

Many examples of git command invocation are given in asciidoc listing
blocks, which makes them monospaced and avoids further interpretation of
special characters.  Some manpages make a list of examples, like:

  git foo::
    Run git foo.

  git foo -q::
    Use the "-q" option.

to quickly show many variants. However, they can sometimes be hard to
read, because they are shown in a proportional-width font (so, for
example, seeing the difference between "-- foo" and "--foo" can be
difficult).

This patch puts all such examples into backticks, which gives the
equivalent formatting to a listing block (i.e., monospaced and without
character interpretation).

As a bonus, this also fixes an example in the git-push manpage, in which
"git push origin :::" was accidentally considered a newly-indented list,
and not a list item with "git push origin :" in it.

Signed-off-by: Jeff King <peff@peff.net>
---
I found all of these with:

  git grep :: Documentation/*.txt | grep 'git '

and then marked up only the examples by hand. Most of the other matches
were fine as-is (i.e., they weren't meant to be code examples). There
was one common type of hit that I didn't convert, but maybe could be,
though. Some of the commands with multiple modes of operation (e.g.,
checkout, diff) use lists like:

  'git diff' [--options] -- [<path>]::
     ...
  'git diff' [--options] --cached [<commit>] [--] [<path>...]::

etc. Those could arguably be monospaced, as well.

I suspect we could replace some invocations of {carat} and other
punctuation inside the newly-backticked text, but it doesn't hurt to
leave it as-is. And I'm paranoid that even if it works on my setup, some
other version of asciidoc will mangle it.

 Documentation/git-archive.txt     |   16 ++++++++--------
 Documentation/git-cherry-pick.txt |   14 +++++++-------
 Documentation/git-grep.txt        |    6 +++---
 Documentation/git-gui.txt         |   16 ++++++++--------
 Documentation/git-log.txt         |   16 ++++++++--------
 Documentation/git-merge-file.txt  |    4 ++--
 Documentation/git-push.txt        |   20 ++++++++++----------
 Documentation/git-remote-fd.txt   |    8 ++++----
 Documentation/git-revert.txt      |    4 ++--
 Documentation/git-rm.txt          |    4 ++--
 Documentation/git-show.txt        |   10 +++++-----
 Documentation/git-tar-tree.txt    |   10 +++++-----
 Documentation/git-whatchanged.txt |    4 ++--
 13 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 1320c87..ac7006e 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -142,41 +142,41 @@ while archiving any tree in your `$GIT_DIR/info/attributes` file.
 
 EXAMPLES
 --------
-git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)::
+`git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)`::
 
 	Create a tar archive that contains the contents of the
 	latest commit on the current branch, and extract it in the
 	`/var/tmp/junk` directory.
 
-git archive --format=tar --prefix=git-1.4.0/ v1.4.0 | gzip >git-1.4.0.tar.gz::
+`git archive --format=tar --prefix=git-1.4.0/ v1.4.0 | gzip >git-1.4.0.tar.gz`::
 
 	Create a compressed tarball for v1.4.0 release.
 
-git archive --format=tar.gz --prefix=git-1.4.0/ v1.4.0 >git-1.4.0.tar.gz::
+`git archive --format=tar.gz --prefix=git-1.4.0/ v1.4.0 >git-1.4.0.tar.gz`::
 
 	Same as above, but using the builtin tar.gz handling.
 
-git archive --prefix=git-1.4.0/ -o git-1.4.0.tar.gz v1.4.0::
+`git archive --prefix=git-1.4.0/ -o git-1.4.0.tar.gz v1.4.0`::
 
 	Same as above, but the format is inferred from the output file.
 
-git archive --format=tar --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} | gzip >git-1.4.0.tar.gz::
+`git archive --format=tar --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} | gzip >git-1.4.0.tar.gz`::
 
 	Create a compressed tarball for v1.4.0 release, but without a
 	global extended pax header.
 
-git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ > git-1.4.0-docs.zip::
+`git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ > git-1.4.0-docs.zip`::
 
 	Put everything in the current head's Documentation/ directory
 	into 'git-1.4.0-docs.zip', with the prefix 'git-docs/'.
 
-git archive -o latest.zip HEAD::
+`git archive -o latest.zip HEAD`::
 
 	Create a Zip archive that contains the contents of the latest
 	commit on the current branch. Note that the output format is
 	inferred by the extension of the output file.
 
-git config tar.tar.xz.command "xz -c"::
+`git config tar.tar.xz.command "xz -c"`::
 
 	Configure a "tar.xz" format for making LZMA-compressed tarfiles.
 	You can use it specifying `--format=tar.xz`, or by creating an
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 6c9c2cb..7cfa3d9 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -112,31 +112,31 @@ effect to your index in a row.
 
 EXAMPLES
 --------
-git cherry-pick master::
+`git cherry-pick master`::
 
 	Apply the change introduced by the commit at the tip of the
 	master branch and create a new commit with this change.
 
-git cherry-pick ..master::
-git cherry-pick ^HEAD master::
+`git cherry-pick ..master`::
+`git cherry-pick ^HEAD master`::
 
 	Apply the changes introduced by all commits that are ancestors
 	of master but not of HEAD to produce new commits.
 
-git cherry-pick master{tilde}4 master{tilde}2::
+`git cherry-pick master{tilde}4 master{tilde}2`::
 
 	Apply the changes introduced by the fifth and third last
 	commits pointed to by master and create 2 new commits with
 	these changes.
 
-git cherry-pick -n master~1 next::
+`git cherry-pick -n master~1 next`::
 
 	Apply to the working tree and the index the changes introduced
 	by the second last commit pointed to by master and by the last
 	commit pointed to by next, but do not create any commit with
 	these changes.
 
-git cherry-pick --ff ..next::
+`git cherry-pick --ff ..next`::
 
 	If history is linear and HEAD is an ancestor of next, update
 	the working tree and advance the HEAD pointer to match next.
@@ -144,7 +144,7 @@ git cherry-pick --ff ..next::
 	are in next but not HEAD to the current branch, creating a new
 	commit for each new change.
 
-git rev-list --reverse master \-- README | git cherry-pick -n --stdin::
+`git rev-list --reverse master \-- README | git cherry-pick -n --stdin`::
 
 	Apply the changes introduced by all commits on the master
 	branch that touched README to the working tree and index,
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 07b3c6a..0627111 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -215,15 +215,15 @@ OPTIONS
 Examples
 --------
 
-git grep {apostrophe}time_t{apostrophe} \-- {apostrophe}*.[ch]{apostrophe}::
+`git grep {apostrophe}time_t{apostrophe} \-- {apostrophe}*.[ch]{apostrophe}`::
 	Looks for `time_t` in all tracked .c and .h files in the working
 	directory and its subdirectories.
 
-git grep -e {apostrophe}#define{apostrophe} --and \( -e MAX_PATH -e PATH_MAX \)::
+`git grep -e {apostrophe}#define{apostrophe} --and \( -e MAX_PATH -e PATH_MAX \)`::
 	Looks for a line that has `#define` and either `MAX_PATH` or
 	`PATH_MAX`.
 
-git grep --all-match -e NODE -e Unexpected::
+`git grep --all-match -e NODE -e Unexpected`::
 	Looks for a line that has `NODE` or `Unexpected` in
 	files that have lines that match both.
 
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 18f713b..0041994 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -50,7 +50,7 @@ version::
 
 Examples
 --------
-git gui blame Makefile::
+`git gui blame Makefile`::
 
 	Show the contents of the file 'Makefile' in the current
 	working directory, and provide annotations for both the
@@ -59,41 +59,41 @@ git gui blame Makefile::
 	uncommitted changes (if any) are explicitly attributed to
 	'Not Yet Committed'.
 
-git gui blame v0.99.8 Makefile::
+`git gui blame v0.99.8 Makefile`::
 
 	Show the contents of 'Makefile' in revision 'v0.99.8'
 	and provide annotations for each line.  Unlike the above
 	example the file is read from the object database and not
 	the working directory.
 
-git gui blame --line=100 Makefile::
+`git gui blame --line=100 Makefile`::
 
 	Loads annotations as described above and automatically
 	scrolls the view to center on line '100'.
 
-git gui citool::
+`git gui citool`::
 
 	Make one commit and return to the shell when it is complete.
 	This command returns a non-zero exit code if the window was
 	closed in any way other than by making a commit.
 
-git gui citool --amend::
+`git gui citool --amend`::
 
 	Automatically enter the 'Amend Last Commit' mode of
 	the interface.
 
-git gui citool --nocommit::
+`git gui citool --nocommit`::
 
 	Behave as normal citool, but instead of making a commit
 	simply terminate with a zero exit code. It still checks
 	that the index does not contain any unmerged entries, so
 	you can use it as a GUI version of linkgit:git-mergetool[1]
 
-git citool::
+`git citool`::
 
 	Same as `git gui citool` (above).
 
-git gui browser maint::
+`git gui browser maint`::
 
 	Show a browser for the tree of the 'maint' branch.  Files
 	selected in the browser can be viewed with the internal
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 59f8be0..6c93466 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -88,45 +88,45 @@ include::diff-generate-patch.txt[]
 
 Examples
 --------
-git log --no-merges::
+`git log --no-merges`::
 
 	Show the whole commit history, but skip any merges
 
-git log v2.6.12.. include/scsi drivers/scsi::
+`git log v2.6.12.. include/scsi drivers/scsi`::
 
 	Show all commits since version 'v2.6.12' that changed any file
 	in the include/scsi or drivers/scsi subdirectories
 
-git log --since="2 weeks ago" \-- gitk::
+`git log --since="2 weeks ago" \-- gitk`::
 
 	Show the changes during the last two weeks to the file 'gitk'.
 	The "--" is necessary to avoid confusion with the *branch* named
 	'gitk'
 
-git log --name-status release..test::
+`git log --name-status release..test`::
 
 	Show the commits that are in the "test" branch but not yet
 	in the "release" branch, along with the list of paths
 	each commit modifies.
 
-git log --follow builtin-rev-list.c::
+`git log --follow builtin-rev-list.c`::
 
 	Shows the commits that changed builtin-rev-list.c, including
 	those commits that occurred before the file was given its
 	present name.
 
-git log --branches --not --remotes=origin::
+`git log --branches --not --remotes=origin`::
 
 	Shows all commits that are in any of local branches but not in
 	any of remote-tracking branches for 'origin' (what you have that
 	origin doesn't).
 
-git log master --not --remotes=*/master::
+`git log master --not --remotes=*/master`::
 
 	Shows all commits that are in local master but not in any remote
 	repository master branches.
 
-git log -p -m --first-parent::
+`git log -p -m --first-parent`::
 
 	Shows the history including change diffs, but only from the
 	"main branch" perspective, skipping commits that come from merged
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 635c669..d7db2a3 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -76,12 +76,12 @@ OPTIONS
 EXAMPLES
 --------
 
-git merge-file README.my README README.upstream::
+`git merge-file README.my README README.upstream`::
 
 	combines the changes of README.my and README.upstream since README,
 	tries to merge them and writes the result into README.my.
 
-git merge-file -L a -L b -L c tmp/a123 tmp/b234 tmp/c345::
+`git merge-file -L a -L b -L c tmp/a123 tmp/b234 tmp/c345`::
 
 	merges tmp/a123 and tmp/c345 with the base tmp/b234, but uses labels
 	`a` and `c` instead of `tmp/a123` and `tmp/c345`.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 88acfcd..49c6e9f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -327,12 +327,12 @@ a case where you do mean to lose history.
 Examples
 --------
 
-git push::
+`git push`::
 	Works like `git push <remote>`, where <remote> is the
 	current branch's remote (or `origin`, if no remote is
 	configured for the current branch).
 
-git push origin::
+`git push origin`::
 	Without additional configuration, works like
 	`git push origin :`.
 +
@@ -344,45 +344,45 @@ use `git config remote.origin.push HEAD`.  Any valid <refspec> (like
 the ones in the examples below) can be configured as the default for
 `git push origin`.
 
-git push origin :::
+`git push origin :`::
 	Push "matching" branches to `origin`. See
 	<refspec> in the <<OPTIONS,OPTIONS>> section above for a
 	description of "matching" branches.
 
-git push origin master::
+`git push origin master`::
 	Find a ref that matches `master` in the source repository
 	(most likely, it would find `refs/heads/master`), and update
 	the same ref (e.g. `refs/heads/master`) in `origin` repository
 	with it.  If `master` did not exist remotely, it would be
 	created.
 
-git push origin HEAD::
+`git push origin HEAD`::
 	A handy way to push the current branch to the same name on the
 	remote.
 
-git push origin master:satellite/master dev:satellite/dev::
+`git push origin master:satellite/master dev:satellite/dev`::
 	Use the source ref that matches `master` (e.g. `refs/heads/master`)
 	to update the ref that matches `satellite/master` (most probably
 	`refs/remotes/satellite/master`) in the `origin` repository, then
 	do the same for `dev` and `satellite/dev`.
 
-git push origin HEAD:master::
+`git push origin HEAD:master`::
 	Push the current branch to the remote ref matching `master` in the
 	`origin` repository. This form is convenient to push the current
 	branch without thinking about its local name.
 
-git push origin master:refs/heads/experimental::
+`git push origin master:refs/heads/experimental`::
 	Create the branch `experimental` in the `origin` repository
 	by copying the current `master` branch.  This form is only
 	needed to create a new branch or tag in the remote repository when
 	the local name and the remote name are different; otherwise,
 	the ref name on its own will work.
 
-git push origin :experimental::
+`git push origin :experimental`::
 	Find a ref that matches `experimental` in the `origin` repository
 	(e.g. `refs/heads/experimental`), and delete it.
 
-git push origin {plus}dev:master::
+`git push origin {plus}dev:master`::
 	Update the origin repository's master branch with the dev branch,
 	allowing non-fast-forward updates.  *This can leave unreferenced
 	commits dangling in the origin repository.*  Consider the
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 4aecd4d..f095d57 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -35,19 +35,19 @@ GIT_TRANSLOOP_DEBUG::
 
 EXAMPLES
 --------
-git fetch fd::17 master::
+`git fetch fd::17 master`::
 	Fetch master, using file descriptor #17 to communicate with
 	git-upload-pack.
 
-git fetch fd::17/foo master::
+`git fetch fd::17/foo master`::
 	Same as above.
 
-git push fd::7,8 master (as URL)::
+`git push fd::7,8 master (as URL)`::
 	Push master, using file descriptor #7 to read data from
 	git-receive-pack and file descriptor #8 to write data to
 	same service.
 
-git push fd::7,8/bar master::
+`git push fd::7,8/bar master`::
 	Same as above.
 
 Documentation
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 3d0a7d1..b311d59 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -93,12 +93,12 @@ effect to your index in a row.
 
 EXAMPLES
 --------
-git revert HEAD~3::
+`git revert HEAD~3`::
 
 	Revert the changes specified by the fourth last commit in HEAD
 	and create a new commit with the reverted changes.
 
-git revert -n master{tilde}5..master{tilde}2::
+`git revert -n master{tilde}5..master{tilde}2`::
 
 	Revert the changes done by commits from the fifth last commit
 	in master (included) to the third last commit in master
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index da0215d..665ad4d 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -137,7 +137,7 @@ git diff --name-only --diff-filter=D -z | xargs -0 git rm --cached
 
 EXAMPLES
 --------
-git rm Documentation/\*.txt::
+`git rm Documentation/\*.txt`::
 	Removes all `*.txt` files from the index that are under the
 	`Documentation` directory and any of its subdirectories.
 +
@@ -145,7 +145,7 @@ Note that the asterisk `*` is quoted from the shell in this
 example; this lets git, and not the shell, expand the pathnames
 of files and subdirectories under the `Documentation/` directory.
 
-git rm -f git-*.sh::
+`git rm -f git-*.sh`::
 	Because this example lets the shell expand the asterisk
 	(i.e. you are listing the files explicitly), it
 	does not remove `subdir/git-foo.sh`.
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 1f0e30b..1e38819 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -48,23 +48,23 @@ include::pretty-formats.txt[]
 EXAMPLES
 --------
 
-git show v1.0.0::
+`git show v1.0.0`::
 	Shows the tag `v1.0.0`, along with the object the tags
 	points at.
 
-git show v1.0.0^\{tree\}::
+`git show v1.0.0^\{tree\}`::
 	Shows the tree pointed to by the tag `v1.0.0`.
 
-git show -s --format=%s v1.0.0^\{commit\}::
+`git show -s --format=%s v1.0.0^\{commit\}`::
 	Shows the subject of the commit pointed to by the
 	tag `v1.0.0`.
 
-git show next~10:Documentation/README::
+`git show next~10:Documentation/README`::
 	Shows the contents of the file `Documentation/README` as
 	they were current in the 10th last commit of the branch
 	`next`.
 
-git show master:Makefile master:t/Makefile::
+`git show master:Makefile master:t/Makefile`::
 	Concatenates the contents of said Makefiles in the head
 	of the branch `master`.
 
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 95b135d..346e7a2 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -53,26 +53,26 @@ tar.umask::
 
 EXAMPLES
 --------
-git tar-tree HEAD junk | (cd /var/tmp/ && tar xf -)::
+`git tar-tree HEAD junk | (cd /var/tmp/ && tar xf -)`::
 
 	Create a tar archive that contains the contents of the
 	latest commit on the current branch, and extracts it in
 	`/var/tmp/junk` directory.
 
-git tar-tree v1.4.0 git-1.4.0 | gzip >git-1.4.0.tar.gz::
+`git tar-tree v1.4.0 git-1.4.0 | gzip >git-1.4.0.tar.gz`::
 
 	Create a tarball for v1.4.0 release.
 
-git tar-tree v1.4.0{caret}\{tree\} git-1.4.0 | gzip >git-1.4.0.tar.gz::
+`git tar-tree v1.4.0{caret}\{tree\} git-1.4.0 | gzip >git-1.4.0.tar.gz`::
 
 	Create a tarball for v1.4.0 release, but without a
 	global extended pax header.
 
-git tar-tree --remote=example.com:git.git v1.4.0 >git-1.4.0.tar::
+`git tar-tree --remote=example.com:git.git v1.4.0 >git-1.4.0.tar`::
 
 	Get a tarball v1.4.0 from example.com.
 
-git tar-tree HEAD:Documentation/ git-docs > git-1.4.0-docs.tar::
+`git tar-tree HEAD:Documentation/ git-docs > git-1.4.0-docs.tar`::
 
 	Put everything in the current head's Documentation/ directory
 	into 'git-1.4.0-docs.tar', with the prefix 'git-docs/'.
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 99388bd..76c7f7e 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -53,12 +53,12 @@ include::pretty-formats.txt[]
 
 Examples
 --------
-git whatchanged -p v2.6.12.. include/scsi drivers/scsi::
+`git whatchanged -p v2.6.12.. include/scsi drivers/scsi`::
 
 	Show as patches the commits since version 'v2.6.12' that changed
 	any file in the include/scsi or drivers/scsi subdirectories
 
-git whatchanged --since="2 weeks ago" \-- gitk::
+`git whatchanged --since="2 weeks ago" \-- gitk`::
 
 	Show the changes during the last two weeks to the file 'gitk'.
 	The "--" is necessary to avoid confusion with the *branch* named
