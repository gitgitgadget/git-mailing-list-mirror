From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2015, #03; Wed, 14)
Date: Wed, 14 Oct 2015 15:23:37 -0700
Message-ID: <xmqq7fmp6qdy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 00:23:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmUSZ-000612-9O
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 00:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbbJNWXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 18:23:42 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35020 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbbJNWXj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 18:23:39 -0400
Received: by pacao1 with SMTP id ao1so1397248pac.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=4KZs1O3kDHqhMqchDL+FyZi+ImO4c13HRJF+eR+zSVk=;
        b=MrNARsmQ6jDPlz+ksXeKI+ICrXj9NtB39sJja09RVC9OLzZaExp6JvDJ/nOJwmobO8
         QNU5dqT+bkywQeBrKr1T7mWu3gGtuhh+PhrkDaEgJVx3/4TZJFixmYZ1Zk3lGebNfdue
         Cn2s803AS4G5XDnHO7vQMD+CN8eiKn//o1I0tLsylFiR3ROI+/Y42kqxNRbpwSA40qRU
         SPMA3P3URy4/bzcZfplzZy6EZ2fpsv/1fHXz6d3eu1Js9GpKMNmVbj7s58keRhqP9isw
         DZYo0gBILTtUtzjpZWO6DD0xj5pNj1TNa1Qm5EyYQzxlow7SWsW94K5YmjALBpbLmhRt
         LqnA==
X-Received: by 10.68.174.193 with SMTP id bu1mr6069417pbc.136.1444861418811;
        Wed, 14 Oct 2015 15:23:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id fk8sm11556957pab.33.2015.10.14.15.23.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 15:23:38 -0700 (PDT)
X-master-at: b27dacc1a80d1eca1994e6552d913e42d517f998
X-next-at: 4b8c365398e63642c531f6a096df9da66a27f9fe
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279635>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

With somewhat reduced review bandwidth, I'd expect that the upcoming
cycle would be slower than usual.  At tinyurl.com/gitCal, I
tentatively drew a 14-week schedule for this cycle (I plan to be
offline during weeks #7-#9 myself---hopefully we'll have capable
interim maintainers to take care of the list traffic in the meantime
as in past years).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/asciidoctor-section-heading-markup-fix (2015-09-25) 1 commit
  (merged to 'next' on 2015-10-07 at 8bbff49)
 + Documentation: fix section header mark-up


* jk/notes-dwim-doc (2015-09-22) 1 commit
  (merged to 'next' on 2015-10-07 at c4341d1)
 + notes: correct documentation of DWIMery for notes references
 (this branch is used by mh/notes-allow-reading-treeish.)

 The way how --ref/--notes to specify the notes tree reference are
 DWIMmed was not clearly documented.


* nd/ls-remote-does-not-have-u-option (2015-09-28) 1 commit
  (merged to 'next' on 2015-10-07 at 0790a76)
 + ls-remote.txt: delete unsupported option


* pt/pull-builtin (2015-10-02) 1 commit
  (merged to 'next' on 2015-10-07 at 19af20e)
 + merge: grammofix in please-commit-before-merge message


* tk/typofix-connect-unknown-proto-error (2015-09-25) 1 commit
  (merged to 'next' on 2015-10-07 at cc3430e)
 + connect: fix typo in result string of prot_name()

--------------------------------------------------
[New Topics]

* jc/mailinfo (2015-10-08) 1 commit
 . mailinfo: ignore in-body header that we do not care about

 Some people write arbitrary garbage at the beginning of a piece of
 e-mail (or after -- >8 -- scissors -- >8 -- line) in the commit log
 message and expect them to be discarded, even though "From:" and
 "Subject:" are the only documented in-body headers that you are
 supposed to have there.  Allow some garbage (specifically, what may
 look like RFC2822 headers like "MIME-Version: ...") to be there and
 ignore them.

 I have a feeling that that this is a step in a wrong direction.
 Excluded from 'pu' for now.


