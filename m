From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2015, #02; Wed, 6)
Date: Wed, 06 May 2015 12:59:12 -0700
Message-ID: <xmqq6185tr3j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 21:59:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5Ti-0005lZ-EU
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 21:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbbEFT7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 15:59:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398AbbEFT7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 15:59:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 102704FE7D;
	Wed,  6 May 2015 15:59:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=A
	IGhoN47dcGqMvjUG+zfcCT6q+M=; b=TjJuuiWu6ut5TSmXkUhs3MewIV91fo57O
	1IotIgoEGzH9fIi6Ac/BC/abD0ZshZpGp+EI2VxVt9N8UTAN7DdKnQPpOBfOawqw
	RR6yGLaVUfUpPYHiFahO+KXcv2EF0kbgyqxHYzWPtwurVQu5LHjHNLaZVywmGEUK
	tfZAjlDDEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=cDL
	4z1Xnf1ZxVL+YMggq8L1Ge+jrLxeoTSS7kfE/63yxGSn/96iYmZ5mu8poN86beV3
	FJD9iuL0JvxTHjhjL/2ABz6QJ8OZeXylgdsCU/aRzQH4ARoXjJC5n9ObYMU4TXsx
	kvKJTsVDzdHgYZ2MsINKZ6CXtew5V7jx36IvHWls=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98A524FE7C;
	Wed,  6 May 2015 15:59:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 500194FE78;
	Wed,  6 May 2015 15:59:13 -0400 (EDT)
X-master-at: 8440f74997cf7958c7e8ec853f590828085049b8
X-next-at: 8e1974edaeee9161b10b8f31a7a86892259e9768
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E282AFE-F42A-11E4-A257-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268490>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The first batch for the next feature release (tentatively called 2.5)
has been merged to 'master'.  They mostly are fixes that are meant
for the first maintenance release for 2.4.x track.  The tip of 'next'
has been rewound and rebuilt.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/object-id (2015-03-13) 10 commits
  (merged to 'next' on 2015-05-05 at 975002f)
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

 Originally merged to 'next' on 2015-03-24

 Identify parts of the code that knows that we use SHA-1 hash to
 name our objects too much, and use (1) symbolic constants instead
 of hardcoded 20 as byte count and/or (2) use struct object_id
 instead of unsigned char [20] for object names.


* cn/bom-in-gitignore (2015-04-16) 5 commits
  (merged to 'next' on 2015-05-05 at 8aa8b91)
 + attr: skip UTF8 BOM at the beginning of the input file
 + config: use utf8_bom[] from utf.[ch] in git_parse_source()
 + utf8-bom: introduce skip_utf8_bom() helper
 + add_excludes_from_file: clarify the bom skipping logic
 + dir: allow a BOM at the beginning of exclude files

 Originally merged to 'next' on 2015-04-21

 Teach the codepaths that read .gitignore and .gitattributes files
 that these files encoded in UTF-8 may have UTF-8 BOM marker at the
 beginning; this makes it in line with what we do for configuration
 files already.


* ep/fix-test-lib-functions-report (2015-04-16) 1 commit
  (merged to 'next' on 2015-05-05 at e49e876)
 + test-lib-functions.sh: fix the second argument to some helper functions

 Originally merged to 'next' on 2015-04-21


* jc/diff-no-index-d-f (2015-03-26) 2 commits
  (merged to 'next' on 2015-05-05 at 61538ca)
 + diff-no-index: align D/F handling with that of normal Git
 + diff-no-index: DWIM "diff D F" into "diff D/F F"

 Originally merged to 'next' on 2015-03-27

 The usual "git diff" when seeing a file turning into a directory
 showed a patchset to remove the file and create all files in the
 directory, but "git diff --no-index" simply refused to work.  Also,
 when asked to compare a file and a directory, imitate POSIX "diff"
 and compare the file with the file with the same name in the
 directory, instead of refusing to run.


* jc/epochtime-wo-tz (2015-04-15) 2 commits
  (merged to 'next' on 2015-05-05 at 3d10988)
 + parse_date_basic(): let the system handle DST conversion
 + parse_date_basic(): return early when given a bogus timestamp

 Originally merged to 'next' on 2015-04-21

 "git commit --date=now" or anything that relies on approxidate lost
 the daylight-saving-time offset.


