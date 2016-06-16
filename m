From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2016, #04; Tue, 12)
Date: Tue, 12 Apr 2016 16:08:26 -0700
Message-ID: <xmqqh9f6o26t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 01:08:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7QC-000566-5C
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbcDLXIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:08:32 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932523AbcDLXI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:08:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C81D455C88;
	Tue, 12 Apr 2016 19:08:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=z
	MzgE4mx24QB7XNEhWXJOKQH2SM=; b=LWRtarkhKNUjv5FMjRqxze1eq6hSU5PTs
	BH4fMDpeKJ6YyX94JNQz6gul3F7CAqOH6j4Y477JJvcXmDeizgKTskiBJxwS+g3T
	RndovirYXMKIsZOJbp7bybTSzzSEnDnNDLp1kbs0UMA096AEa5TViboJ0XDfnndw
	Oya890OfP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=VFI
	ddMzrIjME0SKNek5JjsfbIAdnZuqgSgSIT8Enj9eqDFrod4FSf6HDmhjvSEQBiFM
	Tv8PQfZfu8F7dMVC18lBYGE7kO4BYg1GqSVH+jF2rdrMQJCB1qgo0hhX6mPvkeLM
	E6EAS1aYHOTK2pG72DqNUvr1sVD5KFGcW6jURtG0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BED1A55C86;
	Tue, 12 Apr 2016 19:08:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E41AC55C85;
	Tue, 12 Apr 2016 19:08:27 -0400 (EDT)
X-master-at: 7b0d47b3b6b5b64e02a5aa06b0452cadcdb18355
X-next-at: f4fac6784293189f836875527464b8e7b234cb96
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 774D627E-0103-11E6-A37F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291318>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The 'master' branch now has the third batch of topics of this
cycle.

There are a handful of topics that are stuck; they are marked as
"Needs review", "Needs an Ack", etc. in the following list.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jc/merge-refuse-new-root (2016-03-23) 1 commit
  (merged to 'next' on 2016-04-04 at cd70fd6)
 + merge: refuse to create too cool a merge by default

 Originally merged to 'next' on 2016-03-23

 "git merge" used to allow merging two branches that have no common
 base by default, which led to a brand new history of an existing
 project created and then get pulled by an unsuspecting maintainer,
 which allowed an unnecessary parallel history merged into the
 existing project.  The command has been taught not to allow this by
 default, with an escape hatch "--allow-unrelated-histories" option
 to be used in a rare event that merges histories of two projects
 that started their lives independently.


* nd/apply-doc (2016-03-24) 2 commits
  (merged to 'next' on 2016-04-06 at f9bd355)
 + git-apply.txt: mention the behavior inside a subdir
 + git-apply.txt: remove a space

 A minor documentation update.


* nd/apply-report-skip (2016-03-24) 1 commit
  (merged to 'next' on 2016-04-06 at ae2c824)
 + apply: report patch skipping in verbose mode

 "git apply -v" learned to report paths in the patch that were
 skipped via --include/--exclude mechanism or being outside the
 current working directory.


* oa/doc-diff-check (2016-03-29) 1 commit
  (merged to 'next' on 2016-04-06 at e3d6e8d)
 + Documentation: git diff --check detects conflict markers

 A minor documentation update.


* pb/opt-cmdmode-doc (2016-03-25) 1 commit
  (merged to 'next' on 2016-04-06 at a5f3835)
 + api-parse-options.txt: document OPT_CMDMODE()

 Minor API documentation update.


* ss/msvc (2016-03-30) 2 commits
  (merged to 'next' on 2016-04-06 at 4b53bce)
 + MSVC: use shipped headers instead of fallback definitions
 + MSVC: vsnprintf in Visual Studio 2015 doesn't need SNPRINTF_SIZE_CORR any more

 Build updates for MSVC.

--------------------------------------------------
[New Topics]

* ad/commit-have-m-option (2016-04-07) 2 commits
 - commit: do not ignore an empty message given by -m ''
 - commit: --amend -m '' silently fails to wipe message

 "git commit" misbehaved in a few minor ways when an empty message
 is given via -m '', all of which has been corrected.

 Will merge to 'next'.


