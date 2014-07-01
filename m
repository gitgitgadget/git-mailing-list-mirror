From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 10/16] trace: move code around, in preparation to
 file:line output
Date: Wed, 02 Jul 2014 01:01:30 +0200
Message-ID: <53B33DCA.6000207@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBS73ZSOQKGQEINIZ3CA@googlegroups.com Wed Jul 02 01:01:34 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBS73ZSOQKGQEINIZ3CA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f191.google.com ([74.125.82.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBS73ZSOQKGQEINIZ3CA@googlegroups.com>)
	id 1X273M-00046F-7q
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 01:01:32 +0200
Received: by mail-we0-f191.google.com with SMTP id q59sf1046438wes.8
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=w9j38EZf7AvbZ/FV15kUTfy4kyj8Yf42olxlwJn4KkM=;
        b=RziTjKDiZgr7FP+RMz9u0sSyIcTNG122RmaOtMxwEASTLt/MoQZeq/zngbWBGGzS/X
         pKZ4KntG6vnK6Hogl2NQXw5MCZPjh+oByPD+HbjT7K7INvesb8+2bx0Pp7Ln2cgq2oLD
         9J6DaUjp6vZkM3pIUjvybqutM9TRyntMP7N0AVjFSU/xgSnuyNPzUw5ucGB1O4KBWIKB
         lYDXA5sEyJA63TGuGjoKszCn0RzM/o9nxbFcY8hzZZrb6HuVGKRjf9cPWBM1fCAVaA+I
         JEmthMwDd2abNO+IKuhBsh++SweXTeB1zHHRyCxqtJqkn2nkAnq43fLgCYKYm/wGYsar
         dOaw==
X-Received: by 10.152.116.17 with SMTP id js17mr50lab.41.1404255691855;
        Tue, 01 Jul 2014 16:01:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.20.226 with SMTP id q2ls290469lae.80.gmail; Tue, 01 Jul
 2014 16:01:30 -0700 (PDT)
X-Received: by 10.152.26.41 with SMTP id i9mr42811lag.8.1404255690829;
        Tue, 01 Jul 2014 16:01:30 -0700 (PDT)
Received: from mail-we0-x229.google.com (mail-we0-x229.google.com [2a00:1450:400c:c03::229])
        by gmr-mx.google.com with ESMTPS id r13si811701wib.0.2014.07.01.16.01.30
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:01:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::229 as permitted sender) client-ip=2a00:1450:400c:c03::229;
Received: by mail-we0-f169.google.com with SMTP id t60so10527090wes.0
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 16:01:30 -0700 (PDT)
X-Received: by 10.194.60.110 with SMTP id g14mr6809137wjr.101.1404255690747;
        Tue, 01 Jul 2014 16:01:30 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o2sm48218443wia.16.2014.07.01.16.01.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:01:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::229
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252759>

No functional changes, just move stuff around so that the next patch isn't
that ugly...

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 trace.c | 36 ++++++++++++++++++------------------
 trace.h | 12 ++++++++----
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/trace.c b/trace.c
index 18e5d93..e8ce619 100644
--- a/trace.c
+++ b/trace.c
@@ -132,20 +132,20 @@ static void trace_vprintf(struct trace_key *key, const char *format, va_list ap)
 	print_trace_line(key, &buf);
 }
 
-void trace_printf_key(struct trace_key *key, const char *format, ...)
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
+	if (!prepare_trace_line(NULL, &buf))
+		return;
+
 	va_start(ap, format);
-	trace_vprintf(NULL, format, ap);
+	strbuf_vaddf(&buf, format, ap);
 	va_end(ap);
+
+	sq_quote_argv(&buf, argv, 0);
+	print_trace_line(NULL, &buf);
 }
 
 void trace_strbuf(struct trace_key *key, const struct strbuf *data)
@@ -159,20 +159,20 @@ void trace_strbuf(struct trace_key *key, const struct strbuf *data)
 	print_trace_line(key, &buf);
 }
 
-void trace_argv_printf(const char **argv, const char *format, ...)
+void trace_printf(const char *format, ...)
 {
-	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-
-	if (!prepare_trace_line(NULL, &buf))
-		return;
-
 	va_start(ap, format);
-	strbuf_vaddf(&buf, format, ap);
+	trace_vprintf(NULL, format, ap);
 	va_end(ap);
+}
 
-	sq_quote_argv(&buf, argv, 0);
-	print_trace_line(NULL, &buf);
+void trace_printf_key(struct trace_key *key, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_vprintf(key, format, ap);
+	va_end(ap);
 }
 
 static const char *quote_crnl(const char *path)
diff --git a/trace.h b/trace.h
index e69455f..0c98da2 100644
--- a/trace.h
+++ b/trace.h
@@ -13,15 +13,19 @@ struct trace_key {
 
 #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name }
 
-__attribute__((format (printf, 1, 2)))
-extern void trace_printf(const char *format, ...);
-__attribute__((format (printf, 2, 3)))
-extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
+
+__attribute__((format (printf, 1, 2)))
+extern void trace_printf(const char *format, ...);
+
 __attribute__((format (printf, 2, 3)))
 extern void trace_printf_key(struct trace_key *key, const char *format, ...);
+
+__attribute__((format (printf, 2, 3)))
+extern void trace_argv_printf(const char **argv, const char *format, ...);
+
 extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
 #endif /* TRACE_H */
-- 
2.0.0.406.ge74f8ff

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
