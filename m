From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2012, #07; Mon, 19)
Date: Mon, 19 Mar 2012 17:23:07 -0700
Message-ID: <7vmx7c86j8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 01:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9mr9-00060M-C5
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 01:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758925Ab2CTAXO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 20:23:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755560Ab2CTAXL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 20:23:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 305486EB6;
	Mon, 19 Mar 2012 20:23:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=80N8v9Bw7DPsg7DUXSgRYGanN
	cE=; b=Lsx0AgXXTYNhhHjA9c/djLJA/xFHmfFB4KT0kTelx8psDelhqeiDS6cdi
	UnfE7G+Djm7CE+Q7dCQh1DbGeRoVuLvigcfCrv/TwvJrWxMZK+YFHLbdY8P5XmG3
	wutHlbJXpvVlmBUL+Doc/aBQ7fVPBSxRHF2h945LteG+1+G+Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=IUgPYjAio6N1FrOm+4v
	E+GfRdV0A0Ka4zDeaV0tAryUbH3rFZA6EoVmGt2IrnCVaCZcvwoVVPRbRsIc5qYn
	YOc3LBoGZLWCcW0QJVL0IAh+e1MO8vGqDiXGOktEnLJTrVd/6rafgalo4vwppP5u
	+jjhsYFWhQqkHUTbvhDkdiDQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 277B16EB5;
	Mon, 19 Mar 2012 20:23:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06CD16EB3; Mon, 19 Mar 2012
 20:23:08 -0400 (EDT)
X-master-at: f524129737d9ba3e685c31bacde844ec1db1fea9
X-next-at: 898d27118349f1a83f6d93545cb67dbcb0b8c288
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DECED186-7222-11E1-93D2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193475>

What's cooking in git.git (Mar 2012, #07; Mon, 19)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

The "git push" preparation steps (there are two topics) have enough tim=
e
to be polished to graduate to 'master' soon after 1.7.10 final.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/perl-i18n (2012-03-10) 3 commits
 + perl/Makefile: install Git::I18N under NO_PERL_MAKEMAKER
 + Git::I18N: compatibility with perl <5.8.3

Attempts to help installations with ancient Perl and/or without
MakeMaker.

* jc/maint-verify-objects-remove-pessimism (2012-03-15) 1 commit
  (merged to 'next' on 2012-03-15 at f824530)
 + fetch/receive: remove over-pessimistic connectivity check

The code to validate the history connectivity between old refs and new
refs used by fetch and receive-pack, introduced in 1.7.8, was grossly
inefficient and unnecessarily tried to re-validate integrity of individ=
ual
objects. This essentially reverts the patch that introduced the
performance regression.

* jn/maint-fast-import-empty-ls (2012-03-09) 2 commits
  (merged to 'next' on 2012-03-15 at d531079)
 + fast-import: don't allow 'ls' of path with empty components
 + fast-import: leakfix for 'ls' of dirty trees

fast-import did not diagnose "ls ''" that asks an empty path
as an error.

* sl/customize-sane-tool-path (2012-03-09) 1 commit
  (merged to 'next' on 2012-03-15 at a838844)
 + configure: allow user to prevent $PATH "sanitization" on Solaris

"configure" script learned to take "--sane-tool-path" from the command
line to record SANE_TOOL_PATH (used to avoid broken platform tools in
/usr/bin) in config.mak-autogen.  This may be useful for people on Sola=
ris
who have saner tools outside /usr/xpg[46]/bin.

* th/doc-diff-submodule-option (2012-03-14) 1 commit
  (merged to 'next' on 2012-03-14 at 0e1d755)
 + Documentation/diff-options: reword description of --submodule option

Update "diff --submodule" documentation.

* th/git-diffall (2012-03-14) 5 commits
  (merged to 'next' on 2012-03-14 at 38e1251)
 + contrib/diffall: fix cleanup trap on Windows
 + contrib/diffall: eliminate duplicate while loops
 + contrib/diffall: eliminate use of tar
 + contrib/diffall: create tmp dirs without mktemp
 + contrib/diffall: comment actual reason for 'cdup'

Update sample "diffall" script.

* th/mergetools-deltawalker (2012-03-15) 1 commit
  (merged to 'next' on 2012-03-15 at 1a62faf)
 + Documentation/difftool: add deltawalker to list of valid diff tools

--------------------------------------------------
[New Topics]

* jc/maint-clean-nested-worktree-in-subdir (2012-03-15) 2 commits
 - clean: preserve nested git worktree in subdirectories
 - remove_dir_recursively(): Add flag for skipping removal of toplevel =
dir
 (this branch is tangled with jh/notes-merge-in-git-dir-worktree.)

"git clean -d -f" (not "-d -f -f") is supposed to protect nested workin=
g
trees of independent git repositories that exist in the current project
working tree from getting removed, but the protection applied only to s=
uch
working trees that are at the top-level of the current project by mista=
ke.

