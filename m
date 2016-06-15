From: Jeff King <peff@peff.net>
Subject: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Fri, 9 Nov 2012 14:23:36 -0500
Message-ID: <20121109192336.GA9401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 20:23:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWuBJ-0006Ke-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 20:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab2KITXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 14:23:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40344 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427Ab2KITXm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 14:23:42 -0500
Received: (qmail 10335 invoked by uid 107); 9 Nov 2012 19:24:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 14:24:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 14:23:36 -0500
Content-Disposition: inline
X-master-at: b0b00a3ee43b4813eb85728a482500f6422499fd
X-next-at: 7a4c58c4d7b270e7e6bea673b5515cd0babe9508
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209242>

What's cooking in git.git (Nov 2012, #02; Fri, 9)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The fourth batch of topics has graduated to master. This should be my
last integration cycle, as Junio will be back to take over before the
next one.

You can find the changes described here in the integration branches of
my repository at:

  git://github.com/peff/git.git

Until Junio returns, kernel.org and the other "usual" places will not be
updated.

--------------------------------------------------
[New Topics]

* cr/push-force-tag-update (2012-11-09) 5 commits
 - push: update remote tags only with force
 - push: flag updates that require force
 - push: flag updates
 - push: add advice for rejected tag reference
 - push: return reject reasons via a mask

 Require "-f" for push to update a tag, even if it is a fast-forward.

 Needs review.

 I'm undecided yet on whether the goal is the right thing to do, but it
 does prevent some potential mistakes. I haven't looked closely at the
 implementation itself; review from interested parties would be helpful.


* fc/fast-export-fixes (2012-11-08) 14 commits
 - fast-export: don't handle uninteresting refs
 - fast-export: make sure updated refs get updated
 - fast-export: fix comparison in tests
 - fast-export: trivial cleanup
 - remote-testgit: make clear the 'done' feature
 - remote-testgit: report success after an import
 - remote-testgit: exercise more features
 - remote-testgit: cleanup tests
 - remote-testgit: remove irrelevant test
 - remote-testgit: get rid of non-local functionality
 - Add new simplified git-remote-testgit
 - Rename git-remote-testgit to git-remote-testpy
 - remote-testgit: fix direction of marks
 - fast-export: avoid importing blob marks

 Improvements to fix fast-export bugs, including how refs pointing to
 already-seen commits are handled. An earlier 4-commit version of this
 series looked good to me, but this much-expanded version has not seen
 any comments.

 Needs review.


* mg/maint-pull-suggest-upstream-to (2012-11-08) 1 commit
 - push/pull: adjust missing upstream help text to changed interface

 Follow-on to the new "--set-upstream-to" topic from v1.8.0 to avoid
 suggesting the deprecated "--set-upstream".

 Will merge to 'next'.


* mh/alt-odb-string-list-cleanup (2012-11-08) 2 commits
 - link_alt_odb_entries(): take (char *, len) rather than two pointers
 - link_alt_odb_entries(): use string_list_split_in_place()

 Cleanups in the alternates code. Fixes a potential bug and makes the
 code much cleaner.

 Will merge to 'next'.


* pf/editor-ignore-sigint (2012-11-08) 1 commit
 - launch_editor: ignore SIGINT while the editor has control

 Avoid confusing cases where the user hits Ctrl-C while in the editor
 session, not realizing git will receive the signal. Since most editors
 will take over the terminal and will block SIGINT, this is not likely
 to confuse anyone.

 Comments welcome from people using unusual editors (e.g., a script that
 starts an editor in another window then blocks, waiting for the user to
 finish).


* pp/gitweb-config-underscore (2012-11-08) 1 commit
 - gitweb: make remote_heads config setting work

 The key "gitweb.remote_heads" is not legal git config; this maps it to
 "gitweb.remoteheads".

 Junio raised a good point about the implementation for three-level
 variables.

 Expecting a re-roll.


