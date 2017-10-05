Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA0A20281
	for <e@80x24.org>; Thu,  5 Oct 2017 13:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbdJENWx (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 09:22:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34121 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdJENWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 09:22:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id z1so9618745wre.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=481ivkB1ihO1vFAQP5uj4O/5Ie6wrG6n0RyUkhL6pHw=;
        b=ODHAPWy6Qus9cyDYzv7TTd8xvYeCYfZvnJVtUQXC31kV8lvWrHHqqStOH+pKrB4V9O
         OdwapvUzP1uOFgMK+Gjbi1D4pGUtXoZdf6hFzDqrfEiz9LAUDjmFLGhyBuzGGhtEgA2P
         4aIlAAuRtF24ei3RYI3FANcmpNsmf6Ko14eKTPzMZ/4E+yzILvsg4BUjiZtez4F8GToM
         SZLvonqzHm1uODN+jtEGrQDMNOWTjAE8Qh/JyN9g9ye7e28lJTBf/V0rblWlR5GsgyYr
         78Vs/Yt3BZ4qSC3DuIz6M8JDuK6URFUtLHPvJCspO9j6q9opLIIIXq5593Zczoa/LR60
         jLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=481ivkB1ihO1vFAQP5uj4O/5Ie6wrG6n0RyUkhL6pHw=;
        b=n2O27Mvuqn6dqNWuFK3EmkxihugFMHyW6W25Kbiu0a4Lf7JzMZ//B10cTkQ5VksJT8
         3hQDmsVFvBObL0W+p+pzNG6GE7fr6M/DVj3IcZzA0n/sLyhCerCUBQnMwSnIUBvdY5iC
         PW1UaDTWGtufNDJ1qTOLxUz5+XkBzOOFCptSit+uCNDJYVb3daGbD5QACZRB3ZsrGA1F
         CLNOOu1KfGy0w0UybyaJ/4gCqoI+mnGIjvJz7zMD3wPQaNY1ew0CFj+AyicYLej4TXmc
         I4F0tSLbwicbE5EzuG+WHRZOZixfJFoWpJQauaCMxwT2Y33+KZnYYcGiNeWnSDbSc09J
         rtmA==
X-Gm-Message-State: AMCzsaWWmwnV33m1O3YWBUqEDoQlOJVPAhZKmZyLUaLGEZVRCpVnIpN/
        d/NDQt4Xt9w03nS4TUj/UL0isjrh
X-Google-Smtp-Source: AOwi7QANtivRDUMjNJc6mILvHP2HzuuoHqR/MWOjzFuaQB6FriOhsdcUnDGOoHjv2ReOS/NMivGQdA==
X-Received: by 10.223.160.80 with SMTP id l16mr2535002wrl.281.1507209768642;
        Thu, 05 Oct 2017 06:22:48 -0700 (PDT)
Received: from donizetti.redhat.com (dynamic-adsl-78-12-246-117.clienti.tiscali.it. [78.12.246.117])
        by smtp.gmail.com with ESMTPSA id r15sm10864439wrc.30.2017.10.05.06.22.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 06:22:48 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] trailer: create a new function to handle adding trailers
Date:   Thu,  5 Oct 2017 15:22:42 +0200
Message-Id: <20171005132243.27058-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171005132243.27058-1-pbonzini@redhat.com>
References: <20171005132243.27058-1-pbonzini@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new function apply_arg that takes care of computing the new
trailer's "neighbor", checking for duplicates through a pluggable
callback, and adding the new argument according to "trailer.where".

Rename after_or_end, and don't use it in apply_arg.  It's a coincidence
that the conditions for "scan backwards" and "add after" are the same.

This simplifies find_same_and_apply_arg so that it does exactly what
the name says.  apply_arg_if_missing can also use the new function;
before, it was redoing add_arg_to_input_list's job in a slightly
different fashion.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 trailer.c | 125 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 75 insertions(+), 50 deletions(-)

diff --git a/trailer.c b/trailer.c
index 91f89db7f..ce0d94074 100644
--- a/trailer.c
+++ b/trailer.c
@@ -58,7 +58,7 @@ static const char *git_generated_prefixes[] = {
 		pos != (head); \
 		pos = is_reverse ? pos->prev : pos->next)
 
-static int after_or_end(enum trailer_where where)
+static int scan_backwards(enum trailer_where where)
 {
 	return (where == WHERE_AFTER) || (where == WHERE_END);
 }
@@ -181,18 +181,8 @@ static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 	return new;
 }
 
