From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2015, #03; Mon, 20)
Date: Mon, 20 Apr 2015 16:06:48 -0700
Message-ID: <xmqqvbgqielz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 01:07:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkKmp-0004Qm-93
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 01:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbbDTXH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 19:07:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751705AbbDTXGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 19:06:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12D7349873;
	Mon, 20 Apr 2015 19:06:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=O
	wP6RGQgRcBQMXDhRdcnuROrWsw=; b=fwicp6TwZKH0P2DgXtie1AH4t/hL+JJyu
	SNEt90L31GGdv0Q8MibQnyK+543nvGCPERoURMs+5ysu3GMuXB1ZCmBSP2SnJhPs
	v60Q0jTHowFbzPic9UPOCef13ax08v1I+fLjRzs+9SaSWApRr+DRScaW+pLO7LDZ
	qqtvaGlk0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=O8q
	59aNcF4iZp5dPOc+LtwIUnvTSBc5PplZ1mToHaBJVcrDvuTDy6QTyZIv1dc2RivU
	SQgQ/VHA+tNQxzez5UOQLjiFJFBAMMs/TQ5BTPjfaGUZSQfCUBsfTKizrpzqdQ/8
	JwlzuFfEJ6BM4IoKTmCVgpglTe+RlJVaRqXdLiPQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 093F249872;
	Mon, 20 Apr 2015 19:06:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E97349871;
	Mon, 20 Apr 2015 19:06:49 -0400 (EDT)
X-master-at: 7c597ef345aed345576de616c51f27e6f4b342b3
X-next-at: aa1ae690dee8648c2e1169b5e9a10dbc28109e56
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EC9A1C46-E7B1-11E4-92A7-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267512>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jc/push-cert (2015-04-02) 1 commit
  (merged to 'next' on 2015-04-08 at aecdd43)
 + push --signed: tighten what the receiving end can ask to sign

 The "git push --signed" protocol extension did not limit what the
 "nonce" that is a server-chosen string can contain or how long it
 can be, which was unnecessarily lax.  Limit both the length and the
 alphabet to a reasonably small space that can still have enough
 entropy.


* ma/bash-completion-leaking-x (2015-04-12) 1 commit
  (merged to 'next' on 2015-04-14 at 3a52a6d)
 + completion: fix global bash variable leak on __gitcompappend

 The completion script (in contrib/) contaminated global namespace
 and clobbered on a shell variable $x.


* ps/grep-help-all-callback-arg (2015-04-12) 1 commit
  (merged to 'next' on 2015-04-14 at e0a8092)
 + grep: correctly initialize help-all option

 Code clean-up.


* tb/connect-ipv6-parse-fix (2015-04-08) 1 commit
  (merged to 'next' on 2015-04-14 at e720918)
 + connect.c: ignore extra colon after hostname

 An earlier update to the parser that disects a URL broke an
 address, followed by a colon, followed by an empty string (instead
 of the port number), e.g. ssh://example.com:/path/to/repo.


* va/fix-git-p4-tests (2015-04-12) 3 commits
  (merged to 'next' on 2015-04-14 at 261bf90)
 + t9814: guarantee only one source exists in git-p4 copy tests
 + git-p4: fix copy detection test
 + t9814: fix broken shell syntax in git-p4 rename test

 Test fixes for git-p4.

--------------------------------------------------
[New Topics]

* jc/epochtime-wo-tz (2015-04-15) 2 commits
 - parse_date_basic(): let the system handle DST conversion
 - parse_date_basic(): return early when given a bogus timestamp

 "git commit --date=now" or anything that relies on approxidate lost
 the daylight-saving-time offset.

 Will merge to 'next'.


* jc/plug-fmt-merge-msg-leak (2015-04-20) 1 commit
 - fmt-merge-msg: plug small leak of commit buffer

 Will merge to 'next'.


