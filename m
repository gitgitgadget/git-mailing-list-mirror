Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAB5B5CA
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308750; cv=none; b=EkPv6bTGBcj40rVqZGss1RlkQMKWsFoW/5CRXyL4mk2hkW8TOto0xDsPGdGmeJCo8Z5mYE9BUICVCoBqZvBDae0X33p38egx5tSDTXJSZoiFfBeor+cqpSfRD58+E/igitmLlEoGBAksToPVXjZvLnrZU6TRcqu0jyv3gPbSf3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308750; c=relaxed/simple;
	bh=PtCCuLonOCRt0Ru8sNJNdxyyZ378SkCCDwPTcLZcpTs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SfF8XYtwEFdMg0fJi9kXMmfsKqZTDytA6ygwqtDdWgoqCdfVWdfT7AGgjZ82B2XwRgnkcjil6JzTI1PApbCMO70izTCW4SHi5zniuJjd2N9wZ9UeoGEZC8vg+GsFRTvECWhFE8uIiiGTWCa8n7Ke+gUMpAuGIC+cESiDFhn1tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S43ACXrH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S43ACXrH"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33921b8988fso976856f8f.3
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308746; x=1706913546; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRk+3C8IALaEfI7ZIID5BEGl7Wn4rKwWqU0IKt/GCHc=;
        b=S43ACXrHY1ewrQLlqE+yLF3pmFfZlzoXcGpbVMYPEmK47RoF0s4qA0xSrtAFghFG5N
         iMRGI+aS19Y8GcWGgVdWCYI84bSLwuIX4r1GjhDo+roVPpP/k7qNy1Ex9aGxtSsB8+JY
         gi90w4rgtg+YZdfKOe++t9ypgBOUyyj/hKULmw3m6eJXWHhavZpTatWSSSv24FdOGIMe
         +ydEFR1miZ30Q7g/uU1B1FnPhOiv0+8dacvJpS7plivph8eFvQK/BT5WTvK2vy5cmpgz
         SdrRJSRBID58sTDUxgEzEoYkR6IzBWR53TnbQja8h0J+L21u84vbvqqghcMWjv35ejfx
         jeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308746; x=1706913546;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRk+3C8IALaEfI7ZIID5BEGl7Wn4rKwWqU0IKt/GCHc=;
        b=mXgzcxfAxZTIeVwbAwE632N2OE0EvcESQCp5w9EWOmHPofUZZNvYm39r3QSLRa/EiL
         +fCCOnMfbDflDsDNww6wBa8bd/WT/G60yA88Ul5jS/eIkUW8JCovA8MWg0W9xAU8ZCag
         hQ2NUYkgz4pcUvfoX+ytgQajD2CSaJ9Qa0g0sBwsW8CoPxrVNPMAT4VGaAub18B8PYHf
         a33FjxfffEFzCwXsZo+5C92AWNoDEGvQwooYyY4tVzzN47hjn0opC+CkjbsNrHM6yIb1
         JALjdBkQe9EWz/SKqIuIwc2Cllvhq9f1jCrJoFZWCnC1qUb2Ba9lRsyasnUgVyZlqU6/
         8hTA==
X-Gm-Message-State: AOJu0YyepkF+jZnlJgdEOTy6Xl5UpJuZe6+60kzsT7lgNvqB98qAwt28
	nmRKBpfxfmPjY/Sa7YPjeKw40szm4cPCUefwfUOnl0g5IrCO0BQOY2IhP12t
X-Google-Smtp-Source: AGHT+IFBWH0avXxowxYwEM5XfIqHclQrXkABCKVb7Pk3atBrm9BnYV5o+FBel16WENlS3S4Q1E+xYg==
X-Received: by 2002:a5d:4742:0:b0:337:5997:a4f0 with SMTP id o2-20020a5d4742000000b003375997a4f0mr186735wrs.9.1706308746370;
        Fri, 26 Jan 2024 14:39:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4588000000b00337d735c193sm2125721wrq.49.2024.01.26.14.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:39:06 -0800 (PST)
Message-ID: <64ee07d0b53cf46d8f1aa1b7d26528f35a26b662.1706308737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:55 +0000
Subject: [PATCH v2 08/10] trailer: prepare to move
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Expose more functions in the trailer.h API, in preparation for moving
out

    parse_trailers_from_command_line_args()

to interpret-trailer.c, because the trailer API should not be concerned
with command line arguments (as they have nothing to do with trailers
themselves). The interpret-trailers builtin is the only caller of this
function.

Also rename "conf_info" to "trailer_conf" for readability, dropping the
low-value "_info" suffix as we did earlier in this series for
"trailer_info" to "trailer_block".

Helped-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 66 +++++++++++++++++++++++++++----------------------------
 trailer.h | 10 +++++++++
 2 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/trailer.c b/trailer.c
index e2a48bea0ae..d362b9a604e 100644
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
@@ -1116,20 +1116,19 @@ struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
 
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
@@ -1215,8 +1214,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 		iter->raw = line;
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
-		parse_trailer(&iter->key, &iter->val, NULL,
-			      line, separator_pos);
+		parse_trailer(line, separator_pos, &iter->key, &iter->val, NULL);
 		unfold_value(&iter->val);
 		return 1;
 	}
diff --git a/trailer.h b/trailer.h
index be14dd17185..c6aa96dd6be 100644
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
 struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
 				     const char *str,
 				     struct list_head *head);
-- 
gitgitgadget

