From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/3] git-p4: move to toplevel
Date: Sun,  8 Apr 2012 20:17:59 -0400
Message-ID: <1333930682-31670-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 02:18:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SH2JB-0004Rs-Am
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 02:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab2DIASI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 20:18:08 -0400
Received: from honk.padd.com ([74.3.171.149]:45566 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425Ab2DIASH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 20:18:07 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id B3D812CBE;
	Sun,  8 Apr 2012 17:18:04 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 51CE9313D3; Sun,  8 Apr 2012 20:18:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.56.gfc226
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195006>

Users install git-p4 currently by copying the git-p4 script from
contrib/fast-import into a local or personal bin directory.  If
it is part of the install, the command will be available
automatically.  Also, distributions may be more likely to pick it
up either as part of a core git package, or as a separate add-on.


This series appeared as an RFC two months ago:

    http://thread.gmane.org/gmane.comp.version-control.git/190584

The git-p4 code is in a single python script down in
contrib/fast-import now.  I'd like to move it up to the top-level
source directory of git to make it easier to build and
distribute.  Git-p4 already takes advantage of the git
infrastructure for documentation and testing, as well as the
community support (Junio, many reviewers).

The only observation from the RFC series was that git-p4 is
useful only in the non-open-source world.  While you can download
p4 for testing, a production environment is not free.  No one
particularly complained about that though.

Changes since then:

    - Fix bug in name in Documentation/git-p4.txt.

    - Add to command-list.txt.

    - Adapt to other git-p4 changes.

    - I tested git-p4 on msysgit and cygwin, making sure it passes
      all the tests.  Getting installers for git-p4 in those
      environments should be possible soon.  Fixes for windows
      will appear as a separate series.


Developer note:  Like all scripts in git, the source file has
an extension, git-p4.py, which is built with "make" to git-p4.
Be sure to edit the source file, and to build before running tests.

Installer note: git-p4 uses the existing python dependencies in
the Makefile.  Be sure _not_ to set NO_PYTHON; build and install
as usual.  If your python (2.6 or 2.7) is not in /usr/bin/python,
set PYTHON_PATH accordingly.  Git-p4 does not require the
git_remote_helpers that are also installed.


It would be good to have this in next early in the 1.7.11 series
so we can send the rest of the patches on top of this.  It
conflicts fairly heavily with other changes, obviously.  I think
there are 4-5 other outstanding git-p4 series.

		-- Pete

Pete Wyckoff (3):
  git-p4: move to toplevel
  git p4: update name in script
  git p4: use "git p4" directly in tests

 .gitignore                              |    1 +
 Documentation/git-p4.txt                |   19 +++----
 INSTALL                                 |    3 ++
 Makefile                                |    1 +
 command-list.txt                        |    1 +
 contrib/fast-import/git-p4.README       |   13 +++++
 contrib/fast-import/git-p4.bat          |    1 -
 contrib/fast-import/git-p4 => git-p4.py |   14 ++---
 t/lib-git-p4.sh                         |    8 ++-
 t/t9800-git-p4-basic.sh                 |   84 ++++++++++++++---------------
 t/t9801-git-p4-branch.sh                |   32 +++++------
 t/t9802-git-p4-filetype.sh              |   10 ++--
 t/t9803-git-p4-shell-metachars.sh       |   12 ++---
 t/t9804-git-p4-label.sh                 |    6 +--
 t/t9805-git-p4-skip-submit-edit.sh      |   22 ++++----
 t/t9806-git-p4-options.sh               |   28 +++++-----
 t/t9807-git-p4-submit.sh                |   22 ++++----
 t/t9808-git-p4-chdir.sh                 |    6 +--
 t/t9809-git-p4-client-view.sh           |   88 +++++++++++++++----------------
 t/t9810-git-p4-rcs.sh                   |   48 ++++++++---------
 20 files changed, 214 insertions(+), 205 deletions(-)
 create mode 100644 contrib/fast-import/git-p4.README
 delete mode 100644 contrib/fast-import/git-p4.bat
 rename contrib/fast-import/git-p4 => git-p4.py (99%)

-- 
1.7.10.4.gb369
