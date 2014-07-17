From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 02/13] Win32: Unicode environment (outgoing)
Date: Thu, 17 Jul 2014 17:37:55 +0200
Message-ID: <1405611486-10176-3-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com Thu Jul 17 17:38:21 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nl9-0008Vb-N1
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:15 +0200
Received: by mail-lb0-f187.google.com with SMTP id n15sf328492lbi.24
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Mk6+CfqkKpr4p5JF+OYiIQ5Y0D5X1sYEnOWm297rkl4=;
        b=fJ0huXZVdxkDbHLqpllbu4KxR5H7DlJeUeAA8S7fEzmahO9IhjrfGIVt5ty63cuat5
         e7bb7ea4VMXKtIg5267oG8L19JwuZT9DY7DtsYAtjx/R2bsxbJywpNGp7a+tQvuQ55hS
         V+BECMcdfX9PLH7wDOh75h+LjCsjCE875JB9vIk5juLPeUNguuB5V2+vrEuzWu/DG9wh
         GYqm0+hgvLZlC8Nt9VpCnGWpPm7Wc/2BAR5BE4XcnW11+Hmqhqc84CcS9VLbPlMDxoBh
         sJ1cPXuDlwsVEybXaZBc3LzvjKyUKkbOl+Lq7I1ijUkNih7xNK+VtAO4dM/jkRdzqCPK
         ohPQ==
X-Received: by 10.181.5.7 with SMTP id ci7mr87828wid.15.1405611495350;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.84.1 with SMTP id u1ls943385wiy.25.canary; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.194.103.133 with SMTP id fw5mr3793154wjb.3.1405611494619;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id b9si373667wic.2.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 592311C0198; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253757>

From: Karsten Blees <blees@dcon.de>

Convert environment from UTF-8 to UTF-16 when creating other processes.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ca1b6bd..bd45950 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -919,9 +919,9 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 {
 	STARTUPINFOW si;
 	PROCESS_INFORMATION pi;
-	struct strbuf envblk, args;
-	wchar_t wcmd[MAX_PATH], wdir[MAX_PATH], *wargs;
-	unsigned flags;
+	struct strbuf args;
+	wchar_t wcmd[MAX_PATH], wdir[MAX_PATH], *wargs, *wenvblk = NULL;
+	unsigned flags = CREATE_UNICODE_ENVIRONMENT;
 	BOOL ret;
 
 	/* Determine whether or not we are associated to a console */
@@ -938,7 +938,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 		 * instead of CREATE_NO_WINDOW to make ssh
 		 * recognize that it has no console.
 		 */
-		flags = DETACHED_PROCESS;
+		flags |= DETACHED_PROCESS;
 	} else {
 		/* There is already a console. If we specified
 		 * DETACHED_PROCESS here, too, Windows would
@@ -946,7 +946,6 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 		 * The same is true for CREATE_NO_WINDOW.
 		 * Go figure!
 		 */
-		flags = 0;
 		CloseHandle(cons);
 	}
 	memset(&si, 0, sizeof(si));
@@ -985,6 +984,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 	if (env) {
 		int count = 0;
 		char **e, **sorted_env;
+		int size = 0, wenvsz = 0, wenvpos = 0;
 
 		for (e = env; *e; e++)
 			count++;
@@ -994,20 +994,22 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 		memcpy(sorted_env, env, sizeof(*sorted_env) * (count + 1));
 		qsort(sorted_env, count, sizeof(*sorted_env), env_compare);
 
-		strbuf_init(&envblk, 0);
+		/* create environment block from temporary environment */
 		for (e = sorted_env; *e; e++) {
-			strbuf_addstr(&envblk, *e);
-			strbuf_addch(&envblk, '\0');
+			size = 2 * strlen(*e) + 2; /* +2 for final \0 */
+			ALLOC_GROW(wenvblk, (wenvpos + size) * sizeof(wchar_t), wenvsz);
+			wenvpos += xutftowcs(&wenvblk[wenvpos], *e, size) + 1;
 		}
+		/* add final \0 terminator */
+		wenvblk[wenvpos] = 0;
 		free(sorted_env);
 	}
 
 	memset(&pi, 0, sizeof(pi));
 	ret = CreateProcessW(wcmd, wargs, NULL, NULL, TRUE, flags,
-		env ? envblk.buf : NULL, dir ? wdir : NULL, &si, &pi);
+		wenvblk, dir ? wdir : NULL, &si, &pi);
 
-	if (env)
-		strbuf_release(&envblk);
+	free(wenvblk);
 	free(wargs);
 
 	if (!ret) {
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
