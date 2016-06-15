From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2015, #06; Mon, 28)
Date: Mon, 28 Dec 2015 15:59:52 -0800
Message-ID: <xmqqziwui0p3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 01:00:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDhhq-00070X-7G
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 01:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbbL1X76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 18:59:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752566AbbL1X7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 18:59:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92475399DA;
	Mon, 28 Dec 2015 18:59:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	3eaL+t9C156rMarRpFitQYNWhc=; b=FO910fB6w7w7svjzpwX9yEhpjnTj4bTHx
	CzpBDd8hLBxJaVXOomTPOoQrRFV3ut+eQBNJIN6cJ6iV6cO7zW04cF3CUVCIjmM1
	u77Z5MQcAI9jvv93hOZJZaMpaA2Ot4YUyLQO9ybWfQ5SJSpsBjUH77gaQg5aQtZg
	DZEjWQLYnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=a2K
	maNkhOcTPDcLJfiJ0q3ul2wMoVDZ+eegZNflAqXzrFxm1sFkg2YVgZ28doK70iIi
	8HycWep4Qdtm/shVH1IoJ3d+Jd2CK6iYIhwZdQUPhmnRfhHKd6DOoZKYIUT0EJPY
	JJUBIkCgPkdkaTVN2pz8FvDrSF7S3Yss7TXn/pJ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8944F399D9;
	Mon, 28 Dec 2015 18:59:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD4D6399D8;
	Mon, 28 Dec 2015 18:59:53 -0500 (EST)
X-master-at: 28274d02c489f4c7e68153056e9061a46f62d7a0
X-next-at: 0ac5344e619fec2068de9ab2afdb99d1af8854be
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 16DBDAD4-ADBF-11E5-8CE9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283056>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

v2.7.0-rc3, hopefully the last release candidate for the upcoming 2.7
release, has been tagged.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

Oh, also, a happy birthday to a few Gits, and a bit early happy new
year to everybody ;-)

--------------------------------------------------
[Graduated to "master"]

* bc/format-patch-null-from-line (2015-12-15) 3 commits
  (merged to 'next' on 2015-12-16 at ff58fc7)
 + format-patch: check that header line has expected format
 + format-patch: add an option to suppress commit hash
 + sha1_file.c: introduce a null_oid constant

 "format-patch" has learned a new option to zero-out the commit
 object name on the mbox "From " line.


* fr/rebase-i-continue-preserve-options (2015-12-11) 1 commit
  (merged to 'next' on 2015-12-15 at e99677a)
 + rebase -i: remember merge options beyond continue actions

 "git rebase -i" started with merge strategy options did not
 propagate them upon "git rebase --continue".


* jk/ident-loosen-getpwuid (2015-12-14) 3 commits
  (merged to 'next' on 2015-12-15 at 0c8137b)
 + ident: loosen getpwuid error in non-strict mode
 + ident: keep a flag for bogus default_email
 + ident: make xgetpwuid_self() a static local helper

 When getpwuid() on the system returned NULL (e.g. the user is not
 in the /etc/passwd file or other uid-to-name mappings), the
 codepath to find who the user is to record it in the reflog barfed
 and died.  Loosen the check in this codepath, which already accepts
 questionable ident string (e.g. host part of the e-mail address is
 obviously bogus), and in general when we operate fmt_ident() function
 in non-strict mode.


* jk/pending-keep-tag-name (2015-12-17) 1 commit
  (merged to 'next' on 2015-12-22 at d00d451)
 + revision.c: propagate tag names from pending array

 History traversal with "git log --source" that starts with an
 annotated tag failed to report the tag as "source", due to an
 old regression in the command line parser back in v2.2 days.


* jk/send-email-ssl-errors (2015-12-11) 1 commit
  (merged to 'next' on 2015-12-15 at 104f448)
 + send-email: enable SSL level 1 debug output

 Improve error reporting when SMTP TLS fails.


* jk/symbolic-ref-maint (2015-12-21) 2 commits
  (merged to 'next' on 2015-12-22 at f0d548e)
 + t1401: test reflog creation for git-symbolic-ref
 + symbolic-ref: propagate error code from create_symref()
 (this branch is used by jk/symbolic-ref.)

 "git symbolic-ref" forgot to report a failure with its exit status.


