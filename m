From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2014, #04; Mon, 22)
Date: Mon, 22 Dec 2014 15:17:08 -0800
Message-ID: <xmqqh9wn6zrf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 00:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3CE2-0002wq-DM
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 00:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbaLVXRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 18:17:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753069AbaLVXRL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 18:17:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C27029633;
	Mon, 22 Dec 2014 18:17:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=6
	GfjYsqxVEljELceO/jO5MRN98M=; b=AnHulNm6R/GhHbsi2KviEZepFeUidFp6T
	kZ1rm/Y1FLlEWB9B0OzIpwm287nWP4uhtCf6n0NpDJErS8Vg8LqtelNQlJP5xdra
	k7x7XtMtjyVZSrNZaTkDKNLXA2B8hunr6DYnXpf4mpNWxlVlliaaqd+gPyfPnlAN
	c72UTvQjZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=os+
	mI5fR0towwFprYCfAc7cg/ZSYomkDGu9XcNaYbrEEGviQ2SelkVh1zTzjXAW6nST
	xsf/uAf6wdvtULBH14sHnE9gqva54o+Kno23CJxuMdXhC5BH+9Mgymw6uK72OtJ4
	PxeWPnt9/wI9WYYSEryg1fYRrBkivCNxZVsVIncY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 733E729632;
	Mon, 22 Dec 2014 18:17:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A45F629631;
	Mon, 22 Dec 2014 18:17:09 -0500 (EST)
X-master-at: bbcefffcea9789e4a1a2023a1c778e2c07db77a7
X-next-at: 0ad48deaa29372e974d108b05da375b40a954ec2
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A73D165A-8A30-11E4-9E00-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261698>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Quite a few topics have been merged to 'master' as the third batch
for this cycle, on top of the recent "case sensitive .Git" fix that
has been publicized very widely.  The next release which is expected
to be a small one is taking shape.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cc/interpret-trailers-more (2014-11-10) 4 commits
  (merged to 'next' on 2014-12-15 at 77f6c6a)
 + trailer: add test with an old style conflict block
 + trailer: reuse ignore_non_trailer() to ignore conflict lines
 + commit: make ignore_non_trailer() non static
 + Merge branch 'jc/conflict-hint' into cc/interpret-trailers-more
 (this branch uses jc/conflict-hint.)

 "git interpret-trailers" learned to properly handle the
 "Conflicts:" block at the end.


* ch/new-gpg-drops-rfc-1991 (2014-12-12) 4 commits
  (merged to 'next' on 2014-12-15 at 32d7d50)
 + tests: squelch noise from GPG machinery set-up
 + tests: replace binary GPG keyrings with ASCII-armored keys
 + tests: skip RFC1991 tests for gnupg 2.1
 + tests: create gpg homedir on the fly

 Recent GPG changes the keyring format and drops support for RFC1991
 formatted signatures, breaking our existing tests.


* dm/compat-s-ifmt-for-zos (2014-12-04) 1 commit
  (merged to 'next' on 2014-12-15 at 0eb2fe6)
 + compat: convert modes to use portable file type values

 Long overdue departure from the assumption that S_IFMT is shared by
 everybody made in 2005.


* dw/shell-basename-dashdash-before-stripping-leading-dash-from-login (2014-11-25) 1 commit
  (merged to 'next' on 2014-12-15 at 42937b7)
 + git-sh-setup.sh: use dashdash with basename call


* jc/conflict-hint (2014-10-28) 4 commits
  (merged to 'next' on 2014-12-15 at b72475f)
 + merge & sequencer: turn "Conflicts:" hint into a comment
 + builtin/commit.c: extract ignore_non_trailer() helper function
 + merge & sequencer: unify codepaths that write "Conflicts:" hint
 + builtin/merge.c: drop a parameter that is never used
 (this branch is used by cc/interpret-trailers-more.)

 Unlike all the other hints given in the commit log editor, the list
 of conflicted paths were appended at the end without commented out.


* jc/exec-cmd-system-path-leak-fix (2014-11-30) 1 commit
  (merged to 'next' on 2014-12-15 at f926ee5)
 + system_path(): always return free'able memory to the caller

 The function sometimes returned a non-freeable memory and some
 other times returned a piece of memory that must be freed.


