From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 02/14] t9142: Move call to start_httpd into the setup test
Date: Tue, 14 Dec 2010 18:20:38 +0000
Message-ID: <4D07B576.6020700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:45:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZse-0004kc-A2
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418Ab0LNSp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:45:28 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:37969 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754493Ab0LNSp2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:45:28 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZsM-0001jQ-bu; Tue, 14 Dec 2010 18:45:27 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163663>


In addition to being more consistent with the other calls to
start_httpd in tests t9115-*.sh, t9118-*.sh and t9120-*.sh, this
has the added benefit of making the test less noisy. (start_httpd
writes "SVN_HTTPD_PORT is not defined!" on stderr.)

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t9142-git-svn-shallow-clone.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t9142-git-svn-shallow-clone.sh b/t/t9142-git-svn-shallow-clone.sh
index 1236acc..e21ee5f 100755
--- a/t/t9142-git-svn-shallow-clone.sh
+++ b/t/t9142-git-svn-shallow-clone.sh
@@ -17,11 +17,10 @@ test_expect_success 'setup test repository' '
 		> foo &&
 		svn_cmd add foo &&
 		svn_cmd commit -m "add foo"
-	)
+	) &&
+	start_httpd
 '
 
-start_httpd
-
 test_expect_success 'clone trunk with "-r HEAD"' '
 	git svn clone -r HEAD "$svnrepo/trunk" g &&
 	( cd g && git rev-parse --symbolic --verify HEAD )
-- 
1.7.3
