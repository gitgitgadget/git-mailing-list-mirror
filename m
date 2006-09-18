From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 17 Sep 2006 22:33:00 -0700
Message-ID: <7vu035u4c3.fsf@assigned-by-dhcp.cox.net>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 18 07:33:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPBkh-0004UF-QO
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 07:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965400AbWIRFdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 01:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965402AbWIRFdE
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 01:33:04 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38398 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965400AbWIRFdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 01:33:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918053301.LRCO2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 01:33:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PhYo1V00V1kojtg0000000
	Mon, 18 Sep 2006 01:32:48 -0400
To: git@vger.kernel.org
X-maint-at: 883653babd8ee7ea23e6a5c392bb739348b1eb61
X-master-at: 808239a7db1b4c04c5a9edcf9ee33ff33217fad2
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27223>

* The 'maint' branch has this since the last announcement (v1.4.2.1).

   - Liu Yubao fixed duplicate xmalloc in builtin-add.

   - "git-am --skip" incorrectly insisted that its standard
     input to be connected to a tty.  Fixed.


* The 'master' branch has these since the last announcement.

  - http-fetch from a repository that uses alternates to borrow
    from neighbouring repositories were quite broken for some
    time now.  This has been fixed (this fix is also in
    v1.4.2.1).

  - Andy Whitcroft taught send-pack to use git-rev-list --stdin
    so that we can deal with repositories with massive number
    of refs more efficiently.

  - A handful clean-ups, fixes and documentation updates by
    Christian Couder, Dmitry V. Levin, Jonas Fonseca and Linus.

  - Franck Bui-Huu and Rene Scharfe added 'git-archive' command,
    that will eventually supersede 'git-tar-tree' and
    'git-zip-tree'.

    I think zip-tree can be deprecated without hurting too many
    users, judging from its short existence, but I suspect that
    deprecating tar-tree needs to be done very carefully.
    Perhaps we should drop "tar-tree --remote" and "upload-tar",
    but keep tar-tree but make it internally a synonym for
    "archive --format=tar".  We should also update our toplevel
    Makefile to use git-archive.

  - Jakub Narebski continues improving gitweb with help from 
    Martin Waitz, and Matthias Lederhofer.

    We really need some test suites for gitweb.

  - Jeff King rewrote run_status() shell function used in
    git-commit and git-status in C, and made it colorful while
    he was at it.  Johannes Schindelin taught it --untracked.

  - unpack-objects with "-r" now makes the best effort to
    recover objects from a corrupt packfile.

  - apply does not need --binary anymore to take a binary patch.

  - diff --binary does not produce full 40-byte index lines
    unless necessary.

  - pack-objects learned --revs option, which lets it not to
    rely on rev-list.  Instead of taking the list of objects to
    pack from the standard input, it can read the list of rev
    parameters and run rev-list logic internally.

  - rev-list learned --unpacked=<existing pack> option.

  - Linus taught git-grep "-h" option to suppress filename
    output.

  - "git-am --skip" incorrectly insisted that its standard
    input to be connected to a tty.  Fixed.

  - "git-apply" learned to handle --unified=0 patches more
    gracefully by allowing some sanity checks that cannot be
    done with such patches to be disabled.

  - Sasha Khapyorsky noticed that http-fetch commit walker can
    almost deal with ftp:// transport already, and added
    minimum updates to support it.


* The 'next' branch, in addition, has these.

  - Git.pm is on hold, waiting for stripping out Git.xs part before
    going forward.

  - Linus introduced packed refs and taught the core about
    them.  Christian Couder taught git-branch about them and
    Jeff King taught wt-status about it.

    There are still some things that are broken which need to
    be addressed before this series is pushed out to "master".
    I offhand know of these two but there probably are others:

    - "git branch -d" does not work.
    - "git ls-remote rsync://" does not work.

  - An experimental git-for-each-ref command to help language
    bindings to get information on many refs at once.  Hopefully
    Jakub can teach gitweb to use it to speed things up.


* The 'pu' branch, in addition, has these.

  - Jon Loeliger's git-daemon virtual hosting patch; this will be
    dropped and replaced with his updated version.

  - "git log --author=foo", "git log --grep=pattern" support.

  - I haven't started cleaning up the para-walk changes yet; they
    are still in the form of a messy 10-series patchset.  When I
    find time I'd like to rewrite diff-index with it and see how
    well it performs.