* js/emu-write-epipe-on-windows (2015-12-21) 1 commit
 + mingw: emulate write(2) that fails with a EPIPE

 The write(2) emulation for Windows learned to set errno to EPIPE
 when necessary.


* mc/push-recurse-submodules-config (2015-12-04) 3 commits
  (merged to 'next' on 2015-12-08 at 1b81967)
 + push: follow the "last one wins" convention for --recurse-submodules
 + push: test that --recurse-submodules on command line overrides config
  (merged to 'next' on 2015-11-24 at 3644d4b)
 + push: add recurseSubmodules config option

 Add new config to avoid typing "--recurse-submodules" on each push.


* sg/completion-no-column (2015-12-11) 1 commit
  (merged to 'next' on 2015-12-15 at 01a2476)
 + completion: remove 'git column' from porcelain commands

 The completion script (in contrib/) used to list "git column"
 (which is not an end-user facing command) as one of the choices


* sh/p4-multi-depot (2015-12-21) 3 commits
  (merged to 'next' on 2015-12-22 at aff269a)
 + git-p4: reduce number of server queries for fetches
 + git-p4: support multiple depot paths in p4 submit
 + git-p4: failing test case for skipping changes with multiple depots

 "git p4" when interacting with multiple depots at the same time
 used to incorrectly drop changes.

--------------------------------------------------
[New Topics]

* ea/blame-progress (2015-12-16) 1 commit
  (merged to 'next' on 2015-12-22 at f8e8643)
 + blame: add support for --[no-]progress option

 "git blame" learned to produce the progress eye-candy when it takes
 too much time before emitting the first line of the result.

 Will merge to 'master'.


* dt/unpack-compare-entry-optim (2015-12-21) 1 commit
 - do_compare_entry: use already-computed path

 Will merge to 'next'.


* jk/pack-revindex (2015-12-21) 2 commits
 - pack-revindex: store entries directly in packed_git
 - pack-revindex: drop hash table

 Will merge to 'next'.


* jk/symbolic-ref (2015-12-28) 2 commits
 - create_symref: use existing ref-lock code
 - create_symref: modernize variable names

 Expecting a reroll.
 ($gmane/283032, $gmane/283031)


* nd/stop-setenv-work-tree (2015-12-22) 1 commit
  (merged to 'next' on 2015-12-22 at 6d7bb0c)
 + Revert "setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR"
 (this branch is used by nd/clear-gitenv-upon-use-of-alias.)

 An earlier change in 2.5.x-era broke users' hooks and aliases by
 exporting GIT_WORK_TREE to point at the root of the working tree,
 interfering when they tried to use a different working tree without
 setting GIT_WORK_TREE environment themselves.

 Will merge to 'master'.


