Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444201F453
	for <e@80x24.org>; Sat, 27 Oct 2018 17:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeJ1CMG (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 22:12:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46033 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbeJ1CMF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 22:12:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id c24-v6so3149454lfi.12
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Eo+N31S9V9c5X6pW5M1J4OPBILzxVMSgzud16OJELY=;
        b=GIZJkYwvqrD/EguiT5xthcee+PEm4uGGOfzJsleGtMSdUHkBdhaHEMyxrYkWfy0ZBR
         n/hIXqCGe47E7/YrsFHh+BwRPZKOTXUEYiOkBw3fxbLGxlnccvS+2elEPDaBSQBq92Qe
         Cj+XujT/n3PVHnwdmdGUY1RievSXLnh5q2wTW//B6w/Ku4VPa3Le9K0GCEOi7sXLl01B
         tfcbzFHIJ3y5XeovY3QSnLMmM81nWfRhst7aulu8YKb077tJSaduEbH+eNNAB/Uu306N
         qkLGrCfRFPTBq4WF8SgooXg9t7FAnnpCLhth8+tIZmGjwex32yQ09ZCLdQt+jwhyU37v
         eezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Eo+N31S9V9c5X6pW5M1J4OPBILzxVMSgzud16OJELY=;
        b=caHBelLYpBI/dCUhHu+iE51hFH+OusuEz6L7BM7nbkhC70ZaH8vRUHsKV14uWimp+l
         ibbxK31lmiWlEhq2f7dSLAOe+XYQNmf5uAZCem3vDWaX/9QB+iphT8cfCkrX5uqZaJ9I
         3BTk1DbajIY/tPgslebdBQ2UmX1brT2saFEgbr/up65hy0o2iBZEJjpBmMWNpJRuEgcp
         NIgzQXjmwyFRK4kOlJs4OCHyB3YjP523xM4lmEDl4RfvL9iwcCn093WKByqhMEWuf6UJ
         mhJ7NQOXmL6XqquLxllMN6931jNfkQj1H1/iPq6etD1eT6dP8kY3OCcpni71VzKX83T/
         u4xg==
X-Gm-Message-State: AGRZ1gL1gs+/sjfI8OJVI1O5r5v3//8AXrZWBfKcTne4cKFwraFGD7bk
        2pGavwK3W7093HMpoJZpS6Af5ksL
X-Google-Smtp-Source: AJdET5e4FxsP+HOS8ab1WpHW91PvAQpfWXv9mMdnG10SC0z/JLxkNsJpuKIMuKLDbRt9YyhrfeCoPQ==
X-Received: by 2002:a19:1a41:: with SMTP id a62-v6mr4750356lfa.40.1540661422613;
        Sat, 27 Oct 2018 10:30:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i185-v6sm2333517lfg.89.2018.10.27.10.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:30:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v2 05/10] grep: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 19:30:03 +0200
Message-Id: <20181027173008.18852-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027173008.18852-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 59 +++++++++++++++++++-------------------------------
 grep.c         |  6 -----
 grep.h         |  6 -----
 3 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d8508ddf79..6dd15dbaa2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -34,7 +34,6 @@ static int recurse_submodules;
 #define GREP_NUM_THREADS_DEFAULT 8
 static int num_threads;
 
-#ifndef NO_PTHREADS
 static pthread_t *threads;
 
 /* We use one producer thread and THREADS consumer
@@ -234,6 +233,9 @@ static int wait_all(void)
 	int hit = 0;
 	int i;
 
+	if (!HAVE_THREADS)
+		return 0;
+
 	grep_lock();
 	all_work_added = 1;
 
@@ -265,13 +267,6 @@ static int wait_all(void)
 
 	return hit;
 }
-#else /* !NO_PTHREADS */
-
-static int wait_all(void)
-{
-	return 0;
-}
-#endif
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
@@ -284,8 +279,7 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
-#ifdef NO_PTHREADS
-		else if (num_threads && num_threads != 1) {
+		else if (!HAVE_THREADS && num_threads && num_threads != 1) {
 			/*
 			 * TRANSLATORS: %s is the configuration
 			 * variable for tweaking threads, currently
@@ -294,7 +288,6 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 			warning(_("no threads support, ignoring %s"), var);
 			num_threads = 0;
 		}
-#endif
 	}
 
 	if (!strcmp(var, "submodule.recurse"))
@@ -330,17 +323,14 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 	strbuf_release(&pathbuf);
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
+	if (HAVE_THREADS && num_threads) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
 		 */
 		add_work(opt, &gs);
 		return 0;
-	} else
-#endif
-	{
+	} else {
 		int hit;
 
 		hit = grep_source(opt, &gs);
@@ -363,17 +353,14 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
 	strbuf_release(&buf);
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
+	if (HAVE_THREADS && num_threads) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
 		 */
 		add_work(opt, &gs);
 		return 0;
-	} else
-#endif
-	{
+	} else {
 		int hit;
 
 		hit = grep_source(opt, &gs);
@@ -1038,20 +1025,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
-#ifndef NO_PTHREADS
-	if (list.nr || cached || show_in_pager)
-		num_threads = 0;
-	else if (num_threads == 0)
-		num_threads = GREP_NUM_THREADS_DEFAULT;
-	else if (num_threads < 0)
-		die(_("invalid number of threads specified (%d)"), num_threads);
-	if (num_threads == 1)
+	if (HAVE_THREADS) {
+		if (list.nr || cached || show_in_pager)
+			num_threads = 0;
+		else if (num_threads == 0)
+			num_threads = GREP_NUM_THREADS_DEFAULT;
+		else if (num_threads < 0)
+			die(_("invalid number of threads specified (%d)"), num_threads);
+		if (num_threads == 1)
+			num_threads = 0;
+	} else {
+		if (num_threads)
+			warning(_("no threads support, ignoring --threads"));
 		num_threads = 0;
-#else
-	if (num_threads)
-		warning(_("no threads support, ignoring --threads"));
-	num_threads = 0;
-#endif
+	}
 
 	if (!num_threads)
 		/*
@@ -1062,15 +1049,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		 */
 		compile_grep_patterns(&opt);
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
+	if (HAVE_THREADS && num_threads) {
 		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
 		    && (opt.pre_context || opt.post_context ||
 			opt.file_break || opt.funcbody))
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
-#endif
 
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
diff --git a/grep.c b/grep.c
index f6bd89e40b..4db1510d16 100644
--- a/grep.c
+++ b/grep.c
@@ -1513,7 +1513,6 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	}
 }
 
-#ifndef NO_PTHREADS
 int grep_use_locks;
 
 /*
@@ -1539,11 +1538,6 @@ static inline void grep_attr_unlock(void)
  */
 pthread_mutex_t grep_read_mutex;
 
-#else
-#define grep_attr_lock()
-#define grep_attr_unlock()
-#endif
-
 static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bol, char *eol)
 {
 	xdemitconf_t *xecfg = opt->priv;
diff --git a/grep.h b/grep.h
index 1a57d12b90..fb04893721 100644
--- a/grep.h
+++ b/grep.h
@@ -229,7 +229,6 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs);
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
 
-#ifndef NO_PTHREADS
 /*
  * Mutex used around access to the attributes machinery if
  * opt->use_threads.  Must be initialized/destroyed by callers!
@@ -250,9 +249,4 @@ static inline void grep_read_unlock(void)
 		pthread_mutex_unlock(&grep_read_mutex);
 }
 
-#else
-#define grep_read_lock()
-#define grep_read_unlock()
-#endif
-
 #endif
-- 
2.19.1.647.g708186aaf9

