From: Junio C Hamano <junio@pobox.com>
Subject: What's cooking in git.git (Feb 2010, #06; Tue, 23)
Date: Tue, 23 Feb 2010 17:20:44 -0800
Message-ID: <7v635nsa37.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 02:21:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk5vv-0000fF-OO
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 02:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079Ab0BXBUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 20:20:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab0BXBUw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 20:20:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC6769B23B;
	Tue, 23 Feb 2010 20:20:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=uZgo
	YzjOnbsyKWkJH4p2nXK30EQ=; b=ddM7NNBitquj3kbdW4fq93cCkGvx/v8pWqIc
	vNyx1Om7lsI+egQFmbLDZyOH0FMgso8pTGWHi+hEO9V3SWuYSmiei5zvT0vu2GvU
	knz7P61PPvGYH92I50tvHualeUhXIFPlQoufdp0giywYme9zI8qEOGnYeNKsxK9v
	VuixaPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=GBS
	Sqgg9cM68zGAuKdwQ3n4J/u5+HzWyeVceOhIEeWFjHUucV6TbMaGyXH3AQsuhWR6
	1k2UiT5xkWRBp2TG43SJ8rdHBuryk9uD/WfNH59E1L+SluQnxgKR61XpwTPey1kW
	xRq/NlDWxioWAVOONfHBaW5tctz3/vNnlauTCaX0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7CA39B23A;
	Tue, 23 Feb 2010 20:20:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90CED9B239; Tue, 23 Feb
 2010 20:20:45 -0500 (EST)
X-master-at: 0901d5a2ef80996cf64c8afeaec765e1bc09f795
X-next-at: ac4ec8fb00b9defe6763ade89af32f420a97b5ed
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D676F646-20E2-11DF-9917-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140887>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[New Topics]

* gb/submodule-env (2010-02-23) 2 commits
 - submodules: ensure clean environment when operating in a submodule
 - shell setup: clear_local_git_env() function

This is a round before the round with hardcoded list on the C side.  I
think the idea of the new one is basically sound, but I do not think it
should create a new source file nor call it cache.c which obviously this
thing is not (environment.c might be a better home for it).

* jl/maint-submodule-clear-env (2010-02-23) 1 commit
 - is_submodule_modified(): clear environment properly

I'd prefer to rebuild this on top of rerolled gb/submodule-env before
moving it forward.

* il/loosen-remote-helper-names (2010-02-23) 1 commit
 - Allow '+', '-' and '.' in remote helper names

Judging from the discussion, the conclusion seemed to be that Dscho was
needlessly worried about using '+' in pathnames on DOS, and the patch is
Ok.  There also was a discussion on how to sanely deal with the need to
have duplicated binaries with the current set-up, only to handle
essentially the same svn+ssh:// and ssh+svn:// protocols; I however think
that is pretty much orthogonal to the issue of what letters can be used in
names.

* jk/maint-add--interactive-delete (2010-02-22) 1 commit
 - add-interactive: fix bogus diff header line ordering

Looked Ok for 'next'.

* js/runtime-prefix-trace-not-warn (2010-02-23) 1 commit
 - Print RUNTIME_PREFIX warning only when GIT_TRACE is set

Looked Ok for 'next'.

* lt/deepen-builtin-source (2010-02-22) 1 commit
 - Move 'builtin-*' into a 'builtin/' subdirectory

This is a painful one to keep out of 'master' for a long time, as any
topic with new builtin commands will need evil merges to adjust to it.

* tc/http-cleanup (2010-02-21) 7 commits
 - remote-curl: init walker only when needed
 - remote-curl: use http_fetch_ref() instead of walker wrapper
 - http: init and cleanup separately from http-walker
 - http-walker: cleanup more thoroughly
 - http-push: remove useless condition
 - t554[01]-http-push: refactor, add non-ff tests
 - t5541-http-push: check that ref is unchanged for non-ff test

Didn't look; there was some discussion that may result in a reroll.

* tr/notes-display (2010-02-23) 11 commits
 - notes: add shorthand --ref to override GIT_NOTES_REF
 - commit --amend: copy notes to the new commit
 - rebase: support automatic notes copying
 - notes: implement helpers needed for note copying during rewrite
 - notes: implement 'git notes copy --stdin'
 - rebase -i: invoke post-rewrite hook
 - rebase: invoke post-rewrite hook
 - commit --amend: invoke post-rewrite hook
 - Documentation: document post-rewrite hook
 - Support showing notes from more than one notes tree
 - test-lib: unset GIT_NOTES_REF to stop it from influencing tests
 (this branch uses jh/notes.)