* ep/update-command-substitution-style (2015-12-28) 41 commits
 - t/t5517-push-mirror.sh: use the $( ... ) construct for command substitution
 - t/t5516-fetch-push.sh: use the $( ... ) construct for command substitution
 - t/t5515-fetch-merge-logic.sh: use the $( ... ) construct for command substitution
 - t/t5510-fetch.sh: use the $( ... ) construct for command substitution
 - t/t5506-remote-groups.sh: use the $( ... ) construct for command substitution
 - t/t5505-remote.sh: use the $( ... ) construct for command substitution
 - t/t5500-fetch-pack.sh: use the $( ... ) construct for command substitution
 - t/t5305-include-tag.sh: use the $( ... ) construct for command substitution
 - t/t5304-prune.sh: use the $( ... ) construct for command substitution
 - t/t5303-pack-corruption-resilience.sh: use the $( ... ) construct for command substitution
 - t/t5100: no need to use 'echo' command substitutions for globbing
 - t/t5302-pack-index.sh: use the $( ... ) construct for command substitution
 - t/t5301-sliding-window.sh: use the $( ... ) construct for command substitution
 - t/t5300-pack-object.sh: use the $( ... ) construct for command substitution
 - t/t5100-mailinfo.sh: use the $( ... ) construct for command substitution
 - t/t3700-add.sh: use the $( ... ) construct for command substitution
 - t/t3600-rm.sh: use the $( ... ) construct for command substitution
 - t/t3511-cherry-pick-x.sh: use the $( ... ) construct for command substitution
 - t/t3403-rebase-skip.sh: use the $( ... ) construct for command substitution
 - t/t3210-pack-refs.sh: use the $( ... ) construct for command substitution
 - t/t3101-ls-tree-dirname.sh: use the $( ... ) construct for command substitution
 - t/t3100-ls-tree-restrict.sh: use the $( ... ) construct for command substitution
 - t/t3030-merge-recursive.sh: use the $( ... ) construct for command substitution
 - t/t2102-update-index-symlinks.sh: use the $( ... ) construct for command substitution
 - t/t2025-worktree-add.sh: use the $( ... ) construct for command substitution
 - t/t1700-split-index.sh: use the $( ... ) construct for command substitution
 - t/t1512-rev-parse-disambiguation.sh: use the $( ... ) construct for command substitution
 - t/t1511-rev-parse-caret.sh: use the $( ... ) construct for command substitution
 - t/t1410-reflog.sh: use the $( ... ) construct for command substitution
 - t/t1401-symbolic-ref.sh: use the $( ... ) construct for command substitution
 - t/t1100-commit-tree-options.sh: use the $( ... ) construct for command substitution
 - unimplemented.sh: use the $( ... ) construct for command substitution
 - test-sha1.sh: use the $( ... ) construct for command substitution
 - t/lib-httpd.sh: use the $( ... ) construct for command substitution
 - git-gui/po/glossary/txt-to-pot.sh: use the $( ... ) construct for command substitution
 - contrib/thunderbird-patch-inline/appp.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-revert.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-repack.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-merge.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-fetch.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-commit.sh: use the $( ... ) construct for command substitution

 A shell script style update to change `command substitution` into
 $(command substitution).  Coverts contrib/ and an early half of t/
 directory contents.

 Will merge to 'next'.


* nd/dir-exclude-cleanup (2015-12-28) 1 commit
 - dir.c: clean the entire struct in clear_exclude_list()

 The "exclude_list" structure has the usual "alloc, nr" pair of
 fields to be used by ALLOC_GROW(), but clear_exclude_list() forgot
 to reset 'alloc' to 0 when it cleared 'nr' and discarded the
 managed array.

 Will merge to 'next'.


* ss/user-manual (2015-12-28) 1 commit
 - user-manual: remove temporary branch entry from todo list

 Drop an old "todo" item by deciding that the change it suggests is
 not such a good idea.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* kf/http-proxy-auth-methods (2015-11-04) 3 commits
 . SQUASH???
 . http: use credential API to handle proxy authentication
 . http: allow selection of proxy authentication method

 New http.proxyAuthMethod configuration variable can be used to
 specify what authentication method to use, as a way to work around
 proxies that do not give error response expected by libcurl when
 CURLAUTH_ANY is used.  Also, the codepath for proxy authentication
 has been taught to use credential API to store the authentication
 material in user's keyrings.

 I ejected this from pu for the moment, as it conflicts with the
 pt/http-socks-proxy topic. That is now in master, so it can
 be re-rolled on top.

 Anybody wants to help rerolling this?  Otherwise will discard.


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).
 Will discard.


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Becoming tired of waiting for a reroll.
 ($gmane/271213).
 Anybody wants to help rerolling this?  Otherwise will discard.


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Becoming tired of waiting for a reroll.
 Anybody wants to help rerolling this?  Otherwise will discard.
 ($gmane/272180).


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.
 Will discard.

--------------------------------------------------
[Cooking]

* nd/ita-cleanup (2015-12-28) 3 commits
 - grep: make it clear i-t-a entries are ignored
 - add and use a convenience macro ce_intent_to_add()
 - blame: remove obsolete comment

 Paths that have been told the index about with "add -N" are not
 quite yet in the index, but a few commands behaved as if they
 already are in a harmful way.

 Here are only the obviously correct bits; some other changes were
 in the posted series, but not quite ready to be queued here.

 Will merge to 'next'.


