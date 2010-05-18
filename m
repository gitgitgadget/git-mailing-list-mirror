From: Yann Droneaud <yann@droneaud.fr>
Subject: [PATCH] t9129: fix UTF-8 locale detection
Date: Tue, 18 May 2010 16:41:25 +0200
Message-ID: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
Cc: Yann Droneaud <yann@droneaud.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 18 16:41:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OENzV-0006ah-GZ
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 16:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab0EROln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 10:41:43 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:50740 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab0EROll (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 10:41:41 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 8B3F8E08119;
	Tue, 18 May 2010 16:41:35 +0200 (CEST)
Received: from mais.quest-ce.net (mais.quest-ce.net [88.161.129.79])
	by smtp6-g21.free.fr (Postfix) with ESMTP;
	Tue, 18 May 2010 16:41:33 +0200 (CEST)
Received: by mais.quest-ce.net (Postfix, from userid 500)
	id A02487C055; Tue, 18 May 2010 16:41:25 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147283>

Since I don't have en_US.utf8, some tests failed:

  * UTF-8 locale not available, test skipped
  * skip 10: ISO-8859-1 should match UTF-8 in svn
  * skip 11: eucJP should match UTF-8 in svn
  * skip 12: ISO-2022-JP should match UTF-8 in svn

On my system locale -a reports:

   en_US
   en_US.ISO-8859-1
   en_US.UTF-8

According to Wikipedia utf8 is not a correct name
for the UTF-8 encoding:
http://en.wikipedia.org/wiki/UTF-8#Official_name_and_incorrect_variants

And compare_svn_head_with() is explicitly using en_US.UTF-8
locale.

Signed-off-by: Yann Droneaud <yann@droneaud.fr>
---
 t/t9129-git-svn-i18n-commitencoding.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index b9224bd..ec6ed4f 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -69,7 +69,7 @@ do
 	'
 done
 
-if locale -a |grep -q en_US.utf8; then
+if locale -a |grep -q en_US.UTF-8; then
 	test_set_prereq UTF8
 else
 	say "UTF-8 locale not available, test skipped"
-- 
1.6.4.4
