From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2 2/2] mingw: avoid const warning
Date: Sat,  7 Jun 2014 08:46:41 +0200
Message-ID: <1402123601-26312-3-git-send-email-kasal@ucw.cz>
References: <53922F58.80509@gmail.com>
 <1402123601-26312-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBWHKZKOAKGQEVFPDDSA@googlegroups.com Sat Jun 07 08:46:54 2014
Return-path: <msysgit+bncBCU63DXMWULRBWHKZKOAKGQEVFPDDSA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBWHKZKOAKGQEVFPDDSA@googlegroups.com>)
	id 1WtAOv-0001h2-A1
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 08:46:49 +0200
Received: by mail-wi0-f183.google.com with SMTP id n15sf227863wiw.20
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 23:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=ugLVb4oI8zgzu8xBrp4KXpifxJInQl3lh2ZcCuIYbMc=;
        b=JnZ22OUok9GBJmum9iWDIMIbvq598TKRFKenPAS89Iqam1P5mtFBZycgbV43lU57AM
         dDQFOhnowVhyGAZfsaNOp6fAhjE0LD/1R03PrIiqxWuPi2msOxkhh+LpwoyEYwiv2fWu
         7qzVqt9fzFr72Sr9ZqEAypF6yvIrFyO5TbNi5eA5oVFklJ6yjE/J1E5RQB/Jb/BVH9q4
         aROpm6gqmoTuihBUrCorF8MYGUgQFvu8OHP47KgqGTqzmSwQq4RIPquZ/M0HrbA2R0Di
         RC5Fz0Yrh3oaPoh8fsbPpUlsYTl7VP6w/UnydCVOS8YHgdAno3lj4owWU5MrsEgs6Ka9
         JjdQ==
X-Received: by 10.181.13.230 with SMTP id fb6mr39173wid.1.1402123608831;
        Fri, 06 Jun 2014 23:46:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.24.102 with SMTP id t6ls201648wif.33.gmail; Fri, 06 Jun
 2014 23:46:47 -0700 (PDT)
X-Received: by 10.14.101.2 with SMTP id a2mr3370eeg.7.1402123607652;
        Fri, 06 Jun 2014 23:46:47 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id ck3si792169wib.0.2014.06.06.23.46.47
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 23:46:47 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 789281C00A6; Sat,  7 Jun 2014 08:46:47 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402123601-26312-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251028>

Fix const warnings in http-fetch.c and remote-curl.c main() where is
argv declared as const.

The fix should work for all future declarations of main, no matter
whether the second parameter's type is "char**", "const char**", or
"char *[]".

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 15f0c9d..6dc8b1a 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -372,7 +372,7 @@ static int mingw_main(c,v); \
 int main(int argc, char **argv) \
 { \
 	mingw_startup(); \
-	return mingw_main(__argc, __argv); \
+	return mingw_main(__argc, (void *)__argv); \
 } \
 static int mingw_main(c,v)
 
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
