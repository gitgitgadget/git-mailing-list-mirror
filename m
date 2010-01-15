From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 7/7] Do not use date.c:tm_to_time_t() from 
	compat/mingw.c
Date: Fri, 15 Jan 2010 21:12:21 +0100
Message-ID: <8878e74e4071102dd7c7830d549ed28c5cc1b266.1263584975.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: 3hcxQSwMIB-0YviZSQV.dgVbhnhVXiVddVaTVgdjeh.Rdb@listserv.bounces.google.com Fri Jan 15 21:14:15 2010
Return-path: <3hcxQSwMIB-0YviZSQV.dgVbhnhVXiVddVaTVgdjeh.Rdb@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVsYg-0004tg-ME
	for gcvm-msysgit@m.gmane.org; Fri, 15 Jan 2010 21:14:14 +0100
Received: by mail-gx0-f190.google.com with SMTP id 6sf2050048gxk.13
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Jan 2010 12:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-unsubscribe:list-subscribe;
        bh=dlmM/77RVycZIUdCfQRR1V8qshP1Eb7wXWzMA4gs9LQ=;
        b=yEcW2gMbtPl4V3JMjc9ybeWPKTI+jZcN5W3OYtL4RZoYIjh2goAb72eN8ikkCkGbdY
         D+qEXrG0TZGvSFRYsDJIy3lgoYC16zrzITXeLA/jKRnWNdsRc7ps/LzkvBMVn2EH9ltg
         ptSF9L3/gerwQfKg2VinbcF7SFRCWfUqVjahs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=zmINJ+JLdeKczqzfTASek1w/H4ZY8C4jRhwWqCmN6xy20HorM6HseA+x/hfrsg9Udw
         V+fzeMCbLpGSH0hvLGOhFEchlRVOOvYMqzmVqPqA5lNB691x5z1c72I42dutPBp37vj7
         LtJnpU20+Hgn1sfvOQ2sWK58AjG2NuNJO2lDY=
Received: by 10.101.6.11 with SMTP id j11mr218395ani.0.1263586437957;
        Fri, 15 Jan 2010 12:13:57 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.16.66 with SMTP id n2ls263955bka.1.p; Fri, 15 Jan 2010 
	12:13:56 -0800 (PST)
Received: by 10.204.13.70 with SMTP id b6mr93932bka.37.1263586435797;
        Fri, 15 Jan 2010 12:13:55 -0800 (PST)
Received: by 10.204.13.70 with SMTP id b6mr93931bka.37.1263586435769;
        Fri, 15 Jan 2010 12:13:55 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 18si141020bwz.9.2010.01.15.12.13.55;
        Fri, 15 Jan 2010 12:13:55 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6DD602C400E;
	Fri, 15 Jan 2010 21:13:55 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CA18419F60D;
	Fri, 15 Jan 2010 21:12:58 +0100 (CET)
X-Mailer: git-send-email 1.6.6.218.g3e6eb
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
In-Reply-To: <cover.1263584975.git.j6t@kdbg.org>
References: <cover.1263584975.git.j6t@kdbg.org>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/89026b66486ea92e
X-Message-Url: http://groups.google.com/group/msysgit/msg/7f5fef739295482b
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137113>

To implement gettimeofday(), a broken-down UTC time was requested from the
system using GetSystemTime(), then tm_to_time_t() was used to convert it
to a time_t because it does not look at the current timezone, which
mktime() would do.

Use GetSystemTimeAsFileTime() and a different conversion path to avoid this
back-reference from the compatibility layer to the generic code.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This is new. It was triggered by Junio's "mark function static" series.
 The patch that I sent out in response there was too simple to be correct.

 compat/mingw.c |   36 +++++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 74ffc18..ab65f77 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -140,12 +140,20 @@ int mingw_open (const char *filename, int oflags, ...)
 	return fd;
 }
 
-static inline time_t filetime_to_time_t(const FILETIME *ft)
+/*
+ * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
+ * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
+ */
+static inline long long filetime_to_hnsec(const FILETIME *ft)
 {
 	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
-	winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
-	winTime /= 10000000;		 /* Nano to seconds resolution */
-	return (time_t)winTime;
+	/* Windows to Unix Epoch conversion */
+	return winTime - 116444736000000000LL;
+}
+
+static inline time_t filetime_to_time_t(const FILETIME *ft)
+{
+	return (time_t)(filetime_to_hnsec(ft) / 10000000);
 }
 
 /* We keep the do_lstat code in a separate function to avoid recursion.
@@ -281,19 +289,13 @@ int mkstemp(char *template)
 
 int gettimeofday(struct timeval *tv, void *tz)
 {
-	SYSTEMTIME st;
-	struct tm tm;
-	GetSystemTime(&st);
-	tm.tm_year = st.wYear-1900;
-	tm.tm_mon = st.wMonth-1;
-	tm.tm_mday = st.wDay;
-	tm.tm_hour = st.wHour;
-	tm.tm_min = st.wMinute;
-	tm.tm_sec = st.wSecond;
-	tv->tv_sec = tm_to_time_t(&tm);
-	if (tv->tv_sec < 0)
-		return -1;
-	tv->tv_usec = st.wMilliseconds*1000;
+	FILETIME ft;
+	long long hnsec;
+
+	GetSystemTimeAsFileTime(&ft);
+	hnsec = filetime_to_hnsec(&ft);
+	tv->tv_sec = hnsec / 10000000;
+	tv->tv_usec = (hnsec % 10000000) / 10;
 	return 0;
 }
 
-- 
1.6.6.218.g3e6eb
