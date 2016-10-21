Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C24620229
	for <e@80x24.org>; Fri, 21 Oct 2016 17:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756061AbcJURzW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:55:22 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32994 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755499AbcJURzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:55:15 -0400
Received: by mail-pf0-f173.google.com with SMTP id 128so60691325pfz.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Y+XkmB4y0lcJw6qSqgGOW3VwEkzr08PyyEkDbEtW/Hw=;
        b=aWLZ15zzc6Eq248GF8oEP1ctWLXvEd0CZ5UvxF1912YY4Mu5DZJQoFjLAJK4P9Omim
         L24kqikjJEI49sOPEfm556xztldO+9XPdznZ5LTALmzPM8enA2i9CECGwg1R5rapUwVv
         HR31JTmfZikYMaltMZCsCijw54Bt+fNgouTBpJQvUV4u5Pw6q+PzW3eXMCDdZeCNIS5R
         KAgyaZAafQVoLI+W2gZd56MNA4DFZOMtTdizTJqqP898u5j3sXkOJPCqdNPXQqq0D0YR
         vmGrZQ91KYR5/t+d3r91AhLTpcKdU9qIFOz6WVkzwzZiDL1vzMRk1KOY/31DFGC/0PCx
         mPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Y+XkmB4y0lcJw6qSqgGOW3VwEkzr08PyyEkDbEtW/Hw=;
        b=W4lSvqB2xbWc1N5OaUjmQ9l7lhBa6icsaxxMXe60Ya+162Qy04VrEJZm/OJ1nC03yu
         sgiXYORS5TcmoSAn6PsDAL/UXARfQsaN5p+1xXkeE8COB0rHNwl7MLNUNXvYvtoOgbn9
         abAwaxSZIX2u+RiN3QWgwXCPHDJsaWkeHOkQDluD2YH0QsLQZ3340ISncAS9PKEB5mXd
         fTl9I4kwRetEMHSW51tYh2WxDtgztQBdgAlTbN3JyhKvELNH6qfeMLPIsZDBsiilpYy6
         Ksu4ybXlAKVePxGOo86ygjqkjh2o8lPNRw/oJdo8vqwSVSrongpRZDCtBYSWS9cHz9dN
         nG6w==
X-Gm-Message-State: ABUngvcAmqyJBWM5C0NTgRiFzK8p1uHI1u41GCJMXQH1b/zVFcGx97gLR4mmNBa8za3EpTEr
X-Received: by 10.98.74.12 with SMTP id x12mr3745157pfa.140.1477072514827;
        Fri, 21 Oct 2016 10:55:14 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id c75sm6714020pfb.23.2016.10.21.10.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 10:55:13 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 4/8] trailer: make args have their own struct
Date:   Fri, 21 Oct 2016 10:54:59 -0700
Message-Id: <6d5608bb3dadc9b767a0c48216418931f4602f72.1477072247.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1477072247.git.jonathantanmy@google.com>
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1477072247.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve type safety by making arguments (whether from configuration or
from the command line) have their own "struct arg_item" type, separate
from the "struct trailer_item" type used to represent the trailers in
the buffer being manipulated.

This change also prepares "struct trailer_item" to be further
differentiated from "struct arg_item" in future patches.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 135 +++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 85 insertions(+), 50 deletions(-)

diff --git a/trailer.c b/trailer.c
index ae3972a..99018f8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -29,6 +29,12 @@ struct trailer_item {
 	struct list_head list;
 	char *token;
 	char *value;
+};
+
+struct arg_item {
+	struct list_head list;
+	char *token;
+	char *value;
 	struct conf_info conf;
 };
 
@@ -62,7 +68,7 @@ static size_t token_len_without_separator(const char *token, size_t len)
 	return len;
 }
 
-static int same_token(struct trailer_item *a, struct trailer_item *b)
+static int same_token(struct trailer_item *a, struct arg_item *b)
 {
 	size_t a_len = token_len_without_separator(a->token, strlen(a->token));
 	size_t b_len = token_len_without_separator(b->token, strlen(b->token));
@@ -71,12 +77,12 @@ static int same_token(struct trailer_item *a, struct trailer_item *b)
 	return !strncasecmp(a->token, b->token, min_len);
 }
 
-static int same_value(struct trailer_item *a, struct trailer_item *b)
+static int same_value(struct trailer_item *a, struct arg_item *b)
 {
 	return !strcasecmp(a->value, b->value);
 }
 
-static int same_trailer(struct trailer_item *a, struct trailer_item *b)
+static int same_trailer(struct trailer_item *a, struct arg_item *b)
 {
 	return same_token(a, b) && same_value(a, b);
 }
