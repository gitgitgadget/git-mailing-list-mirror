From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2016, #02; Fri, 4)
Date: Fri, 04 Mar 2016 14:31:53 -0800
Message-ID: <xmqqio11yiw6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 23:33:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abyHY-0001e3-UX
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 23:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbcCDWdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 17:33:02 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760230AbcCDWb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 17:31:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EE1E49A98;
	Fri,  4 Mar 2016 17:31:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=j
	crLNEhIqhF+rqldB8R1gT/Vc1g=; b=t3Xlsglrz7pXPKPmDlY0rjZN5osikCn5c
	tW8sUNbXemU+6Y9/8Y+oPX0b/mmD3qE69nr8pGlZieT3GTGjevag/RtCgwSADaEz
	5I8JU77tnag5rLWIEcSj+/zsO/ezcV7Fu/rV1DX22ZZ3DEXd3SFRFopuMQ1XBXvz
	jkG9M/AZMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=uiO
	7EvXIhcEn+yx9Qm9DGT4kWb6YS0KPElHV3tcccz9zQbqQm5iEbAntyb64htZg5kI
	1UV7rjWpKi95iXWbfIQvdKAnqYV6bf7kfpOEgt7/9QaRdqw+6R6VFLSnpuekaKSA
	y/B6rnY17Ww35tGEWDRTMEz1yjuovKd8mqY0LFMo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9697249A97;
	Fri,  4 Mar 2016 17:31:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C58C749A95;
	Fri,  4 Mar 2016 17:31:54 -0500 (EST)
X-master-at: ab5d01a29eb7380ceab070f0807c2939849c44bc
X-next-at: 19dcece4e85c9fe888a1ab646b626fa6039c184c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5FCBF04-E258-11E5-9480-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288276>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

v2.8-rc1 has been tagged.  There still is a known regression around
"git status" (and "ls-files -o") relative to 2.7.2, which we may end
up resolving by reverting a topic by 2.8 final.  We'll see.

Again, the topics that have not been cooked sufficiently in 'next'
at this point will not be considered for 2.8 final, even though I
might later succumb to the temptation to pick up ones that look
trivially correct.  Those who have their topics merged to 'master'
since v2.7 are expected to focus on responding to regressions and
remaining bugs in their topics in 'master', and strongly encouraged
to actively hunt for regressions and remaining bugs there, not in a
random shiny new feature, during the pre-release period.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/pack-idx-corruption-safety (2016-02-27) 4 commits
  (merged to 'next' on 2016-03-01 at 49e08d3)
 + sha1_file.c: mark strings for translation
  (merged to 'next' on 2016-02-26 at ef0d6de)
 + use_pack: handle signed off_t overflow
 + nth_packed_object_offset: bounds-check extended offset
 + t5313: test bounds-checks of corrupted/malicious pack/idx files

 The code to read the pack data using the offsets stored in the pack
 idx file has been made more carefully check the validity of the
 data in the idx.


* jk/tighten-alloc (2016-02-29) 1 commit
  (merged to 'next' on 2016-03-01 at f4df936)
 + compat/mingw: brown paper bag fix for 50a6c8e


* js/pthread-exit-emu-windows (2016-03-02) 1 commit
  (merged to 'next' on 2016-03-02 at 391b917)
 + Mark win32's pthread_exit() as NORETURN


* mg/httpd-tests-update-for-apache-2.4 (2016-02-25) 1 commit
  (merged to 'next' on 2016-03-01 at d2f7e8c)
 + t/lib-httpd: load mod_unixd
 (this branch is used by jk/submodule-c-credential.)

 The way the test scripts configure the Apache web server has been
 updated to work also for Apache 2.4 running on RedHat derived
 distros.


* nd/clear-gitenv-upon-use-of-alias (2016-03-03) 1 commit
  (merged to 'next' on 2016-03-03 at 1c1c50f)
 + t0001: fix GIT_* environment variable check under --valgrind

 Hotfix for a test breakage made between 2.7 and 'master'.


* nd/i18n-2.8.0 (2016-02-29) 4 commits
  (merged to 'next' on 2016-03-01 at cdf4675)
 + trailer.c: mark strings for translation
 + ref-filter.c: mark strings for translation
 + builtin/clone.c: mark strings for translation
 + builtin/checkout.c: mark strings for translation


