From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 11/14] compat/nedmalloc/malloc.c.h: fix compilation
 under MinGW-W64
Date: Tue, 30 Sep 2014 11:02:40 +0400
Message-ID: <1412060563-22041-12-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB4NQVGQQKGQE6D4VQDQ@googlegroups.com Tue Sep 30 09:14:59 2014
Return-path: <msysgit+bncBCE7TAPITACRB4NQVGQQKGQE6D4VQDQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f63.google.com ([74.125.83.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB4NQVGQQKGQE6D4VQDQ@googlegroups.com>)
	id 1XYreE-0004jX-Cu
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:14:58 +0200
Received: by mail-ee0-f63.google.com with SMTP id d17sf293000eek.28
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=gnj0GZ/BMghyZwtS9Z5vicnxeYie35pthG6O8IVMBWM=;
        b=T2pO2v2y11qjh8WQ6BpWEr+1LmrJ0f9/BaZy6VwGJe/439Do0fQTG8R+sFY40ZCYJ/
         XWPvyNudh+3kpltMI1kH0i9GDswAbIu/PV2s5HpGlBc2KMO+VEHmqaeWXNwCvBrnGhCt
         W7olrGgB0u0lksLzIDdQwWOzXt0meY5i0VWwGe87oNFxabmj/lzuEWl2Puzki6n8LSsf
         SJ/JgMMEb43oJHrZ1Q6saqEFKnujPOKC/Q/imMBDTcWmqSgXic7wuYpysghpAaa5IiVe
         AVa6vNLfF9tMINeihuxue0rH1ZZvyJvkLu2xpU2/zvz3iiDky0KVxGbfyHT38k3Lq0qq
         7OdA==
X-Received: by 10.180.108.177 with SMTP id hl17mr11123wib.20.1412061298098;
        Tue, 30 Sep 2014 00:14:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.108.45 with SMTP id hh13ls351473wib.53.canary; Tue, 30 Sep
 2014 00:14:57 -0700 (PDT)
X-Received: by 10.194.63.206 with SMTP id i14mr457068wjs.5.1412061297651;
        Tue, 30 Sep 2014 00:14:57 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id j12si740598wie.2.2014.09.30.00.14.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:14:57 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSt-0004X0-5D; Tue, 30 Sep 2014 11:03:15 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257658>

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
