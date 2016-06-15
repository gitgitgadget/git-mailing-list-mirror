From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2015, #01; Thu, 5)
Date: Thu, 05 Nov 2015 15:13:20 -0800
Message-ID: <xmqqlhac3ur3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 00:13:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuTik-0003No-CH
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 00:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072AbbKEXN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 18:13:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756358AbbKEXNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 18:13:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B48DD27517;
	Thu,  5 Nov 2015 18:13:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=U
	RALB4PQdvPvPRFydxS8P43woF0=; b=dvyFcdFYXXKs9gc498gQ+1AnoovlxgDDi
	FcPMGVRfpwm+9RO8KEDuNAcadQfXX22eXP6vWFLYhl7BGvSPC/GQzO2HAKwXSDdK
	qUAZ9YO7fmNzdOKUOUHerNJ58aGWU3tqzYlnoQ/wwE1x08JzgI6vMIQMHLgUT4sn
	tj1EMOzhV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=oAc
	c+fmK8gzWn1tyTJHU7GuQaSPaEKYrHwkTOW5NrMjBCQ+CpcUPjTu5rT818SDjW8x
	eLC7j2EYIvLt/TTH3naeFwEJ1mL3fLxAodERYYGCgXaSXvrZtzOUk1BW3nUK8tvJ
	BpNaJCH7j2OaV+WS19AwmOSQeCuNIfnxZGbtUEiU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD6DC27516;
	Thu,  5 Nov 2015 18:13:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0879D27515;
	Thu,  5 Nov 2015 18:13:21 -0500 (EST)
X-master-at: 2c78628255b8cc7f0b5d47981acea138db8716d2
X-next-at: 550542234b0fed5a3944af44b01152b620e8dba1
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CEEB348E-8412-11E5-8930-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280946>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Git 2.6.3 has been tagged, with accumulated fixes and minor updates
that are already in 'master'.  We have about 5 weeks left til -rc0
so hopefully a handful of topics that are not yet in 'next' but have
already been reviewed and polished may be able to be merged to
'next', cook in there for a while and be in 2.7.0 release.  I'll be
offline for a few weeks starting this weekend, but I am confident
that our capable interim maintainer can shepherd these topics
forward with the help from our contributors ;-).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* da/difftool (2015-10-29) 1 commit
  (merged to 'next' on 2015-11-01 at 4e5ab33)
 + difftool: ignore symbolic links in use_wt_file

 The code to prepare the working tree side of temporary directory
 for the "dir-diff" feature forgot that symbolic links need not be
 copied (or symlinked) to the temporary area, as the code already
 special cases and overwrites them.  Besides, it was wrong to try
 computing the object name of the target of symbolic link, which may
 not even exist or may be a directory.


* jc/mailinfo-lib (2015-11-01) 1 commit
  (merged to 'next' on 2015-11-01 at 3ecaa28)
 + mailinfo: fix passing wrong address to git_mailinfo_config

 Hotfix for a topic already in 'master'.


* jk/initialization-fix-to-add-submodule-odb (2015-10-28) 1 commit
  (merged to 'next' on 2015-11-01 at da94b97)
 + add_submodule_odb: initialize alt_odb list earlier

 We peek objects from submodule's object store by linking it to the
 list of alternate object databases, but the code to do so forgot to
 correctly initialize the list.


* js/git-gdb (2015-10-30) 1 commit
  (merged to 'next' on 2015-11-01 at 3d232d5)
 + test: facilitate debugging Git executables in tests with gdb

 Allow easier debugging of a single "git" invocation in our test
 scripts.


* kn/for-each-branch (2015-10-30) 1 commit
  (merged to 'next' on 2015-11-01 at 4249dc9)
 + ref-filter: fallback on alphabetical comparison

 Using the timestamp based criteria in "git branch --sort" did not
 tiebreak branches that point at commits with the same timestamp (or
 the same commit), making the resulting output unstable.


