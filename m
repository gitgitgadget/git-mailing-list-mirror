From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2016, #02; Mon, 6)
Date: Mon, 06 Jun 2016 22:58:44 -0700
Message-ID: <xmqqshwpsfor.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 07:59:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAA2c-0005nL-3L
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 07:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbcFGF6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 01:58:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751499AbcFGF6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 01:58:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 438871A913;
	Tue,  7 Jun 2016 01:58:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	knEXdg3ZyMt136/XG7lqcQIpbU=; b=RZK5I6pUPpBzJnZpTiFFnAPzWCnn/2UBK
	z/W82sUNdQYE39OZe4A7mVkbj/5iLf684rY+chvoUUPwa+kCQLQMR08KNnWvGzYS
	FfsMVWGG0Ks0XdK0f2dpdkHHpxBMYrS93fviGTcL0mBxqPhWTWOR3JBrEHmC2mUR
	hQ2xLIr3+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=fJv
	6fZfatuBd4Yz6rXz7xzEyrwf/mPshPESHG/0VD2cL5mIV8SX9rKnZnmIlJ2zQSBQ
	dGrAivvH7FFUhy5bSaMh9q5RDP7Pwju6FwuBcyNxkN5Qs3ljh1KzofE6BqYkdS4Z
	xhteEITpZ6ma9vUFZ5RDP4+2+rLnuHOEPCIG4qbE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C46F1A912;
	Tue,  7 Jun 2016 01:58:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77DCA1A90F;
	Tue,  7 Jun 2016 01:58:46 -0400 (EDT)
X-master-at: 49fa3dc76179e04b0833542fa52d0f287a4955ac
X-next-at: 3cd93d08f085fd56ac81614bd2e920c3b50eacec
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5D2E5A6-2C74-11E6-B9FC-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296599>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The hopefully final release candidate 2.9-rc2 together with 2.8.4
has been pushed out.

By the way, the tip of 'pu' is not expected to pass its own test
suite, due to multiple broken topics queued near its tip. Earlier
there was a talk about automatically bisecting breakage on 'pu', but
tonight's pushout is a good illustration why that would not be very
useful.  What would be useful is (1) enumeration of commits on the
first parent chain on master..pu, (2) test of the second parent of
each of the commits found in (1), and (3) bisection between the
broken commits in (2) and 'master', which would highlight broken
topics and the commit(s) that might be responsible for each broken
topic.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bd/readme.markdown-more (2016-05-31) 1 commit
  (merged to 'next' on 2016-06-02 at 1de7554)
 + README.md: format CLI commands with code syntax

 The mark-up in the top-level README.md file has been updated to
 typeset CLI command names differently from the body text.


* em/man-bold-literal (2016-05-31) 1 commit
  (merged to 'next' on 2016-06-02 at efb4156)
 + Documentation: bold literals in man

 The manpage output of our documentation did not render well in
 terminal; typeset literals in bold by default to make them stand
 out more.


* js/perf-rebase-i (2016-05-31) 1 commit
  (merged to 'next' on 2016-05-31 at 39d8dc8)
 + perf: make the tests work without a worktree

 The one in 'master' has a brown-paper-bag bug that breaks the perf
 test when used inside a usual Git repository with a working tree.


* js/rebase-i-dedup-call-to-rerere (2016-05-31) 1 commit
  (merged to 'next' on 2016-05-31 at db1f9e3)
 + rebase -i: remove an unnecessary 'rerere' invocation

 "git rebase -i", after it fails to auto-resolve the conflict, had
 an unnecessary call to "git rerere" from its very early days, which
 was spotted recently; the call has been removed.


* mm/makefile-developer-can-be-in-config-mak (2016-06-01) 2 commits
  (merged to 'next' on 2016-06-02 at f3a0678)
 + Makefile: add $(DEVELOPER_CFLAGS) variable
 + Makefile: move 'ifdef DEVELOPER' after config.mak* inclusion

 "make DEVELOPER=1" worked as expected; setting DEVELOPER=1 in
 config.mak didn't.


* mr/send-email-doc-gmail-2fa (2016-06-01) 1 commit
  (merged to 'next' on 2016-06-02 at cd2ade8)
 + Documentation/git-send-email: fix typo in gmail 2FA section

 Typofix.


* pa/cherry-pick-doc-typo (2016-05-29) 1 commit
  (merged to 'next' on 2016-06-02 at e2c2457)
 + git-cherry-pick.txt: correct a small typo

 "git cherry-pick --help" had three instances of word "behavior",
 one of which was spelled "behaviour", which is updated to match the
 other two.


* rs/apply-name-terminate (2016-05-29) 1 commit
  (merged to 'next' on 2016-06-02 at 8df9332)
 + apply: remove unused parameters from name_terminate()

 Code clean-up.


