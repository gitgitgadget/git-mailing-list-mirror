From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 37/45] tests: fix autostash
Date: Sun,  9 Jun 2013 11:40:49 -0500
Message-ID: <1370796057-25312-38-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlijU-0007SX-9h
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab3FIQoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:38 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:61062 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab3FIQof (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:35 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so855191oah.24
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Imct4LLVfNP/T09GkkC+/7ON5jFLQ07X2Yu33/pcijk=;
        b=lghTQt0doaV3kErBaaqF/2qmd9HbJ+3f01nWtt5bKo65oL8N9Up+sIF+bvNt7XxOI9
         /8u/dgj2KgZQMKMKeYYUbzSkNLs8rJv7I62mV9u1V3Ut9qN5EOSGI2C/MafhCQhuM1Av
         rwbBwcBx+ZNSyRMkXAMkdkN0xVEfZjPtqYXBy/deK6PgrhJ/wEOiIzS4CQs7YmSsfk1/
         c6oe5pmG+R3slacRdknmP9elBTdutjMaLgeod9YduMRuBaDNrbCdChpsU9013yGSNFr0
         TrFKkvRNR0TLXPxkG3cjN6YJACYmO01RzmoYNhsfZpXsUXU7d1miGwgezjCfKN4Sg1U0
         DiVA==
X-Received: by 10.60.131.104 with SMTP id ol8mr5150112oeb.104.1370796275267;
        Sun, 09 Jun 2013 09:44:35 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ei16sm15154392oeb.7.2013.06.09.09.44.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227006>

We should call 'git rebase --abort', like a normal user would do.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3420-rebase-autostash.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index a5e69f3..ff370a3 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -71,8 +71,7 @@ testrebase() {
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
 		! grep dirty file3 &&
-		rm -rf $dotest &&
-		git reset --hard &&
+		git rebase --abort &&
 		git checkout feature-branch
 	'
 
-- 
1.8.3.698.g079b096
