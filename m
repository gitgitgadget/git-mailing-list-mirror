Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C77F7C4
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196377; cv=none; b=S2Aw8pg1Z0xn6qOi1+TB1JPAEoRNI8yk3IEig5+A7s09Drzs97mW/QOqIE1FH1IKf1/bsOmOE/aAHUTXnDBz8MuIkSfmcuVpYn6KyQfk+IZU0oVwdPhh22cQakTFvh2rf7UYiKOwLZXM19RMF5GZkjutKeowoIAfjdoQP4R3Vgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196377; c=relaxed/simple;
	bh=rNuRlQZTLSbeS2GM2ocNousd05NDbYtnIeWdJKaGJrQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BUSKgH+5MzdCBNEun3Ngiwvcoem3XVx0Y2BXh4etCDUPDeubCglYbqf2UyPr0pnB1pp7iUcD3aEeSphMVeQqP1lBbLLDcq/qksIz8tiWzUENVHOflbTGp7E3u+NVJnqZzFqXxGEs2zD876Ds2Kxd1wQcyqPA0pYgIyla31R4iiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9WLGGYF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9WLGGYF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fd280421aso22400405e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196374; x=1707801174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9YbuTac7HerLgW3Z92WF4EFJF1mMxRQHEPVw3mxxg8=;
        b=R9WLGGYFHHAfEexyzObP3m7mRE5cF5OTi52qsOdyCSxiV8o52YkPa3BDDJQRqw/R55
         uvODk9r1rrYtlFIfWSlu5pMx6XM7+ybp4pUOAQ0U6AZlMbsEyfGjZZZC3KSER34+PRIs
         4ZjC+OFbSsMjP7k8Gs0CqhTWyhex2+gy96AogXIqY/3z/wPxaEoffUo3PRCsnUss0wi3
         bbByx12Nw5UdicOylYMgecuyIU4qTuD5kkd6l/LghdUPan/eWCwDB9qTlqldSyJhS/qz
         6HpGpYJIj5Xkb8nD6bGOjexPL4EEZFWy2Sgsh+yeCmSJFWS3xHD/1/MNU2bssizUVust
         4EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196374; x=1707801174;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9YbuTac7HerLgW3Z92WF4EFJF1mMxRQHEPVw3mxxg8=;
        b=viuuOYuNKqOB8iX8u9OdKBx9femw1Ns9a2BZRxPcVAwBlATYm3HkFtekQ2dD5Y20vR
         l9Qy6tck6Rrxzah2cgZXvceH233OUv7jNWlP9bUM1n1QIRY5TenYbcq7yDdQfV2Pnf2t
         V128SW54zslbVRXipO/KNCDQhYod8N/5ZceEiMecLhOGyxWJDQtj/fpdsUZuFHrs4dbm
         e6HlKwDHXgaTlcSalzEbLPvUhObcYM6z4nYb0oW2CnSuO0VWoztPgJMGNzVwxGH6cKgG
         pmpT0Qb9SYHJX9XHU7iHw+FLMNnSdOg2WlDIcTu3Z76s2UJNhpn2pjgOpPNHlMHoLNeo
         wnCA==
X-Gm-Message-State: AOJu0YwcuIKKybkw1PPPcsYDmN/TFmuo5U/601dYvCx7XEUQMMLGV/xX
	X6HNt2/AF0O4G3yqLtKPuC9QHCabFHQgf/cBgB5Qs2hR/Dg4rXdXyORbmczU
X-Google-Smtp-Source: AGHT+IHSIqsuL2VWazlUSBeM8y/uyDmr+56u7iFaDd6D4ZpjwnUZKt5hXurYo34XhmLj8L6EUMbAWA==
X-Received: by 2002:a05:600c:19c8:b0:40f:b691:d3c1 with SMTP id u8-20020a05600c19c800b0040fb691d3c1mr1101687wmq.30.1707196373820;
        Mon, 05 Feb 2024 21:12:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXHB0UlTB/JO+8WTG3riV1ghR2c5HsYP4VaLCKwztxSsWxKJJ5tTb/fcsb4R3VaVT+fFR4+vtF+MR5tq2QWUu+0EKUIWJnhS2HyB0xCsCVAvaVHZNhcw+9SWYFzLR8b88q4Q/W6kO1bc7m66pzhr+AmOKShjzOoYlTsd4dN47CxMo5bbYip+PyrggzGZWF8fGif3lQswrUB3g==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c020800b0040faf3df118sm642998wmi.32.2024.02.05.21.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:53 -0800 (PST)
