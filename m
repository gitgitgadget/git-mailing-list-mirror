From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:42 +0900
Message-ID: <1401118436-66090-2-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WowvL-0004dd-SK
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbaEZPer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:34:47 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:38049 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbaEZPeq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:46 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so7891371pbc.9
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YbOHpDMrOmzdZ64r67FaPm28dHxIyaeOR6Jh1QD27fw=;
        b=mPznsB6ramEvh66b+UU90wEkAMqvE6bx2rULPj2Ycu/c+49mcboDNlOrIb3nUWCIGs
         ABrQA7FIyBTZHBKw1+irrWLeKiDvuLkMK1eNssD/W6MQYqPA4I4MZj8lETdIKYP+IAyC
         W0HAZm67MdXe3lIm35Qd4GJZS3miGJCzr8ROtwIQYr3MjWy/w3feHx/4sDGKlJcEnIo8
         P9izjjWeLKtrkOVwPvaCgM8wNDmGYLiDC8kg4FmupZwbuba4vMag3ww4V4MUZ35Q7P/L
         CexCnEFlxs4Nz9+N9cjO7vb7pw/knTcKAGjE6D0pXxPGpU9t6noZLpTnHnYGeYl6JHTd
         EAwg==
X-Received: by 10.68.235.6 with SMTP id ui6mr28720047pbc.45.1401118486270;
        Mon, 26 May 2014 08:34:46 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250094>

xcalloc takes two arguments: the number of elements and their size.
run_add_interactive passes the arguments in reverse order, passing the
size of a char*, followed by the number of char* to be allocated.
Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 672adc0..488acf4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -248,7 +248,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	int status, ac, i;
 	const char **args;
 
-	args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
+	args = xcalloc((pathspec->nr + 6), sizeof(const char *));
 	ac = 0;
 	args[ac++] = "add--interactive";
 	if (patch_mode)
-- 
2.0.0.rc1.543.gc8042da
