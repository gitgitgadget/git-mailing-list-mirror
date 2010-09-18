From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH (girocco) 3/3] Revert "Finalized fix, we can't git fetch any longer."
Date: Sat, 18 Sep 2010 13:58:54 +0400
Message-ID: <e1ebe5d7de07152f1e7b6c997658dedc094af3c4.1284803429.git.kirr@landau.phys.spbu.ru>
References: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Andrew Steinborn <g33kdyoo@gmail.com>
To: Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
X-From: git-owner@vger.kernel.org Sat Sep 18 11:57:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwuBB-0005oj-4I
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 11:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab0IRJ5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 05:57:39 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:42948 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab0IRJ5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 05:57:38 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id AE0C0FF66F; Sat, 18 Sep 2010 13:57:37 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1OwuCZ-0002cK-GU; Sat, 18 Sep 2010 13:59:23 +0400
X-Mailer: git-send-email 1.7.3.rc2.1.g63647
In-Reply-To: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
References: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156448>

This reverts commit 1b442bd3713465e05e7e1a2c46d2439508dd2d4e.

Andrew forgot to revert this when he was reverting his experiments
in 1cb526 (Readded the trick.) .

Andrew, please be careful not to introduce regressions - without this
fetch, svn mirrors won't update their git refs, and so would become
stale.

Cc: Andrew Steinborn <g33kdyoo@gmail.com>
---
 jobd/update.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/jobd/update.sh b/jobd/update.sh
index ea94306..36f7531 100755
--- a/jobd/update.sh
+++ b/jobd/update.sh
@@ -40,6 +40,7 @@ bang git for-each-ref --format '%(refname)	%(objectname)' >.refs-before
 case "$url" in
 	svn://* | svn+http://* | svn+https://*)
 		GIT_DIR=. bang git svn fetch
+		GIT_DIR=. bang git fetch
 		;;
 	darcs://*)
 		httpurl="${url/darcs:\/\//http://}"
-- 
1.7.3.rc2.1.g63647
