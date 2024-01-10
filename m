Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F13A1BF
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmuz/iNT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e5508ecb9so8381215e9.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 22:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704869495; x=1705474295; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smVvMc5pEUpKMKNz7Dao5GDVMmWhSganQOLMSnlURps=;
        b=fmuz/iNTHpaqZ8q4dE1yOZZJSlw9qn+bKoD4jIlnUNnbGeYJjXtl/VR5MvDYEy/TZd
         Go2zdrxWMhMKM0wCG3aP1r7Y3/aEdFVtrAkAok/8A90jSKTcZ3aoYuHHJpiC094b3+B2
         ODPUOVr4n9YVZNU9uujvTVPmpTG54uYSq8+RHxbaGp9ULzI3qwDkeP0ZcTCTocuAs+dz
         kjHk/6M0SUOu3wqCB1uStFE2OYW3wV9hrjWCd0mdohTv9YwnpoLmrY2UofHu315wCQeV
         O6ordQ14x0u7s/hYACCcd/mdGJKHKQKi2RJ6kAjJfBpQZkrN0S8IzTGVB0o9jN5oLfkq
         OT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869495; x=1705474295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smVvMc5pEUpKMKNz7Dao5GDVMmWhSganQOLMSnlURps=;
        b=u1UsttHY4nwCWxh1HQBSMYry1AM6rxxcZdOx6l237KUy6tMdLjZwPId11hmZouAZC0
         GBit00gs5Gr0ntyRUBx9PtA1ow2C8tz0M8zDCyP7kS+dv5mPxKOj1vM/xvQM2C9Q8M8e
         T0+HR90oWUo9DnUnnGkoKkXYG6fpHyZWsM1sxCCQKBBAuvQrxhtlbKV4YY40VrulZ5+i
         K5G7hDRYZFpMAj3HfZp7xGwNuifVwj22fHxnLHxyOH0C5LCywForCaOoUtB0FnsoIRbL
         d4nk0uBY5sJrtEFVYlrEXlREvinRwO6r8RaQjKHyMb4295ltXcuPkFzMuDEdCZDCYVYm
         +9EQ==
X-Gm-Message-State: AOJu0YxB3o378nSOXz6ZvaMmywBSSXGdzdUDP9d9OeLvF2Wmcer/G5xS
	XjD5roKaQ0G3il9vwGEqwrNbgWA0VRE=
X-Google-Smtp-Source: AGHT+IFkPLGfI250qUsiplT/INksDbtUacUabUQTUt0M1JthoXVsU0UP/54p5yDm//tKXve/KgV3Ow==
X-Received: by 2002:a7b:c414:0:b0:40e:4a88:2de2 with SMTP id k20-20020a7bc414000000b0040e4a882de2mr228850wmi.155.1704869495285;
        Tue, 09 Jan 2024 22:51:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0040d91912f2csm1019038wms.1.2024.01.09.22.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:51:34 -0800 (PST)
Message-ID: <406725df46a81f485d7a74c11488e625d3026dc5.1704869487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 06:51:24 +0000
Subject: [PATCH 08/10] trailer: prepare to move
 parse_trailers_from_command_line_args() to builtin
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
Cc: Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Expose more functions in the trailer.h API, in preparation for moving
out

    parse_trailers_from_command_line_args()

to interpret-trailer.c, because the trailer API should not be concerned
with command line arguments (as it has nothing to do with trailers
themselves). The interpret-trailers builtin is the only user of the
above function.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 66 +++++++++++++++++++++++++++----------------------------
 trailer.h | 10 +++++++++
 2 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/trailer.c b/trailer.c
index 360e76376b8..e2d541372a3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -33,7 +33,7 @@ struct trailer_block {
 	size_t trailer_nr;
 };
 