* jc/xstrfmt-null-with-prec-0 (2016-04-07) 1 commit
 - setup.c: do not feed NULL to "%.*s" even with precision 0

 Will merge to 'next'.


* dt/pre-refs-backend (2016-04-10) 24 commits
 - refs: on symref reflog expire, lock symref not referrent
 - refs: move resolve_ref_unsafe into common code
 - show_head_ref(): check the result of resolve_ref_namespace()
 - check_aliased_update(): check that dst_name is non-NULL
 - checkout_paths(): remove unneeded flag variable
 - cmd_merge(): remove unneeded flag variable
 - fsck_head_link(): remove unneeded flag variable
 - read_raw_ref(): change flags parameter to unsigned int
 - files-backend: inline resolve_ref_1() into resolve_ref_unsafe()
 - read_raw_ref(): manage own scratch space
 - files-backend: break out ref reading
 - resolve_ref_1(): eliminate local variable "bad_name"
 - resolve_ref_1(): reorder code
 - resolve_ref_1(): eliminate local variable
 - resolve_ref_unsafe(): ensure flags is always set
 - resolve_ref_unsafe(): use for loop to count up to MAXDEPTH
 - resolve_missing_loose_ref(): simplify semantics
 - t1430: improve test coverage of deletion of badly-named refs
 - t1430: test for-each-ref in the presence of badly-named refs
 - t1430: don't rely on symbolic-ref for creating broken symrefs
 - t1430: clean up broken refs/tags/shadow
 - t1430: test the output and error of some commands more carefully
 - refs: move for_each_*ref* functions into common code
 - refs: move head_ref{,_submodule} to the common code
 (this branch uses jk/check-repository-format.)

 Code restructuring around the "refs" area to prepare for pluggable
 refs backends.

 Will merge to 'next'.


* ky/imap-send (2016-04-08) 2 commits
 - imap-send: fix CRAM-MD5 response calculation
 - imap-send: check for NOLOGIN capability only when using LOGIN command

 Support for CRAM-MD5 authentication method in "git imap-send" did
 not work well.

 Will merge to 'next'.


* ky/imap-send-openssl-1.1.0 (2016-04-08) 4 commits
 - configure: remove checking for HMAC_CTX_cleanup
 - imap-send: avoid deprecated TLSv1_method()
 - imap-send: check NULL return of SSL_CTX_new()
 - imap-send: use HMAC() function provided by OpenSSL

 Upcoming OpenSSL 1.1.0 will break compilation b updating a few APIs
 we use in imap-send, which has been adjusted for the change.

 Will merge to 'next'.


* jc/http-socks5h (2016-04-10) 1 commit
 - http: differentiate socks5:// and socks5h://

 The socks5:// proxy support added back in 2.6.4 days was not aware
 that socks5h:// proxies behave differently.

 Will merge to 'next'.


* jc/send-email-skip-backup (2016-04-12) 1 commit
 - send-email: detect and offer to skip backup files

 A careless invocation of "git send-email directory/" after editing
 0001-change.patch with an editor often ends up sending both
 0001-change.patch and its backup file, 0001-change.patch~, causing
 embarrassment and a minor confusion.  Detect such an input and
 offer to skip the backup files when sending the patches out.

 Needs review.


* jk/do-not-printf-NULL (2016-04-10) 3 commits
 - git_config_set_multivar_in_file: handle "unset" errors
 - git_config_set_multivar_in_file: all non-zero returns are errors
 - config: lower-case first word of error strings

 "git config" had a codepath that tried to pass a NULL to
 printf("%s"), which nobody seems to have noticed.

 Will merge to 'next'.


* jk/use-write-script-more (2016-04-12) 3 commits
 - t3404: use write_script
 - t1020: do not overuse printf and use write_script
 - t5532: use write_script

 Code clean-up.

 Will merge to 'next'.


* nf/mergetool-prompt (2016-04-12) 2 commits
 - SQUASH???
 - difftool/mergetool: make the form of yes/no questions consistent

 UI consistency improvements.


* va/i18n-misc-updates (2016-04-12) 4 commits
 - i18n: builtin/rm.c: remove a comma ',' from string
 - i18n: unpack-trees: mark strings for translation
 - i18n: builtin/branch.c: mark option for translation
 - i18n: index-pack: use plural string instead of normal one

 Mark several messages for translation.

