From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.3.rc0
Date: Sun, 12 Apr 2009 19:50:20 -0700
Message-ID: <7v7i1pxo5v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 04:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtCHE-0002BD-Rg
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 04:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbZDMCua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Apr 2009 22:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754010AbZDMCu3
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 22:50:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbZDMCu1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Apr 2009 22:50:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 05490A9403;
	Sun, 12 Apr 2009 22:50:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5E992A9402; Sun,
 12 Apr 2009 22:50:23 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7381616-27D5-11DE-ACCA-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116404>

A release candidate GIT 1.6.3.rc0 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.3.rc0.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.3.rc0.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.3.rc0.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.3.rc0-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------

GIT v1.6.3 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

With the next major release, "git push" into a branch that is
currently checked out will be refused by default.  You can choose
what should happen upon such a push by setting the configuration
variable receive.denyCurrentBranch in the receiving repository.

To ease the transition plan, the receiving repository of such a
push running this release will issue a big warning when the
configuration variable is missing.  Please refer to:

  http://git.or.cz/gitwiki/GitFaq#non-bare
  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=3D=
108007

for more details on the reason why this change is needed and the
transition plan.

=46or a similar reason, "git push $there :$killed" to delete the branch
$killed in a remote repository $there, if $killed branch is the current
branch pointed at by its HEAD, gets a large warning.  You can choose wh=
at
should happen upon such a push by setting the configuration variable
receive.denyDeleteCurrent in the receiving repository.

When the user does not tell "git push" what to push, it has always
pushed matching refs.  For some people it is unexpected, and a new
configuration variable push.default has been introduced to allow
changing a different default behaviour.  To advertise the new feature,
a big warning is issued if this is not configured and a git push withou=
t
arguments is attempted.


Updates since v1.6.2
--------------------

(subsystems)

* various git-svn updates.

(performance)

* many uses of lstat(2) in the codepath for "git checkout" have been
  optimized out.

* pruning reflog entries that are unreachable from the tip of the ref
  during "git reflog prune" (hence "git gc") was very inefficient.

(usability, bells and whistles)

* rsync:/path/to/repo can be used to run git over rsync for local
  repositories.  It may not be useful in practice; meant primarily for
  testing.

* http transport learned to prompt and use password when fetching from =
or
  pushing to http://user@host.xz/ URL.

* (msysgit) progress output that is sent over the sideband protocol can
  be handled appropriately in Windows console.

* "--pretty=3D<style>" option to the log family of commands can now be
  spelled as "--format=3D<style>".  In addition, --format=3D%formatstri=
ng
  is a short-hand for --pretty=3Dtformat:%formatstring.

* "--oneline" is a synonym for "--pretty=3Doneline --abbrev-commit".

* If you realize that you botched the patch when you are editing hunks
  with the 'edit' action in git-add -i/-p, you can abort the editor to
  tell git not to apply it.

* The number of commits shown in "you are ahead/behind your upstream"
  messages given by "git checkout" and "git status" used to count merge
  commits; now it doesn't.

* @{-1} is a new way to refer to the last branch you were on introduced=
 in
  1.6.2, but the initial implementation did not teach this to a few
  commands.  Now the syntax works with "branch -m @{-1} newname".

* git-archive learned --output=3D<file> option.

* git-bisect shows not just the number of remaining commits whose goodn=
ess
  is unknown, but also shows the estimated number of remaining rounds.

* You can give --date=3D<format> option to git-blame.

* "git-branch -r" shows HEAD symref that points at a remote branch in
  interest of each tracked remote repository.

* "git-branch -v -v" is a new way to get list of names for branches and=
 the
  "upstream" branch for them.

* git-config learned -e option to open an editor to edit the config fil=
e
  directly.

* git-clone runs post-checkout hook when run without --no-checkout.

* git-fast-export choked when seeing a tag that does not point at commi=
t.

* git-for-each-ref learned a new "upstream" token.

* git-format-patch can be told to use attachment with a new configurati=
on,
  format.attach.

* git-format-patch can be told to produce deep or shallow message threa=
ds.

* git-format-patch can be told to always add sign-off with a configurat=
ion
  variable.

* git-format-patch learned format.headers configuration to add extra
  header fields to the output.  This behaviour is similar to the existi=
ng
  --add-header=3D<header> option of the command.

* git-format-patch gives human readable names to the attached files, wh=
en
  told to send patches as attachments.

* git-grep learned to highlight the found substrings in color.