Not urgent.

* ct/advise-push-default (2012-03-19) 1 commit
 - push: Provide situational hints for non-fast-forward errors

Breaks down the cases in which "git push" fails due to non-ff into thre=
e
categories, and gives separate advise messages.  I think there should b=
e
three advise confvars, not just two.

* nl/rebase-i-cheat-sheet (2012-03-16) 1 commit
 - [Do not merge] rebase -i: remind that the lines are top-to-bottom

Not urgent.

* da/difftool-test (2012-03-19) 1 commit
 - t7800: Test difftool passing arguments to diff

Makes sure "difftool" options can be given in any order.

* th/difftool-diffall (2012-03-19) 9 commits
 - difftool: print list of valid tools with '--tool-help'
 - difftool: teach dir-diff to copy modified files back to working tree
 - difftool: teach difftool to handle directory diffs
 - difftool: replace system call with Git::command_noisy
 - difftool: eliminate setup_environment function
 - difftool: stop appending '.exe' to git
 - difftool: remove explicit change of PATH
 - difftool: exit(0) when usage is printed
 - difftool: parse options using Getopt::Long

Reworks the "diffall" contrib script into "difftool" framework.  Use of
Getopt::Long obviously contradicts with da/difftool-test and breaks 'pu=
'.

--------------------------------------------------
[Stalled]

* nd/columns (2012-03-13) 12 commits
 - column: support grouping entries
 - column: support "denser" mode
 - ls-files: support --column
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add dense layout support
 - column: add columnar layout
 - Stop starting pager recursively
 - Add column layout skeleton and git-column

Rerolled again.  Modulo minor nits, looked nicer than the previous roun=
d.

* nd/threaded-index-pack (2012-03-11) 2 commits
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function

Another reroll after a bugreport on pthread usage discovered by Ramsey,
but it seems the topic is cooking between Ramsay and Duy out of tree.
Waiting for resolution.

* dg/test-from-elsewhere (2012-03-04) 2 commits
 - Support out-of-tree Valgrind tests
 - Allow overriding GIT_BUILD_DIR

Better support for out-of-tree test scripts, but it appears that the
approach needs to be rethought.  By repointing TEST_DIRECTORY to a
directory other than $(pwd)/.., an out of place test script can reach
test helpers and freshly built Git relative to it (GIT_BUILD_DIR is
a mere short-hand for $TEST_DIRECTORY/..).

* cn/apply-fix-ws-can-lengthen-lines (2012-03-11) 1 commit
 . apply: reallocate the postimage buffer when needed

Attempts to address an ancient bug that dates back to the addition
of an oddball "tab-in-indent" whitespace breakage class that wants
to have longer lines than the original when fixing things up.

Needs more work; results in double-frees.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained and needs a reroll.

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments
from =C3=86var. The second one needs more work, both in perl/Git.pm and
prompt.c, to give precedence to tty over SSH_ASKPASS when terminal
is available.

* jc/split-blob (2012-03-16) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

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

* jh/notes-merge-in-git-dir-worktree (2012-03-15) 4 commits
 - notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE; it may be the u=
ser's cwd
 - notes-merge: use opendir/readdir instead of using read_directory()
 - t3310: illustrate failure to "notes merge --commit" inside $GIT_DIR/
 - remove_dir_recursively(): Add flag for skipping removal of toplevel =
dir
 (this branch is tangled with jc/maint-clean-nested-worktree-in-subdir.=
)

Running "notes merge --commit" failed to perform correctly when run
from any directory inside $GIT_DIR/.  When "notes merge" stops with
conflicts, $GIT_DIR/NOTES_MERGE_WORKTREE is the place a user edits
to resolve it.

Not urgent.

* jn/diffstat-tests (2012-03-13) 7 commits
 - diffstat summary line varies by locale: miscellany
 - test: use numstat instead of diffstat in binary-diff test
 - test: use --numstat instead of --stat in "git stash show" tests
 - test: test cherry-pick functionality and output separately
 - test: modernize funny-names test style
 - test: use numstat instead of diffstat in funny-names test
 - test: use test_i18ncmp when checking --stat output

Some tests checked the "diff --stat" output when they do not have to,
which unnecessarily made things harder to verify under GETTEXT_POISON.

Not urgent.

* tr/maint-word-diff-regex-sticky (2012-03-14) 3 commits
 - diff: tweak a _copy_ of diff_options with word-diff
 - diff: refactor the word-diff setup from builtin_diff_cmd
 - t4034: diff.*.wordregex should not be "sticky" in --word-diff

The regexp configured with wordregex was incorrectly reused across
files.
Not urgent.

* zj/test-cred-helper-nicer-prove (2012-03-15) 2 commits
 - t0303: resurrect commit message as test documentation
 - t0303: immediately bail out w/o GIT_TEST_CREDENTIAL_HELPER

