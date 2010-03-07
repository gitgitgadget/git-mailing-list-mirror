From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCHv2 1/3] Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*
Date: Sun,  7 Mar 2010 11:52:45 -0500
Message-ID: <1267980767-12617-2-git-send-email-lodatom@gmail.com>
References: <1267980767-12617-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 17:53:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoJjF-0005kc-AU
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 17:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab0CGQxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 11:53:13 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:56488 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab0CGQxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 11:53:10 -0500
Received: by qw-out-2122.google.com with SMTP id 5so896445qwd.37
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 08:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PYNKkg5U88aSozwcBB8FKvmmxwHz6UKVnDMUQhnmwbA=;
        b=DkrdUa1gs4BAAnr8TC5Qafp85Pm64Svqo7nHQVScfgTq64UMAvNyQKU3MzlSoKUpvx
         lu4mpPo5KuNzrtW4620AMebA9c3HccwwUiE5/0zfV8qBia5DRENBmQMI+dFt4LegP+qn
         U9FCMfm3EtA0uvxKLNmUxVvOP6EfdUDPp0lJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Qg2k4EQGoX5nOs5X7kQAAmgMH5CBS6IdiitQbKMzO2Ff4h1P6zqH8Niwgc1lIUEKww
         Hil/txIpZ2QPWMToPvY0CRDT5If/adhzZLaXIoqO/fcB1yF98wFifoaBlrAQ1J+RNDFr
         xh1H60ZLu3jTV1WyEjryTupmvYHXQocMQO9Ig=
Received: by 10.224.140.13 with SMTP id g13mr1850762qau.268.1267980789913;
        Sun, 07 Mar 2010 08:53:09 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm2767266qyk.4.2010.03.07.08.53.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 08:53:09 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267980767-12617-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141717>

Add GIT_COLOR_BOLD_* macros to set both bold and the color in one
sequence.  This saves two characters of output ("ESC [ m", minus ";")
and makes the code more readable.

Add the remaining GIT_COLOR_BG_* macros to make the list complete.
The white and black colors are not included since they look bad on most
terminals.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 builtin-grep.c |    2 +-
 color.h        |   11 +++++++++++
 graph.c        |   12 ++++++------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 2697957..2a876c4 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -847,7 +847,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	opt.regflags = REG_NEWLINE;
 	opt.max_depth = -1;
 
-	strcpy(opt.color_match, GIT_COLOR_RED GIT_COLOR_BOLD);
+	strcpy(opt.color_match, GIT_COLOR_BOLD_RED);
 	opt.color = -1;
 	git_config(grep_config, &opt);
 	if (opt.color == -1)
diff --git a/color.h b/color.h
index 3cb4b7f..bfeea1f 100644
--- a/color.h
+++ b/color.h
@@ -18,7 +18,18 @@
 #define GIT_COLOR_BLUE		"\033[34m"
 #define GIT_COLOR_MAGENTA	"\033[35m"
 #define GIT_COLOR_CYAN		"\033[36m"
+#define GIT_COLOR_BOLD_RED	"\033[1;31m"
+#define GIT_COLOR_BOLD_GREEN	"\033[1;32m"
+#define GIT_COLOR_BOLD_YELLOW	"\033[1;33m"
+#define GIT_COLOR_BOLD_BLUE	"\033[1;34m"
+#define GIT_COLOR_BOLD_MAGENTA	"\033[1;35m"
+#define GIT_COLOR_BOLD_CYAN	"\033[1;36m"
 #define GIT_COLOR_BG_RED	"\033[41m"
+#define GIT_COLOR_BG_GREEN	"\033[42m"
+#define GIT_COLOR_BG_YELLOW	"\033[43m"
+#define GIT_COLOR_BG_BLUE	"\033[44m"
+#define GIT_COLOR_BG_MAGENTA	"\033[45m"
+#define GIT_COLOR_BG_CYAN	"\033[46m"
 
 /*
  * This variable stores the value of color.ui
diff --git a/graph.c b/graph.c
index 6746d42..e6bbcaa 100644
--- a/graph.c
+++ b/graph.c
@@ -80,12 +80,12 @@ static char column_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BLUE,
 	GIT_COLOR_MAGENTA,
 	GIT_COLOR_CYAN,
-	GIT_COLOR_BOLD GIT_COLOR_RED,
-	GIT_COLOR_BOLD GIT_COLOR_GREEN,
-	GIT_COLOR_BOLD GIT_COLOR_YELLOW,
-	GIT_COLOR_BOLD GIT_COLOR_BLUE,
-	GIT_COLOR_BOLD GIT_COLOR_MAGENTA,
-	GIT_COLOR_BOLD GIT_COLOR_CYAN,
+	GIT_COLOR_BOLD_RED,
+	GIT_COLOR_BOLD_GREEN,
+	GIT_COLOR_BOLD_YELLOW,
+	GIT_COLOR_BOLD_BLUE,
+	GIT_COLOR_BOLD_MAGENTA,
+	GIT_COLOR_BOLD_CYAN,
 };
 
 #define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))
-- 
1.7.0
