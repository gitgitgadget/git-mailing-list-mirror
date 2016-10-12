Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AEBB1F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 01:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbcJLBbz (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 21:31:55 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36280 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbcJLBbx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 21:31:53 -0400
Received: by mail-pa0-f41.google.com with SMTP id ry6so23020287pac.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 18:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eC0BhWhlwilo/Ow2U17yZk5IAObCQ2Ts3QSFINpqT74=;
        b=I22uR6OCIHCfsII6S2zYsZ/KDtR0qRsxxZUQ4d7/QbReHOp0y+eA5+3HPp86BfLeVL
         uB793pZ8OLn/CUZ4nm6Xp1Wj+9/6HP+x+suO1OJDkLaR/cPEiEL8sfa75T5R17cfyg4G
         KULWndecYcECIwzaDKqtQK9aKPX+el5xsVV7VO7qrs7s4h92spCp+aaDZ2IC32CPyWOW
         sIMsh6G/kHBU8I5guiAnVTCBZd3FSUYtNO1MZJNTKluLUewy40AtfMvWlD/CTXMZjpxQ
         r8tHNxZJgNZh72Lzz8hpZaS9pue4KKRU6mZG3cyZv80Zjx7djJH/8Fi7Oc2gVjT0YMyM
         PpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eC0BhWhlwilo/Ow2U17yZk5IAObCQ2Ts3QSFINpqT74=;
        b=G8FoNaE6V6vRzL68Ya2FXwSgtOR2+2zMb076OoM83al6C/r1rP+mCQ9KRCtZboi6Hg
         nupzsMbcx2CsLa0mxAeex+9lisYXvZyVEfJXoo5vZdNzUYEZugU+rUH9CAD3yEvV7+hP
         ZHerqaM5AFPBN5w/txyesLjBmQWTI4dr0IKKkQHI1lUSrixn6EICe6mPpFxXg3xMwNAX
         fQqGoLmwW15Rodx97M+MQB4dMqFTDgcdsg7HZzA63ALsZRg3ou1/hny3/QvCfLKe4sB4
         6vKvsmFq6twYBXGcAcszN9k2WzFmTwSWFRkkS7/hEviowP96ifNAnitxjqiCSLfqGbj+
         v/kA==
X-Gm-Message-State: AA6/9RnEVnbd//MlZeZRSneEYHzkVlYfPkMi92ULaRCT6WOftI2GW0tifriqLylm4e7tRqB3
X-Received: by 10.66.248.229 with SMTP id yp5mr11164534pac.31.1476235417068;
        Tue, 11 Oct 2016 18:23:37 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b11sm7175042pfb.49.2016.10.11.18.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 18:23:35 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, gitster@pobox.com
Subject: [PATCH 2/5] trailer: streamline trailer item create and add
Date:   Tue, 11 Oct 2016 18:23:26 -0700
Message-Id: <99b6b334e61ac12e93cdc76a8c60e87d7d1c39cc.1476232683.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, creation and addition (to a list) of trailer items are spread
across multiple functions. Streamline this by only having 2 functions:
one to parse the user-supplied string, and one to add the parsed
information to a list.
---
 trailer.c | 135 +++++++++++++++++++++++++++++---------------------------------
 1 file changed, 62 insertions(+), 73 deletions(-)

diff --git a/trailer.c b/trailer.c
index bf3d7d0..e8b1bfb 100644
--- a/trailer.c
+++ b/trailer.c
@@ -335,7 +335,7 @@ static int set_if_missing(struct conf_info *item, const char *value)
 	return 0;
 }
 
-static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
+static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 {
 	*dst = *src;
 	if (src->name)
@@ -467,10 +467,30 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	return 0;
 }
 
-static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
+static const char *token_from_item(struct trailer_item *item, char *tok)
+{
+	if (item->conf.key)
+		return item->conf.key;
+	if (tok)
+		return tok;
+	return item->conf.name;
+}
+
+static int token_matches_item(const char *tok, struct trailer_item *item, int tok_len)
+{
+	if (!strncasecmp(tok, item->conf.name, tok_len))
+		return 1;
+	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
+}
+
+static int parse_trailer(struct strbuf *tok, struct strbuf *val,
+			 const struct conf_info **conf, const char *trailer)
 {
 	size_t len;
 	struct strbuf seps = STRBUF_INIT;
+	struct trailer_item *item;
+	int tok_len;
+
 	strbuf_addstr(&seps, separators);
 	strbuf_addch(&seps, '=');
 	len = strcspn(trailer, seps.buf);
@@ -490,73 +510,31 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
 		strbuf_addstr(tok, trailer);
 		strbuf_trim(tok);
 	}