Minor improvement to t0303.
Not urgent.

* jc/commit-hook-authorship (2012-03-11) 3 commits
  (merged to 'next' on 2012-03-12 at 05ca7f8)
 + commit: pass author/committer info to hooks
 + t7503: does pre-commit-hook learn authorship?
 + ident.c: add split_ident_line() to parse formatted ident line
 (this branch is tangled with jc/run-hook-env-1.)

"git commit --author=3D$name" did not tell the name that was being
recorded in the resulting commit to hooks, even though it does do so
when the end user overrode the authorship via the "GIT_AUTHOR_NAME"
environment variable.  This is a simpler of the two approaches.

Will defer til 1.7.10.

* jc/run-hook-env-1 (2012-03-11) 3 commits
 - run_hook(): enhance the interface to pass arbitrary environment
 + t7503: does pre-commit-hook learn authorship?
 + ident.c: add split_ident_line() to parse formatted ident line
 (this branch is tangled with jc/commit-hook-authorship.)

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks=
=2E

* jc/diff-algo-cleanup (2012-02-19) 2 commits
  (merged to 'next' on 2012-03-15 at cca0032)
 + xdiff: PATIENCE/HISTOGRAM are not independent option bits
 + xdiff: remove XDL_PATCH_* macros
 (this branch is used by jc/diff-ignore-case.)

Resurrects the preparatory clean-up patches from another topic that was
discarded, as this would give a saner foundation to build on diff.algo
configuration option series.

Not urgent.

* jh/apply-free-patch (2012-03-07) 1 commit
 - apply: do not leak patches and fragments

Will defer til 1.7.10.

* rs/unpack-trees-leakfix (2012-03-06) 1 commit
  (merged to 'next' on 2012-03-07 at 69a69cd)
 + unpack-trees: plug minor memory leak

Will defer til 1.7.10.

* tb/maint-remove-irrelevant-i18n-test (2012-03-06) 1 commit
  (merged to 'next' on 2012-03-07 at 23f2dd1)
 + t0204: remove a test that checks undefined behaviour

I tentatively parked this in 'next' but later reverted the merge.
Will discard.

* mm/push-default-switch-warning (2012-03-09) 1 commit
 - push: start warning upcoming default change for push.default

Not urgent.

This resurrects an ancient patch I wrote during a discussion we had in =
the
1.6.3-1.6.4 era.  This should probably come after ct/advise-push-defaul=
t
topic and at that point the advise messages need to be rephrased, takin=
g
the future default change into account.

* jc/fmt-merge-msg-people (2012-03-13) 1 commit
 - fmt-merge-msg: show those involved in a merged series

The "fmt-merge-msg" command learns to list the primary contributors
involved in the side topic you are merging.

Will defer til 1.7.10.

* nl/http-proxy-more (2012-03-15) 5 commits
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice
 - http: handle proxy authentication failure (error 407)
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not se=
t

The code to talk to http proxies learn to use the same credential
API used to talk to the final http destinations.

Will defer til 1.7.10.

* nd/stream-more (2012-03-07) 7 commits
  (merged to 'next' on 2012-03-07 at 7325922)
 + update-server-info: respect core.bigfilethreshold
 + fsck: use streaming API for writing lost-found blobs
 + show: use streaming API for showing blobs
 + parse_object: avoid putting whole blob in core
 + cat-file: use streaming API to print blobs
 + Add more large blob test cases
 + streaming: make streaming-write-entry to be more reusable

Use API to read blob data in smaller chunks in more places to
reduce the memory footprint.  In general, looked fairly good.

Will defer til 1.7.10.

--------------------------------------------------
[Discarded]

* jc/diff-ignore-mode (2012-03-01) 1 commit
 . diff --ignore-mode-change

 * jc/diff-ignore-case (2012-02-28) 6 commits
 . diff: -i is "--ignore-case" but means a bit more in "log"
 . diff: --ignore-case
 . xdiff: introduce XDF_IGNORE_CASE
 . xdiff: introduce XDF_INEXACT_MATCH
 - xdiff: PATIENCE/HISTOGRAM are not independent option bits
 - xdiff: remove XDL_PATCH_* macros

* jh/trace-use-startup-info (2012-03-02) 1 commit
 . Use startup_info->prefix rather than prefix.

I tend to agree with the doubt of the author of this patch expressed.

* nd/optim-connected (2012-03-15) 1 commit
 . {fetch,receive}-pack: skip sha-1 integrity test on objects from new =
pack

jc/maint-verify-objects-remove-pessimism replaces this.

* jc/advise-push-default (2011-12-18) 1 commit
 . push: hint to use push.default=3Dupstream when appropriate

A rework by Christopher Tiwald replaces this.

* th/mergetools-tool-help (2012-03-15) 1 commit
 . difftool: print list of valid tools with '--tool-help'

Reworked as part of th/difftool-diffall topic.
