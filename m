From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: stop repeatedly reusing the first commit message with dcommit
Date: Sat, 26 Aug 2006 09:52:25 -0700
Message-ID: <11566111451012-git-send-email-normalperson@yhbt.net>
References: <20060826070123.GA10801@localdomain>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Aug 26 18:52:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH1OY-0000ZU-UD
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 18:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWHZQw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 12:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWHZQw1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 12:52:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42134 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030234AbWHZQw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 12:52:27 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D48CC7DC02E;
	Sat, 26 Aug 2006 09:52:25 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 26 Aug 2006 09:52:25 -0700
To: Junio C Hamano <junkio@cox.net>, seth@hand.yhbt.net
X-Mailer: git-send-email 1.4.2.g7c9b
In-Reply-To: <20060826070123.GA10801@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26051>

Excessive use of global variables got me into trouble.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9382a15..0290850 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -819,6 +819,7 @@ sub commit_diff {
 	} else {
 		$ed->close_edit;
 	}
+	$_message = $_file = undef;
 }
 
 ########################### utility functions #########################
-- 
1.4.2.g7c9b