Didn't look too carefully except for the second one.

* ts/svn-mergeinfo (2010-02-22) 3 commits
 - git-svn: Fix discarding of extra parents from svn:mergeinfo
 - t9151: Add two new svn:mergeinfo test cases
 - t9151: Fix a few commits in the SVN dump

I won't pick up git-svn patches myself without Acks from Eric and/or Sam;
there are here only so that they won't be forgotten.

* cw/test-lib-relicense (2010-02-22) 1 commit
 . test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.

I think a reasonable way forward would be to collect Acks from everybody
who appears on "git blame" or "git shortlog" output.  How do people feel
about relicensing the whole (except for the obviously borrowed bits, such
as xdiff/) under GPLv2 _or later_?  I am not a big fan of GPLv3 and do not
see a compelling reason to switch to v3 for the sake of v3 license per-se,
but helping others that want to use our code might tip the balance.

--------------------------------------------------
[Stalled]

* ld/push-porcelain (2010-02-09) 4 commits
 - git-push: fix an error message so it goes to stderr
 - git-push: make git push --dry-run --porcelain exit with status 0 even if updates will be rejected
 - git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
 - git-push: squelch advice message if in --porcelain mode

This needs further simplification, judging from the previous discussion?

* sd/format-patch-to (2010-02-17) 1 commit
 - Add 'git format-patch --to=' option and 'format.to' configuration variable.

Shouldn't be too hard to add tests to t4014; other than that looked ready
for 'next'.

* sd/init-template (2010-02-17) 2 commits
 - Add a "TEMPLATE DIRECTORY" section to git-init[1].
 - Add `init.templatedir` configuration variable.

Shouldn't be too hard to add tests to t0001; other than that looked ready
for 'next'.

