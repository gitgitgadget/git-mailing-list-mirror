From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2015, #05; Thu, 22)
Date: Thu, 22 Oct 2015 13:51:31 -0700
Message-ID: <xmqq7fmer5ik.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 22:51:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpMpq-0000FR-5t
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 22:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965608AbbJVUvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 16:51:38 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965019AbbJVUvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 16:51:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 131D2258A5;
	Thu, 22 Oct 2015 16:51:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=f
	WzEfI2hGjJVPrWPdusQmmd3AKM=; b=RcfcRLvHTxLdY3rKYIfyq56T3EKx6b4b1
	uQNPmkONT1R16aXi4ZadwmrcRSxzYYtEFmn6eGeml5eRKTtf9tIplDCPT9SskN++
	Wd/ACa9h68xMOABlmquppx719YfvnybwF96XRD9YQQK2D/TYyerUixXK/9o4Zf4X
	J83GKtMTAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=AVw
	THrz70wAbvgKdL6nsw+qGdIK3eGHAQFTzKTH3KztBs8hIf8Uwfpr6Alvce/hiO1N
	3mm2bQ4Ivms8Bas3mmOJLOKaSeaLgr8u5Ssc5m8+AH9PkzhyTPnalbrc2TU8WbCQ
	qXVx9tRLOQex8C/HsPvrhgfyvGnPiMRh06GWpFqI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09DE8258A4;
	Thu, 22 Oct 2015 16:51:34 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B1EB258A3;
	Thu, 22 Oct 2015 16:51:33 -0400 (EDT)
X-master-at: 74301d6edeb0e081a4ef864057952b6a7ff2b4be
X-next-at: b049f0a3b4560d97ac87735f8c2e9b4d5c69fd44
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD943FC0-78FE-11E5-B0CF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280077>

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

* jk/war-on-sprintf (2015-10-05) 70 commits
  (merged to 'next' on 2015-10-15 at 27a1ae5)
 + name-rev: use strip_suffix to avoid magic numbers
 + use strbuf_complete to conditionally append slash
 + fsck: use for_each_loose_file_in_objdir
 + Makefile: drop D_INO_IN_DIRENT build knob
 + fsck: drop inode-sorting code
 + convert strncpy to memcpy
 + notes: document length of fanout path with a constant
 + color: add color_set helper for copying raw colors
 + prefer memcpy to strcpy
 + help: clean up kfmclient munging
 + receive-pack: simplify keep_arg computation
 + avoid sprintf and strcpy with flex arrays
 + use alloc_ref rather than hand-allocating "struct ref"
 + color: add overflow checks for parsing colors
 + drop strcpy in favor of raw sha1_to_hex
 + use sha1_to_hex_r() instead of strcpy
 + daemon: use cld->env_array when re-spawning
 + stat_tracking_info: convert to argv_array
 + http-push: use an argv_array for setup_revisions
 + fetch-pack: use argv_array for index-pack / unpack-objects
 + diagnose_invalid_index_path: use strbuf to avoid strcpy/strcat
 + write_loose_object: convert to strbuf
 + remove_leading_path: use a strbuf for internal storage
 + enter_repo: convert fixed-size buffers to strbufs
 + merge-recursive: convert malloc / strcpy to strbuf
 + transport: use strbufs for status table "quickref" strings
 + apply: convert root string to strbuf
 + init: use strbufs to store paths
 + probe_utf8_pathname_composition: use internal strbuf
 + precompose_utf8: drop unused variable
 + sha1_get_pack_name: use a strbuf
 + http-walker: store url in a strbuf
 + http-push: use strbuf instead of fwrite_buffer
 + remote-ext: simplify git pkt-line generation
 + upload-archive: convert sprintf to strbuf
 + resolve_ref: use strbufs for internal buffers
 + read_remotes_file: simplify string handling
 + read_branches_file: simplify string handling
 + mailmap: replace strcpy with xstrdup
 + help: drop prepend function in favor of xstrfmt
 + ref-filter: drop sprintf and strcpy calls
 + use strip_suffix and xstrfmt to replace suffix
 + fetch: replace static buffer with xstrfmt
 + config: use xstrfmt in normalize_value
 + replace trivial malloc + sprintf / strcpy calls with xstrfmt
 + receive-pack: convert strncpy to xsnprintf
 + http-push: replace strcat with xsnprintf
 + add_packed_git: convert strcpy into xsnprintf
 + entry.c: convert strcpy to xsnprintf
 + grep: use xsnprintf to format failure message
 + compat/hstrerror: convert sprintf to snprintf
 + stop_progress_msg: convert sprintf to xsnprintf
 + find_short_object_filename: convert sprintf to xsnprintf
 + use xsnprintf for generating git object headers
 + archive-tar: use xsnprintf for trivial formatting
 + convert trivial sprintf / strcpy calls to xsnprintf
 + compat/inet_ntop: fix off-by-one in inet_ntop4
 + test-dump-cache-tree: avoid overflow of cache-tree name
 + progress: store throughput display in a strbuf
 + trace: use strbuf for quote_crnl output
 + mailsplit: make PATH_MAX buffers dynamic
 + fsck: use strbuf to generate alternate directories
 + add reentrant variants of sha1_to_hex and find_unique_abbrev
 + strbuf: make strbuf_complete_line more generic
 + add git_path_buf helper function
 + add xsnprintf helper function
 + fsck: don't fsck alternates for connectivity-only check
 + archive-tar: fix minor indentation violation
 + mailsplit: fix FILE* leak in split_maildir
 + show-branch: avoid segfault with --reflog of unborn branch
 (this branch is used by dt/refs-backend-lmdb and dt/refs-backend-pre-vtable.)

 Many allocations that is manually counted (correctly) that are
 followed by strcpy/sprintf have been replaced with a less error
 prone constructs such as xstrfmt.


