From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Fri, 18 Jan 2008 05:24:47 +0100
Message-ID: <20080118042447.GA13178@diana.vm.bytemark.co.uk>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> <200801162147.33448.kumbayo84@arcor.de> <200801162158.26450.kumbayo84@arcor.de> <20080117074559.GB25213@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Pavel Roskin <proski@gnu.org>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 05:25:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFing-0007bH-Sr
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 05:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYAREZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 23:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbYAREZV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 23:25:21 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2106 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbYAREZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 23:25:20 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JFimd-0003Qu-00; Fri, 18 Jan 2008 04:24:47 +0000
Content-Disposition: inline
In-Reply-To: <20080117074559.GB25213@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70963>

On 2008-01-17 08:45:59 +0100, Karl Hasselstr=F6m wrote:

> Thanks, I'll apply this tonight. (Along with Pavel's "stg edit --sign=
"
> patch, which I've been neglecting for quite a while now. Sorry!)

The following changes since commit 5b2666bab799830ac5e511f35103d04fc396=
8b32:
  Catalin Marinas (1):
        Remove a newline from the e-mail template

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

David K=E5gedal (2):
      Emacs mode: Add mark command
      Emacs mode: coalesce command

Karl Hasselstr=F6m (12):
      Teach the new infrastructure about the index and worktree
      Let "stg clean" use the new transaction primitives
      Let "stg goto" use the new infrastructure
      Convert "stg uncommit" to the new infrastructure
      New infrastructure: Make sure that the branch is initialized
      Expose transaction abort function
      stg coalesce: Support --file and --save-template
      Set exit code to 3 on merge conflict
      Convert "stg commit" to new infrastructure
      Make "stg commit" fancier
      Test that "stg goto" can be called from a subdirectory
      Make "stg goto" subdirectory safe

Pavel Roskin (1):
      Fix "stg edit --sign"

Peter Oberndorfer (2):
      Don't mention removed "stg refresh" options
      replace "git repo-config" usage by "git config"

 contrib/stgit.el              |   97 ++++++++++++++++++-----
 stgit/commands/clean.py       |   35 ++------
 stgit/commands/coalesce.py    |  118 ++++++++++++++++++---------
 stgit/commands/commit.py      |  111 ++++++++++++++++----------
 stgit/commands/edit.py        |    5 +-
 stgit/commands/goto.py        |   52 ++++--------
 stgit/commands/refresh.py     |    8 +-
 stgit/commands/uncommit.py    |   81 ++++++++-----------
 stgit/config.py               |   14 ++--
 stgit/lib/git.py              |  128 +++++++++++++++++++++++++++++
 stgit/lib/stack.py            |   10 ++-
 stgit/lib/stackupgrade.py     |    6 +-
 stgit/lib/transaction.py      |  178 +++++++++++++++++++++++++++++++++=
++------
 stgit/main.py                 |    4 +-
 stgit/run.py                  |    9 ++-
 stgit/utils.py                |    1 +
 t/t1300-uncommit.sh           |   12 ++--
 t/t1900-mail.sh               |    2 +-
 t/t2100-pull-policy-fetch.sh  |    4 +-
 t/t2101-pull-policy-pull.sh   |    4 +-
 t/t2102-pull-policy-rebase.sh |    4 +-
 t/t2800-goto-subdir.sh        |   59 ++++++++++++++
 22 files changed, 675 insertions(+), 267 deletions(-)
 create mode 100755 t/t2800-goto-subdir.sh

                                  -+-

The following changes since commit 085902b45b9bea3fa5bc14470219891ec4cc=
ba78:
  Peter Oberndorfer (1):
        replace "git repo-config" usage by "git config"

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Peter Oberndorfer (1):
      Add an --index option to "stg refresh"

 stgit/commands/refresh.py |   25 ++++++++++++++++---
 t/t2700-refresh.sh        |   57 +++++++++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 77 insertions(+), 5 deletions(-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
