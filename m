From: Jeff King <peff@peff.net>
Subject: [PATCH] t9600: test cvsimport from CVS working tree
Date: Sun, 2 Dec 2007 12:22:19 -0500
Message-ID: <20071202172219.GA7812@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 18:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IysWg-0004Wr-7u
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 18:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbXLBRWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 12:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbXLBRWW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 12:22:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3131 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbXLBRWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 12:22:21 -0500
Received: (qmail 22199 invoked by uid 111); 2 Dec 2007 17:22:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 12:22:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 12:22:19 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66800>

This test passes with v1.5.3.7, but not with v1.5.3.6.

Signed-off-by: Jeff King <peff@peff.net>
---
I wrote this to investigate a reported bug (which turned out
to be fixed by the recent cvsimport patches). No bug to fix,
but I think it's a good test to have in general.

 t/t9600-cvsimport.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 29fee2d..08f0f2a 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -119,4 +119,16 @@ test_expect_success 'cvsimport.module config works' '
 
 '
 
+test_expect_success 'import from a CVS working tree' '
+
+	cvs co -d import-from-wt module &&
+	cd import-from-wt &&
+		git cvsimport -a -z0 &&
+		echo 1 >expect &&
+		git log -1 --pretty=format:%s%n >actual &&
+		git diff actual expect &&
+	cd ..
+
+'
+
 test_done
-- 
1.5.3.6.2094.g0ce9a-dirty
