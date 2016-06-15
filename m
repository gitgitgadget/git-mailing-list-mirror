From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2012, #07; Mon, 25)
Date: Mon, 25 Jun 2012 13:08:26 -0700
Message-ID: <7vmx3rf939.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 22:08:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjFaN-0006DD-GX
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 22:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab2FYUIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 16:08:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab2FYUI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 16:08:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76FA194BA;
	Mon, 25 Jun 2012 16:08:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=J
	IUa9g7S136V+xYUTvc2Kv1UKn0=; b=Pz1tNM7ZMqUyZCO3w87oIQy8katVSId9G
	GzdejgG/YdeQtPLy48K4cZfu2GAvDFXMzXIA8Vwc2vjQCqfSF3QteRl0MqgEhR/T
	LfMcOWsmsSnyenYp33gc+1SGLgjet7a8ih8qHkhLloSiDOeR7ojzB7AEQaYb5fnV
	R+M4OYfZCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=PV0
	Za3bS/gu95awRs5oFRjfHX88hBjNcFMYmhqT383KfmZTvB5r6Ndq0S362xIzEDeC
	gaQGHUULbDSspJr9zfdiayB30xEiZrkGV5g57LMh+UnBxNLWLqLw9y6QNeyqSG+L
	kdHGp1Qaw61kmrr8AiwhC14rbj68S00hZdLabuk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DC0194B9;
	Mon, 25 Jun 2012 16:08:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70D3C94B7; Mon, 25 Jun 2012
 16:08:27 -0400 (EDT)
X-master-at: bc9e7dd41fe8b51cc7f2e79312a2ff777899f930
X-next-at: d3f29e2e8f7ed8869c211f67f49ffecd8994f456
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86C462FE-BF01-11E1-BE0F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200595>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The second batch of topics have graduated to 'master', and a handful
of topics have entered 'next' for developer testing.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cn/cherry-pick-range-docs (2012-06-15) 2 commits
  (merged to 'next' on 2012-06-21 at 5cf7f97)
 + git-cherry-pick.txt: clarify the use of revision range notation
 + Documentation: --no-walk is no-op if range is specified

The command line argument of "git cherry-pick maint master..next" is
just an ordinary revision range, which is unintuitive and at least
deserves documentation.

* jc/ustar-checksum-is-unsigned (2012-06-13) 1 commit
  (merged to 'next' on 2012-06-21 at bb8e2b0)
 + archive: ustar header checksum is computed unsigned

"git archive" incorrectly computed the header checksum; the symptom
was observed only when using pathnames with hi-bit set.

* jk/no-more-asciidoc7 (2012-05-30) 2 commits
  (merged to 'next' on 2012-06-19 at a36b498)
 + docs: drop antique comment from Makefile
 + docs: drop asciidoc7compatible flag

Originally merged to 'next' on 2012-06-05.

We no longer use AsciiDoc7 syntax in our documentation and favor a
more modern style.

* lm/git-blame-el (2012-06-14) 3 commits
  (merged to 'next' on 2012-06-21 at 6514487)
 + git-blame.el: Do not use bare 0 to mean (point-min)
 + git-blame.el: Use with-current-buffer where appropriate
 + git-blame.el: Do not use goto-line in lisp code

* lp/no-cmd-http-fetch (2012-06-15) 1 commit
  (merged to 'next' on 2012-06-21 at 242a10e)
 + builtin.h: remove unused cmd_<foo> declarations

Remove unused declarations of nonexisting functions from a header
file.

* nd/i18n-branch-lego (2012-06-07) 1 commit
  (merged to 'next' on 2012-06-21 at 0cb53fc)
 + Remove i18n legos in notifying new branch tracking setup

Restructure the way message strings are created, in preparation for
marking them for i18n.

* nd/i18n-misc (2012-06-07) 3 commits
  (merged to 'next' on 2012-06-21 at 0a82040)
 + rerere: remove i18n legos in result message
 + notes-merge: remove i18n legos in merge result message
 + reflog: remove i18n legos in pruning message

Restructure the way message strings are created, in preparation for
marking them for i18n.

* rr/doc-commit (2012-06-08) 1 commit
  (merged to 'next' on 2012-06-21 at af8301c)
 + commit: document a couple of options

