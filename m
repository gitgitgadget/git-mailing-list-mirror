From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2014, #04; Tue, 17)
Date: Wed, 18 Jun 2014 10:25:03 -0700
Message-ID: <xmqqfvj2jfkg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:25:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJby-0008IF-BB
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbaFRRZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:25:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57779 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbaFRRZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:25:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 122781FFBB;
	Wed, 18 Jun 2014 13:25:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	ch0LaRWCbLjq0lRJ42I3X0Ik8A=; b=bLVzG/oxT7pK7Wb2rahn974NJCvBZwUFm
	9PmC9kqizUzg2U6Uu7eSEGFj9B+fyCg7p8py9/8i0LqD+31olND06hnYVKUS01GU
	g4D6sFOiozmgI6w/5YoNfXqH/TduJ2SvzhdkooAdbfg07kcpoZkRiEqfJx65mjoS
	IN5XlmCBlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=hMo
	EsXDQ/ydVJcrX3ih7nEEzQF7Z1OJGtfR4RaYjNPitU6TjDzDODWTsAMwE1o+ZTXw
	Ewx2p9JnffSuWsP12IuNXjnU3BZQNHoXJKa+K9qj/oUJvtnNaXMNwfm052PIlvwe
	gofhz3NHuP2OZlO0kYCntF8TNeLNCTFkX0Qs6qSg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 79D831FFBA;
	Wed, 18 Jun 2014 13:25:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 450261FFA9;
	Wed, 18 Jun 2014 13:25:03 -0400 (EDT)
X-master-at: cb682f8cfe63ecd0da08a526f404d295e51e3ab1
X-next-at: f681aa8b2164b7263bd68f49cd3bebd6bf560b78
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7BB37B16-F70D-11E3-B679-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252014>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Many topics that have been cooking in 'next' during the previous
cycle, totalling close to 300 individual patches, are in 'master'
now.  We have also accumulated some fixes we need to merge down to
'maint' and cut a v2.0.1 sometime next week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.


* as/pretty-truncate (2014-05-21) 5 commits
  (merged to 'next' on 2014-06-10 at d8147a2)
 + pretty.c: format string with truncate respects logOutputEncoding
 + t4205, t6006: add tests that fail with i18n.logOutputEncoding set
 + t4205 (log-pretty-format): use `tformat` rather than `format`
 + t4041, t4205, t6006, t7102: don't hardcode tested encoding value
 + t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs

 Originally merged to 'next' on 2014-05-23


* bg/xcalloc-nmemb-then-size (2014-05-27) 12 commits
  (merged to 'next' on 2014-06-10 at eddb5bc)
 + transport-helper.c: rearrange xcalloc arguments
 + remote.c: rearrange xcalloc arguments
 + reflog-walk.c: rearrange xcalloc arguments
 + pack-revindex.c: rearrange xcalloc arguments
 + notes.c: rearrange xcalloc arguments
 + imap-send.c: rearrange xcalloc arguments
 + http-push.c: rearrange xcalloc arguments
 + diff.c: rearrange xcalloc arguments
 + config.c: rearrange xcalloc arguments
 + commit.c: rearrange xcalloc arguments
 + builtin/remote.c: rearrange xcalloc arguments
 + builtin/ls-remote.c: rearrange xcalloc arguments

 Originally merged to 'next' on 2014-06-06

 Like calloc(3), xcalloc() takes nmemb and then size.


* cb/byte-order (2014-05-30) 3 commits
  (merged to 'next' on 2014-06-10 at 63db8ee)
 + compat/bswap.h: fix endianness detection
 + compat/bswap.h: restore preference __BIG_ENDIAN over BIG_ENDIAN
 + compat/bswap.h: detect endianness on more platforms that don't use BYTE_ORDER

 Originally merged to 'next' on 2014-05-30

 Compatibility enhancement for Solaris.


* cc/replace-edit (2014-05-19) 10 commits
  (merged to 'next' on 2014-06-10 at ff69722)
 + Documentation: replace: describe new --edit option
 + replace: add --edit to usage string
 + replace: add tests for --edit
 + replace: die early if replace ref already exists
 + replace: refactor checking ref validity
 + replace: make sure --edit results in a different object
 + replace: add --edit option
 + replace: factor object resolution out of replace_object
 + replace: use OPT_CMDMODE to handle modes
 + replace: refactor command-mode determination
 (this branch is used by cc/replace-graft.)

 Originally merged to 'next' on 2014-05-19

 "git replace" learns a new "--edit" option.


* dt/refs-check-refname-component-optim (2014-06-05) 1 commit
  (merged to 'next' on 2014-06-10 at 4560669)
 + refs.c: optimize check_refname_component()
 (this branch is used by dt/refs-check-refname-component-sse42.)

 Originally merged to 'next' on 2014-06-06


