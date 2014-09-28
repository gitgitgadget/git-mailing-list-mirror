From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 01/14] MINGW: compat/mingw.h: do not attempt to
 redefine lseek on mingw-w64
Date: Sun, 28 Sep 2014 17:24:17 +0400
Message-ID: <1411910670-31285-2-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBYEYUCQQKGQEZOHTT6I@googlegroups.com Sun Sep 28 15:25:55 2014
Return-path: <msysgit+bncBCE7TAPITACRBYEYUCQQKGQEZOHTT6I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f187.google.com ([209.85.212.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBYEYUCQQKGQEZOHTT6I@googlegroups.com>)
	id 1XYEU6-0000BC-4l
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:25:54 +0200
Received: by mail-wi0-f187.google.com with SMTP id q5sf135363wiv.4
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=dick/35AQXebPswDw4/UcACGBPrpLgfv2kN5oTxpbWw=;
        b=DM9FXkfxIfyMkVcuxN7zFRblW+I8TS+wwMrx/bDZzceKxXWXtUFRgCVJKlcL9lQqWx
         EVL961GV+j7gi2D8/qF+HVoqouHJb8GOjDdwbYdkzlDJJCDEqgHykq3rSlo/ioBh8qWs
         F0WS2mZcNrvD4f/0fJAfHShLEbhv5g+mB5+J/+aPA/+Hi9vz5MpvaToV7O4aAb88RXIV
         J2bLpOjx1OJYMOVDpSuSMd6QRR3GcgrGxFzPubLLwjJOJOoDP1vDSAqz5+B2FV8sQqHT
         Hq6Unp1dWnz7ICFaI+9YsnMY8promM22BrV9K4JURa/xKg9uDf6DdnGDRynskKE2Zt2v
         rVSA==
X-Received: by 10.152.19.226 with SMTP id i2mr31550lae.5.1411910753884;
        Sun, 28 Sep 2014 06:25:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.4 with SMTP id r4ls43356lae.54.gmail; Sun, 28 Sep 2014
 06:25:51 -0700 (PDT)
X-Received: by 10.152.3.134 with SMTP id c6mr318431lac.5.1411910751850;
        Sun, 28 Sep 2014 06:25:51 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id go4si418525wib.3.2014.09.28.06.25.51
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:51 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYETz-0000Yl-JA; Sun, 28 Sep 2014 17:25:47 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257597>

Unlike MinGW, MinGW-W64 has lseek already properly defined in io.h.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index df0e320..ed79368 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -281,7 +281,9 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
  * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
  */
 #define off_t off64_t
+#ifndef lseek
 #define lseek _lseeki64
+#endif
 
 /* use struct stat with 64 bit st_size */
 #ifdef stat
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