* mk/blame-first-parent (2015-10-30) 3 commits
  (merged to 'next' on 2015-11-01 at 3f87150)
 + blame: allow blame --reverse --first-parent when it makes sense
 + blame: extract find_single_final
 + blame: test to describe use of blame --reverse --first-parent

 "git blame" learnt to take "--first-parent" and "--reverse" at the
 same time when it makes sense.


* rs/daemon-plug-child-leak (2015-11-02) 2 commits
  (merged to 'next' on 2015-11-02 at 64afbb9)
 + daemon: plug memory leak
 + run-command: factor out child_process_clear()
 (this branch is used by sb/submodule-parallel-update.)

 "git daemon" uses "run_command()" without "finish_command()", so it
 needs to release resources itself, which it forgot to do.


* rs/show-branch-argv-array (2015-11-01) 1 commit
  (merged to 'next' on 2015-11-01 at fac4fa6)
 + show-branch: use argv_array for default arguments

 Code simplification.


* rs/wt-status-detached-branch-fix (2015-11-01) 5 commits
  (merged to 'next' on 2015-11-01 at cb23615)
 + wt-status: use skip_prefix() to get rid of magic string length constants
 + wt-status: don't skip a magical number of characters blindly
 + wt-status: avoid building bogus branch name with detached HEAD
 + wt-status: exit early using goto in wt_shortstatus_print_tracking()
 + t7060: add test for status --branch on a detached HEAD

 "git status --branch --short" accessed beyond the constant string
 "HEAD", which has been corrected.

--------------------------------------------------
[New Topics]

* ad/sha1-update-chunked (2015-11-05) 2 commits
 - sha1: allow limiting the size of the data passed to SHA1_Update()
 - sha1: provide another level of indirection for the SHA-1 functions

 Apple's common crypto implementation of SHA1_Update() does not take
 more than 4GB at a time, and we now have a compile-time workaround
 for it.

 I think this is more or less ready.  I am skeptical about the file
 location reorg ([PATCH 3/3] $gmane/280912) and did not queue it.


* dt/http-range (2015-11-02) 2 commits
  (merged to 'next' on 2015-11-03 at 7c3cc60)
 + http: use off_t to store partial file size
 + http.c: use CURLOPT_RANGE for range requests

 A Range: request can be responded with a full response and when
 asked properly libcurl knows how to strip the result down to the
 requested range.  However, we were hand-crafting a range request
 and it did not kick in.

 Will merge to 'master'.


* vl/grep-configurable-threads (2015-11-01) 1 commit
 - grep: add --threads=<num> option and grep.threads configuration

 "git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

 Expecting a reroll.
 ($gmane/280854)


* kf/http-proxy-auth-methods (2015-11-04) 3 commits
 - SQUASH???
 - http: use credential API to handle proxy authentication
 - http: allow selection of proxy authentication method

 New http.proxyAuthMethod configuration variable can be used to
 specify what authentication method to use, as a way to work around
 proxies that do not give error response expected by libcurl when
 CURLAUTH_ANY is used.  Also, the codepath for proxy authentication
 has been taught to use credential API to store the authentication
 material in user's keyrings.

 Still being worked on.
 ($gmane/280925).


* lf/ref-is-hidden-namespace (2015-11-05) 4 commits
 - t5509: add basic tests for hideRefs
 - hideRefs: add support for matching full refs
 - upload-pack: strip refs before calling ref_is_hidden()
 - config.txt: document the semantics of hideRefs with namespaces

 Extend transfer.hideRefs to work better with use of namespaces.

 Will merge to 'next'.


* dg/git-svn-empty-dirs (2015-11-05) 1 commit
 - git-svn: improve rebase/mkdirs performance


* fp/subtree-todo-update (2015-11-05) 1 commit
 - contrib/subtree: remove "push" command from the "todo" file

--------------------------------------------------
[Stalled]

* nd/ita-cleanup (2015-09-06) 6 commits
 - grep: make it clear i-t-a entries are ignored
 - checkout(-index): do not checkout i-t-a entries
 - apply: make sure check_preimage() does not leave empty file on error
 - apply: fix adding new files on i-t-a entries
 - add and use a convenience macro ce_intent_to_add()
 - blame: remove obsolete comment

 Paths that have been told the index about with "add -N" are not yet
 in the index, but various commands behaved as if they already are.

 Some commits need better explanation.

 Waiting for a reroll.


