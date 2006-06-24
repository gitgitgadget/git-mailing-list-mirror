From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] git-repack -- respect -q and be quiet
Date: Sat, 24 Jun 2006 21:41:25 +1200
Message-ID: <1151142085815-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 24 11:41:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu4ds-00060K-2b
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 11:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933375AbWFXJlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 05:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933376AbWFXJlX
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 05:41:23 -0400
Received: from bm-4a.paradise.net.nz ([203.96.152.183]:19640 "EHLO
	linda-4.paradise.net.nz") by vger.kernel.org with ESMTP
	id S933375AbWFXJlW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 05:41:22 -0400
Received: from smtp-3.paradise.net.nz
 (tclsnelb1-src-1.paradise.net.nz [203.96.152.172]) by linda-4.paradise.net.nz
 (Paradise.net.nz) with ESMTP id <0J1C00M1XYWW1V@linda-4.paradise.net.nz> for
 git@vger.kernel.org; Sat, 24 Jun 2006 21:41:21 +1200 (NZST)
Received: from localhost.localdomain
 (203-79-116-174.cable.paradise.net.nz [203.79.116.174])
	by smtp-3.paradise.net.nz (Postfix) with ESMTP id B9830D15663; Sat,
 24 Jun 2006 21:41:20 +1200 (NZST)
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.4.1.rc1.g59c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22495>

git-repack was passing the -q along to pack-objects but ignoring it
itself. Correct the oversight.
Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
 git-repack.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 4fb3f26..eb75c8c 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -49,8 +49,9 @@ name=$(git-rev-list --objects --all $rev
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
 else
-	echo "Pack pack-$name created."
-
+	if test "$quiet" != '-q'; then
+	    echo "Pack pack-$name created."
+	fi
 	mkdir -p "$PACKDIR" || exit
 
 	mv .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
-- 
1.4.1.rc1.g59c8
