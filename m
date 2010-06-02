From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/8] implement cherry-picking many commits
Date: Wed, 02 Jun 2010 07:58:33 +0200
Message-ID: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Antriksh Pany <antriksh.pany@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:59:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgyu-0006o3-FG
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab0FBF7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:59:08 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47629 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab0FBF7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:59:07 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B40D9818128;
	Wed,  2 Jun 2010 07:58:59 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148208>

This a patch series to implement cherry-picking and reverting
many commits instead of just one.

There is still no way to continue or abort the process when
cherry-picking or reverting fails, but this can be implemented
later.

Changes since the previous series are the following:
- fixed some memory leaks, thanks to Jonathan Nieder
- improved documentation, thanks to Jonathan, Ram and Antriksh
- small fixup to use (void) instead of (), thanks to Junio

Christian Couder (8):
  revert: cleanup code for -x option
  revert: use run_command_v_opt() instead of execv_git_cmd()
  revert: refactor code into a do_pick_commit() function
  revert: change help_msg() to take no argument
  revert: allow cherry-picking more than one commit
  revert: add tests to check cherry-picking many commits
  Documentation/cherry-pick: describe passing more than one commit
  Documentation/revert: describe passing more than one commit

 Documentation/git-cherry-pick.txt   |   64 +++++++++++++++---
 Documentation/git-revert.txt        |   51 +++++++++++----
 builtin/revert.c                    |  120 +++++++++++++++++++++++------------
 t/t3508-cherry-pick-many-commits.sh |   95 +++++++++++++++++++++++++++
 4 files changed, 264 insertions(+), 66 deletions(-)
 create mode 100755 t/t3508-cherry-pick-many-commits.sh
