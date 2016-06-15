From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2015, #06; Wed, 24)
Date: Wed, 24 Jun 2015 14:14:53 -0700
Message-ID: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 23:15:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7s0e-0006v7-Ic
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 23:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbbFXVPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 17:15:00 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37927 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbFXVO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 17:14:56 -0400
Received: by igin14 with SMTP id n14so42761159igi.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=JNLYZt5Tgozq2NNdn/wkSCCbogzhdFpqcLwzosoPfIs=;
        b=pb883lYNzmwnw2ZHM+b/U6JRJ+iYEVVXRg2bAhDd7+53aTfUcj5hDgBEv4QK6bM1iB
         6oal0P+tYWcjtgl8Kaog/CJQ99+drCiGcboQgvY687iQOo2gfLzq8G2Ysi24c14ESCny
         EtRg5Zt5q60+loxM0Ly6V2QvXiSqNgDg3GxV2IxpSS4tB/ArCVwMpR5K5uEw2sQKszdj
         Z30uUvc69Q1MHdH+8PC3IqmRFZ0nL8X3eGfBEsgTO/Lu18uGMjz5UxvsAsT2qBhU9s6K
         lyl6kjVSD2adzLNXfZXNpjqheiwH301Ft0COSus2iMeK60Gl3B1IJI++m3JRAWrETXEo
         mOtg==
X-Received: by 10.107.148.144 with SMTP id w138mr56316923iod.12.1435180495843;
        Wed, 24 Jun 2015 14:14:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id fm3sm2122643igb.1.2015.06.24.14.14.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 14:14:55 -0700 (PDT)
X-master-at: df97e5dfeaea093e50afc15e44a23dfd3fa02502
X-next-at: 3f8b1d03318d3e5eff389ac0d3568f45053ae1fd
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272606>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Some of the topics in flight have overlaps with each other and have
been excluded from 'pu'; most notably, I think the remainder of
bc/object-id needs to wait until the for-each-ref topic from Karthik
settles and then rebased on it, or something.

We will be in the pre-release freeze soonish, and the next cycle
would reopen mid next month.  In the meantime, let's shift the focus
on making sure that what has already been merged to 'master' are
good (i.e. regression hunting and fixes).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* af/tcsh-completion-noclobber (2015-06-09) 1 commit
  (merged to 'next' on 2015-06-16 at 621f205)
 + git-completion.tcsh: fix redirect with noclobber

 The tcsh completion writes a bash scriptlet but that would have
 failed for users with noclobber set.


* es/configure-getdelim (2015-06-03) 2 commits
  (merged to 'next' on 2015-06-11 at cdead14)
 + configure: add getdelim() check
 + config.mak.uname: Darwin: define HAVE_GETDELIM for modern OS X releases

 Auto-detect availability of getdelim() that helps optimized version
 of strbuf_getwholeline().


* es/osx-header-pollutes-mask-macro (2015-06-03) 2 commits
  (merged to 'next' on 2015-06-11 at cd8c39e)
 + ewah: use less generic macro name
 + ewah/bitmap: silence warning about MASK macro redefinition


* es/send-email-sendmail-alias (2015-06-01) 10 commits
  (merged to 'next' on 2015-06-11 at b5e310e)
 + send-email: further warn about unsupported sendmail aliases features
 + t9001: add sendmail aliases line continuation tests
 + t9001: refactor sendmail aliases test infrastructure
 + send-email: implement sendmail aliases line continuation support
 + send-email: simplify sendmail aliases comment and blank line recognizer
 + send-email: refactor sendmail aliases parser
 + send-email: fix style: cuddle 'elsif' and 'else' with closing brace
 + send-email: drop noise comments which merely repeat what code says
 + send-email: visually distinguish sendmail aliases parser warnings
 + send-email: further document missing sendmail aliases functionality

 "git send-email" learned to handle more forms of sendmail style
 aliases file.


* es/utf8-stupid-compiler-workaround (2015-06-05) 1 commit
  (merged to 'next' on 2015-06-11 at dc0f2d2)
 + utf8: NO_ICONV: silence uninitialized variable warning

 A compilation workaround.


* fk/doc-format-patch-vn (2015-06-10) 1 commit
  (merged to 'next' on 2015-06-16 at 9be3516)
 + doc: format-patch: fix typo

 Docfix.


