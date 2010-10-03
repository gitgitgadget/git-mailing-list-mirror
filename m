From: Yann Dirson <ydirson@altern.org>
Subject: [RFC PATCH v4 0/4] Detection of directory renames
Date: Sun,  3 Oct 2010 22:42:05 +0200
Message-ID: <1286138529-6780-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 22:32:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2VEf-000189-Ah
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 22:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971Ab0JCUc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 16:32:27 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:32796 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab0JCUc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 16:32:26 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id C14E8D4815D;
	Sun,  3 Oct 2010 22:32:20 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2VNu-0001qO-3G; Sun, 03 Oct 2010 22:42:14 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157917>

At last a reroll of that old series.  The most prominent change is a
split of the old --factorize-renames flag into --detect-dir-renames
and --hide-dir-rename-details - hopefully following Junio's comments
dated nearly 2 years ago.  While doing this, a couple of testcases got
added (as well as a list of more testcases to be written), and some
minor optimizations were done, but no heavy surgery.

I hope we can turn the simple detection feature to something
acceptable for inclusion - that is, once unified diff output shows the
detected renames as annotations, and once the known major holes are
plugged (both from FIXME and testcases).  For the "hiding" one OTOH, a
more precise description of what we want must probably be done before
progressing, but I suggest we keep that for later.

Also, maybe the --detect-dir-renames would get a good alias as "-M -M".

Does all of that look reasonable ?

Yann Dirson (4):
  Introduce wholesame directory move detection in diffcore.
  Add testcases for the --detect-dir-renames diffcore flag.
  Allow hiding renames of individual files involved in a directory
    rename.
  Add testcases for the --hide-dir-rename-details diffcore flag.

 diff-lib.c                       |    6 +-
 diff.c                           |   12 +
 diff.h                           |    6 +
 diffcore-rename.c                |  316 +++++++++++++++++++++++++++-
 diffcore.h                       |    1 +
 t/t4046-diff-rename-factorize.sh |  433 ++++++++++++++++++++++++++++++++++++++
 tree-diff.c                      |    4 +-
 7 files changed, 766 insertions(+), 12 deletions(-)
 create mode 100755 t/t4046-diff-rename-factorize.sh

-- 
1.7.2.3
