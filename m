From: Pete Wyckoff <pw@padd.com>
Subject: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Sun, 12 Feb 2012 13:13:40 -0500
Message-ID: <1329070423-23761-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 19:14:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwdwJ-0004YO-B4
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 19:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab2BLSNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 13:13:48 -0500
Received: from honk.padd.com ([74.3.171.149]:39180 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754393Ab2BLSNr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 13:13:47 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id A9219E8B;
	Sun, 12 Feb 2012 10:13:46 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0D36B313C6; Sun, 12 Feb 2012 13:13:43 -0500 (EST)
X-Mailer: git-send-email 1.7.9.193.g1d4a5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190584>

The git-p4 code is in a single python script down in
contrib/fast-import now.  I'd like to move it up to the top-level
source directory of git to make it easier to build and
distribute.  Git-p4 already takes advantage of the git
infrastructure for documentation and testing, as well as the
community support (Junio, many reviewers).

Users install git-p4 currently by copying the git-p4 script from
contrib/fast-import into a local or personal bin directory, and
setting up an alias for "git p4" to invoke it.  If it is part of
the install, the command will be available automatically.  Also,
distributions may be more likely to pick it up either as part of
a core git package, or as a separate add-on.  Getting support
for python and git-p4 in msysgit is something I'd like to see
happen too.

While I considered taking this opportunity to split up git-p4
into more modular components across multiple files, it seems best
now just to do the script move intact.  That effort could come
later.  If anyone has a strong preference to do this now, we could.

Developer note:  Like all scripts in git, the source file is
git-p4.py, which is built with "make" to git-p4, substituting the
specified path for python in the first line.  Be sure to edit the
source file, and to build before running tests.  This is sort of
a pain for existing developers, but hopefully we can get used to it.


Pete Wyckoff (3):
  git-p4: move to toplevel
  git p4: update name in script
  git p4: use "git p4" directly in tests

 .gitignore                              |    1 +
 Documentation/git-p4.txt                |   23 +++------
 INSTALL                                 |    3 +
 Makefile                                |    1 +
 contrib/fast-import/git-p4.README       |   13 +++++
 contrib/fast-import/git-p4.bat          |    1 -
 contrib/fast-import/git-p4 => git-p4.py |   14 +++---
 t/lib-git-p4.sh                         |    8 +--
 t/t9800-git-p4-basic.sh                 |   84 +++++++++++++++---------------
 t/t9801-git-p4-branch.sh                |   32 ++++++------
 t/t9802-git-p4-filetype.sh              |   10 ++--
 t/t9803-git-p4-shell-metachars.sh       |   12 ++--
 t/t9804-git-p4-label.sh                 |    6 +-
 t/t9805-git-p4-skip-submit-edit.sh      |   22 ++++----
 t/t9806-git-p4-options.sh               |   28 +++++-----
 t/t9807-git-p4-submit.sh                |   22 ++++----
 t/t9808-git-p4-chdir.sh                 |    6 +-
 t/t9809-git-p4-client-view.sh           |   64 ++++++++++++------------
 18 files changed, 179 insertions(+), 171 deletions(-)
 create mode 100644 contrib/fast-import/git-p4.README
 delete mode 100644 contrib/fast-import/git-p4.bat
 rename contrib/fast-import/git-p4 => git-p4.py (99%)

-- 
1.7.9.192.ga1d4b
