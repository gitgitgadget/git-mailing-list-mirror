From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 01/83] builtin/apply: make gitdiff_verify_name() return void
Date: Sun, 24 Apr 2016 15:33:01 +0200
Message-ID: <1461504863-15946-2-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:34:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBc-0007do-ME
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbcDXNes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:34:48 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38121 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbcDXNeq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:34:46 -0400
Received: by mail-wm0-f53.google.com with SMTP id u206so89917341wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gM8oXVARd4mryQQl2keakAgfc1YtJz9527QMJFwIP14=;
        b=uP/IxPht8PYLt1i5Un91HBvoKqECPYSDDWWToezNojRD+namR40WCV25h0tUKGfFPb
         ldvnXArWoAVWbVFNXov8Mp/Km9FqFmVzrEbi6va1P/ZaEkS5YwVcDRJjRMniFfYsBOP8
         iK5tkrlUBR+oepaUpt9BICg+L1k7Iir4fhk6X3Qe3zEb3ER4vjhgjqmMBLCTnOAUeiPd
         U+Ru+RFtF33SOrEmETvW8ZUg5TMpNa/+HbnQcXXLQd9wE0hqGZaj65KpHTPjkxBSXrO/
         Mes+sw2i8qoAQQ7mKVPieBmjGYUaaaCB8Jom0/e2/vcwyItR1OSGUuGwluKyVy/0R0hb
         7L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gM8oXVARd4mryQQl2keakAgfc1YtJz9527QMJFwIP14=;
        b=LxX1kTRxg5Ic+9H5CWu2xjuzW8cHZX2Y3Jm37+XGyDO23bbyErGbdS5XCP/6f3wqdt
         vJ64rMcZv1ZLAbIhKicsRrUQy30CiZ2UAcfMbZShPQlGDhag9YqpXcOO4oNqZAZbg0Df
         Bc89lyp7TmXpgGmZTys+jCgqGWp8FcoXWyuTb7ycLbjs5tO0mpD8KpK8Rq4nzzGpedzU
         D0quAZNuofhtK4z8DqrDIBJgA7CeQJjTWfT5FpGM/Nw4G0RvrqkLzgO4Fh2M9pwkqveb
         mLhcC/aIT6233o77xT8CGwM7pYvgLpvCaberMEH/Q8cB/FNQot/GNt0RFUsHJlPK3p7H
         Qb0A==
X-Gm-Message-State: AOPr4FU8F8Jzq1dHAfn0ciCae4/kD5A8rWNFDcDXW0xrhSENt5H1b89Cw5lEg7cRjgRq1g==
X-Received: by 10.194.175.168 with SMTP id cb8mr29776129wjc.56.1461504885133;
        Sun, 24 Apr 2016 06:34:45 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:44 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292323>

As the value returned by gitdiff_verify_name() is put into the
same variable that is passed as a parameter to this function,
it is simpler to pass the address of the variable and have
gitdiff_verify_name() change the variable itself.

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
2.8.1.300.g5fed0c0