* ld/p4-detached-head (2015-09-09) 2 commits
 - git-p4: work with a detached head
 - git-p4: add failing test for submit from detached head

 Will be rerolled.
 ($gmane/277574)


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Becoming tired of waiting for a reroll.
 ($gmane/271213).


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Reroll exists but didn't pick it up as it seemed to be still
 collecting review comments.

 Becoming tired of waiting for a reroll.
 ($gmane/272180).


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

--------------------------------------------------
[Cooking]

* dk/gc-idx-wo-pack (2015-11-04) 3 commits
 - gc: remove garbage .idx files from pack dir
 - t5304: test cleaning pack garbage
 - prepare_packed_git(): refactor garbage reporting in pack directory

 Having a leftover .idx file without corresponding .pack file in
 the repository hurts performance; "git gc" learned to prune them.

 We may want to do the same for .bitmap (and notice but not prune
 .keep) without corresponding .pack, but that can be a separate
 topic.

 Will merge to 'next'.


* sb/submodule-parallel-update (2015-11-05) 10 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - fetching submodules: respect `submodule.jobs` config option
 - submodule config: update parse_config()
 - submodule config: remove name_and_item_from_var
 - submodule config: keep update strategy around
 - run_processes_parallel: add output to tracing messages
 - Merge branch 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update
 - Merge branch 'sb/submodule-parallel-fetch' into sb/submodule-parallel-update
 (this branch uses sb/submodule-parallel-fetch; is tangled with rs/daemon-leak-fix.)

 Builds on top of the "fetch --recurse-submodules" work to introduce
 parallel downloading into multiple submodules for "submodule update".

 Waiting for sb/submodule-parallel-fetch to stabilize.

 It would be the cleanest to rebuild sb/submodule-parallel-fetch on
 top of 2.7.0 once it ships and then build this directly on top;
 that way, we do not have to have merges in this topic that
 distracting (besides, some part of the other topic can be updated
 in-place instead of this follow-up topic tweaking them as past
 mistakes and inflexibilities).