* fc/remote-helper-refmap (2014-04-21) 8 commits
  (merged to 'next' on 2014-06-10 at 8cd8cf8)
 + transport-helper: remove unnecessary strbuf resets
 + transport-helper: add support to delete branches
 + fast-export: add support to delete refs
 + fast-import: add support to delete refs
 + transport-helper: add support to push symbolic refs
 + transport-helper: add support for old:new refspec
 + fast-export: add new --refspec option
 + fast-export: improve argument parsing

 Originally merged to 'next' on 2014-04-22

 Allow remote-helper/fast-import based transport to rename the refs
 while transferring the history.


* ib/test-selectively-run (2014-06-06) 4 commits
  (merged to 'next' on 2014-06-10 at 1235570)
 + t0000-*.sh: fix the GIT_SKIP_TESTS sub-tests
 + test-lib: '--run' to run only specific tests
 + test-lib: tests skipped by GIT_SKIP_TESTS say so
 + test-lib: document short options in t/README

 Originally merged to 'next' on 2014-06-06

 Allow specifying only certain individual test pieces to be run
 using a range notation (e.g. "t1234-test.sh --run='1-4 6 8 9-'").


* jk/argv-array-for-child-process (2014-05-15) 7 commits
  (merged to 'next' on 2014-06-10 at 07a167b)
 + argv-array: drop "detach" code
 + get_importer: use run-command's internal argv_array
 + get_exporter: use argv_array
 + get_helper: use run-command's internal argv_array
 + git_connect: use argv_array
 + run_column_filter: use argv_array
 + run-command: store an optional argv_array

 Originally merged to 'next' on 2014-05-21


* jk/complete-merge-pull (2014-05-27) 2 commits
  (merged to 'next' on 2014-06-10 at d1524c5)
 + completion: add missing options for git-merge
 + completion: add a note that merge options are shared

 Originally merged to 'next' on 2014-06-06

 The completion code did not know about quite a few options that are
 common between "git merge" and "git pull", and a couple of options
 unique to "git merge".


* jk/daemon-tolower (2014-05-23) 1 commit
  (merged to 'next' on 2014-06-10 at f3c549d)
 + daemon/config: factor out duplicate xstrdup_tolower

 Originally merged to 'next' on 2014-05-23


* jk/diff-files-assume-unchanged (2014-05-15) 1 commit
  (merged to 'next' on 2014-06-10 at 984862b)
 + run_diff_files: do not look at uninitialized stat data

 Originally merged to 'next' on 2014-05-21


* jk/diff-follow-must-take-one-pathspec (2014-05-20) 1 commit
  (merged to 'next' on 2014-06-10 at 0cd28d7)
 + move "--follow needs one pathspec" rule to diff_setup_done

 Originally merged to 'next' on 2014-05-23


* jk/do-not-run-httpd-tests-as-root (2014-05-12) 1 commit
  (merged to 'next' on 2014-06-10 at 745b05c)
 + t/lib-httpd: require SANITY prereq

 Originally merged to 'next' on 2014-05-21


* jk/error-resolve-conflict-advice (2014-06-03) 2 commits
  (merged to 'next' on 2014-06-10 at 713ebe0)
 + error_resolve_conflict: drop quotations around operation
 + error_resolve_conflict: rewrap advice message

 Originally merged to 'next' on 2014-06-06


* jk/http-errors (2014-05-27) 8 commits
  (merged to 'next' on 2014-06-10 at 30e9212)
 + http: default text charset to iso-8859-1
 + remote-curl: reencode http error messages
 + strbuf: add strbuf_reencode helper
 + http: optionally extract charset parameter from content-type
 + http: extract type/subtype portion of content-type
 + t5550: test display of remote http error messages
 + t/lib-httpd: use write_script to copy CGI scripts
 + test-lib: preserve GIT_CURL_VERBOSE from the environment

 Originally merged to 'next' on 2014-06-06

 Propagate the error messages from the webserver better to the
 client coming over the HTTP transport.


* jk/report-fail-to-read-objects-better (2014-05-15) 1 commit
  (merged to 'next' on 2014-06-10 at 299ea28)
 + open_sha1_file: report "most interesting" errno

 Originally merged to 'next' on 2014-05-21


* jk/strbuf-tolower (2014-05-23) 1 commit
  (merged to 'next' on 2014-06-10 at 01e6983)
 + strbuf: add strbuf_tolower function

 Originally merged to 'next' on 2014-05-23