* jk/init-core-worktree-at-root (2015-04-02) 1 commit
  (merged to 'next' on 2015-05-05 at 65c7453)
 + init: don't set core.worktree when initializing /.git

 Originally merged to 'next' on 2015-04-08

 We avoid setting core.worktree when the repository location is the
 ".git" directory directly at the top level of the working tree, but
 the code misdetected the case in which the working tree is at the
 root level of the filesystem (which arguably is a silly thing to
 do, but still valid).


* jk/prune-mtime (2015-04-20) 3 commits
  (merged to 'next' on 2015-05-05 at 6c0a311)
 + sha1_file: only freshen packs once per run
 + sha1_file: freshen pack objects before loose
 + reachable: only mark local objects as recent

 Originally merged to 'next' on 2015-04-21

 Access to objects in repositories that borrow from another one on a
 slow NFS server unnecessarily got more expensive due to recent code
 becoming more cautious in a naive way not to lose objects to pruning.


* jk/type-from-string-gently (2015-04-17) 1 commit
  (merged to 'next' on 2015-05-05 at 73b5c2a)
 + type_from_string_gently: make sure length matches

 Originally merged to 'next' on 2015-04-20

 "git cat-file bl $blob" failed to barf even though there is no
 object type that is "bl".


* ld/p4-filetype-detection (2015-04-04) 3 commits
  (merged to 'next' on 2015-05-05 at ce95858)
 + git-p4: fix filetype detection on files opened exclusively
 + git-p4: small fix for locked-file-move-test
 + git-p4: fix small bug in locked test scripts

 Originally merged to 'next' on 2015-04-08


* mh/show-branch-topic (2015-03-31) 1 commit
  (merged to 'next' on 2015-05-05 at 43c6237)
 + show-branch: show all local heads when only giving one rev along --topics

 Originally merged to 'next' on 2015-04-08

 "git show-branch --topics HEAD" (with no other arguments) did not
 do anything interesting.  Instead, contrast the given revision
 against all the local branches by default.


* mm/usage-log-l-can-take-regex (2015-04-20) 2 commits
  (merged to 'next' on 2015-05-05 at dbe590c)
 + log -L: improve error message on malformed argument
 + Documentation: change -L:<regex> to -L:<funcname>

 Originally merged to 'next' on 2015-04-21

 Documentation fix.


* nd/t1509-chroot-test (2015-04-18) 1 commit
  (merged to 'next' on 2015-05-05 at e93f60e)
 + t1509: update prepare script to be able to run t1509 in chroot again

 Originally merged to 'next' on 2015-04-21

 Correct test bitrot.


* oh/fix-config-default-user-name-section (2015-04-17) 1 commit
  (merged to 'next' on 2015-05-05 at b4778c2)
 + config: fix settings in default_user_config template

 Originally merged to 'next' on 2015-04-20

 The default $HOME/.gitconfig file created upon "git config --global"
 that edits it had incorrectly spelled user.name and user.email
 entries in it.


* sb/line-log-plug-pairdiff-leak (2015-03-30) 1 commit
  (merged to 'next' on 2015-05-05 at 3d8e735)
 + line-log.c: fix a memleak

 Originally merged to 'next' on 2015-04-08


* sb/test-bitmap-free-at-end (2015-04-12) 1 commit
  (merged to 'next' on 2015-05-05 at 2b83c75)
 + pack-bitmap.c: fix a memleak

 Originally merged to 'next' on 2015-04-14


* ts/checkout-advice-plural (2015-04-02) 1 commit
  (merged to 'next' on 2015-05-05 at 546f824)
 + checkout: call a single commit "it" intead of "them"

 Originally merged to 'next' on 2015-04-08

--------------------------------------------------
[New Topics]

* jc/daemon-no-ipv6-for-2.4.1 (2015-05-05) 1 commit
  (merged to 'next' on 2015-05-05 at 1eb279f)
 + daemon: unbreak NO_IPV6 build regression

 "git daemon" fails to build from the source under NO_IPV6
 configuration (regression in 2.4).

 Will merge to 'master' in the second batch.


* sb/prefix-path-free-results (2015-05-05) 1 commit
 - prefix_path(): unconditionally free results in the callers

 Code clean-up (not a leak-fix).

 Will merge to 'next'.


