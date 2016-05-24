From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 01/49] builtin/apply: make gitdiff_verify_name() return void
Date: Tue, 24 May 2016 10:10:38 +0200
Message-ID: <20160524081126.16973-2-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:12:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Ra-0000fN-Ex
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbcEXILw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:11:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34990 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbcEXILs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:11:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id f75so3651490wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IJnV9D0k0p0Or4F6ogNMklA7ZgdJeVzft48ItpqkDb4=;
        b=dE9qgbanL75EsLadsmDP5eQeNqAlSlvSOMVxb5wKZl+FKdtnZIqQe4afu9JOiJUPsz
         Bd/CibnM9x1+WDixABdgsb8yzt/c88FFJr74rzcBGRJk+mmZQ7lwxPdk+zeFGuhPwP0b
         W5Bs3EDYqoW7R2tqAgaqKDlUnXTNCRTYMCc/3Ux3qnf9nLZEBqscV0408Mvy8W1Qj35v
         DdqcaTmmrOY3jrcHJk3oAFTJVaRyB6rGPFngpEldf5Unm6JOL7JAGJ85GKEjA4Y01bqe
         19w2PfVgEa1yI3VWshkSc/Gl6GX/5pWV2L5HdIQKi5SUn83LfLKY9Ylt6IqYDfViN3Dn
         GUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IJnV9D0k0p0Or4F6ogNMklA7ZgdJeVzft48ItpqkDb4=;
        b=lQ6Rl+QH01cx6V62AKKIfKpFVrIV04YPyF1VUEGuuWT3PVsVpWTsakYfAYKCWZ0wc7
         Mvpp2EP3X3NT6ljxUxcLCN0ctsvqSajZLrsJNfrJtts38/zYwhZysLvGovsGZEB59BCE
         5l+r9B7zLy/v3OPQNq+9W4EiyyHiJvkxJTRR5MIb5QRUX62juBlcXbwFoB5goYX3oaOz
         8c8IJ/B/UJMS6JRNiryg25tTW0l4BGq+i8R94cPe0Tzugbh3f/aX+IgsS9xG1vE9dMhk
         qUAR3adLfRHyKr9MjX97h4bmgCLyxr1UzhmXem3BCy6ZZI5y3iR+QMokEFirKJwIFo8e
         hJWA==
X-Gm-Message-State: ALyK8tLMvMACbNBHr3evnnchZ5Lq482bjX8X/yPhdNI5aZT49pLrdlaLqI6yp6JWB9Au3Q==
X-Received: by 10.194.169.37 with SMTP id ab5mr2795820wjc.141.1464077507215;
        Tue, 24 May 2016 01:11:47 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:46 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295428>

As the value returned by gitdiff_verify_name() is put into the
same variable that is passed as a parameter to this function,
it is simpler to pass the address of the variable and have
gitdiff_verify_name() change the variable itself.

This also makes it possible to later have this function return
-1 instead of die()ing in case of error.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8e4da2e..fe5aebd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -925,43 +925,43 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, int side)
+static void gitdiff_verify_name(const char *line, int isnull, char **name, int side)
 {
-	if (!orig_name && !isnull)
-		return find_name(line, NULL, p_value, TERM_TAB);
+	if (!*name && !isnull) {
+		*name = find_name(line, NULL, p_value, TERM_TAB);
+		return;
+	}
 
-	if (orig_name) {
-		int len = strlen(orig_name);
+	if (*name) {
+		int len = strlen(*name);
 		char *another;
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
-			    orig_name, linenr);
+			    *name, linenr);
 		another = find_name(line, NULL, p_value, TERM_TAB);
-		if (!another || memcmp(another, orig_name, len + 1))
+		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
 			    _("git apply: bad git-diff - inconsistent old filename on line %d"), linenr);
 		free(another);
-		return orig_name;
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
 			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
-		return NULL;
 	}
 }
 
 static int gitdiff_oldname(const char *line, struct patch *patch)
 {
-	patch->old_name = gitdiff_verify_name(line, patch->is_new, patch->old_name,
-					      DIFF_OLD_NAME);
+	gitdiff_verify_name(line, patch->is_new, &patch->old_name,
+			    DIFF_OLD_NAME);
 	return 0;
 }
 
 static int gitdiff_newname(const char *line, struct patch *patch)
 {
-	patch->new_name = gitdiff_verify_name(line, patch->is_delete, patch->new_name,
-					      DIFF_NEW_NAME);
+	gitdiff_verify_name(line, patch->is_delete, &patch->new_name,
+			    DIFF_NEW_NAME);
 	return 0;
 }
 
-- 
2.8.3.443.gaeee61e
