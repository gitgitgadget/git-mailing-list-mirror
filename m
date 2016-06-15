From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2012, #06; Thu, 21)
Date: Thu, 21 Jun 2012 15:53:14 -0700
Message-ID: <7vk3z0qntx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 00:53:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShqFi-0003iu-B7
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 00:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760486Ab2FUWxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 18:53:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760471Ab2FUWxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 18:53:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06BE89B32;
	Thu, 21 Jun 2012 18:53:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	VYLZ6EwJbvEnw+x2yzAbe9AggY=; b=e+K8mR5hgHpJadlmxAiTJX0spRyU67xye
	GlTe2u6tPnD+XRB+3byWistFEvnZlqzR/UiDPFapQ+wxdiOEhrq4VZJSFf5wBa2/
	E5S4EULZjjf16O0y7kHFZt0OWAJUt/gqR3Run31mn82PfvwTZzZhureEmIgz55S3
	uxzzNfhTjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ty4
	XOu1dny/dXrI60631zjmNLj43MzFCHgtEnWQZ9rlUzvD0dv4FN6UujC8EejFTgXB
	tBH7FrbWn09+nb/Xyt9gUzdBt6CXHtLctGPFxvKy1Ka1LtiyzvY1n+ChFpR0Wlwi
	zIxDQPXefsrOmntOP70umrFP10B8KrQ0dOgS/PWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F122E9B31;
	Thu, 21 Jun 2012 18:53:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEE8C9B30; Thu, 21 Jun 2012
 18:53:15 -0400 (EDT)
X-master-at: 0e18bef7e62d6fffd09c394381056ec7a4a79840
X-next-at: d03daced714572d0060e2bd8ae5e751b5a245f46
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3216058-BBF3-11E1-BB57-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200418>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

A brown-paper bag release 1.7.11.1 is out.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jc/bundle-complete-notice (2012-06-04) 1 commit
  (merged to 'next' on 2012-06-19 at b42227b)
 + tweak "bundle verify" of a complete history

Originally merged to 'next' on 2012-06-04.

Running "git bundle verify" on a bundle that records a complete
history said "it requires these 0 commits".

* jc/ls-files-i-dir (2012-06-05) 6 commits
  (merged to 'next' on 2012-06-19 at 4a7aa99)
 + dir.c: make excluded() file scope static
 + unpack-trees.c: use path_excluded() in check_ok_to_remove()
 + builtin/add.c: use path_excluded()
 + path_excluded(): update API to less cache-entry centric
 + ls-files -i: micro-optimize path_excluded()
 + ls-files -i: pay attention to exclusion of leading paths

Originally merged to 'next' on 2012-06-08.

"git ls-files --exclude=t -i" did not consider anything under t/
as excluded, as it did not pay attention to exclusion of leading
paths while walking the index.  Other two users of excluded() are
also updated.

* jc/request-pull-match-tagname (2012-06-01) 1 commit
  (merged to 'next' on 2012-06-19 at bb96d6c)
 + request-pull: really favor a matching tag

Originally merged to 'next' on 2012-06-05.

"git request-pull $url dev" when the tip of "dev" branch was tagged
with "ext4-for-linus" used the contents from the tag in the output
but still asked the "dev" branch to be pulled, not the tag.

* jk/clone-local (2012-05-30) 2 commits
  (merged to 'next' on 2012-06-19 at a42bbcc)
 + clone: allow --no-local to turn off local optimizations
 + docs/clone: mention that --local may be ignored

Originally merged to 'next' on 2012-06-05.

"git clone --local $path" started its life as an experiment to
optionally use link/copy when cloning a repository on the disk, but
we didn't deprecate it after we made the option a no-op to always
use the optimization.

The command learns "--no-local" option to turn this off, as a more
explicit alternative over use of file:// URL.

* jk/maint-t1304-setfacl (2012-06-07) 1 commit
  (merged to 'next' on 2012-06-19 at 2449521)
 + t1304: improve setfacl prerequisite setup

Originally merged to 'next' on 2012-06-08.

Works around a false test failure caused by a bug in ecryptofs.

* jk/version-string (2012-06-03) 3 commits
  (merged to 'next' on 2012-06-19 at 12f8e07)
 + http: get default user-agent from git_user_agent
 + version: add git_user_agent function
 + move git_version_string into version.c
 (this branch is used by jk/version-string-dependency.)

Originally merged to 'next' on 2012-06-05.

Teaches git native protocol agents to show software version over the
wire.

* vr/help-per-platform (2012-06-06) 1 commit
  (merged to 'next' on 2012-06-19 at d9a08ba)
 + help: use HTML as the default help format on Windows

Originally merged to 'next' on 2012-06-08