-static void add_arg_to_input_list(struct trailer_item *on_tok,
-				  struct arg_item *arg_tok)
-{
-	int aoe = after_or_end(arg_tok->conf.where);
-	struct trailer_item *to_add = trailer_from_arg(arg_tok);
-	if (aoe)
-		list_add(&to_add->list, &on_tok->list);
-	else
-		list_add_tail(&to_add->list, &on_tok->list);
-}
-
 static int check_if_different(struct trailer_item *in_tok,
+			      struct trailer_item *neighbor,
 			      struct arg_item *arg_tok,
 			      struct list_head *head)
 {
@@ -203,8 +193,8 @@ static int check_if_different(struct trailer_item *in_tok,
 		 * if we want to add a trailer after another one,
 		 * we have to check those before this one
 		 */
-		next_head = after_or_end(where) ? in_tok->list.prev
-						: in_tok->list.next;
+		next_head = scan_backwards(where) ? in_tok->list.prev
+						  : in_tok->list.next;
 		if (next_head == head)
 			return 1;
 		in_tok = list_entry(next_head, struct trailer_item, list);
@@ -212,6 +202,14 @@ static int check_if_different(struct trailer_item *in_tok,
 	return 0;
 }
 
+static int check_if_different_neighbor(struct trailer_item *in_tok,
+				       struct trailer_item *neighbor,
+				       struct arg_item *arg_tok,
+				       struct list_head *head)
+{
+	return !same_trailer(neighbor, arg_tok);
+}
+
 static char *apply_command(const char *command, const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
@@ -260,33 +258,80 @@ static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
 	}
 }
 
+static int apply_arg(struct trailer_item *in_tok,
+		     struct arg_item *arg_tok,
+		     struct list_head *head,
+		     int (*check)(struct trailer_item *in_tok,
+				  struct trailer_item *neighbor,
+				  struct arg_item *arg_tok,
+				  struct list_head *head),
+		     int replace)
+{
+	struct trailer_item *to_add, *neighbor;
+	struct list_head *place;
+	int add_after;
+
+	enum trailer_where where = arg_tok->conf.where;
+	int middle = (where == WHERE_AFTER) || (where == WHERE_BEFORE);
+
+	/*
+	 * No other trailer to apply arg_tok one before/after.  Put it
+	 * before/after _all_ other trailers.
+	 */
+	if (!in_tok && middle) {
+		where = (where == WHERE_AFTER) ? WHERE_END : WHERE_START;
+		middle = 0;
+	}
+
+	if (list_empty(head)) {
+		add_after = 1;
+		place = head;
+		neighbor = NULL;
+	} else if (middle) {
+		add_after = (where == WHERE_AFTER);
+		place = &in_tok->list;
+		neighbor = in_tok;
+	} else {
+		add_after = (where == WHERE_END);
+		place = (where == WHERE_END) ? head->prev : head->next;
+		neighbor = list_entry(place, struct trailer_item, list);
+	}
+
+	apply_item_command(in_tok, arg_tok);
+	if (check && !check(in_tok, neighbor, arg_tok, head))
+		return 0;
+
+	to_add = trailer_from_arg(arg_tok);
+	if (add_after)
+		list_add(&to_add->list, place);
+	else
+		list_add_tail(&to_add->list, place);
+
+	if (replace) {
+		list_del(&in_tok->list);
+		free_trailer_item(in_tok);
+	}
+	return 1;
+}
+
 static void apply_arg_if_exists(struct trailer_item *in_tok,
 				struct arg_item *arg_tok,
-				struct trailer_item *on_tok,
 				struct list_head *head)
 {
 	switch (arg_tok->conf.if_exists) {
 	case EXISTS_DO_NOTHING:
 		break;
 	case EXISTS_REPLACE:
-		apply_item_command(in_tok, arg_tok);
-		add_arg_to_input_list(on_tok, arg_tok);
-		list_del(&in_tok->list);
-		free_trailer_item(in_tok);
+		apply_arg(in_tok, arg_tok, head, NULL, 1);
 		break;
 	case EXISTS_ADD:
-		apply_item_command(in_tok, arg_tok);
-		add_arg_to_input_list(on_tok, arg_tok);
+		apply_arg(in_tok, arg_tok, head, NULL, 0);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT:
-		apply_item_command(in_tok, arg_tok);
-		if (check_if_different(in_tok, arg_tok, head))
-			add_arg_to_input_list(on_tok, arg_tok);
+		apply_arg(in_tok, arg_tok, head, check_if_different, 0);
 		break;
 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
-		apply_item_command(in_tok, arg_tok);
-		if (!same_trailer(on_tok, arg_tok))
-			add_arg_to_input_list(on_tok, arg_tok);
+		apply_arg(in_tok, arg_tok, head, check_if_different_neighbor, 0);
 		break;
 	default:
 		die("BUG: trailer.c: unhandled value %d",
@@ -297,24 +342,12 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 static void apply_arg_if_missing(struct list_head *head,
 				 struct arg_item *arg_tok)
 {
-	enum trailer_where where;
-	struct trailer_item *to_add;
-
 	switch (arg_tok->conf.if_missing) {
 	case MISSING_DO_NOTHING:
 		break;
 	case MISSING_ADD:
-		where = arg_tok->conf.where;
-		apply_item_command(NULL, arg_tok);
-		to_add = trailer_from_arg(arg_tok);
-		if (after_or_end(where))
-			list_add_tail(&to_add->list, head);
-		else
-			list_add(&to_add->list, head);
+		apply_arg(NULL, arg_tok, head, NULL, 0);
 		break;
-	default:
-		die("BUG: trailer.c: unhandled value %d",
-		    arg_tok->conf.if_missing);
 	}
 }
 
@@ -323,26 +356,18 @@ static int find_same_and_apply_arg(struct list_head *head,
 {
 	struct list_head *pos;
 	struct trailer_item *in_tok;
-	struct trailer_item *on_tok;
 
 	enum trailer_where where = arg_tok->conf.where;
-	int middle = (where == WHERE_AFTER) || (where == WHERE_BEFORE);
-	int backwards = after_or_end(where);
-	struct trailer_item *start_tok;
+	int backwards = scan_backwards(where);
 
 	if (list_empty(head))
 		return 0;
 
-	start_tok = list_entry(backwards ? head->prev : head->next,
-			       struct trailer_item,
-			       list);
-
 	list_for_each_dir(pos, head, backwards) {
 		in_tok = list_entry(pos, struct trailer_item, list);
 		if (!same_token(in_tok, arg_tok))
 			continue;
-		on_tok = middle ? in_tok : start_tok;
-		apply_arg_if_exists(in_tok, arg_tok, on_tok, head);
+		apply_arg_if_exists(in_tok, arg_tok, head);
 		return 1;
 	}
 	return 0;
-- 
2.14.2


