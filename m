From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2012, #05; Sun, 20)
Date: Sun, 20 May 2012 22:23:05 -0700
Message-ID: <7vipfq85vq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 07:23:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWL5S-0001JV-VM
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 07:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab2EUFXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 01:23:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab2EUFXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 01:23:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 320369B72;
	Mon, 21 May 2012 01:23:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	GfdfCiJ1hZKQAGCpH35apewrAg=; b=WLoDHdHR7rUx7nO3RWoP0c1dPE6SvQpOy
	d2OmYY69cSI8UD3MuCEnVAgr67M0nOq5aVExyy0ZMYsqJxIgbKpcGJrzvWbB6p7p
	1GaKp+PO/JqtanMIZOPhHxWYKQrUEp8r9pJiJIcdurhYBa0RQutYZBYSjQRtSSFt
	oQBcvETI3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=q+a
	ojIRI7JlJNgPnmF4H9dvxyOOEwdNTJvDsXwBGnF6XwpJOiIMcsjb/Asdg8trXYvK
	KZfC4K+BcppsIF14pHvC/3dPjrI02sO0pCxBCJAaJNfWnww8bC1XAZVVC1Wt3iZb
	hegzTZGsY91nUa2EBmGfYUZw4aiyQ9vKkTmgGcL4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 280249B71;
	Mon, 21 May 2012 01:23:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 470F49B6F; Mon, 21 May 2012
 01:23:07 -0400 (EDT)
X-master-at: aa3bb87176d42f1782c5030fa41e6e62492551c0
X-next-at: 292236e1ac597c1020462c4a16e9603482ac1410
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C385B34-A305-11E1-BB48-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198082>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

I haven't tagged 1.7.11-rc0 as some of the late "fixup" patches still
haven't settled yet, but hopefully we can go directly to rc1 by the end of
the week.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* hv/submodule-alt-odb (2012-05-14) 1 commit
  (merged to 'next' on 2012-05-18 at 2f17ac8)
 + teach add_submodule_odb() to look for alternates

When peeking into object stores of submodules, the code forgot that they
might borrow objects from alternate object stores on their own.

* jk/ident-gecos-strbuf (2012-05-20) 13 commits
 - format-patch: refactor get_patch_filename
 - ident: use a dynamic strbuf in fmt_ident
 - ident: use full dns names to generate email addresses
 - ident: report passwd errors with a more friendly message
 - drop length limitations on gecos-derived names and emails
 - ident: don't write fallback username into git_default_name
 - fmt_ident: drop IDENT_WARN_ON_NO_NAME code
 - format-patch: use default email for generating message ids
 - fmt-merge-msg: don't use static buffer in record_person
 - move git_default_* variables to ident.c
 - move identity config parsing to ident.c
 - http-push: do not access git_default_email directly
 - ident: split setup_ident into separate functions

Fixes quite a lot of brokenness when ident information needs to be taken
from the system and cleans up the code.  The series seem to break tests
here and there along the way but at the end everything balances out ;-)

* bp/diff-no-index-strbuf-fix (2012-05-16) 2 commits
  (merged to 'next' on 2012-05-18 at b2c26bb)
 + diff --no-index: don't leak buffers in queue_diff
 + diff --no-index: reset temporary buffer lengths on directory iteration

* js/rebase-i-p-test-fix (2012-05-18) 1 commit
  (merged to 'next' on 2012-05-18 at b7482fc)
 + Fix t3411.3 to actually rebase something

* js/rev-parse-doc-fix (2012-05-18) 1 commit
  (merged to 'next' on 2012-05-18 at c16f1c7)
 + rev-parse doc: --git-dir does not always show a relative path

* js/submodule-relative (2012-05-20) 2 commits
 - submodule: fix handling of superproject with relative origin URLs
 - submodule: add tests for add,sync,init in presence of relative super origin URL

* mh/ref-api-lazy-loose (2012-05-20) 1 commit
 - free_ref_entry(): do not trigger reading of loose refs

* mh/test-keep-prove-cache (2012-05-20) 1 commit
 - t/Makefile: retain cache t/.prove across prove runs

* ng/pack-objects-cleanup (2012-05-18) 2 commits
 - pack-objects: refactor write_object() into helper functions
 - pack-objects, streaming: turn "xx >= big_file_threshold" to ".. > .."

* rs/archive-tree-in-tip-simplify (2012-05-18) 2 commits
  (merged to 'next' on 2012-05-18 at a8ca614)
 + archive-tar: keep const in checksum calculation
 + archive: simplify refname handling

* rs/maint-grep-F (2012-05-20) 3 commits
 - grep: support newline separated pattern list
 - grep: factor out do_append_grep_pat()
 - grep: factor out create_grep_pat()

* rs/xdiff-fast-hash-fix (2012-05-18) 1 commit
 - xdiff: signed right shift for 32-bit case of XDL_FAST_HASH

* sp/sh-windows-pwd (2012-05-16) 1 commit
 - git-sh-setup: define workaround wrappers before they are used

* fc/git-complete-helper-fix (2012-05-20) 2 commits
 - completion: add support for backwards compatibility
 - completion: rename internal helpers _git and _gitk