* jc/apply-reject-noop-hunk (2015-06-01) 1 commit
  (merged to 'next' on 2015-06-11 at 8063665)
 + apply: reject a hunk that does not do anything

 "git apply" cannot diagnose a patch corruption when the breakage is
 to mark the length of the hunk shorter than it really is on the
 hunk header line "@@ -l,k +m,n @@"; one special case it could is
 when the hunk becomes no-op (e.g. k == n == 2 for two-line context
 patch output), and it learned to do so for this special case.


* jc/do-not-feed-tags-to-clear-commit-marks (2015-06-01) 1 commit
  (merged to 'next' on 2015-06-11 at 65b4308)
 + format-patch: do not feed tags to clear_commit_marks()

 "git format-patch --ignore-if-upstream A..B" did not like to be fed
 tags as boundary commits.


* jc/ll-merge-expose-path (2015-06-04) 1 commit
  (merged to 'next' on 2015-06-11 at 5c5fe41)
 + ll-merge: pass the original path to external drivers

 Traditionally, external low-level 3-way merge drivers are expected
 to produce their results based solely on the contents of the three
 variants given in temporary files named by %O, %A and %B on their
 command line.  Additionally allow them to look at the final path
 (given by %P).


* jk/index-pack-reduce-recheck (2015-06-09) 1 commit
  (merged to 'next' on 2015-06-16 at ff83705)
 + index-pack: avoid excessive re-reading of pack directory

 Disable "have we lost a race with competing repack?" check while
 receiving a huge object transfer that runs index-pack.


* jk/stash-require-clean-index (2015-06-15) 1 commit
  (merged to 'next' on 2015-06-16 at beb4883)
 + Revert "stash: require a clean index to apply"

 A hotfix for the topic already in 'master'.


* js/sleep-without-select (2015-06-05) 4 commits
  (merged to 'next' on 2015-06-11 at 278edb1)
 + lockfile: wait using sleep_millisec() instead of select()
 + lockfile: convert retry timeout computations to millisecond
 + help.c: wrap wait-only poll() invocation in sleep_millisec()
 + lockfile: replace random() by rand()

 Portability fix.


* ld/p4-changes-block-size (2015-06-10) 4 commits
  (merged to 'next' on 2015-06-16 at 09b7daa)
 + git-p4: fixing --changes-block-size handling
 + git-p4: add tests for non-numeric revision range
 + git-p4: test with limited p4 server results
 + git-p4: additional testing of --changes-block-size

 More workaround for Perforce's row number limit in "git p4".


* mh/fsck-reflog-entries (2015-06-08) 2 commits
  (merged to 'next' on 2015-06-16 at 44e3202)
 + fsck: report errors if reflog entries point at invalid objects
 + fsck_handle_reflog_sha1(): new function

 "git fsck" used to ignore missing or invalid objects recorded in reflog.


* mh/reporting-broken-refs-from-for-each-ref (2015-06-08) 4 commits
  (merged to 'next' on 2015-06-16 at 31af2b8)
 + read_loose_refs(): treat NULL_SHA1 loose references as broken
 + read_loose_refs(): simplify function logic
 + for-each-ref: report broken references correctly
 + t6301: new tests of for-each-ref error handling

 "git for-each-ref" reported "missing object" for 0{40} when it
 encounters a broken ref.  The lack of object whose name is 0{40} is
 not the problem; the ref being broken is.


* nd/untracked-cache (2015-06-08) 1 commit
  (merged to 'next' on 2015-06-16 at 5e7df1d)
 + read-cache: fix untracked cache invalidation when split-index is used

 Hotfix for the 'untracked-cache' topic that is already in 'master'.


* pa/auto-gc-mac-osx (2015-06-12) 1 commit
  (merged to 'next' on 2015-06-16 at 151ec95)
 + hooks/pre-auto-gc: adjust power checking for newer OS X

 Recent Mac OS X updates breaks the logic to detect that the machine
 is on the AC power in the sample pre-auto-gc script.


* pt/am-abort-fix (2015-06-08) 6 commits
  (merged to 'next' on 2015-06-16 at 9cac1de)
 + am --abort: keep unrelated commits on unborn branch
 + am --abort: support aborting to unborn branch
 + am --abort: revert changes introduced by failed 3way merge
 + am --skip: support skipping while on unborn branch
 + am -3: support 3way merge on unborn branch
 + am --skip: revert changes introduced by failed 3way merge

 Various fixes around "git am" that applies a patch to a history
 that is not there yet.


