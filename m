Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418057492
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664158; cv=none; b=uEPzLkTuN2K3YwFi3cRnL48q1baK1xhBEUV9nY/K1yOxRL8vwh5Ts2R3OZ009RICLP0WVrULNACSC0XKMGm/dfefuEkXpRd8jpKt6hmjrktlqcBp6BLmzowUAl4a58GMgrM2Ya4bg/nszpXDDGXlNza3ZUP4eqmRXALw0XaP0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664158; c=relaxed/simple;
	bh=WKXUpNCZQpjfyLiAh3bcKFnCovOwMOM6pPDSExzaaNY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BMiQ3JYdTuhaZ8t5yh48xtmsetxFnG/qlTGOHJUORAoo5XXQh+2Z3fSs80r/buXfhscwJGxJBWPJfzhVmNXJ5+9TAhptNerRPoQwVRQBx12E/TWjjxBE2270MoiW7JeQSfyhqApkswubmktQQTusr352BtIY4vvqBdUoKBWh/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwtRK5gx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwtRK5gx"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ae3154cf8so2351455f8f.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 17:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706664154; x=1707268954; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQvmqV0OISwBdzCAoRM4EbupczYBhodAkHpQYhhvKyQ=;
        b=VwtRK5gx98Q96vlMb82h5q1u8UQhdblT7GarOj72wHZxY6+DLSOtP2HKBObRHugOZw
         0Xpyo1Qq3SijgNX735s52Uwsq0eRUE8vIyXee/IRYW5xC1jxvkLaiIdEhCDHx5TK7W7h
         Lt66q5MsJiS21lnoNUB4Uks6dCKjZZhDYubDqLf/+jqYjPvLMCJFcce3B63xdWV/niIU
         SmJ6ExWfkkhNeOmwZwoi0wCLCyK7U4CLPDX9Fnzr9hbpmZZLXX3FYZjkp5z9TjEcwarg
         Ka/+fawbOiIAKqbuo2Zt9v2Zl+BnU5XWeDGHdJZri/KGnkqnYmho6jWsuIb16TF5mOYQ
         mB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706664154; x=1707268954;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQvmqV0OISwBdzCAoRM4EbupczYBhodAkHpQYhhvKyQ=;
        b=ITBTJwprnfXc9dyByq+LGz3buieBMSqrKof0N0KCNH8SmY6zg7dgCeWxOeu7hBSa75
         8pjWqIMgsgE4rvKOt3LxZECoqGg5tO1k7p1H6XU4x79Zw043sR7UvyzHQvZx15Kq86fQ
         /g3/a96ON6Ttyn3nxPaSDYu8UtOud9zfjEfH7PPfxjyPDS/THp0LwH07gmDPKQO69tJo
         2owjJ/lm6/xCoU2LS4GzNzIvZS+NXCJUdA5ds8S3r3LX1pJPu3OwBM19E+Juy6cqZbTc
         wEdMVq9yhQdaHPczwpDKRurMtHiBPdeiISJueL2FAHmtP9H4nvYKiMHnmyPdczjzru3m
         LLdg==
X-Gm-Message-State: AOJu0YyPqWOeHkvQEbPBb4dFzN+zTFGJgC14kS0v2e4Ic0V3z5f2koOa
	jRSLa9YHlMNP0Rc8EOxPmoj9fWDBl5LtRIT2/D8vdD3Fofbb8n5qyA+jqLir
X-Google-Smtp-Source: AGHT+IEahtMrJGYNxP0CXorB6l7c5F7HsIes5E1OHH/2GOh7CDQvcWfZ3RnhPYmCK+GfvN/pjlH3DA==
X-Received: by 2002:a5d:6781:0:b0:33a:d0da:5e4 with SMTP id v1-20020a5d6781000000b0033ad0da05e4mr97568wru.6.1706664153991;
        Tue, 30 Jan 2024 17:22:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fa8-20020a056000258800b0033afb7c68a7sm2923341wrb.55.2024.01.30.17.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:22:33 -0800 (PST)
Message-ID: <465dc51cdcba28d235241021bc52369f6082d329.1706664145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 01:22:22 +0000
Subject: [PATCH v3 08/10] trailer: move arg handling to interpret-trailers.c
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
is now a struct that contains information about trailers that could be
added into the input text's own trailers. This is a generic concept that
extends beyond trailers defined as CLI arguments (it applies to trailers
defined in configuration as well). We will rename "arg_item" to
"trailer_template" in a follow-up patch to keep the diff here small.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 88 ++++++++++++++++++++++--------------
 trailer.c                    | 62 ++++++++++++++++++-------
 trailer.h                    | 12 +++++
 3 files changed, 112 insertions(+), 50 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 9f0ba39b317..9a902012912 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -45,23 +45,17 @@ static int option_parse_if_missing(const struct option *opt,
 	return trailer_set_if_missing(opt->value, arg);
 }
 
-static void free_new_trailers(struct list_head *trailers)
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
 		free_new_trailers(trailers);
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
+		trailer_add_arg_item(strbuf_detach(&tok, NULL),
+				     strbuf_detach(&val, NULL),
+				     conf_current,
+				     trailers);
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
+	cl_separators = xstrfmt("=%s", trailer_default_separators());
 
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
 
-	free_new_trailers(&trailers);
+	free_new_trailers(&arg_trailers);
 
 	return 0;
 }
diff --git a/trailer.c b/trailer.c
index c16f552b463..19637ff295d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -66,6 +66,11 @@ static LIST_HEAD(conf_head);
 
 static char *separators = ":";
 
+const char *trailer_default_separators(void)
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
+ * override them if we find a matching trailer configuration.
+ *
  * separator_pos must not be 0, since the token cannot be an empty string.
  *
  * If separator_pos is -1, interpret the whole trailer as a token.
@@ -691,22 +718,13 @@ static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
 	return new_item;
 }
 
-static void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
-				 const struct trailer_conf *conf,
-				 const struct new_trailer_item *new_trailer_item)
+void trailer_add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
+			  struct list_head *arg_head)
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
 
@@ -719,10 +737,10 @@ void parse_trailers_from_config(struct list_head *config_head)
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
 		if (item->conf.command)
-			trailer_add_arg_item(config_head,
-					     xstrdup(token_from_item(item, NULL)),
+			trailer_add_arg_item(xstrdup(token_from_item(item, NULL)),
 					     xstrdup(""),
-					     &item->conf, NULL);
+					     &item->conf,
+					     config_head);
 	}
 }
 
@@ -755,10 +773,10 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 			strbuf_release(&sb);
 		} else {
 			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
-			trailer_add_arg_item(arg_head,
-					     strbuf_detach(&tok, NULL),
+			trailer_add_arg_item(strbuf_detach(&tok, NULL),
 					     strbuf_detach(&val, NULL),
-					     conf, tr);
+					     conf,
+					     arg_head);
 		}
 	}
 
@@ -1148,6 +1166,16 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
+void free_new_trailers(struct list_head *trailers)
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
index d724263e4f6..8fcf1969a3c 100644
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
 
+const char *trailer_default_separators(void);
+
+void trailer_add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
+			  struct list_head *arg_head);
+
 struct process_trailer_options {
 	int in_place;
 	int trim_empty;
@@ -95,6 +106,7 @@ void format_trailers(const struct process_trailer_options *opts,
 		     struct list_head *trailers,
 		     struct strbuf *out);
 void free_trailers(struct list_head *);
+void free_new_trailers(struct list_head *);
 
 /*
  * Convenience function to format the trailers from the commit msg "msg" into
-- 
gitgitgadget

