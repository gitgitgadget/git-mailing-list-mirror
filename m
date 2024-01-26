Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF7C5BAC5
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308751; cv=none; b=lnJXFxHOi8r19CjCz3UMuu3dgUIpuN4JtUPQlEAbOg1pnNJUwiXr8GyUO4K1j6AbmDCvC19CJDSM7C/EGJtdADNJWiHlm/VDY20WYW9Op+kLeqpEYm7xbIBySIDvCfvaxLPY4J+7DZ179RbocMb6hXkIGgnYiXw0o1aBo75nPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308751; c=relaxed/simple;
	bh=oN2oky9mumCxLBV1B7pWYY0gU5lRdDWuLMfKZo9din4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BTxw0jx7qgg6vl5CT3QtyHiPzbv2Hu9rkHSjMGHTJb6O/7Q35er2TZzad6Gqa+BFN4z7a6MGVBtDrmqHXE8j2UWzsxr1j6w9gxrY2Py05hjYlF4mGj/h42d0GDI3hgnxdsFPJlGuOqEtamCUCDCM6Nc+SV4xi4YDu9sgJrlji/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdmNii1R; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdmNii1R"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so14512735e9.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308748; x=1706913548; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybg+brw47oXuSv6Jhnj/AdUtbgd9VH1MR8nNSBdOk90=;
        b=mdmNii1RPNeRl10SG8WM5UGuliXob1Pu33S6VtoI5SqixSIiJfnIHEX15gl1V28g1g
         uQVtpG7RlJ9YUgneRbbs+kqjvJIvEDooqz27oO6i/TVKYU+ucgI6yZCoyuUOQLotAdZ6
         VWSXpTLbAnJUfFBa8BFoHJZTLDZ1WYBNc/7q+gJVnUsuHv85XhqnmYU+4MYaCs09tQrF
         mHA0fvkuLe47pvVMLLMIoMxm73mn4e4fy1K43Q6gzZVAzEUyYX6yJRGADVFHcQHayUd/
         OOzcrjBcVYLbNN2g5HcArw7g0kUVa8w165bTTU+8Cg7lhlliOiFVGeeXMEwxi4/HyfUv
         hlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308748; x=1706913548;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybg+brw47oXuSv6Jhnj/AdUtbgd9VH1MR8nNSBdOk90=;
        b=nxB7C/N4WBf/BcDdJKYx9MWhCTamnF5oRAFYNafhutI8rj8PjimlMWAhS9Q5jiakKg
         p+dmChdJrfp29df+PdHWVGkSiWoMBHWitoxKUe10mWtMO4rq1gprQ12VBbiJN51WVSXY
         dQ/3uxUJiqOVa6/NnmOFA8DfiwIeCTdkEG4yjO8VHAFbq7XQp/3vCDgOrkyIYNtu4JVY
         u3kx90R4926tYJRVSe/49iTgos3+njPB5yf7SW2VWvkVEMSRsPB41Pen3pwvC9DOR9Bw
         HRWeAOQT7zYmvnEa+tuqaksMvKEckkyyFfSH1kH6x0SBGKhfBW/6iGRw5G1R/p1vW9dK
         RGIg==
X-Gm-Message-State: AOJu0YzxIipgtaj1VjsdQmPH/z8HWnX550cnCtF27FAch3QdT2S60ag6
	97YNtYSp+A6vQkZNRpQqg1x3Uya9p/kn2BI/WDISkrqb9gnkJ5LszC6QC4Mu
X-Google-Smtp-Source: AGHT+IHAs+Qo+thLnRGzcz3i3UyBLZOZrBxcS1XyJGAk55T/ZRBXrKq0glNuhK0fKAX7cPPPrsFhaQ==
X-Received: by 2002:a05:600c:1c91:b0:40e:e743:87 with SMTP id k17-20020a05600c1c9100b0040ee7430087mr372542wms.49.1706308747570;
        Fri, 26 Jan 2024 14:39:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b0040e621feca9sm3007045wmq.17.2024.01.26.14.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:39:06 -0800 (PST)
Message-ID: <1b4bdde65bcb375ce9ef2345814330df92e6d932.1706308737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:56 +0000
Subject: [PATCH v2 09/10] trailer: move arg handling to interpret-trailers.c
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

We don't move the "arg_item" struct to interpret-trailers.c, because it
is now a struct that contains information about trailers that should be
injected into the input text's own trailers. We will rename this
language as such in a follow-up patch to keep the diff here small.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 88 ++++++++++++++++++++++--------------
 trailer.c                    | 63 +++++++++++++++++++-------
 trailer.h                    | 13 +++++-
 3 files changed, 113 insertions(+), 51 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 9e41fa20b5f..ad9b9a9f9ef 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -45,23 +45,17 @@ static int option_parse_if_missing(const struct option *opt,
 	return trailer_set_if_missing(opt->value, arg);
 }
 
