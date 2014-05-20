From: Karsten Blees <karsten.blees@gmail.com>
Subject: [RFC/PATCH v4 2/3] add trace_performance facility to debug
 performance issues
Date: Tue, 20 May 2014 21:11:19 +0200
Message-ID: <537BA8D7.4000007@gmail.com>
References: <537BA806.50600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBV6R52NQKGQEBHHXCQY@googlegroups.com Tue May 20 21:11:20 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBV6R52NQKGQEBHHXCQY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBV6R52NQKGQEBHHXCQY@googlegroups.com>)
	id 1WmpRY-00088l-9p
	for gcvm-msysgit@m.gmane.org; Tue, 20 May 2014 21:11:20 +0200
Received: by mail-wi0-f190.google.com with SMTP id q5sf130670wiv.27
        for <gcvm-msysgit@m.gmane.org>; Tue, 20 May 2014 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=XxtVQeA3StIlnfABrHx7t8iLk3iVU2YHuyxfASA0XYY=;
        b=tTnFrB5ogYzg+emeBrFMc2ofSXVZX2GPhAuACDMumgR5zmby5wcZR+XDsKFKT0Sajc
         SPb5YYUFevVnZkg7W3LEFMc4OFKypFqv2CdXWbBvqsQ0IpwOwPYgrmtcPq9uM0NREEve
         /8tZOVz2+FMXU075XAtr9dq/6HD2RcRBY5drtg4tejGxU5/eZz/a2AOVdPhELr/na4w0
         bZRF7ku6HvT0kLlHfS3LJaCK1MocilANjFrKRH4CODTfdQFUov+ycWxJmAKcxN1obx5s
         7NAHMjtEIg2qjN246oUr63Q3IAM5HkW5bRRAwPa6cELfruBnVdmTDWqzbMKoZJSCQ7Ff
         dUuA==
X-Received: by 10.152.37.200 with SMTP id a8mr39506lak.19.1400613080019;
        Tue, 20 May 2014 12:11:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.22.131 with SMTP id d3ls70356laf.95.gmail; Tue, 20 May
 2014 12:11:18 -0700 (PDT)
X-Received: by 10.112.140.170 with SMTP id rh10mr3732806lbb.7.1400613078542;
        Tue, 20 May 2014 12:11:18 -0700 (PDT)
Received: from mail-ee0-x22a.google.com (mail-ee0-x22a.google.com [2a00:1450:4013:c00::22a])
        by gmr-mx.google.com with ESMTPS id g42si975321eev.1.2014.05.20.12.11.18
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 12:11:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22a as permitted sender) client-ip=2a00:1450:4013:c00::22a;
Received: by mail-ee0-f42.google.com with SMTP id d49so857239eek.15
        for <msysgit@googlegroups.com>; Tue, 20 May 2014 12:11:18 -0700 (PDT)
X-Received: by 10.14.203.199 with SMTP id f47mr7670422eeo.3.1400613078454;
        Tue, 20 May 2014 12:11:18 -0700 (PDT)
Received: from [10.1.116.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ci54sm5930456eeb.19.2014.05.20.12.11.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 12:11:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <537BA806.50600@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249732>

Add trace_performance and trace_performance_since macros that print file
name, line number, time and an optional printf-formatted text to the file
specified in environment variable GIT_TRACE_PERFORMANCE.

Unless enabled via GIT_TRACE_PERFORMANCE, these macros have no noticeable
impact on performance, so that test code may be shipped in release builds.

MSVC: variadic macros (__VA_ARGS__) require VC++ 2005 or newer.

Simple use case (measure one code section):

  uint64_t start = getnanotime();
  /* code section to measure */
  trace_performance_since(start, "foobar");

Medium use case (measure consecutive code sections):

  uint64_t start = getnanotime();
  /* first code section to measure */
  start = trace_performance_since(start, "first foobar");
  /* second code section to measure */
  trace_performance_since(start, "second foobar");

Complex use case (measure repetitive code sections):

  uint64_t t = 0;
  for (;;) {
    /* ignore */
    t -= getnanotime();
    /* code section to measure */
    t += getnanotime();
    /* ignore */
  }
  trace_performance(t, "frotz");

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 cache.h | 18 ++++++++++++++++++
 trace.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/cache.h b/cache.h
index 48fc616..cb856d9 100644
--- a/cache.h
+++ b/cache.h
@@ -1363,6 +1363,24 @@ __attribute__((format (printf, 2, 3)))
 extern void trace_printf_key(const char *key, const char *fmt, ...);
 extern void trace_strbuf(const char *key, const struct strbuf *buf);
 extern uint64_t getnanotime(void);
+__attribute__((format (printf, 4, 5)))
+extern uint64_t trace_performance_file_line(const char *file, int lineno,
+	uint64_t nanos, const char *fmt, ...);
+
+/*
+ * Prints specified time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled.
+ * Returns current time in nanoseconds.
+ */
+#define trace_performance(nanos, ...) \
+	trace_performance_file_line(__FILE__, __LINE__, nanos, __VA_ARGS__)
+
+/*
+ * Prints time since 'start' if GIT_TRACE_PERFORMANCE is enabled.
+ * Returns current time in nanoseconds.
+ */
+#define trace_performance_since(start, ...) \
+	trace_performance_file_line(__FILE__, __LINE__, \
+		getnanotime() - (start), __VA_ARGS__)
 
 void packet_trace_identity(const char *prog);
 
diff --git a/trace.c b/trace.c
index 3d72084..1b1903b 100644
--- a/trace.c
+++ b/trace.c
@@ -269,3 +269,43 @@ inline uint64_t getnanotime(void)
 		return now;
 	}
 }
+
+static const char *GIT_TRACE_PERFORMANCE = "GIT_TRACE_PERFORMANCE";
+
+static inline int trace_want_performance(void)
+{
+	static int enabled = -1;
+	if (enabled < 0)
+		enabled = trace_want(GIT_TRACE_PERFORMANCE);
+	return enabled;
+}
+
+/*
+ * Prints performance data if environment variable GIT_TRACE_PERFORMANCE is
+ * set, otherwise a NOOP. Returns the current time in nanoseconds.
+ */
+__attribute__((format (printf, 4, 5)))
+uint64_t trace_performance_file_line(const char *file, int lineno,
+				     uint64_t nanos, const char *fmt, ...)
+{
+	struct strbuf buf = STRBUF_INIT;
+	va_list args;
+
+	if (!trace_want_performance())
+		return 0;
+
+	strbuf_addf(&buf, "performance: at %s:%i, time: %.9f s", file, lineno,
+		    (double) nanos / 1000000000);
+
+	if (fmt && *fmt) {
+		strbuf_addstr(&buf, ": ");
+		va_start(args, fmt);
+		strbuf_vaddf(&buf, fmt, args);
+		va_end(args);
+	}
+	strbuf_addch(&buf, '\n');
+
+	trace_strbuf(GIT_TRACE_PERFORMANCE, &buf);
+	strbuf_release(&buf);
+	return getnanotime();
+}
-- 
1.9.2.msysgit.0.493.g47a82c3

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