* cc/untracked (2015-12-15) 10 commits
 - dir: do not use untracked cache ident anymore
 - t7063: add tests for core.untrackedCache
 - config: add core.untrackedCache
 - dir: free untracked cache when removing it
 - dir: add remove_untracked_cache()
 - dir: add add_untracked_cache()
 - update-index: move 'uc' var declaration
 - update-index: add untracked cache notifications
 - update-index: add --test-untracked-cache
 - update-index: use enum for untracked cache options

 Update the untracked cache subsystem and change its primary UI from
 "git update-index" to "git config".

 Expecting a reroll.
 $gmane/282955


* ep/make-phoney (2015-12-16) 1 commit
  (merged to 'next' on 2015-12-22 at 27c7593)
 + Makefile: add missing phony target

 A slight update to the Makefile.

 Will merge to 'master'.


* vl/grep-configurable-threads (2015-12-16) 3 commits
  (merged to 'next' on 2015-12-22 at 8954705)
 + grep: add --threads=<num> option and grep.threads configuration
 + grep: slight refactoring to the code that disables threading
 + grep: allow threading even on a single-core machine

 "git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

 Will merge to 'master'.


* ps/push-delete-option (2015-12-16) 2 commits
  (merged to 'next' on 2015-12-22 at d83cc1d)
 + push: add '-d' as shorthand for '--delete'
 + push: add '--delete' flag to synopsis

 "branch --delete" has "branch -d" but "push --delete" does not.

 Will merge to 'master'.


* dt/refs-backend-lmdb (2015-12-04) 16 commits
 - refs: tests for lmdb backend
 - refs: add LMDB refs backend
 - refs: allow ref backend to be set for clone
 - init: allow alternate backends to be set for new repos
 - refs: always handle non-normal refs in files backend
 - refs: move duplicate check to common code
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs backend and db
 - refs: add method for delete_refs
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add do_for_each_per_worktree_ref
 - refs: add methods for the ref iterators
 - refs: add methods for misc ref operations
 - refs: add a backend method structure with transaction functions

 Building on top of a few refs-backend preparatory series, LMDB
 based refs backend has been plugged into the system.

 Waiting for review.


* dw/subtree-split-do-not-drop-merge (2015-12-10) 1 commit
 - contrib/subtree: fix "subtree split" skipped-merge bug

 The "split" subcommand of "git subtree" (in contrib/) incorrectly
 skipped merges when it shouldn't, which was corrected.

 Waiting for review from 'subtree' folks.


* nd/clear-gitenv-upon-use-of-alias (2015-12-22) 4 commits
 - git.c: make sure we do not leak GIT_* to alias scripts
 - setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..
 - git.c: make it clear save_env() is for alias handling only
 - Merge branch 'nd/stop-setenv-work-tree' into nd/clear-gitenv-upon-use-of-alias
 (this branch uses nd/stop-setenv-work-tree.)

 d95138e6 (setup: set env $GIT_WORK_TREE when work tree is set, like
 $GIT_DIR, 2015-06-26) attempted to work around a glitch in alias
 handling by overwriting GIT_WORK_TREE environment variable to
 affect subprocesses when set_git_work_tree() gets called, which
 resulted in a rather unpleasant regression to "clone" and "init".
 Try to address the same issue by always restoring the environment
 and respawning the real underlying command when handling alias.

 Will merge to 'next'.


* kn/ref-filter-atom-parsing (2015-12-11) 10 commits
 - ref-filter: introduce objectname_atom_parser()
 - ref-filter: introduce contents_atom_parser()
 - ref-filter: introduce remote_ref_atom_parser()
 - ref-filter: introduce align_atom_parser()
 - strbuf: introduce strbuf_split_str_without_term()
 - ref-filter: introduce color_atom_parser()
 - ref-filter: skip deref specifier in match_atom_name()
 - ref-filter: bump match_atom() name to the top
 - ref-filter: introduce struct used_atom
 - ref-filter: introduce a parsing function for each atom in valid_atom

 Refactoring of ref-filter's format-parsing code, in preparation
 for "branch --format" and friends.

 This replaces (for now) kn/for-each-ref-remainder, which will be built
 on top.

 Reviewed mostly by Eric.

 Waiting for a reroll.
 ($gmane/281180).


