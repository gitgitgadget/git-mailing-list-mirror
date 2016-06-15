From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2013, #08; Tue, 23)
Date: Tue, 23 Apr 2013 12:31:44 -0700
Message-ID: <7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 21:31:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUiwW-0006p0-6d
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 21:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab3DWTbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 15:31:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59096 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab3DWTbs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 15:31:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D73F18B2D;
	Tue, 23 Apr 2013 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5iDbpRt9kXrMlJJc0SdqQ8y4qCU=; b=Mgqdfp
	li08MAHpKgvfTZVo39BD+OvC5h2bwOGchobJH5bYBRPjeWKq60nXA+3A+MBrlcyZ
	rDQ8/nLBL6ugwC6S1TUwSGHZti1mLmPhg3I+xXEItxhgzhhqS+yKcKyqfh/iGVR1
	X1wdkbjhLMNKXqqSAwyzpziCuvvV5T0pb4z0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ojKRvWPRufyI3qdGFlRmS8vrwbFpLKWE
	ibEk3Q7q2JU4MC/zYDy8WoG4HaCLZ5XFZzoi31GpnrA9HtO+nW06T6ZRtGSS+J4m
	6iHCqEjQo/BVkLDbQ8kGdCcjfeDkj9h+k6lT9MHjUIKHykTbmC2XV4oSlh8JRo6X
	Sa7hd9/fYqU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5424318B2C;
	Tue, 23 Apr 2013 19:31:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C4D718B1E;
	Tue, 23 Apr 2013 19:31:46 +0000 (UTC)
X-master-at: 562af5b0b900539bd7ef481316834e500f571899
X-next-at: d6019519f9f40af1f430c4a5e6d87e69d376483d
In-Reply-To: <7vvc7enxco.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 22 Apr 2013 13:07:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F6A3EA6-AC4C-11E2-9A03-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222209>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Both of the two topics on preparing "git add" users for the
behaviour change in Git 2.0 are in 'master'.  We may want to tweak
the wording of warning messages and such before the feature freeze
(see jc/add-ignore-removal topic in 'pu' for a proposal).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* fc/untracked-zsh-prompt (2013-04-21) 1 commit
  (merged to 'next' on 2013-04-22 at 472da3e)
 + prompt: fix untracked files for zsh

 Zsh completion forgot that '%' character used to signal untracked
 files needs to be escaped with another '%'.


* jk/receive-pack-deadlocks-with-early-failure (2013-04-19) 1 commit
  (merged to 'next' on 2013-04-22 at 1e27177)
 + receive-pack: close sideband fd on early pack errors

 When receive-pack detects error in the pack header it received in
 order to decide which of unpack-objects or index-pack to run, it
 returned without closing the error stream, which led to a hang
 sideband thread.


* jn/gitweb-install-doc (2013-04-17) 2 commits
  (merged to 'next' on 2013-04-22 at a5d4812)
 + gitweb/INSTALL: GITWEB_CONFIG_SYSTEM is for backward compatibility
 + gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM

 Reword gitweb configuration instrutions.


* kb/status-ignored-optim-2 (2013-04-15) 14 commits
  (merged to 'next' on 2013-04-21 at d2a5c70)
 + dir.c: git-status --ignored: don't scan the work tree twice
 + dir.c: git-status --ignored: don't scan the work tree three times
 + dir.c: git-status: avoid is_excluded checks for tracked files
 + dir.c: replace is_path_excluded with now equivalent is_excluded API
 + dir.c: unify is_excluded and is_path_excluded APIs
 + dir.c: move prep_exclude
 + dir.c: factor out parts of last_exclude_matching for later reuse
 + dir.c: git-clean -d -X: don't delete tracked directories
 + dir.c: make 'git-status --ignored' work within leading directories
 + dir.c: git-status --ignored: don't list empty directories as ignored
 + dir.c: git-ls-files --directories: don't hide empty directories
 + dir.c: git-status --ignored: don't list empty ignored directories
 + dir.c: git-status --ignored: don't list files in ignored directories
 + dir.c: git-status --ignored: don't drop ignored directories

 A handful of issues in the code to traverse working tree to find
 untracked and/or ignored files have been fixed, and the general
 codepath involved in "status -u" and "clean" have been cleaned up
 and optimized.


