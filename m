From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 4/5] mingw: reuse tty-version of git_terminal_prompt
Date: Tue, 13 Nov 2012 15:04:06 +0100
Message-ID: <1352815447-8824-5-git-send-email-kusmabite@gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: git@vger.kernel.org,
	msysgit@googlegroups.com
X-From: msysgit+bncBDR53PPJ7YHRB45GRGCQKGQEAMTSF5Y@googlegroups.com Tue Nov 13 15:04:48 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB45GRGCQKGQEAMTSF5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f58.google.com ([209.85.214.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB45GRGCQKGQEAMTSF5Y@googlegroups.com>)
	id 1TYH6b-0004I4-K7
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 15:04:45 +0100
Received: by mail-bk0-f58.google.com with SMTP id j10sf2511217bkw.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Nov 2012 06:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=FbQtKinWr+6lP/NzsbCc95ZfBKKGaekQ5W3DfXzkP64=;
        b=LyKFF2810Hur1CrirJm8E4+E/ZmMZRzWal4yB/qPIfUPr8cDg7vI/NoZbiZMmFjxdZ
         ulaj6JDzTSwUD9lm8CHs3k92lWEO6x8JnuvHOmxgVjDKly5pCKM9G/Ghbgqu0P5Kw29X
         X3Tll3Ji7iBpcb3tTbThoDYkb5kPYEuRZSlhEr7ccVQH60PrT0dDCjrVuXb16F869sQg
         vmZTv7/ilqlTxjomR1TRhnM5X+qcEY4ZMCekMRwHFoojSTySORVRYhMWoa/3uKsyaUxC
         OJCX2ggLsK25nRHORgD8KvQR7C+Vlkbst16JJN0ICy02VL9dTcHh7WuhotDxfRsS8jnm
         RQoA==
Received: by 10.204.9.5 with SMTP id j5mr2095279bkj.9.1352815476123;
        Tue, 13 Nov 2012 06:04:36 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.153.24 with SMTP id i24ls1720381bkw.7.gmail; Tue, 13 Nov
 2012 06:04:35 -0800 (PST)
Received: by 10.204.11.65 with SMTP id s1mr178212bks.7.1352815475317;
        Tue, 13 Nov 2012 06:04:35 -0800 (PST)
Received: by 10.204.11.65 with SMTP id s1mr178211bks.7.1352815475297;
        Tue, 13 Nov 2012 06:04:35 -0800 (PST)
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com [209.85.217.170])
        by gmr-mx.google.com with ESMTPS id v13si828618bkw.0.2012.11.13.06.04.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:35 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.217.170 as permitted sender) client-ip=209.85.217.170;
Received: by mail-lb0-f170.google.com with SMTP id gm13so5174048lbb.15
        for <msysgit@googlegroups.com>; Tue, 13 Nov 2012 06:04:35 -0800 (PST)
Received: by 10.152.110.229 with SMTP id id5mr21625705lab.36.1352815475001;
        Tue, 13 Nov 2012 06:04:35 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id bf3sm3826859lbb.16.2012.11.13.06.04.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:34 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.1.g1cbcfae.dirty
In-Reply-To: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.217.170 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209608>

The getpass-implementation we use on Windows isn't at all ideal;
it works in raw-mode (as opposed to cooked mode), and as a result
does not deal correcly with deletion, arrow-keys etc.

Instead, use cooked mode to read a line at the time, allowing the
C run-time to process the input properly.

Since we set files to be opened in binary-mode by default on
Windows, introduce a FORCE_TEXT macro that expands to the "t"
modifier that forces the terminal to be opened in text-mode so we
do not have to deal with CRLF issues.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/terminal.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 4a1fd3d..ce0fbd9 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -3,8 +3,22 @@
 #include "sigchain.h"
 #include "strbuf.h"
 
+#if defined(HAVE_DEV_TTY) || defined(WIN32)
+
+static void restore_term(void);
+
+static void restore_term_on_signal(int sig)
+{
+	restore_term();
+	sigchain_pop(sig);
+	raise(sig);
+}
+
 #ifdef HAVE_DEV_TTY
 
+#define INPUT_PATH "/dev/tty"
+#define OUTPUT_PATH "/dev/tty"
+
 static int term_fd = -1;
 static struct termios old_term;
 
@@ -18,13 +32,6 @@ static void restore_term(void)
 	term_fd = -1;
 }
 
-static void restore_term_on_signal(int sig)
-{
-	restore_term();
-	sigchain_pop(sig);
-	raise(sig);
-}
-
 static int disable_echo()
 {
 	struct termios t;
@@ -46,17 +53,61 @@ error:
 	return -1;
 }
 
+#elif defined(WIN32)
+
+#define INPUT_PATH "CONIN$"
+#define OUTPUT_PATH "CONOUT$"
+#define FORCE_TEXT "t"
+
+static HANDLE hconin = INVALID_HANDLE_VALUE;
+static DWORD cmode;
+
+static void restore_term(void)
+{
+	if (hconin == INVALID_HANDLE_VALUE)
+		return;
+
+	SetConsoleMode(hconin, cmode);
+	CloseHandle(hconin);
+	hconin = INVALID_HANDLE_VALUE;
+}
+
+static int disable_echo(void)
+{
+	hconin = CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
+	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
+	    FILE_ATTRIBUTE_NORMAL, NULL);
+	if (hconin == INVALID_HANDLE_VALUE)
+		return -1;
+
+	GetConsoleMode(hconin, &cmode);
+	sigchain_push_common(restore_term_on_signal);
+	if (!SetConsoleMode(hconin, cmode & (~ENABLE_ECHO_INPUT))) {
+		CloseHandle(hconin);
+		hconin = INVALID_HANDLE_VALUE;
+		return -1;
+	}
+
+	return 0;
+}
+
+#endif
+
+#ifndef FORCE_TEXT
+#define FORCE_TEXT
+#endif
+
 char *git_terminal_prompt(const char *prompt, int echo)
 {
 	static struct strbuf buf = STRBUF_INIT;
 	int r;
 	FILE *input_fh, *output_fh;
 
-	input_fh = fopen("/dev/tty", "r");
+	input_fh = fopen(INPUT_PATH, "r" FORCE_TEXT);
 	if (!input_fh)
 		return NULL;
 
-	output_fh = fopen("/dev/tty", "w");
+	output_fh = fopen(OUTPUT_PATH, "w" FORCE_TEXT);
 	if (!output_fh) {
 		fclose(input_fh);
 		return NULL;
-- 
1.8.0.7.gbeffeda

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
