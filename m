From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] git-completion.bash - add support for git-bundle
Date: Sun, 12 Aug 2007 14:46:12 -0400
Message-ID: <11869443722087-git-send-email-mdl123@verizon.net>
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 20:46:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKISX-0001Nk-85
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 20:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933549AbXHLSqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 14:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933538AbXHLSqb
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 14:46:31 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:54410 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933491AbXHLSqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 14:46:30 -0400
Received: from fal-l07294-lp.us.ray.com ([71.246.233.117])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMO00ASJC52MBH7@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 12 Aug 2007 13:46:14 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc4.80.ge600
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55699>

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 contrib/completion/git-completion.bash |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 82b9ed4..52b2893 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -459,6 +459,35 @@ _git_branch ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_bundle ()
+{
+	local mycword="$COMP_CWORD"
+	case "${COMP_WORDS[0]}" in
+	git)
+		local cmd="${COMP_WORDS[2]}"
+		mycword="$((mycword-1))"
+		;;
+	git-bundle*)
+		local cmd="${COMP_WORDS[1]}"
+		;;
+	esac
+	case "$mycword" in
+	1)
+		__gitcomp "create list-heads verify unbundle"
+		;;
+	2)
+		# looking for a file
+		;;
+	*)
+		case "$cmd" in
+			create)
+				__git_complete_revlist
+			;;
+		esac
+		;;
+	esac
+}
+
 _git_checkout ()
 {
 	__gitcomp "$(__git_refs)"
@@ -1009,6 +1038,7 @@ _git ()
 	add)         _git_add ;;
 	apply)       _git_apply ;;
 	bisect)      _git_bisect ;;
+	bundle)      _git_bundle ;;
 	branch)      _git_branch ;;
 	checkout)    _git_checkout ;;
 	cherry)      _git_cherry ;;
@@ -1057,6 +1087,7 @@ complete -o default -o nospace -F _git_am git-am
 complete -o default -o nospace -F _git_apply git-apply
 complete -o default -o nospace -F _git_bisect git-bisect
 complete -o default -o nospace -F _git_branch git-branch
+complete -o default -o nospace -F _git_bundle git-bundle
 complete -o default -o nospace -F _git_checkout git-checkout
 complete -o default -o nospace -F _git_cherry git-cherry
 complete -o default -o nospace -F _git_cherry_pick git-cherry-pick
@@ -1092,6 +1123,7 @@ complete -o default -o nospace -F _git_add git-add.exe
 complete -o default -o nospace -F _git_apply git-apply.exe
 complete -o default -o nospace -F _git git.exe
 complete -o default -o nospace -F _git_branch git-branch.exe
+complete -o default -o nospace -F _git_bundle git-bundle.exe
 complete -o default -o nospace -F _git_cherry git-cherry.exe
 complete -o default -o nospace -F _git_diff git-diff.exe
 complete -o default -o nospace -F _git_format_patch git-format-patch.exe
-- 
1.5.3.rc4.80.ge600