* jl/remote-rm-prune (2014-05-27) 3 commits
  (merged to 'next' on 2014-06-10 at 13259ff)
 + remote prune: optimize "dangling symref" check/warning
 + remote: repack packed-refs once when deleting multiple refs
 + remote rm: delete remote configuration as the last

 Originally merged to 'next' on 2014-06-06

 "git remote rm" and "git remote prune" can involve removing many
 refs at once, which is not a very efficient thing to do when very
 many refs exist in the packed-refs file.


* jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
  (merged to 'next' on 2014-06-10 at fc63847)
 + commit -m: commit staged submodules regardless of ignore config
 + status/commit: show staged submodules regardless of ignore config

 Originally merged to 'next' on 2014-06-06

 submodule.*.ignore and diff.ignoresubmodules are used to ignore all
 submodule changes in "diff" output, but it can be confusing to
 apply these configuration values to status and commit.

 This is a backward-incompatible change, but should be so in a good
 way (aka bugfix).


* jm/dedup-test-config (2014-06-05) 1 commit
  (merged to 'next' on 2014-06-10 at 8966f54)
 + t/t7810-grep.sh: remove duplicate test_config()

 Originally merged to 'next' on 2014-06-06


* jm/doc-wording-tweaks (2014-05-28) 1 commit
  (merged to 'next' on 2014-06-10 at 5f2e094)
 + Documentation: wording fixes in the user manual and glossary

 Originally merged to 'next' on 2014-06-06


* jm/format-patch-mail-sig (2014-05-27) 2 commits
  (merged to 'next' on 2014-06-10 at 310f59e)
 + format-patch: add "--signature-file=<file>" option
 + format-patch: make newline after signature conditional

 Originally merged to 'next' on 2014-06-06


* jm/instaweb-apache-24 (2014-05-27) 1 commit
  (merged to 'next' on 2014-06-10 at ecf2048)
 + git-instaweb: add support for Apache 2.4

 Originally merged to 'next' on 2014-06-06


* jm/t9138-style-fix (2014-05-27) 1 commit
  (merged to 'next' on 2014-06-10 at 034f13d)
 + t9138-git-svn-authors-prog.sh fixups

 Originally merged to 'next' on 2014-06-06


* lt/log-auto-decorate (2014-05-30) 1 commit
  (merged to 'next' on 2014-06-10 at f149f4a)
 + git log: support "auto" decorations

 Originally merged to 'next' on 2014-06-06


* nd/daemonize-gc (2014-05-27) 1 commit
  (merged to 'next' on 2014-06-10 at 6fae7b0)
 + gc --auto: do not lock refs in the background

 Originally merged to 'next' on 2014-06-06

 "git gc --auto" was recently changed to run in the background to
 give control back early to the end-user sitting in front of the
 terminal, but it forgot that housekeeping involving reflogs should
 be done without other processes competing for accesses to the refs.


* ow/config-mailmap-pathname (2014-05-27) 1 commit
  (merged to 'next' on 2014-06-10 at aba4ca2)
 + config: respect '~' and '~user' in mailmap.file

 Originally merged to 'next' on 2014-06-06

 mailmap.file configuration names a pathname, hence should honor
 ~/path and ~user/path as its value.


* rr/rebase-autostash-fix (2014-05-20) 2 commits
  (merged to 'next' on 2014-06-10 at afd0c29)
 + rebase -i: test "Nothing to do" case with autostash
 + rebase -i: handle "Nothing to do" case with autostash

 Originally merged to 'next' on 2014-05-21


* rs/pack-objects-no-unnecessary-realloc (2014-06-02) 1 commit
  (merged to 'next' on 2014-06-10 at abae695)
 + pack-objects: use free()+xcalloc() instead of xrealloc()+memset()

 Originally merged to 'next' on 2014-06-06

 Avoid unnecessary copy of previous contents when extending the
 hashtable used in pack-objects.


* rs/read-ref-at (2014-06-03) 1 commit
  (merged to 'next' on 2014-06-10 at f58f2fc)
 + refs.c: change read_ref_at to use the reflog iterators

 Originally merged to 'next' on 2014-06-06


* sh/enable-preloadindex (2014-06-03) 1 commit
  (merged to 'next' on 2014-06-10 at 7cedf2d)
 + environment.c: enable core.preloadindex by default

 Originally merged to 'next' on 2014-06-06


* sk/test-cmp-bin (2014-06-04) 1 commit
  (merged to 'next' on 2014-06-10 at 020a475)
 + t5000, t5003: do not use test_cmp to compare binary files

 Originally merged to 'next' on 2014-06-06


* sk/wincred (2014-05-14) 2 commits
  (merged to 'next' on 2014-06-10 at 8d03e5a)
 + wincred: avoid overwriting configured variables
 + wincred: add install target

 Originally merged to 'next' on 2014-05-21