-static void new_trailers_clear(struct list_head *trailers)
-{
-	struct list_head *pos, *tmp;
-	struct new_trailer_item *item;
-
-	list_for_each_safe(pos, tmp, trailers) {
-		item = list_entry(pos, struct new_trailer_item, list);
-		list_del(pos);
-		free(item);
-	}
-}
+static char *cl_separators;
 
 static int option_parse_trailer(const struct option *opt,
 				   const char *arg, int unset)
 {
 	struct list_head *trailers = opt->value;
-	struct new_trailer_item *item;
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	const struct trailer_conf *conf;
+	struct trailer_conf *conf_current = new_trailer_conf();
+	ssize_t separator_pos;
 
 	if (unset) {
 		new_trailers_clear(trailers);
@@ -71,12 +65,31 @@ static int option_parse_trailer(const struct option *opt,
 	if (!arg)
 		return -1;
 
-	item = xmalloc(sizeof(*item));
-	item->text = arg;
-	item->where = where;
-	item->if_exists = if_exists;
-	item->if_missing = if_missing;
-	list_add_tail(&item->list, trailers);
+	separator_pos = find_separator(arg, cl_separators);
+	if (separator_pos) {
+		parse_trailer(arg, separator_pos, &tok, &val, &conf);
+		duplicate_trailer_conf(conf_current, conf);
+
+		/*
+		 * Override conf_current with settings specified via CLI flags.
+		 */
+		trailer_conf_set(where, if_exists, if_missing, conf_current);
+
+		add_arg_item(strbuf_detach(&tok, NULL),
+			     strbuf_detach(&val, NULL),
+			     conf_current,
+			     trailers);
+	} else {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, arg);
+		strbuf_trim(&sb);
+		error(_("empty trailer token in trailer '%.*s'"),
+			(int) sb.len, sb.buf);
+		strbuf_release(&sb);
+	}
+
+	free(conf_current);
+
 	return 0;
 }
 
@@ -135,7 +148,7 @@ static void read_input_file(struct strbuf *sb, const char *file)
 }
 
 static void interpret_trailers(const struct process_trailer_options *opts,
-			       struct list_head *new_trailer_head,
+			       struct list_head *arg_trailers,
 			       const char *file)
 {
 	LIST_HEAD(head);
@@ -144,8 +157,6 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	struct trailer_block *trailer_block;
 	FILE *outfile = stdout;
 
-	trailer_config_init();
-
 	read_input_file(&sb, file);
 
 	if (opts->in_place)
@@ -162,12 +173,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 
 
 	if (!opts->only_input) {
-		LIST_HEAD(config_head);
-		LIST_HEAD(arg_head);
-		parse_trailers_from_config(&config_head);
-		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
-		list_splice(&config_head, &arg_head);
-		process_trailers_lists(&head, &arg_head);
+		process_trailers_lists(&head, arg_trailers);
 	}
 
 	/* Print trailer block. */
@@ -193,7 +199,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-	LIST_HEAD(trailers);
+	LIST_HEAD(configured_trailers);
+	LIST_HEAD(arg_trailers);
 
 	struct option options[] = {
 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
@@ -212,33 +219,48 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
 		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat \"---\" as the end of input")),
-		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
+		OPT_CALLBACK(0, "trailer", &arg_trailers, N_("trailer"),
 				N_("trailer(s) to add"), option_parse_trailer),
 		OPT_END()
 	};
 
 	git_config(git_default_config, NULL);
+	trailer_config_init();
+
+	if (!opts.only_input) {
+		parse_trailers_from_config(&configured_trailers);
+	}
+
+	/*
+	* In command-line arguments, '=' is accepted (in addition to the
+	* separators that are defined).
+	*/
+	cl_separators = xstrfmt("=%s", default_separators());
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_interpret_trailers_usage, 0);
 
-	if (opts.only_input && !list_empty(&trailers))
+	free(cl_separators);
+
+	if (opts.only_input && !list_empty(&arg_trailers))
 		usage_msg_opt(
 			_("--trailer with --only-input does not make sense"),
 			git_interpret_trailers_usage,
 			options);
 
+	list_splice(&configured_trailers, &arg_trailers);
+
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			interpret_trailers(&opts, &trailers, argv[i]);
+			interpret_trailers(&opts, &arg_trailers, argv[i]);
 	} else {
 		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
-		interpret_trailers(&opts, &trailers, NULL);
+		interpret_trailers(&opts, &arg_trailers, NULL);
 	}
 
-	new_trailers_clear(&trailers);
+	new_trailers_clear(&arg_trailers);
 
 	return 0;
 }
diff --git a/trailer.c b/trailer.c
index d362b9a604e..1865d04bdf2 100644
--- a/trailer.c
+++ b/trailer.c
@@ -66,6 +66,11 @@ static LIST_HEAD(conf_head);
 
 static char *separators = ":";
 
