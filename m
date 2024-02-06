Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0517F7EB
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196382; cv=none; b=RW+KfsyoJ+EsdzDhgp+ChZbeaneN04sg0LBuGRqENKPqEocoX1x9dW5etgiX69KghH23FGG90oUYR8svqknGMWgr70veq7W3cQktVRINUlgLdrVqstWbVCrw1PQ33BGqbS+1pzY7zwRIedCW+O9UqXDtN0Trh0yZMgt3+sTqgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196382; c=relaxed/simple;
	bh=HqdNNuOgcRUWIv4Bu3L5mG+r+C1sEdxhxaniETYFe+A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RPVa3ovRWr/VDVMmchOHCURm3ePnh4VLhu7OPDdrOwUGFrmXATNLt0sYLEu9psYK/CsNZZd6MHctoDmP7Q4+ZzPNrzaA1sRYmuMSEANVG/ThmozF3fmDJMYWOS2gtNhL0iP2glzGnQTlgk21dIdsRrFzaZ015kuVJ2WxSfRLrhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaWObl4o; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaWObl4o"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b28aadb28so2018733f8f.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196376; x=1707801176; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elLYb457565nc6G7ZZ9IQ5rTIuXVp4ECY0kiErw5pvg=;
        b=DaWObl4oYAOPEGqwlbVTiE3hMvulZ83DmDwcjLeQP7j5tR9knz3nUjY0cHUiU1L2XO
         xvIVM5JN0GiKJ2MBN82qssaGf8PBJsVC3irNoPeB2XSgnSnOLus008zeFFC4rBTLYZW8
         E6hnojBBVUC/zPhGhDVw9bBsPSnO1TENGnNb/QXtWXZiP0EKAKP0BPrJgXyoDz1pd6wO
         RYI3RpJQDJHt0K3VaJvD2EuUOR56724ZZwbkxeeS42tV7sDZcnXVD2U8DygjEYYYShZy
         Hu8llCq5pP02R92awRAYnvuOZeXNMkceevQu+srBW+JzXNDl1IqfVOM5aMTIX4aw9LU3
         ayRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196376; x=1707801176;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elLYb457565nc6G7ZZ9IQ5rTIuXVp4ECY0kiErw5pvg=;
        b=rM5VSg8iTtCJKwQGupMwmdz2YO7UywtPoevNzGR9uK4hxBLdxirR2QtXbuAG0ZTfOY
         K8GgvYHrpGSJSQ/CTdr0nyebyQ8rXH3t7oQHf3/dophODMy9qnRL4zT4QD2w3uYStS9F
         OiLQGWljPmMSrKszD3AP9IAuTbVTbDzg7FvWP6QVuuxGAX0zKVdIltdgembFaVPFbwW5
         u+WVOjN3ydLMYG8yqU4Qr3GKumL/q/9qph/A+P3IPZe1wfqzxRwVyFtrUqVdjhAGBLNK
         AkEtPyy/FwU7JnnYxwmmsh9JZkIlcx7g9dxPOeUYsz6iEuHbA7ticWeGJBci9DeOiSpQ
         zoEQ==
X-Gm-Message-State: AOJu0Yx7AiIiOiPpVRSY5KRHCsp3UqUsiE84DcTf4lwPzMBFMn0rtnGP
	1ajiIc3MFiPvIZ5M7+nrPRn28+jsfBLvG6RIif2gk6beAh0HbY9hP62C51B6
X-Google-Smtp-Source: AGHT+IHVdZ6ZYCy5kW3kI2gMJP55m3YP2R/vcWxax4GtBsMwYUZ55CyUmaiW6eRdIus8Fbnkruac0w==
X-Received: by 2002:a5d:4b8e:0:b0:33b:1763:947d with SMTP id b14-20020a5d4b8e000000b0033b1763947dmr411858wrt.2.1707196376544;
        Mon, 05 Feb 2024 21:12:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXRAHY8C2d2cKErDjNQgxklv/jGsb4KSnGZV2m2B34yY6rteyMS/AfQdPz3bOy32jHE5IqLCVgbD9a9h1t2K2ZQKUGAT5bKWHB7/RXHSMKKAX0yiR6RgbR2wot+VG8QDxdMn/GLmNsDX1yQt4eq2aUb1b+9khOs4VKd59eX2frevl4y/2m5YnQsIGuOJBq08I9UwmT7DM4c4g==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020adffe84000000b0033929310ae4sm1051065wrr.73.2024.02.05.21.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:55 -0800 (PST)
