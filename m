Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829711F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbcJTVkM (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:40:12 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35496 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755255AbcJTVkH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:07 -0400
Received: by mail-pf0-f179.google.com with SMTP id s8so43663102pfj.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fgWElO4z6bVkJtsu2Vs9N5/jba3247R+KerJG70LAAw=;
        b=GogkhCsXCuauyLz6KbOLRrJZ3/nfYsmDfDKKvz4pHqPkv+Gm6hbpbe4oS//+BRcRA/
         u54Xqf9Uf0O4Fidy7O9eT6r9PWICgxTnaSKzloEnRUXZL7d0o3oa8llPq7gwcTBkiBDU
         BQiM17MkaqdYvATyAEWSviuPluLG1/ztKXhqOl1GwnddFw4iEsSZe3JEl5Vz/Gqsddw3
         GFK/JGMny0VoUCruuRDo1cOf9VRljuJtqHOiDHt/UeU/zJh9ORNdxkxG2X7Slykt06V/
         /eWNufLbebAR3nU/dOmcjpZjh2IiQ5abAaQd7J1MsMI8CWDpfhMu6c3j8AWaQHJUUajC
         3zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fgWElO4z6bVkJtsu2Vs9N5/jba3247R+KerJG70LAAw=;
        b=AomXxCH4TZJHjIzspPD1LfROqk+cg52tukkpvVD8GWWhr9EspV0b8ch0PdmuLUItAU
         MZsYhDtdZ75XUOZmrS3SrRkbd1Ti6wgDp+194xSBOFvJm3wyyjNukR/tGz0ZYABfejxg
         gSdrZAh4VS/EYc4NmmoiC/HqWviJYBO0Z5IQrxc/NQxIDQ4t9bYqH+BVNhBwg0eQPnB7
         J1v11shtTCdScFcLWI0YMb7tuJD6oFCi9wMYtnqjLA7gI3vLsQIQ9DeLWY9ukkU2Fpgx
         57iUQtD/0Pmt8apDinJhg+QJYA0U94VTvR2YGTk5EK0rKNJWbkI7lIzNgOUlFdjovi57
         vnxg==
X-Gm-Message-State: AA6/9RkBYhUkj6cY09D1jNX4q2QRBsNH6pKvSmIbuL2wrzdOLUvtzbmpjP3lyrAOjLiKvMEU
X-Received: by 10.99.113.14 with SMTP id m14mr4071693pgc.57.1476999606461;
        Thu, 20 Oct 2016 14:40:06 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e6sm73883890pfb.57.2016.10.20.14.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 14:40:06 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v4 2/8] trailer: use list.h for doubly-linked list
Date:   Thu, 20 Oct 2016 14:39:47 -0700
Message-Id: <f0acfc7d23ce76a2562b9125af6f8b270baf7b8c.1476998988.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476998988.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476998988.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the existing handwritten implementation of a doubly-linked list
in trailer.c with the functions and macros from list.h. This
significantly simplifies the code.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 trailer.c | 258 ++++++++++++++++++++++----------------------------------------
 1 file changed, 91 insertions(+), 167 deletions(-)

diff --git a/trailer.c b/trailer.c
index 1f191b2..4e85aae 100644
--- a/trailer.c
+++ b/trailer.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "tempfile.h"
 #include "trailer.h"
+#include "list.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -25,19 +26,24 @@ struct conf_info {
 static struct conf_info default_conf_info;
 
 struct trailer_item {
-	struct trailer_item *previous;
-	struct trailer_item *next;
+	struct list_head list;
 	char *token;
 	char *value;
 	struct conf_info conf;
 };
 
-static struct trailer_item *first_conf_item;
+static LIST_HEAD(conf_head);
 
 static char *separators = ":";
 
 #define TRAILER_ARG_STRING "$ARG"
 