* jk/filter-branch-use-of-sed-on-incomplete-line (2015-10-12) 1 commit
 - filter-branch: remove multi-line headers in msg filter

 A recent "filter-branch --msg-filter" broke skipping of the commit
 object header, which is fixed.

 Will merge to 'next'.


* rd/test-path-utils (2015-10-08) 1 commit
 - test-path-utils.c: remove incorrect assumption

 The normalize_ceiling_entry() function does not muck with the end
 of the path it accepts, and the real world callers do rely on that,
 but a test insisted that the function drops a trailing slash.

 Will merge to 'next'.


* jc/doc-gc-prune-now (2015-10-14) 1 commit
 - Documentation/gc: warn against --prune=<now>

 "git gc" is safe to run anytime only because it has the built-in
 grace period to protect young objects.  In order to run with no
 grace period, the user must make sure that the repository is
 quiescent.

 Will merge to 'next'.


* jc/am-mailinfo-direct (2015-10-14) 1 commit
 - am: make direct call to mailinfo
 (this branch uses jc/mailinfo-lib.)

 "git am" used to spawn "git mailinfo" via run_command() API once
 per each patch, but learned to make a direct call to mailinfo()
 instead.

 Needs benchmark on platforms with slow run_command().


* jc/mailinfo-lib (2015-10-14) 30 commits
 - mailinfo: remove calls to exit() and die() deep in the callchain
 - mailinfo: handle charset conversion errors in the caller
 - mailinfo: libify
 - mailinfo: move definition of MAX_HDR_PARSED to closer to its use
 - mailinfo: move cleanup_space() before its users
 - mailinfo: move check_header() after the helpers it uses
 - mailinfo: move read_one_header_line() closer to its callers
 - mailinfo: move content/content_top to struct mailinfo
 - mailinfo: keep the parsed log message in a strbuf
 - mailinfo: move [ps]_hdr_data to struct mailinfo
 - mailinfo: move cmitmsg and patchfile to struct mailinfo
 - mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
 - mailinfo: move charset to struct mailinfo
 - mailinfo: move transfer_encoding to struct mailinfo
 - mailinfo: move metainfo_charset to struct mailinfo
 - mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
 - mailinfo: move add_message_id and message_id to struct mailinfo
 - mailinfo: move patch_lines to struct mailinfo
 - mailinfo: move filter/header stage to struct mailinfo
 - mailinfo: move global "FILE *fin, *fout" to struct mailinfo
 - mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
 - mailinfo: introduce "struct mailinfo" to hold globals
 - mailinfo: move global "line" into mailinfo() function
 - mailinfo: always pass "line" as an argument
 - mailinfo: get rid of function-local static states
 - mailinfo: move handle_boundary() lower
 - mailinfo: fold decode_header_bq() into decode_header()
 - mailinfo: explicitly close file handle to the patch output
 - mailinfo: fix for off-by-one error in boundary stack
 - mailinfo: remove a no-op call convert_to_utf8(it, "")
 (this branch is used by jc/am-mailinfo-direct.)

 The implementation of "git mailinfo" was refactored so that a
 mailinfo() function can be directly called from inside a process.


* jc/am-3-fallback-regression-fix (2015-10-09) 1 commit
 - am -3: do not let failed merge from completing the error codepath
 (this branch is used by js/am-3-merge-recursive-direct.)

 "git am -3" had a small regression where it is aborted in its error
 handling codepath when underlying merge-recursive failed in certain
 ways, as it assumed that the internal call to merge-recursive will
 never die, which is not the case (yet).


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag
 (this branch uses jc/am-3-fallback-regression-fix.)

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.


* km/cache-entry-refcnt (2015-10-12) 1 commit
 - merge: fix cache_entry use-after-free

 Sometimes we discarded a cache-entry that is still referenced from
 name-hash (used only to hold the pathname there), leading to use
 after free errors.  Reference-count cache entries to work it
 around.


