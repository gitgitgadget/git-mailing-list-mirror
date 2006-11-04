X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Added bash completion support for git-reset.
Date: Sat, 4 Nov 2006 13:57:44 -0500
Message-ID: <20061104185744.GB2500@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 18:57:59 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30935>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgQiF-0007hL-Pc for gcvg-git@gmane.org; Sat, 04 Nov
 2006 19:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965607AbWKDS5s (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 13:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965608AbWKDS5s
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 13:57:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:62178 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965607AbWKDS5r
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 13:57:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgQi2-0007Dm-AW; Sat, 04 Nov 2006 13:57:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0FC1120E491; Sat,  4 Nov 2006 13:57:44 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Completion for the --hard/--soft/--mixed modes of operation as
well as a ref name for <commit-ish> can be very useful and save
some fingers.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b7b8a43..a3fbb90 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -271,6 +271,13 @@ _git_push ()
 	esac
 }
 
+_git_reset ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local opt="--mixed --hard --soft"
+	COMPREPLY=($(compgen -W "$opt $(__git_refs .)" -- "$cur"))
+}
+
 _git_show ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -304,6 +311,7 @@ _git ()
 		ls-tree)     _git_ls_tree ;;
 		pull)        _git_pull ;;
 		push)        _git_push ;;
+		reset)       _git_reset ;;
 		show)        _git_show ;;
 		show-branch) _git_log ;;
 		whatchanged) _git_log ;;
@@ -332,6 +340,7 @@ complete -o default -o nospace -F _git_l
 complete -o default            -F _git_merge_base git-merge-base
 complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
+complete -o default            -F _git_reset git-reset
 complete -o default            -F _git_show git-show
 complete -o default -o nospace -F _git_log git-whatchanged
 
-- 
