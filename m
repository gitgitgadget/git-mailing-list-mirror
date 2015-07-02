From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 08/11] parse-option: rename parse_opt_with_commit()
Date: Thu,  2 Jul 2015 20:51:07 +0530
Message-ID: <1435850470-5175-8-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 17:22:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAgJi-0000RF-63
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 17:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbbGBPWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 11:22:16 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35979 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbbGBPWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 11:22:07 -0400
Received: by pdcu2 with SMTP id u2so47654527pdc.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4O0G3PCfeUtlrBNW5Y8vO0tVXd7/TELVvSFw9JiNsfg=;
        b=wLYNEjtDDxC8b7cJcfsJjJwVObmTf/HnJb8/wg8hPjzJ5Z3qt3EEDLDsvjjdrrYSdD
         uAaMb0sTx3FBBMPty07KW0qaD8BfUhUbA1nBLbzGkekhM/ZyaUQ9eynUCx39+WP3COvo
         gcCPicLq1/5kBxQlWkFvRGL14JQIUNotHyhq2KgS5a7huHvhHlXJAjKbpPANeHfjckQe
         ZWVUaryoNmRbhr9GlVt7gECxNBNHbj24mvPrV+czD1J/T/K5GZFfRywMDxK8vjIL+KXH
         xvN6Z+eioCf2SrD8TaU74wAUFTCfUlerHgYxrRDoDJ/udW3VKjwtgcaxSir+9aU3gB1e
         d1wA==
X-Received: by 10.70.101.168 with SMTP id fh8mr66669464pdb.15.1435850526525;
        Thu, 02 Jul 2015 08:22:06 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id fu2sm635208pdb.32.2015.07.02.08.22.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 08:22:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273240>

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
index e63102e..ae9a0eb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -832,13 +832,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
index 1478818..583690c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -224,7 +224,7 @@ extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
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