* ls/p4-test-updates (2015-10-12) 2 commits
 - git-p4: skip t9819 test case on case insensitive file systems
 - git-p4: avoid "stat" command in t9815 git-p4-submit-fail

 A few test scripts around "git p4" have been improved for
 portability.

 Will merge to 'next'.


* sb/submodule-config-parse (2015-10-12) 1 commit
 - submodule-config: "goto" removal in parse_config()

 Will merge to 'next'.


* tb/t0027-crlf (2015-10-12) 1 commit
 - t0027: improve test for not-normalized files

 The test for various line-ending conversions has been enhanced.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* dk/gc-idx-wo-pack (2015-08-17) 3 commits
 - DONTMERGE: log message, grace-period and tests $gmane/276058
 - gc: remove stale .idx files without corresponding .pack file
 - prepare_packed_git(): refactor garbage reporting in pack directory

 Having a leftover .idx file without correspoinding .pack file in
 the repository hurts performance; "git gc" learned to prune them.

 Waiting for a reroll.


* nd/ita-cleanup (2015-09-06) 6 commits
 - grep: make it clear i-t-a entries are ignored
 - checkout(-index): do not checkout i-t-a entries
 - apply: make sure check_preimage() does not leave empty file on error
 - apply: fix adding new files on i-t-a entries
 - add and use a convenience macro ce_intent_to_add()
 - blame: remove obsolete comment

 Paths that have been told the index about with "add -N" are not yet
 in the index, but various commands behaved as if they already are.

 Some commits need better explanation.

 Waiting for a reroll.


* ld/p4-detached-head (2015-09-09) 2 commits
 - git-p4: work with a detached head
 - git-p4: add failing test for submit from detached head

 Will be rerolled.
 ($gmane/277574)


* mr/worktree-list (2015-10-08) 5 commits
 - worktree: add 'list' command
 - worktree: add details to the worktree struct
 - worktree: add a function to get worktree details
 - worktree: refactor find_linked_symref function
 - worktree: add top-level worktree.c

 Add the "list" subcommand to "git worktree".


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Becoming tired of waiting for a reroll.
 ($gmane/271213).


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Reroll exists but didn't pick it up as it seemed to be still
 collecting review comments.

 Becoming tired of waiting for a reroll.
 ($gmane/272180).


* mh/notes-allow-reading-treeish (2015-10-08) 3 commits
 - notes: allow treeish expressions as notes ref
 + Merge branch 'jk/notes-dwim-doc' into next
 + Merge branch 'jc/merge-drop-old-syntax' into next
 (this branch uses jc/merge-drop-old-syntax.)

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).


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

--------------------------------------------------
[Cooking]

* cc/quote-comments (2015-10-07) 2 commits
  (merged to 'next' on 2015-10-09 at fc8a359)
 + quote: move comment before sq_quote_buf()
 + quote: fix broken sq_quote_buf() related comment

 A no-op code-health maintenance.

 Will merge to 'master'.


* dt/log-follow-config (2015-10-07) 1 commit
  (merged to 'next' on 2015-10-09 at 64a30d2)
 + log: Update log.follow doc and add to config.txt

 Description of the "log.follow" configuration variable in "git log"
 documentation is now also copied to "git config" documentation.

 Will merge to 'master'.


* es/worktree-add-cleanup (2015-10-07) 1 commit
  (merged to 'next' on 2015-10-09 at 6ffd721)
 + t2026: rename worktree prune test

 A no-op code-health maintenance.

 Will merge to 'master'.


* sg/pretty-more-date-mode-format (2015-10-07) 1 commit
 - pretty: add format specifiers for short and raw date formats

 Introduce "%as" and "%aR" placeholders for "log --format" to show
 the author date in the short and raw formats.

 I have a feeling that that this is a step in a wrong direction.


