X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/6] Only load .exe suffix'd completions on Cygwin.
Date: Sun, 5 Nov 2006 06:20:25 -0500
Message-ID: <20061105112025.GB20495@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 11:20:38 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30965>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggg3H-0006qA-Vu for gcvg-git@gmane.org; Sun, 05 Nov
 2006 12:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932644AbWKELUa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 06:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWKELUa
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 06:20:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40832 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932644AbWKELU2
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 06:20:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggg35-0008Kk-7i; Sun, 05 Nov 2006 06:20:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4E63920E491; Sun,  5 Nov 2006 06:20:25 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

The only platform which actually needs to define .exe suffixes as
part of its completion set is Cygwin.  So don't define them on any
other platform.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fdfbf95..926638d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -350,6 +350,7 @@ complete -o default -o nospace -F _git_l
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
+if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
 complete -o default -o nospace -F _git git.exe
 complete -o default            -F _git_branch git-branch.exe
 complete -o default -o nospace -F _git_cat_file git-cat-file.exe
@@ -361,3 +362,4 @@ complete -o default            -F _git_m
 complete -o default -o nospace -F _git_push git-push.exe
 complete -o default -o nospace -F _git_log git-show-branch.exe
 complete -o default -o nospace -F _git_log git-whatchanged.exe
+fi
-- 
1.4.3.3.g9621
