From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] t8005: use more portable character encoding names
Date: Fri, 22 May 2009 18:47:05 -0500
Message-ID: <p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 23 01:47:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7eSo-00050Q-GY
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 01:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244AbZEVXrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 19:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758150AbZEVXrZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 19:47:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36836 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758187AbZEVXrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 19:47:21 -0400
Received: by mail.nrlssc.navy.mil id n4MNlIYT002710; Fri, 22 May 2009 18:47:19 -0500
In-Reply-To: <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 22 May 2009 23:47:19.0071 (UTC) FILETIME=[A4C332F0:01C9DB37]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119754>

Some platforms do not have an extensive list of alternate names for
character encodings.

Solaris 7 does not know about shift-jis, but does know SJIS.  It also does
not know that utf-8 and UTF-8 refer to the same encoding.

With the above in mind, the following conversions were performed:

      utf-8 --> UTF-8
  shift-jis --> SJIS

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t8005-blame-i18n.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index fcd5c26..75cbced 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup the repository' '
 
 	echo "SJIS LINE" >> file &&
 	git add file &&
-	git config i18n.commitencoding shift-jis &&
+	git config i18n.commitencoding SJIS &&
 	git commit --author "$SJIS_NAME <sjis@localhost>" -m "$SJIS_MSG"
 '
 
@@ -67,8 +67,8 @@ summary $UTF8_MSG
 EOF
 
 test_expect_success \
-	'blame respects --encoding=utf-8' '
-	git blame --incremental --encoding=utf-8 file | \
+	'blame respects --encoding=UTF-8' '
+	git blame --incremental --encoding=UTF-8 file | \
 		egrep "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
-- 
1.6.3.1.24.g152f4
