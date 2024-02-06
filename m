Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D97E76A
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196374; cv=none; b=MtcupnmhalUXD6XRclOA6SiLCVbq/LecaWsmnJagv9X35dPkvzYoW68RAozVaVq38iRQEPEXLo0knAKEarf5KqUt82nVR0vHzmghKp9IP4OzBmL0Z0yk1A4xEJPl1EChb4PiaYWP6YlqK6t9tGM3jp9lDZ1Jiq0dbtg1xdlTbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196374; c=relaxed/simple;
	bh=cchuHLnSL+nGTYzHvQIYLFQ5zeCmzJCmvph+zCqjTgU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ydpms+AI7YAt5WcqFkIWfp2KzLqXr9RhvbmALSxamfTO7myuEXNZHIACHrbWtsDmWEbS13tqu46qK0I4MD+omY85Hkcg9YLm2xvrAgJzpcTtHZIz0URxOzvARCiWi486QqT5LbM37b4wWyja7vRLWJoCdJWR413hGq6LUmP588w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYnn7ThH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYnn7ThH"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511234430a4so9102939e87.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196371; x=1707801171; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6Zj2YOYhr0LYMrWK0exJg+gp07Yzh6Kzf0Hh53kln0=;
        b=PYnn7ThHeygLWyYj+9Dr9sJ3WFnYr8wDTAdMNREfBhqBdSOUuq/7axaYz/CqVvBHjf
         JDegOsW5P3SAQ2IZuMrB3Z6mJtPozGi6cw78HFhPhJ+9xSdm61rr2CuFaAaY4I4emZYS
         uFU+3aeatTw4R2L7tBFwrBUuSlclw/U+/kGAwPO0/0ehmmn/uJUrS7NxatDG56LHbBbg
         S0proz1XgH+DqQtP+QH9WlextgpS6n9W1oJsOFbX8NfNckoVS9RmFz2/lexaUu3HtsyH
         oOxBGgwe0qRYK2/hxbRdboEn0i3wlCkXuPLSKRJ4y+kWlNQJJo4eEzd7Oo0S+DO7uPA5
         PRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196371; x=1707801171;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6Zj2YOYhr0LYMrWK0exJg+gp07Yzh6Kzf0Hh53kln0=;
        b=gY0Ds293VZmJd5AAI9oDmaFAbA5lxBTnmb3Xxoh9ABvjREDmKep15IZUkXO2oHKmQQ
         9PX8YzA4ZMTUiBGeJlrOuRGRFdWFI9r2hbxOAUp2m3n1SwiQcTAu3by12xLvNjWgG8fi
         T8qHXlF1vd1AEOicmRNq35Vley20jgr1Ab0ecUqKJmaQp4E0rim4buUQtihmas3VUsFg
         rzmved0xCyKYy31FxUPMELagrCfNPyxzIDB0RWxQH3axjugpA/e9Wy9UNS/tL2o6XJu4
         6p21KMt8Tkn/0iNoXsbi55/I48ntCc7ohUSCCduI4ZUQBGsxeWim4/neMlT5/nU2MPF3
         bQug==
X-Gm-Message-State: AOJu0YzDLNiDLe1TnwaPnhIiIdnrXCr9hVdZuq1Ghlf5hOpuA1zi79yF
	+FDpxQscAi7StoifFYFML2n7ziG0KE2OYdYNoNMrHsAC5+DPpnEPzASr7h5W
X-Google-Smtp-Source: AGHT+IEV9R6+vQP1nqvv07+1avySMgHbjggEPlw94naSByP1qYeF+2ikP+Cr7zdZgf/iQ98l11cdUQ==
X-Received: by 2002:a05:6512:31c6:b0:511:5e45:1150 with SMTP id j6-20020a05651231c600b005115e451150mr610139lfe.61.1707196370734;
        Mon, 05 Feb 2024 21:12:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsA90ncBSe87U5gEu57pF/qa9C+Rc3PwF/bb0grfkkYazC4WFZDSl8sUYBQQV0lvCo4YpUQ5GqF2AbbMMcXUHUi1N3MDd7fbUI7UvOYUj6NXZI6y348wqO+0KoWJ0gkVIgn689IVep511fET+t5+BWoIb8VW1juMvNJt+bSxVzE9QHXhXZtx04jzINBvUnbLMBDoQ8V/Lr1Q==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b0040efb445698sm657484wmq.5.2024.02.05.21.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:49 -0800 (PST)
Message-ID: <94bf182e3ffbf8ed6e20cd77b2e46e5b83c44d34.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:22 +0000
Subject: [PATCH v4 22/28] trailer: prepare to delete
 "parse_trailers_from_command_line_args()"
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

Expose more functions in the trailer.h API, in preparation for deleting

    parse_trailers_from_command_line_args()

from the trailers implementation, because it should not be concerned
with command line arguments (as they have nothing to do with trailers
themselves). Indeed, the interpret-trailers builtin is the only caller
of this function inside Git.

