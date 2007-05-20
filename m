From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.2
Date: Sun, 20 May 2007 02:08:53 -0700
Message-ID: <7vsl9rq2u2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 11:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HphPc-0004B9-Hr
	for gcvg-git@gmane.org; Sun, 20 May 2007 11:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbXETJJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 05:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754417AbXETJJD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 05:09:03 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61242 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbXETJI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2007 05:08:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520090856.WDMA2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 20 May 2007 05:08:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1M8u1X0041kojtg0000000; Sun, 20 May 2007 05:08:55 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47801>

The latest feature release GIT 1.5.2 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.2-1.$arch.rpm	(RPM)

GIT v1.5.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v1.5.1
--------------------

* Plumbing level superproject support.

  You can include a subdirectory that has an independent git
  repository in your index and tree objects of your project
  ("superproject").  This plumbing (i.e. "core") level
  superproject support explicitly excludes recursive behaviour.

  The "subproject" entries in the index and trees of a superproject
  are incompatible with older versions of git.  Experimenting with
  the plumbing level support is encouraged, but be warned that
  unless everybody in your project updates to this release or
  later, using this feature would make your project
  inaccessible by people with older versions of git.

* Plumbing level gitattributes support.

  The gitattributes mechanism allows you to add 'attributes' to
  paths in your project, and affect the way certain git
  operations work.  Currently you can influence if a path is
  considered a binary or text (the former would be treated by
  'git diff' not to produce textual output; the latter can go
  through the line endings conversion process in repositories
  with core.autocrlf set), expand and unexpand '$Id$' keyword
  with blob object name, specify a custom 3-way merge driver,
  and specify a custom diff driver.  You can also apply
  arbitrary filter to contents on check-in/check-out codepath
  but this feature is an extremely sharp-edged razor and needs
  to be handled with caution (do not use it unless you
  understand the earlier mailing list discussion on keyword
  expansion).  These conversions apply when checking files in
  or out, and exporting via git-archive.

* The packfile format now optionally suports 64-bit index.

  This release supports the "version 2" format of the .idx
  file.  This is automatically enabled when a huge packfile
  needs more than 32-bit to express offsets of objects in the
  pack.

* Comes with an updated git-gui 0.7.1

* Updated gitweb:

  - can show combined diff for merges;
  - uses font size of user's preference, not hardcoded in pixels;
  - can now 'grep';

* New commands and options.

  - "git bisect start" can optionally take a single bad commit and
    zero or more good commits on the command line.

  - "git shortlog" can optionally be told to wrap its output.

  - "subtree" merge strategy allows another project to be merged in as
    your subdirectory.

  - "git format-patch" learned a new --subject-prefix=3D<string>
    option, to override the built-in "[PATCH]".

  - "git add -u" is a quick way to do the first stage of "git
    commit -a" (i.e. update the index to match the working
    tree); it obviously does not make a commit.

  - "git clean" honors a new configuration, "clean.requireforce".  When
    set to true, this makes "git clean" a no-op, preventing you
    from losing files by typing "git clean" when you meant to
    say "make clean".  You can still say "git clean -f" to
    override this.

  - "git log" family of commands learned --date=3D{local,relative,defau=
lt}
    option.  --date=3Drelative is synonym to the --relative-date.
    --date=3Dlocal gives the timestamp in local timezone.

* Updated behavior of existing commands.

  - When $GIT_COMMITTER_EMAIL or $GIT_AUTHOR_EMAIL is not set
    but $EMAIL is set, the latter is used as a substitute.

  - "git diff --stat" shows size of preimage and postimage blobs
    for binary contents.  Earlier it only said "Bin".

  - "git lost-found" shows stuff that are unreachable except
    from reflogs.

  - "git checkout branch^0" now detaches HEAD at the tip commit
    on the named branch, instead of just switching to the
    branch (use "git checkout branch" to switch to the branch,
    as before).

  - "git bisect next" can be used after giving only a bad commit
    without giving a good one (this starts bisection half-way to
    the root commit).  We used to refuse to operate without a
    good and a bad commit.

  - "git push", when pushing into more than one repository, does
    not stop at the first error.

  - "git archive" does not insist you to give --format parameter
    anymore; it defaults to "tar".

  - "git cvsserver" can use backends other than sqlite.

  - "gitview" (in contrib/ section) learned to better support
    "git-annotate".

  - "git diff $commit1:$path2 $commit2:$path2" can now report
    mode changes between the two blobs.

  - Local "git fetch" from a repository whose object store is
    one of the alternates (e.g. fetching from the origin in a
    repository created with "git clone -l -s") avoids
    downloading objects unnecessarily.

  - "git blame" uses .mailmap to canonicalize the author name
    just like "git shortlog" does.

  - "git pack-objects" pays attention to pack.depth
    configuration variable.

  - "git cherry-pick" and "git revert" does not use .msg file in
    the working tree to prepare commit message; instead it uses
    $GIT_DIR/MERGE_MSG as other commands do.

