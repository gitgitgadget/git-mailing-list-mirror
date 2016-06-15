From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2013, #07; Mon, 28)
Date: Mon, 28 Oct 2013 12:28:33 -0700
Message-ID: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 28 20:28:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VasUV-0005bm-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 20:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab3J1T2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 15:28:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J1T2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 15:28:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 829194E68C;
	Mon, 28 Oct 2013 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	JF6PT0mzwpTNPMZINr7IEEFJyU=; b=O3kyM8YldGJRYKrPXZNyqXS+SM5yMXHDT
	cexyELcPzkG/irnWa4XMRIytcdeiyqHS82QH786fnzOTv1WzrDNAKXIZiyqyqWgW
	P3Dhq75gr7iEqMPs3UldoqKqayPut4bP1cwGdgAVq7/HY9FDe0Y0qJYjwG9W0BSS
	fuji3BPWpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Gsz
	TJugndsq1T7bWamHa2Z58E9lKJuBa/TfNV/txG1nsADK75aMmoJ/lWxamXWeJIs5
	xCdfFpTa3YgljEoPDSNX8r5gvCcAo9RRqh3oGvDH1XSGmZ2XCP1ceppiWcS8Bn5b
	FKpSSPKe4hg2D1eK7ObK5A5HeDAxk8PgukCLnrMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED324E68B;
	Mon, 28 Oct 2013 19:28:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85BA34E689;
	Mon, 28 Oct 2013 19:28:35 +0000 (UTC)
X-master-at: 0d6cf2471f426dd2b742e2285aad78381738be96
X-next-at: f1bec963d618585da2c32644d95f42c8f174f1ce
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 237D4084-4007-11E3-B278-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236852>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

It is already 10th week of this cycle, but somehow I completely
forgot where in the cycle we were.  Sorry about that.

I'll tag 1.8.5-rc0 in a few days by the end of this month, and then
hopefully we will have two to three -rc weeks after that, aiming for
the final 1.8.5 release sometime late November (tentative schedule
at http://tinyurl.com/gitCal).

As promised/requested, the final steps for 2.0 are in 'next'; they,
together with a handful topics that have been merged to 'next'
fairly recently, will _not_ be part of the upcoming 1.8.5 release,
but will be carried over in 'next' to the next cycle.

Also there is 1.8.4.2 maintenance release out.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ew/keepalive (2013-10-16) 2 commits
  (merged to 'next' on 2013-10-16 at 56fd9f3)
 + http: use curl's tcp keepalive if available
  (merged to 'next' on 2013-10-14 at 24d786f)
 + http: enable keepalive on TCP sockets

 The HTTP transport will try to use TCP keepalive when able.


* jc/revision-range-unpeel (2013-10-15) 1 commit
  (merged to 'next' on 2013-10-16 at d04ddfe)
 + revision: do not peel tags used in range notation

 "git rev-list --objects ^v1.0^ v1.0" gave v1.0 tag itself in the
 output, but "git rev-list --objects v1.0^..v1.0" did not.


* jk/remote-literal-string-leakfix (2013-10-15) 1 commit
  (merged to 'next' on 2013-10-18 at 6abddac)
 + remote: do not copy "origin" string literal


* jk/split-broken-ident (2013-10-15) 1 commit
  (merged to 'next' on 2013-10-18 at 8f4b8b7)
 + split_ident: parse timestamp from end of line

 Make the fall-back parsing of commit objects with broken author or
 committer lines more robust to pick up the timestamps.


* jx/relative-path-regression-fix (2013-10-14) 3 commits
  (merged to 'next' on 2013-10-18 at b4af45f)
 + Use simpler relative_path when set_git_dir
  (merged to 'next' on 2013-10-14 at 704b9ee)
 + relative_path should honor dos-drive-prefix
 + test: use unambigous leading path (/foo) for MSYS

 Will merge to 'master' and later to 'maint'.


* sb/repack-in-c (2013-10-22) 1 commit
  (merged to 'next' on 2013-10-23 at 5d7ac72)
 + Reword repack documentation to no longer state it's a script

 Finishing touches to update documentation.


* sg/prompt-svn-remote-fix (2013-10-15) 1 commit
  (merged to 'next' on 2013-10-18 at 20b47eb)
 + bash prompt: don't use '+=' operator in show upstream code path

 Bash portability fix.

--------------------------------------------------
[New Topics]

* bw/solaris-sed-tr-test-portability (2013-10-28) 2 commits
 - Avoid difference in tr semantics between System V and BSD
 - Change sed i\ usage to something Solaris' sed can handle

 Needs a bit of reroll.


* fc/transport-helper-fixes (2013-10-28) 13 commits
 - test: remote-helper: add test for force pushes
 - git-remote-testgit: support the new 'force' option
 - fixup! transport-helper: add 'force' to 'export' helpers
 - transport-helper: don't update refs in dry-run
 - transport-helper: add support to delete branches
 - fast-export: add support to delete refs
 - fast-import: add support to delete refs
 - transport-helper: add support for old:new refspec
 - fast-export: add new --refspec option
 - fast-export: improve argument parsing
 - transport-helper: check for 'forced update' message
 - transport-helper: fix extra lines
 - transport-helper: add 'force' to 'export' helpers



* jh/loose-object-dirs-creation-race (2013-10-28) 1 commit
 - sha1_file.c:create_tmpfile(): Fix race when creating loose object dirs


* js/test-help-format-windows-port-fix (2013-10-28) 1 commit
 - PATCH] t3200: do not open a HTML manual page when DEFAULT_MAN_FORMAT is html

 Will merge to 'next' after amending the title.