* pt/pull-optparse (2015-06-02) 3 commits
  (merged to 'next' on 2015-06-11 at e252b4c)
 + pull: use git-rev-parse --parseopt for option parsing
 + pull: handle git-fetch's options as well
 + Merge branch 'pt/pull-tests' into pt/pull-optparse

 "git pull" has become more aware of the options meant for
 underlying "git fetch" and then learned to use parse-options
 parser.


* pt/t0302-needs-sanity (2015-06-12) 1 commit
  (merged to 'next' on 2015-06-16 at f0d8e17)
 + t0302: "unreadable" test needs SANITY prereq


* qn/blame-show-email (2015-06-01) 1 commit
  (merged to 'next' on 2015-06-11 at b4998e2)
 + blame: add blame.showEmail configuration

 "git blame" learned blame.showEmail configuration variable.


* rl/am-3way-config (2015-06-04) 3 commits
  (merged to 'next' on 2015-06-11 at 9b9910d)
 + git-am: add am.threeWay config variable
 + t4150-am: refactor am -3 tests
 + git-am.sh: fix initialization of the threeway variable

 "git am" learned am.threeWay configuration variable.


* sg/commit-cleanup-scissors (2015-06-09) 1 commit
  (merged to 'next' on 2015-06-16 at 988e23d)
 + commit: cope with scissors lines in commit message

 "git commit --cleanup=scissors" was not careful enough to protect
 against getting fooled by a line that looked like scissors.


* sg/completion-commit-cleanup (2015-06-08) 1 commit
  (merged to 'next' on 2015-06-16 at a9d1c77)
 + completion: teach 'scissors' mode to 'git commit --cleanup='

--------------------------------------------------
[New Topics]

* ad/bisect-terms (2015-06-24) 5 commits
 - bisect: allow any terms set by user
 - bisect: add the terms old/new
 - bisect: simplify the addition of new bisect terms
 - bisect: replace hardcoded "bad|good" by variables
 - bisect: correction of typo

 The use of 'good/bad' in "git bisect" made it confusing to use when
 hunting for a state change that is not a regression (e.g. bugfix).
 The command learned 'old/new' and then also allows the end user to
 choose the words via a new subcommand "git bisect terms $new $old".

 The last one is still iffy ($gmane/272554); perhaps split this
 at patch 4 and leave the last one as a separate topic.


* mh/tempfile (2015-06-10) 14 commits
 - credential-cache--daemon: use tempfile module
 - credential-cache--daemon: delete socket from main()
 - gc: use tempfile module to handle gc.pid file
 - lock_repo_for_gc(): compute the path to "gc.pid" only once
 - diff: use tempfile module
 - setup_temporary_shallow(): use tempfile module
 - write_shared_index(): use tempfile module
 - register_tempfile(): new function to handle an existing temporary file
 - tempfile: add several functions for creating temporary files
 - register_tempfile_object(): new function, extracted from create_tempfile()
 - commit_lock_file(): use get_locked_file_path()
 - lockfile: remove some redundant functions
 - tempfile: a new module for handling temporary files
 - Move lockfile API documentation to lockfile.h

 Rebuild "lockfile" API on top of a new "tempfile" API.
 This needs rerolling, to include "tempfile.h" in "lockfile.h", at
 least.

 Expecting a reroll.
 ($gmane/271353)


* nd/diff-i-t-a (2015-06-23) 1 commit
 - Revert "diff-lib.c: adjust position of i-t-a entries in diff"

 The "let's show paths added with -N as 'new' in status output"
 change was done without enough consideration on potential fallouts
 on the codepaths that do not have anything to do with "status" and
 caused regression to at least one widely used "wsadd" alias.

 We do not know how widespread the fallouts would be; while we
 determine if it is feasible to squash all the fallouts and move
 things forward until the upcoming release or it would take more
 time and better be postponed til the next cycle, I prepared this
 just in case we need to revert it.

--------------------------------------------------
[Stalled]

