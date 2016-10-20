Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F741F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbcJTVkW (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:40:22 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34083 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755434AbcJTVkK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:10 -0400
Received: by mail-pf0-f176.google.com with SMTP id r16so43659316pfg.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zwvsvZYzZNzRz1Xg0EeFj1ke5BBgetfox7v2URRj8vg=;
        b=ifE9VGLfc5bafSam+I7+4n6R7P152YDgPHpOm/YOX+TqOIDbW05/z6PPtSZqLO7A5a
         ptqvo/hoZOE+9N2gylA5Hfk6pgvP3ISVWk46I98MY4aLsTKzGljxIc7AgCzIQafx03uB
         qZaMlb1dxmKhQCvvIb4VveVKONzrmB29FNFx6iz+VnQgCP7hMu2lrJ2ItMFMqB7LbZSY
         uggL85VxzpxQzybi7JnjxZfB6A39fcYold6LNU5R03gaG4RoaUP/sDSocie2BW9m7tK4
         RI54vkRv/mkbqL76qenMqqRSl5gk30vDPxmksPLvjoypmcu2sLQ7eGJ7xtszxNzO1y8D
         ekcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zwvsvZYzZNzRz1Xg0EeFj1ke5BBgetfox7v2URRj8vg=;
        b=I7D0bQ5OfP/mocB8AlEQArliSdBQlL+XxZSDcXSfWOODdF/D93OSiG3IieR8xTnbsq
         75yWJ6VS0PIGTu8GRUog8m6hT7PqUUKFRIh2SBoIThCyBSdvKztPpOMjKUEQt7Ppp9zJ
         dyFa/8w1giPx25oJzkQ4eBcGaw9imBVx/h5xcMa+Etb/YKgmrXFxiQwfbo/WI1JI3RIx
         TNsokmZFXTpIhL6kXSEEkK1KtqzO1WtK1nH4iigw/eSwMS5CrnEYawfolk+4KdFo//rA
         X8cCsBN+IM8bndjsNoQz+uyCItQvHR+oaO4TItAXspUBlE2WwPmoHRnXNk4SM24sMf0N
         zmsQ==
X-Gm-Message-State: AA6/9RlQKTGOdCbaz1T+1ogNOEzYhRlw94E/5FJ6NlwyDgxBL+lyy7DHp+DbhReCHD/A3ubG
X-Received: by 10.98.29.131 with SMTP id d125mr4981942pfd.111.1476999608562;
        Thu, 20 Oct 2016 14:40:08 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e6sm73883890pfb.57.2016.10.20.14.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 14:40:08 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
Date:   Thu, 20 Oct 2016 14:39:50 -0700
Message-Id: <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476998988.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476998988.git.jonathantanmy@google.com>
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
making parse_trailer do it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 70 +++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/trailer.c b/trailer.c
index 99018f8..137a3fb 100644
--- a/trailer.c
+++ b/trailer.c
@@ -543,29 +543,40 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
 	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
 }
 
-static int parse_trailer(struct strbuf *tok, struct strbuf *val,
-			 const struct conf_info **conf, const char *trailer)
+/*
+ * Return the location of the first separator or '=' in line, or -1 if either a
+ * newline or the null terminator is reached first.
+ */
+static int find_separator(const char *line)
+{
+	const char *c;
+	for (c = line; ; c++) {
+		if (!*c || *c == '\n')
+			return -1;
+		if (*c == '=' || strchr(separators, *c))
+			return c - line;
+	}
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
@@ -587,8 +598,6 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 			break;
 		}
 	}
-
-	return 0;
 }
 
 static void add_trailer_item(struct list_head *head, char *tok, char *val)
@@ -631,11 +640,22 @@ static void process_command_line_args(struct list_head *arg_head,
 
 	/* Add an arg item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
-		if (!parse_trailer(&tok, &val, &conf, tr->string))
+		int separator_pos = find_separator(tr->string);
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
 }
 
@@ -775,11 +795,17 @@ static int process_input_file(FILE *outfile,
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
-		if (lines[i]->buf[0] != comment_line_char &&
-		    !parse_trailer(&tok, &val, NULL, lines[i]->buf))
+		int separator_pos;
+		if (lines[i]->buf[0] == comment_line_char)
+			continue;
+		separator_pos = find_separator(lines[i]->buf);
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