* tk/doc-interpret-trailers-grammo (2015-10-07) 1 commit
  (merged to 'next' on 2015-10-09 at 37888a2)
 + Documentation/interpret-trailers: Grammar fix

 Will merge to 'master'.


* dt/refs-backend-lmdb (2015-10-12) 45 commits
 - refs: tests for db backend
 - refs: add LMDB refs backend
 - introduce "extensions" form of core.repositoryformatversion
 - refs: add register_refs_backend
 - refs: allow ref backend to be set for clone
 - refs: always handle non-normal refs in files backend
 - refs: move duplicate check to common code
 - refs: break out a ref conflict check
 - refs: make files_log_ref_write functions public
 - refs: make lock generic
 - refs-be-files.c: add method to rename refs
 - refs.c: add method for initializing refs db
 - initdb: move safe_create_dir into common code
 - refs.c: add method for initial ref transaction commit
 - refs.c: add methods for reflog
 - refs.c: add ref backend init function
 - refs.c: move should_autocreate_reflog to common code
 - refs.c: move peel_object to the common code
 - refs.c: move copy_msg to the common code
 - refs.h: document make refname_is_safe and add it to header
 - refs.c: move refname_is_safe to the common code
 - refs-be-files.c: add do_for_each_per_worktree_ref
 - refs-be-files.c: add method for for_each_reftype_...
 - refs-be-files.c: add methods for the ref iterators
 - refs-be-files.c: add methods for misc ref operations
 - refs: add a backend method structure with transaction functions
 - refs: move transaction functions into common code
 - refs.c: move head_ref_namespaced to the common code
 - refs.c: move ref iterators to the common code
 - refs.c: move prettify_refname to the common code
 - refs.c: move is_branch to the common code
 - refs.c: move check_refname_format to the common code
 - refs.c: move resolve_refdup to common
 - refs.c: move read_ref, read_ref_full and ref_exists to the common code
 - refs.c: move warn_if_dangling_symref* to the common code
 - refs.c: move dwim and friend functions to the common refs code
 - refs.c: move the hidden refs functions to the common code
 - refs.c: move read_ref_at to the common refs file
 - refs.c: move delete_ref and delete_refs to the common code
 - refs.c: move update_ref to refs.c
 - refs.c: add a new refs.c file to hold all common refs code
 - refs-be-files.c: rename refs to refs-be-files
 - refs: make repack_without_refs and is_branch public
 - refs.c: create a public version of verify_refname_available
 - Merge branch 'jk/war-on-sprintf' into HEAD
 (this branch uses jk/war-on-sprintf.)

 Pluggable ref backend.

 Expecting a reroll (as two parts series).


* gr/rebase-i-drop-warn (2015-10-05) 2 commits
  (merged to 'next' on 2015-10-09 at 0626b96)
 + rebase-i: loosen over-eager check_bad_cmd check
 + rebase-i: explicitly accept tab as separator in commands

 "git rebase -i" had a minor regression recently, which stopped
 considering a line that begins with an indented '#' in its insn
 sheet not a comment, which is now fixed.

 Will merge to 'master'.


* kn/for-each-branch-remainder (2015-10-02) 9 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: adopt get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: add support for %(path) atom
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: implement %(if), %(then), and %(else) atoms
 (this branch uses kn/for-each-branch.)

 More unification among "branch -l", "tag -l" and "for-each-ref --format".

 Expecting a reroll.
 ($gmane/278926)


