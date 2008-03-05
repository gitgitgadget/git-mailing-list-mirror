From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] bash: add 'git svn' subcommands
Date: Wed,  5 Mar 2008 20:28:05 +0100
Message-ID: <ad6d56c74f4e5ae29dc8176eba6e7381c12a3351.1204745177.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, spearce@spearce.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 20:28:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWzIE-0002mG-Nm
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 20:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbYCET2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 14:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755088AbYCET2I
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 14:28:08 -0500
Received: from francis.fzi.de ([141.21.7.5]:19310 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754256AbYCET2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 14:28:07 -0500
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Mar 2008 20:28:05 +0100
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 05 Mar 2008 19:28:05.0166 (UTC) FILETIME=[08EA64E0:01C87EF7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76254>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   29 ++++++++++++++++++++++++=
++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 23e5994..8f56641 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -384,7 +384,6 @@ __git_commands ()
 		show-index)       : plumbing;;
 		ssh-*)            : transport;;
 		stripspace)       : plumbing;;
-		svn)              : import export;;
 		symbolic-ref)     : plumbing;;
 		tar-tree)         : deprecated;;
 		unpack-file)      : plumbing;;
@@ -1164,6 +1163,32 @@ _git_submodule ()
 	fi
 }
=20
+_git_svn ()
+{
+	local i c=3D1 command
+
+	while [ $c -lt $COMP_CWORD ]; do
+		i=3D"${COMP_WORDS[c]}"
+		case "$i" in
+		init|fetch|clone|rebase|dcommit|log|find-rev|\
+		set-tree|commit-diff|info|\
+		create-ignore|propget|proplist|show-ignore|show-externals)
+			command=3D"$i"
+			break
+			;;
+		esac
+		c=3D$((++c))
+	done
+
+	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
+		__gitcomp "
+			init fetch clone rebase dcommit log find-rev
+			set-tree commit-diff info create-ignore propget
+			proplist show-ignore show-externals
+			"
+	fi
+}
+
 _git_tag ()
 {
 	local i c=3D1 f=3D0
@@ -1265,6 +1290,7 @@ _git ()
 	show-branch) _git_log ;;
 	stash)       _git_stash ;;
 	submodule)   _git_submodule ;;
+	svn)         _git_svn ;;
 	tag)         _git_tag ;;
 	whatchanged) _git_log ;;
 	*)           COMPREPLY=3D() ;;
@@ -1315,6 +1341,7 @@ complete -o default -o nospace -F _git_shortlog g=
it-shortlog
 complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_stash git-stash
 complete -o default -o nospace -F _git_submodule git-submodule
+complete -o default -o nospace -F _git_svn git-svn
 complete -o default -o nospace -F _git_log git-show-branch
 complete -o default -o nospace -F _git_tag git-tag
 complete -o default -o nospace -F _git_log git-whatchanged
--=20
1.5.4.3

