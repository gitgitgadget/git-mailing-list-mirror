From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2015, #06; Fri, 22)
Date: Fri, 22 May 2015 15:14:02 -0700
Message-ID: <xmqqiobkdzv9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 00:14:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvvCq-0002pU-CZ
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 00:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbbEVWOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 18:14:11 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36118 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756929AbbEVWOG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 18:14:06 -0400
Received: by iepj10 with SMTP id j10so40695865iep.3
        for <git@vger.kernel.org>; Fri, 22 May 2015 15:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=e3N3MWOtuEzuXSxUGiN6d8DRL5Bx+z3suxqTnk8W2do=;
        b=Uo6CwNOtSAAFfD7oayt90FB4oA+V7UUkIN1nIThbfyXGjVTM7TWIepawTYPLFclcwH
         6i0qIaW3qjFOKpdYZ5/unbtnXJ59Rcwo297ODMDC5TjCeG19F/Sglf2kvEOGjGPwr3AL
         AMcNSdjYy/3d6EbetmEGuGsCRcmD6xQHp5m+0PinDj1iBPN6OtBxk1C7M5HTomJ6rLvf
         bylR3ib21xLkWnB6xxjpfiKWcUd6CbHGFTKARy+Dr3IjnE22bnxCE1B34T1G6w+tJkea
         dbhUuV2gB/8lYf6PfFPA02dVNzhAfowyqBtlo4X3IlJtmrx/Ly2mrsuRp/t92z6eHGxa
         WzvA==
X-Received: by 10.43.163.129 with SMTP id mo1mr2352983icc.61.1432332844994;
        Fri, 22 May 2015 15:14:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id i4sm223077igm.2.2015.05.22.15.14.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 15:14:03 -0700 (PDT)
X-master-at: 9532ead9875b7b92ff2007f9de61af5874e8839a
X-next-at: b70f6470d4a42c2efce07be8bc1edac7c5743a77
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269767>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The fourth batch of topics have been merged to 'master'.

The "untracked cache" series is in 'next', to give it a wider
exposure.  I do not use it personally, but it is meant to make life
easier for those with large amount of untracked cruft in their
working trees.  Please try it out and report successes (and of
course breakages, too).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* dl/branch-error-message (2015-05-06) 1 commit
  (merged to 'next' on 2015-05-11 at ed947ab)
 + branch: do not call a "remote-tracking branch" a "remote branch"

 Error messages from "git branch" called remote-tracking branches as
 "remote branches".


* dl/subtree-avoid-tricky-echo (2015-05-08) 1 commit
  (merged to 'next' on 2015-05-11 at 36d4f0e)
 + contrib/subtree: portability fix for string printing

 "git subtree" script (in contrib/) used "echo -n" to produce
 progress messages in a non-portable way.


* dl/subtree-push-no-squash (2015-05-07) 1 commit
  (merged to 'next' on 2015-05-11 at 74d07ca)
 + contrib/subtree: there's no push --squash

 "git subtree" script (in contrib/) does not have --squash option
 when pushing, but the documentation and help text pretended as if
 it did.


* ja/tutorial-asciidoctor-fix (2015-05-12) 1 commit
  (merged to 'next' on 2015-05-19 at f15d940)
 + doc: fix unmatched code fences

 A literal block in the tutorial had lines with unequal lengths to
 delimit it from the rest of the document, which choke GitHub's
 AsciiDoc renderer.


* jc/ignore-epipe-in-filter (2015-05-20) 2 commits
  (merged to 'next' on 2015-05-20 at 2b14ed7)
 + filter_buffer_or_fd(): ignore EPIPE
 + copy.c: make copy_fd() report its status silently

 Filter scripts were run with SIGPIPE disabled on the Git side,
 expecting that they may not read what Git feeds them to filter.
 We however treated a filter that does not read its input fully
 before exiting as an error.

 This changes semantics, but arguably in a good way.  If a filter
 can produce its output without consuming its input using whatever
 magic, we now let it do so, instead of diagnosing it as a
 programming error.


