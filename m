From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/4] "git reset --merge" related improvements
Date: Wed, 16 Sep 2009 06:14:38 +0200
Message-ID: <20090916035131.3737.33020.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Bonzini <bonzini@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 06:20:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnm0W-0007HV-DN
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 06:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbZIPEUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 00:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbZIPEU3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 00:20:29 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:54668 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbZIPEU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 00:20:28 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2CCED818085;
	Wed, 16 Sep 2009 06:20:22 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B90FB818080;
	Wed, 16 Sep 2009 06:20:19 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128602>

In this new version, the test cases that were bogus are now fixed. And
the new "git reset" option is now called "--merge-safe" (instead of
"--merge-dirty").

To make the test cases pass I had to change a little bit the way
"--merge-safe" is implemented. It now does not set the "reset" flag in the
"struct unpack_trees_options" passed to "unpack_trees()". 

And commit messages have been improved, thanks to input from Daniel, Junio
and Linus. And there is no more "exec </dev/null" in the test script, thanks
to Jakub.

I prefer to keep Stephan as the author of patch 3/4 because he designed and
implemented the new feature in the first place.

I am working on the documentation for "--merge-safe" and on improving the
existing "git reset" documentation using a table at the same time. So
another patch will be added to this series later.

Christian Couder (2):
  reset: add a few tests for "git reset --merge"
  reset: add test cases for "--merge-safe" option

Stephan Beyer (2):
  reset: use "unpack_trees()" directly instead of "git read-tree"
  reset: add option "--merge-safe" to "git reset"

 builtin-reset.c        |   81 ++++++++++++++++++++++++++++-------
 t/t7110-reset-merge.sh |  112 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+), 16 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh
