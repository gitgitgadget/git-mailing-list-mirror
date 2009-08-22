From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/9] more changes to port rebase -i to C using sequencer
	code
Date: Sat, 22 Aug 2009 06:16:06 +0200
Message-ID: <20090822041157.4261.92491.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 06:51:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeiZX-0005aq-7D
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 06:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbZHVEun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 00:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZHVEun
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 00:50:43 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38283 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbZHVEun (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 00:50:43 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C516381809D;
	Sat, 22 Aug 2009 06:50:36 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C439B818057;
	Sat, 22 Aug 2009 06:50:33 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126785>

This is another reroll of the series I first sent on August the 12th.

The only changes since v2 are in the commit messages. References to the
pick() function have been replaced by references to pick_commit(), and I
tried to describe the purpose of the patch first. 

Christian Couder (5):
  sequencer: add "--fast-forward" option to "git sequencer--helper"
  sequencer: let "git sequencer--helper" callers set "allow_dirty"
  rebase -i: use "git sequencer--helper --fast-forward"
  pick: libify "pick_help_msg()"
  rebase -i: use "git sequencer--helper --cherry-pick"

Stephan Beyer (4):
  sequencer: add "do_fast_forward()" to perform a fast forward
  revert: libify pick
  sequencer: add "do_commit()" and related functions
  sequencer: add "--cherry-pick" option to "git sequencer--helper"

 Makefile                    |    2 +
 builtin-revert.c            |  293 ++++++-----------------------------------
 builtin-sequencer--helper.c |  305 +++++++++++++++++++++++++++++++++++++++++--
 git-rebase--interactive.sh  |   22 ++--
 pick.c                      |  232 ++++++++++++++++++++++++++++++++
 pick.h                      |   14 ++
 6 files changed, 599 insertions(+), 269 deletions(-)
 create mode 100644 pick.c
 create mode 100644 pick.h