* nd/pretty-formats (2013-04-18) 13 commits
  (merged to 'next' on 2013-04-22 at 3d63014)
 + pretty: support %>> that steal trailing spaces
 + pretty: support truncating in %>, %< and %><
 + pretty: support padding placeholders, %< %> and %><
 + pretty: add %C(auto) for auto-coloring
 + pretty: split color parsing into a separate function
 + pretty: two phase conversion for non utf-8 commits
 + utf8.c: add reencode_string_len() that can handle NULs in string
 + utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
 + utf8.c: move display_mode_esc_sequence_len() for use by other functions
 + pretty: share code between format_decoration and show_decorations
 + pretty-formats.txt: wrap long lines
 + pretty: get the correct encoding for --pretty:format=%e
 + pretty: save commit encoding from logmsg_reencode if the caller needs it

 pretty-printing body of the commit that is stored in non UTF-8
 encoding did not work well.  The early part of this series fixes
 it.  And then it adds %C(auto) specifier that turns the coloring on
 when we are emitting to the terminal, and adds column-aligning
 format directives.

--------------------------------------------------
[New Topics]

* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"
 (this branch uses jc/add-ignore-removal.)

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/add-ignore-removal (2013-04-22) 2 commits
 - git add: rephrase -A/--no-all warning
 - git add: --ignore-removal is a better named --no-all
 (this branch is used by jc/add-2.0-ignore-removal.)

 Introduce "--ignore-removal" as a synonym to "--no-all" for "git
 add", and improve the 2.0 migration warning with it.

 Will merge to 'next'.


* fc/remote-hg (2013-04-22) 16 commits
 - remote-hg: strip extra newline
 - remote-hg: use marks instead of inlined files
 - remote-hg: small performance improvement
 - remote-hg: allow refs with spaces
 - remote-hg: don't update bookmarks unnecessarily
 - remote-hg: add support for schemes extension
 - remote-hg: improve email sanitation
 - remote-hg: add custom local tag write code
 - remote-hg: write tags in the appropriate branch
 - remote-hg: custom method to write tags
 - remote-hg: add support for tag objects
 - remote-hg: add branch_tip() helper
 - remote-hg: properly mark branches up-to-date
 - remote-hg: use python urlparse
 - remote-hg: safer bookmark pushing
 - remote-helpers: avoid has_key

 Further updates to remote-hg (in contrib/).

 Will merge to 'next' after a few days.


* th/bisect-skipped-log (2013-04-23) 1 commit
 - bisect: Log possibly bad, skipped commits at bisection end

--------------------------------------------------
[Stalled]

* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Waiting for a reroll after a review.


* jk/commit-info-slab (2013-04-19) 3 commits
 - commit-slab: introduce a macro to define a slab for new type
 - commit-slab: avoid large realloc
 - commit: allow associating auxiliary info on-demand

 Technology demonstration to show a way we could use unbound number
 of flag bits on commit objects.


* jn/config-ignore-inaccessible (2013-04-15) 1 commit
 - config: allow inaccessible configuration under $HOME

 When $HOME is misconfigured to point at an unreadable directory, we
 used to complain and die. This loosens the check.

 I do not think we agreed that this is a good idea, though.

--------------------------------------------------
[Cooking]

