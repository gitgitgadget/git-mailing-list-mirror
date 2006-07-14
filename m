From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] Fix "git-fetch --tags" exit status when nothing has been changed
Date: Fri, 14 Jul 2006 19:06:57 +0400
Message-ID: <11528896171250-git-send-email-vsu@altlinux.ru>
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Fri Jul 14 17:08:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1PG1-0001vi-8t
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 17:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWGNPG7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 11:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWGNPG7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 11:06:59 -0400
Received: from mivlgu.ru ([81.18.140.87]:22175 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1030455AbWGNPG7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 11:06:59 -0400
Received: from localhost.localdomain (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with ESMTP
	id 86A108062; Fri, 14 Jul 2006 19:06:57 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.ga319
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23890>

After commit 55b7835e1b81a6debc7648149d2b8a4c5c64ddba git-fetch --tags
exits with status 1 when no tags have been changed, which breaks calling
git-fetch from scripts.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 git-fetch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index ff17699..ee99280 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -153,7 +153,7 @@ fast_forward_local () {
 	then
 		if now_=$(cat "$GIT_DIR/$1") && test "$now_" = "$2"
 		then
-			[ "$verbose" ] && echo >&2 "* $1: same as $3"
+			[ "$verbose" ] && echo >&2 "* $1: same as $3" ||:
 		else
 			echo >&2 "* $1: updating with $3"
 			git-update-ref -m "$rloga: updating tag" "$1" "$2"
-- 
1.4.1.ga319
