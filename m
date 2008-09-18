From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [TopGit PATCH] tg help: <something>: improve readability
Date: Thu, 18 Sep 2008 20:29:29 +0400
Message-ID: <1221755370-6817-3-git-send-email-kirr@landau.phys.spbu.ru>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
Cc: Git Mailing List <git@vger.kernel.org>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:19:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNAC-0002JT-Vz
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbYIRRS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754588AbYIRRS2
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:18:28 -0400
Received: from vs281.server4u.cz ([81.91.85.31]:35261 "EHLO vs281.server4u.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575AbYIRRS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:18:26 -0400
Received: from localhost ([127.0.0.1] helo=roro3)
	by vs281.server4u.cz with esmtp (Exim 4.69)
	(envelope-from <kirr@landau.phys.spbu.ru>)
	id 1KgMcM-000088-To; Thu, 18 Sep 2008 18:44:35 +0200
Received: from kirr by roro3 with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1KgMNm-0001nh-3V; Thu, 18 Sep 2008 20:29:30 +0400
X-Mailer: git-send-email 1.6.0.2.250.g965aa
In-Reply-To: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96221>

Previously tg help was not showing Usage line, and with this change, now it
looks like e.g.:

$ tg help import
Usage: tg [...] import [-p PREFIX] RANGE...

        Import commits within the given revision range into TopGit,
        creating one topic branch per commit, the dependencies forming
        a linear sequence starting on your current branch.

        The branch names are auto-guessed from the commit messages
        and prefixed by t/ by default; use '-p PREFIX' to specify
        an alternative prefix (even an empty one).

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 tg.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index 545e1b8..08975ae 100644
--- a/tg.sh
+++ b/tg.sh
@@ -224,8 +224,12 @@ do_help()
 
 		echo "TopGit v0.3 - A different patch queue manager"
 		echo "Usage: tg [-r REMOTE] ($cmds|help) ..."
-	elif [ -r "@sharedir@/tg-$1.txt" ] ; then
-		cat "@sharedir@/tg-$1.txt"
+	elif [ -r "@cmddir@"/tg-$1 ] ; then
+		@cmddir@/tg-$1 -h || :
+		echo
+		if [ -r "@sharedir@/tg-$1.txt" ] ; then
+			cat "@sharedir@/tg-$1.txt"
+		fi
 	else
 		echo "`basename $0`: no help for $1" 1>&2
 	fi
-- 
1.6.0.2.250.g965aa
