Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7E71F45F
	for <e@80x24.org>; Wed,  8 May 2019 17:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfEHRdw (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 13:33:52 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:55991 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfEHRdv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 13:33:51 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2019 13:33:37 EDT
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 4A3EC1A2BE;
        Wed,  8 May 2019 13:23:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=kXGAWWbrFdt6nj4AQLmkr7qoZ
        EA=; b=peyeqKrYorwggXavBPCjmTYoQ0bpjG14geBAc2gNknLMtP7wSYaY1r+ka
        EsCZJnYfOa2huViknuCyuBxTCeXnw5tSsD+dn2sVukcRQ+F38OmfU02eTsOqooCE
        wsZ6iHVZ4aYHCFfvfxJOUE/gpRt4Ykdnbs870NjHhoy/hwQ124=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=Fztd9csLANF0sxATD1u
        xB95nNf8FxOVUIecVgzxubaJV5KKo8ou4p4pbdtwgSBzQA6QNSFKLlelzmZiasM1
        4HgWBS11BdwYwZOBcL1eBUHgH8T90FONO0JcGdq3nHWo7F0/nTV6aZDyLNZRWml4
        xMyBQ11RHIM5CIxEfDNG184I=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 281841A2BD;
        Wed,  8 May 2019 13:23:26 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EE0E153F51;
        Wed,  8 May 2019 13:23:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2019, #01; Thu, 9)
X-master-at: 6a6c0f10a70a6eb101c213b09ae82a9cad252743
X-next-at: 81c186ecd2768836c2dc37eefd32d2e2a5e6dfb5
Date:   Thu, 09 May 2019 02:23:24 +0900
Message-ID: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC9F65BE-71B5-11E9-8797-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The 8th batch of topics, which Hopefully is the final one before
-rc0, have been pushed out to 'master'.  The "no-extern" topic is
now in 'next', with its merge conflict with many other topics, is
still slowing me down when it is moved earlier in the merge order.
I expect it to need only one more topic shuffling before merged to
'master', so I hope I'd survive.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cc/aix-has-fileno-as-a-macro (2019-04-25) 1 commit
  (merged to 'next' on 2019-04-25 at f1d6464f98)
 + Makefile: use fileno macro work around on AIX
 (this branch is used by cc/access-on-aix-workaround.)

 AIX shared the same build issues with other BSDs around fileno(fp),
 which has been corrected.


* cc/replace-graft-peel-tags (2019-04-15) 4 commits
  (merged to 'next' on 2019-04-25 at f8d0db27ba)
 + replace: peel tag when passing a tag first to --graft
 + replace: peel tag when passing a tag as parent to --graft
 + t6050: redirect expected error output to a file
 + t6050: use test_line_count instead of wc -l

 When given a tag that points at a commit-ish, "git replace --graft"
 failed to peel the tag before writing a replace ref, which did not
 make sense because the old graft mechanism the feature wants to
 mimick only allowed to replace one commit object with another.
 This has been fixed.


* dl/merge-cleanup-scissors-fix (2019-04-19) 10 commits
  (merged to 'next' on 2019-04-25 at 2014eef6b1)
 + cherry-pick/revert: add scissors line on merge conflict
 + sequencer.c: save and restore cleanup mode
 + merge: add scissors line on merge conflict
 + merge: cleanup messages like commit
 + parse-options.h: extract common --cleanup option
 + commit: extract cleanup_mode functions to sequencer
 + t7502: clean up style
 + t7604: clean up style
 + t3507: clean up style
 + t7600: clean up style
 (this branch uses pw/sequencer-cleanup-with-signoff-x-fix.)

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.


* dl/warn-tagging-a-tag (2019-04-12) 2 commits
  (merged to 'next' on 2019-04-25 at 8b966d7fe8)
 + tag: advise on nested tags
 + tag: fix formatting

 "git tag" learned to give an advice suggesting it might be a
 mistake when creating an annotated or signed tag that points at
 another tag.


* dr/ref-filter-push-track-fix (2019-04-18) 1 commit
  (merged to 'next' on 2019-04-25 at 07db067adc)
 + ref-filter: use correct branch for %(push:track)

 %(push:track) token used in the --format option to "git
 for-each-ref" and friends was not showing the right branch, which
 has been fixed.


* en/merge-directory-renames (2019-04-08) 15 commits
  (merged to 'next' on 2019-04-25 at fd5b4f57b4)
 + merge-recursive: switch directory rename detection default
 + merge-recursive: give callers of handle_content_merge() access to cont=
ents
 + merge-recursive: track information associated with directory renames
 + t6043: fix copied test description to match its purpose
 + merge-recursive: switch from (oid,mode) pairs to a diff_filespec
 + merge-recursive: cleanup handle_rename_* function signatures
 + merge-recursive: track branch where rename occurred in rename struct
 + merge-recursive: remove ren[12]_other fields from rename_conflict_info
 + merge-recursive: shrink rename_conflict_info
 + merge-recursive: move some struct declarations together
 + merge-recursive: use 'ci' for rename_conflict_info variable name
 + merge-recursive: rename locals 'o' and 'a' to 'obuf' and 'abuf'
 + merge-recursive: rename diff_filespec 'one' to 'o'
 + merge-recursive: rename merge_options argument from 'o' to 'opt'
 + Use 'unsigned short' for mode, like diff_filespec does

 "git merge-recursive" backend recently learned a new heuristics to
 infer file movement based on how other files in the same directory
 moved.  As this is inherently less robust heuristics than the one
 based on the content similarity of the file itself (rather than
 based on what its neighbours are doing), it sometimes gives an
 outcome unexpected by the end users.  This has been toned down to
 leave the renamed paths in higher/conflicted stages in the index so
 that the user can examine and confirm the result.


* jk/pack-objects-reports-num-objects-to-trace2 (2019-04-12) 1 commit
  (merged to 'next' on 2019-04-25 at e79464c054)
 + pack-objects: write objects packed to trace2

 The "git pack-objects" command learned to report the number of
 objects it packed via the trace2 mechanism.


* jk/prune-optim (2019-04-19) 1 commit
  (merged to 'next' on 2019-04-25 at c50353b27f)
 + t5304: add a test for pruning with bitmaps

 A follow-up test for an earlier "git prune" improvements.


* jk/untracked-cache-more-fixes (2019-04-19) 3 commits
  (merged to 'next' on 2019-04-25 at a6037ddd54)
 + untracked-cache: simplify parsing by dropping "len"
 + untracked-cache: simplify parsing by dropping "next"
 + untracked-cache: be defensive about missing NULs in index

 Code clean-up.


* js/misc-doc-fixes (2019-04-19) 8 commits
  (merged to 'next' on 2019-04-25 at 6898f709d0)
 + Turn `git serve` into a test helper
 + test-tool: handle the `-C <directory>` option just like `git`
 + check-docs: do not bother checking for legacy scripts' documentation
 + docs: exclude documentation for commands that have been excluded
 + check-docs: allow command-list.txt to contain excluded commands
 + help -a: do not list commands that are excluded from the build
 + Makefile: drop the NO_INSTALL variable
 + remote-testgit: move it into the support directory for t5801

 "make check-docs", "git help -a", etc. did not account for cases
 where a particular build may deliberately omit some subcommands,
 which has been corrected.


* js/trace2-to-directory (2019-03-22) 1 commit
  (merged to 'next' on 2019-04-25 at 53adf71c41)
 + trace2: write to directory targets

 The trace2 tracing facility learned to auto-generate a filename
 when told to log to a directory.


* jt/clone-server-option (2019-04-18) 2 commits
  (merged to 'next' on 2019-04-25 at 21f07cc85d)
 + clone: send server options when using protocol v2
 + transport: die if server options are unsupported

 "git clone" learned a new --server-option option when talking over
 the protocol version 2.


* jt/submodule-repo-is-with-worktree (2019-04-21) 1 commit
  (merged to 'next' on 2019-04-25 at da2c6d684d)
 + worktree: update is_bare heuristics

 The logic to tell if a Git repository has a working tree protects
 "git branch -D" from removing the branch that is currently checked
 out by mistake.  The implementation of this logic was broken for
 repositories with unusual name, which unfortunately is the norm for
 submodules these days.  This has been fixed.


* km/empty-repo-is-still-a-repo (2019-04-10) 3 commits
  (merged to 'next' on 2019-04-25 at bb3d4406a5)
 + add: error appropriately on repository with no commits
 + dir: do not traverse repositories with no commits
 + submodule: refuse to add repository with no commits

 Running "git add" on a repository created inside the current
 repository is an explicit indication that the user wants to add it
 as a submodule, but when the HEAD of the inner repository is on an
 unborn branch, it cannot be added as a submodule.  Worse, the files
 in its working tree can be added as if they are a part of the outer
 repository, which is not what the user wants.  These problems are
 being addressed.


* nd/sha1-name-c-wo-the-repository (2019-04-16) 34 commits
  (merged to 'next' on 2019-04-25 at d826918329)
 + sha1-name.c: remove the_repo from get_oid_mb()
 + sha1-name.c: remove the_repo from other get_oid_*
 + sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
 + submodule-config.c: use repo_get_oid for reading .gitmodules
 + sha1-name.c: add repo_get_oid()
 + sha1-name.c: remove the_repo from get_oid_with_context_1()
 + sha1-name.c: remove the_repo from resolve_relative_path()
 + sha1-name.c: remove the_repo from diagnose_invalid_index_path()
 + sha1-name.c: remove the_repo from handle_one_ref()
 + sha1-name.c: remove the_repo from get_oid_1()
 + sha1-name.c: remove the_repo from get_oid_basic()
 + sha1-name.c: remove the_repo from get_describe_name()
 + sha1-name.c: remove the_repo from get_oid_oneline()
 + sha1-name.c: add repo_interpret_branch_name()
 + sha1-name.c: remove the_repo from interpret_branch_mark()
 + sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
 + sha1-name.c: remove the_repo from get_short_oid()
 + sha1-name.c: add repo_for_each_abbrev()
 + sha1-name.c: store and use repo in struct disambiguate_state
 + sha1-name.c: add repo_find_unique_abbrev_r()
 + sha1-name.c: remove the_repo from find_abbrev_len_packed()
 + sha1-name.c: remove the_repo from sort_ambiguous()
 + commit.c: add repo_get_commit_tree()
 + commit.cocci: refactor code, avoid double rewrite
 + refs.c: remove the_repo from read_ref_at()
 + refs.c: add repo_dwim_log()
 + refs.c: add repo_dwim_ref()
 + refs.c: remove the_repo from expand_ref()
 + refs.c: remove the_repo from substitute_branch_name()
 + refs.c: add refs_shorten_unambiguous_ref()
 + refs.c: add refs_ref_exists()
 + packfile.c: add repo_approximate_object_count()
 + builtin rebase: use oideq()
 + builtin rebase: use FREE_AND_NULL

 Further code clean-up to allow the lowest level of name-to-object
 mapping layer to work with a passed-in repository other than the
 default one.


* pw/sequencer-cleanup-with-signoff-x-fix (2019-04-18) 1 commit
  (merged to 'next' on 2019-04-25 at cc587fb2b9)
 + sequencer: fix cleanup with --signoff and -x
 (this branch is used by dl/merge-cleanup-scissors-fix.)

 "git cherry-pick" run with the "-x" or the "--signoff" option used
 to (and more importantly, ought to) clean up the commit log message
 with the --cleanup=3Dspace option by default, but this has been
 broken since late 2017.  This has been fixed.


* ss/msvc-path-utils-fix (2019-04-09) 1 commit
  (merged to 'next' on 2019-04-25 at ee2850da18)
 + MSVC: include compat/win32/path-utils.h for MSVC, too, for real_path()

 An earlier update for MinGW and Cygwin accidentally broke MSVC build,
 which has been fixed.


* tb/unexpected (2019-04-10) 7 commits
  (merged to 'next' on 2019-04-25 at c49927fca0)
 + rev-list: detect broken root trees
 + rev-list: let traversal die when --missing is not in use
 + get_commit_tree(): return NULL for broken tree
 + list-objects.c: handle unexpected non-tree entries
 + list-objects.c: handle unexpected non-blob entries
 + t: introduce tests for unexpected object types
 + t: move 'hex2oct' into test-lib-functions.sh

 Code tightening against a "wrong" object appearing where an object
 of a different type is expected, instead of blindly assuming that
 the connection between objects are correctly made.


* tz/git-svn-doc-markup-fix (2019-04-10) 1 commit
  (merged to 'next' on 2019-04-25 at 3efaa6285c)
 + Documentation/git-svn: improve asciidoctor compatibility

 Doc formatting fix.


* vk/autoconf-gettext (2019-04-19) 1 commit
  (merged to 'next' on 2019-04-25 at 918870cbc2)
 + autoconf: #include <libintl.h> when checking for gettext()

 The autoconf generated configure script failed to use the right
 gettext() implementations from -libintl by ignoring useless stub
 implementations shipped in some C library, which has been
 corrected.

--------------------------------------------------
[New Topics]

* ab/perf-installed-fix (2019-05-08) 6 commits
 - perf-lib.sh: forbid the use of GIT_TEST_INSTALLED
 - perf tests: add "bindir" prefix to git tree test results
 - perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh
 - perf-lib.sh: make "./run <revisions>" use the correct gits
 - perf aggregate: remove GIT_TEST_INSTALLED from --codespeed
 - perf README: correct docs for 3c8f12c96c regression

 Performance test framework has been broken and measured the version
 of Git that happens to be on $PATH, not the specified one to
 measure, for a while, which has been corrected.

 Will merge to 'next'.
 cf. <20190507105434.9600-1-avarab@gmail.com>


* an/ignore-doc-update (2019-05-08) 1 commit
 - gitignore.txt: make slash-rules more readable

 The description about slashes in gitignore patterns (used to
 indicate things like "anchored to this level only" and "only
 matches directories") has been revamped.

 Almost there.
 cf. <20190507104507.18735-1-admin@in-ici.net>


* bl/t4253-exit-code-from-format-patch (2019-05-07) 1 commit
 - t4253-am-keep-cr-dos: avoid using pipes

 Avoid patterns to pipe output from a git command to feed another
 command in tests.

 Will merge to 'next'.


* cm/notes-comment-fix (2019-05-07) 1 commit
 - notes: correct documentation of format_display_notes()

 A stale in-code comment has been updated.

 Will merge to 'next'.


* dl/branch-from-3dot-merge-base (2019-05-07) 2 commits
 - branch: make create_branch accept a merge base rev
 - t2018: cleanup in current test

 "git branch new A...B" and "git checkout -b new A...B" have been
 taught that in their contexts, the notation A...B means "the merge
 base between these two commits", just like "git checkout A...B"
 detaches HEAD at that commit.

 Will merge to 'next'.
 cf. <cover.1556366347.git.liu.denton@gmail.com>


* ds/cvsexportcommit-force-text (2019-05-07) 1 commit
 - cvsexportcommit: force crlf translation

 "git cvsexportcommit" running on msys did not expect cvsnt showed
 "cvs status" output with CRLF line endings.

 Will merge to 'next'.


* en/fast-export-encoding (2019-05-07) 5 commits
 - fast-export: do automatic reencoding of commit messages only if reques=
ted
 - fast-export: differentiate between explicitly utf-8 and implicitly utf=
-8
 - fast-export: avoid stripping encoding header if we cannot reencode
 - fast-import: support 'encoding' commit header
 - t9350: fix encoding test to actually test reencoding

 The "git fast-export/import" pair has been taught to handle commits
 with log messages in encoding other than UTF-8 better.

 Will merge to 'next'.


* jh/trace2 (2019-04-26) 1 commit
  (merged to 'next' on 2019-05-09 at e1bba8aeac)
 + trace2: fix incorrect function pointer check

 An embarrassing bugfix.

 Will merge to 'master'.


* jk/apache-lsan (2019-05-08) 1 commit
 - t/lib-httpd: pass LSAN_OPTIONS through apache

 Allow tests that involve httpd to be run under leak sanitizer, just
 like we can already do so under address sanitizer.

 Will merge to 'next'.


* jk/cocci-batch (2019-05-08) 2 commits
 - coccicheck: make batch size of 0 mean "unlimited"
 - coccicheck: optionally batch spatch invocations

 Optionally "make coccicheck" can feed multiple source files to
 spatch, gaining performance while spending more memory.

 Will merge to 'next'.


* js/commit-graph-parse-leakfix (2019-05-07) 1 commit
 - commit-graph: fix memory leak

 Leakfix.

 Will merge to 'next'.


* js/fsmonitor-refresh-after-discarding-index (2019-05-08) 2 commits
 - fsmonitor: force a refresh after the index was discarded
 - fsmonitor: demonstrate that it is not refreshed after discard_index()

 The fsmonitor interface got out of sync after the in-core index
 file gets discarded, which has been corrected.

 Will merge to 'next'.


* js/t5580-unc-alternate-test (2019-05-07) 1 commit
 - t5580: verify that alternates can be UNC paths

 An additional test for MinGW

 Will merge to 'next'.


* js/t6500-use-windows-pid-on-mingw (2019-05-08) 1 commit
 - t6500(mingw): use the Windows PID of the shell

 Future-proof a test against an update to MSYS2 runtime v3.x series.

 Will merge to 'next'.
 cf. <pull.185.git.gitgitgadget@gmail.com>
 It might be helpful in the longer term to encapsulate the code that
 uses /proc/$$/winpid into a helper function and use it anywhere $$
 is referenced, but let's defer it until we see such a callsite that
 would be helped by such a move.


* mh/http-fread-api-fix (2019-05-08) 1 commit
 - Make fread/fwrite-like functions in http.c more like fread/fwrite.

 A pair of private functions in http.c that had names similar to
 fread/fwrite did not return the number of elements, which was found
 to be confusing.

 Will merge to 'next'.


* nd/merge-quit (2019-05-07) 2 commits
 - merge: add --quit
 - merge: remove drop_save() in favor of remove_merge_branch_state()

 "git merge" learned "--quit" option that cleans up the in-progress
 merge while leaving the working tree and the index still in a mess.

 Hmph, why is this a good idea?


* nd/parse-options-aliases (2019-05-07) 1 commit
 - parse-options: don't emit "ambiguous option" for aliases

 Attempt to use an abbreviated option in "git clone --recurs" is
 responded by a request to disambiguate between --recursive and
 --recurse-submodules, which is bad because these two are synonyms.
 The parse-options API has been extended to define such synonyms
 more easily and not produce an unnecessary failure.

 Will merge to 'next'.


* pw/rebase-abort-clean-rewritten (2019-05-08) 1 commit
 - rebase --abort: cleanup refs/rewritten
 (this branch uses pw/rebase-i-internal.)

 "git rebase --abort" used to leave refs/rewritten/ when concluding
 "git rebase -r", which has been corrected.

 Will merge to 'next'.


* sg/ci-libsvn-perl (2019-05-07) 1 commit
 - ci: install 'libsvn-perl' instead of 'git-svn'

 To run tests for Git SVN, our scripts for CI used to install the
 git-svn package (in the hope that it would bring in the right
 dependencies).  This has been updated to install the more direct
 dependency, namely, libsvn-perl.

 Will merge to 'next'.


* tt/no-ipv6-fallback-for-winxp (2019-05-07) 1 commit
 - mingw: remove obsolete IPv6-related code

 Code cleanup.

 Will merge to 'next'.


* jc/send-email-transferencoding-fix (2019-05-08) 2 commits
 - send-email: honor transferencoding config option again
 - send-email: update the mechanism to set default configuration values

 Since "git send-email" learned to take 'auto' as the value for the
 transfer-encoding, it by mistake stopped honoring the values given
 to the configuration variables sendemail.transferencoding and/or
 sendemail.<ident>.transferencoding.  Attempt to correct this.

 cf. <20190508105607.178244-1-gitster@pobox.com> (v2)

--------------------------------------------------
[Stalled]

* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=3DwhP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).

 Still being discussed.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=3Dj3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.co=
m>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.

--------------------------------------------------
[Cooking]

* nb/branch-show-other-worktrees-head (2019-05-07) 3 commits
 - branch: add worktree info on verbose output
 - branch: update output to include worktree info
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.


* jc/make-dedup-ls-files-output (2019-04-22) 1 commit
  (merged to 'next' on 2019-05-09 at e3d5825003)
 + Makefile: dedup list of files obtained from ls-files

 A "ls-files" that emulates "find" to enumerate files in the working
 tree resulted in duplicated Makefile rules that caused the build to
 issue an unnecessary warning during a trial build after merge
 conflicts are resolved in working tree *.h files but before the
 resolved results are added to the index.  This has been corrected.

 Will merge to 'master'.
 A not-so-low hanging fruit to teach ls-files to dedup either optionally
 or always has also been discussed, which probably is a good idea,
 to prevent mistakes similar to the bug this topic fixes in the future.


* jk/ls-files-doc-markup-fix (2019-04-23) 1 commit
  (merged to 'next' on 2019-05-09 at a68fe0ae72)
 + doc/ls-files: put nested list for "-t" option into block

 Docfix.

 Will merge to 'master'.


* jk/p5302-avoid-collision-check-cost (2019-04-23) 1 commit
  (merged to 'next' on 2019-05-09 at 8dc92cad96)
 + p5302: create the repo in each index-pack test

 Fix index-pack perf test so that the repeated invocations always
 run in an empty repository, which emulates the initial clone
 situation better.

 Will merge to 'master'.


* dl/rev-tilde-doc-clarify (2019-05-08) 4 commits
  (merged to 'next' on 2019-05-09 at 6efd564b11)
 + revisions.txt: remove ambibuity between <rev>:<path> and :<path>
 + revisions.txt: mention <rev>~ form
 + revisions.txt: mark optional rev arguments with []
 + revisions.txt: change "rev" to "<rev>"

 Docfix.

 Will merge to 'master'.


* en/unicode-in-refnames (2019-04-26) 1 commit
 - Honor core.precomposeUnicode in more places

 The names of the refs stored as filesystem entities may become
 different from what the end-user expects, just like files in the
 working tree gets "renamed", on a filesystem like HFS+.  Work it
 around by paying attemption to the core.precomposeUnicode
 configuration.

 Looked sensible.  Ready for next?


* jk/perf-aggregate-wo-libjson (2019-04-24) 1 commit
  (merged to 'next' on 2019-05-09 at e697c1993b)
 + t/perf: depend on perl JSON only when using --codespeed

 The script to aggregate perf result unconditionally depended on
 libjson-perl even though it did not have to, which has been
 corrected.

 Will merge to 'master'.


* cc/access-on-aix-workaround (2019-04-25) 1 commit
  (merged to 'next' on 2019-05-09 at 79b25b1954)
 + git-compat-util: work around for access(X_OK) under root

 Workaround for standard-compliant but less-than-useful behaviour of
 access(2) for the root user.

 Will merge to 'master'.


* dl/difftool-mergetool (2019-04-25) 6 commits
 - difftool: fallback on merge.guitool
 - difftool: make --gui, --tool and --extcmd mutually exclusive
 - mergetool: fallback to tool when guitool unavailable
 - mergetool: use get_merge_tool function
 - t7610: add mergetool --gui tests
 - t7610: unsuppress output

 Update "git difftool" and "git mergetool" so that the combinations
 of {diff,merge}.{tool,guitool} configuration variables serve as
 fallback settings of each other in a sensible order.

 Will merge to 'next'.


* ds/midx-expire-repack (2019-04-25) 11 commits
 - t5319-multi-pack-index.sh: test batch size zero
 - midx: add test that 'expire' respects .keep files
 - multi-pack-index: test expire while adding packs
 - midx: implement midx_repack()
 - multi-pack-index: prepare 'repack' subcommand
 - multi-pack-index: implement 'expire' subcommand
 - midx: refactor permutation logic and pack sorting
 - midx: simplify computation of pack name lengths
 - multi-pack-index: prepare for 'expire' subcommand
 - Docs: rearrange subcommands for multi-pack-index
 - repack: refactor pack deletion for future use

 "git multi-pack-index expire/repack" are new subcommands that
 consult midx file and are used to drop unused pack files and
 coalesce small pack files that are still in use.

 Ready for next?
 cf. <20190424151428.170316-1-dstolee@microsoft.com> (v5)


* es/first-contrib-tutorial (2019-05-08) 2 commits
 - documentation: add anchors to MyFirstContribution
 - documentation: add tutorial for first contribution

 A new tutorial targetting specifically aspiring git-core
 developers.

 I think we are almost there.
 cf. <20190507213040.151799-1-emilyshaffer@google.com> (v5)


* pw/clean-sequencer-state-upon-final-commit (2019-04-17) 2 commits
  (merged to 'next' on 2019-05-09 at cf6cce8ca7)
 + fix cherry-pick/revert status after commit
 + commit/reset: try to clean up sequencer state

 "git chery-pick" (and "revert" that shares the same runtime engine)
 that deals with multiple commits got confused when the final step
 gets stopped with a conflict and the user concluded the sequence
 with "git commit".  Attempt to fix it by cleaning up the state
 files used by these commands in such a situation.

 Will merge to 'master'.


* dl/no-extern-in-func-decl (2019-05-05) 3 commits
  (merged to 'next' on 2019-05-09 at d165ac4cee)
 + *.[ch]: manually align parameter lists
 + *.[ch]: remove extern from function declarations using sed
 + *.[ch]: remove extern from function declarations using spatch

 Mechanically and systematically drop "extern" from function
 declarlation.

 Will merge to 'master'.


* js/partial-clone-connectivity-check (2019-05-05) 2 commits
 - t/perf: add perf script for partial clones
  (merged to 'next' on 2019-04-25 at ebd8b4bffd)
 + clone: do faster object check for partial clones

 During an initial "git clone --depth=3D..." partial clone, it is
 pointless to spend cycles for a large portion of the connectivity
 check that enumerates and skips promisor objects (which by
 definition is all objects fetched from the other side).  This has
 been optimized out.

 Will merge to 'next' and then to 'master'.


* cc/multi-promisor (2019-04-15) 17 commits
 - Move core_partial_clone_filter_default to promisor-remote.c
 - Move repository_format_partial_clone to promisor-remote.c
 - Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - diff: use promisor-remote.h instead of fetch-object.h
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code
 - t0410: remove pipes after git commands
 - Merge branch 'jt/batch-fetch-blobs-in-diff' into cc/multi-promisor

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.

 Needs review.


* nd/switch-and-restore (2019-05-07) 43 commits
 - Declare both git-switch and git-restore experimental
 - help: move git-diff and git-reset to different groups
 - doc: promote "git restore"
 - user-manual.txt: prefer 'merge --abort' over 'reset --hard'
 - completion: support restore
 - t: add tests for restore
 - restore: support --patch
 - restore: replace --force with --ignore-unmerged
 - restore: default to --source=3DHEAD when only --staged is specified
 - restore: reject invalid combinations with --staged
 - restore: add --worktree and --staged
 - checkout: factor out worktree checkout code
 - restore: disable overlay mode by default
 - restore: make pathspec mandatory
 - restore: take tree-ish from --source option instead
 - checkout: split part of it to new command 'restore'
 - doc: promote "git switch"
 - completion: support switch
 - t: add tests for switch
 - switch: make --orphan switch to an empty tree
 - switch: reject if some operation is in progress
 - switch: no worktree status unless real branch switch happens
 - switch: implicit dwim, use --no-guess to disable it
 - switch: add short option for --detach
 - switch: only allow explicit detached HEAD
 - switch: reject "do nothing" case
 - switch: stop accepting pathspec
 - switch: remove -l
 - switch: add --discard-changes
 - switch: better names for -b and -B
 - checkout: split part of it to new command 'switch'
 - checkout: split options[] array in three pieces
 - checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 - checkout: make "opts" in cmd_checkout() a pointer
 - checkout: factor out some code in parse_branchname_arg()
 - checkout: keep most #include sorted
 - checkout: inform the user when removing branch state
 - checkout: advice how to get out of detached HEAD mode
 - t: rename t2014-switch.sh to t2014-checkout-switch.sh
 - git-checkout.txt: fix monospace typeset
 - doc: document --overwrite-ignore
 - git-checkout.txt: fix one syntax line
 - git-checkout.txt: spell out --no-option

 Two new commands "git switch" and "git restore" are introduced to
 split "checking out a branch to work on advancing its history" and
 "checking out paths out of the index and/or a tree-ish to work on
 advancing the current history" out of the single "git checkout"
 command.

 The "switch" part seems more or less ready for testing.  Perhaps
 we should split this back into two topics and merge it to 'next'.
 cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
 cf. <20190425094600.15673-1-pclouds@gmail.com> (restore v3)


* ew/repack-with-bitmaps-by-default (2019-03-18) 3 commits
  (merged to 'next' on 2019-05-09 at 4f8e8b01c8)
 + pack-objects: default to writing bitmap hash-cache
 + t5310: correctly remove bitmaps for jgit test
 + repack: enable bitmaps by default on bare repos

 The connectivity bitmaps are created by default in bare
 repositories now; also the pathname hash-cache is created by
 default to avoid making crappy deltas when repacking.

 Will merge to 'master'.
 cf. <87a7g2iuem.fsf@evledraar.gmail.com>


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Undecided but inclined to discard.


* am/p4-branches-excludes (2019-04-02) 8 commits
 - git-p4: respect excluded paths when detecting branches
 - git-p4: add failing test for "git-p4: respect excluded paths when dete=
cting branches"
 - git-p4: don't exclude other files with same prefix
 - git-p4: add failing test for "don't exclude other files with same pref=
ix"
 - git-p4: don't groom exclude path list on every commit
 - git-p4: match branches case insensitively if configured
 - git-p4: add failing test for "git-p4: match branches case insensitivel=
y if configured"
 - git-p4: detect/prevent infinite loop in gitCommitByP4Change()

 "git p4" update.

 Is this ready for 'next'?


* dl/rebase-i-keep-base (2019-04-25) 6 commits
 - rebase: teach rebase --keep-base
 - rebase: fast-forward --fork-point in more cases
 - rebase: fast-forward --onto in more cases
 - rebase: refactor can_fast_forward into goto tower
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base,
 which is useful when running the "git rebase -i" (and its limited
 variant "git rebase -x").

 The command also has learned to fast-forward in more cases where it
 can instead of replaying to recreate identical commits.

 On hold.
 cf. <20190508001252.15752-1-avarab@gmail.com>
 cf. <xmqqa7fxionx.fsf@gitster-ct.c.googlers.com>


* jh/trace2-sid-fix (2019-05-07) 11 commits
 - trace2: fixup access problem on /etc/gitconfig in read_very_early_conf=
ig
  (merged to 'next' on 2019-04-25 at a5c08f1226)
 + trace2: update docs to describe system/global config settings
 + trace2: make SIDs more unique
 + trace2: clarify UTC datetime formatting
 + trace2: report peak memory usage of the process
 + trace2: use system/global config for default trace2 settings
 + config: add read_very_early_config()
 + trace2: find exec-dir before trace2 initialization
 + trace2: add absolute elapsed time to start event
 + trace2: refactor setting process starting time
 + config: initialize opts structure in repo_read_config()

 Polishing of the new trace2 facility continues.  The system-level
 configuration can specify site-wide trace2 settings, which can be
 overridden with per-user configuration and environment variables.

 Will merge to 'next' and then to 'master'.
 cf. <pull.169.v4.git.gitgitgadget@gmail.com> (v4)


* pw/rebase-i-internal (2019-04-19) 13 commits
  (merged to 'next' on 2019-05-09 at 1206aa6865)
 + rebase -i: run without forking rebase--interactive
 + rebase: use a common action enum
 + rebase -i: use struct rebase_options in do_interactive_rebase()
 + rebase -i: use struct rebase_options to parse args
 + rebase -i: use struct object_id for squash_onto
 + rebase -i: use struct commit when parsing options
 + rebase -i: remove duplication
 + rebase -i: combine rebase--interactive.c with rebase.c
 + rebase: use OPT_RERERE_AUTOUPDATE()
 + rebase: rename write_basic_state()
 + rebase: don't translate trace strings
 + sequencer: always discard index after checkout
 + Merge branch 'ag/sequencer-reduce-rewriting-todo' into pw/rebase-i-int=
ernal
 (this branch is used by pw/rebase-abort-clean-rewritten.)

 The internal implementation of "git rebase -i" has been updated to
 avoid forking a separate "rebase--interactive" process.

 Will merge to 'master'.


* nd/worktree-name-sanitization (2019-03-20) 2 commits
 - SQUASH???
 - worktree add: sanitize worktree names

 In recent versions of Git, per-worktree refs are exposed in
 refs/worktrees/<wtname>/ hierarchy, which means that worktree names
 must be a valid refname component.  The code now sanitizes the names
 given to worktrees, to make sure these refs are well-formed.

 I am inclined to squash the fix at the tip in and merge the result
 to 'next'.  Opinions?


* ds/commit-graph-format-v2 (2019-05-08) 6 commits
 - commit-graph: remove Future Work section
 - commit-graph: implement file format version 2
 - commit-graph: add --version=3D<n> option
 - commit-graph: create new version parameter
 - commit-graph: collapse parameters into flags
 - commit-graph: return with errors during write

 Introduce version 2 of the commit-graph format to correct
 deficiency in the initial version.

 Still actively discussed.
 cf. <pull.112.v3.git.gitgitgadget@gmail.com> (v3)


* br/blame-ignore (2019-04-14) 6 commits
 - blame: use a fingerprint heuristic to match ignored lines
 - blame: optionally track line fingerprints during fill_blame_origin()
 - blame: add config options to handle output for ignored lines
 - blame: add the ability to ignore commits and their changes
 - blame: use a helper function in blame_chunk()
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Expecting a reroll.
 cf. <20190410162409.117264-1-brho@google.com> (v6)
 cf. <a742dd62-c84e-1f85-0663-4a3aa4d14989@google.com>
 cf. <3db6bad3-e7a5-af1d-3fe2-321bd17db2c6@google.com>

--------------------------------------------------
[Discarded]

* nd/precious (2019-04-09) 1 commit
 - Introduce "precious" file concept

 "git clean" learned to pay attention to the 'precious' attributes
 and keep untracked paths with the attribute instead of removing
 when the "--keep-precious" is given.

 Retracted.
 cf. <CACsJy8AEZ-Lz6zgEsuNukvphB9TTa9FAC1gK05fhnie2xtfc9w@mail.gmail.com>

 I am not sure what aspect of this longer-term "precious" vision,
 which gets taught to various commands and use cases individually
 and incrementally, =C3=86var finds problematic, which I understand is
 the reason of redtraction.


* nd/config-move-to (2019-01-14) 7 commits
 . config.h: fix hdr-check warnings
 . config: add --move-to
 . config: factor out set_config_source_file()
 . config: use OPT_FILENAME()
 . config.c: add repo_config_set_worktree_gently()
 . worktree.c: add get_worktree_config()
 . config.c: avoid git_path() in do_git_config_sequence()

 Dropped.
 cf. <CACsJy8DcaxBLCa2vK=3DMfoxkaHS0gDmdUsmamyqE2yOaoG_Esog@mail.gmail.co=
m>


* dm/some-stdio-functions-are-macro-on-freebsd (2019-02-01) 1 commit
 . http: cast result to FILE *

 Variants of BSD define fileno(fh) as a macro, breaking a program
 that passes a "void *" to it.

 Can be safely discarded.
 cf. <CACsJy8BcyD199L4qGv6-TP-8HD+GS+ZDNN5jspkh5uVaWekkoQ@mail.gmail.com>


* hs/send-email-transferencoding-fix (2019-04-10) 1 commit
 . send-email: honor transferencoding config option again

 Since "git send-email" learned to take 'auto' as the value for the
 transfer-encoding, it by mistake stopped honoring the values given
 to the configuration variables sendemail.transferencoding and/or
 sendemail.<ident>.transferencoding.  Attempt to correct this.

 Not quite.
 cf. <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>
 Replaced by jc/send-email-transferencoding-fix
