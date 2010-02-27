From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 2/5] Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*
Date: Fri, 26 Feb 2010 23:57:47 -0500
Message-ID: <1267246670-19118-3-git-send-email-lodatom@gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 05:54:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlEhT-0007hl-EL
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967862Ab0B0EyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 23:54:24 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:51848 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967841Ab0B0EyO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 23:54:14 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so475291qyk.5
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 20:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Qnl+Avlvk36LqfefDrsqWqnRrV58BoqBnXNt6kV3P5A=;
        b=VCqb+VpSpOLzUHOhj1mwbrvjWUZKzwj/BTaaVvCxXnG0K0/xrCUm2RMW0+QYGjamRb
         p29JhV1ny5EmSYnEBSe4esN9yYdaWlWu+nZhv9DVdfiMOZPdn5pj7PkeWCROcQnRHC1v
         AuYq4D5DAoJbfk+fkks7Z8pY0SbF4YKiiwHaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tU32G+Q9wzMkAEXLhFu5OMI9MN8gG2I5JO1+bM2bXmD51chwyfZOixlMGUgLA3iYcw
         V84DX0hhTLFSTenV8Cwyecq+bJ0wMfJEHCmSuBWiOWQEVPo5WzWdrLJLZPsUPO6f/HnO
         EiWMZuVQNAJqwpKDHH+xbdjLREjWzXrspL1W4=
Received: by 10.224.87.19 with SMTP id u19mr809881qal.8.1267246453743;
        Fri, 26 Feb 2010 20:54:13 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm622133qyk.12.2010.02.26.20.54.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 20:54:13 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141188>

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
index 552ef1f..dcc3d48 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -871,7 +871,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
