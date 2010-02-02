From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [TOPGIT PATCH] Make 'tg patch' work in subdirectories
Date: Tue,  2 Feb 2010 11:31:12 +0100
Message-ID: <1265106672-18518-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Petr Baudis <pasky@ucw.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 11:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcG2u-0004iU-04
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 11:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786Ab0BBKbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 05:31:45 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:53907 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755775Ab0BBKbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 05:31:42 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 7CC2019F333B;
	Tue,  2 Feb 2010 11:31:41 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id h+GOoWipa921; Tue,  2 Feb 2010 11:31:41 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 5960819F331D;
	Tue,  2 Feb 2010 11:31:41 +0100 (CET)
Received: from localhost.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 2704815C052;
	Tue,  2 Feb 2010 11:31:40 +0100 (CET)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138709>

When 'tg patch' is called from a subdirectory, it outputs only the
commit message and no diff.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>

---
 tg-patch.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index d701c54..f703a87 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -56,6 +56,7 @@ git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"$name"} -- |
 	fgrep -vx ".topdeps" |
 	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail randomly?
 if [ -s "$git_is_stupid" ]; then
+	cd "$root_dir"
 	cat "$git_is_stupid" | xargs git diff --patch-with-stat $diff_opts "$base_rev" ${diff_committed_only:+"$name"} --
 else
 	echo "No changes."
-- 
tg: (341a371..) t/make-patch-work-in-subdir (depends on: master)