* rs/patch-id-use-skip-prefix (2016-05-29) 1 commit
  (merged to 'next' on 2016-06-02 at c993de3)
 + patch-id: use starts_with() and skip_prefix()

 Code clean-up.


* sb/submodule-helper-list-signal-unmatch-via-exit-status (2016-06-01) 1 commit
  (merged to 'next' on 2016-06-02 at 29064a2)
 + submodule--helper: offer a consistent API
 (this branch is used by sb/submodule-helper-relative-path.)

 The way how "submodule--helper list" signals unmatch error to its
 callers has been updated.


* sb/submodule-helper-relative-path (2016-06-01) 1 commit
  (merged to 'next' on 2016-06-02 at 8a191e1)
 + submodule: remove bashism from shell script
 (this branch uses sb/submodule-helper-list-signal-unmatch-via-exit-status.)

 A bash-ism "local" has been removed from "git submodule" scripted
 Porcelain.

--------------------------------------------------
[New Topics]

* wd/userdiff-css (2016-06-03) 1 commit
  (merged to 'next' on 2016-06-06 at 536102f)
 + userdiff: add built-in pattern for CSS

 Update the funcname definition to support css files.

 Will merge to 'master' after 2.9 final.


* jc/attr-more (2016-06-03) 2 commits
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 (this branch uses jc/attr; is tangled with sb/pathspec-label and sb/submodule-default-paths.)

 The beginning of long and tortuous journey to clean-up attribute
 subsystem implementation.


* jk/rev-list-count-with-bitmap (2016-06-03) 2 commits
  (merged to 'next' on 2016-06-06 at dd9b30f)
 + rev-list: disable bitmaps when "-n" is used with listing objects
 + rev-list: "adjust" results of "--count --use-bitmap-index -n"

 "git rev-list --count" whose walk-length is limited with "-n"
 option did not work well with the counting optimized to look at the
 bitmap index.

 Will merge to 'master' after 2.9 final.


* mh/ref-iterators (2016-06-03) 13 commits
  (merged to 'next' on 2016-06-06 at c8e79dc)
 + for_each_reflog(): reimplement using iterators
 + dir_iterator: new API for iterating over a directory tree
 + for_each_reflog(): don't abort for bad references
 + do_for_each_ref(): reimplement using reference iteration
 + refs: introduce an iterator interface
 + ref_resolves_to_object(): new function
 + entry_resolves_to_object(): rename function from ref_resolves_to_object()
 + get_ref_cache(): only create an instance if there is a submodule
 + remote rm: handle symbolic refs correctly
 + delete_refs(): add a flags argument
 + refs: use name "prefix" consistently
 + do_for_each_ref(): move docstring to the header file
 + refs: remove unnecessary "extern" keywords
 (this branch uses mh/split-under-lock.)

 The API to iterate over all the refs (i.e. for_each_ref(), etc.)
 has been revamped.

 Will merge to 'master' after 2.9 final.


* ew/mboxrd-format-am (2016-06-06) 3 commits
 - am: support --patch-format=mboxrd
 - mailsplit: support unescaping mboxrd messages
 - pretty: support "mboxrd" output format

 Teach format-patch and mailsplit (hence "am") how a line that
 happens to begin with "From " in the e-mail message is quoted with
 ">", so that these lines can be restored to their original shape.


* lf/receive-pack-auto-gc-to-client (2016-06-06) 1 commit
 - receive-pack: send auto-gc output over sideband 2

 Allow messages that are generated by auto gc during "git push" on
 the receiving end to be explicitly passed back to the sending end
 over sideband, so that they are shown with "remote: " prefix to
 avoid confusing the users.


* mg/cherry-pick-multi-on-unborn (2016-06-06) 1 commit
 - cherry-pick: allow to pick to unborn branches

 "git cherry-pick A" worked on an unborn branch, but "git
 cherry-pick A..B" didn't.


* mj/log-show-signature-conf (2016-06-06) 2 commits
 - log: "--no-show-signature" commmand-line option
 - log: add "log.showsignature" configuration variable

 "git log" learns log.showSignature configuration variable, and a
 command line option "--no-show-signature" to countermand it.

 The order of the commits in the topic need to be reversed.


* nd/i-t-a-commitable (2016-06-06) 3 commits
 - commit: don't count i-t-a entries when checking if the new commit is empty
 - Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
 - diff.h: extend "flags" field to 64 bits because we're out of bits


* sg/reflog-past-root (2016-06-06) 1 commit
 - reflog: continue walking the reflog past root commits

 "git reflog" stopped upon seeing an entry that denotes a branch
 creation event (aka "unborn"), which made it appear as if the
 reflog was truncated.