* sg/completion-omit-credential-helpers (2015-05-05) 2 commits
 - SQUASH???
 - completion: remove credential helpers from porcelain commands

 The Git subcommand completion (in contrib/) listed credential
 helpers among candidates, which is not something the end user would
 invoke interatively.

 Will merge to 'next' after squashing the fix in.


* jk/skip-http-tests-under-no-curl (2015-05-06) 1 commit
 - t/lib-httpd.sh: skip tests if NO_CURL is defined

 Test clean-up.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* kk/log-merges-config (2015-04-21) 5 commits
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

 The documentation may need to be updated once more ($gmane/267250).
 Waiting for a reroll.


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962
 Will be rerolled.
 with updated log message ($gmane/268061).


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

 Will be rerolled.
 ($gmane/268058).


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


* nd/pathspec-strip-fix (2015-04-18) 1 commit
 - pathspec: adjust prefixlen after striping trailing slash

 Does not quite fix ($gmane/267614).


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

* mh/ref-directory-file (2015-05-05) 19 commits
 - SQUASH???
 - reflog_expire(): integrate lock_ref_sha1_basic() errors into ours
 - ref_transaction_commit(): delete extra "the" from error message
 - ref_transaction_commit(): provide better error messages
 - rename_ref(): integrate lock_ref_sha1_basic() errors into ours
 - lock_ref_sha1_basic(): improve diagnostics for D/F conflicts
 - lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
 - verify_refname_available(): report errors via a "struct strbuf *err"
 - verify_refname_available(): rename function
 - refs: check for D/F conflicts among refs processed in a transaction
 - ref_transaction_commit(): use a string_list for detecting duplicates
 - is_refname_available(): use dirname in first loop
 - struct nonmatching_ref_data: store a refname instead of a ref_entry
 - report_refname_conflict(): inline function
 - entry_matches(): inline function
 - is_refname_available(): convert local variable "dirname" to strbuf
 - is_refname_available(): avoid shadowing "dir" variable
 - is_refname_available(): explain the reason for an early exit
 - t1404: new tests of D/F conflicts within ref transactions
 (this branch uses mh/ref-lock-avoid-running-out-of-fds.)

 Expecting a reroll.


* nd/dwim-wildcards-as-pathspecs (2015-05-03) 1 commit
 - pathspec: avoid the need of "--" when wildcard is used

 A heuristic to help the "git <cmd> <revs> <pathspec>" command line
 convention to catch mistyped paths is to make sure all the non-rev
 parameters in the later part of the command line are names of the
 files in the working tree, but that means "git grep $str -- \*.c"
 must always be disambiguated with "--", because nobody sane will
 create a file whose name literally is asterisk-dot-see.  Loosen the
 heuristic to declare that with a wildcard string the user likely
 meant to give us a pathspec.

 Will merge to 'next'.


* pt/pull-tests (2015-05-03) 7 commits
 - t5521: test --dry-run does not make any changes
 - t5520: test --rebase failure on unborn branch with index
 - t5520: test --rebase with multiple branches
 - t5520: test work tree fast-forward when fetch updates head
 - t5520: test for failure if index has unresolved entries
 - t5520: implement tests for no merge candidates cases
 - t5520: test pulling multiple branches into an empty repository

 Add more test coverage to "git pull".  This conflicts slightly with
 a new test jc/merge topic adds, but resolution is fairly trivial.

 Expecting a reroll ($gmane/268391).


* sg/complete-decorate-full-not-long (2015-05-03) 1 commit
 - completion: fix and update 'git log --decorate=' options

 The completion for "log --decorate=" parameter value was incorrect.

 Will merge to 'next'.


* sg/completion-no-redundant-all-command-list (2015-05-03) 1 commit
 - completion: remove redundant __git_compute_all_commands() call

 Code simplification.

 Will merge to 'next'.


* jc/hash-object (2015-05-05) 4 commits
 - write_sha1_file(): do not use a separate sha1[] array
 - t1007: add hash-object --literally tests
 - hash-object --literally: fix buffer overrun with extra-long object type
 - git-hash-object.txt: document --literally option

 "hash-object --literally" introduced in v2.2 days was not prepared
 to take a really long object type name.

 Will merge to 'next'.


