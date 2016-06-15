From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2012, #09; Sun, 29)
Date: Sun, 29 Jul 2012 20:06:58 -0700
Message-ID: <7v8ve2t0a5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 05:07:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvgK8-0000za-BE
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 05:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab2G3DHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 23:07:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929Ab2G3DHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 23:07:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 137A693D2;
	Sun, 29 Jul 2012 23:07:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	oD3s0ORmquAT+MmcCMH8WsohN4=; b=JwTO1mVIwYofA6SuqI3OLiZf38xg2+vlh
	Fi8XcvtQ53oRm8xZg7pujr4St0OOoXL8H8hpSrGYg6tFtAt3O8VYQpjTiVgnwdyx
	zBcwjQa0kU7t+XQnRnkg/UvHWM3DOeuZX5frhJG3MNsh+O4WjH646loe84S3uGUP
	7/WZfcVsHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=eRK
	rzeye6iZpb4qxxvzn/vheuNv53Yhy4Y8ALHeAx/9Z19kkj65AY+gaNeFLnh+EUWh
	4mo7T75EWZk3C4A9K0Z4q7pHBXYJiQNL5rtieY7ou2k5esTCN33eBuYeWk5MlUkx
	oexgpgouvO1UOgmwjzUu2yj/75WRaEj2uPCBjhgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01B0693D1;
	Sun, 29 Jul 2012 23:07:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AFA993D0; Sun, 29 Jul 2012
 23:07:00 -0400 (EDT)
X-master-at: 425b8a22aa14d624c807d5eed92c92f5cd32f376
X-next-at: 3dac0f9a513f5cb0b8689ff36862dd53759d52e3
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A14596A4-D9F3-11E1-830F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202520>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

We are getting closer to 1.7.12-rc1; I do not see any topic in
'next' (let alnoe 'pu') right now that is so urgent that cannot wait
until the next release.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* mz/cherry-code-cleanup (2012-07-29) 3 commits
 - cherry: remove redundant check for merge commit
 - cherry: don't set ignored rev_info options
 - remove unnecessary parameter from get_patch_ids()

Minor code clean-up on the cherry-pick codepath.
Not urgent.

* nd/maint-i18n-diffstat (2012-07-26) 1 commit
 - i18n: leave \n out of translated diffstat

Will merge to 'next' and then down to 'master' by 1.7.2-rc1.

* hv/link-alt-odb-entry (2012-07-29) 1 commit
 - link_alt_odb_entry: fix read over array bounds reported by valgrind

The code to avoid mistaken attempt to add the object directory
itself as its own alternate could read beyond end of a string while
comparison.  The patch is different from what was posted by Heiko.

Waiting for comments.

* jc/maint-config-exit-status (2012-07-29) 1 commit
 - config: "git config baa" should exit with status 1

The exit status code from "git config" was way overspecified while
being incorrect.  Update the implementation to give the documented
status for a case that was documented, and introduce a new code for
"all other errors".

* jk/maint-null-in-trees (2012-07-29) 3 commits
 - fsck: detect null sha1 in tree entries
 - do not write null sha1s to on-disk index
 - diff: do not use null sha1 as a sentinel value

"git diff" used incorrectly an all-NUL object name as sentinel.

* rj/maint-grep-remove-redundant-test (2012-07-29) 1 commit
 - t7810-*.sh: Remove redundant test

"git grep" stopped spawning an external "grep" long time ago, but a
duplicated test to check internal and external "grep" was left
behind.

--------------------------------------------------
[Graduated to "master"]

* dg/submodule-in-dismembered-working-tree (2012-07-25) 1 commit
  (merged to 'next' on 2012-07-26 at cfa16c4)
 + git-submodule: work with GIT_DIR/GIT_WORK_TREE

In a superproject that has repository outside of its working tree,
"git submodule add" failed to clone a new submodule, as GIT_DIR and
GIT_WORK_TREE environment variables necessary to work in such a
superproject interfered with access to the submodule repository.

* jk/autoident-test (2012-07-26) 6 commits
  (merged to 'next' on 2012-07-26 at f358a28)
 + t7502: test early quit from commit with bad ident
 + t7502: handle systems where auto-identity is broken
 + t7502: drop confusing test_might_fail call
 + t7502: narrow checks for author/committer name in template
 + t7502: properly quote GIT_EDITOR
 + t7502: clean up fake_editor tests

Fix test breakages by a builder who does not have a valid user name
in his /etc/password entry.

* jk/help-plug-memleak (2012-07-25) 2 commits
  (merged to 'next' on 2012-07-26 at bd57cb8)
 + help.c::exclude_cmds(): plug a leak
 + help.c::uniq: plug a leak

Plug a few trivial memory leaks.

* jk/maint-checkout-orphan-check-fix (2012-07-25) 1 commit
  (merged to 'next' on 2012-07-26 at a513c5a)
 + checkout: don't confuse ref and object flags

"git checkout <branchname>" to come back from a detached HEAD state
incorrectly computed reachability of the detached HEAD, resulting in
unnecessary warnings.

--------------------------------------------------
[Stalled]