* tb/complete-status (2016-06-06) 3 commits
 - completion: add git status
 - completion: add __git_get_option_value helper
 - completion: factor out untracked file modes into a variable

 The completion script (in contrib/) learned to complete "git
 status" options.


* tr/doc-tt (2016-06-06) 3 commits
 - doc: change configuration variables format
 - doc: change environment variables format
 - doc: clearer rule about formatting literals

 The documentation set has been updated so that literal commands,
 configuration variables and environment variables are consistently
 typeset in fixed-width font and bold in manpages.


* vs/prompt-avoid-unset-variable (2016-06-06) 1 commit
 - git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION, $short_sha

 The git-prompt scriptlet (in contrib/) was not friendly with those
 who uses "set -u", which has been fixed.


* rj/compat-regex-size-max-fix (2016-06-06) 1 commit
 - regex: fix a SIZE_MAX macro redefinition warning

 A compilation fix.

 Will merge to 'next'.


* bc/cocci-object-id (2016-06-06) 8 commits
 - merge-recursive: convert merge_recursive_generic to object_id
 - merge-recursive: convert leaf functions to use struct object_id
 - merge-recursive: convert struct merge_file_info to object_id
 - merge-recursive: convert struct stage_data to use object_id
 - Rename struct diff_filespec's sha1_valid member.
 - Convert struct diff_filespec to struct object_id
 - Apply standard object_id Coccinelle transformations.
 - Add basic Coccinelle transforms.

 Move from "unsigned char [20]" to "struct object_id" continues,
 with help from an automated tool.

--------------------------------------------------
[Stalled]

* sb/bisect (2016-04-15) 22 commits
 - SQUASH???
 - bisect: get back halfway shortcut
 - bisect: compute best bisection in compute_relevant_weights()
 - bisect: use a bottom-up traversal to find relevant weights
 - bisect: prepare for different algorithms based on find_all
 - bisect: rename count_distance() to compute_weight()
 - bisect: make total number of commits global
 - bisect: introduce distance_direction()
 - bisect: extract get_distance() function from code duplication
 - bisect: use commit instead of commit list as arguments when appropriate
 - bisect: replace clear_distance() by unique markers
 - bisect: use struct node_data array instead of int array
 - bisect: get rid of recursion in count_distance()
 - bisect: make algorithm behavior independent of DEBUG_BISECT
 - bisect: make bisect compile if DEBUG_BISECT is set
 - bisect: plug the biggest memory leak
 - bisect: add test for the bisect algorithm
 - t6030: generalize test to not rely on current implementation
 - t: use test_cmp_rev() where appropriate
 - t/test-lib-functions.sh: generalize test_cmp_rev
 - bisect: allow 'bisect run' if no good commit is known
 - bisect: write about `bisect next` in documentation

 The internal algorithm used in "git bisect" to find the next commit
 to check has been optimized greatly.

 Expecting a reroll.
 ($gmane/291163)


* nd/shallow-deepen (2016-04-13) 26 commits
 - fetch, upload-pack: --deepen=N extends shallow boundary by N commits
 - upload-pack: add get_reachable_list()
 - upload-pack: split check_unreachable() in two, prep for get_reachable_list()
 - t5500, t5539: tests for shallow depth excluding a ref
 - clone: define shallow clone boundary with --shallow-exclude
 - fetch: define shallow boundary with --shallow-exclude
 - upload-pack: support define shallow boundary by excluding revisions
 - refs: add expand_ref()
 - t5500, t5539: tests for shallow depth since a specific date
 - clone: define shallow clone boundary based on time with --shallow-since
 - fetch: define shallow boundary with --shallow-since
 - upload-pack: add deepen-since to cut shallow repos based on time
 - shallow.c: implement a generic shallow boundary finder based on rev-list
 - fetch-pack: use a separate flag for fetch in deepening mode
 - fetch-pack.c: mark strings for translating
 - fetch-pack: use a common function for verbose printing
 - fetch-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move rev-list code out of check_non_tip()
 - upload-pack: tighten number parsing at "deepen" lines
 - upload-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move "unshallow" sending code out of deepen()
 - upload-pack: remove unused variable "backup"
 - upload-pack: move "shallow" sending code out of deepen()
 - upload-pack: move shallow deepen code out of receive_needs()
 - transport-helper.c: refactor set_helper_option()
 - remote-curl.c: convert fetch_git() to use argv_array

 The existing "git fetch --depth=<n>" option was hard to use
 correctly when making the history of an existing shallow clone
 deeper.  A new option, "--deepen=<n>", has been added to make this
 easier to use.  "git clone" also learned "--shallow-since=<date>"
 and "--shallow-exclude=<tag>" options to make it easier to specify
 "I am interested only in the recent N months worth of history" and
 "Give me only the history since that version".

 Needs review.