We used to always default to "man" format even on platforms where
"man" viewer is not widely available.

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

* vr/use-our-perl-in-tests (2012-06-12) 3 commits
 - t/README: add a bit more Don'ts
 - tests: enclose $PERL_PATH in duoble quotes
 - t: Replace 'perl' by $PERL_PATH

Needs more work.

There are still unconverted use of bare 'perl' remaining in the test
scripts, the second patch needs its title typofixed, and PERL_PATH
needs to be exported to the environment from test-lib.sh.

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

* sg/bash-prompt (2012-05-09) 4 commits
 . completion: respect $GIT_DIR
 . completion: use __gitdir() in _git_log()
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library
 (this branch is tangled with fc/git-prompt-script.)

This is only the "correction" bits taken from the beginning of a
larger series that is to be rerolled.  The tip commit has been
cherry-picked to fc/fc/git-prompt-script topic.

Will discard without prejudice.

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
There still seem to be other bugs hiding (e.g. try pushing twice).

Not ready.

* jc/run-hook-env-1 (2012-03-11) 1 commit
 . run_hook(): enhance the interface to pass arbitrary environment

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks.

Will discard.

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

* cn/cherry-pick-range-docs (2012-06-15) 2 commits
  (merged to 'next' on 2012-06-21 at 5cf7f97)
 + git-cherry-pick.txt: clarify the use of revision range notation
 + Documentation: --no-walk is no-op if range is specified

The command line argument of "git cherry-pick maint master..next" is
just an ordinary revision range, which is unintuitive and at least
deserves documentation.

Will merge to 'master'.

* jc/sha1-name-more (2012-06-21) 9 commits
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

Will hold in 'pu' to give Peff and Jonathan to work out improvements
for a week or so.

* jn/perl-makemaker-leading-paths (2012-06-15) 1 commit
 - perl/Makefile: move "mkdir -p" to module installation loop for maintainability

Will wait for a few days to see if somebody comes up with a more
concise and cleaner way to do this, but otherwise this looked good.

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

* fc/git-prompt-script (2012-06-19) 7 commits
 - completion: respect $GIT_DIR
 - completion: warn people about duplicated function
 - completion: split __git_ps1 into a separate script
 - completion: remove executable mode
 - Merge branch 'fc/git-complete-helper' into fc/git-prompt-script
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library
 (this branch is tangled with sg/bash-prompt.)

Splits a rather heavy-ish "git completion" script out and creates a
separate "git prompting" script, to help lazy-autoloading of the
completion part while making prompting part always available.

Will merge to 'next'.

* lm/git-blame-el (2012-06-14) 3 commits
  (merged to 'next' on 2012-06-21 at 6514487)
 + git-blame.el: Do not use bare 0 to mean (point-min)
 + git-blame.el: Use with-current-buffer where appropriate
 + git-blame.el: Do not use goto-line in lisp code

Will merge to 'master'.

* lp/no-cmd-http-fetch (2012-06-15) 1 commit
  (merged to 'next' on 2012-06-21 at 242a10e)
 + builtin.h: remove unused cmd_<foo> declarations

Will merge to 'master'.

* jk/diff-no-index-pager (2012-06-15) 2 commits
  (merged to 'next' on 2012-06-21 at e2a2562)
 + do not run pager with diff --no-index --quiet
 + fix pager.diff with diff --no-index

"git diff --no-index" did not work with pagers correctly.

Will merge to 'master'.

* nd/i18n-branch-lego (2012-06-07) 1 commit
  (merged to 'next' on 2012-06-21 at 0cb53fc)
 + Remove i18n legos in notifying new branch tracking setup

Restructure the way message strings are created, in preparation for
marking them for i18n.

Will merge to 'master'.

* nd/i18n-misc (2012-06-07) 3 commits
  (merged to 'next' on 2012-06-21 at 0a82040)
 + rerere: remove i18n legos in result message
 + notes-merge: remove i18n legos in merge result message
 + reflog: remove i18n legos in pruning message

Restructure the way message strings are created, in preparation for
marking them for i18n.

Will merge to 'master'.

* rr/doc-commit (2012-06-08) 1 commit
  (merged to 'next' on 2012-06-21 at af8301c)
 + commit: document a couple of options

Will merge to 'master'.

* hv/remote-end-hung-up (2012-06-19) 1 commit
 - remove the impression of unexpectedness when access is denied

Will merge to 'next'.

* hv/submodule-checkout-nuke-submodules (2012-06-11) 1 commit
 - update-index: allow overwriting existing submodule index entries

Will merge to 'next'.

* jc/rev-list-simplify-merges-first-parent (2012-06-13) 3 commits
 - revision: ignore side parents while running simplify-merges
 - revision: note the lack of free() in simplify_merges()
 - revision: "simplify" options imply topo-order sort

