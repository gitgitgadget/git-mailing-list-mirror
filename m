From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2012, #07; Mon, 23)
Date: Mon, 23 Jul 2012 22:10:00 -0700
Message-ID: <7vsjchhhhz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 07:10:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StXNv-0003SB-9M
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 07:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990Ab2GXFKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 01:10:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab2GXFKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 01:10:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF2058F07;
	Tue, 24 Jul 2012 01:10:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Q
	rGACnRNHN0ST8zzMQAAdj1mrJ0=; b=psS7aYb9V/QrE1YEC6qBWACShKmNPLOZD
	3UsMCa+fNElCgG1kfAsut3gGVDxxB1Gt1MzTseVcTA+a9frCR8kcX6p+TEZkFbqG
	IU54VO3zcKIoLrbP/7huio0x5quNz4T3AAYGXfUL2ui1TCblRjeZJsWUYHC7PuhU
	POsuVuh7Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=g02
	KXl47qtkffYshy6Lng51DjaZNW11Iu3jMRxiKjGYIVM6G6HLoRqR3vB7n7C53SUJ
	dt+KbqUMZDnbPCAs6iavptdHDBOeRWTIUpY49vNBLQEqGRAk+ZrW18rngtT/18aE
	wHLSPqxTAlBLRJqiKxLNha+iBce90RhZV+AUY9GI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D0048F05;
	Tue, 24 Jul 2012 01:10:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B05718F04; Tue, 24 Jul 2012
 01:10:01 -0400 (EDT)
X-master-at: ccc1188fa34cd9519185a22b13599256ccfac7e1
X-next-at: ef256fcf12b3e3fdb5f9a5b3185d9727e9415afa
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D26BA958-D54D-11E1-8BCB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202009>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The tip of 'master' has been tagged as 1.7.12-rc0; this deliberately
contains a few topics that have been in 'next' only for a few days,
so please make sure to spot any possible issues and report soonish
to avoid regressions in the upcoming release.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/mediawiki-credential (2012-07-18) 4 commits
  (merged to 'next' on 2012-07-22 at 2cb99b2)
 + mw-to-git: use git-credential's URL parser
 + credential: convert "url" attribute into its parsed subparts
 + mw-to-git: check blank credential attributes via length
 + docs/credential: minor clarity fixups

Mediawiki importer updates.

* jn/block-sha1 (2012-07-23) 3 commits
  (merged to 'next' on 2012-07-23 at a11a08b)
 + Makefile: BLK_SHA1 does not require fast htonl() and unaligned loads
 + block-sha1: put expanded macro parameters in parentheses
 + block-sha1: avoid pointer conversion that violates alignment constraints

The code to load a word one-byte-at-a-time was optimized into a
word-wide load instruction even when the pointer was not aligned,
which caused issues on architectures that do not like unaligned
access.

* jn/make-assembly-in-right-directory (2012-07-22) 1 commit
  (merged to 'next' on 2012-07-23 at 3c155cc)
 + Makefile: fix location of listing produced by "make subdir/foo.s"

* jv/maint-no-ext-diff (2012-07-19) 2 commits
  (merged to 'next' on 2012-07-22 at eefcf45)
 + diff: test precedence of external diff drivers
 + diff: correctly disable external_diff with --no-ext-diff

"git diff --no-ext-diff" did not output anything for a typechange
filepair when GIT_EXTERNAL_DIFF is in effect.

* kk/maint-1.7.9-commit-tree (2012-07-17) 1 commit
 + commit-tree: resurrect command line parsing updates
 (this branch is used by kk/maint-commit-tree.)

A more natural-looking "git commit-tree -p <parent> <tree>" syntax
was introduced long time ago, but we accidentally broke it in the
1.7.9 era.

* kk/maint-commit-tree (2012-07-17) 2 commits
  (merged to 'next' on 2012-07-22 at ab15d56)
 + Revert "git-commit-tree(1): update synopsis"
 + Merge branch 'kk/maint-1.7.9-commit-tree' into kk/maint-commit-tree
 (this branch uses kk/maint-1.7.9-commit-tree.)

The same as above, for merging to the upcoming release.

* mm/mediawiki-usability (2012-07-17) 10 commits
  (merged to 'next' on 2012-07-22 at fe66a95)
 + git-remote-mediawiki: allow page names with a ':'
 + git-remote-mediawiki: fix incorrect test usage in test
 + git-remote-mediawiki: properly deal with invalid remote revisions
 + git-remote-mediawiki: show progress information when getting last remote revision
 + git-remote-mediawiki: show progress information when listing pages
 + git-remote-mediawiki: use --force when adding notes
 + git-remote-mediawiki: get rid of O(N^2) loop
 + git-remote-mediawiki: make mediafiles export optional
 + git-remote-mediawiki: actually send empty comment when they're empty
 + git-remote-mediawiki: don't split namespaces with spaces

Mediawiki importer updates.

* nk/maint-gitweb-log-by-lines (2012-07-05) 3 commits
  (merged to 'next' on 2012-07-13 at 780e16a)
 + gitweb: Add support to Link: tag
 + gitweb: Handle other types of tag in git_print_log
 + gitweb: Cleanup git_print_log()

