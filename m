From: Marcel Koeppen <git-dev@marzelpan.de>
Subject: [PATCH] t9129-git-svn-i18n-commitencoding: Make compare_svn_head_with() compatible with OSX sed
Date: Wed, 26 Nov 2008 17:51:01 +0100
Message-ID: <1227718261-12615-1-git-send-email-git-dev@marzelpan.de>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 26 17:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Nis-00024X-6O
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 17:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbYKZQ50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 11:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbYKZQ5Z
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 11:57:25 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:54033 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYKZQ5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 11:57:25 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Nov 2008 11:57:25 EST
Received: from [80.145.219.106] (helo=localhost.localdomain)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <git-dev@marzelpan.de>)
	id 1L5NbS-0008Ll-NZ; Wed, 26 Nov 2008 17:51:02 +0100
X-Mailer: git-send-email 1.6.0.4.771.gef3b3.dirty
X-Df-Sender: 893553
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101747>

The sed call used in compare_svn_head_with() uses the + quantifier, which
is not supported in the OSX version of sed. It is replaced by the
equivalent \{1,\}.

Signed-off-by: Marcel Koeppen <git-dev@marzelpan.de>
---
 t/t9129-git-svn-i18n-commitencoding.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 2848e46..938b7fe 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -16,7 +16,7 @@ compare_git_head_with () {
 
 compare_svn_head_with () {
 	LC_ALL=en_US.UTF-8 svn log --limit 1 `git svn info --url` | \
-		sed -e 1,3d -e "/^-\+\$/d" >current &&
+		sed -e 1,3d -e "/^-\{1,\}\$/d" >current &&
 	test_cmp current "$1"
 }
 
-- 
1.6.0.4.771.gef3b3.dirty
