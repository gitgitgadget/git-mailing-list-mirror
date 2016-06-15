From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2016, #03; Tue, 9)
Date: Tue, 09 Feb 2016 15:17:54 -0800
Message-ID: <xmqq37t11nj1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 00:18:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTHXp-0001SD-0I
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 00:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbcBIXR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 18:17:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752727AbcBIXR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 18:17:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6380542FAE;
	Tue,  9 Feb 2016 18:17:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	kvuSe9qx9cLnZo1Scf2j/VtAk8=; b=xbcz7gbadx5U1+mPi4OVOq4TSJUhW8jX0
	CtarDtV4gjh2FmLh/YZJlXRvadRQJOcgDrh9hX/UMGJFteDrqu9OUYJmxC4Hptw4
	UXPaKKzIHtOWat8v3mnQYK/mHrz7VWO6RmDEseYvLb3a5gWGMYPF4lL3ZfYhbGW6
	16rhr3qtOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=YXG
	LvZ6B0bDH+kgwDbdUV8oERH6QqXrxRKEovUrX6UsAH+M1vj5cerfdz22r4ndJ4Mv
	f7xDcoWKz672M7gJfAepYKJnfsfr/ZY5NtPgyus5wjKggkEIlODHlGVoAIfmGyia
	gjN1etEDxeKeeFOM8cAlRdQ5bOjdvcXAvdtZGch8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B78F42FAD;
	Tue,  9 Feb 2016 18:17:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9C39642FAC;
	Tue,  9 Feb 2016 18:17:55 -0500 (EST)
X-master-at: ff4ea6004fb48146330d663d64a71e7774f059f9
X-next-at: ced85554d3d871f66dc4442631320a96a5d702f5
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 59A804D8-CF83-11E5-B13F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285885>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jk/rerere-xsnprintf (2016-02-08) 1 commit
  (merged to 'next' on 2016-02-09 at ff9ade3)
 + rerere: replace strcpy with xsnprintf
 (this branch is used by jc/rerere-multi.)

 Some calls to strcpy(3) triggers a false warning from static
 analysers that are less intelligent than humans, and reducing the
 number of these false hits helps us notice real issues.  A few
 calls to strcpy(3) in "git rerere" that are already safe has been
 rewritten to avoid false wanings.

 Will merge to 'master'.


* jk/test-path-utils-xsnprintf (2016-02-08) 1 commit
  (merged to 'next' on 2016-02-09 at 931f70b)
 + test-path-utils: use xsnprintf in favor of strcpy

 Some calls to strcpy(3) triggers a false warning from static
 analysers that are less intelligent than humans, and reducing the
 number of these false hits helps us notice real issues.  A few
 calls to strcpy(3) in test-path-utils that are already safe has
 been rewritten to avoid false wanings.

 Will merge to 'master'.


