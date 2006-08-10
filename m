From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Wed, 09 Aug 2006 18:29:30 -0700
Message-ID: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 03:29:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAzMg-0006W1-Ce
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 03:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbWHJB3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 21:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbWHJB3e
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 21:29:34 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:1417 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030558AbWHJB3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 21:29:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810012932.PQDJ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 21:29:32 -0400
To: git@vger.kernel.org
X-maint-at: a0764cb838c2f1885fb58ca794c21523fb05c825
X-master-at: 943d5b73e2adf3cd0d3f72c9a06c75681a4ea3ca
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25151>

GIT 1.4.2-rc4

It's been a week since -rc3, so here it is.  The changes are
really small fixes and nothing else.  Let's hope I can tag the
real 1.4.2 this weekend.

* The 'master' branch has these since the last announcement;
  these are all in 1.4.2-rc4:

   Jeff King:
      git-push: allow pushing from subdirectories

   Johannes Schindelin:
      Fix crash when GIT_DIR is invalid

   Jonas Fonseca:
      Update git-init-db(1) and documentation of core.sharedRepository

   Junio C Hamano:
      Cygwin needs NO_C99_FORMAT???
      Makefile: Cygwin does not seem to need NO_STRLCPY
      Fix "grep -w"
      debugging: XMALLOC_POISON
      builtin-mv: fix use of uninitialized memory.
      GIT-VERSION-GEN: adjust for ancient git
      Documentation: git-status takes the same options as git-commit
      Fix tutorial-2.html
      check return value from diff_setup_done()
      find_unique_abbrev() with len=0 should not abbreviate
      make --find-copies-harder imply -C
      allow diff.renamelimit to be set regardless of -M/-C

   Michael Krelin:
      handle https:// protocol in git-clone

   Ramsay Jones:
      Allow config file to specify Signed-off-by identity in format-patch.
      commit walkers: setup_ident() to record correct committer in ref-log.

   Ryan Anderson:
      log-tree: show_log() should respect the setting of diffopt->line_termination
      annotate: Fix bug when parsing merges with differing real and logical parents.


* The 'next' branch, in addition, has these.

  = To graduate immediately after 1.4.2 happens:

  - Jakub Narebski's autoconf stuff acquired a bit more
    clean-ups and new detections since the last announcement.

  - A new merge strategy, merge-recur, which is a rewrite of
    merge-recursive in C, by Johannes and Alex.

  - More commands are made built-in by Matthias Kestenholz, and
    I cleaned up the build procedure for built-ins a bit.

  - Matthias Lederhofer introduced $GIT_PAGER environment
    variable that can specify a different pager from $PAGER.

  - Ramsay Jones has one header fix to add _GNU_SOURCE, which
    helps things to compile in his environment.  This was
    confirmed to fix a similar problem on an ancient version of
    one distribution.

  - Timo Hirvonen made the parameter parsing of diff family
    saner some time ago.  Remaining two minor changes will
    graduate to "master" after 1.4.2:

    * --name-only, --name-status, --check and -s are mutually exclusive

    * Remove awkward compatibility warts "-s".  Now -s means "do
      not output diff" everywhere, including git-diff-files.

  - Johannes made http-push avoid fork() by calling
    merge_bases() directly.

  - MAX_NEEDS and MAX_HAS limitation in upload-pack has been
    lifted.

  - pack-objects can copy a non-delta representation of a object
    with the new style header straight into packs.

  - Paul Mackerras has a few gitk updates.


  * Hopefully not too long after 1.4.2:

  - A big gitweb clean-up series by Jakub Narebski, with help
    from Jeff King, Matthias Lederhofer and Martin Waitz to make
    run-time and build-time configuration easier.

    Quite a lot of clean-ups and enhancements by Jakub and Luben
    Tuikov are queued, and with the proposed function renames,
    it may be stable enough to start seriously testing soon
    after 1.4.2 happens.

  - New style loose objects, which use the same header format as
    in-pack objects, can be copied straight into packs when not
    deltified.  I am hoping that we can make the new-style loose
    objects the default in 10 to 12 weeks to give everybody time
    to update to 1.4 series.

  = Graduation schedule unknown:

  - Not-universally-liked Git.pm by Pasky with help from Dennis
    Stosberg, Johannes, Pavel Roskin and others.  One drawback
    is this pretty much makes Perl scripts that use Git.pm
    unusable with ActiveState right now.  No changes since the
    last announcement.

  - Linus worries that Racy-git avoidance code leaves racily-clean
    index entries forever and hurts performance, and I did some
    tweaks.  First we need to verify performance is actually
    harmed and by how much to see if this is needed.


* The 'pu' branch, in addition, has these.

  - An update to upload-pack to prevent it from going all the
    way back when the downloader has more roots than it.  Needs
    testing and comments.

  - Johannes has a new diff option --color-words to use color to
    squash word differences into single line output.

    I do not feel much need for this stuff, and the change is
    rather intrusive, so I am tempted to drop it.

  - A new merge strategy, merge-rename, which is still a
    work-in-progress to handle renames in read-tree 3-way
    merge.  Judging from the way Johannes's merge-recur is
    making progress, I may want to drop this.
