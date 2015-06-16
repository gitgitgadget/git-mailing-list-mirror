From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 08/11] parse-option: rename parse_opt_with_commit()
Date: Tue, 16 Jun 2015 19:50:54 +0530
Message-ID: <1434464457-10749-8-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 16:27:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rpR-0007te-Rf
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbbFPO1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:27:00 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35961 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbbFPO06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:26:58 -0400
Received: by pabqy3 with SMTP id qy3so13802819pab.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4iLnl4JxYkKNQ3L4VLN0ry0vaUMg8oRPSVjZ1hZqjPo=;
        b=N/YFoCqwx6Jiwn56JbfT7LWJZb7DSrF5NtKcM+VIwAYcLoofqPsshz7iugSdV6UNcC
         A58l0VUxKUMq6m/AUeyCAFLoDkTQH3NjVkCwHQ6CTnR/NJWp5/SmgzxvutOS2pNruSOp
         mdSLUSOU4SgHEFDOfeo8OaFUhIofPUnw2Ko635isugYrp/ePjbdTDUCusIvdlYpQ7k0b
         GcZLhwocqSFZPUc7HSxWw4kLOaZqCgeTLAbyw7zTMnn3H9k1gSdDPVbv9iVs5Zn3dFgz
         5y/CVRGc+avT/HXA7coljJubF4cewvucgdoTY97it/ZWJo9qpatqSJ3HzIMU4wOsw03J
         p1wg==
X-Received: by 10.68.139.225 with SMTP id rb1mr1205005pbb.68.1434464818490;
        Tue, 16 Jun 2015 07:26:58 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm1594145pda.54.2015.06.16.07.26.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 07:26:57 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.436.g722e2ce.dirty
In-Reply-To: <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271761>

Rename parse_opt_with_commit() to parse_opt_commit_object_name()
to show that it can be used to obtain a list of commits and is
not constricted to usage of '--contains' option.

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
index ddd90e6..ddd728e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -828,13 +828,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
 			N_("print only branches that contain the commit"),
 			PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_with_commit, (intptr_t)"HEAD",
+			parse_opt_commit_object_name, (intptr_t)"HEAD",
 		},
 		{
 			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
 			N_("print only branches that contain the commit"),
 			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_with_commit, (intptr_t) "HEAD",
+			parse_opt_commit_object_name, (intptr_t) "HEAD",
 		},
 		OPT__ABBREV(&abbrev),
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 280981f..2d6610a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -603,13 +603,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
 			N_("print only tags that contain the commit"),
 			PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_with_commit, (intptr_t)"HEAD",
+			parse_opt_commit_object_name, (intptr_t)"HEAD",
 		},
 		{
 			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
 			N_("print only tags that contain the commit"),
 			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_with_commit, (intptr_t)"HEAD",
+			parse_opt_commit_object_name, (intptr_t)"HEAD",
 		},
 		{
 			OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
diff --git a/parse-options-cb.c b/parse-options-cb.c
index de75411..8bec5e4 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -77,7 +77,7 @@ int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
-int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
+int parse_opt_commit_object_name(const struct option *opt, const char *arg, int unset)
 {
 	unsigned char sha1[20];
 	struct commit *commit;
diff --git a/parse-options.h b/parse-options.h
index 36c71fe..8542d9c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -221,7 +221,7 @@ extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_object_name(const struct option *, const char *, int);
-extern int parse_opt_with_commit(const struct option *, const char *, int);
+extern int parse_opt_commit_object_name(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
-- 
2.4.3.436.g722e2ce.dirty