* jk/add-e-kill-editor (2015-05-12) 1 commit
  (merged to 'next' on 2015-05-19 at 9e01174)
 + add: check return value of launch_editor

 "git add -e" did not allow the user to abort the operation by
 killing the editor.


* jk/asciidoc-markup-fix (2015-05-14) 9 commits
  (merged to 'next' on 2015-05-19 at df0c63e)
 + doc: convert AsciiDoc {?foo} to ifdef::foo[]
 + doc: put example URLs and emails inside literal backticks
 + doc: drop backslash quoting of some curly braces
 + doc: convert \--option to --option
 + doc/add: reformat `--edit` option
 + doc: fix length of underlined section-title
 + doc: fix hanging "+"-continuation
 + doc: fix unquoted use of "{type}"
 + doc: fix misrendering due to `single quote'

 Various documentation mark-up fixes to make the output more
 consistent in general and also make AsciiDoctor (an alternative
 formatter) happier.


* jk/skip-http-tests-under-no-curl (2015-05-07) 2 commits
  (merged to 'next' on 2015-05-11 at a52b711)
 + tests: skip dav http-push tests under NO_EXPAT=NoThanks
 + t/lib-httpd.sh: skip tests if NO_CURL is defined

 Test clean-up.


* jk/stripspace-asciidoctor-fix (2015-05-12) 1 commit
  (merged to 'next' on 2015-05-19 at 12f9059)
 + doc: fix unmatched code fences in git-stripspace

 A literal block in the tutorial had lines with unequal lengths to
 delimit it from the rest of the document, which choke GitHub's
 AsciiDoc renderer.


* lm/squelch-bg-progress (2015-05-19) 1 commit
  (merged to 'next' on 2015-05-20 at 60916e6)
 + progress: treat "no terminal" as being in the foreground

 The controlling tty-based heuristics to squelch progress output did
 not consider that the process may not be talking to a tty at all
 (e.g. sending the progress to sideband #2).  This is a finishing
 touch to a topic that is already in 'master'.


* ls/http-ssl-cipher-list (2015-05-08) 1 commit
  (merged to 'next' on 2015-05-11 at 55764ce)
 + http: add support for specifying an SSL cipher list

 Introduce http.<url>.SSLCipherList configuration variable to tweak
 the list of cipher suite to be used with libcURL when talking with
 https:// sites.


* mg/log-decorate-HEAD (2015-05-13) 2 commits
  (merged to 'next' on 2015-05-19 at 009342b)
 + log: do not shorten decoration names too early
 + log: decorate HEAD with branch name under --decorate=full, too

 The "log --decorate" enhancement in Git 2.4 that shows the commit
 at the tip of the current branch e.g. "HEAD -> master", did not
 work with --decorate=full.


* mh/clone-verbosity-fix (2015-05-19) 1 commit
  (merged to 'next' on 2015-05-20 at f613575)
 + clone: call transport_set_verbosity before anything else on the newly created transport

 Git 2.4 broke setting verbosity and progress levels on "git clone"
 with native transports.


* mh/lockfile-retry (2015-05-14) 2 commits
  (merged to 'next' on 2015-05-20 at 7ad2e9d)
 + lock_packed_refs(): allow retries when acquiring the packed-refs lock
 + lockfile: allow file locking to be retried with a timeout

 Instead of dying immediately upon failing to obtain a lock, retry
 after a short while with backoff.


* mh/ref-directory-file (2015-05-11) 18 commits
  (merged to 'next' on 2015-05-19 at 38eb122)
 + reflog_expire(): integrate lock_ref_sha1_basic() errors into ours
 + ref_transaction_commit(): delete extra "the" from error message
 + ref_transaction_commit(): provide better error messages
 + rename_ref(): integrate lock_ref_sha1_basic() errors into ours
 + lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts
 + lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
 + verify_refname_available(): report errors via a "struct strbuf *err"
 + verify_refname_available(): rename function
 + refs: check for D/F conflicts among refs created in a transaction
 + ref_transaction_commit(): use a string_list for detecting duplicates
 + is_refname_available(): use dirname in first loop
 + struct nonmatching_ref_data: store a refname instead of a ref_entry
 + report_refname_conflict(): inline function
 + entry_matches(): inline function
 + is_refname_available(): convert local variable "dirname" to strbuf
 + is_refname_available(): avoid shadowing "dir" variable
 + is_refname_available(): revamp the comments
 + t1404: new tests of ref D/F conflicts within transactions

 The ref API did not handle cases where 'refs/heads/xyzzy/frotz' is
 removed at the same time as 'refs/heads/xyzzy' is added (or vice
 versa) very well.


* mh/write-refs-sooner-2.2 (2015-05-12) 8 commits
 + ref_transaction_commit(): fix atomicity and avoid fd exhaustion
 + ref_transaction_commit(): remove the local flags variable
 + ref_transaction_commit(): inline call to write_ref_sha1()
 + rename_ref(): inline calls to write_ref_sha1() from this function
 + commit_ref_update(): new function, extracted from write_ref_sha1()
 + write_ref_to_lockfile(): new function, extracted from write_ref_sha1()
 + t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
 + update-ref: test handling large transactions properly
 (this branch is used by mh/write-refs-sooner-2.3 and mh/write-refs-sooner-2.4.)

 Multi-ref transaction support we merged a few releases ago
 unnecessarily kept many file descriptors open, risking to fail with
 resource exhaustion.


* mh/write-refs-sooner-2.3 (2015-05-12) 1 commit
 + Merge branch 'mh/write-refs-sooner-2.2' into mh/write-refs-sooner-2.3
 (this branch is used by mh/write-refs-sooner-2.4; uses mh/write-refs-sooner-2.2.)

 Multi-ref transaction support we merged a few releases ago
 unnecessarily kept many file descriptors open, risking to fail with
 resource exhaustion.  This is for 2.3.x track.


* mh/write-refs-sooner-2.4 (2015-05-12) 9 commits
  (merged to 'next' on 2015-05-19 at f7be074)
 + Merge branch 'mh/write-refs-sooner-2.3' into mh/write-refs-sooner-2.4
 + ref_transaction_commit(): fix atomicity and avoid fd exhaustion
 + ref_transaction_commit(): remove the local flags variable
 + ref_transaction_commit(): inline call to write_ref_sha1()
 + rename_ref(): inline calls to write_ref_sha1() from this function
 + commit_ref_update(): new function, extracted from write_ref_sha1()
 + write_ref_to_lockfile(): new function, extracted from write_ref_sha1()
 + t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
 + update-ref: test handling large transactions properly
 (this branch uses mh/write-refs-sooner-2.2 and mh/write-refs-sooner-2.3.)

 Multi-ref transaction support we merged a few releases ago
 unnecessarily kept many file descriptors open, risking to fail with
 resource exhaustion.  This is for 2.4.x track.


* ps/bundle-verify-arg (2015-05-08) 1 commit
  (merged to 'next' on 2015-05-11 at 9f1b1ae)
 + bundle: verify arguments more strictly

 "git bundle verify" did not diagnose extra parameters on the
 command line.


* ps/doc-packfile-vs-pack-file (2015-05-17) 3 commits
  (merged to 'next' on 2015-05-20 at 7302174)
 + pack-protocol.txt: fix insconsistent spelling of "packfile"
 + git-unpack-objects.txt: fix inconsistent spelling of "packfile"
 + git-verify-pack.txt: fix inconsistent spelling of "packfile"

 Doc consistency updates.


* pt/pull-tags-error-diag (2015-05-14) 1 commit
  (merged to 'next' on 2015-05-20 at 6e1a5f1)
 + pull: remove --tags error in no merge candidates case

 There was a dead code that used to handle "git pull --tags" and
 show special-cased error message, which was made irrelevant when
 the semantics of the option changed back in Git 1.9 days.


* sb/t1020-cleanup (2015-05-18) 1 commit
  (merged to 'next' on 2015-05-20 at fa74b14)
 + subdirectory tests: code cleanup, uncomment test

 There was a commented-out (instead of being marked to expect
 failure) test that documented a breakage that was fixed since the
 test was written; turn it into a proper test.


* sg/completion-config (2015-05-12) 2 commits
  (merged to 'next' on 2015-05-19 at c83fde1)
 + completion: simplify query for config variables
 + completion: add a helper function to get config variables

 Code clean-up for completion script (in contrib/).


* sg/completion-omit-credential-helpers (2015-05-06) 1 commit
  (merged to 'next' on 2015-05-11 at aa7e554)
 + completion: remove credential helpers from porcelain commands

 The Git subcommand completion (in contrib/) listed credential
 helpers among candidates, which is not something the end user would
 invoke interatively.


* sg/help-subcommands (2015-05-08) 1 commit
  (merged to 'next' on 2015-05-11 at 91e4f9e)
 + command-list.txt: fix whitespace inconsistency
 (this branch is used by sg/help-group.)

 A preparatory clean-up step.

--------------------------------------------------
[New Topics]

* da/mergetool-winmerge (2015-05-20) 2 commits
 - mergetools: add winmerge as a builtin tool
 - mergetool--lib: set IFS for difftool and mergetool

 "git mergetool" learned to drive WinMerge as a backend.

 Will merge to 'next'.


* jk/http-backend-deadlock-2.2 (2015-05-20) 3 commits
 - http-backend: spool ref negotiation requests to buffer
 - t5551: factor out tag creation
 - http-backend: fix die recursion with custom handler
 (this branch is used by jk/http-backend-deadlock and jk/http-backend-deadlock-2.3.)

 Communication between the HTTP server and http_backend process can
 lead to a dead-lock when relaying a large ref negotiation request.
 Diagnose the situation better, and mitigate it by reading such a
 request first into core (to a reasonable limit).

 This was wiggled back to apply to the 2.2 maintenance track
 (original was for 2.4).

 Will merge to 'next'.


* jk/http-backend-deadlock-2.3 (2015-05-20) 1 commit
 - Merge branch 'jk/http-backend-deadlock-2.2' into jk/http-backend-deadlock-2.3
 (this branch is used by jk/http-backend-deadlock; uses jk/http-backend-deadlock-2.2.)

 Same for 2.3 maintenance track.

 Will merge to 'next'.


* jk/stash-options (2015-05-20) 2 commits
 - stash: recognize "--help" for subcommands
 - stash: complain about unknown flags

 Make "git stash something --help" error out, so that users can
 safely say "git stash drop --help".

 Will merge to 'next'.


* mc/commit-doc-grammofix (2015-05-19) 1 commit
 - Documentation/git-commit: grammofix

 Will merge to 'next'.


* rs/janitorial (2015-05-20) 3 commits
 - dir: remove unused variable sb
 - clean: remove unused variable buf
 - use file_exists() to check if a file exists in the worktree

 Will merge to 'next'.


* ah/send-email-postfix-alias (2015-05-21) 1 commit
 - git-send-email.perl: Add sendmail aliases support


* fm/fetch-raw-sha1 (2015-05-21) 5 commits
 - SQUASH
 - upload-pack: optionally allow fetching reachable sha1
 - SQUASH
 - upload-pack: prepare to extend allow-tip-sha1-in-want
 - config.txt: clarify allowTipSHA1InWant with camelCase

 "git upload-pack" that serves "git fetch" can be told to serve
 commits that are not at the tip of any ref as long as they are
 reachable from a ref with uploadpack.allowReachableSHA1InWant
 configuration variable.

 Will squash the fixes in and then merge to 'next'.


* jc/commit-slab (2015-05-22) 1 commit
 - commit-slab: introduce slabname##_peek() function

 Memory use reduction when commit-slab facility is used to annotate
 sparsely (which is not recommended in the first place).


* mm/rebase-i-post-rewrite-exec (2015-05-22) 3 commits
 - t5407: use <<- to align the expected output
 - rebase -i: fix post-rewrite hook with failed exec command
 - rebase -i: demonstrate incorrect behavior of post-rewrite

 "git rebase -i" fired post-rewrite hook when it shouldn't (namely,
 when it was told to stop sequencing with 'exec' insn).

 Will merge to 'next'.


* sb/submodule-doc-intro (2015-05-22) 1 commit
 - submodule documentation: reorder introductory paragraphs

 Will merge to 'next'.


* sb/test-bitmap-free-at-end (2015-05-22) 1 commit
 - test_bitmap_walk: free bitmap with bitmap_free

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

* dt/cat-file-follow-symlinks (2015-05-20) 3 commits
 - cat-file: add --follow-symlinks to --batch
 - sha1_name: get_sha1_with_context learns to follow symlinks
 - tree-walk: learn get_tree_entry_follow_symlinks

 "git cat-file --batch(-check)" learned the "--follow-symlinks"
 option that follows an in-tree symblic links when asked about an
 object via extended SHA-1 syntax, e.g. HEAD:RelNotes that points at
 Documentation/RelNotes/2.5.0.txt.  With the new option, the command
 behaves as if HEAD:Documentation/RelNotes/2.5.0.txt was given as
 input instead.

 Will merge to 'next'.


* dt/clean-pathspec-filter-then-lstat (2015-05-18) 1 commit
 - clean: only lstat files in pathspec

 "git clean pathspec..." tried to lstat(2) and complain even for
 paths outside the given pathspec.

 Will merge to 'next'.


* jh/filter-empty-contents (2015-05-18) 1 commit
 - sha1_file: pass empty buffer to index empty file

 The clean/smudge interface did not work well when filtering an
 empty contents (failed and then passed the empty input through).
 It can be argued that a filter that produces anything but empty for
 an empty input is nonsense, but if the user wants to do strange
 things, then why not?

 Will merge to 'next'.


* jk/http-backend-deadlock (2015-05-20) 1 commit
 - Merge branch 'jk/http-backend-deadlock-2.3' into jk/http-backend-deadlock
 (this branch uses jk/http-backend-deadlock-2.2 and jk/http-backend-deadlock-2.3.)

 Communication between the HTTP server and http_backend process can
 lead to a dead-lock when relaying a large ref negotiation request.
 Diagnose the situation better, and mitigate it by reading such a
 request first into core (to a reasonable limit).

 Will merge to 'next'.


* jk/rerere-forget-check-enabled (2015-05-14) 1 commit
  (merged to 'next' on 2015-05-19 at bfe67dc)
 + rerere: exit silently on "forget" when rerere is disabled

 "git rerere forget" in a repository without rerere enabled gave a
 cryptic error message; it should be a silent no-op instead.

 Will merge to 'master'.


* mm/log-format-raw-doc (2015-05-20) 2 commits
 - Documentation/log: clarify sha1 non-abbreviation in log --raw
 - Documentation/log: clarify what --raw means

 Clarify that "log --raw" and "log --format=raw" are unrelated
 concepts.

 Will merge to 'next'.


* pt/pull-ff-vs-merge-ff (2015-05-18) 2 commits
  (merged to 'next' on 2015-05-20 at 064a082)
 + pull: parse pull.ff as a bool or string
 + pull: make pull.ff=true override merge.ff

 The pull.ff configuration was supposed to override the merge.ff
 configuration, but it didn't.

 Will merge to 'master'.


* pt/pull-log-n (2015-05-18) 1 commit
  (merged to 'next' on 2015-05-20 at db6ce78)
 + pull: handle --log=<n>

 "git pull --log" and "git pull --no-log" worked as expected, but
 "git pull --log=20" did not.

 Will merge to 'master'.


* rs/plug-leak-in-pack-bitmaps (2015-05-19) 1 commit
  (merged to 'next' on 2015-05-20 at b70f647)
 + pack-bitmaps: plug memory leak, fix allocation size for recent_bitmaps

 The code to read pack-bitmap wanted to allocate a few hundred
 pointers to a structure, but by mistake allocated and leaked memory
 enough to hold that many actual structures.  Correct the allocation
 size and also have it on stack, as it is small enough.

 Will merge to 'master'.


* sg/help-group (2015-05-21) 5 commits
 - help: respect new common command grouping
 - command-list.txt: drop the "common" tag
 - generate-cmdlist: parse common group commands
 - command-list.txt: add the common groups block
 - command-list: prepare machinery for upcoming "common groups" section

 Group list of commands shown by "git help" along the workflow
 elements to help early learners.

 Will merge to 'next'.


* nd/untracked-cache (2015-03-12) 24 commits
  (merged to 'next' on 2015-05-19 at 26e619b)
 + git-status.txt: advertisement for untracked cache
 + untracked cache: guard and disable on system changes
 + mingw32: add uname()
 + t7063: tests for untracked cache
 + update-index: test the system before enabling untracked cache
 + update-index: manually enable or disable untracked cache
 + status: enable untracked cache
 + untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
 + untracked cache: mark index dirty if untracked cache is updated
 + untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
 + untracked cache: avoid racy timestamps
 + read-cache.c: split racy stat test to a separate function
 + untracked cache: invalidate at index addition or removal
 + untracked cache: load from UNTR index extension
 + untracked cache: save to an index extension
 + ewah: add convenient wrapper ewah_serialize_strbuf()
 + untracked cache: don't open non-existent .gitignore
 + untracked cache: mark what dirs should be recursed/saved
 + untracked cache: record/validate dir mtime and reuse cached output
 + untracked cache: make a wrapper around {open,read,close}dir()
 + untracked cache: invalidate dirs recursively if .gitignore changes
 + untracked cache: initial untracked cache validation
 + untracked cache: record .gitignore information and dir hierarchy
 + dir.c: optionally compute sha-1 of a .gitignore file

 Teach the index to optionally remember already seen untracked files
 to speed up "git status" in a working tree with tons of cruft.

 Will cook in 'next'.


* ld/p4-editor-multi-words (2015-05-20) 6 commits
 - SQUASH
 - git-p4: tests: use test-chmtime in place of touch
 - SQUASH
 - git-p4: fix handling of multi-word P4EDITOR
 - SQUASH
 - git-p4: add failing test for P4EDITOR handling

 Unlike "$EDITOR" and "$GIT_EDITOR" that can hold the path to the
 command and initial options (e.g. "/path/to/emacs -nw"), 'git p4'
 did not let the shell interpolate the contents of the environment
 variable that name the editor "$P4EDITOR" (and "$EDITOR", too).
 Make it in line with the rest of Git, as well as with Perforce.


* pt/pull-tests (2015-05-18) 8 commits
 - t5520: check reflog action in fast-forward merge
 - t5521: test --dry-run does not make any changes
 - t5520: test --rebase failure on unborn branch with index
 - t5520: test --rebase with multiple branches
 - t5520: test work tree fast-forward when fetch updates head
 - t5520: test for failure if index has unresolved entries
 - t5520: test no merge candidates cases
 - t5520: prevent field splitting in content comparisons

 Add more test coverage to "git pull".


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Still an early WIP


* jk/at-push-sha1 (2015-05-22) 16 commits
 - for-each-ref: accept "%(push)" format
 - for-each-ref: use skip_prefix instead of starts_with
 - sha1_name: implement @{push} shorthand
 - sha1_name: refactor interpret_upstream_mark
 - sha1_name: refactor upstream_mark
 - remote.c: add branch_get_push
 - remote.c: return upstream name from stat_tracking_info
 - remote.c: untangle error logic in branch_get_upstream
 - remote.c: report specific errors from branch_get_upstream
 - remote.c: introduce branch_get_upstream helper
 - remote.c: hoist read_config into remote_get_1
 - remote.c: provide per-branch pushremote name
 - remote.c: hoist branch.*.remote lookup out of remote_get_1
 - remote.c: drop "remote" pointer from "struct branch"
 - remote.c: refactor setup of branch->merge list
 - remote.c: drop default_remote_name variable

 Introduce <branch>@{push} short-hand to denote the remote-tracking
 branch that tracks the branch at the remote the <branch> would be
 pushed to.

 Will merge to 'next'.


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


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <messsage> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will merge to 'next' and keep there during the 2.5 cycle.


* ah/usage-strings (2015-05-03) 2 commits
 - branch: fix funny-sounding error message
 - blame, log: format usage strings similarly to those in documentation

 A few usage string updates.  The tip one still needs work.