* pw/maint-p4-rcs-expansion-newline (2012-11-08) 1 commit
 - git p4: RCS expansion should not span newlines

 I do not have p4 to play with, but looks obviously correct to me.

 Will merge to 'next'.


* rh/maint-gitweb-highlight-ext (2012-11-08) 1 commit
 - gitweb.perl: fix %highlight_ext mappings

 Fixes a clever misuse of perl's list interpretation.

 Will merge to 'next'.


* rr/submodule-diff-config (2012-11-08) 3 commits
 - submodule: display summary header in bold
 - diff: introduce diff.submodule configuration variable
 - Documentation: move diff.wordRegex from config.txt to diff-config.txt

 Lets "git diff --submodule=log" become the default via configuration.

 Seems like a good direction, though I had a few comments.

 Expecting a re-roll.


--------------------------------------------------
[Graduated to "master"]

* fc/completion-send-email-with-format-patch (2012-10-16) 1 commit
  (merged to 'next' on 2012-11-04 at 0a6366e)
 + completion: add format-patch options to send-email

 Will merge to 'master' in the fourth batch.


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

 Will merge to 'master' in the fourth batch.


* km/send-email-compose-encoding (2012-10-25) 5 commits
  (merged to 'next' on 2012-10-29 at d7d2bb4)
 + git-send-email: add rfc2047 quoting for "=?"
 + git-send-email: introduce quote_subject()
 + git-send-email: skip RFC2047 quoting for ASCII subjects
 + git-send-email: use compose-encoding for Subject
  (merged to 'next' on 2012-10-25 at 5447367)
 + git-send-email: introduce compose-encoding

 "git send-email --compose" can let the user create a non-ascii
 cover letter message, but there was not a way to mark it with
 appropriate content type before sending it out.

 Further updates fix subject quoting.

 Will merge to 'master' in the fourth batch.


* mh/maint-parse-dirstat-fix (2012-10-29) 1 commit
  (merged to 'next' on 2012-11-04 at 852d609)
 + parse_dirstat_params(): use string_list to split comma-separated string

 Cleans up some code and avoids a potential bug.

 Will merge to 'master' in the fourth batch.


* mo/cvs-server-cleanup (2012-10-26) 11 commits
  (merged to 'next' on 2012-10-29 at 4e70622)
 + Use character class for sed expression instead of \s
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
 (this branch is tangled with mo/cvs-server-updates.)

 Cleanups to prepare for mo/cvs-server-updates.

 Will merge to 'master' in the fourth batch.


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

 Will merge to 'master' in the fourth batch.


* nd/builtin-to-libgit (2012-10-29) 7 commits
  (merged to 'next' on 2012-11-04 at 06cbf9b)
 + fetch-pack: move core code to libgit.a
 + fetch-pack: remove global (static) configuration variable "args"
 + send-pack: move core code to libgit.a
 + Move setup_diff_pager to libgit.a
 + Move print_commit_list to libgit.a
 + Move estimate_bisect_steps to libgit.a
 + Move try_merge_command and checkout_fast_forward to libgit.a

 Code cleanups so that libgit.a does not depend on anything in the
 builtin/ directory.

 Some of the code movement is pretty big, but there doesn't seem to be
 any conflicts with topics in flight.

 Will merge to 'master' in the fourth batch.


* nd/tree-walk-enum-cleanup (2012-10-19) 1 commit
  (merged to 'next' on 2012-11-04 at 8ccdf98)
 + tree-walk: use enum interesting instead of integer

 Will merge to 'master' in the fourth batch.


* ph/maint-submodule-status-fix (2012-10-29) 2 commits
  (merged to 'next' on 2012-11-04 at d700e02)
 + submodule status: remove unused orig_* variables
 + t7407: Fix recursive submodule test

 Cleans up some leftover bits from an earlier submodule change.

 Will merge to 'master' in the fourth batch.