* jk/war-on-sprintf (2015-10-05) 70 commits
 - name-rev: use strip_suffix to avoid magic numbers
 - use strbuf_complete to conditionally append slash
 - fsck: use for_each_loose_file_in_objdir
 - Makefile: drop D_INO_IN_DIRENT build knob
 - fsck: drop inode-sorting code
 - convert strncpy to memcpy
 - notes: document length of fanout path with a constant
 - color: add color_set helper for copying raw colors
 - prefer memcpy to strcpy
 - help: clean up kfmclient munging
 - receive-pack: simplify keep_arg computation
 - avoid sprintf and strcpy with flex arrays
 - use alloc_ref rather than hand-allocating "struct ref"
 - color: add overflow checks for parsing colors
 - drop strcpy in favor of raw sha1_to_hex
 - use sha1_to_hex_r() instead of strcpy
 - daemon: use cld->env_array when re-spawning
 - stat_tracking_info: convert to argv_array
 - http-push: use an argv_array for setup_revisions
 - fetch-pack: use argv_array for index-pack / unpack-objects
 - diagnose_invalid_index_path: use strbuf to avoid strcpy/strcat
 - write_loose_object: convert to strbuf
 - remove_leading_path: use a strbuf for internal storage
 - enter_repo: convert fixed-size buffers to strbufs
 - merge-recursive: convert malloc / strcpy to strbuf
 - transport: use strbufs for status table "quickref" strings
 - apply: convert root string to strbuf
 - init: use strbufs to store paths
 - probe_utf8_pathname_composition: use internal strbuf
 - precompose_utf8: drop unused variable
 - sha1_get_pack_name: use a strbuf
 - http-walker: store url in a strbuf
 - http-push: use strbuf instead of fwrite_buffer
 - remote-ext: simplify git pkt-line generation
 - upload-archive: convert sprintf to strbuf
 - resolve_ref: use strbufs for internal buffers
 - read_remotes_file: simplify string handling
 - read_branches_file: simplify string handling
 - mailmap: replace strcpy with xstrdup
 - help: drop prepend function in favor of xstrfmt
 - ref-filter: drop sprintf and strcpy calls
 - use strip_suffix and xstrfmt to replace suffix
 - fetch: replace static buffer with xstrfmt
 - config: use xstrfmt in normalize_value
 - replace trivial malloc + sprintf / strcpy calls with xstrfmt
 - receive-pack: convert strncpy to xsnprintf
 - http-push: replace strcat with xsnprintf
 - add_packed_git: convert strcpy into xsnprintf
 - entry.c: convert strcpy to xsnprintf
 - grep: use xsnprintf to format failure message
 - compat/hstrerror: convert sprintf to snprintf
 - stop_progress_msg: convert sprintf to xsnprintf
 - find_short_object_filename: convert sprintf to xsnprintf
 - use xsnprintf for generating git object headers
 - archive-tar: use xsnprintf for trivial formatting
 - convert trivial sprintf / strcpy calls to xsnprintf
 - compat/inet_ntop: fix off-by-one in inet_ntop4
 - test-dump-cache-tree: avoid overflow of cache-tree name
 - progress: store throughput display in a strbuf
 - trace: use strbuf for quote_crnl output
 - mailsplit: make PATH_MAX buffers dynamic
 - fsck: use strbuf to generate alternate directories
 - add reentrant variants of sha1_to_hex and find_unique_abbrev
 - strbuf: make strbuf_complete_line more generic
 - add git_path_buf helper function
 - add xsnprintf helper function
 - fsck: don't fsck alternates for connectivity-only check
 - archive-tar: fix minor indentation violation
 - mailsplit: fix FILE* leak in split_maildir
 - show-branch: avoid segfault with --reflog of unborn branch
 (this branch is used by dt/refs-backend-lmdb.)

 Many allocations that is manually counted (correctly) that are
 followed by strcpy/sprintf have been replaced with a less error
 prone constructs such as xstrfmt.

 Macintosh-specific breakage was noticed and corrected in this
 reroll.

 Will wait for a week or so before merging to 'next'.


* rp/link-curl-before-ssl (2015-09-25) 3 commits
 - configure: make curl-config path configurable
 - configure.ac: detect ssl need with libcurl
 - Makefile: link libcurl before openssl and crypto

 Rerolls exist, but are still being discussed.


* sb/http-flaky-test-fix (2015-09-25) 1 commit
  (merged to 'next' on 2015-10-09 at 9dc37f3)
 + t5561: get rid of racy appending to logfile

 Will merge to 'master'.