* ls/p4-test-updates (2015-10-12) 2 commits
  (merged to 'next' on 2015-10-15 at 3c94932)
 + git-p4: skip t9819 test case on case insensitive file systems
 + git-p4: avoid "stat" command in t9815 git-p4-submit-fail

 A few test scripts around "git p4" have been improved for
 portability.


* tb/t0027-crlf (2015-10-12) 1 commit
  (merged to 'next' on 2015-10-15 at 7ab4f31)
 + t0027: improve test for not-normalized files

 The test for various line-ending conversions has been enhanced.

--------------------------------------------------
[New Topics]

* ar/clone-dissociate (2015-10-22) 1 commit
 - clone: allow "--dissociate" without reference

 "git clone --dissociate" used to require that "--reference" was
 used at the same time, but you can create a new repository that
 borrows objects from another without using "--reference", namely
 with "clone --local" from a repository that borrows objects from
 other repositories.

 Will merge to 'next'.


* da/difftool (2015-10-21) 1 commit
 - difftool: gracefully handle symlinks to directories

 The code to reuse checked out files for comparison was too
 aggressive and forgot that symbolic links cannot be reused
 for comparison.

 Smells wrong that this special-cases based on the target of
 symbolic link.


* dt/name-hash-dir-entry-fix (2015-10-21) 1 commit
  (merged to 'next' on 2015-10-22 at 15eb519)
 + name-hash: don't reuse cache_entry in dir_entry

 The name-hash subsystem that is used to cope with case insensitive
 filesystems keeps track of directories and their on-filesystem
 cases for all the paths in the index by holding a pointer to a
 randomly chosen cache entry that is inside the directory (for its
 ce->ce_name component).  This pointer was not updated even when the
 cache entry was removed from the index, leading to use after free.
 This was fixed by recording the path for each directory instead of
 borrowing cache entries and restructuring the API somewhat.

 Will merge to 'master'.


* jc/everyday-markup (2015-10-22) 1 commit
  (merged to 'next' on 2015-10-22 at 0a2702d)
 + Documentation/everyday: match undefline with the text

 AsciiDoc markup fixes.

 Will merge to 'master'.


* jk/repository-extension (2015-06-24) 2 commits
  (merged to 'next' on 2015-10-22 at 116c8ce)
 + introduce "preciousObjects" repository extension
 + introduce "extensions" form of core.repositoryformatversion

 Prepare for Git on-disk repository representation to undergo
 backward incompatible changes by introducing a new repository
 format version "1", with an extension mechanism.

 Will merge to 'master'.


* tk/sigchain-unnecessary-post-tempfile (2015-10-22) 4 commits
  (merged to 'next' on 2015-10-22 at b049f0a)
 + shallow: remove unused #include "sigchain.h"
 + read-cache: remove unused #include "sigchain.h"
 + diff: remove unused #include "sigchain.h"
 + credential-cache--daemon: remove unused #include "sigchain.h"

 Remove no-longer used #include.

 Will merge to 'master'.


* xf/user-manual-markup (2015-10-22) 3 commits
  (merged to 'next' on 2015-10-22 at cd33c83)
 + Documentation: match undefline with the text in old release notes
 + Documentation: match underline with the text
 + Documentation: fix header markup

 AsciiDoc markup fixes.

 Will merge to 'master'.


* jc/em-dash-in-doc (2015-10-22) 1 commit
 - Documentation: AsciiDoc spells em-dash as double-dashes, not triple

 AsciiDoc markup fixes.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* dk/gc-idx-wo-pack (2015-08-17) 3 commits
 - DONTMERGE: log message, grace-period and tests $gmane/276058
 - gc: remove stale .idx files without corresponding .pack file
 - prepare_packed_git(): refactor garbage reporting in pack directory

 Having a leftover .idx file without corresponding .pack file in
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

 Will cook in 'next'.


