Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8011B20229
	for <e@80x24.org>; Fri, 21 Oct 2016 17:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756038AbcJURzU (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:55:20 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33882 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755961AbcJURzR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:55:17 -0400
Received: by mail-pf0-f181.google.com with SMTP id r16so60488937pfg.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gGParwnowF+M845oA+KspuiCmx7pa/S3sOXs1AeTA+4=;
        b=cxunxgEQ+d15N0LVN0019Mm02PNBr4w/4/LrTM79iv3syLOYXaC3vqWzOFX4KeAgiT
         ll3pntwuX9gOWG8pV6shvQeFqh1IHmP+mCxRSFI7qTP4GztKjla+6bac/pPn/RYVbUdl
         KtwLdNGGXgGSbmoxhIdjh6ESd7bTo7dNwaFwFLirlBbFpC3YoX70yQmDhEWAT6n0eTXM
         W0X+Ri2+33WG/3MLTHpgjoFSCNTfoTBEJMYVLM8qlcsT8rOuUPI5esuwliEH3nuE+UK9
         oitUS/Bo9dxm4x3H4f0WR2BM6gTaMuDW0XGPwVLN/a/CWkFK1adVXsigOGv/I1edv+uE
         cBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gGParwnowF+M845oA+KspuiCmx7pa/S3sOXs1AeTA+4=;
        b=SBiQSK7MbRbuRDXswXqsm7WpRNsaqGIsVD38RWe/1imdHRAOXBsabusc7vOm+33sSB
         YRK7iTugeZYzExnxdZsNyP8qkeU/kCCKSDmHCGOEl62G27wEkfguSn1ei7TDf0zVYJw1
         GcYcf9YThzP5uxwQD3AQI29mLTkCTWzrsvKTVDymDDOcEfHA6CpbdLbynMAaO9w/41IA
         JeghGGZcX3C3mdfRVFiiUR8JvJqUEq3MSmH4r19ACXRWhrsBN/RDkJMrYPQegyO3uzkU
         dEPyJ4Ga5D9gVGomM7GiaizzLjK3u6H8mLRsEZLCbkA7D6mZ1tsXyNvwosWQGd8pyOvI
         JHVQ==
X-Gm-Message-State: ABUngvdjPYFIRl/YRox7saGK9UlXv216sOfk37ql00R3zZ8IuS2O4oUINGa+v+lww6x9xS7/
X-Received: by 10.98.81.199 with SMTP id f190mr3774886pfb.36.1477072516295;
        Fri, 21 Oct 2016 10:55:16 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id c75sm6714020pfb.23.2016.10.21.10.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 10:55:15 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 5/8] trailer: clarify failure modes in parse_trailer
Date:   Fri, 21 Oct 2016 10:55:00 -0700
Message-Id: <a2bd43b8b0c5846455afb59be713218f774410e9.1477072247.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1477072247.git.jonathantanmy@google.com>
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1477072247.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parse_trailer function has a few modes of operation, all depending
on whether the separator is present in its input, and if yes, the
separator's position. Some of these modes are failure modes, and these
failure modes are handled differently depending on whether the trailer
line was sourced from a file or from a command-line argument.

Extract a function to find the separator, allowing the invokers of
parse_trailer to determine how to handle the failure modes instead of
making parse_trailer do it. In this function, also take in the list of
separators, so that we can distinguish between command line arguments
(which allow '=' as separator) and file input (which does not allow '='
as separator).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 75 ++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/trailer.c b/trailer.c
index 99018f8..aff858b 100644
--- a/trailer.c
+++ b/trailer.c
@@ -543,29 +543,37 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
 	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
 }
 
-static int parse_trailer(struct strbuf *tok, struct strbuf *val,
-			 const struct conf_info **conf, const char *trailer)
+/*
+ * Return the location of the first separator in line, or -1 if there is no
+ * separator.
+ */
+static int find_separator(const char *line, const char *separators)
+{
+	int loc = strcspn(line, separators);
+	if (!line[loc])
+		return -1;
+	return loc;
+}
+
+/*
+ * Obtain the token, value, and conf from the given trailer.
+ *
+ * separator_pos must not be 0, since the token cannot be an empty string.
+ *
+ * If separator_pos is -1, interpret the whole trailer as a token.
+ */
+static void parse_trailer(struct strbuf *tok, struct strbuf *val,
+			 const struct conf_info **conf, const char *trailer,
+			 int separator_pos)
 {
-	size_t len;
-	struct strbuf seps = STRBUF_INIT;
 	struct arg_item *item;
 	int tok_len;
 	struct list_head *pos;
 
-	strbuf_addstr(&seps, separators);
-	strbuf_addch(&seps, '=');
-	len = strcspn(trailer, seps.buf);
-	strbuf_release(&seps);
-	if (len == 0) {
-		int l = strlen(trailer);
-		while (l > 0 && isspace(trailer[l - 1]))
-			l--;
-		return error(_("empty trailer token in trailer '%.*s'"), l, trailer);
-	}
-	if (len < strlen(trailer)) {
-		strbuf_add(tok, trailer, len);
+	if (separator_pos != -1) {
+		strbuf_add(tok, trailer, separator_pos);
 		strbuf_trim(tok);
-		strbuf_addstr(val, trailer + len + 1);
+		strbuf_addstr(val, trailer + separator_pos + 1);
 		strbuf_trim(val);
 	} else {
 		strbuf_addstr(tok, trailer);
@@ -587,8 +595,6 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 			break;
 		}
 	}
-
-	return 0;
 }
 
 static void add_trailer_item(struct list_head *head, char *tok, char *val)
@@ -619,6 +625,12 @@ static void process_command_line_args(struct list_head *arg_head,
 	const struct conf_info *conf;
 	struct list_head *pos;
 
+	/*
+	 * In command-line arguments, '=' is accepted (in addition to the
+	 * separators that are defined).
+	 */
+	char *cl_separators = xstrfmt("=%s", separators);
+
 	/* Add an arg item for each configured trailer with a command */
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
@@ -631,12 +643,25 @@ static void process_command_line_args(struct list_head *arg_head,
 
 	/* Add an arg item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
-		if (!parse_trailer(&tok, &val, &conf, tr->string))
+		int separator_pos = find_separator(tr->string, cl_separators);
+		if (separator_pos == 0) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addstr(&sb, tr->string);
+			strbuf_trim(&sb);
+			error(_("empty trailer token in trailer '%.*s'"),
+			      (int) sb.len, sb.buf);
+			strbuf_release(&sb);
+		} else {
+			parse_trailer(&tok, &val, &conf, tr->string,
+				      separator_pos);
 			add_arg_item(arg_head,
 				     strbuf_detach(&tok, NULL),
 				     strbuf_detach(&val, NULL),
 				     conf);
+		}
 	}
+
+	free(cl_separators);
 }
 
 static struct strbuf **read_input_file(const char *file)
@@ -775,11 +800,17 @@ static int process_input_file(FILE *outfile,
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
-		if (lines[i]->buf[0] != comment_line_char &&
-		    !parse_trailer(&tok, &val, NULL, lines[i]->buf))
+		int separator_pos;
+		if (lines[i]->buf[0] == comment_line_char)
+			continue;
+		separator_pos = find_separator(lines[i]->buf, separators);
+		if (separator_pos >= 1) {
+			parse_trailer(&tok, &val, NULL, lines[i]->buf,
+				      separator_pos);
 			add_trailer_item(head,
 					 strbuf_detach(&tok, NULL),
 					 strbuf_detach(&val, NULL));
+		}
 	}
 
 	return trailer_end;
-- 
2.8.0.rc3.226.g39d4020