-	return 0;
-}
-
-static const char *token_from_item(struct trailer_item *item, char *tok)
-{
-	if (item->conf.key)
-		return item->conf.key;
-	if (tok)
-		return tok;
-	return item->conf.name;
-}
-
-static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
-					     char *tok, char *val)
-{
-	struct trailer_item *new = xcalloc(sizeof(*new), 1);
-	new->value = val ? val : xstrdup("");
-
-	if (conf_item) {
-		duplicate_conf(&new->conf, &conf_item->conf);
-		new->token = xstrdup(token_from_item(conf_item, tok));
-		free(tok);
-	} else {
-		duplicate_conf(&new->conf, &default_conf_info);
-		new->token = tok;
-	}
-
-	return new;
-}
-
-static int token_matches_item(const char *tok, struct trailer_item *item, int tok_len)
-{
-	if (!strncasecmp(tok, item->conf.name, tok_len))
-		return 1;
-	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
-}
-
-static struct trailer_item *create_trailer_item(const char *string)
-{
-	struct strbuf tok = STRBUF_INIT;
-	struct strbuf val = STRBUF_INIT;
-	struct trailer_item *item;
-	int tok_len;
-
-	if (parse_trailer(&tok, &val, string))
-		return NULL;
-
-	tok_len = token_len_without_separator(tok.buf, tok.len);
 
 	/* Lookup if the token matches something in the config */
+	tok_len = token_len_without_separator(tok->buf, tok->len);
+	*conf = &default_conf_info;
 	for (item = first_conf_item; item; item = item->next) {
-		if (token_matches_item(tok.buf, item, tok_len))
-			return new_trailer_item(item,
-						strbuf_detach(&tok, NULL),
-						strbuf_detach(&val, NULL));
+		if (token_matches_item(tok->buf, item, tok_len)) {
+			char *tok_buf = strbuf_detach(tok, NULL);
+			*conf = &item->conf;
+			strbuf_addstr(tok, token_from_item(item, tok_buf));
+			free(tok_buf);
+			break;
+		}
 	}
 
-	return new_trailer_item(NULL,
-				strbuf_detach(&tok, NULL),
-				strbuf_detach(&val, NULL));
+	return 0;
 }
 
-static void add_trailer_item(struct trailer_item ***tail,
-			     struct trailer_item *new)
+static void add_trailer_item(struct trailer_item ***tail, char *tok, char *val,
+			     const struct conf_info *conf)
 {
-	if (!new)
-		return;
+	struct trailer_item *new = xcalloc(sizeof(*new), 1);
+	new->token = tok;
+	new->value = val;
+	duplicate_conf(&new->conf, conf);
+
 	**tail = new;
 	*tail = &new->next;
 }
@@ -567,19 +545,25 @@ static struct trailer_item *process_command_line_args(struct string_list *traile
 	struct trailer_item **arg_tok_tail = &arg_tok_head;
 	struct string_list_item *tr;
 	struct trailer_item *item;
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	const struct conf_info *conf;
 
 	/* Add a trailer item for each configured trailer with a command */
-	for (item = first_conf_item; item; item = item->next) {
-		if (item->conf.command) {
-			struct trailer_item *new = new_trailer_item(item, NULL, NULL);
-			add_trailer_item(&arg_tok_tail, new);
-		}
-	}
+	for (item = first_conf_item; item; item = item->next)
+		if (item->conf.command)
+			add_trailer_item(&arg_tok_tail,
+					 xstrdup(token_from_item(item, NULL)),
+					 xstrdup(""),
+					 &item->conf);
 
 	/* Add a trailer item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
-		struct trailer_item *new = create_trailer_item(tr->string);
-		add_trailer_item(&arg_tok_tail, new);
+		if (!parse_trailer(&tok, &val, &conf, tr->string))
+			add_trailer_item(&arg_tok_tail,
+					 strbuf_detach(&tok, NULL),
+					 strbuf_detach(&val, NULL),
+					 conf);
 	}
 
 	return arg_tok_head;
@@ -702,6 +686,9 @@ static int process_input_file(FILE *outfile,
 {
 	int count = 0;
 	int patch_start, trailer_start, trailer_end, i;
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	const struct conf_info *conf;
 
 	/* Get the line count */
 	while (lines[count])
@@ -719,10 +706,12 @@ static int process_input_file(FILE *outfile,
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
-		if (lines[i]->buf[0] != comment_line_char) {
-			struct trailer_item *new = create_trailer_item(lines[i]->buf);
-			add_trailer_item(in_tok_tail, new);
-		}
+		if (lines[i]->buf[0] != comment_line_char &&
+		    !parse_trailer(&tok, &val, &conf, lines[i]->buf))
+			add_trailer_item(in_tok_tail,
+					 strbuf_detach(&tok, NULL),
+					 strbuf_detach(&val, NULL),
+					 conf);
 	}
 
 	return trailer_end;
-- 
2.8.0.rc3.226.g39d4020