* jc/hook-cleanup (2014-12-01) 1 commit
  (merged to 'next' on 2014-12-15 at f5759d0)
 + run-command.c: retire unused run_hook_with_custom_index()

 Remove unused code.


* jc/refer-to-t-readme-from-submitting-patches (2014-11-24) 2 commits
  (merged to 'next' on 2014-12-15 at 0e88699)
 + t/README: justify why "! grep foo" is sufficient
 + SubmittingPatches: refer to t/README for tests


* jg/prompt-localize-temporary (2014-12-12) 1 commit
  (merged to 'next' on 2014-12-15 at bb9cac9)
 + git-prompt.sh: make $f local to __git_eread()

 "git-prompt" (in contrib/) used a variable from the global scope,
 possibly contaminating end-user's namespace.


* jk/always-allow-large-packets (2014-12-10) 1 commit
  (merged to 'next' on 2014-12-15 at c3fb2c8)
 + pkt-line: allow writing of LARGE_PACKET_MAX buffers

 "git push" and "git fetch" did not communicate an overlong refname
 correctly.


* jk/colors (2014-12-09) 6 commits
  (merged to 'next' on 2014-12-15 at 20b045f)
 + parse_color: drop COLOR_BACKGROUND macro
 + diff-highlight: allow configurable colors
 + parse_color: recognize "no$foo" to clear the $foo attribute
 + parse_color: support 24-bit RGB values
 + parse_color: refactor color storage
 + Merge branch 'jn/parse-config-slot' into jk/colors

 "diff-highlight" filter (in contrib/) allows its color output
 to be customized via configuration variables.


* jk/commit-date-approxidate (2014-12-11) 2 commits
  (merged to 'next' on 2014-12-15 at 047530e)
 + commit: always populate GIT_AUTHOR_* variables
 + commit: loosen ident checks when generating template

 Recent update to "git commit" broke amending an existing commit
 with bogus author/committer lines without a valid e-mail address.


* jk/credential-quit (2014-12-04) 2 commits
  (merged to 'next' on 2014-12-15 at 4cfd999)
 + prompt: respect GIT_TERMINAL_PROMPT to disable terminal prompts
 + credential: let helpers tell us to quit

 Credential helpers are asked in turn until one of them give
 positive response, which is cumbersome to turn off when you need to
 run Git in an automated setting.  The credential helper interface
 learned to allow a helper to say "stop, don't ask other helpers."
 Also GIT_TERMINAL_PROMPT environment can be set to false to disable
 our built-in prompt mechanism for passwords.


* jk/for-each-reflog-ent-reverse (2014-12-05) 2 commits
  (merged to 'next' on 2014-12-15 at de71f08)
 + for_each_reflog_ent_reverse: turn leftover check into assertion
 + for_each_reflog_ent_reverse: fix newlines on block boundaries

 The code that reads the reflog from the newer to the older entries
 did not handle an entry that crosses a boundary of block it uses to
 read them correctly.


* jk/lock-ref-sha1-basic-return-errors (2014-11-20) 1 commit
  (merged to 'next' on 2014-12-15 at c48b110)
 + lock_ref_sha1_basic: do not die on locking errors

 Correct an API anomaly.


* jk/read-packed-refs-without-path-max (2014-12-10) 3 commits
  (merged to 'next' on 2014-12-15 at c6d6f56)
 + read_packed_refs: use skip_prefix instead of static array
 + read_packed_refs: pass strbuf to parse_ref_line
 + read_packed_refs: use a strbuf for reading lines

 Git did not correctly read an overlong refname from a packed refs
 file.


* jk/test-asan (2014-12-11) 1 commit
  (merged to 'next' on 2014-12-15 at d24cb92)
 + t: support clang/gcc AddressSanitizer


* js/fsck-tag-validation (2014-12-09) 2 commits
  (merged to 'next' on 2014-12-15 at 455f26c)
 + index-pack: terminate object buffers with NUL
 + fsck: properly bound "invalid tag name" error message

 New tag object format validation added in 2.2 showed garbage
 after a tagname it reported in its error message.