* mm/clean-doc-fix (2016-02-09) 1 commit
  (merged to 'next' on 2016-02-09 at ced8555)
 + Documentation/git-clean.txt: don't mention deletion of .git/modules/*

 The documentation for "git clean" has been corrected; it mentioned
 that .git/modules/* are removed by giving two "-f", which has never
 been the case.

 Will merge to 'master'.


* mg/mingw-test-fix (2016-02-08) 1 commit
 - t9100: fix breakage when SHELL_PATH is not /bin/sh
 (this branch uses js/mingw-tests.)

 An earlier adjustment of test mistakenly used write_script
 to prepare a file whose exact content matters for the test;
 reverting that part fixes the breakage for those who use
 SHELL_PATH that is different from /bin/sh.


* nd/icase (2016-02-09) 11 commits
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


* tb/conversion (2016-02-08) 7 commits
 - convert.c: simplify text_stat
 - convert.c: refactor crlf_action
 - convert: auto_crlf=false and no attributes set: same as binary
 - convert.c: use text_eol_is_crlf()
 - convert.c: remove input_crlf_action()
 - convert.c: remove unused parameter 'path'
 - t0027: add tests for get_stream_filter()

 Simplication of eol conversion codepath.

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


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for a reroll.
 ($gmane/284368).


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).
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
 Will discard.

--------------------------------------------------
[Cooking]

* da/user-useconfigonly (2016-02-08) 2 commits
  (merged to 'next' on 2016-02-09 at 8b303ce)
 + ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
 + fmt_ident: refactor strictness checks

 The "user.useConfigOnly" configuration variable can be used to
 force the user to always set user.email & user.name configuration
 variables, serving as a reminder for those who work on multiple
 projects and do not want to put these in their $HOME/.gitconfig.

 Will merge to 'master'.


* aw/push-force-with-lease-reporting (2016-02-01) 1 commit
  (merged to 'next' on 2016-02-03 at facd28f)
 + push: fix ref status reporting for --force-with-lease

 "git push --force-with-lease" has been taught to report if the push
 needed to force (or fast-forwarded).

 Will merge to 'master'.


* ew/connect-verbose (2016-01-28) 1 commit
  (merged to 'next' on 2016-02-03 at ceac37e)
 + pass transport verbosity down to git_connect

 There were a few "now I am doing this thing" progress messages in
 the TCP connection code that can be triggered by setting a verbose
 option internally in the code, but "git fetch -v" and friends never
 passed the verbose option down to that codepath.

 There was a brief discussion about the impact on the end-user
 experience by not limiting this to "fetch -v -v", but I think the
 conclusion is that this is OK to enable with a single "-v" as it is
 not too noisy.

 Will merge to 'master'.


* ls/clean-smudge-override-in-config (2016-01-29) 1 commit
  (merged to 'next' on 2016-02-03 at 5962354)
 + convert: treat an empty string for clean/smudge filters as "cat"

 Clean/smudge filters defined in a configuration file of lower
 precedence can now be overridden to be a pass-through no-op by
 setting the variable to an empty string.

 Will merge to 'master'.


* ah/stripspace-optstring (2016-01-29) 1 commit
 - stripspace: call U+0020 a "space" instead of a "blank"

 Comments?


* dw/mergetool-vim-window-shuffle (2016-01-29) 1 commit
 - mergetool: reorder vim/gvim buffers in three-way diffs

 Comments from real vim/gvim users?


* jk/drop-rsync-transport (2016-02-01) 1 commit
  (merged to 'next' on 2016-02-03 at 08be402)
 + transport: drop support for git-over-rsync

 It turns out "git clone" over rsync transport has been broken when
 the source repository has packed references for a long time, and
 nobody noticed nor complained about it.

 Will merge to 'master'.


* jk/options-cleanup (2016-02-01) 6 commits
  (merged to 'next' on 2016-02-03 at a78d89d)
 + apply, ls-files: simplify "-z" parsing
 + checkout-index: disallow "--no-stage" option
 + checkout-index: handle "--no-index" option
 + checkout-index: handle "--no-prefix" option
 + checkout-index: simplify "-z" option parsing
 + give "nbuf" strbuf a more meaningful name

 Various clean-ups to the command line option parsing.

 Will merge to 'master'.


* dv/http-try-negotiate-at-least-once (2016-02-02) 1 commit
 - remote-curl: don't fall back to Basic auth if we haven't tried Negotiate

 Will be replaced with a solution with a different approach.
 ($gmane/285633)


* js/test-lib-windows-emulated-yes (2016-02-02) 1 commit
  (merged to 'next' on 2016-02-03 at bf6b42c)
 + test-lib: limit the output of the yes utility

 The emulated "yes" command used in our test scripts has been
 tweaked not to spend too much time generating unnecessary output
 that is not used, to help those who test on Windows where it would
 not stop until it fills the pipe buffer due to lack of SIGPIPE.

 Will merge to 'master'.


* sb/submodule-parallel-update (2016-01-12) 8 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - fetching submodules: respect `submodule.fetchJobs` config option
 - submodule-config: introduce parse_generic_submodule_config
 - submodule-config: remove name_and_item_from_var
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around
 (this branch is used by dt/refs-backend-lmdb and sb/submodule-init.)

 A reroll exists.  Not picked up yet as it takes a while to flip
 three overlapping topics.


* dt/refs-backend-lmdb (2016-02-08) 22 commits
 - refs: tests for lmdb backend
 - refs: add LMDB refs storage backend
 - refs: add register_ref_storage_backends()
 - svn: learn ref-storage argument
 - clone: allow ref storage backend to be set for clone
 - refs: check submodules ref storage config
 - init: allow alternate ref strorage to be set for new repos
 - refs: always handle non-normal refs in files backend
 - refs: resolve symbolic refs first
 - refs: allow log-only updates
 - refs: move duplicate check to common code
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: add method for delete_refs
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add do_for_each_per_worktree_ref
 - refs: add methods for the ref iterators
 - refs: add methods for misc ref operations
 - refs: add a backend method structure with transaction functions
 - Merge branch 'sb/submodule-parallel-update' into dt/refs-backend-lmdb
 (this branch uses sb/submodule-parallel-update; is tangled with sb/submodule-init.)

 Building on top of a few refs-backend preparatory series, LMDB
 based refs backend has been plugged into the system.

 This can now be reviewed and polished as it no longer depends on
 too many topics in flight.  I haven't picked the latest one posted
 apart to queue it as a topic properly, as the patches sent to the
 list were done on top of some version of 'pu'.


* js/mingw-tests (2016-02-08) 21 commits
  (merged to 'next' on 2016-02-08 at 417e555)
 + gitignore: ignore generated test-fake-ssh executable
  (merged to 'next' on 2016-02-03 at ace7624)
 + mingw: do not bother to test funny file names
 + mingw: skip a test in t9130 that cannot pass on Windows
 + mingw: handle the missing POSIXPERM prereq in t9124
 + mingw: avoid illegal filename in t9118
 + mingw: mark t9100's test cases with appropriate prereqs
 + t0008: avoid absolute path
 + mingw: work around pwd issues in the tests
 + mingw: fix t9700's assumption about directory separators
 + mingw: skip test in t1508 that fails due to path conversion
 + tests: turn off git-daemon tests if FIFOs are not available
 + mingw: disable mkfifo-based tests
 + mingw: accomodate t0060-path-utils for MSYS2
 + mingw: fix t5601-clone.sh
 + mingw: let lstat() fail with errno == ENOTDIR when appropriate
 + mingw: try to delete target directory before renaming
 + mingw: prepare the TMPDIR environment variable for shell scripts
 + mingw: factor out Windows specific environment setup
 + Git.pm: stop assuming that absolute paths start with a slash
 + mingw: do not trust MSYS2's MinGW gettext.sh
 + mingw: let's use gettext with MSYS2
 (this branch is used by mg/mingw-test-fix.)

 Test scripts have been updated to remove assumptions that are not
 portable between Git for POSIX and Git for Windows, or to skip ones
 with expectations that are not satisfiable on Git for Windows.

 Will merge to 'master'.


* js/xmerge-marker-eol (2016-01-27) 2 commits
  (merged to 'next' on 2016-02-01 at 05d91a4)
 + merge-file: ensure that conflict sections match eol style
 + merge-file: let conflict markers match end-of-line style of the context

 The low-level merge machinery has been taught to use CRLF line
 termination when inserting conflict markers to merged contents that
 are themselves CRLF line-terminated.

 Will merge to 'master'.


* nd/clear-gitenv-upon-use-of-alias (2016-02-02) 4 commits
  (merged to 'next' on 2016-02-09 at 2c441b4)
 + restore_env(): free the saved environment variable once we are done
 + git: simplify environment save/restore logic
 + git: protect against unbalanced calls to {save,restore}_env()
 + git: remove an early return from save_env_before_alias()

 The automatic typo correction applied to an alias was broken
 with a recent change already in 'master'.

 Will merge to 'master'.


* nd/do-not-move-worktree-manually (2016-01-22) 2 commits
  (merged to 'next' on 2016-01-26 at c539221)
 + worktree: stop supporting moving worktrees manually
 + worktree.c: fix indentation

 "git worktree" had a broken code that attempted to auto-fix
 possible inconsistency that results from end-users moving a
 worktree to different places without telling Git (the original
 repository needs to maintain backpointers to its worktrees, but
 "mv" run by end-users who are not familiar with that fact will
 obviously not adjust them), which actually made things worse
 when triggered.

 Will merge to 'master'.


* sb/submodule-init (2016-01-28) 2 commits
 - submodule: port init from shell to C
 - submodule: port resolve_relative_url from shell to C
 (this branch uses sb/submodule-parallel-update; is tangled with dt/refs-backend-lmdb.)

 Major part of "git submodule init" has been ported to C.

 Will have to wait for 'sb/submodule-parallel-update'.


* wp/sha1-name-negative-match (2016-02-01) 2 commits
  (merged to 'next' on 2016-02-03 at 89fa5ef)
 + object name: introduce '^{/!-<negative pattern>}' notation
 + test for '!' handling in rev-parse's named commits

 A new "<branch>^{/!-<pattern>}" notation can be used to name a
 commit that is reachable from <branch> that does not match the
 given <pattern>.

 Will merge to 'master'.


* cc/untracked (2016-01-27) 11 commits
  (merged to 'next' on 2016-02-01 at 8203631)
 + t7063: add tests for core.untrackedCache
 + test-dump-untracked-cache: don't modify the untracked cache
 + config: add core.untrackedCache
 + dir: simplify untracked cache "ident" field
 + dir: add remove_untracked_cache()
 + dir: add {new,add}_untracked_cache()
 + update-index: move 'uc' var declaration
 + update-index: add untracked cache notifications
 + update-index: add --test-untracked-cache
 + update-index: use enum for untracked cache options
 + dir: free untracked cache when removing it

 Update the untracked cache subsystem and change its primary UI from
 "git update-index" to "git config".

 Will merge to 'master'.


* kn/ref-filter-atom-parsing (2016-02-02) 12 commits
 - ref-filter: introduce objectname_atom_parser()
 - ref-filter: introduce contents_atom_parser()
 - ref-filter: introduce remote_ref_atom_parser()
 - ref-filter: align: introduce long-form syntax
 - ref-filter: introduce align_atom_parser()
 - ref-filter: introduce parse_align_position()
 - ref-filter: introduce color_atom_parser()
 - ref-filter: introduce parsing functions for each valid atom
 - ref-filter: introduce struct used_atom
 - ref-filter: bump 'used_atom' and related code to the top
 - ref-filter: use strbuf_split_str_omit_term()
 - strbuf: introduce strbuf_split_str_omit_term()

 Refactoring of ref-filter's format-parsing code, in preparation
 for "branch --format" and friends.

 ($gmane/285158)


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
 (this branch uses jk/rerere-xsnprintf.)

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