* sg/config-name-only (2015-05-28) 3 commits
 - completion: use new 'git config' options to reliably list variable names
 - SQUASH
 - config: add options to list only variable names

 "git config --list" output was hard to parse when values consist of
 multiple lines.  Introduce a way to show only the keys.

 Adding a single --name-only option may be a better way to go than
 adding two new options.

 Expecting a reroll.


* kb/i18n-doc (2015-06-15) 1 commit
 - Documentation/i18n.txt: clarify character encoding support

 Comments (other than $gmane/271657)?


* kb/use-nsec-doc (2015-06-15) 1 commit
 - Makefile / racy-git.txt: clarify USE_NSEC prerequisites

 Comments (other than $gmane/271656)?


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

 Expecting a reroll.
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


* nd/pathspec-strip-fix (2015-04-18) 1 commit
 - pathspec: adjust prefixlen after striping trailing slash

 Does not quite fix ($gmane/267614).
 Will discard.


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

 Waiting for a reroll.
 ($gmane/256591).


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

* js/fsck-opt (2015-06-23) 19 commits
 - fsck: support ignoring objects in `git fsck` via fsck.skiplist
 - fsck: git receive-pack: support excluding objects from fsck'ing
 - fsck: introduce `git fsck --connectivity-only`
 - fsck: support demoting errors to warnings
 - fsck: document the new receive.fsck.<msg-id> options
 - fsck: allow upgrading fsck warnings to errors
 - fsck: optionally ignore specific fsck issues completely
 - fsck: disallow demoting grave fsck errors to warnings
 - fsck: add a simple test for receive.fsck.<msg-id>
 - fsck: make fsck_tag() warn-friendly
 - fsck: handle multiple authors in commits specially
 - fsck: make fsck_commit() warn-friendly
 - fsck: make fsck_ident() warn-friendly
 - fsck: report the ID of the error/warning
 - fsck (receive-pack): allow demoting errors to warnings
 - fsck: offer a function to demote fsck errors to warnings
 - fsck: provide a function to parse fsck message IDs
 - fsck: introduce identifiers for fsck messages
 - fsck: introduce fsck options

 Allow ignoring fsck errors on specific set of known-to-be-bad
 objects, and also tweaking warning level of various kinds of non
 critical breakages reported.

 Will merge to 'next'.


* js/rebase-i-clean-up-upon-continue-to-skip (2015-06-23) 2 commits
 - rebase -i: do not leave a CHERRY_PICK_HEAD file behind
 - t3404: demonstrate CHERRY_PICK_HEAD bug

 Abandoning an already applied change in "git rebase -i" with
 "--continue" left CHERRY_PICK_HEAD and confused later steps.

 Will merge to 'next'.


* me/fetch-into-shallow-safety (2015-06-17) 1 commit
  (merged to 'next' on 2015-06-24 at 8ecc19a)
 + fetch-pack: check for shallow if depth given

 "git fetch --depth=<depth>" and "git clone --depth=<depth>" issued
 a shallow transfer request even to an upload-pack that does not
 support the capability.

 Will merge to 'master'.


* mm/describe-doc (2015-06-16) 1 commit
  (merged to 'next' on 2015-06-24 at 75e34cc)
 + Documentation/describe: improve one-line summary

 Docfix.

 Will merge to 'master'.


* rh/test-color-avoid-terminfo-in-original-home (2015-06-17) 2 commits
  (merged to 'next' on 2015-06-24 at 6af5fa7)
 + test-lib.sh: fix color support when tput needs ~/.terminfo
 + Revert "test-lib.sh: do tests for color support after changing HOME"

 An ancient test framework enhancement to allow color was not
 entirely correct; this makes it work even when tput needs to read
 from the ~/.terminfo under the user's real HOME directory.

 Will merge to 'master'.


* tb/checkout-doc (2015-06-17) 1 commit
 - git-checkout.txt: document "git checkout <pathspec>" better

 Doc update.

 Will merge to 'next'.


* jk/pretty-encoding-doc (2015-06-17) 1 commit
 - docs: clarify that --encoding can produce invalid sequences

 Doc update.

 Will merge to 'next'.


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Reroll exists but didn't pick it up as it seems to be still
 collecting review comments.

 Expecting a reroll.
 ($gmane/272180).