Message-ID: <14927038d855020f9ae7594ad5cc646257613cc1.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:28 +0000
Subject: [PATCH v4 28/28] trailer: introduce "template" term for readability
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

The term "arg_item" is ambiguous because we use it to hold data for

  (1) trailers specified as command line arguments (in
      builtin/interpret-trailers.c), and

  (2) trailers specified in configuration,

and these are both used to ultimately insert new trailers (based
on the contents of arg_item, acting as a kind of template) into some
other set of existing trailers (such as those found in a trailer block
inside a log message) that have already been parsed.

Rename "arg_item" to "trailer_template". This necessitates further
renames to make the functions that act on these templates match the data
structures (parameters) they act on:

  - [*] add_arg_to_input_list()      to apply_template_to_trailers()
  - [*] apply_arg_if_exists()        to maybe_add_if_exists()
  - [*] apply_arg_if_missing()       to maybe_add_if_missing()
  -     apply_command()              to run_command_from_template()
  - [*] apply_item_command()         to populate_template_value()
  -     free_arg_item()              to free_template() (non-API function)
  -     free_new_trailers()          to free_trailer_templates() (API function)
  -     get_conf_item()              to get_or_add_template_by()
  -     option_parse_trailer()       to option_parse_trailer_template()
  -     parse_trailers_from_config() to parse_trailer_templates_from_config()
  - [*] process_trailers_lists()     to apply_trailer_templates()
  -     token_from_item()            to token_from_template()
  -     token_matches_item           to token_matches_template
  - [*] trailer_add_arg_item()       to add_trailer_template()
  -     trailer_from_arg()           to trailer_from()
  - [*] check_if_different()         (reorder parameters only)
  - [*] find_same_and_apply_arg()    (reorder parameters only)

Reorder parameters to prefer input parameters toward the beginning and
out parameters at the end; these functions have been marked with an
asterisk ([*]).

This removes the "arg" terminology (standing for "CLI arguments") from
the trailer implementation, which makes sense because trailers
themselves have nothing to do with CLI argument handling.

Also note that these renames expose the previously liberal use of
"trailer" to mean both trailers we read from the input text (trailer
block) and trailer templates that are defined as CLI args or
configurations. Some functions implied a single action when they could
do two different things, so introduce words like "maybe" and "or" to
make their behavior more explicit.

In summary this patch renames and reorders parameters for readability,
without any behavioral change. We don't rename
find_same_and_apply_arg(), because it will be refactored soon.

For parse_trailers_from_config() (renamed to
parse_trailer_templates_from_config()), add a NEEDSWORK discussion about
how the deprecated trailer.*.command configuration option is oddly more
featureful than trailer.*.cmd (if we were to remove support for
trailer.*.command, users would not be able to replicate the behavior
with trailer.*.cmd and would lose out on functionality).

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  50 +++---
 trailer.c                    | 290 +++++++++++++++++++----------------
 trailer.h                    |  12 +-
 3 files changed, 193 insertions(+), 159 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index d0c09d1d73b..d3d2544c5f1 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -45,10 +45,14 @@ static int option_parse_if_missing(const struct option *opt,
 	return trailer_set_if_missing(arg, opt->value);
 }
 
