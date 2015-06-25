From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 08/11] parse-option: rename parse_opt_with_commit()
Date: Thu, 25 Jun 2015 14:27:10 +0530
Message-ID: <1435222633-32007-8-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 10:58:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82yt-0000hM-Lm
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbFYI5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:57:54 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:32844 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbFYI5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:57:52 -0400
Received: by pdjn11 with SMTP id n11so49343075pdj.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2enAA2nhzrFDbRrk+YY6NfE4AU4urphsJLd+m0N8PDE=;
        b=F3sQDf715/BBww3RDUP6iEQhnOs/lvsvp497QgNF0NF5ymBs33w9pyYe7pUC8H0oN9
         zONt84sEtk6p1wXWcm7v5CIVIaaujnSTjT36E1+iE58enb8c85vF5f6vp5ehQyrMAqOG
         lg4OeTA3epc/vtafE8j8CdvNdo/CPV89t3AhGI+Dhg//h5lOlu/M+doZNe9Iv4OdcJ18
         dLE8hIVyPG4F6C7QmOScGeWwnFclFwFA9xGb3No84FIgAZAle1m5BIUmlR+JxHWBLGAG
         0xFDaLE/kOSzlzXD4UQhLLn7L2sLaLrvcuerb/2XcPuluN/uNliGXAiDGXgjrQ9xLu4K
         /EEA==
X-Received: by 10.70.124.134 with SMTP id mi6mr89773134pdb.104.1435222672318;
        Thu, 25 Jun 2015 01:57:52 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id wa4sm29391000pab.17.2015.06.25.01.57.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 01:57:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272649>

Rename parse_opt_with_commit() to parse_opt_commits() to show
that it can be used to obtain a list of commits and is not
constricted to usage of '--contains' option.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c   | 4 ++--
 builtin/tag.c      | 4 ++--
 parse-options-cb.c | 2 +-
 parse-options.h    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ddd90e6..a008b0d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -828,13 +828,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
 			N_("print only branches that contain the commit"),
 			PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_with_commit, (intptr_t)"HEAD",
+			parse_opt_commits, (intptr_t)"HEAD",
 		},
 		{
 			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
 			N_("print only branches that contain the commit"),
 			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_with_commit, (intptr_t) "HEAD",
+			parse_opt_commits, (intptr_t) "HEAD",
 		},
 		OPT__ABBREV(&abbrev),
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 280981f..7af45a0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -603,13 +603,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
 			N_("print only tags that contain the commit"),
 			PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_with_commit, (intptr_t)"HEAD",
+			parse_opt_commits, (intptr_t)"HEAD",
 		},
 		{
 			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
 			N_("print only tags that contain the commit"),
 			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_with_commit, (intptr_t)"HEAD",
+			parse_opt_commits, (intptr_t)"HEAD",
 		},
 		{
 			OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
diff --git a/parse-options-cb.c b/parse-options-cb.c
index de75411..632f10f 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -77,7 +77,7 @@ int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
-int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
+int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 {
 	unsigned char sha1[20];
 	struct commit *commit;
diff --git a/parse-options.h b/parse-options.h
index 36c71fe..2ffd857 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -221,7 +221,7 @@ extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_object_name(const struct option *, const char *, int);
-extern int parse_opt_with_commit(const struct option *, const char *, int);
+extern int parse_opt_commits(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
-- 
2.4.4
