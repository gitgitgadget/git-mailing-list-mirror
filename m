From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 0/8] RESEND: git notes
Date: Wed, 29 Jul 2009 04:25:18 +0200
Message-ID: <1248834326-31488-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 04:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVyrT-0007PK-Ia
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 04:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbZG2CZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 22:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755949AbZG2CZj
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 22:25:39 -0400
Received: from mx.getmail.no ([84.208.15.66]:62121 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755433AbZG2CZi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 22:25:38 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI007BLUQQ1I90@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:25:38 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI004NXUQPO310@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:25:38 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.29.20616
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124294>

Hi,

Here is a long overdue resend and improvement of the jh/notes topic in 'pu'.

The 5 first patches are pretty much unchanged (except for better attribution
of the various people who have helped improve this patch series).

The 6th patch introduces a first draft of notes tree parsing with support for
fanout subtrees. This first draft is just a straightforward implementation of
what I have picked up from the (many) discussions on this topic. As such,
this first draft focuses on correctness, rather than performance. BTW, did I
mention this was a first draft?

The 7th patch is stolen from the jh/vcs-cvs topic in 'pu', and teaches
git-fast-import to import note objects.

The final 8th patch is a relatively straightforward optimization of t3302.


Have fun! :)

...Johan


Johan Herland (4):
  Teach "-m <msg>" and "-F <file>" to "git notes edit"
  First draft of notes tree parser with support for fanout subtrees
  fast-import: Add support for importing commit notes
  t3302-notes-index-expensive: Speed up create_repo()

Johannes Schindelin (4):
  Introduce commit notes
  Add a script to edit/inspect notes
  Speed up git notes lookup
  Add an expensive test for git-notes

 .gitignore                        |    1 +
 Documentation/config.txt          |   13 ++
 Documentation/git-fast-import.txt |   45 +++++-
 Documentation/git-notes.txt       |   60 ++++++++
 Makefile                          |    3 +
 cache.h                           |    4 +
 command-list.txt                  |    1 +
 commit.c                          |    1 +
 config.c                          |    5 +
 environment.c                     |    1 +
 fast-import.c                     |   88 +++++++++++-
 git-notes.sh                      |  121 +++++++++++++++
 notes.c                           |  295 +++++++++++++++++++++++++++++++++++++
 notes.h                           |    7 +
 pretty.c                          |    5 +
 t/t3301-notes.sh                  |  149 +++++++++++++++++++
 t/t3302-notes-index-expensive.sh  |  118 +++++++++++++++
 t/t3303-notes-subtrees.sh         |  206 ++++++++++++++++++++++++++
 t/t9300-fast-import.sh            |  166 +++++++++++++++++++++
 19 files changed, 1279 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100644 notes.c
 create mode 100644 notes.h
 create mode 100755 t/t3301-notes.sh
 create mode 100755 t/t3302-notes-index-expensive.sh
 create mode 100755 t/t3303-notes-subtrees.sh
