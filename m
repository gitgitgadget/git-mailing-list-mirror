From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 6/6] mingw: get rid of getpass implementation
Date: Tue,  4 Dec 2012 09:10:42 +0100
Message-ID: <1354608642-5316-7-git-send-email-kusmabite@gmail.com>
References: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	gitster@pobox.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBNXA62CQKGQENUORECQ@googlegroups.com Tue Dec 04 09:11:51 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBNXA62CQKGQENUORECQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBNXA62CQKGQENUORECQ@googlegroups.com>)
	id 1TfnbW-0004tJ-Gb
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 09:11:46 +0100
Received: by mail-ea0-f186.google.com with SMTP id c1sf1487801eaa.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 00:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=h75d4oL9tnkG3P56ffJ8wS3Lvbfk8LniTDYCkAEPovQ=;
        b=m9bUw+H0M4JX/muDY5MZhfm+TSvBymR7s7CT/EV3x4rWdZya+eoazhwUZAZMO6CQ3t
         /AqIeo+bsyWrCcCp9ZC35mRsavRGE3xdWPlX3j1KM8kJqvDdSyvvF0S0Brx5cMgFZVil
         GceWsG9aRqShVVFQ2ftohlH+amb29uX6ygpXvcZk8p3C5yKcp5/BAYJYCSZfnMQ6e4Zp
         BRtyiDfLFc8+Iczg+ezoEUV3p6xvj0j9bvVUOy2CAW7mxLeWeH2deDRm9MU9TBZJUgZ2
         lj/nynJW0SNEGLZ5YviLvOT075TAepdxe82N6pg7hQj7pStD2DnTBwehgszQruhINrxA
         ERRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=h75d4oL9tnkG3P56ffJ8wS3Lvbfk8LniTDYCkAEPovQ=;
        b=S+Zg+9nCgnkMyUJuE7OJHqzkx5uySMMoqpR7erHmcW2TfCrENmBYt8wALyDWh0V3le
         PQTT2iLp4w68oyVE3TeHadQZKE+BenB0LwRX3Yv94Nv9VZ9zOC7YsHSz4YyvfJBWtHGa
         yJTsbWt1Jp30YcAuo92Z7+fjbF2V4+BwUuR/glkkSOKMoCh4uBaGjamCy+NYR3ks5kgb
         q0q42ssUGil65BlihtoP/Bn5HxLwY8NdrOR6BRFHN3mFuBWxxk6yJrkiqB5qA//euz6T
         U61VKEI2qvaJOFbtj8DYRFscelRodVDRdeEp+W7WlU6UasSgfJ8DPN1GxYnyYWdqqZH6
         aXXA==
Received: by 10.180.91.230 with SMTP id ch6mr333214wib.11.1354608694960;
        Tue, 04 Dec 2012 00:11:34 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.19.137 with SMTP id f9ls114155wie.2.gmail; Tue, 04 Dec
 2012 00:11:34 -0800 (PST)
Received: by 10.204.130.141 with SMTP id t13mr1790801bks.3.1354608694156;
        Tue, 04 Dec 2012 00:11:34 -0800 (PST)
Received: by 10.204.130.141 with SMTP id t13mr1790800bks.3.1354608694137;
        Tue, 04 Dec 2012 00:11:34 -0800 (PST)
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com [209.85.217.174])
        by gmr-mx.google.com with ESMTPS id j28si44814bkv.0.2012.12.04.00.11.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:34 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.217.174 as permitted sender) client-ip=209.85.217.174;
Received: by mail-lb0-f174.google.com with SMTP id gi11so3407181lbb.5
        for <msysgit@googlegroups.com>; Tue, 04 Dec 2012 00:11:33 -0800 (PST)
Received: by 10.112.10.71 with SMTP id g7mr5492603lbb.70.1354608693680;
        Tue, 04 Dec 2012 00:11:33 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id oz12sm199012lab.17.2012.12.04.00.11.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:32 -0800 (PST)
X-Mailer: git-send-email 1.7.11.msysgit.0.5.g0225efe.dirty
In-Reply-To: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.217.174 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211075>

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
1.8.0.4.g3c6fb4f.dirty

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