-static int option_parse_trailer(const struct option *opt,
-				   const char *arg, int unset)
+/*
+ * Interpret "--trailer ..." as trailer templates (trailers we want to add into
+ * the input text).
+ */
+static int option_parse_trailer_template(const struct option *opt,
+					 const char *arg, int unset)
 {
-	struct list_head *trailers = opt->value;
+	struct list_head *templates = opt->value;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	const struct trailer_conf *conf;
@@ -56,7 +60,7 @@ static int option_parse_trailer(const struct option *opt,
 	static char *cl_separators;
 
 	if (unset) {
-		free_new_trailers(trailers);
+		free_trailer_templates(templates);
 		return 0;
 	}
 
@@ -93,10 +97,10 @@ static int option_parse_trailer(const struct option *opt,
 		if (if_missing != MISSING_DEFAULT)
 			trailer_set_conf_if_missing(if_missing, conf_current);
 
-		trailer_add_arg_item(trailers,
-				     strbuf_detach(&tok, NULL),
+		add_trailer_template(strbuf_detach(&tok, NULL),
 				     strbuf_detach(&val, NULL),
-				     conf_current);
+				     conf_current,
+				     templates);
 		free_trailer_conf(conf_current);
 	}
 
@@ -158,10 +162,10 @@ static void read_input_file(struct strbuf *sb, const char *file)
 }
 
 static void interpret_trailers(const struct process_trailer_options *opts,
-			       struct list_head *new_trailer_head,
+			       struct list_head *templates,
 			       const char *file)
 {
-	LIST_HEAD(head);
+	LIST_HEAD(trailers_from_sb);
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf tb = STRBUF_INIT;
 	struct trailer_block *trailer_block;
@@ -172,7 +176,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	trailer_block = parse_trailers(opts, sb.buf, &head);
+	trailer_block = parse_trailers(opts, sb.buf, &trailers_from_sb);
 
 	/* Print the lines before the trailer block */
 	if (!opts->only_trailers)
@@ -182,11 +186,11 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 		fprintf(outfile, "\n");
 
 	if (!opts->only_input)
-		process_trailers_lists(&head, new_trailer_head);
+		apply_trailer_templates(templates, &trailers_from_sb);
 
 	/* Print trailer block. */
-	format_trailers(opts, &head, &tb);
-	free_trailers(&head);
+	format_trailers(opts, &trailers_from_sb, &tb);
+	free_trailers(&trailers_from_sb);
 	fwrite(tb.buf, 1, tb.len, outfile);
 	strbuf_release(&tb);
 
@@ -206,8 +210,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-	LIST_HEAD(configured_trailers);
-	LIST_HEAD(trailers);
+	LIST_HEAD(configured_templates);
+	LIST_HEAD(templates);
 
 	struct option options[] = {
 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
@@ -226,8 +230,8 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
 		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat \"---\" as the end of input")),
-		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
-				N_("trailer(s) to add"), option_parse_trailer),
+		OPT_CALLBACK(0, "trailer", &templates, N_("trailer"),
+				N_("trailer(s) to add"), option_parse_trailer_template),
 		OPT_END()
 	};
 
@@ -235,30 +239,30 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	trailer_config_init();
 
 	if (!opts.only_input)
-		parse_trailers_from_config(&configured_trailers);
+		parse_trailer_templates_from_config(&configured_templates);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_interpret_trailers_usage, 0);
 
-	if (opts.only_input && !list_empty(&trailers))
+	if (opts.only_input && !list_empty(&templates))
 		usage_msg_opt(
 			_("--trailer with --only-input does not make sense"),
 			git_interpret_trailers_usage,
 			options);
 
-	list_splice(&configured_trailers, &trailers);
+	list_splice(&configured_templates, &templates);
 
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			interpret_trailers(&opts, &trailers, argv[i]);
+			interpret_trailers(&opts, &templates, argv[i]);
 	} else {
 		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
-		interpret_trailers(&opts, &trailers, NULL);
+		interpret_trailers(&opts, &templates, NULL);
 	}
 
-	free_new_trailers(&trailers);
+	free_trailer_templates(&templates);
 
 	return 0;
 }
diff --git a/trailer.c b/trailer.c
index 7b0bdfcb27e..cdb235c27b5 100644
--- a/trailer.c
+++ b/trailer.c
@@ -55,14 +55,14 @@ struct trailer_item {
 	char *value;
 };
 