* bc/gpg-verify-raw (2015-06-22) 7 commits
  (merged to 'next' on 2015-06-24 at 08a1164)
 + verify-tag: add option to print raw gpg status information
 + verify-commit: add option to print raw gpg status information
 + gpg: centralize printing signature buffers
 + gpg: centralize signature check
 + verify-commit: add test for exit status on untrusted signature
 + verify-tag: share code with verify-commit
 + verify-tag: add tests

 "git verify-tag" and "git verify-commit" have been taught to share
 more code, and then learned to optionally show the verification
 message from the underlying GPG implementation.

 Will merge to 'master'.


* cb/parse-magnitude (2015-06-22) 2 commits
  (merged to 'next' on 2015-06-24 at 2fd7205)
 + parse-options: move unsigned long option parsing out of pack-objects.c
 + test-parse-options: update to handle negative ints

 Move machinery to parse human-readable scaled numbers like 1k, 4M,
 and 2G as an option parameter's value from pack-objects to
 parse-options API, to make it available to other codepaths.

 Will merge to 'master'.


* cb/subtree-tests-update (2015-06-22) 3 commits
  (merged to 'next' on 2015-06-24 at 31a2938)
 + contrib/subtree: small tidy-up to test
 + contrib/subtree: fix broken &&-chains and revealed test error
 + contrib/subtree: use tabs consitently for indentation in tests

 Tests update in contrib/subtree.

 Will merge to 'master'.


* da/mergetool-winmerge (2015-06-19) 1 commit
  (merged to 'next' on 2015-06-24 at 2fb10c4)
 + mergetool-lib: fix default tool selection

 Hotfix for an earlier change already in 'master' that broke the
 default tool selection for mergetool.

 Will merge to 'master'.


* jk/cat-file-batch-all (2015-06-22) 8 commits
 - cat-file: sort and de-dup output of --batch-all-objects
 - cat-file: add --batch-all-objects option
 - cat-file: split batch_one_object into two stages
 - cat-file: stop returning value from batch_one_object
 - cat-file: add --buffer option
 - cat-file: move batch_options definition to top of file
 - cat-file: minor style fix in options list
 - Merge branch 'jk/maint-for-each-packed-object' into jk/cat-file-batch-all
 (this branch uses jk/maint-for-each-packed-object.)

 "cat-file" learned "--batch-all-objects" option to enumerate all
 available objects in the repository more quickly than "rev-list
 --all --objects" (the output includes unreachable objects, though).

 Will merge to 'next'.


* jk/maint-for-each-packed-object (2015-06-22) 1 commit
  (merged to 'next' on 2015-06-24 at 162e134)
 + for_each_packed_object: automatically open pack index
 (this branch is used by jk/cat-file-batch-all.)

 The for_each_packed_object() API function did not iterate over
 objects in a packfile that hasn't been used yet.

 Will merge to 'master'.


* jk/pkt-log-pack (2015-06-16) 3 commits
 - pkt-line: support tracing verbatim pack contents
 - pkt-line: tighten sideband PACK check when tracing
 - pkt-line: simplify starts_with checks in packet tracing

 Enhance packet tracing machinery to allow capturing an incoming
 pack data to a file for debugging.

 Will merge to 'next'.


* kn/for-each-ref (2015-06-15) 11 commits
  (merged to 'next' on 2015-06-24 at 1a3a734)
 + ref-filter: make 'ref_array_item' use a FLEX_ARRAY for refname
 + for-each-ref: introduce filter_refs()
 + ref-filter: move code from 'for-each-ref'
 + ref-filter: add 'ref-filter.h'
 + for-each-ref: rename variables called sort to sorting
 + for-each-ref: rename some functions and make them public
 + for-each-ref: introduce 'ref_array_clear()'
 + for-each-ref: introduce new structures for better organisation
 + for-each-ref: rename 'refinfo' to 'ref_array_item'
 + for-each-ref: clean up code
 + for-each-ref: extract helper functions out of grab_single_ref()

 GSoC project to rebuild ref listing by branch and tag based on the
 for-each-ref machinery.  This is its first part.