* sk/windows-unc-path (2014-06-10) 1 commit
  (merged to 'next' on 2014-06-10 at 3598cc6)
 + Windows: allow using UNC path for git repository
 (this branch is used by sk/mingw-main, sk/mingw-uni-console and sk/mingw-unicode-spawn-args.)

 Originally merged to 'next' on 2014-05-21


* ta/string-list-init (2014-06-06) 1 commit
  (merged to 'next' on 2014-06-10 at bf209ff)
 + string-list: spell all values out that are given to a string_list initializer

 Originally merged to 'next' on 2014-06-06

--------------------------------------------------
[New Topics]

* fr/sequencer-fail-with-not-one-upon-no-ff (2014-06-09) 1 commit
  (merged to 'next' on 2014-06-16 at 29734cc)
 + sequencer: signal failed ff as an aborted, not a conflicted merge

 Will merge to 'master'.


* hv/submodule-config (2014-06-13) 6 commits
 - SQUASH compilation fix
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names
 - hashmap: add enum for hashmap free_entries option


* mc/git-p4-prepare-p4-only (2014-06-13) 1 commit
  (merged to 'next' on 2014-06-16 at 3c05e19)
 + git-p4: fix submit in non --prepare-p4-only mode

 Will merge to 'master'.


* sk/mingw-unicode-spawn-args (2014-06-16) 6 commits
 - Win32: Unicode arguments (incoming)
 - Win32: Unicode arguments (outgoing)
 - MinGW: disable CRT command line globbing
 - Win32: fix potential multi-threading issue
 - Win32: simplify internal mingw_spawn* APIs
 - Win32: let mingw_execve() return an int
 (this branch uses sk/mingw-main and sk/mingw-uni-console.)


* sp/complete-ext-alias (2014-06-13) 1 commit
  (merged to 'next' on 2014-06-16 at 399679e)
 + completion: handle '!f() { ... }; f' and "!sh -c '...' -" aliases

 Will merge to 'master'.


* bc/fix-rebase-merge-skip (2014-06-16) 1 commit
 - rebase--merge: fix --skip with two conflicts in a row

 "git rebase --skip" did not work well when it stopped due to a
 conflict twice in a row.

 Will merge to 'next'.


* jl/submodule-tests (2014-06-16) 16 commits
 - revert: add t3513 for submodule updates
 - stash: add t3906 for submodule updates
 - am: add t4255 for submodule updates
 - cherry-pick: add t3512 for submodule updates
 - pull: add t5572 for submodule updates
 - SQUASH???
 - rebase: add t3426 for submodule updates
 - merge: add t7613 for submodule updates
 - bisect: add t6041 for submodule updates
 - reset: add t7112 for submodule updates
 - read-tree: add t1013 for submodule updates
 - apply: add t4137 for submodule updates
 - checkout: call the new submodule update test framework
 - submodules: Add the lib-submodule-update.sh test library
 - SQUASH???
 - test-lib: add test_dir_is_empty()

 Expecting a reroll.


* mc/doc-submodule-sync-recurse (2014-06-13) 1 commit
 - submodule: document "sync --recursive"

 Will merge to 'next'.


* pb/trim-trailing-spaces (2014-06-13) 1 commit
 - t0008: do not depend on 'echo' handling backslashes specially

 Will merge to 'next'.


* po/error-message-style (2014-06-16) 1 commit
 - doc: state coding guideline for error message punctuation

 Expecting a reroll.


* rs/blame-refactor (2014-06-13) 2 commits
 - blame: simplify prepare_lines()
 - blame: factor out get_next_line()

 Will merge to 'next'.


* rs/ref-transaction (2014-06-17) 48 commits
 - refs.c: make write_ref_sha1 static
 - fetch.c: change s_update_ref to use a ref transaction
 - refs.c: propagate any errno==ENOTDIR from _commit back to the callers
 - refs.c: pass a skip list to name_conflict_fn
 - refs.c: call lock_ref_sha1_basic directly from commit
 - refs.c: move the check for valid refname to lock_ref_sha1_basic
 - refs.c: pass NULL as *flags to read_ref_full
 - refs.c: pass the ref log message to _create/delete/update instead of _commit
 - refs.c: make delete_ref use a transaction
 - refs.c: make prune_ref use a transaction to delete the ref
 - refs.c: remove lock_ref_sha1
 - refs.c: remove the update_ref_write function
 - refs.c: remove the update_ref_lock function
 - refs.c: make lock_ref_sha1 static
 - walker.c: use ref transaction for ref updates
 - fast-import.c: use a ref transaction when dumping tags
 - receive-pack.c: use a reference transaction for updating the refs
 - refs.c: change update_ref to use a transaction
 - branch.c: use ref transaction for all ref updates
 - fast-import.c: change update_branch to use ref transactions
 - sequencer.c: use ref transactions for all ref updates
 - commit.c: use ref transactions for updates
 - replace.c: use the ref transaction functions for updates
 - tag.c: use ref transactions when doing updates
 - refs.c: add transaction.status and track OPEN/CLOSED/ERROR
 - refs.c: make ref_transaction_begin take an err argument
 - refs.c: update ref_transaction_delete to check for error and return status
 - refs.c: change ref_transaction_create to do error checking and return status
 - refs.c: change ref_transaction_update() to do error checking and return status
 - refs.c: remove the onerr argument to ref_transaction_commit
 - update-ref: use err argument to get error from ref_transaction_commit
 - refs.c: make update_ref_write update a strbuf on failure
 - refs.c: add an err argument to delete_ref_loose
 - refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
 - refs.c: log_ref_write should try to return meaningful errno
 - refs.c: make resolve_ref_unsafe set errno to something meaningful on error
 - refs.c: commit_packed_refs to return a meaningful errno on failure
 - refs.c: make remove_empty_directories alwasy set errno to something sane
 - refs.c: verify_lock should set errno to something meaningful
 - refs.c: make sure log_ref_setup returns a meaningful errno
 - refs.c: add an err argument to repack_without_refs
 - lockfile.c: make lock_file return a meaningful errno on failurei
 - lockfile.c: add a new public function unable_to_lock_message
 - refs.c: add a strbuf argument to ref_transaction_commit for error logging
 - refs.c: allow passing NULL to ref_transaction_free
 - refs.c: constify the sha arguments for ref_transaction_create|delete|update
 - refs.c: ref_transaction_commit should not free the transaction
 - refs.c: remove ref_transaction_rollback


* ye/doc-http-proto (2014-06-16) 1 commit
 - http-protocol.txt: Basic Auth is defined in RFC 2617, not RFC 2616

 Will merge to 'next'.


* jk/pretty-G-format-fixes (2014-06-17) 5 commits
 - pretty: avoid reading past end-of-string with "%G"
 - t7510: check %G* pretty-format output
 - t7510: test a commit signed by an unknown key
 - t7510: use consistent &&-chains in loop
 - t7510: stop referring to master in later tests


* tb/unicode-7.0 (2014-06-17) 1 commit
 - Update of unicode_width.h to Unicode Version 7.0

--------------------------------------------------
[Stalled]

* cc/replace-graft (2014-06-09) 5 commits
 - DONTMERGE: wise to wait for peff's commit->buffer length series
 - contrib: add convert-grafts-to-replace-refs.sh
 - Documentation: replace: add --graft option
 - replace: add test for --graft
 - replace: add --graft option

 "git replace" learned a "--graft" option to rewrite parents of a
 commit.


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* rh/prompt-tests (2014-06-05) 11 commits
 - t9904: new __git_ps1 tests for Zsh
 - test-lib: make it possible to override how test code is eval'd
 - lib-prompt-tests.sh: add variable for string that encodes percent in PS1
 - lib-prompt-tests.sh: put all tests inside a function
 - t9903: move prompt tests to a new lib-prompt-tests.sh file
 - t9903: move PS1 color code variable definitions to lib-bash.sh
 - t9903: include "Bash" in test names via new $shellname var
 - t9903: run pc mode tests again with PS1 expansion disabled
 - t9903: move test name prefix to a separate variable
 - t9903: put the Bash pc mode prompt test cases in a function
 - t9903: remove Zsh test from the suite of Bash prompt tests

 Expecting a reroll to limit the damage to test_eval_; also reported
 to be broken with older zsh that are still in the field ($gmane/251231).


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* cc/interpret-trailers (2014-05-28) 11 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from file or stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from input message and arguments
 - trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.

 What is the status of this one?  I think I saw reviews by Michael
 but after that I do not recall seeing any updates.


* jh/submodule-tests (2014-04-17) 1 commit
 - t7410: 210 tests for various 'git submodule update' scenarios

 More or less abandoned.  Will drop.


* nd/multiple-work-trees (2014-03-25) 28 commits
 - count-objects: report unused files in $GIT_DIR/repos/...
 - gc: support prune --repos
 - gc: style change -- no SP before closing bracket
 - prune: strategies for linked checkouts
 - checkout: detach if the branch is already checked out elsewhere
 - checkout: clean up half-prepared directories in --to mode
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


