From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] A test case addition for strbuf regression
Date: Wed, 18 May 2005 23:55:07 -0700
Message-ID: <7vekc3n1ro.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 08:55:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYevY-00080N-0O
	for gcvg-git@gmane.org; Thu, 19 May 2005 08:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVESGzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 02:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVESGzR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 02:55:17 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31984 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262404AbVESGzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 02:55:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519065507.QOQB16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 02:55:07 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This test would have caught the strbuf eof condition gotcha,
hopefully fixed with my previous patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
# - HEAD: fix strbuf take #2
# + (working tree)
diff --git a/strbuf.c b/strbuf.c
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -50,4 +50,13 @@ test_expect_success \
     'validate git-diff-files -p output.' \
     'cmp -s current expected'
 
+test_expect_success \
+    'build same diff using git-diff-helper.' \
+    'git-diff-files -z | git-diff-helper -z >current'
+
+
+test_expect_success \
+    'validate git-diff-helper output.' \
+    'cmp -s current expected'
+
 test_done