* js/push-to-deploy (2014-11-30) 2 commits
  (merged to 'next' on 2014-12-15 at ef8c99f)
 + t5516: more tests for receive.denyCurrentBranch=updateInstead
 + receive-pack: add another option for receive.denyCurrentBranch
 (this branch is used by jc/push-to-checkout.)

 "git push" into a repository with a working tree normally refuses
 to modify the branch that is checked out.  The command learned to
 optionally do an equivalent of "git reset --hard" only when there
 is no change to the working tree and the index instead, which would
 be useful to "deploy" by pushing into a repository.


* js/t5000-dont-copy-bin-sh (2014-11-24) 1 commit
  (merged to 'next' on 2014-12-15 at 65ffd05)
 + t5000 on Windows: do not mistake "sh.exe" as "sh"


* js/test-hashmap-squelch-gcc (2014-12-09) 1 commit
  (merged to 'next' on 2014-12-15 at a8da691)
 + test-hashmap: squelch gcc compiler warning


* mg/add-ignore-errors (2014-11-21) 1 commit
  (merged to 'next' on 2014-12-15 at 3834789)
 + add: ignore only ignored files

 "git add --ignore-errors ..." did not ignore an error to
 give a file that did not exist.


* mg/branch-d-m-f (2014-12-09) 2 commits
  (merged to 'next' on 2014-12-15 at 8366f2c)
 + branch: allow -f with -m and -d
 + t3200-branch: test -M

 "git branch -d" (delete) and "git branch -m" (move) learned to
 honor "-f" (force) flag; unlike many other subcommands, the way to
 force these have been with separate "-D/-M" options, which was
 inconsistent.


* mg/doc-check-ignore-tracked-are-not-ignored (2014-12-04) 1 commit
  (merged to 'next' on 2014-12-15 at c50f748)
 + check-ignore: clarify treatment of tracked files


* mh/find-uniq-abbrev (2014-11-26) 1 commit
  (merged to 'next' on 2014-12-15 at e3b2b62)
 + sha1_name: avoid unnecessary sha1 lookup in find_unique_abbrev

 The code to abbreviate an object name to its short unique prefix
 has been optimized when no abbreviation was requested.


* mh/simplify-repack-without-refs (2014-11-25) 7 commits
  (merged to 'next' on 2014-12-15 at 351e03e)
 + sort_string_list(): rename to string_list_sort()
 + prune_remote(): iterate using for_each_string_list_item()
 + prune_remote(): rename local variable
 + repack_without_refs(): make the refnames argument a string_list
 + prune_remote(): sort delete_refs_list references en masse
 + prune_remote(): initialize both delete_refs lists in a single loop
 + prune_remote(): exit early if there are no stale references

 "git remote update --prune" to drop many refs has been optimized.


* nd/ls-tree-pathspec (2014-12-01) 5 commits
  (merged to 'next' on 2014-12-15 at 8da6e09)
 + t3102: style modernization
 + t3102: document that ls-tree does not yet support negated pathspec
 + ls-tree: disable negative pathspec because it's not supported
 + ls-tree: remove path filtering logic in show_tree
 + tree.c: update read_tree_recursive callback to pass strbuf as base

 "git ls-tree" does not support path selection based on negative
 pathspecs, but did not error out when negative pathspecs are given.


* nd/split-index (2014-12-11) 1 commit
  (merged to 'next' on 2014-12-15 at ed6490c)
 + index-format.txt: add a missing closing quote

 A typofix to the documentation of a feature already in the release.


* ok/rebase-i-count-todo (2014-12-10) 1 commit
  (merged to 'next' on 2014-12-15 at 4a1f7ed)
 + Show number of TODO items for interactive rebase


* pb/am-message-id-footer (2014-11-25) 2 commits
  (merged to 'next' on 2014-12-15 at b44b6bd)
 + git-am: add --message-id/--no-message-id
 + git-mailinfo: add --message-id

 "git am" learned "--message-id" option to copy the message ID of
 the incoming e-mail to the log message of resulting commit.


