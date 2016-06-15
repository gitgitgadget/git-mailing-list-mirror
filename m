From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2015, #05; Tue, 27)
Date: Tue, 27 Jan 2015 15:35:07 -0800
Message-ID: <xmqqiofriyqc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 00:35:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGFfS-0005Qu-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 00:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759068AbbA0XfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 18:35:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754454AbbA0XfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 18:35:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75D19320F9;
	Tue, 27 Jan 2015 18:35:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	G6RHLFo6/InHrR/JXodfs0TY1M=; b=T/rJO9oj5vP102E6OuwYqnNbVUHrjl+CI
	XrlFZFRm5AvJX/fk62FF63GEj/d3tsCEiCGywBN2YgzBcCiInjYwPXZakGa2TyUU
	45B4KAGI1mtXCrYeywusTeKAfWxmzXbKJ6dm32BmK/3voSMmt5p8E/yCmAtJwC3K
	kHcJ5SzV3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=keC
	4ZgvZW/YlObx1sfs35WFl/L6d/5DVJuljgAcYuloHyGo15nbsUAWvkC2I62SUIv+
	BLmQ5AG9ngINBpWWx0cV/xQBmFjmJz13ctnzRrxFyWANKpNO0j4ltwXJYrEBjcOQ
	iYi1a/QMFNdCAcM+xrV9xVZC+Hfco5d2+eDlLsEo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5862F320F5;
	Tue, 27 Jan 2015 18:35:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56B6A320F4;
	Tue, 27 Jan 2015 18:35:08 -0500 (EST)
X-master-at: 15598cf41beed0d86cd2ac443e0f69c5a3b40321
X-next-at: 4b64765b7657288d677cec107fb5295afb4e3a29
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 210DD4E8-A67D-11E4-92B1-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263097>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Hopefully final release candidate 2.3-rc2 has been tagged.  Please
spend some time to find and fix regressions, instead of spending all
time having fun with new and shiny toys.  The final hopefully will
happen sometime next week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/cat-file-clean-up (2015-01-13) 1 commit
  (merged to 'next' on 2015-01-15 at bb1a4b3)
 + cat-file: use "type" and "size" from outer scope


* js/t1050 (2015-01-14) 1 commit
  (merged to 'next' on 2015-01-15 at f010b00)
 + t1050-large: generate large files without dd

--------------------------------------------------
[New Topics]

* jc/apply-ws-fix-expands-report (2015-01-22) 1 commit
 - apply: detect and mark whitespace errors in context lines when fixing
 (this branch uses jc/apply-ws-fix-expands.)

 "git apply --whitespace=fix" fixed whitespace errors in the common
 context lines but did so without reporting.

 Will merge to 'next'.


* ks/rebase-i-abbrev (2015-01-22) 1 commit
 - rebase -i: use full object name internally throughout the script

 The insn sheet "git rebase -i" creates did not fully honor
 core.abbrev settings.

 Will merge to 'next'.


* mh/deref-symref-over-helper-transport (2015-01-21) 1 commit
 - transport-helper: do not request symbolic refs to remote helpers

 "git fetch" over a remote-helper that cannot respond to "list"
 command could not fetch from a symbolic reference e.g. HEAD.

 Will merge to 'next'.


* ak/add-i-empty-candidates (2015-01-22) 1 commit
 - add -i: return from list_and_choose if there is no candidate

 The interactive "show a list and let the user choose from it"
 interface "add -i" used showed and prompted to the user even when
 the candidate list was empty, against which the only "choice" the
 user could have made was to choose nothing.

 Will merge to 'next'.


* av/wincred-with-at-in-username-fix (2015-01-25) 1 commit
 - wincred: fix get credential if username has "@"

 Will merge to 'next'.


* jc/conf-var-doc (2015-01-27) 3 commits
 - CodingGuidelines: describe naming rules for configuration variables
 - config.txt: mark deprecated variables more prominently
 - config.txt: clarify that add.ignore-errors as deprecated

 Need to send this out for review before doing anything to it.


* jc/doc-log-rev-list-options (2015-01-23) 1 commit
 - Documentation: what does "git log --indexed-objects" even mean?

 Will merge to 'next'.


