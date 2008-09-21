From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [StGit] kha/{safe,experimental} updated
Date: Sun, 21 Sep 2008 17:37:57 +0200
Message-ID: <20080921153757.GA9098@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Daniel White <daniel@whitehouse.id.au>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 17:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhQm0-0001ZJ-Ke
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 17:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbYIUPQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 11:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbYIUPQM
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 11:16:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1299 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbYIUPQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 11:16:11 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KhR0X-0002ow-00; Sun, 21 Sep 2008 16:37:57 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96399>

Just pushed out the stack log stuff to kha/safe. It really should be
ready for wider use at this point, and it was getting tiresome to keep
rebasing it.

One patch is still in experimental -- it depends on a new git feature
that isn't in any release yet.

There's also a patch for much improved bash completion support; I'll
post it as a reply to this mail.


                                 -+-


The following changes since commit 3ce5fec2ef4154369653a41eb7692aca2587=
8298:
  Catalin Marinas (1):
        Merge branch 'stable'

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Daniel White (1):
      Fixes for auto-generation of man pages

David K=E5gedal (1):
      Add support for initializing a branch for stgit from Emacs.

Karl Hasselstr=F6m (24):
      Auto-generate man pages for all StGit commands
      asciidoc.conf: Steal updates from git
      Generate command lists automatically
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
      Test that stg coalesce handles head !=3D top gracefully
      Check for top =3D=3D head at the start of every transaction
      Make "stg log" show stack log instead of patch log
      Convert "stg refresh" to the new infrastructure
      New refresh tests
      Remove --undo flags from stg commands and docs
      Refactor stgit.commands.edit
      Invoke the correct interactive editor
      Implement "stg refresh --edit" again
      Automatic bash completion
      Read several objects at once with git cat-file --batch

 .gitignore                         |    1 +
 Documentation/.gitignore           |    5 +-
 Documentation/COMMAND-TEMPLATE.txt |   42 ---
 Documentation/Makefile             |   15 +-
 Documentation/asciidoc.conf        |  100 +++++--
 Documentation/stg-branch.txt       |  114 --------
 Documentation/stg-clone.txt        |   32 ---
 Documentation/stg-init.txt         |   29 --
 Documentation/stg-new.txt          |  115 --------
 Documentation/stg-sink.txt         |   49 ----
 Documentation/stg.txt              |  138 +----------
 Documentation/tutorial.txt         |    4 +-
 INSTALL                            |    4 +-
 Makefile                           |   21 ++-
 TODO                               |    2 -
 contrib/stgit-completion.bash      |  270 -------------------
 contrib/stgit.el                   |   12 +-
 setup.py                           |    4 +-
 stg-build                          |   41 +++
 stgit/argparse.py                  |  260 +++++++++++++++---
 stgit/commands/.gitignore          |    1 +
 stgit/commands/__init__.py         |   78 ++++++
 stgit/commands/branch.py           |  148 +++++++----
 stgit/commands/clean.py            |   23 +-
 stgit/commands/clone.py            |   23 +-
 stgit/commands/coalesce.py         |   16 +-
 stgit/commands/commit.py           |   27 ++-
 stgit/commands/common.py           |   18 +-
 stgit/commands/delete.py           |   19 +-
 stgit/commands/diff.py             |   36 ++--
 stgit/commands/edit.py             |  106 ++------
 stgit/commands/export.py           |   53 ++--
 stgit/commands/files.py            |   31 ++-
 stgit/commands/float.py            |   24 +-
 stgit/commands/fold.py             |   26 +-
 stgit/commands/goto.py             |   16 +-
 stgit/commands/hide.py             |   23 +-
 stgit/commands/id.py               |   15 +-
 stgit/commands/imprt.py            |   98 ++++----
 stgit/commands/init.py             |   17 +-
 stgit/commands/log.py              |  192 +++++---------
 stgit/commands/mail.py             |  126 ++++-----
 stgit/commands/new.py              |   39 ++--
 stgit/commands/patches.py          |   27 +-
 stgit/commands/pick.py             |   57 ++--
 stgit/commands/pop.py              |   33 ++--
 stgit/commands/pull.py             |   28 +-
 stgit/commands/push.py             |   65 ++---
 stgit/commands/rebase.py           |   30 +-
 stgit/commands/redo.py             |   56 ++++
 stgit/commands/refresh.py          |  355 ++++++++++++++++--------
 stgit/commands/rename.py           |   32 ++-
 stgit/commands/repair.py           |   21 +-
 stgit/commands/reset.py            |   65 +++++
 stgit/commands/resolved.py         |   33 ++--
 stgit/commands/series.py           |   82 +++---
 stgit/commands/show.py             |   36 ++--
 stgit/commands/sink.py             |   46 +++-
 stgit/commands/status.py           |   61 ++---
 stgit/commands/sync.py             |   56 ++---
 stgit/commands/top.py              |   18 +-
 stgit/commands/uncommit.py         |   34 ++-
 stgit/commands/undo.py             |   53 ++++
 stgit/commands/unhide.py           |   24 +-
 stgit/completion.py                |  140 ++++++++++
 stgit/git.py                       |    4 -
 stgit/lib/edit.py                  |   99 +++++++
 stgit/lib/git.py                   |  116 ++++++++-
 stgit/lib/log.py                   |  524 ++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py                 |   25 ++
 stgit/lib/transaction.py           |  128 ++++++---
 stgit/main.py                      |  140 +---------
 stgit/run.py                       |   19 ++
 stgit/stack.py                     |   45 +---
 stgit/utils.py                     |   22 +-
 t/t1200-push-modified.sh           |    2 +-
 t/t1201-pull-trailing.sh           |    2 +-
 t/t1202-push-undo.sh               |    8 +-
 t/t1400-patch-history.sh           |  103 -------
 t/t2300-refresh-subdir.sh          |   29 ++-
 t/t2600-coalesce.sh                |   13 +
 t/t2701-refresh-p.sh               |    2 +-
 t/t3100-reset.sh                   |  160 +++++++++++
 t/t3101-reset-hard.sh              |   53 ++++
 t/t3102-undo.sh                    |   81 ++++++
 t/t3103-undo-hard.sh               |   53 ++++
 t/t3104-redo.sh                    |  114 ++++++++
 t/t3105-undo-external-mod.sh       |   65 +++++
 t/t3300-edit.sh                    |   12 +-
 t/test-lib.sh                      |    5 +-
 90 files changed, 3348 insertions(+), 2241 deletions(-)
 delete mode 100644 Documentation/COMMAND-TEMPLATE.txt
 delete mode 100644 Documentation/stg-branch.txt
 delete mode 100644 Documentation/stg-clone.txt
 delete mode 100644 Documentation/stg-init.txt
 delete mode 100644 Documentation/stg-new.txt
 delete mode 100644 Documentation/stg-sink.txt
 delete mode 100644 contrib/stgit-completion.bash
 create mode 100755 stg-build
 create mode 100644 stgit/commands/.gitignore
 create mode 100644 stgit/commands/redo.py
 create mode 100644 stgit/commands/reset.py
 create mode 100644 stgit/commands/undo.py
 create mode 100644 stgit/completion.py
 create mode 100644 stgit/lib/edit.py
 create mode 100644 stgit/lib/log.py
 delete mode 100755 t/t1400-patch-history.sh
 create mode 100755 t/t3100-reset.sh
 create mode 100755 t/t3101-reset-hard.sh
 create mode 100755 t/t3102-undo.sh
 create mode 100755 t/t3103-undo-hard.sh
 create mode 100755 t/t3104-redo.sh
 create mode 100755 t/t3105-undo-external-mod.sh


                                 -+-


The following changes since commit 2f34dbb4625e0c04a983229477a50ba4de70=
36bf:
  Karl Hasselstr=F6m (1):
        Read several objects at once with git cat-file --batch

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Karl Hasselstr=F6m (1):
      Diff several trees at once with git diff-tree --stdin

 INSTALL          |    5 +++--
 stgit/lib/git.py |   37 +++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 6 deletions(-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
