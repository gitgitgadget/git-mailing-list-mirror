From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/6] --dirstat fixes, part 2
Date: Tue, 26 Apr 2011 02:01:36 +0200
Message-ID: <1303776102-9085-1-git-send-email-johan@herland.net>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 02:02:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEVj9-0006nu-E9
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 02:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307Ab1DZAB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 20:01:56 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53557 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932157Ab1DZAB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 20:01:56 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LK800234G366S30@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Apr 2011 02:01:54 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id EDD0F1EEF6F1_DB60B71B	for <git@vger.kernel.org>; Tue,
 26 Apr 2011 00:01:53 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id D7E001EEF2C4_DB60B71F	for <git@vger.kernel.org>; Tue,
 26 Apr 2011 00:01:53 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LK8006GDG35AA10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Apr 2011 02:01:53 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172054>

Hi,

I finally found the time to re-roll the remaining dirstat fixes,
incorporating feedback from Linus and Junio in the surrounding thread.

The first patch adds a number of testcases for --dirstat, guarding
against regressions.

The second patch fixes a small issue I found while playing around with
--dirstat=0.

The next three patches revamps the dirstat-related command-line options
and introduces a diff.dirstat config variable for controlling the
--dirstat defaults. The third patch here (accepting floating-point
percentage input) has some remaining questions mentioned in that email.

Finally, the last patch is a re-roll of the previous "RFC/PATCH 5/3"
that introduces a new dirstat mode, based on the diffstat analysis.


Have fun! :)

...Johan


Johan Herland (6):
  Add several testcases for --dirstat and friends
  Make --dirstat=0 output directories that contribute < 0.1% of changes
  Refactor --dirstat parsing; deprecate --cumulative and --dirstat-by-file
  Add config variable for specifying default --dirstat behavior
  Use floating point for --dirstat percentages
  New --dirstat=lines mode, doing dirstat analysis based on diffstat

 Documentation/config.txt       |   43 ++
 Documentation/diff-options.txt |   52 ++-
 diff.c                         |  182 ++++++++-
 diff.h                         |    3 +-
 t/t4046-diff-dirstat.sh        |  873 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1121 insertions(+), 32 deletions(-)
 create mode 100755 t/t4046-diff-dirstat.sh

-- 
1.7.5.rc1.3.g4d7b