Teach gitweb to pay attention to various forms of credits that are
similar to "Signed-off-by:" lines.

Needs to be eyeballed for the correctness of the esc_html() in the tip one.

* sl/autoconf (2012-07-19) 7 commits
  (merged to 'next' on 2012-07-23 at dc94990)
 + build: reconfigure automatically if configure.ac changes
 + build: "make clean" should not remove configure-generated files
 + autoconf: use AC_CONFIG_COMMANDS instead of ad-hoc 'config.mak.append'
 + autoconf: remove few redundant semicolons
 + autoconf: remove some redundant shell indirections
 + autoconf: GIT_CONF_APPEND_LINE -> GIT_CONF_SUBST
 + autoconf: GIT_CONF_APPEND_LINE: change signature

* sn/doc-typofix (2012-07-14) 1 commit
  (merged to 'next' on 2012-07-22 at 168bba9)
 + doc: A few minor copy edits.

* tg/ce-namelen-field (2012-07-11) 2 commits
  (merged to 'next' on 2012-07-22 at 2d85b05)
 + Strip namelen out of ce_flags into a ce_namelen field
 + Merge branch 'tg/maint-cache-name-compare' into tg/ce-namelen-field

Split lower bits of ce_flags field and creates a new ce_namelen
field in the in-core index structure.

* th/difftool-diffall (2012-07-19) 1 commit
  (merged to 'next' on 2012-07-23 at db62371)
 + difftool: only copy back files modified during directory diff
 (this branch is used by da/difftool-updates.)

Finishing touches to "difftool --dir-diff".

--------------------------------------------------
[New Topics]

* da/difftool-updates (2012-07-23) 5 commits
  (merged to 'next' on 2012-07-23 at 96528a7)
 + difftool: Use symlinks when diffing against the worktree
 + difftool: Call the temp directory "git-difftool"
 + difftool: Move option values into a hash
 + difftool: Eliminate global variables
 + difftool: Simplify print_tool_help()

"git difftool --dir-diff" learned to use symbolic links to prepare
temporary copy of the working tree when available.

Will merge to 'master'.

* jc/mergetool-tool-help (2012-07-23) 1 commit
  (merged to 'next' on 2012-07-23 at ef256fc)
 + mergetool: support --tool-help option like difftool does

"git mergetool" did not support --tool-help option to give the list
of supported backends, like "git difftool" does.

Will merge to 'master'.

* jk/maint-advise-vaddf (2012-07-23) 1 commit
  (merged to 'next' on 2012-07-23 at 5b13a77)
 + advice: pass varargs to strbuf_vaddf, not strbuf_addf
 (this branch is used by jk/maint-commit-abandoned-message.)

The advise() function did not use varargs correctly to format
its message.

Will merge to 'master' and soon to 'maint'.

* jk/maint-commit-abandoned-message (2012-07-23) 2 commits
 - commit: give a hint when a commit message has been abandoned
 - Merge commit 'b2eda9b' into jk/maint-commit-abandoned-message
 (this branch uses jk/maint-advise-vaddf.)

Will drop.

* jk/maint-commit-check-committer-early (2012-07-23) 1 commit
  (merged to 'next' on 2012-07-23 at a2c7133)
 + commit: check committer identity more strictly

"git commit --amend" let the user edit the log message and then died
when the human-readable committer name was given insufficiently by
getpwent(3).

Will merge to 'master' and soon to 'maint'.

* jk/maint-commit-document-editmsg (2012-07-23) 1 commit
  (merged to 'next' on 2012-07-23 at 06307fb)
 + commit: document the temporary commit message file

Document $GIT_DIR/COMMIT_EDITMSG file.

Will merge to 'master' and soon to 'maint'.

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

* jc/test-lib-source-build-options-early (2012-06-24) 1 commit
 - test-lib: reorder and include GIT-BUILD-OPTIONS a lot earlier

Reorders t/test-lib.sh so that we dot-source GIT-BUILD-OPTIONS that
records the shell and Perl the user told us to use with Git a lot
early, so that test-lib.sh script itself can use "$PERL_PATH" in
one of its early operations.

Needs to be eyeballed by people who run tests with exotic options
like valgrind, --root=/dev/shm/somewhere, etc.

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
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* mh/maint-revisions-doc (2012-07-23) 3 commits
 - fixup-amend: Enumerate revision range specifiers in the documentation
 - Document rev^! and rev^@ as revision specifiers
 - Make <refname> documentation more consistent.

Getting tired of waiting, so I rewrote the tip one.
Waiting for some feedback.

* jx/i18n-1.7.11 (2012-07-22) 7 commits
 - i18n: merge-recursive: mark strings for translation
 - Remove unused and bad gettext block from git-am
 - i18n: am: mark more strings for translation
 - Remove obsolete LONG_USAGE which breaks xgettext
 - i18n: Rewrite gettext messages start with dash
 - i18n: rebase: mark strings for translation
 - i18n: New keywords for xgettext extraction from sh

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
  (merged to 'next' on 2012-07-23 at fe59cb6)
 + pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Will defer for another cycle.
