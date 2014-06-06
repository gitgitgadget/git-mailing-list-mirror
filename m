From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 1/5] Support Unicode console output on Windows
Date: Fri,  6 Jun 2014 15:42:49 +0200
Message-ID: <1402062173-9602-2-git-send-email-kasal@ucw.cz>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com Fri Jun 06 15:43:21 2014
Return-path: <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>)
	id 1WsuQP-0000fZ-5L
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 15:43:17 +0200
Received: by mail-wg0-f59.google.com with SMTP id k14sf228529wgh.24
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=A/V5ZT/+5cFY5Jd0mbeJedct42Y05YFw0rrXqbuLh3E=;
        b=PGkLvCT9X2k2Kbz42B7D2aALihv8r0t0GTHYbAe/spIasXJhRvK7GvTNFLp0aLRksf
         qpcjq1zCbM1ThkCe6FRqlopTES/ffkVn5rCagVwfDfj6/V0VA3mqleUhrvhodJVLf4lT
         VhENXPkI5o2Rx26ha8Hv5yzZy3odrbIwnzzzJXfrk3zN4MTzWtdcpNuCRyjhl5RuOclb
         WVnkr3hONQ8aYz53GVXp+2j4ZlWKpOWEmNULnHoYeGKI3RGksDStJ0k82j6IdsbOH7RE
         I8gD045ELu34scDeQlboNlAvgpPtQZwiNvG49IR2fbRRVp+BTFAzsesSXo4j+5iwBXTi
         wL3Q==
X-Received: by 10.152.23.65 with SMTP id k1mr15670laf.21.1402062196905;
        Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.87.178 with SMTP id az18ls133628lab.4.gmail; Fri, 06 Jun
 2014 06:43:15 -0700 (PDT)
X-Received: by 10.112.156.138 with SMTP id we10mr1376115lbb.12.1402062195835;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id x7si1305809wiw.1.2014.06.06.06.43.15
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 9106A1C00A0; Fri,  6 Jun 2014 15:43:15 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250902>

From: Karsten Blees <blees@dcon.de>

WriteConsoleW seems to be the only way to reliably print unicode to the
console (without weird code page conversions).

Also redirects vfprintf to the winansi.c version.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.h   |  2 ++
 compat/winansi.c | 26 ++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 3eaf822..a465d1e 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -320,9 +320,11 @@ int mingw_raise(int sig);
 int winansi_fputs(const char *str, FILE *stream);
 int winansi_printf(const char *format, ...) __attribute__((format (printf, 1, 2)));
 int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format (printf, 2, 3)));
+int winansi_vfprintf(FILE *stream, const char *format, va_list list);
 #define fputs winansi_fputs
 #define printf(...) winansi_printf(__VA_ARGS__)
 #define fprintf(...) winansi_fprintf(__VA_ARGS__)
+#define vfprintf winansi_vfprintf
 
 /*
  * git specific compatibility
diff --git a/compat/winansi.c b/compat/winansi.c
index dedce21..abe0fea 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -3,6 +3,7 @@
  */
 
 #include "../git-compat-util.h"
+#include <malloc.h>
 
 /*
  Functions to be wrapped:
@@ -10,6 +11,7 @@
 #undef printf
 #undef fprintf
 #undef fputs
+#undef vfprintf
 /* TODO: write */
 
 /*
@@ -46,6 +48,18 @@ static void init(void)
 	initialized = 1;
 }
 
+static int write_console(const char *str, size_t len)
+{
+	/* convert utf-8 to utf-16, write directly to console */
+	int wlen = MultiByteToWideChar(CP_UTF8, 0, str, len, NULL, 0);
+	wchar_t *wbuf = (wchar_t *) alloca(wlen * sizeof(wchar_t));
+	MultiByteToWideChar(CP_UTF8, 0, str, len, wbuf, wlen);
+
+	WriteConsoleW(console, wbuf, wlen, NULL, NULL);
+
+	/* return original (utf-8 encoded) length */
+	return len;
+}
 
 #define FOREGROUND_ALL (FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE)
 #define BACKGROUND_ALL (BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE)
@@ -245,13 +259,15 @@ static int ansi_emulate(const char *str, FILE *stream)
 	int rv = 0;
 	const char *pos = str;
 
+	fflush(stream);
+
 	while (*pos) {
 		pos = strstr(str, "\033[");
 		if (pos) {
 			size_t len = pos - str;
 
 			if (len) {
-				size_t out_len = fwrite(str, 1, len, stream);
+				size_t out_len = write_console(str, len);
 				rv += out_len;
 				if (out_len < len)
 					return rv;
@@ -260,14 +276,12 @@ static int ansi_emulate(const char *str, FILE *stream)
 			str = pos + 2;
 			rv += 2;
 
-			fflush(stream);
-
 			pos = set_attr(str);
 			rv += pos - str;
 			str = pos;
 		} else {
-			rv += strlen(str);
-			fputs(str, stream);
+			size_t len = strlen(str);
+			rv += write_console(str, len);
 			return rv;
 		}
 	}
@@ -294,7 +308,7 @@ int winansi_fputs(const char *str, FILE *stream)
 		return EOF;
 }
 
-static int winansi_vfprintf(FILE *stream, const char *format, va_list list)
+int winansi_vfprintf(FILE *stream, const char *format, va_list list)
 {
 	int len, rv;
 	char small_buf[256];
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
