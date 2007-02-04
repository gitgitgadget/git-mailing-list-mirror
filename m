From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 8/8] bash: Support internal revlist options better.
Date: Sun, 4 Feb 2007 02:38:47 -0500
Message-ID: <20070204073847.GH17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 08:39:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDbxj-0007di-5K
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 08:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbXBDHiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 02:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbXBDHiw
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 02:38:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55537 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbXBDHiv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 02:38:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDbxX-000064-P1; Sun, 04 Feb 2007 02:38:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 57CF920FBAE; Sun,  4 Feb 2007 02:38:47 -0500 (EST)
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
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38663>

format-patch/log/whatchanged all take --not and --all as options
to the internal revlist process.  So these should be supported
as possible completions.

gitk takes anything rev-list/log/whatchanged takes, so we should
use complete_revlist to handle its options.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3b1f100..466cc32 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -494,6 +494,7 @@ _git_format_patch ()
 			--signoff
 			--in-reply-to=
 			--full-index --binary
+			--not --all
 			"
 		return
 		;;
@@ -532,6 +533,7 @@ _git_log ()
 			--author= --committer= --grep=
 			--all-match
 			--pretty= --name-status --name-only
+			--not --all
 			"
 		return
 		;;
@@ -898,7 +900,7 @@ _gitk ()
 		return
 		;;
 	esac
-	__gitcomp "$(__git_refs)"
+	__git_complete_revlist
 }
 
 complete -o default -o nospace -F _git git
-- 
1.5.0.rc3.22.g5057
