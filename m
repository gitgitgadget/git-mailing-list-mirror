From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.9-rc1
Date: Mon, 27 Jan 2014 13:57:57 -0800
Message-ID: <xmqqbnyxnl3u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 27 22:58:29 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W7uCL-0000Yl-4M
	for glk-linux-kernel-3@plane.gmane.org; Mon, 27 Jan 2014 22:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbaA0V6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 27 Jan 2014 16:58:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46217 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572AbaA0V6S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jan 2014 16:58:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AEAC677E0;
	Mon, 27 Jan 2014 16:58:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=84OPqi7O1hR6tjTu35I4rDVMj
	LM=; b=oVT1H1qX1zYQBNKKJT7aGASKylnb8I9iVUUDskCBCDHuwStnh7inO0sxI
	EcQbCg2zQW6ioXI/k8dzBwlTLj2c7W6y9VmSftZm16TOdeEBmVO3xZojzIXLp3gx
	HGSLb3BlG8zVXhRWQ+9wR409zPUJLTA54x1WYh0EcHRfORDVAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Uc5HmX2Dm9BrWEeNJ0N
	yQPc0IeUS/b+qlLn5R+yeE7AJk1EHhjr2LwiKU/bgEe7wfVLZxr5+MbZbJXUIr8N
	bn2oguK7ALIGejs3wwxzV7KSIUKVPdd6UU9SZgVLcPN+ZcfNDjJZo4F73naZ8+mD
	OwOj+M5ijvS0cD79gpO1UvLs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5946A677DF;
	Mon, 27 Jan 2014 16:58:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E208C677B9;
	Mon, 27 Jan 2014 16:58:09 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C394B2C-879E-11E3-9C4A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241160>

The first release candidate for this cycle, Git v1.9-rc1, is now
available for testing at the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

acc2343b4a0a0ed1920036fde1b1bf2109feb969  git-1.9.rc1.tar.gz
37bc0f5ef8f777a980304d58df003515364a54d0  git-htmldocs-1.9.rc1.tar.gz
c378ff4aca0737c9773181f4e97d36a8d8413e9a  git-manpages-1.9.rc1.tar.gz

The following public repositories all have a copy of the v1.9-rc1
tag and the master branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.9 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Backward compatibility notes
----------------------------

"git submodule foreach $cmd $args" used to treat "$cmd $args" the same
way "ssh" did, concatenating them into a single string and letting the
shell unquote. Careless users who forget to sufficiently quote $args
gets their argument split at $IFS whitespaces by the shell, and got
unexpected results due to this. Starting from this release, the
command line is passed directly to the shell, if it has an argument.

Read-only support for experimental loose-object format, in which users
could optionally choose to write in their loose objects for a short
while between v1.4.3 to v1.5.3 era, has been dropped.

The meanings of "--tags" option to "git fetch" has changed; the
command fetches tags _in addition to_ what are fetched by the same
command line without the option.

The way "git push $there $what" interprets $what part given on the
command line, when it does not have a colon that explicitly tells us
what ref at the $there repository is to be updated, has been enhanced.

A handful of ancient commands that have long been deprecated are
finally gone (repo-config, tar-tree, lost-found, and peek-remote).


Backward compatibility notes (for Git 2.0)
------------------------------------------

When "git push [$there]" does not say what to push, we have used the
traditional "matching" semantics so far (all your branches were sent
to the remote as long as there already are branches of the same name
over there).  In Git 2.0, the default will change to the "simple"
semantics, which pushes:

 - only the current branch to the branch with the same name, and only
   when the current branch is set to integrate with that remote
   branch, if you are pushing to the same remote as you fetch from; or

 - only the current branch to the branch with the same name, if you
   are pushing to a remote that is not where you usually fetch from.

Use the user preference configuration variable "push.default" to
change this.  If you are an old-timer who is used to the "matching"
semantics, you can set the variable to "matching" to keep the
traditional behaviour.  If you want to live in the future early, you
can set it to "simple" today without waiting for Git 2.0.

When "git add -u" (and "git add -A") is run inside a subdirectory and
does not specify which paths to add on the command line, it
will operate on the entire tree in Git 2.0 for consistency
with "git commit -a" and other commands.  There will be no
mechanism to make plain "git add -u" behave like "git add -u .".
Current users of "git add -u" (without a pathspec) should start
training their fingers to explicitly say "git add -u ."
before Git 2.0 comes.  A warning is issued when these commands are
run without a pathspec and when you have local changes outside the
current directory, because the behaviour in Git 2.0 will be different
from today's version in such a situation.