* Builds

  - git-p4import has never been installed; now there is an
    installation option to do so.

  - gitk and git-gui can be configured out.

  - Generated documentation pages automatically get version
    information from GIT_VERSION.

  - Parallel build with "make -j" descending into subdirectory
    was fixed.

* Performance Tweaks

  - Optimized "git-rev-list --bisect" (hence "git-bisect").

  - Optimized "git-add $path" in a large directory, most of
    whose contents are ignored.

  - Optimized "git-diff-tree" for reduced memory footprint.

  - The recursive merge strategy updated a worktree file that
    was changed identically in two branches, when one of them
    renamed it.  We do not do that when there is no rename, so
    match that behaviour.  This avoids excessive rebuilds.

  - The default pack depth has been increased to 50, as the
    recent addition of delta_base_cache makes deeper delta chains
    much less expensive to access.  Depending on the project, it was
    reported that this reduces the resulting pack file by 10%
    or so.


=46ixes since v1.5.1
------------------

All of the fixes in v1.5.1 maintenance series are included in
this release, unless otherwise noted.

* Bugfixes

  - Switching branches with "git checkout" refused to work when
    a path changes from a file to a directory between the
    current branch and the new branch, in order not to lose
    possible local changes in the directory that is being turned
    into a file with the switch.  We now allow such a branch
    switch after making sure that there is no locally modified
    file nor un-ignored file in the directory.  This has not
    been backported to 1.5.1.x series, as it is rather an
    intrusive change.

  - Merging branches that have a file in one and a directory in
    another at the same path used to get quite confused.  We
    handle such a case a bit more carefully, even though that is
    still left as a conflict for the user to sort out.  This
    will not be backported to 1.5.1.x series, as it is rather an
    intrusive change.

  - git-fetch had trouble with a remote with insanely large number
    of refs.

  - "git clean -d -X" now does not remove non-excluded directories.

  - rebasing (without -m) a series that changes a symlink to a director=
y
    in the middle of a path confused git-apply greatly and refused to
    operate.

----------------------------------------------------------------

Changes since v1.5.1 are as follows:

Adam Roben (5):
      Remove usernames from all commit messages, not just when using sv=
mprops
      git-svn: Don't rely on $_ after making a function call
      git-svn: Ignore usernames in URLs in find_by_url
      git-svn: Added 'find-rev' command
      git-svn: Add 'find-rev' command

Alex Riesen (22):
      Fix passing of TCLTK_PATH to git-gui
      Use rev-list --reverse in git-rebase.sh
      Document -g (--walk-reflogs) option of git-log
      Fix t4201: accidental arithmetic expansion
      Fix permissions on test scripts
      Fix overwriting of files when applying contextually independent d=
iffs
      Tests for core subproject support
      Simplify calling of CR/LF conversion routines
      Fix a typo in crlf conversion code
      Fix crash in t0020 (crlf conversion)
      Fix handle leak in write_tree
      Avoid excessive rewrites in merge-recursive
      Add a test for merging changed and rename-changed branches
      Ignore merged status of the file-level merge
      Use strlcpy instead of strncpy in mailmap.c
      Fix read_mailmap to handle a caller uninterested in repo abbrevia=
tion
      Remove pointless calls to access(2) when checking for .mailmap
      Include mailmap.h in mailmap.c to catch mailmap interface changes
      Small correction in reading of commit headers
      Handle return code of parse_commit in revision machinery
      Use GIT_OBJECT_DIR for temporary files of pack-objects
      Allow fetching references from any namespace

Alexandre Julliard (2):
      git.el: Add a commit description to the reflog.
      http-fetch: Disable use of curl multi support for libcurl < 7.16.

Amos Waterland (1):
      wcwidth redeclaration

Andrew Ruder (17):
      Add policy on user-interface changes
      Update git-am documentation
      Update git-applymbox documentation
      Update git-apply documentation
      Update git-annotate/git-blame documentation
      Update git-archive documentation
      Update git-cherry-pick documentation
      Fix unmatched emphasis tag in git-tutorial
      Update git-config documentation
      Removing -n option from git-diff-files documentation
      Document additional options for git-fetch
      Update git-fmt-merge documentation
      Update git-grep documentation
      Update -L documentation for git-blame/git-annotate
      Update git-http-push documentation
      Update git-local-fetch documentation
      Update git-http-fetch documentation

Andy Parkins (6):
      Show binary file size change in diff --stat
      post-receive-email example hook: fastforward should have been fas=
t_forward
      post-receive-email example hook: detect rewind-only updates and o=
utput sensible message
      post-receive-email example hook: sed command for getting descript=
ion was wrong
      Use $Id$ as the ident attribute keyword rather than $ident$ to be=
 consistent with other VCSs
      Fix crlf attribute handling to match documentation