* rs/lock-correct-ref-during-delete (2012-10-16) 1 commit
  (merged to 'next' on 2012-10-25 at 9341eea)
 + refs: lock symref that is to be deleted, not its target

 When "update-ref -d --no-deref SYM" tried to delete a symbolic ref
 SYM, it incorrectly locked the underlying reference pointed by SYM,
 not the symbolic ref itself.

 Will merge to 'master' in the fourth batch.


* sz/maint-curl-multi-timeout (2012-10-19) 1 commit
  (merged to 'next' on 2012-11-04 at f696dd8)
 + Fix potential hang in https handshake

 Sometimes curl_multi_timeout() function suggested a wrong timeout
 value when there is no file descriptors to wait on and the http
 transport ended up sleeping for minutes in select(2) system call.
 Detect this and reduce the wait timeout in such a case.

 Will merge to 'master' in the fourth batch.

--------------------------------------------------
[Stalled]

* rc/maint-complete-git-p4 (2012-09-24) 1 commit
  (merged to 'next' on 2012-10-29 at af52cef)
 + Teach git-completion about git p4

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

 Expecting a re-roll.

 "The first remote becomes the default" bit is better done as a
 separate step.


* mh/ceiling (2012-10-29) 8 commits
 - string_list_longest_prefix(): remove function
 - setup_git_directory_gently_1(): resolve symlinks in ceiling paths
 - longest_ancestor_length(): require prefix list entries to be normalized
 - longest_ancestor_length(): take a string_list argument for prefixes
 - longest_ancestor_length(): use string_list_split()
 - Introduce new function real_path_if_valid()
 - real_path_internal(): add comment explaining use of cwd
 - Introduce new static function real_path_internal()

 Elements of GIT_CEILING_DIRECTORIES list may not match the real
 pathname we obtain from getcwd(), leading the GIT_DIR discovery
 logic to escape the ceilings the user thought to have specified.


--------------------------------------------------
[Cooking]

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

 Needs review by folks interested in cvsserver.


* ta/doc-cleanup (2012-10-25) 6 commits
 - Documentation: build html for all files in technical and howto
 - Documentation/howto: convert plain text files to asciidoc
 - Documentation/technical: convert plain text files to asciidoc
 - Change headline of technical/send-pack-pipeline.txt to not confuse its content with content from git-send-pack.txt
 - Shorten two over-long lines in git-bisect-lk2009.txt by abbreviating some sha1
 - Split over-long synopsis in git-fetch-pack.txt into several lines

 Will merge to 'next'.


* lt/diff-stat-show-0-lines (2012-10-17) 1 commit
 - Fix "git diff --stat" for interesting - but empty - file changes

 We failed to mention a file without any content change but whose
 permission bit was modified, or (worse yet) a new file without any
 content in the "git diff --stat" output.

 Needs some test updates.


* jc/prettier-pretty-note (2012-10-26) 11 commits
  (merged to 'next' on 2012-11-04 at 40e3e48)
 + Doc User-Manual: Patch cover letter, three dashes, and --notes
 + Doc format-patch: clarify --notes use case
 + Doc notes: Include the format-patch --notes option
 + Doc SubmittingPatches: Mention --notes option after "cover letter"
 + Documentation: decribe format-patch --notes
 + format-patch --notes: show notes after three-dashes
 + format-patch: append --signature after notes
 + pretty_print_commit(): do not append notes message
 + pretty: prepare notes message at a centralized place
 + format_note(): simplify API
 + pretty: remove reencode_commit_message()

 Now that Philip has submitted some documentation updates, this is
 looking more ready.

 Will merge to 'master' in the fifth batch.


* jc/same-encoding (2012-11-04) 1 commit
  (merged to 'next' on 2012-11-04 at 54991f2)
 + reencode_string(): introduce and use same_encoding()

 Various codepaths checked if two encoding names are the same using
 ad-hoc code and some of them ended up asking iconv() to convert
 between "utf8" and "UTF-8".  The former is not a valid way to spell
 the encoding name, but often people use it by mistake, and we
 equated them in some but not all codepaths. Introduce a new helper
 function to make these codepaths consistent.

 Will merge to 'master' in the fifth batch.