* sb/submodule-parallel-fetch (2016-03-01) 1 commit
  (merged to 'next' on 2016-03-01 at b47ab6e)
 + run-command: do not pass child process data into callbacks
 (this branch is used by sb/submodule-init and sb/submodule-parallel-update.)

 Simplify the two callback functions that are triggered when the
 child process terminates to avoid misuse of the child-process
 structure that has already been cleaned up.


* tb/avoid-gcc-on-darwin-10-6 (2016-02-28) 1 commit
  (merged to 'next' on 2016-03-01 at e8dd08a)
 + config.mak.uname: use clang for Mac OS X 10.6

 Out of maintenance gcc on OSX 10.6 fails to compile the code in
 'master'; work it around by using clang by default on the platform.

--------------------------------------------------
[New Topics]

* sb/rebase-summary (2016-03-02) 1 commit
  (merged to 'next' on 2016-03-04 at d40714d)
 + Documentation: reword rebase summary

 Will merge to 'master' by 2.8-rc2.


* jc/index-pack (2016-03-03) 2 commits
 - index-pack: add a helper function to derive .idx/.keep filename
 - Merge branch 'jc/maint-index-pack-keep' into jc/index-pack
 (this branch is used by jc/bundle; uses jc/maint-index-pack-keep; is tangled with jc/index-pack-clone-bundle.)

 Code clean-up.

 Will merge to 'next'.


* jc/maint-index-pack-keep (2016-03-03) 1 commit
  (merged to 'next' on 2016-03-04 at bc1d37a)
 + index-pack: correct --keep[=<msg>]
 (this branch is used by jc/bundle, jc/index-pack and jc/index-pack-clone-bundle.)

 "git index-pack --keep[=<msg>] pack-$name.pack" simply did not work.

 Will merge to 'master' after 2.8 final.


* js/close-packs-before-gc (2016-03-04) 1 commit
  (merged to 'next' on 2016-03-04 at fe6f6ed)
 + t5510: do not leave changed cwd

 A small future-proofing of a test added recently.

 Will merge to 'master' by 2.8-rc2.

--------------------------------------------------
[Stalled]

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

 Needs review.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.


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

--------------------------------------------------
[Cooking]

* mm/readme-markdown (2016-02-27) 1 commit
  (merged to 'next' on 2016-03-01 at 81f3858)
 + README.md: don't take 'commandname' literally

 The top-level README file has been updated to be more appropriate
 for the sign on the front door to welcome new acquaintances to Git
 by toning down inside jokes and making it into MarkDown.

 Will merge to 'master' after 2.8 final.


* gf/fetch-pack-direct-object-fetch (2016-03-01) 1 commit
  (merged to 'next' on 2016-03-04 at 49199e0)
 + fetch-pack: fix object_id of exact sha1

 Fetching of history by naming a commit object name directly didn't
 work across remote-curl transport.

 Will merge to 'master' after 2.8 final.


* jk/add-i-highlight (2016-02-28) 1 commit
  (merged to 'next' on 2016-03-04 at 4ac3aa1)
 + add--interactive: allow custom diff highlighting programs

 Will merge to 'master' after 2.8 final.


* jk/config-get-urlmatch (2016-02-28) 3 commits
  (merged to 'next' on 2016-03-04 at feeb192)
 + Documentation/git-config: fix --get-all description
 + Documentation/git-config: use bulleted list for exit codes
 + config: fail if --get-urlmatch finds no value

 "git config --get-urlmatch", unlike other variants of the "git
 config --get" family, did not signal error with its exit status
 when there was no matching configuration.

 Will merge to 'master' after 2.8 final.


* jk/rev-parse-local-env-vars (2016-02-29) 2 commits
  (merged to 'next' on 2016-03-04 at a0300d5)
 + rev-parse: let some options run outside repository
 + t1515: add tests for rev-parse out-of-repo helpers

 The "--local-env-vars" and "--resolve-git-dir" options of "git
 rev-parse" failed to work outside a repository when the command's
 option parsing was rewritten in 1.8.5 era.

 Will merge to 'master' after 2.8 final.