Andy Whitcroft (2):
      fix up strtoul_ui error handling
      git name-rev writes beyond the end of malloc() with large generat=
ions

Aneesh Kumar K.V (1):
      gitview: annotation support

Arjen Laarhoven (5):
      usermanual.txt: some capitalization nits
      t3200-branch.sh: small language nit
      t5300-pack-object.sh: portability issue using /usr/bin/stat
      Makefile: iconv() on Darwin has the old interface
      Document 'opendiff' value in config.txt and git-mergetool.txt

Brian Gernhardt (7):
      Remove unused WITH_OWN_SUBPROCESS_PY from RPM spec
      Fix t4200-rerere for white-space from "wc -l"
      Document --left-right option to rev-list.
      Distinguish branches by more than case in tests.
      Remove case-sensitive file in t3030-merge-recursive.
      Reverse the order of -b and --track in the man page.
      Ignore all man sections as they are generated files.

Bryan Larsen (2):
      Allow PERL_PATH=3D"/usr/bin/env perl"
      posix compatibility for t4200

Carl Worth (1):
      Mention version 1.5.1 in tutorial and user-manual

Carlos Rica (1):
      Use const qualifier for 'sha1' parameter in delete_ref function

Christian Couder (4):
      Bisect: teach "bisect start" to optionally use one bad and many g=
ood revs.
      Documentation: bisect: "start" accepts one bad and many good comm=
its
      Bisect: simplify "bisect start" logging.
      Bisect: rename "t/t6030-bisect-run.sh" to "t/t6030-bisect-porcela=
in.sh".

Dana L. How (2):
      Fix lseek(2) calls with args 2 and 3 swapped
      Create pack-write.c for common pack writing code

Daniel Barkalow (1):
      Make xstrndup common

Eric Wong (14):
      git-svn: bail out on incorrect command-line options
      git-svn: bail out on incorrect command-line options
      git-svn: dcommit/rebase confused by patches with git-svn-id: line=
s
      git-svn: fix log command to avoid infinite loop on long commit me=
ssages
      git-svn: respect lower bound of -r/--revision when following pare=
nt
      git-svn: quiet some warnings when run only with --version/--help
      git-svn: don't allow globs to match regular files
      perl: install private Error.pm if the site version is older than =
our own
      git-svn: don't drop the username from URLs when dcommit is run
      git-svn: clean up caching of SVN::Ra functions
      git-svn: fix segfaults due to initial SVN pool being cleared
      git-svn: don't attempt to minimize URLs by default
      git-svn: avoid crashing svnserve when creating new directories
      git-svn: don't minimize-url when doing an init that tracks multip=
le paths

Eygene Ryabinkin (13):
      Teach gitk to use the user-defined UI font everywhere.
      Improve look-and-feel of the gitk tool.
      Add the WITH_P4IMPORT knob to the Makefile.
      Added git-p4 package to the list of git RPMs.
      Added correct Python path to the RPM specfile.
      NO_TCLTK
      Add --with-tcltk and --without-tcltk to configure.
      Rewrite Tcl/Tk interpreter path for the GUI tools.
      Eliminate checks of user-specified Tcl/Tk interpreter.
      Allow wish interpreter to be defined with TCLTK_PATH
      Teach git-gui to use the user-defined UI font everywhere.
      Improve look-and-feel of the git-gui tool.
      Do not break git-gui messages into multiple lines.

=46ernando J. Pereda (1):
      Makefile: Add '+' to QUIET_SUBDIR0 to fix parallel make.

=46rank Lichtenheld (35):
      cvsserver: Introduce new state variable 'method'
      cvsserver: Handle three part keys in git config correctly
      cvsserver: Allow to override the configuration per access method
      cvsserver: Make the database backend configurable
      cvsserver: Abort if connect to database fails
      Documentation: Replace @@GIT_VERSION@@ in documentation
      Documentation: Add version information to man pages
      cvsserver: Use DBI->table_info instead of DBI->tables
      cvsimport: sync usage lines with existing options
      cvsimport: Improve documentation of CVSROOT and CVS module determ=
ination
      cvsimport: Improve usage error reporting
      cvsimport: Reorder options in documentation for better understand=
ing
      cvsimport: Improve formating consistency
      cvsserver: small corrections to asciidoc documentation
      cvsserver: Corrections to the database backend configuration
      cvsserver: Add asciidoc documentation for new database backend co=
nfiguration
      gitweb: Allow forks with project list file
      gitweb: Allow configuring the default projects order and add orde=
r 'none'
      cvsserver: Fix handling of diappeared files on update
      cvsserver: Allow to "add" a removed file
      cvsserver: Reword documentation on necessity of write access
      cvsserver: Document the GIT branches -> CVS modules mapping more =