@@ -98,6 +104,13 @@ static inline void strbuf_replace(struct strbuf *sb, const char *a, const char *
 
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
@@ -137,17 +150,29 @@ static void print_all(FILE *outfile, struct list_head *head, int trim_empty)
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
 static void add_arg_to_input_list(struct trailer_item *on_tok,
-				  struct trailer_item *arg_tok)
+				  struct arg_item *arg_tok)
 {
-	if (after_or_end(arg_tok->conf.where))
-		list_add(&arg_tok->list, &on_tok->list);
+	int aoe = after_or_end(arg_tok->conf.where);
+	struct trailer_item *to_add = trailer_from_arg(arg_tok);
+	if (aoe)
+		list_add(&to_add->list, &on_tok->list);
 	else
-		list_add_tail(&arg_tok->list, &on_tok->list);
+		list_add_tail(&to_add->list, &on_tok->list);
 }
 
 static int check_if_different(struct trailer_item *in_tok,
-			      struct trailer_item *arg_tok,
+			      struct arg_item *arg_tok,
 			      int check_all,
 			      struct list_head *head)
 {
@@ -200,7 +225,7 @@ static char *apply_command(const char *command, const char *arg)
 	return result;
 }
 
-static void apply_item_command(struct trailer_item *in_tok, struct trailer_item *arg_tok)
+static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
 {
 	if (arg_tok->conf.command) {
 		const char *arg;
@@ -218,13 +243,13 @@ static void apply_item_command(struct trailer_item *in_tok, struct trailer_item
 }
 
 static void apply_arg_if_exists(struct trailer_item *in_tok,
-				struct trailer_item *arg_tok,
+				struct arg_item *arg_tok,
 				struct trailer_item *on_tok,
 				struct list_head *head)
 {
 	switch (arg_tok->conf.if_exists) {
 	case EXISTS_DO_NOTHING:
-		free_trailer_item(arg_tok);
+		free_arg_item(arg_tok);
 		break;
 	case EXISTS_REPLACE:
 		apply_item_command(in_tok, arg_tok);
@@ -241,39 +266,41 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 		if (check_if_different(in_tok, arg_tok, 1, head))
 			add_arg_to_input_list(on_tok, arg_tok);
 		else
-			free_trailer_item(arg_tok);
+			free_arg_item(arg_tok);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
 		apply_item_command(in_tok, arg_tok);
 		if (check_if_different(on_tok, arg_tok, 0, head))
 			add_arg_to_input_list(on_tok, arg_tok);
 		else
-			free_trailer_item(arg_tok);
+			free_arg_item(arg_tok);
 		break;
 	}
 }
 
 static void apply_arg_if_missing(struct list_head *head,
-				 struct trailer_item *arg_tok)
+				 struct arg_item *arg_tok)
 {
 	enum action_where where;
+	struct trailer_item *to_add;
 
 	switch (arg_tok->conf.if_missing) {
 	case MISSING_DO_NOTHING:
-		free_trailer_item(arg_tok);
+		free_arg_item(arg_tok);
 		break;
 	case MISSING_ADD:
 		where = arg_tok->conf.where;
 		apply_item_command(NULL, arg_tok);
+		to_add = trailer_from_arg(arg_tok);
 		if (after_or_end(where))
-			list_add_tail(&arg_tok->list, head);
+			list_add_tail(&to_add->list, head);
 		else
-			list_add(&arg_tok->list, head);
+			list_add(&to_add->list, head);
 	}
 }
 
 static int find_same_and_apply_arg(struct list_head *head,
-				   struct trailer_item *arg_tok)
+				   struct arg_item *arg_tok)
 {
 	struct list_head *pos;
 	struct trailer_item *in_tok;
@@ -306,11 +333,11 @@ static void process_trailers_lists(struct list_head *head,
 				   struct list_head *arg_head)
 {
 	struct list_head *pos, *p;
-	struct trailer_item *arg_tok;
+	struct arg_item *arg_tok;
 
 	list_for_each_safe(pos, p, arg_head) {
 		int applied = 0;
-		arg_tok = list_entry(pos, struct trailer_item, list);
+		arg_tok = list_entry(pos, struct arg_item, list);
 
 		list_del(pos);
 
@@ -375,20 +402,20 @@ static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 		dst->command = xstrdup(src->command);
 }
 
-static struct trailer_item *get_conf_item(const char *name)
+static struct arg_item *get_conf_item(const char *name)
 {
 	struct list_head *pos;
-	struct trailer_item *item;
+	struct arg_item *item;
 
 	/* Look up item with same name */
 	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct trailer_item, list);
+		item = list_entry(pos, struct arg_item, list);
 		if (!strcasecmp(item->conf.name, name))
 			return item;
 	}
 
 	/* Item does not already exists, create it */
-	item = xcalloc(sizeof(struct trailer_item), 1);
+	item = xcalloc(sizeof(*item), 1);
 	duplicate_conf(&item->conf, &default_conf_info);
 	item->conf.name = xstrdup(name);
 
@@ -442,7 +469,7 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
 static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 {
 	const char *trailer_item, *variable_name;
-	struct trailer_item *item;
+	struct arg_item *item;
 	struct conf_info *conf;
 	char *name = NULL;
 	enum trailer_info_type type;
@@ -500,7 +527,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	return 0;
 }
 
-static const char *token_from_item(struct trailer_item *item, char *tok)
+static const char *token_from_item(struct arg_item *item, char *tok)
 {
 	if (item->conf.key)
 		return item->conf.key;
@@ -509,7 +536,7 @@ static const char *token_from_item(struct trailer_item *item, char *tok)
 	return item->conf.name;
 }
 
-static int token_matches_item(const char *tok, struct trailer_item *item, int tok_len)
+static int token_matches_item(const char *tok, struct arg_item *item, int tok_len)
 {
 	if (!strncasecmp(tok, item->conf.name, tok_len))
 		return 1;
@@ -521,7 +548,7 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 {
 	size_t len;
 	struct strbuf seps = STRBUF_INIT;
-	struct trailer_item *item;
+	struct arg_item *item;
 	int tok_len;
 	struct list_head *pos;
 
@@ -547,12 +574,14 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 
 	/* Lookup if the token matches something in the config */
 	tok_len = token_len_without_separator(tok->buf, tok->len);
-	*conf = &default_conf_info;
+	if (conf)
+		*conf = &default_conf_info;
 	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct trailer_item, list);
+		item = list_entry(pos, struct arg_item, list);
 		if (token_matches_item(tok->buf, item, tok_len)) {
 			char *tok_buf = strbuf_detach(tok, NULL);
-			*conf = &item->conf;
+			if (conf)
+				*conf = &item->conf;
 			strbuf_addstr(tok, token_from_item(item, tok_buf));
 			free(tok_buf);
 			break;
@@ -562,43 +591,51 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 	return 0;
 }
 
-static void add_trailer_item(struct list_head *head, char *tok, char *val,
-			     const struct conf_info *conf)
+static void add_trailer_item(struct list_head *head, char *tok, char *val)
 {
 	struct trailer_item *new = xcalloc(sizeof(*new), 1);
 	new->token = tok;
 	new->value = val;
-	duplicate_conf(&new->conf, conf);
 	list_add_tail(&new->list, head);
 }
 
+static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
+			 const struct conf_info *conf)
+{
+	struct arg_item *new = xcalloc(sizeof(*new), 1);
+	new->token = tok;
+	new->value = val;
+	duplicate_conf(&new->conf, conf);
+	list_add_tail(&new->list, arg_head);
+}
+
 static void process_command_line_args(struct list_head *arg_head, 
 				      struct string_list *trailers)
 {
 	struct string_list_item *tr;
-	struct trailer_item *item;
+	struct arg_item *item;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	const struct conf_info *conf;
 	struct list_head *pos;
 
-	/* Add a trailer item for each configured trailer with a command */
+	/* Add an arg item for each configured trailer with a command */
 	list_for_each(pos, &conf_head) {
-		item = list_entry(pos, struct trailer_item, list);
+		item = list_entry(pos, struct arg_item, list);
 		if (item->conf.command)
-			add_trailer_item(arg_head,
-					 xstrdup(token_from_item(item, NULL)),
-					 xstrdup(""),
-					 &item->conf);
+			add_arg_item(arg_head,
+				     xstrdup(token_from_item(item, NULL)),
+				     xstrdup(""),
+				     &item->conf);
 	}
 
-	/* Add a trailer item for each trailer on the command line */
+	/* Add an arg item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
 		if (!parse_trailer(&tok, &val, &conf, tr->string))
-			add_trailer_item(arg_head,
-					 strbuf_detach(&tok, NULL),
-					 strbuf_detach(&val, NULL),
-					 conf);
+			add_arg_item(arg_head,
+				     strbuf_detach(&tok, NULL),
+				     strbuf_detach(&val, NULL),
+				     conf);
 	}
 }
 
@@ -721,7 +758,6 @@ static int process_input_file(FILE *outfile,
 	int patch_start, trailer_start, trailer_end, i;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
-	const struct conf_info *conf;
 
 	/* Get the line count */
 	while (lines[count])
@@ -740,11 +776,10 @@ static int process_input_file(FILE *outfile,
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
 		if (lines[i]->buf[0] != comment_line_char &&
-		    !parse_trailer(&tok, &val, &conf, lines[i]->buf))
+		    !parse_trailer(&tok, &val, NULL, lines[i]->buf))
 			add_trailer_item(head,
 					 strbuf_detach(&tok, NULL),
-					 strbuf_detach(&val, NULL),
-					 conf);
+					 strbuf_detach(&val, NULL));
 	}
 
 	return trailer_end;
-- 
2.8.0.rc3.226.g39d4020