* cn/bom-in-gitignore (2015-04-16) 5 commits
 - attr: skip UTF8 BOM at the beginning of the input file
 - config: use utf8_bom[] from utf.[ch] in git_parse_source()
 - utf8-bom: introduce skip_utf8_bom() helper
 - add_excludes_from_file: clarify the bom skipping logic
 - dir: allow a BOM at the beginning of exclude files

 Teach the codepaths that read .gitignore and .gitattributes files
 that these files encoded in UTF-8 may have UTF-8 BOM marker at the
 beginning; this makes it in line with what we do for configuration
 files already.

 Will merge to 'next'.


* ee/clean-remove-dirs (2015-04-18) 4 commits
 - clean: improve performance when removing lots of directories
 - p7300: add performance tests for clean
 - t7300: add tests to document behavior of clean and nested git
 - setup: add gentle version of read_gitfile

 Still WIP.


* ep/fix-test-lib-functions-report (2015-04-16) 1 commit
 - test-lib-functions.sh: fix the second argument to some helper functions

 Will merge to 'next'.


* jk/still-interesting (2015-04-17) 1 commit
 - limit_list: avoid quadratic behavior from still_interesting

 "git rev-list --objects $old --not --all" to see if everything that
 is reachable from $old is already connected to the existing refs
 was very inefficient.

 Will merge to 'next'.


* jk/type-from-string-gently (2015-04-17) 1 commit
  (merged to 'next' on 2015-04-20 at a97611f)
 + type_from_string_gently: make sure length matches

 "git cat-file bl $blob" failed to barf even though there is no
 object type that is "bl".


* ls/p4-changes-block-size (2015-04-20) 1 commit
 - git-p4: use -m when running p4 changes

 "git p4" learned "--changes-block-size <n>" to read the changes in
 chunks from Perforce, instead of making one call to "p4 changes"
 that may trigger "too many rows scanned" error from Perforce.

 Will merge to 'next'.


* mg/show-notes-doc (2015-04-17) 1 commit
  (merged to 'next' on 2015-04-20 at 2e93969)
 + rev-list-options.txt: complete sentence about notes matching

 Documentation fix.

 Will merge to 'master' in the first batch of post v2.4 cycle.


* mm/add-p-split-error (2015-04-16) 5 commits
 - stash -p: demonstrate failure of split with mixed y/n
 - t3904-stash-patch: factor PERL prereq at the top of the file
 - t3904-stash-patch: fix test description
 - add -p: demonstrate failure when running 'edit' after a split
 - t3701-add-interactive: simplify code


* mm/usage-log-l-can-take-regex (2015-04-20) 2 commits
 - log -L: improve error message on malformed argument
 - Documentation: change -L:<regex> to -L:<funcname>

 Will merge to 'next'.


* nd/pathspec-strip-fix (2015-04-18) 1 commit
 - pathspec: adjust prefixlen after striping trailing slash


* nd/t1509-chroot-test (2015-04-18) 1 commit
 - t1509: update prepare script to be able to run t1509 in chroot again

 Correct test bitrot.

 Will merge to 'next'.


* oh/fix-config-default-user-name-section (2015-04-17) 1 commit
  (merged to 'next' on 2015-04-20 at b74b914)
 + config: fix settings in default_user_config template

 The default $HOME/.gitconfig file created upon "git config --global"
 that edits it had incorrectly spelled user.name and user.email
 entries in it.

 Will merge to 'master' in the first batch of post v2.4 cycle.


* tb/t0027-crlf (2015-04-18) 2 commits
 - t0027: support NATIVE_CRLF platforms
 - t0027: cleanup: rename functions; avoid non-leading TABs

 Will merge to 'next'.


* jk/prune-mtime (2015-04-20) 3 commits
 - sha1_file: only freshen packs once per run
 - sha1_file: freshen pack objects before loose
 - reachable: only mark local objects as recent

 Access to objects in repositories that borrow from another one on a
 slow NFS server unnecessarily got more expensive due to recent code
 becoming more cautious in a naive way not to lose objects to pruning.

 Will merge to 'next'.


