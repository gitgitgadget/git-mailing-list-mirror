From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 0/7] add --ff option to cherry-pick
Date: Sat, 06 Mar 2010 21:34:39 +0100
Message-ID: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 03:27:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No6Dh-0001yo-My
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378Ab0CGC1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 21:27:48 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:45458 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360Ab0CGC1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 21:27:47 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 46B8E818089;
	Sun,  7 Mar 2010 03:27:37 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DED1B818019;
	Sun,  7 Mar 2010 03:27:34 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141635>

The goal of this patch series is to make it possible for "git cherry-pick"
to fast forward instead of creating a new commit if the cherry picked commit
has the same parent as the one we are cherry-picking on.

The big change since previous version is that the first patches to implement
the --ff option are based on what Junio suggested.

Christian Couder (4):
  cherry-pick: add tests for new --ff option
  Documentation: describe new cherry-pick --ff option
  cherry-pick: add a no-op --no-ff option to future proof scripts
  rebase -i: use new --ff cherry-pick option

Junio C Hamano (3):
  parse-options: add parse_options_concat() to concat options
  builtin/merge: make checkout_fast_forward() non static
  revert: add --ff option to allow fast forward when cherry-picking

 Documentation/git-cherry-pick.txt |   10 +++-
 builtin/merge.c                   |    2 +-
 builtin/revert.c                  |   47 +++++++++++++++-
 cache.h                           |    3 +
 git-rebase--interactive.sh        |   15 +----
 parse-options.c                   |   15 +++++
 parse-options.h                   |    1 +
 t/t3506-cherry-pick-ff.sh         |  106 +++++++++++++++++++++++++++++++++++++
 8 files changed, 182 insertions(+), 17 deletions(-)
 create mode 100755 t/t3506-cherry-pick-ff.sh