* js/tests-windows-port-fix (2013-10-28) 3 commits
 - tests: undo special treatment of CRLF for Windows
 - Windows: a test_cmp that is agnostic to random LF <> CRLF conversions
 - t5300-pack-object: do not compare binary data using test_cmp

 Will merge to 'next'.


* nd/liteal-pathspecs (2013-10-28) 1 commit
 - pathspec: stop --*-pathspecs impact on internal parse_pathspec() uses


* rs/web-browse-xdg-open (2013-10-28) 1 commit
 - web--browse: Add support for xdg-open.

 Will merge to 'next'.


* sb/refs-code-cleanup (2013-10-28) 2 commits
 - cache: remove unused function 'have_git_dir'
 - refs: remove unused function invalidate_ref_cache

 Will merge to 'next'.


* th/reflog-annotated-tag (2013-10-28) 1 commit
 - reflog: handle lightweight and annotated tags equally

--------------------------------------------------
[Stalled]

* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
 this topic conflicts with.


* sc/doc-howto-dumb-http (2013-10-16) 1 commit
 . doc/howto: warn about (dumb)http server document being too old

 The new text needs to go somewhere in the body of the document,
 not before the title line.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Holding until needed.


* yt/shortened-rename (2013-10-18) 2 commits
 - SQUASH??? style fixes and s/omit/shorten/ where appropriate
 - diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible

 Attempts to give more weight on the fact that a filepair represents
 a rename than showing substring of the actual path when diffstat
 lines are not wide enough.

 I am not sure if that is solving a right problem, though.


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


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


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

* tr/merge-recursive-index-only (2013-10-28) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 Holding until there is a caller to learn from.


* bc/http-100-continue (2013-10-28) 1 commit
 - remote-curl: fix large pushes with GSSAPI

 Conditionally allow "100 Continue" responses to help use of
 GSS-Negotiate authentication scheme over HTTP transport.

 Rerolled. Is everybody happy with this version without
 configuration?


* jc/merge-base-reflog (2013-10-28) 2 commits
 - merge-base: teach "--fork-point" mode
 - merge-base: use OPT_CMDMODE and clarify the command line parsing

 Code the logic in "pull --rebase" that figures out a fork point
 from reflog entries in C.

 Rerolled.


* jk/date-c-double-semicolon (2013-10-24) 1 commit
  (merged to 'next' on 2013-10-28 at 00ce440)
 + drop redundant semicolon in empty while

 Will merge to 'master'.


* jk/for-each-ref-skip-parsing (2013-10-24) 1 commit
 - for-each-ref: avoid loading objects to print %(objectname)

 Will merge to 'next' and then to 'master'.


