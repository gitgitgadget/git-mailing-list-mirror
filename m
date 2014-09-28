From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 04/14] MINGW: do not fail at redefining pid_t on MinGW-W64
Date: Sun, 28 Sep 2014 17:24:20 +0400
Message-ID: <1411910670-31285-5-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBYUYUCQQKGQEU2OSEHQ@googlegroups.com Sun Sep 28 15:25:57 2014
Return-path: <msysgit+bncBCE7TAPITACRBYUYUCQQKGQEU2OSEHQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBYUYUCQQKGQEU2OSEHQ@googlegroups.com>)
	id 1XYEU8-0000CK-RI
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:25:56 +0200
Received: by mail-lb0-f187.google.com with SMTP id z12sf1363411lbi.24
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=MVZFtxTWVxDzucPewvpf22luxePvbgKb5HnL9gkde3k=;
        b=rlkAQKCNUNMBvZyTBeft5vTTBz6+5r2So3TkWRBn4FY/UP9q0ZbcgsSs1hwnu1Wz+V
         HvZdmFDsrWP6k+zVbhvTOM9/D4AvJG/QWUL2VJZLwsyjsx4jX8XBaHM0wCEZWgioNfIX
         k43d2Wv/fFioOYTeMqVokGxofYDg7D/7H+FbWJEDSF9MsYRyVgvqwTzlFcFhDvrGyrSz
         ZlLU0GRae+AK3vEDWKDInfHHx7BK91/jTcXWDslpFp96Igv/2nhclRX5yewRHf9r6sBC
         6M2923BdV/tXExZMUmKxNlmt+EUsmxK+KIL7z+X6ry4mrz6uFSiqmOGc1Vp6WiBoqFBf
         zmlA==
X-Received: by 10.152.7.226 with SMTP id m2mr609587laa.0.1411910756510;
        Sun, 28 Sep 2014 06:25:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.74 with SMTP id r10ls568086lag.109.gmail; Sun, 28 Sep
 2014 06:25:54 -0700 (PDT)
X-Received: by 10.152.3.134 with SMTP id c6mr318445lac.5.1411910754261;
        Sun, 28 Sep 2014 06:25:54 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id i6si429235wiy.0.2014.09.28.06.25.54
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:54 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEU3-0000Yl-Q5; Sun, 28 Sep 2014 17:25:52 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257602>

pid_t is available in sys/types.h on both MinGW and MinGW-W64

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 1 -
 compat/msvc.h  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 948a174..d113b19 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -5,7 +5,6 @@
  * things that are not available in header files
  */
 
-typedef int pid_t;
 typedef int uid_t;
 typedef int socklen_t;
 #define hstrerror strerror
diff --git a/compat/msvc.h b/compat/msvc.h
index 580bb55..a63d878 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -15,6 +15,8 @@
 #define strtoull     _strtoui64
 #define strtoll      _strtoi64
 
+typedef int pid_t;
+
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
 	int size1 = strlen(s1);
-- 
2.1.1

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
