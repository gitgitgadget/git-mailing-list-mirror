From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn: t9114: verify merge commit message in test
Date: Mon,  5 Nov 2007 03:21:48 -0800
Message-ID: <1194261708-32256-2-git-send-email-normalperson@yhbt.net>
References: <1194261708-32256-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 12:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip01v-0006xA-Qn
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 12:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbXKELVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 06:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbXKELVw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 06:21:52 -0500
Received: from hand.yhbt.net ([66.150.188.102]:51092 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589AbXKELVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 06:21:51 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id EBA5F7DC109;
	Mon,  5 Nov 2007 03:21:49 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 05 Nov 2007 03:21:49 -0800
X-Mailer: git-send-email 1.5.3.5.566.gc207
In-Reply-To: <1194261708-32256-1-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63497>

It's possible that we end up with an incorrect commit message
in this test after making changes to fix the clobber bug
in dcommit.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9114-git-svn-dcommit-merge.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index d6ca955..225060b 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -86,4 +86,9 @@ test_expect_success 'verify post-merge ancestry' "
 	git cat-file commit refs/heads/svn^ | grep '^friend$'
 	"
 
+test_expect_success 'verify merge commit message' "
+	git rev-list --pretty=raw -1 refs/heads/svn | \
+	  grep \"    Merge branch 'merge' into svn\"
+	"
+
 test_done
-- 
1.5.3.5.566.gc207