* mh/init-delete-refs-api (2015-06-22) 19 commits
 - delete_ref(): use the usual convention for old_sha1
 - cmd_update_ref(): make logic more straightforward
 - update_ref(): don't read old reference value before delete
 - check_branch_commit(): make first parameter const
 - refs.h: add some parameter names to function declarations
 - refs: move the remaining ref module declarations to refs.h
 - initial_ref_transaction_commit(): check for ref D/F conflicts
 - initial_ref_transaction_commit(): check for duplicate refs
 - refs: remove some functions from the module's public interface
 - initial_ref_transaction_commit(): function for initial ref creation
 - repack_without_refs(): make function private
 - prune_refs(): use delete_refs()
 - prune_remote(): use delete_refs()
 - delete_refs(): bail early if the packed-refs file cannot be rewritten
 - delete_refs(): make error message more generic
 - delete_refs(): new function for the refs API
 - delete_ref(): handle special case more explicitly
 - remove_branches(): remove temporary
 - delete_ref(): move declaration to refs.h

 Clean up refs API and make "git clone" less intimate with the
 implementation detail.

 Will merge to 'next'.


* mh/replace-refs (2015-06-12) 1 commit
  (merged to 'next' on 2015-06-24 at cb13adf)
 + Allow to control where the replace refs are looked for

 Add an environment variable to tell Git to look into refs hierarchy
 other than refs/replace/ for the object replacement data.


* nd/multiple-work-trees (2015-06-12) 1 commit
  (merged to 'next' on 2015-06-24 at 7c3f918)
 + checkout: don't check worktrees when not necessary

 "git checkout [<tree-ish>] <paths>" spent unnecessary cycles
 checking if the current branch was checked out elsewhere, when we
 know we are not switching the branches ourselves.

 Will merge to 'master'.


* gp/status-rebase-i-info (2015-06-09) 5 commits
 - SQUASH??? fix misindent
 - status: add new tests for status during rebase -i
 - status: give more information during rebase -i
 - status: differentiate interactive from non-interactive rebases
 - status: factor two rebase-related messages together

 Teach "git status" to show a more detailed information regarding
 the "rebase -i" session in progress.

 Expecting a reroll.


* jc/prompt-document-ps1-state-separator (2015-06-10) 1 commit
  (merged to 'next' on 2015-06-24 at e4d1bad)
 + git-prompt.sh: document GIT_PS1_STATESEPARATOR

 Docfix.

 Will merge to 'master'.


* mk/utf8-no-iconv-warn (2015-06-08) 1 commit
 - utf8.c: print warning about disabled iconv

 Warn when a reencoding is requested in a build without iconv
 support, as the end user is likely to get an unexpected result.  I
 think the same level of safety should be added to a build with
 iconv support when the specified encoding is not available, but the
 patch does not go there.

 Expecting a reroll.


* mr/rebase-i-customize-insn-sheet (2015-06-15) 1 commit
 - git-rebase--interactive.sh: add config option for custom instruction format

 "git rebase -i"'s list of todo is made configurable.

 Will merge to 'next'.


* pt/am-foreign (2015-06-15) 5 commits
  (merged to 'next' on 2015-06-24 at 838c702)
 + am: teach mercurial patch parser how to read from stdin
 + am: use gmtime() to parse mercurial patch date
 + t4150: test applying StGit series
 + am: teach StGit patch parser how to read from stdin
 + t4150: test applying StGit patch

 Various enhancements around "git am" reading patches generated by
 foreign SCM.


* pt/pull-builtin (2015-06-18) 19 commits
 - pull: remove redirection to git-pull.sh
 - pull --rebase: error on no merge candidate cases
 - pull --rebase: exit early when the working directory is dirty
 - pull: configure --rebase via branch.<name>.rebase or pull.rebase
 - pull: teach git pull about --rebase
 - pull: set reflog message
 - pull: implement pulling into an unborn branch
 - pull: fast-forward working tree if head is updated
 - pull: check if in unresolved merge state
 - pull: support pull.ff config
 - pull: error on no merge candidates
 - pull: pass git-fetch's options to git-fetch
 - pull: pass git-merge's options to git-merge
 - pull: pass verbosity, --progress flags to fetch and merge
 - pull: implement fetch + merge
 - pull: implement skeletal builtin pull
 - argv-array: implement argv_array_pushv()
 - parse-options-cb: implement parse_opt_passthru_argv()
 - parse-options-cb: implement parse_opt_passthru()

 Reimplement 'git pull' in C.

 This is v4 ($gmane/271943).
 Comments from mentors and others?