* jn/clean-use-error-not-fprintf-on-stderr (2015-05-04) 1 commit
  (merged to 'next' on 2015-05-05 at 12391f1)
 + config: use error() instead of fprintf(stderr, ...)

 Some error messages in "git config" were emitted without calling
 the usual error() facility.

 Will merge to 'master' in the second batch.


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Still an early WIP


* jk/at-push-sha1 (2015-05-03) 12 commits
 - for-each-ref: accept "%(push)" format
 - for-each-ref: use skip_prefix instead of starts_with
 - sha1_name: implement @{push} shorthand
 - sha1_name: refactor interpret_upstream_mark
 - sha1_name: refactor upstream_mark
 - remote.c: add branch_get_push
 - remote.c: report specific errors from branch_get_upstream
 - remote.c: introduce branch_get_upstream helper
 - remote.c: provide per-branch pushremote name
 - remote.c: hoist branch.*.remote lookup out of remote_get_1
 - remote.c: drop "remote" pointer from "struct branch"
 - remote.c: drop default_remote_name variable

 Introduce <branch>@{push} short-hand to denote the remote-tracking
 branch that tracks the branch at the remote the <branch> would be
 pushed to.

 Expecting a reroll ($gmane/268419, etc.).


* jk/rebase-quiet-noop (2015-04-28) 1 commit
  (merged to 'next' on 2015-05-05 at 82780b9)
 + rebase: silence "git checkout" for noop rebase

 "git rebase --quiet" was not quite quiet when there is nothing to
 do.

 Will merge to 'master' in the second batch.


* ld/p4-case-fold (2015-04-28) 1 commit
  (merged to 'next' on 2015-05-05 at 03ecbd0)
 + git-p4: add failing tests for case-folding p4d

 Will merge to 'master' in the second batch.


* va/fix-git-p4-tests (2015-04-28) 1 commit
  (merged to 'next' on 2015-05-05 at 795e858)
 + git-p4: t9814: prevent --chain-lint failure

 Will merge to 'master' in the second batch.


* jk/filter-branch-use-of-sed-on-incomplete-line (2015-04-29) 1 commit
 - filter-branch: avoid passing commit message through sed

 "filter-branch" was broken by some "sed" implementations that
 corrupt commit log message that ends with an incomplete line.
 Work it around by avoiding to use "sed".

 Will merge to 'next'.


* ph/rebase-i-redo (2015-04-29) 1 commit
 - rebase -i: redo tasks that die during cherry-pick

 "git rebase -i" moved the "current" command from "todo" to "done" a
 bit too prematurely, losing a step when a "pick" did not even start.

 Will merge to 'next'.


* ep/do-not-feed-a-pointer-to-array-size (2015-05-05) 1 commit
 - git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array

 Catch programmer mistake to feed a pointer not an array to
 ARRAY_SIZE() macro, by using a couple of GCC extensions.

 Will merge to 'next'.


* tb/blame-resurrect-convert-to-git (2015-05-03) 1 commit
  (merged to 'next' on 2015-05-05 at 8e1974e)
 + blame: CRLF in the working tree and LF in the repo

 Some time ago, "git blame" (incorrectly) lost the convert_to_git()
 call when synthesizing a fake "tip" commit that represents the
 state in the working tree, which broke folks who record the history
 with LF line ending to make their project portabile across
 platforms while terminating lines in their working tree files with
 CRLF for their platform.

 Will merge to 'master' in the second batch.


* jc/plug-fmt-merge-msg-leak (2015-04-20) 1 commit
  (merged to 'next' on 2015-05-05 at bd94828)
 + fmt-merge-msg: plug small leak of commit buffer

 Originally merged to 'next' on 2015-04-21

 Will merge to 'master' in the second batch.


* ee/clean-remove-dirs (2015-04-26) 5 commits
 - clean: improve performance when removing lots of directories
 - p7300: add performance tests for clean
 - t7300: add tests to document behavior of clean and nested git
 - setup: sanity check file size in read_gitfile_gently
 - setup: add gentle version of read_gitfile

 Replace "is this subdirectory a separate repository that should not
 be touched?" check "git clean" does by checking if it has .git/HEAD
 using the submodule-related code with a more optimized check.

 Waiting for a reroll.


