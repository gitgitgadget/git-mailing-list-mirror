From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/9] more changes to port rebase -i to C using sequencer
	code
Date: Fri, 21 Aug 2009 07:49:51 +0200
Message-ID: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 07:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeN76-0001oS-HA
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 07:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbZHUFzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 01:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753067AbZHUFzp
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 01:55:45 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56334 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbZHUFzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 01:55:44 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B766681811E;
	Fri, 21 Aug 2009 07:55:36 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 982A18180F0;
	Fri, 21 Aug 2009 07:55:33 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126687>

This is a reroll of the series I sent 9 days ago.

Patch 5/9 (revert: libify pick) now contains some fixups suggested by
Junio, so it's based on a newer commit in the sequencer repo. 

I also updated the commit message of some following patches so they
display the same commit sha1 from the sequencer repo.

Patch 8/9 has been reworked so that the --cherry-pick option use the
same arguments as other options.

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