* mh/lockfile (2014-04-15) 25 commits
 - trim_last_path_elm(): replace last_path_elm()
 - resolve_symlink(): take a strbuf parameter
 - resolve_symlink(): use a strbuf for internal scratch space
 - change lock_file::filename into a strbuf
 - commit_lock_file(): use a strbuf to manage temporary space
 - try_merge_strategy(): use a statically-allocated lock_file object
 - try_merge_strategy(): remove redundant lock_file allocation
 - struct lock_file: declare some fields volatile
 - lockfile: avoid transitory invalid states
 - commit_lock_file(): die() if called for unlocked lockfile object
 - commit_lock_file(): inline temporary variable
 - remove_lock_file(): call rollback_lock_file()
 - lock_file(): exit early if lockfile cannot be opened
 - write_packed_entry_fn(): convert cb_data into a (const int *)
 - prepare_index(): declare return value to be (const char *)
 - delete_ref_loose(): don't muck around in the lock_file's filename
 - cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 - lockfile.c: document the various states of lock_file objects
 - lock_file(): always add lock_file object to lock_file_list
 - hold_lock_file_for_append(): release lock on errors
 - lockfile: unlock file if lockfile permissions cannot be adjusted
 - rollback_lock_file(): set fd to -1
 - rollback_lock_file(): do not clear filename redundantly
 - api-lockfile: expand the documentation
 - unable_to_lock_die(): rename function from unable_to_lock_index_die()

 Refactor and fix corner-case bugs in the lockfile API, all looked
 sensible.

 Expecting a reroll.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)

 Will hold.


* tr/remerge-diff (2014-02-26) 5 commits
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . revision: fold all merge diff variants into an enum merge_diff_mode
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Needs to be rebased, now kb/fast-hashmap topic is in.


* jk/makefile (2014-02-05) 16 commits
 . FIXUP
 . move LESS/LV pager environment to Makefile
 . Makefile: teach scripts to include make variables
 . FIXUP
 . Makefile: auto-build C strings from make variables
 . Makefile: drop *_SQ variables
 . FIXUP
 . Makefile: add c-quote helper function
 . Makefile: introduce sq function for shell-quoting
 . Makefile: always create files via make-var
 . Makefile: store GIT-* sentinel files in MAKE/
 . Makefile: prefer printf to echo for GIT-*
 . Makefile: use tempfile/mv strategy for GIT-*
 . Makefile: introduce make-var helper function
 . Makefile: fix git-instaweb dependency on gitweb
 . Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 . t1507 (rev-parse-upstream): fix typo in test title
 . implement @{publish} shorthand
 . branch_get: provide per-branch pushremote pointers
 . branch_get: return early on error
 . sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Meant to be used as a basis for whatever Ram wants to build on.

 Ejected from 'pu' to unclutter.


* fc/publish-vs-upstream (2014-04-21) 8 commits
 . sha1_name: add support for @{publish} marks
 . sha1_name: simplify track finding
 . sha1_name: cleanup interpret_branch_name()
 . branch: display publish branch
 . push: add --set-publish option
 . branch: add --set-publish-to option
 . Add concept of 'publish' branch
 . t5516 (fetch-push): fix test restoration

 Add branch@{publish}; it seems that this is somewhat different from
 Ram and Peff started working on.  At least the tip needs to be
 rerolled not to squat on @{p} which @{push} and possibly @{pull}
 may want to share.


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


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Needs to be rebased, now the pack-bitmap series is in.


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

* jc/fetch-pull-refmap (2014-06-12) 10 commits
  (merged to 'next' on 2014-06-12 at 5428530)
 + docs: Explain the purpose of fetch's and pull's <refspec> parameter.
  (merged to 'next' on 2014-06-10 at 13c13ae)
 + fetch: allow explicit --refmap to override configuration
 + fetch doc: add a section on configured remote-tracking branches
 + fetch doc: remove "short-cut" section
 + fetch doc: update refspec format description
 + fetch doc: on pulling multiple refspecs
 + fetch doc: remove notes on outdated "mixed layout"
 + fetch doc: update note on '+' in front of the refspec
 + fetch doc: move FETCH_HEAD material lower and add an example
 + fetch doc: update introductory part for clarity

 Will merge to 'master'.


