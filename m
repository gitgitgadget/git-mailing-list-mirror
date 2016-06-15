From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2013, #06; Fri, 20)
Date: Fri, 20 Sep 2013 15:03:07 -0700
Message-ID: <xmqqli2rp2w4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 00:03:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN8nG-0007Yf-3n
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 00:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab3ITWDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 18:03:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56635 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824Ab3ITWDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 18:03:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8F434317D;
	Fri, 20 Sep 2013 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	+p3rTOUTA0ZAFlKmK9uqzkv5HE=; b=bF9QR5g3LqmZh/q07U+2ImlSqObsZ8NP9
	O++bZ0ziEgSxczs5jvN7pNh9AlkoVMjz6RFhM+H7sSdST3vdzj1uTq0qaFrBSke0
	4AhuU4PpqLxidwNeb+G5jwsYtngW8t/RR9Nk8PVej1LxaCXizS+17jOGyf2eCD9Y
	nZBAlcOGcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=wn9
	eGjNZzt+mGRtGsYDovNScewONgnp6s9cOqI8lUrzazVVa+LLO67p3fEFCxBeHzQr
	I8UaL82pHMbQSz611yMFhuZpVrzzZ/F4F4sUHzJxPLogjlnMAV16lVvUSGc/QcZK
	IyxMJLwdRcHgMHOClxKBUwQX/4p26AADNYKTsDfs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DADC84317C;
	Fri, 20 Sep 2013 22:03:11 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDC2D4317B;
	Fri, 20 Sep 2013 22:03:10 +0000 (UTC)
X-master-at: 128a96c98442524c7f2eeef4757b1e48445f24ce
X-next-at: 0d6e0ce2a5090eb3c05a624d1ad584a1153fcc52
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7055ACD2-2240-11E3-B494-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235083>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The fifth batch of topics are in 'master'.  We are about to pass 350
non-merge commits since the last release, which means we are halfway
there for the next release.  Among ~60 contributors who have commits
in the 'master' branch since v1.8.4, ~10 are new faces.

I'll be offline starting next week for a few weeks; in order to
improve the "bus factor", I asked Jonathan Nieder to fill in for me
as the interim maintainer, with Peff as a back-up.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/http-backend-allow-405 (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-12 at bc1719f)
 + http-backend: provide Allow header for 405

 When the webserver responds with "405 Method Not Allowed", it
 should tell the client what methods are allowed with the "Allow"
 header.


* bk/refs-multi-update (2013-09-11) 8 commits
  (merged to 'next' on 2013-09-13 at e6d21af)
 + update-ref: add test cases covering --stdin signature
 + update-ref: support multiple simultaneous updates
 + refs: add update_refs for multiple simultaneous updates
 + refs: add function to repack without multiple refs
 + refs: factor delete_ref loose ref step into a helper
 + refs: factor update_ref steps into helpers
 + refs: report ref type from lock_any_ref_for_update
 + reset: rename update_refs to reset_refs

 Give "update-refs" a "--stdin" option to read multiple update
 requests and perform them in an all-or-none fashion.


* dw/check-ignore-sans-index (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-13 at 8daec3c)
 + check-ignore: Add option to ignore index contents

 "git check-ignore" follows the same rule as "git add" and "git
 status" in that the ignore/exclude mechanism does not take effect
 on paths that are already tracked.  With "--no-index" option, it
 can be used to diagnose which paths that should have been ignored
 have been mistakenly added to the index.


* fc/at-head (2013-09-12) 2 commits
  (merged to 'next' on 2013-09-13 at d3800c2)
 + Add new @ shortcut for HEAD
 + sha1-name: pass len argument to interpret_branch_name()

 Attempt to resurrect "Type @ for HEAD"; the bottom one seems to be
 a genuine code improvement, but identifying cases where "@" means
 HEAD were harder than it should have been.  I think the result of
 squashing the tip one in covers all the necessary cases.


* hu/cherry-pick-previous-branch (2013-09-09) 1 commit
  (merged to 'next' on 2013-09-12 at 36e4d9b)
 + cherry-pick: allow "-" as abbreviation of '@{-1}'

 Just like "git checkout -" knows to check out and "git merge -"
 knows to merge the branch you were previously on, teach "git
 cherry-pick" to understand "-" as the previous branch.