I need to send this out to the list for re-review.

* jc/ustar-checksum-is-unsigned (2012-06-13) 1 commit
  (merged to 'next' on 2012-06-21 at bb8e2b0)
 + archive: ustar header checksum is computed unsigned

"git archive" incorrectly computed the header checksum; the symptom
was observed only when using pathnames with hi-bit set.

Will merge to 'master'.

* rs/git-blame-mapcar-mapc (2012-06-10) 1 commit
  (merged to 'next' on 2012-06-21 at 71a3b36)
 + git-blame.el: use mapc instead of mapcar

Will merge to 'master'.

* rs/ipv6-ssh-url (2012-06-13) 1 commit
  (merged to 'next' on 2012-06-21 at d0116a8)
 + git: Wrong parsing of ssh urls with IPv6 literals ignores port

Will merge to 'master'.

ssh:// URLs to IPv6 hosts with custom port number were parsed
incorrectly.

* nd/exclude-workaround-top-heavy (2012-06-07) 3 commits
 - exclude: do strcmp as much as possible before fnmatch
 - dir.c: get rid of the wildcard symbol set in no_wildcard()
 - Unindent excluded_from_list()

Attempts to optimize matching with an exclude pattern with a deep
directory hierarchy by taking the part that specifies leading path
without wildcard literally.

Will merge to 'next'.

* lk/more-helpful-status-hints (2012-06-14) 4 commits
 - status: better advices when splitting a commit (during rebase -i)
 - status: don't suggest "git rm" or "git add" if not appropriate
 - t7512-status-help.sh: better advices for git status
 - wt-status.*: better advices for git status added

Will merge to 'next'.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

On hold for 6 months until ancient "less" goes extinct.

* lk/rebase-i-x (2012-06-13) 1 commit
 - rebase -i: teach "--exec <cmd>"

Adds -x <cmd> to "rebase -i" to insert "exec <cmd>" after each
commit in the resulting history.

Will merge to 'next'.

* nd/stream-pack-objects (2012-05-29) 1 commit
 - pack-objects: use streaming interface for reading large loose blobs

Will merge to 'next'.

* jk/no-more-asciidoc7 (2012-05-30) 2 commits
  (merged to 'next' on 2012-06-19 at a36b498)
 + docs: drop antique comment from Makefile
 + docs: drop asciidoc7compatible flag

Originally merged to 'next' on 2012-06-05.

We no longer use AsciiDoc7 syntax in our documentation and favor a
more modern style.

Will merge to 'master'.

* nd/stream-index-pack (2012-05-24) 4 commits
 - index-pack: use streaming interface for collision test on large blobs
 - index-pack: factor out unpack core from get_data_from_pack
 - index-pack: use streaming interface on large blobs (most of the time)
 - index-pack: hash non-delta objects while reading from stream

Use streaming API to read from the object store to avoid having to hold
a large blob object in-core while running index-pack.

Will merge to 'next'.

* js/submodule-relative (2012-06-14) 5 commits
 - t7400: avoid path mangling issues
 - submodule: fix handling of superproject origin URLs like foo, ./foo and ./foo/bar
 - submodule: fix sync handling of some relative superproject origin URLs
 - submodule: document failure to handle relative superproject origin URLs
 - submodule: additional regression tests for relative URLs

Makes "git submodule" deal with nested submodule structure where a
module is contained within a module whose origin is specified as a
relative URL to its superproject's origin.

Will merge to 'next'.

* mm/push-default-switch-warning (2012-06-20) 1 commit
 - push: start warning upcoming default change for push.default

Will merge to 'next'.

Hopwefully we can have a solidly tested series early in 1.7.12 or
1.7.13 at the latest.

--------------------------------------------------
[Discarded]

* cb/daemon-test-race-fix (2012-04-27) 2 commits
  (merged to 'next' on 2012-04-27 at 84bbcf8)
 + Revert "git-daemon wrapper to wait until daemon is ready"
  (merged to 'next' on 2012-04-24 at d5c30be)
 + git-daemon wrapper to wait until daemon is ready

Reverted from 'next' to replace it with js/daemon-test-race-fix.

* jc/merge-annotated-tag (2012-06-05) 2 commits
 . merge: allow fast-forwarding to an annotated but unsigned tag
 . merge: separte the logic to check for a signed tag

"git merge anno" created a merge commit even when anno is an
unsigned annotated tag that points at a commit that can be fast
forwarded to; this came from a laziness of the implementation of
merging of signed tags in 1.7.9.  People may have different opinion
on making signed and unsigned annotated tag behave differently, but
I tend to agree that it is probably not a good idea.
