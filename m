From: Jon Loeliger <jdl@freescale.com>
Subject: [BUG] ProgramError: merge ... .merge_file_4CPoEQ: No such file
Date: Tue, 06 Dec 2005 08:03:38 -0600
Message-ID: <E1EjdPu-00034z-Hu@jdl.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 15:03:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjdQ5-00030Z-7F
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 15:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVLFODp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 09:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVLFODp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 09:03:45 -0500
Received: from mail.jdl.com ([66.118.10.122]:29159 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932563AbVLFODo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 09:03:44 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EjdPu-00034z-Hu
	for git@vger.kernel.org; Tue, 06 Dec 2005 08:03:39 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13275>


So, I was surprised by this display this morning.
(I swear I'm trying to help! :-)

I grabbed new (7:30 CST Dec 6) top-of-git, built and installed it.
I then "git checkout jdl" and "git pull . origin" to bring my
branch up to date.  It looked like this just before the pull
into branch "jdl":

jdl@ubuntu:/usr/src/git-core$ git show-branch jdl master origin
* [jdl] Added documentation for few missing options.
 ! [master] git-merge-one-file: resurrect leading path creation.
  ! [origin] git-merge-one-file: resurrect leading path creation.
---
 ++ [master] git-merge-one-file: resurrect leading path creation.
 ++ [master^] Documentaiton (read-tree): update description of 3-way
 ++ [master~2] Documentation: hash-object.
 ++ [master~3] write-tree: check extra arguments and die but be a bit more helpful.
 ++ [master~4] init-db: check extra arguments and complain.
 ++ [master~5] hash-object: -- and --help
 ++ [master~6] Added documentation for few missing options.
+   [jdl] Added documentation for few missing options.
+   [jdl^] Merge branch 'origin'
+++ [master~7] git-mv to work with Perl 5.6

jdl@ubuntu:/usr/src/git-core$ git status
# On branch refs/heads/jdl
nothing to commit

jdl@ubuntu:/usr/src/git-core$ git pull . origin
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with be61db922a230ae2638c27c071ee4b8c98f01f72
Merging:
4baf91676c2462796137e93917c75f2e14ebb877 Added documentation for few missing options.
be61db922a230ae2638c27c071ee4b8c98f01f72 git-merge-one-file: resurrect leading path creation.
found 1 common ancestor(s):
23c99d84601316c1e51ebc1f0b9bec5cddd011fb git-mv to work with Perl 5.6
Auto-merging Documentation/git-read-tree.txt
Traceback (most recent call last):
  File "/home/jdl/bin/git-merge-recursive", line 868, in ?
    firstBranch, secondBranch, graph)
  File "/home/jdl/bin/git-merge-recursive", line 87, in merge
    branch1Name, branch2Name)
  File "/home/jdl/bin/git-merge-recursive", line 160, in mergeTrees
    if not processEntry(entry, branch1Name, branch2Name):
  File "/home/jdl/bin/git-merge-recursive", line 821, in processEntry
    branch1Name, branch2Name)
  File "/home/jdl/bin/git-merge-recursive", line 212, in mergeFile
    src1, orig, src2], returnCode=True)
  File "/home/jdl/share/git-core/python/gitMergeCommon.py", line 72, in runProgram
    raise ProgramError(progStr, e.strerror)
ProgramError: merge -L HEAD/Documentation/git-read-tree.txt -L orig/Documentation/git-read-tree.txt -L be61db922a230ae2638c27c071ee4b8c98f01f72/Documentation/git-read-tree.txt .merge_file_DamWnQ .merge_file_U9K5YP .merge_file_4CPoEQ: No such file or directory
No merge strategy handled the merge.

jdl@ubuntu:/usr/src/git-core$ ll Documentation/git-read-tree.txt .merge*
12 -rw-r--r--  1 jdl jdl 10464 2005-12-06 07:46 Documentation/git-read-tree.txt
12 -rw-------  1 jdl jdl 11469 2005-12-06 07:47 .merge_file_4CPoEQ
12 -rw-------  1 jdl jdl 10464 2005-12-06 07:47 .merge_file_DamWnQ
12 -rw-------  1 jdl jdl 10339 2005-12-06 07:47 .merge_file_U9K5YP


jdl@ubuntu:/usr/src/git-core$ git status
# On branch refs/heads/jdl
#
# Updated but not checked in:
#   (will commit)
#
#       modified: Documentation/git-hash-object.txt
#       modified: git-merge-one-file.sh
#       modified: hash-object.c
#       modified: init-db.c
#       modified: write-tree.c
#
#
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       unmerged: Documentation/git-read-tree.txt
#       modified: Documentation/git-read-tree.txt
#
#
# Untracked files:
#   (use "git add" to add to commit)
#
#       .merge_file_4CPoEQ
#       .merge_file_DamWnQ
#       .merge_file_U9K5YP