* git-imap-send learned to work around Thunderbird's inability to easil=
y
  disable format=3Dflowed with a new configuration, imap.preformattedHT=
ML.

* git-rebase can be told to rebase the series even if your branch is a
  descendant of the commit you are rebasing onto with --force-rebase
  option.

* git-rebase can be told to report diffstat with the --stat option.

* Output from git-remote command has been vastly improved.

* "git remote update --prune $remote" updates from the named remote and
  then prunes stale tracking branches.

* git-send-email learned --confirm option to review the Cc: list before
  sending the messages out.

(developers)

* Test scripts can be run under valgrind.

* Test scripts can be run with installed git.

* Makefile learned 'coverage' option to run the test suites with
  coverage tracking enabled.

* Building the manpages with docbook-xsl between 1.69.1 and 1.71.1 now
  requires setting DOCBOOK_SUPPRESS_SP to work around a docbook-xsl bug=
=2E
  This workaround used to be enabled by default, but causes problems
  with newer versions of docbook-xsl.  In addition, there are a few mor=
e
  knobs you can tweak to work around issues with various versions of th=
e
  docbook-xsl package.  See comments in Documentation/Makefile for deta=
ils.

=46ixes since v1.6.2
------------------

All of the fixes in v1.6.2.X maintenance series are included in this
release, unless otherwise noted.

Here are fixes that this release has, but have not been backported to
v1.6.2.X series.

* The initial checkout did not read the attributes from the .gitattribu=
te
  file that is being checked out.

* "git-checkout <tree-ish> <submodule>" did not update the index entry =
at
  the named path; it now does.

* git-gc spent excessive amount of time to decide if an object appears
  in a locally existing pack (if needed, backport by merging 69e020a).

* "git-ls-tree" and "git-diff-tree" used a pathspec correctly when
  deciding to descend into a subdirectory but they did not match the
  individual paths correctly.  This caused pathspecs "abc/d ab" to matc=
