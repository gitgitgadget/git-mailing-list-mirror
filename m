From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 85/94] write_or_die: use warning() instead of fprintf(stderr, ...)
Date: Wed, 11 May 2016 15:17:36 +0200
Message-ID: <20160511131745.2914-86-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:22:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5W-0005UD-NA
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbcEKNWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:22:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33216 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391AbcEKNVY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so9419662wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vb34KU99aQIDdVaSp/aNKNzSJzsg7uVvyyaNvtpMtm0=;
        b=sMKsJp/LiYxiPiPkunoxUTEKegUSAIonLwBNueS/T7JJgm0r3jUfaUVKF8V+7WJHoW
         7Wm2zmhx+MlOKrNp/3eHfxk2rnUJjQvGcXpBWMU4ccFeUKUeHw0rWTxJFEbSQkMTWrB/
         vT8PrfhNyQnU6Q3QsE/U+2Wgvw2iNFOkoYTLk8a708nXtuzbKFUd6CQi8m1mREqJ1sDe
         E7Ge0anZowz0QS1WmDjIkXTTHgjSF+Q8CkLCt1wiWHZjrxer41FeTDfcfobJ6NkHzND5
         CVnF1I80hmw/IG5E0t6Ucw/DK0rh8D7zQCpEmfabEgXBb+1FEMdqj+bB8ELG9R6lUlzd
         Jckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vb34KU99aQIDdVaSp/aNKNzSJzsg7uVvyyaNvtpMtm0=;
        b=JNPen7QUwHtwawF+DIZG8Kk4OgUVDf2dF8XPd+AbDsH6Q5kAKlkvgIY5WqjnteTZ3k
         sGYQy2btncNkSxszlF+WwNtohrPCvcVEiK8mXjCfstad03S6gdIG0JyNXc4Rn481BM6a
         YLOl1WAxg1BIuhNARX/u4oaCDi5VDo4pOb7eUs2wsbjwh/YGz8Ie1M6AxcYWTn2/J9nL
         iH7e5Q9veLIq8/QwdIwgaISGAvo7sCqZFPSOneSsM0O2iw/b5eBuHr04Z2p8N+7M3EOv
         gxMjGwzC6qkff7M9nH61cxMED0KFyZC6IQEZ+qSXgOfjsJYawFwvEecgOmVU1/2g1c1N
         cb/w==
X-Gm-Message-State: AOPr4FW5Ewux4rkb1wkDiQ9wQ3KDQ+4GLJyf07/WKEinY97F6ruA0MorQ2g66x0MwAh83w==
X-Received: by 10.194.17.106 with SMTP id n10mr3740844wjd.131.1462972882761;
        Wed, 11 May 2016 06:21:22 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:21 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294308>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 write_or_die.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/write_or_die.c b/write_or_die.c
index 49e80aa..c29f677 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -87,8 +87,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
 		check_pipe(errno);
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
+		warning("%s: write error (%s)\n", msg, strerror(errno));
 		return 0;
 	}
 
@@ -98,8 +97,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
+		warning("%s: write error (%s)\n", msg, strerror(errno));
 		return 0;
 	}
 
-- 
2.8.2.490.g3dabe57