+const char *default_separators(void)
+{
+	return separators;
+}
+
 static int configured;
 
 #define TRAILER_ARG_STRING "$ARG"
@@ -424,6 +429,25 @@ int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
 	return 0;
 }
 
+void trailer_conf_set(enum trailer_where where,
+		      enum trailer_if_exists if_exists,
+		      enum trailer_if_missing if_missing,
+		      struct trailer_conf *conf)
+{
+	if (where != WHERE_DEFAULT)
+		conf->where = where;
+	if (if_exists != EXISTS_DEFAULT)
+		conf->if_exists = if_exists;
+	if (if_missing != MISSING_DEFAULT)
+		conf->if_missing = if_missing;
+}
+
+struct trailer_conf *new_trailer_conf(void)
+{
+	struct trailer_conf *new = xcalloc(1, sizeof(*new));
+	return new;
+}
+
 void duplicate_trailer_conf(struct trailer_conf *dst,
 			    const struct trailer_conf *src)
 {
@@ -642,6 +666,9 @@ ssize_t find_separator(const char *line, const char *separators)
 /*
  * Obtain the token, value, and conf from the given trailer.
  *
+ * The conf needs special handling. We first read hardcoded defaults, and
+ * override them if we find a matching trailer configuration in the config.
+ *
  * separator_pos must not be 0, since the token cannot be an empty string.
  *
  * If separator_pos is -1, interpret the whole trailer as a token.
@@ -691,22 +718,14 @@ static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
 	return new_item;
 }
 
-static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
-			 const struct trailer_conf *conf,
-			 const struct new_trailer_item *new_trailer_item)
+void add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
+		  struct list_head *arg_head)
+
 {
 	struct arg_item *new_item = xcalloc(1, sizeof(*new_item));
 	new_item->token = tok;
 	new_item->value = val;
 	duplicate_trailer_conf(&new_item->conf, conf);
-	if (new_trailer_item) {
-		if (new_trailer_item->where != WHERE_DEFAULT)
-			new_item->conf.where = new_trailer_item->where;
-		if (new_trailer_item->if_exists != EXISTS_DEFAULT)
-			new_item->conf.if_exists = new_trailer_item->if_exists;
-		if (new_trailer_item->if_missing != MISSING_DEFAULT)
-			new_item->conf.if_missing = new_trailer_item->if_missing;
-	}
 	list_add_tail(&new_item->list, arg_head);
 }
 
@@ -719,10 +738,10 @@ void parse_trailers_from_config(struct list_head *config_head)
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
 		if (item->conf.command)
-			add_arg_item(config_head,
-				     xstrdup(token_from_item(item, NULL)),
+			add_arg_item(xstrdup(token_from_item(item, NULL)),
 				     xstrdup(""),
-				     &item->conf, NULL);
+				     &item->conf,
+				     config_head);
 	}
 }
 
@@ -755,10 +774,10 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 			strbuf_release(&sb);
 		} else {
 			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
-			add_arg_item(arg_head,
-				     strbuf_detach(&tok, NULL),
+			add_arg_item(strbuf_detach(&tok, NULL),
 				     strbuf_detach(&val, NULL),
-				     conf, tr);
+				     conf,
+				     arg_head);
 		}
 	}
 
@@ -1148,6 +1167,16 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
+void new_trailers_clear(struct list_head *trailers)
+{
+	struct list_head *pos, *p;
+
+	list_for_each_safe(pos, p, trailers) {
+		list_del(pos);
+		free_arg_item(list_entry(pos, struct arg_item, list));
+	}
+}
+
 size_t trailer_block_start(struct trailer_block *trailer_block)
 {
 	return trailer_block->start;
diff --git a/trailer.h b/trailer.h
index c6aa96dd6be..e01437160cf 100644
--- a/trailer.h
+++ b/trailer.h
@@ -46,9 +46,20 @@ struct new_trailer_item {
 	enum trailer_if_missing if_missing;
 };
 
+void trailer_conf_set(enum trailer_where where,
+		      enum trailer_if_exists if_exists,
+		      enum trailer_if_missing if_missing,
+		      struct trailer_conf *conf);
+
+struct trailer_conf *new_trailer_conf(void);
 void duplicate_trailer_conf(struct trailer_conf *dst,
 			    const struct trailer_conf *src);
 
+const char *default_separators(void);
+
+void add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
+		  struct list_head *arg_head);
+
 struct process_trailer_options {
 	int in_place;
 	int trim_empty;
@@ -95,7 +106,7 @@ void format_trailers(const struct process_trailer_options *opts,
 		     struct list_head *trailers,
 		     struct strbuf *out);
 void free_trailers(struct list_head *trailers);
-
+void new_trailers_clear(struct list_head *new_trailers);
 /*
  * Convenience function to format the trailers from the commit msg "msg" into
  * the strbuf "out". Reuses format_trailers internally.
-- 
gitgitgadget

