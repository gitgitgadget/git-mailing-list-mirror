From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 4/6] wt-status: remove unused field in grab_1st_switch_cbdata
Date: Sun, 16 Jun 2013 14:15:14 +0530
Message-ID: <1371372316-16059-5-git-send-email-artagnon@gmail.com>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 16 10:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo8cg-00028h-7D
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 10:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034Ab3FPIra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 04:47:30 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52177 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab3FPIrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 04:47:14 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so1829955pbc.11
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o8XgEQUdbAqcLdvrNHA1XrrM3sc0hAn8lk0yRlxyZwM=;
        b=oHNfOzkCe4BLG2Osp4BnkD+KOJzrsGRvPhwaBdDS6M9ym2UKn47RkF8LDZ95bP7Jfz
         DPKSdqACa4WaDo+ICxjysvV+q0I/Cjh1P6FTCsOZ0uWZ8EeNXWDZfS7Sei7zYTsR3fhe
         akwqQM7VtqTXf76Lo3otB28F9kGJex7u8yhTrJsOC9lYoI+0CslRviA/X8a1aYQY7t9s
         M87MI/r5pn5tdtl55pp6ErAx6SiG79ZT8tFgkacGeDyJSR3ltbMybgMWFMe7PSjPIUqu
         jk92SSga82nnGYOrJhtxZbsVz05RpttQRxdSGSsRBajz6ceaP78f98zZV2RbdQs+643j
         v27g==
X-Received: by 10.68.134.131 with SMTP id pk3mr8921839pbb.83.1371372433978;
        Sun, 16 Jun 2013 01:47:13 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id vu5sm9917919pab.10.2013.06.16.01.47.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 01:47:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.443.g4fd77b9
In-Reply-To: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228000>

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
1.8.3.1.443.g4fd77b9
