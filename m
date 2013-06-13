From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] wt-status: remove unused field in grab_1st_switch_cbdata
Date: Thu, 13 Jun 2013 19:02:27 +0530
Message-ID: <1371130349-30651-5-git-send-email-artagnon@gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:30:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7cA-0003x5-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758571Ab3FMNas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:30:48 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:36719 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178Ab3FMNap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:30:45 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so10273098pbc.24
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JBvbHTUao4r+56W7HqxWn62/09tKcn7jCZtMURkTwAs=;
        b=TE35HzBf/7ZcXYCxCLOhCO1zisr1lBJ3ZpV0sCreflIjW/FWnMtJmpRoJcUT/IybdM
         42aXO/mkgSq39Q5CGxz+MqMUHAW/eEtZK3kOBkvcym1feuPdiNmwvyjt9Wzaxr9IhUUh
         ftpIWn44tU0APT4DGKJ9hecpFXl06xw4CVxaeL7eAIyH31HsmL9YFQvfjcsGgLI6gUUZ
         1L58ghgGjO2CpyYwfgbllymHz5g46KiyHVshIwZPapSPs67UFxOFRbcHtNJLL0SFkTaY
         NmABU3CjYtFC0LBitAP/qB2onD+9U/vPP3AaoXTwc46ZFLX1005h0ZHeWGryK61w8+FH
         2i6Q==
X-Received: by 10.66.219.68 with SMTP id pm4mr2859983pac.59.1371130244627;
        Thu, 13 Jun 2013 06:30:44 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id re16sm4581222pac.16.2013.06.13.06.30.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 06:30:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.384.g7cec0b4
In-Reply-To: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227729>

The struct grab_1st_switch_cbdata has the field "found", which is set in
grab_1st_switch() when a match is found.  This information is redundant
and unused by any caller: the return value of the function serves to
communicate this information anyway.  Remove the field.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
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
1.8.3.1.384.g7cec0b4