* jh/checkout-auto-tracking (2013-09-17) 6 commits
  (merged to 'next' on 2013-09-17 at 6748f49)
 + t3200: fix failure on case-insensitive filesystems
  (merged to 'next' on 2013-09-13 at 2aa1553)
 + branch.c: Relax unnecessary requirement on upstream's remote ref name
 + t3200: Add test demonstrating minor regression in 41c21f2
 + Refer to branch.<name>.remote/merge when documenting --track
 + t3200: Minor fix when preparing for tracking failure
 + t2024: Fix &&-chaining and a couple of typos

 Fix a minor regression in v1.8.3.2 and later that made it
 impossible to base your local work on anything but a local branch
 of the upstream repository you are tracking from.


* jk/upload-pack-keepalive (2013-09-09) 2 commits
  (merged to 'next' on 2013-09-17 at d3141ac)
 + upload-pack: bump keepalive default to 5 seconds
 + upload-pack: send keepalive packets during pack computation

 When running "fetch -q", a long silence while the sender side
 computes the set of objects to send can be mistaken by proxies as
 dropped connection.


* jx/branch-vv-always-compare-with-upstream (2013-08-26) 2 commits
  (merged to 'next' on 2013-09-12 at b5c37f4)
 + status: always show tracking branch even no change
 + branch: report invalid tracking branch as gone

 "git branch -v -v" (and "git status") did not distinguish among a
 branch that does not build on any other branch, a branch that is in
 sync with the branch it builds on, and a branch that is configured
 to build on some other branch that no longer exists.


* mm/commit-template-squelch-advice-messages (2013-09-12) 3 commits
  (merged to 'next' on 2013-09-13 at 410d207)
 + commit: disable status hints when writing to COMMIT_EDITMSG
 + wt-status: turn advice_status_hints into a field of wt_status
 + commit: factor status configuration is a helper function

 From the commit log template, remove irrelevant "advice" messages
 that are shared with "git status" output.


* mm/rebase-continue-freebsd-WB (2013-09-09) 1 commit
  (merged to 'next' on 2013-09-13 at 82e8b91)
 + rebase: fix run_specific_rebase's use of "return" on FreeBSD

 Work around a bug in FreeBSD shell that caused a regression to "git
 rebase" in v1.8.4.  May need to be later applied to 'maint'.


* mm/status-without-comment-char (2013-09-17) 7 commits
  (merged to 'next' on 2013-09-17 at d93e7c1)
 + t7508: avoid non-portable sed expression
  (merged to 'next' on 2013-09-12 at 89161b8)
 + status: add missing blank line after list of "other" files
 + tests: don't set status.displayCommentPrefix file-wide
 + status: disable display of '#' comment prefix by default
 + submodule summary: ignore --for-status option
 + wt-status: use argv_array API
 + builtin/stripspace.c: fix broken indentation

 Allow "git status" to omit the prefix to make its output a comment
 in a commit log editor, which is not necessary for human
 consumption.

 We may want to tighten the output to omit unnecessary trailing
 blank lines, but that does not have to be in the scope of this
 series.


* nd/fetch-into-shallow (2013-08-28) 7 commits
  (merged to 'next' on 2013-09-09 at 87a3b99)
 + Add testcase for needless objects during a shallow fetch
 + list-objects: mark more commits as edges in mark_edges_uninteresting
 + list-objects: reduce one argument in mark_edges_uninteresting
 + upload-pack: delegate rev walking in shallow fetch to pack-objects
 + shallow: add setup_temporary_shallow()
 + shallow: only add shallow graft points to new shallow file
 + move setup_alternate_shallow and write_shallow_commits to shallow.c

 When there is no sufficient overlap between old and new history
 during a fetch into a shallow repository, we unnecessarily sent
 objects the sending side knows the receiving end has.


* np/lookup-object-hashing (2013-09-11) 1 commit
  (merged to 'next' on 2013-09-12 at d835ef6)
 + lookup_object: remove hashtable_index() and optimize hash_obj()

 Micro optimize hash function used in the object hash table.


