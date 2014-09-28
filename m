From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 11/14] compat/nedmalloc/malloc.c.h: fix compilation
 under MinGW-W64
Date: Sun, 28 Sep 2014 17:24:27 +0400
Message-ID: <1411910670-31285-12-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBXE2UCQQKGQENLTWXLA@googlegroups.com Sun Sep 28 15:30:07 2014
Return-path: <msysgit+bncBCE7TAPITACRBXE2UCQQKGQENLTWXLA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBXE2UCQQKGQENLTWXLA@googlegroups.com>)
	id 1XYEY9-0001c1-0W
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:30:05 +0200
Received: by mail-ee0-f58.google.com with SMTP id b15sf594267eek.13
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=gnj0GZ/BMghyZwtS9Z5vicnxeYie35pthG6O8IVMBWM=;
        b=d8X5AO/2Nhon45ifrit38LB/PjRjxPmIIiUWmzadNIv1WQSm3Pc7etGUr2Q1KBGSYv
         bEZDjL85lUJqHOIu4Q1+fz/hOG3sOBEwSpZsCTPCgmzWt1MmYeMz0BUmEAagm/QWgowW
         L6PCia4LkuIaUcLuCUj7sZ57UWuHNUSEHTiczYs72zmFiyxiHtPTb5uuW77iipe9dEs2
         ZZDGq93Td9JERPsToJIQZt19aZnXgToU7ohBOZQWCfMKuPzHobLtCdVw4bxtuLRJuNm4
         c4Uc85qrvMfUdt9DGF/We+LroM4W5SOOrDxxWaRGPBC431vhjvv0a3kTKCHqa/TMysna
         STRA==
X-Received: by 10.180.100.106 with SMTP id ex10mr302198wib.7.1411911004768;
        Sun, 28 Sep 2014 06:30:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.13.209 with SMTP id j17ls367459wic.48.gmail; Sun, 28 Sep
 2014 06:30:04 -0700 (PDT)
X-Received: by 10.181.25.225 with SMTP id it1mr1326241wid.0.1411911004179;
        Sun, 28 Sep 2014 06:30:04 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id i6si429616wiy.0.2014.09.28.06.30.04
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:30:04 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEUB-0000Yl-0R; Sun, 28 Sep 2014 17:25:59 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257610>

1. Unlike MinGW, MinGW-W64 already provides _ReadWriteBarrier macro,
   so don't try to redefine it.

2. MinGW-W64 has a strange definition FORCEINLINE as
   extern __inline__ __attribute__((__always_inline__,__gnu_inline__))

   'extern' doesn't work together with 'static', so #undef MinGW-W64
   version of FORCEINLINE.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/nedmalloc/malloc.c.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index f216a2a..a6c8cac 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -715,6 +715,10 @@ struct mallinfo {
 #endif /* HAVE_USR_INCLUDE_MALLOC_H */
 #endif /* NO_MALLINFO */
 
+#ifdef __MINGW64_VERSION_MAJOR
+  #undef FORCEINLINE
+#endif
+
 /*
   Try to persuade compilers to inline. The most critical functions for
   inlining are defined as macros, so these aren't used for them.
@@ -1382,7 +1386,9 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
 
   /*** Atomic operations ***/
   #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
-    #define _ReadWriteBarrier() __sync_synchronize()
+    #ifndef _ReadWriteBarrier
+      #define _ReadWriteBarrier() __sync_synchronize()
+    #endif
   #else
     static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)
     {
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