* pb/send-email-te (2014-11-25) 2 commits
  (merged to 'next' on 2014-12-15 at 38c2810)
 + git-send-email: add --transfer-encoding option
 + git-send-email: delay creation of MIME headers
 (this branch is used by jc/t9001-modernise.)

 "git send-email" learned "--transfer-encoding" option to force
 a non-fault Content-Transfer-Encoding header (e.g. base64).


* po/doc-assume-unchanged (2014-12-09) 2 commits
  (merged to 'next' on 2014-12-15 at 646e77e)
 + gitignore.txt: do not suggest assume-unchanged
 + doc: make clear --assume-unchanged's user contract

 Fixes long-standing misunderstanding of what assume-unchanged is
 about.  Some text near what is removed by the bottom patch may also
 have to be removed.


* ps/new-workdir-into-empty-directory (2014-12-03) 1 commit
  (merged to 'next' on 2014-12-15 at 0787b56)
 + git-new-workdir: don't fail if the target directory is empty

 "git new-workdir" (in contrib/) can be used to populate an empty
 and existing directory now.


* rj/no-xopen-source-for-cygwin (2014-11-24) 1 commit
  (merged to 'next' on 2014-12-15 at 6e8e9ff)
 + git-compat-util.h: don't define _XOPEN_SOURCE on cygwin

 Avoid compilation warnings on recent gcc toolchain on Cygwin.


* rj/t0050-passes (2014-11-30) 1 commit
  (merged to 'next' on 2014-12-15 at f56c339)
 + t0050-*.sh: mark the rename (case change) test as passing


* rs/use-strbuf-complete-line (2014-12-12) 1 commit
  (merged to 'next' on 2014-12-15 at d6426a0)
 + use strbuf_complete_line() for adding a newline if needed


* rt/completion-tag (2014-12-04) 1 commit
  (merged to 'next' on 2014-12-15 at b03ee39)
 + completion: add git-tag options


* rt/for-each-ref-spell-tcl-as-Tcl (2014-11-30) 1 commit
  (merged to 'next' on 2014-12-15 at c0fcefb)
 + for-each-ref: correct spelling of Tcl in option description


* rw/apply-does-not-take-ignore-date (2014-12-09) 1 commit
  (merged to 'next' on 2014-12-15 at ded2f99)
 + git-am.txt: --ignore-date flag is not passed to git-apply


* sb/string-list (2014-12-04) 3 commits
  (merged to 'next' on 2014-12-15 at 8bb8ddd)
 + string_list: remove string_list_insert_at_index() from its API
 + mailmap: use higher level string list functions
 + string_list: document string_list_(insert,lookup)

 API simplification.


* sv/doc-stripspace (2014-12-04) 1 commit
  (merged to 'next' on 2014-12-15 at e86f8ba)
 + Documentation/git-stripspace: add synopsis for --comment-lines


* tb/config-core-filemode-check-on-broken-fs (2014-11-21) 1 commit
  (merged to 'next' on 2014-12-15 at 3e5490b)
 + init-db: improve the filemode trustability check

 Some filesystems assign filemodes in a strange way, fooling then
 automatic "filemode trustability" check done during a new
 repository creation.


* tb/t0027-eol-conversion (2014-12-05) 1 commit
  (merged to 'next' on 2014-12-15 at ba24e75)
 + t0027: check the eol conversion warnings

--------------------------------------------------
[New Topics]

* bb/update-unicode-table (2014-12-22) 5 commits
 - update_unicode.sh: delete the command group
 - update_unicode.sh: make the output structure visible
 - update_unicode.sh: shorten uniset invocation path
 - update_unicode.sh: set UNICODE_DIR only once
 - update_unicode.sh: simplify output capture

 Simplify the procedure to generate unicode table.

 Will merge to 'next'.


* bc/fetch-thin-less-aggressive-in-normal-repository (2014-12-22) 3 commits
 - pack-objects: use --objects-edge-aggressive only for shallow repos
 - rev-list: add an option to mark fewer edges as uninteresting
 - Documentation: add missing article in rev-list-options.txt

 Earlier we made "rev-list --object-edge" more aggressively list the
 objects at the edge commits, in order to reduce number of objects
 fetched into a shallow repository, but the change affected cases
 other than "fetching into a shallow repository" and made it
 unusably slow (e.g. fetching into a normal repository should not
 have to suffer the overhead from extra processing).  Limit it to a
 more specific case by introducing --objects-edge-aggressive, a new
 option to rev-list.

 Seems to break t5500 when merged to 'pu'.