--------------------------------------------------
[Stalled]

* tb/safe-crlf-output-fix (2016-04-01) 7 commits
 . convert.c: more safer crlf handling with text attribute
 . correct blame for files commited with CRLF
 . convert: unify the "auto" handling of CRLF
 . t0027: test cases for combined attributes
 . convert: allow core.autocrlf=input and core.eol=crlf
 . convert.c: stream and early out
 . read-cache: factor out get_sha1_from_index() helper

 The "safe CRLF" facility disables line-end conversion from CRLF to
 LF when checking in if the blob registered to the index already
 contains CR, but some codepaths like "git blame" did not know this,
 and instead assumed that only the configuration and attribute
 settings determined how the data from the working tree is converted.

 Will be rerolled.
 ($gmane/290637)


* da/user-useconfigonly (2016-04-01) 2 commits
 - ident: give "please tell me" message upon useConfigOnly error
 - ident: check for useConfigOnly before auto-detection of name/email

 The "user.useConfigOnly" configuration variable makes it an error
 if users do not explicitly set user.name and user.email.  However,
 its check was not done early enough and allowed another error to
 trigger, reporting that the default value we guessed from the
 system setting was unusable.  This was a suboptimal end-user
 experience as we want the users to set user.name/user.email without
 relying on the auto-detection at all.

 Waiting for Acks.
 ($gmane/290340)


* sb/clone-shallow-passthru (2016-03-23) 3 commits
 - clone: add t5614 to test cloning submodules with shallowness involved
 - submodule clone: pass along `local` option
 - clone: add `--shallow-submodules` flag

 "git clone" learned "--shallow-submodules" option.

 Needs review.


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


* sb/submodule-init (2016-03-15) 2 commits
 . submodule: port init from shell to C
 . submodule: port resolve_relative_url from shell to C

 Update of "git submodule" to move pieces of logic to C continues.

 Needs to be adjusted for the recent "prefix" fixes.


* az/p4-bare-no-rebase (2016-02-19) 1 commit
 - git-p4.py: Don't try to rebase on submit from bare repository

 "git p4 submit" attempts to do a rebase, which would fail if done
 in a bare repository.  Not doing this rebase would paper over the
 failure, which is what this patch does, but it is unclear what the
 side effect of not rebasing is.

 Needs a better explanation.


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

* jc/drop-git-spec-in (2016-04-06) 1 commit
 - Makefile: stop pretending to support rpmbuild

 As nobody maintains our in-tree git.spec.in and distros use their
 own spec file, we stopped pretending that we support "make rpm".

 Comments?


* jc/makefile-redirection-stderr (2016-04-05) 1 commit
  (merged to 'next' on 2016-04-06 at e3f2ded)
 + Makefile: fix misdirected redirections

 A minor fix in the Makefile.

 Will merge to 'master'.


* js/mingw-tests-2.8 (2016-04-04) 1 commit
  (merged to 'next' on 2016-04-06 at f85a013)
 + Windows: shorten code by re-using convert_slashes()

 Code clean-up.

 Will merge to 'master'.


* ar/diff-args-osx-precompose (2016-04-05) 1 commit
 - diff: run arguments through precompose_argv

 Many commands normalize command line arguments from NFD to NFC
 variant of UTF-8 on OSX, but commands in the "diff" family did
 not, causing "git diff $path" to complain that no such path is
 known to Git.  They have been taught to do the normalization.

 Will be rerolled?
 ($gmane/290724)


* ep/trace-doc-sample-fix (2016-04-05) 1 commit
  (merged to 'next' on 2016-04-06 at 0df7357)
 + api-trace.txt: fix typo

 Fix a typo in an example in the trace API documentation.

 Will merge to 'master'.


* ew/send-email-readable-message-id (2016-04-06) 1 commit
 - send-email: more meaningful Message-ID

 "git send-email" now uses a more readable timestamps when
 formulating a message ID.

 Will merge to 'next'.


* mg/complete-cherry-mark-to-log (2016-04-05) 1 commit
  (merged to 'next' on 2016-04-06 at 3002be6)
 + completion: complete --cherry-mark for git log

 The completion scripts (in contrib/) did not include the
 "--cherry-mark" option when completing "git log <HT>".

 Will merge to 'master'.