prominently
      config.txt: Document gitcvs.allbinary
      config.txt: Document core.autocrlf
      config.txt: Change pserver to server in description of gitcvs.*
      config.txt: Fix grammatical error in description of http.noEPSV
      config.txt: Add gitcvs.db* variables
      git-shortlog: Fix two formatting errors in asciidoc documentation
      cvsserver: Handle re-added files correctly
      cvsserver: Add test cases for git-cvsserver
      cvsserver: Limit config parser to needed options
      cvsserver: Don't send mixed messages to clients
      builtin-log.c: Fix typo in comment
      Documentation: format-patch has no --mbox option
      git-am: Clean up the asciidoc documentation

Geert Bosch (1):
      Fix renaming branch without config file

Gerrit Pape (5):
      rename contrib/hooks/post-receieve-email to contrib/hooks/post-re=
ceive-email.
      variable $projectdesc needs to be set before checking against unc=
hanged default.
      Have sample update hook not refuse deleting a branch through push=
=2E
      Documentation/git-reset.txt: suggest git commit --amend in exampl=
e.
      gitweb: choose appropriate view for file type if a=3D parameter m=
issing

Ismail D=C3=B6nmez (1):
      gitweb: use decode_utf8 directly

J. Bruce Fields (28):
      Documentation: minor edits of git-lost-found manpage
      Documentation: clarify git-checkout -f, minor editing
      Documentation: clarify track/no-track option.
      user-manual: fix discussion of default clone
      user-manual: detached HEAD
      user-manual: start revising "internals" chapter
      user-manual: use detached head when rewriting history
      user-manual: more discussion of detached heads, fix typos
      user-manual: add section ID's
      user-manual: clean up fast-forward and dangling-objects sections
      user-manual: fix .gitconfig editing examples
      user-manual: miscellaneous editing
      user-manual: stop deprecating the manual
      user-manual: fix clone and fetch typos
      user-manual: revise birdseye-view chapter
      glossary: expand and clarify some definitions, prune cross-refere=
nces
      user-manual: move quick-start to an appendix
      Documentation: remove howto's now incorporated into manual
      user-manual: move howto/make-dist.txt into user manual
      user-manual: move howto/using-topic-branches into manual
      user-manual: add a "counting commits" example
      user-manual: introduce git
      user-manual: listing commits reachable from some refs not others
      user-manual: reorganize public git repo discussion
      tutorials: add user-manual links
      tutorial: revise index introduction
      user-manual: discourage shared repository
      user-manual: finding commits referencing given file content

Jakub Narebski (20):
      gitweb: Whitespace cleanup - tabs are for indent, spaces are for =
align (3)
      gitweb: Quote hash keys, and do not use barewords keys
      gitweb: Fix bug in "blobdiff" view for split (e.g. file to symlin=
k) patches
      diff format documentation: describe raw combined diff format
      gitweb: Add parsing of raw combined diff format to parse_difftree=
_raw_line
      gitweb: Add combined diff support to git_difftree_body
      gitweb: Add combined diff support to git_patchset_body
      gitweb: Make it possible to use pre-parsed info in git_difftree_b=
ody
      gitweb: Show combined diff for merge commits in 'commitdiff' view
      gitweb: Show combined diff for merge commits in 'commit' view
      gitweb: Test if $from_id and $to_id are defined before comparison
      gitweb: Check if requested object exists
      gitweb: Fix "Use of unitialized value" warnings in empty reposito=
ry
      Documentation: Split description of pretty formats of commit log
      gitweb: Add a few comments about %feature hash
      gitweb: Do not use absolute font sizes
      gitweb: Separate search regexp from search text
      gitweb: Empty patch for merge means trivial merge, not no differe=
nces
      gitweb: Fix error in git_patchset_body for deletion in merge comm=
it
      gitweb: Fix "Use of uninitialized value" warning in git_feed

James Bowes (2):
      Document git-check-attr
      Documentation: fix typo in git-remote.txt

Jan Hudec (2):
      Updated documentation of hooks in git-receive-pack.
      Minor fixup to documentation of hooks in git-receive-pack.

Jari Aalto (4):
      Clarify SubmittingPatches Checklist
      git.7: Mention preformatted html doc location
      send-email documentation: clarify --smtp-server
      SPECIFYING RANGES typo fix: it it =3D> it is

Jeff King (4):
      Documentation: don't reference non-existent 'git-cvsapplycommit'
      git-add: allow path limiting with -u
      Documentation/git-add: clarify -u with path limiting
      format-patch: add MIME-Version header when we add content-type.

Jim Meyering (3):
      (encode_85, decode_85): Mark source buffer pointer as "const".
      sscanf/strtoul: parse integers robustly
      sscanf/strtoul: parse integers robustly

Johan Herland (3):
      Fix signedness on return value from xread()
      Ensure return value from xread() is always stored into an ssize_t
      user-manual: Add section on ignoring files