* cr/cvsimport-local-zone (2012-11-04) 2 commits
  (merged to 'next' on 2012-11-04 at 292f0b4)
 + cvsimport: work around perl tzset issue
 + git-cvsimport: allow author-specific timezones

 Allows "cvsimport" to read per-author timezone from the author info
 file.

 Will merge to 'master' in the fifth batch.


* fc/zsh-completion (2012-10-29) 3 commits
 - completion: add new zsh completion
 - completion: add new __gitcompadd helper
 - completion: get rid of empty COMPREPLY assignments

 There were some comments on this, but I wasn't clear on the outcome.

 Need to take a closer look.


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


* as/check-ignore (2012-11-08) 14 commits
 - t0007: fix tests on Windows
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

 Duy helped to reroll this.

 Expecting a re-roll.


* so/prompt-command (2012-10-17) 4 commits
  (merged to 'next' on 2012-10-25 at 79565a1)
 + coloured git-prompt: paint detached HEAD marker in red
 + Fix up colored git-prompt
 + show color hints based on state of the git tree
 + Allow __git_ps1 to be used in PROMPT_COMMAND

 Updates __git_ps1 so that it can be used as $PROMPT_COMMAND,
 instead of being used for command substitution in $PS1, to embed
 color escape sequences in its output.

 Will cook in 'next'.


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

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hierarchies.

 I suspect that this needs to be plugged to pathspec matching code;
 otherwise "git log -- 'Docum*/**/*.txt'" would not show the log for
 commits that touch Documentation/git.txt, which would be confusing
 to the users.

 Will cook in 'next'.


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
  (merged to 'next' on 2012-11-04 at eda85ef)
 + get_fetch_map(): tighten checks on dest refs

 This was split out from discarded jc/maint-push-refs-all topic.

 Will merge to 'master' in the fifth batch.


* jh/symbolic-ref-d (2012-10-21) 1 commit
  (merged to 'next' on 2012-11-04 at b0762f5)
 + git symbolic-ref --delete $symref

 Add "symbolic-ref -d SYM" to delete a symbolic ref SYM.

 It is already possible to remove a symbolic ref with "update-ref -d
 --no-deref", but it may be a good addition for completeness.

 Will merge to 'master' in the fifth batch.


* jh/update-ref-d-through-symref (2012-10-21) 2 commits
 - Fix failure to delete a packed ref through a symref
 - t1400-update-ref: Add test verifying bug with symrefs in delete_ref()

 "update-ref -d --deref SYM" to delete a ref through a symbolic ref
 that points to it did not remove it correctly.


* jk/config-ignore-duplicates (2012-10-29) 9 commits
  (merged to 'next' on 2012-10-29 at 67fa0a2)
 + builtin/config.c: Fix a sparse warning
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

 Will cook in 'next'.


* ph/submodule-sync-recursive (2012-10-29) 2 commits
  (merged to 'next' on 2012-11-04 at a000f78)
 + Add tests for submodule sync --recursive
 + Teach --recursive to submodule sync

 Adds "--recursive" option to submodule sync.

 Will merge to 'master' in the fifth batch.


* fc/completion-test-simplification (2012-10-29) 2 commits
 - completion: simplify __gitcomp test helper
 - completion: refactor __gitcomp related tests

 Clean up completion tests.

 There were some comments on the list.

 Expecting a re-roll.


* fc/remote-testgit-feature-done (2012-10-29) 1 commit
 - remote-testgit: properly check for errors

 Needs review.


* jk/maint-diff-grep-textconv (2012-10-28) 1 commit
  (merged to 'next' on 2012-11-04 at 790337b)
 + diff_grep: use textconv buffers for add/deleted files
 (this branch is used by jk/pickaxe-textconv.)

 Fixes inconsistent use of textconv with "git log -G".

 Will merge to 'master' in the fifth batch.