Message-ID: <a9080597a28de9977e4909f0ff9d0f04f6689984.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:25 +0000
Subject: [PATCH v4 25/28] trailer: deprecate "new_trailer_item" struct from
 API
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

Previously, the "new_trailer_item" struct served only one purpose --- to
capture the unparsed raw string <RAW> in "--trailer <RAW>", as well as
the current state of the "where", "if_exists", and "if_missing" global
variables at the time that the "--trailer <RAW>" CLI argument was
encountered.

In addition, the previous CLI argument handling behavior was to capture
the <RAW> string in all "--trailer <RAW>" arguments and to collect
them (via option_parse_trailer()) into the "new_trailer_head" list. We
would then iterate over this list again in
parse_trailers_from_command_line_args() and convert these
"new_trailer_item" objects into "arg_item" objects.

Skip this intermediate storage of "new_trailer_item" objects in favor of
just storing "arg_item" objects. Remove the looping behavior of
parse_trailers_from_command_line_args() so that it parses a single
"--trailer ..." argument at a time. Rename it to
parse_trailer_from_command_line_arg() to reflect this new behavior of
only looking at one string (not multiple strings) at a time. Make
option_parse_trailer() call parse_trailer_from_command_line_arg() so
that the CLI arguments it sees are parsed immediately without the need
for intermediate storage.

Delete "new_trailer_item", because we don't need it any more.

In the next patch we will retire parse_trailer_from_command_line_arg()
as well, combining it with option_parse_trailer().

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 29 +++++--------
 trailer.c                    | 81 +++++++++++++++++-------------------
 trailer.h                    | 21 +++-------
 3 files changed, 54 insertions(+), 77 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 9169c320921..943be5b360e 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -49,7 +49,6 @@ static int option_parse_trailer(const struct option *opt,
 				   const char *arg, int unset)
 {
 	struct list_head *trailers = opt->value;
-	struct new_trailer_item *item;
 
 	if (unset) {
 		free_new_trailers(trailers);
@@ -59,12 +58,8 @@ static int option_parse_trailer(const struct option *opt,
 	if (!arg)
 		return -1;
 
-	item = xmalloc(sizeof(*item));
-	item->text = arg;
-	item->where = where;
-	item->if_exists = if_exists;
-	item->if_missing = if_missing;
-	list_add_tail(&item->list, trailers);
+	parse_trailer_from_command_line_arg(arg, where, if_exists, if_missing, trailers);
+
 	return 0;
 }
 
@@ -132,8 +127,6 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	struct trailer_block *trailer_block;
 	FILE *outfile = stdout;
 
-	trailer_config_init();
-
 	read_input_file(&sb, file);
 
 	if (opts->in_place)
@@ -148,15 +141,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
 		fprintf(outfile, "\n");
 
-
-	if (!opts->only_input) {
-		LIST_HEAD(config_head);
-		LIST_HEAD(arg_head);
-		parse_trailers_from_config(&config_head);
-		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
-		list_splice(&config_head, &arg_head);
-		process_trailers_lists(&head, &arg_head);
-	}
+	if (!opts->only_input)
+		process_trailers_lists(&head, new_trailer_head);
 
 	/* Print trailer block. */
 	format_trailers(opts, &head, &tb);
@@ -180,6 +166,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	LIST_HEAD(configured_trailers);
 	LIST_HEAD(trailers);
 
 	struct option options[] = {
@@ -205,6 +192,10 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
+	trailer_config_init();
+
+	if (!opts.only_input)
+		parse_trailers_from_config(&configured_trailers);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_interpret_trailers_usage, 0);
@@ -215,6 +206,8 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 			git_interpret_trailers_usage,
 			options);
 
+	list_splice(&configured_trailers, &trailers);
+
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
diff --git a/trailer.c b/trailer.c
index 6ab5cf7e5d7..0893175553a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -754,57 +754,54 @@ void parse_trailers_from_config(struct list_head *config_head)
 	}
 }
 
-void parse_trailers_from_command_line_args(struct list_head *arg_head,
-					   struct list_head *new_trailer_head)
+void parse_trailer_from_command_line_arg(const char *line,
+					 enum trailer_where where,
+					 enum trailer_if_exists if_exists,
+					 enum trailer_if_missing if_missing,
+					 struct list_head *arg_head)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	const struct trailer_conf *conf;
-	struct list_head *pos;
 
 	/*
 	 * In command-line arguments, '=' is accepted (in addition to the
 	 * separators that are defined).
 	 */
-	char *cl_separators = xstrfmt("=%s", separators);
+	char *cl_separators = xstrfmt("=%s", trailer_default_separators());
 
