From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] t7501-commit: Add test for git commit <file> with dirty index.
Date: Thu, 15 Nov 2007 09:49:58 -0500
Message-ID: <1195138198-24511-1-git-send-email-krh@redhat.com>
References: <Pine.LNX.4.64.0711150038020.4362@racer.site>
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 15 15:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isg8b-0006c9-67
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 15:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbXKOOz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 09:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757288AbXKOOz5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 09:55:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43219 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757870AbXKOOz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 09:55:56 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lAFEo4kC015127;
	Thu, 15 Nov 2007 09:50:04 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAFEo4TG006711;
	Thu, 15 Nov 2007 09:50:04 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lAFEo4n4022823;
	Thu, 15 Nov 2007 09:50:04 -0500
X-Mailer: git-send-email 1.5.3.5.1840.g73e86
In-Reply-To: <Pine.LNX.4.64.0711150038020.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65126>

---
 t/t7501-commit.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 5aed3de..3627d9f 100644
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -259,4 +259,14 @@ test_expect_success 'amend commit to fix author' '
 	diff expected current
 
 '
+
+test_expect_success 'git commit <file> with dirty index' '
+	echo tacocat > elif &&
+	echo tehlulz > chz &&
+	git add chz &&
+	git commit elif -m "tacocat is a palindrome" &&
+	git show --stat | grep elif &&
+	git diff --cached | grep chz
+'
+	
 test_done
-- 
1.5.3.4.206.g58ba4