* jk/pickaxe-textconv (2012-10-28) 2 commits
 - pickaxe: use textconv for -S counting
 - pickaxe: hoist empty needle check
 (this branch uses jk/maint-diff-grep-textconv.)

 Use textconv filters when searching with "log -S".

 Waiting for a sanity check and review from Junio.


* as/maint-doc-fix-no-post-rewrite (2012-11-02) 1 commit
  (merged to 'next' on 2012-11-09 at 117a91e)
 + commit: fixup misplacement of --no-post-rewrite description

 Will merge to 'master' in the fifth batch.


* fc/remote-bzr (2012-11-08) 5 commits
 - remote-bzr: update working tree
 - remote-bzr: add support for remote repositories
 - remote-bzr: add support for pushing
 - remote-bzr: add simple tests
 - Add new remote-bzr transport helper

 New remote helper for bzr.

 Will merge to 'next'.


* fc/remote-hg (2012-11-04) 16 commits
 - remote-hg: the author email can be null
 - remote-hg: add option to not track branches
 - remote-hg: add extra author test
 - remote-hg: add tests to compare with hg-git
 - remote-hg: add bidirectional tests
 - test-lib: avoid full path to store test results
 - remote-hg: add basic tests
 - remote-hg: fake bookmark when there's none
 - remote-hg: add compat for hg-git author fixes
 - remote-hg: add support for hg-git compat mode
 - remote-hg: match hg merge behavior
 - remote-hg: make sure the encoding is correct
 - remote-hg: add support to push URLs
 - remote-hg: add support for remote pushing
 - remote-hg: add support for pushing
 - Add new remote-hg transport helper

 New remote helper for hg.

 Will merge to 'next'.


* jk/maint-http-half-auth-fetch (2012-10-31) 2 commits
  (merged to 'next' on 2012-11-09 at af69926)
 + remote-curl: retry failed requests for auth even with gzip
 + remote-curl: hoist gzip buffer size to top of post_rpc

 Fixes fetch from servers that ask for auth only during the actual
 packing phase. This is not really a recommended configuration, but it
 cleans up the code at the same time.

 Will merge to 'master' in the sixth batch.


* js/hp-nonstop (2012-10-30) 1 commit
  (merged to 'next' on 2012-11-09 at fe58205)
 + fix 'make test' for HP NonStop

 Will merge to 'master' in the fifth batch.


* kb/preload-index-more (2012-11-02) 1 commit
  (merged to 'next' on 2012-11-09 at a750ebd)
 + update-index/diff-index: use core.preloadindex to improve performance

 Use preloadindex in more places, which has a nice speedup on systems
 with slow stat calls (and even on Linux).

 Will merge to 'master' in the sixth batch.


* mh/notes-string-list (2012-11-08) 5 commits
  (merged to 'next' on 2012-11-09 at 7a4c58c)
 + string_list_add_refs_from_colon_sep(): use string_list_split()
 + notes: fix handling of colon-separated values
 + combine_notes_cat_sort_uniq(): sort and dedup lines all at once
 + Initialize sort_uniq_list using named constant
 + string_list: add a function string_list_remove_empty_items()

 Improve the asymptotic performance of the cat_sort_uniq notes merge
 strategy.

 Will merge to 'master' in the fifth batch.


* mh/strbuf-split (2012-11-04) 4 commits
  (merged to 'next' on 2012-11-09 at fa984b1)
 + strbuf_split*(): document functions
 + strbuf_split*(): rename "delim" parameter to "terminator"
 + strbuf_split_buf(): simplify iteration
 + strbuf_split_buf(): use ALLOC_GROW()

 Cleanups and documentation for strbuf_split.

 Will merge to 'master' in the fifth batch.


* mm/maint-doc-commit-edit (2012-11-02) 1 commit
  (merged to 'next' on 2012-11-09 at 8dab7f5)
 + Document 'git commit --no-edit' explicitly

 Will merge to 'master' in the fifth batch.
