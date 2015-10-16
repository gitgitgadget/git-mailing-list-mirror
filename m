From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.6.2
Date: Fri, 16 Oct 2015 15:10:57 -0700
Message-ID: <xmqqoafycvm6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Oct 17 00:11:14 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ZnDDU-0000wG-MD
	for glk-linux-kernel-3@plane.gmane.org; Sat, 17 Oct 2015 00:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbbJPWLD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 16 Oct 2015 18:11:03 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35401 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbbJPWK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Oct 2015 18:10:59 -0400
Received: by payp3 with SMTP id p3so735430pay.2;
        Fri, 16 Oct 2015 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=oMxagKYpkxj9jT1yn0XIu5Ddkea0iG0zwlyKb8DWkr4=;
        b=pr+r9n7uxWzAdF+nknuFqo0Nj0N+tgYkKX1xG5YB2sZEKFctv1srKEiEzfdUlGWens
         lCn39UD4I6dIfvmnlwBkqTstIzvqEeQ48YviiR9bov6c590Lz6aINS/KFk+/EwOQGIn6
         t6lL+B3tzr1egZ02u+F0NDVXr2huUpvoyE9gHbVQfTi/dsyZA6+9vNT7v/Nyyd3fj93c
         r4XCsPrXQ2xeaKyqlzm30Hb4X1kmLmwg5eZOHFZHyyGFyIBH5pT5ECo3on3IUPB/84f6
         IZcQlEVIOvkkk0A77tRRzO1r+5xvoN4CVVcJufA0k9FA6/56dSuPdcIXdQ5f99x7uhYG
         OJ4A==
X-Received: by 10.68.105.193 with SMTP id go1mr18934579pbb.59.1445033459138;
        Fri, 16 Oct 2015 15:10:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b1ee:7c8f:ac32:e39f])
        by smtp.gmail.com with ESMTPSA id we9sm23144452pab.3.2015.10.16.15.10.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 15:10:58 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279774>

The latest maintenance release Git v2.6.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.6.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.6.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.6.1
------------------

 * There were some classes of errors that "git fsck" diagnosed to its
   standard error that did not cause it to exit with non-zero status.

 * A test script for the HTTP service had a timing dependent bug,
   which was fixed.

 * Performance-measurement tests did not work without an installed Git.

 * On a case insensitive filesystems, setting GIT_WORK_TREE variable
   using a random cases that does not agree with what the filesystem
   thinks confused Git that it wasn't inside the working tree.

 * When "git am" was rewritten as a built-in, it stopped paying
   attention to user.signingkey, which was fixed.

 * After "git checkout --detach", "git status" reported a fairly
   useless "HEAD detached at HEAD", instead of saying at which exact
   commit.

 * "git rebase -i" had a minor regression recently, which stopped
   considering a line that begins with an indented '#' in its insn
   sheet not a comment, which is now fixed.

 * Description of the "log.follow" configuration variable in "git log"
   documentation is now also copied to "git config" documentation.

 * Allocation related functions and stdio are unsafe things to call
   inside a signal handler, and indeed killing the pager can cause
   glibc to deadlock waiting on allocation mutex as our signal handler
   tries to free() some data structures in wait_for_pager().  Reduce
   these unsafe calls.

 * The way how --ref/--notes to specify the notes tree reference are
   DWIMmed was not clearly documented.

 * Customization to change the behaviour with "make -w" and "make -s"
   in our Makefile was broken when they were used together.

 * The Makefile always runs the library archiver with hardcoded "crs"
   options, which was inconvenient for exotic platforms on which
   people want to use programs with totally different set of command
   line options.

 * The ssh transport, just like any other transport over the network,
   did not clear GIT_* environment variables, but it is possible to
   use SendEnv and AcceptEnv to leak them to the remote invocation of
   Git, which is not a good idea at all.  Explicitly clear them just
   like we do for the local transport.

 * "git blame --first-parent v1.0..v2.0" was not rejected but did not
   limit the blame to commits on the first parent chain.

 * Very small number of options take a parameter that is optional
   (which is not a great UI element as they can only appear at the end
   of the command line).  Add notice to documentation of each and
   every one of them.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.6.1 are as follows:

Alex Henrie (2):
      merge: grammofix in please-commit-before-merge message
      pull: enclose <options> in brackets in the usage string

Christian Couder (2):
      quote: fix broken sq_quote_buf() related comment
      quote: move comment before sq_quote_buf()

Eric N. Vander Weele (1):
      log: Update log.follow doc and add to config.txt

Jacob Keller (1):
      notes: correct documentation of DWIMery for notes references

Jeff King (3):
      git_connect: clear GIT_* environment for ssh
      git_connect: clarify conn->use_shell flag
      blame: handle --first-parent

Johannes Schindelin (1):
      setup: fix "inside work tree" detection on case-insensitive files=
ystems

John Keeping (2):
      Makefile: fix MAKEFLAGS tests with multiple flags
      Documentation: fix section header mark-up

Junio C Hamano (3):
      Makefile: allow $(ARFLAGS) specified from the command line
      fsck: exit with non-zero when problems are found
      Git 2.6.2

Matthieu Moy (7):
      Documentation: use 'keyid' consistently, not 'key-id'
      Documentation/grep: fix documentation of -O
      Documentation: explain optional arguments better
      t3203: test 'detached at' after checkout --detach
      status: don't say 'HEAD detached at HEAD'
      rebase-i: explicitly accept tab as separator in commands
      rebase-i: loosen over-eager check_bad_cmd check

Michael J Gruber (1):
      t2026: rename worktree prune test

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      ls-remote.txt: delete unsupported option

Renee Margaret McConahy (1):
      am: configure gpg at startup

Stephan Beyer (2):
      t5561: get rid of racy appending to logfile
      t/perf: make runner work even if Git is not installed

Takashi Iwai (1):
      pager: don't use unsafe functions in signal handlers

Tobias Klauser (2):
      connect: fix typo in result string of prot_name()
      Documentation/interpret-trailers: Grammar fix