* bb/merge-marker-crlf (2015-11-24) 1 commit
 - merge-file: consider core.crlf when writing merge markers

 Write out merge markers using system end-of-line convention.

 Waiting for a re-roll to handle gitattributes.
 ($gmane/281701)


* dk/gc-more-wo-pack (2015-11-24) 3 commits
 - gc: Clean garbage .bitmap files from pack dir
 - t5304: Add test for .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for review.


* ps/rebase-keep-empty (2015-11-24) 2 commits
 - rebase: fix preserving commits with --keep-empty
 - rebase: test broken behavior with --keep-empty

 Keep duplicate commits via rebase --keep-empty.

 Of dubious or negative value.
 Will discard.
 ($gmane/282107).


* rm/subtree-unwrap-tags (2015-11-24) 1 commit
 - contrib/subtree: unwrap tag refs

 Waiting for review from subtree folks.


* sg/sh-require-clean-orphan (2015-11-24) 2 commits
 - sh-setup: make require_clean_work_tree() work on orphan branches
 - Add tests for git-sh-setup's require_clean_work_tree()

 Allow users of git-sh-setup to handle orphan branch state.

 This series takes the conservative route of requiring scripts to opt
 into the looser behavior, at the expense of carrying around a new
 option-flag forever. I'm not sure if we need to do so.

 Needs review.


* tb/ls-files-eol (2015-12-16) 1 commit
 - ls-files: Add eol diagnostics

 Add options to ls-files to help diagnose end-of-line problems.

 Expecting a reroll.
 ($gmane/282537)


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* sb/submodule-parallel-fetch (2015-12-16) 7 commits
  (merged to 'next' on 2015-12-22 at 44e84ff)
 + submodules: allow parallel fetching, add tests and documentation
 + fetch_populated_submodules: use new parallel job processing
 + run-command: add an asynchronous parallel child processor
 + sigchain: add command to pop all common signals
 + strbuf: add strbuf_read_once to read without blocking
 + xread: poll on non blocking fds
 + submodule.c: write "Fetching submodule <foo>" to stderr
 (this branch is used by sb/submodule-parallel-update.)

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 Rerolled and this seems to be a lot cleaner.  The merge of the
 earlier one to 'next' has been reverted.

 Will merge to 'master'.


* sb/submodule-parallel-update (2015-12-16) 8 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - fetching submodules: respect `submodule.fetchJobs` config option
 - submodule-config: introduce parse_generic_submodule_config
 - submodule-config: remove name_and_item_from_var
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around
 (this branch uses sb/submodule-parallel-fetch.)

 Builds on top of the "fetch --recurse-submodules" work to introduce
 parallel downloading into multiple submodules for "submodule update".

 Needs review.


* jc/strbuf-gets (2015-12-16) 17 commits
 - test-sha1-array: read command stream with strbuf_getline_crlf()
 - grep: read -f file with strbuf_getline_crlf()
 - send-pack: read list of refs with strbuf_getline_crlf()
 - column: read lines with strbuf_getline_crlf()
 - cat-file: read batch stream with strbuf_getline_crlf()
 - transport-helper: read helper response with strbuf_getline_crlf()
 - clone/sha1_file: read info/alternates with strbuf_getline_crlf()
 - remote.c: read $GIT_DIR/remotes/* with strbuf_getline_crlf()
 - ident.c: read /etc/mailname with strbuf_getline_crlf()
 - rev-parse: read parseopt spec with strbuf_getline_crlf()
 - revision: read --stdin with strbuf_getline_crlf()
 - hash-object: read --stdin-paths with strbuf_getline_crlf()
 - mktree: read textual tree representation with strbuf_getline_crlf()
 - update-index: read list of paths with strbuf_getline_crlf() under --stdin
 - update-index: read --index-info with strbuf_getline_crlf()
 - check-attr, check-ignore, checkout-index: read paths with strbuf_getline_crlf()
 - strbuf: make strbuf_getline_crlf() global

 Teach codepaths that communicate with users by reading text files
 to be more lenient to editors that write CRLF-terminated lines.
 Note that this is only about communication with Git, like feeding
 list of object names from the standard input instead of from the
 command line, and does not involve files in the working tree.

 Rerolled.
 Needs review.


* mh/notes-allow-reading-treeish (2015-10-08) 3 commits
  (merged to 'next' on 2015-10-23 at 8a697f0)
 + notes: allow treeish expressions as notes ref
 + Merge branch 'jk/notes-dwim-doc' into next
 + Merge branch 'jc/merge-drop-old-syntax' into next
 (this branch uses jc/merge-drop-old-syntax.)

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).

 As the patch was done on top of the 'drop old-syntax from merge',
 this has to wait until that other topic can graduate, unfortunately.
 It can be redone in a way that does not depend on that topic after
 this cycle, though.

 Will keep in 'next'.


* jc/mailinfo (2015-10-21) 1 commit
 - mailinfo: ignore in-body header that we do not care about

 Some people write arbitrary garbage at the beginning of a piece of
 e-mail (or after -- >8 -- scissors -- >8 -- line) in the commit log
 message and expect them to be discarded, even though "From:" and
 "Subject:" are the only documented in-body headers that you are
 supposed to have there.  Allow some garbage (specifically, what may
 look like RFC2822 headers like "MIME-Version: ...") to be there and
 ignore them.

 No comments after waiting for a long time.
 Will discard.


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
  (merged to 'next' on 2015-10-23 at dc631e5)
 + am: make a direct call to merge_recursive
 + merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, we would want to see it backed up by numbers.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.

 Will keep in 'next'.


* sg/pretty-more-date-mode-format (2015-10-07) 1 commit
 - pretty: add format specifiers for short and raw date formats

 Introduce "%as" and "%aR" placeholders for "log --format" to show
 the author date in the short and raw formats.

 No comments after waiting for a long time.
 Will discard.


* jk/graph-format-padding (2015-09-14) 1 commit
 - pretty: pass graph width to pretty formatting for use in '%>|(N)'

 Redefine the way '%>|(N)' padding and the "--graph" option
 interacts.  It has been that the available columns to display the
 log message was measured from the edge of the area the graph ended,
 but with this it becomes the beginning of the entire output.

 I have a suspicion that 50% of the users would appreciate this
 change, and the remainder see this break their expectation.  If
 that is the case, we might need to introduce a similar but
 different alignment operator so that this new behaviour is
 available to those who want to use it, without negatively affecting
 existing uses.

 No comments after waiting for a long time.
 Will discard.
 ($gmane/278326)


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2015-09-14) 7 commits
 - rerere: do use multiple variants
 - t4200: rerere a merge with two identical conflicts
 - rerere: allow multiple variants to exist
 - rerere: delay the recording of preimage
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further

 "git rerere" can encounter two or more files with the same conflict
 signature that have to be resolved in different ways, but there was
 no way to record these separate resolutions.

 Needs review.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-10-07 at 50fed71)
 + merge: drop 'git merge <message> HEAD <commit>' syntax
 (this branch is used by mh/notes-allow-reading-treeish.)

 Originally merged to 'next' on 2015-05-28

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.
 ($gmane/282594)

 Will keep in 'next'.

--------------------------------------------------
[Discarded]

* kn/for-each-branch-remainder (2015-10-02) 9 commits
 . branch: implement '--format' option
 . branch: use ref-filter printing APIs
 . ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 . ref-filter: introduce format_ref_array_item()
 . ref-filter: adopt get_head_description() from branch.c
 . ref-filter: modify "%(objectname:short)" to take length
 . ref-filter: add support for %(path) atom
 . ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 . ref-filter: implement %(if), %(then), and %(else) atoms

 More unification among "branch -l", "tag -l" and "for-each-ref --format".

 Ejected from pu for now, as a re-roll should come on top of
 kn/ref-filter-atom-parsing.

 Expecting a reroll.
 ($gmane/278926)