* jc/strbuf-gets (2015-10-28) 17 commits
 - test-sha1-array: read command stream with strbuf_gets()
 - grep: read -f file with strbuf_gets()
 - send-pack: read list of refs with strbuf_gets()
 - column: read lines with strbuf_gets()
 - cat-file: read batch stream with strbuf_gets()
 - transport-helper: read helper response with strbuf_gets()
 - clone/sha1_file: read info/alternates with strbuf_gets()
 - remote.c: read $GIT_DIR/remotes/* with strbuf_gets()
 - ident.c: read /etc/mailname with strbuf_gets()
 - rev-parse: read parseopt spec with strbuf_gets()
 - revision: read --stdin with strbuf_gets()
 - hash-object: read --stdin-paths with strbuf_gets()
 - mktree: read textual tree representation with strbuf_gets()
 - update-index: read list of paths with strbuf_gets() under --stdin
 - update-index: read --index-info with strbuf_gets()
 - check-attr, check-ignore, checkout-index: read paths with strbuf_gets()
 - strbuf: add strbuf_gets()

 Teach codepaths that communicate with users by reading text files
 to be more lenient to editors that write CRLF-terminated lines.
 Note that this is only about communication with Git, like feeding
 list of object names from the standard input instead of from the
 command line, and does not involve files in the working tree.

 Waiting for reviews.


* eg/p4-submit-catch-failure (2015-10-30) 1 commit
 - git-p4: clean up after p4 submit failure

 Just like the working tree is cleaned up when the user cancelled
 submission in P4Submit.applyCommit(), clean up the mess if "p4
 submit" fails.

 Needs an update to test.
 ($gmane/280539)


* ep/ident-with-getaddrinfo (2015-10-30) 1 commit
 - (NEEDSWORK $gmane/280507) ident.c: add support for IPv6

 A build without NO_IPv6 used to use gethostbyname() when guessing
 user's hostname, instead of getaddrinfo() that is used in other
 codepaths in such a build.

 Waiting for a reroll.
 ($gmane/280507)


* ea/checkout-progress (2015-11-01) 1 commit
  (merged to 'next' on 2015-11-03 at 08a8d1f)
 + checkout: add --progress option

 "git checkout" did not follow the usual "--[no-]progress"
 convention and implemented only "--quiet" that is essentially
 a superset of "--no-progress".  Extend the command to support the
 usual "--[no-]progress".

 Will merge to 'master'.


* jc/test-must-fail-with-sigpipe (2015-10-30) 1 commit
 - test: accept death by SIGPIPE as a valid failure mode

 In some tests we expect a git command that transfers objects to
 result in failure, but it is normal for the failure to come from
 SIGPIPE when the other end of the connection detects an (expected)
 error and hangs up.  However, test_expect_failure helper function
 was not prepared to see a death by sigpipe as a normal failure
 exit.

 It probably is more sensible to limit the test that allows depth by
 SIGPIPE as Lars Schneider suggests, so it is likely that this will
 be replaced while I am away ;-)


* pt/http-socks-proxy (2015-10-26) 1 commit
 - remote-http(s): support SOCKS proxies

 Add support for talking http/https over socks proxy.
 Needs a sign-off from the original author.


* mh/notes-allow-reading-treeish (2015-10-08) 3 commits
  (merged to 'next' on 2015-10-23 at 8a697f0)
 + notes: allow treeish expressions as notes ref
 + Merge branch 'jk/notes-dwim-doc' into next
 + Merge branch 'jc/merge-drop-old-syntax' into next
 (this branch uses jc/merge-drop-old-syntax.)

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).

 As the patch was done on top of the 'drop old-syntax from merge',
 this has to wait until that other topic can graduate, unfortunately.
 It can be redone in a way that does not depend on that topic after
 this cycle, though.

 Will keep in 'next'.


* jc/mailinfo (2015-10-21) 1 commit
 - mailinfo: ignore in-body header that we do not care about

 Some people write arbitrary garbage at the beginning of a piece of
 e-mail (or after -- >8 -- scissors -- >8 -- line) in the commit log
 message and expect them to be discarded, even though "From:" and
 "Subject:" are the only documented in-body headers that you are
 supposed to have there.  Allow some garbage (specifically, what may
 look like RFC2822 headers like "MIME-Version: ...") to be there and
 ignore them.

 I have a feeling that that this is a step in a wrong direction.
 Comments?


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
  (merged to 'next' on 2015-10-23 at dc631e5)
 + am: make a direct call to merge_recursive
 + merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, we would want to see it backed up by numbers.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.

 Will keep in 'next'.


* sg/pretty-more-date-mode-format (2015-10-07) 1 commit
 - pretty: add format specifiers for short and raw date formats

 Introduce "%as" and "%aR" placeholders for "log --format" to show
 the author date in the short and raw formats.

 I have a feeling that that this is a step in a wrong direction.
 Comments?


* kn/for-each-branch-remainder (2015-10-02) 9 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: adopt get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: add support for %(path) atom
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: implement %(if), %(then), and %(else) atoms

 More unification among "branch -l", "tag -l" and "for-each-ref --format".

 Expecting a reroll.
 ($gmane/278926)


* jk/graph-format-padding (2015-09-14) 1 commit
 - pretty: pass graph width to pretty formatting for use in '%>|(N)'

 Redefine the way '%>|(N)' padding and the "--graph" option
 interacts.  It has been that the available columns to display the
 log message was measured from the edge of the area the graph ended,
 but with this it becomes the beginning of the entire output.

 I have a suspicion that 50% of the users would appreciate this
 change, and the remainder see this break their expectation.  If
 that is the case, we might need to introduce a similar but
 different alignment operator so that this new behaviour is
 available to those who want to use it, without negatively affecting
 existing uses.

 Undecided.
 ($gmane/278326)


* sb/submodule-parallel-fetch (2015-11-05) 16 commits
 - strbuf: update documentation for strbuf_read_once()
 - run-command: remove set_nonblocking()
  (merged to 'next' on 2015-10-23 at 8f04bbd)
 + run-command: fix missing output from late callbacks
 + test-run-command: increase test coverage
 + test-run-command: test for gracefully aborting
 + run-command: initialize the shutdown flag
 + run-command: clear leftover state from child_process structure
 + run-command: fix early shutdown
  (merged to 'next' on 2015-10-15 at df63590)
 + submodules: allow parallel fetching, add tests and documentation
 + fetch_populated_submodules: use new parallel job processing
 + run-command: add an asynchronous parallel child processor
 + sigchain: add command to pop all common signals
 + strbuf: add strbuf_read_once to read without blocking
 + xread_nonblock: add functionality to read from fds without blocking
 + xread: poll on non blocking fds
 + submodule.c: write "Fetching submodule <foo>" to stderr
 (this branch is used by sb/submodule-parallel-update; is tangled with rs/daemon-leak-fix.)

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 Still being worked on, but it seems that we are seeing light at the
 end of the tunnel.
 ($gmane/280937)


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2015-09-14) 7 commits
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


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-10-07 at 50fed71)
 + merge: drop 'git merge <message> HEAD <commit>' syntax
 (this branch is used by mh/notes-allow-reading-treeish.)

 Originally merged to 'next' on 2015-05-28

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.

 Will keep in 'next'.

--------------------------------------------------
[Discarded]

* km/cache-entry-refcnt (2015-10-14) 1 commit
 . merge: fix cache_entry use-after-free

 Made unnecessary with dt/name-hash-dir-entry-fix topic.


* rs/daemon-leak-fix (2015-10-31) 3 commits
  (merged to 'next' on 2015-11-01 at 9b6c8f9)
 + daemon: plug memory leak
 + run-command: export child_process_clear()
 + run-command: name the cleanup function child_process_clear()
 (this branch uses sb/submodule-parallel-fetch; is tangled with sb/submodule-parallel-update.)

 "git daemon" uses "run_command()" without "finish_command()", so it
 needs to release resources itself, which it forgot to do.

 This was tangled with another topic that was not quite ready.
 Discard and replace it with an equivalent rs/daemon-plug-child-leak
 that is independent.


* dt/refs-backend-pre-vtable (2015-10-15) 26 commits
 . refs: break out ref conflict checks
 . refs: make files_log_ref_write functions public
 . initdb: move safe_create_dir into common code
 . refs.c: move should_autocreate_reflog to common code
 . refs.c: move peel_object to the common code
 . refs.c: move copy_msg to the common code
 . refs.c: move refname_is_safe to the common code
 . refs: move transaction functions into common code
 . refs.c: move head_ref_namespaced to the common code
 . refs.c: move ref iterators to the common code
 . refs.c: move prettify_refname to the common code
 . refs.c: move is_branch to the common code
 . refs.c: move check_refname_format to the common code
 . refs.c: move resolve_refdup to common
 . refs.c: move read_ref, read_ref_full and ref_exists to the common code
 . refs.c: move warn_if_dangling_symref* to the common code
 . refs.c: move dwim and friend functions to the common refs code
 . refs.c: move the hidden refs functions to the common code
 . refs.c: move read_ref_at to the common refs file
 . refs.c: move delete_pseudoref and delete_ref to the common code
 . refs.c: move update_ref to refs.c
 . refs.c: add a new refs.c file to hold all common refs code
 . refs-be-files.c: rename refs to refs-be-files
 . refs: make repack_without_refs and is_branch public
 . refs.c: create a public version of verify_refname_available
 . Merge branch 'jk/war-on-sprintf' into HEAD

 The early part of the pluggable ref backend series, which sifts the
 ref API functions into two bins: the filesystem backend specific
 ones and the generic API functions.  The next step will start
 introducing the framework to dispatch generic calls to specific
 backend implementation(s) and then finally plug a new backend that
 is different from the file backend.

 It seems Michael's "I'd do it like this if I were doing it"
 $gmane/280754 would be the way forward?

 Ejected while the topic is in flux, as this and its later reroll
 both want to move things around while other topics want to update
 the files involved.