* sg/completion-updates (2016-02-28) 21 commits
 . completion: cache the path to the repository
 . completion: extract repository discovery from __gitdir()
 . completion: don't guard git executions with __gitdir()
 . completion: consolidate silencing errors from git commands
 . completion: don't use __gitdir() for git commands
 . completion: respect 'git -C <path>'
 . completion: fix completion after 'git -C <path>'
 . completion: don't offer commands when 'git --opt' needs an argument
 . rev-parse: add '--absolute-git-dir' option
 . completion: list short refs from a remote given as a URL
 . completion: don't list 'HEAD' when trying refs completion outside of a repo
 . completion: list refs from remote when remote's name matches a directory
 . completion: respect 'git --git-dir=<path>' when listing remote refs
 . completion: fix most spots not respecting 'git --git-dir=<path>'
 . completion: ensure that the repository path given on the command line exists
 . completion tests: add tests for the __git_refs() helper function
 . completion tests: check __gitdir()'s output in the error cases
 . completion tests: consolidate getting path of current working directory
 . completion tests: make the $cur variable local to the test helper functions
 . completion tests: don't add test cruft to the test repository
 . completion: improve __git_refs()'s in-code documentation

 Will be rerolled.
 ($gmane/287839)


* az/p4-bare-no-rebase (2016-02-19) 1 commit
 - git-p4.py: Don't try to rebase on submit from bare repository

 "git p4 submit" attempts to do a rebase, which would fail if done
 in a bare repository.  Not doing this rebase would paper over the
 failure, which is what this patch does, but it is unclear what the
 side effect of not rebasing is.

 Needs a better explanation.


* nd/icase (2016-02-15) 12 commits
 - grep.c: reuse "icase" variable
 - diffcore-pickaxe: support case insensitive match on non-ascii
 - diffcore-pickaxe: "share" regex error handling code
 - grep/pcre: support utf-8
 - gettext: add is_utf8_locale()
 - grep/pcre: prepare locale-dependent tables for icase matching
 - grep/icase: avoid kwsset when -F is specified
 - grep/icase: avoid kwsset on literal non-ascii strings
 - test-regex: expose full regcomp() to the command line
 - test-regex: isolate the bug test code
 - grep: break down an "if" stmt in preparation for next changes
 - grep: allow -F -i combination

 "git grep -i" has been taught to fold case in non-ascii locales.

 Needs review.
 ($gmane/286137)


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* dg/subtree-rebase-test (2016-01-19) 1 commit
 - contrib/subtree: Add a test for subtree rebase that loses commits

 Reviewed up to v5.
 Will be rerolled.
 ($gmane/284426)


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, the change needs to be backed up by numbers.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.

 Will be rerolled.
 ($gmane/292205)


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for a reroll.
 ($gmane/284368).


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


* jc/merge-impossible-no-commit (2016-04-26) 2 commits
 - merge: warn --no-commit merge when no new commit is created
 - merge: do not contaminate option_commit with --squash

 "git merge --no-commit" silently succeeded when there is no need to
 create any commit, either when you are more recent than the commit
 you tried to merge, or you can fast-forward to the commit you tried
 to merge.  The command gives a warning message in such cases.

 Just tying loose ends in a discussion.  Unless somebody else
 champions this topic, I'll drop it.

 Will discard.

--------------------------------------------------
[Cooking]

* et/add-chmod-x (2016-06-01) 2 commits
 - SQUASH??? add: add --chmod=+x / --chmod=-x options
 - add: add --chmod=+x / --chmod=-x options

 Waiting for a reroll (or ack for proposed fixup).


* jc/t2300-setup (2016-06-01) 1 commit
  (merged to 'next' on 2016-06-06 at 20f7f83)
 + t2300: run git-sh-setup in an environment that better mimics the real life

 A test fix.

 Will merge to 'master'.


* jk/shell-portability (2016-06-01) 2 commits
  (merged to 'next' on 2016-06-06 at 5de784e)
 + t5500 & t7403: lose bash-ism "local"
 + test-lib: add in-shell "env" replacement

 test fixes.

 Will merge to 'master'.


* mh/connect (2016-06-06) 10 commits
 - connect: [host:port] is legacy for ssh
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Ok, folks, is everybody happy with this version?


* aq/upload-pack-use-parse-options (2016-05-31) 1 commit
  (merged to 'next' on 2016-06-06 at 505f1ee)
 + upload-pack.c: use parse-options API

 "git upload-pack" command has been updated to use the parse-options
 API.

 Will merge to 'master' after 2.9 final.