Rename add_arg_item() to trailer_add_arg_item() to expose it as an API
function. Rename new_trailers_clear() to free_new_trailers() because it
will be promoted into an API function; the API already has
free_trailers(), so using the "free_*" naming style will keep it
consistent. Also rename "conf_info" to "trailer_conf" for readability,
dropping the low-value "_info" suffix as we did earlier in this series
for "trailer_info" to "trailer_block".

Helped-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  6 +--
 trailer.c                    | 86 ++++++++++++++++++------------------
 trailer.h                    | 13 ++++++
 3 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index f76841c5280..f674b5f4b9e 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -45,7 +45,7 @@ static int option_parse_if_missing(const struct option *opt,
 	return trailer_set_if_missing(opt->value, arg);
 }
 
-static void new_trailers_clear(struct list_head *trailers)
+static void free_new_trailers(struct list_head *trailers)
 {
 	struct list_head *pos, *tmp;
 	struct new_trailer_item *item;
@@ -64,7 +64,7 @@ static int option_parse_trailer(const struct option *opt,
 	struct new_trailer_item *item;
 
 	if (unset) {
-		new_trailers_clear(trailers);
+		free_new_trailers(trailers);
 		return 0;
 	}
 
@@ -237,7 +237,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		interpret_trailers(&opts, &trailers, NULL);
 	}
 
-	new_trailers_clear(&trailers);
+	free_new_trailers(&trailers);
 
 	return 0;
 }
diff --git a/trailer.c b/trailer.c
index 49bf26e3211..3b8f0ba103c 100644
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
@@ -690,14 +691,14 @@ static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
 	return new_item;
 }
 
-static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
-			 const struct conf_info *conf,
-			 const struct new_trailer_item *new_trailer_item)
+void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
+			  const struct trailer_conf *conf,
+			  const struct new_trailer_item *new_trailer_item)
 {
 	struct arg_item *new_item = xcalloc(1, sizeof(*new_item));
 	new_item->token = tok;
 	new_item->value = val;
-	duplicate_conf(&new_item->conf, conf);
+	duplicate_trailer_conf(&new_item->conf, conf);
 	if (new_trailer_item) {
 		if (new_trailer_item->where != WHERE_DEFAULT)
 			new_item->conf.where = new_trailer_item->where;
@@ -718,10 +719,10 @@ void parse_trailers_from_config(struct list_head *config_head)
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
 		if (item->conf.command)
-			add_arg_item(config_head,
-				     xstrdup(token_from_item(item, NULL)),
-				     xstrdup(""),
-				     &item->conf, NULL);
+			trailer_add_arg_item(config_head,
+					     xstrdup(token_from_item(item, NULL)),
+					     xstrdup(""),
+					     &item->conf, NULL);
 	}
 }
 
@@ -730,7 +731,7 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
-	const struct conf_info *conf;
+	const struct trailer_conf *conf;
 	struct list_head *pos;
 
 	/*
@@ -753,12 +754,11 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 			      (int) sb.len, sb.buf);
 			strbuf_release(&sb);
 		} else {
-			parse_trailer(&tok, &val, &conf, tr->text,
-				      separator_pos);
-			add_arg_item(arg_head,
-				     strbuf_detach(&tok, NULL),
-				     strbuf_detach(&val, NULL),
-				     conf, tr);
+			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
+			trailer_add_arg_item(arg_head,
+					     strbuf_detach(&tok, NULL),
+					     strbuf_detach(&val, NULL),
+					     conf, tr);
 		}
 	}
 
@@ -1044,20 +1044,19 @@ struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
 
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
@@ -1200,8 +1199,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 		iter->raw = line;
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
-		parse_trailer(&iter->key, &iter->val, NULL,
-			      line, separator_pos);
+		parse_trailer(line, separator_pos, &iter->key, &iter->val, NULL);
 		/* Always unfold values during iteration. */
 		unfold_value(&iter->val);
 		return 1;
diff --git a/trailer.h b/trailer.h
index 76e6d941a07..f80f8f7e63f 100644
--- a/trailer.h
+++ b/trailer.h
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 
 struct trailer_block;
+struct trailer_conf;
 
 enum trailer_where {
 	WHERE_DEFAULT,
@@ -45,6 +46,12 @@ struct new_trailer_item {
 	enum trailer_if_missing if_missing;
 };
 
+void duplicate_trailer_conf(struct trailer_conf *dst,
+			    const struct trailer_conf *src);
+void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
+			  const struct trailer_conf *conf,
+			  const struct new_trailer_item *new_trailer_item);
+
 struct process_trailer_options {
 	int in_place;
 	int trim_empty;
@@ -70,6 +77,12 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
+ssize_t find_separator(const char *line, const char *separators);
+
+void parse_trailer(const char *line, ssize_t separator_pos,
+		   struct strbuf *tok, struct strbuf *val,
+		   const struct trailer_conf **);
+
 struct trailer_block *parse_trailers(const struct process_trailer_options *,
 				     const char *str,
 				     struct list_head *head);
-- 
gitgitgadget

