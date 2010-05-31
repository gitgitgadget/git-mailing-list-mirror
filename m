From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/8] implement cherry-picking many commits
Date: Mon, 31 May 2010 21:42:31 +0200
Message-ID: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 05:04:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJHm9-0000OY-4B
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 05:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab0FADEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 23:04:04 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:41980 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898Ab0FADEB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 23:04:01 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 263D3818040;
	Tue,  1 Jun 2010 05:03:53 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148062>

This a patch series to implement cherry-picking and reverting
many commits instead of just one.

There is still no way to continue or abort the process when
cherry-picking or reverting fails, but this can be implemented
later.

Changes since the previous RFC series are the following:

- now use the equivalent of 'git rev-list --no-walk "$@"' to
enumerate the commits (suggested by Junio)
- added a patch to cleanup the code related to the -x option
(suggested by Ram)
- added a commit to change help_msg() and its callers
- added 2 documentation patches 

Christian Couder (8):
  revert: cleanup code for -x option
  revert: use run_command_v_opt() instead of execv_git_cmd()
  revert: refactor code into a do_pick_commit() function
  revert: change help_msg() to take no argument
  revert: allow cherry-picking more than one commit
  revert: add tests to check cherry-picking many commits
  Documentation/cherry-pick: describe passing more than one commit
  Documentation/revert: describe passing more than one commit

 Documentation/git-cherry-pick.txt   |   64 ++++++++++++++++-----
 Documentation/git-revert.txt        |   52 +++++++++++------
 builtin/revert.c                    |  109 ++++++++++++++++++++++-------------
 t/t3508-cherry-pick-many-commits.sh |   95 ++++++++++++++++++++++++++++++
 4 files changed, 249 insertions(+), 71 deletions(-)
 create mode 100755 t/t3508-cherry-pick-many-commits.sh