* sb/perf-without-installed-git (2015-09-25) 1 commit
  (merged to 'next' on 2015-10-09 at 7a1ed05)
 + t/perf: make runner work even if Git is not installed

 Performance-measurement tests did not work without an installed Git.

 Will merge to 'master'.


* js/clone-dissociate (2015-10-07) 4 commits
  (merged to 'next' on 2015-10-09 at ba30393)
 + clone --dissociate: avoid locking pack files
 + sha1_file.c: add a function to release all packs
 + sha1_file: consolidate code to close a pack's file descriptor
 + t5700: demonstrate a Windows file locking issue with `git clone --dissociate`

 "git clone --dissociate" runs a big "git repack" process at the
 end, and it helps to close file descriptors that are open on the
 packs and their idx files before doing so on filesystems that
 cannot remove a file that is still open.

 Will merge to 'master'.


* js/gc-with-stale-symref (2015-10-08) 2 commits
  (merged to 'next' on 2015-10-09 at 8b89576)
 + pack-objects: do not get distracted by broken symrefs
 + gc: demonstrate failure with stale remote HEAD

 "git gc" used to barf when a symbolic ref has gone dangling
 (e.g. the branch that used to be your upstream's default when you
 cloned from it is now gone, and you did "fetch --prune").

 Will merge to 'master'.


* js/icase-wt-detection (2015-09-28) 1 commit
  (merged to 'next' on 2015-10-09 at 78ff500)
 + setup: fix "inside work tree" detection on case-insensitive filesystems

 Will merge to 'master'.


* mm/detach-at-HEAD-reflog (2015-10-02) 2 commits
  (merged to 'next' on 2015-10-09 at 624bc87)
 + status: don't say 'HEAD detached at HEAD'
 + t3203: test 'detached at' after checkout --detach

 After "git checkout --detach", "git status" reported a fairly
 useless "HEAD detached at HEAD", instead of saying at which exact
 commit.

 Will merge to 'master'.


* pt/am-builtin (2015-09-30) 1 commit
  (merged to 'next' on 2015-10-09 at 396def8)
 + am: configure gpg at startup

 When "git am" was rewritten as a built-in, it stopped paying
 attention to user.signingkey.

 Will merge to 'master'.


* sa/send-email-smtp-batch-data-limit (2015-09-30) 1 commit
  (merged to 'next' on 2015-10-09 at c021fdf)
 + git-send-email.perl: Fixed sending of many/huge changes/patches

 When "git send-email" wanted to talk over Net::SMTP::SSL,
 Net::Cmd::datasend() did not like to be fed too many bytes at the
 same time and failed to send messages.  Send the payload one line
 at a time to work around the problem.

 Will merge to 'master'.


* ls/p4-translation-failure (2015-09-22) 2 commits
  (merged to 'next' on 2015-10-09 at b462387)
 + git-p4: handle "Translation of file content failed"
 + git-p4: add test case for "Translation of file content failed" error

 Work around "git p4" failing when the P4 depot records the contents
 in UTF-16 without UTF-16 BOM.

 Will merge to 'master'.


* kn/for-each-branch (2015-09-25) 8 commits
  (merged to 'next' on 2015-10-09 at 45723ce)
 + branch: add '--points-at' option
 + branch.c: use 'ref-filter' APIs
 + branch.c: use 'ref-filter' data structures
 + branch: drop non-commit error reporting
 + branch: move 'current' check down to the presentation layer
 + branch: roll show_detached HEAD into regular ref_list
 + branch: bump get_head_description() to the top
 + branch: refactor width computation
 (this branch is used by kn/for-each-branch-remainder.)

 Update "git branch" that list existing branches, using the
 ref-filter API that is shared with "git tag" and "git
 for-each-ref".

 Will merge to 'master'.


