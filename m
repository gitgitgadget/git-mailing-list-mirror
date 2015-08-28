From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.5.1
Date: Fri, 28 Aug 2015 14:12:06 -0700
Message-ID: <xmqqwpwfyv6h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Aug 28 23:12:28 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ZVQwh-0004ps-3m
	for glk-linux-kernel-3@plane.gmane.org; Fri, 28 Aug 2015 23:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbbH1VMK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 28 Aug 2015 17:12:10 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33351 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbH1VMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Aug 2015 17:12:08 -0400
Received: by pacgr6 with SMTP id gr6so675615pac.0;
        Fri, 28 Aug 2015 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=TzDjLH0n+sNRCCjgdSis/xZbiMipASeu3YPD50d3L4I=;
        b=ypNtSFBwPv0jUNIC5z958MOoerzUTjTS9vs1To8iz+DKv5ls0Ue5J1m+QlHhSaJcNt
         4MQn04N8NQqsv+Wr+12XkZQMOm+R0RIPM8eCuqJo559DjejDX1TqSqC2ujFJ533a8rqA
         wQlssKuwIAoTjBlySl11ajhIrLAQ+RDBaEQsdnwci02TcPicO2T9TGCpNsP/zeixxl8r
         veVl5W44Y1LZYH3w4Mb7vvTAbx2f8cDn4X+yP5B1zLfyqaViN2dDEP9XX/LWSfqkObcB
         +IcMa6zmTkiBQ2SS9DtaXDxIEcJ2rRnPDLog4+GDu38yMK+Yb9LQhA8KCHWN9zVO9vtw
         aCzQ==
X-Received: by 10.68.254.69 with SMTP id ag5mr18580085pbd.130.1440796327773;
        Fri, 28 Aug 2015 14:12:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id wj8sm6740262pab.3.2015.08.28.14.12.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 28 Aug 2015 14:12:07 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276761>

The latest maintenance release Git v2.5.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.5.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Note that code.google.com/ has gone into read-only mode and the
branches and tags there will not be updated.

----------------------------------------------------------------

Git v2.5.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.5
----------------

 * Running an aliased command from a subdirectory when the .git thing
   in the working tree is a gitfile pointing elsewhere did not work.

 * Often a fast-import stream builds a new commit on top of the
   previous commit it built, and it often unconditionally emits a
   "from" command to specify the first parent, which can be omitted in
   such a case.  This caused fast-import to forget the tree of the
   previous commit and then re-read it from scratch, which was
   inefficient.  Optimize for this common case.

 * The "rev-parse --parseopt" mode parsed the option specification
   and the argument hint in a strange way to allow '=3D' and other
   special characters in the option name while forbidding them from
   the argument hint.  This made it impossible to define an option
   like "--pair <key>=3D<value>" with "pair=3Dkey=3Dvalue" specificatio=
n,
   which instead would have defined a "--pair=3Dkey <value>" option.

 * A "rebase" replays changes of the local branch on top of something
   else, as such they are placed in stage #3 and referred to as
   "theirs", while the changes in the new base, typically a foreign
   work, are placed in stage #2 and referred to as "ours".  Clarify
   the "checkout --ours/--theirs".

 * An experimental "untracked cache" feature used uname(2) in a
   slightly unportable way.

 * "sparse checkout" misbehaved for a path that is excluded from the
   checkout when switching between branches that differ at the path.

 * The low-level "git send-pack" did not honor 'user.signingkey'
   configuration variable when sending a signed-push.

 * An attempt to delete a ref by pushing into a repository whose HEAD
   symbolic reference points at an unborn branch that cannot be
   created due to ref D/F conflict (e.g. refs/heads/a/b exists, HEAD
   points at refs/heads/a) failed.

 * "git subtree" (in contrib/) depended on "git log" output to be
   stable, which was a no-no.  Apply a workaround to force a
   particular date format.

 * "git clone $URL" in recent releases of Git contains a regression in
   the code that invents a new repository name incorrectly based on
   the $URL.  This has been corrected.
   (merge db2e220 jk/guess-repo-name-regression-fix later to maint).

 * Running tests with the "-x" option to make them verbose had some
   unpleasant interactions with other features of the test suite.
   (merge 9b5fe78 jk/test-with-x later to maint).

 * "git pull" in recent releases of Git has a regression in the code
   that allows custom path to the --upload-pack=3D<program>.  This has
   been corrected.

 * pipe() emulation used in Git for Windows looked at a wrong variable
   when checking for an error from an _open_osfhandle() call.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.5.0 are as follows:

Charles Bailey (1):
      untracked: fix detection of uname(2) failure

David Aguilar (1):
      contrib/subtree: ignore log.date configuration

David Turner (1):
      unpack-trees: don't update files with CE_WT_REMOVE set

Eric Sunshine (5):
      Documentation/git: drop outdated Cogito reference
      Documentation/git-tools: improve discoverability of Git wiki
      Documentation/git-tools: fix item text formatting
      Documentation/git-tools: drop references to defunct tools
      Documentation/git-tools: retire manually-maintained list

Ilya Bobyr (1):
      rev-parse --parseopt: allow [*=3D?!] in argument hints

Jeff King (4):
      test-lib: turn off "-x" tracing during chain-lint check
      test-lib: disable trace when test is not verbose
      clone: add tests for output directory
      clone: use computed length in guess_dir_name

Jiang Xin (1):
      receive-pack: crash when checking with non-exist HEAD

Jose F. Morales (1):
      Mingw: verify both ends of the pipe () call

Junio C Hamano (5):
      builtin/send-pack.c: respect user.signingkey
      Git 2.4.8
      Start preparing for 2.5.1
      pull: pass upload_pack only when it was given
      Git 2.5.1

Karthik Nayak (1):
      Documentation/tag: remove double occurance of "<pattern>"

Matthieu Moy (1):
      pull.sh: quote $upload_pack when passing it to git-fetch

Mike Hommey (1):
      fast-import: do less work when given "from" matches current branc=
h head

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DI=
R

Simon A. Eugster (1):
      checkout: document subtlety around --ours/--theirs

Stefan Beller (3):
      parse-options: align curly braces for all options
      add: remove dead code
      transport-helper: die on errors reading refs.

Thomas Ackermann (1):
      typofix for index-format.txt