* sb/remove-fd-from-ref-lock (2015-04-17) 5 commits
 . refs.c: enable large transactions
 . sha1_fiel.c: move get_max_fd_limit(void) to wrapper.c
 . refs.c: remove lock_fd from struct ref_lock
 . t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
 . update-ref: test handling large transactions properly

--------------------------------------------------
[Stalled]

* mh/fdopen-with-retry (2015-03-06) 6 commits
 - buffer_fdinit(): use fdopen_with_retry()
 - update_info_file(): use fdopen_with_retry()
 - copy_to_log(): use fdopen_with_retry()
 - fdopen_lock_file(): use fdopen_with_retry()
 - SQUASH??? $gmane/264889
 - xfdopen(): if first attempt fails, free memory and try again

 Various parts of the code where they call fdopen() can fail when
 they run out of memory; attempt to proceed by retrying the
 operation after freeing some resource.

 Waiting for further comments.


* nd/untracked-cache (2015-03-12) 24 commits
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

 Need extra sets of eyes to review this.


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


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url

 Expecting a reroll.


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

 Waiting for the final step to lift the hard-limit.

--------------------------------------------------
[Cooking]

* ah/usage-strings (2015-04-02) 2 commits
 - branch: fix funny-sounding error message
 - standardize usage strings that were missed the first time

 A few usage string updates.

 Will hold.


* jk/reading-packed-refs (2015-04-16) 9 commits
 - t1430: add another refs-escape test
 - read_packed_refs: avoid double-checking sane refs
 - strbuf_getwholeline: use getdelim if it is available
 - strbuf_getwholeline: avoid calling strbuf_grow
 - strbuf_addch: avoid calling strbuf_grow
 - config: use getc_unlocked when reading from file
 - strbuf_getwholeline: use getc_unlocked
 - git-compat-util: add fallbacks for unlocked stdio
 - strbuf_getwholeline: use getc macro

 An earlier rewrite to use strbuf_getwholeline() instead of fgets(3)
 to read packed-refs file revealed that the former is unacceptably
 inefficient.

 Will merge to 'next'.


* kk/log-merges-config (2015-04-04) 5 commits
 - bash-completion: add support for git-log --merges= and log.merges
 - t4202-log: add tests for --merges=
 - Documentation: add git-log --merges= option and log.merges config. var
 - log: honor log.merges= option
 - revision: add --merges={show|only|hide} option

 "git log" (but not other commands in the "log" family) learned to
 pay attention to the log.merges configuration variable that can be
 set to "show" (the normal behaviour), "only" (hide non-merge
 commits), or "hide" (hide merge commits).  --merges=(show|only|hide)
 can be used to override the setting from the command line.

 The documentation may need to be updated once more.


* kn/cat-file-literally (2015-04-15) 5 commits
 - SQUASH???
 - t1006: add tests for git cat-file --literally
 - cat-file: add documentation for '--literally' option.
 - cat-file: teach cat-file a '--literally' option
 - sha1_file.c: support reading from a loose object of unknown type

 Add the "--literally" option to "cat-file" to allow inspecting
 loose objects of an experimental or a broken type.

 This is v8 $gmane/267213; getting closer to the final, I would say.


* ld/p4-filetype-detection (2015-04-04) 3 commits
  (merged to 'next' on 2015-04-08 at da735b4)
 + git-p4: fix filetype detection on files opened exclusively
 + git-p4: small fix for locked-file-move-test
 + git-p4: fix small bug in locked test scripts

 Will merge to 'master' in the first batch of post v2.4 cycle.


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962


* lm/squelch-bg-progress (2015-04-15) 2 commits
 - compat/mingw: stubs for getpgid() and tcgetpgrp()
 - progress: no progress in background

 Many long-running operations show progress eye-candy, even when
 they are later backgrounded.  Hide the eye-candy when the process
 is sent to the background instead.

 Will merge to 'next'.


