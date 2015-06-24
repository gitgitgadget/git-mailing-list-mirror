From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 08/11] parse-option: rename parse_opt_with_commit()
Date: Thu, 25 Jun 2015 01:23:49 +0530
Message-ID: <1435175632-27803-8-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
 <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 21:54:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qki-00083M-I4
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbbFXTy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:54:28 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33665 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbbFXTyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:54:21 -0400
Received: by padev16 with SMTP id ev16so35085868pad.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2enAA2nhzrFDbRrk+YY6NfE4AU4urphsJLd+m0N8PDE=;
        b=gu8gsl4G1b/LYjiOBR8XYjeDIfRS8qo/F7q+2Ad9Rg16v3/K232b1cMaAwT6kaS/0D
         4ZADGo+Va1cJQb6dWEx9r+iZwmBuAgoGJGgsQv9ydQ5XwIZ0+qr8ni5DCe0voo/05P3p
         gcylyTXx3N/Kg5Au1DokAL0GVDxUJUTszCBLhl5NJ7SlLBPu8XEPVGQlyBWKJfeXz4AB
         a98/U5JV9QSfiJRDEICN9Cjl82nyLWMLyyl6Zz7WVgg6mTdvjvIRCinemsQvqjD9mOLK
         JDRZdV1fjfzoTLQvsk7Y25+Zg7ZvT+0uvcmLmvtQao+V6YN2E5ipaOxQs+t2r2ANGVO4
         OoOA==
X-Received: by 10.70.38.10 with SMTP id c10mr82963491pdk.72.1435175660535;
        Wed, 24 Jun 2015 12:54:20 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id zx1sm27583483pbb.73.2015.06.24.12.54.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:54:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272599>

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