* dt/refs-backend-pre-vtable (2015-10-15) 26 commits
 - refs: break out ref conflict checks
 - refs: make files_log_ref_write functions public
 - initdb: move safe_create_dir into common code
 - refs.c: move should_autocreate_reflog to common code
 - refs.c: move peel_object to the common code
 - refs.c: move copy_msg to the common code
 - refs.c: move refname_is_safe to the common code
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
 - refs.c: move delete_pseudoref and delete_ref to the common code
 - refs.c: move update_ref to refs.c
 - refs.c: add a new refs.c file to hold all common refs code
 - refs-be-files.c: rename refs to refs-be-files
 - refs: make repack_without_refs and is_branch public
 - refs.c: create a public version of verify_refname_available
 - Merge branch 'jk/war-on-sprintf' into HEAD

 The early part of the pluggable ref backend series, which sifts the
 ref API functions into two bins: the filesystem backend specific
 ones and the generic API functions.  The next step will start
 introducing the framework to dispatch generic calls to specific
 backend implementation(s) and then finally plug a new backend that
 is different from the file backend.

 Expecting a reroll after an review of the remainder.
 ($gmane/279897).


* jc/usage-stdin (2015-10-16) 1 commit
  (merged to 'next' on 2015-10-20 at 937d4aa)
 + usage: do not insist that standard input must come from a file

 The synopsis text and the usage string of subcommands that read
 list of things from the standard input are often shown as if they
 only take input from a file on a filesystem, which was misleading.

 Will merge to 'master'.


* rt/placeholder-in-usage (2015-10-16) 1 commit
  (merged to 'next' on 2015-10-20 at 5189b23)
 + am, credential-cache: add angle brackets to usage string

 A couple of commands still showed "[options]" in their usage string
 to note where options should come on their command line, but we
 spell that "[<options>]" in most places these days.

 Will merge to 'master'.


* tk/stripspace (2015-10-16) 2 commits
  (merged to 'next' on 2015-10-20 at 327a997)
 + stripspace: use parse-options for command-line parsing
 + strbuf: make stripspace() part of strbuf

 The internal stripspace() function has been moved to where it
 logically belongs to, i.e. strbuf API, and the command line parser
 of "git stripspace" has been updated to use the parse_options API.

 Will merge to 'master'.


* dk/p4-import-ctypes (2015-10-20) 1 commit
  (merged to 'next' on 2015-10-22 at 5760144)
 + git-p4: import the ctypes module

 "git-p4" tried to use from ctypes module without first importing
 it.

 Will merge to 'master'.


* dt/t7063-fix-flaky-test (2015-10-19) 1 commit
  (merged to 'next' on 2015-10-20 at 156af72)
 + t7063: fix flaky untracked-cache test

 Will merge to 'master'.


* es/worktree-add (2015-10-18) 1 commit
  (merged to 'next' on 2015-10-20 at ccadb70)
 + worktree: usage: denote <branch> as optional with 'add'

 Will merge to 'master'.


* kn/for-each-tag (2015-10-18) 1 commit
  (merged to 'next' on 2015-10-20 at 7afd374)
 + tag.c: use the correct algorithm for the '--contains' option

 Recent update to "git tag --contains" caused a performance
 regression.

 Will merge to 'master'.


* mr/worktree-list (2015-10-08) 5 commits
  (merged to 'next' on 2015-10-20 at 7cb272d)
 + worktree: add 'list' command
 + worktree: add details to the worktree struct
 + worktree: add a function to get worktree details
 + worktree: refactor find_linked_symref function
 + worktree: add top-level worktree.c

 Add the "list" subcommand to "git worktree".

 Will merge to 'master'.


* jc/mailinfo (2015-10-21) 1 commit
 - mailinfo: ignore in-body header that we do not care about
 (this branch uses jc/am-mailinfo-direct and jc/mailinfo-lib.)

 Some people write arbitrary garbage at the beginning of a piece of
 e-mail (or after -- >8 -- scissors -- >8 -- line) in the commit log
 message and expect them to be discarded, even though "From:" and
 "Subject:" are the only documented in-body headers that you are
 supposed to have there.  Allow some garbage (specifically, what may
 look like RFC2822 headers like "MIME-Version: ...") to be there and
 ignore them.

 I have a feeling that that this is a step in a wrong direction.
 Comments?


* jc/am-mailinfo-direct (2015-10-21) 1 commit
  (merged to 'next' on 2015-10-22 at ca15014)
 + am: make direct call to mailinfo
 (this branch is used by jc/mailinfo; uses jc/mailinfo-lib.)

 "git am" used to spawn "git mailinfo" via run_command() API once
 per each patch, but learned to make a direct call to mailinfo()
 instead.

 Will merge to 'master'.


