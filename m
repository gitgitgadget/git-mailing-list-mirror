From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT experimental branch updated
Date: Sun, 26 Aug 2007 22:46:50 +0200
Message-ID: <20070826204650.GA22528@diana.vm.bytemark.co.uk>
References: <20070823022958.GA9323@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 22:47:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPP0b-0003g3-G2
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbXHZUqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXHZUqy
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:46:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2372 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXHZUqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:46:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IPP0U-00064r-00; Sun, 26 Aug 2007 21:46:50 +0100
Content-Disposition: inline
In-Reply-To: <20070823022958.GA9323@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56732>

Updated again. It has all the patches I just mailed out, as well as
the DAG series.

The following changes since commit 5f1629be6d0d10aa2acb253c89c6f6c38fdf=
3cf2:
  Catalin Marinas (1):
        Allow 'import' to apply empty patches

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git master

David K=E5gedal (5):
      Split git.merge into two functions
      Leave working dir and index alone after failed (conflicting) push
      Added a test case to check what happens when push finds a conflic=
t
      Simplify merge_recursive
      Use the output from merge-recursive to list conflicts

Karl Hasselstr=F6m (19):
      Don't use test_expect_failure when more than one thing could fail
      Don't write None to the conf file
      Replace "git repo-config" with "git config" in help texts
      Compile regexp just once
      Refactor output handling to break circular dependency
      Refactor subprocess creation
      Assert that the argument to Run is a sequence of strings
      Add optional logging of subprocess execution
      Better error message if merge fails
      Compute patch appliedness from commit DAG
      Test the new DAG appliedness machinery
      Fix bash completion after the DAG appliedness patch
      Speed up the appliedness test
      Speed up the discovery of uninteresting commits
      Speed up appliedness check during patch creation
      Don't traverse the whole DAG when looking for uninteresting commi=
ts
      Find uninteresting commits faster for special cases
      Optimize uninterestingness checks for rebase
      Merge branch 'conflict-run'

 contrib/stgit-completion.bash |   15 +-
 examples/gitconfig            |    2 +-
 stgit/basedir.py              |   13 +-
 stgit/commands/applied.py     |    1 +
 stgit/commands/assimilate.py  |    1 +
 stgit/commands/branch.py      |    1 +
 stgit/commands/clean.py       |    1 +
 stgit/commands/commit.py      |    9 +-
 stgit/commands/common.py      |    1 +
 stgit/commands/delete.py      |    1 +
 stgit/commands/diff.py        |    1 +
 stgit/commands/export.py      |   10 +-
 stgit/commands/files.py       |    1 +
 stgit/commands/float.py       |    2 +-
 stgit/commands/fold.py        |    1 +
 stgit/commands/hide.py        |    1 +
 stgit/commands/id.py          |    1 +
 stgit/commands/imprt.py       |    3 +-
 stgit/commands/log.py         |    1 +
 stgit/commands/mail.py        |    1 +
 stgit/commands/patches.py     |    1 +
 stgit/commands/pick.py        |    3 +-
 stgit/commands/pull.py        |    1 +
 stgit/commands/push.py        |    1 +
 stgit/commands/refresh.py     |    3 +-
 stgit/commands/rename.py      |    1 +
 stgit/commands/series.py      |    1 +
 stgit/commands/sync.py        |    3 +-
 stgit/commands/top.py         |    1 +
 stgit/commands/unapplied.py   |    1 +
 stgit/commands/uncommit.py    |    1 +
 stgit/commands/unhide.py      |    1 +
 stgit/config.py               |   56 +---
 stgit/git.py                  |  374 +++++++++++---------------
 stgit/gitmergeonefile.py      |   21 +-
 stgit/main.py                 |    2 +-
 stgit/out.py                  |  100 +++++++
 stgit/run.py                  |  141 ++++++++++
 stgit/stack.py                |  583 +++++++++++++++++++++++++++++++++=
--------
 stgit/utils.py                |   81 +------
 t/t1203-push-conflict.sh      |   64 +++++
 t/t2101-pull-policy-pull.sh   |    4 +-
 t/t3000-git-interop.sh        |   60 +++++
 t/t4000-upgrade.sh            |    6 +
 44 files changed, 1082 insertions(+), 495 deletions(-)
 create mode 100644 stgit/out.py
 create mode 100644 stgit/run.py
 create mode 100755 t/t1203-push-conflict.sh
 create mode 100755 t/t3000-git-interop.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
