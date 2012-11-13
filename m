From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 5/5] mingw: get rid of getpass implementation
Date: Tue, 13 Nov 2012 15:04:07 +0100
Message-ID: <1352815447-8824-6-git-send-email-kusmabite@gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: git@vger.kernel.org,
	msysgit@googlegroups.com
X-From: msysgit+bncBDR53PPJ7YHRB5VGRGCQKGQE5HQZNJY@googlegroups.com Tue Nov 13 15:04:49 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB5VGRGCQKGQE5HQZNJY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB5VGRGCQKGQE5HQZNJY@googlegroups.com>)
	id 1TYH6e-0004Ii-79
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 15:04:48 +0100
Received: by mail-we0-f186.google.com with SMTP id x43sf2514969wey.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Nov 2012 06:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=8OZQLk+3O5QNLW9mD6Hn3aSefSYxU4DowF/a2hQ98xc=;
        b=rjqgmJEVY9DW7aYpslwSoi0K6RXJw92gl0J9SH2FxsJ5IdFgWeLTFAmz3gI4IlpJgp
         emI06iDyftyGqzqrvkYIVxIQ2nJ1XbeExMiqN6ldBxRKo0tzuTUJZWz9u0wrzreaAHIr
         oBVDFKcZqs/ypiW8oXOOlY+jeEuTYNvuwsIG2SFc7thUJyti4t+z5AXS8FxKuwWAhPVp
         mm1Yj0lPRc0WbMDlmqoIrnFYSbkQrCaKOYiZmmUo4RSVLMpXbzgZ7VELdMyRlTgfdfB4
         x5KA9uEmqZd+4+8oRlnyS9fcJA/vsa6tnlN+5UgapUOYJSEAeW5L8KnfejQv+vFXr3xB
         ArrA==
Received: by 10.204.130.18 with SMTP id q18mr1851953bks.12.1352815478607;
        Tue, 13 Nov 2012 06:04:38 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.131.72 with SMTP id w8ls7889067bks.3.gmail; Tue, 13 Nov
 2012 06:04:37 -0800 (PST)
Received: by 10.204.11.65 with SMTP id s1mr178261bks.7.1352815477865;
        Tue, 13 Nov 2012 06:04:37 -0800 (PST)
Received: by 10.204.11.65 with SMTP id s1mr178260bks.7.1352815477848;
        Tue, 13 Nov 2012 06:04:37 -0800 (PST)
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com [209.85.215.41])
        by gmr-mx.google.com with ESMTPS id v13si828595bkw.0.2012.11.13.06.04.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:37 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.41 as permitted sender) client-ip=209.85.215.41;
Received: by mail-la0-f41.google.com with SMTP id p5so6873283lag.14
        for <msysgit@googlegroups.com>; Tue, 13 Nov 2012 06:04:37 -0800 (PST)
Received: by 10.112.103.202 with SMTP id fy10mr423015lbb.51.1352815477518;
        Tue, 13 Nov 2012 06:04:37 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id so7sm3835337lab.0.2012.11.13.06.04.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:36 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.1.g1cbcfae.dirty
In-Reply-To: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.41 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209609>

There's no remaining call-sites, and as pointed out in the
previous commit message, it's not quite ideal. So let's just
lose it.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c | 15 ---------------
 compat/mingw.h |  2 --
 2 files changed, 17 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 33ddfdf..5fc14b7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1758,21 +1758,6 @@ int link(const char *oldpath, const char *newpath)
 	return 0;
 }
 
-char *getpass(const char *prompt)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	fputs(prompt, stderr);
-	for (;;) {
-		char c = _getch();
-		if (c == '\r' || c == '\n')
-			break;
-		strbuf_addch(&buf, c);
-	}
-	fputs("\n", stderr);
-	return strbuf_detach(&buf, NULL);
-}
-
 pid_t waitpid(pid_t pid, int *status, int options)
 {
 	HANDLE h = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION,
diff --git a/compat/mingw.h b/compat/mingw.h
index 6b9e69a..f494ecb 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -55,8 +55,6 @@ struct passwd {
 	char *pw_dir;
 };
 
-extern char *getpass(const char *prompt);
-
 typedef void (__cdecl *sig_handler_t)(int);
 struct sigaction {
 	sig_handler_t sa_handler;
-- 
1.8.0.7.gbeffeda

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