* rl/send-email-aliases (2015-06-17) 10 commits
 - send-email: suppress meaningless whitespaces in from field
 - send-email: allow multiple emails using --cc, --to and --bcc
 - send-email: consider quote as delimiter instead of character
 - send-email: reduce dependancies impact on parse_address_line
 - send-email: minor code refactoring
 - send-email: allow use of aliases in the From field of --compose mode
 - send-email: refactor address list process
 - t9001-send-email: refactor header variable fields replacement
 - send-email: allow aliases in patch header and command script outputs
 - t9001-send-email: move script creation in a setup test

 "git send-email" now performs alias-expansion on names that are
 given via --cccmd, etc.

 This round comes with a lot more enhanced e-mail address parser,
 which makes it a bit scary, but as long as it works as designed, it
 makes it wonderful ;-).

 This is a lot older version than the latest round ($gmane/272499).
 Expecting a reroll.
 ($gmane/272517).


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Expecting a reroll.


* bc/object-id (2015-06-17) 10 commits
 . remote.c: use struct object_id in many functions
 . object-id: use struct object_id in struct object
 . remote.c: use struct object_id in ref_newer()
 . transport-helper.c: use struct object_id in push_refs_with_export()
 . connect.c: use struct object_id in get_remote_heads()
 . remote-curl: use struct object_id in parse_fetch()
 . fetch-pack: use struct object_id in add_sought_entry_mem()
 . object_id: convert struct ref to use object_id.
 . sha1_file: introduce has_object_file() helper
 . refs: convert some internal functions to use object_id

 More transition from "unsigned char[40]" to "struct object_id".

 While GSoC and other topics are actively moving existing code
 around, this cannot go in; ejected from 'pu'.


* jk/log-missing-default-HEAD (2015-06-03) 1 commit
 - log: diagnose empty HEAD more clearly

 "git init empty && git -C empty log" said "bad default revision 'HEAD'",
 which was found to be a bit confusing to new users.

 What's the status of this one?


* gr/rebase-i-drop-warn (2015-06-01) 2 commits
 - git rebase -i: warn about removed commits
 - git-rebase -i: add command "drop" to remove a commit

 Add "drop commit-object-name subject" command as another way to
 skip replaying of a commit in "rebase -i", and then punish those
 who do not use it (and instead just remove the lines) by throwing
 a warning.

 This is a lot older version than the latest round ($gmane/272420)
 Expecting a reroll.
 ($gmane/272506).


* jh/strbuf-read-use-read-in-full (2015-06-01) 1 commit
 - strbuf_read(): skip unnecessary strbuf_grow() at eof

 Avoid one extra iteration and strbuf_grow() of 8kB in
 strbuf_read().

 Looked reasonable; perhaps a log message clarification is needed.

 Expecting a reroll.


* mg/index-read-error-messages (2015-06-01) 2 commits
 - messages: uniform error messages for index write
 - show-index: uniform error messages for index read

 The tip was RFC.
 Expecting a reroll.


* hv/submodule-config (2015-06-15) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config API for lookup of .gitmodules values

 The gitmodules API accessed from the C code learned to cache stuff
 lazily.

 Looked reasonable from a cursory read.

 Will merge to 'next'.


* jc/push-tags-also (2015-05-29) 1 commit
 - push --tags: push tags *in addition to* other stuff

 "git fetch --tags" learned to fetch tags in addition to other stuff
 a few years ago, but "git push --tags" didn't.  Now it does.


* jc/commit-slab (2015-05-22) 1 commit
 - commit-slab: introduce slabname##_peek() function

 Memory use reduction when commit-slab facility is used to annotate
 sparsely (which is not recommended in the first place).


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Still an early WIP


* ee/clean-remove-dirs (2015-06-15) 5 commits
  (merged to 'next' on 2015-06-24 at 7c27821)
 + clean: improve performance when removing lots of directories
 + p7300: add performance tests for clean
 + t7300: add tests to document behavior of clean and nested git
 + setup: sanity check file size in read_gitfile_gently
 + setup: add gentle version of read_gitfile

 Replace "is this subdirectory a separate repository that should not
 be touched?" check "git clean" does by checking if it has .git/HEAD
 using the submodule-related code with a more optimized check.

 Will merge to 'master'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-05-28 at 6bfd8b9)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will keep in 'next' during the 2.5 cycle.
