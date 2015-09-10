From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.5.2, v2.4.9, v2.3.9 and v2.2.3
Date: Thu, 10 Sep 2015 13:24:52 -0700
Message-ID: <xmqqa8su2faj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Sep 10 22:25:11 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Za8P6-0007hS-2t
	for glk-linux-kernel-3@plane.gmane.org; Thu, 10 Sep 2015 22:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbbIJUY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 10 Sep 2015 16:24:57 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36595 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbbIJUYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Sep 2015 16:24:54 -0400
Received: by padhk3 with SMTP id hk3so52142798pad.3;
        Thu, 10 Sep 2015 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=wLDEbbx3WxJYXuq6SUcMj+1dyiJj13htpZUCg8FhV7w=;
        b=n4AzINJafTNWpA05j7v8/56FIV2kEsVCUiJwfrVQwpU0tiNX0DBHkjp6/wnkXlpccR
         43ndnUpsejmaGvJFkjT0ULleUISZrROGTW7o7+rnQfwmfwAzNBDUi7DQGAiOwNbji5KZ
         bm2tyU8DQ2WQzRo2T2uYTLz2ad3Eyn/M+7nZeC819LZTE6keju/1MQVPUjvuXAxODLIn
         uh2SzECpDr0hXStgiD15b9llYFldPfCTzo0VTLcNRVTqj5XaOBa0/GQI0ri269Um1j62
         4heEmZa2/7wYoUV2DRcfewXPdPm0+5R2gsiMzKsquRVo9A9X7OkgEfxM/Da+tdXOHIod
         2LkA==
X-Received: by 10.66.255.42 with SMTP id an10mr76441992pad.107.1441916694274;
        Thu, 10 Sep 2015 13:24:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id fk8sm13673253pab.33.2015.09.10.13.24.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 13:24:53 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277634>

The latest maintenance release Git v2.5.2 is now available at the
usual places, together with updates to older maintenance tracks,
v2.4.9, v2.3.9 and v2.2.3.  These updates to older tracks are to
plug buffer overflows due to fixed-sized buffers used to store
pathnames in a handful of codepaths (kudos to Peff).

The maintenance release 2.5.2 for the current maintenance track also
contains other fixes that was recently made on the 'master' front.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.5.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.5.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.5.1
------------------

 * "git init empty && git -C empty log" said "bad default revision 'HEA=
D'",
   which was found to be a bit confusing to new users.

 * The "interpret-trailers" helper mistook a multi-paragraph title of
   a commit log message with a colon in it as the end of the trailer
   block.

 * When re-priming the cache-tree opportunistically while committing
   the in-core index as-is, we mistakenly invalidated the in-core
   index too aggressively, causing the experimental split-index code
   to unnecessarily rewrite the on-disk index file(s).

 * "git archive" did not use zip64 extension when creating an archive
   with more than 64k entries, which nobody should need, right ;-)?

 * The code in "multiple-worktree" support that attempted to recover
   from an inconsistent state updated an incorrect file.

 * "git rev-list" does not take "--notes" option, but did not complain
   when one is given.

 * Because the configuration system does not allow "alias.0foo" and
   "pager.0foo" as the configuration key, the user cannot use '0foo'
   as a custom command name anyway, but "git 0foo" tried to look these
   keys up and emitted useless warnings before saying '0foo is not a
   git command'.  These warning messages have been squelched.

 * We recently rewrote one of the build scripts in Perl, which made it
   necessary to have Perl to build Git.  Reduced Perl dependency by
   rewriting it again using sed.

 * t1509 test that requires a dedicated VM environment had some
   bitrot, which has been corrected.

 * strbuf_read() used to have one extra iteration (and an unnecessary
   strbuf_grow() of 8kB), which was eliminated.

 * The codepath to produce error messages had a hard-coded limit to
   the size of the message, primarily to avoid memory allocation while
   calling die().

 * When trying to see that an object does not exist, a state errno
   leaked from our "first try to open a packfile with O_NOATIME and
   then if it fails retry without it" logic on a system that refuses
   O_NOATIME.  This confused us and caused us to die, saying that the
   packfile is unreadable, when we should have just reported that the
   object does not exist in that packfile to the caller.

 * An off-by-one error made "git remote" to mishandle a remote with a
   single letter nickname.

 * A handful of codepaths that used to use fixed-sized arrays to hold
   pathnames have been corrected to use strbuf and other mechanisms to
   allow longer pathnames without fearing overflows.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.5.1 are as follows:

Andreas Schwab (1):
      Documentation/config: fix inconsistent label on gc.*.reflogExpire=
Unreachable

Christian Couder (3):
      trailer: ignore first line of message
      trailer: retitle a test and correct an in-comment message
      trailer: support multiline title

Clemens Buchacher (1):
      git_open_noatime: return with errno=3D0 on success

David Turner (1):
      commit: don't rewrite shared index unnecessarily

Eric Sunshine (1):
      generate-cmdlist: re-implement as shell script

Erik Elfstr=C3=B6m (1):
      t7300: fix broken && chains

Jeff King (9):
      vreportf: report to arbitrary filehandles
      vreportf: avoid intermediate buffer
      config: silence warnings for command names with invalid keys
      rev-list: make it obvious that we do not support notes
      log: diagnose empty HEAD more clearly
      verify_absent: allow filenames longer than PATH_MAX
      notes: use a strbuf in add_non_note
      read_info_alternates: handle paths larger than PATH_MAX
      show-branch: use a strbuf for reflog descriptions

Jim Hill (1):
      strbuf_read(): skip unnecessary strbuf_grow() at eof

Johannes Sixt (1):
      t2019: skip test requiring '*' in a file name non Windows

Junio C Hamano (5):
      ps_matched: xcalloc() takes nmemb and then element size
      Git 2.2.3
      Git 2.3.9
      Git 2.4.9
      Git 2.5.2

Michael Haggerty (4):
      get_remote_group(): handle remotes with single-character names
      get_remote_group(): rename local variable "space" to "wordlen"
      get_remote_group(): eliminate superfluous call to strcspn()
      get_remote_group(): use skip_prefix()

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      setup: update the right file in multiple checkouts

Patrick Steinhardt (2):
      tests: fix broken && chains in t1509-root-worktree
      tests: fix cleanup after tests in t1509-root-worktree

Philip Oakley (1):
      po/README: Update directions for l10n contributors

Ren=C3=A9 Scharfe (3):
      t5004: test ZIP archives with many entries
      archive-zip: use a local variable to store the creator version
      archive-zip: support more than 65535 entries

SZEDER G=C3=A1bor (2):
      t3020: fix typo in test description
      wt-status: move #include "pathspec.h" to the header

Sven Strickroth (1):
      config: close config file handle in case of error