* rs/git-blame-mapcar-mapc (2012-06-10) 1 commit
  (merged to 'next' on 2012-06-21 at 71a3b36)
 + git-blame.el: use mapc instead of mapcar

* rs/ipv6-ssh-url (2012-06-13) 1 commit
  (merged to 'next' on 2012-06-21 at d0116a8)
 + git: Wrong parsing of ssh urls with IPv6 literals ignores port

ssh:// URLs to IPv6 hosts with custom port number were parsed
incorrectly.

--------------------------------------------------
[New Topics]

* mm/config-xdg (2012-06-25) 4 commits
 - config: write to $XDG_CONFIG_HOME/git/config file when appropriate
 - Let core.attributesfile default to $XDG_CONFIG_HOME/git/attributes
 - Let core.excludesfile default to $XDG_CONFIG_HOME/git/ignore
 - config: read (but not write) from $XDG_CONFIG_HOME/git/config file

Teach git to read various information from $XDG_CONFIG_HOME/git/ to allow
the user to avoid cluttering $HOME.

* mm/credential-plumbing (2012-06-25) 3 commits
 - git-remote-mediawiki: add credential support
 - git credential fill: output the whole 'struct credential'
 - add 'git credential' plumbing command

Expose the credential API to scripted Porcelain writers.

* th/diff-no-index-fixes (2012-06-22) 2 commits
 - diff-no-index: exit(1) if 'diff --quiet <repo file> <external file>' finds changes
 - diff: handle relative paths in no-index

"git diff --no-index" did not correctly handle relative paths and
did not correctly give exit codes when run under "--quiet" option.

Will merge to 'next'.

* nd/clone-single-fix (2012-06-22) 1 commit
 - clone: fix ref selection in --single-branch --branch=xxx

"git clone --single-branch" to clone a single branch did not limit
the cloning to the specified branch.

Will merge to 'next'.

--------------------------------------------------
[Stalled]

* db/vcs-svn (2012-06-01) 6 commits
 - vcs-svn: drop no-op reset methods
 - vcs-svn: fix signedness warnings
 - vcs-svn: prefer strstr over memmem
 - vcs-svn: prefer constcmp to prefixcmp
 - vcs-svn: simplify cleanup in apply_one_window()
 - vcs-svn: fix clang-analyzer error

Waiting for Jonathan's clean-up offered earlier.

* nl/http-proxy-more (2012-05-11) 2 commits
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice

I queued only the later two patches from this series, even though they do
not make much sense without the first one that seems to need a bit more
work, so that we won't forget.

Will discard without prejudice, unless rerolled.

* jk/no-op-push-message (2012-05-30) 1 commit
 - improve no-op push output

Rewords the status message of "git push" that pushed only one ref
differently from "Everything up-to-date", to give a bit more help to
people who get the message when their current branch is not pushed.

I had an impression after the discussion thread that a redesign is
coming, but it hasn't happened yet.

Will discard without prejudice, unless rerolled.

* jc/apply-3way (2012-06-13) 19 commits
 - apply --3way: tests
 - apply: document --3way option
 - apply: allow rerere() upon --3way results
 - apply: register conflicted stages to the index
 - apply: --3way with add/add conflict
 - apply: move verify_index_match() higher
 - apply: plug the three-way merge logic in
 - apply: fall back on three-way merge
 - apply: accept -3/--3way command line option
 - apply: move "already exists" logic to check_to_create()
 - apply: move check_to_create_blob() closer to its sole caller
 - apply: further split load_preimage()
 - apply: refactor "previous patch" logic
 - apply: split load_preimage() helper function out
 - apply: factor out checkout_target() helper function
 - apply: refactor read_file_or_gitlink()
 - apply: clear_image() clears things a bit more
 - apply: a bit more comments on PATH_TO_BE_DELETED
 - apply: fix an incomplete comment in check_patch()

"git apply" learns to wiggle the base version and perform three-way merge
when a patch does not exactly apply to the version you have.

Waiting for comments.

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

* vr/use-our-perl-in-tests (2012-06-24) 5 commits
 - test-lib: reorder and include GIT-BUILD-OPTIONS a lot earlier
 - t/README: add a bit more Don'ts
 - tests: enclose $PERL_PATH in double quotes
 - t/test-lib.sh: export PERL_PATH for use in scripts
 - t: Replace 'perl' by $PERL_PATH

