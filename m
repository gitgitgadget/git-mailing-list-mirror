From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2012, #01; Thu, 2)
Date: Thu, 02 Aug 2012 16:11:25 -0700
Message-ID: <7v1ujodh42.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 01:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx4YJ-0007zr-5X
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 01:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab2HBXLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 19:11:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609Ab2HBXL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 19:11:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E16A9884;
	Thu,  2 Aug 2012 19:11:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=K
	PLGDSMYRIh4ZEJaIFjbiEcFlzg=; b=I53uAoNzNbJVyyjSsG4ovmqsG2yA6xqjj
	DagVxOf8MmdGqsw7UYTsGkuvmfPGXxRAkRy06pNBXKslNVgJXYda3dYSyt7Rk6dr
	rxSL1x1y1rLRBWuR8czmsdTnsuxIThGoWyRtuZURQXUtP6sZHcY3cPi03PKs5Oco
	xS6OnbEJ10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=SY1
	9EVPRZspesA1TroCkeqffWCxsMIEiWLSXIR9beIHyAXoxyqmqP46fheLXo3ZI46U
	IpyWEWR7igT4vq1G86TANcz1+4iE6hmyXm13BEXSDPiWRZv4C0Kf9GYpljBLV8YF
	sTwwvGp1fOOSccCG3ACaaLifC+ty9SjQ1A7NX5xA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC2D9883;
	Thu,  2 Aug 2012 19:11:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00032987E; Thu,  2 Aug 2012
 19:11:26 -0400 (EDT)
X-master-at: 05a20c87abd08441c98dfcca0606bc0f8432ab26
X-next-at: b94da764fd895685600c79f25c9c9ca5003a2807
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62C73642-DCF7-11E1-A2A0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202813>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The series to mark strings for i18n in merge(-recursive), am and
rebase have been merged.  From now on, until the final release, no
further updates, except for obviously correct fixes to regressions,
will be merged to 'master'.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/maint-sane-execvp-notdir (2012-07-31) 1 commit
 - sane_execvp(): ignore non-directory on $PATH

"git foo" errored out with "Not a directory" when the user had a non
directory on $PATH, and worse yet it masked an alias "foo" to run.

Not urgent.

* jc/sanitize-nkd-lazy-iconv-open (2012-07-31) 1 commit
 - macos: lazily initialize iconv

Teach the code that works around NKD/NKC gotcha on MacOS to call
iconv_open() only when it is necessary, in the hope of avoiding
set-up overhead.

Not urgent.

* tr/maint-send-email-2047 (2012-07-31) 1 commit
 - send-email: improve RFC2047 quote parsing

"git send-email" did not unquote encoded words that appear on the
header correctly, and lost "_" from strings.

Not urgent.

* cw/cherry-pick-allow-empty-message (2012-08-02) 1 commit
 - cherry-pick: add --allow-empty-message option

"git cherry-pick" by default stops when it sees a commit without any
log message.  The "--allow-empty-message" option can be used to
silently proceed.

Not urgent.

* ms/git-svn-1.7 (2012-08-02) 20 commits
 - git-svn: remove ad-hoc canonicalizations
 - git-svn: canonicalize newly-minted URLs
 - git-svn: introduce add_path_to_url function
 - git-svn: canonicalize earlier
 - git-svn: replace URL escapes with canonicalization
 - git-svn: attempt to mimic SVN 1.7 URL canonicalization
 - t9107: fix typo
 - t9118: workaround inconsistency between SVN versions
 - Git::SVN{,::Ra}: canonicalize earlier
 - git-svn: path canonicalization uses SVN API
 - Git::SVN::Utils: remove irrelevant comment
 - git-svn: add join_paths() to safely concatenate paths
 - git-svn: factor out _collapse_dotdot function
 - git-svn: use SVN 1.7 to canonicalize when possible
 - git-svn: move canonicalization to Git::SVN::Utils
 - use Git::SVN{,::RA}->url accessor globally
 - use Git::SVN->path accessor globally
 - Git::SVN::Ra: use accessor for URLs
 - Git::SVN: use accessor for URLs internally
 - Git::SVN: use accessors internally for path

A series by Michael Schwern via Eric to update git-svn to revamp the
way URLs are internally passed around, to make it work with SVN 1.7.

--------------------------------------------------
[Graduated to "master"]

* jx/i18n-1.7.11 (2012-07-26) 7 commits
  (merged to 'next' on 2012-07-30 at 3c00929)
 + i18n: merge-recursive: mark strings for translation
 + Remove dead code which contains bad gettext block
 + i18n: am: mark more strings for translation
 + rebase: remove obsolete and unused LONG_USAGE which breaks xgettext
 + i18n: Rewrite gettext messages start with dash
 + i18n: rebase: mark messages for translation
 + i18n: New keywords for xgettext extraction from sh

Will merge after 1.7.11-rc1
together with nd/maint-i18n-diffstat topic, as they will affect i18n/l10n
teams.

* nd/maint-i18n-diffstat (2012-07-26) 1 commit
  (merged to 'next' on 2012-07-30 at 0da57ef)
 + i18n: leave \n out of translated diffstat

Will merge after 1.7.11-rc1
together with jx/i18n-1.7.11 topic, as they will affect i18n/l10n
teams.

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

* jc/maint-t7406-rev-parse-max-count-huh (2012-07-30) 1 commit
  (merged to 'next' on 2012-07-30 at 9b27acc)
 + t7406: fix misleading "rev-parse --max-count=1 HEAD"

Test clean-up, with no behaviour change.
Not urgent.

* jk/maint-diff-nul40-as-sentinel (2012-07-29) 1 commit
 + diff: do not use null sha1 as a sentinel value
 (this branch is used by jk/maint-null-in-trees.)

"git diff" had a confusion between taking data from a path in the
working tree and taking data from an object that happens to have
name 0{40} recorded in a tree.
Not urgent.

* mz/cherry-code-cleanup (2012-07-29) 3 commits
 - cherry: remove redundant check for merge commit
 - cherry: don't set ignored rev_info options
 - remove unnecessary parameter from get_patch_ids()

Minor code clean-up on the cherry-pick codepath.
Not urgent.

* jc/maint-config-exit-status (2012-07-30) 1 commit
  (merged to 'next' on 2012-07-30 at 8392da9)
 + config: "git config baa" should exit with status 1

The exit status code from "git config" was way overspecified while
being incorrect.  Update the implementation to give the documented
status for a case that was documented, and introduce a new code for
"all other errors".

Not urgent.

* jk/maint-null-in-trees (2012-07-29) 2 commits
  (merged to 'next' on 2012-07-30 at 771c497)
 + fsck: detect null sha1 in tree entries
 + do not write null sha1s to on-disk index
 (this branch uses jk/maint-diff-nul40-as-sentinel.)

We do not want a link to 0{40} object stored anywhere in our objects.

Not urgent.

* sz/submodule-force-update (2012-07-25) 1 commit
  (merged to 'next' on 2012-07-26 at 3bda2be)
 + Make 'git submodule update --force' always check out submodules.

We may want a documentation update and a few tests on top.

Not urgent.

* jc/test-prereq (2012-07-30) 7 commits
  (merged to 'next' on 2012-07-30 at b7c6949)
 + t3910: use the UTF8_NFD_TO_NFC test prereq
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

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
  (merged to 'next' on 2012-07-23 at fe59cb6)
 + pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Will defer for another cycle.