In Git 2.0, "git add <path>" will behave as "git add -A <path>", so
that "git add dir/" will notice paths you removed from the directory
and record the removal.  Versions before Git 2.0, including this
release, will keep ignoring removals, but the users who rely on this
behaviour are encouraged to start using "git add --ignore-removal <path=
>"
now before 2.0 is released.

The default prefix for "git svn" will change in Git 2.0.  For a long
time, "git svn" created its remote-tracking branches directly under
refs/remotes, but it will place them under refs/remotes/origin/ unless
it is told otherwise with its --prefix option.


Updates since v1.8.5
--------------------

=46oreign interfaces, subsystems and ports.

 * The HTTP transport, when talking GSS-Negotiate, uses "100
   Continue" response to avoid having to rewind and resend a large
   payload, which may not be always doable.

 * Various bugfixes to remote-bzr and remote-hg (in contrib/).

 * The build procedure is aware of MirBSD now.

 * Various "git p4", "git svn" and "gitk" updates.


UI, Workflows & Features

 * Fetching from a shallowly-cloned repository used to be forbidden,
   primarily because the codepaths involved were not carefully vetted
   and we did not bother supporting such usage. This release attempts
   to allow object transfer out of a shallowly-cloned repository in a
   more controlled way (i.e. the receiver become a shallow repository
   with a truncated history).

 * Just like we give a reasonable default for "less" via the LESS
   environment variable, we now specify a reasonable default for "lv"
   via the "LV" environment variable when spawning the pager.

 * Two-level configuration variable names in "branch.*" and "remote.*"
   hierarchies, whose variables are predominantly three-level, were
   not completed by hitting a <TAB> in bash and zsh completions.

 * Fetching 'frotz' branch with "git fetch", while 'frotz/nitfol'
   remote-tracking branch from an earlier fetch was still there, would
   error out, primarily because the command was not told that it is
   allowed to lose any information on our side.  "git fetch --prune"
   now can be used to remove 'frotz/nitfol' to make room to fetch and
   store 'frotz' remote-tracking branch.

 * "diff.orderfile=3D<file>" configuration variable can be used to
   pretend as if the "-O<file>" option were given from the command
   line of "git diff", etc.

 * The negative pathspec syntax allows "git log -- . ':!dir'" to tell
   us "I am interested in everything but 'dir' directory".

 * "git difftool" shows how many different paths there are in total,
   and how many of them have been shown so far, to indicate progress.

 * "git push origin master" used to push our 'master' branch to update
   the 'master' branch at the 'origin' repository.  This has been
   enhanced to use the same ref mapping "git push origin" would use to
   determine what ref at the 'origin' to be updated with our 'master'.
   For example, with this configuration

   [remote "origin"]
      push =3D refs/heads/*:refs/review/*

   that would cause "git push origin" to push out our local branches
   to corresponding refs under refs/review/ hierarchy at 'origin',
   "git push origin master" would update 'refs/review/master' over
   there.  Alternatively, if push.default is set to 'upstream' and our
   'master' is set to integrate with 'topic' from the 'origin' branch,
   running "git push origin" while on our 'master' would update their
   'topic' branch, and running "git push origin master" while on any
   of our branches does the same.

 * "gitweb" learned to treat ref hierarchies other than refs/heads as
   if they are additional branch namespaces (e.g. refs/changes/ in
   Gerrit).

 * "git for-each-ref --format=3D..." learned a few formatting directive=
s;
   e.g. "%(color:red)%(HEAD)%(color:reset) %(refname:short) %(subject)"=
=2E

 * The command string given to "git submodule foreach" is passed
   directly to the shell, without being eval'ed.  This is a backward
   incompatible change that may break existing users.

 * "git log" and friends learned the "--exclude=3D<glob>" option, to
   allow people to say "list history of all branches except those that
   match this pattern" with "git log --exclude=3D'*/*' --branches".

 * "git rev-parse --parseopt" learned a new "--stuck-long" option to
   help scripts parse options with an optional parameter.

 * The "--tags" option to "git fetch" no longer tells the command to
   fetch _only_ the tags. It instead fetches tags _in addition to_
   what are fetched by the same command line without the option.


