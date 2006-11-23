X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] git-svn: preserve uncommitted changes after dcommit
Date: Thu, 23 Nov 2006 14:54:05 -0800
Message-ID: <11643224483832-git-send-email-normalperson@yhbt.net>
References: <1164322445180-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Thu, 23 Nov 2006 22:54:33 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g22a08
In-Reply-To: <1164322445180-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32163>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNSS-0005y8-QT for gcvg-git@gmane.org; Thu, 23 Nov
 2006 23:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934199AbWKWWyM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 17:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934113AbWKWWyL
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 17:54:11 -0500
Received: from hand.yhbt.net ([66.150.188.102]:3796 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1757485AbWKWWyJ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 17:54:09 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 38D847DC0F9; Thu, 23 Nov 2006 14:54:08 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 23 Nov 2006
 14:54:08 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Using dcommit could cause the user to lose uncommitted changes
during the reset --hard operation, so change it to reset --mixed.

If dcommit chooses the rebase path, then git-rebase will already
error out when local changes are made.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6feae56..bb8935a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -623,7 +623,7 @@ sub dcommit {
 	} else {
 		print "No changes between current HEAD and $gs\n",
 		      "Hard resetting to the latest $gs\n";
-		@finish = qw/reset --hard/;
+		@finish = qw/reset --mixed/;
 	}
 	sys('git', @finish, $gs);
 }
-- 
1.4.4.1.g22a08