The tip one is iffy and needs to be carefully proof-read by folks
who have worked on adding various features to the test suite, e.g. 
valgrind, testing in an out of tree trash area, running under prove,
etc.

* jc/sha1-name-more (2012-06-23) 9 commits
 - sha1_name.c: get_describe_name() by definition groks only commits
 - sha1_name.c: teach get_short_sha1() a commit-only option
 - sha1_name.c: allow get_short_sha1() to take other flags
 - sha1_name.c: restructure disambiguation of short names
 - sha1_name.c: correct misnamed "canonical" and "res"
 - sha1_name.c: refactor find_short_packed_object()
 - sha1_name.c: rename "now" to "current"
 - sha1_name.c: clarify what "fake" is for in find_short_object_filename()
 - sha1_name.c: indentation fix

Teaches the object name parser that a "git describe" output is
always a commit object, to prolong the lifetime of abbreviated
object name in it.

It has a handful of failing tests that show directions for a couple
of enhancement ideas.

* jk/version-string-dependency (2012-06-20) 11 commits
 - Makefile: move GIT-VERSION-FILE dependencies closer to use
 - Makefile: build instaweb similar to other scripts
 - Makefile: update scripts when build-time parameters change
 - Makefile: do not replace @@GIT_VERSION@@ in shell scripts
 - Makefile: split prefix flags from GIT-CFLAGS
 - Makefile: split GIT_USER_AGENT from GIT-CFLAGS
 - Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
 - Makefile: apply dependencies consistently to sparse/asm targets
 - Makefile: do not have git.o depend on common-cmds.h
 - Makefile: fold MISC_H into LIB_H
 - Makefile: sort LIB_H list

Will keep in 'pu' to give Peff and Jonathan to work out improvements
for a week or so.

* jn/perl-makemaker-leading-paths (2012-06-15) 1 commit
 - perl/Makefile: move "mkdir -p" to module installation loop for maintainability

Will merge to 'next' after waiting for a few more days.

* mm/verify-filename-fix (2012-06-18) 2 commits
  (merged to 'next' on 2012-06-21 at d03dace)
 + verify_filename(): ask the caller to chose the kind of diagnosis
 + sha1_name: do not trigger detailed diagnosis for file arguments

"git diff COPYING HEAD:COPYING" gave a nonsense error message that
claimed that the treeish HEAD did not have COPYING in it.

Will merge to 'master'.

* tr/maint-show-walk (2012-06-19) 2 commits
 - show: fix "range implies walking"
 - Demonstrate git-show is broken with ranges

Fixes "git show"'s auto-walking behaviour, and make it behave just
like "git log" does when it walks.

Note that this is different from Thomas's patch.

Waiting for response from original author.

* fc/git-prompt-script (2012-06-19) 7 commits
  (merged to 'next' on 2012-06-25 at e690a02)
 + completion: respect $GIT_DIR
 + completion: warn people about duplicated function
 + completion: split __git_ps1 into a separate script
 + completion: remove executable mode
 + Merge branch 'fc/git-complete-helper' into fc/git-prompt-script
 + tests: add tests for the bash prompt functions in the completion script
 + tests: move code to run tests under bash into a helper library

Split a rather heavy-ish "git completion" script out to create a
separate "git prompting" script, to help lazy-autoloading of the
completion part while making prompting part always available.

* jk/diff-no-index-pager (2012-06-15) 2 commits
  (merged to 'next' on 2012-06-21 at e2a2562)
 + do not run pager with diff --no-index --quiet
 + fix pager.diff with diff --no-index

"git diff --no-index" did not work with pagers correctly.

Will merge to 'master'.

* hv/remote-end-hung-up (2012-06-19) 1 commit
  (merged to 'next' on 2012-06-25 at d3f29e2)
 + remove the impression of unexpectedness when access is denied

When we get disconnected while expecting a response from the remote
side because authentication failed, we issued an error message "The
remote side hung up unexpectedly."  Give hint that it may be a
permission problem in the message when we can reasonably suspect it.

