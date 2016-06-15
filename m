From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2013, #04; Fri, 18)
Date: Fri, 18 Oct 2013 15:14:49 -0700
Message-ID: <xmqq38nyw7ja.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 00:15:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXIJv-0006L9-5y
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 00:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab3JRWOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 18:14:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756553Ab3JRWOx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 18:14:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50D554BD3C;
	Fri, 18 Oct 2013 22:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	rieJMZRimhQlp2LRU76ZAAa0fE=; b=ZR86vCwccgAfzr7BBwOMsoQ49kwCKL4D7
	ZV7x99SRW5Yel88TEM1X2OL4HuYWpEXttiq9O+BDGESo5zuTVrDy2TbWM9ljGNoK
	OEvP4ooUspiLeiQ/QvB8by4H1EgEY2EhL7RzZzkX0Ru/reqcvBzcvMOS1m9y4nUp
	ZUaKqU0gfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=RvQ
	EA3nIPxl3mpS5sGrHceTkxpc4ZV7l/7HuY4sSPpx8wDOSE/BUCJUW4m1M+I65k+Q
	255ul0qSiFSLUhNpRov2sNzqd/XEzBQHYAkCxYUDR5uVXWh9NxTsxXvHoMRGVxk2
	0Jsc5RIp4IMI6EXBSw/kOz22wv830mAom2CHStJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F1FF4BD3A;
	Fri, 18 Oct 2013 22:14:52 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D5AA4BD30;
	Fri, 18 Oct 2013 22:14:51 +0000 (UTC)
X-master-at: db9bdfbeb044f73a01f6325f4ad61413666a2ce0
X-next-at: a09e2a8521091b0cc2a18d124507050f20dee1d0
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B56A829E-3842-11E3-A949-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236372>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* es/name-hash-no-trailing-slash-in-dirs (2013-09-17) 4 commits
  (merged to 'next' on 2013-09-20 at 9633d9a)
 + dir: revert work-around for retired dangerous behavior
 + name-hash: stop storing trailing '/' on paths in index_state.dir_hash
 + employ new explicit "exists in index?" API
 + name-hash: refactor polymorphic index_name_exists()

 Clean up the internal of the name-hash mechanism used to work
 around case insensitivity on some filesystems to cleanly fix a
 long-standing API glitch where the caller of cache_name_exists()
 that ask about a directory with a counted string was required to
 have '/' at one location past the end of the string.


* jc/checkout-detach-doc (2013-09-11) 1 commit
  (merged to 'next' on 2013-09-17 at 438cf13)
 + checkout: update synopsys and documentation on detaching HEAD

 "git checkout [--detach] <commit>" was listed poorly in the
 synopsis section of its documentation.


* jc/reflog-doc (2013-06-19) 1 commit
  (merged to 'next' on 2013-09-25 at 4eb0c14)
 + setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates them, but it
 is a leaf user that does not call out to or dot-source other
 scripts, so it does not urgently need to be fixed.


* jk/clone-progress-to-stderr (2013-09-18) 3 commits
  (merged to 'next' on 2013-09-25 at 137af9e)
 + clone: always set transport options
 + clone: treat "checking connectivity" like other progress
 + clone: send diagnostic messages to stderr

 Some progress and diagnostic messages from "git clone" were
 incorrectly sent to the standard output stream, not to the standard
 error stream.


* jk/format-patch-from (2013-09-20) 1 commit
  (merged to 'next' on 2013-09-20 at 0506530)
 + format-patch: print in-body "From" only when needed

 "format-patch --from=<whom>" forgot to omit unnecessary in-body
 from line, i.e. when <whom> is the same as the real author.


* jk/trailing-slash-in-pathspec (2013-09-13) 2 commits
  (merged to 'next' on 2013-09-17 at 18fe277)
 + reset: handle submodule with trailing slash
 + rm: re-use parse_pathspec's trailing-slash removal

 Code refactoring.


* lc/filter-branch-too-many-refs (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-17 at 31cd01a)
 + Allow git-filter-branch to process large repositories with lots of branches.

 "git filter-branch" in a repository with many refs blew limit of
 command line length.