* jk/dumb-http-idx-fetch-fix (2015-01-27) 1 commit
 - dumb-http: do not pass NULL path to parse_pack_index

 Will merge to 'next'.


* ld/p4-submit-hint (2015-01-23) 1 commit
  (merged to 'next' on 2015-01-23 at ed972d3)
 + git-p4: correct --prepare-p4-only instructions

 Will merge to 'master' after 2.3 final.


* mg/commit-author-no-match-malformed-message (2015-01-26) 1 commit
 - commit: reword --author error message

 Will merge to 'next'.


* mg/push-repo-option-doc (2015-01-27) 1 commit
 - git-push.txt: document the behavior of --repo

 Will merge to 'next'.


--------------------------------------------------
[Stalled]

* jn/doc-api-errors (2014-12-04) 1 commit
 - doc: document error handling functions and conventions

 For discussion.


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url

 Expecting a reroll.


* ms/submodule-update-config-doc (2014-11-03) 1 commit
 - submodule: clarify documentation for update subcommand

 Needs a reroll ($gmane/259037).


* je/quiltimport-no-fuzz (2014-10-21) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Tired of waiting for an Ack; will discard.


* tr/remerge-diff (2014-11-10) 9 commits
 - t4213: avoid "|" in sed regexp
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll ($gmane/256591).


* hv/submodule-config (2014-11-11) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* ye/http-accept-language (2015-01-27) 2 commits
 - SQUASH???
 - http: Add Accept-Language header if possible

 Using environment variable LANGUAGE and friends on the client side,
 send Accept-Language when making HTTP requests.

 Almost there, I would think.


* ak/typofixes (2015-01-21) 2 commits
  (merged to 'next' on 2015-01-22 at e36f25a)
 + t/lib-terminal.sh: fix typo
 + pack-bitmap: fix typo

 Will merge to 'master'.


* jc/apply-ws-fix-expands (2015-01-22) 3 commits
 - apply: count the size of postimage correctly
 - apply: make update_pre_post_images() sanity check the given postlen
 - apply.c: typofix
 (this branch is used by jc/apply-ws-fix-expands-report.)

 "git apply --whitespace=fix" used to under-allocate the memory
 when the fix resulted in a longer text than the original patch.

 Will merge to 'next'.


* jc/coding-guidelines (2015-01-15) 1 commit
  (merged to 'next' on 2015-01-22 at 3c96639)
 + CodingGuidelines: clarify C #include rules

 Will merge to 'master'.


* jc/pretty-format-doc (2015-01-15) 1 commit
  (merged to 'next' on 2015-01-22 at 2a81ecc)
 + "log --pretty" documentation: do not forget "tformat:"

 Will cook in 'next'.


* jc/unused-symbols (2015-01-15) 8 commits
  (merged to 'next' on 2015-01-22 at 77fd5f0)
 + shallow.c: make check_shallow_file_for_update() static
 + remote.c: make clear_cas_option() static
 + urlmatch.c: make match_urls() static
 + revision.c: make save_parents() and free_saved_parents() static
 + line-log.c: make line_log_data_init() static
 + pack-bitmap.c: make pack_bitmap_filename() static
 + prompt.c: remove git_getpass() nobody uses
 + http.c: make finish_active_slot() and handle_curl_result() static

 Mark file-local symbols as "static", and drop functions that nobody
 uses.

 Will cook in 'next'.


* jk/sanity (2015-01-27) 3 commits
 - test-lib.sh: set prerequisite SANITY by testing what we really need
 - tests: correct misuses of POSIXPERM
 - t/lib-httpd: switch SANITY check for NOT_ROOT

 Waiting for ack or counter-proposal from Torsten.
 Otherwise looking good.


* js/fsck-opt (2015-01-21) 19 commits
 - fsck: support ignoring objects in `git fsck` via fsck.skiplist
 - fsck: git receive-pack: support excluding objects from fsck'ing
 - fsck: introduce `git fsck --quick`
 - fsck: support demoting errors to warnings
 - fsck: document the new receive.fsck.* options
 - fsck: allow upgrading fsck warnings to errors
 - fsck: optionally ignore specific fsck issues completely
 - fsck: disallow demoting grave fsck errors to warnings
 - fsck: add a simple test for receive.fsck.*
 - fsck: make fsck_tag() warn-friendly
 - fsck: handle multiple authors in commits specially
 - fsck: make fsck_commit() warn-friendly
 - fsck: make fsck_ident() warn-friendly
 - fsck: report the ID of the error/warning
 - fsck: allow demoting errors to warnings via receive.fsck.warn = <key>
 - fsck: offer a function to demote fsck errors to warnings
 - fsck: provide a function to parse fsck message IDs
 - fsck: introduce identifiers for fsck messages
 - fsck: introduce fsck options

 Need extra set of eyes to review this.