* jk/still-interesting (2015-04-17) 1 commit
  (merged to 'next' on 2015-05-05 at 6a5c89c)
 + limit_list: avoid quadratic behavior from still_interesting

 Originally merged to 'next' on 2015-04-21

 "git rev-list --objects $old --not --all" to see if everything that
 is reachable from $old is already connected to the existing refs
 was very inefficient.

 Will merge to 'master' in the second batch.


* ls/p4-changes-block-size (2015-04-20) 1 commit
  (merged to 'next' on 2015-05-05 at 92596d4)
 + git-p4: use -m when running p4 changes

 Originally merged to 'next' on 2015-04-21

 "git p4" learned "--changes-block-size <n>" to read the changes in
 chunks from Perforce, instead of making one call to "p4 changes"
 that may trigger "too many rows scanned" error from Perforce.

 Will merge to 'master' in the second batch.


* mm/add-p-split-error (2015-04-16) 5 commits
  (merged to 'next' on 2015-05-05 at c556011)
 + stash -p: demonstrate failure of split with mixed y/n
 + t3904-stash-patch: factor PERL prereq at the top of the file
 + t3904-stash-patch: fix test description
 + add -p: demonstrate failure when running 'edit' after a split
 + t3701-add-interactive: simplify code

 Originally merged to 'next' on 2015-04-23

 When "add--interactive" splits a hunk into two overlapping hunks
 and then let the user choose only one, it sometimes feeds an
 incorrect patch text to "git apply".  Add tests to demonstrate
 this.

 I have a slight suspicion that this may be $gmane/87202 coming back
 and biting us (I seem to have said "let's run with this and see
 what happens" back then).

 Will merge to 'master' in the second batch.


* tb/t0027-crlf (2015-04-25) 3 commits
  (merged to 'next' on 2015-05-05 at 36accbb)
 + t0027: Add repoMIX and LF_nul
 + t0027: support NATIVE_CRLF platforms
 + t0027: cleanup: rename functions; avoid non-leading TABs

 Originally merged to 'next' on 2015-04-21

 More line-ending tests.

 Will merge to 'master' in the second batch.


* jc/gitignore-precedence (2015-04-22) 1 commit
  (merged to 'next' on 2015-05-05 at 6ef85da)
 + ignore: info/exclude should trump core.excludesfile

 core.excludesfile (defaulting to $XDG_HOME/git/ignore) is supposed
 to be overridden by repository-specific .git/info/exclude file, but
 the order was swapped from the beginning. This belatedly fixes it.

 Will merge to 'master' in the third batch.


* jk/git-no-more-argv0-path-munging (2015-04-22) 1 commit
  (merged to 'next' on 2015-05-05 at b3f9a45)
 + stop putting argv[0] dirname at front of PATH

 We have prepended $GIT_EXEC_PATH and the path "git" is installed in
 (typically "/usr/bin") to $PATH when invoking subprograms and hooks
 for almost eternity, but the original use case the latter tried to
 support was semi-bogus (i.e. install git to /opt/foo/git and run it
 without having /opt/foo on $PATH), and more importantly it has
 become less and less relevant as Git grew more mainstream (i.e. the
 users would _want_ to have it on their $PATH).  Stop prepending the
 path in which "git" is installed to users' $PATH, as that would
 interfere the command search order people depend on (e.g. they may
 not like versions of programs that are unrelated to Git in /usr/bin
 and want to override them by having different ones in /usr/local/bin
 and have the latter directory earlier in their $PATH).

 Will merge to 'master' in the third batch.


* jk/stash-require-clean-index (2015-04-22) 3 commits
  (merged to 'next' on 2015-05-05 at b5f6c32)
 + stash: require a clean index to apply
 + t3903: avoid applying onto dirty index
 + t3903: stop hard-coding commit sha1s

 "git stash pop/apply" forgot to make sure that not just the working
 tree is clean but also the index is clean. The latter is important
 as a stash application can conflict and the index will be used for
 conflict resolution.

 Will merge to 'master' in the third batch.


* jc/merge (2015-04-29) 15 commits
 - merge: deprecate 'git merge <message> HEAD <commit>' syntax
 - merge: handle FETCH_HEAD internally
 - merge: decide if we auto-generate the message early in collect_parents()
 - merge: make collect_parents() auto-generate the merge message
 - merge: extract prepare_merge_message() logic out
 - merge: narrow scope of merge_names
 - merge: split reduce_parents() out of collect_parents()
 - merge: clarify collect_parents() logic
 - merge: small leakfix and code simplification
 - merge: do not check argc to determine number of remote heads
 - merge: clarify "pulling into void" special case
 - t5520: test pulling an octopus into an unborn branch
 - t5520: style fixes
 - merge: simplify code flow
 - merge: test the top-level merge driver
 (this branch is used by jc/merge-drop-old-syntax.)

 "git merge FETCH_HEAD" learned that the previous "git fetch" could
 be to create an Octopus merge, i.e. recording multiple branches
 that are not marked as "not-for-merge"; this allows us to lose an
 old style invocation "git merge <msg> HEAD $commits..." in the
 implementation of "git pull" script; the old style syntax can now
 be deprecated.

 Will merge to 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax
 (this branch uses jc/merge.)

 Stop supporting "git merge <messsage> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will merge to 'next' and keep there during the 2.5 cycle.


* jk/test-chain-lint (2015-04-28) 2 commits
  (merged to 'next' on 2015-05-05 at e6f0290)
 + test-lib: turn on GIT_TEST_CHAIN_LINT by default
 + t7502-commit.sh: fix a broken and-chain

 Developer support to automatically detect broken &&-chain in the
 test scripts is now turned on by default.

 Will merge to 'master' in the third batch.


* mh/ref-lock-avoid-running-out-of-fds (2015-04-25) 8 commits
 - ref_transaction_commit(): only keep one lockfile open at a time
 - ref_transaction_commit(): remove the local flags variables
 - write_ref_sha1(): inline function at callers
 - commit_ref_update(): new function, extracted from write_ref_sha1()
 - write_ref_to_lockfile(): new function, extracted from write_ref_sha1()
 - refs.c: remove lock_fd from struct ref_lock
 - t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
 - update-ref: test handling large transactions properly
 (this branch is used by mh/ref-directory-file.)

 "git update-ref --stdin" was converted to be "transactional" some
 time ago, but the ref transaction machinery was not prepared to
 handle many refs, primarily because it tried to keep the loose ref
 files open at the same time, which would cause us to hit the ENFILE
 limit.  Fix the ref_transaction_commit() code not to keep the file
 descriptors open unnecessarily.

 We would want to apply the fix to older codebase, but this fix is
 unfortunately done to apply only on v2.4.x track.

 Expecting a rebase to older codebase.


* bc/connect-plink (2015-04-28) 3 commits
  (merged to 'next' on 2015-05-05 at 9def2e1)
 + connect: improve check for plink to reduce false positives
 + t5601: fix quotation error leading to skipped tests
 + connect: simplify SSH connection code path

 The connection initiation code for "ssh" transport tried to absorb
 differences between the stock "ssh" and Putty-supplied "plink" and
 its derivatives, but the logic to tell that we are using "plink"
 variants were too loose and falsely triggered when "plink" appeared
 anywhere in the path (e.g. "/home/me/bin/uplink/ssh").

 Will merge to 'master' in the third batch.


* jc/test-prereq-validate (2015-04-28) 1 commit
  (merged to 'next' on 2015-05-05 at a30464c)
 + test: validate prerequistes syntax

 Help us to find broken test script that splits the body part of the
 test by mistaken use of wrong kind of quotes.

 Will merge to 'master' in the third batch.


* fg/document-commit-message-stripping (2015-04-27) 1 commit
  (merged to 'next' on 2015-05-05 at 1892a99)
 + Documentation: clarify how "git commit" cleans up the edited log message

 Will merge to 'master' in the third batch.


* ah/usage-strings (2015-05-03) 2 commits
 - branch: fix funny-sounding error message
 - blame, log: format usage strings similarly to those in documentation

 A few usage string updates.  The tip one still needs work.


* jk/reading-packed-refs (2015-04-16) 9 commits
  (merged to 'next' on 2015-05-05 at 89b5694)
 + t1430: add another refs-escape test
 + read_packed_refs: avoid double-checking sane refs
 + strbuf_getwholeline: use getdelim if it is available
 + strbuf_getwholeline: avoid calling strbuf_grow
 + strbuf_addch: avoid calling strbuf_grow
 + config: use getc_unlocked when reading from file
 + strbuf_getwholeline: use getc_unlocked
 + git-compat-util: add fallbacks for unlocked stdio
 + strbuf_getwholeline: use getc macro

 Originally merged to 'next' on 2015-04-21

 An earlier rewrite to use strbuf_getwholeline() instead of fgets(3)
 to read packed-refs file revealed that the former is unacceptably
 inefficient.

 Will merge to 'master' in the second batch.


* kn/cat-file-literally (2015-05-04) 5 commits
 - fixup! sha1_file: support reading from a loose object of unknown type
 - t1006: add tests for git cat-file --allow-unknown-type
 - cat-file: teach cat-file a '--allow-unknown-type' option
 - cat-file: make the options mutually exclusive
 - sha1_file: support reading from a loose object of unknown type

 Add the "--allow-unknown-type" option to "cat-file" to allow
 inspecting loose objects of an experimental or a broken type.

 This is v10 $gmane/267960; I think with fixup! squashed in the
 series is in a good shape (the test may fail without Eric's fix
 to "hash-object --literally" elsewhere, though).


* lm/squelch-bg-progress (2015-04-15) 2 commits
  (merged to 'next' on 2015-05-05 at a2fe74d)
 + compat/mingw: stubs for getpgid() and tcgetpgrp()
 + progress: no progress in background

 Originally merged to 'next' on 2015-04-21

 Many long-running operations show progress eye-candy, even when
 they are later backgrounded.  Hide the eye-candy when the process
 is sent to the background instead.

 Will merge to 'master' in the second batch.


* va/p4-client-path (2015-04-23) 2 commits
  (merged to 'next' on 2015-05-05 at 852facc)
 + git-p4: improve client path detection when branches are used
 + t9801: check git-p4's branch detection with client spec enabled

 Originally merged to 'next' on 2015-04-23

 git p4 attempts to better handle branches in Perforce.

 Will merge to 'master' in the second batch.


* jk/sha1-file-reduce-useless-warnings (2015-03-30) 1 commit
  (merged to 'next' on 2015-05-05 at a8de68e)
 + sha1_file: squelch "packfile cannot be accessed" warnings

 Originally merged to 'next' on 2015-04-21

 Will merge to 'master' in the second batch.


* pt/credential-xdg (2015-03-25) 4 commits
  (merged to 'next' on 2015-05-05 at 0d6711f)
 + t0302: "unreadable" test needs POSIXPERM
 + t0302: test credential-store support for XDG_CONFIG_HOME
 + git-credential-store: support XDG_CONFIG_HOME
 + git-credential-store: support multiple credential files
 (this branch is used by pt/xdg-config-path.)

 Originally merged to 'next' on 2015-03-25

 Tweak the sample "store" backend of the credential helper to honor
 XDG configuration file locations when specified.

 Will merge to 'master' in the second batch.


* pt/xdg-config-path (2015-05-06) 7 commits
 - path.c: remove home_config_paths()
 - git-config: replace use of home_config_paths()
 - git-commit: replace use of home_config_paths()
 - credential-store.c: replace home_config_paths() with xdg_config_home()
 - dir.c: replace home_config_paths() with xdg_config_home()
 - attr.c: replace home_config_paths() with xdg_config_home()
 - path.c: implement xdg_config_home()
 (this branch uses pt/credential-xdg.)

 Code clean-up for xdg configuration path support.

 Will merge to 'next'.


* nd/diff-i-t-a (2015-03-23) 1 commit
  (merged to 'next' on 2015-05-05 at cba9cd9)
 + diff-lib.c: adjust position of i-t-a entries in diff

 Originally merged to 'next' on 2015-03-24

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

 Will merge to 'master' in the third batch.


* nd/slim-index-pack-memory-usage (2015-04-18) 2 commits
  (merged to 'next' on 2015-05-05 at 42bd845)
 + index-pack: kill union delta_base to save memory
 + index-pack: reduce object_entry size to save memory

 Originally merged to 'next' on 2015-04-21

 Memory usage of "git index-pack" has been trimmed by tens of
 per-cent.

 Will merge to 'master' in the second batch.


* nd/multiple-work-trees (2015-03-31) 41 commits
  (merged to 'next' on 2015-05-05 at 0f04a1c)
 + prune --worktrees: fix expire vs worktree existence condition
 + t1501: fix test with split index
 + t2026: fix broken &&-chain
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

 Originally merged to 'next' on 2015-04-02

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Will merge to 'master' in the second batch.
