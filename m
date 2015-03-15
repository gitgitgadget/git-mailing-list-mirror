From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 3/3] t3700-add: added test for --exclude option
Date: Sun, 15 Mar 2015 19:50:37 +0600
Message-ID: <1426427437-23370-1-git-send-email-kuleshovmail@gmail.com>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 14:50:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX8wN-0002Do-EX
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 14:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbbCONur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 09:50:47 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34044 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbCONuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 09:50:46 -0400
Received: by lagg8 with SMTP id g8so20841567lag.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fh08+9Dqmz/d2/EHCvMegVCTExvGw7LEg94ACI4QGWc=;
        b=JCMiMN7qA7640bO7tNg3SGuKktNTF0izpu4dO/wxirYQOyExalsBdQUNeE1aPgUDzY
         wtnkIgYyvBltkJXqPFiwiZHPd8NQIr06PbYnBPbG1xk4nsSfUQdHBLKRRFtOl/YesPw5
         6YOFU0n9eg8fvYaahX0VM1L2NVaehykuRcmR6fELRcqAvX0311LQe+gAYnM0hWjiPFfO
         oLRb/C4p5DG8wWbtrAfWBLMFK4CiXMc+WPt8sCsyG+7u0Uuh5aFaqnLdQJI0mnXZZKYO
         dXsxOJaHLz7q4D9iXnwykC49t9OSzSe/XLm7WoRg9awG704Yp8exig/s3li0bB72vEWL
         dnAg==
X-Received: by 10.152.181.197 with SMTP id dy5mr51447158lac.57.1426427445230;
        Sun, 15 Mar 2015 06:50:45 -0700 (PDT)
Received: from localhost.localdomain ([95.56.108.218])
        by mx.google.com with ESMTPSA id p7sm1577206lag.7.2015.03.15.06.50.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Mar 2015 06:50:44 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.472.g20ceeac
In-Reply-To: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265495>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 t/t3700-add.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f7ff1f5..c52a5d0 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -81,6 +81,13 @@ test_expect_success '.gitignore is honored' '
 	! (git ls-files | grep "\\.ig")
 '
 
+test_expect_success 'Test that "git add --exclude" works' '
+	touch foo &&
+	touch bar &&
+	git add --exclude="bar" . &&
+	! (git ls-files | grep bar)
+'
+
 test_expect_success 'error out when attempting to add ignored ones without -f' '
 	test_must_fail git add a.?? &&
 	! (git ls-files | grep "\\.ig")
-- 
2.3.3.472.g20ceeac