* tb/blame-force-read-cache-to-workaround-safe-crlf (2016-04-05) 1 commit
  (merged to 'next' on 2016-04-06 at 263bba8)
 + correct blame for files commited with CRLF

 When running "git blame $path" with unnormalized data in the index
 for the path, the data in the working tree was blamed, even though
 "git add" would not have changed what is already in the index, due
 to "safe crlf" that disables the line-end conversion.  It has been
 corrected.

 Will merge to 'master'.


* st/verify-tag (2016-04-06) 3 commits
 - verify-tag: change variable name for readability
 - t7030: test verifying multiple tags
 - builtin/verify-tag.c: ignore SIGPIPE in gpg-interface

 Only the first three patches in a six-patch series.
 Needs further work.


* ew/send-email-drop-data-dumper (2016-04-06) 1 commit
 - send-email: do not load Data::Dumper

 Code clean-up.

 Will merge to 'next'.


* es/format-patch-doc-hide-no-patch (2016-04-04) 1 commit
  (merged to 'next' on 2016-04-06 at 25d79bb)
 + git-format-patch.txt: don't show -s as shorthand for multiple options

 "git format-patch --help" showed `-s` and `--no-patch` as if these
 are valid options to the command.  We already hide `--patch` option
 from the documentation, because format-patch is about showing the
 diff, and the documentation now hides these options as well.

 Will merge to 'master'.


