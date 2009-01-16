From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 5/5] bash: refactor 'git log --pretty=<format>' options
Date: Fri, 16 Jan 2009 17:02:15 +0100
Message-ID: <1232121735-10239-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNrAc-0007SL-1E
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbZAPQCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 11:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbZAPQCR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:02:17 -0500
Received: from francis.fzi.de ([141.21.7.5]:55254 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754821AbZAPQCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 11:02:16 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 17:02:14 +0100
X-Mailer: git-send-email 1.6.1.198.geb475f
X-OriginalArrivalTime: 16 Jan 2009 16:02:14.0864 (UTC) FILETIME=[CC829D00:01C977F3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105969>

Both 'git log' and 'show' have the same '--pretty=3D<format>' option
with the same formats.  So refactor these formats into a common
variable.

While at it, also add 'format:' to the list.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 3a26d2b..b5b40c2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -947,6 +947,8 @@ _git_ls_tree ()
 	__git_complete_file
 }
=20
+__git_log_pretty_formats=3D"oneline short medium full fuller email raw=
 format:"
+
 _git_log ()
 {
 	__git_has_doubledash && return
@@ -954,8 +956,7 @@ _git_log ()
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--pretty=3D*)
-		__gitcomp "
-			oneline short medium full fuller email raw
+		__gitcomp "$__git_log_pretty_formats
 			" "" "${cur##--pretty=3D}"
 		return
 		;;
@@ -1487,8 +1488,7 @@ _git_show ()
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--pretty=3D*)
-		__gitcomp "
-			oneline short medium full fuller email raw
+		__gitcomp "$__git_log_pretty_formats
 			" "" "${cur##--pretty=3D}"
 		return
 		;;
--=20
1.6.1.198.geb475f
