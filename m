Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04EF51F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 01:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbcJLBvM (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 21:51:12 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35689 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754736AbcJLBvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 21:51:07 -0400
Received: by mail-pf0-f173.google.com with SMTP id s8so10728801pfj.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 18:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hAi6mUH0CnqhwlyAAVjq46FgBRYVXabD1GdQCcET5+I=;
        b=Dmh+n7ChEFqDPHSp7GYTlmK9D8tcuncAN6t4uI0moJ1IR2SDPkAXL2a92+TQihYhRZ
         RaVf91GzbjSTcWSXBx4AweMMOEMyAjULKv3dUO3wlFz0kho8JxQBD14dIaJrUbFYGdro
         /KeFv8xp2ozGGGhedWZxVhpvlYEb4QiwL3ov8jHbpYX8zMetD+G2nfud3b5QDPUW1N5c
         K/QR/KBPQKDXHSs/Z+dQVCjU6xJfktYvcAnXTm5wBtR5Sz80SjCJ6pj7junkN9gH1bts
         4dA1Oi1cnGVOk+EV8cUvYHAHotXqCZMcKbvNrp2r+qgD33/MW3eJPSOyZS7pVM54MUDX
         ZMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hAi6mUH0CnqhwlyAAVjq46FgBRYVXabD1GdQCcET5+I=;
        b=jHAbhwdWpBUTxLEhme3CpQjYzYFXAEhhKegxoYzcZPpwNN/aDpTsua9WUQz0UhWSYZ
         Ol3lU9+nR+i793GT42x5oJp3WnQb4QiYSA62DXZcTqosspHiYfX9YckzCwTItfkr81pd
         ggWD98a/nXTNICQCFz55ie8Kr8taQ+aAp6PvlQqZWCzKFC9d0Z08+X29oIk9/nFWWr+r
         XKkOvOmE2FyFycfgt2nnccJNkGaUjDmsV6Qt2jr3u1LiN1MH5NqA0+J2w0dsIC9fgEvV
         RJSQLrYJif/5kUxtrYP0K6pLQ+HuY7SxAJHOd3KBFY0TAe6xZajkboUJKN/dXLEuKwkl
         Zp7Q==
X-Gm-Message-State: AA6/9Rk4AT9cf9EFeuTm243WLE0PhnX/JOXZbcRS/uNU44msiAqtafwr/yZ2VUQtBJpCKxOS
X-Received: by 10.98.34.218 with SMTP id p87mr1323362pfj.76.1476235418492;
        Tue, 11 Oct 2016 18:23:38 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b11sm7175042pfb.49.2016.10.11.18.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 18:23:37 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, gitster@pobox.com
Subject: [PATCH 3/5] trailer: make args have their own struct
Date:   Tue, 11 Oct 2016 18:23:27 -0700
Message-Id: <a4fdcf820a1d4c2bd9fe8bf157eab833c1e02044.1476232683.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve type safety by making arguments (whether from configuration or
from the command line) have their own "struct arg_item" type, separate
from the "struct trailer_item" type used to represent the trailers in
the buffer being manipulated.

Also take the opportunity to refine the "struct trailer_item" definition
by removing the conf (which is used only by arguments) and by removing
const on the string fields, since those fields are owned by the struct.

This change also prepares "struct trailer_item" to be further
differentiated from "struct arg_item" in future patches.
---
 trailer.c | 161 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 99 insertions(+), 62 deletions(-)

diff --git a/trailer.c b/trailer.c
index e8b1bfb..167b2fd 100644
--- a/trailer.c
+++ b/trailer.c
@@ -26,12 +26,18 @@ static struct conf_info default_conf_info;
 
 struct trailer_item {
 	struct trailer_item *next;
-	const char *token;
-	const char *value;
+	char *token;
+	char *value;
+};
+
+struct arg_item {
+	struct arg_item *next;
+	char *token;
+	char *value;
 	struct conf_info conf;
 };
 
-static struct trailer_item *first_conf_item;
+static struct arg_item *first_conf_item;
 
 static char *separators = ":";
 
@@ -55,8 +61,7 @@ static size_t token_len_without_separator(const char *token, size_t len)
 	return len;
 }
 
