From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.5
Date: Thu, 25 Jun 2015 13:19:21 -0700
Message-ID: <xmqqsi9fy20m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jun 25 22:19:42 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Z8Dca-0000c7-Cb
	for glk-linux-kernel-3@plane.gmane.org; Thu, 25 Jun 2015 22:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbbFYUTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 25 Jun 2015 16:19:34 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38125 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbFYUTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Jun 2015 16:19:24 -0400
Received: by igin14 with SMTP id n14so68302igi.1;
        Thu, 25 Jun 2015 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=cTW9ym3UeqYAL7OOx6Rwwo6Sj7dl3L1OlXgUGDWOFGc=;
        b=wu57SlFXJjLNH2FcfuOmPlQG8jNy987POteOY65qPmVDthTFJisEWYcvp6W0eaovhM
         YIcCBzTBWjYMoo6Fzb2a+GazdB4Y+wpSyQ4YNFDq0mnQXwZ1e7M3ceWQ5WQzU+MsczdS
         KiuCo4/WSRIdRKjswC8NyHjkGPbCtzXZr0vGZXou9/kZjvmD8fFdK4101d1UPM36u/wR
         BOE4QhjkUcjZMw7eukUbEQUnNhCpAkldyp72JjN2DmQdzcrfLeKlw74q9yVQNr/Xjeya
         +60p+Se3BmOcv0ptPJjAaZY6ZIe9+QSy2VkXKDnIUxS7mdZFRVn4AG8mDkIDt27hCVOe
         j1JA==
X-Received: by 10.50.43.131 with SMTP id w3mr6499298igl.8.1435263563408;
        Thu, 25 Jun 2015 13:19:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id p193sm20278116ioe.34.2015.06.25.13.19.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 13:19:22 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272718>

The latest maintenance release Git v2.4.5 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.4.5'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.4.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.4.4
------------------

 * The setup code used to die when core.bare and core.worktree are set
   inconsistently, even for commands that do not need working tree.

 * There was a dead code that used to handle "git pull --tags" and
   show special-cased error message, which was made irrelevant when
   the semantics of the option changed back in Git 1.9 days.

 * "color.diff.plain" was a misnomer; give it 'color.diff.context' as
   a more logical synonym.

 * The configuration reader/writer uses mmap(2) interface to access
   the files; when we find a directory, it barfed with "Out of memory?"=
=2E

 * Recent "git prune" traverses young unreachable objects to safekeep
   old objects in the reachability chain from them, which sometimes
   showed unnecessary error messages that are alarming.

 * "git rebase -i" fired post-rewrite hook when it shouldn't (namely,
   when it was told to stop sequencing with 'exec' insn).

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.4.4 are as follows:

Jeff King (13):
      diff: accept color.diff.context as a synonym for "plain"
      diff.h: rename DIFF_PLAIN color slot to DIFF_CONTEXT
      read-cache.c: drop PROT_WRITE from mmap of index
      config.c: fix mmap leak when writing config
      config.c: avoid xmmap error messages
      config.c: rewrite ENODEV into EISDIR when mmap fails
      Makefile: drop dependency between git-instaweb and gitweb
      Makefile: avoid timestamp updates to GIT-BUILD-OPTIONS
      Makefile: silence perl/PM.stamp recipe
      setup_git_directory: delay core.bare/core.worktree errors
      add quieter versions of parse_{tree,commit}
      silence broken link warnings with revs->ignore_missing_links
      suppress errors on missing UNINTERESTING links

Junio C Hamano (3):
      t5407: use <<- to align the expected output
      xmmap(): drop "Out of memory?"
      Git 2.4.5

Matthieu Moy (2):
      rebase -i: demonstrate incorrect behavior of post-rewrite
      rebase -i: fix post-rewrite hook with failed exec command

Paul Tan (1):
      pull: remove --tags error in no merge candidates case

SZEDER G=C3=A1bor (1):
      Documentation: include 'merge.branchdesc' for merge and config as=
 well

Stefan Beller (1):
      Documentation/technical/pack-protocol: mention http as possible p=
rotocol
