Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620281F42F
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeHZNpo (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:44 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:45783 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHZNpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:42 -0400
Received: by mail-lf1-f43.google.com with SMTP id r4-v6so9707745lff.12
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xWuyU0uzuI/KgpebiqbkJ+rnBZmMCAANR8V7MdZuPmI=;
        b=qUM/yyWF9dNtDPT6KVNOkI7mzvzGepOYUGDNsRthSPjucQjEIgFeo9mUxeqos/U1YF
         fXwYNxTSy67kQ3akMm5Z5/wWTguw+JNswtRhxPqD7kyaWhDKBTTtsxL5viKNKVg+hqkf
         ITRNVc1IprP7RnVh5eaVXSNUIU11zZbM6sWnzKe8i/olDMPkuwCm/xlYcglSPQ2x2W8V
         jMvgA7dzfLxb7LlLqOgLjf1ICwlvGKocO/hxJJl0XY1CBbUgmmvEVKy18h2ou6X4CBae
         JVK5PAfdpYnqFQ4XCIGX0aK0ejeSNKrz+D4RUVwU5+SAz/29VZj1Z3PyGxlsqYab3nP3
         Mrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xWuyU0uzuI/KgpebiqbkJ+rnBZmMCAANR8V7MdZuPmI=;
        b=Ubml9EffGtS2DpcN/8Lariz584o9YRPqegGxhXNenedJAq19d4gYMibxYmwo0ayq8H
         2vAsaTS0aiS5Y4J2CRnev0pwdeN6oMKbYVLzWBj0X/XgZq88e0kuJhyX2LIpB8vL9Nn+
         soM4M/ZwZQIJOsdrk9mxX2jOhFVZpWqfjFzS93frjwpkY5byTTZZ8Jhn4HEPSV2lzagz
         8e1PYv2vaSuK37gUAgvTvRlOeGfmj/I7xaznxGsO5/A0ne2/dVJPKzFZhuxqqUIt4v0z
         mp4sBD2n3azYM5yyfA95PP4ey49o1aqz7RsLy1CfAezyGZ0zyayZ0Mbv8+5j3oyXSS+G
         cjZg==
X-Gm-Message-State: APzg51CFmIuKJc8Efio+gu2weO17iQWKZy95XUl6257A8698ZkBoNQD+
        Z69SnO+ypNdBNEwvOBy3F6cYyKmk
X-Google-Smtp-Source: ANB0VdbOHSBytH9wgwn0/DPdl1/RbBYM/Lo/2KaPEt3VBJ72JykC6bWXmme5xEXcL+OGzaTqXtDfaw==
X-Received: by 2002:a19:d484:: with SMTP id l126-v6mr5410532lfg.28.1535277812982;
        Sun, 26 Aug 2018 03:03:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/21] userdiff.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:08 +0200
Message-Id: <20180826100314.5137-16-pclouds@gmail.com>
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
 archive-zip.c      | 14 +++++++++-----
 builtin/grep.c     |  3 ++-
 combine-diff.c     |  2 +-
 diff.c             | 40 +++++++++++++++++++++++-----------------
 diff.h             |  3 ++-
 diffcore-pickaxe.c |  4 ++--
 grep.c             | 21 ++++++++++++---------
 grep.h             |  3 ++-
 line-range.c       |  2 +-
 userdiff.c         |  5 +++--
 userdiff.h         |  3 ++-
 11 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 5a62351ab1..155ee4a779 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -264,9 +264,10 @@ static int has_only_ascii(const char *s)
 	}
 }
 