-static int same_token(const struct trailer_item *a,
-		      const struct trailer_item *b)
+static int same_token(const struct trailer_item *a, const struct arg_item *b)
 {
 	size_t a_len = token_len_without_separator(a->token, strlen(a->token));
 	size_t b_len = token_len_without_separator(b->token, strlen(b->token));
@@ -65,14 +70,12 @@ static int same_token(const struct trailer_item *a,
 	return !strncasecmp(a->token, b->token, min_len);
 }
 
-static int same_value(const struct trailer_item *a,
-		      const struct trailer_item *b)
+static int same_value(const struct trailer_item *a, const struct arg_item *b)
 {
 	return !strcasecmp(a->value, b->value);
 }
 
-static int same_trailer(const struct trailer_item *a,
-			const struct trailer_item *b)
+static int same_trailer(const struct trailer_item *a, const struct arg_item *b)
 {
 	return same_token(a, b) && same_value(a, b);
 }
@@ -94,11 +97,18 @@ static inline void strbuf_replace(struct strbuf *sb, const char *a, const char *
 
 static void free_trailer_item(struct trailer_item *item)
 {
+	free(item->token);
+	free(item->value);
+	free(item);
+}
+
+static void free_arg_item(struct arg_item *item)
+{
 	free(item->conf.name);
 	free(item->conf.key);
 	free(item->conf.command);
-	free((char *)item->token);
-	free((char *)item->value);
+	free(item->token);
+	free(item->value);
 	free(item);
 }
 
@@ -131,13 +141,13 @@ static void print_all(FILE *outfile, struct trailer_item *first, int trim_empty)
 	}
 }
 
-static const char *apply_command(const char *command, const char *arg)
+static char *apply_command(const char *command, const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const char *argv[] = {NULL, NULL};
-	const char *result;
+	char *result;
 
 	strbuf_addstr(&cmd, command);
 	if (arg)
@@ -162,7 +172,7 @@ static const char *apply_command(const char *command, const char *arg)
 	return result;
 }
 
