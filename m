From: Jeff King <peff@peff.net>
Subject: What's cooking in git.git (Oct 2012, #08; Thu, 25)
Date: Thu, 25 Oct 2012 07:54:06 -0400
Message-ID: <20121025115406.GA17053@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 13:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRM13-0007it-JH
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 13:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab2JYLyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 07:54:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56189 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab2JYLyK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 07:54:10 -0400
Received: (qmail 8976 invoked by uid 107); 25 Oct 2012 11:54:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 07:54:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 07:54:06 -0400
Content-Disposition: inline
X-master-at: 2cfceefaca16d64baecf0ba9bcd4e05229d9c31b
X-next-at: 73d9d14c037055c674779c1538fc7bfddf428db0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208395>

What's cooking in git.git (Oct 2012, #08; Thu, 25)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Now that 1.8.0 is out, I've graduated the first batch of topics to
master. I've also picked up some topics from the list, mostly
documentation fixes that went straight to next. I haven't yet moved any
of the cooking topics up to next.

You can find the changes described here in the integration branches of
my repository at:

  git://github.com/peff/git.git

Until Junio returns, kernel.org and the other "usual" places will not be
updated.

--------------------------------------------------
[New Topics]

* gb/maint-doc-svn-log-window-size (2012-10-25) 1 commit
 - Document git-svn fetch --log-window-size parameter

Looks good to me, but I'd like to get an ack from svn folks.


* jk/config-ignore-duplicates (2012-10-24) 8 commits
  (merged to 'next' on 2012-10-25 at 233df08)
 + git-config: use git_config_with_options
 + git-config: do not complain about duplicate entries
 + git-config: collect values instead of immediately printing
 + git-config: fix regexp memory leaks on error conditions
 + git-config: remove memory leak of key regexp
 + t1300: test "git config --get-all" more thoroughly
 + t1300: remove redundant test
 + t1300: style updates

Drop duplicate detection from git-config; this lets it
better match the internal config callbacks, which clears up
some corner cases with includes.


* mm/maint-doc-remote-tracking (2012-10-25) 1 commit
  (merged to 'next' on 2012-10-25 at 80f1592)
 + Documentation: remote tracking branch -> remote-tracking branch

We long ago hyphenated "remote-tracking branch"; this
catches some new instances added since then.


* ph/pull-rebase-detached (2012-10-25) 1 commit
  (merged to 'next' on 2012-10-25 at 73d9d14)
 + git-pull: Avoid merge-base on detached head

Avoids spewing error messages when using "pull --rebase" on a
detached HEAD.


* ph/submodule-sync-recursive (2012-10-24) 2 commits
 - Add tests for submodule sync --recursive
 - Teach --recursive to submodule sync

I'd like review from submodule folks on this one.


* po/maint-refs-replace-docs (2012-10-25) 1 commit
  (merged to 'next' on 2012-10-25 at 3874c9d)
 + Doc repository-layout: Show refs/replace

The refs/replace hierarchy was not mentioned in the
repository-layout docs.


* sl/maint-configure-messages (2012-10-25) 1 commit
  (merged to 'next' on 2012-10-25 at e1d7ecd)
 + configure: fix some output message

Minor message fixes for the configure script.

--------------------------------------------------
[Graduated to "master"]

* bw/config-lift-variable-name-length-limit (2012-10-01) 1 commit
  (merged to 'next' on 2012-10-08 at 69f54f4)
 + Remove the hard coded length limit on variable names in config files

 The configuration parser had an unnecessary hardcoded limit on
 variable names that was not checked consistently. Lift the limit.


* da/mergetools-p4 (2012-10-11) 1 commit
  (merged to 'next' on 2012-10-12 at 16f5c06)
 + mergetools/p4merge: Handle "/dev/null"


* fa/remote-svn (2012-10-07) 16 commits
  (merged to 'next' on 2012-10-07 at 7b90cf4)
 + Add a test script for remote-svn
 + remote-svn: add marks-file regeneration
 + Add a svnrdump-simulator replaying a dump file for testing
 + remote-svn: add incremental import
 + remote-svn: Activate import/export-marks for fast-import
 + Create a note for every imported commit containing svn metadata
 + vcs-svn: add fast_export_note to create notes
 + Allow reading svn dumps from files via file:// urls
 + remote-svn, vcs-svn: Enable fetching to private refs
 + When debug==1, start fast-import with "--stats" instead of "--quiet"
 + Add documentation for the 'bidi-import' capability of remote-helpers
 + Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
 + Add argv_array_detach and argv_array_free_detached
 + Add svndump_init_fd to allow reading dumps from arbitrary FDs
 + Add git-remote-testsvn to Makefile
 + Implement a remote helper for svn in C

 A GSoC project.


