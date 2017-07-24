Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D174F1F89D
	for <e@80x24.org>; Mon, 24 Jul 2017 08:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbdGXIWv (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 04:22:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34541 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbdGXIWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 04:22:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id 79so4160312wmg.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T4KlfUegXjtkIJ/H6uPU73dZGg3Vfl7g1RZYRue2DZo=;
        b=LVVhvfAnPQP6ISM3J/w0zVQGXi+Jwb7lwv0AEyeXDKZh46TsVHM6CztS1V+yULgHQy
         NpFwWoQr41GeAO2XfjmpG/Qu5nHTVza5ozSDlZqUuLUOYTL+66N6fazA7QpAAOebfx79
         AO1EmdEih26VPOiw0G7Qx9/9L8Pg+poxp/LqJQP3bX1K2zl+AiHX9la8sdG8KyI6okkU
         bhuPpkKShBvlRyAPy078cGMLu8K9j+pSYyYRxpEkwuXoIez8m7IzyNnHkpJm4kp3Q/Cx
         guAjVHu2NxCPjTNP2z9jrjx0bLgfXWcqi1mWEAK+9DtuKUTf8Z27XTI7A7q0vsRgqi2m
         JctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=T4KlfUegXjtkIJ/H6uPU73dZGg3Vfl7g1RZYRue2DZo=;
        b=F/jRWX6qF8MWKcfK/tiF5NmXaDP5CuVckB5qzYhUQi90q+Ydm/ccRMLWRJlJu3zmDZ
         2BVnuoytMbQcz1Ybn1QE0qh9LBxlQ/M2pj/2oq8OTNUELAFmhw1KSsDRdQVAcIQ1kBF9
         XPlaBhkEW1ieYLEa6bCB+QwCExFB+B37POXU4S3k75HB7dJlYwajef9kddf/WBHoGf+Y
         VhziC+8uv30Vj9Wm/h6yLVovMFrMBty4fPyxdilwDcQrJC2WvrOZWmp6HJ+pI+Wps8k1
         TvVjYIOPSB619I5xojBYmYoNPzCOUQSYoP5UQBuu5bSTba2tBBrrVwjUFGWzy6tzkWWV
         7T+w==
X-Gm-Message-State: AIVw112D6J1OQI9WLTOH6xggO3IjqP7je8LOux7bnYlvWaXmN4xU0GD6
        xPFrRWQsF+pmBDgOyDI=
X-Received: by 10.28.189.133 with SMTP id n127mr2922591wmf.23.1500884567427;
        Mon, 24 Jul 2017 01:22:47 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-195-172.adsl-ull.clienti.tiscali.it. [94.39.195.172])
        by smtp.gmail.com with ESMTPSA id r129sm7911476wmg.42.2017.07.24.01.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jul 2017 01:22:46 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 1/3] trailers: export action enums and corresponding lookup functions
Date:   Mon, 24 Jul 2017 10:22:43 +0200
Message-Id: <20170724082245.26496-1-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170724082044.26199-1-bonzini@gnu.org>
References: <20170724082044.26199-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Separate the mechanical changes out of the next patch.  The functions
are changed to take a pointer to enum, because struct conf_info is not
going to be public.

Set the default values explicitly in default_conf_info, since they are
not anymore close to default_conf_info and it's not obvious which
constant has value 0.  With the next patches, in fact, the values will
not be zero anymore!

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 trailer.c | 65 ++++++++++++++++++++++++++++++++-------------------------------
 trailer.h | 22 +++++++++++++++++++++
 2 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/trailer.c b/trailer.c
index 751b56c00..f02895373 100644
--- a/trailer.c
+++ b/trailer.c
@@ -10,18 +10,13 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
 
-enum action_where { WHERE_END, WHERE_AFTER, WHERE_BEFORE, WHERE_START };
-enum action_if_exists { EXISTS_ADD_IF_DIFFERENT_NEIGHBOR, EXISTS_ADD_IF_DIFFERENT,
-			EXISTS_ADD, EXISTS_REPLACE, EXISTS_DO_NOTHING };
-enum action_if_missing { MISSING_ADD, MISSING_DO_NOTHING };
-
 struct conf_info {
 	char *name;
 	char *key;
 	char *command;
-	enum action_where where;
-	enum action_if_exists if_exists;
-	enum action_if_missing if_missing;
+	enum trailer_where where;
+	enum trailer_if_exists if_exists;
+	enum trailer_if_missing if_missing;
 };
 
 static struct conf_info default_conf_info;
@@ -63,7 +58,7 @@ static const char *git_generated_prefixes[] = {
 		pos != (head); \
 		pos = is_reverse ? pos->prev : pos->next)
 
-static int after_or_end(enum action_where where)
+static int after_or_end(enum trailer_where where)
 {
 	return (where == WHERE_AFTER) || (where == WHERE_END);
 }
