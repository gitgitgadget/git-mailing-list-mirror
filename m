Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E548C04E69
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjHJQiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjHJQhb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:37:31 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D402D7F
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:19 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-564fec87e4fso1423733a12.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691685439; x=1692290239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xg6X9acYqDxAbpbyRKoaikCwIC1ixFALe5UD9PsE4qA=;
        b=lG3oKi5SNxaJpbPlYNXyiHjADbXCFoze7AEmZ2rV7s6RmzG6GWwxJKW8fTB5mtEHP5
         6gnPlQtnTeQ+kWLkKeFfkqMvu7oVFwvNuc1G4Iih3/CfXej2iptaOnBhSJhjZBZ/BgS8
         YP9UZwOJj55+CHtMTBuAmJmL7ehM/rmZ7Go8ZQ/pTanS3Bwx9QjAzcmFglBL6QAhPgt8
         MZDb8aNp6SA5dVaUBV+3rCLDkrhfqGxtvfTQQuVdtigfGRjhOJ5UCgALqIkB9tlfok84
         gFggpD5M/oxVgMmV9OPBMoWAlHjeaNEER3WSeE/xtKHzCDyFVtS3Y+dRhqyZItxJggBy
         32Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685439; x=1692290239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xg6X9acYqDxAbpbyRKoaikCwIC1ixFALe5UD9PsE4qA=;
        b=AInBN9rwfySJ10usIsEIWhRhymVl2MDRoA0IUGKmeJ+fpAy3n3U8oOEGUa0DsYxKF+
         btFkfUAR8D6uewV3mD9HqZsaoBIFHzs2w65sdqOADLf2ecKhkW58f50KcIH9Jo4JldjW
         VlhUHEhtNNUzzRqU+fj0B3jV4zhSgoa/tWp8+i5tHPx4QdFHlllmA1nCXsdi5Jh8XM3c
         r901gyN+FOtQpF2JaCeaewVsxWGLUQVB/8C5Z/mNAJEWsBekCYE2sjrfKCMWy5Fbrx5D
         aICkBOZkFlXvCdWBBx/oPUnBEetsppwt+NNoqsDEcITcUrHqfOCo7lf0yFpGtZuHy1uO
         WnDQ==
X-Gm-Message-State: AOJu0Ywn1M1ZSTWrjEmm7qYLasIjAIDY58wDonFLg10lvQU/wgheiO63
        WdNwrAueQBJ+HBOEHD3caizxgphFucPv09WU58GDIX9CEPohDw+g+rthWBdG+pH+2ixNmM4EeHM
        WkB+UQbcFm3wwonffn0XsDygoWaDgKvpNJHOitDEustsgW2LxKe+vvwoshff6q2sr5Q==
X-Google-Smtp-Source: AGHT+IFf+7EWZqOhfET8+xzB5ng3QsolvfBONpJ3P+cE+aX4ff9VfyWNL3aDXqocK3QMw+TzLCZOVV9nOa7bGgs=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:770f:0:b0:55f:d4a4:57ba with SMTP id
 s15-20020a63770f000000b0055fd4a457bamr207452pgc.8.1691685439207; Thu, 10 Aug
 2023 09:37:19 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:36:52 +0000
In-Reply-To: <20230810163346.274132-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230810163346.274132-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810163654.275023-5-calvinwan@google.com>
Subject: [RFC PATCH v2 5/7] date: push pager.h dependency up
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order for date.c to be included in git-std-lib, the dependency to
pager.h must be removed since it has dependencies on many other files
not in git-std-lib. We achieve this by passing a boolean for
"pager_in_use", rather than checking for it in parse_date_format() so
callers of the function will have that dependency.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 builtin/blame.c      | 2 +-
 builtin/log.c        | 2 +-
 date.c               | 5 ++---
 date.h               | 2 +-
 ref-filter.c         | 3 ++-
 revision.c           | 3 ++-
 t/helper/test-date.c | 3 ++-
 7 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9a3f9facea..665511570d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -714,7 +714,7 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "blame.date")) {
 		if (!value)
 			return config_error_nonbool(var);
-		parse_date_format(value, &blame_date_mode);
+		parse_date_format(value, &blame_date_mode, pager_in_use());
 		return 0;
 	}
 	if (!strcmp(var, "blame.ignorerevsfile")) {
diff --git a/builtin/log.c b/builtin/log.c
index 03954fb749..a72ce30c2e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -185,7 +185,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->diffopt.flags.allow_textconv = 1;
 
 	if (default_date_mode)
-		parse_date_format(default_date_mode, &rev->date_mode);
+		parse_date_format(default_date_mode, &rev->date_mode, pager_in_use());
 }
 
 static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