-struct arg_item {
+struct trailer_template {
 	struct list_head list;
 	char *token;
 	char *value;
 	struct trailer_conf conf;
 };
 
-static LIST_HEAD(conf_head);
+static LIST_HEAD(templates_from_conf);
 
 static char *separators = ":";
 
@@ -105,7 +105,7 @@ static size_t token_len_without_separator(const char *token, size_t len)
 	return len;
 }
 
-static int same_token(struct trailer_item *a, struct arg_item *b)
+static int same_token(struct trailer_item *a, struct trailer_template *b)
 {
 	size_t a_len, b_len, min_len;
 
@@ -119,12 +119,12 @@ static int same_token(struct trailer_item *a, struct arg_item *b)
 	return !strncasecmp(a->token, b->token, min_len);
 }
 
-static int same_value(struct trailer_item *a, struct arg_item *b)
+static int same_value(struct trailer_item *a, struct trailer_template *b)
 {
 	return !strcasecmp(a->value, b->value);
 }
 
-static int same_trailer(struct trailer_item *a, struct arg_item *b)
+static int same_trailer(struct trailer_item *a, struct trailer_template *b)
 {
 	return same_token(a, b) && same_value(a, b);
 }
@@ -151,15 +151,15 @@ static void free_trailer_item(struct trailer_item *item)
 	free(item);
 }
 
-static void free_arg_item(struct arg_item *item)
+static void free_template(struct trailer_template *template)
 {
-	free(item->conf.name);
-	free(item->conf.key);
-	free(item->conf.command);
-	free(item->conf.cmd);
-	free(item->token);
-	free(item->value);
-	free(item);
+	free(template->conf.name);
+	free(template->conf.key);
+	free(template->conf.command);
+	free(template->conf.cmd);
+	free(template->token);
+	free(template->value);
+	free(template);
 }
 
 static char last_non_space_char(const char *s)
@@ -171,36 +171,36 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
+static struct trailer_item *trailer_from(struct trailer_template *template)
 {
 	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
-	new_item->token = arg_tok->token;
-	new_item->value = arg_tok->value;
-	arg_tok->token = arg_tok->value = NULL;
-	free_arg_item(arg_tok);
+	new_item->token = template->token;
+	new_item->value = template->value;
+	template->token = template->value = NULL;
+	free_template(template);
 	return new_item;
 }
 
-static void add_arg_to_input_list(struct trailer_item *on_tok,
-				  struct arg_item *arg_tok)
+static void apply_template_to_trailers(struct trailer_template *template,
+				       struct trailer_item *on_tok)
 {
-	int aoe = after_or_end(arg_tok->conf.where);
-	struct trailer_item *to_add = trailer_from_arg(arg_tok);
+	int aoe = after_or_end(template->conf.where);
+	struct trailer_item *to_add = trailer_from(template);
 	if (aoe)
 		list_add(&to_add->list, &on_tok->list);
 	else
 		list_add_tail(&to_add->list, &on_tok->list);
 }
 