* jc/clear-pathspec (2016-06-02) 1 commit
  (merged to 'next' on 2016-06-06 at 9e7e291)
 + pathspec: rename free_pathspec() to clear_pathspec()

 We usually call a function that clears the contents a data
 structure X without freeing the structure itself clear_X(), and
 call a function that does clear_X() and also frees it free_X().
 free_pathspec() function has been renamed to clear_pathspec()
 to avoid confusion.

 Will merge to 'master' after 2.9 final.


* sb/submodule-recommend-shallowness (2016-05-27) 2 commits
  (merged to 'next' on 2016-05-31 at 1ee161c)
 + submodule update: learn `--[no-]recommend-shallow` option
 + submodule-config: keep shallow recommendation around

 An upstream project can make a recommendation to make only a
 shallow clone for some submodules in the .gitmodules file it ship.

 Will merge to 'master' after 2.9 final.


* tb/convert-peek-in-index (2016-05-24) 2 commits
 - convert: ce_compare_data() checks for a sha1 of a path
 - read-cache: factor out get_sha1_from_index() helper

 The motivation is rather iffy.


* va/i18n-even-more (2016-05-26) 22 commits
 - t5523: use test_i18ngrep for negation
 - t4153: fix negated test_i18ngrep call
 - t9003: become resilient to GETTEXT_POISON
 - tests: unpack-trees: update to use test_i18n* functions
 - tests: use test_i18n* functions to suppress false positives
 - i18n: setup: mark strings for translation
 - i18n: rebase-interactive: mark comments of squash for translation
 - i18n: rebase-interactive: mark here-doc strings for translation
 - i18n: rebase-interactive: mark strings for translation
 - i18n: git-sh-setup.sh: mark strings for translation
 - t6030: update to use test_i18ncmp
 - i18n: bisect: simplify error message for i18n
 - i18n: rebase: mark placeholder for translation
 - i18n: rebase: fix marked string to use eval_gettext variant
 - merge-octupus: use die shell function from git-sh-setup.sh
 - i18n: merge-octopus: mark messages for translation
 - i18n: sequencer: mark string for translation
 - i18n: sequencer: mark entire sentences for translation
 - i18n: transport: mark strings for translation
 - i18n: advice: internationalize message for conflicts
 - i18n: advice: mark string about detached head for translation
 - i18n: builtin/remote.c: fix mark for translation

 More markings of messages for i18n, with updates to various tests
 to pass GETTEXT_POISON tests.

 Is everybody happy with this version?


* jg/dash-is-last-branch-in-worktree-add (2016-05-31) 1 commit
  (merged to 'next' on 2016-06-02 at 3959ef6)
 + worktree: allow "-" short-hand for @{-1} in add command

 "git worktree add" learned that '-' can be used as a short-hand for
 "@{-1}", the previous branch.

 Will merge to 'master' after 2.9 final.


* dk/blame-move-no-reason-for-1-line-context (2016-05-29) 1 commit
 - blame: require 0 context lines while finding moved lines with -M

 "git blame -M" missed a single line that was moved within the file.

 We may want to squash a test or two to this commit.  Volunteers?


* nd/worktree-lock (2016-06-03) 6 commits
 - worktree.c: find_worktree() search by path suffix
 - worktree: add "unlock" command
 - worktree: add "lock" command
 - worktree.c: add is_worktree_locked()
 - worktree.c: add is_main_worktree()
 - worktree.c: add find_worktree()
 (this branch uses nd/worktree-cleanup-post-head-protection.)

 "git worktree prune" protected worktrees that are marked as
 "locked" by creating a file in a known location.  "git worktree"
 command learned a dedicated command pair to create and remoev such
 a file, so that the users do not have to do this with editor.

 Ok, folks, is everybody happy with this version?


* et/pretty-format-c-auto (2016-05-27) 1 commit
  (merged to 'next' on 2016-05-31 at 1e9c920)
 + format_commit_message: honor `color=auto` for `%C(auto)`

 %C(auto) in a custom format string that commands in `git log`
 family takes unconditionally turned the color on, ignoring
 --no-color or --color=auto with output not connected to a tty;
 this was corrected to make the format truly behave as "auto".

 Will merge to 'master' after 2.9 final.


* ew/daemon-socket-keepalive (2016-05-25) 1 commit
  (merged to 'next' on 2016-05-31 at c32acf1)
 + daemon: enable SO_KEEPALIVE for all sockets

 When "git daemon" is run without --[init-]timeout specified, a
 connection from a client that silently goes offline can hang around
 for a long time, wasting resources.  The socket-level KEEPALIVE has
 been enabled to allow the OS to notice such failed connections.

 Will merge to 'master' after 2.9 final.