Johannes Schindelin (7):
      Use print_wrapped_text() in shortlog
      dir.c(common_prefix): Fix two bugs
      t4201: Do not display weird characters on the terminal
      import-tars: be nice to wrong directory modes
      Teach import-tars about GNU tar's @LongLink extension.
      import-tars: Use the "Link indicator" to identify directories
      Add a birdview-on-the-source-code section to the user manual

Johannes Sixt (1):
      git-gui: Call changes "Staged" and "Unstaged" in file list titles=
=2E

Jonas Fonseca (1):
      git-tag(1): -v option is a subcommand; fix code block

Josh Triplett (5):
      Add clean.requireForce option, and add -f option to git-clean to =
override it
      Fix typo in git-am: s/Was is/Was it/
      Create a sysconfdir variable, and use it for ETC_GITCONFIG
      Add missing reference to GIT_COMMITTER_DATE in git-commit-tree do=
cumentation
      Fall back to $EMAIL for missing GIT_AUTHOR_EMAIL and GIT_COMMITTE=
R_EMAIL

Julian Phillips (3):
      Documentation: show-ref: document --exclude-existing
      refs.c: add a function to sort a ref list, rather then sorting on=
 add
      http.c: Fix problem with repeated calls of http_init

Junio C Hamano (151):
      git-fetch: add --quiet
      t6002: minor spelling fix.
      git-rev-list: add --bisect-vars option.
      git-rev-list --bisect: optimization
      t6004: add a bit more path optimization test.
      rev-list --bisect: Fix "halfway" optimization.
      make the previous optimization work also on path-limited rev-list=
 --bisect
      Documentation: unbreak user-manual.
      Optional Tck/Tk: ignore generated files.
      checkout: allow detaching to HEAD even when switching to the tip =
of a branch
      _GIT_INDEX_OUTPUT: allow plumbing to output to an alternative ind=
ex file.
      git-read-tree --index-output=3D<file>
      add_cache_entry(): removal of file foo does not conflict with foo=
/bar
      unpack_trees.c: pass unpack_trees_options structure to keep_entry=
() as well.
      unpack-trees: get rid of *indpos parameter.
      Fix read-tree --prefix=3Ddir/.
      Fix twoway_merge that passed d/f conflict marker to merged_entry(=
).
      Fix switching to a branch with D/F when current branch has file D=
=2E
      rerere: make sorting really stable.
      RPM spec: include git-p4 in the list of all packages.
      Fix dependency of common-cmds.h
      Fix bogus error message from merge-recursive error path
      Propagate cache error internal to refresh_cache() via parameter.
      Rename internal function "add_file_to_cache" in builtin-update-in=
dex.c
      Rename static variable write_index to update_index in builtin-app=
ly.c
      Rename add_file_to_index() to add_file_to_cache()
      git-bisect: modernization
      t6030: add a bit more tests to git-bisect
      git-bisect: allow bisecting with only one bad commit.
      Documentation: tighten dependency for git.{html,txt}
      git-push reports the URL after failing.
      git-push to multiple locations does not stop at the first failure
      A new merge stragety 'subtree'.
      Prepare for 1.5.1.1
      Start 1.5.2 cycle by prepareing RelNotes for it.
      Add Documentation/cmd-list.made to .gitignore
      shortlog -w: make wrap-line behaviour optional.
      t1000: fix case table.
      Treat D/F conflict entry more carefully in unpack-trees.c::threew=
ay_merge()
      merge-recursive: do not barf on "to be removed" entries.
      merge-recursive: handle D/F conflict case more carefully.
      t3030: merge-recursive backend test.
      git-fetch--tool pick-rref
      git-fetch: use fetch--tool pick-rref to avoid local fetch from al=
ternate
      fsck: do not complain on detached HEAD.
      GIT 1.5.1.1
      Add %m to '--pretty=3Dformat:'
      Refactor patch-id filtering out of git-cherry and git-format-patc=
h.
      git-log --cherry-pick A...B
      Documentation: --cherry-pick
      Fix git {log,show,...} --pretty=3Demail
      Do not default to --no-index when given two directories.
      Add basic infrastructure to assign attributes to paths
      Define 'crlf' attribute.
      Teach 'diff' about 'diff' attribute.
      Fix 'crlf' attribute semantics.
      Fix 'diff' attribute semantics.
      Makefile: add patch-ids.h back in.
      attribute macro support
      Define a built-in attribute macro "binary".
      Change attribute negation marker from '!' to '-'.
      send-email: do not leave an empty CC: line if no cc is present.
      Make sure quickfetch is not fooled with a previous, incomplete fe=