Performance, Internal Implementation, etc.

 * When parsing a 40-hex string into the object name, the string is
   checked to see if it can be interpreted as a ref so that a warning
   can be given for ambiguity. The code kicked in even when the
   core.warnambiguousrefs is set to false to squelch this warning, in
   which case the cycles spent to look at the ref namespace were an
   expensive no-op, as the result was discarded without being used.

 * The naming convention of the packfiles has been updated; it used to
   be based on the enumeration of names of the objects that are
   contained in the pack, but now it also depends on how the packed
   result is represented---packing the same set of objects using
   different settings (or delta order) would produce a pack with
   different name.

 * "git diff --no-index" mode used to unnecessarily attempt to read
   the index when there is one.

 * The deprecated parse-options macro OPT_BOOLEAN has been removed;
   use OPT_BOOL or OPT_COUNTUP in new code.

 * A few duplicate implementations of prefix/suffix string comparison
   functions have been unified to starts_with() and ends_with().

 * The new PERLLIB_EXTRA makefile variable can be used to specify
   additional directories Perl modules (e.g. the ones necessary to run
   git-svn) are installed on the platform when building.

 * "git merge-base" learned the "--fork-point" mode, that implements
   the same logic used in "git pull --rebase" to find a suitable fork
   point out of the reflog entries for the remote-tracking branch the
   work has been based on.  "git rebase" has the same logic that can be
   triggered with the "--fork-point" option.

 * A third-party "receive-pack" (the responder to "git push") can
   advertise the "no-thin" capability to tell "git push" not to use
   the thin-pack optimization. Our receive-pack has always been
   capable of accepting and fattening a thin-pack, and will continue
   not to ask "git push" to use a non-thin pack.


Also contains various documentation updates and code clean-ups.


=46ixes since v1.8.5
------------------