* sg/completion-updates (2016-02-28) 21 commits
 - completion: cache the path to the repository
 - completion: extract repository discovery from __gitdir()
 - completion: don't guard git executions with __gitdir()
 - completion: consolidate silencing errors from git commands
 - completion: don't use __gitdir() for git commands
 - completion: respect 'git -C <path>'
 - completion: fix completion after 'git -C <path>'
 - completion: don't offer commands when 'git --opt' needs an argument
 - rev-parse: add '--absolute-git-dir' option
 - completion: list short refs from a remote given as a URL
 - completion: don't list 'HEAD' when trying refs completion outside of a repo
 - completion: list refs from remote when remote's name matches a directory
 - completion: respect 'git --git-dir=<path>' when listing remote refs
 - completion: fix most spots not respecting 'git --git-dir=<path>'
 - completion: ensure that the repository path given on the command line exists
 - completion tests: add tests for the __git_refs() helper function
 - completion tests: check __gitdir()'s output in the error cases
 - completion tests: consolidate getting path of current working directory
 - completion tests: make the $cur variable local to the test helper functions
 - completion tests: don't add test cruft to the test repository
 - completion: improve __git_refs()'s in-code documentation

 Will be rerolled.
 ($gmane/287839)


* jx/http-no-proxy (2016-02-29) 1 commit
 - http: honor no_http env variable to bypass proxy

 Needs review.


* mm/lockfile-error-message (2016-03-01) 2 commits
  (merged to 'next' on 2016-03-04 at 04ed7e6)
 + lockfile: improve error message when lockfile exists
 + lockfile: mark strings for translation

 Will merge to 'master' after 2.8 final.


* ss/exc-flag-is-a-collection-of-bits (2016-03-01) 1 commit
  (merged to 'next' on 2016-03-04 at 5ea48c7)
 + dir: store EXC_FLAG_* values in unsigned integers

 Will merge to 'master' after 2.8 final.



* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle
 (this branch uses jc/index-pack and jc/maint-index-pack-keep; is tangled with jc/index-pack-clone-bundle.)

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.


* ss/receive-pack-parse-options (2016-03-01) 1 commit
  (merged to 'next' on 2016-03-04 at c577ea7)
 + builtin/receive-pack.c: use parse_options API

 The command line argument parser for "receive-pack" has been
 rewritten to use parse-options.

 Will merge to 'master' after 2.8 final.


* jk/credential-clear-config (2016-02-26) 1 commit
  (merged to 'next' on 2016-03-04 at f7b26b7)
 + credential: let empty credential specs reset helper list

 The credential.helper configuration variable is cumulative and
 there is no good way to override it from the command line.  As
 a special case, giving an empty string as its value now serves
 as the signal to clear the values specified in various files.

 Will merge to 'master' after 2.8 final.


* jk/submodule-c-credential (2016-03-01) 6 commits
 - git: submodule honor -c credential.* from command line
 - quote: implement sq_quotef()
 - submodule: fix segmentation fault in submodule--helper clone
 - submodule: fix submodule--helper clone usage
 - submodule: check argc count for git submodule--helper clone
 - submodule: don't pass empty string arguments to submodule--helper clone

 "git -c credential.<var>=<value> submodule" can now be used to
 propagate configuration variables related to credential helper
 down to the submodules.

 Will merge to 'next'.


* nd/shallow-deepen (2016-02-23) 25 commits
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


* mm/diff-renames-default (2016-02-25) 5 commits
  (merged to 'next' on 2016-02-25 at 947c399)
 + diff: activate diff.renames by default
 + log: introduce init_log_defaults()
 + t: add tests for diff.renames (true/false/unset)
 + t4001-diff-rename: wrap file creations in a test
 + Documentation/diff-config: fix description of diff.renames

 The end-user facing Porcelain level commands like "diff" and "log"
 now enables the rename detection by default.

 Will merge to 'master' after 2.8 final.


* mp/upload-pack-use-embedded-args (2016-02-25) 1 commit
  (merged to 'next' on 2016-02-26 at f0a54e5)
 + upload-pack: use argv_array for pack_objects

 The embedded args argv-array in the child process is used to build
 the command line to run pack-objects instead of using a separate
 array of strings.

 Will merge to 'master' after 2.8 final.


