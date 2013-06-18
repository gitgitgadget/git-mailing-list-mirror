From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/8] wt-status: remove unused field in grab_1st_switch_cbdata
Date: Tue, 18 Jun 2013 17:44:24 +0530
Message-ID: <1371557670-12534-3-git-send-email-artagnon@gmail.com>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uour6-00080s-QC
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab3FRMRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:17:40 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:60447 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3FRMRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:17:39 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so3852478pbc.11
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WaTanry9Vuj/90Nf8Y4Y6X9jXd7FHfmEAXCEZLqhApw=;
        b=Hgay1uiG+wg8HPbw9cfO+Ev6Yegr7F/kD2kDMIMCpQ3QEjOhBY9iYGN23CpfxikBrD
         PbeDkywkeet/J5dYUO7brZAg9wEMe7ixB03BkhDzBbvUMx0R5DltkgKEf4jdpqvxaWjK
         Vok5f5bowj64XwsSgGfpKjiAEJyczmtuFaDhsQM7ljDUMC9Mq6+hyTgd59KsRAUxFC/D
         zU4dVg6gyP9USCQcuefGFwcvnH3OU34SjKMivnE3EdUVy/rguG5fnzvlayckFhxBxHqq
         jrQDgfaQpS3Ngqr0We1wsrjxccMHDn5xVTamBrJov2lmwvgvuSn2pl6CfkORD+SGooZM
         SUTg==
X-Received: by 10.68.211.73 with SMTP id na9mr17111301pbc.90.1371557858494;
        Tue, 18 Jun 2013 05:17:38 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id fm2sm19398332pab.13.2013.06.18.05.17.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 05:17:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6
In-Reply-To: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228207>

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
1.8.3.1.456.gb7f4cb6