* jc/wip-apply-3way (2012-05-14) 9 commits
 . WIP: apply --3way with add/add conflicts
 . apply: refactor codepath to check new files
 - apply: register conflicted stages to the index
 - apply: plug the three-way merge logic in
 - apply: fall back on three-way merge
 - apply: accept -3/--3way command line option
 - apply: split load_preimage() helper function out
 - apply: refactor read_file_or_gitlink()
 - apply: clear_image() clears things a bit more
 (this branch is tangled with jc/apply-3way.)

--------------------------------------------------
[Graduated to "master"]

* fc/git-complete-helper (2012-05-20) 2 commits
 - completion: add support for backwards compatibility
 - completion: rename internal helpers _git and _gitk
* fc/git-complete-helper (2012-05-14) 1 commit
  (merged to 'next' on 2012-05-14 at 759d5f4)
 + completion: add new __git_complete helper

There is a late fix-up that still need to be merged for backward
compatibility for external users of the unpublished internal API.

* fc/simplify-complete-revlist-file (2012-05-07) 1 commit
  (merged to 'next' on 2012-05-08 at ff0b7d1)
 + completion: simplify __git_complete_revlist_file

* ld/git-p4-tags-and-labels (2012-05-11) 3 commits
  (merged to 'next' on 2012-05-11 at 441bd9a)
 + git p4: fix bug when enabling tag import/export via config variables
 + git p4: fix bug when verbose enabled with tag export
 + git p4: add test for tag import/export enabled via config

* nd/i18n-parseopt (2012-05-08) 2 commits
  (merged to 'next' on 2012-05-08 at 15eb029)
 + i18n: apply: mark parseopt strings for translation
 + i18n: parseopt: lookup help and argument translations when showing usage

Text from "git cmd --help" are getting prepared for i18n.

* nd/threaded-index-pack (2012-05-07) 4 commits
  (merged to 'next' on 2012-05-08 at 053b797)
 + index-pack: disable threading if NO_PREAD is defined
 + index-pack: support multithreaded delta resolving
 + index-pack: restructure pack processing into three main functions
 + compat/win32/pthread.h: Add an pthread_key_delete() implementation

Enables threading in index-pack to resolve base data in parallel.

* rs/xdiff-lose-emit-func (2012-05-14) 7 commits
  (merged to 'next' on 2012-05-14 at 422f328)
 + builtin/blame.c: Fix a "Using plain integer as NULL pointer" warning
  (merged to 'next' on 2012-05-11 at 1eeb893)
 + xdiff: remove unused functions
 + xdiff: remove emit_func() and xdi_diff_hunks()
 + blame: factor out helper for calling xdi_diff()
 + blame: use hunk_func(), part 2
 + blame: use hunk_func(), part 1
 + xdiff: add hunk_func()

Simplifies the interface between the implementation of "blame" and
underlying xdiff engine, and removes a lot of unused or unnecessary code
from the latter.

--------------------------------------------------
[Stalled]

* sg/bash-prompt (2012-05-09) 4 commits
 - completion: respect $GIT_DIR
 - completion: use __gitdir() in _git_log()
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library

This is only the "correction" bits taken from the beginning of a larger
series that is to be rerolled.

* jc/apply-3way (2012-05-16) 12 commits
 - WIP: the message is bogus in apply:::check_patch()
 - apply: refactor "previous patch" logic
 - apply: a bit more comments on PATH_TO_BE_DELETED
 - apply: document --3way option
 - apply: allow rerere() upon --3way results
 - apply: register conflicted stages to the index
 - apply: plug the three-way merge logic in
 - apply: fall back on three-way merge
 - apply: accept -3/--3way command line option
 - apply: split load_preimage() helper function out
 - apply: refactor read_file_or_gitlink()
 - apply: clear_image() clears things a bit more
 (this branch is tangled with jc/wip-apply-3way.)

"git apply" learns to wiggle the base version and perform three-way merge
when a patch does not exactly apply to the version you have.

It turns out that it is somewhat unpleasant to handle add/add conflicts in
this code, but it seems necessary if we want to use "apply -3" to replace
the use of "apply --build-fake-ancestor" followed by the slow "merge" in
"am -3".

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
Not ready.
There still seem to be other bugs hiding (e.g. try pushing twice).

* jc/run-hook-env-1 (2012-03-11) 1 commit
 - run_hook(): enhance the interface to pass arbitrary environment

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks.

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

* rs/dir-strbuf-read-recursive-fix (2012-05-11) 2 commits
 - dir: simplify fill_directory()
 - dir: respect string length argument of read_directory_recursive()

* nl/http-proxy-more (2012-05-11) 2 commits
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice

I queued only the later two patches from this series, even though they do
not make much sense without the first one that seems to need a bit more
work, so that we won't forget.

* mm/push-default-switch-warning (2012-04-26) 2 commits
 - t5541: warning message is given even with --quiet
 - push: start warning upcoming default change for push.default

Will squash the two, but this has to wait for a few release cycles.

--------------------------------------------------
[Discarded]

* cb/daemon-test-race-fix (2012-04-27) 2 commits
  (merged to 'next' on 2012-04-27 at 84bbcf8)
 + Revert "git-daemon wrapper to wait until daemon is ready"
  (merged to 'next' on 2012-04-24 at d5c30be)
 + git-daemon wrapper to wait until daemon is ready

Reverted from 'next' to replace it with js/daemon-test-race-fix.
