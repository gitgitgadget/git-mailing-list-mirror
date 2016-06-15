From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2012, #02; Fri, 7)
Date: Fri, 07 Sep 2012 14:55:56 -0700
Message-ID: <7vy5klv6oj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 23:56:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA6XE-00040k-VX
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 23:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758239Ab2IGV4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 17:56:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769Ab2IGV4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 17:56:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53C1C9056;
	Fri,  7 Sep 2012 17:55:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=G
	zDOJB0tazqieeuIFFuvocC4feI=; b=iXnySBdqPOvF9GJvCU5tBkiwBTyagUtag
	W7X/nzzHjDDAJh+rQ0OZWGTj0m6oDBeGieFNPlI0Z4D4+jpNawrfGGcecWvhf8Bv
	sRqWdIVuqEIt3BlHuqCvd7Ahc3dElBue5wnBQ65escgzoQekpQAhDrQ/oe4N6Are
	tNMjtzaArY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=v8a
	4KiAxjYgngmCKIpJPvG9stz6mknSKrJJggPjMCFm6n7y4Ooo+IhHVoimSun43y82
	hBtcPbVWP1RurK0m7HyKTuKCYeGw1ptDqmYHtSqQmq/80FG1cKRUfqWMa8KUfTok
	JWVvAQ/R7QD8aGvzqKZhmvuvoTyPxb874UzHiRd0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40F199055;
	Fri,  7 Sep 2012 17:55:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D67EB9052; Fri,  7 Sep 2012
 17:55:57 -0400 (EDT)
X-master-at: 0ce986446163b37c7f663ce7a408e7f94c31ba63
X-next-at: 6ddb849836fa53f9ed36fe74e7f1caf18e635160
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE155D2E-F936-11E1-A37B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205004>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The fourth batch of topics have graduated to 'master'.

I'm planning to keep this cycle reasonably short and aim for tagging
the result as 1.8.0 at the end of 9th week, on October 21st, after
which I'd disappear for a few weeks.  http://tinyurl.com/gitCal is
where you can always find my rough tagging schedule at.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jc/apply-binary-p0 (2012-08-24) 1 commit
  (merged to 'next' on 2012-08-28 at 6fa690c)
 + apply: compute patch->def_name correctly under -p0

"git apply -p0" did not parse pathnames on "diff --git" line
correctly.  This caused patches that had pathnames in no other
places to be mistakenly rejected (most notably, binary patch that
does not rename nor change mode).  Textual patches, renames or
mode changes have preimage and postimage pathnames in different
places in a form that can be parsed unambiguously and did not suffer
from this problem.

* jc/dotdot-is-parent-directory (2012-08-23) 1 commit
  (merged to 'next' on 2012-08-28 at 2f2ae87)
 + specifying ranges: we did not mean to make ".." an empty set

"git log .." errored out saying it is both rev range and a path when
there is no disambiguating "--" is on the command line.  Update the
command line parser to interpret ".." as a path in such a case.

* jc/maint-doc-checkout-b-always-takes-branch-name (2012-08-26) 1 commit
  (merged to 'next' on 2012-08-29 at e0d0f5c)
 + doc: "git checkout -b/-B/--orphan" always takes a branch name

The synopsis said "checkout [-B branch]" to make it clear the branch
name is a parameter to the option, but the heading for the option
description was "-B::", not "-B branch::", making the documentation
misleading.  There may be room in documentation pages of other
commands for similar improvements (hint, hint).

* jk/config-warn-on-inaccessible-paths (2012-08-21) 4 commits
  (merged to 'next' on 2012-08-24 at 7470bd6)
 + warn_on_inaccessible(): a helper to warn on inaccessible paths
 + attr: warn on inaccessible attribute files
 + gitignore: report access errors of exclude files
 + config: warn on inaccessible files

When looking for $HOME/.gitconfig etc., it is OK if we cannot read
them because they do not exist, but we did not diagnose existing
files that we cannot read.

* jk/maint-http-half-auth-push (2012-08-27) 8 commits
  (merged to 'next' on 2012-08-29 at 0ed32f5)
 + http: prompt for credentials on failed POST
 + http: factor out http error code handling
 + t: test http access to "half-auth" repositories
 + t: test basic smart-http authentication
 + t/lib-httpd: recognize */smart/* repos as smart-http
 + t/lib-httpd: only route auth/dumb to dumb repos
 + t5550: factor out http auth setup
 + t5550: put auth-required repo in auth/dumb

Pushing to smart HTTP server with recent Git fails without having
the username in the URL to force authentication, if the server is
configured to allow GET anonymously, while requiring authentication
for POST.

* kk/maint-for-each-ref-multi-sort (2012-08-21) 2 commits
  (merged to 'next' on 2012-08-24 at 28a5db4)
 + for-each-ref: Fix sort with multiple keys
 + t6300: test sort with multiple keys

"git for-each-ref" did not currectly support more than one --sort
option.

* lt/commit-tree-guess-utf-8 (2012-08-21) 1 commit
  (merged to 'next' on 2012-08-24 at d16ac69)
 + commit/commit-tree: correct latin1 to utf-8

Teaches "git commit" and "git commit-tree" the "we are told to use
utf-8 in log message, but this does not look like utf-8---attempt to
pass it through convert-from-latin1-to-utf8 and see if it makes
sense" heuristics "git mailinfo" already uses.

* nd/am-i18n-fix (2012-08-22) 1 commit
  (merged to 'next' on 2012-08-24 at f8e9a63)
 + am: quote string for translation before passing to eval_gettextln

"git am" wasn't marked up for i18n properly.

* nd/branch-v-alignment (2012-08-27) 1 commit
  (merged to 'next' on 2012-08-29 at 5c0d226)
 + branch -v: align even when branch names are in UTF-8

Output from "git branch -v" contains "(no branch)" that could be
localized, but the code to align it along with the names of branches
were counting in bytes, not in display columns.

* nd/i18n-parseopt-help (2012-08-22) 66 commits
  (merged to 'next' on 2012-08-24 at 2a04ce0)
 + Use imperative form in help usage to describe an action
 + Reduce translations by using same terminologies
 + i18n: write-tree: mark parseopt strings for translation
 + i18n: verify-tag: mark parseopt strings for translation
 + i18n: verify-pack: mark parseopt strings for translation
 + i18n: update-server-info: mark parseopt strings for translation
 + i18n: update-ref: mark parseopt strings for translation
 + i18n: update-index: mark parseopt strings for translation
 + i18n: tag: mark parseopt strings for translation
 + i18n: symbolic-ref: mark parseopt strings for translation
 + i18n: show-ref: mark parseopt strings for translation
 + i18n: show-branch: mark parseopt strings for translation
 + i18n: shortlog: mark parseopt strings for translation
 + i18n: rm: mark parseopt strings for translation
 + i18n: revert, cherry-pick: mark parseopt strings for translation
 + i18n: rev-parse: mark parseopt strings for translation
 + i18n: reset: mark parseopt strings for translation
 + i18n: rerere: mark parseopt strings for translation
 + i18n: status: mark parseopt strings for translation
 + i18n: replace: mark parseopt strings for translation
 + i18n: remote: mark parseopt strings for translation
 + i18n: read-tree: mark parseopt strings for translation
 + i18n: push: mark parseopt strings for translation
 + i18n: prune: mark parseopt strings for translation
 + i18n: prune-packed: mark parseopt strings for translation
 + i18n: pack-refs: mark parseopt strings for translation
 + i18n: pack-objects: mark parseopt strings for translation
 + i18n: notes: mark parseopt strings for translation
 + i18n: name-rev: mark parseopt strings for translation
 + i18n: mv: mark parseopt strings for translation
 + i18n: mktree: mark parseopt strings for translation
 + i18n: merge: mark parseopt strings for translation
 + i18n: merge-file: mark parseopt strings for translation
 + i18n: merge-base: mark parseopt strings for translation
 + i18n: ls-tree: mark parseopt strings for translation
 + i18n: ls-files: mark parseopt strings for translation
 + i18n: log: mark parseopt strings for translation
 + i18n: init-db: mark parseopt strings for translation
 + i18n: help: mark parseopt strings for translation
 + i18n: hash-object: mark parseopt strings for translation
 + i18n: grep: mark parseopt strings for translation
 + i18n: gc: mark parseopt strings for translation
 + i18n: fsck: mark parseopt strings for translation
 + i18n: format-patch: mark parseopt strings for translation
 + i18n: for-each-ref: mark parseopt strings for translation
 + i18n: fmt-merge-msg: mark parseopt strings for translation
 + i18n: fetch: mark parseopt strings for translation
 + i18n: fast-export: mark parseopt strings for translation
 + i18n: describe: mark parseopt strings for translation
 + i18n: config: mark parseopt strings for translation
 + i18n: count-objects: mark parseopt strings for translation
 + i18n: commit: mark parseopt strings for translation
 + i18n: column: mark parseopt strings for translation
 + i18n: clone: mark parseopt strings for translation
 + i18n: clean: mark parseopt strings for translation
 + i18n: cherry: mark parseopt strings for translation
 + i18n: checkout: mark parseopt strings for translation
 + i18n: checkout-index: mark parseopt strings for translation
 + i18n: check-attr: mark parseopt strings for translation
 + i18n: cat-file: mark parseopt strings for translation
 + i18n: branch: mark parseopt strings for translation
 + i18n: blame: mark parseopt strings for translation
 + i18n: add: mark parseopt strings for translation
 + i18n: bisect--helper: mark parseopt strings for translation
 + i18n: archive: mark parseopt strings for translation
 + i18n: mark "style" in OPT_COLUMN() for translation

A lot of i18n mark-up for the help text from "git <cmd> -h".

* nd/i18n-poison-test-updates (2012-08-27) 7 commits
  (merged to 'next' on 2012-08-29 at 9b7ff7f)
 + Fix tests under GETTEXT_POISON on parseopt
 + Fix tests under GETTEXT_POISON on git-remote
 + Fix tests under GETTEXT_POISON on pack-object
 + Fix tests under GETTEXT_POISON on git-apply
 + Fix tests under GETTEXT_POISON on diffstat
 + Fix tests under GETTEXT_POISON on git-stash
 + Fix tests under GETTEXT_POISON on relative dates

Update tests that can be broken with gettext-poison builds.

* pw/p4-use-client-spec-branch-detection (2012-08-20) 5 commits
  (merged to 'next' on 2012-08-24 at 08abc61)
 + git p4: make branch detection work with --use-client-spec
 + git p4: do wildcard decoding in stripRepoPath
 + git p4: set self.branchPrefixes in initialization
 + git p4 test: add broken --use-client-spec --detect-branches tests
 + git p4 test: move client_view() function to library

Fixes "git p4" when "--use-client-spec" and "--detect-branches" are
used together (the command used to misdetect branches).

* tr/maint-parseopt-avoid-empty (2012-08-20) 1 commit
  (merged to 'next' on 2012-08-24 at cffa9a0)
 + gettext: do not translate empty string

A workaround to avoid doing _(""), which translates to unwanted
magic string in the .po files.

--------------------------------------------------
[New Topics]

* kd/cvsimport-avoid-invalid-tag (2012-09-06) 1 commit
 - cvsimport: strip all inappropriate tag strings

"cvsimport" tried to create a tag taken from CVS without
sufficiently sanitizing it, causing the import to fail when an
invalid character in the tagname made underlying "git tag" to fail.

Will merge to 'next'.

* mh/abspath (2012-09-06) 8 commits
 - t0060: verify that real_path() removes extra slashes
 - real_path(): properly handle nonexistent top-level paths
 - t0060: verify that real_path() works correctly with absolute paths
 - real_path(): reject the empty string
 - t0060: verify that real_path() fails if passed the empty string
 - absolute_path(): reject the empty string
 - t0060: verify that absolute_path() fails if passed the empty string
 - t0060: move tests of real_path() from t0000 to here

* nd/i18n-status (2012-09-06) 1 commit
 - status: remove i18n legos

Will merge to 'next'.

* nd/log-n-doc (2012-09-06) 1 commit
 - doc: move rev-list option -<n> from git-log.txt to rev-list-options.txt

Will merge to 'next'.

* nd/maint-remote-remove (2012-09-06) 1 commit
 - remote: prefer subcommand name 'remove' to 'rm'

Will merge to 'next'.

* sb/send-email-reconfirm-fix (2012-09-06) 1 commit
 - send-email: initial_to and initial_reply_to are both optional

Will merge to 'next'.

* sn/ls-remote-get-url-doc (2012-09-07) 1 commit
 - ls-remote: document the '--get-url' option

Will merge to 'next'.

* dj/fetch-all-tags (2012-09-07) 1 commit
 - fetch --all: pass --tags/--no-tags through to each remote
 (this branch uses jk/argv-array.)

"git fetch --all", when passed "--no-tags", did not honor the
"--no-tags" option while fetching from individual remotes (the same
issue existed with "--tags", but combination "--all --tags" makes
much less sense than "--all --no-tags").

Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jx/test-real-path (2012-08-27) 1 commit
 - test: set the realpath of CWD as TRASH_DIRECTORY

Running tests with the "trash" directory elsewhere with the "--root"
option did not work well if the directory was specified by a symbolic
link pointing at it.

Seems broken as it makes $(pwd) and TRASH_DIRECTORY inconsistent.
Needs rerolling.

* jc/maint-push-refs-all (2012-08-27) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - [BROKEN] fetch/push: allow refs/*:refs/*

Allows pushing and fetching everything including refs/stash.
This is broken (see the log message there).

* er/doc-fast-import-done (2012-08-22) 1 commit
 - fast-import: document the --done option

Parked in 'pu' in case ESR responds with "Sorry, forgot to sign-off".

* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

"git add dir/" updated modified files and added new files, but does
not notice removed files, which may be "Huh?" to some users.  They
can of course use "git add -A dir/", but why should they?

Resurrected from graveyard, as I thought it was a worthwhile thing
to do in the longer term; waiting for comments.

* tx/relative-in-the-future (2012-08-16) 2 commits
 - date: show relative dates in the future
 - date: refactor the relative date logic from presentation

Not my itch; rewritten an earlier submission by Tom Xue into
somewhat more maintainable form, though it breaks existing i18n.

Anybody interested in fixing it up?  Otherwise may discard.

* tg/index-v5 (2012-08-17) 13 commits
 . p0002-index.sh: add perf test for the index formats
 . update-index.c: rewrite index when index-version is given
 . Write resolve-undo data for index-v5
 . Write index-v5 cache-tree data
 . Write index-v5
 . Read cache-tree in index-v5
 . Read resolve-undo data
 . Read index-v5
 . Make in-memory format aware of stat_crc
 . Add documentation of the index-v5 file format
 . t2104: Don't fail for index versions other than [23]
 . read-cache.c: Re-read index if index file changed
 . Move index v2 specific functions to their own file

A GSoC project.  Was waiting for comments from mentors and
stakeholders, but nothing seems to be happening, other than breakage
fixes on Cygwin.  May discard.

* pw/p4-submit-conflicts (2012-08-16) 12 commits
 - git p4: add submit --prepare-p4-only option
 - git p4: add submit --dry-run option
 - git p4: accept -v for --verbose
 - git p4: revert deleted files after submit cancel
 - git p4: rearrange submit template construction
 - git p4: test clean-up after failed submit, fix added files
 - git p4: standardize submit cancel due to unchanged template
 - git p4: move conflict prompt into run, use [c]ontinue and [q]uit
 - git p4: remove submit failure options [a]pply and [w]rite
 - git p4: gracefully fail if some commits could not be applied
 - git p4 test: use p4d -L option to suppress log messages
 - git p4 test: remove bash-ism of combined export/assignment

Waiting for the dust to settle.

* mz/rebase-range (2012-07-18) 7 commits
 . rebase (without -p): correctly calculate patches to rebase
 . rebase -p: don't request --left-right only to ignore left side
 . rebase -p: use --cherry-mark for todo file
 . git-rebase--interactive.sh: look up subject in add_pick_line
 . git-rebase--interactive: group all $preserve_merges code
 . git-rebase--interactive.sh: extract function for adding "pick" line
 . git-rebase--am.sh: avoid special-casing --keep-empty

Expecting a reroll.

Performance concerns from Windows folks.  Also the series lacks
proper sign-offs.

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

* as/check-ignore (2012-09-02) 10 commits
 . fixup: decl-after-stmt etc.
 . Add git-check-ignore
 . Provide free_directory() for reclaiming dir_struct memory
 . Extract some useful pathspec handling code from builtin/add.c into a library
 . For each exclude pattern, store information about where it came from
 . dir.c: refactor excluded() and path_excluded()
 . dir.c: refactor excluded_from_list()
 . dir.c: rename cryptic 'which' variable to more consistent name
 . Improve documentation and comments regarding directory traversal API
 . Update directory listing API doc to match code

Will be rerolled.

* jc/maint-ident-missing-human-name (2012-08-31) 1 commit
  (merged to 'next' on 2012-09-07 at 0e99b20)
 + split_ident_line(): make best effort when parsing author/committer line

"git show --format='%ci'" did not give timestamp correctly for
commits created without human readable name on "committer" line.

Will merge to 'master' as part of the fifth batch.

* jk/argv-array (2012-09-02) 4 commits
  (merged to 'next' on 2012-09-07 at 98dbd14)
 + submodule: use argv_array instead of hand-building arrays
 + fetch: use argv_array instead of hand-building arrays
 + argv-array: fix bogus cast when freeing array
 + argv-array: add pop function
 (this branch is used by dj/fetch-all-tags.)

Use argv-array API in "git fetch" implementation.

Will merge to 'master' as part of the fifth batch.

* rj/tap-fix (2012-09-02) 6 commits
 - test-lib.sh: Suppress the "passed all ..." message if no tests run
 - test-lib.sh: Add check for invalid use of 'skip_all' facility
 - test-lib.sh: Fix some shell coding style violations
 - t4016-*.sh: Skip all tests rather than each test
 - t3902-*.sh: Skip all tests rather than each test
 - t3300-*.sh: Fix a TAP parse error

Will merge to 'next'.

* rj/test-regex (2012-09-02) 1 commit
  (merged to 'next' on 2012-09-07 at e7e3527)
 + test-regex: Add a test to check for a bug in the regex routines

Git ships with a fall-back regexp implementation for platforms with
buggy regexp library; give people a tool to see if they should be
using it on their platform.

Will merge to 'master' as part of the fifth batch.

* jc/maint-checkout-fileglob-doc (2012-09-07) 2 commits
 - gitcli: contrast wildcard given to shell and to git
 - Document file-glob for "git checkout -- '*.c'"

Will merge to 'next'.

* jc/xprm-generation (2012-09-04) 1 commit
 - test-generation: compute generation numbers and clock skews

* rj/path-cleanup (2012-09-04) 5 commits
 - Call mkpathdup() rather than xstrdup(mkpath(...))
 - Call git_pathdup() rather than xstrdup(git_path("..."))
 - path.c: Use vsnpath() in the implementation of git_path()
 - path.c: Don't discard the return value of vsnpath()
 - path.c: Remove the 'git_' prefix from a file scope function

* rs/archive-zip-utf8 (2012-09-04) 1 commit
 - archive-zip: support UTF-8 paths

* mz/cherry-pick-cmdline-order (2012-08-30) 3 commits
  (merged to 'next' on 2012-08-31 at fc8eec4)
 + cherry-pick/revert: respect order of revisions to pick
 + demonstrate broken 'git cherry-pick three one two'
 + teach log --no-walk=unsorted, which avoids sorting

"git cherry-pick A C B" used to replay changes in A and then B and
then C if these three commits had committer timestamps in that
order, which is not what the user who said "A C B" naturally expects.

Will merge to 'master' as part of the fifth batch.

* ph/credential-gnome-keyring (2012-08-24) 1 commit
  (merged to 'next' on 2012-08-31 at 6f3b1de)
 + contrib: add credential helper for GnomeKeyring
 (this branch is used by ph/credential-refactor.)

The later refactoring of the shared code in the original series may
not be worth the trouble, so it is split into a separate topic that
builds on top of this one, which independently should be useful.

Will merge to 'master' as part of the fifth batch.

* ms/contrib-thunderbird-updates (2012-08-31) 2 commits
 - [SQUASH] minimum fixup
 - Thunderbird: fix appp.sh format problems

Update helper to send out format-patch output using Thunderbird.
Seems to have design regression for silent users.

* nd/i18n-index-pack (2012-08-31) 1 commit
  (merged to 'next' on 2012-09-07 at bbcece1)
 + i18n: mark more index-pack strings for translation

Will merge to 'master' as part of the fifth batch.

* jk/maint-quiet-is-synonym-to-s-in-log (2012-08-28) 1 commit
  (merged to 'next' on 2012-08-31 at 06f6953)
 + log: fix --quiet synonym for -s

We tried to bend backwards to allow "--quiet" to be a synonym as
"-s" when given as e.g. "git show --quiet", but did not quite
succeed.

Will merge to 'master' as part of the fifth batch.

* nd/checkout-option-parsing-fix (2012-09-07) 4 commits
 - fixup! checkout: reorder option handling
 - checkout: reorder option handling
 - checkout: move more parameters to struct checkout_opts
 - checkout: pass "struct checkout_opts *" as const pointer

The option parsing of "git checkout" had error checking, dwim and
defaulting missing options, all mixed in the code, and issuing an
appropriate error message with useful context was getting harder.
Reorganize the code and allow giving a proper diagnosis when the
user says "git checkout -b -t foo bar" (e.g. "-t" is not a good name
for a branch).

Will merge to 'next' after squashing the tip two.

* jc/maint-name-rev (2012-09-04) 7 commits
 - describe --contains: use "name-rev --weight"
 - name-rev --weight: tests and documentation
 - name-rev --weight: cache the computed weight in notes
 - name-rev --weight: trivial optimization
 - name-rev: --weight option
 - name_rev: clarify the logic to assign a new tip-name to a commit
 - name-rev: lose unnecessary typedef

"git name-rev" names the given revision based on a ref that can be
reached in the smallest number of steps from the rev, but that is
not useful when the caller wants to know which tag is the oldest one
that contains the rev.  This teaches a new mode to the command that
uses the oldest ref among those which contain the rev.

I am not sure if this is worth it; for one thing, even with the help
from notes-cache, it seems to make the "describe --contains" even
slower. Also the command will be unusably slow for a user who does
not have a write access (hence unable to create or update the
notes-cache).

Needs another round to at least find a better name for the option,
and possibly a cheaper but still better than the current "close to
the tip" heuristics.

* cn/branch-set-upstream-to (2012-08-30) 3 commits
  (merged to 'next' on 2012-08-31 at d550ecd)
 + branch: deprecate --set-upstream and show help if we detect possible mistaken use
 + branch: add --unset-upstream option
 + branch: introduce --set-upstream-to

"git branch --set-upstream origin/master" is a common mistake to
create a local branch 'origin/master' and set it to integrate with
the current branch.  With a plan to deprecate this option, introduce
"git branch (-u|--set-upstream-to) origin/master" that sets the
current branch to integrate with 'origin/master' remote tracking
branch.

Will merge to 'master' as part of the fifth batch.

* js/compat-itimer (2012-08-24) 1 commit
 - Support for setitimer() on platforms lacking it

Pieces to support compilation on __TANDEM.

* ph/credential-refactor (2012-09-02) 5 commits
 - wincred: port to generic credential helper
 - Merge branch 'ef/win32-cred-helper' into ph/credential-refactor
 - osxkeychain: port to generic credential helper implementation
 - gnome-keyring: port to generic helper implementation
 - contrib: add generic credential helper
 (this branch uses ph/credential-gnome-keyring.)

Attempts to refactor to share code among OSX keychain, Gnome keyring
and Win32 credential helpers.

* mh/fetch-filter-refs (2012-08-26) 17 commits
 - filter_refs(): simplify logic
 - fetch_pack(): free matching heads
 - cmd_fetch_pack(): simplify computation of return value
 - fetch-pack: report missing refs even if no existing refs were received
 - cmd_fetch_pack: return early if finish_connect() returns an error
 - filter_refs(): compress unmatched refs in heads array
 - filter_refs(): do not leave gaps in return_refs
 - filter_refs(): simplify by removing optimization
 - Pass nr_heads to filter_refs() by reference
 - Pass nr_heads to everything_local() by reference
 - Pass nr_heads to do_pack_ref() by reference
 - Let fetch_pack() inform caller about number of unique heads
 - filter_refs(): do not check the same head_pos twice
 - fetch-pack.c: name local variables more consistently
 - fetch_pack(): reindent function decl and defn
 - Rename static function fetch_pack() to http_fetch_pack()
 - t5500: add tests of error output for missing refs

Code simplification and clarification.
Waiting for a follow-up patch based on Peff's idea.

* jc/merge-bases (2012-08-31) 9 commits
  (merged to 'next' on 2012-09-07 at ab0974d)
 + reduce_heads(): reimplement on top of remove_redundant()
 + merge-base: "--is-ancestor A B"
 + get_merge_bases_many(): walk from many tips in parallel
 + in_merge_bases(): use paint_down_to_common()
 + merge_bases_many(): split out the logic to paint history
 + in_merge_bases(): omit unnecessary redundant common ancestor reduction
 + http-push: use in_merge_bases() for fast-forward check
 + receive-pack: use in_merge_bases() for fast-forward check
 + in_merge_bases(): support only one "other" commit

Optimise the "merge-base" computation a bit, and also update its
users that do not need the full merge-base information to call a
cheaper subset.

Will merge to 'master' as part of the fifth batch.

* jl/submodule-rm (2012-08-27) 1 commit
 - Teach rm to remove submodules unless they contain a git directory

"git rm submodule" cannot blindly remove a submodule directory as
its working tree may have local changes, and worse yet, it may even
have its repository embedded in it.  Teach it some special cases
where it is safe to remove a submodule, specifically, when there is
no local changes in the submodule working tree, and its repository
is not embedded in its working tree but is elsewhere and uses the
gitfile mechanism to point at it.

* fa/remote-svn (2012-08-28) 16 commits
 - Add a test script for remote-svn
 - remote-svn: add marks-file regeneration
 - Add a svnrdump-simulator replaying a dump file for testing
 - remote-svn: add incremental import
 - remote-svn: Activate import/export-marks for fast-import
 - Create a note for every imported commit containing svn metadata
 - vcs-svn: add fast_export_note to create notes
 - Allow reading svn dumps from files via file:// urls
 - remote-svn, vcs-svn: Enable fetching to private refs
 - When debug==1, start fast-import with "--stats" instead of "--quiet"
 - Add documentation for the 'bidi-import' capability of remote-helpers
 - Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
 - Add argv_array_detach and argv_array_free_detached
 - Add svndump_init_fd to allow reading dumps from arbitrary FDs
 - Add git-remote-testsvn to Makefile and .gitignore
 - Implement a remote helper for svn in C
 (this branch is used by fa/vcs-svn.)

A GSoC project.  Looked promising.
Waiting for comments from mentors and stakeholders.

* fa/vcs-svn (2012-08-28) 4 commits
 - vcs-svn: remove repo_tree
 - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
 - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
 - svndump: move struct definitions to .h
 (this branch uses fa/remote-svn.)

A GSoC project.  Looked promising.
Waiting for comments from mentors and stakeholders.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

(Originally merged to 'next' on 2012-07-23)

Will defer until the end of the 2012.
while waiting for older "less" to go extinct.

--------------------------------------------------
[Discarded]

* jc/sanitize-nkd-lazy-iconv-open (2012-07-31) 1 commit
 . macos: lazily initialize iconv

Teach the code that works around NKD/NKC gotcha on MacOS to call
iconv_open() only when it is necessary, in the hope of avoiding
set-up overhead.  It turns out that there was no noticeable
improvements.

* nd/checkout-branch-name-check (2012-08-27) 1 commit
 . checkout: verify new branch name's validity early

"git checkout -b --opt y" errors out saying that creating a new
branch to check it out and grabbing contents for paths out of a
commit are incompatible operations.  While it is technically correct
(the command line wants to create a new branch whose name is "--opt"
and check it out, and there shouldn't be anything else left on the
command line, but there is "y"), "--opt" is not a valid name of the
branch to begin with, so even without "y", the command will not
succeed.  Treat this case specially to complain that "--opt" is not
a valid branch name.
