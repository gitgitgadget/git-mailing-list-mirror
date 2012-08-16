From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 02/12] git p4 test: use p4d -L option to suppress log messages
Date: Thu, 16 Aug 2012 19:35:04 -0400
Message-ID: <1345160114-27654-3-git-send-email-pw@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:36:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29bf-0002wc-PO
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab2HPXf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:35:58 -0400
Received: from honk.padd.com ([74.3.171.149]:47756 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab2HPXf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:35:57 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 14F26D27;
	Thu, 16 Aug 2012 16:35:57 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D2F12313FD; Thu, 16 Aug 2012 19:35:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Send p4d output to a logfile in the $TRASH_DIRECTORY.
Its messages add no value to testing.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 482eeac..edb4033 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -35,12 +35,13 @@ db="$TRASH_DIRECTORY/db"
 cli=$(test-path-utils real_path "$TRASH_DIRECTORY/cli")
 git="$TRASH_DIRECTORY/git"
 pidfile="$TRASH_DIRECTORY/p4d.pid"
+logfile="$TRASH_DIRECTORY/p4d.log"
 
 start_p4d() {
 	mkdir -p "$db" "$cli" "$git" &&
 	rm -f "$pidfile" &&
 	(
-		p4d -q -r "$db" -p $P4DPORT &
+		p4d -q -r "$db" -p $P4DPORT -L "$logfile" &
 		echo $! >"$pidfile"
 	) &&
 
-- 
1.7.11.4