* mz/rebase-range (2012-07-18) 7 commits
 - rebase (without -p): correctly calculate patches to rebase
 - rebase -p: don't request --left-right only to ignore left side
 - rebase -p: use --cherry-mark for todo file
 - git-rebase--interactive.sh: look up subject in add_pick_line
 - git-rebase--interactive: group all $preserve_merges code
 - git-rebase--interactive.sh: extract function for adding "pick" line
 - git-rebase--am.sh: avoid special-casing --keep-empty

Expecting a reroll.

Performance concerns from Windows folks.  Also the series lacks
proper sign-offs.

* jl/submodule-rm (2012-07-05) 2 commits
 - rm: remove submodules from the index and the .gitmodules file
 - rm: don't fail when removing populated submodules

Expecting a reroll.

* ph/stash-rerere (2012-07-08) 2 commits
 - stash: invoke rerere in case of conflict
 - test: git-stash conflict sets up rerere

Will be rerolled but is going in the right direction.

* lt/commit-tree-guess-utf-8 (2012-06-28) 1 commit
 - commit/commit-tree: correct latin1 to utf-8

Teaches "git commit" and "git commit-tree" the "we are told to use
utf-8 in log message, but this does not look like utf-8---attempt to
pass it through convert-from-latin1-to-utf8 and see if it makes
sense" heuristics "git mailinfo" already uses.

A draft from Linus received privately without a log message.
Expecting a reroll.

* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

When the user does not specify what remote to interact with, we
often attempt to use 'origin'.  This can now be customized via a
configuration variable.

Expecting a reroll.
"The first remote becomes the default" bit is better done as a
separate step.

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
There still seem to be other bugs hiding (e.g. try pushing twice).

Not ready.

* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent long time ago still remains here without much comments
and updates from the developer community. I even made the interface
to the logic that decides where to split chunks easily replaceable,
and I deliberately made the logic in the original patch extremely
stupid to entice others, especially the "bup" fanbois, to come up
with a better logic, thinking that giving people an easy target to
shoot for, they may be encouraged to help out. The plan is not
working :-<.

--------------------------------------------------
[Cooking]

* sz/submodule-force-update (2012-07-25) 1 commit
  (merged to 'next' on 2012-07-26 at 3bda2be)
 + Make 'git submodule update --force' always check out submodules.

We may want a documentation update and a few tests on top.
Not urgent.

* jc/test-prereq (2012-07-27) 6 commits
  (merged to 'next' on 2012-07-27 at 448cbbc)
 + test-lib: provide UTF8 behaviour as a prerequisite
 + t0050: use the SYMLINKS test prereq
 + t0050: use the CASE_INSENSITIVE_FS test prereq
 + test-lib: provide case insensitivity as a prerequisite
 + test: allow prerequisite to be evaluated lazily
 + test: rename $satisfied to $satisfied_prereq

Teaches the test framework to probe rarely used prerequistes lazily,
and make use of it for detecting SYMLINKS, CASE_INSENSITIVE_FS and
NKD/NKC MacOS x gotcha.

Not urgent.

* da/difftool-updates (2012-07-26) 10 commits
  (merged to 'next' on 2012-07-26 at 3263461)
 + difftool: Disable --symlinks on cygwin
 + difftool: Handle compare() returning -1
 + difftool: Wrap long lines for readability
 + difftool: Check all return codes from compare()
 + difftool: Handle finding mergetools/ in a path with spaces
  (merged to 'next' on 2012-07-23 at 96528a7)
 + difftool: Use symlinks when diffing against the worktree
 + difftool: Call the temp directory "git-difftool"
 + difftool: Move option values into a hash
 + difftool: Eliminate global variables
 + difftool: Simplify print_tool_help()

"git difftool --dir-diff" learned to use symbolic links to prepare
temporary copy of the working tree when available.

Not urgent.

* jx/i18n-1.7.11 (2012-07-26) 7 commits
 - i18n: merge-recursive: mark strings for translation
 - Remove dead code which contains bad gettext block
 - i18n: am: mark more strings for translation
 - rebase: remove obsolete and unused LONG_USAGE which breaks xgettext
 - i18n: Rewrite gettext messages start with dash
 - i18n: rebase: mark messages for translation
 - i18n: New keywords for xgettext extraction from sh

Is this ready for 'next'?
Not urgent.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
  (merged to 'next' on 2012-07-23 at fe59cb6)
 + pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Will defer for another cycle.

--------------------------------------------------
[Discarded]

* jk/maint-commit-abandoned-message (2012-07-23) 2 commits
 . commit: give a hint when a commit message has been abandoned
 . Merge commit 'b2eda9b' into jk/maint-commit-abandoned-message

* ms/git-svn-pm (2012-07-26) 4 commits
 . Move initialization of Git::SVN variables into Git::SVN.
 . Extract Git::SVN from git-svn into its own .pm file.
 . Prepare Git::SVN for extraction into its own file.
 . Extract some utilities from git-svn to allow extracting Git::SVN.
 (this branch uses ms/makefile-pl.)

Already in 'master' via Eric's git-svn tree.

* ms/makefile-pl (2012-07-25) 3 commits
 . The Makefile.PL will now find .pm files itself.
 . Don't lose Error.pm if $@ gets clobbered.
 . Quiet warning if Makefile.PL is run with -w and no --localedir
 (this branch is used by ms/git-svn-pm.)

Already in 'master' via Eric's git-svn tree.