* pt/xdg-config-path (2015-04-12) 7 commits
 - path.c: remove home_config_paths()
 - git-config: replace use of home_config_paths()
 - git-commit: replace use of home_config_paths()
 - credential-store.c: replace home_config_paths() with xdg_config_home()
 - dir.c: replace home_config_paths() with xdg_config_home()
 - attr.c: replace home_config_paths() with xdg_config_home()
 - path.c: implement xdg_config_home()
 (this branch uses pt/credential-xdg.)


* sb/test-bitmap-free-at-end (2015-04-12) 1 commit
  (merged to 'next' on 2015-04-14 at 0ae4759)
 + pack-bitmap.c: fix a memleak

 Will merge to 'master' in the first batch of post v2.4 cycle.


* va/p4-client-path (2015-04-19) 2 commits
 - git-p4: improve client path detection when branches are used
 - t9801: check git-p4's branch detection and client view together

 git p4 attempts to better handle branches in Perforce.

 Will merge to 'next'.


* jk/at-push-sha1 (2015-03-31) 6 commits
 - sha1_name: implement @{push} shorthand
 - sha1_name: refactor upstream_mark
 - remote.c: provide per-branch pushremote name
 - remote.c: hoist branch.*.remote lookup out of remote_get_1
 - remote.c: drop "remote" pointer from "struct branch"
 - remote.c: drop default_remote_name variable

 Introduce <branch>@{push} short-hand to denote the remote-tracking
 branch that tracks the branch at the remote the <branch> would be
 pushed to.

 Waiting for a reroll ($gmane/266573).


* jk/sha1-file-reduce-useless-warnings (2015-03-30) 1 commit
 - sha1_file: squelch "packfile cannot be accessed" warnings

 Will merge to 'next'.


* mh/show-branch-topic (2015-03-31) 1 commit
  (merged to 'next' on 2015-04-08 at 628ada5)
 + show-branch: show all local heads when only giving one rev along --topics

 "git show-branch --topics HEAD" (with no other arguments) did not
 do anything interesting.  Instead, contrast the given revision
 against all the local branches by default.

 Will merge to 'master' in the first batch of post v2.4 cycle.


* sb/line-log-plug-pairdiff-leak (2015-03-30) 1 commit
  (merged to 'next' on 2015-04-08 at 6ea8b71)
 + line-log.c: fix a memleak

 Will merge to 'master' in the first batch of post v2.4 cycle.


* jk/init-core-worktree-at-root (2015-04-02) 1 commit
  (merged to 'next' on 2015-04-08 at 92a942b)
 + init: don't set core.worktree when initializing /.git

 We avoid setting core.worktree when the repository location is the
 ".git" directory directly at the top level of the working tree, but
 the code misdetected the case in which the working tree is at the
 root level of the filesystem (which arguably is a silly thing to
 do, but still valid).

 Will merge to 'master' in the first batch of post v2.4 cycle.


* ts/checkout-advice-plural (2015-04-02) 1 commit
  (merged to 'next' on 2015-04-08 at dd5c436)
 + checkout: call a single commit "it" intead of "them"

 Will merge to 'master' in the first batch of post v2.4 cycle.


* pt/credential-xdg (2015-03-25) 4 commits
  (merged to 'next' on 2015-03-25 at 765128e)
 + t0302: "unreadable" test needs POSIXPERM
  (merged to 'next' on 2015-03-24 at 9a3706e)
 + t0302: test credential-store support for XDG_CONFIG_HOME
 + git-credential-store: support XDG_CONFIG_HOME
 + git-credential-store: support multiple credential files
 (this branch is used by pt/xdg-config-path.)

 Tweak the sample "store" backend of the credential helper to honor
 XDG configuration file locations when specified.

 As this may see further updates, and also this is not an urgent
 issue anyway, I'll give it a bit more time for it to simmer.

 Will cook in 'next'.


* jc/merge-deprecate-old-syntax (2015-03-26) 1 commit
 - merge: deprecate 'git merge <message> HEAD <commit>' syntax
 (this branch is used by jc/merge-drop-old-syntax.)

 The first step to really start the process of removing the ancient
 syntax to invoke a two-way merge, which has been deprecated since
 October 2007.

 This regresses "git pull" in various ways; do not merge ($gmane/267432).