+/* Iterate over the elements of the list. */
+#define list_for_each_dir(pos, head, is_reverse) \
+	for (pos = is_reverse ? (head)->prev : (head)->next; \
+		pos != (head); \
+		pos = is_reverse ? pos->prev : pos->next)
+
 static int after_or_end(enum action_where where)
 {
 	return (where == WHERE_AFTER) || (where == WHERE_END);
@@ -120,101 +126,49 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(FILE *outfile, struct trailer_item *first, int trim_empty)
+static void print_all(FILE *outfile, struct list_head *head, int trim_empty)
 {
+	struct list_head *pos;
 	struct trailer_item *item;
-	for (item = first; item; item = item->next) {
+	list_for_each(pos, head) {
+		item = list_entry(pos, struct trailer_item, list);
 		if (!trim_empty || strlen(item->value) > 0)
 			print_tok_val(outfile, item->token, item->value);
 	}
 }
 
-static void update_last(struct trailer_item **last)
-{
-	if (*last)
-		while ((*last)->next != NULL)
-			*last = (*last)->next;
-}
-
-static void update_first(struct trailer_item **first)
-{
-	if (*first)
-		while ((*first)->previous != NULL)
-			*first = (*first)->previous;
-}
-
 static void add_arg_to_input_list(struct trailer_item *on_tok,
-				  struct trailer_item *arg_tok,
-				  struct trailer_item **first,
-				  struct trailer_item **last)
-{
-	if (after_or_end(arg_tok->conf.where)) {
-		arg_tok->next = on_tok->next;
-		on_tok->next = arg_tok;
-		arg_tok->previous = on_tok;
-		if (arg_tok->next)
-			arg_tok->next->previous = arg_tok;
-		update_last(last);
-	} else {
-		arg_tok->previous = on_tok->previous;
-		on_tok->previous = arg_tok;
-		arg_tok->next = on_tok;
-		if (arg_tok->previous)
-			arg_tok->previous->next = arg_tok;
-		update_first(first);
-	}
+				  struct trailer_item *arg_tok)
+{
+	if (after_or_end(arg_tok->conf.where))
+		list_add(&arg_tok->list, &on_tok->list);
+	else
+		list_add_tail(&arg_tok->list, &on_tok->list);
 }
 
 static int check_if_different(struct trailer_item *in_tok,
 			      struct trailer_item *arg_tok,
-			      int check_all)
+			      int check_all,
+			      struct list_head *head)
 {
 	enum action_where where = arg_tok->conf.where;
+	struct list_head *next_head;
 	do {
-		if (!in_tok)
-			return 1;
 		if (same_trailer(in_tok, arg_tok))
 			return 0;
 		/*
 		 * if we want to add a trailer after another one,
 		 * we have to check those before this one
 		 */
-		in_tok = after_or_end(where) ? in_tok->previous : in_tok->next;
+		next_head = after_or_end(where) ? in_tok->list.prev
+						: in_tok->list.next;
+		if (next_head == head)
+			break;
+		in_tok = list_entry(next_head, struct trailer_item, list);
 	} while (check_all);
 	return 1;
 }
 
-static void remove_from_list(struct trailer_item *item,
-			     struct trailer_item **first,
-			     struct trailer_item **last)
-{
-	struct trailer_item *next = item->next;
-	struct trailer_item *previous = item->previous;
-
-	if (next) {
-		item->next->previous = previous;
-		item->next = NULL;
-	} else if (last)
-		*last = previous;
-
-	if (previous) {
-		item->previous->next = next;
-		item->previous = NULL;
-	} else if (first)
-		*first = next;
-}
-
-static struct trailer_item *remove_first(struct trailer_item **first)
-{
-	struct trailer_item *item = *first;
-	*first = item->next;
-	if (item->next) {
-		item->next->previous = NULL;
-		item->next = NULL;
-	}
-	return item;
-}
-
 static char *apply_command(const char *command, const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
@@ -266,8 +220,7 @@ static void apply_item_command(struct trailer_item *in_tok, struct trailer_item
 static void apply_arg_if_exists(struct trailer_item *in_tok,
 				struct trailer_item *arg_tok,
 				struct trailer_item *on_tok,
-				struct trailer_item **in_tok_first,
-				struct trailer_item **in_tok_last)
+				struct list_head *head)
 {
 	switch (arg_tok->conf.if_exists) {
 	case EXISTS_DO_NOTHING:
@@ -275,40 +228,34 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 		break;
 	case EXISTS_REPLACE:
 		apply_item_command(in_tok, arg_tok);
-		add_arg_to_input_list(on_tok, arg_tok,
-				      in_tok_first, in_tok_last);
-		remove_from_list(in_tok, in_tok_first, in_tok_last);
+		add_arg_to_input_list(on_tok, arg_tok);
+		list_del(&in_tok->list);
 		free_trailer_item(in_tok);
 		break;
 	case EXISTS_ADD:
 		apply_item_command(in_tok, arg_tok);
-		add_arg_to_input_list(on_tok, arg_tok,
-				      in_tok_first, in_tok_last);
+		add_arg_to_input_list(on_tok, arg_tok);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT:
 		apply_item_command(in_tok, arg_tok);
-		if (check_if_different(in_tok, arg_tok, 1))
-			add_arg_to_input_list(on_tok, arg_tok,
-					      in_tok_first, in_tok_last);
+		if (check_if_different(in_tok, arg_tok, 1, head))
+			add_arg_to_input_list(on_tok, arg_tok);
 		else
 			free_trailer_item(arg_tok);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
 		apply_item_command(in_tok, arg_tok);
-		if (check_if_different(on_tok, arg_tok, 0))
-			add_arg_to_input_list(on_tok, arg_tok,
-					      in_tok_first, in_tok_last);
+		if (check_if_different(on_tok, arg_tok, 0, head))
+			add_arg_to_input_list(on_tok, arg_tok);
 		else
 			free_trailer_item(arg_tok);
 		break;
 	}
 }
 
-static void apply_arg_if_missing(struct trailer_item **in_tok_first,
-				 struct trailer_item **in_tok_last,
+static void apply_arg_if_missing(struct list_head *head,
 				 struct trailer_item *arg_tok)
 {
-	struct trailer_item **in_tok;
 	enum action_where where;
 
 	switch (arg_tok->conf.if_missing) {
@@ -317,68 +264,60 @@ static void apply_arg_if_missing(struct trailer_item **in_tok_first,
 		break;
 	case MISSING_ADD:
 		where = arg_tok->conf.where;
-		in_tok = after_or_end(where) ? in_tok_last : in_tok_first;
 		apply_item_command(NULL, arg_tok);
-		if (*in_tok) {
-			add_arg_to_input_list(*in_tok, arg_tok,
-					      in_tok_first, in_tok_last);
-		} else {
-			*in_tok_first = arg_tok;
-			*in_tok_last = arg_tok;
-		}
-		break;
+		if (after_or_end(where))
+			list_add_tail(&arg_tok->list, head);
+		else
+			list_add(&arg_tok->list, head);
 	}
 }
 
-static int find_same_and_apply_arg(struct trailer_item **in_tok_first,
-				   struct trailer_item **in_tok_last,
+static int find_same_and_apply_arg(struct list_head *head,
 				   struct trailer_item *arg_tok)
 {
+	struct list_head *pos;
 	struct trailer_item *in_tok;
 	struct trailer_item *on_tok;
-	struct trailer_item *following_tok;
 
 	enum action_where where = arg_tok->conf.where;
 	int middle = (where == WHERE_AFTER) || (where == WHERE_BEFORE);
 	int backwards = after_or_end(where);
-	struct trailer_item *start_tok = backwards ? *in_tok_last : *in_tok_first;
+	struct trailer_item *start_tok;
 
-	for (in_tok = start_tok; in_tok; in_tok = following_tok) {
-		following_tok = backwards ? in_tok->previous : in_tok->next;
+	if (list_empty(head))
+		return 0;
+
+	start_tok = list_entry(backwards ? head->prev : head->next,
+			       struct trailer_item,
+			       list);
+
+	list_for_each_dir(pos, head, backwards) {
+		in_tok = list_entry(pos, struct trailer_item, list);
 		if (!same_token(in_tok, arg_tok))
 			continue;
 		on_tok = middle ? in_tok : start_tok;
-		apply_arg_if_exists(in_tok, arg_tok, on_tok,
-				    in_tok_first, in_tok_last);
+		apply_arg_if_exists(in_tok, arg_tok, on_tok, head);
 		return 1;
 	}
 	return 0;
 }
 
-static void process_trailers_lists(struct trailer_item **in_tok_first,
-				   struct trailer_item **in_tok_last,
-				   struct trailer_item **arg_tok_first)
+static void process_trailers_lists(struct list_head *head,
+				   struct list_head *arg_head)
 {
+	struct list_head *pos, *p;
 	struct trailer_item *arg_tok;
-	struct trailer_item *next_arg;
-
-	if (!*arg_tok_first)
-		return;
 
-	for (arg_tok = *arg_tok_first; arg_tok; arg_tok = next_arg) {
+	list_for_each_safe(pos, p, arg_head) {
 		int applied = 0;
+		arg_tok = list_entry(pos, struct trailer_item, list);
 
-		next_arg = arg_tok->next;
-		remove_from_list(arg_tok, arg_tok_first, NULL);
+		list_del(pos);
 
-		applied = find_same_and_apply_arg(in_tok_first,
-						  in_tok_last,
-						  arg_tok);
+		applied = find_same_and_apply_arg(head, arg_tok);
 
 		if (!applied)
-			apply_arg_if_missing(in_tok_first,
-					     in_tok_last,
-					     arg_tok);
+			apply_arg_if_missing(head, arg_tok);
 	}
 }
 
@@ -438,13 +377,12 @@ static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 
 static struct trailer_item *get_conf_item(const char *name)
 {
+	struct list_head *pos;
 	struct trailer_item *item;
-	struct trailer_item *previous;
 
 	/* Look up item with same name */
-	for (previous = NULL, item = first_conf_item;
-	     item;
-	     previous = item, item = item->next) {
+	list_for_each(pos, &conf_head) {
+		item = list_entry(pos, struct trailer_item, list);
 		if (!strcasecmp(item->conf.name, name))
 			return item;
 	}
@@ -454,12 +392,7 @@ static struct trailer_item *get_conf_item(const char *name)
 	duplicate_conf(&item->conf, &default_conf_info);
 	item->conf.name = xstrdup(name);
 
-	if (!previous)
-		first_conf_item = item;
-	else {
-		previous->next = item;
-		item->previous = previous;
-	}
+	list_add_tail(&item->list, &conf_head);
 
 	return item;
 }
@@ -633,6 +566,7 @@ static struct trailer_item *create_trailer_item(const char *string)
 	struct strbuf val = STRBUF_INIT;
 	struct trailer_item *item;
 	int tok_len;
+	struct list_head *pos;
 
 	if (parse_trailer(&tok, &val, string))
 		return NULL;
@@ -640,7 +574,8 @@ static struct trailer_item *create_trailer_item(const char *string)
 	tok_len = token_len_without_separator(tok.buf, tok.len);
 
 	/* Lookup if the token matches something in the config */
-	for (item = first_conf_item; item; item = item->next) {
+	list_for_each(pos, &conf_head) {
+		item = list_entry(pos, struct trailer_item, list);
 		if (token_matches_item(tok.buf, item, tok_len))
 			return new_trailer_item(item,
 						strbuf_detach(&tok, NULL),
@@ -652,44 +587,34 @@ static struct trailer_item *create_trailer_item(const char *string)
 				strbuf_detach(&val, NULL));
 }
 
-static void add_trailer_item(struct trailer_item **first,
-			     struct trailer_item **last,
-			     struct trailer_item *new)
+static void add_trailer_item(struct list_head *head, struct trailer_item *new)
 {
 	if (!new)
 		return;
-	if (!*last) {
-		*first = new;
-		*last = new;
-	} else {
-		(*last)->next = new;
-		new->previous = *last;
-		*last = new;
-	}
+	list_add_tail(&new->list, head);
 }
 
-static struct trailer_item *process_command_line_args(struct string_list *trailers)
+static void process_command_line_args(struct list_head *arg_head, 
+				      struct string_list *trailers)
 {
-	struct trailer_item *arg_tok_first = NULL;
-	struct trailer_item *arg_tok_last = NULL;
 	struct string_list_item *tr;
 	struct trailer_item *item;
+	struct list_head *pos;
 
 	/* Add a trailer item for each configured trailer with a command */
-	for (item = first_conf_item; item; item = item->next) {
+	list_for_each(pos, &conf_head) {
+		item = list_entry(pos, struct trailer_item, list);
 		if (item->conf.command) {
 			struct trailer_item *new = new_trailer_item(item, NULL, NULL);
-			add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+			add_trailer_item(arg_head, new);
 		}
 	}
 
 	/* Add a trailer item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
 		struct trailer_item *new = create_trailer_item(tr->string);
-		add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+		add_trailer_item(arg_head, new);
 	}
-
-	return arg_tok_first;
 }
 
 static struct strbuf **read_input_file(const char *file)
@@ -805,8 +730,7 @@ static void print_lines(FILE *outfile, struct strbuf **lines, int start, int end
 
 static int process_input_file(FILE *outfile,
 			      struct strbuf **lines,
-			      struct trailer_item **in_tok_first,
-			      struct trailer_item **in_tok_last)
+			      struct list_head *head)
 {
 	int count = 0;
 	int patch_start, trailer_start, trailer_end, i;
@@ -829,18 +753,19 @@ static int process_input_file(FILE *outfile,
 	for (i = trailer_start; i < trailer_end; i++) {
 		if (lines[i]->buf[0] != comment_line_char) {
 			struct trailer_item *new = create_trailer_item(lines[i]->buf);
-			add_trailer_item(in_tok_first, in_tok_last, new);
+			add_trailer_item(head, new);
 		}
 	}
 
 	return trailer_end;
 }
 
-static void free_all(struct trailer_item **first)
+static void free_all(struct list_head *head)
 {
-	while (*first) {
-		struct trailer_item *item = remove_first(first);
-		free_trailer_item(item);
+	struct list_head *pos, *p;
+	list_for_each_safe(pos, p, head) {
+		list_del(pos);
+		free_trailer_item(list_entry(pos, struct trailer_item, list));
 	}
 }
 
@@ -877,9 +802,8 @@ static FILE *create_in_place_tempfile(const char *file)
 
 void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
 {
-	struct trailer_item *in_tok_first = NULL;
-	struct trailer_item *in_tok_last = NULL;
-	struct trailer_item *arg_tok_first;
+	LIST_HEAD(head);
+	LIST_HEAD(arg_head);
 	struct strbuf **lines;
 	int trailer_end;
 	FILE *outfile = stdout;
@@ -894,15 +818,15 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 		outfile = create_in_place_tempfile(file);
 
 	/* Print the lines before the trailers */
-	trailer_end = process_input_file(outfile, lines, &in_tok_first, &in_tok_last);
+	trailer_end = process_input_file(outfile, lines, &head);
 
-	arg_tok_first = process_command_line_args(trailers);
+	process_command_line_args(&arg_head, trailers);
 
-	process_trailers_lists(&in_tok_first, &in_tok_last, &arg_tok_first);
+	process_trailers_lists(&head, &arg_head);
 
-	print_all(outfile, in_tok_first, trim_empty);
+	print_all(outfile, &head, trim_empty);
 
-	free_all(&in_tok_first);
+	free_all(&head);
 
 	/* Print the lines after the trailers as is */
 	print_lines(outfile, lines, trailer_end, INT_MAX);
-- 
2.8.0.rc3.226.g39d4020