* jk/upload-pack-hook (2016-06-02) 7 commits
 - upload-pack: provide a hook for running pack-objects
 - t1308: do not get fooled by symbolic links to the source tree
 - config: add a notion of "scope"
 - config: return configset value for current_config_ functions
 - config: set up config_source for command-line config
 - git_config_parse_parameter: refactor cleanup code
 - git_config_with_options: drop "found" counting

 Allow a custom "git upload-pack" replacement to respond to
 "fetch/clone" request.

 Still under discussion.
 ($gmane/295705).


* rs/xdiff-hunk-with-func-line (2016-05-31) 8 commits
  (merged to 'next' on 2016-06-02 at 0c2e335)
 + grep: -W: don't extend context to trailing empty lines
 + t7810: add test for grep -W and trailing empty context lines
 + xdiff: don't trim common tail with -W
 + xdiff: -W: don't include common trailing empty lines in context
 + xdiff: ignore empty lines before added functions with -W
 + xdiff: handle appended chunks better with -W
 + xdiff: factor out match_func_rec()
 + t4051: rewrite, add more tests

 "git show -W" (extend hunks to cover the entire function, delimited
 by lines that match the "funcname" pattern) used to show the entire
 file when a change added an entire function at the end of the file,
 which has been fixed.

 Will merge to 'master' after 2.9 final.


* sb/submodule-misc-cleanups (2016-05-25) 1 commit
  (merged to 'next' on 2016-05-31 at 0d07b9c)
 + submodule update: make use of the existing fetch_in_submodule function

 Minor simplification.

 Will merge to 'master' after 2.9 final.


* sb/submodule-default-paths (2016-05-26) 11 commits
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 - Merge branch 'jc/attr' into sb/submodule-default-paths
 - Merge branch 'sb/clone-shallow-passthru' into sb/submodule-default-paths
 - Merge branch 'sb/submodule-deinit-all' into sb/submodule-default-paths
 - Merge branch 'sb/submodule-parallel-update' into sb/submodule-default-paths
  (merged to 'next' on 2016-05-31 at e72b604)
 + pathspec: allow querying for attributes
 + pathspec: move prefix check out of the inner loop
 + pathspec: move long magic parsing out of prefix_pathspec
 + Documentation: fix a typo
 (this branch uses jc/attr; is tangled with jc/attr-more and sb/pathspec-label.)

 Will hold.


* ah/no-verify-signature-with-pull-rebase (2016-05-20) 1 commit
  (merged to 'next' on 2016-05-31 at 30add83)
 + pull: warn on --verify-signatures with --rebase

 "git pull --rebase --verify-signature" learned to warn the user
 that "--verify-signature" is a no-op.

 Will merge to 'master' after 2.9 final.


* ep/http-curl-trace (2016-05-24) 2 commits
 - imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
 - http.c: implement the GIT_TRACE_CURL environment variable

 HTTP transport gained an option to produce more detailed debugging
 trace.

 Rerolled.  Is everybody happy with this version?


