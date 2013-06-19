From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 2/7] wt-status: remove unused field in grab_1st_switch_cbdata
Date: Wed, 19 Jun 2013 13:34:44 +0530
Message-ID: <1371629089-27008-3-git-send-email-artagnon@gmail.com>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 10:08:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDRM-0001ly-5G
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 10:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673Ab3FSIIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 04:08:17 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:43279 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab3FSIID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 04:08:03 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so4809655pbb.20
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gDg9uzN4e4QjK4gviOlVvx6opNQ/V+WQXrgbIK7mTQU=;
        b=Yo98wo4V8PsLCR0CSXENx5leEI77ob/oS+88BtLs7ujBSXt7RDe8GIHz9rb1c5k7Cn
         MoKDHGZBPQNQO4X1DlVJ5YgD8srPAH39J7yNLyfwStDHZyO1wvTGwz0cFiPPPeIE+QgT
         /Xo7d63NTcesB4eD5t6psfEvw4l+/BsJ2H+1FpqRZ/LN7ePssgm+m+bJCN3Ctvtldi8t
         vmWsTFUCkAwYEW1ejZniGJ9gtku8jqF/6Yjwn/X0E/93ZVQTjO2doXPGwCNUNjF16AdT
         J0BKZCYo/pKqPtjHYymeVgQ8WQvnsExjsYAm86ivB5ODO2trNhigDWqtj7WDN6sgbUWs
         8WbA==
X-Received: by 10.69.12.65 with SMTP id eo1mr1598812pbd.205.1371629282294;
        Wed, 19 Jun 2013 01:08:02 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm23663400pac.20.2013.06.19.01.08.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 01:08:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.449.g41b32a4.dirty
In-Reply-To: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228372>

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
1.8.3.1.449.g41b32a4.dirty
