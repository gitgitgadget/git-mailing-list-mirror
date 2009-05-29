From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: remove always true if statement from __git_ps1()
Date: Fri, 29 May 2009 14:00:36 +0200
Message-ID: <1243598436-2207-1-git-send-email-szeder@ira.uka.de>
References: <1243527441-3394-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ted Pavlic <ted@tedpavlic.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 29 14:00:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA0lU-0000r6-Mp
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 14:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757744AbZE2MAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 08:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbZE2MAj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 08:00:39 -0400
Received: from francis.fzi.de ([141.21.7.5]:35578 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754788AbZE2MAj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 08:00:39 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 May 2009 14:00:37 +0200
X-Mailer: git-send-email 1.6.3.1.189.g9321
In-Reply-To: <1243527441-3394-1-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 29 May 2009 12:00:37.0856 (UTC) FILETIME=[148F7E00:01C9E055]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120273>

The recent commits 8763dbb1 (completion: fix PS1 display during a
merge on detached HEAD, 2009-05-16), ff790b6a (completion: simplify
"current branch" in __git_ps1(), 2009-05-10), and d7107ca6
(completion: fix PS1 display during an AM on detached HEAD,
2009-05-26) ensure that the branch name in __git_ps1() is always set
to something sensible.  Therefore, the condition for checking the
non-empty branch name is always fulfilled, and can be removed.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

The patch is the same, but the commit message is different, because
Junio's d7107ca6 has fixed the issue.

 contrib/completion/git-completion.bash |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0c8bb53..6c78c94 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -152,12 +152,10 @@ __git_ps1 ()
 			fi
 		fi
=20
-		if [ -n "$b" ]; then
-			if [ -n "${1-}" ]; then
-				printf "$1" "$c${b##refs/heads/}$w$i$r"
-			else
-				printf " (%s)" "$c${b##refs/heads/}$w$i$r"
-			fi
+		if [ -n "${1-}" ]; then
+			printf "$1" "$c${b##refs/heads/}$w$i$r"
+		else
+			printf " (%s)" "$c${b##refs/heads/}$w$i$r"
 		fi
 	fi
 }
--=20
1.6.3.1.189.g9321