* jc/merge-drop-old-syntax (2015-03-26) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax
 (this branch uses jc/merge-deprecate-old-syntax.)

 Stop supporting "git merge <messsage> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 This regresses "git pull" in various ways; do not merge ($gmane/267432).


* jc/diff-no-index-d-f (2015-03-26) 2 commits
  (merged to 'next' on 2015-03-27 at 1f270f9)
 + diff-no-index: align D/F handling with that of normal Git
 + diff-no-index: DWIM "diff D F" into "diff D/F F"

 The usual "git diff" when seeing a file turning into a directory
 showed a patchset to remove the file and create all files in the
 directory, but "git diff --no-index" simply refused to work.  Also,
 when asked to compare a file and a directory, imitate POSIX "diff"
 and compare the file with the file with the same name in the
 directory, instead of refusing to run.

 Will merge to 'master' in the first batch of post v2.4 cycle.


* nd/diff-i-t-a (2015-03-23) 1 commit
  (merged to 'next' on 2015-03-24 at a6be89f)
 + diff-lib.c: adjust position of i-t-a entries in diff

 After "git add -N", the path appeared in output of "git diff HEAD"
 and "git diff --cached HEAD", leading "git status" to classify it
 as "Changes to be committed".  Such a path, however, is not yet to
 be scheduled to be committed.  "git diff" showed the change to the
 path as modification, not as a "new file", in the header of its
 output.

 Treat such paths as "yet to be added to the index but Git already
 know about them"; "git diff HEAD" and "git diff --cached HEAD"
 should not talk about them, and "git diff" should show them as new
 files yet to be added to the index.

 Will cook in 'next', as this brings in a new world order.


* mh/numparse (2015-03-19) 14 commits
 - diff_opt_parse(): use convert_i() when handling --abbrev=<num>
 - diff_opt_parse(): use convert_i() when handling "-l<num>"
 - opt_arg(): simplify pointer handling
 - opt_arg(): report errors parsing option values
 - opt_arg(): use convert_i() in implementation
 - opt_arg(): val is always non-NULL
 - builtin_diff(): detect errors when parsing --unified argument
 - handle_revision_opt(): use convert_ui() when handling "--abbrev="
 - strtoul_ui(), strtol_i(): remove functions
 - handle_revision_opt(): use convert_i() when handling "-<digit>"
 - handle_revision_opt(): use skip_prefix() in many places
 - write_subdirectory(): use convert_ui() for parsing mode
 - cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
 - numparse: new module for parsing integral numbers

 Many codepaths use unchecked use of strtol() and friends (or even
 worse, atoi()).  Introduce a set of wrappers that try to be more
 careful.

 Waiting for a reroll ($gmane/266209).


* tf/gitweb-project-listing (2015-03-19) 5 commits
 - gitweb: make category headings into links when they are directories
 - gitweb: optionally set project category from its pathname
 - gitweb: add a link under the search box to clear a project filter
 - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
 - gitweb: fix typo in man page

 Update gitweb to make it more pleasant to deal with a hierarchical
 forest of repositories.

 Any comments from those who use or have their own code in Gitweb?


* jc/a-lone-dash-stands-for-previous-branch (2015-03-16) 1 commit
 - "-" and "@{-1}" on various programs

 Lose special case code to make a lone dash "-" mean the previous
 branch aka "@{-1}" from a handful subcommands, and instead support
 the notation throughout the system by reimplementing it at the
 revisions layer.

 Needs tests, documentation updates, etc.  Also does only a half-way
 job dealing with range notation, which needs to be fixed before the
 series goes anywhere.