diff --git a/date.c b/date.c
index 619ada5b20..55f73ce2e0 100644
--- a/date.c
+++ b/date.c
@@ -7,7 +7,6 @@
 #include "git-compat-util.h"
 #include "date.h"
 #include "gettext.h"
-#include "pager.h"
 #include "strbuf.h"
 
 /*
@@ -1003,13 +1002,13 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
 	die("unknown date format %s", format);
 }
 
-void parse_date_format(const char *format, struct date_mode *mode)
+void parse_date_format(const char *format, struct date_mode *mode, int pager_in_use)
 {
 	const char *p;
 
 	/* "auto:foo" is "if tty/pager, then foo, otherwise normal" */
 	if (skip_prefix(format, "auto:", &p)) {
-		if (isatty(1) || pager_in_use())
+		if (isatty(1) || pager_in_use)
 			format = p;
 		else
 			format = "default";
diff --git a/date.h b/date.h
index 6136212a19..d9bd6dc09f 100644
--- a/date.h
+++ b/date.h
@@ -53,7 +53,7 @@ const char *show_date(timestamp_t time, int timezone, const struct date_mode *mo
  * be used with strbuf_addftime(), in which case you'll need to call
  * date_mode_release() later.
  */
-void parse_date_format(const char *format, struct date_mode *mode);
+void parse_date_format(const char *format, struct date_mode *mode, int pager_in_use);
 
 /**
  * Release a "struct date_mode", currently only required if
diff --git a/ref-filter.c b/ref-filter.c
index 2ed0ecf260..1b96bb7822 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -28,6 +28,7 @@
 #include "worktree.h"
 #include "hashmap.h"
 #include "strvec.h"
+#include "pager.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -1323,7 +1324,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	formatp = strchr(atomname, ':');
 	if (formatp) {
 		formatp++;
-		parse_date_format(formatp, &date_mode);
+		parse_date_format(formatp, &date_mode, pager_in_use());
 	}
 
 	if (!eoemail)
diff --git a/revision.c b/revision.c
index 985b8b2f51..c7efd11914 100644
--- a/revision.c
+++ b/revision.c
@@ -46,6 +46,7 @@
 #include "resolve-undo.h"
 #include "parse-options.h"
 #include "wildmatch.h"
+#include "pager.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2577,7 +2578,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->date_mode.type = DATE_RELATIVE;
 		revs->date_mode_explicit = 1;
 	} else if ((argcount = parse_long_opt("date", argv, &optarg))) {
-		parse_date_format(optarg, &revs->date_mode);
+		parse_date_format(optarg, &revs->date_mode, pager_in_use());
 		revs->date_mode_explicit = 1;
 		return argcount;
 	} else if (!strcmp(arg, "--log-size")) {
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 0683d46574..b3927a95b3 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "date.h"
+#include "pager.h"
 #include "trace.h"
 
 static const char *usage_msg = "\n"
@@ -37,7 +38,7 @@ static void show_dates(const char **argv, const char *format)
 {
 	struct date_mode mode = DATE_MODE_INIT;
 
-	parse_date_format(format, &mode);
+	parse_date_format(format, &mode, pager_in_use());
 	for (; *argv; argv++) {
 		char *arg;
 		timestamp_t t;
-- 
2.41.0.640.ga95def55d0-goog

