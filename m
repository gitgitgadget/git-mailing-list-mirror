From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-svn: fix test for trunk svn (commit message not needed)
Date: Fri, 21 Sep 2007 14:02:33 +1200
Message-ID: <11903401551014-git-send-email-sam.vilain@catalyst.net.nz>
References: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 04:32:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYYJD-00072h-S2
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 04:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbXIUCbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 22:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbXIUCby
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 22:31:54 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:37086 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbXIUCbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 22:31:53 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IYXqm-0003ZX-58; Fri, 21 Sep 2007 14:02:36 +1200
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 11D5D2C6DD; Fri, 21 Sep 2007 14:02:35 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58820>

The 'svn mv -m "rename to thunk"' was a local operation, therefore not
needing a commit message, it was silently ignored.  Newer svn clients will
instead raise an error.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 t/t9104-git-svn-follow-parent.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index d8f9cab..9eab945 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -19,8 +19,7 @@ test_expect_success 'initialize repo' "
 	poke trunk/readme &&
 	svn commit -m 'another commit' &&
 	svn up &&
-	svn mv -m 'rename to thunk' trunk thunk &&
-	svn up &&
+	svn mv trunk thunk &&
 	echo goodbye >> thunk/readme &&
 	poke thunk/readme &&
 	svn commit -m 'bye now' &&
-- 
1.5.2.4