* bc/object-id (2015-03-13) 10 commits
  (merged to 'next' on 2015-03-24 at 3ec4f83)
 + apply: convert threeway_stage to object_id
 + patch-id: convert to use struct object_id
 + commit: convert parts to struct object_id
 + diff: convert struct combine_diff_path to object_id
 + bulk-checkin.c: convert to use struct object_id
 + zip: use GIT_SHA1_HEXSZ for trailers
 + archive.c: convert to use struct object_id
 + bisect.c: convert leaf functions to use struct object_id
 + define utility functions for object IDs
 + define a structure for object IDs

 Identify parts of the code that knows that we use SHA-1 hash to
 name our objects too much, and use (1) symbolic constants instead
 of hardcoded 20 as byte count and/or (2) use struct object_id
 instead of unsigned char [20] for object names.

 Will cook in 'next'.
 Also waiting for reviews on the follow-up series ($gmane/265939)
 that seems to have seen no interest X-<.


* nd/slim-index-pack-memory-usage (2015-04-18) 2 commits
 - index-pack: kill union delta_base to save memory
 - index-pack: reduce object_entry size to save memory

 Memory usage of "git index-pack" has been trimmed by tens of
 per-cent.

 Will merge to 'next'.


* nd/list-files (2015-02-09) 21 commits
 - t3080: tests for git-list-files
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

 Reroll to base on wt-status work ($gmane/265142) has seen some
 positive discussions.

 Waiting for a further polished reroll ($gmane/265534).


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

 "fsck.warnings = <list of error tokens>" I suggested turned out to
 be an unpopular choice (sorry Dscho).

 Expecting a reroll.


* nd/multiple-work-trees (2015-03-31) 41 commits
  (merged to 'next' on 2015-04-02 at 7ea51b4)
 + prune --worktrees: fix expire vs worktree existence condition
  (merged to 'next' on 2015-03-24 at 58b5a60)
 + t1501: fix test with split index
  (merged to 'next' on 2015-03-20 at cc98ed0)
 + t2026: fix broken &&-chain
  (merged to 'next' on 2015-02-18 at b51f696)
 + t2026 needs procondition SANITY
 + git-checkout.txt: a note about multiple checkout support for submodules
 + checkout: add --ignore-other-wortrees
 + checkout: pass whole struct to parse_branchname_arg instead of individual flags
 + git-common-dir: make "modules/" per-working-directory directory
 + checkout: do not fail if target is an empty directory
 + t2025: add a test to make sure grafts is working from a linked checkout
 + checkout: don't require a work tree when checking out into a new one
 + git_path(): keep "info/sparse-checkout" per work-tree
 + count-objects: report unused files in $GIT_DIR/worktrees/...
 + gc: support prune --worktrees
 + gc: factor out gc.pruneexpire parsing code
 + gc: style change -- no SP before closing parenthesis
 + checkout: clean up half-prepared directories in --to mode
 + checkout: reject if the branch is already checked out elsewhere
 + prune: strategies for linked checkouts
 + checkout: support checking out into a new working directory
 + use new wrapper write_file() for simple file writing
 + wrapper.c: wrapper to open a file, fprintf then close
 + setup.c: support multi-checkout repo setup
 + setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 + setup.c: convert check_repository_format_gently to use strbuf
 + setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 + setup.c: convert is_git_directory() to use strbuf
 + git-stash: avoid hardcoding $GIT_DIR/logs/....
 + *.sh: avoid hardcoding $GIT_DIR/hooks/...
 + git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 + $GIT_COMMON_DIR: a new environment variable
 + commit: use SEQ_DIR instead of hardcoding "sequencer"
 + fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 + reflog: avoid constructing .lock path with git_path
 + *.sh: respect $GIT_INDEX_FILE
 + git_path(): be aware of file relocation in $GIT_DIR
 + path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 + path.c: rename vsnpath() to do_git_path()
 + git_snpath(): retire and replace with strbuf_git_path()
 + path.c: make get_pathname() call sites return const char *
 + path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* as/userdiff-sh (2015-03-13) 1 commit
 . userdiff: funcname and word patterns for sh

 Add a built-in "userdiff" patterns to word-split and identify
 notable lines in shell scripts to help presentation of diff and
 grep output.
