X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Teach bash how to complete long options for git-commit.
Date: Tue, 28 Nov 2006 12:12:08 -0500
Message-ID: <20061128171208.GA28830@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 17:12:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32550>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp6VF-0002kZ-52 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 18:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758707AbWK1RMN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 12:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758706AbWK1RMN
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 12:12:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:24213 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758705AbWK1RML
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 12:12:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gp6V1-0003Js-Nq; Tue, 28 Nov 2006 12:12:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A645620FB7F; Tue, 28 Nov 2006 12:12:08 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 It appears as though this patch was dropped, probably due
 to the fact that paint commonly dries faster than tab
 completion of --author= on the kernel.git repository runs.

 So this is a resubmit without the paint drying features.

 contrib/completion/git-completion.bash |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d8ae4d7..be978cf 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -398,6 +398,20 @@ _git_cherry_pick ()
 	esac
 }
 
+_git_commit ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		COMPREPLY=($(compgen -W "
+			--all --author= --signoff --verify --no-verify
+			--edit --amend --include --only
+			" -- "$cur"))
+		return
+	esac
+	COMPREPLY=()
+}
+
 _git_diff ()
 {
 	__git_complete_file
@@ -768,6 +782,7 @@ _git ()
 	cat-file)    _git_cat_file ;;
 	checkout)    _git_checkout ;;
 	cherry-pick) _git_cherry_pick ;;
+	commit)      _git_commit ;;
 	diff)        _git_diff ;;
 	diff-tree)   _git_diff_tree ;;
 	fetch)       _git_fetch ;;
@@ -804,6 +819,7 @@ complete -o default            -F _git_branch git-branch
 complete -o default -o nospace -F _git_cat_file git-cat-file
 complete -o default            -F _git_checkout git-checkout
 complete -o default            -F _git_cherry_pick git-cherry-pick
+complete -o default            -F _git_commit git-commit
 complete -o default -o nospace -F _git_diff git-diff
 complete -o default            -F _git_diff_tree git-diff-tree
 complete -o default -o nospace -F _git_fetch git-fetch
-- 
1.4.4.1.g289c2
