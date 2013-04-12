From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] i18n: make the translation of -u advice in one go
Date: Fri, 12 Apr 2013 11:53:01 +0800
Message-ID: <7df2833fe51c614bf9a2a6208df2e09d913a046e.1365738420.git.worldhello.net@gmail.com>
References: <20130412025501.GB3266@elie.Belkin>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.co>, Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 05:53:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQV3H-0001uK-ID
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 05:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab3DLDxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 23:53:21 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:54122 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab3DLDxU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 23:53:20 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so1239781pab.18
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=f/LGfSTP07ROxIizbGvpzcv31o5wsKBnzydW1uhz5iU=;
        b=l/OfT7DSGFkgU1JmQ+uwlPj7x+2z73t+X12Gz72TTlZm5RTZ+FAawgNLeJNiBYFYDJ
         rEtxic3gWMyCJfnA5/1lqJW/7p8fidhAZZsDbjaP0G3a90A5ZiOJl5cet/qRqBtXjNZg
         qtysQelV8zjdE96HwOMxMI2kCcq+m8Zt3NeHYH4J1ZBCdjmba6mKTz452AEEkj1unPDR
         IC9WTxUU8eof1ul6/CwXv/C8sC8TGCUAYTC+GKBxrEeBkChMUivYjUr6oNS9b5QrOXnJ
         I2cZTQdalCN23YtObb1tVVhNsRTsYydLbiH9PauXIdGHtbuLieogNP5iAmXq8vA0qlFO
         fUjg==
X-Received: by 10.66.41.11 with SMTP id b11mr13201817pal.183.1365738800024;
        Thu, 11 Apr 2013 20:53:20 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.32])
        by mx.google.com with ESMTPS id ak5sm7614785pac.4.2013.04.11.20.53.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 20:53:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.348.g7df2833
In-Reply-To: <20130412025501.GB3266@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220948>

The advice (consider use of -u when read_directory takes too long) is
separated into 3 different status_printf_ln() calls, and which brings
trouble for translators.

Since status_vprintf() called by status_printf_ln() can handle eol in
buffer, we could simply join these lines into one paragraph.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 wt-status.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 09416..ec5f2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1225,14 +1225,10 @@ void wt_status_print(struct wt_status *s)
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "");
 			status_printf_ln(s, GIT_COLOR_NORMAL,
-				 _("It took %.2f seconds to enumerate untracked files."
-				   "  'status -uno'"),
-				 s->untracked_in_ms / 1000.0);
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-				 _("may speed it up, but you have to be careful not"
-				   " to forget to add"));
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-				 _("new files yourself (see 'git help status')."));
+					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
+					   "may speed it up, but you have to be careful not to forget to add\n"
+					   "new files yourself (see 'git help status')."),
+					 s->untracked_in_ms / 1000.0);
 		}
 	} else if (s->commitable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
-- 
1.8.2.1.347.g1003b3a.dirty
