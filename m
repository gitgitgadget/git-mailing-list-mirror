From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 07/11] trace: move code around, in preparation to
 file:line output
Date: Wed, 11 Jun 2014 10:00:11 +0200
Message-ID: <53980C8B.2010207@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBDEZ4COAKGQEC7L4VQI@googlegroups.com Wed Jun 11 10:00:15 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBDEZ4COAKGQEC7L4VQI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBDEZ4COAKGQEC7L4VQI@googlegroups.com>)
	id 1WudSA-0007pz-LJ
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 10:00:14 +0200
Received: by mail-wg0-f57.google.com with SMTP id b13sf404822wgh.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=K7tvb3tEHkGyBV6GpXgWbUJPATxeeebfhMJhF8Pky3s=;
        b=stkAtylXEZFbzfZ6WeoPf32M6uvtJ2JHLi7FGF/ha09O9DdaYEeJy/8rDExIgL41gb
         xbYwKjLns1zUloGtR4CmH+zUL1L/BVacXdU5ATXH4NKmWyPByt8X89f8nOmy3U7dfSVk
         NzzIkvY0kqNNMUJPBq/Ghvf6Sp+4dQHenSzfb9cW7GicldJpJ1pSACdPhDYYc+qWdTKF
         ZcL88zz0tfnQ4uczWuKtIspKJ7XlHPm9ei+cGOYDE7qNCFgX5Xc87hIhS0ZxEbqq0g6r
         hKL3hyXwltsJ566V8Ot0wc1g4L1pOVWCU1GMRc3Jyr4V3oPwPySYKKjRd28i3bBkviIt
         xPJg==
X-Received: by 10.180.186.73 with SMTP id fi9mr22881wic.6.1402473613364;
        Wed, 11 Jun 2014 01:00:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.75.113 with SMTP id b17ls201336wiw.54.canary; Wed, 11 Jun
 2014 01:00:12 -0700 (PDT)
X-Received: by 10.180.87.71 with SMTP id v7mr4180609wiz.2.1402473612339;
        Wed, 11 Jun 2014 01:00:12 -0700 (PDT)
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id eh2si1263112wib.2.2014.06.11.01.00.12
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:00:12 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e as permitted sender) client-ip=2a00:1450:400c:c05::22e;
Received: by mail-wi0-x22e.google.com with SMTP id bs8so1063958wib.13
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 01:00:12 -0700 (PDT)
X-Received: by 10.180.105.102 with SMTP id gl6mr3851427wib.7.1402473612249;
        Wed, 11 Jun 2014 01:00:12 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id m1sm18160307eep.24.2014.06.11.01.00.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:00:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251336>

No functional changes, just move stuff around so that the next patch isn't
that ugly...

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 trace.c | 36 ++++++++++++++++++------------------
 trace.h | 12 ++++++++----
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/trace.c b/trace.c
index 5a3393a..c86d33c 100644
--- a/trace.c
+++ b/trace.c
@@ -119,20 +119,20 @@ static void trace_vprintf(const char *key, const char *format, va_list ap)
 	print_trace_line(key, &buf);
 }
 
-void trace_printf_key(const char *key, const char *format, ...)
+void trace_argv_printf(const char **argv, const char *format, ...)
 {
+	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-	va_start(ap, format);
-	trace_vprintf(key, format, ap);
-	va_end(ap);
-}
 
-void trace_printf(const char *format, ...)
-{
-	va_list ap;
+	if (!prepare_trace_line("GIT_TRACE", &buf))
+		return;
+
 	va_start(ap, format);
-	trace_vprintf("GIT_TRACE", format, ap);
+	strbuf_vaddf(&buf, format, ap);
 	va_end(ap);
+
+	sq_quote_argv(&buf, argv, 0);
+	print_trace_line("GIT_TRACE", &buf);
 }
 
 void trace_strbuf(const char *key, const struct strbuf *data)
@@ -146,20 +146,20 @@ void trace_strbuf(const char *key, const struct strbuf *data)
 	print_trace_line(key, &buf);
 }
 
-void trace_argv_printf(const char **argv, const char *format, ...)
+void trace_printf(const char *format, ...)
 {
-	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-
-	if (!prepare_trace_line("GIT_TRACE", &buf))
-		return;
-
 	va_start(ap, format);
-	strbuf_vaddf(&buf, format, ap);
+	trace_vprintf("GIT_TRACE", format, ap);
 	va_end(ap);
+}
 
-	sq_quote_argv(&buf, argv, 0);
-	print_trace_line("GIT_TRACE", &buf);
+void trace_printf_key(const char *key, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_vprintf(key, format, ap);
+	va_end(ap);
 }
 
 static const char *quote_crnl(const char *path)
diff --git a/trace.h b/trace.h
index e03db2f..5c7f2dc 100644
--- a/trace.h
+++ b/trace.h
@@ -4,14 +4,18 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 
-__attribute__((format (printf, 1, 2)))
-extern void trace_printf(const char *format, ...);
-__attribute__((format (printf, 2, 3)))
-extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
+
+__attribute__((format (printf, 1, 2)))
+extern void trace_printf(const char *format, ...);
+
 __attribute__((format (printf, 2, 3)))
 extern void trace_printf_key(const char *key, const char *format, ...);
+
+__attribute__((format (printf, 2, 3)))
+extern void trace_argv_printf(const char **argv, const char *format, ...);
+
 extern void trace_strbuf(const char *key, const struct strbuf *data);
 
 #endif /* TRACE_H */
-- 
1.9.2.msysgit.0.501.gaeecf09

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