* nd/split-index (2014-06-13) 32 commits
 - t1700: new tests for split-index mode
 - t2104: make sure split index mode is off for the version test
 - read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
 - read-tree: note about dropping split-index mode or index version
 - read-tree: force split-index mode off on --index-output
 - rev-parse: add --shared-index-path to get shared index path
 - update-index --split-index: do not split if $GIT_DIR is read only
 - update-index: new options to enable/disable split index mode
 - split-index: strip pathname of on-disk replaced entries
 - split-index: do not invalidate cache-tree at read time
 - split-index: the reading part
 - split-index: the writing part
 - read-cache: mark updated entries for split index
 - read-cache: save deleted entries in split index
 - read-cache: mark new entries for split index
 - read-cache: split-index mode
 - read-cache: save index SHA-1 after reading
 - entry.c: update cache_changed if refresh_cache is set in checkout_entry()
 - cache-tree: mark istate->cache_changed on prime_cache_tree()
 - cache-tree: mark istate->cache_changed on cache tree update
 - cache-tree: mark istate->cache_changed on cache tree invalidation
 - unpack-trees: be specific what part of the index has changed
 - resolve-undo: be specific what part of the index has changed
 - update-index: be specific what part of the index has changed
 - read-cache: be specific what part of the index has changed
 - read-cache: be strict about "changed" in remove_marked_cache_entries()
 - read-cache: store in-memory flags in the first 12 bits of ce_flags
 - read-cache: relocate and unexport commit_locked_index()
 - read-cache: new API write_locked_index instead of write_index/write_cache
 - sequencer: do not update/refresh index if the lock cannot be held
 - ewah: delete unused ewah_read_mmap_native declaration
 - ewah: fix constness of ewah_read_mmap


* ep/avoid-test-a-o (2014-06-10) 21 commits
 - git-submodule.sh: avoid "echo" path-like values
 - SQUASH: misconversion breakage fix
 - git-submodule.sh: avoid "test <cond> -a/-o <cond>"
 - t/test-lib-functions.sh: avoid "test <cond> -a/-o <cond>"
 - t/t9814-git-p4-rename.sh: avoid "test <cond> -a/-o <cond>"
 - t/t5538-push-shallow.sh: avoid "test <cond> -a/-o <cond>"
 - t/t5403-post-checkout-hook.sh: avoid "test <cond> -a/-o <cond>"
 - t/t5000-tar-tree.sh: avoid "test <cond> -a/-o <cond>"
 - t/t4102-apply-rename.sh: avoid "test <cond> -a/-o <cond>"
 - t/t0026-eol-config.sh: avoid "test <cond> -a/-o <cond>"
 - t/t0025-crlf-auto.sh: avoid "test <cond> -a/-o <cond>"
 - t/lib-httpd.sh: avoid "test <cond> -a/-o <cond>"
 - git-rebase--interactive.sh: avoid "test <cond> -a/-o <cond>"
 - git-mergetool.sh: avoid "test <cond> -a/-o <cond>"
 - git-bisect.sh: avoid "test <cond> -a/-o <cond>"
 - contrib/examples/git-resolve.sh: avoid "test <cond> -a/-o <cond>"
 - contrib/examples/git-repack.sh: avoid "test <cond> -a/-o <cond>"
 - contrib/examples/git-merge.sh: avoid "test <cond> -a/-o <cond>"
 - contrib/examples/git-commit.sh: avoid "test <cond> -a/-o <cond>"
 - contrib/examples/git-clone.sh: avoid "test <cond> -a/-o <cond>"
 - check_bindir: avoid "test <cond> -a/-o <cond>"


* jc/revision-dash-count-parsing (2014-06-09) 1 commit
  (merged to 'next' on 2014-06-10 at 1aeca19)
 + revision: parse "git log -<count>" more carefully

 "git log -2master" is a common typo that shows two commits starting
 from whichever random branch that is not 'master' that happens to
 be checked out currently.

 Will merge to 'master'.


* jc/test-lazy-prereq (2014-06-13) 7 commits
 - tests: drop GIT_*_TIMING_TESTS environment variable support
  (merged to 'next' on 2014-06-10 at 4f774f7)
 + t3419: drop unnecessary NOT_EXPENSIVE pseudo-prerequisite
 + t3302: drop unnecessary NOT_EXPENSIVE pseudo-prerequisite
 + t3302: do not chdir around in the primary test process
 + t3302: coding style updates
 + test: turn USR_BIN_TIME into a lazy prerequisite
 + test: turn EXPENSIVE into a lazy prerequisite

 Test-script clean-up.  The last step might be controversial.

 Will merge to 'master' except for the last one.


* jk/commit-buffer-length (2014-06-13) 18 commits
  (merged to 'next' on 2014-06-16 at b2d2d7b)
 + reuse cached commit buffer when parsing signatures
 + commit: record buffer length in cache
 + commit: convert commit->buffer to a slab
 + commit-slab: provide a static initializer
 + use get_commit_buffer everywhere
 + convert logmsg_reencode to get_commit_buffer
 + use get_commit_buffer to avoid duplicate code
 + use get_cached_commit_buffer where appropriate
 + provide helpers to access the commit buffer
 + provide a helper to set the commit buffer
 + provide a helper to free commit buffer
 + sequencer: use logmsg_reencode in get_message
 + logmsg_reencode: return const buffer
 + do not create "struct commit" with xcalloc
 + commit: push commit_index update into alloc_commit_node
 + alloc: include any-object allocations in alloc_report
 + replace dangerous uses of strbuf_attach
 + commit_tree: take a pointer/len pair rather than a const strbuf

 Move "commit->buffer" out of the in-core commit object and keep
 track of their lengths.  Use this to optimize the code paths to
 validate GPG signatures in commit objects.

 Will merge to 'master'.