* jk/pack-bitmap (2013-10-28) 20 commits
 - count-objects: consider .bitmap without .pack/.idx pair garbage
 - pack-bitmap: implement optional name_hash cache
 - t: add basic bitmap functionality tests
 - repack: consider bitmaps when performing repacks
 - repack: handle optional files created by pack-objects
 - repack: turn exts array into array-of-struct
 - repack: stop using magic number for ARRAY_SIZE(exts)
 - pack-objects: implement bitmap writing
 - rev-list: add bitmap mode to speed up object lists
 - pack-objects: use bitmaps when packing objects
 - pack-bitmap: add support for bitmap indexes
 - documentation: add documentation for the bitmap format
 - ewah: compressed bitmap implementation
 - compat: add endianness helpers
 - sha1_file: export `git_open_noatime`
 - revision: allow setting custom limiter function
 - pack-objects: factor out name_hash
 - pack-objects: refactor the packing list
 - revindex: export new APIs
 - sha1write: make buffer const-correct

 Borrows the bitmap index into packfiles from JGit to speed up
 enumeration of objects involved in a commit range without having to
 fully traverse the history.


* jk/refs-c-squelch-gcc (2013-10-24) 1 commit
  (merged to 'next' on 2013-10-28 at d15f7c2)
 + silence gcc array-bounds warning

 Will merge to 'master'.


* jk/robustify-parse-commit (2013-10-24) 6 commits
 - checkout: do not die when leaving broken detached HEAD
 - use parse_commit_or_die instead of custom message
 - use parse_commit_or_die instead of segfaulting
 - assume parse_commit checks for NULL commit
 - assume parse_commit checks commit->object.parsed
 - log_tree_diff: die when we fail to parse a commit

 Will merge to 'next' after taking another look.


* mh/fetch-tags-in-addition-to-normal-refs (2013-10-24) 16 commits
 - fetch, remote: properly convey --no-prune options to subprocesses
 - builtin/remote.c:update(): use struct argv_array
 - builtin/remote.c: reorder function definitions
 - query_refspecs(): move some constants out of the loop
 - fetch --prune: prune only based on explicit refspecs
 - SQUASH??? --tags is no longer a short-hand
 - fetch --tags: fetch tags *in addition to* other stuff
 - builtin/fetch.c: reorder function definitions
 - ref_remove_duplicates(): improve documentation comment
 - ref_remove_duplicates(): simplify function
 - ref_remove_duplicates(): avoid redundant bisection
 - get_ref_map(): rename local variables
 - api-remote.txt: correct section "struct refspec"
 - t5510: check that "git fetch --prune --tags" does not prune branches
 - t5510: prepare test refs more straightforwardly
 - t5510: use the correct tag name in test

 Some questionable paragraphs in the doc updates, but other than
 that looks reasonably solid.

 Expecting a reroll.


* nd/lift-path-max (2013-10-24) 2 commits
  (merged to 'next' on 2013-10-28 at 07698af)
 + checkout_entry(): clarify the use of topath[] parameter
 + entry.c: convert checkout_entry to use strbuf

 Will merge to 'master'.


* jk/pack-corruption-post-mortem (2013-10-25) 1 commit
 - howto: add article on recovering a corrupted object

 Will merge to 'next' and then to 'master'.


* jk/reset-p-current-head-fix (2013-10-25) 2 commits
 - reset: pass real rev name to add--interactive
 - add-interactive: handle unborn branch in patch mode

 "git reset -p HEAD" has codepath to special case it from resetting
 to contents of other commits, but recent change broke it.

 Will merge to 'next' and then to 'master'.


* mf/graph-show-root (2013-10-25) 1 commit
 - graph.c: mark root commit differently

 In a repository with multiple-roots, "log --graph", especially with
 "--oneline", does not give the reader enough visual cue to see
 where one line of history ended and a separate history began.

 This is the version that marks the roots 'x' when they would have
 been marked as '*'; Keshav Kini suggested an alternative of giving
 an extra blank line after every root, which I tend to think is a
 better approach to the problem.


* nv/parseopt-opt-arg (2013-10-25) 1 commit
 - rev-parse --parseopt: add the --sticked-long mode

 Enhance "rev-parse --parseopt" mode to help parsing options with
 an optional parameter.

 Option name bikeshedding aside ("Is it sticked or stuck?"), the
 change seems to be competently done.


