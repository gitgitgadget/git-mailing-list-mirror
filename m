From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v3 0/9] History traversal refinements
Date: Sun,  5 May 2013 18:32:48 +0300
Message-ID: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 17:39:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ11v-0007be-U6
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 17:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab3EEPjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 11:39:01 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:42496 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751947Ab3EEPjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 11:39:00 -0400
X-Greylist: delayed 69004 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2013 11:39:00 EDT
Received: from mail636.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 4D000DC1858
	for <git@vger.kernel.org>; Sun,  5 May 2013 17:33:02 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 5 May 2013 17:33:07 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 5 May 2013 17:33:06 +0200
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g682c2d9
X-Ovh-Tracer-Id: 8913186614384890078
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedriedvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.50008/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedriedvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223403>

New version - nothing much changed since v2.2, except the new test
set to illustrate and prove the changes. Not sure about the t6111
numbering - there wasn't space where I really wanted to put it.
And maybe it should be appended to one of the existing tests.

You will note that I'm floundering for the name for the commits I care
about in part 9. Currently at "priority", but that's horrible, not least
because it isn't an adjective. I think the word I really want is
"interesting", but that's already taken... "Relevant", "important"?

Junio C Hamano (1):
  t6012: update test for tweaked full-history traversal

Kevin Bracey (8):
  decorate.c: compact table when growing
  t6019: test file dropped in -s ours merge
  t6111: new TREESAME test set
  rev-list-options.txt: correct TREESAME for P
  revision.c: Make --full-history consider more merges
  simplify-merges: never remove all TREESAME parents
  simplify-merges: drop merge from irrelevant side branch
  revision.c: discount side branches when computing TREESAME

 Documentation/rev-list-options.txt |  38 +--
 decorate.c                         |   2 +-
 revision.c                         | 511 +++++++++++++++++++++++++++++++++----
 revision.h                         |   4 +-
 t/t6012-rev-list-simplify.sh       |  31 ++-
 t/t6019-rev-list-ancestry-path.sh  |  29 ++-
 t/t6111-rev-list-treesame.sh       | 180 +++++++++++++
 7 files changed, 723 insertions(+), 72 deletions(-)
 create mode 100755 t/t6111-rev-list-treesame.sh

-- 
1.8.3.rc0.28.g682c2d9