* jc/fsck-dropped-errors (2015-09-23) 1 commit
  (merged to 'next' on 2015-10-09 at 887fcac)
 + fsck: exit with non-zero when problems are found

 There were some classes of errors that "git fsck" diagnosed to its
 standard error that did not cause it to exit with non-zero status.

 Will merge to 'master'.


* nd/gc-auto-background-fix (2015-09-21) 1 commit
  (merged to 'next' on 2015-10-09 at 1f0fc60)
 + gc: save log from daemonized gc --auto and print it next time

 When "git gc --auto" is backgrounded, its diagnosis message is
 lost.  Save it to a file in $GIT_DIR and show it next time the "gc
 --auto" is run.

 Will merge to 'master'.


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

 Undecided.
 ($gmane/278326)


* sb/submodule-parallel-fetch (2015-10-12) 8 commits
 - submodules: allow parallel fetching, add tests and documentation
 - fetch_populated_submodules: use new parallel job processing
 - run-command: add an asynchronous parallel child processor
 - sigchain: add command to pop all common signals
 - strbuf: add strbuf_read_once to read without blocking
 - xread_nonblock: add functionality to read from fds without blocking
 - xread: poll on non blocking fds
 - submodule.c: write "Fetching submodule <foo>" to stderr

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 Will merge to 'next'.


* mk/submodule-gitdir-path (2015-09-14) 2 commits
  (merged to 'next' on 2015-10-09 at cf8768e)
 + path: implement common_dir handling in git_pathdup_submodule()
 + submodule refactor: use strbuf_git_path_submodule() in add_submodule_odb()

 The submodule code has been taught to work better with separate
 work trees created via "git worktree add".

 Will merge to 'master'.


* ls/p4-lfs (2015-10-03) 7 commits
  (merged to 'next' on 2015-10-14 at 4b8c365)
 + git-p4: add Git LFS backend for large file system
 + git-p4: add support for large file systems
 + git-p4: check free space during streaming
 + git-p4: add file streaming progress in verbose mode
 + git-p4: return an empty list if a list config has no values
 + git-p4: add gitConfigInt reader
 + git-p4: add optional type specifier to gitConfig reader

 Teach "git p4" to send large blobs outside the repository by
 talking to Git LFS.

 Will merge to 'master'.


* nd/clone-linked-checkout (2015-09-28) 6 commits
  (merged to 'next' on 2015-10-09 at a93973f)
 + clone: better error when --reference is a linked checkout
 + clone: allow --local from a linked checkout
 + enter_repo: allow .git files in strict mode
 + enter_repo: avoid duplicating logic, use is_git_directory() instead
 + t0002: add test for enter_repo(), non-strict mode
 + path.c: delete an extra space

 It was not possible to use a repository-lookalike created by "git
 worktree add" as a local source of "git clone".

 Will merge to 'master'.


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


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-10-07 at 50fed71)
 + merge: drop 'git merge <message> HEAD <commit>' syntax
 (this branch is used by mh/notes-allow-reading-treeish.)

 Originally merged to 'next' on 2015-05-28

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will keep in 'next' during the 2.7 cycle.

--------------------------------------------------
[Discarded]

* sb/remove-get-pathspec (2015-08-03) 1 commit
 . builtin/mv: remove get_pathspec()

 ($gmane/276104)


* nd/list-files (2015-02-09) 21 commits
 . t3080: tests for git-list-files
 . list-files: -M aka diff-cached
 . list-files -F: show submodules with the new indicator '&'
 . list-files: add -F/--classify
 . list-files: show directories as well as files
 . list-files: do not show duplicate cached entries
 . list-files: sort output and remove duplicates
 . list-files: add -t back
 . list-files: add -1 short for --no-column
 . list-files: add -R/--recursive short for --max-depth=-1
 . list-files: -u does not imply showing stages
 . list-files: make alias 'ls' default to 'list-files'
 . list-files: a user friendly version of ls-files and more
 . ls-files: support --max-depth
 . ls-files: add --column
 . ls-files: add --color to highlight file names
 . ls-files: buffer full item in strbuf before printing
 . ls_colors.c: highlight submodules like directories
 . ls_colors.c: add a function to color a file name
 . ls_colors.c: parse color.ls.* from config file
 . ls_colors.c: add $LS_COLORS parsing code

 A new "git list-files" Porcelain command, "ls-files" with bells and
 whistles.

 Reroll to base on wt-status work ($gmane/265142) has seen some
 positive discussions.

 ($gmane/265534).