* jc/test-say-color-avoid-echo-escape (2012-10-11) 1 commit
  (merged to 'next' on 2012-10-11 at 639036d)
 + test-lib: Fix say_color () not to interpret \a\b\c in the message

 Recent nd/wildmatch series was the first to reveal this ancient bug
 in the test scaffolding.


* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
  (merged to 'next' on 2012-10-12 at 69fed45)
 + pager: drop "wait for output to run less" hack

 (Originally merged to 'next' on 2012-07-23)
 Removes a workaround for buggy version of less older than version
 406.


* jk/peel-ref (2012-10-04) 4 commits
  (merged to 'next' on 2012-10-08 at 4adfa2f)
 + upload-pack: use peel_ref for ref advertisements
 + peel_ref: check object type before loading
 + peel_ref: do not return a null sha1
 + peel_ref: use faster deref_tag_noverify

 Speeds up "git upload-pack" (what is invoked by "git fetch" on the
 other side of the connection) by reducing the cost to advertise the
 branches and tags that are available in the repository.


* jk/strbuf-detach-always-non-null (2012-10-18) 1 commit
  (merged to 'next' on 2012-10-18 at 54561c7)
 + strbuf: always return a non-NULL value from strbuf_detach


* jm/diff-context-config (2012-10-02) 2 commits
  (merged to 'next' on 2012-10-02 at e57700a)
 + t4055: avoid use of sed 'a' command
  (merged to 'next' on 2012-10-01 at 509a558)
 + diff: diff.context configuration gives default to -U

 Teaches a new configuration variable to "git diff" Porcelain and
 its friends.


* js/mingw-fflush-errno (2012-10-17) 1 commit
  (merged to 'next' on 2012-10-18 at 43d6ebb)
 + maybe_flush_or_die: move a too-loose Windows specific error


* nd/attr-match-optim (2012-10-05) 2 commits
  (merged to 'next' on 2012-10-08 at bfbdd8a)
 + attr: avoid searching for basename on every match
 + attr: avoid strlen() on every match
 (this branch is used by as/check-ignore, nd/attr-match-optim-more and nd/wildmatch.)

 Trivial and obvious optimization for finding attributes that match
 a given path.

--------------------------------------------------
[Stalled]

* rc/maint-complete-git-p4 (2012-09-24) 1 commit
 - Teach git-completion about git p4

 Comment from Pete will need to be addressed in a follow-up patch.


* as/test-tweaks (2012-09-20) 7 commits
 - tests: paint unexpectedly fixed known breakages in bold red
 - tests: test the test framework more thoroughly
 - [SQUASH] t/t0000-basic.sh: quoting of TEST_DIRECTORY is screwed up
 - tests: refactor mechanics of testing in a sub test-lib
 - tests: paint skipped tests in bold blue
 - tests: test number comes first in 'not ok $count - $message'
 - tests: paint known breakages in bold yellow

 Various minor tweaks to the test framework to paint its output
 lines in colors that match what they mean better.

 Has the "is this really blue?" issue Peff raised resolved???


* jc/maint-name-rev (2012-09-17) 7 commits
 - describe --contains: use "name-rev --algorithm=weight"
 - name-rev --algorithm=weight: tests and documentation
 - name-rev --algorithm=weight: cache the computed weight in notes
 - name-rev --algorithm=weight: trivial optimization
 - name-rev: --algorithm option
 - name_rev: clarify the logic to assign a new tip-name to a commit
 - name-rev: lose unnecessary typedef

 "git name-rev" names the given revision based on a ref that can be
 reached in the smallest number of steps from the rev, but that is
 not useful when the caller wants to know which tag is the oldest one
 that contains the rev.  This teaches a new mode to the command that
 uses the oldest ref among those which contain the rev.

 I am not sure if this is worth it; for one thing, even with the help
 from notes-cache, it seems to make the "describe --contains" even
 slower. Also the command will be unusably slow for a user who does
 not have a write access (hence unable to create or update the
 notes-cache).

 Stalled mostly due to lack of responses.