tch.
      Allow more than true/false to attributes.
      merge-recursive: separate out xdl_merge() interface.
      git-gui: Honor TCLTK_PATH if supplied
      Allow specifying specialized merge-backend per path.
      Add a demonstration/test of customized merge.
      Start preparing for 1.5.1.2
      Update draft release notes for 1.5.2 with accumulated changes.
      Custom low-level merge driver support.
      Allow the default low-level merge driver to be configured.
      Custom low-level merge driver: change the configuration scheme.
      Allow low-level driver to specify different behaviour during inte=
rnal merge.
      Fix funny types used in attribute value representation
      Counto-fix in merge-recursive
      Simplify code to find recursive merge driver.
      Documentation: support manual section (5) - file formats.
      Update 'crlf' attribute semantics.
      Document gitattributes(5)
      git-add -u: match the index with working tree.
      git-clone: fix dumb protocol transport to clone from pack-pruned =
ref
      Fix bogus linked-list management for user defined merge drivers.
      convert.c: restructure the attribute checking part.
      lockfile: record the primary process.
      GIT 1.5.1.2
      Update documentation links to point at v1.5.1.2
      Documentation/Makefile: fix section (5) installation
      Update draft release notes for v1.5.2
      pack-objects: quickfix for permission modes.
      Fix 'quickfix' on pack-objects.
      Update tests not to assume that generated packfiles are writable.
      pack-objects: make generated packfile read-only
      Support 'diff=3Dpgm' attribute
      Move index-related variables into a structure.
      Make read-cache.c "the_index" free.
      Document "diff=3Ddriver" attribute
      t5302: avoid using tail -c
      t6030: grab commit object name as we go
      Build RPM with ETC_GITCONFIG=3D/etc/gitconfig
      Diff between two blobs should take mode changes into account now.
      t/test-lib.sh: Protect ourselves from common misconfiguration
      gitattributes documentation: clarify overriding
      applymbox & quiltimport: typofix.
      Add 'ident' conversion.
      Add 'filter' attribute and external filter driver definition.
      Add --date=3D{local,relative,default}
      Start preparing for 1.5.1.3
      Do not barf on too long action description
      Update .mailmap with "Michael"
      Fix import-tars fix.
      blame -s: suppress author name and time.
      Split out mailmap handling out of shortlog
      Apply mailmap in git-blame output.
      Make macros to prevent double-inclusion in headers consistent.
      Make sure test-genrandom and test-chmtime are builtas part of the=
 main build.
      Fix symlink handling in git-svn, related to PerlIO
      GIT v1.5.1.3
      GIT v1.5.2-rc1
      blame: use .mailmap unconditionally
      diff.c: fix "size cache" handling.
      blame: Notice a wholesale incorporation of an existing file.
      blame: -C -C -C
      Add test for blame corner cases.
      GIT v1.5.2-rc2
      diff: release blobs after generating textual diff.
      diff.c: do not use a separate "size cache".
      diff -M: release the preimage candidate blobs after rename detect=
ion.
      diff -S: release the image after looking for needle in it
      GIT v1.5.1.4
      Update documentation links to point at 1.5.1.4
      t9400: skip cvsserver test if Perl SQLite interface is unavailabl=
e
      git-clone: don't get fooled by $PWD
      .mailmap: add some aliases
      GIT v1.5.2-rc3
      Minor copyediting on Release Notes for 1.5.2
      Add has_symlink_leading_path() function.
      apply: do not get confused by symlinks in the middle
      read-tree -m -u: avoid getting confused by intermediate symlinks.
      checkout: allow detaching to HEAD even when switching to the tip =
of a branch
      git-config: do not forget seeing "a.b.var" means we are out of "a=
=2Evar" section.
      Link to HTML version of external doc if available
      Fix git-clone buglet for remote case.
      Prepare for 1.5.1.5 Release Notes
      gitweb: fix another use of undefined value
      GIT v1.5.1.5
      Add link to 1.5.1.5 release notes.
      Documentation/git.txt: Update links to older documentation pages.
      GIT 1.5.1.6
      git-cvsserver: exit with 1 upon "I HATE YOU"
      GIT 1.5.2

Junio Hamano (1):
      t9400: Use the repository config and nothing else.

Karl Hasselstr=C3=B6m (2):
      Fix markup in git-svn man page
      Add --no-rebase option to git-svn dcommit

Lars Hjemli (3):
      rename_ref(): only print a warning when config-file update fails
      Make builtin-branch.c handle the git config file
      git-archive: don't die when repository uses subprojects

Linus Torvalds (26):
      Optimize directory listing with pathspec limiter.
      diff-lib: use ce_mode_from_stat() rather than messing with modes =
