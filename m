From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sun, 06 May 2007 01:53:19 -0700
Message-ID: <7vejlucozk.fsf@assigned-by-dhcp.cox.net>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net>
	<1177662893872-git-send-email-junkio@cox.net>
	<7v4pmzdo9o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 10:53:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkcUg-0001qa-1A
	for gcvg-git@gmane.org; Sun, 06 May 2007 10:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbXEFIxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 04:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933368AbXEFIxY
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 04:53:24 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37980 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbXEFIxV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 04:53:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506085321.ZBRK24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 04:53:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vktL1W00E1kojtg0000000; Sun, 06 May 2007 04:53:21 -0400
X-maint-at: e102d4353d7cfd69a597cd976eabdcb74641be69
X-master-at: 9159afbfce955db86373dab95b5f8e31fb763dae
In-Reply-To: <7v4pmzdo9o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 29 Apr 2007 11:33:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46320>

Master is at v1.5.2-rc2; maint is probably ready to produce
v1.5.1.4, but not tonight.

Here are two draft release notes, followed by the usual "What's in"
summaries.

----------------------------------------------------------------

GIT v1.5.1.4 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.1.3
--------------------

* Bugfixes

  - "git-http-fetch" did not work around a bug in libcurl
    earlier than 7.16 (curl_multi_remove_handle() was broken).

  - "git cvsserver" handles a file that was once removed and
    then added again correctly.

  - import-tars script (in contrib/) handles GNU tar archives
    that contain pathnames longer than 100 bytes (long-link
    extension) correctly.

  - xdelta test program did not build correctly.

  - gitweb sometimes tried incorrectly to apply function to
    decode utf8 twice, resulting in corrupt output.

  - "git blame -C" mishandled text at the end of a group of
    lines.

  - "git log/rev-list --boundary" did not produce output
    correctly without --left-right option.

----------------------------------------------------------------

GIT v1.5.2 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v1.5.1
--------------------

* Plumbing level subproject support.

  You can include a subdirectory that has an independent git
  repository in your index and tree objects as a
  "subproject".  This plumbing (i.e. "core") level subproject
  support explicitly excludes recursive behaviour.

  The "subproject" entries in the index and trees are
  incompatible with older versions of git.  Experimenting with
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
  with core.autocrlf set), expand and unexpand '$ident$' keyword
  with blob object name, specify a custom 3-way merge driver,
  and specify a custom diff driver.  You can also apply
  arbitrary filter to contents on check-in/check-out codepath
  but this feature is an extremely sharp-edged razor and needs
  to be handled with caution (do not use it unless you
  understand the earlier mailing list discussion on keyward
  expansion).

* The packfile format now optionally suports 64-bit index.

  This release supports the "version 2" format of the .idx
  file.  This is automatically enabled when a huge packfile
  needs more than 32-bit to express offsets of objects in the
  pack

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
    downloading objects unnecessary.

  - "git blame" uses .mailmap to canonicalize the author name
    just like "git shortlog" does.

* Builds

  - git-p4import has never been installed; now there is an
    installation option to do so.

  - gitk and git-gui can be configured out.

  - Generated documentation pages automatically get version
    information from GIT_VERSION

  - Parallel build with "make -j" descending into subdirectory
    was fixed.

* Performance Tweaks

  - Optimized "git-rev-list --bisect" (hence "git-bisect").

  - Optimized "git-add $path" in a large directory, most of
    whose contents are ignored.

  - The recursive merge strategy updated a worktree file that
    was changed identically in two branches, when one of them
    renamed it.  We do not do that when there is no rename, so
    match that behaviour.

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

  [[[jc: I'll probably copy&paste v1.5.1.X release notes here, or
  refer readers to those separate documents.  I haven't decided
  which way I would go, but I am inclined to do the latter.]]]

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

 Alex Riesen (1):
  Small correction in reading of commit headers

 Alexandre Julliard (1):
  http-fetch: Disable use of curl multi support for libcurl < 7.16.

 Arjen Laarhoven (1):
  Document 'opendiff' value in config.txt and git-mergetool.txt

 Bryan Larsen (2):
  Allow PERL_PATH=3D"/usr/bin/env perl"
  posix compatibility for t4200

 Carl Worth (1):
  Mention version 1.5.1 in tutorial and user-manual

 Daniel Barkalow (1):
  Make xstrndup common

 Frank Lichtenheld (1):
  cvsserver: Handle re-added files correctly

 Ismail D=C3=B6nmez (1):
  gitweb: use decode_utf8 directly

 Jakub Narebski (1):
  diff format documentation: describe raw combined diff format

 James Bowes (1):
  Documentation: fix typo in git-remote.txt

 Johannes Schindelin (1):
  Teach import-tars about GNU tar's @LongLink extension.

 Junio C Hamano (4):
  diff.c: fix "size cache" handling.
  blame: Notice a wholesale incorporation of an existing file.
  blame: -C -C -C
  Add test for blame corner cases.

 Karl Hasselstr=C3=B6m (2):
  Fix markup in git-svn man page
  Add --no-rebase option to git-svn dcommit

 Linus Torvalds (1):
  Fix --boundary output

 Martin Koegler (1):
  Fix compilation of test-delta


* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (1):
  Handle return code of parse_commit in revision machinery

 Dana L. How (1):
  Create pack-write.c for common pack writing code

 Jonas Fonseca (1):
  git-tag(1): -v option is a subcommand; fix code block

 Junio C Hamano (2):
  blame: use .mailmap unconditionally
  GIT v1.5.2-rc2

 Shawn O. Pearce (3):
  Reuse fixup_pack_header_footer in index-pack
  Don't use seq in tests, not everyone has it
  Improve request-pull to handle non-rebased branches
