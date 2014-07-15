From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 1/2] MinGW: fix compile error due to missing ELOOP
Date: Wed, 16 Jul 2014 00:53:27 +0200
Message-ID: <53C5B0E7.4050706@gmail.com>
References: <20140712075035.GA12400@ucw.cz>	<1405431797-20899-1-git-send-email-kasal@ucw.cz> <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com> <53C5B0A1.4060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBZ7BS2PAKGQEJ3I7X4I@googlegroups.com Wed Jul 16 00:53:28 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBZ7BS2PAKGQEJ3I7X4I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f191.google.com ([74.125.82.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBZ7BS2PAKGQEJ3I7X4I@googlegroups.com>)
	id 1X7BbE-0006dr-7W
	for gcvm-msysgit@m.gmane.org; Wed, 16 Jul 2014 00:53:28 +0200
Received: by mail-we0-f191.google.com with SMTP id q59sf7909wes.18
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=p60F0jWU4GU2/EIY3Frm5V8JHug6DM5W2aoYU5rGSL4=;
        b=F+5RktkTTKCi6iXt0WoPPsIFotG4rmpbd12Z2jvcKYaiVq8nPJWXWMNLi3drhqwg85
         zHinT828+nvLgJMVPw72t/8wTB8xHvpIopp+fw6mX2fuvdTJ3/9qCT/NNFDGPKL7qp04
         fsXSWH/klPfeJ1qAAEfC1qkj05pOaDav1vfgQi3zCMFvT7OftYiidX/v9jZWOK/hEFkI
         oZzRHBHZpR+PFLU/QLcMzXyKEygciq7bgeNHVbTTGMpEDOc1skT1BNQR8HMSDuqctsXo
         ntMj+fGJIMJROB8Xks+XPgGXkchNDMtQiIgv72IGC568cn449ekQ0SvCzM6nmeXouxdu
         uvCw==
X-Received: by 10.180.10.229 with SMTP id l5mr39036wib.11.1405464807862;
        Tue, 15 Jul 2014 15:53:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.101.170 with SMTP id fh10ls660187wib.9.canary; Tue, 15 Jul
 2014 15:53:27 -0700 (PDT)
X-Received: by 10.194.92.167 with SMTP id cn7mr2406785wjb.1.1405464807111;
        Tue, 15 Jul 2014 15:53:27 -0700 (PDT)
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com [2a00:1450:400c:c00::22b])
        by gmr-mx.google.com with ESMTPS id iz18si714265wic.3.2014.07.15.15.53.27
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 15:53:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b as permitted sender) client-ip=2a00:1450:400c:c00::22b;
Received: by mail-wg0-f43.google.com with SMTP id l18so76071wgh.26
        for <msysgit@googlegroups.com>; Tue, 15 Jul 2014 15:53:27 -0700 (PDT)
X-Received: by 10.194.191.162 with SMTP id gz2mr30988383wjc.89.1405464806979;
        Tue, 15 Jul 2014 15:53:26 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id lk7sm35543201wjb.24.2014.07.15.15.53.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 15:53:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C5B0A1.4060502@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253614>

MinGW and MSVC before 2010 don't define ELOOP, use EMLINK (aka "Too many
links") instead.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 compat/mingw.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 405c08f..510530c 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -35,6 +35,9 @@ typedef int socklen_t;
 #ifndef EWOULDBLOCK
 #define EWOULDBLOCK EAGAIN
 #endif
+#ifndef ELOOP
+#define ELOOP EMLINK
+#endif
 #define SHUT_WR SD_SEND
 
 #define SIGHUP 1
-- 
2.0.1.779.g26aeac4.dirty

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