h
  "abc/0" ("abc/d" made them decide to descend into the directory "abc/=
",
  and then "ab" incorrectly matched "abc/0" when it shouldn't).

* "git-merge-recursive" was broken when a submodule entry was involved =
in
  a criss-cross merge situation.

----------------------------------------------------------------

Changes since v1.6.2 are as follows:

Alex Riesen (4):
      disable post-checkout test on Cygwin
      Produce a nicer output in case of sha1_object_info failures in ls=
-tree -l
      Microoptimize strbuf_cmp
      Improve error message about fetch into current branch

Ali Gholami Rudi (2):
      builtin-clone.c: make junk_pid static
      builtin-clone.c: no need to strdup for setenv

Allan Caffee (1):
      Documentation: update graph api example.

Amos King (2):
      Do not name "repo" struct "remote" in push_http.c
      http-push.c: use a faux remote to pass to http_init

Arjen Laarhoven (2):
      Clean up use of ANSI color sequences
      builtin-branch.c: Rename branch category color names

Arto Jonsson (1):
      bash completion: add options for 'git fsck'

Ben Jackson (2):
      git-svn: Add per-svn-remote ignore-paths config
      git-svn: Save init/clone --ignore-paths in config

Ben Walton (8):
      configure: ensure settings from user are also usable in the scrip=
t
      configure: reorganize flow of argument checks
      configure: add macros to stash FLAG variables
      configure: wrap some library tests with GIT_STASH_FLAGS
      configure: asciidoc version test cleanup
      configure: make iconv tests aware of user arguments
      configure: rework pthread handling to allow for user defined flag=
s
      documentation: Makefile accounts for SHELL_PATH setting

Benjamin Kramer (4):
      Remove unused function scope local variables
      Move local variables to narrower scopes
      Remove unused assignments
      Fix various dead stores found by the clang static analyzer

Bj=C3=B6rn Steinbrink (3):
      Mailmap: Allow empty email addresses to be mapped
      tree_entry_interesting: a pathspec only matches at directory boun=
dary
      process_{tree,blob}: Remove useless xstrdup calls

Boris Byk (1):
      git-svn: speed up blame command

Brandon Casey (8):
      t7700-repack: add two new tests demonstrating repacking flaws
      git-repack.sh: don't use --kept-pack-only option to pack-objects
      pack-objects: only repack or loosen objects residing in "local" p=
acks
      Remove --kept-pack-only option and associated infrastructure
      git-branch: display "was sha1" on branch deletion rather than jus=
t "sha1"
      t7700: demonstrate repack flaw which may loosen objects unnecessa=
rily
      pack-objects: don't loosen objects available in alternate or kept=
 packs
      builtin-send-pack.c: avoid empty structure initialization

Brian Gernhardt (2):
      Create USE_ST_TIMESPEC and turn it on for Darwin
      Makefile: Set compiler switch for USE_NSEC

Carlo Marcelo Arenas Belon (1):
      documentation: update cvsimport description of "-r" for recent cl=
one

Carlos Manuel Duclos Vergara (1):
      git-archive: add --output=3D<file> to send output to a file

Carlos Rica (1):
      config: test for --replace-all with one argument and fix document=
ation.

Chris Johnsen (14):
      builtin-revert.c: release index lock when cherry-picking an empty=
 commit
      git-push.txt: describe how to default to pushing only current bra=
nch
      Documentation: remove extra quoting/emphasis around literal texts
      Documentation/Makefile: make most operations "quiet"
      Documentation/Makefile: break up texi pipeline
      Documentation: move callouts.xsl to manpage-{base,normal}.xsl
      Documentation: use parametrized manpage-base.xsl with manpage-{1.=
72,normal}.xsl
      Documentation: rename docbook-xsl-172 attribute to git-asciidoc-n=
o-roff
      Documentation: move quieting params into manpage-base.xsl
      Documentation: move "spurious .sp" code into manpage-base.xsl
      Documentation: asciidoc.conf: always use <literallayout> for [blo=
cktext]
      Documentation: asciidoc.conf: fix verse block with block titles
      Documentation: option to render literal text as bold for manpages
      Documentation: use "spurious .sp" XSLT if DOCBOOK_SUPPRESS_SP is =
set

Christian Couder (25):
      rev-list: estimate number of bisection step left
      Documentation: fix badly indented paragraphs in "--bisect-all" de=
scription
      log-tree: fix patch filename computation in "git format-patch"
      quote: implement "sq_dequote_many" to unwrap many args in one str=
ing
      quote: add "sq_dequote_to_argv" to put unwrapped args in an argv =
array
      refs: add "for_each_ref_in" function to refactor "for_each_*_ref"=
 functions
      rev-list: make "bisect_list" variable local to "cmd_rev_list"
      rev-list: move bisect related code into its own file
      rev-list: move code to show bisect vars into its own function
      rev-list: make "show_bisect_vars" non static
      rev-list: pass "revs" to "show_bisect_vars"
      sha1-lookup: add new "sha1_pos" function to efficiently lookup sh=
a1
      patch-ids: use the new generic "sha1_pos" function to lookup sha1
      bisect: improve error message when branch checkout fails
      rev-list: call new "filter_skip" function
      bisect: use the new generic "sha1_pos" function to lookup sha1
      bisect--helper: implement "git bisect--helper"
      bisect: implement "read_bisect_paths" to read paths in "$GIT_DIR/=
BISECT_NAMES"
      bisect: use "bisect--helper" and remove "filter_skipped" function
      t6030: test bisecting with paths
      rev-list: pass "int flags" as last argument of "show_bisect_vars"
      bisect--helper: string output variables together with "&&"
      list-objects: add "void *data" parameter to show functions
      rev-list: remove last static vars used in "show_commit"
      rev-list: add "int bisect_show_flags" in "struct rev_list_info"

Clemens Buchacher (3):
      add tests for merging with submodules
      update cache for conflicting submodule entries
      simplify output of conflicting merge

Dan McGee (2):
      git-repack: use non-dashed update-server-info
      Update delta compression message to be less misleading

Daniel Barkalow (9):
      Make clone parse the default refspec with the normal code
      Use a single function to match names against patterns
      Use the matching function to generate the match results
      Keep '*' in pattern refspecs
      Support '*' in the middle of a refspec
      Use a common function to get the pretty name of refs
      Move push matching and reporting logic into transport.c
      Include log_config module in apache.conf
      Give error when no remote is configured

Daniel Cheng (aka SDiZ) (2):
      Fix bash completion in path with spaces
      State the effect of filter-branch on graft explicitly

David Aguilar (2):
      contrib/difftool: use a separate config namespace for difftool co=
mmands
      everyday: use the dashless form of git-init

David J. Mellor (12):
      Documentation: minor grammatical fixes in git-archive.txt.
      Documentation: reword the "Description" section of git-bisect.txt=
=2E
      Documentation: minor grammatical fixes in git-blame.txt.
      Documentation: minor grammatical fixes in git-branch.txt.
      Documentation: reworded the "Description" section of git-bisect.t=
xt.
      Documentation: reword example text in git-bisect.txt.
      Documentation: remove some uses of the passive voice in git-bisec=
t.txt
      Documentation: minor grammatical fixes and rewording in git-bundl=
e.txt
      Documentation: minor grammatical fixes in git-cat-file.txt
      Documentation: minor grammatical fixes in git-check-attr.txt
      Documentation: minor grammatical fix in git-check-ref-format.txt
      Documentation: Remove spurious uses of "you" in git-bisect.txt.

Deskin Miller (1):
      add -i: revisit hunk on editor failure

Elijah Newren (4):
      Ensure proper setup of git_dir for git-hash-object
      git-filter-branch: avoid collisions with variables in eval'ed com=
mands
      Correct missing SP characters in grammar comment at top of fast-i=
mport.c
      fast-export: Avoid dropping files from commits

Emil Sit (2):
      config.txt: Describe special 'none' handling in core.gitProxy.
      test-lib: Clean up comments and Makefile.

Eric Wong (2):
      git-svn: fix ls-tree usage with dash-prefixed paths
      git-svn: fix ls-tree usage with dash-prefixed paths

Erik Faye-Lund (5):
      connect.c: remove a few globals by using git_config callback data
      test-suite: adding a test for fast-export with tag variants
      builtin-fast-export.c: turn error into warning
      builtin-fast-export.c: fix crash on tagged trees
      builtin-fast-export.c: handle nested tags

Eugene Letuchy (1):
      Make git blame's date output format configurable, like git log

=46elipe Contreras (14):
      config: Add new option to open an editor.
      git config: codestyle cleanups
      git_config(): not having a per-repo config file is not an error
      git config: trivial rename in preparation for parseopt
      git config: reorganize get_color*
      git config: reorganize to use parseopt
      git config: don't allow multiple config file locations
      git config: don't allow multiple variable types
      git config: don't allow extra arguments for -e or -l.
      git config: don't allow --get-color* and variable type
      Add tests for git log --pretty, --format and --oneline.
      user-manual: remove some git-foo usage
      docbook: change css style
      user-manual: the name of the hash function is SHA-1, not sha1

=46inn Arne Gangstad (8):
      Support "\" in non-wildcard exclusion entries
      New config push.default to decide default behavior for push
      Display warning for default git push with no push.default config
      builtin-remote.c: Split out prune_remote as a separate function.
      git remote update: New option --prune
      git remote update: Report error for non-existing groups
      remote: New function remote_is_configured()
      git remote update: Fallback to remote if group does not exist

Giuseppe Bilotta (1):
      import-tars: separate author from committer

Heiko Voigt (3):
      Add warning about known issues to documentation of cvsimport
      Cleanup warning about known issues in cvsimport documentation
      Add configuration variable for sign-off to format-patch

Holger Wei=C3=9F (1):
      Documentation: Remove an odd "instead"

Janos Laube (1):
      MinGW: implement mmap

Jari Aalto (1):
      Change double quotes to single quotes in message

Jason Merrill (2):
      Documentation: clarify .gitattributes search
      git-svn: add fetch --parent option

Jay Soffian (34):
      builtin-branch: improve output when displaying remote branches
      send-email: allow send-email to run outside a repo
      send-email: handle multiple Cc addresses when reading mbox messag=
e
      send-email: --suppress-cc improvements
      send-email: don't create temporary compose file until it is neede=
d
      move duplicated get_local_heads() to remote.c
      move duplicated ref_newer() to remote.c
      move locate_head() to remote.c
      remote: simplify guess_remote_head()
      remote: make copy_ref() perform a deep copy
      remote: let guess_remote_head() optionally return all matches
      remote: make match_refs() copy src ref before assigning to peer_r=
ef
      remote: make match_refs() not short-circuit
      string-list: new for_each_string_list() function
      builtin-remote: refactor duplicated cleanup code
      builtin-remote: remove unused code in get_ref_states
      builtin-remote: rename variables and eliminate redundant function=
 call
      builtin-remote: make get_remote_ref_states() always populate stat=
es.tracked
      builtin-remote: fix two inconsistencies in the output of "show <r=
emote>"
      builtin-remote: teach show to display remote HEAD
      builtin-remote: add set-head subcommand
      builtin-remote: new show output style
      builtin-remote: new show output style for push refspecs
      send-email: add --confirm option and configuration setting
      bash completion: fix completion issues with fetch, pull, and push
      bash completion: refactor --strategy completion
      bash completion: teach fetch, pull, and push to complete their op=
tions
      send-email: refactor and ensure prompting doesn't loop forever
      send-email: add tests for refactored prompting
      send-email: don't attempt to prompt if tty is closed
      send-email: ask_default should apply to all emails, not just the =
first
      send-email: correct two tests which were going interactive
      send-email: ensure quoted addresses are rfc2047 encoded
      send-email: fix nasty bug in ask() function

Jeff King (34):
      valgrind: ignore ldso and more libz errors
      branch: clean up repeated strlen
      add basic branch display tests
      never fallback relative times to absolute
      test scripts: refactor start_httpd helper
      add basic http clone/fetch tests
      refactor find_ref_by_name() to accept const list
      remote: make guess_remote_head() use exact HEAD lookup if it is a=
vailable
      clone: run post-checkout hook when checking out
      improve missing repository error message
      t1300: use test_must_fail as appropriate
      config: set help text for --bool-or-int
      document config --bool-or-int
      t3000: use test_cmp instead of diff
      ls-files: fix broken --no-empty-directory
      ls-files: require worktree when --deleted is given
      doc: clarify how -S works
      make oneline reflog dates more consistent with multiline format
      ls-files: require worktree when --deleted is given
      remote: improve sorting of "configure for git push" list
      Makefile: turn on USE_ST_TIMESPEC for FreeBSD
      t0060: fix whitespace in "wc -c" invocation
      fix portability problem with IS_RUN_COMMAND_ERR
      t1301: loosen test for forced modes
      commit: abort commit if interactive add failed
      tests: remove exit after test_done call
      for-each-ref: refactor get_short_ref function
      for-each-ref: refactor refname handling
      for-each-ref: add "upstream" format field
      make get_short_ref a public function
      branch: show upstream branch when double verbose
      Makefile: allow building without perl
      tests: skip perl tests if NO_PERL is defined
      add tests for remote groups

Jens Lehmann (1):
      githooks documentation: post-checkout hook is also called after c=
lone

Jeremy White (2):
      Enable setting attach as the default in .gitconfig for git-format=
-patch.
      imap.preformattedHTML to tell Thunderbird to send non-flowed text

Johan Herland (1):
      Move chmod(foo, 0444) into move_temp_to_file()

Johannes Schindelin (28):
      Add valgrind support in test scripts
      Valgrind support: check for more than just programming errors
      test-lib.sh: optionally output to test-results/$TEST.out, too
      t/Makefile: provide a 'valgrind' target
      Add a script to coalesce the valgrind outputs
      Tests: let --valgrind imply --verbose and --tee
      test-lib: avoid assuming that templates/ are in the GIT_EXEC_PATH
      valgrind: do not require valgrind 3.4.0 or newer
      Avoid segfault with 'git branch' when the HEAD is detached
      Turn the flags in struct dir_struct into a single variable
      git config: trivial cleanup for editor action
      rebase -i: avoid 'git reset' when possible
      MinGW: 64-bit file offsets
      Brown paper bag fix for MinGW 64-bit stat
      Add an (optional, since expensive) test for >2gb clones
      MinGW: fix diff --no-index /dev/null ...
      rsync transport: allow local paths, and fix tests
      winansi: support ESC [ K (erase in line)
      test: do not LoadModule log_config_module unconditionally
      test-lib: write test results to test-results/<basename>-<pid>
      gc --aggressive: make it really aggressive
      t7300: fix clean up on Windows
      Smudge the files fed to external diff and textconv
      Guard a few Makefile variables against user environments
      import-zips: fix thinko
      mailmap: resurrect lower-casing of email addresses
      Fix 'git checkout <submodule>' to update the index
      git-svn: always initialize with core.autocrlf=3Dfalse

Johannes Sixt (32):
      recv_sideband: Bands #2 and #3 always go to stderr
      test-suite: Make test script numbers unique
      t9400, t9401: Do not force hard-linked clone
      test suite: Use 'say' to say something instead of 'test_expect_su=
ccess'
      Call 'say' outside test_expect_success
      test-lib: Replace uses of $(expr ...) by POSIX shell features.
      test-lib: Simplify test counting.
      test-lib: Introduce test_chmod and use it instead of update-index=
 --chmod
      t2200, t7004: Avoid glob pattern that also matches files
      t5300, t5302, t5303: Do not use /dev/zero
      t5602: Work around path mangling on MSYS
      test-lib: Work around incompatible sort and find on Windows
      test-lib: Work around missing sum on Windows
      Tests on Windows: $(pwd) must return Windows-style paths
      t0050: Check whether git init detected symbolic link support corr=
ectly
      test-lib: Infrastructure to test and check for prerequisites
      Propagate --exec-path setting to external commands via GIT_EXEC_P=
ATH
      t3600: Use test prerequisite tags
      Skip tests that fail if the executable bit is not handled by the =
filesystem
      t5302: Use prerequisite tags to skip 64-bit offset tests
      t9100, t9129: Use prerequisite tags for UTF-8 tests
      Use prerequisite tags to skip tests that depend on symbolic links
      t0060: Fix tests on Windows
      Skip tests that require a filesystem that obeys POSIX permissions
      t3700: Skip a test with backslashes in pathspec
      Use prerequisites to skip tests that need unzip
      t7004: Use prerequisite tags to skip tests that need gpg
      t5503: GIT_DEBUG_SEND_PACK is not supported on MinGW
      MinGW: Quote arguments for subprocesses that contain a single-quo=
te
      diff --no-index: Do not generate patch output if other output is =
requested
      t7005-editor: Use $SHELL_PATH in the editor scripts
      t7502-commit: Skip SIGTERM test on Windows

John Tapsell (5):
      Modify description file to say what this file is
      Google has renamed the imap folder
      Improve error message for git-filter-branch
      Make the 'lock file' exists error more informative
      Documentation - More examples for git bisect

Julien Danjou (1):
      git submodule: fix usage line

Junio C Hamano (51):
      git-blame: refactor code to emit "porcelain format" output
      blame: show "previous" information in --porcelain/--incremental f=
ormat
      git-add -i/-p: learn to unwrap C-quoted paths
      git-repack: resist stray environment variable
      has_sha1_pack(): refactor "pretend these packs do not exist" inte=
rface
      has_sha1_kept_pack(): take "struct rev_info"
      Consolidate ignore_packed logic more
      Simplify is_kept_pack()
      is_kept_pack(): final clean-up
      Make git-clone respect branch.autosetuprebase
      Beginning of 1.6.2 maintenance track
      Draft release notes: Carry forward the warning for behaviour chan=
ges
      Update draft release notes to 1.6.3
      builtin-remote.c: no "commented out" code, please
      Not all systems use st_[cm]tim field for ns resolution file times=
tamp
      grep: cast printf %.*s "precision" argument explicitly to int
      http.c: style cleanups
      Improve "git branch --tracking" output
      http_init(): Fix config file parsing
      http authentication via prompts
      Update draft release notes for 1.6.2.1
      Update release notes to 1.6.3
      read-tree A B C: do not create a bogus index and do not segfault
      http.c: CURLOPT_NETRC_OPTIONAL is not available in ancient versio=
ns of cURL
      Read attributes from the index that is being checked out
      GIT 1.6.2.1
      Remove total confusion from git-fetch and git-push
      Update draft release notes to 1.6.3
      blame: read custom grafts given by -S before calling setup_revisi=
ons()
      http tests: Darwin is not that special
      Update draft release notes to 1.6.2.2
      diff --cached: do not borrow from a work tree when a path is mark=
ed as assume-unchanged
      Rename interpret/substitute nth_last_branch functions
      strbuf_branchname(): a wrapper for branch name shorthands
      check-ref-format --branch: give Porcelain a way to grok branch sh=
orthand
      Fix branch -m @{-1} newname
      strbuf_check_branch_ref(): a helper to check a refname for a bran=
ch
      check_ref_format(): tighten refname rules
      "core.sharedrepository =3D 0mode" should set, not loosen
      Update draft release notes to 1.6.3
      move_temp_to_file(): do not forget to chmod() in "Coda hack" code=
path
      set_shared_perm(): sometimes we know what the final mode bits sho=
uld look like
      Update draft release notes to 1.6.2.2
      match_tree_entry(): a pathspec only matches at directory boundari=
es
      GIT 1.6.2.2
      Update draft release notes to 1.6.3
      sha1-lookup: fix up the assertion message
      Start 1.6.2.3 preparation
      Update draft release notes to 1.6.3
      GIT 1.6.2.3
      GIT 1.6.3-rc0

Junio Hamano (1):
      Speed up reflog pruning of unreachable commits

Keith Cascio (2):
      Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw bit-masking
      Fix neglect of diff_setup()/diff_setup_done() symmetry.

Kevin Ballard (1):
      builtin-push.c: Fix typo: "anythig" -> "anything"

Kevin McConnell (1):
      Add --staged to bash completion for git diff

Kjetil Barvik (18):
      lstat_cache(): small cleanup and optimisation
      lstat_cache(): generalise longest_match_lstat_cache()
      lstat_cache(): swap func(length, string) into func(string, length=
)
      unlink_entry(): introduce schedule_dir_for_removal()
      create_directories(): remove some memcpy() and strchr() calls
      write_entry(): cleanup of some duplicated code
      write_entry(): use fstat() instead of lstat() when file is open
      show_patch_diff(): remove a call to fstat()
      lstat_cache(): print a warning if doing ping-pong between cache t=
ypes
      check_updates(): effective removal of cache entries marked CE_REM=
OVE
      fix compile error when USE_NSEC is defined
      make USE_NSEC work as expected
      verify_uptodate(): add ce_uptodate(ce) test
      write_index(): update index_state->timestamp after flushing to di=
sk
      stat_tracking_info(): only count real commits
      Record ns-timestamps if possible, but do not use it without USE_N=
SEC
      checkout bugfix: use stat.mtime instead of stat.ctime in two plac=
es
      Revert "lstat_cache(): print a warning if doing ping-pong between=
 cache types"

Kristian Amlie (1):
      Add a test for checking whether gitattributes is honored by check=
out.

Linus Torvalds (4):
      close_sha1_file(): make it easier to diagnose errors
      Clean up reflog unreachability pruning decision
      Allow users to un-configure rename detection
      process_{tree,blob}: Remove useless xstrdup calls

Marius Storm-Olsen (2):
      Add bare repository indicator for __git_ps1
      Fixup: Add bare repository indicator for __git_ps1

Markus Heidelberg (2):
      add --html-path to get the location of installed HTML docs
      doc/git-pack-refs: fix two grammar issues

Martin Storsj=C3=B6 (1):
      Allow curl to rewind the read buffers

Matthieu Moy (5):
      git-checkout.txt: fix incorrect statement about HEAD and index
      git-checkout.txt: clarify that <branch> applies when no path is g=
iven.
      git-send-email.txt: clarify which options take an argument.
      git-rev-list.txt: make ascii markup uniform with other pages.
      git-pull.sh: better warning message for "git pull" on detached he=
ad.

Michael Hendricks (1):
      format-patch: add arbitrary email headers

Michael J Gruber (8):
      git submodule: Add test cases for git submodule add
      git submodule: Fix adding of submodules at paths with ./, .. and =
//
      Typo and language fixes for git-checkout.txt
      test-lib.sh: Test for presence of git-init in the right path.
      test-lib.sh: Allow running the test suite against installed git
      git-branch.txt: document -f correctly
      Test for local branches being followed with --track
      Make local branches behave like remote branches when --tracked

Michael Lai (1):
      git-svn: support intermediate paths when matching tags/branches

Michele Ballabio (6):
      apply: consistent spelling of "don't"
      apply: hide unused options from short help
      git log: avoid segfault with --all-match
      document --force-rebase
      rebase: add options passed to git-am
      rebase: fix typo (force_rebas -> force-rebas)

Mike Hommey (1):
      Replace ",<,>,& with their respective XML entities in DAV request=
s

Miklos Vajna (11):
      parse-opt: migrate builtin-ls-files.
      Tests: use test_cmp instead of diff where possible
      http-push: using error() and warning() as appropriate
      builtin-apply: use warning() instead of fprintf(stderr, "warning:=
 ")
      builtin-checkout: use warning() instead of fprintf(stderr, "warni=
ng: ")
      builtin-fetch-pack: use warning() instead of fprintf(stderr, "war=
ning: ")
      builtin-init-db: use warning() instead of fprintf(stderr, "warnin=
g: ")
      builtin-rm: use warning() instead of fprintf(stderr, "warning: ")
      builtin-show-branch: use warning() instead of fprintf(stderr, "wa=
rning: ")
      builtin-show-ref: use warning() instead of fprintf(stderr, "warni=
ng: ")
      refs: use warning() instead of fprintf(stderr, "warning: ")

Nanako Shiraishi (4):
      Add --format that is a synonym to --pretty
      Give short-hands to --pretty=3Dtformat:%formatstring
      Add --oneline that is a synonym to "--pretty=3Doneline --abbrev-c=
ommit"
      Documentation/git.txt: GIT 1.6.2.2 has been out for a while

Nate Case (1):
      format-patch: Respect --quiet option

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      grep: prefer builtin over external one when coloring results

Nico -telmich- Schottelius (1):
      git-tag(1): add hint about commit messages

Nicolas Pitre (1):
      avoid possible overflow in delta size filtering computation

Pete Wyckoff (1):
      git-p4: remove tabs from usermap file

Petr Kodl (2):
      MinGW: a helper function that translates Win32 API error codes
      MinGW: a hardlink implementation

Ramsay Allan Jones (1):
      git-instaweb: fix lighttpd configuration on cygwin

Ren=C3=A9 Scharfe (16):
      diffcore-pickaxe: use memmem()
      optimize compat/ memmem()
      cleanup: add isascii()
      grep: micro-optimize hit collection for AND nodes
      grep: remove grep_opt argument from match_expr_eval()
      grep: add pmatch and eflags arguments to match_one_pattern()
      grep: color patterns in output
      grep: add support for coloring with external greps
      parseopt: add PARSE_OPT_KEEP_UNKNOWN
      parseopt: add PARSE_OPT_NO_INTERNAL_HELP
      parseopt: make usage optional
      archive: use parseopt for local-only options
      parseopt: document KEEP_ARGV0, KEEP_UNKNOWN, NO_INTERNAL_HELP
      parseopt: prevent KEEP_UNKNOWN and STOP_AT_NON_OPTION from being =
used together
      pickaxe: count regex matches only once
      pickaxe: count regex matches only once

SZEDER G=C3=A1bor (1):
      rerere: remove duplicated functions

Santi B=C3=A9jar (4):
      Documentation: enhance branch.<name>.{remote,merge}
      Documentation: push.default applies to all remotes
      Documentation: branch.*.merge can also affect 'git-push'
      Documentation: Introduce "upstream branch"

Shawn O. Pearce (2):
      Increase the size of the die/warning buffer to avoid truncation
      Don't permit ref/branch names to end with ".lock"

Simon Arlott (2):
      git-svn: don't output git commits in quiet mode
      git-svn: add a double quiet option to hide git commits

Stephen Boyd (12):
      git-send-email.txt: describe --compose better
      format-patch: --numbered-files and --stdout aren't mutually exclu=
sive
      pretty.c: add %f format specifier to format_commit_message()
      format-patch: construct patch filename in one function
      format-patch: pass a commit to reopen_stdout()
      format-patch: move get_patch_filename() into log-tree
      format-patch: --attach/inline uses filename instead of SHA1
      format-patch: --numbered-files and --stdout aren't mutually exclu=
sive
      completion: add --annotate option to send-email
      completion: add --cc and --no-attachment option to format-patch
      completion: add --thread=3Ddeep/shallow to format-patch
      format_sanitized_subject: Don't trim past initial length of strbu=
f

Sverre Rabbelier (1):
      Teach rebase to rebase even if upstream is up to date

Tay Ray Chuan (1):
      http.c: use strbuf API in quote_ref_url

Ted Pavlic (4):
      completion: For consistency, change "git rev-parse" to __gitdir c=
alls
      completion: Use consistent if [...] convention, not "test"
      completion: Better __git_ps1 support when not in working director=
y
      completion: More fixes to prevent unbound variable errors

Teemu Likonen (1):
      bash completion: add --format=3D and --oneline options for "git l=
og"

Thomas Rast (17):
      format-patch: threading test reactivation
      Support coverage testing with GCC/gcov
      Test that diff can read from stdin
      Test diff --dirstat functionality
      Test log --graph
      Test fsck a bit harder
      Test log --decorate
      Test rev-list --parents/--children
      Test git-patch-id
      format-patch: track several references
      format-patch: thread as reply to cover letter even with in-reply-=
to
      format-patch: support deep threading
      send-email: respect in-reply-to regardless of threading
      send-email: test --no-thread --in-reply-to combination
      Documentation: filter-branch: show --ignore-unmatch in main index=
-filter example
      Documentation: format-patch --root clarifications
      bash completion: only show 'log --merge' if merging

Todd Zullinger (1):
      bash completion: Update 'git am' options

Tor Arne Vestb=C3=B8 (2):
      git-rebase: Add --stat and --no-stat for producing diffstat on re=
base
      git-pull: Allow --stat and --no-stat to be used with --rebase

Wesley J. Landaker (1):
      Documentation: git-svn: fix trunk/fetch svn-remote key typo

Wincent Colaiuta (2):
      Grammar fixes to "merge" and "patch-id" docs
      Grammar fix for "git merge" man page