* jk/branch-shortening-funny-symrefs (2016-04-04) 1 commit
  (merged to 'next' on 2016-04-06 at 1a3f8be)
 + branch: fix shortening of non-remote symrefs

 A change back in version 2.7 to "git branch" broke display of a
 symbolic ref in a non-standard place in the refs/ hierarchy (we
 expect symbolic refs to appear in refs/remotes/*/HEAD to point at
 the primary branch the remote has, and as .git/HEAD to point at the
 branch we locally checked out).

 Will merge to 'next' and later down to maint-2.7.


* jn/mergetools-examdiff (2016-04-04) 2 commits
  (merged to 'next' on 2016-04-06 at 819e858)
 + mergetools: add support for ExamDiff
 + mergetools: create mergetool_find_win32_cmd() helper function for winmerge

 "git mergetools" learned to drive ExamDiff.

 Will merge to 'master'.


* kn/for-each-tag-branch (2016-03-30) 1 commit
  (merged to 'next' on 2016-04-06 at 4595ad3)
 + for-each-ref: fix description of '--contains' in manpage

 A minor documentation update.

 Will merge to 'master'.


* kn/ref-filter-branch-list (2016-04-12) 16 commits
 . branch: implement '--format' option
 . branch: use ref-filter printing APIs
 . branch, tag: use porcelain output
 . ref-filter: allow porcelain to translate messages in the output
 . ref-filter: add support for %(refname:dir) and %(refname:base)
 . ref-filter: introduce refname_atom_parser()
 . ref-filter: introduce symref_atom_parser()
 . ref-filter: make "%(symref)" atom work with the ':short' modifier
 . ref-filter: add support for %(upstream:track,nobracket)
 . ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 . ref-filter: introduce format_ref_array_item()
 . ref-filter: move get_head_description() from branch.c
 . ref-filter: modify "%(objectname:short)" to take length
 . ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 . ref-filter: include reference to 'used_atom' within 'atom_value'
 . ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Rerolled but seems to lack jk/branch-shortening-funny-symrefs aka
 $gmane/291295 yet.


* rz/worktree-no-checkout (2016-03-29) 1 commit
  (merged to 'next' on 2016-04-06 at e725216)
 + worktree: add: introduce --checkout option

 "git worktree add" can be given "--no-checkout" option to only
 create an empty worktree without checking out the files.

 Will merge to 'master'.


* sb/misc-cleanups (2016-04-01) 4 commits
  (merged to 'next' on 2016-04-06 at 4e63691)
 + credential-cache, send_request: close fd when done
 + bundle: don't leak an fd in case of early return
 + abbrev_sha1_in_line: don't leak memory
 + notes: don't leak memory in git_config_get_notes_strategy

 Assorted minor clean-ups.

 Will merge to 'master'.


* sb/submodule-helper-clone-regression-fix (2016-04-01) 6 commits
 - submodule--helper, module_clone: catch fprintf failure
 - submodule--helper: do not borrow absolute_path() result for too long
 - submodule--helper, module_clone: always operate on absolute paths
 - submodule--helper clone: create the submodule path just once
 - submodule--helper: fix potential NULL-dereference
 - recursive submodules: test for relative paths

 A partial rewrite of "git submodule" in the 2.7 timeframe changed
 the way the gitdir: pointer in the submodules point at the real
 repository location to use absolute paths by accident.  This has
 been corrected.

 Will merge to 'next'.


* sb/submodule-path-misc-bugs (2016-03-30) 6 commits
 - t7407: make expectation as clear as possible
 - submodule update: test recursive path reporting from subdirectory
 - submodule update: align reporting path for custom command execution
 - submodule status: correct path handling in recursive submodules
 - submodule update --init: correct path handling in recursive submodules
 - submodule foreach: correct path display in recursive submodules

 "git submodule" reports the paths of submodules the command
 recurses into, but this was incorrect when the command was not run
 from the root level of the superproject.

 Any further comments?  Otherwise will merge to 'next'.


* sg/diff-multiple-identical-renames (2016-03-30) 1 commit
  (merged to 'next' on 2016-04-06 at ac19e48)
 + diffcore: fix iteration order of identical files during rename detection

 "git diff -M" used to work better when two originally identical
 files A and B got renamed to X/A and X/B by pairing A to X/A and B
 to X/B, but this was broken in the 2.0 timeframe.

 Will merge to 'master'.


* sk/send-pack-all-fix (2016-03-31) 1 commit
  (merged to 'next' on 2016-04-06 at 31e1e1b)
 + git-send-pack: fix --all option when used with directory

 "git send-pack --all <there>" was broken when its command line
 option parsing was written in the 2.6 timeframe.

 Will merge to 'master'.


* xy/format-patch-base (2016-04-12) 4 commits
 - format-patch: introduce format.base configuration
 - format-patch: introduce --base=auto option
 - format-patch: add '--base' option to record base tree info
 - patch-ids: make commit_patch_id() a public helper function

 "git format-patch" learned a new "--base" option to record what
 (public, well-known) commit the original series was built on in
 its output.

 Review comments sent.
 ($gmane/291198)


* ak/use-hashmap-iter-first-in-submodule-config (2016-03-23) 1 commit
  (merged to 'next' on 2016-04-06 at 2aab890)
 + submodule-config: use hashmap_iter_first()

 Minor code cleanup.

 Will merge to 'master'.


* ky/branch-d-worktree (2016-03-29) 1 commit
  (merged to 'next' on 2016-04-06 at 00f9bff)
 + branch -d: refuse deleting a branch which is currently checked out

 When "git worktree" feature is in use, "git branch -d" allowed
 deletion of a branch that is checked out in another worktree

 Will merge to 'master'.


* ky/branch-m-worktree (2016-04-08) 3 commits
  (merged to 'next' on 2016-04-08 at b673b5e)
 + set_worktree_head_symref(): fix error message
  (merged to 'next' on 2016-04-06 at e7b285c)
 + branch -m: update all per-worktree HEADs
 + refs: add a new function set_worktree_head_symref

 When "git worktree" feature is in use, "git branch -m" renamed a
 branch that is checked out in another worktree without adjusting
 the HEAD symbolic ref for the worktree.

 Will merge to 'master'.


* rt/completion-help (2016-03-24) 2 commits
  (merged to 'next' on 2016-04-06 at 8c3ee08)
 + completion: add 'revisions' and 'everyday' to 'git help'
 + completion: add option '--guides' to 'git help'

 Shell completion (in contrib/) updates.

 Will merge to 'master'.


* rt/rebase-i-shorten-stop-report (2016-03-28) 1 commit
  (merged to 'next' on 2016-04-06 at 7a766b7)
 + rebase-i: print an abbreviated hash when stop for editing

 The commit object name reported when "rebase -i" stops has been
 shortened.

 Will merge to 'master'.


* jk/check-repository-format (2016-03-11) 10 commits
  (merged to 'next' on 2016-04-06 at a0dada0)
 + verify_repository_format: mark messages for translation
 + setup: drop repository_format_version global
 + setup: unify repository version callbacks
 + init: use setup.c's repo version verification
 + setup: refactor repo format reading and verification
 + config: drop git_config_early
 + check_repository_format_gently: stop using git_config_early
 + lazily load core.sharedrepository
 + wrap shared_repository global in get/set accessors
 + setup: document check_repository_format()
 (this branch is used by dt/pre-refs-backend.)

 The repository set-up sequence has been streamlined (the biggest
 change is that there is no longer git_config_early()), so that we
 do not attempt to look into refs/* when we know we do not have a
 Git repository.

 Will merge to 'master'.


* mj/pull-rebase-autostash (2016-04-04) 9 commits
  (merged to 'next' on 2016-04-06 at b4e4f31)
 + t5520: test --[no-]autostash with pull.rebase=true
 + t5520: reduce commom lines of code
 + t5520: factor out common "failing autostash" code
 + t5520: factor out common "successful autostash" code
 + t5520: use better test to check stderr output
 + t5520: ensure consistent test conditions
 + t5520: use consistent capitalization in test titles
 + pull --rebase: add --[no-]autostash flag
 + git-pull.c: introduce git_pull_config()

 "git pull --rebase" learned "--[no-]autostash" option, so that
 the rebase.autostash configuration variable set to true can be
 overridden from the command line.

 Will merge to 'master'.


* pb/commit-verbose-config (2016-04-12) 6 commits
 . commit: add a commit.verbose config variable
 . t7507-commit-verbose: improve test coverage by testing number of diffs
 . parse-options.c: make OPTION_COUNTUP respect "unspecified" values
 . t0040-parse-options: improve test coverage
 . test-parse-options: print quiet as integer
 . t0040-test-parse-options.sh: fix style issues

 "git commit" learned to pay attention to "commit.verbose"
 configuration variable and act as if "--verbose" option was
 given from the command line.

 Old one reverted, will wait for reroll.
 ($gmane/291303).


* lt/pretty-expand-tabs (2016-04-04) 4 commits
  (merged to 'next' on 2016-04-06 at 186ac2a)
 + pretty: test --expand-tabs
 + pretty: allow tweaking tabwidth in --expand-tabs
 + pretty: enable --expand-tabs by default for selected pretty formats
 + pretty: expand tabs in indented logs to make things line up properly

 When "git log" shows the log message indented by 4-spaces, the
 remainder of a line after a HT does not align in the way the author
 originally intended.  The command now expands tabs by default in
 such a case, and allows the users to override it with a new option,
 '--no-expand-tabs'.

 Will merge to 'master'.


* cc/apply (2016-04-01) 4 commits
  (merged to 'next' on 2016-04-06 at 2e23c44)
 + builtin/apply: free patch when parse_chunk() fails
 + builtin/apply: handle parse_binary() failure
 + apply: remove unused call to free() in gitdiff_{old,new}name()
 + builtin/apply: get rid of useless 'name' variable

 Minor code clean-up.

 Will merge to 'master'.


* dt/index-helper (2016-04-07) 16 commits
 - read-cache: config for waiting for index-helper
 - index-helper: optionally automatically run
 - index-helper: autorun mode
 - index-helper: don't run if already running
 - index-helper: kill mode
 - unpack-trees: preserve index extensions
 - update-index: enable/disable watchman support
 - index-helper: use watchman to avoid refreshing index with lstat()
 - add watchman support to reduce index refresh cost
 - read-cache: add watchman 'WAMA' extension
 - index-helper: add --detach
 - daemonize(): set a flag before exiting the main process
 - index-helper: add --strict
 - index-helper: new daemon for caching index and related stuff
 - read-cache: allow to keep mmap'd memory after reading
 - read-cache.c: fix constness of verify_hdr()

 Needs review.


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


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2016-04-06) 11 commits
 - rerere: adjust 'forget' to multi-variant world order
 - rerere: split code to call ll_merge() further
 - rerere: move code related to "forget" together
 - rerere: gc and clear
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

 Will merge to 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 ($gmane/282594)
