From: Marius Storm-Olsen <git@storm-olsen.com>
Subject: [PATCH] Add bare repository indicator for __git_ps1
Date: Sat, 21 Feb 2009 15:48:43 +0100
Message-ID: <1235227723-11471-1-git-send-email-git@storm-olsen.com>
Cc: git@vger.kernel.org, Marius Storm-Olsen <git@storm-olsen.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Feb 21 15:53:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LatDX-0002Qo-47
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 15:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbZBUOvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 09:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbZBUOvE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 09:51:04 -0500
Received: from hoat.troll.no ([62.70.27.150]:57430 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbZBUOvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 09:51:03 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 8C22E211B4;
	Sat, 21 Feb 2009 15:50:56 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id 75FD421040;
	Sat, 21 Feb 2009 15:50:56 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc0.5.gf970
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110957>

Prefixes the branch name with "BARE:" if you're in a
bare repository.

Signed-off-by: Marius Storm-Olsen <git@storm-olsen.com>
---
 Ok, had some free cycles, so here's fixed up version.
 Based on next this time

 contrib/completion/git-completion.bash |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ec587d2..e585d40 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -135,11 +135,17 @@ __git_ps1 ()
 			fi
 		fi
 
+		local c
+
+		if [ "true" = "$(git config --bool core.bare 2>/dev/null)" ]; then
+			c="BARE:"
+		fi
+
 		if [ -n "$b" ]; then
 			if [ -n "${1-}" ]; then
-				printf "$1" "${b##refs/heads/}$w$i$r"
+				printf "$1" "$c${b##refs/heads/}$w$i$r"
 			else
-				printf " (%s)" "${b##refs/heads/}$w$i$r"
+				printf " (%s)" "$c${b##refs/heads/}$w$i$r"
 			fi
 		fi
 	fi
-- 
1.6.2.rc1.20.g8c5b