* hv/submodule-update-nuke-submodules (2012-06-11) 1 commit
  (merged to 'next' on 2012-06-25 at bbfcd02)
 + update-index: allow overwriting existing submodule index entries

"git add" allows adding a regular file to the path where a submodule
used to exist, but "git update-index" does not allow an equivalent
operation to Porcelain writers.

* jc/rev-list-simplify-merges-first-parent (2012-06-13) 3 commits
  (merged to 'next' on 2012-06-25 at 4c5ffbe)
 + revision: ignore side parents while running simplify-merges
 + revision: note the lack of free() in simplify_merges()
 + revision: "simplify" options imply topo-order sort

When "--simplify-merges/by-decoration" is given together with
"--first-parent" to "git log", the combination of these options
makes the simplification logic to use in-core commit objects that
haven't been examined for relevance, either producing incorrect
result or taking too long to produce any output.  Teach the
simplification logic to ignore commits that the first-parent
traversal logic ignored when both are in effect to work around the
issue.

* nd/exclude-workaround-top-heavy (2012-06-07) 3 commits
  (merged to 'next' on 2012-06-25 at 08429bb)
 + exclude: do strcmp as much as possible before fnmatch
 + dir.c: get rid of the wildcard symbol set in no_wildcard()
 + Unindent excluded_from_list()

Attempt to optimize matching with an exclude pattern with a deep
directory hierarchy by taking the part that specifies leading path
without wildcard literally.

* lk/more-helpful-status-hints (2012-06-14) 4 commits
  (merged to 'next' on 2012-06-25 at 6502d4b)
 + status: better advices when splitting a commit (during rebase -i)
 + status: don't suggest "git rm" or "git add" if not appropriate
 + t7512-status-help.sh: better advices for git status
 + wt-status.*: better advices for git status added

Give finer classification to various states of paths in conflicted
state and offer advice messages in the "git status" output.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* lk/rebase-i-x (2012-06-13) 1 commit
  (merged to 'next' on 2012-06-25 at 8252da2)
 + rebase -i: teach "--exec <cmd>"

Teach "-x <cmd>" to "rebase -i" to insert "exec <cmd>" after each
commit in the resulting history.

* nd/stream-pack-objects (2012-05-29) 1 commit
  (merged to 'next' on 2012-06-25 at fa91345)
 + pack-objects: use streaming interface for reading large loose blobs

"pack-objects" learned to read large loose blobs using the streaming API,
without the need to hold everything in core at once.

* nd/stream-index-pack (2012-05-24) 4 commits
  (merged to 'next' on 2012-06-25 at 3084674)
 + index-pack: use streaming interface for collision test on large blobs
 + index-pack: factor out unpack core from get_data_from_pack
 + index-pack: use streaming interface on large blobs (most of the time)
 + index-pack: hash non-delta objects while reading from stream

Use streaming API to read from the object store to avoid having to hold
a large blob object in-core while running index-pack.

* js/submodule-relative (2012-06-14) 5 commits
  (merged to 'next' on 2012-06-25 at 310ed77)
 + t7400: avoid path mangling issues
 + submodule: fix handling of superproject origin URLs like foo, ./foo and ./foo/bar
 + submodule: fix sync handling of some relative superproject origin URLs
 + submodule: document failure to handle relative superproject origin URLs
 + submodule: additional regression tests for relative URLs

Teach "git submodule" deal with nested submodule structure where a
module is contained within a module whose origin is specified as a
relative URL to its superproject's origin.

* mm/push-default-switch-warning (2012-06-24) 1 commit
 - push: start warning upcoming default change for push.default

Will merge to 'next'.

Hopwefully we can have a solidly tested series early in 1.7.12 or
1.7.13 at the latest.

--------------------------------------------------
[Discarded]

* jc/run-hook-env-1 (2012-03-11) 1 commit
 . run_hook(): enhance the interface to pass arbitrary environment

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks.

* sg/bash-prompt (2012-05-09) 4 commits
 . completion: respect $GIT_DIR
 . completion: use __gitdir() in _git_log()
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library
 (this branch is tangled with fc/git-prompt-script.)

This is only the "correction" bits taken from the beginning of a
larger series that is to be rerolled.  The tip commit has been
cherry-picked to fc/fc/git-prompt-script topic.
