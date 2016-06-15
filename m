From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Thu, 12 Apr 2012 15:41:55 -0700
Message-ID: <7v8vi04los.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 00:42:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SISiP-0002zJ-Uq
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 00:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966128Ab2DLWmD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 18:42:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757869Ab2DLWl7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 18:41:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDA1A73C4;
	Thu, 12 Apr 2012 18:41:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=chA4Rm+bg5QEWUnj5dGLs6F60
	n8=; b=nXzXm3c8g8EAkV0NNa7tpjKkKv8CwKDFpiNH53Ndzn58h0RCHberqX3T7
	R/eTwFeBZQW//mxkGvUYd5MHXqlLQBlWAm/7Hf8WwBGBK8CJeu85y56mjNwZ7SNl
	K9m+QGoMymlxzAz4xgSeTTpwuy343mZYOt98lKT8kSZUdDXgKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=pY9jRIr0x73Z1rtJgz0
	QKtAj+cVjVaF6yewoEFMuPye/+W2kAxJos1xdIvPXpr6j7rD92EXBwvgXFpCpTp9
	gENZARAKHdWEgeM5A9J4QYRTdaJivzBCV9DEnkBwkEV2cgV/iigSCsNsRk8DR4nz
	mweYkhuG7d0Ugt4zOmzZOG+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B464273C3;
	Thu, 12 Apr 2012 18:41:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C76B373C1; Thu, 12 Apr 2012
 18:41:56 -0400 (EDT)
X-master-at: 36e6c803a1ef68b8acdc4138597db4fb087112be
X-next-at: 3bf1d831cc29e917a2cd49a8a2df911e3b3ff26c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5671282-84F0-11E1-8A15-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195381>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

This issue describes the state of my tree in preparation for opening th=
e
post 1.7.10 cycle.  The 'next' branch has been rewound.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* mh/ref-api (2012-04-10) 13 commits
 - do_for_each_ref(): only iterate over the subtree that was requested
 - refs: store references hierarchically
 - sort_ref_dir(): simplify logic
 - refs.c: rename ref_array -> ref_dir
 - struct ref_entry: nest the value part in a union
 - check_refname_component(): return 0 for zero-length components
 - free_ref_entry(): new function
 - names_conflict(): simplify implementation
 - repack_without_ref(): reimplement using do_for_each_ref_in_array()
 - do_for_each_ref_in_arrays(): new function
 - do_for_each_ref_in_array(): new function
 - refs: manage current_ref within do_one_ref()
 - refs.c: reorder definitions more logically