* jc/mailinfo-lib (2015-10-21) 34 commits
  (merged to 'next' on 2015-10-22 at 405bd66)
 + mailinfo: remove calls to exit() and die() deep in the callchain
 + mailinfo: handle charset conversion errors in the caller
 + mailinfo: libify
 + mailinfo: keep the parsed log message in a strbuf
 + mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
 + mailinfo: move content/content_top to struct mailinfo
 + mailinfo: move [ps]_hdr_data to struct mailinfo
 + mailinfo: move cmitmsg and patchfile to struct mailinfo
 + mailinfo: move charset to struct mailinfo
 + mailinfo: move transfer_encoding to struct mailinfo
 + mailinfo: move check for metainfo_charset to convert_to_utf8()
 + mailinfo: move metainfo_charset to struct mailinfo
 + mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
 + mailinfo: move add_message_id and message_id to struct mailinfo
 + mailinfo: move patch_lines to struct mailinfo
 + mailinfo: move filter/header stage to struct mailinfo
 + mailinfo: move global "FILE *fin, *fout" to struct mailinfo
 + mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
 + mailinfo: introduce "struct mailinfo" to hold globals
 + mailinfo: move global "line" into mailinfo() function
 + mailinfo: do not let find_boundary() touch global "line" directly
 + mailinfo: do not let handle_boundary() touch global "line" directly
 + mailinfo: do not let handle_body() touch global "line" directly
 + mailinfo: get rid of function-local static states
 + mailinfo: move definition of MAX_HDR_PARSED closer to its use
 + mailinfo: move cleanup_space() before its users
 + mailinfo: move check_header() after the helpers it uses
 + mailinfo: move read_one_header_line() closer to its callers
 + mailinfo: move handle_boundary() lower
 + mailinfo: plug strbuf leak during continuation line handling
 + mailinfo: explicitly close file handle to the patch output
 + mailinfo: fix an off-by-one error in the boundary stack
 + mailinfo: fold decode_header_bq() into decode_header()
 + mailinfo: remove a no-op call convert_to_utf8(it, "")
 (this branch is used by jc/am-mailinfo-direct and jc/mailinfo.)

 The implementation of "git mailinfo" was refactored so that a
 mailinfo() function can be directly called from inside a process.

 Will merge to 'master'.


* jc/am-3-fallback-regression-fix (2015-10-09) 1 commit
  (merged to 'next' on 2015-10-15 at 7dde994)
 + am -3: do not let failed merge from completing the error codepath
 (this branch is used by js/am-3-merge-recursive-direct.)

 "git am -3" had a small regression where it is aborted in its error
 handling codepath when underlying merge-recursive failed in certain
 ways, as it assumed that the internal call to merge-recursive will
 never die, which is not the case (yet).

 Will merge to 'master'.


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag
 (this branch uses jc/am-3-fallback-regression-fix.)

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Will cook in 'next'.


* sg/pretty-more-date-mode-format (2015-10-07) 1 commit
 - pretty: add format specifiers for short and raw date formats

 Introduce "%as" and "%aR" placeholders for "log --format" to show
 the author date in the short and raw formats.

 I have a feeling that that this is a step in a wrong direction.
 Comments?


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

 More unification among "branch -l", "tag -l" and "for-each-ref --format".

 Expecting a reroll.
 ($gmane/278926)


* rp/link-curl-before-ssl (2015-10-21) 3 commits
  (merged to 'next' on 2015-10-22 at dad4fc6)
 + configure.ac: detect ssl need with libcurl
 + Makefile: make curl-config path configurable
 + Makefile: link libcurl before zlib

 The linkage order of libraries was wrong in places around libcurl.

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


* sb/submodule-parallel-fetch (2015-10-21) 16 commits
 - git submodule update: have a dedicated helper for cloning
 - submodule config: keep update strategy around
 - run-command: fix missing output from late callbacks
 - test-run-command: increase test coverage
 - test-run-command: test for gracefully aborting
 - run-command: initialize the shutdown flag
 - run-command: clear leftover state from child_process structure
 - run-command: fix early shutdown
  (merged to 'next' on 2015-10-15 at df63590)
 + submodules: allow parallel fetching, add tests and documentation
 + fetch_populated_submodules: use new parallel job processing
 + run-command: add an asynchronous parallel child processor
 + sigchain: add command to pop all common signals
 + strbuf: add strbuf_read_once to read without blocking
 + xread_nonblock: add functionality to read from fds without blocking
 + xread: poll on non blocking fds
 + submodule.c: write "Fetching submodule <foo>" to stderr

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 Will cook in 'next'.


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

* km/cache-entry-refcnt (2015-10-14) 1 commit
 . merge: fix cache_entry use-after-free

 Made unnecessary with dt/name-hash-dir-entry-fix topic.
