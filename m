X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-cvsserver: fix breakage when calling git merge-file
Date: Tue, 19 Dec 2006 14:58:20 -0800
Message-ID: <20061219225820.GA6418@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 22:58:31 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34861>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwnun-0003Ks-3Z for gcvg-git@gmane.org; Tue, 19 Dec
 2006 23:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932983AbWLSW6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 17:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932996AbWLSW6Z
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 17:58:25 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34077 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932991AbWLSW6Y
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 17:58:24 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 59B6D2DC035; Tue, 19 Dec 2006 14:58:21 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 19 Dec 2006
 14:58:20 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

In the same vein as 8336afa563fbeff35e531396273065161181f04c,
this fixes the the RCS merge to git-merge-file conversion in
commit e2b70087.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-cvsserver.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 2a8447e..df39512 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -946,7 +946,7 @@ sub req_update
 
             $log->debug("Temporary directory for merge is $dir");
 
-            my $return = system("git merge-file", $file_local, $file_old, $file_new);
+            my $return = system("git", "merge-file", $file_local, $file_old, $file_new);
             $return >>= 8;
 
             if ( $return == 0 )
-- 
1.4.4.2.ga184