* jm/api-strbuf-doc (2014-06-09) 1 commit
  (merged to 'next' on 2014-06-10 at 831aa30)
 + api-strbuf.txt minor typos

 Will merge to 'master'.


* rs/more-starts-with (2014-06-09) 1 commit
  (merged to 'next' on 2014-06-10 at efcd02e)
 + Use starts_with() for C strings instead of memcmp()

 Will merge to 'master'.


* sk/mingw-dirent (2014-06-09) 5 commits
 - Win32 dirent: improve dirent implementation
 - Win32 dirent: clarify #include directives
 - Win32 dirent: change FILENAME_MAX to MAX_PATH
 - Win32 dirent: remove unused dirent.d_reclen member
 - Win32 dirent: remove unused dirent.d_ino member


* sk/mingw-main (2014-06-10) 2 commits
 - mingw: avoid const warning
 - Win32: move main macro to a function
 (this branch is used by sk/mingw-uni-console and sk/mingw-unicode-spawn-args.)


* sk/mingw-uni-console (2014-06-16) 7 commits
 - Win32: reliably detect console pipe handles
 - Win32: fix broken pipe detection
 - Win32: Thread-safe windows console output
 - Win32: add Unicode conversion functions
 - Win32: warn if the console font doesn't support Unicode
 - Win32: detect console streams more reliably
 - Win32: support Unicode console output
 (this branch is used by sk/mingw-unicode-spawn-args; uses sk/mingw-main.)

 Now, are Windows folks happy with all four mingw topics?


* tb/t5551-clone-notice-to-stderr (2014-06-09) 1 commit
  (merged to 'next' on 2014-06-10 at 374082c)
 + t5551: fix the 50,000 tag test

 Will merge to 'master'.


* jk/repack-pack-keep-objects (2014-06-10) 3 commits
  (merged to 'next' on 2014-06-16 at 89716c9)
 + repack: s/write_bitmap/&s/ in code
 + repack: respect pack.writebitmaps
 + repack: do not accidentally pack kept objects by default
 (this branch is used by jk/repack-pack-writebitmaps-config.)

 Recent updates to "git repack" started to duplicate objects that
 are in packfiles marked with .keep flag into the new packfile by
 mistake.

 Will merge to 'master'.


* jk/repack-pack-writebitmaps-config (2014-06-12) 4 commits
  (merged to 'next' on 2014-06-16 at 777005d)
 + t7700: drop explicit --no-pack-kept-objects from .keep test
 + repack: introduce repack.writeBitmaps config option
 + repack: simplify handling of --write-bitmap-index
 + pack-objects: stop respecting pack.writebitmaps
 (this branch uses jk/repack-pack-keep-objects.)

 Will merge to 'master'.


* mg/verify-commit (2014-06-10) 3 commits
 - verify-commit: scriptable commit signature verification
 - gpg-interface: provide access to the payload
 - pretty: free the gpg status buf

 What is queued here is v1; v2 exists but I skipped it.
 Expecting a reroll.


* nd/init-restore-env (2014-06-10) 1 commit
  (merged to 'next' on 2014-06-16 at ecbbfca)
 + git potty: restore environments after alias expansion

 Will merge to 'master'.


* jl/git-gui-show-added-submodule-changes (2014-04-15) 1 commit
 - git-gui: show staged submodules regardless of ignore config

 Tentatively queued what I expect to receive via Pat Thoyts.


* jl/gitk-show-added-submodule-changes (2014-04-15) 3 commits
 - gitk: show staged submodules regardless of ignore config
 - gitk: Merge branch 'new' of https://github.com/vnwildman/gitk
 - l10n: Init Vietnamese translation

 Will drop, as I heard from Paul that these are queued in his tree.


* mt/send-email-cover-to-cc (2014-06-10) 3 commits
  (merged to 'next' on 2014-06-10 at 6bb1465)
 + t9001: avoid non-portable '\n' with sed
 + test/send-email: to-cover, cc-cover tests
 + git-send-email: two new options: to-cover, cc-cover

 Originally merged to 'next' on 2014-06-10

 Will merge to 'master'.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

--------------------------------------------------
[Discarded]

* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 . Teach checkout to recursively checkout submodules
 . submodule: teach unpack_trees() to update submodules
 . submodule: teach unpack_trees() to repopulate submodules
 . submodule: teach unpack_trees() to remove submodule contents
 . submodule: prepare for recursive checkout of submodules

 Dropped for now to make room for another topic ($gmane/251521)