* jc/attr (2016-05-25) 18 commits
  (merged to 'next' on 2016-05-31 at 5b2f08b)
 + attr: support quoting pathname patterns in C style
 + attr: expose validity check for attribute names
 + attr: add counted string version of git_attr()
 + attr: add counted string version of git_check_attr()
 + attr: retire git_check_attrs() API
 + attr: convert git_check_attrs() callers to use the new API
 + attr: convert git_all_attrs() to use "struct git_attr_check"
 + attr: (re)introduce git_check_attr() and struct git_attr_check
 + attr: rename function and struct related to checking attributes
 + attr.c: plug small leak in parse_attr_line()
 + attr.c: tighten constness around "git_attr" structure
 + attr.c: simplify macroexpand_one()
 + attr.c: mark where #if DEBUG ends more clearly
 + attr.c: complete a sentence in a comment
 + attr.c: explain the lack of attr-name syntax check in parse_attr()
 + attr.c: update a stale comment on "struct match_attr"
 + attr.c: use strchrnul() to scan for one line
 + commit.c: use strchrnul() to scan for one line
 (this branch is used by jc/attr-more, sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.


* cc/apply-introduce-state (2016-06-06) 50 commits
  (merged to 'next' on 2016-06-06 at 9f6bdcb)
 + builtin/apply: remove misleading comment on lock_file field
  (merged to 'next' on 2016-06-03 at 1ab0cf9)
 + builtin/apply: move 'newfd' global into 'struct apply_state'
 + builtin/apply: add 'lock_file' pointer into 'struct apply_state'
 + builtin/apply: move applying patches into apply_all_patches()
 + builtin/apply: move 'state' check into check_apply_state()
 + builtin/apply: move 'symlink_changes' global into 'struct apply_state'
 + builtin/apply: move 'fn_table' global into 'struct apply_state'
 + builtin/apply: move 'state_linenr' global into 'struct apply_state'
 + builtin/apply: move 'max_change' and 'max_len' into 'struct apply_state'
 + builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
 + builtin/apply: move 'ws_error_action' into 'struct apply_state'
 + builtin/apply: move 'applied_after_fixing_ws' into 'struct apply_state'
 + builtin/apply: move 'squelch_whitespace_errors' into 'struct apply_state'
 + builtin/apply: remove whitespace_option arg from set_default_whitespace_mode()
 + builtin/apply: move 'whitespace_option' into 'struct apply_state'
 + builtin/apply: move 'whitespace_error' global into 'struct apply_state'
 + builtin/apply: move 'root' global into 'struct apply_state'
 + builtin/apply: move 'p_value_known' global into 'struct apply_state'
 + builtin/apply: move 'p_value' global into 'struct apply_state'
 + builtin/apply: move 'has_include' global into 'struct apply_state'
 + builtin/apply: move 'limit_by_name' global into 'struct apply_state'
 + builtin/apply: move 'patch_input_file' global into 'struct apply_state'
 + builtin/apply: move 'apply' global into 'struct apply_state'
 + builtin/apply: move 'p_context' global into 'struct apply_state'
 + builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
 + builtin/apply: move 'line_termination' global into 'struct apply_state'
 + builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
 + builtin/apply: move 'no_add' global into 'struct apply_state'
 + builtin/apply: move 'threeway' global into 'struct apply_state'
 + builtin/apply: move 'summary' global into 'struct apply_state'
 + builtin/apply: move 'numstat' global into 'struct apply_state'
 + builtin/apply: move 'diffstat' global into 'struct apply_state'
 + builtin/apply: move 'cached' global into 'struct apply_state'
 + builtin/apply: move 'allow_overlap' global into 'struct apply_state'
 + builtin/apply: move 'update_index' global into 'struct apply_state'
 + builtin/apply: move 'apply_verbosely' global into 'struct apply_state'
 + builtin/apply: move 'apply_with_reject' global into 'struct apply_state'
 + builtin/apply: move 'apply_in_reverse' global into 'struct apply_state'
 + builtin/apply: move 'check_index' global into 'struct apply_state'
 + builtin/apply: move 'check' global into 'struct apply_state'
 + builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
 + builtin/apply: move 'state' init into init_apply_state()
 + builtin/apply: introduce 'struct apply_state' to start libifying
 + builtin/apply: move 'read_stdin' global into cmd_apply()
 + builtin/apply: move 'options' variable into cmd_apply()
 + builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
 + builtin/apply: avoid local variable shadowing 'len' parameter
 + builtin/apply: avoid parameter shadowing 'linenr' global
 + builtin/apply: avoid parameter shadowing 'p_value' global
 + builtin/apply: make gitdiff_verify_name() return void

 The "git apply" standalone program is being libified; this is the
 first step to move many state variables into a structure that can
 be explicitly (re)initialized to make the machinery callable more
 than once.

 The next step that moves some remaining state variables into the
 structure and turns die()s into an error return that propagates up
 to the caller is not queued yet but in flight.  It would be good to
 review the above first and give the remainder of the series a solid
 base to build on.

 Will hold.


* pb/bisect (2016-05-24) 3 commits
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Beginning of GSoC "git bisect" project.


* sb/pathspec-label (2016-06-03) 6 commits
  (merged to 'next' on 2016-06-03 at 362f097)
 + pathspec: disable preload-index when attribute pathspec magic is in use
 + pathspec: allow escaped query values
  (merged to 'next' on 2016-05-31 at e72b604)
 + pathspec: allow querying for attributes
 + pathspec: move prefix check out of the inner loop
 + pathspec: move long magic parsing out of prefix_pathspec
 + Documentation: fix a typo
 (this branch uses jc/attr; is tangled with jc/attr-more and sb/submodule-default-paths.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.
 The preload-index mechanism is disabled when the new pathspec magic
 is in use (at least for now), because the attribute subsystem is
 not thread-ready.

 Will hold.


* nd/worktree-cleanup-post-head-protection (2016-05-24) 6 commits
 - worktree: simplify prefixing paths
 - worktree: avoid 0{40}, too many zeroes, hard to read
 - worktree.c: use is_dot_or_dotdot()
 - git-worktree.txt: keep subcommand listing in alphabetical order
 - worktree.c: rewrite mark_current_worktree() to avoid strbuf
 - completion: support git-worktree
 (this branch is used by nd/worktree-lock.)

 Further preparatory clean-up for "worktree" feature.

 Expecting a reroll.
 ($gmane/294136, etc.)


* mh/split-under-lock (2016-05-13) 33 commits
  (merged to 'next' on 2016-06-03 at 2e71330)
 + lock_ref_sha1_basic(): only handle REF_NODEREF mode
 + commit_ref_update(): remove the flags parameter
 + lock_ref_for_update(): don't resolve symrefs
 + lock_ref_for_update(): don't re-read non-symbolic references
 + refs: resolve symbolic refs first
 + ref_transaction_update(): check refname_is_safe() at a minimum
 + unlock_ref(): move definition higher in the file
 + lock_ref_for_update(): new function
 + add_update(): initialize the whole ref_update
 + verify_refname_available(): adjust constness in declaration
 + refs: don't dereference on rename
 + refs: allow log-only updates
 + delete_branches(): use resolve_refdup()
 + ref_transaction_commit(): correctly report close_ref() failure
 + ref_transaction_create(): disallow recursive pruning
 + refs: make error messages more consistent
 + lock_ref_sha1_basic(): remove unneeded local variable
 + read_raw_ref(): move docstring to header file
 + read_raw_ref(): improve docstring
 + read_raw_ref(): rename symref argument to referent
 + read_raw_ref(): clear *type at start of function
 + read_raw_ref(): rename flags argument to type
 + ref_transaction_commit(): remove local variable n
 + rename_ref(): remove unneeded local variable
 + commit_ref_update(): write error message to *err, not stderr
 + refname_is_safe(): insist that the refname already be normalized
 + refname_is_safe(): don't allow the empty string
 + refname_is_safe(): use skip_prefix()
 + remove_dir_recursively(): add docstring
 + safe_create_leading_directories(): improve docstring
 + read_raw_ref(): don't get confused by an empty directory
 + commit_ref(): if there is an empty dir in the way, delete it
 + t1404: demonstrate a bug resolving references
 (this branch is used by mh/ref-iterators.)

 Further preparatory work on the refs API before the pluggable
 backend series can land.

 Will merge to 'master' after 2.9 final.


* ew/fast-import-unpack-limit (2016-05-29) 2 commits
  (merged to 'next' on 2016-05-29 at af32aba)
 + fast-import: invalidate pack_id references after loosening
  (merged to 'next' on 2016-05-11 at ffd4efb)
 + fast-import: implement unpack limit

 "git fast-import" learned the same performance trick to avoid
 creating too small a packfile as "git fetch" and "git push" have,
 using *.unpackLimit configuration.

 Will hold.


* jc/send-email-skip-backup (2016-04-12) 1 commit
 - send-email: detect and offer to skip backup files

 A careless invocation of "git send-email directory/" after editing
 0001-change.patch with an editor often ends up sending both
 0001-change.patch and its backup file, 0001-change.patch~, causing
 embarrassment and a minor confusion.  Detect such an input and
 offer to skip the backup files when sending the patches out.

 Needs review.


* kn/ref-filter-branch-list (2016-05-17) 17 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add `:dir` and `:base` options for ref printing atoms
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce symref_atom_parser() and refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Rerolled.
 Needs review.


* dt/index-helper (2016-05-20) 20 commits
 - index-helper: indexhelper.exitafter config
 - trace: measure where the time is spent in the index-heavy operations
 - index-helper: optionally automatically run
 - index-helper: autorun mode
 - index-helper: don't run if already running
 - index-helper: kill mode
 - watchman: add a config option to enable the extension
 - unpack-trees: preserve index extensions
 - update-index: enable/disable watchman support
 - index-helper: use watchman to avoid refreshing index with lstat()
 - watchman: support watchman to reduce index refresh cost
 - read-cache: add watchman 'WAMA' extension
 - index-helper: log warnings
 - index-helper: add --detach
 - daemonize(): set a flag before exiting the main process
 - index-helper: add --strict
 - index-helper: new daemon for caching index and related stuff
 - pkt-line: add gentle version of packet_write
 - read-cache: allow to keep mmap'd memory after reading
 - read-cache.c: fix constness of verify_hdr()

 A new "index-helper" daemon has been introduced to give newly
 spawned Git process a quicker access to the data in the index, and
 optionally interface with the watchman daemon to further reduce the
 refresh cost.

 Rerolled.
 ($gmane/295106).


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 ($gmane/282594)

--------------------------------------------------
[Discarded]

* mh/connect-leak (2016-04-28) 1 commit
 . git_connect(): fix memory leak with CONNECT_DIAG_URL

 Is already made obsolete with a patch in flight under discussion.
 ($gmane/292962)