* jc/xprm-generation (2012-09-14) 1 commit
 - test-generation: compute generation numbers and clock skews

 A toy to analyze how bad the clock skews are in histories of real
 world projects.

 Stalled mostly due to lack of responses.


* jc/blame-no-follow (2012-09-21) 2 commits
 - blame: pay attention to --no-follow
 - diff: accept --no-follow option

 Teaches "--no-follow" option to "git blame" to disable its
 whole-file rename detection.

 Stalled mostly due to lack of responses.


* jc/doc-default-format (2012-10-07) 2 commits
 - [SQAUSH] allow "cd Doc* && make DEFAULT_DOC_TARGET=..."
 - Allow generating a non-default set of documentation

 Need to address the installation half if this is to be any useful.


* mk/maint-graph-infinity-loop (2012-09-25) 1 commit
 - graph.c: infinite loop in git whatchanged --graph -m

 The --graph code fell into infinite loop when asked to do what the
 code did not expect ;-)

 Anybody who worked on "--graph" wants to comment?
 Stalled mostly due to lack of responses.


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Waiting for comments.


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a reroll.

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* mh/ceiling (2012-10-21) 8 commits
 - string_list_longest_prefix(): remove function
 - normalize_ceiling_entry(): resolve symlinks
 - longest_ancestor_length(): require prefix list entries to be normalized
 - longest_ancestor_length(): take a string_list argument for prefixes
 - longest_ancestor_length(): use string_list_split()
 - Introduce new function real_path_if_valid()
 - real_path_internal(): add comment explaining use of cwd
 - Introduce new static function real_path_internal()

 Elements of GIT_CEILING_DIRECTORIES list may not match the real
 pathname we obtain from getcwd(), leading the GIT_DIR discovery
 logic to escape the ceilings the user thought to have specified.


* mo/cvs-server-cleanup (2012-10-16) 10 commits
  (merged to 'next' on 2012-10-25 at c70881d)
 + cvsserver status: provide real sticky info
 + cvsserver: cvs add: do not expand directory arguments
 + cvsserver: use whole CVS rev number in-process; don't strip "1." prefix
 + cvsserver: split up long lines in req_{status,diff,log}
 + cvsserver: clean up client request handler map comments
 + cvsserver: remove unused functions _headrev and gethistory
 + cvsserver update: comment about how we shouldn't remove a user-modified file
 + cvsserver: add comments about database schema/usage
 + cvsserver: removed unused sha1Or-k mode from kopts_from_path
 + cvsserver t9400: add basic 'cvs log' test
 (this branch is used by mo/cvs-server-updates.)


* mo/cvs-server-updates (2012-10-16) 10 commits
 - cvsserver Documentation: new cvs ... -r support
 - cvsserver: add t9402 to test branch and tag refs
 - cvsserver: support -r and sticky tags for most operations
 - cvsserver: Add version awareness to argsfromdir
 - cvsserver: generalize getmeta() to recognize commit refs
 - cvsserver: implement req_Sticky and related utilities
 - cvsserver: add misc commit lookup, file meta data, and file listing functions
 - cvsserver: define a tag name character escape mechanism
 - cvsserver: cleanup extra slashes in filename arguments
 - cvsserver: factor out git-log parsing logic
 (this branch uses mo/cvs-server-cleanup.)


* ta/doc-cleanup (2012-10-25) 6 commits
 - Documentation: build html for all files in technical and howto
 - Documentation/howto: convert plain text files to asciidoc
 - Documentation/technical: convert plain text files to asciidoc
 - Change headline of technical/send-pack-pipeline.txt to not confuse its content with content from git-send-pack.txt
 - Shorten two over-long lines in git-bisect-lk2009.txt by abbreviating some sha1
 - Split over-long synopsis in git-fetch-pack.txt into several lines

 Misapplication of a patch fixed; the ones near the tip needs to
 update the links to point at the html files, though.


* lt/diff-stat-show-0-lines (2012-10-17) 1 commit
 - Fix "git diff --stat" for interesting - but empty - file changes

 We failed to mention a file without any content change but whose
 permission bit was modified, or (worse yet) a new file without any
 content in the "git diff --stat" output.


