From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2012, #06; Sun, 22)
Date: Sun, 22 Jul 2012 14:38:22 -0700
Message-ID: <7vfw8jpjch.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 23:38:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St3rM-0000JK-Vr
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 23:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab2GVVi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 17:38:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab2GVVi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 17:38:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D2A5909B;
	Sun, 22 Jul 2012 17:38:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=O
	9wqaABxKoptckP8dFavfX2G/Go=; b=jomvbqYHhmzS9z66WjfN/mBNgQneh39zL
	oWKio8oP30hkFnhP8l0uVkIxnLHDlQT24aOx9s6ThBL/wmMmiByxfiOz6Wnm6kWm
	iZ7xV32VQoqWAfc40GcC3jOtulyNqRCsNOqzyfVieoQeYz3ytT6DMcgEJmezdeZT
	BkEqNyuXbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=OIP
	Wi+kvn/cMPGWlU6XU1D2nzHVjK0MlSA2OBVy+kDCK3jzjkA0q/VLdCNwd5FKvt+d
	rdFv+hk9xkzaG0SHf4lnd0Yof9MdvrmwMzYTXTqA13Kemz9F85xjFfB5IzG51LDi
	DbPAXBPstLmAlFnYeEDNL78EYobTL0EalzuTqGXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A005909A;
	Sun, 22 Jul 2012 17:38:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13AF99097; Sun, 22 Jul 2012
 17:38:23 -0400 (EDT)
X-master-at: e7719469154fc9bbf910df89b80a5145c7d93959
X-next-at: 70d4bc158cb1d6d848984267f267177390e71989
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 908DE130-D445-11E1-B486-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201871>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

I think we are more or less done for this cycle except for a handful
of topics that are to be rerolled, even though I haven't tagged the
tip of the 'master' with 1.7.12-rc0 yet.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* as/t4012-style-updates (2012-07-16) 8 commits
  (merged to 'next' on 2012-07-16 at 86c14f6)
 + t4012: Use test_must_fail instead of if-else
 + t4012: use 'printf' instead of 'dd' to generate a binary file
 + t4012: Re-indent test snippets
 + t4012: Make --shortstat test more robust
 + t4012: Break up pipe into serial redirections
 + t4012: Actually quote the sed script
 + t4012: Unquote git command fragment in test title
 + t4012: modernize style for quoting

* jc/maint-filter-branch-epoch-date (2012-07-12) 3 commits
  (merged to 'next' on 2012-07-13 at d144342)
 + t7003: add test to filter a branch with a commit at epoch
 + date.c: Fix off by one error in object-header date parsing
  (merged to 'next' on 2012-07-10 at f9774ca)
 + filter-branch: do not forget the '@' prefix to force git-timestamp

In 1.7.9 era, we taught "git rebase" about the raw timestamp format
but we did not teach the same trick to "filter-branch", which rolled
a similar logic on its own.

* jc/sha1-name-more (2012-07-13) 27 commits
  (merged to 'next' on 2012-07-13 at 534e6fe)
 + t1512: match the "other" object names
  (merged to 'next' on 2012-07-11 at d30ef51)
 + t1512: ignore whitespaces in wc -l output
  (merged to 'next' on 2012-07-10 at 669dd92)
 + rev-parse --disambiguate=<prefix>
 + rev-parse: A and B in "rev-parse A..B" refer to committish
 + reset: the command takes committish
 + commit-tree: the command wants a tree and commits
 + apply: --build-fake-ancestor expects blobs
 + sha1_name.c: add support for disambiguating other types
 + revision.c: the "log" family, except for "show", takes committish
 + revision.c: allow handle_revision_arg() to take other flags
 + sha1_name.c: introduce get_sha1_committish()
 + sha1_name.c: teach lookup context to get_sha1_with_context()
 + sha1_name.c: many short names can only be committish
 + sha1_name.c: get_sha1_1() takes lookup flags
 + sha1_name.c: get_describe_name() by definition groks only commits
 + sha1_name.c: teach get_short_sha1() a commit-only option
 + sha1_name.c: allow get_short_sha1() to take other flags
 + get_sha1(): fix error status regression
 + sha1_name.c: restructure disambiguation of short names
 + sha1_name.c: correct misnamed "canonical" and "res"
 + sha1_name.c: refactor find_short_packed_object()
 + sha1_name.c: rename "now" to "current"
 + sha1_name.c: clarify what "fake" is for in find_short_object_filename()
 + sha1_name.c: get rid of get_sha1_with_mode()
 + sha1_name.c: get rid of get_sha1_with_mode_1()
 + sha1_name.c: hide get_sha1_with_context_1() ugliness
 + sha1_name.c: indentation fix

Logic to disambiguate abbreviated object names have been taught to
take advantage of object types that are expected in the context,
e.g. XXXXXX in the "git describe" output v1.2.3-gXXXXXX must be a
commit object, not a blob nor a tree.  This will help us prolong the
lifetime of abbreviated object names.

* jk/revision-walk-stop-at-max-count (2012-07-13) 1 commit
  (merged to 'next' on 2012-07-16 at 603975d)
 + revision: avoid work after --max-count is reached

"git log -n 1 -- rarely-touched-path" was spending unnecessary
cycles after showing the first change to find the next one, only to
discard it.