* es/squelch-openssl-warnings-on-macosx (2014-12-18) 1 commit
 - git-compat-util: suppress unavoidable Apple-specific deprecation warnings

 Squelch useless compiler warnings on Mac OS X.

 Will merge to 'next'.


* jh/pre-push-sample-no-custom-ifs (2014-12-22) 1 commit
 - pre-push.sample: remove unnecessary and misleading IFS=' '

 The sample pre-push hook used customized IFS=' ' for no good reason.

 Will merge to 'next'.


* mh/update-ref-verify (2014-12-11) 2 commits
 - update-ref: fix "verify" command with missing <oldvalue>
 - t1400: add some more tests of "update-ref --stdin"'s verify command

 "git update-ref --stdin"'s verify command did not work well when
 <oldvalue>, which is documented as optional, was missing.

 Will merge to 'next'.


* sb/atomic-push (2014-12-22) 7 commits
 - t5543-atomic-push.sh: add basic tests for atomic pushes
 - push.c: add an --atomic argument
 - receive-pack: move execute_commands_non_atomic before execute_commands
 - receive-pack.c: receive-pack.c: use a single ref_transaction for atomic pushes
 - send-pack.c: add --atomic command line argument
 - send-pack: rename ref_update_to_be_sent to check_to_send_update
 - receive-pack.c: add protocol support to negotiate atomic-push
 (this branch uses mh/reflog-expire.)

 "git push" has been taught a "--atomic" option that makes push to
 update more than one ref an "all-or-none" affair.

 Will merge to 'next'.


* sb/dco-indentation-fix (2014-12-22) 1 commit
 - Documentation/SubmittingPatches: unify whitespace/tabs for the DCO

 Will merge to 'next'.


* sb/t5400-remove-unused (2014-12-16) 1 commit
 - t5400: remove dead code

 Will merge to 'next'.


* tf/prompt-preserve-exit-status (2014-12-22) 1 commit
 - git-prompt: preserve value of $? inside shell prompt

 Using the exit status of the last command in the prompt, e.g.
 PS1='$(__git_ps1) $? ', did not work well because the helper
 function stomped on the exit status.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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


* jc/push-cert-hmac-optim (2014-09-25) 2 commits
 - receive-pack: truncate hmac early and convert only necessary bytes
 - sha1_to_hex: split out "hex-format n bytes" helper and use it

 This is "we could do this if we wanted to", not "we measured and it
 improves performance critical codepath".

 Will perhaps drop.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Nobody seems to be jumping up & down requesting this last step,
 which makes the result somewhat backward incompatible.
 Will perhaps drop.


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

* ye/http-accept-language (2014-12-22) 1 commit
 - http: Add Accept-Language header if possible

 An earlier iteration broke various people ($gmane/260903).  Please
 retest and comment.


* jk/strbuf-doc-to-header (2014-12-12) 4 commits
 - strbuf.h: reorganize api function grouping headers
 - strbuf.h: format asciidoc code blocks as 4-space indent
 - strbuf.h: drop asciidoc list formatting from API docs
 - strbuf: migrate api-strbuf.txt documentation to strbuf.h

 Resolve the "doc vs header" to favor the latter.

 Expecting to be rerolled.