* jc/prettier-pretty-note (2012-10-25) 11 commits
 - Doc User-Manual: Patch cover letter, three dashes, and --notes
 - Doc format-patch: clarify --notes use case
 - Doc notes: Include the format-patch --notes option
 - Doc SubmittingPatches: Mention --notes option after "cover letter"
 - Documentation: decribe format-patch --notes
 - format-patch --notes: show notes after three-dashes
 - format-patch: append --signature after notes
 - pretty_print_commit(): do not append notes message
 - pretty: prepare notes message at a centralized place
 - format_note(): simplify API
 - pretty: remove reencode_commit_message()

 Needs updates to the placeholder documentation.


* jk/sh-setup-in-filter-branch (2012-10-18) 2 commits
  (merged to 'next' on 2012-10-25 at 3879f0e)
 + filter-branch: use git-sh-setup's ident parsing functions
 + git-sh-setup: refactor ident-parsing functions

 Will merge to 'master' in the second batch after 1.8.0 ships.


* nd/status-long (2012-10-18) 1 commit
  (merged to 'next' on 2012-10-25 at ff1b3a0)
 + status: add --long output format option

 Allow an earlier "--short" option on the command line to be
 countermanded with the "--long" option for "git status" and "git
 commit".

 Will merge to 'master' in the second batch after 1.8.0 ships.


* rs/branch-del-symref (2012-10-18) 5 commits
  (merged to 'next' on 2012-10-25 at c2cd358)
 + branch: show targets of deleted symrefs, not sha1s
 + branch: skip commit checks when deleting symref branches
 + branch: delete symref branch, not its target
 + branch: factor out delete_branch_config()
 + branch: factor out check_branch_commit()
 (this branch is used by jh/update-ref-d-through-symref.)

 A symbolic ref refs/heads/SYM was not correctly removed with
 "git branch -d SYM"; the command removed the ref pointed by
 SYM instead.

 Will merge to 'master' in the second batch after 1.8.0 ships.


* sz/maint-curl-multi-timeout (2012-10-19) 1 commit
 - Fix potential hang in https handshake

 Sometimes curl_multi_timeout() function suggested a wrong timeout
 value when there is no file descriptors to wait on and the http
 transport ended up sleeping for minutes in select(2) system call.
 Detect this and reduce the wait timeout in such a case.


* jc/same-encoding (2012-10-18) 1 commit
 - reencode_string(): introduce and use same_encoding()

 Various codepaths checked if two encoding names are the same using
 ad-hoc code and some of them ended up asking iconv() to convert
 between "utf8" and "UTF-8".  The former is not a valid way to spell
 the encoding name, but often people use it by mistake, and we
 equated them in some but not all codepaths. Introduce a new helper
 function to make these codepaths consistent.


* nd/tree-walk-enum-cleanup (2012-10-19) 1 commit
 - tree-walk: use enum interesting instead of integer


* jk/maint-http-init-not-in-result-handler (2012-10-12) 2 commits
  (merged to 'next' on 2012-10-25 at 59d3687)
 + http: do not set up curl auth after a 401
 + remote-curl: do not call run_slot repeatedly

 Further clean-up to the http codepath that picks up results after
 cURL library is done with one request slot.

 Will merge to 'master' in the second batch after 1.8.0 ships.


* nd/grep-true-path (2012-10-12) 1 commit
  (merged to 'next' on 2012-10-25 at 1c7d320)
 + grep: stop looking at random places for .gitattributes

 "git grep -e pattern <tree>" asked the attribute system to read
 "<tree>:.gitattributes" file in the working tree, which was
 nonsense.

 Will merge to 'master' in the second batch after 1.8.0 ships.


* cr/cvsimport-local-zone (2012-10-16) 1 commit
 - git-cvsimport: allow author-specific timezones

 Allows "cvsimport" to read per-author timezone from the author info
 file.


* fc/completion-send-email-with-format-patch (2012-10-16) 1 commit
 - completion: add format-patch options to send-email


* fc/zsh-completion (2012-10-15) 3 commits
 - completion: add new zsh completion
 - tests: use __gitcompadd to simplify completion tests
 - completion: add new __gitcompadd helper


* jc/apply-trailing-blank-removal (2012-10-12) 1 commit
 - apply.c:update_pre_post_images(): the preimage can be truncated

 Fix to update_pre_post_images() that did not take into account the
 possibility that whitespace fix could shrink the preimage and
 change the number of lines in it.

 Extra set of eyeballs appreciated.


* jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
 - config: exit on error accessing any config file
 - doc: advertise GIT_CONFIG_NOSYSTEM
 - config: treat user and xdg config permission problems as errors
 - config, gitignore: failure to access with ENOTDIR is ok

 An RFC to deal with a situation where .config/git is a file and we
 notice .config/git/config is not readable due to ENOTDIR, not
 ENOENT; I think a bit more refactored approach to consistently
 address permission errors across config, exclude and attrs is
 desirable.  Don't we also need a check for an opposite situation
 where we open .config/git/config or .gitattributes for reading but
 they turn out to be directories?


* rs/lock-correct-ref-during-delete (2012-10-16) 1 commit
  (merged to 'next' on 2012-10-25 at 9341eea)
 + refs: lock symref that is to be deleted, not its target

 When "update-ref -d --no-deref SYM" tried to delete a symbolic ref
 SYM, it incorrectly locked the underlying reference pointed by SYM,
 not the symbolic ref itself.


* as/check-ignore (2012-10-19) 13 commits
 - Documentation/check-ignore: we show the deciding match, not the first
 - Add git-check-ignore sub-command
 - dir.c: provide free_directory() for reclaiming dir_struct memory
 - pathspec.c: move reusable code from builtin/add.c
 - dir.c: refactor treat_gitlinks()
 - dir.c: keep track of where patterns came from
 - dir.c: refactor is_path_excluded()
 - dir.c: refactor is_excluded()
 - dir.c: refactor is_excluded_from_list()
 - dir.c: rename excluded() to is_excluded()
 - dir.c: rename excluded_from_list() to is_excluded_from_list()
 - dir.c: rename path_excluded() to is_path_excluded()
 - dir.c: rename cryptic 'which' variable to more consistent name
 (this branch uses nd/attr-match-optim-more; is tangled with nd/wildmatch.)

 Duy helped to reroll this.


* js/format-2047 (2012-10-18) 7 commits
  (merged to 'next' on 2012-10-25 at 76d91fe)
 + format-patch tests: check quoting/encoding in To: and Cc: headers
 + format-patch: fix rfc2047 address encoding with respect to rfc822 specials
 + format-patch: make rfc2047 encoding more strict
 + format-patch: introduce helper function last_line_length()
 + format-patch: do not wrap rfc2047 encoded headers too late
 + format-patch: do not wrap non-rfc2047 headers too early
 + utf8: fix off-by-one wrapping of text

 Fixes many rfc2047 quoting issues in the output from format-patch.


* km/send-email-compose-encoding (2012-10-25) 5 commits
 - git-send-email: add rfc2047 quoting for "=?"
 - git-send-email: introduce quote_subject()
 - git-send-email: skip RFC2047 quoting for ASCII subjects
 - git-send-email: use compose-encoding for Subject
  (merged to 'next' on 2012-10-25 at 5447367)
 + git-send-email: introduce compose-encoding

 "git send-email --compose" can let the user create a non-ascii
 cover letter message, but there was not a way to mark it with
 appropriate content type before sending it out.

 Will merge to 'master' in the second batch after 1.8.0 ships.


* so/prompt-command (2012-10-17) 4 commits
  (merged to 'next' on 2012-10-25 at 79565a1)
 + coloured git-prompt: paint detached HEAD marker in red
 + Fix up colored git-prompt
 + show color hints based on state of the git tree
 + Allow __git_ps1 to be used in PROMPT_COMMAND

 Updates __git_ps1 so that it can be used as $PROMPT_COMMAND,
 instead of being used for command substitution in $PS1, to embed
 color escape sequences in its output.


* aw/rebase-am-failure-detection (2012-10-11) 1 commit
 - rebase: Handle cases where format-patch fails

 I am unhappy a bit about the possible performance implications of
 having to store the output in a temporary file only for a rare case
 of format-patch aborting.


