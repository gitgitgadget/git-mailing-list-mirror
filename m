From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: add 'git stash apply --index' option
Date: Fri, 14 Mar 2008 12:15:12 +0100
Message-ID: <1205493313-4717-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 12:16:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja7tV-0002vR-Qi
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 12:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYCNLP1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 07:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbYCNLP0
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 07:15:26 -0400
Received: from francis.fzi.de ([141.21.7.5]:56294 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752284AbYCNLPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 07:15:16 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Mar 2008 12:15:13 +0100
X-Mailer: git-send-email 1.5.4.4.532.ga6828
X-OriginalArrivalTime: 14 Mar 2008 11:15:13.0491 (UTC) FILETIME=[AC8AA230:01C885C4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77206>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5046f69..2265757 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1126,8 +1126,19 @@ _git_show ()
 _git_stash ()
 {
 	local subcommands=3D'save list show apply clear drop pop create'
-	if [ -z "$(__git_find_subcommand "$subcommands")" ]; then
+	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
+	else
+		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+		case "$subcommand,$cur" in
+		apply,--*)
+			__gitcomp "--index"
+			;;
+		*)
+			COMPREPLY=3D()
+			;;
+		esac
 	fi
 }
=20
--=20
1.5.4.4.532.ga6828