manually
      Avoid overflowing name buffer in deep directory structures
      Add 'resolve_gitlink_ref()' helper function
      Add "S_IFDIRLNK" file mode infrastructure for git links
      Teach "fsck" not to follow subproject links
      Teach core object handling functions about gitlinks
      Fix thinko in subproject entry sorting
      Teach directory traversal about subprojects
      Teach git-update-index about gitlinks
      Don't show gitlink directories when we want "other" files
      Teach git list-objects logic not to follow gitlinks
      Teach "git-read-tree -u" to check out submodules as a directory
      Fix gitlink index entry filesystem matching
      Teach git list-objects logic to not follow gitlinks
      Teach "git-read-tree -u" to check out submodules as a directory
      git-quiltimport complaining yet still working
      Fix some "git ls-files -o" fallout from gitlinks
      Expose subprojects as special files to "git diff" machinery
      Add a generic "object decorator" interface, and make object refs =
use it
      Add support for "commit name decorations" to log family of comman=
ds
      Use proper object allocators for unknown object nodes too
      Clean up object creation to use more common code
      Fix working directory errno handling when unlinking a directory
      Fix a copy-n-paste bug in the object decorator code.
      Fix --boundary output

Luiz Fernando N. Capitulino (7):
      ident.c: Use const qualifier for 'struct passwd' parameters
      ident.c: Use size_t (instead of int) to store sizes
      remove_subtree(): Use strerror() when possible
      entry.c: Use const qualifier for 'struct checkout' parameters
      read_cache_from(): small simplification
      core-tutorial: minor fixes
      init_buffer(): Kill buf pointer

Marco Costalba (1):
      Fix an unmatched comment end in arm/sha1_arm.S

Martin Koegler (7):
      gitweb: Show "no difference" message for empty diff
      Add S_IFINVALID mode
      add get_sha1_with_mode
      add add_object_array_with_mode
      store mode in rev_list, if <tree>:<filename> syntax is used
      use mode of the tree in git-diff, if <tree>:<file> syntax is used
      Fix compilation of test-delta

Matthias Kestenholz (2):
      Documentation: Added [verse] to SYNOPSIS where necessary
      Documentation: Reformatted SYNOPSIS for several commands

Matthias Lederhofer (1):
      handle_options in git wrapper miscounts the options it handled.

Matthieu Castet (1):
      Remove stale non-static-inline prototype for tree_entry_extract()

Matthieu Moy (2):
      Document git add -u introduced earlier.
      Added a reference to git-add in the documentation for git-update-=
index

Michael Hendricks (3):
      Document 'git-log --decorate'
      git-send-email: allow leading white space on mutt aliases
      Document core.excludesfile for git-add

Michael S. Tsirkin (1):
      Display the subject of the commit just made.

Michael Spang (4):
      git-blame: Fix overrun in fake_working_tree_commit()
      dir.c: Omit non-excluded directories with dir->show_ignored
      t7300: Basic tests for git-clean
      Fix minor documentation errors

Michele Ballabio (1):
      git shortlog documentation: add long options and fix a typo

Nicolas Pitre (33):
      clean up and optimize nth_packed_object_sha1() usage
      get rid of num_packed_objects()
      make overflow test on delta base offset work regardless of variab=
le size
      add overflow tests on pack offset variables
      compute a CRC32 for each object as stored in a pack
      compute object CRC32 with index-pack
      pack-objects: learn about pack index version 2
      index-pack: learn about pack index version 2
      sha1_file.c: learn about index version 2
      show-index.c: learn about index v2
      pack-redundant.c: learn about index v2
      allow forcing index v2 and 64-bit offset treshold
      validate reused pack data with CRC when possible
      simple random data generator for tests
      use test-genrandom in tests instead of /dev/urandom
      tests for various pack index features
      clean up add_object_entry()
      pack-objects: optimize preferred base handling a bit
      pack-objects: equal objects in size should delta against newer ob=
jects
      pack-objects: rework check_delta_limit usage
      pack-objects: clean up list sorting
      pack-objects: get rid of reuse_cached_pack
      pack-objects: get rid of create_final_object_list()
      pack-objects: make in_pack_header_size a variable of its own
      add get_size_from_delta()
      pack-objects: better check_object() performances
      pack-objects: remove obsolete comments
      document --index-version for index-pack and pack-objects
      common progress display support
      make progress "title" part of the common progress interface
      provide a facility for "delayed" progress reporting
      delay progress display when checking out files
      add file checkout progress

OGAWA Hirofumi (1):
      git-fetch: Fix "argument list too long"

Paul Mackerras (1):
      gitk: Allow user to choose whether to see the diff, old file, or =
new file

Petr Baudis (7):
      Git.pm: config_boolean() -> config_bool()
      gitweb: Do not use absolute font sizes
      gitweb: Normalize searchbar font size
      gitweb: Add support for grep searches
      gitweb: Allow arbitrary strings to be dug with pickaxe
      Documentation: git-rev-list's "patterns"
      gitweb: Remove redundant $searchtype setup

Quy Tonthat (4):
      Add howto files to rpm packages.
      Added new git-gui library files to rpm spec
      RPM spec: include files in technical/ to package.
      Documentation/branch: fix small typo in -D example

