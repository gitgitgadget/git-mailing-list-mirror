From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] merge: simplify ff-only option
Date: Sat, 14 Sep 2013 01:38:35 -0500
Message-ID: <1379140717-12940-4-git-send-email-felipe.contreras@gmail.com>
References: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:44:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjaP-0003XB-Qp
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab3INGoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:44:00 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:55326 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab3INGn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:43:59 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so1977325oag.40
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HIEat1HvXSbvCb5ZdEIDBdzBNGaqx9AyvEATds2EF48=;
        b=XMI5ehlXglaSydelecj5B2p98JMYz+DXlzLay0IcSYMImGM8o936+kjrX/4lZuTjjs
         28Napp4GjjWi4qY36rsf1G2txnegPBVrDVzCLnFmH6tLlFw0/1xgV6SZ+LtmtfQdehuV
         r63sTpRESgr/pETec8uQdaWex5mqdl6gBTLVsYqWBPnk41192Ax2WTpXQQztYd7HoE+9
         usX5KvFuHg9KgjHz0qaidk1Auqcn/d8suM8VxxHS2uV+Ac7+m8wqj69ncQ34tfv/vgiZ
         MbePtk5WV+VFPIZxhNggVw5qeiLvaj4k3nXVPdCw6rHRCCvA6jpiA50yo8OCvYbQNm97
         3ALg==
X-Received: by 10.60.68.135 with SMTP id w7mr16196907oet.9.1379141037711;
        Fri, 13 Sep 2013 23:43:57 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm20366239obc.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:43:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234799>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 34a6166..da9fc08 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -186,13 +186,6 @@ static int option_parse_n(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_ff_only(const struct option *opt,
-			  const char *arg, int unset)
-{
-	fast_forward = FF_ONLY;
-	return 0;
-}
-
 static struct option builtin_merge_options[] = {
 	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
 		N_("do not show a diffstat at the end of the merge"),
@@ -210,9 +203,9 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
-	{ OPTION_CALLBACK, 0, "ff-only", NULL, NULL,
+	{ OPTION_SET_INT, 0, "ff-only", &fast_forward, NULL,
 		N_("abort if fast-forward is not possible"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG, option_parse_ff_only },
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
 		N_("Verify that the named commit has a valid GPG signature")),
-- 
1.8.4-fc