* nr/git-cd-to-a-directory (2013-09-19) 2 commits
  (merged to 'next' on 2013-09-19 at e9394e8)
 + t0056: "git -C" test updates
  (merged to 'next' on 2013-09-13 at 2b07af9)
 + git: run in a directory given with -C option

 Just like "make -C <directory>", make "git -C <directory> ..." to
 go there before doing anything else.


* rh/peeling-tag-to-tag (2013-09-03) 2 commits
  (merged to 'next' on 2013-09-12 at 3a1d906)
 + peel_onion: do not assume length of x_type globals
 + peel_onion(): add support for <rev>^{tag}

 Make "foo^{tag}" to peel a tag to itself, i.e. no-op., and fail if
 "foo" is not a tag.

--------------------------------------------------
[New Topics]

* jc/revision-range-unpeel (2013-09-20) 2 commits
 - (possible fixup) jc/revision-range-unpeel - peel only when necessary
 - revision: do not peel tags used in range notation

 "git rev-list --objects ^v1.0^ v1.0" gave v1.0 tag itself in the
 output, but "git rev-list --objects v1.0^..v1.0" did not.

 Need to decide either squashing the top fixup in, or dropping it
 and then merge to 'next'.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold, until we get any user.


* jc/push-cas (2013-09-20) 1 commit
  (merged to 'next' on 2013-09-20 at 5e1e7cc)
 + t5541: mark passing c-a-s test as success

 A trivial fix to a test.

 Will merge to 'master'.


* jk/format-patch-from (2013-09-20) 1 commit
  (merged to 'next' on 2013-09-20 at 0506530)
 + format-patch: print in-body "From" only when needed

 "format-patch --from=<whom>" forgot to omit unnecessary in-body
 from line, i.e. when <whom> is the same as the real author.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Will hold, until we get any user.


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


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


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

 Will merge to 'master'.


* po/dot-url (2013-09-13) 2 commits
  (merged to 'next' on 2013-09-20 at 6a12786)
 + config doc: update dot-repository notes
 + doc: command line interface (cli) dot-repository dwimmery

 Explain how '.' can be used to refer to the "current repository"
 in the documentation.

 Will merge to 'master'.


* es/contacts-in-subdir (2013-09-17) 1 commit
  (merged to 'next' on 2013-09-20 at d67164f)
 + contacts: fix to work in subdirectories

 Allow the contacts (in contrib/) script to run from inside a
 subdirectory.

 Will merge to 'master'.


* jc/upload-pack-send-symref (2013-09-17) 7 commits
 - clone: test the new HEAD detection logic
 - connect: annotate refs with their symref information in get_remote_head()
 - connect.c: make parse_feature_value() static
 - upload-pack: send non-HEAD symbolic refs
 - upload-pack: send symbolic ref information as capability
 - upload-pack.c: do not pass confusing cb_data to mark_our_ref()
 - t5505: fix "set-head --auto with ambiguous HEAD" test

 One long-standing flaw in the pack transfer protocol used by "git
 clone" was that there was no way to tell the other end which branch
 "HEAD" points at, and the receiving end needed to guess.  A new
 capability has been defined in the pack protocol to convey this
 information so that cloning from a repository with more than one
 branches pointing at the same commit where the HEAD is at now
 reliably sets the initial branch in the resulting repository.

 Will merge to 'next'.


* jk/clone-progress-to-stderr (2013-09-18) 3 commits
 - clone: always set transport options
 - clone: treat "checking connectivity" like other progress
 - clone: send diagnostic messages to stderr

 Some progress and diagnostic messages from "git clone" were
 incorrectly sent to the standard output stream, not to the standard
 error stream.

 Will merge to 'next'.


* nd/fetch-pack-error-reporting-fix (2013-09-18) 1 commit
  (merged to 'next' on 2013-09-20 at fefa04f)
 + fetch-pack.c: show correct command name that fails

 When "fetch-pack" detected an error from spawned "index-pack" or
 "unpack-objects", it did not report the failed program name
 correctly when a shallow repository is involved.

 Will merge to 'master'.


* sg/complete-untracked-filter (2013-09-19) 1 commit
  (merged to 'next' on 2013-09-20 at 798d0b9)
 + completion: improve untracked directory filtering for filename completion

 Will merge to 'master'.


