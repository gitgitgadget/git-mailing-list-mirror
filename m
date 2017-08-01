Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050DB20899
	for <e@80x24.org>; Tue,  1 Aug 2017 09:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdHAJDm (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 05:03:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35885 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdHAJDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 05:03:39 -0400
Received: by mail-wr0-f194.google.com with SMTP id y67so828712wrb.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T4KlfUegXjtkIJ/H6uPU73dZGg3Vfl7g1RZYRue2DZo=;
        b=SRs2dVwjq5M7zDkKlS70Ohjdp56CXMW3wwr5Mrbg4FejnVwbIYkwkj2Hbgk4LeO89U
         k2gWZAkazdwnnwu0yy8rGF1pn/l3rw3Xpp/EVkSFz9B5svlDEJWXjTKUUQYFumWmoLmh
         MiCgpPxTDMcZXYvsoAT7EgHwYfhL+BKfn1YbV1an3yBQn4lkiW0oL/z9CuujFV9MkiLA
         qhaAqIqy9ZeqsXLawY6fM3YhzMgFORAYxkg4X3bHqCJFDCrHh36EdetCMH2o8Oqiq0t7
         ni6gURvIYvxBoiTDjHej8x4Qvul7ki5ouV9GpJ8WPI38zeRAKNkAAwOqgptMqcrFyOjN
         5ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=T4KlfUegXjtkIJ/H6uPU73dZGg3Vfl7g1RZYRue2DZo=;
        b=GQ6pgZqtMkqlX4COnrryRaxpNDHj3yOtMwIcR+SkUqF6HTPlRDmcz8jEFhAmTT4zBE
         8OJ2Sbk8OtdtHnQQ772r3rGjyceVffLutlPnAMPd4KpeV6Q+jNIyBjX21xsCbEdW9Yb6
         UuZOA5H8+Hj6BMOzKSJY4GnPGOiduOEkM+DPhR3YRiBwg3pPATsbsGe5kIVHEuTPqZw0
         QlrAHfrYwZJMiiUJ3tDjxV9NAzNJkALjeWDWMUpIezSBcxLVjD12mzxxFTAPi14Nkpwn
         30evoGInbJ9/TPWAeOrPt8qyH8fdOKUhOaKZ59cGt+Ds1ct1DPDLLyMNecZDJxPKxjU0
         7HIQ==
X-Gm-Message-State: AIVw110bccuuCNL2derNddaNvmyCg2C0NoWAu4GiC/qQ3JJWVLSi/MJ9
        wLYD/X9YgMwHxgEgq3A=
X-Received: by 10.223.153.70 with SMTP id x64mr13386304wrb.18.1501578217790;
        Tue, 01 Aug 2017 02:03:37 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-192-75.adsl-ull.clienti.tiscali.it. [94.39.192.75])
        by smtp.gmail.com with ESMTPSA id 91sm29947237wrg.83.2017.08.01.02.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Aug 2017 02:03:37 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 1/4] trailers: export action enums and corresponding lookup functions
Date:   Tue,  1 Aug 2017 11:03:30 +0200
Message-Id: <20170801090333.32642-2-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170801090333.32642-1-bonzini@gnu.org>
References: <20170801090333.32642-1-bonzini@gnu.org>
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