* mh/numparse (2015-03-19) 14 commits
 . diff_opt_parse(): use convert_i() when handling --abbrev=<num>
 . diff_opt_parse(): use convert_i() when handling "-l<num>"
 . opt_arg(): simplify pointer handling
 . opt_arg(): report errors parsing option values
 . opt_arg(): use convert_i() in implementation
 . opt_arg(): val is always non-NULL
 . builtin_diff(): detect errors when parsing --unified argument
 . handle_revision_opt(): use convert_ui() when handling "--abbrev="
 . strtoul_ui(), strtol_i(): remove functions
 . handle_revision_opt(): use convert_i() when handling "-<digit>"
 . handle_revision_opt(): use skip_prefix() in many places
 . write_subdirectory(): use convert_ui() for parsing mode
 . cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
 . numparse: new module for parsing integral numbers

 Many codepaths use unchecked use of strtol() and friends (or even
 worse, atoi()).  Introduce a set of wrappers that try to be more
 careful.

 ($gmane/268058).


* kk/log-merges-config (2015-04-21) 5 commits
 . bash-completion: add support for git-log --merges= and log.merges
 . t4202-log: add tests for --merges=
 . Documentation: add git-log --merges= option and log.merges config. var
 . log: honor log.merges= option
 . revision: add --merges={show|only|hide} option

 "git log" (but not other commands in the "log" family) learned to
 pay attention to the log.merges configuration variable that can be
 set to "show" (the normal behaviour), "only" (hide non-merge
 commits), or "hide" (hide merge commits).  --merges=(show|only|hide)
 can be used to override the setting from the command line.

 The documentation may need to be updated once more ($gmane/267250).


* bw/portability-solaris (2015-07-20) 3 commits
 . tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 . tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 . tests: modify tr expressions so that xpg4/tr handles it on Solaris

 ($gmane/274296)


* jc/clone-bundle (2015-04-30) 1 commit
 . repack: optionally create a clone.bundle

 Still an early WIP.


* mg/index-read-error-messages (2015-06-01) 2 commits
 . messages: uniform error messages for index write
 . show-index: uniform error messages for index read

 The tip was RFC.
 Waiting for a reroll.


* mk/utf8-no-iconv-warn (2015-06-08) 1 commit
 . utf8.c: print warning about disabled iconv

 Warn when a reencoding is requested in a build without iconv
 support, as the end user is likely to get an unexpected result.  I
 think the same level of safety should be added to a build with
 iconv support when the specified encoding is not available, but the
 patch does not go there.

 ($gmane/277424).


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 . remote: add --fetch and --both options to set-url

 Ejected.


* tr/remerge-diff (2014-11-10) 9 commits
 . t4213: avoid "|" in sed regexp
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . merge_diff_mode: fold all merge diff variants into an enum
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 . merge-recursive: -Xindex-only to leave worktree unchanged
 . merge-recursive: internal flag to avoid touching the worktree
 . merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll.
 ($gmane/256591).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 . perf-lib: add test_perf_cleanup target
 . perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.


* jc/show-branch (2014-03-24) 5 commits
 . show-branch: use commit slab to represent bitflags of arbitrary width
 . show-branch.c: remove "all_mask"
 . show-branch.c: abstract out "flags" operation
 . show-branch.c: lift all_mask/all_revs to a global static
 . show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit.