Ren=C3=A9 Scharfe (3):
      Revert "builtin-archive: use RUN_SETUP"
      git-archive: make tar the default format
      git-archive: convert archive entries like checkouts do

Richard P. Curnow (2):
      Fix documentation of tag in git-fast-import.txt
      Fix documentation of tag in git-fast-import.txt

Robin H. Johnson (12):
      Add custom subject prefix support to format-patch (take 3)
      Add testcase for format-patch --subject-prefix (take 3)
      Document --dry-run parameter to send-email.
      Prefix Dry- to the message status to denote dry-runs.
      Debugging cleanup improvements
      Change the scope of the $cc variable as it is not needed outside =
of send_message.
      Perform correct quoting of recipient names.
      Validate @recipients before using it for sendmail and Net::SMTP.
      Ensure clean addresses are always used with Net::SMTP
      Allow users to optionally specify their envelope sender.
      Document --dry-run and envelope-sender for git-send-email.
      Sanitize @to recipients.

Sam Vilain (1):
      git-tar-tree: complete deprecation conversion message

Sami Farin (1):
      fast-import: size_t vs ssize_t

Shawn O. Pearce (50):
      Always bind the return key to the default button
      git-gui: Brown paper bag fix division by 0 in blame
      Fix lost-found to show commits only referenced by reflogs
      Honor -p<n> when applying git diffs
      Don't yap about merge-subtree during make
      git-gui: Display the directory basename in the title
      Revert "Allow wish interpreter to be defined with TCLTK_PATH"
      Contribute a fairly paranoid update hook
      Kill the useless progress meter in merge-recursive
      Don't repack existing objects in fast-import
      Cleanup variables in cat-file
      git-gui: Correctly handle UTF-8 encoded commit messages
      Actually handle some-low memory conditions
      Don't allow empty pathnames in fast-import
      Catch empty pathnames in trees during fsck
      git-gui: Allow spaces in path to 'wish'
      git-gui: Include the subject in the status bar after commit
      git-gui: Warn users before making an octopus merge
      git-gui: Correct line wrapping for too many branch message
      git-gui: Cleanup common font handling for font_ui
      git-gui: Use option database defaults to set the font
      git-gui: Refactor to use our git proc more often
      git-gui: Track our own embedded values and rebuild when they chan=
ge
      Reuse fixup_pack_header_footer in index-pack
      Don't use seq in tests, not everyone has it
      Improve request-pull to handle non-rebased branches
      Properly handle '0' filenames in import-tars
      git-gui: Refactor into multiple files to save my sanity
      git-gui: Move console procs into their own namespace
      git-gui: Allow vi keys to scroll the diff/blame regions
      git-gui: Move merge support into a namespace
      git-gui: Show all possible branches for merge
      git-gui: Include commit id/subject in merge choices
      git-gui: Use vi-like keys in merge dialog
      Remove duplicate exports from Makefile
      git-gui: Allow shift-{k,j} to select a range of branches to merge
      git-gui: Define a simple class/method system
      git-gui: Convert browser, console to "class" format
      git-gui: Don't attempt to inline array reads in methods
      git-gui: Convert blame to the "class" way of doing things
      git-gui: Use prefix if blame is run in a subdirectory
      git-gui: Smarter command line parsing for browser, blame
      git-gui: Generate blame on uncommitted working tree file
      git-gui: Cleanup minor nits in blame code
      git-gui: Format author/committer times in ISO format
      Use .git/MERGE_MSG in cherry-pick/revert
      git-gui: Paperbag fix blame in subdirectory
      git gui 0.7.0
      Correct error message in revert/cherry-pick
      git-gui: Gracefully handle bad TCL_PATH at compile time

Steffen Prohaska (4):
      tiny fix in documentation of git-clone
      git-config: test for 'do not forget "a.b.var" ends "a.var" sectio=
n'.
      Optimized cvsexportcommit: calling 'cvs status' once instead of o=
nce per touched file.
      Fixed link in user-manual

Steven Grimm (3):
      Add --quiet option to suppress output of "rm" commands for remove=
d files.
      git-rm: Trivial fix for a comment typo.
      Add --ignore-unmatch option to exit with zero status when no file=
s are removed.

Theodore Ts'o (2):
      Add pack.depth option to git-pack-objects.
      Increase pack.depth default to 50

Tomash Brechko (1):
      cvsexportcommit -p : fix the usage of git-apply -C.

Uwe Kleine-K=C3=B6nig (1):
      fix importing of subversion tars

Ville Skytt=C3=A4 (1):
      DESTDIR support for git/contrib/emacs

Xavier Maillard (2):
      git-blame.el: separate git-blame-mode to ease maintenance
      git-blame.el: pick a set of random colors for each git-blame turn

YOSHIFUJI Hideaki (1):
      Avoid composing too long "References" header.
