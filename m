From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 3/4] mingw: make failures to unlink or move raise
 a question
Date: Sun,  7 Nov 2010 15:56:26 +0100
Message-ID: <b25a0668848fd85521da9b7dd7e1ca82c2c16e7f.1289139299.git.hvoigt@hvoigt.net>
References: <cover.1289139299.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncCOrwtbejChC2_NrmBBoEEhHJUQ@googlegroups.com Sun Nov 07 15:57:20 2010
Return-path: <msysgit+bncCOrwtbejChC2_NrmBBoEEhHJUQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOrwtbejChC2_NrmBBoEEhHJUQ@googlegroups.com>)
	id 1PF6gI-0002Pc-LB
	for gcvm-msysgit@m.gmane.org; Sun, 07 Nov 2010 15:57:18 +0100
Received: by mail-fx0-f58.google.com with SMTP id 11sf1123881fxm.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 07 Nov 2010 06:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=NoPuPfZBZq42rQwt5qasTsb9yZ5bpazl1QTXWMManwA=;
        b=VG7S8YOkAHT/cs+IOHPkxgsilX2so/GQkdCR1qqgyiI/gbvXOPlELgjnr1OY6Ps5jc
         yQ/rS4M3dH650TjZ4kgxeSD6JZ/D7SyMv+TfBpmpavsHgPxKOoCi/ipyf1yCGikeOvPh
         +yqglVevXqTxbqOJ559rmNW+/kGY1P8TD+PYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=xn+JmpPr0DE/BXc2uNFjxf1x2DpIs6jgvjGl2a3Uhw6SPHw+thWQw9frWJBvWAInAv
         dL10R4eQbxCtIEYJatQLWE5e1206Kh3vI4S4OUndaViRSVkj7v7oW4FYKSXP7VNpS3sq
         NVZ5e5pa+JADOwpZRsfor3ay4TfYzFEi/I0TA=
Received: by 10.223.79.72 with SMTP id o8mr128514fak.42.1289141814605;
        Sun, 07 Nov 2010 06:56:54 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.99.144 with SMTP id u16ls1045771fan.2.p; Sun, 07 Nov 2010
 06:56:54 -0800 (PST)
Received: by 10.223.72.197 with SMTP id n5mr225068faj.16.1289141813991;
        Sun, 07 Nov 2010 06:56:53 -0800 (PST)
Received: by 10.223.72.197 with SMTP id n5mr225067faj.16.1289141813862;
        Sun, 07 Nov 2010 06:56:53 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id e7si946806fak.9.2010.11.07.06.56.53;
        Sun, 07 Nov 2010 06:56:53 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 21224 invoked from network); 7 Nov 2010 15:56:53 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2010 15:56:53 +0100
X-Mailer: git-send-email 1.7.2.2.177.geec0d
In-Reply-To: <cover.1289139299.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1289139299.git.hvoigt@hvoigt.net>
References: <201009282252.25688.j6t@kdbg.org> <cover.1289139299.git.hvoigt@hvoigt.net>
X-Original-Sender: hvoigt@hvoigt.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 83.133.111.250 is neither permitted nor denied by best guess record for
 domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160883>

On Windows in case a program is accessing a file unlink or
move operations may fail. To give the user a chance to correct
this we simply wait until the user asks us to retry or fail.

This is useful because of the following use case which seem
to happen rarely but when it does it is a mess:

After making some changes the user realizes that he was on the
incorrect branch. When trying to change the branch some file
is still in use by some other process and git stops in the
middle of changing branches. Now the user has lots of files
with changes mixed with his own. This is especially confusing
on repositories that contain lots of files.

Although the recent implementation of automatic retry makes
this scenario much more unlikely lets provide a fallback as
a last resort.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 compat/mingw.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index bf9ffb8..b66bf89 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,6 +3,7 @@
 #include <conio.h>
 #include "../strbuf.h"
 #include "../cache.h"
+#include "../run-command.h"
 
 unsigned int _CRT_fmode = _O_BINARY;
 static const int delay[] = { 0, 1, 10, 20, 40 };
@@ -163,6 +164,78 @@ int mingw_mkdir(const char *path, int mode)
 	return ret;
 }
 
+static int read_yes_no_answer()
+{
+	char answer[1024];
+
+	if (fgets(answer, sizeof(answer), stdin)) {
+		size_t answer_len = strlen(answer);
+		int got_full_line = 0, c;
+
+		/* remove the newline */
+		if (answer_len >= 2 && answer[answer_len-2] == '\r') {
+			answer[answer_len-2] = '\0';
+			got_full_line = 1;
+		}
+		else if (answer_len >= 1 && answer[answer_len-1] == '\n') {
+			answer[answer_len-1] = '\0';
+			got_full_line = 1;
+		}
+		/* flush the buffer in case we did not get the full line */
+		if (!got_full_line)
+			while((c = getchar()) != EOF && c != '\n');
+	} else
+		/* we could not read, return the
+		 * default answer which is no */
+		return 0;
+
+	if (answer[0] == 'y' && strlen(answer) == 1)
+		return 1;
+	if (!strncasecmp(answer, "yes", sizeof(answer)))
+		return 1;
+	if (answer[0] == 'n' && strlen(answer) == 1)
+		return 0;
+	if (!strncasecmp(answer, "no", sizeof(answer)))
+		return 0;
+
+	/* did not find an answer we understand */
+	return -1;
+}
+
+static int ask_user_yes_no(const char *format, ...)
+{
+	char question[4096];
+	const char *retry_hook[] = { NULL, NULL, NULL };
+	va_list args;
+
+	if ((retry_hook[0] = getenv("GIT_ASK_YESNO"))) {
+
+		va_start(args, format);
+		vsnprintf(question, sizeof(question), format, args);
+		va_end(args);
+
+		retry_hook[1] = question;
+		return !run_command_v_opt(retry_hook, 0);
+	}
+
+	if (!isatty(_fileno(stdin)))
+		return 0;
+
+	while (1) {
+		int answer;
+		va_start(args, format);
+		vfprintf(stderr, format, args);
+		va_end(args);
+		fprintf(stderr, " (y/n)? ");
+
+		if ((answer = read_yes_no_answer()) >= 0)
+			return answer;
+
+		fprintf(stderr, "Sorry, I did not understand your answer. "
+				"Please type 'y' or 'n'\n");
+	}
+}
+
 #undef unlink
 int mingw_unlink(const char *pathname)
 {
@@ -183,6 +256,10 @@ int mingw_unlink(const char *pathname)
 		Sleep(delay[tries]);
 		tries++;
 	}
+	while (ret == -1 && is_file_in_use_error() &&
+	       ask_user_yes_no("Unlink of file '%s' failed. "
+			"Should I try again?", pathname))
+	       ret = unlink(pathname);
 	return ret;
 }
 
@@ -1343,6 +1420,11 @@ repeat:
 		tries++;
 		goto repeat;
 	}
+	if (gle == ERROR_ACCESS_DENIED &&
+	       ask_user_yes_no("Rename from '%s' to '%s' failed. "
+		       "Should I try again?", pold, pnew))
+		goto repeat;
+
 	errno = EACCES;
 	return -1;
 }
-- 
1.7.2.2.177.geec0d
