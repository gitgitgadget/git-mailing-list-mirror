From: Dinesh Polathula <dpdineshp2@gmail.com>
Subject: [PATCH] Allow "-" as a short-hand for "@{-1}" in "git branch -d @{-1}"
Date: Sun,  6 Mar 2016 18:18:14 +0530
Message-ID: <1457268494-8394-2-git-send-email-dpdineshp2@gmail.com>
References: <1457268494-8394-1-git-send-email-dpdineshp2@gmail.com>
Cc: Dinesh <dpdineshp2@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:48:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acY6n-0003j3-0C
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbcCFMsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:48:25 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35025 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbcCFMsX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:48:23 -0500
Received: by mail-pa0-f49.google.com with SMTP id bj10so62617987pad.2
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S7pzMD4iEgmV36FRjgGfXNBiDwUHsFEfcWn+MXtJJcQ=;
        b=bnGIla9Xlo/y2hQ2+L1ePmggnmLgFqldUlFKu8SBW+bGEg6PAAEwPnK5ujljCQzLJ0
         Qo8Agl+ZBkP1aSG9hLCXHw8Hlm4Nx4F2u24EL/K2n9jLLEvWdDEuGdj3SvRl0oiA3/WD
         Si4PPvz3qBxaWQ+1PBjwt2vspbfbFlXhuqvBh+Xo4sH2S8uSVv0PUnex6gVyJZZRMyl3
         alT4WoHr2hqWcEm81UzRD7z9pu0ukkq8yctNzKX8yxy4O5P9BBREW1sWc++on9AFRF3g
         i6p9tH9KWlYTZ4eK3tYMrhCCo3LQskFRCShJ7MlrwlFVd5GAz0uaAsXZJ07RG30MENfo
         Q9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S7pzMD4iEgmV36FRjgGfXNBiDwUHsFEfcWn+MXtJJcQ=;
        b=bqJMI8j8YEmPrKafAoJfaAkZrLYYImRjkR9QX3McsuOncr3gCsOWGZjwSPpIcKAfC8
         Nxx2AngbYtCvpQHAureG8cR4zep8aASjULYUMvn3gJwmftNoFMcdzcUlqT0UnUkQS00W
         CbHa5heI/0yvvuEwVy3F+lImLl+je2R9wApG1yTv5Pv0Ipj4YXyfBwdxxs4DO0fEnCY3
         vPFl1DwcybciWnq+te2CQIyHkMYQ+7vN3C7US0Xc2TIxm+YJsJ2Bz4FV6zYjyxM8vT9D
         YZfqG1BuGSY7KiRKQGlxBFz1lD19Z1Plg+2qcVerAbNL3vXAyrWbeCePGMEk4uF4J95Z
         lvHA==
X-Gm-Message-State: AD7BkJLxWyO9PBWupgj1DPxGqchh6AuljtkDwrNyPvmE/sFlnWiyT5zUQmZxPbY/3DSK4w==
X-Received: by 10.66.246.234 with SMTP id xz10mr26047417pac.49.1457268502781;
        Sun, 06 Mar 2016 04:48:22 -0800 (PST)
Received: from dinesh-pc.local.lan ([61.3.12.28])
        by smtp.gmail.com with ESMTPSA id v7sm17691453pfa.80.2016.03.06.04.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:48:22 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0
In-Reply-To: <1457268494-8394-1-git-send-email-dpdineshp2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288359>

From: Dinesh <dpdineshp2@gmail.com>

The "-" shorthand can be used as a replacement for "@{-1}" to refer
to the previous branch the user was on in the "git branch -d @{-1}"
command.
Replace "-" argument with "@{-1}" when the command line arguments
are parsed.

Signed-off-by: Dinesh Polathula<dpdineshp2@gmail.com>
---
 builtin/branch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..98d2c4b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -24,7 +24,7 @@
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
-	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
+	N_("git branch [<options>] [-r] (-d | -D) [-] <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	NULL
@@ -658,8 +658,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	filter.abbrev = -1;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_branch_usage, options);
-
+	{
+		usage_with_options(builtin_branch_usage, options);	
+	}
+	if (argc == 3 && !strcmp(argv[2], "-"))
+	{
+	    argv[2] = "@{-1}";	
+	}
 	git_config(git_branch_config, NULL);
 
 	track = git_branch_track;
-- 
2.8.0.rc0