* sb/submodule-init (2016-03-01) 2 commits
 - submodule: port init from shell to C
 - submodule: port resolve_relative_url from shell to C
 (this branch uses sb/submodule-parallel-update.)

 Update of "git submodule" to move pieces of logic to C continues.

 Needs review.


* az/p4-bare-no-rebase (2016-02-19) 1 commit
 - git-p4.py: Don't try to rebase on submit from bare repository

 "git p4 submit" attempts to do a rebase, which would fail if done
 in a bare repository.  Not doing this rebase would paper over the
 failure, which is what this patch does, but it is unclear what the
 side effect of not rebasing is.

 Needs a better explanation.


* cn/deprecate-ssh-git-url (2016-02-15) 1 commit
 - Disown ssh+git and git+ssh

 Needs toning down by replacing the condescendence with an
 explanation and enlightenment.
 ($gmane/286222)


* ss/commit-dry-run-resolve-merge-to-no-op (2016-02-17) 1 commit
 - wt-status.c: set commitable bit if there is a meaningful merge.

 "git commit --dry-run" reported "No, no, you cannot commit." in one
 case where "git commit" would have allowed you to commit, and this
 improves it a little bit ("git commit --dry-run --short" still does
 not give you the correct answer, for example).


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


* sb/submodule-parallel-update (2016-03-01) 10 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - submodule helper: remove double 'fatal: ' prefix
 - git submodule update: have a dedicated helper for cloning
 - run_processes_parallel: rename parameters for the callbacks
 - run_processes_parallel: treat output of children as byte array
 - submodule update: direct error message to stderr
 - fetching submodules: respect `submodule.fetchJobs` config option
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around
 (this branch is used by sb/submodule-init.)

 A major part of "git submodule update" has been ported to C to take
 advantage of the recently added framework to run download tasks in
 parallel.

 Will merge to 'next'.


* dt/refs-backend-lmdb (2016-02-25) 45 commits
 . SQUASH??? Minimum compilation band-aid
 . tests: add ref-storage argument
 . refs: tests for lmdb backend
 . refs: add LMDB refs storage backend
 . refs: break out resolve_ref_unsafe_submodule
 . config: read ref storage config on startup
 . refs: register ref storage backends
 . svn: learn ref-storage argument
 . clone: allow ref storage backend to be set for clone
 . refs: check submodules' ref storage config
 . init: allow alternate ref strorage to be set for new repos
 . refs: always handle non-normal refs in files backend
 . refs: resolve symbolic refs first
 . refs: on symref reflog expire, lock symref not referrent
 . refs: don't dereference on rename
 . refs: allow log-only updates
 . refs: move duplicate check to common code
 . refs: make lock generic
 . refs: handle non-normal ref renames
 . refs: add method to rename refs
 . refs: add methods to init refs db
 . refs: add method for delete_refs
 . refs: add method for initial ref transaction commit
 . refs: add methods for reflog
 . refs: add do_for_each_per_worktree_ref
 . refs: reduce the visibility of do_for_each_ref()
 . refs: add method for do_for_each_ref
 . refs: add methods for misc ref operations
 . refs: add a backend method structure with transaction functions
 . refs: move resolve_ref_unsafe into common code
 . files-backend: break out ref reading
 . refs: move for_each_*ref* functions into common code
 . refs: move head_ref{,_submodule} to the common code
 . Merge branch 'sb/submodule-parallel-update' into dt/refs-backend-lmdb
 . clone: allow an explicit argument for parallel submodule clones
 . submodule update: expose parallelism to the user
 . git submodule update: have a dedicated helper for cloning
 . run_processes_parallel: correctly terminate callbacks with an LF
 . run_processes_parallel: rename parameters for the callbacks
 . run-command: expose default_{start_failure, task_finished}
 . run_processes_parallel: treat output of children as byte array
 . submodule update: direct error message to stderr
 . fetching submodules: respect `submodule.fetchJobs` config option
 . submodule-config: drop check against NULL
 . submodule-config: keep update strategy around

 A reroll exists, but it seems that will further be rerolled.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2016-02-08) 7 commits
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

 Needs further work on forget/gc.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.
 ($gmane/282594)