* ld/p4-exclude-in-sync (2015-01-20) 1 commit
  (merged to 'next' on 2015-01-22 at f6f1fc7)
 + git-p4: support excluding paths on sync

 Will merge to 'master' after 2.3 final.


* tb/connect-ipv6-parse-fix (2015-01-22) 3 commits
 - t5500: show user name and host in diag-url
 - t5601: add more test cases for IPV6
 - connect.c: improve parsing of literal IPV6 addresses

 Need extra set of eyes to review this.


* sb/atomic-push-fix (2015-01-23) 6 commits
 - refs.c: enable large transactions
 - refs.c: remove unlock_ref and commit_ref from write_ref_sha1
 - refs.c: move static functions to close and commit refs
 - refs.c: remove lock_fd from struct ref_lock
 - t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
 - update-ref: test handling large transactions properly
 (this branch uses mh/reflog-expire and sb/atomic-push.)

 I had to wiggle this in and am not confident I did it correctly.

 Need extra set of eyes to review this.


* jk/strbuf-doc-to-header (2015-01-16) 7 commits
 - strbuf.h: group documentation for trim functions
 - strbuf.h: drop boilerplate descriptions of strbuf_split_*
 - strbuf.h: reorganize api function grouping headers
 - strbuf.h: format asciidoc code blocks as 4-space indent
 - strbuf.h: drop asciidoc list formatting from API docs
 - strbuf.h: unify documentation comments beginnings
 - strbuf.h: integrate api-strbuf.txt documentation

 Resolve the "doc vs header" to favor the latter.


* ah/usage-strings (2015-01-14) 1 commit
  (merged to 'next' on 2015-01-22 at bfa5bab)
 + standardize usage info string format

 Will cook in 'next'.


* ak/stash-store-create-help (2015-01-13) 1 commit
 - stash: show "create" and "store" subcommands in usage-help

 Undecided.


* jk/blame-commit-label (2015-01-13) 5 commits
  (merged to 'next' on 2015-01-15 at 1b32e21)
 + blame.c: fix garbled error message
 + use xstrdup_or_null to replace ternary conditionals
 + builtin/commit.c: use xstrdup_or_null instead of envdup
 + builtin/apply.c: use xstrdup_or_null instead of null_strdup
 + git-compat-util: add xstrdup_or_null helper

 Will cook in 'next'.


* bc/http-fallback-to-password-after-krb-fails (2015-01-07) 1 commit
  (merged to 'next' on 2015-01-12 at 4c67038)
 + remote-curl: fall back to Basic auth if Negotiate fails

 After attempting and failing a password-less authentication
 (e.g. kerberos), libcURL refuses to fall back to password based
 Basic authentication without a bit of help/encouragement.

 Will cook in 'next'.


* bp/diff-relative-config (2015-01-07) 2 commits
 - diff: teach diff.relative to give default to --relative=<value>
 - diff: teach --no-relative to override earlier --relative


* dk/format-patch-ignore-diff-submodule (2015-01-07) 2 commits
  (merged to 'next' on 2015-01-12 at 6b4605b)
 + format-patch: ignore diff.submodule setting
 + t4255: test am submodule with diff.submodule

 Setting diff.submodule to 'log' made "git format-patch" produce
 broken patches.

 Will cook in 'next'.


* nd/attr-optim (2014-12-29) 3 commits
 - attr: avoid heavy work when we know the specified attr is not defined
 - attr: do not attempt to expand when we know it's not a macro
 - attr.c: rename arg name attr_nr to avoid shadowing the global one


* cj/log-invert-grep (2015-01-13) 1 commit
  (merged to 'next' on 2015-01-13 at c908e99)
 + log: teach --invert-grep option

 Will cook in 'next'.


