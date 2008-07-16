From: Stephan Beyer <s-beyer@gmx.net>
Subject: Sequencer migration patches
Date: Wed, 16 Jul 2008 22:45:19 +0200
Message-ID: <cover.1216233918.git.s-beyer@gmx.net>
References: <fd9b4f2b04c9b997c6bdba90352eb1ef973114ae.1216233915.git.s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:46:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDtS-0004T8-4b
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbYGPUpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756671AbYGPUpc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:45:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:47826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754728AbYGPUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:45:32 -0400
Received: (qmail invoked by alias); 16 Jul 2008 20:45:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp006) with SMTP; 16 Jul 2008 22:45:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+WDHk2UWaWkOTGtPsdKHADoIvf0opaqx0EAHC5yq
	BnPmTe/B6PUJHc
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJDsI-0005nw-FB; Wed, 16 Jul 2008 22:45:22 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <fd9b4f2b04c9b997c6bdba90352eb1ef973114ae.1216233915.git.s-beyer@gmx.net> 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88750>

Hi,

the following patches migrate git-am and git-rebase--interactive to
git-sequencer.

But there are some issues I want to mention.

I've compared performance of original rebase and am with the
sequencer-based ones and the sequencer-based ones perform fairly bad.
For example, applying 45 patches with git-am took 3 seconds using the
original and 8 seconds using the sequencer-based one.
Rebasing 100 commits takes 10.1 seconds instead of only 4.8 seconds
on my test machine.

I expect that the builtin-sequencer performs muuuch better.
But as long as there is no builtin-sequencer these patches should
perhaps not be applied.
Well, I could offer to provide patches to put sequencer-based git-am and
git-rebase-i scripts to contrib/examples/ (or contrib/sequencer-examples/
or something else). ;-)

Regards,
  Stephan


Stephan Beyer (2):
  Migrate git-am to use git-sequencer
  Introduce git am --abort

 Documentation/git-am.txt               |    5 +-
 Documentation/git-rerere.txt           |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 git-am.sh                              |  617 +++++++++++---------------------
 git-rebase.sh                          |    7 +-
 t/t4150-am.sh                          |   27 +-
 6 files changed, 244 insertions(+), 416 deletions(-)


Stephan Beyer (1):
  Migrate rebase-i to sequencer

 git-rebase--interactive.sh    |  438 ++++++++++-------------------------------
 t/t3404-rebase-interactive.sh |    9 +-
 2 files changed, 113 insertions(+), 334 deletions(-)