* jl/maint-1.7.10-recurse-submodules-with-symlink (2012-07-12) 1 commit
  (merged to 'next' on 2012-07-16 at 2e10caf)
 + submodules: don't stumble over symbolic links when cloning recursively

When "git submodule add" clones a submodule repository, it can get
confused where to store the resulting submodule repository in the
superproject's .git/ directory when there is a symbolic link in the
path to the current directory.

* lk/more-helpful-status-hints (2012-07-16) 1 commit
  (merged to 'next' on 2012-07-16 at 8f9b3cc)
 + status: color in-progress message like other header messages

Finishing touches.

* mm/config-xdg (2012-07-16) 1 commit
  (merged to 'next' on 2012-07-16 at 1a75d75)
 + config: fix several access(NULL) calls

Finishing touches.

* ms/daemon-doc-typo (2012-07-16) 1 commit
  (merged to 'next' on 2012-07-16 at 3976434)
 + Documentation/git-daemon: add missing word

* pg/maint-1.7.9-am-where-is-patch (2012-07-13) 1 commit
  (merged to 'next' on 2012-07-16 at 32f1e30)
 + am: indicate where a failed patch is to be found

When "git am" failed, old timers knew to check .git/rebase-apply/patch
to see what went wrong, but we never told the users about it.

--------------------------------------------------
[New Topics]

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

Will merge to 'master'.

* jk/mediawiki-credential (2012-07-18) 4 commits
  (merged to 'next' on 2012-07-22 at 2cb99b2)
 + mw-to-git: use git-credential's URL parser
 + credential: convert "url" attribute into its parsed subparts
 + mw-to-git: check blank credential attributes via length
 + docs/credential: minor clarity fixups

Will merge to 'master'.

* jv/maint-no-ext-diff (2012-07-19) 2 commits
  (merged to 'next' on 2012-07-22 at eefcf45)
 + diff: test precedence of external diff drivers
 + diff: correctly disable external_diff with --no-ext-diff

"git diff --no-ext-diff" did not output anything for a typechange
filepair when GIT_EXTERNAL_DIFF is in effect.

Will merge to 'master'.

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

Will merge to 'master'.

* mz/rebase-range (2012-07-18) 7 commits
 - rebase (without -p): correctly calculate patches to rebase
 - rebase -p: don't request --left-right only to ignore left side
 - rebase -p: use --cherry-mark for todo file
 - git-rebase--interactive.sh: look up subject in add_pick_line
 - git-rebase--interactive: group all $preserve_merges code
 - git-rebase--interactive.sh: extract function for adding "pick" line
 - git-rebase--am.sh: avoid special-casing --keep-empty

* sl/autoconf (2012-07-19) 7 commits
 - build: reconfigure automatically if configure.ac changes
 - build: "make clean" should not remove configure-generated files
 - autoconf: use AC_CONFIG_COMMANDS instead of ad-hoc 'config.mak.append'
 - autoconf: remove few redundant semicolons
 - autoconf: remove some redundant shell indirections
 - autoconf: GIT_CONF_APPEND_LINE -> GIT_CONF_SUBST
 - autoconf: GIT_CONF_APPEND_LINE: change signature

Will merge to 'next'.

* jx/i18n-1.7.11 (2012-07-22) 7 commits
 - i18n: merge-recursive: mark strings for translation
 - Remove unused and bad gettext block from git-am
 - i18n: am: mark more strings for translation
 - Remove obsolete LONG_USAGE which breaks xgettext
 - i18n: Rewrite gettext messages start with dash
 - i18n: rebase: mark strings for translation
 - i18n: New keywords for xgettext extraction from sh

* th/difftool-diffall (2012-07-19) 1 commit
 - difftool: only copy back files modified during directory diff

Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jl/submodule-rm (2012-07-05) 2 commits
 - rm: remove submodules from the index and the .gitmodules file
 - rm: don't fail when removing populated submodules

Expecting a reroll.

* mh/maint-revisions-doc (2012-07-05) 2 commits
 - Document rev^! and rev^@ as revision specifiers
 - Make <refname> documentation more consistent.

Expecting a reroll of the tip one.

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

* nk/maint-gitweb-log-by-lines (2012-07-05) 3 commits
  (merged to 'next' on 2012-07-13 at 780e16a)
 + gitweb: Add support to Link: tag
 + gitweb: Handle other types of tag in git_print_log
 + gitweb: Cleanup git_print_log()

Teach gitweb to pay attention to various forms of credits that are
similar to "Signed-off-by:" lines.

Needs to be eyeballed for the correctness of the esc_html() in the tip one.

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

* sn/doc-typofix (2012-07-14) 1 commit
  (merged to 'next' on 2012-07-22 at 168bba9)
 + doc: A few minor copy edits.

Will merge to 'master'.

* tg/ce-namelen-field (2012-07-11) 2 commits
  (merged to 'next' on 2012-07-22 at 2d85b05)
 + Strip namelen out of ce_flags into a ce_namelen field
 + Merge branch 'tg/maint-cache-name-compare' into tg/ce-namelen-field

Split lower bits of ce_flags field and creates a new ce_namelen
field in the in-core index structure.

Will merge to 'master'.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Will defer for another cycle.