* ap/remote-hg-unquote-cquote (2013-10-23) 1 commit
  (merged to 'next' on 2013-10-28 at 6b99fd5)
 + remote-hg: unquote C-style paths when exporting

 A fast-import stream expresses a pathname with funny characters by
 quoting them in C style; remote-hg remote helper forgot to unquote
 such a path.

 Will merge to 'next'.


* jl/pack-transfer-avoid-double-close (2013-10-23) 1 commit
  (merged to 'next' on 2013-10-28 at 4a55bba)
 + Clear fd after closing to avoid double-close error

 The codepath that send_pack() calls pack_objects() mistakenly
 closed the same file descriptor twice, leading to potentially
 closing a wrong file descriptor that was opened in the meantime.

 Will merge to 'master' and later to 'maint'.


* nd/magic-pathspec (2013-10-22) 1 commit
  (merged to 'next' on 2013-10-28 at 50eda68)
 + Fix calling parse_pathspec with no paths nor PATHSPEC_PREFER_* flags

 All callers to parse_pathspec() must choose between getting no
 pathspec or one path that is limited to the current directory
 when there is no paths given on the command line, but there were
 two callers that violated this rule, triggering a BUG().

 Will merge to 'master'.


* sb/git-svn-docs-indent-with-ht (2013-10-22) 1 commit
  (merged to 'next' on 2013-10-28 at 8a952d1)
 + git-svn docs: Use tabs consistently within the ascii doc

 Will merge to 'master'.


* tr/gitk-doc-update (2013-10-22) 1 commit
  (merged to 'next' on 2013-10-28 at f4158b8)
 + Documentation: revamp gitk(1)

 Will merge to 'master'.


* tr/valgrind-test-fix (2013-10-22) 2 commits
  (merged to 'next' on 2013-10-28 at 4d3f31a)
 + Revert "test-lib: allow prefixing a custom string before "ok N" etc."
 + Revert "test-lib: support running tests under valgrind in parallel"

 Will merge to 'master'.


* mm/checkout-auto-track-fix (2013-10-18) 2 commits
  (merged to 'next' on 2013-10-28 at f4594ba)
 + checkout: proper error message on 'git checkout foo bar --'
 + checkout: allow dwim for branch creation for "git checkout $branch --"

 "git checkout topic", when there is not yet a local "topic" branch
 but there is a unique remote-tracking branch for a remote "topic"
 branch, pretended as if "git checkout -t -b topic remote/$r/topic"
 (for that unique remote $r) was run. This hack however was not
 implemented for "git checkout topic --".

 Will merge to 'master'.


* hn/log-graph-color-octopus (2013-10-18) 1 commit
  (merged to 'next' on 2013-10-28 at e103175)
 + graph: fix coloring around octopus merges

 Will merge to 'master'.


* nd/gc-lock-against-each-other (2013-10-18) 1 commit
  (merged to 'next' on 2013-10-28 at 14bd458)
 + gc: remove gc.pid file at end of execution

 Will merge to 'master'.


* fc/styles (2013-10-16) 7 commits
  (merged to 'next' on 2013-10-28 at cf592ed)
 + block-sha1/sha1.c: have SP around arithmetic operators
 + base85.c: have SP around arithmetic operators
 + archive.c: have SP around arithmetic operators
 + alloc.c: have SP around arithmetic operators
 + abspath.c: have SP around arithmetic operators
 + alias: have SP around arithmetic operators
 + C: have space around && and || operators

 C coding style fixes.

 Will merge to 'master'.


* sg/t3600-nul-sha1-fix (2013-10-16) 1 commit
  (merged to 'next' on 2013-10-28 at ac4b703)
 + t3600: fix broken "choking git rm" test

 Will merge to 'master'.


* ak/submodule-foreach-quoting (2013-09-27) 1 commit
  (merged to 'next' on 2013-10-14 at d77c5f1)
 + submodule foreach: skip eval for more than one argument

 A behavior change, but a worthwhile one: "git submodule foreach"
 was treating its arguments as part of a single command to be
 concatenated and passed to a shell, making writing buggy
 scripts too easy.

 This patch preserves the old "just pass it to the shell" behavior
 when a single argument is passed to 'git submodule foreach' and
 moves to a new "skip the shell and use the arguments passed
 unmolested" behavior when more than one argument is passed.

 The old behavior (always concatenating and passing to the shell)
 was similar to the 'ssh' command, while the new behavior (switching
 on the number of arguments) is what 'xterm -e' does.

 May need more thought to make sure this change is advertised well
 so that scripts that used multiple arguments but added their own
 extra layer of quoting are not broken.

 Will cook in 'next' for the rest of this cycle.