* mh/reflog-expire (2014-12-22) 24 commits
 - refs.c: let fprintf handle the formatting
 - refs.c: don't expose the internal struct ref_lock in the header file
 - lock_any_ref_for_update(): inline function
 - refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
 - reflog_expire(): new function in the reference API
 - expire_reflog(): treat the policy callback data as opaque
 - Move newlog and last_kept_sha1 to "struct expire_reflog_cb"
 - expire_reflog(): move rewrite to flags argument
 - expire_reflog(): move verbose to flags argument
 - expire_reflog(): pass flags through to expire_reflog_ent()
 - struct expire_reflog_cb: a new callback data type
 - Rename expire_reflog_cb to expire_reflog_policy_cb
 - expire_reflog(): move updateref to flags argument
 - expire_reflog(): move dry_run to flags argument
 - expire_reflog(): add a "flags" argument
 - expire_reflog(): extract two policy-related functions
 - Extract function should_expire_reflog_ent()
 - expire_reflog(): use a lock_file for rewriting the reflog file
 - expire_reflog(): return early if the reference has no reflog
 - expire_reflog(): rename "ref" parameter to "refname"
 - expire_reflog(): it's not an each_ref_fn anymore
 - refs.c: add a function to append a reflog entry to a fd
 - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 - refs.c: make ref_transaction_create a wrapper for ref_transaction_update
 (this branch is used by sb/atomic-push.)

 Restructure "reflog expire" to fit the reflogs better with the
 recently updated ref API.

 Looked reasonable (except that some shortlog entries stood out like
 a sore thumb).


* po/doc-core-ignorestat (2014-12-12) 1 commit
 - doc: core.ignoreStat clarify the --assume-unchanged effect

 Expecting a reroll.


* jk/add-i-read-error (2014-12-15) 1 commit
 - add--interactive: leave main loop on read error

 "git add -i" did not notice when the interactive command input
 stream went away and kept asking.

 Will merge to 'next'.


* pd/completion-filenames-fix (2014-12-15) 1 commit
 - Update documentation occurrences of filename .sh

 The top-of-the-file instruction for completion scripts (in contrib/)
 did not name the files correctly.

 Will merge to 'next'.


* rd/send-email-2047-fix (2014-12-15) 2 commits
 - send-email: handle adjacent RFC 2047-encoded words properly
 - send-email: align RFC 2047 decoding more closely with the spec

 "git send-email" did not handle RFC 2047 encoded headers quite
 right.

 Will merge to 'next'.


* jn/doc-api-errors (2014-12-04) 1 commit
 - doc: document error handling functions and conventions

 For discussion.


* jn/rerere-fail-on-auto-update-failure (2014-12-03) 2 commits
 - SQUASH???
 - rerere: error out on autoupdate failure

 Will be rerolled as a part of a larger series.


* jc/push-to-checkout (2014-12-01) 2 commits
 - receive-pack: support push-to-checkout hook
 - receive-pack: refactor updateInstead codepath

 Extending the js/push-to-deploy topic, the behaviour of "git push"
 when updating the working tree and the index with an update to the
 branch that is checked out can be tweaked by push-to-checkout hook.

 Needs docs.


* lh/send-email-hide-x-mailer (2014-12-15) 2 commits
 - test/send-email: --[no-]xmailer tests
 - send-email: add --[no-]xmailer option

 "git send-email" normally identifies itself via X-Mailer: header
 in the message it sends out.  A new command line flag allows the
 header to be squelched.

 Will merge to 'next'.


* nd/list-files (2014-12-01) 19 commits
 - list-files: -M aka diff-cached
 - list-files -F: show submodules with the new indicator '&'
 - list-files: add -F/--classify
 - list-files: show directories as well as files
 - list-files: do not show duplicate cached entries
 - list-files: sort output and remove duplicates
 - list-files: add -t back
 - list-files: add -1 short for --no-column
 - list-files: add -R/--recursive short for --max-depth=-1
 - list-files: -u does not imply showing stages
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


* nd/multiple-work-trees (2014-12-01) 34 commits
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


* sb/copy-fd-errno (2014-11-17) 1 commit
 - copy.c: make copy_fd preserve meaningful errno

 Will be rerolled as a part of a larger series.


* jc/t9001-modernise (2014-11-25) 5 commits
 - t9001: style modernisation phase #5
 - t9001: style modernisation phase #4
 - t9001: style modernisation phase #3
 - t9001: style modernisation phase #2
 - t9001: style modernisation phase #1


* jk/approxidate-avoid-y-d-m-over-future-dates (2014-11-13) 2 commits
  (merged to 'next' on 2014-12-15 at 397e986)
 + approxidate: allow ISO-like dates far in the future
 + pass TIME_DATE_NOW to approxidate future-check

 Traditionally we tried to avoid interpreting date strings given by
 the user as future dates, e.g. GIT_COMMITTER_DATE=2014-12-10 when
 used early November 2014 was taken as "October 12, 2014" because it
 is likely that a date in the future, December 10, is a mistake.

 Loosen this and do not tiebreak by future-ness of the date when

 (1) ISO-like format is used, and
 (2) the string can make sense interpreted as both y-m-d and y-d-m.

 Will cook in 'next'.


