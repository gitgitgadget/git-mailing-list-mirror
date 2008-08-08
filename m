From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [StGit] kha/{safe,experimental} updated
Date: Fri, 8 Aug 2008 10:27:28 +0200
Message-ID: <20080808082728.GA24017@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>,
	Daniel White <daniel@whitehouse.id.au>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 10:07:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRMzq-00077u-FQ
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 10:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbYHHIFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 04:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbYHHIFr
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 04:05:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1514 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbYHHIFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 04:05:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KRNJo-0006JW-00; Fri, 08 Aug 2008 09:27:28 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91631>

Catalin has pulled the safe and stable branches, but I've accumulated
some new stuff in kha/safe.

The stack log stuff (and nothing else) is still in kha/experimental.
It's unchanged since my last status mail, except for the addition of
an optimization at the end (will post as a follow-up to this mail).


                                 -+-


The following changes since commit 36a06e0194e013552499677e431e528ecb2f=
aee9:
  Karl Hasselstr=F6m (1):
        Global performance logging

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Daniel White (7):
      Fix Makefile to correctly pass prefix option
      Remove variables regarding section 7 man pages
      Fix default install location for manpages
      Add install-doc target to makefile
      Add install-html target to makefile
      Remove installation of documentation from setup.py
      Updated INSTALL with documentation of Makefile

Karl Hasselstr=F6m (1):
      Add some tests of refreshing removed files

Samuel Tardieu (2):
      Do not insert an empty line before the diffstat info
      Do not mess-up with commit message formatting when sending email

 Documentation/Makefile     |   25 +++++------
 INSTALL                    |   15 ++++--
 Makefile                   |   12 ++++-
 setup.py                   |    2 +-
 stgit/commands/mail.py     |    4 +-
 t/t2702-refresh-rm.sh      |  101 ++++++++++++++++++++++++++++++++++++=
++++++++
 templates/mailattch.tmpl   |    1 -
 templates/patchexport.tmpl |    1 -
 templates/patchmail.tmpl   |    1 -
 9 files changed, 135 insertions(+), 27 deletions(-)
 create mode 100755 t/t2702-refresh-rm.sh


                                 -+-


The following changes since commit 42857cbe036ba5917eacc9dbb5644d395f63=
8ed9:
  Samuel Tardieu (1):
        Do not mess-up with commit message formatting when sending emai=
l

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Karl Hasselstr=F6m (17):
      Write to a stack log when stack is modified
      New command: stg reset
      Log conflicts separately
      Log conflicts separately for all commands
      Add a --hard flag to stg reset
      Don't write a log entry if there were no changes
      Move stack reset function to a shared location
      New command: stg undo
      New command: stg redo
      Log and undo external modifications
      Make "stg log" show stack log instead of patch log
      Convert "stg refresh" to the new infrastructure
      New refresh tests
      Remove --undo flags from stg commands and docs
      Refactor stgit.commands.edit
      Implement "stg refresh --edit" again
      Read several objects at once with git cat-file --batch

 Documentation/tutorial.txt   |    4 +-
 TODO                         |    2 -
 stgit/commands/branch.py     |   19 +-
 stgit/commands/clone.py      |    2 +-
 stgit/commands/coalesce.py   |    2 +-
 stgit/commands/common.py     |   18 ++-
 stgit/commands/diff.py       |    6 +-
 stgit/commands/edit.py       |   82 +------
 stgit/commands/export.py     |    2 +-
 stgit/commands/files.py      |    6 +-
 stgit/commands/float.py      |    2 +-
 stgit/commands/fold.py       |    2 +-
 stgit/commands/goto.py       |    3 +-
 stgit/commands/hide.py       |    2 +-
 stgit/commands/id.py         |    2 +-
 stgit/commands/imprt.py      |    4 +-
 stgit/commands/log.py        |  169 +++++----------
 stgit/commands/mail.py       |    8 +-
 stgit/commands/new.py        |    3 +-
 stgit/commands/patches.py    |    2 +-
 stgit/commands/pick.py       |    2 +-
 stgit/commands/pop.py        |    4 +-
 stgit/commands/pull.py       |    2 +-
 stgit/commands/push.py       |   31 +--
 stgit/commands/rebase.py     |    4 +-
 stgit/commands/redo.py       |   52 ++++
 stgit/commands/refresh.py    |  338 ++++++++++++++++++---------
 stgit/commands/rename.py     |    2 +-
 stgit/commands/repair.py     |   11 +-
 stgit/commands/reset.py      |   57 +++++
 stgit/commands/resolved.py   |    2 +-
 stgit/commands/show.py       |    2 +-
 stgit/commands/sink.py       |    2 +-
 stgit/commands/status.py     |    3 +-
 stgit/commands/sync.py       |   26 +--
 stgit/commands/undo.py       |   49 ++++
 stgit/commands/unhide.py     |    2 +-
 stgit/git.py                 |    4 -
 stgit/lib/edit.py            |   99 ++++++++
 stgit/lib/git.py             |  108 ++++++++-
 stgit/lib/log.py             |  524 ++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py           |   25 ++
 stgit/lib/transaction.py     |  125 +++++++----
 stgit/main.py                |    8 +
 stgit/run.py                 |   17 ++
 stgit/stack.py               |   45 +----
 stgit/utils.py               |   18 +-
 t/t1200-push-modified.sh     |    2 +-
 t/t1201-pull-trailing.sh     |    2 +-
 t/t1202-push-undo.sh         |    8 +-
 t/t1400-patch-history.sh     |  103 --------
 t/t2300-refresh-subdir.sh    |   29 +++-
 t/t2701-refresh-p.sh         |    2 +-
 t/t3100-reset.sh             |  160 +++++++++++++
 t/t3101-reset-hard.sh        |   56 +++++
 t/t3102-undo.sh              |   86 +++++++
 t/t3103-undo-hard.sh         |   56 +++++
 t/t3104-redo.sh              |  122 ++++++++++
 t/t3105-undo-external-mod.sh |   68 ++++++
 t/t3300-edit.sh              |    4 +-
 60 files changed, 1986 insertions(+), 614 deletions(-)
 create mode 100644 stgit/commands/redo.py
 create mode 100644 stgit/commands/reset.py
 create mode 100644 stgit/commands/undo.py
 create mode 100644 stgit/lib/edit.py
 create mode 100644 stgit/lib/log.py
 delete mode 100755 t/t1400-patch-history.sh
 create mode 100755 t/t3100-reset.sh
 create mode 100755 t/t3101-reset-hard.sh
 create mode 100755 t/t3102-undo.sh
 create mode 100755 t/t3103-undo-hard.sh
 create mode 100755 t/t3104-redo.sh
 create mode 100755 t/t3105-undo-external-mod.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
