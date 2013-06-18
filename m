From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/7] wt-status: remove unused field in grab_1st_switch_cbdata
Date: Wed, 19 Jun 2013 00:25:32 +0530
Message-ID: <1371581737-10013-3-git-send-email-artagnon@gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:58:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up17J-0002Ab-5V
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933696Ab3FRS6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:58:53 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38161 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933693Ab3FRS6u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:58:50 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so4197796pdj.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M0XFbOOhdiIdX1sTn6E+Ktrj3Z7IL/lTB+1bK0u/Tso=;
        b=BM1OM5+hBzqFzs/53VG6Z1a4Vk3oCe7qqRJv3URTL2kOxGmZK80KRXO185zX2pwwFx
         1+TT8wn3PD6uCWnZzvld1fcJsGkky3AuCu20Q5sM31MQ/PJm9M58EDYUqib0Yf7HF3sR
         g198OD0i32+Hmj+EqHwP3hViBcxQv0Ia9F8z12u7WeR7h6YOzNM3rh/GklC1AGki63og
         9gGk6Mk0jMVbwY9O4l1YB0IoSuNCBHYvOq9npPOBj9Cgjre6g3YjDINJzelezryYGPJV
         QXUXxhpVJ/zs9iKvSHTbt8QPJDTgnG7CCfJUYuL87lmZQRUJxu6ifC0ARSa/9Pf1eEyC
         06qw==
X-Received: by 10.66.172.197 with SMTP id be5mr3374173pac.50.1371581930337;
        Tue, 18 Jun 2013 11:58:50 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ag4sm19432751pbc.20.2013.06.18.11.58.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:58:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.455.g5932b31
In-Reply-To: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228298>

The struct grab_1st_switch_cbdata has the field "found", which is
set in grab_1st_switch() when a match is found.  This information is
redundant and unused by any code.  The return value of the function
serves to communicate this information anyway.

Remove the field.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index bf84a86..2511270 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1035,7 +1035,6 @@ got_nothing:
 }
 
 struct grab_1st_switch_cbdata {
-	int found;
 	struct strbuf buf;
 	unsigned char nsha1[20];
 };
@@ -1059,7 +1058,6 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
 	for (end = target; *end && *end != '\n'; end++)
 		;
 	strbuf_add(&cb->buf, target, end - target);
-	cb->found = 1;
 	return 1;
 }
 
-- 
1.8.3.1.455.g5932b31
