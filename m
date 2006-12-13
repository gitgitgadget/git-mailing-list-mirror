X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: svn versus git
Date: Wed, 13 Dec 2006 22:00:37 +0000
Message-ID: <200612132200.41420.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 22:03:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VO0udrnP7VkXN7X2oQuFLCZPSRZG4CGGMV34ktIDav6W2EQfpcTyN51Kh2AOhdx9t9sMn3OKIfkUwh2ISEMKjjFo1POgUcsZSYMJPRcoT89/OuctDg5IsMT+GECRI48WeVzy0iPw4lcUnXwEr1PkUOwrFAZPrXyzrGjB0PM0v30=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34236>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GucCS-0005Nd-0y for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751615AbWLMWDh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWLMWDh
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:03:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:56988 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751613AbWLMWDg (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 17:03:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so303342uga for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 14:03:34 -0800 (PST)
Received: by 10.67.19.17 with SMTP id w17mr223423ugi.1166047414269; Wed, 13
 Dec 2006 14:03:34 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id s7sm1517760uge.2006.12.13.14.03.28; Wed, 13 Dec
 2006 14:03:33 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

With all the discussion about user interface difficulties, I started to write 
a comparison with subversion document.  (I was assuming that people find 
subversion easy).  As much as I love git, I was expecting to find that it's 
hard to use interface would have subversion as the clear winner.  I was 
hoping that would then give guidance as to what could be fixed in git.

I was surprised, therefore, to find that in each case I was finding that git 
was the winner.

This is only the first draft, so it's not very pretty; given that I now think 
it's fairly pointless, I doubt very much that there will be a second draft.  
However, before I consign it to the waste bin; I thought I'd share what I had 
in case someone here had a use for it.

Executive summary: for the subset of features that git supplies that would 
make it a subversion replacement; the UI for git is broadly compatible and 
mostly better.  The areas that make git look scary are:
 - git-clone
 - git-checkout
 - git-help
 - "svn cat" is missing from git
 - git-ls-tree
 - git-fsck-objects/git-repack/git-prune
 - "svn revert" is missing from git

As always, please take the following with liberal amounts of IMHO.


---------------------------------
Subversion Versus Git
=====================
Andy Parkins <andyparkins@gmail.com>


Introduction
------------

Git is often accused of having a difficult user interface.  I had
imagined that was the case too.  I decided to write this comparison to
show the areas for which a simple version control system (like
subversion) had got the user interface right, and git had it wrong.

I was surprised to find that the areas of difficulty were a lot fewer
than I had expected.  There is no reason why a user familiar with
subversion couldn't quickly cope with git's commands.   I realised I had
been looking at Subversion through rose-tinted glasses.  For the set of
features that Subversion supports, git is just as easy to use - if not
easier.

Note that this comparison is not of features, but of interface.  Git
easily wins in terms of features.  When it comes to using the more
advanced features of git, for which there is no Subversion equivalent,
then obviously there will be things to be learned.  This comparison
however is limited to the subset of features of git that would make it
as near an equivalent to subversion as possible.


Comparison
----------

svn add::
Put files and directories under version control, scheduling them for
addition to repository.  They will be added in next commit.  This
doesn't really add anything, it just schedules.
git add::
Add files to the index file.  This command does not simply schedule.  It
takes the current contents of the file and copies it to the git staging
area.

The git index makes this command more complicated for git; however git
is using the verb "add" more correctly.  In the subversion case, nothing
is actually added to a repository, it is merely scheduled for addition.
Although one could argue that by its nature, everything in subversion is
merely scheduling the action.  Subversion being inherently simpler,
makes this easier to understand for the subversion user.


svn blame::
Output the content of specified files or URLs with revision and author
information inline.
git blame::
Show what revision and author last modified each line of a file.

This one is a draw.  However, in terms of output, git is signficantly
better, it is much more intelligent about renames and copies and is much
faster.


svn cat::
Output the contents of specified files or URLs.  Optionally at a
specific revision.
git cat-file -p $(git-ls-tree $REV $file | cut -d " " -f 3 | cut -f 1)::
git-ls-tree lists the object ID for $file in revision $REV, this is cut
out of the output and used as an argument to git-cat-file, which should
really be called git-cat-object, and simply dumps that object to stdout.

Subversion wins.  This is a distinctly non-user friendly way of reading
a file.


svn checkout::
Checkout a working copy from a repository.  You may check out an
arbitrary revision.
git clone::
git checkout::
Git, of course, is different from subversion, as the whole repository is
always available.  git-checkout is nearest in concept to svn-checkout
though.  It changes the current working directory to a particular
branch.  You may not checkout an arbitrary revision.  git-clone might
also be considered as an svn checkout analog.  However, 

Subversion wins.  The output from Subversion's checkout is clear.  The
output from git-clone gives output that is only understandable by
someone familiar with git internals.


svn cleanup::
Recursively clean up the working copy, removing locks, resuming
unfinished operations, etc.
git fsck-objects::
git prune::
git repack::
Check the repository for consistency, remove unreferenced objects, or
recompress existing objects.

They don't really serve the exact same purpose, but they are all
maintenance commands.

Subversion wins, as it only has one command and you don't need to
understand the repository in order to understand what its doing.


svn commit::
Pushes changes to the upstream respository from your working copy.
git commit -a::
Saves changes to the working copy as a new revision in the local
repository.

The need for "-a" (or not) because of git's staging area (the index)
here makes it more confusing than svn-commit for new users.  However,
the ability to do "git --amend" more than makes up for it.  Fixing a
typo in your last log message is difficult in subversion.  Also, git's
commit message template is much better: both uses the output of their
status commands which is far clearer in git than in Subversion.

Git wins.


svn copy::
Duplicate something in working copy or repository, remembering history.
cp A B; git add B::
Git doesn't have a direct equivalent of svn copy.  It's arguable whether
it needs it once the user knows they can git-add so easily.

Git wins.  Git's ability to detect copies after-the-fact, mean that a
git-copy isn't necessary.


svn delete::
Remove files and directories from version control.
git rm::
Remove files from the working copy and the staging area.

Git wins.  Git wins this because it doesn't need the git-rm at all.  It
notices when a file has been removed anyway in git-commit -a; so for
this comparison, we can say that git-rm is not needed.  For more complex
cases, were a user wants to remove a file from version control, but not
from disk, git-rm might be needed.


svn diff::
Display the differences between two paths.  Defaults to showing the
differences between HEAD and the working copy.
git diff::
As for svn; but is arguably more powerful.  It also has the distinct
advantage that it colourises its output, making it much easier to read.

Git wins.  More powerful functionality available, but its default output
is fine as it is.


svn export::
Create an unversioned copy of a tree.
git archive::
Creates an archive of the files in the named tree.

Git wins.  It can make zip/tar directly and add directory prefixes
should you want them.  It could perhaps be a modicum easier if it had a
default output format so that "git-archive HEAD" would do something.


svn help::
git help::
Both of these operate in the same way, so this one will be judged on
utility of the output.

Subversion wins.  The output from subversion often fits on a single
screen, and is merely there to give a reminder of what each option does.
git help simply forwards the user to a man page; which is very thorough,
but usually more than you need for a quick reference.


svn import::
Commit an unversioned file or tree into the repository.
git-init-db; git-add::
Git doesn't import external trees.  Mainly because it doesn't need to.
Any directory can be quickly turned into a repository because
git-init-db and git-add are so fast.  It can easily be turned back
because git only keeps one special directory (".git") at the top of the
working tree whereas subversion keeps one ".svn" directory per working
directory.  Conversely, there is no way in subversion to adopt an
existing directory structure.  It must be imported then checked out
somewhere else.

Git wins.  It's fast and simple.  There is only the most minimal change
to the users working tree.


svn info::
Display information about a local or remote item.
[no git equivalent]::
Apart from manually running git-log, git-show, git-diff, etc.  There is
no way to get the simple summary that subversion provides about a given
item.


svn list::
List directory entries in the repository.  Showing an arbitrary revision
if wanted.
git ls-tree::
Lists the content of a tree object.

Subversion wins.  The output of git-ls-tree is not user friendly; it
requires some understanding of git internals.

svn lock::
svn unlock::
Lock working copy paths in the repository so that no other user can
commit changes to them.
[no git equivalent]::
Git can't do this; nor should it.  Your repository is your own so there
is no point in locking any part of it.

Git wins.  Being distributed makes this function unnecessary in git.
This makes one less command to learn.


svn log::
Show the log messages for a set of revision(s) and/or file(s).
git log::
Show commit logs.

Git wins.  The log command is equally as simple to use, but git supports
more output formats (--pretty=online I find particularly useful).  It
also colours it and formats it for much easier viewing.  It can also
accept much more human-convenient filters (git log --since="2 weeks
ago").


svn merge::
Apply the differences between two sources to a working copy path.
git pull::
Pull and merge from another repository or a local branch.

It could be argued that "pull" is a bad name for this command.  Apart
from that however, git-pull is significantly easier to use than svn
merge.  It's output isn't as easy to understand, as it dumps loads of
confusing information to the user.

Git wins.  Once you've used it, it's nowhere near as terrifying to use,
because it can be easily undone.  It's harder to do damage because git
tracks merges whereas svn doesn't.  It's better at merging.  You will
spend a good five minutes thinking about what you must type for an
svn-merge.  git-pull is a no-brainer.


svn mkdir::
Create a new directory under version control.
[no git equivalent]::
Git doesn't track directories, so doesn't need this command.  Simply
adding content that is in a subdirectory is sufficient.

Git wins.   It does the right thing for you and you needn't remember to
wrap your "mkdir"s with your VCS.  Also, one-less-command.


svn move::
Move and/or rename something in working copy or repository.
git-mv::
Move or rename a file, directory or symlink.

Git wins.  The two are equivalent except that git can do multiple moves
in one command, just like normal "mv".  So "git mv src/* newsrc/" works
while "svn mv src/* newsrc/" doesn't.  Additionally, if you forget to do
moves with git and instead use the command line, you can easily use
"update-index" to tell git about the move after the fact.  In subversion
you have to undo all the moves and do them again with subversion.  This
makes it inconvenient to use tools like "rename" to do regexp moves.


svn resolved::
Remove 'conflicted' state on working copy files or directories.
git update-index::
git checkout::
Git doesn't have a direct "resolved"; after you fix conflicts, you push
the changes into the staging area with "git-update-index".
Alternatively you can simply accept the version in HEAD by checking out
that version.

Draw.  "svn-resolved" is rubbish, as it doesn't do any checks, it just
removes the conflict markers.  Git could do with something that makes
life easier than understanding the index.


svn revert::
Restore pristine working copy file (undo most local edits).
git reset --hard::
Reset the repository to an arbitrary point in the past, updating the
working copy as well.
git checkout -f HEAD <file>::
Checks out <file> from HEAD, forcing an overwrite of any working
directory changes to that file.

Draw.  There is no easy way to undo changes that have already been
committed to a subversion repository, so git would win.  However, it's
uncomfortable to revert a single file using checkout.


svn status::
Print the status of working copy files and directories.
git status::
Show working tree status.

Git wins.  Git's status output is colorised and doesn't rely on you
remembering single letter codes for file status.  Instead is arranges
the changes in sections and describes the status in English.  It shows
renames clearly, and sorts the file list instead of leaving it in a
random order (which makes it difficult to find particular files).


svn switch::
Update the working copy to a different URL.
[no git equivalent]::
git is distributed and can fetch from any number of remote repositories.
The URL can be typed on the command line of git-fetch, or can be given a
shortcut as a "remote".  If we're talking about a single repository
(which we have to to compare against subversion), the repository is
local anyway.

Git wins.  Command is unnecessary.


svn update::
Bring changes from the repository into the working copy.
git fetch; git pull::
git-fetch synchronises a tracking branch with a remote repository.  Git
pull can be used to merge those changes into your working branch.

Git wins.  The ability to track an upstream repository in a separate
branch, without having to merge until you're ready is a boon.  The
commands "git-fetch" and "git-pull" are badly named, but the fact that
they are separate functions makes it far less traumatic to regularly run
"git-fetch" than "svn update".


[no svn equivalent]::
git ls-files::
Information about files in the index/working directory.

Git wins.  git-ls-files can show modified files, tracked files, ignored
files, deleted files, untracked files - all in a format that is easily
piped to other commands.  


Discussion
----------

What would git need to do to win in every section?

Subversion won:
 - svn cat: the git equivalent is too complicated.
   It wouldn't be hard to write a git-cat; if git's aliases allowed
   pipes, it could be done instantly.
 - svn checkout: the output from git-clone is unfriendly.
   -------------------
   remote: Generating pack...
   remote: Done counting 6 objects.
   remote: Deltifying 6 objects.
   remote:  100% (6/6) done
   Indexing 6 objects.
   remote: Total 6, written 6 (delta 0), reused 0 (delta 0)
    100% (6/6) done
   -------------------
   What are "objects"?  What is deltifying?  Why does object count
   matter to me?  What is indexing?  How much data was transferred?  How
   long did it take?  How big is my local clone?
   
   While transferring: how long is it going to take to finish?  How much
   data is there to transfer in total?
 - svn list: this only wins because the default output of git-ls-tree is
   so user unfriendly.
 - svn cleanup: git-fsck-objects, git-prune and git-repack all need too
   specific knowledge of git.
   
   They also need running too often on the user's initiative.  It would
   be nice, for example, if git-reset, git-rebase and git-branch could
   detect when a prune is going to be needed and give the user a hint.

   As to git-repack and git-fsck-objects - when _should_ these be run?
   How is the user meant to know?
 - svn help: subversion only won this because the help for almost every
   command fits on a page.  Git commands have so many options that need
   such a lot of explanation that it's almost impossible to think of a
   way that this problem could be solved.

Git draws with Subversion:
 - svn resolved: Subversion only knows files are conflicted because they
   are marked as such.  git has good ways of detecting conflicting files
   but has no interface around them.  It would be nice to have a
   git-resolve command that could pick "ours", "theirs" or "mine" and
   update the index accordingly.
 - svn revert: it's not easy to revert a single file in git; especially
   once we bring the index into play.  Restoring a single file in the index
   to HEAD while leaving the rest of the index AND the working directory
   untouched requires something like 
   ----------------------------------------------------
   git-ls-tree file | git-update-index --index-info
   ----------------------------------------------------
   Which isn't simple enough for a typical user.


Conclusion
----------

Git is a perfectly adequate Subversion replacement.  For a user who
would only want the features that they already have, they could surely
get to grips with the git UI quickly.

---------------------------------


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