-static int entry_is_binary(const char *path, const void *buffer, size_t size)
+static int entry_is_binary(struct index_state *istate, const char *path,
+			   const void *buffer, size_t size)
 {
-	struct userdiff_driver *driver = userdiff_find_by_path(path);
+	struct userdiff_driver *driver = userdiff_find_by_path(istate, path);
 	if (!driver)
 		driver = userdiff_find_by_name("default");
 	if (driver->binary != -1)
@@ -352,7 +353,8 @@ static int write_zip_entry(struct archiver_args *args,
 				return error(_("cannot read %s"),
 					     oid_to_hex(oid));
 			crc = crc32(crc, buffer, size);
-			is_binary = entry_is_binary(path_without_prefix,
+			is_binary = entry_is_binary(args->repo->index,
+						    path_without_prefix,
 						    buffer, size);
 			out = buffer;
 		}
@@ -428,7 +430,8 @@ static int write_zip_entry(struct archiver_args *args,
 				break;
 			crc = crc32(crc, buf, readlen);
 			if (is_binary == -1)
-				is_binary = entry_is_binary(path_without_prefix,
+				is_binary = entry_is_binary(args->repo->index,
+							    path_without_prefix,
 							    buf, readlen);
 			write_or_die(1, buf, readlen);
 		}
@@ -460,7 +463,8 @@ static int write_zip_entry(struct archiver_args *args,
 				break;
 			crc = crc32(crc, buf, readlen);
 			if (is_binary == -1)
-				is_binary = entry_is_binary(path_without_prefix,
+				is_binary = entry_is_binary(args->repo->index,
+							    path_without_prefix,
 							    buf, readlen);
 
 			zstream.next_in = buf;
diff --git a/builtin/grep.c b/builtin/grep.c
index 0667ffde84..0c3527242e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -103,7 +103,8 @@ static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 
 	todo[todo_end].source = *gs;
 	if (opt->binary != GREP_BINARY_TEXT)
-		grep_source_load_driver(&todo[todo_end].source);
+		grep_source_load_driver(&todo[todo_end].source,
+					opt->repo->index);
 	todo[todo_end].done = 0;
 	strbuf_reset(&todo[todo_end].out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
diff --git a/combine-diff.c b/combine-diff.c
index ec20fff63b..67adba1933 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -987,7 +987,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	const char *line_prefix = diff_line_prefix(opt);
 
 	context = opt->context;
-	userdiff = userdiff_find_by_path(elem->path);
+	userdiff = userdiff_find_by_path(opt->repo->index, elem->path);
 	if (!userdiff)
 		userdiff = userdiff_find_by_name("default");
 	if (opt->flags.allow_textconv)
diff --git a/diff.c b/diff.c
index ec3029df82..5a5f91480b 100644
--- a/diff.c
+++ b/diff.c
@@ -2093,23 +2093,25 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 	}
 }
 
-static void diff_filespec_load_driver(struct diff_filespec *one)
+static void diff_filespec_load_driver(struct diff_filespec *one,
+				      struct index_state *istate)
 {
 	/* Use already-loaded driver */
 	if (one->driver)
 		return;
 
 	if (S_ISREG(one->mode))
-		one->driver = userdiff_find_by_path(one->path);
+		one->driver = userdiff_find_by_path(istate, one->path);
 
 	/* Fallback to default settings */
 	if (!one->driver)
 		one->driver = userdiff_find_by_name("default");
 }
 
-static const char *userdiff_word_regex(struct diff_filespec *one)
+static const char *userdiff_word_regex(struct diff_filespec *one,
+				       struct index_state *istate)
 {
-	diff_filespec_load_driver(one);
+	diff_filespec_load_driver(one, istate);
 	return one->driver->word_regex;
 }
 
@@ -2132,9 +2134,9 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 			xcalloc(1, sizeof(struct emitted_diff_symbols));
 
 	if (!o->word_regex)
-		o->word_regex = userdiff_word_regex(one);
+		o->word_regex = userdiff_word_regex(one, o->repo->index);
 	if (!o->word_regex)
-		o->word_regex = userdiff_word_regex(two);
+		o->word_regex = userdiff_word_regex(two, o->repo->index);
 	if (!o->word_regex)
 		o->word_regex = diff_word_regex_cfg;
 	if (o->word_regex) {
@@ -3257,7 +3259,7 @@ int diff_filespec_is_binary(struct repository *repo,
 			    struct diff_filespec *one)
 {
 	if (one->is_binary == -1) {
-		diff_filespec_load_driver(one);
+		diff_filespec_load_driver(one, repo->index);
 		if (one->driver->binary != -1)
 			one->is_binary = one->driver->binary;
 		else {
@@ -3273,9 +3275,10 @@ int diff_filespec_is_binary(struct repository *repo,
 	return one->is_binary;
 }
 
-static const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespec *one)
+static const struct userdiff_funcname *
+diff_funcname_pattern(struct diff_options *o, struct diff_filespec *one)
 {
-	diff_filespec_load_driver(one);
+	diff_filespec_load_driver(one, o->repo->index);
 	return one->driver->funcname.pattern ? &one->driver->funcname : NULL;
 }
 
@@ -3287,12 +3290,13 @@ void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const
 		options->b_prefix = b;
 }
 
-struct userdiff_driver *get_textconv(struct diff_filespec *one)
+struct userdiff_driver *get_textconv(struct index_state *istate,
+				     struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return NULL;
 
-	diff_filespec_load_driver(one);
+	diff_filespec_load_driver(one, istate);
 	return userdiff_get_textconv(one->driver);
 }
 
@@ -3342,8 +3346,8 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->flags.allow_textconv) {
-		textconv_one = get_textconv(one);
-		textconv_two = get_textconv(two);
+		textconv_one = get_textconv(o->repo->index, one);
+		textconv_two = get_textconv(o->repo->index, two);
 	}
 
 	/* Never use a non-valid filename anywhere if at all possible */
@@ -3465,9 +3469,9 @@ static void builtin_diff(const char *name_a,
 		mf1.size = fill_textconv(o->repo, textconv_one, one, &mf1.ptr);
 		mf2.size = fill_textconv(o->repo, textconv_two, two, &mf2.ptr);
 
-		pe = diff_funcname_pattern(one);
+		pe = diff_funcname_pattern(o, one);
 		if (!pe)
-			pe = diff_funcname_pattern(two);
+			pe = diff_funcname_pattern(o, two);
 
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
@@ -4223,7 +4227,9 @@ static void run_diff_cmd(const char *pgm,
 
 
 	if (o->flags.allow_external) {
-		struct userdiff_driver *drv = userdiff_find_by_path(attr_path);
+		struct userdiff_driver *drv;
+
+		drv = userdiff_find_by_path(o->repo->index, attr_path);
 		if (drv && drv->external)
 			pgm = drv->external;
 	}
@@ -6399,7 +6405,7 @@ int textconv_object(struct repository *repo,
 
 	df = alloc_filespec(path);
 	fill_filespec(df, oid, oid_valid, mode);
-	textconv = get_textconv(df);
+	textconv = get_textconv(repo->index, df);
 	if (!textconv) {
 		free_filespec(df);
 		return 0;
diff --git a/diff.h b/diff.h
index 1d364c3867..c03def456f 100644
--- a/diff.h
+++ b/diff.h
@@ -452,7 +452,8 @@ size_t fill_textconv(struct repository *repo,
  * and only if it has textconv enabled (otherwise return NULL). The result
  * can be passed to fill_textconv().
  */
-struct userdiff_driver *get_textconv(struct diff_filespec *one);
+struct userdiff_driver *get_textconv(struct index_state *istate,
+				     struct diff_filespec *one);
 
 /*
  * Prepare diff_filespec and convert it using diff textconv API
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 7a5cf446ff..d2361e06a1 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -139,8 +139,8 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 		return 0;
 
 	if (o->flags.allow_textconv) {
-		textconv_one = get_textconv(p->one);
-		textconv_two = get_textconv(p->two);
+		textconv_one = get_textconv(o->repo->index, p->one);
+		textconv_two = get_textconv(o->repo->index, p->two);
 	}
 
 	/*
diff --git a/grep.c b/grep.c
index 51c8beda43..f20eca9e76 100644
--- a/grep.c
+++ b/grep.c
@@ -11,7 +11,8 @@
 #include "help.h"
 
 static int grep_source_load(struct grep_source *gs);
-static int grep_source_is_binary(struct grep_source *gs);
+static int grep_source_is_binary(struct grep_source *gs,
+				 struct index_state *istate);
 
 static struct grep_opt grep_defaults;
 
@@ -1547,7 +1548,7 @@ static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bo
 {
 	xdemitconf_t *xecfg = opt->priv;
 	if (xecfg && !xecfg->find_func) {
-		grep_source_load_driver(gs);
+		grep_source_load_driver(gs, opt->repo->index);
 		if (gs->driver->funcname.pattern) {
 			const struct userdiff_funcname *pe = &gs->driver->funcname;
 			xdiff_set_find_func(xecfg, pe->pattern, pe->cflags);
@@ -1804,7 +1805,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	opt->last_shown = 0;
 
 	if (opt->allow_textconv) {
-		grep_source_load_driver(gs);
+		grep_source_load_driver(gs, opt->repo->index);
 		/*
 		 * We might set up the shared textconv cache data here, which
 		 * is not thread-safe.
@@ -1821,11 +1822,11 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	if (!textconv) {
 		switch (opt->binary) {
 		case GREP_BINARY_DEFAULT:
-			if (grep_source_is_binary(gs))
+			if (grep_source_is_binary(gs, opt->repo->index))
 				binary_match_only = 1;
 			break;
 		case GREP_BINARY_NOMATCH:
-			if (grep_source_is_binary(gs))
+			if (grep_source_is_binary(gs, opt->repo->index))
 				return 0; /* Assume unmatch */
 			break;
 		case GREP_BINARY_TEXT:
@@ -2171,22 +2172,24 @@ static int grep_source_load(struct grep_source *gs)
 	BUG("invalid grep_source type to load");
 }
 
-void grep_source_load_driver(struct grep_source *gs)
+void grep_source_load_driver(struct grep_source *gs,
+			     struct index_state *istate)
 {
 	if (gs->driver)
 		return;
 
 	grep_attr_lock();
 	if (gs->path)
-		gs->driver = userdiff_find_by_path(gs->path);
+		gs->driver = userdiff_find_by_path(istate, gs->path);
 	if (!gs->driver)
 		gs->driver = userdiff_find_by_name("default");
 	grep_attr_unlock();
 }
 
-static int grep_source_is_binary(struct grep_source *gs)
+static int grep_source_is_binary(struct grep_source *gs,
+				 struct index_state *istate)
 {
-	grep_source_load_driver(gs);
+	grep_source_load_driver(gs, istate);
 	if (gs->driver->binary != -1)
 		return gs->driver->binary;
 
diff --git a/grep.h b/grep.h
index 3651183971..1a57d12b90 100644
--- a/grep.h
+++ b/grep.h
@@ -220,7 +220,8 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 		      const void *identifier);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
-void grep_source_load_driver(struct grep_source *gs);
+void grep_source_load_driver(struct grep_source *gs,
+			     struct index_state *istate);
 
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs);
diff --git a/line-range.c b/line-range.c
index 232c3909ec..7fa0d8bba5 100644
--- a/line-range.c
+++ b/line-range.c
@@ -198,7 +198,7 @@ static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_
 	anchor--; /* input is in human terms */
 	start = nth_line_cb(cb_data, anchor);
 
-	drv = userdiff_find_by_path(path);
+	drv = userdiff_find_by_path(&the_index, path);
 	if (drv && drv->funcname.pattern) {
 		const struct userdiff_funcname *pe = &drv->funcname;
 		xecfg = xcalloc(1, sizeof(*xecfg));
diff --git a/userdiff.c b/userdiff.c
index f3f4be579c..c913232396 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -270,7 +270,8 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 	return userdiff_find_by_namelen(name, len);
 }
 
-struct userdiff_driver *userdiff_find_by_path(const char *path)
+struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
+					      const char *path)
 {
 	static struct attr_check *check;
 
@@ -278,7 +279,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 		check = attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	if (git_check_attr(&the_index, path, check))
+	if (git_check_attr(istate, path, check))
 		return NULL;
 
 	if (ATTR_TRUE(check->items[0].value))
diff --git a/userdiff.h b/userdiff.h
index 2ef0ce5452..dad3fc03c1 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -21,7 +21,8 @@ struct userdiff_driver {
 
 int userdiff_config(const char *k, const char *v);
 struct userdiff_driver *userdiff_find_by_name(const char *name);
-struct userdiff_driver *userdiff_find_by_path(const char *path);
+struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
+					      const char *path);
 
 /*
  * Initialize any textconv-related fields in the driver and return it, or NULL
-- 
2.19.0.rc0.337.ge906d732e7