* nd/wildmatch (2012-10-15) 13 commits
  (merged to 'next' on 2012-10-25 at 510e8df)
 + Support "**" wildcard in .gitignore and .gitattributes
 + wildmatch: make /**/ match zero or more directories
 + wildmatch: adjust "**" behavior
 + wildmatch: fix case-insensitive matching
 + wildmatch: remove static variable force_lower_case
 + wildmatch: make wildmatch's return value compatible with fnmatch
 + t3070: disable unreliable fnmatch tests
 + Integrate wildmatch to git
 + wildmatch: follow Git's coding convention
 + wildmatch: remove unnecessary functions
 + Import wildmatch from rsync
 + ctype: support iscntrl, ispunct, isxdigit and isprint
 + ctype: make sane_ctype[] const array
 (this branch uses nd/attr-match-optim-more; is tangled with as/check-ignore.)

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hierarchies.

 I suspect that this needs to be plugged to pathspec matching code;
 otherwise "git log -- 'Docum*/**/*.txt'" would not show the log for
 commits that touch Documentation/git.txt, which would be confusing
 to the users.


* jk/lua-hackery (2012-10-07) 6 commits
 - pretty: fix up one-off format_commit_message calls
 - Minimum compilation fixup
 - Makefile: make "lua" a bit more configurable
 - add a "lua" pretty format
 - add basic lua infrastructure
 - pretty: make some commit-parsing helpers more public

 Interesting exercise. When we do this for real, we probably would want
 to wrap a commit to make it more like an "object" with methods like
 "parents", etc.


* nd/attr-match-optim-more (2012-10-15) 7 commits
  (merged to 'next' on 2012-10-25 at 09f70ce)
 + attr: more matching optimizations from .gitignore
 + gitignore: make pattern parsing code a separate function
 + exclude: split pathname matching code into a separate function
 + exclude: fix a bug in prefix compare optimization
 + exclude: split basename matching code into a separate function
 + exclude: stricten a length check in EXC_FLAG_ENDSWITH case
 + Merge commit 'f9f6e2c' into nd/attr-match-optim-more
 (this branch is used by as/check-ignore and nd/wildmatch.)

 Start laying the foundation to build the "wildmatch" after we can
 agree on its desired semantics.


* jc/grep-pcre-loose-ends (2012-10-09) 7 commits
  (merged to 'next' on 2012-10-25 at 2ea9b27)
 + log: honor grep.* configuration
 + log --grep: accept --basic-regexp and --perl-regexp
 + log --grep: use the same helper to set -E/-F options as "git grep"
 + revisions: initialize revs->grep_filter using grep_init()
 + grep: move pattern-type bits support to top-level grep.[ch]
 + grep: move the configuration parsing logic to grep.[ch]
 + builtin/grep.c: make configuration callback more reusable

 "git log -F -E --grep='<ere>'" failed to use the given <ere>
 pattern as extended regular expression, and instead looked for the
 string literally.  The early part of this series is a fix for it.

 Will merge to 'master' in the second batch after 1.8.0 ships.


* jl/submodule-add-by-name (2012-09-30) 2 commits
  (merged to 'next' on 2012-10-25 at a322082)
 + submodule add: Fail when .git/modules/<name> already exists unless forced
 + Teach "git submodule add" the --name option

 If you remove a submodule, in order to keep the repository so that
 "git checkout" to an older commit in the superproject history can
 resurrect the submodule, the real repository will stay in $GIT_DIR
 of the superproject.  A later "git submodule add $path" to add a
 different submodule at the same path will fail.  Diagnose this case
 a bit better, and if the user really wants to add an unrelated
 submodule at the same path, give the "--name" option to give it a
 place in $GIT_DIR of the superproject that does not conflict with
 the original submodule.

 Will merge to 'master' in the second batch after 1.8.0 ships.


* jl/submodule-rm (2012-09-29) 1 commit
  (merged to 'next' on 2012-10-25 at 0fb5876)
 + submodule: teach rm to remove submodules unless they contain a git directory

 "git rm submodule" cannot blindly remove a submodule directory as
 its working tree may have local changes, and worse yet, it may even
 have its repository embedded in it.  Teach it some special cases
 where it is safe to remove a submodule, specifically, when there is
 no local changes in the submodule working tree, and its repository
 is not embedded in its working tree but is elsewhere and uses the
 gitfile mechanism to point at it.

 Will merge to 'master' in the second batch after 1.8.0 ships.


