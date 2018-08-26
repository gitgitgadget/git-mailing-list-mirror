Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5C61F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeHZNpc (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40907 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHZNpa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id x26-v6so7661818lfi.7
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYHjBUIPWouVA3zUK4vd46RJS6XuINMCKe98PYuAdS4=;
        b=rY5F6aS53+5uJC449Zj7oeh5JoDEZrOASHqov6eRlin+M+hgQ5U0PHRZDwQUN+WnBA
         cLQPywNofpFYxa0N9Fct7DUl0ehFQGSCQXoB+cDHz6DJP9acksXwfGxRfKCWa1pWH/Ud
         PQ2nL9bcEfllSz5MuNcTBnJxLf59oEssntVsuM7rK8tXsdqKmKSvyKChTImK0Tcoqx/4
         vqGguHsyDD2HbdIQ8c9PDsDG6LW/GcZ/qbs4/m1UKgacj+SUixluhjN9kr2Ygawq0JhJ
         v15EUjC6c8sgpnb/hnE3wVeFg2pPnyUtS4/Uqp8L0Gf55cNAomEAm8HMhvsGoDBrvU8Y
         MK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYHjBUIPWouVA3zUK4vd46RJS6XuINMCKe98PYuAdS4=;
        b=HAnlT9+Zdjl3sr+nq6738X5MSlk7EOdUAes9kCcst9LwIu/WBFWuU3RgTJzBZA2yAQ
         Ppt8Fmn1gjLVtHZFjlY+4Pi06QJrckl6XzCWvFSIqV5b+fQeFqy/YOq2YdWZ16rNPJ8h
         kjdtv74dNnh04fFIuQMR7PM9kLq/S5jQd7HcDPvW2jhDWAZsFh3VqEOhT20Thm7YYV5G
         xurlZvoVerTRgK1Z6UEB7pjDi5H+pJMj2KmTdI6d7z02yr+eoDWtIdDjZLiPk9H+R/kU
         UDivGi8SQeQZTmUyHdgvyS+v+Gj2qwvjalobp4OFOeA+AZSft4Dh41SuQp/HBeq76KtD
         JvjA==
X-Gm-Message-State: APzg51C9cabzerWf7lLb0KcpycDM2YyB3iyinBkpRA3Qwqd0UDy6/l02
        nk7I2OigdgpQtMH9w8tjQCM3MiLi
X-Google-Smtp-Source: ANB0VdYsIvy218gjr5peL+aaiBA881yiZnBE2tkOeXN+3trBQ5ayc0RQyN1Y5zSs70rGn3STosS/iA==
X-Received: by 2002:a19:7d84:: with SMTP id y126-v6mr5928755lfc.94.1535277802572;
        Sun, 26 Aug 2018 03:03:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/21] grep.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:02:58 +0200
Message-Id: <20180826100314.5137-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c |  4 ++--
 builtin/log.c  |  2 +-
 grep.c         | 13 ++++++++-----
 grep.h         |  7 +++++--
 revision.c     |  4 ++--
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 601f801158..0667ffde84 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -904,9 +904,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_grep_defaults();
+	init_grep_defaults(the_repository);
 	git_config(grep_cmd_config, NULL);
-	grep_init(&opt, prefix);
+	grep_init(&opt, the_repository, prefix);
 
 	/*
 	 * If there is no -- then the paths must exist in the working
diff --git a/builtin/log.c b/builtin/log.c
index f32a07f6a9..b62082472c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -115,7 +115,7 @@ static int log_line_range_callback(const struct option *option, const char *arg,
 
 static void init_log_defaults(void)
 {
-	init_grep_defaults();
+	init_grep_defaults(the_repository);
 	init_diff_ui_defaults();
 
 	decoration_style = auto_decoration_style();
diff --git a/grep.c b/grep.c
index e146ff20bb..51c8beda43 100644
--- a/grep.c
+++ b/grep.c
@@ -42,7 +42,7 @@ static void color_set(char *dst, const char *color_bytes)
  * We could let the compiler do this, but without C99 initializers
  * the code gets unwieldy and unreadable, so...
  */