-	/* Add an arg item for each trailer on the command line */
-	list_for_each(pos, new_trailer_head) {
-		struct new_trailer_item *tr =
-			list_entry(pos, struct new_trailer_item, list);
-		ssize_t separator_pos = find_separator(tr->text, cl_separators);
+	/* Add an arg item for a trailer from the command line */
+	ssize_t separator_pos = find_separator(line, cl_separators);
+	free(cl_separators);
 
-		if (separator_pos == 0) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, tr->text);
-			strbuf_trim(&sb);
-			error(_("empty trailer token in trailer '%.*s'"),
-			      (int) sb.len, sb.buf);
-			strbuf_release(&sb);
-		} else {
-			struct trailer_conf *conf_current = new_trailer_conf();
-			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
-			duplicate_trailer_conf(conf_current, conf);
+	if (separator_pos == 0) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, line);
+		strbuf_trim(&sb);
+		error(_("empty trailer token in trailer '%.*s'"),
+		      (int) sb.len, sb.buf);
+		strbuf_release(&sb);
+	} else {
+		struct trailer_conf *conf_current = new_trailer_conf();
+		parse_trailer(line, separator_pos, &tok, &val, &conf);
+		duplicate_trailer_conf(conf_current, conf);
 
-			/*
-			 * Override conf_current with settings specified via CLI flags.
-			 */
-			if (tr->where != WHERE_DEFAULT)
-				trailer_set_conf_where(tr->where, conf_current);
-			if (tr->if_exists != EXISTS_DEFAULT)
-				trailer_set_conf_if_exists(tr->if_exists, conf_current);
-			if (tr->if_missing != MISSING_DEFAULT)
-				trailer_set_conf_if_missing(tr->if_missing, conf_current);
-
-			trailer_add_arg_item(arg_head,
-					     strbuf_detach(&tok, NULL),
-					     strbuf_detach(&val, NULL),
-					     conf_current);
-			free_trailer_conf(conf_current);
-		}
+		/*
+		 * Override conf_current with settings specified via CLI flags.
+		 */
+		if (where != WHERE_DEFAULT)
+			trailer_set_conf_where(where, conf_current);
+		if (if_exists != EXISTS_DEFAULT)
+			trailer_set_conf_if_exists(if_exists, conf_current);
+		if (if_missing != MISSING_DEFAULT)
+			trailer_set_conf_if_missing(if_missing, conf_current);
+
+		trailer_add_arg_item(arg_head,
+				     strbuf_detach(&tok, NULL),
+				     strbuf_detach(&val, NULL),
+				     conf_current);
+		free_trailer_conf(conf_current);
 	}
-
-	free(cl_separators);
 }
 
 static const char *next_line(const char *str)
@@ -1120,13 +1117,11 @@ void free_trailers(struct list_head *trailers)
 
 void free_new_trailers(struct list_head *trailers)
 {
-	struct list_head *pos, *tmp;
-	struct new_trailer_item *item;
+	struct list_head *pos, *p;
 
-	list_for_each_safe(pos, tmp, trailers) {
-		item = list_entry(pos, struct new_trailer_item, list);
+	list_for_each_safe(pos, p, trailers) {
 		list_del(pos);
-		free(item);
+		free_arg_item(list_entry(pos, struct arg_item, list));
 	}
 }
 
diff --git a/trailer.h b/trailer.h
index 32fc93beb33..2848a0d086c 100644
--- a/trailer.h
+++ b/trailer.h
@@ -32,20 +32,6 @@ int trailer_set_where(enum trailer_where *item, const char *value);
 int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
 int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
 
-/*
- * A list that represents newly-added trailers, such as those provided
- * with the --trailer command line option of git-interpret-trailers.
- */
-struct new_trailer_item {
-	struct list_head list;
-
-	const char *text;
-
-	enum trailer_where where;
-	enum trailer_if_exists if_exists;
-	enum trailer_if_missing if_missing;
-};
-
 void trailer_set_conf_where(enum trailer_where, struct trailer_conf *);
 void trailer_set_conf_if_exists(enum trailer_if_exists, struct trailer_conf *);
 void trailer_set_conf_if_missing(enum trailer_if_missing, struct trailer_conf *);
@@ -76,8 +62,11 @@ struct process_trailer_options {
 
 void parse_trailers_from_config(struct list_head *config_head);
 
-void parse_trailers_from_command_line_args(struct list_head *arg_head,
-					   struct list_head *new_trailer_head);
+void parse_trailer_from_command_line_arg(const char *line,
+					 enum trailer_where where,
+					 enum trailer_if_exists if_exists,
+					 enum trailer_if_missing if_missing,
+					 struct list_head *arg_head);
 
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
-- 
gitgitgadget