-struct conf_info {
+struct trailer_conf {
 	char *name;
 	char *key;
 	char *command;
@@ -43,7 +43,7 @@ struct conf_info {
 	enum trailer_if_missing if_missing;
 };
 
-static struct conf_info default_conf_info;
+static struct trailer_conf default_trailer_conf;
 
 struct trailer_item {
 	struct list_head list;
@@ -59,7 +59,7 @@ struct arg_item {
 	struct list_head list;
 	char *token;
 	char *value;
-	struct conf_info conf;
+	struct trailer_conf conf;
 };
 
 static LIST_HEAD(conf_head);
@@ -210,7 +210,7 @@ static int check_if_different(struct trailer_item *in_tok,
 	return 1;
 }
 
-static char *apply_command(struct conf_info *conf, const char *arg)
+static char *apply_command(struct trailer_conf *conf, const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
@@ -424,7 +424,8 @@ int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
 	return 0;
 }
 
-static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
+void duplicate_trailer_conf(struct trailer_conf *dst,
+			    const struct trailer_conf *src)
 {
 	*dst = *src;
 	dst->name = xstrdup_or_null(src->name);
@@ -447,7 +448,7 @@ static struct arg_item *get_conf_item(const char *name)
 
 	/* Item does not already exists, create it */
 	CALLOC_ARRAY(item, 1);
-	duplicate_conf(&item->conf, &default_conf_info);
+	duplicate_trailer_conf(&item->conf, &default_trailer_conf);
 	item->conf.name = xstrdup(name);
 
 	list_add_tail(&item->list, &conf_head);
@@ -482,17 +483,17 @@ static int git_trailer_default_config(const char *conf_key, const char *value,
 	variable_name = strrchr(trailer_item, '.');
 	if (!variable_name) {
 		if (!strcmp(trailer_item, "where")) {
-			if (trailer_set_where(&default_conf_info.where,
+			if (trailer_set_where(&default_trailer_conf.where,
 					      value) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "ifexists")) {
-			if (trailer_set_if_exists(&default_conf_info.if_exists,
+			if (trailer_set_if_exists(&default_trailer_conf.if_exists,
 						  value) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "ifmissing")) {
-			if (trailer_set_if_missing(&default_conf_info.if_missing,
+			if (trailer_set_if_missing(&default_trailer_conf.if_missing,
 						   value) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
@@ -511,7 +512,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 {
 	const char *trailer_item, *variable_name;
 	struct arg_item *item;
-	struct conf_info *conf;
+	struct trailer_conf *conf;
 	char *name = NULL;
 	enum trailer_info_type type;
 	int i;
@@ -585,9 +586,9 @@ void trailer_config_init(void)
 		return;
 
 	/* Default config must be setup first */
-	default_conf_info.where = WHERE_END;
-	default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
-	default_conf_info.if_missing = MISSING_ADD;
+	default_trailer_conf.where = WHERE_END;
+	default_trailer_conf.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
+	default_trailer_conf.if_missing = MISSING_ADD;
 	git_config(git_trailer_default_config, NULL);
 	git_config(git_trailer_config, NULL);
 	configured = 1;
@@ -620,7 +621,7 @@ static int token_matches_item(const char *tok, struct arg_item *item, size_t tok
  * distinguished from the non-well-formed-line case (in which this function
  * returns -1) because some callers of this function need such a distinction.
  */
-static ssize_t find_separator(const char *line, const char *separators)
+ssize_t find_separator(const char *line, const char *separators)
 {
 	int whitespace_found = 0;
 	const char *c;
@@ -645,28 +646,28 @@ static ssize_t find_separator(const char *line, const char *separators)
  *
  * If separator_pos is -1, interpret the whole trailer as a token.
  */
-static void parse_trailer(struct strbuf *tok, struct strbuf *val,
-			 const struct conf_info **conf, const char *trailer,
-			 ssize_t separator_pos)
+void parse_trailer(const char *line, ssize_t separator_pos,
+		   struct strbuf *tok, struct strbuf *val,
+		   const struct trailer_conf **conf)
 {
 	struct arg_item *item;
 	size_t tok_len;
 	struct list_head *pos;
 
 	if (separator_pos != -1) {
-		strbuf_add(tok, trailer, separator_pos);
+		strbuf_add(tok, line, separator_pos);
 		strbuf_trim(tok);
-		strbuf_addstr(val, trailer + separator_pos + 1);
+		strbuf_addstr(val, line + separator_pos + 1);
 		strbuf_trim(val);
 	} else {
-		strbuf_addstr(tok, trailer);
+		strbuf_addstr(tok, line);
 		strbuf_trim(tok);
 	}
 
 	/* Lookup if the token matches something in the config */
 	tok_len = token_len_without_separator(tok->buf, tok->len);
 	if (conf)
-		*conf = &default_conf_info;
+		*conf = &default_trailer_conf;
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
 		if (token_matches_item(tok->buf, item, tok_len)) {
@@ -691,13 +692,13 @@ static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
 }
 
 static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
-			 const struct conf_info *conf,
+			 const struct trailer_conf *conf,
 			 const struct new_trailer_item *new_trailer_item)
 {
 	struct arg_item *new_item = xcalloc(1, sizeof(*new_item));
 	new_item->token = tok;
 	new_item->value = val;
-	duplicate_conf(&new_item->conf, conf);
+	duplicate_trailer_conf(&new_item->conf, conf);
 	if (new_trailer_item) {
 		if (new_trailer_item->where != WHERE_DEFAULT)
 			new_item->conf.where = new_trailer_item->where;
@@ -730,7 +731,7 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
-	const struct conf_info *conf;
+	const struct trailer_conf *conf;
 	struct list_head *pos;
 
 	/*
@@ -753,8 +754,7 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 			      (int) sb.len, sb.buf);
 			strbuf_release(&sb);
 		} else {
-			parse_trailer(&tok, &val, &conf, tr->text,
-				      separator_pos);
+			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
 			add_arg_item(arg_head,
 				     strbuf_detach(&tok, NULL),
 				     strbuf_detach(&val, NULL),
@@ -1116,20 +1116,19 @@ struct trailer_block *parse_trailers(const char *str,
 
 	for (i = 0; i < trailer_block->trailer_nr; i++) {
 		int separator_pos;
-		char *trailer = trailer_block->trailers[i];
-		if (trailer[0] == comment_line_char)
+		char *line = trailer_block->trailers[i];
+		if (line[0] == comment_line_char)
 			continue;
-		separator_pos = find_separator(trailer, separators);
+		separator_pos = find_separator(line, separators);
 		if (separator_pos >= 1) {
-			parse_trailer(&tok, &val, NULL, trailer,
-				      separator_pos);
+			parse_trailer(line, separator_pos, &tok, &val, NULL);
 			if (opts->unfold)
 				unfold_value(&val);
 			add_trailer_item(head,
 					 strbuf_detach(&tok, NULL),
 					 strbuf_detach(&val, NULL));
 		} else if (!opts->only_trailers) {
-			strbuf_addstr(&val, trailer);
+			strbuf_addstr(&val, line);
 			strbuf_strip_suffix(&val, "\n");
 			add_trailer_item(head,
 					 NULL,
@@ -1217,8 +1216,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 		strbuf_addstr(&iter->raw, line);
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
-		parse_trailer(&iter->key, &iter->val, NULL,
-			      line, separator_pos);
+		parse_trailer(line, separator_pos, &iter->key, &iter->val, NULL);
 		unfold_value(&iter->val);
 		return 1;
 	}
diff --git a/trailer.h b/trailer.h
index 5c8503ade78..fe49a9bad52 100644
--- a/trailer.h
+++ b/trailer.h
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 
 struct trailer_block;
+struct trailer_conf;
 
 enum trailer_where {
 	WHERE_DEFAULT,
@@ -45,6 +46,9 @@ struct new_trailer_item {
 	enum trailer_if_missing if_missing;
 };
 
+void duplicate_trailer_conf(struct trailer_conf *dst,
+			    const struct trailer_conf *src);
+
 struct process_trailer_options {
 	int in_place;
 	int trim_empty;
@@ -70,6 +74,12 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
+ssize_t find_separator(const char *line, const char *separators);
+
+void parse_trailer(const char *line, ssize_t separator_pos,
+		   struct strbuf *tok, struct strbuf *val,
+		   const struct trailer_conf **conf);
+
 struct trailer_block *parse_trailers(const char *str,
 				     const struct process_trailer_options *opts,
 				     struct list_head *head);
-- 
gitgitgadget

