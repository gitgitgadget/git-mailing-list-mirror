Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD7C20229
	for <e@80x24.org>; Fri, 21 Oct 2016 17:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934621AbcJURzr (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:55:47 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33869 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755989AbcJURzO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:55:14 -0400
Received: by mail-pf0-f174.google.com with SMTP id r16so60488272pfg.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Vywvrbc6RhrIRmSnUrYFLoUATmWL8glgMaq0Rmz15n0=;
        b=EscnSuiZ4khp4duON4hBgm+OQZBorS+QIU52g69iW5xLrHxV8dXwtbQDRuJpNRILC9
         MoVlWoUvT6IGoAjudnKsIB6Ahxx/WSrLcY25erLQJRboDnP7OyI9AOd+8+ecx+cceqOa
         Tvndnb3kXfkCUDeLwPUsM5ZgHkLj/Y7yNfc5Vmn8TLHXtBLYqmB/gEX8UImv19jh4/Gb
         BsDtl7JVedjaXTxZOJwsOGoQG2M3m5qBWt6kuJpb8AVeYET+ebD5KxvhJQPOd7ZnZOiW
         PQyGuQJOBlkFoNKzo4D16tnxX3hOXNIj8GHU80/kyGIbIZichfWZ/uDmX4oGQ2XEkl0W
         hBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Vywvrbc6RhrIRmSnUrYFLoUATmWL8glgMaq0Rmz15n0=;
        b=FrPxs33JxGmR6mGjyQJMr5seJk0JysdvjCi+Q7PgVtuR+spZ708BoURFO7yl7CcjeQ
         zMa72yE9+0xPxvGxgJCS/UnUegJpsHJBVG7oqNKNYwwM3Pt8krpA6ptcQkVA0eifJ/ZC
         IJeZgnip2kpZo22/4ih3GZlbNKaboCgJUZPDvmL50o/3IZHIFqtkwNy+AwUb6BNV6i+6
         NsBXIBHMNLlzhAJalEQN/tUkMMMS86fcYSScrvF0G4eGcN+36ubssLs0P52bd82ez15q
         zNroh5MToMKJne3r3oO50f1Jg3ld4hjLcuX1/z/rpkiq4BzvwzpQIA9y0YhvhBRlA3Ic
         B2GQ==
X-Gm-Message-State: ABUngvesypgH7Sb8FkyTfl+PJFGXpsziZdii7dJi2pSyGfiYVohxiSKM21emOzz1bLUs3qFn
X-Received: by 10.99.54.196 with SMTP id d187mr3168783pga.34.1477072512970;
        Fri, 21 Oct 2016 10:55:12 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id c75sm6714020pfb.23.2016.10.21.10.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 10:55:11 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 3/8] trailer: streamline trailer item create and add
Date:   Fri, 21 Oct 2016 10:54:58 -0700
Message-Id: <c821f75f4000fc3e224b23633cce983c33b6d4d6.1477072247.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1477072247.git.jonathantanmy@google.com>
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1477072247.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, creation and addition (to a list) of trailer items are spread
across multiple functions. Streamline this by only having 2 functions:
one to parse the user-supplied string, and one to add the parsed
information to a list.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 130 +++++++++++++++++++++++++++++---------------------------------
 1 file changed, 60 insertions(+), 70 deletions(-)

diff --git a/trailer.c b/trailer.c
index 4e85aae..ae3972a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -500,10 +500,31 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
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
+	struct list_head *pos;
+
 	strbuf_addstr(&seps, separators);
 	strbuf_addch(&seps, '=');
 	len = strcspn(trailer, seps.buf);
@@ -523,74 +544,31 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
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
-	struct list_head *pos;
-
-	if (parse_trailer(&tok, &val, string))
-		return NULL;
-
-	tok_len = token_len_without_separator(tok.buf, tok.len);
 
 	/* Lookup if the token matches something in the config */
+	tok_len = token_len_without_separator(tok->buf, tok->len);
+	*conf = &default_conf_info;
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct trailer_item, list);
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
 
-static void add_trailer_item(struct list_head *head, struct trailer_item *new)
+static void add_trailer_item(struct list_head *head, char *tok, char *val,
+			     const struct conf_info *conf)
 {
-	if (!new)
-		return;
+	struct trailer_item *new = xcalloc(sizeof(*new), 1);
+	new->token = tok;
+	new->value = val;
+	duplicate_conf(&new->conf, conf);
 	list_add_tail(&new->list, head);
 }
 
@@ -599,21 +577,28 @@ static void process_command_line_args(struct list_head *arg_head,
 {
 	struct string_list_item *tr;
 	struct trailer_item *item;
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	const struct conf_info *conf;
 	struct list_head *pos;
 
 	/* Add a trailer item for each configured trailer with a command */
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct trailer_item, list);
-		if (item->conf.command) {
-			struct trailer_item *new = new_trailer_item(item, NULL, NULL);
-			add_trailer_item(arg_head, new);
-		}
+		if (item->conf.command)
+			add_trailer_item(arg_head,
+					 xstrdup(token_from_item(item, NULL)),
+					 xstrdup(""),
+					 &item->conf);
 	}
 
 	/* Add a trailer item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
-		struct trailer_item *new = create_trailer_item(tr->string);
-		add_trailer_item(arg_head, new);
+		if (!parse_trailer(&tok, &val, &conf, tr->string))
+			add_trailer_item(arg_head,
+					 strbuf_detach(&tok, NULL),
+					 strbuf_detach(&val, NULL),
+					 conf);
 	}
 }
 
@@ -734,6 +719,9 @@ static int process_input_file(FILE *outfile,
 {
 	int count = 0;
 	int patch_start, trailer_start, trailer_end, i;
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	const struct conf_info *conf;
 
 	/* Get the line count */
 	while (lines[count])
@@ -751,10 +739,12 @@ static int process_input_file(FILE *outfile,
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
-		if (lines[i]->buf[0] != comment_line_char) {
-			struct trailer_item *new = create_trailer_item(lines[i]->buf);
-			add_trailer_item(head, new);
-		}
+		if (lines[i]->buf[0] != comment_line_char &&
+		    !parse_trailer(&tok, &val, &conf, lines[i]->buf))
+			add_trailer_item(head,
+					 strbuf_detach(&tok, NULL),
+					 strbuf_detach(&val, NULL),
+					 conf);
 	}
 
 	return trailer_end;
-- 
2.8.0.rc3.226.g39d4020