-void init_grep_defaults(void)
+void init_grep_defaults(struct repository *repo)
 {
 	struct grep_opt *opt = &grep_defaults;
 	static int run_once;
@@ -52,6 +52,7 @@ void init_grep_defaults(void)
 	run_once++;
 
 	memset(opt, 0, sizeof(*opt));
+	opt->repo = repo;
 	opt->relative = 1;
 	opt->pathname = 1;
 	opt->max_depth = -1;
@@ -149,12 +150,13 @@ int grep_config(const char *var, const char *value, void *cb)
  * default values from the template we read the configuration
  * information in an earlier call to git_config(grep_config).
  */
-void grep_init(struct grep_opt *opt, const char *prefix)
+void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
 	struct grep_opt *def = &grep_defaults;
 	int i;
 
 	memset(opt, 0, sizeof(*opt));
+	opt->repo = repo;
 	opt->prefix = prefix;
 	opt->prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
 	opt->pattern_tail = &opt->pattern_list;
@@ -1708,7 +1710,8 @@ static int look_ahead(struct grep_opt *opt,
 	return 0;
 }
 
-static int fill_textconv_grep(struct userdiff_driver *driver,
+static int fill_textconv_grep(struct repository *repo,
+			      struct userdiff_driver *driver,
 			      struct grep_source *gs)
 {
 	struct diff_filespec *df;
@@ -1741,7 +1744,7 @@ static int fill_textconv_grep(struct userdiff_driver *driver,
 	 * structure.
 	 */
 	grep_read_lock();
-	size = fill_textconv(the_repository, driver, df, &buf);
+	size = fill_textconv(repo, driver, df, &buf);
 	grep_read_unlock();
 	free_filespec(df);
 
@@ -1837,7 +1840,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 
 	try_lookahead = should_lookahead(opt);
 
-	if (fill_textconv_grep(textconv, gs) < 0)
+	if (fill_textconv_grep(opt->repo, textconv, gs) < 0)
 		return 0;
 
 	bol = gs->buf;
diff --git a/grep.h b/grep.h
index 0ba62a11c5..3651183971 100644
--- a/grep.h
+++ b/grep.h
@@ -36,6 +36,8 @@ typedef int pcre2_jit_stack;
 #include "thread-utils.h"
 #include "userdiff.h"
 
+struct repository;
+
 enum grep_pat_token {
 	GREP_PATTERN,
 	GREP_PATTERN_HEAD,
@@ -136,6 +138,7 @@ struct grep_opt {
 	struct grep_pat *header_list;
 	struct grep_pat **header_tail;
 	struct grep_expr *pattern_expression;
+	struct repository *repo;
 	const char *prefix;
 	int prefix_length;
 	regex_t regexp;
@@ -183,9 +186,9 @@ struct grep_opt {
 	void *output_priv;
 };
 
-extern void init_grep_defaults(void);
+extern void init_grep_defaults(struct repository *);
 extern int grep_config(const char *var, const char *value, void *);
-extern void grep_init(struct grep_opt *, const char *prefix);
+extern void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 extern void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
diff --git a/revision.c b/revision.c
index de4dce600d..3457064ff3 100644
--- a/revision.c
+++ b/revision.c
@@ -1464,8 +1464,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->commit_format = CMIT_FMT_DEFAULT;
 	revs->expand_tabs_in_log_default = 8;
 
-	init_grep_defaults();
-	grep_init(&revs->grep_filter, prefix);
+	init_grep_defaults(the_repository);
+	grep_init(&revs->grep_filter, the_repository, prefix);
 	revs->grep_filter.status_only = 1;
 
 	diff_setup(&revs->diffopt);
-- 
2.19.0.rc0.337.ge906d732e7