* br/imap-send-verbosity (2014-11-05) 1 commit
  (merged to 'next' on 2014-12-15 at 504af0b)
 + imap-send: use parse options API to determine verbosity
 (this branch is used by br/imap-send-via-libcurl.)

 Will cook in 'next'.


* br/imap-send-via-libcurl (2014-11-10) 1 commit
  (merged to 'next' on 2014-12-15 at 90db637)
 + git-imap-send: use libcurl for implementation
 (this branch uses br/imap-send-verbosity.)

 Newer libCurl knows how to talk IMAP; "git imap-send" has been
 updated to use this instead of a hand-rolled OpenSSL calls.

 Will cook in 'next'.


* nd/lockfile-absolute (2014-11-03) 1 commit
  (merged to 'next' on 2014-12-15 at 34db9af)
 + lockfile.c: store absolute path

 The lockfile API can get confused which file to clean up when the
 process moved the $cwd after creating a lockfile.

 Will cook in 'next'.


* jc/merge-bases (2014-10-30) 2 commits
  (merged to 'next' on 2014-12-15 at cac279e)
 + get_merge_bases(): always clean-up object flags
 + bisect: clean flags after checking merge bases

 The get_merge_bases*() API was easy to misuse by careless
 copy&paste coders, leaving object flags tainted in the commits that
 needed to be traversed.

 Will cook in 'next'.


* jc/strbuf-add-lines-avoid-sp-ht-sequence (2014-10-27) 1 commit
  (merged to 'next' on 2014-12-15 at b499889)
 + strbuf_add_commented_lines(): avoid SP-HT sequence in commented lines

 The commented output used to blindly add a SP before the payload
 line, resulting in "# \t<indented text>\n" when the payload began
 with a HT.  Instead, produce "#\t<indented text>\n".

 Will cook in 'next'.


* nd/untracked-cache (2014-12-15) 24 commits
 - SQUASH???
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

 Comments?


* jc/diff-b-m (2014-10-23) 1 commit
  (merged to 'next' on 2014-12-15 at 59c6636)
 + diff -B -M: fix output for "copy and then rewrite" case

 Fix long-standing bug in "diff -B -M" output.

 Will cook in 'next'.


* jc/checkout-local-track-report (2014-10-14) 1 commit
  (merged to 'next' on 2014-12-15 at e91a7df)
 + checkout: report upstream correctly even with loosely defined branch.*.merge

 The report from "git checkout" on a branch that builds on another
 local branch by setting its branch.*.merge to branch name (not a
 full refname) incorrectly said that the upstream is gone.

 Will cook in 'next'.


* jc/clone-borrow (2014-10-15) 1 commit
  (merged to 'next' on 2014-12-15 at 08fdf77)
 + clone: --dissociate option to mark that reference is only temporary

 Allow "git clone --reference" to be used more safely.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* mb/enable-lib-terminal-test-on-newer-darwin (2014-11-14) 1 commit
 . t/lib-terminal: allow TTY tests to run under recent Mac OS

 We probably should drop this ($gmane/259609).


* zk/grep-color-words (2014-10-27) 2 commits
 . Revert "grep: fix match highlighting for combined patterns with context lines"
 . grep: fix match highlighting for combined patterns with context lines

 rs/grep-color-words topic solves it in a different way.

 Will discard.


* jn/dedup-doc-header (2014-12-10) 2 commits
 . put string-list API documentation in one place
 . put strbuf API documentation in one place

 We would want to have an easy way for developers to learn about
 APIs, and also a way to encourage them to keep the API
 documentation up to date when they make changes.  Having header
 comments and API documentation duplicated in two different places
 risked them going out of sync.

 The approach taken by jk/strbuf-doc-to-header is the other way
 around, which people seem to prefer, so this is discarded.