* nd/pretty-placeholder-with-color-option (2012-09-30) 9 commits
 . pretty: support %>> that steal trailing spaces
 . pretty: support truncating in %>, %< and %><
 . pretty: support padding placeholders, %< %> and %><
 . pretty: two phase conversion for non utf-8 commits
 . utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
 . utf8.c: move display_mode_esc_sequence_len() for use by other functions
 . pretty: support %C(auto[,N]) to turn on coloring on next placeholder(s)
 . pretty: split parsing %C into a separate function
 . pretty: share code between format_decoration and show_decorations

 This causes warnings with -Wuninitialized, so I've ejected it from pu
 for the time being.


* jc/maint-fetch-tighten-refname-check (2012-10-19) 1 commit
 - get_fetch_map(): tighten checks on dest refs

 This was split out from discarded jc/maint-push-refs-all topic.


* jh/symbolic-ref-d (2012-10-21) 1 commit
 - git symbolic-ref --delete $symref

 Add "symbolic-ref -d SYM" to delete a symbolic ref SYM.

 It is already possible to remove a symbolic ref with "update-ref -d
 --no-deref", but it may be a good addition for completeness.


* jh/update-ref-d-through-symref (2012-10-21) 2 commits
 - Fix failure to delete a packed ref through a symref
 - t1400-update-ref: Add test verifying bug with symrefs in delete_ref()
 (this branch uses rs/branch-del-symref.)

 "update-ref -d --deref SYM" to delete a ref through a symbolic ref
 that points to it did not remove it correctly.


--------------------------------------------------
[Discarded]

* fa/vcs-svn (2012-10-07) 4 commits
 - vcs-svn: remove repo_tree
 - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
 - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
 - svndump: move struct definitions to .h
 (this branch uses fa/remote-svn.)

 A follow-up to a GSoC project, but seems not quite ready.


* ph/credential-refactor (2012-09-02) 5 commits
 - wincred: port to generic credential helper
 - Merge branch 'ef/win32-cred-helper' into ph/credential-refactor
 - osxkeychain: port to generic credential helper implementation
 - gnome-keyring: port to generic helper implementation
 - contrib: add generic credential helper

 Attempts to refactor to share code among OSX keychain, Gnome keyring
 and Win32 credential helpers.  Turns out that the sharing wasn't
 big enough to worth the churn.


* ms/contrib-thunderbird-updates (2012-08-31) 2 commits
 - [SQUASH] minimum fixup
 - Thunderbird: fix appp.sh format problems

 Update helper to send out format-patch output using Thunderbird.
 Seems to have design regression for silent users.


* jx/test-real-path (2012-08-27) 1 commit
 - test: set the realpath of CWD as TRASH_DIRECTORY

 Running tests with the "trash" directory elsewhere with the "--root"
 option did not work well if the directory was specified by a symbolic
 link pointing at it.

 Seems broken as it makes $(pwd) and TRASH_DIRECTORY inconsistent.


* jc/maint-push-refs-all (2012-08-27) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - [BROKEN] fetch/push: allow refs/*:refs/*

 This is broken (see the log message there).  "git fetch/push
 $there 'refs/*:refs/*'" already propagates heads, tags, notes,
 etc. hierarchies; an attempt to propagate refs/stash will fail
 against an older version of the other side and is not worth
 supporting.


* tx/relative-in-the-future (2012-08-16) 2 commits
 - date: show relative dates in the future
 - date: refactor the relative date logic from presentation

 Not my itch; rewritten an earlier submission by Tom Xue into
 somewhat more maintainable form, though it breaks existing i18n.

 Was waiting for a voluteer to fix it up, which never happend.


* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

 I finished the streaming checkout codepath, but as explained in
 127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
 these are still early steps of a long and painful journey. At least
 pack-objects and fsck need to learn the new encoding for the series
 to be usable locally, and then index-pack/unpack-objects needs to
 learn it to be used remotely.

 Given that I heard a lot of noise that people want large files, and
 that I was asked by somebody at GitTogether'11 privately for an
 advice on how to pay developers (not me) to help adding necessary
 support, I am somewhat disappointed that the original patch series
 that was sent long time ago still remains here without much comments
 and updates from the developer community. I even made the interface
 to the logic that decides where to split chunks easily replaceable,
 and I deliberately made the logic in the original patch extremely
 stupid to entice others, especially the "bup" fanbois, to come up
 with a better logic, thinking that giving people an easy target to
 shoot for, they may be encouraged to help out. The plan is not
 working :-<.
