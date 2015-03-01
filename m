From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] git: make was_alias non-static
Date: Sun,  1 Mar 2015 12:48:51 +0600
Message-ID: <1425192531-11951-1-git-send-email-kuleshovmail@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 07:49:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRxgi-0003lu-CA
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 07:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbbCAGtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 01:49:05 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:42155 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbCAGtD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 01:49:03 -0500
Received: by lbiw7 with SMTP id w7so24385825lbi.9
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 22:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rQTt2esPogfkqEANXUnvCWq0OWQn8LjXZtP6vRF4XGs=;
        b=KF4daUEHX2sbh9TQzWh6OGosf/xPshT0G8N9DB31u+dbu56F8CERqqKFcav+hYVdy9
         TvwP4zl3ifzzWsdhO7ib3/M580qo9cvEAzig6zzoRu5W8Zkqxmpaej4JmG4Zc9NRCEKy
         dCnrBOobr11L/mAr11SNfWyeMIn8oECZDQlA7hwHn0I6wVYWjtrINP/DSsAzCYmtc1nv
         sDsjJqIOuTbOkNEmTWubwnHku01N+6CduAK59T8aOOJE0Bz4Nzxk2JCcZ5ZNYVqw5KJV
         xBaTXJbAlaDfdKjYauUVRGwmkYG5IhhjhkYxYwfjab5tmH60AdOSsDisjLiRTgxNAYGI
         tTKg==
X-Received: by 10.112.85.140 with SMTP id h12mr19083966lbz.67.1425192540917;
        Sat, 28 Feb 2015 22:49:00 -0800 (PST)
Received: from localhost.localdomain ([37.151.37.66])
        by mx.google.com with ESMTPSA id 5sm22825lar.11.2015.02.28.22.48.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Feb 2015 22:48:59 -0800 (PST)
X-Mailer: git-send-email 2.3.1.422.ge618558.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264551>

'was_alias' variable does not need to store it's value each iteration in the
loop, anyway this variable changes it's value with run_argv. So it does not
need to be static.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 1780233..b8b6520 100644
--- a/git.c
+++ b/git.c
@@ -682,7 +682,7 @@ int main(int argc, char **av)
 
 	while (1) {
 		static int done_help = 0;
-		static int was_alias = 0;
+		int was_alias = 0;
 		was_alias = run_argv(&argc, &argv);
 		if (errno != ENOENT)
 			break;
-- 
2.3.1.422.ge618558.dirty