* jt/timer-settime (2014-08-29) 6 commits
 . use timer_settime() for new platforms
 . autoconf: check for timer_settime()
 . autoconf: check for struct itimerspec
 . autoconf: check for struct sigevent
 . autoconf: check for struct timespec
 . autoconf: check for timer_t

 Was wanting for a reroll.


* rs/ref-transaction-reflog (2014-11-03) 15 commits
 . refs.c: allow deleting refs with a broken sha1
 . refs.c: remove lock_any_ref_for_update
 . refs.c: make unlock_ref/close_ref/commit_ref static
 . refs.c: rename log_ref_setup to create_reflog
 . reflog.c: use a reflog transaction when writing during expire
 . refs.c: allow multiple reflog updates during a single transaction
 . refs.c: only write reflog update if msg is non-NULL
 . refs.c: add a flag to allow reflog updates to truncate the log
 . refs.c: add a transaction function to append a reflog entry
 . copy.c: make copy_fd preserve meaningful errno
 . refs.c: add a function to append a reflog entry to a fd
 . refs.c: add a new update_type field to ref_update
 . refs.c: rename the transaction functions
 . refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 . refs.c make ref_transaction_create a wrapper to ref_transaction_update
 (this branch is used by rs/ref-transaction-rename and rs/ref-transaction-send-pack.)

 Stefan Beller started working on reorganizing these three series,
 which unfortunately did not see much reviews.


* rs/ref-transaction-rename (2014-11-07) 16 commits
 . refs.c: add an err argument to pack_refs
 . refs.c: make lock_packed_refs take an err argument
 . refs.c: make add_packed_ref return an error instead of calling die
 . refs.c: replace the onerr argument in update_ref with a strbuf err
 . refs.c: make the *_packed_refs functions static
 . refs.c: make repack_without_refs static
 . remote.c: use a transaction for deleting refs
 . refs.c: write updates to packed refs when a transaction has more than one ref
 . refs.c: move reflog updates into its own function
 . refs.c: rollback the lockfile before we die() in repack_without_refs
 . refs.c: update rename_ref to use a transaction
 . refs.c: add transaction support for renaming a reflog
 . refs.c: use a stringlist for repack_without_refs
 . refs.c: use packed refs when deleting refs during a transaction
 . refs.c: return error instead of dying when locking fails during transaction
 . refs.c: allow passing raw git_committer_info as email to _update_reflog
 (this branch is used by rs/ref-transaction-send-pack; uses rs/ref-transaction-reflog.)

 Stefan Beller started working on reorganizing these three series,
 which unfortunately did not see much reviews.


* rs/ref-transaction-send-pack (2014-11-07) 7 commits
 . refs.c: add an err argument to create_symref
 . refs.c: add an err argument to create_reflog
 . t5543-atomic-push.sh: add basic tests for atomic pushes
 . push.c: add an --atomic-push argument
 . receive-pack.c: use a single transaction when atomic-push is negotiated
 . send-pack.c: add an --atomic-push command line argument
 . receive-pack.c: add protocol support to negotiate atomic-push
 (this branch uses rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 Stefan Beller started working on reorganizing these three series,
 which unfortunately did not see much reviews.


* sb/simplify-repack-without-refs (2014-11-20) 1 commit
 . refs.c: use a string_list for repack_without_refs


* sb/log-ref-write-fd (2014-11-20) 1 commit
 . refs.c: add a function to append a reflog entry to a fd

 Will be rerolled as a part of a larger series.


* sb/ref-transaction-unify-to-update (2014-11-20) 2 commits
 . refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 . refs.c: make ref_transaction_create a wrapper for ref_transaction_update
 (this branch is used by sb/ref-transaction-reflog.)

 Code simplification.

 Will be rerolled as a part of a larger series.

* sb/write-sha1-update-reflog (2014-11-24) 1 commit
 . refs.c: move reflog updates into its own function

 Moves a part of function around to add a helper that still only has
 one caller.  Need to see how this helps in a bigger picture.


* sb/ref-transaction-reflog (2014-12-03) 2 commits
 . refs.c: rename transaction.updates to transaction.ref_updates
 . refs.c: rename the transaction functions
 (this branch uses sb/ref-transaction-unify-to-update.)

 Will be rerolled as a part of a larger series.