* sd/log-decorate (2010-02-17) 3 commits
 - log.decorate: usability fixes
 - Add `log.decorate' configuration variable.
 - git_config_maybe_bool()

Probably ready for 'next', except that people need to be warned about
having to update their scripts to explicitly pass --no-decorate to keep
them working.  A good idea to disable this when --pretty was given, just
like notes are disabled by default, was floated.

* pb/log-first-parent-p-m (2010-02-10) 1 commit
  (merged to 'next' on 2010-02-17 at 2f8e5ae)
 + git log -p -m: document -m and honor --first-parent

Needs tests but otherwise looked fine.  We might want to teach "-m trumps
implicit --cc" to "git show", but that is a totally separate topic.

I actually care about this "log -p --first-parent" very much, but if Pasky
is counting on that and procrastinating until I write the tests myself, he
is in for a dissapointment.  I don't have that much free time these days.
Help is appreciated.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

--------------------------------------------------
[Cooking]

* dp/read-not-mmap-small-loose-object (2010-02-21) 1 commit
  (merged to 'next' on 2010-02-21 at fa39a9a)
 + hash-object: don't use mmap() for small files

Will merge to 'master' after a few more days of cooking.

* np/compress-loose-object-memsave (2010-02-21) 2 commits
  (merged to 'next' on 2010-02-21 at 1e558d6)
 + sha1_file: be paranoid when creating loose objects
 + sha1_file: don't malloc the whole compressed result when writing out objects

Will merge to 'master' after a few more days of cooking.

* jc/maint-fix-mailinfo-strip (2010-02-19) 1 commit
 - mailinfo: do not strip leading spaces even for a header line

Ready for 'next', I think.

* ne/pack-local-doc (2010-02-18) 1 commit
 - Documentation: pack-objects: Clarify --local's semantics.

Comments from pack experts?

* ml/connect-refactor (2010-02-17) 1 commit
  (merged to 'next' on 2010-02-21 at 7361651)
 + connect.c: move duplicated code to a new function 'get_host_and_port'

* ml/encode-header-refactor (2010-02-23) 2 commits
  (merged to 'next' on 2010-02-23 at ac4ec8f)
 + move encode_in_pack_object_header() to a better place
  (merged to 'next' on 2010-02-21 at efe648b)
 + refactor duplicated encode_header in pack-objects and fast-import

* ml/fill-mm-refactor (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at 2fc5570)
 + refactor duplicated fill_mm() in checkout and merge-recursive

* ml/send-pack-transport-refactor (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at db276f4)
 + refactor duplicated code in builtin-send-pack.c and transport.c

Will merge to 'master' soonish.

* mm/mkstemps-mode-for-packfiles (2010-02-22) 6 commits
 - Use git_mkstemp_mode instead of plain mkstemp to create object files
 - git_mkstemps_mode: don't set errno to EINVAL on exit.
 - Use git_mkstemp_mode and xmkstemp_mode in odb_mkstemp, not chmod later.
 - git_mkstemp_mode, xmkstemp_mode: variants of gitmkstemps with mode argument.
 - Move gitmkstemps to path.c
 - Add a testcase for ACL with restrictive umask.

Looked Ok for 'next'.

* rs/optim-text-wrap (2010-02-19) 4 commits
  (merged to 'next' on 2010-02-21 at 70ef189)
 + utf8.c: speculatively assume utf-8 in strbuf_add_wrapped_text()
 + utf8.c: remove strbuf_write()
 + utf8.c: remove print_spaces()
 + utf8.c: remove print_wrapped_text()

Will merge to 'master' soonish.

* tr/maint-cherry-pick-list (2010-02-20) 1 commit
  (merged to 'next' on 2010-02-21 at 65fded0)
 + cherry_pick_list: quit early if one side is empty

Will merge to 'master' soonish, and backmerge to 'maint'.

* tc/transport-verbosity (2010-02-18) 9 commits
 - transport: update flags to be in running order
 - pull: learn --progress
 - fetch: learn --progress
 - push: learn --progress
 - transport->progress: use flag authoritatively
 - clone: support multiple levels of verbosity
 - push: support multiple levels of verbosity
 - fetch: refactor verbosity option handling into transport.[ch]
 - Documentation/git-push.txt: put --quiet before --verbose

Didn't look very carefully.  Comments from transport people are very much
appreciated before moving this forward.

* ld/maint-diff-quiet-w (2010-02-21) 2 commits
  (merged to 'next' on 2010-02-21 at 4701142)
 + git-diff: add a test for git diff --quiet -w
 + git diff --quiet -w: check and report the status

Will merge to 'master' after a few more days of cooking.

* cp/add-u-pathspec (2010-02-09) 2 commits
 - test for add with non-existent pathspec
 - git add -u: die on unmatched pathspec

Will merge to 'next'.

* jc/for-each-ref (2010-02-13) 4 commits
  (merged to 'next' on 2010-02-21 at c9a6c2f)
 + for-each-ref --format='%(flag)'
 + for-each-ref --format='%(symref) %(symref:short)'
 + builtin-for-each-ref.c: check if we need to peel onion while parsing the format
 + builtin-for-each-ref.c: comment fixes

Will merge to 'master' soonish.

* jn/gitweb-config-error-die (2010-02-14) 1 commit
  (merged to 'next' on 2010-02-21 at e3ecd65)
 + gitweb: Die if there are parsing errors in config file

Will merge to 'master' soonish.

* jn/maint-fix-pager (2010-02-22) 8 commits
  (merged to 'next' on 2010-02-23 at 575e0e4)
 + tests: Fix race condition in t7006-pager
  (merged to 'next' on 2010-02-21 at 640e10c)
 + t7006-pager: if stdout is not a terminal, make a new one
 + tests: Add tests for automatic use of pager
 + am: Fix launching of pager
 + git svn: Fix launching of pager
 + git.1: Clarify the behavior of the --paginate option
 + Make 'git var GIT_PAGER' always print the configured pager
 + Fix 'git var' usage synopsis

Will merge to 'master' after a few more days of cooking.

* ml/color-when (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at d52c051)
 + Add an optional argument for --color options

Will merge to 'master' soonish.

* hm/imap-send-cram-md5 (2010-02-15) 1 commit
  (merged to 'next' on 2010-02-21 at de8f650)
 + imap-send: support CRAM-MD5 authentication

Will merge to 'master' after a few more days of cooking.

* jh/maint-submodule-status-in-void (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at 2e605c3)
 + submodule summary: Don't barf when invoked in an empty repo

Will merge to 'master' after a few more days of cooking.

* bg/apply-blank-at-eof (2010-02-17) 3 commits
 - t3417: Add test cases for "rebase --whitespace=fix"
 - t4124: Add additional tests of --whitespace=fix
 - apply: Allow blank context lines to match beyond EOF

RFC.

* gf/maint-sh-setup-nongit-ok (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at aca55e6)
 + require_work_tree broken with NONGIT_OK

Will merge to 'master' soonish, and backmerge to 'maint'.

* jc/maint-status-preload (2010-02-17) 1 commit
  (merged to 'next' on 2010-02-21 at d79e163)
 + status: preload index to optimize lstat(2) calls

Will merge to 'master' soonish, and backmerge to 'maint'.

* nd/root-git (2010-02-14) 5 commits
 - Add test for using Git at root of file system
 - Support working directory located at root
 - Move offset_1st_component() to path.c
 - init-db, rev-parse --git-dir: do not append redundant slash
 - make_absolute_path(): Do not append redundant slash

Will merge to 'next' unless I hear objections.

* ac/cvsimport-revision-mapping (2010-02-06) 1 commit
  (merged to 'next' on 2010-02-17 at 6756446)
 + cvsimport: new -R option: generate .git/cvs-revisions mapping

Will merge to 'master' shortly unless negative comments from CVSimport
users comes.

* jn/maint-makedepend (2010-01-26) 5 commits
  (merged to 'next' on 2010-02-21 at 34a3e48)
 + Makefile: drop dependency on $(wildcard */*.h)
 + Makefile: clean up http-walker.o dependency rules
 + Makefile: remove wt-status.h from LIB_H
 + Makefile: make sure test helpers are rebuilt when headers change
 + Makefile: add missing header file dependencies
 (this branch is used by jn/makedepend and jn/master-makedepend.)

* jn/master-makedepend (2010-01-26) 0 commits
 (this branch uses jn/maint-makedepend; is used by jn/makedepend.)

This is to help merging the clean-up to "master".

* jn/makedepend (2010-01-31) 9 commits
  (merged to 'next' on 2010-02-21 at 34a3e48)
 + Makefile: always remove .depend directories on 'make clean'
 + Makefile: tuck away generated makefile fragments in .depend
 + Teach Makefile to check header dependencies
 + Makefile: list standalone program object files in PROGRAM_OBJS
 + Makefile: lazily compute header dependencies
 + Makefile: list generated object files in OBJECTS
 + Makefile: disable default implicit rules
 + Makefile: rearrange dependency rules
 + Makefile: transport.o depends on branch.h now
 (this branch uses jn/maint-makedepend and jn/master-makedepend.)

Will merge to 'master' after a few more days of cooking.

* jh/notes (2010-02-13) 30 commits
  (merged to 'next' on 2010-02-21 at 75fc451)
 + builtin-notes: Add "copy" subcommand for copying notes between objects
 + builtin-notes: Misc. refactoring of argc and exit value handling
 + builtin-notes: Add -c/-C options for reusing notes
 + builtin-notes: Refactor handling of -F option to allow combining -m and -F
 + builtin-notes: Deprecate the -m/-F options for "git notes edit"
 + builtin-notes: Add "append" subcommand for appending to note objects
 + builtin-notes: Add "add" subcommand for adding notes to objects
 + builtin-notes: Add --message/--file aliases for -m/-F options
 + builtin-notes: Add "list" subcommand for listing note objects
 + Documentation: Generalize git-notes docs to 'objects' instead of 'commits'
 + builtin-notes: Add "prune" subcommand for removing notes for missing objects
 + Notes API: prune_notes(): Prune notes that belong to non-existing objects
 + t3305: Verify that removing notes triggers automatic fanout consolidation
 + builtin-notes: Add "remove" subcommand for removing existing notes
 + Teach builtin-notes to remove empty notes
 + Teach notes code to properly preserve non-notes in the notes tree
 + t3305: Verify that adding many notes with git-notes triggers increased fanout
 + t3301: Verify successful annotation of non-commits
 + Builtin-ify git-notes
 + Refactor notes concatenation into a flexible interface for combining notes
 + Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 + Notes API: write_notes_tree(): Store the notes tree in the database
 + Notes API: for_each_note(): Traverse the entire notes tree with a callback
 + Notes API: get_note(): Return the note annotating the given object
 + Notes API: remove_note(): Remove note objects from the notes tree structure
 + Notes API: add_note(): Add note objects to the internal notes tree structure
 + Notes API: init_notes(): Initialize the notes tree from the given notes ref
 + Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
 + Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 + Minor cosmetic fixes to notes.c
 (this branch is used by tr/notes-display.)

Will merge to 'master' after a few more days of cooking.

* jc/grep-author-all-match-implicit (2010-01-17) 1 commit
  (merged to 'next' on 2010-02-17 at 3b7be80)
 + "log --author=me --grep=it" should find intersection, not union

Will merge to 'master' after a few more days of cooking.

* jh/gitweb-caching (2010-01-30) 1 commit
 - gitweb: Add an option to force version match

The controversial one.  Will probably drop this.  RFC v3 of gitweb caching
series needs to be queued but hasn't happened yet.

* cc/reset-keep (2010-01-19) 5 commits
 - reset: disallow using --keep when there are unmerged entries
 - reset: disallow "reset --keep" outside a work tree
 - Documentation: reset: describe new "--keep" option
 - reset: add test cases for "--keep" option
 - reset: add option "--keep" to "git reset"