* km/gettext-n (2015-01-12) 1 commit
  (merged to 'next' on 2015-01-12 at 0cbbf4a)
 + gettext.h: add parentheses around N_ expansion if supported

 Will cook in 'next'.


* jn/rerere-fail-on-auto-update-failure (2015-01-08) 1 commit
  (merged to 'next' on 2015-01-12 at 313c449)
 + rerere: error out on autoupdate failure

 "git rerere" (invoked internally from many mergy operations) did
 not correctly signal errors when told to update the working tree
 files and failed to do so for whatever reason.

 Will cook in 'next'.


* sb/atomic-push (2015-01-14) 11 commits
  (merged to 'next' on 2015-01-14 at 12c4e28)
 + Document receive.advertiseatomic
  (merged to 'next' on 2015-01-12 at 411c6a6)
 + t5543-atomic-push.sh: add basic tests for atomic pushes
 + push.c: add an --atomic argument
 + send-pack.c: add --atomic command line argument
 + send-pack: rename ref_update_to_be_sent to check_to_send_update
 + receive-pack.c: negotiate atomic push support
 + receive-pack.c: add execute_commands_atomic function
 + receive-pack.c: move transaction handling in a central place
 + receive-pack.c: move iterating over all commands outside execute_commands
 + receive-pack.c: die instead of error in case of possible future bug
 + receive-pack.c: shorten the execute_commands loop over all commands
 (this branch is used by sb/atomic-push-fix; uses mh/reflog-expire.)

 "git push" has been taught a "--atomic" option that makes push to
 update more than one ref an "all-or-none" affair.

 Will cook in 'next'.


* mh/reflog-expire (2014-12-22) 24 commits
  (merged to 'next' on 2015-01-12 at 12a7dff)
 + refs.c: let fprintf handle the formatting
 + refs.c: don't expose the internal struct ref_lock in the header file
 + lock_any_ref_for_update(): inline function
 + refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
 + reflog_expire(): new function in the reference API
 + expire_reflog(): treat the policy callback data as opaque
 + Move newlog and last_kept_sha1 to "struct expire_reflog_cb"
 + expire_reflog(): move rewrite to flags argument
 + expire_reflog(): move verbose to flags argument
 + expire_reflog(): pass flags through to expire_reflog_ent()
 + struct expire_reflog_cb: a new callback data type
 + Rename expire_reflog_cb to expire_reflog_policy_cb
 + expire_reflog(): move updateref to flags argument
 + expire_reflog(): move dry_run to flags argument
 + expire_reflog(): add a "flags" argument
 + expire_reflog(): extract two policy-related functions
 + Extract function should_expire_reflog_ent()
 + expire_reflog(): use a lock_file for rewriting the reflog file
 + expire_reflog(): return early if the reference has no reflog
 + expire_reflog(): rename "ref" parameter to "refname"
 + expire_reflog(): it's not an each_ref_fn anymore
 + refs.c: add a function to append a reflog entry to a fd
 + refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 + refs.c: make ref_transaction_create a wrapper for ref_transaction_update
 (this branch is used by sb/atomic-push and sb/atomic-push-fix.)

 Restructure "reflog expire" to fit the reflogs better with the
 recently updated ref API.

 Looked reasonable (except that some shortlog entries stood out like
 a sore thumb).

 Will cook in 'next'.


* jc/push-to-checkout (2015-01-08) 2 commits
  (merged to 'next' on 2015-01-12 at e64df63)
 + receive-pack: support push-to-checkout hook
 + receive-pack: refactor updateInstead codepath

 Extending the js/push-to-deploy topic, the behaviour of "git push"
 when updating the working tree and the index with an update to the
 branch that is checked out can be tweaked by push-to-checkout hook.

 Will cook in 'next'.