* jc/strcasecmp-pure-inline (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-20 at 7142d08)
 + mailmap: work around implementations with pure inline strcasecmp

 Work around MinGW <string.h> header that does not declare strcasecmp
 whose address cannot be taken.

 Will merge to 'master'.


* jk/shortlog-tolerate-broken-commit (2013-09-18) 1 commit
  (merged to 'next' on 2013-09-20 at 9c85c02)
 + shortlog: ignore commits with missing authors

 Will merge to 'master'.


* jx/relative-path-regression-fix (2013-09-20) 3 commits
 - Use simpler relative_path when set_git_dir
 - relative_path should honor dos-driver-prefix
 - test: use unambigous leading path (/foo) for mingw

 Waiting for the review to settle.


* nd/unpack-entry-optim-in-pack-objects (2013-09-13) 1 commit
  (merged to 'next' on 2013-09-17 at 00f7335)
 + pack-objects: no crc check when the cached version is used

 The codepath to use data from packfiles that is only exercised in
 pack-objects unnecessarily checked crc checksum of the pack data,
 even when it ends up using in-core copy that it got by reading from
 the pack (at which point the checksum was validated).

 Will merge to 'master'.


* jc/checkout-detach-doc (2013-09-11) 1 commit
  (merged to 'next' on 2013-09-17 at 438cf13)
 + checkout: update synopsys and documentation on detaching HEAD

 "git checkout [--detach] <commit>" was listed poorly in the
 synopsis section of its documentation.

 Will merge to 'master'.


* jk/trailing-slash-in-pathspec (2013-09-13) 2 commits
  (merged to 'next' on 2013-09-17 at 18fe277)
 + reset: handle submodule with trailing slash
 + rm: re-use parse_pathspec's trailing-slash removal

 Code refactoring.

 Will merge to 'master'.


* kb/msvc-compile (2013-09-11) 5 commits
  (merged to 'next' on 2013-09-17 at a9bcbb5)
 + Windows: do not redefine _WIN32_WINNT
 + MinGW: Fix stat definitions to work with MinGW runtime version 4.0
 + MSVC: fix stat definition hell
 + MSVC: fix compile errors due to macro redefinitions
 + MSVC: fix compile errors due to missing libintl.h

 Build updates for Windows port.

 Will merge to 'master'.


* lc/filter-branch-too-many-refs (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-17 at 31cd01a)
 + Allow git-filter-branch to process large repositories with lots of branches.

 "git filter-branch" in a repository with many refs blew limit of
 command line length.

 Will merge to 'master'.


* np/pack-v4 (2013-09-18) 90 commits
 - packv4-parse.c: add tree offset caching
 - t1050: replace one instance of show-index with verify-pack
 - index-pack, pack-objects: allow creating .idx v2 with .pack v4
 - unpack-objects: decode v4 trees
 - unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.


* cc/replace-with-the-same-type (2013-09-09) 8 commits
  (merged to 'next' on 2013-09-17 at 34b5bb7)
 + Doc: 'replace' merge and non-merge commits
 + t6050-replace: use some long option names
 + replace: allow long option names
 + Documentation/replace: add Creating Replacement Objects section
 + t6050-replace: add test to clean up all the replace refs
 + t6050-replace: test that objects are of the same type
 + Documentation/replace: state that objects must be of the same type
 + replace: forbid replacing an object with one of a different type

 Using the replace mechanism to swap an object with another object
 of a different type can introduce inconsistency (e.g. a tree
 expects an object name to refer to a blob, but the blob object can
 be mistakenly or maliciously replaced with an object with a
 different type). Attempt to forbid such.

 Will merge to 'master'.


* bc/submodule-status-ignored (2013-09-11) 3 commits
  (merged to 'next' on 2013-09-11 at 9f66712)
 + Improve documentation concerning the status.submodulesummary setting
  (merged to 'next' on 2013-09-10 at a417960)
 + submodule: don't print status output with ignore=all
 + submodule: fix confusing variable name

 Will merge to 'master'.


* sb/repack-in-c (2013-09-17) 3 commits
 - repack: improve warnings about failure of renaming and removing files
 - repack: retain the return value of pack-objects
 - repack: rewrite the shell script in C

 Rerolled, and I think it is in a reasonably good shape.

 Will merge to 'next'.


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.

 Will merge to 'next'.


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