-static int check_if_different(struct trailer_item *in_tok,
-			      struct arg_item *arg_tok,
-			      int check_all,
-			      struct list_head *head)
+static int check_if_different(struct trailer_template *template,
+			      struct trailer_item *in_tok,
+			      struct list_head *head,
+			      int check_all)
 {
-	enum trailer_where where = arg_tok->conf.where;
+	enum trailer_where where = template->conf.where;
 	struct list_head *next_head;
 	do {
-		if (same_trailer(in_tok, arg_tok))
+		if (same_trailer(in_tok, template))
 			return 0;
 		/*
 		 * if we want to add a trailer after another one,
@@ -215,7 +215,8 @@ static int check_if_different(struct trailer_item *in_tok,
 	return 1;
 }
 
-static char *apply_command(struct trailer_conf *conf, const char *arg)
+static char *run_command_from_template(struct trailer_conf *conf,
+				       const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
@@ -250,133 +251,142 @@ static char *apply_command(struct trailer_conf *conf, const char *arg)
 	return result;
 }
 
-static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
+/*
+ * Prepare the template by running the command (if any) requested by the
+ * template in order to populate the template's value field.
+ */
+static void populate_template_value(struct trailer_template *template,
+				    struct trailer_item *in_tok)
 {
-	if (arg_tok->conf.command || arg_tok->conf.cmd) {
+	if (template->conf.command || template->conf.cmd) {
+		/*
+		 * Determine argument to pass into the command.
+		 */
 		const char *arg;
-		if (arg_tok->value && arg_tok->value[0]) {
-			arg = arg_tok->value;
+		if (template->value && template->value[0]) {
+			arg = template->value;
 		} else {
 			if (in_tok && in_tok->value)
 				arg = xstrdup(in_tok->value);
 			else
 				arg = xstrdup("");
 		}
-		arg_tok->value = apply_command(&arg_tok->conf, arg);
+		template->value = run_command_from_template(&template->conf,
+							    arg);
 		free((char *)arg);
 	}
 }
 
-static void apply_arg_if_exists(struct trailer_item *in_tok,
-				struct arg_item *arg_tok,
+static void maybe_add_if_exists(struct trailer_template *template,
+				struct trailer_item *in_tok,
 				struct trailer_item *on_tok,
-				struct list_head *head)
+				struct list_head *trailers)
 {
-	switch (arg_tok->conf.if_exists) {
+	switch (template->conf.if_exists) {
 	case EXISTS_DO_NOTHING:
-		free_arg_item(arg_tok);
+		free_template(template);
 		break;
 	case EXISTS_REPLACE:
-		apply_item_command(in_tok, arg_tok);
-		add_arg_to_input_list(on_tok, arg_tok);
+		populate_template_value(template, in_tok);
+		apply_template_to_trailers(template, on_tok);
 		list_del(&in_tok->list);
 		free_trailer_item(in_tok);
 		break;
 	case EXISTS_ADD:
-		apply_item_command(in_tok, arg_tok);
-		add_arg_to_input_list(on_tok, arg_tok);
+		populate_template_value(template, in_tok);
+		apply_template_to_trailers(template, on_tok);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT:
-		apply_item_command(in_tok, arg_tok);
-		if (check_if_different(in_tok, arg_tok, 1, head))
-			add_arg_to_input_list(on_tok, arg_tok);
+		populate_template_value(template, in_tok);
+		if (check_if_different(template, in_tok, trailers, 1))
+			apply_template_to_trailers(template, on_tok);
 		else
-			free_arg_item(arg_tok);
+			free_template(template);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
-		apply_item_command(in_tok, arg_tok);
-		if (check_if_different(on_tok, arg_tok, 0, head))
-			add_arg_to_input_list(on_tok, arg_tok);
+		populate_template_value(template, in_tok);
+		if (check_if_different(template, on_tok, trailers, 0))
+			apply_template_to_trailers(template, on_tok);
 		else
-			free_arg_item(arg_tok);
+			free_template(template);
 		break;
 	default:
 		BUG("trailer.c: unhandled value %d",
-		    arg_tok->conf.if_exists);
+		    template->conf.if_exists);
 	}
 }
 
-static void apply_arg_if_missing(struct list_head *head,
-				 struct arg_item *arg_tok)
+static void maybe_add_if_missing(struct trailer_template *template,
+				 struct list_head *trailers)
 {
 	enum trailer_where where;
 	struct trailer_item *to_add;
 
-	switch (arg_tok->conf.if_missing) {
+	switch (template->conf.if_missing) {
 	case MISSING_DO_NOTHING:
-		free_arg_item(arg_tok);
+		free_template(template);
 		break;
 	case MISSING_ADD:
-		where = arg_tok->conf.where;
-		apply_item_command(NULL, arg_tok);
-		to_add = trailer_from_arg(arg_tok);
+		where = template->conf.where;
+		populate_template_value(template, NULL);
+		to_add = trailer_from(template);
 		if (after_or_end(where))
-			list_add_tail(&to_add->list, head);
+			list_add_tail(&to_add->list, trailers);
 		else
-			list_add(&to_add->list, head);
+			list_add(&to_add->list, trailers);
 		break;
 	default:
 		BUG("trailer.c: unhandled value %d",
-		    arg_tok->conf.if_missing);
+		    template->conf.if_missing);
 	}
 }
 
-static int find_same_and_apply_arg(struct list_head *head,
-				   struct arg_item *arg_tok)
+static int find_same_and_apply_arg(struct trailer_template *template,
+				   struct list_head *trailers)
 {
 	struct list_head *pos;
 	struct trailer_item *in_tok;
 	struct trailer_item *on_tok;
 
-	enum trailer_where where = arg_tok->conf.where;
+	enum trailer_where where = template->conf.where;
 	int middle = (where == WHERE_AFTER) || (where == WHERE_BEFORE);
 	int backwards = after_or_end(where);
 	struct trailer_item *start_tok;
 
-	if (list_empty(head))
+	if (list_empty(trailers))
 		return 0;
 
-	start_tok = list_entry(backwards ? head->prev : head->next,
+	start_tok = list_entry(backwards ? trailers->prev : trailers->next,
 			       struct trailer_item,
 			       list);
 
-	list_for_each_dir(pos, head, backwards) {
+	list_for_each_dir(pos, trailers, backwards) {
 		in_tok = list_entry(pos, struct trailer_item, list);
-		if (!same_token(in_tok, arg_tok))
+		if (!same_token(in_tok, template))
 			continue;
 		on_tok = middle ? in_tok : start_tok;
-		apply_arg_if_exists(in_tok, arg_tok, on_tok, head);
+		maybe_add_if_exists(template, in_tok, on_tok, trailers);
 		return 1;
 	}
 	return 0;
 }
 
-void process_trailers_lists(struct list_head *head,
-			    struct list_head *arg_head)
+void apply_trailer_templates(struct list_head *templates,
+			     struct list_head *trailers)
 {
 	struct list_head *pos, *p;
-	struct arg_item *arg_tok;
+	struct trailer_template *template;
 
-	list_for_each_safe(pos, p, arg_head) {
+	list_for_each_safe(pos, p, templates) {
 		int applied = 0;
-		arg_tok = list_entry(pos, struct arg_item, list);
+		template = list_entry(pos, struct trailer_template, list);
 
 		list_del(pos);
 
-		applied = find_same_and_apply_arg(head, arg_tok);
+		applied = find_same_and_apply_arg(template, trailers);
 
 		if (!applied)
-			apply_arg_if_missing(head, arg_tok);
+			maybe_add_if_missing(template, trailers);
 	}
 }
 
@@ -471,26 +481,26 @@ void free_trailer_conf(struct trailer_conf *conf)
 	free(conf);
 }
 
-static struct arg_item *get_conf_item(const char *name)
+static struct trailer_template *get_or_add_template_by(const char *name)
 {
 	struct list_head *pos;
-	struct arg_item *item;
+	struct trailer_template *template;
 
-	/* Look up item with same name */
-	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct arg_item, list);
-		if (!strcasecmp(item->conf.name, name))
-			return item;
+	/* Look up template with same name. */
+	list_for_each(pos, &templates_from_conf) {
+		template = list_entry(pos, struct trailer_template, list);
+		if (!strcasecmp(template->conf.name, name))
+			return template;
 	}
 
-	/* Item does not already exists, create it */
-	CALLOC_ARRAY(item, 1);
-	duplicate_trailer_conf(&item->conf, &default_trailer_conf);
-	item->conf.name = xstrdup(name);
+	/* Template does not already exist; create it. */
+	CALLOC_ARRAY(template, 1);
+	duplicate_trailer_conf(&template->conf, &default_trailer_conf);
+	template->conf.name = xstrdup(name);
 
-	list_add_tail(&item->list, &conf_head);
+	list_add_tail(&template->list, &templates_from_conf);
 
-	return item;
+	return template;
 }
 
 enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_CMD,
@@ -548,7 +558,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 			      void *cb UNUSED)
 {
 	const char *trailer_item, *variable_name;
-	struct arg_item *item;
+	struct trailer_template *template;
 	struct trailer_conf *conf;
 	char *name = NULL;
 	enum trailer_info_type type;
@@ -573,8 +583,8 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	if (!name)
 		return 0;
 
-	item = get_conf_item(name);
-	conf = &item->conf;
+	template = get_or_add_template_by(name);
+	conf = &template->conf;
 	free(name);
 
 	switch (type) {
@@ -631,20 +641,22 @@ void trailer_config_init(void)
 	configured = 1;
 }
 
-static const char *token_from_item(struct arg_item *item, char *tok)
+static const char *token_from_template(struct trailer_template *template, char *tok)
 {
-	if (item->conf.key)
-		return item->conf.key;
+	if (template->conf.key)
+		return template->conf.key;
 	if (tok)
 		return tok;
-	return item->conf.name;
+	return template->conf.name;
 }
 
-static int token_matches_item(const char *tok, struct arg_item *item, size_t tok_len)
+static int token_matches_template(const char *tok,
+				  struct trailer_template *template,
+				  size_t tok_len)
 {
-	if (!strncasecmp(tok, item->conf.name, tok_len))
+	if (!strncasecmp(tok, template->conf.name, tok_len))
 		return 1;
-	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
+	return template->conf.key ? !strncasecmp(tok, template->conf.key, tok_len) : 0;
 }
 
 /*
@@ -687,7 +699,7 @@ void parse_trailer(const char *line, ssize_t separator_pos,
 		   struct strbuf *tok, struct strbuf *val,
 		   const struct trailer_conf **conf)
 {
-	struct arg_item *item;
+	struct trailer_template *template;
 	size_t tok_len;
 	struct list_head *pos;
 
@@ -705,13 +717,13 @@ void parse_trailer(const char *line, ssize_t separator_pos,
 	tok_len = token_len_without_separator(tok->buf, tok->len);
 	if (conf)
 		*conf = &default_trailer_conf;
-	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct arg_item, list);
-		if (token_matches_item(tok->buf, item, tok_len)) {
+	list_for_each(pos, &templates_from_conf) {
+		template = list_entry(pos, struct trailer_template, list);
+		if (token_matches_template(tok->buf, template, tok_len)) {
 			char *tok_buf = strbuf_detach(tok, NULL);
 			if (conf)
-				*conf = &item->conf;
-			strbuf_addstr(tok, token_from_item(item, tok_buf));
+				*conf = &template->conf;
+			strbuf_addstr(tok, token_from_template(template, tok_buf));
 			free(tok_buf);
 			break;
 		}
@@ -728,29 +740,41 @@ static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
 	return new_item;
 }
 
-void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
-			  const struct trailer_conf *conf)
+void add_trailer_template(char *tok, char *val, const struct trailer_conf *conf,
+			  struct list_head *templates)
 {
-	struct arg_item *new_item = xcalloc(1, sizeof(*new_item));
-	new_item->token = tok;
-	new_item->value = val;
-	duplicate_trailer_conf(&new_item->conf, conf);
-	list_add_tail(&new_item->list, arg_head);
+	struct trailer_template *template = xcalloc(1, sizeof(*template));
+	template->token = tok;
+	template->value = val;
+	duplicate_trailer_conf(&template->conf, conf);
+	list_add_tail(&template->list, templates);
 }
 
-void parse_trailers_from_config(struct list_head *config_head)
+void parse_trailer_templates_from_config(struct list_head *config_head)
 {
-	struct arg_item *item;
+	struct trailer_template *template;
 	struct list_head *pos;
 
-	/* Add an arg item for each configured trailer with a command */
-	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct arg_item, list);
-		if (item->conf.command)
-			trailer_add_arg_item(config_head,
-					     xstrdup(token_from_item(item, NULL)),
-					     xstrdup(""),
-					     &item->conf);
+	/*
+	 * Get configured templates with a ".command" option.
+	 *
+	 * NEEDSWORK: If the interpret-trailers builtin sees a
+	 * "trailer.foo.command = ..." setting, then the "foo" trailer will
+	 * always be inserted, even if "--trailer foo" is not provided.
+	 * Considering how ".command" is deprecated, it is a bit strange to see
+	 * it getting special treatment like this over ".cmd". Instead, we
+	 * should add a new option that explicitly lets the user decide if the
+	 * configured trailer should always be added automatically, or if it
+	 * should only be added if "--trailer foo" is provided (default).
+	 * Then we can collect configured trailers that have either ".command"
+	 * or ".cmd" below, instead of just ".command".
+	 */
+	list_for_each(pos, &templates_from_conf) {
+		template = list_entry(pos, struct trailer_template, list);
+		if (template->conf.command)
+			add_trailer_template(xstrdup(token_from_template(template,
+									 NULL)),
+					     xstrdup(""), &template->conf, config_head);
 	}
 }
 
@@ -906,10 +930,16 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
 			possible_continuation_lines = 0;
 			if (recognized_prefix)
 				continue;
-			list_for_each(pos, &conf_head) {
-				struct arg_item *item;
-				item = list_entry(pos, struct arg_item, list);
-				if (token_matches_item(bol, item,
+			/*
+			 * The templates here are not used for actually
+			 * adding trailers anywhere, but instead to help us
+			 * identify trailer lines by comparing their keys with
+			 * those found in configured templates.
+			 */
+			list_for_each(pos, &templates_from_conf) {
+				struct trailer_template *template;
+				template = list_entry(pos, struct trailer_template, list);
+				if (token_matches_template(bol, template,
 						       separator_pos)) {
 					recognized_prefix = 1;
 					break;
@@ -1065,13 +1095,13 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
-void free_new_trailers(struct list_head *trailers)
+void free_trailer_templates(struct list_head *trailer_templates)
 {
 	struct list_head *pos, *p;
 
-	list_for_each_safe(pos, p, trailers) {
+	list_for_each_safe(pos, p, trailer_templates) {
 		list_del(pos);
-		free_arg_item(list_entry(pos, struct arg_item, list));
+		free_template(list_entry(pos, struct trailer_template, list));
 	}
 }
 
diff --git a/trailer.h b/trailer.h
index 4193bedbae4..2a21d74c263 100644
--- a/trailer.h
+++ b/trailer.h
@@ -40,8 +40,8 @@ struct trailer_conf *new_trailer_conf(void);
 void duplicate_trailer_conf(struct trailer_conf *dst,
 			    const struct trailer_conf *src);
 const char *trailer_default_separators(void);
-void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
-			  const struct trailer_conf *conf);
+void add_trailer_template(char *tok, char *val, const struct trailer_conf *,
+			  struct list_head *templates);
 
 struct process_trailer_options {
 	int in_place;
@@ -60,10 +60,10 @@ struct process_trailer_options {
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
 
-void parse_trailers_from_config(struct list_head *config_head);
+void parse_trailer_templates_from_config(struct list_head *config_head);
 
-void process_trailers_lists(struct list_head *head,
-			    struct list_head *arg_head);
+void apply_trailer_templates(struct list_head *templates,
+			     struct list_head *trailers_head);
 
 ssize_t find_separator(const char *line, const char *separators);
 
@@ -86,8 +86,8 @@ void format_trailers(const struct process_trailer_options *,
 		     struct list_head *trailers,
 		     struct strbuf *out);
 void free_trailers(struct list_head *);
-void free_new_trailers(struct list_head *);
 void free_trailer_conf(struct trailer_conf *);
+void free_trailer_templates(struct list_head *);
 
 /*
  * Convenience function to format the trailers from the commit msg "msg" into
-- 
gitgitgadget