@@ -201,7 +196,7 @@ static int check_if_different(struct trailer_item *in_tok,
 			      int check_all,
 			      struct list_head *head)
 {
-	enum action_where where = arg_tok->conf.where;
+	enum trailer_where where = arg_tok->conf.where;
 	struct list_head *next_head;
 	do {
 		if (same_trailer(in_tok, arg_tok))
@@ -306,7 +301,7 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 static void apply_arg_if_missing(struct list_head *head,
 				 struct arg_item *arg_tok)
 {
-	enum action_where where;
+	enum trailer_where where;
 	struct trailer_item *to_add;
 
 	switch (arg_tok->conf.if_missing) {
@@ -331,7 +326,7 @@ static int find_same_and_apply_arg(struct list_head *head,
 	struct trailer_item *in_tok;
 	struct trailer_item *on_tok;
 
-	enum action_where where = arg_tok->conf.where;
+	enum trailer_where where = arg_tok->conf.where;
 	int middle = (where == WHERE_AFTER) || (where == WHERE_BEFORE);
 	int backwards = after_or_end(where);
 	struct trailer_item *start_tok;
@@ -373,44 +368,44 @@ static void process_trailers_lists(struct list_head *head,
 	}
 }
 
-static int set_where(struct conf_info *item, const char *value)
+int trailer_set_where(enum trailer_where *item, const char *value)
 {
 	if (!strcasecmp("after", value))
-		item->where = WHERE_AFTER;
+		*item = WHERE_AFTER;
 	else if (!strcasecmp("before", value))
-		item->where = WHERE_BEFORE;
+		*item = WHERE_BEFORE;
 	else if (!strcasecmp("end", value))
-		item->where = WHERE_END;
+		*item = WHERE_END;
 	else if (!strcasecmp("start", value))
-		item->where = WHERE_START;
+		*item = WHERE_START;
 	else
 		return -1;
 	return 0;
 }
 
-static int set_if_exists(struct conf_info *item, const char *value)
+int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
 {
 	if (!strcasecmp("addIfDifferent", value))
-		item->if_exists = EXISTS_ADD_IF_DIFFERENT;
+		*item = EXISTS_ADD_IF_DIFFERENT;
 	else if (!strcasecmp("addIfDifferentNeighbor", value))
-		item->if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
+		*item = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
 	else if (!strcasecmp("add", value))
-		item->if_exists = EXISTS_ADD;
+		*item = EXISTS_ADD;
 	else if (!strcasecmp("replace", value))
-		item->if_exists = EXISTS_REPLACE;
+		*item = EXISTS_REPLACE;
 	else if (!strcasecmp("doNothing", value))
-		item->if_exists = EXISTS_DO_NOTHING;
+		*item = EXISTS_DO_NOTHING;
 	else
 		return -1;
 	return 0;
 }
 
-static int set_if_missing(struct conf_info *item, const char *value)
+int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
 {
 	if (!strcasecmp("doNothing", value))
-		item->if_missing = MISSING_DO_NOTHING;
+		*item = MISSING_DO_NOTHING;
 	else if (!strcasecmp("add", value))
-		item->if_missing = MISSING_ADD;
+		*item = MISSING_ADD;
 	else
 		return -1;
 	return 0;
@@ -470,15 +465,18 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
 	variable_name = strrchr(trailer_item, '.');
 	if (!variable_name) {
 		if (!strcmp(trailer_item, "where")) {
-			if (set_where(&default_conf_info, value) < 0)
+			if (trailer_set_where(&default_conf_info.where,
+					      value) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "ifexists")) {
-			if (set_if_exists(&default_conf_info, value) < 0)
+			if (trailer_set_if_exists(&default_conf_info.if_exists,
+						  value) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "ifmissing")) {
-			if (set_if_missing(&default_conf_info, value) < 0)
+			if (trailer_set_if_missing(&default_conf_info.if_missing,
+						   value) < 0)
 				warning(_("unknown value '%s' for key '%s'"),
 					value, conf_key);
 		} else if (!strcmp(trailer_item, "separators")) {
@@ -532,15 +530,15 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 		conf->command = xstrdup(value);
 		break;
 	case TRAILER_WHERE:
-		if (set_where(conf, value))
+		if (trailer_set_where(&conf->where, value))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	case TRAILER_IF_EXISTS:
-		if (set_if_exists(conf, value))
+		if (trailer_set_if_exists(&conf->if_exists, value))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	case TRAILER_IF_MISSING:
-		if (set_if_missing(conf, value))
+		if (trailer_set_if_missing(&conf->if_missing, value))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	default:
@@ -555,6 +553,9 @@ static void ensure_configured(void)
 		return;
 
 	/* Default config must be setup first */
+	default_conf_info.where = WHERE_END;
+	default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
+	default_conf_info.if_missing = MISSING_ADD;
 	git_config(git_trailer_default_config, NULL);
 	git_config(git_trailer_config, NULL);
 	configured = 1;
diff --git a/trailer.h b/trailer.h
index 65cc5d79c..2b39a1bee 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,6 +1,28 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
+enum trailer_where {
+	WHERE_END,
+	WHERE_AFTER,
+	WHERE_BEFORE,
+	WHERE_START
+};
+enum trailer_if_exists {
+	EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
+	EXISTS_ADD_IF_DIFFERENT,
+	EXISTS_ADD,
+	EXISTS_REPLACE,
+	EXISTS_DO_NOTHING
+};
+enum trailer_if_missing {
+	MISSING_ADD,
+	MISSING_DO_NOTHING
+};
+
+int trailer_set_where(enum trailer_where *item, const char *value);
+int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
+int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
+
 struct trailer_info {
 	/*
 	 * True if there is a blank line before the location pointed to by
-- 
2.13.3