Allows walking only a sub-hierarchy in refs/*.

Will merge to 'next'.

* jc/maint-blame-minimal (2012-04-11) 1 commit
 - blame: accept --need-minimal

"git blame" started missing quite a few changes from the origin since w=
e
stopped using the diff minimalization by default in v1.7.2 era.

Will merge to 'next'.

* jk/repack-no-explode-objects-from-old-pack (2012-04-11) 1 commit
 - gc: do not explode objects which will be immediately pruned

Will merge to 'next'.

* ld/git-p4-tags-and-labels (2012-04-11) 2 commits
 - git p4: import/export of labels to/from p4
 - git p4: Fixing script editor checks
 (this branch uses pw/git-p4.)

* lt/octopus-simplify (2012-04-12) 1 commit
 - Make 'git merge' simplify parents earlier

Octopus merge strategy did not reduce heads that are recorded in the fi=
nal
commit.  This was done off-list.

* mr/fetch-call-a-non-branch-a-ref (2012-04-11) 1 commit
 - fetch: Only call a new ref a "branch" if it's under refs/heads/.

The change itself may be sensible, but it exposes a funny in the vicini=
ty
about recursive submodule fetching behaviour.

* nh/empty-rebase (2012-04-11) 3 commits
 - git-cherry-pick: add test to validate new options
 - git-cherry-pick: add --keep-redundant-commits option
 - git-cherry-pick: add allow-empty option

Waiting for a reroll.

* sl/test-wc-l-line-count (2012-04-11) 1 commit
 - tests: modernise style: more uses of test_line_count

Will merge to 'next'.

* zj/upstream-error-message (2012-04-11) 5 commits
 - i18n: mark @{upstream} error messages for translation
 - Be more specific if upstream branch is not fetched
 - Provide better message for barnhc_wiht_tpyo@{u}
 - Provide branch name in error message when using @{u}
 - t1507: add additional tests for @{upstream}

Waiting for a reroll.

* fc/completion-tests (2012-04-12) 1 commit
 - tests: add initial bash completion tests

Will merge to 'next'.

--------------------------------------------------
[Stalled]

* nl/http-proxy-more (2012-04-12) 6 commits
 - fixup? 6e17b8c
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice
 - http: handle proxy authentication failure (error 407)
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not se=
t

The code to talk to http proxies learn to use the same credential
API used to talk to the final http destinations.

Kicked back to 'pu', as it breaks the proxied codepath quite badly.

* lp/maint-diff-three-dash-with-graph (2012-03-20) 3 commits
 - t4202: add test for "log --graph --stat -p" separator lines
 - log --graph: fix break in graph lines
 - log --graph --stat: three-dash separator should come after graph lin=
es

With a review from Zbigniew, I have been expecting that this would be
rerolled, but that didn't happen.

Waiting for a reroll.

* cn/apply-fix-ws-can-lengthen-lines (2012-03-11) 1 commit
 . apply: reallocate the postimage buffer when needed

Attempts to address an ancient bug that dates back to the addition
of an oddball "tab-in-indent" whitespace breakage class that wants
to have longer lines than the original when fixing things up; broken
and results in double-frees.

Will discard shortly if nothing happens.

* nd/columns (2012-03-13) 12 commits
 - column: support grouping entries
 - column: support "denser" mode
 - ls-files: support --column
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add dense layout support
 - column: add columnar layout
 - Stop starting pager recursively
 - Add column layout skeleton and git-column

Modulo minor nits, looked nicer than the previous round and getting clo=
ser
to completion but nothing has happened recently.

Will discard shortly if nothing happens.

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments
from =C3=86var. The second one needs more work, both in perl/Git.pm and
prompt.c, to give precedence to tty over SSH_ASKPASS when terminal
is available.

Will discard shortly if nothing happens.

* jc/split-blob (2012-04-03) 7 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions
 - varint: make it available outside the context of pack
 (this branch is tangled with jc/index-v4.)

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* jh/apply-free-patch (2012-04-11) 9 commits
 - apply: document buffer ownership rules across functions
 - apply: tighten constness of line buffer
 - apply: drop unused macro
 - apply: free unused fragments for submodule patch
 - apply: free patch->result
 - apply: release memory for fn_table
 - apply: free patch->{def,old,new}_name fields
 - apply: rename free_patch() to free_patch_list()
 - apply: do not leak patches and fragments

Valgrind reports quite a lot of discarded memory inside apply.

Will merge to 'next'.

* nd/threaded-index-pack (2012-04-11) 3 commits
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function
 - compat/win32/pthread.h: Add an pthread_key_delete() implementation

* bw/submodule-sed-solaris (2012-04-09) 1 commit
  (merged to 'next' on 2012-04-12 at 3bf1d83)
 + Avoid bug in Solaris xpg4/sed as used in submodule

* cb/http-multi-curl-auth (2012-04-10) 2 commits
 - fix http auth with multiple curl handles
 - http auth fails with multiple curl handles

=46ixes http authentication breakage when we keep multiple HTTP request=
s in
flight using curl-multi.

I haven't looked at Peff's follow-up deeply yet.  Perhaps a reroll is
coming?

* jk/rebase-i-submodule-conflict-only (2012-04-09) 1 commit
 - rebase -i continue: don't skip commits that only change submodules

Giving "--continue" to a conflicted "rebase -i" session skipped a commi=
t
that only results in changes to submodules.

Will merge to 'next'.

* ms/remote-usage-string (2012-04-09) 1 commit
 - remote: update builtin usage

As an independent follow-up, we may want to rethink how the overall usa=
ge
string and subcommand usage strings are maintained.

Will merge to 'next'.

* pw/fast-import-dataref-parsing (2012-04-10) 1 commit
 - fast-import: tighten parsing of datarefs

Will merge to 'next'.

* pw/git-p4 (2012-04-09) 3 commits
 - git p4: use "git p4" directly in tests
 - git p4: update name in script
 - git-p4: move to toplevel
 (this branch is used by ld/git-p4-tags-and-labels.)

Will merge to 'next'.

* rl/show-empty-prefix (2012-04-10) 1 commit
 - rev-parse --show-prefix: add in trailing newline

Will merge to 'next'.

* tr/xdiff-fast-hash (2012-04-09) 1 commit
 - xdiff: load full words in the inner loop of xdl_hash_record

Will merge to 'next'.

* jc/index-v4 (2012-04-04) 10 commits
 - update-index: upgrade/downgrade on-disk index version
 - read-cache.c: write prefix-compressed names in the index
 - read-cache.c: read prefix-compressed names in index on-disk version =
v4
 - read-cache.c: move code to copy incore to ondisk cache to a helper f=
unction
 - read-cache.c: move code to copy ondisk to incore cache to a helper f=
unction
 - read-cache.c: report the header version we do not understand
 - read-cache.c: make create_from_disk() report number of bytes it cons=
umed
 - read-cache.c: allow unaligned mapping of the index file
 - cache.h: hide on-disk index details
 - varint: make it available outside the context of pack
 (this branch is tangled with jc/split-blob.)

Trivially shrinks the on-disk size of the index file to save both I/O a=
nd
checksum overhead.  The "v4" format represented here may not be what we
eventually want to have, but the preparatory refactoring steps and the =
way
how backward compatibility is retained should give plenty to learn to G=
SoC
student-hopefuls.

Will merge to 'next', if nobody objects.

* jk/add-p-skip-conflicts (2012-04-05) 1 commit
  (merged to 'next' on 2012-04-12 at e65ceb1)
 + add--interactive: ignore unmerged entries in patch mode

Excludes conflicted paths from "add -p" processing, as it is not prepar=
ed
to handle them.

* bw/spawn-via-shell-path (2012-04-03) 1 commit
  (merged to 'next' on 2012-04-12 at 0ff833b)
 + Use SHELL_PATH from build system in run_command.c:prepare_shell_cmd

"sh" on the user's PATH may be utterly broken on some systems;
consistently use SHELL_PATH even from inside run-command API.

* jc/commit-unedited-template (2012-04-03) 5 commits
  (merged to 'next' on 2012-04-12 at a2e153b)
 + Documentation/git-commit: rephrase the "initial-ness" of templates
 + git-commit.txt: clarify -t requires editing message
 + commit: rephrase the error when user did not touch templated log mes=
sage
 + commit: do not trigger bogus "has templated message edited" check
 + t7501: test the right kind of breakage

When "git commit --template F" errors out because the user did not touc=
h
the message, it claimed that it aborts due to "empty message", which wa=
s
utterly wrong.

* jc/push-upstream-sanity (2012-04-05) 1 commit
  (merged to 'next' on 2012-04-12 at 288e1ad)
 + push: error out when the "upstream" semantics does not make sense

=46ix broken 'push to upstream' implementation.  "git push $there" with=
out
refspec, when the current branch is set to push to a remote different f=
rom
$there, used to push to $there using the upstream information to a remo=
te
unreleated to $there.

* jk/http-backend-keep-committer-ident-env (2012-03-30) 1 commit
  (merged to 'next' on 2012-04-12 at b2d0136)
 + http-backend: respect existing GIT_COMMITTER_* variables

The smart-http backend used to always override GIT_COMMITTER_* variable=
s
with REMOTE_USER and REMOTE_ADDR.

* mk/gitweb-diff-hl (2012-04-11) 8 commits
 - gitweb: Refinement highlightning in combined diffs
 - gitweb: Highlight interesting parts of diff
 - gitweb: Push formatting diff lines to print_diff_chunk()
 - gitweb: Use print_diff_chunk() for both side-by-side and inline diff=
s
 - gitweb: Extract print_sidebyside_diff_lines()
 - gitweb: Pass esc_html_hl_regions() options to esc_html()
 - gitweb: esc_html_hl_regions(): Don't create empty <span> elements
 - gitweb: Use descriptive names in esc_html_hl_regions()

Will merge to 'next'.

* it/fetch-pack-many-refs (2012-04-10) 4 commits
 - remote-curl: main test case for the OS command line overflow
 - fetch-pack: test cases for the new --stdin option
 - remote-curl: send the refs to fetch-pack on stdin
 - fetch-pack: new --stdin option to read refs from stdin

Will merge to 'next'.

* jn/debian-customizes-default-editor (2012-04-10) 2 commits
 - var doc: advertise current DEFAULT_PAGER and DEFAULT_EDITOR settings
 - var doc: default editor and pager are configurable at build time

Will merge to 'next'.

* rs/commit-list-sort-in-batch (2012-04-11) 3 commits
 - revision: insert unsorted, then sort in prepare_revision_walk()
 - commit: use mergesort() in commit_list_sort_by_date()
 - add mergesort() for linked lists

Will merge to 'next'.

* hv/submodule-recurse-push (2012-03-30) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

Will merge to 'next'.

* jk/branch-quiet (2012-03-26) 2 commits
  (merged to 'next' on 2012-04-12 at 7d0a438)
 + teach "git branch" a --quiet option
 + checkout: suppress tracking message with "-q"

Even with "-q"uiet option, "checkout" used to report setting up trackin=
g.
Also "branch" learns "-q"uiet option to squelch informational message.

* jk/run-command-eacces (2012-04-05) 2 commits
  (merged to 'next' on 2012-04-12 at ef3782e)
 + run-command: treat inaccessible directories as ENOENT
 + compat/mingw.[ch]: Change return type of exec functions to int

When PATH contains an unreadable directory, alias expansion code did no=
t
kick in, and failed with an error that said "git-subcmd" was not found.

* jb/am-include (2012-03-28) 1 commit
  (merged to 'next' on 2012-04-12 at ddbf96d)
 + am: support --include option

* jc/am-report-3way (2012-03-28) 1 commit
  (merged to 'next' on 2012-04-12 at cf5d599)
 + am -3: list the paths that needed 3-way fallback

* rs/combine-diff-zero-context-at-the-beginning (2012-03-25) 1 commit
  (merged to 'next' on 2012-04-12 at b4d92e3)
 + combine-diff: fix loop index underflow

=46ixes an age old corner case bug in combine diff (only triggered with=
 -U0
and the hunk at the beginning of the file needs to be shown).

* sl/autoconf (2012-03-26) 3 commits
  (merged to 'next' on 2012-04-12 at 68f346d)
 + configure: be more idiomatic
 + configure: avoid some code repetitions thanks to m4_{push,pop}def
 + configure: move definitions of private m4 macros before AC_INIT invo=
cation

Updates our configure.ac to follow a better "autoconf" style.

* wk/gitweb-snapshot-use-if-modified-since (2012-03-30) 3 commits
  (merged to 'next' on 2012-04-12 at 611d318)
 + gitweb: add If-Modified-Since handling to git_snapshot().
 + gitweb: refactor If-Modified-Since handling
 + gitweb: add `status` headers to git_feed() responses.

Makes 'snapshot' request to "gitweb" honor If-Modified-Since: header,
based on the commit date.

* jk/diff-no-rename-empty (2012-03-23) 4 commits
  (merged to 'next' on 2012-04-12 at d1d95c5)
 + merge-recursive: don't detect renames of empty files
 + teach diffcore-rename to optionally ignore empty content
 + make is_empty_blob_sha1 available everywhere
 + drop casts from users EMPTY_TREE_SHA1_BIN

=46orbids rename detection logic from matching two empty files as renam=
es
during merge-recursive to prevent mismerges.

* th/difftool-diffall (2012-04-04) 8 commits
 - difftool: print list of valid tools with '--tool-help'
 - difftool: teach difftool to handle directory diffs
 - difftool: eliminate setup_environment function
 - difftool: stop appending '.exe' to git
 - difftool: remove explicit change of PATH
 - difftool: exit(0) when usage is printed
 - difftool: add '--no-gui' option
 - difftool: parse options using Getopt::Long

Rolls the two-directory-diff logic from diffall script (in contrib/) in=
to
"git difftool" framework.=20

Still being reworked.

* jc/maint-clean-nested-worktree-in-subdir (2012-03-15) 2 commits
  (merged to 'next' on 2012-04-12 at 280a6e5)
 + clean: preserve nested git worktree in subdirectories
 + remove_dir_recursively(): Add flag for skipping removal of toplevel =
dir
 (this branch is tangled with jh/notes-merge-in-git-dir-worktree.)

Originally merged to 'next' on 2012-03-20

"git clean -d -f" (not "-d -f -f") is supposed to protect nested workin=
g
trees of independent git repositories that exist in the current project
working tree from getting removed, but the protection applied only to s=
uch
working trees that are at the top-level of the current project by mista=
ke.

* ct/advise-push-default (2012-04-12) 3 commits
  (merged to 'next' on 2012-04-12 at b0613cd)
 + Fix httpd tests that broke when non-ff push advice changed
 + clean up struct ref's nonfastforward field
 + push: Provide situational hints for non-fast-forward errors

Breaks down the cases in which "git push" fails due to non-ff into thre=
e
categories, and gives separate advise messages.  This should be a good
change regardless of mm/push-default-switch-warning topic.

* nl/rebase-i-cheat-sheet (2012-03-20) 1 commit
  (merged to 'next' on 2012-04-12 at cd76fcb)
 + rebase -i: remind that the lines are top-to-bottom

Originally merged to 'next' on 2012-03-20

* da/difftool-test (2012-03-19) 1 commit
  (merged to 'next' on 2012-04-11 at f245c01)
 + t7800: Test difftool passing arguments to diff

Makes sure "difftool" options can be given in any order.

Will merge to 'master'.

* jh/notes-merge-in-git-dir-worktree (2012-03-15) 4 commits
  (merged to 'next' on 2012-04-11 at 6042ef5)
 + notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE; it may be the u=
ser's cwd
 + notes-merge: use opendir/readdir instead of using read_directory()
 + t3310: illustrate failure to "notes merge --commit" inside $GIT_DIR/
 + remove_dir_recursively(): Add flag for skipping removal of toplevel =
dir
 (this branch is tangled with jc/maint-clean-nested-worktree-in-subdir.=
)

Originally merged to 'next' on 2012-03-20

Running "notes merge --commit" failed to perform correctly when run
from any directory inside $GIT_DIR/.  When "notes merge" stops with
conflicts, $GIT_DIR/NOTES_MERGE_WORKTREE is the place a user edits
to resolve it.

Will merge to 'master'.

* jn/diffstat-tests (2012-03-13) 7 commits
  (merged to 'next' on 2012-04-11 at 7365e41)
 + diffstat summary line varies by locale: miscellany
 + test: use numstat instead of diffstat in binary-diff test
 + test: use --numstat instead of --stat in "git stash show" tests
 + test: test cherry-pick functionality and output separately
 + test: modernize funny-names test style
 + test: use numstat instead of diffstat in funny-names test
 + test: use test_i18ncmp when checking --stat output

Originally merged to 'next' on 2012-03-20

Some tests checked the "diff --stat" output when they do not have to,
which unnecessarily made things harder to verify under GETTEXT_POISON.

Will merge to 'master'.

* tr/maint-word-diff-regex-sticky (2012-03-14) 3 commits
  (merged to 'next' on 2012-04-11 at 24d14de)
 + diff: tweak a _copy_ of diff_options with word-diff
 + diff: refactor the word-diff setup from builtin_diff_cmd
 + t4034: diff.*.wordregex should not be "sticky" in --word-diff

Originally merged to 'next' on 2012-03-20

The regexp configured with wordregex was incorrectly reused across
files.

Will merge to 'master'.

* zj/test-cred-helper-nicer-prove (2012-03-15) 2 commits
  (merged to 'next' on 2012-04-11 at 9169614)
 + t0303: resurrect commit message as test documentation
 + t0303: immediately bail out w/o GIT_TEST_CREDENTIAL_HELPER

Originally merged to 'next' on 2012-03-20

Minor improvement to t0303.
Will merge to 'master'.

* jc/commit-hook-authorship (2012-03-11) 3 commits
  (merged to 'next' on 2012-04-11 at 15ec4d4)
 + commit: pass author/committer info to hooks
 + t7503: does pre-commit-hook learn authorship?
 + ident.c: add split_ident_line() to parse formatted ident line
 (this branch is tangled with jc/run-hook-env-1.)

Originally merged to 'next' on 2012-03-12

"git commit --author=3D$name" did not tell the name that was being
recorded in the resulting commit to hooks, even though it does do so
when the end user overrode the authorship via the "GIT_AUTHOR_NAME"
environment variable.

Will merge to 'master'.

* jc/run-hook-env-1 (2012-03-11) 3 commits
 - run_hook(): enhance the interface to pass arbitrary environment
 + t7503: does pre-commit-hook learn authorship?
 + ident.c: add split_ident_line() to parse formatted ident line
 (this branch is tangled with jc/commit-hook-authorship.)

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks=
=2E

* jc/diff-algo-cleanup (2012-02-19) 2 commits
  (merged to 'next' on 2012-04-11 at f2c6b9a)
 + xdiff: PATIENCE/HISTOGRAM are not independent option bits
 + xdiff: remove XDL_PATCH_* macros

Originally merged to 'next' on 2012-03-15

Resurrects the preparatory clean-up patches from another topic that was
discarded, as this would give a saner foundation to build on diff.algo
configuration option series.

Will merge to 'master'.

* rs/unpack-trees-leakfix (2012-04-10) 2 commits
  (merged to 'next' on 2012-04-12 at 6958b54)
 + unpack-trees: plug minor memory leak
 + unpack-trees: don't perform any index operation if we're not merging

Originally merged to 'next' on 2012-03-07

* mm/push-default-switch-warning (2012-03-09) 1 commit
 - push: start warning upcoming default change for push.default

This resurrects an ancient patch I wrote during a discussion we had in =
the
1.6.3-1.6.4 era.  This should probably come after ct/advise-push-defaul=
t
topic and at that point the advise messages need to be rephrased, takin=
g
the future default change into account.

Will kick back to 'pu'.

* jc/fmt-merge-msg-people (2012-03-13) 1 commit
  (merged to 'next' on 2012-04-12 at 4c2031c)
 + fmt-merge-msg: show those involved in a merged series

The "fmt-merge-msg" command learns to list the primary contributors
involved in the side topic you are merging.

* nd/stream-more (2012-03-07) 7 commits
  (merged to 'next' on 2012-04-11 at b17684d)
 + update-server-info: respect core.bigfilethreshold
 + fsck: use streaming API for writing lost-found blobs
 + show: use streaming API for showing blobs
 + parse_object: avoid putting whole blob in core
 + cat-file: use streaming API to print blobs
 + Add more large blob test cases
 + streaming: make streaming-write-entry to be more reusable

Originally merged to 'next' on 2012-03-07

Use API to read blob data in smaller chunks in more places to
reduce the memory footprint.  In general, looked fairly good.

Will merge to 'master'.