* sb/repack-in-c (2013-09-17) 3 commits
  (merged to 'next' on 2013-09-25 at 7c47036)
 + repack: improve warnings about failure of renaming and removing files
 + repack: retain the return value of pack-objects
 + repack: rewrite the shell script in C

 Rerolled, and I think it is in a reasonably good shape.

--------------------------------------------------
[New Topics]

* mm/checkout-auto-track-fix (2013-10-18) 2 commits
 - checkout: proper error message on 'git checkout foo bar --'
 - checkout: allow dwim for branch creation for "git checkout $branch --"

 "git checkout topic", when there is not yet a local "topic" branch
 but there is a unique remote-tracking branch for a remote "topic"
 branch, pretended as if "git checkout -t -b topic remote/$r/topic"
 (for that unique remote $r) was run. This hack however was not
 implemented for "git checkout topic --".

 Will merge to 'next'.


* hn/log-graph-color-octopus (2013-10-18) 1 commit
 - graph: fix coloring around octopus merges

 Will merge to 'next'.


* nd/gc-lock-against-each-other (2013-10-18) 1 commit
 - gc: remove gc.pid file at end of execution

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* np/pack-v4 (2013-09-18) 90 commits
 - packv4-parse.c: add tree offset caching
 - t1050: replace one instance of show-index with verify-pack
 - index-pack, pack-objects: allow creating .idx v2 with .pack v4
 - unpack-objects: decode v4 trees
 - unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.


* sc/doc-howto-dumb-http (2013-10-16) 1 commit
 . doc/howto: warn about (dumb)http server document being too old

 The new text needs to go somewhere in the body of the document,
 not before the title line.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Holding until there is a caller to learn from.


