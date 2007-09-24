From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit kha experimental branch updated
Date: Mon, 24 Sep 2007 02:10:34 +0200
Message-ID: <20070924001034.GB24403@diana.vm.bytemark.co.uk>
References: <20070924000244.GA24403@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 02:10:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZbX9-00019R-Ju
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 02:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbXIXAKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2007 20:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbXIXAKh
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 20:10:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3952 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446AbXIXAKg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 20:10:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IZbX0-0006ON-00; Mon, 24 Sep 2007 01:10:34 +0100
Content-Disposition: inline
In-Reply-To: <20070924000244.GA24403@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59008>

The three last patches of David's top/bottom removal series are here,
and all the old patches too. Changes:

  * Everything's been rebased on top of David's top/bottom removal
    series, which turned out to be a major undertaking. I'm not 100%
    sure I've managed to not break anything.

  * I've modified the conflict series to adhere to the new test suite
    policy; it now passes the test suite at every point, by using
    test_expect_failure for broken tests.

  * The add/rm/cp removal patches no longer break "stg help".

The following changes since commit 5f594e90e9a0867e1b87ffb8b0a077152246=
b56c:
  Karl Hasselstr=F6m (1):
        New policy: Only use test_expect_failure for broken tests

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

David K=E5gedal (9):
      Check bottom and invariants
      Remove the 'bottom' field
      Remove the 'top' field
      Split git.merge into two functions
      Leave working dir and index alone after failed (conflicting) push
      Added a test case to check what happens when push finds a conflic=
t
      Simplify merge_recursive
      Use the output from merge-recursive to list conflicts
      Ask git about unmerged files

Karl Hasselstr=F6m (20):
      Remove the --force flag to "stg rebase" and "stg pull"
      Better error message if merge fails
      Fix "stg resolved" to work with new conflict representation
      Refactoring: pass more than one file to resolved()
      We keep the different stages of a conflict in the index now
      Clean up the logic in "stg resolved"
      "stg status --reset" is not needed anymore
      Remove "stg add"
      Remove "stg rm"
      Remove "stg cp"
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
      Merge branch 'conflict' into experimental

 Documentation/stg-cp.txt      |   63 -----
 Documentation/tutorial.txt    |   22 +-
 contrib/stgit-completion.bash |   15 +-
 stgit/commands/add.py         |   43 ---
 stgit/commands/commit.py      |    8 +-
 stgit/commands/common.py      |   34 +--
 stgit/commands/copy.py        |   44 ---
 stgit/commands/float.py       |    2 +-
 stgit/commands/pick.py        |    2 +-
 stgit/commands/pull.py        |    5 +-
 stgit/commands/rebase.py      |    5 +-
 stgit/commands/resolved.py    |   70 ++---
 stgit/commands/rm.py          |   47 ---
 stgit/commands/status.py      |   34 +--
 stgit/commands/sync.py        |    1 -
 stgit/git.py                  |   72 +++--
 stgit/gitmergeonefile.py      |   99 ++++---
 stgit/main.py                 |    6 -
 stgit/run.py                  |    3 +
 stgit/stack.py                |  620 ++++++++++++++++++++++++++++++++-=
--------
 t/t0002-status.sh             |   11 +-
 t/t1200-push-modified.sh      |    2 +-
 t/t1202-push-undo.sh          |    4 +-
 t/t1203-push-conflict.sh      |   70 +++++
 t/t1300-uncommit.sh           |    4 +-
 t/t1301-assimilate.sh         |    2 +-
 t/t1400-patch-history.sh      |    4 +-
 t/t1500-float.sh              |   14 +-
 t/t1600-delete-one.sh         |   12 +-
 t/t1601-delete-many.sh        |    2 +-
 t/t1700-goto-top.sh           |    2 +-
 t/t2000-sync.sh               |    8 +-
 t/t2100-pull-policy-fetch.sh  |   18 +-
 t/t2101-pull-policy-pull.sh   |    4 +-
 t/t2102-pull-policy-rebase.sh |   28 +--
 t/t3000-git-interop.sh        |   60 ++++
 t/t4000-upgrade.sh            |    6 +
 37 files changed, 822 insertions(+), 624 deletions(-)
 delete mode 100644 Documentation/stg-cp.txt
 delete mode 100644 stgit/commands/add.py
 delete mode 100644 stgit/commands/copy.py
 delete mode 100644 stgit/commands/rm.py
 create mode 100755 t/t1203-push-conflict.sh
 create mode 100755 t/t3000-git-interop.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
