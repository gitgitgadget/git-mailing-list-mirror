From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.2-rc3
Date: Thu, 07 Mar 2013 15:13:59 -0800
Message-ID: <7v7glils5k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Mar 08 00:14:42 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UDk1I-0008Ts-Q3
	for glk-linux-kernel-3@plane.gmane.org; Fri, 08 Mar 2013 00:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759990Ab3CGXOG (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 7 Mar 2013 18:14:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759936Ab3CGXOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Mar 2013 18:14:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79791BE31;
	Thu,  7 Mar 2013 18:14:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=S
	jVZi4Bmqz03xZRjWWsvjoRK0yY=; b=lcVDVqTuRFxSzHqmGZAloRU1zfVLBRJTW
	J0xrWD1FLM48FmeA8F5G/feVPXiKQqGgna35qqch+h6v3hpmGZoYr2PfePXxyU3u
	8jUzTBA8vGeFbCFS/TAUmm2JgQeIzw4+TCe4TdrlLSwS8BbNRHXkicbzqp7KkQe3
	1b6ntsQgl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=PQw3udIaEB+pmNkNs1awWWRdVo8NUvdJimw2tNwtUuVBpOt7eAbBKuPk
	DXzvrrl+p+6uMDv7blOp1ZRLBOf8leDKymZHQB0uxEOgW41V1jLJNEV3OGV0LSaU
	K5xo2ihEuZFlrkA7OcDUNx8uVs5jc97OZBJ9akFtJmLeLuAFd8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DBE6BE30;
	Thu,  7 Mar 2013 18:14:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB265BE2F; Thu,  7 Mar 2013
 18:14:00 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B22FD876-877C-11E2-8492-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217625>

A release candidate Git v1.8.2-rc3 is now available for testing
at the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

3fe30d85cea78a388d61ba79fe3a106fca41cfbe  git-1.8.2.rc3.tar.gz
4b378cf6129fa4c9355436b93a698dde2ed4ce7a  git-htmldocs-1.8.2.rc3.tar.gz
b18a1f2e70920b5028f1179cc4b362ad78a6f34c  git-manpages-1.8.2.rc3.tar.gz

Also the following public repositories all have a copy of the v1.8.2-rc3
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.8.2 Release Notes (draft)
========================

Backward compatibility notes
----------------------------

In the next major release Git 2.0 (not *this* one), we will change the
behavior of the "git push" command.

When "git push [$there]" does not say what to push, we have used the
traditional "matching" semantics so far (all your branches were sent
to the remote as long as there already are branches of the same name
over there).  We will use the "simple" semantics that pushes the
current branch to the branch with the same name, only when the current
branch is set to integrate with that remote branch.  There is a user
preference configuration variable "push.default" to change this.

"git push $there tag v1.2.3" used to allow replacing a tag v1.2.3
that already exists in the repository $there, if the rewritten tag
you are pushing points at a commit that is a descendant of a commit
that the old tag v1.2.3 points at.  This was found to be error prone
and starting with this release, any attempt to update an existing
ref under refs/tags/ hierarchy will fail, without "--force".

When "git add -u" and "git add -A", that does not specify what paths
to add on the command line, is run from inside a subdirectory, the
scope of the operation has always been limited to the subdirectory.
Many users found this counter-intuitive, given that "git commit -a"
and other commands operate on the entire tree regardless of where you
are. In this release, these commands give warning in such a case and
encourage the user to say "git add -u/-A ." instead when restricting
the scope to the current directory.

At Git 2.0 (not *this* one), we plan to change these commands without
pathspec to operate on the entire tree.  Forming a habit to type "."
when you mean to limit the command to the current working directory
will protect you against the planned future change, and that is the
whole point of the new message (there will be no configuration
variable to squelch this warning---it goes against the "habit forming"
objective).


Updates since v1.8.1
--------------------

UI, Workflows & Features

 * Initial ports to QNX and z/OS UNIX System Services have started.

 * Output from the tests is coloured using "green is okay, yellow is
   questionable, red is bad and blue is informative" scheme.

 * Mention of "GIT/Git/git" in the documentation have been updated to
   be more uniform and consistent.  The name of the system and the
   concept it embodies is "Git"; the command the users type is "git".
   All-caps "GIT" was merely a way to imitate "Git" typeset in small
   caps in our ASCII text only documentation and to be avoided.

 * The completion script (in contrib/completion) used to let the
   default completer to suggest pathnames, which gave too many
   irrelevant choices (e.g. "git add" would not want to add an
   unmodified path).  It learnt to use a more git-aware logic to
   enumerate only relevant ones.

 * In bare repositories, "git shortlog" and other commands now read
   mailmap files from the tip of the history, to help running these
   tools in server settings.

 * Color specifiers, e.g. "%C(blue)Hello%C(reset)", used in the
   "--format=" option of "git log" and friends can be disabled when
   the output is not sent to a terminal by prefixing them with
   "auto,", e.g. "%C(auto,blue)Hello%C(auto,reset)".

 * Scripts can ask Git that wildcard patterns in pathspecs they give do
   not have any significance, i.e. take them as literal strings.

 * The patterns in .gitignore and .gitattributes files can have **/,
   as a pattern that matches 0 or more levels of subdirectory.
   E.g. "foo/**/bar" matches "bar" in "foo" itself or in a
   subdirectory of "foo".

 * When giving arguments without "--" disambiguation, object names
   that come earlier on the command line must not be interpretable as
   pathspecs and pathspecs that come later on the command line must
   not be interpretable as object names.  This disambiguation rule has
   been tweaked so that ":/" (no other string before or after) is
   always interpreted as a pathspec; "git cmd -- :/" is no longer
   needed, you can just say "git cmd :/".

 * Various "hint" lines Git gives when it asks the user to edit
   messages in the editor are commented out with '#' by default. The
   core.commentchar configuration variable can be used to customize
   this '#' to a different character.

 * "git add -u" and "git add -A" without pathspec issues warning to
   make users aware that they are only operating on paths inside the
   subdirectory they are in.  Use ":/" (everything from the top) or
   "." (everything from the $cwd) to disambiguate.

 * "git blame" (and "git diff") learned the "--no-follow" option.

 * "git branch" now rejects some nonsense combinations of command line
   arguments (e.g. giving more than one branch name to rename) with
   more case-specific error messages.

 * "git check-ignore" command to help debugging .gitignore files has
   been added.

 * "git cherry-pick" can be used to replay a root commit to an unborn
   branch.

 * "git commit" can be told to use --cleanup=whitespace by setting the
   configuration variable commit.cleanup to 'whitespace'.

 * "git diff" and other Porcelain commands can be told to use a
   non-standard algorithm by setting diff.algorithm configuration
   variable.

 * "git fetch --mirror" and fetch that uses other forms of refspec
   with wildcard used to attempt to update a symbolic ref that match
   the wildcard on the receiving end, which made little sense (the
   real ref that is pointed at by the symbolic ref would be updated
   anyway).  Symbolic refs no longer are affected by such a fetch.

 * "git format-patch" now detects more cases in which a whole branch
   is being exported, and uses the description for the branch, when
   asked to write a cover letter for the series.

 * "git format-patch" learned "-v $count" option, and prepends a
   string "v$count-" to the names of its output files, and also
   automatically sets the subject prefix to "PATCH v$count". This
   allows patches from rerolled series to be stored under different
   names and makes it easier to reuse cover letter messages.

 * "git log" and friends can be told with --use-mailmap option to
   rewrite the names and email addresses of people using the mailmap
   mechanism.

 * "git log --cc --graph" now shows the combined diff output with the
   ancestry graph.

 * "git log --grep=<pattern>" honors i18n.logoutputencoding to look
   for the pattern after fixing the log message to the specified
   encoding.

 * "git mergetool" and "git difftool" learned to list the available
   tool backends in a more consistent manner.

 * "git mergetool" is aware of TortoiseGitMerge now and uses it over
   TortoiseMerge when available.

 * "git push" now requires "-f" to update a tag, even if it is a
   fast-forward, as tags are meant to be fixed points.

 * Error messages from "git push" when it stops to prevent remote refs
   from getting overwritten by mistake have been improved to explain
   various situations separately.

 * "git push" will stop without doing anything if the new "pre-push"
   hook exists and exits with a failure.

 * When "git rebase" fails to generate patches to be applied (e.g. due
   to oom), it failed to detect the failure and instead behaved as if
   there were nothing to do.  A workaround to use a temporary file has
   been applied, but we probably would want to revisit this later, as
   it hurts the common case of not failing at all.

 * Input and preconditions to "git reset" has been loosened where
   appropriate.  "git reset $fromtree Makefile" requires $fromtree to
   be any tree (it used to require it to be a commit), for example.
   "git reset" (without options or parameters) used to error out when
   you do not have any commits in your history, but it now gives you
   an empty index (to match non-existent commit you are not even on).

 * "git status" says what branch is being bisected or rebased when
   able, not just "bisecting" or "rebasing".

 * "git submodule" started learning a new mode to integrate with the
   tip of the remote branch (as opposed to integrating with the commit
   recorded in the superproject's gitlink).

 * "git upload-pack" which implements the service "ls-remote" and
   "fetch" talk to can be told to hide ref hierarchies the server
   side internally uses (and that clients have no business learning
   about) with transfer.hiderefs configuration.


Foreign Interface

 * "git fast-export" has been updated for its use in the context of
   the remote helper interface.

 * A new remote helper to interact with bzr has been added to contrib/.

 * "git p4" got various bugfixes around its branch handling.  It is
   also made usable with Python 2.4/2.5.  In addition, its various
   portability issues for Cygwin have been addressed.

 * The remote helper to interact with Hg in contrib/ has seen a few
   fixes.


Performance, Internal Implementation, etc.

 * "git fsck" has been taught to be pickier about entries in tree
   objects that should not be there, e.g. ".", ".git", and "..".

 * Matching paths with common forms of pathspecs that contain wildcard
   characters has been optimized further.

 * We stopped paying attention to $GIT_CONFIG environment that points
   at a single configuration file from any command other than "git config"
   quite a while ago, but "git clone" internally set, exported, and
   then unexported the variable during its operation unnecessarily.

 * "git reset" internals has been reworked and should be faster in
   general. We tried to be careful not to break any behaviour but
   there could be corner cases, especially when running the command
   from a conflicted state, that we may have missed.

 * The implementation of "imap-send" has been updated to reuse xml
   quoting code from http-push codepath, and lost a lot of unused
   code.

 * There is a simple-minded checker for the test scripts in t/
   directory to catch most common mistakes (it is not enabled by
   default).

 * You can build with USE_WILDMATCH=YesPlease to use a replacement
   implementation of pattern matching logic used for pathname-like
   things, e.g. refnames and paths in the repository.  This new
   implementation is not expected change the existing behaviour of Git
   in this release, except for "git for-each-ref" where you can now
   say "refs/**/master" and match with both refs/heads/master and
   refs/remotes/origin/master.  We plan to use this new implementation
   in wider places (e.g. "git ls-files '**/Makefile' may find Makefile
   at the top-level, and "git log '**/t*.sh'" may find commits that
   touch a shell script whose name begins with "t" at any level) in
   future versions of Git, but we are not there yet.  By building with
   USE_WILDMATCH, using the resulting Git daily and reporting when you
   find breakages, you can help us get closer to that goal.

 * Some reimplementations of Git do not write all the stat info back
   to the index due to their implementation limitations (e.g. jgit).
   A configuration option can tell Git to ignore changes to most of
   the stat fields and only pay attention to mtime and size, which
   these implementations can reliably update.  This can be used to
   avoid excessive revalidation of contents.

 * Some platforms ship with old version of expat where xmlparse.h
   needs to be included instead of expat.h; the build procedure has
   been taught about this.

 * "make clean" on platforms that cannot compute header dependencies
   on the fly did not work with implementations of "rm" that do not
   like an empty argument list.

Also contains minor documentation updates and code clean-ups.


Fixes since v1.8.1
------------------

Unless otherwise noted, all the fixes since v1.8.1 in the maintenance
track are contained in this release (see release notes to them for
details).

 * An element on GIT_CEILING_DIRECTORIES list that does not name the
   real path to a directory (i.e. a symbolic link) could have caused
   the GIT_DIR discovery logic to escape the ceiling.

 * When attempting to read the XDG-style $HOME/.config/git/config and
   finding that $HOME/.config/git is a file, we gave a wrong error
   message, instead of treating the case as "a custom config file does
   not exist there" and moving on.

 * The behaviour visible to the end users was confusing, when they
   attempt to kill a process spawned in the editor that was in turn
   launched by Git with SIGINT (or SIGQUIT), as Git would catch that
   signal and die.  We ignore these signals now.
   (merge 0398fc34 pf/editor-ignore-sigint later to maint).

 * A child process that was killed by a signal (e.g. SIGINT) was
   reported in an inconsistent way depending on how the process was
   spawned by us, with or without a shell in between.

 * After failing to create a temporary file using mkstemp(), failing
   pathname was not reported correctly on some platforms.

 * We used to stuff "user@" and then append what we read from
   /etc/mailname to come up with a default e-mail ident, but a bug
   lost the "user@" part.

 * The attribute mechanism didn't allow limiting attributes to be
   applied to only a single directory itself with "path/" like the
   exclude mechanism does.  The initial implementation of this that
   was merged to 'maint' and 1.8.1.2 was with a severe performance
   degradations and needs to merge a fix-up topic.

 * The smart HTTP clients forgot to verify the content-type that comes
   back from the server side to make sure that the request is being
   handled properly.

 * "git am" did not parse datestamp correctly from Hg generated patch,
   when it is run in a locale outside C (or en).

 * "git apply" misbehaved when fixing whitespace breakages by removing
   excess trailing blank lines.

 * "git apply --summary" has been taught to make sure the similarity
   value shown in its output is sensible, even when the input had a
   bogus value.

 * A tar archive created by "git archive" recorded a directory in a
   way that made NetBSD's implementation of "tar" sometimes unhappy.

 * "git archive" did not record uncompressed size in the header when
   streaming a zip archive, which confused some implementations of unzip.

 * "git archive" did not parse configuration values in tar.* namespace
   correctly.
   (merge b3873c3 jk/config-parsing-cleanup later to maint).

 * Attempt to "branch --edit-description" an existing branch, while
   being on a detached HEAD, errored out.

 * "git clean" showed what it was going to do, but sometimes end up
   finding that it was not allowed to do so, which resulted in a
   confusing output (e.g. after saying that it will remove an
   untracked directory, it found an embedded git repository there
   which it is not allowed to remove).  It now performs the actions
   and then reports the outcome more faithfully.

 * When "git clone --separate-git-dir=$over_there" is interrupted, it
   failed to remove the real location of the $GIT_DIR it created.
   This was most visible when interrupting a submodule update.

 * "git cvsimport" mishandled timestamps at DST boundary.

 * We used to have an arbitrary 32 limit for combined diff input,
   resulting in incorrect number of leading colons shown when showing
   the "--raw --cc" output.

 * "git fetch --depth" was broken in at least three ways.  The
   resulting history was deeper than specified by one commit, it was
   unclear how to wipe the shallowness of the repository with the
   command, and documentation was misleading.
   (merge cfb70e1 nd/fetch-depth-is-broken later to maint).

 * "git log --all -p" that walked refs/notes/textconv/ ref can later
   try to use the textconv data incorrectly after it gets freed.

 * We forgot to close the file descriptor reading from "gpg" output,
   killing "git log --show-signature" on a long history.

 * The way "git svn" asked for password using SSH_ASKPASS and
   GIT_ASKPASS was not in line with the rest of the system.

 * The --graph code fell into infinite loop when asked to do what the
   code did not expect.

 * http transport was wrong to ask for the username when the
   authentication is done by certificate identity.

 * "git pack-refs" that ran in parallel to another process that
   created new refs had a nasty race.

 * Rebasing the history of superproject with change in the submodule
   has been broken since v1.7.12.

 * After "git add -N" and then writing a tree object out of the
   index, the cache-tree data structure got corrupted.

 * "git clone" used to allow --bare and --separate-git-dir=$there
   options at the same time, which was nonsensical.

 * "git rebase --preserve-merges" lost empty merges in recent versions
   of Git.

 * "git merge --no-edit" computed who were involved in the work done
   on the side branch, even though that information is to be discarded
   without getting seen in the editor.

 * "git merge" started calling prepare-commit-msg hook like "git
   commit" does some time ago, but forgot to pay attention to the exit
   status of the hook.

 * A failure to push due to non-ff while on an unborn branch
   dereferenced a NULL pointer when showing an error message.

 * When users spell "cc:" in lowercase in the fake "header" in the
   trailer part, "git send-email" failed to pick up the addresses from
   there. As e-mail headers field names are case insensitive, this
   script should follow suit and treat "cc:" and "Cc:" the same way.

 * Output from "git status --ignored" showed an unexpected interaction
   with "--untracked".

 * "gitweb", when sorting by age to show repositories with new
   activities first, used to sort repositories with absolutely
   nothing in it early, which was not very useful.

 * "gitweb"'s code to sanitize control characters before passing it to
   "highlight" filter lost known-to-be-safe control characters by
   mistake.

 * "gitweb" pages served over HTTPS, when configured to show picon or
   gravatar, referred to these external resources to be fetched via
   HTTP, resulting in mixed contents warning in browsers.

 * When a line to be wrapped has a solid run of non space characters
   whose length exactly is the wrap width, "git shortlog -w" failed
   to add a newline after such a line.

 * Command line completion leaked an unnecessary error message while
   looking for possible matches with paths in <tree-ish>.

 * Command line completion for "tcsh" emitted an unwanted space
   after completing a single directory name.

 * Command line completion code was inadvertently made incompatible with
   older versions of bash by using a newer array notation.

 * "git push" was taught to refuse updating the branch that is
   currently checked out long time ago, but the user manual was left
   stale.
   (merge 50995ed wk/man-deny-current-branch-is-default-these-days later to maint).

 * Some shells do not behave correctly when IFS is unset; work it
   around by explicitly setting it to the default value.

 * Some scripted programs written in Python did not get updated when
   PYTHON_PATH changed.
   (cherry-pick 96a4647fca54031974cd6ad1 later to maint).

 * When autoconf is used, any build on a different commit always ran
   "config.status --recheck" even when unnecessary.

 * A fix was added to the build procedure to work around buggy
   versions of ccache broke the auto-generation of dependencies, which
   unfortunately is still relevant because some people use ancient
   distros.

 * The autoconf subsystem passed --mandir down to generated
   config.mak.autogen but forgot to do the same for --htmldir.
   (merge 55d9bf0 ct/autoconf-htmldir later to maint).

 * A change made on v1.8.1.x maintenance track had a nasty regression
   to break the build when autoconf is used.
   (merge 7f1b697 jn/less-reconfigure later to maint).

 * We have been carrying a translated and long-unmaintained copy of an
   old version of the tutorial; removed.

 * t0050 had tests expecting failures from a bug that was fixed some
   time ago.

 * t4014, t9502 and t0200 tests had various portability issues that
   broke on OpenBSD.

 * t9020 and t3600 tests had various portability issues.

 * t9200 runs "cvs init" on a directory that already exists, but a
   platform can configure this fail for the current user (e.g. you
   need to be in the cvsadmin group on NetBSD 6.0).

 * t9020 and t9810 had a few non-portable shell script construct.

 * Scripts to test bash completion was inherently flaky as it was
   affected by whatever random things the user may have on $PATH.

 * An element on GIT_CEILING_DIRECTORIES could be a "logical" pathname
   that uses a symbolic link to point at somewhere else (e.g. /home/me
   that points at /net/host/export/home/me, and the latter directory
   is automounted). Earlier when Git saw such a pathname e.g. /home/me
   on this environment variable, the "ceiling" mechanism did not take
   effect. With this release (the fix has also been merged to the
   v1.8.1.x maintenance series), elements on GIT_CEILING_DIRECTORIES
   are by default checked for such aliasing coming from symbolic
   links. As this needs to actually resolve symbolic links for each
   element on the GIT_CEILING_DIRECTORIES, you can disable this
   mechanism for some elements by listing them after an empty element
   on the GIT_CEILING_DIRECTORIES. e.g. Setting /home/me::/home/him to
   GIT_CEILING_DIRECTORIES makes Git resolve symbolic links in
   /home/me when checking if the current directory is under /home/me,
   but does not do so for /home/him.
   (merge 7ec30aa mh/maint-ceil-absolute later to maint).

----------------------------------------------------------------

Changes since v1.8.2-rc2 are as follows:

Fredrik Gustafsson (1):
      gitweb/README: remove reference to git.kernel.org

Jiang Xin (2):
      l10n: git.pot: v1.8.2 round 4 (1 changed)
      l10n: zh_CN.po: translate 1 new message

Junio C Hamano (1):
      Git 1.8.2-rc3

Matthieu Moy (1):
      git-completion.zsh: define __gitcomp_file compatibility function

Peter Krefting (1):
      l10n: Update Swedish translation (2009t0f0u)

Ralf Thielow (4):
      l10n: de.po: translate 35 new messages
      l10n: de.po: translate 5 new messages
      l10n: de.po: correct translation of "bisect" messages
      l10n: de.po: translate 1 new message

Tran Ngoc Quan (1):
      l10n: vi.po: Update translation (2009t0f0u)
