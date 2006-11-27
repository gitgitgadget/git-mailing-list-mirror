X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/10] Teach bash how to complete git-cherry-pick.
Date: Mon, 27 Nov 2006 03:41:59 -0500
Message-ID: <20061127084159.GF19745@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:42:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32396>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc40-0007ej-6k for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757420AbWK0ImF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757422AbWK0ImE
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:42:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:6796 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757420AbWK0ImC
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:42:02 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc3q-0004UE-Kb; Mon, 27 Nov 2006 03:41:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1E09F20FB7F; Mon, 27 Nov 2006 03:41:59 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 729e5a9..02a60a0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -269,6 +269,21 @@ _git_checkout ()
 	COMPREPLY=($(compgen -W "-l -b $(__git_refs)" -- "$cur"))
 }
 
+_git_cherry_pick ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		COMPREPLY=($(compgen -W "
+			--edit --no-commit
+			" -- "$cur"))
+		;;
+	*)
+		COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
+		;;
+	esac
+}
+
 _git_diff ()
 {
 	__git_complete_file
@@ -472,6 +487,7 @@ _git ()
 	branch)      _git_branch ;;
 	cat-file)    _git_cat_file ;;
 	checkout)    _git_checkout ;;
+	cherry-pick) _git_cherry_pick ;;
 	diff)        _git_diff ;;
 	diff-tree)   _git_diff_tree ;;
 	fetch)       _git_fetch ;;
@@ -503,6 +519,7 @@ complete -o default            -F _gitk gitk
 complete -o default            -F _git_branch git-branch
 complete -o default -o nospace -F _git_cat_file git-cat-file
 complete -o default            -F _git_checkout git-checkout
+complete -o default            -F _git_cherry_pick git-cherry-pick
 complete -o default -o nospace -F _git_diff git-diff
 complete -o default            -F _git_diff_tree git-diff-tree
 complete -o default -o nospace -F _git_fetch git-fetch
-- 
1.4.4.1.ge3fb