* nd/list-files (2015-01-27) 22 commits
 - t3080: tests for git-list-files
 - list-files: -M aka diff-cached
 - list-files -F: show submodules with the new indicator '&'
 - list-files: add -F/--classify
 - SQUASH???
 - list-files: show directories as well as files
 - list-files: do not show duplicate cached entries
 - list-files: sort output and remove duplicates
 - list-files: add -t back
 - list-files: add -1 short for --no-column
 - list-files: add -R/--recursive short for --max-depth=-1
 - list-files: -u does not imply showing stages
 - list-files: make alias 'ls' default to 'list-files'
 - list-files: a user friendly version of ls-files and more
 - ls-files: support --max-depth
 - ls-files: add --column
 - ls-files: add --color to highlight file names
 - ls-files: buffer full item in strbuf before printing
 - ls_colors.c: highlight submodules like directories
 - ls_colors.c: add a function to color a file name
 - ls_colors.c: parse color.ls.* from config file
 - ls_colors.c: add $LS_COLORS parsing code

 A new "git list-files" Porcelain command, "ls-files" with bells and
 whistles.

 Some comments seen on the list; may be gaining some interests?


* nd/multiple-work-trees (2015-01-27) 38 commits
 - t2026 needs procondition SANITY
 - git-checkout.txt: a note about multiple checkout support for submodules
 - checkout: add --ignore-other-wortrees
 - checkout: pass whole struct to parse_branchname_arg instead of individual flags
 - git-common-dir: make "modules/" per-working-directory directory
 - checkout: do not fail if target is an empty directory
 - t2025: add a test to make sure grafts is working from a linked checkout
 - checkout: don't require a work tree when checking out into a new one
 - git_path(): keep "info/sparse-checkout" per work-tree
 - count-objects: report unused files in $GIT_DIR/worktrees/...
 - gc: support prune --worktrees
 - gc: factor out gc.pruneexpire parsing code
 - gc: style change -- no SP before closing parenthesis
 - checkout: clean up half-prepared directories in --to mode
 - checkout: reject if the branch is already checked out elsewhere
 - prune: strategies for linked checkouts
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - $GIT_COMMON_DIR: a new environment variable
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - git_path(): be aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 - path.c: rename vsnpath() to do_git_path()
 - git_snpath(): retire and replace with strbuf_git_path()
 - path.c: make get_pathname() call sites return const char *
 - path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.


* nd/untracked-cache (2015-01-21) 24 commits
 - git-status.txt: advertisement for untracked cache
 - untracked cache: guard and disable on system changes
 - mingw32: add uname()
 - t7063: tests for untracked cache
 - update-index: test the system before enabling untracked cache
 - update-index: manually enable or disable untracked cache
 - status: enable untracked cache
 - untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
 - untracked cache: mark index dirty if untracked cache is updated
 - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
 - untracked cache: avoid racy timestamps
 - read-cache.c: split racy stat test to a separate function
 - untracked cache: invalidate at index addition or removal
 - untracked cache: load from UNTR index extension
 - untracked cache: save to an index extension
 - ewah: add convenient wrapper ewah_serialize_strbuf()
 - untracked cache: don't open non-existent .gitignore
 - untracked cache: mark what dirs should be recursed/saved
 - untracked cache: record/validate dir mtime and reuse cached output
 - untracked cache: make a wrapper around {open,read,close}dir()
 - untracked cache: invalidate dirs recursively if .gitignore changes
 - untracked cache: initial untracked cache validation
 - untracked cache: record .gitignore information and dir hierarchy
 - dir.c: optionally compute sha-1 of a .gitignore file

 Need extra set of eyes to review this.

--------------------------------------------------
[Discarded]

* jc/push-cert-hmac-optim (2014-09-25) 2 commits
 . receive-pack: truncate hmac early and convert only necessary bytes
 . sha1_to_hex: split out "hex-format n bytes" helper and use it

 This is "we could do this if we wanted to", not "we measured and it
 improves performance critical codepath".


* mt/patch-id-stable (2014-06-10) 1 commit
 . patch-id: change default to stable

 Nobody seems to be jumping up & down requesting this last step,
 which makes the result somewhat backward incompatible.


* sb/copy-fd-errno (2014-11-17) 1 commit
 . copy.c: make copy_fd preserve meaningful errno


* cj/grep-none-match (2015-01-06) 1 commit
 . git-log: added --none-match option

 "git log --none-match --grep=WIP" will show only commits that are
 not marked as WIP.

 cj/log-invert-grep replaces this.


* lf/blame-commit-label (2015-01-12) 1 commit
 . blame.c: fix garbled error message

 jk/blame-commit-label replaces this.