-static void apply_item_command(struct trailer_item *in_tok, struct trailer_item *arg_tok)
+static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
 {
 	if (arg_tok->conf.command) {
 		const char *arg;
@@ -179,60 +189,77 @@ static void apply_item_command(struct trailer_item *in_tok, struct trailer_item
 	}
 }
 
+static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
+{
+	struct trailer_item *new = xcalloc(sizeof(*new), 1);
+	new->token = arg_tok->token;
+	new->value = arg_tok->value;
+	arg_tok->token = arg_tok->value = NULL;
+	free_arg_item(arg_tok);
+	return new;
+}
+
 static void apply_existing_arg(struct trailer_item **found_next,
-			       struct trailer_item *arg_tok,
+			       struct arg_item *arg_tok,
 			       struct trailer_item **position_to_add,
 			       const struct trailer_item *in_tok_head,
 			       const struct trailer_item *neighbor)
 {
-	if (arg_tok->conf.if_exists == EXISTS_DO_NOTHING) {
-		free_trailer_item(arg_tok);
+	enum action_if_exists if_exists = arg_tok->conf.if_exists;
+	struct trailer_item *to_add;
+
+	if (if_exists == EXISTS_DO_NOTHING) {
+		free_arg_item(arg_tok);
 		return;
 	}
 
 	apply_item_command(*found_next, arg_tok);
 
-	if (arg_tok->conf.if_exists == EXISTS_ADD_IF_DIFFERENT_NEIGHBOR) {
+	if (if_exists == EXISTS_ADD_IF_DIFFERENT_NEIGHBOR) {
 		if (neighbor && same_trailer(neighbor, arg_tok)) {
-			free_trailer_item(arg_tok);
+			free_arg_item(arg_tok);
 			return;
 		}
-	} else if (arg_tok->conf.if_exists == EXISTS_ADD_IF_DIFFERENT) {
+	} else if (if_exists == EXISTS_ADD_IF_DIFFERENT) {
 		const struct trailer_item *in_tok;
 		for (in_tok = in_tok_head; in_tok; in_tok = in_tok->next) {
 			if (same_trailer(in_tok, arg_tok)) {
-				free_trailer_item(arg_tok);
+				free_arg_item(arg_tok);
 				return;
 			}
 		}
 	}
 
-	arg_tok->next = *position_to_add;
-	*position_to_add = arg_tok;
+	to_add = trailer_from_arg(arg_tok);
+	to_add->next = *position_to_add;
+	*position_to_add = to_add;
 
-	if (arg_tok->conf.if_exists == EXISTS_REPLACE) {
+	if (if_exists == EXISTS_REPLACE) {
 		struct trailer_item *new_next = (*found_next)->next;
 		free_trailer_item(*found_next);
 		*found_next = new_next;
 	}
 }
 
-static void apply_missing_arg(struct trailer_item *arg_tok,
+static void apply_missing_arg(struct arg_item *arg_tok,
 			      struct trailer_item **position_to_add)
 {
+	struct trailer_item *to_add;
+
 	if (arg_tok->conf.if_missing == MISSING_DO_NOTHING) {
-		free_trailer_item(arg_tok);
+		free_arg_item(arg_tok);
 		return;
 	}
 
 	apply_item_command(NULL, arg_tok);
 
-	arg_tok->next = *position_to_add;
-	*position_to_add = arg_tok;
+	to_add = trailer_from_arg(arg_tok);
+	to_add->next = *position_to_add;
+	*position_to_add = to_add;
 }
 
 static void apply_arg(struct trailer_item **in_tok_head,
-		      struct trailer_item *arg_tok)
+		      struct arg_item *arg_tok)
 {
 	struct trailer_item **next, **found_next = NULL, *last = NULL;
 	enum action_where where = arg_tok->conf.where;
@@ -283,9 +310,9 @@ static void apply_arg(struct trailer_item **in_tok_head,
 }
 
 static void process_trailers_lists(struct trailer_item **in_tok_head,
-				   struct trailer_item *arg_tok_head)
+				   struct arg_item *arg_tok_head)
 {
-	struct trailer_item *arg_tok, *next;
+	struct arg_item *arg_tok, *next;
 	for (arg_tok = arg_tok_head; arg_tok; arg_tok = next) {
 		next = arg_tok->next;
 		apply_arg(in_tok_head, arg_tok);
@@ -346,10 +373,10 @@ static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 		dst->command = xstrdup(src->command);
 }
 
-static struct trailer_item *get_conf_item(const char *name)
+static struct arg_item *get_conf_item(const char *name)
 {
-	struct trailer_item **next = &first_conf_item;
-	struct trailer_item *item;
+	struct arg_item **next = &first_conf_item;
+	struct arg_item *item;
 
 	/* Look up item with same name */
 	for (next = &first_conf_item; *next; next = &(*next)->next)
@@ -357,7 +384,7 @@ static struct trailer_item *get_conf_item(const char *name)
 			return *next;
 
 	/* Item does not already exists, create it */
-	item = xcalloc(sizeof(struct trailer_item), 1);
+	item = xcalloc(sizeof(*item), 1);
 	duplicate_conf(&item->conf, &default_conf_info);
 	item->conf.name = xstrdup(name);
 	*next = item;
@@ -409,7 +436,7 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
 static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 {
 	const char *trailer_item, *variable_name;
-	struct trailer_item *item;
+	struct arg_item *item;
 	struct conf_info *conf;
 	char *name = NULL;
 	enum trailer_info_type type;
@@ -467,7 +494,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	return 0;
 }
 
-static const char *token_from_item(struct trailer_item *item, char *tok)
+static const char *token_from_item(struct arg_item *item, char *tok)
 {
 	if (item->conf.key)
 		return item->conf.key;
@@ -476,7 +503,7 @@ static const char *token_from_item(struct trailer_item *item, char *tok)
 	return item->conf.name;
 }
 
-static int token_matches_item(const char *tok, struct trailer_item *item, int tok_len)
+static int token_matches_item(const char *tok, struct arg_item *item, int tok_len)
 {
 	if (!strncasecmp(tok, item->conf.name, tok_len))
 		return 1;
@@ -488,7 +515,7 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 {
 	size_t len;
 	struct strbuf seps = STRBUF_INIT;
-	struct trailer_item *item;
+	struct arg_item *item;
 	int tok_len;
 
 	strbuf_addstr(&seps, separators);
@@ -513,11 +540,13 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 
 	/* Lookup if the token matches something in the config */
 	tok_len = token_len_without_separator(tok->buf, tok->len);
-	*conf = &default_conf_info;
+	if (conf)
+		*conf = &default_conf_info;
 	for (item = first_conf_item; item; item = item->next) {
 		if (token_matches_item(tok->buf, item, tok_len)) {
 			char *tok_buf = strbuf_detach(tok, NULL);
-			*conf = &item->conf;
+			if (conf)
+				*conf = &item->conf;
 			strbuf_addstr(tok, token_from_item(item, tok_buf));
 			free(tok_buf);
 			break;
@@ -527,43 +556,53 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 	return 0;
 }
 
-static void add_trailer_item(struct trailer_item ***tail, char *tok, char *val,
-			     const struct conf_info *conf)
+static void add_trailer_item(struct trailer_item ***tail, char *tok, char *val)
 {
 	struct trailer_item *new = xcalloc(sizeof(*new), 1);
 	new->token = tok;
 	new->value = val;
+
+	**tail = new;
+	*tail = &new->next;
+}
+
+static void add_arg_item(struct arg_item ***tail, char *tok, char *val,
+			 const struct conf_info *conf)
+{
+	struct arg_item *new = xcalloc(sizeof(*new), 1);
+	new->token = tok;
+	new->value = val;
 	duplicate_conf(&new->conf, conf);
 
 	**tail = new;
 	*tail = &new->next;
 }
 
-static struct trailer_item *process_command_line_args(struct string_list *trailers)
+static struct arg_item *process_command_line_args(struct string_list *trailers)
 {
-	struct trailer_item *arg_tok_head = NULL;
-	struct trailer_item **arg_tok_tail = &arg_tok_head;
+	struct arg_item *arg_tok_head = NULL;
+	struct arg_item **arg_tok_tail = &arg_tok_head;
 	struct string_list_item *tr;
-	struct trailer_item *item;
+	struct arg_item *item;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	const struct conf_info *conf;
 
-	/* Add a trailer item for each configured trailer with a command */
+	/* Add an arg item for each configured trailer with a command */
 	for (item = first_conf_item; item; item = item->next)
 		if (item->conf.command)
-			add_trailer_item(&arg_tok_tail,
-					 xstrdup(token_from_item(item, NULL)),
-					 xstrdup(""),
-					 &item->conf);
+			add_arg_item(&arg_tok_tail,
+				     xstrdup(token_from_item(item, NULL)),
+				     xstrdup(""),
+				     &item->conf);
 
-	/* Add a trailer item for each trailer on the command line */
+	/* Add an arg item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
 		if (!parse_trailer(&tok, &val, &conf, tr->string))
-			add_trailer_item(&arg_tok_tail,
-					 strbuf_detach(&tok, NULL),
-					 strbuf_detach(&val, NULL),
-					 conf);
+			add_arg_item(&arg_tok_tail,
+				     strbuf_detach(&tok, NULL),
+				     strbuf_detach(&val, NULL),
+				     conf);
 	}
 
 	return arg_tok_head;
@@ -688,7 +727,6 @@ static int process_input_file(FILE *outfile,
 	int patch_start, trailer_start, trailer_end, i;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
-	const struct conf_info *conf;
 
 	/* Get the line count */
 	while (lines[count])
@@ -707,11 +745,10 @@ static int process_input_file(FILE *outfile,
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
 		if (lines[i]->buf[0] != comment_line_char &&
-		    !parse_trailer(&tok, &val, &conf, lines[i]->buf))
+		    !parse_trailer(&tok, &val, NULL, lines[i]->buf))
 			add_trailer_item(in_tok_tail,
 					 strbuf_detach(&tok, NULL),
-					 strbuf_detach(&val, NULL),
-					 conf);
+					 strbuf_detach(&val, NULL));
 	}
 
 	return trailer_end;
@@ -761,7 +798,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 {
 	struct trailer_item *in_tok_head = NULL;
 	struct trailer_item **in_tok_tail = &in_tok_head;
-	struct trailer_item *arg_tok_head;
+	struct arg_item *arg_tok_head;
 	struct strbuf **lines;
 	int trailer_end;
 	FILE *outfile = stdout;
-- 
2.8.0.rc3.226.g39d4020