Unless otherwise noted, all the fixes since v1.8.5 in the maintenance
track are contained in this release (see the maintenance releases' note=
s
for details).

 * The pathspec matching code, while comparing two trees (e.g. "git
   diff A B -- path1 path2") was too agrresive and failed to match
   some paths when multiple pathspecs were involved.
   (merge e4ddb05 as/tree-walk-fix-aggressive-short-cut later to maint)=
=2E

 * "git repack --max-pack-size=3D8g" stopped being parsed correctly whe=
n
   the command was reimplemented in C.
   (merge b861e23 sb/repack-in-c later to maint).

 * An earlier update in v1.8.4.x to "git rev-list --objects" with
   negative ref had performance regression.
   (merge 200abe7 jk/mark-edges-uninteresting later to maint).

 * A recent update to "git send-email" broke platforms where
   /etc/ssl/certs/ directory exists, but it cannot used as SSL_ca_path
   (e.g. Fedora rawhide).
   (merge 01645b7 rk/send-email-ssl-cert later to maint).

 * A handful of bugs around interpreting $branch@{upstream} notation
   and its lookalike, when $branch part has interesting characters,
   e.g. "@", and ":", have been fixed.
   (merge 9892d5d jk/interpret-branch-name-fix later to maint).

 * "git clone" would fail to clone from a repository that has a ref
   directly under "refs/", e.g. "refs/stash", because different
   validation paths do different things on such a refname.  Loosen the
   client side's validation to allow such a ref.
   (merge 4c22408 jk/allow-fetch-onelevel-refname later to maint).

 * "git log --left-right A...B" lost the "leftness" of commits
   reachable from A when A is a tag as a side effect of a recent
   bugfix.  This is a regression in 1.8.4.x series.
   (merge a743528 jc/revision-range-unpeel later to maint).

 * documentations to "git pull" hinted there is an "-m" option because
   it incorrectly shared the documentation with "git merge".
   (merge 08f19cf jc/maint-pull-docfix later to maint).

 * "git diff A B submod" and "git diff A B submod/" ought to have done
   the same for a submodule "submod", but didn't.

 * "git clone $origin foo\bar\baz" on Windows failed to create the
   leading directories (i.e. a moral-equivalent of "mkdir -p").

 * "submodule.*.update=3Dcheckout", when propagated from .gitmodules to
   .git/config, turned into a "submodule.*.update=3Dnone", which did no=
t
   make much sense.
   (merge efa8fd7 fp/submodule-checkout-mode later to maint).

 * The implementation of 'git stash $cmd "stash@{...}"' did not quote
   the stash argument properly and left it split at IFS whitespace.
   (merge 2a07e43 ow/stash-with-ifs later to maint).

 * The "--[no-]informative-errors" options to "git daemon" were parsed
   a bit too loosely, allowing any other string after these option
   names.
   (merge 82246b7 nd/daemon-informative-errors-typofix later to maint).

 * There is no reason to have a hardcoded upper limit of the number of
   parents for an octopus merge, created via the graft mechanism, but
   there was.
   (merge e228c17 js/lift-parent-count-limit later to maint).

 * The basic test used to leave unnecessary trash directories in the
   t/ directory.
   (merge 738a8be jk/test-framework-updates later to maint).

 * "git merge-base --octopus" used to leave cleaning up suboptimal
   result to the caller, but now it does the clean-up itself.
   (merge 8f29299 bm/merge-base-octopus-dedup later to maint).

 * A "gc" process running as a different user should be able to stop a
   new "gc" process from starting, but it didn't.
   (merge ed7eda8 km/gc-eperm later to maint).

 * An earlier "clean-up" introduced an unnecessary memory leak.
   (merge e1c1a32 jk/credential-plug-leak later to maint).

 * "git add -A" (no other arguments) in a totally empty working tree
   used to emit an error.
   (merge 64ed07c nd/add-empty-fix later to maint).

 * "git log --decorate" did not handle a tag pointed by another tag
   nicely.
   (merge 5e1361c bc/log-decoration later to maint).

 * When we figure out how many file descriptors to allocate for
   keeping packfiles open, a system with non-working getrlimit() could
   cause us to die(), but because we make this call only to get a
   rough estimate of how many is available and we do not even attempt
   to use up all file descriptors available ourselves, it is nicer to
   fall back to a reasonable low value rather than dying.
   (merge 491a8de jh/rlimit-nofile-fallback later to maint).

 * read_sha1_file(), that is the workhorse to read the contents given
   an object name, honoured object replacements, but there was no
   corresponding mechanism to sha1_object_info() that was used to
   obtain the metainfo (e.g. type & size) about the object.  This led
   callers to weird inconsistencies.
   (merge 663a856 cc/replace-object-info later to maint).

 * "git cat-file --batch=3D", an admittedly useless command, did not
   behave very well.
   (merge 6554dfa jk/cat-file-regression-fix later to maint).

 * "git rev-parse <revs> -- <paths>" did not implement the usual
   disambiguation rules the commands in the "git log" family used in
   the same way.
   (merge 62f162f jk/rev-parse-double-dashes later to maint).

 * "git mv A B/", when B does not exist as a directory, should error
   out, but it didn't.
   (merge c57f628 mm/mv-file-to-no-such-dir-with-slash later to maint).

 * A workaround to an old bug in glibc prior to glibc 2.17 has been
   retired; this would remove a side effect of the workaround that
   corrupts system error messages in non-C locales.

 * SSL-related options were not passed correctly to underlying socket
   layer in "git send-email".
   (merge 5508f3e tr/send-email-ssl later to maint).

 * "git commit -v" appends the patch to the log message before
   editing, and then removes the patch when the editor returned
   control. However, the patch was not stripped correctly when the
   first modified path was a submodule.
   (merge 1a72cfd jl/commit-v-strip-marker later to maint).

 * "git fetch --depth=3D0" was a no-op, and was silently ignored.
   Diagnose it as an error.
   (merge 5594bca nd/transport-positive-depth-only later to maint).

 * Remote repository URL expressed in scp-style host:path notation are
   parsed more carefully (e.g. "foo/bar:baz" is local, "[::1]:/~user" a=
sks
   to connect to user's home directory on host at address ::1.
   (merge a2036d7 tb/clone-ssh-with-colon-for-port later to maint).

 * "git diff -- ':(icase)makefile'" was unnecessarily rejected at the
   command line parser.
   (merge 887c6c1 nd/magic-pathspec later to maint).

 * "git cat-file --batch-check=3Dok" did not check the existence of
   the named object.
   (merge 4ef8d1d sb/sha1-loose-object-info-check-existence later to ma=
int).

 * "git am --abort" sometimes complained about not being able to write
   a tree with an 0{40} object in it.
   (merge 77b43ca jk/two-way-merge-corner-case-fix later to maint).

 * Two processes creating loose objects at the same time could have
   failed unnecessarily when the name of their new objects started
   with the same byte value, due to a race condition.
   (merge b2476a6 jh/loose-object-dirs-creation-race later to maint).

----------------------------------------------------------------

Changes since v1.9-rc0 are as follows:

Alexander Shopov (4):
      git-gui i18n: Initial glossary in Bulgarian
      git-gui l10n: Add 29 more terms to glossary
      git-gui i18n: Added Bulgarian translation
      gitk: Add Bulgarian translation (304t)

Andy Spencer (1):
      tree_entry_interesting: match against all pathspecs

Anthony Baire (1):
      subtree: fix argument validation in add/pull/push

Astril Hayato (1):
      gitk: Comply with XDG base directory specification

Erik Faye-Lund (2):
      prefer xwrite instead of write
      mingw: remove mingw_write

Jeff King (18):
      fetch-pack: do not filter out one-level refs
      interpret_branch_name: factor out upstream handling
      interpret_branch_name: rename "cp" variable to "at"
      interpret_branch_name: always respect "namelen" parameter
      interpret_branch_name: avoid @{upstream} past colon
      interpret_branch_name: find all possible @-marks
      diff_filespec: reorder dirty_submodule macro definitions
      diff_filespec: drop funcname_pattern_ident field
      diff_filespec: drop xfrm_flags field
      diff_filespec: reorder is_binary field
      diff_filespec: use only 2 bits for is_binary flag
      t/perf: time rev-list with UNINTERESTING commits
      list-objects: only look at cmdline trees with edge_hint
      repack: fix typo in max-pack-size option
      repack: make parsed string options const-correct
      repack: propagate pack-objects options as strings
      t7501: fix "empty commit" test with NO_PERL
      t7700: do not use "touch" unnecessarily

Johannes Sixt (1):
      Makefile: Fix compilation of Windows resource file

John Keeping (3):
      completion: complete merge-base options
      completion: handle --[no-]fork-point options to git-rebase
      Makefile: remove redundant object in git-http{fetch,push}

Jonathan Nieder (3):
      gitignore doc: add global gitignore to synopsis
      git-gui: chmod +x po2msg, windows/git-gui.sh
      gitk: chmod +x po2msg.sh

Junio C Hamano (6):
      Documentation: exclude irrelevant options from "git pull"
      Documentation: "git pull" does not have the "-m" option
      revision: mark contents of an uninteresting tree uninteresting
      revision: propagate flag bits from tags to pointees
      Documentation: make it easier to maintain enumerated documents
      Git 1.9-rc1

Marc Branchaud (1):
      gitk: Replace "next" and "prev" buttons with down and up arrows

Max Kirillov (2):
      git-gui: fallback right pane to packed widgets with Tk 8.4
      gitk: Fix mistype

Michael Haggerty (22):
      safe_create_leading_directories(): fix format of "if" chaining
      safe_create_leading_directories(): reduce scope of local variable
      safe_create_leading_directories(): add explicit "slash" pointer
      safe_create_leading_directories(): rename local variable
      safe_create_leading_directories(): split on first of multiple sla=
shes
      safe_create_leading_directories(): always restore slash at end of=
 loop
      safe_create_leading_directories(): introduce enum for return valu=
es
      cmd_init_db(): when creating directories, handle errors conservat=
ively
      safe_create_leading_directories(): add new error value SCLD_VANIS=
HED
      gitattributes: document more clearly where macros are allowed
      refname_match(): always use the rules in ref_rev_parse_rules
      lock_ref_sha1_basic(): on SCLD_VANISHED, retry
      lock_ref_sha1_basic(): if locking fails with ENOENT, retry
      remove_dir_recurse(): tighten condition for removing unreadable d=
ir
      remove_dir_recurse(): handle disappearing files and directories
      rename_ref(): extract function rename_tmp_log()
      rename_tmp_log(): handle a possible mkdir/rmdir race
      rename_tmp_log(): limit the number of remote_empty_directories() =
attempts
      rename_tmp_log(): on SCLD_VANISHED, retry
      safe_create_leading_directories(): on Windows, \ can separate pat=
h components
      Add cross-references between docs for for-each-ref and show-ref
      doc: remote author/documentation sections from more pages

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      tree-walk.c: ignore trailing slash on submodule in tree_entry_int=
eresting()

Pat Thoyts (1):
      git-gui 0.19

Paul Mackerras (2):
      gitk: Update copyright dates
      gitk: Indent word-wrapped lines in commit display header

Pete Wyckoff (11):
      git p4 test: wildcards are supported
      git p4 test: ensure p4 symlink parsing works
      git p4: work around p4 bug that causes empty symlinks
      git p4 test: explicitly check p4 wildcard delete
      git p4 test: is_cli_file_writeable succeeds
      git p4 test: run as user "author"
      git p4 test: do not pollute /tmp
      git p4: handle files with wildcards when doing RCS scrubbing
      git p4: fix an error message when "p4 where" fails
      git p4 test: examine behavior with locked (+l) files
      git p4 doc: use two-line style for options with multiple spelling=
s

Ruben Kerkhof (1):
      send-email: /etc/ssl/certs/ directory may not be usable as ca_pat=
h

Thomas Ackermann (2):
      create HTML for http-protocol.txt
      http-protocol.txt: don't use uppercase for variable names in "The=
 Negotiation Algorithm"

Thomas Rast (2):
      Documentation/gitk: document -L option
      Documentation: @{-N} can refer to a commit

lin zuojian (1):
      git-svn: memoize _rev_list and rebuild