* jh/checkout-auto-tracking (2013-04-21) 8 commits
  (merged to 'next' on 2013-04-22 at 2356700)
 + glossary: Update and rephrase the definition of a remote-tracking branch
 + branch.c: Validate tracking branches with refspecs instead of refs/remotes/*
 + t9114.2: Don't use --track option against "svn-remote"-tracking branches
 + t7201.24: Add refspec to keep --track working
 + t3200.39: tracking setup should fail if there is no matching refspec.
 + checkout: Use remote refspecs when DWIMming tracking branches
 + t2024: Show failure to use refspec when DWIMming remote branch names
 + t2024: Add tests verifying current DWIM behavior of 'git checkout <branch>'

 Updates "git checkout foo" that DWIMs the intended "upstream" and
 turns it into "git checkout -t -b foo remotes/origin/foo" to
 correctly take existing remote definitions into account.  The
 remote "origin" may be what uniquely map its own branch to
 remotes/some/where/foo but that some/where may not be "origin".

 Will cook in 'next'.


* mg/more-textconv (2013-04-23) 7 commits
 - git grep: honor textconv by default
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - t4030: demonstrate behavior of show with textconv

 Rerolld. I am not sure if I like "show <blob>" and "grep" that use
 textconv by default, though.


* jn/glossary-revision (2013-04-21) 1 commit
 - glossary: a revision is just a commit

 The wording for "revision" in the glossary wanted to say it refers
 to "commit (noun) as a concept" but it was badly phrased.

 Will cook in 'next'.

 This may need further updates to hint that in contexts where it is
 clear, the word may refer to an object name, not necessarily a
 commit.


* rr/shortlog-doc (2013-04-22) 8 commits
 - builtin/shortlog.c: make usage string consistent with log
 - builtin/log.c: make usage string consistent with doc
 - git-shortlog.txt: make SYNOPSIS match log, update OPTIONS
 - git-log.txt: rewrite note on why "--" may be required
 - git-log.txt: generalize <since>..<until>
 - git-log.txt: order OPTIONS properly; move <since>..<until>
 - revisions.txt: clarify the .. and ... syntax
 - git-shortlog.txt: remove (-h|--help) from OPTIONS

 Update documentation for "log" and "shortlog".

 Looked reasonable.
 Will merge to 'next'.


* mh/multimail (2013-04-21) 1 commit
 - git-multimail: a replacement for post-receive-email

 Waiting for comments.


* jc/prune-all (2013-04-18) 3 commits
  (merged to 'next' on 2013-04-22 at b00ccf6)
 + api-parse-options.txt: document "no-" for non-boolean options
 + git-gc.txt, git-reflog.txt: document new expiry options
 + date.c: add parse_expiry_date()
 (this branch is used by mh/packed-refs-various.)

 We used the approxidate() parser for "--expire=<timestamp>" options
 of various commands, but it is better to treat --expire=all and
 --expire=now a bit more specially than using the current timestamp.
 Update "git gc" and "git reflog" with a new parsing function for
 expiry dates.

 Will cook in 'next'.


* as/check-ignore (2013-04-11) 5 commits
  (merged to 'next' on 2013-04-21 at 7515aa8)
 + Documentation: add caveats about I/O buffering for check-{attr,ignore}
 + check-ignore: allow incremental streaming of queries via --stdin
 + check-ignore: move setup into cmd_check_ignore()
 + check-ignore: add -n / --non-matching option
 + t0008: remove duplicated test fixture data

 Enhance "check-ignore" (1.8.2 update) to work more like "check-attr"
 over bidi-pipes.

 Will cook in 'next'.
 The test in the second from the tip needs to be updated.


* mh/packed-refs-various (2013-04-23) 33 commits
 - refs: handle the main ref_cache specially
 - refs: change do_for_each_*() functions to take ref_cache arguments
 - pack_one_ref(): do some cheap tests before a more expensive one
 - pack_one_ref(): use write_packed_entry() to do the writing
 - pack_one_ref(): use function peel_entry()
 - refs: inline function do_not_prune()
 - pack_refs(): change to use do_for_each_entry()
 - refs: use same lock_file object for both ref-packing functions
 - pack_one_ref(): rename "path" parameter to "refname"
 - pack-refs: merge code from pack-refs.{c,h} into refs.{c,h}
 - pack-refs: rename handle_one_ref() to pack_one_ref()
 - refs: extract a function write_packed_entry()
 - repack_without_ref(): write peeled refs in the rewritten file
 - t3211: demonstrate loss of peeled refs if a packed ref is deleted
 - refs: change how packed refs are deleted
 - search_ref_dir(): return an index rather than a pointer
 - repack_without_ref(): silence errors for dangling packed refs
 - t3210: test for spurious error messages for dangling packed refs
 - refs: change the internal reference-iteration API
 - refs: extract a function peel_entry()
 - peel_ref(): fix return value for non-peelable, not-current reference
 - peel_object(): give more specific information in return value
 - refs: extract function peel_object()
 - refs: extract a function ref_resolves_to_object()
 - repack_without_ref(): use function get_packed_ref()
 - peel_ref(): use function get_packed_ref()
 - get_packed_ref(): return a ref_entry
 - do_for_each_ref_in_dirs(): remove dead code
 - refs: define constant PEELED_LINE_LENGTH
 - refs: document how current_ref is used
 - refs: document do_for_each_ref() and do_one_ref()
 - refs: document the fields of struct ref_value
 - refs: document flags constants REF_*
 (this branch uses jc/prune-all.)

 Updates reading and updating packed-refs file, correcting corner
 case bugs.

 Waiting for comments.


* jk/remote-helper-with-signed-tags (2013-04-15) 3 commits
  (merged to 'next' on 2013-04-21 at 0231d45)
 + transport-helper: add 'signed-tags' capability
 + transport-helper: pass --signed-tags=warn-strip to fast-export
 + fast-export: add --signed-tags=warn-strip mode

 Allows remote-helpers to declare they can handle signed tags, and
 issue a warning when using those that don't.

 Will merge to 'master'.


* fc/transport-helper-error-reporting (2013-04-17) 9 commits
  (merged to 'next' on 2013-04-22 at 5ba6467)
 + transport-helper: update remote helper namespace
 + transport-helper: trivial code shuffle
 + transport-helper: warn when refspec is not used
 + transport-helper: clarify pushing without refspecs
 + transport-helper: update refspec documentation
 + transport-helper: clarify *:* refspec
 + transport-helper: improve push messages
 + transport-helper: mention helper name when it dies
 + transport-helper: report errors properly

 Update transport helper to report errors and maintain ref hierarchy
 used to keep track of remote helper state better.

 Will merge to 'master'.


* jk/submodule-subdirectory-ok (2013-04-18) 2 commits
  (merged to 'next' on 2013-04-22 at f211e25)
 + submodule: drop the top-level requirement
 + rev-parse: add --prefix option

 Allow various subcommands of "git submodule" to be run not from the
 top of the working tree of the superproject.

 Will cook in 'next'.


* jl/submodule-mv (2013-04-23) 5 commits
  (merged to 'next' on 2013-04-23 at c04f574)
 + submodule.c: duplicate real_path's return value
  (merged to 'next' on 2013-04-19 at 45ae3c9)
 + rm: delete .gitmodules entry of submodules removed from the work tree
 + Teach mv to update the path entry in .gitmodules for moved submodules
 + Teach mv to move submodules using a gitfile
 + Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Will cook in 'next'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-03) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* nd/magic-pathspecs (2013-03-31) 45 commits
 . Rename field "raw" to "_raw" in struct pathspec
 . pathspec: support :(glob) syntax
 . pathspec: make --literal-pathspecs disable pathspec magic
 . pathspec: support :(literal) syntax for noglob pathspec
 . Kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 . parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 . parse_pathspec: make sure the prefix part is wildcard-free
 . tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 . Remove match_pathspec() in favor of match_pathspec_depth()
 . Remove init_pathspec() in favor of parse_pathspec()
 . Remove diff_tree_{setup,release}_paths
 . Convert common_prefix() to use struct pathspec
 . Convert add_files_to_cache to take struct pathspec
 . Convert {read,fill}_directory to take struct pathspec
 . Convert refresh_index to take struct pathspec
 . Convert report_path_error to take struct pathspec
 . checkout: convert read_tree_some to take struct pathspec
 . Convert unmerge_cache to take struct pathspec
 . Convert run_add_interactive to use struct pathspec
 . Convert read_cache_preload() to take struct pathspec
 . reset: convert to use parse_pathspec
 . add: convert to use parse_pathspec
 . check-ignore: convert to use parse_pathspec
 . archive: convert to use parse_pathspec
 . ls-files: convert to use parse_pathspec
 . rm: convert to use parse_pathspec
 . checkout: convert to use parse_pathspec
 . rerere: convert to use parse_pathspec
 . status: convert to use parse_pathspec
 . commit: convert to use parse_pathspec
 . clean: convert to use parse_pathspec
 . Guard against new pathspec magic in pathspec matching code
 . parse_pathspec: support prefixing original patterns
 . parse_pathspec: support stripping/checking submodule paths
 . parse_pathspec: support stripping submodule trailing slashes
 . parse_pathspec: a special flag for max_depth feature
 . Convert some get_pathspec() calls to parse_pathspec()
 . parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
 . parse_pathspec: save original pathspec for reporting
 . Add parse_pathspec() that converts cmdline args to struct pathspec
 . pathspec: add copy_pathspec
 . pathspec: i18n-ize error strings in pathspec parsing code
 . Move struct pathspec and related functions to pathspec.[ch]
 . clean: remove unused variable "seen"
 . setup.c: check that the pathspec magic ends with ")"

 Migrate the rest of codebase to use "struct pathspec" more.

 This has nasty conflicts with kb/status-ignored-optim-2,
 as/check-ignore and tr/line-log; I've already asked Duy to hold
 this and later rebase on top of them.


* tr/line-log (2013-04-22) 13 commits
  (merged to 'next' on 2013-04-22 at 8f2c1de)
 + git-log(1): remove --full-line-diff description
  (merged to 'next' on 2013-04-21 at cd92620)
 + line-log: fix documentation formatting
  (merged to 'next' on 2013-04-15 at 504559e)
 + log -L: improve comments in process_all_files()
 + log -L: store the path instead of a diff_filespec
 + log -L: test merge of parallel modify/rename
 + t4211: pass -M to 'git log -M -L...' test
  (merged to 'next' on 2013-04-05 at 5afb00c)
 + log -L: fix overlapping input ranges
 + log -L: check range set invariants when we look it up
  (merged to 'next' on 2013-04-01 at 5be920c)
 + Speed up log -L... -M
 + log -L: :pattern:file syntax to find by funcname
 + Implement line-history search (git log -L)
 + Export rewrite_parents() for 'log -L'
 + Refactor parse_loc

 Will cook in 'next'.


* jc/push-2.0-default-to-simple (2013-04-03) 1 commit
 - push: switch default from "matching" to "simple"

 The early bits to adjust the tests have been merged to 'master'.

 Will cook in 'next' until Git 2.0.

--------------------------------------------------
[Discarded]

* jc/add-2.0-delete-default (2013-04-21) 1 commit
 - git add <pathspec>... defaults to "-A"

 Superseded by jc/add-2.0-ignore-removal