* jc/ref-excludes (2013-09-03) 2 commits
 - document --exclude option
 - revision: introduce --exclude=<glob> to tame wildcards

 People often wished a way to tell "git log --branches" (and "git
 log --remotes --not --branches") to exclude some local branches
 from the expansion of "--branches" (similarly for "--tags", "--all"
 and "--glob=<pattern>").  Now they have one.

 Needs a matching change to rev-parse.


* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* fc/styles (2013-10-16) 7 commits
 - block-sha1/sha1.c: have SP around arithmetic operators
 - base85.c: have SP around arithmetic operators
 - archive.c: have SP around arithmetic operators
 - alloc.c: have SP around arithmetic operators
 - abspath.c: have SP around arithmetic operators
 - alias: have SP around arithmetic operators
 - C: have space around && and || operators

 C coding style fixes.  The ones near the tip have not been sent to
 the list yet (they cover the same kind of style violation as the
 second one) and I may either send them or drop some of them if they
 turn out to conflict with other work in flight---I still haven't
 caught up with the backlog and do not know.


* jk/remote-literal-string-leakfix (2013-10-15) 1 commit
  (merged to 'next' on 2013-10-18 at 6abddac)
 + remote: do not copy "origin" string literal

 Will merge to 'master'.


* jk/split-broken-ident (2013-10-15) 1 commit
  (merged to 'next' on 2013-10-18 at 8f4b8b7)
 + split_ident: parse timestamp from end of line

 Make the fall-back parsing of commit objects with broken author or
 committer lines more robust to pick up the timestamps.

 Will merge to 'master'.


* sg/prompt-svn-remote-fix (2013-10-15) 1 commit
  (merged to 'next' on 2013-10-18 at 20b47eb)
 + bash prompt: don't use '+=' operator in show upstream code path

 Bash portability fix.

 Will merge to 'master'.


* sg/t3600-nul-sha1-fix (2013-10-16) 1 commit
 - t3600: fix broken "choking git rm" test

 Will merge to 'next'.


* mg/more-textconv (2013-05-10) 7 commits
  (merged to 'next' on 2013-10-14 at 8a12490)
 + grep: honor --textconv for the case rev:path
 + grep: allow to use textconv filters
 + t7008: demonstrate behavior of grep with textconv
 + cat-file: do not die on --textconv without textconv filters
 + show: honor --textconv for blobs
 + diff_opt: track whether flags have been set explicitly
 + t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 Will merge to 'master'.


* ak/submodule-foreach-quoting (2013-09-27) 1 commit
  (merged to 'next' on 2013-10-14 at d77c5f1)
 + submodule foreach: skip eval for more than one argument

 A behavior change, but a worthwhile one: "git submodule foreach"
 was treating its arguments as part of a single command to be
 concatenated and passed to a shell, making writing buggy
 scripts too easy.

 This patch preserves the old "just pass it to the shell" behavior
 when a single argument is passed to 'git submodule foreach' and
 moves to a new "skip the shell and use the arguments passed
 unmolested" behavior when more than one argument is passed.

 The old behavior (always concatenating and passing to the shell)
 was similar to the 'ssh' command, while the new behavior (switching
 on the number of arguments) is what 'xterm -e' does.

 May need more thought to make sure this change is advertised well
 so that scripts that used multiple arguments but added their own
 extra layer of quoting are not broken.


* ew/keepalive (2013-10-16) 2 commits
  (merged to 'next' on 2013-10-16 at 56fd9f3)
 + http: use curl's tcp keepalive if available
  (merged to 'next' on 2013-10-14 at 24d786f)
 + http: enable keepalive on TCP sockets

 Will merge to 'master'.


* hu/cherry-pick-previous-branch (2013-10-10) 1 commit
  (merged to 'next' on 2013-10-14 at 090934f)
 + cherry-pick: handle "-" after parsing options

 "git cherry-pick" without further options would segfault.

 Could use a follow-up to handle '-' after argv[1] better.

 Will merge to 'master'.


* jc/pack-objects (2013-02-04) 1 commit
  (merged to 'next' on 2013-10-14 at 8e8feb6)
 + pack-objects: shrink struct object_entry

 Will merge to 'master'.


* jc/prompt-upstream (2013-10-14) 1 commit
  (merged to 'next' on 2013-10-14 at 270ef7b)
 + git-prompt.sh: optionally show upstream branch name

 An enhancement to the GIT_PS1_SHOWUPSTREAM facility.

 Will merge to 'master'.


* jk/http-auth-redirects (2013-10-14) 9 commits
 - remote-curl: rewrite base url from info/refs redirects
 - remote-curl: store url as a strbuf
 - remote-curl: make refs_url a strbuf
 - http: update base URLs when we see redirects
 - http: provide effective url to callers
 - http: hoist credential request out of handle_curl_result
  (merged to 'next' on 2013-10-14 at a0642be)
 + http: refactor options to http_get_*
 + http_request: factor out curlinfo_strbuf
 + http_get_file: style fixes

 Handle the case where http transport gets redirected during the
 authorization request better.

 Will merge to 'next'.


* jl/submodule-mv (2013-10-13) 1 commit
 - mv: Fix spurious warning when moving a file in presence of submodules

 Moving a regular file in a repository with a .gitmodules file was
 producing a warning 'Could not find section in .gitmodules where
 path=<filename>'.

 Will merge to 'next'.


* yt/shortened-rename (2013-10-18) 2 commits
 - SQUASH??? style fixes and s/omit/shorten/ where appropriate
 - diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible

 Attempts to give more weight on the fact that a filepair represents
 a rename than showing substring of the actual path when diffstat
 lines are not wide enough.

 I am not sure if that is solving a right problem, though.


* bc/gnome-keyring (2013-10-16) 16 commits
  (merged to 'next' on 2013-10-18 at 25024aa)
 + contrib/git-credential-gnome-keyring.c: support really ancient gnome-keyring
 + contrib/git-credential-gnome-keyring.c: support ancient gnome-keyring
 + contrib/git-credential-gnome-keyring.c: report failure to store password
 + contrib/git-credential-gnome-keyring.c: use glib messaging functions
 + contrib/git-credential-gnome-keyring.c: use glib memory allocation functions
 + contrib/git-credential-gnome-keyring.c: use secure memory for reading passwords
 + contrib/git-credential-gnome-keyring.c: use secure memory functions for passwds
 + contrib/git-credential-gnome-keyring.c: use gnome helpers in keyring_object()
 + contrib/git-credential-gnome-keyring.c: set Gnome application name
 + contrib/git-credential-gnome-keyring.c: ensure buffer is non-empty before accessing
 + contrib/git-credential-gnome-keyring.c: strlen() returns size_t, not ssize_t
 + contrib/git-credential-gnome-keyring.c: exit non-zero when called incorrectly
 + contrib/git-credential-gnome-keyring.c: add static where applicable
 + contrib/git-credential-gnome-keyring.c: *style* use "if ()" not "if()" etc.
 + contrib/git-credential-gnome-keyring.c: remove unused die() function
 + contrib/git-credential-gnome-keyring.c: remove unnecessary pre-declarations

 Cleanups and tweaks for credential handling to work with ancient versions
 of the gnome-keyring library that are still in use.

 Will merge to 'master'.


* kb/fast-hashmap (2013-10-18) 12 commits
 - SQUASH??? submodule.c: do not use ce after it gets freed by remove-cache-entry
 - remove old hash.[ch] implementation
 - read-cache.c: fix memory leaks caused by removed cache entries
 - name-hash.c: remove cache entries instead of marking them CE_UNHASHED
 - name-hash.c: use new hash map implementation for cache entries
 - name-hash.c: remove unreferenced directory entries
 - name-hash.c: use new hash map implementation for directories
 - diffcore-rename.c: use new hash map implementation
 - diffcore-rename.c: simplify finding exact renames
 - diffcore-rename.c: move code around to prepare for the next patch
 - buitin/describe.c: use new hash map implementation
 - add a hashtable implementation that supports O(1) removal

 Improvements to our hash table to get it to meet the needs of the
 msysgit fscache project, with some nice performance improvements.

 Replaced with a newer reroll; the tip one needs to be replaced with
 the version from Jens and should come before any of them.


* jc/revision-range-unpeel (2013-10-15) 1 commit
  (merged to 'next' on 2013-10-16 at d04ddfe)
 + revision: do not peel tags used in range notation

 "git rev-list --objects ^v1.0^ v1.0" gave v1.0 tag itself in the
 output, but "git rev-list --objects v1.0^..v1.0" did not.

 Will merge to 'master'.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Holding until needed.


* po/dot-url (2013-10-15) 3 commits
  (merged to 'next' on 2013-10-15 at 312d0af)
 + doc/cli: make "dot repository" an independent bullet point
  (merged to 'next' on 2013-09-20 at 6a12786)
 + config doc: update dot-repository notes
 + doc: command line interface (cli) dot-repository dwimmery

 Explain how '.' can be used to refer to the "current repository"
 in the documentation.

 Will merge to 'master'.


* jc/upload-pack-send-symref (2013-09-17) 7 commits
  (merged to 'next' on 2013-10-16 at eb1ae25)
 + clone: test the new HEAD detection logic
 + connect: annotate refs with their symref information in get_remote_head()
 + connect.c: make parse_feature_value() static
 + upload-pack: send non-HEAD symbolic refs
 + upload-pack: send symbolic ref information as capability
 + upload-pack.c: do not pass confusing cb_data to mark_our_ref()
 + t5505: fix "set-head --auto with ambiguous HEAD" test

 One long-standing flaw in the pack transfer protocol used by "git
 clone" was that there was no way to tell the other end which branch
 "HEAD" points at, and the receiving end needed to guess.  A new
 capability has been defined in the pack protocol to convey this
 information so that cloning from a repository with more than one
 branches pointing at the same commit where the HEAD is at now
 reliably sets the initial branch in the resulting repository.

 Will merge to 'master'.


* jx/relative-path-regression-fix (2013-10-14) 3 commits
  (merged to 'next' on 2013-10-18 at b4af45f)
 + Use simpler relative_path when set_git_dir
  (merged to 'next' on 2013-10-14 at 704b9ee)
 + relative_path should honor dos-drive-prefix
 + test: use unambigous leading path (/foo) for MSYS

 Will merge to 'master' and later to 'maint'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future

 Will cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* jc/pull-training-wheel (2013-07-19) 1 commit
  (merged to 'next' on 2013-08-28 at c39bd15)
 + pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 This topic has been reverted from 'next'.  Will wait for the
 conclusion of the discussion to seek a more user-friendly
 alternative; it is likely that it will be based on the simpler
 approach Felipe posted earlier.