* jk/http-auth-redirects (2013-10-24) 10 commits
  (merged to 'next' on 2013-10-24 at 4bebb66)
 + http.c: Spell the null pointer as NULL
 + remote-curl: rewrite base url from info/refs redirects
 + remote-curl: store url as a strbuf
 + remote-curl: make refs_url a strbuf
 + http: update base URLs when we see redirects
 + http: provide effective url to callers
 + http: hoist credential request out of handle_curl_result
  (merged to 'next' on 2013-10-14 at a0642be)
 + http: refactor options to http_get_*
 + http_request: factor out curlinfo_strbuf
 + http_get_file: style fixes

 Handle the case where http transport gets redirected during the
 authorization request better.

 Will merge to 'master'.


* jl/submodule-mv (2013-10-13) 1 commit
  (merged to 'next' on 2013-10-28 at 8dc9b31)
 + mv: Fix spurious warning when moving a file in presence of submodules

 Moving a regular file in a repository with a .gitmodules file was
 producing a warning 'Could not find section in .gitmodules where
 path=<filename>'.

 Will merge to 'master'.


* kb/fast-hashmap (2013-10-22) 12 commits
 - remove old hash.[ch] implementation
 - read-cache.c: fix memory leaks caused by removed cache entries
 - name-hash.c: remove cache entries instead of marking them CE_UNHASHED
 - name-hash.c: use new hash map implementation for cache entries
 - name-hash.c: remove unreferenced directory entries
 - name-hash.c: use new hash map implementation for directories
 - diffcore-rename.c: use new hash map implementation
 - diffcore-rename.c: simplify finding exact renames
 - diffcore-rename.c: move code around to prepare for the next patch
 - buitin/describe.c: use new hash map implementation
 - add a hashtable implementation that supports O(1) removal
 - submodule: don't access the .gitmodules cache entry after removing it

 Improvements to our hash table to get it to meet the needs of the
 msysgit fscache project, with some nice performance improvements.

 The preparatory clean-up to submodule from Jens is at the bottom. I
 also squashed in a fix-up by Karsten found at $gmane/236468 (please
 double-check the result).

 Will merge to 'next'.


* jc/upload-pack-send-symref (2013-10-22) 10 commits
  (merged to 'next' on 2013-10-23 at 8ef5660)
 + t5570: Update for clone-progress-to-stderr branch
 + Merge branch 'jk/clone-progress-to-stderr' into jc/upload-pack-send-symref
 + t5570: Update for symref capability
  (merged to 'next' on 2013-10-16 at eb1ae25)
 + clone: test the new HEAD detection logic
 + connect: annotate refs with their symref information in get_remote_head()
 + connect.c: make parse_feature_value() static
 + upload-pack: send non-HEAD symbolic refs
 + upload-pack: send symbolic ref information as capability
 + upload-pack.c: do not pass confusing cb_data to mark_our_ref()
 + t5505: fix "set-head --auto with ambiguous HEAD" test

 One long-standing flaw in the pack transfer protocol used by "git
 clone" was that there was no way to tell the other end which branch
 "HEAD" points at, and the receiving end needed to guess.  A new
 capability has been defined in the pack protocol to convey this
 information so that cloning from a repository with more than one
 branches pointing at the same commit where the HEAD is at now
 reliably sets the initial branch in the resulting repository.

 Will merge to 'master'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
  (merged to 'next' on 2013-10-28 at d8cdf30)
 + git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
  (merged to 'next' on 2013-10-28 at f1bec96)
 + core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
  (merged to 'next' on 2013-10-28 at 3153a9e)
 + push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
  (merged to 'next' on 2013-10-28 at 5fd76ec)
 + git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future

 Will merge to and cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* jh/shorten-refname (2013-05-07) 4 commits
 . t1514: refname shortening is done after dereferencing symbolic refs
 . shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 . t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 . t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Has been expecting a reroll, as an early part of a larger series.
 $gmane/225137

 Discarded due to inactivity, without prejudice.
