Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5338209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754942AbcJNRiV (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:38:21 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35944 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753920AbcJNRiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:38:16 -0400
Received: by mail-pa0-f42.google.com with SMTP id ry6so48751269pac.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4qzqqRctjtC8Oi8sxce+HiwsLYL+vl5sDJq/EAPQqS0=;
        b=QzbLDlkL/kdxOXlRG2B29JXHpE4JpzRXZFoo62bzH6I5AgQ3/3LtU5MrVnTAJ2XOnI
         pKw1kECl0F+/uA15YYB1+XSD/M9nhrHANm/ISVvRHmV9RE5Rsje3hX6NciOPOMeweyqr
         XIYPGKlb62XKTI+zZ/RhY+FYvSqLUp36Qaq4K9buQ35N/J/bPF0Pi8eWBDYSBqPmBfk0
         xo99v4DErf/6NZ0F/6QDRf5e2G/CNAwN+UlUaDZv4J+GY5mH6S4arf3pjOPZ2Dkbr8Qe
         9KUp9snxDjIwkVCwnGogjq4jS8rVr3aBJFd4v28+IlmkZBsLOo+etUDa0WFEpMC+N2zj
         VgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4qzqqRctjtC8Oi8sxce+HiwsLYL+vl5sDJq/EAPQqS0=;
        b=GVJ6ttHp33XWD+Gs7awLzXmy4Fm1cYRR8qMVoZmb2JWFO3HSNWmaNp5xy/yxSEVDbK
         o5IlfQtAiLGfP/okxER6CoqjOW8MFh9gbIFM8pmpc0osrVUAHj5LNDG3q6sRwU6dNHwz
         y2lIYmUXXlAOobyqN5RZUr7KX2lzGofd6/V5pXkITWKoTiolqwXFXz1NIfavuo7KHqCE
         /J5F/kQdruxvJSiXUjsYz4FT5U9udisEC5giRdCdW1cTLRxV182gCvhgwjOnqRza+zv/
         8Q5USwz4g1CNUMXOwxufWvvWB8EklZomqCeFXyU53uMJ8A8Eh70XAtN7d3FDXqh4YNmo
         cs1Q==
X-Gm-Message-State: AA6/9RmzZ3wfS1UZj3AKsKHrOMameTq4CsElMEanEtwVcCRfaT2xud/IpngIw1kiC9rtkxeM
X-Received: by 10.67.23.201 with SMTP id ic9mr16422830pad.143.1476466694997;
        Fri, 14 Oct 2016 10:38:14 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b88sm28955706pfe.72.2016.10.14.10.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Oct 2016 10:38:13 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jnareb@gmail.com
Subject: [PATCH v3 5/6] trailer: allow non-trailers in trailer block
Date:   Fri, 14 Oct 2016 10:38:02 -0700
Message-Id: <1b3fe84e4b6126884a801e721d0a93c41fcb4184.1476466609.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476466609.git.jonathantanmy@google.com>
References: <cover.1476466609.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476466609.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476466609.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, interpret-trailers requires all lines of a trailer block to
be trailers (or comments) - if not it would not identify that block as a
trailer block, and thus create its own trailer block, inserting a blank
line.  For example:

  echo -e "\na: b\nnot trailer" |
  git interpret-trailers --trailer "c: d"

would result in:

  a: b
  not trailer

  c: d

Relax the definition of a trailer block to only require 1 trailer, so
that trailers can be directly added to such blocks, resulting in:

  a: b
  not trailer
  c: d

This allows arbitrary lines to be included in trailer blocks, like those
in [1], and still allow interpret-trailers to be used.

This change also makes comments in the trailer block be treated as any
other non-trailer line, preserving them in the output of
interpret-trailers.

[1]
https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable/+/e7d316a02f683864a12389f8808570e37fb90aa3

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-interpret-trailers.txt |  3 +-
 t/t7513-interpret-trailers.sh            | 35 +++++++++++++++
 trailer.c                                | 77 ++++++++++++++++++++++----------
 3 files changed, 90 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 93d1db6..c480da6 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -48,7 +48,8 @@ with only spaces at the end of the commit message part, one blank line
 will be added before the new trailer.
 
 Existing trailers are extracted from the input message by looking for
-a group of one or more lines that contain a colon (by default), where
+a group of one or more lines in which at least one line contains a 
+colon (by default), where
 the group is preceded by one or more empty (or whitespace-only) lines.
 The group must either be at the end of the message or be the last
 non-whitespace lines before a line that starts with '---'. Such three
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index aee785c..7f5cd2a 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -126,6 +126,37 @@ test_expect_success 'with multiline title in the message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with non-trailer lines mixed with trailer lines' '
+	cat >patch <<-\EOF &&
+
+		this: is a trailer
+		this is not a trailer
+	EOF
+	cat >expected <<-\EOF &&
+
+		this: is a trailer
+		this is not a trailer
+		token: value
+	EOF
+	git interpret-trailers --trailer "token: value" patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with non-trailer lines only' '
+	cat >patch <<-\EOF &&
+
+		this is not a trailer
+	EOF
+	cat >expected <<-\EOF &&
+
+		this is not a trailer
+
+		token: value
+	EOF
+	git interpret-trailers --trailer "token: value" patch >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with config setup' '
 	git config trailer.ack.key "Acked-by: " &&
 	cat >expected <<-\EOF &&
@@ -257,6 +288,8 @@ test_expect_success 'with message that has comments' '
 	cat >>expected <<-\EOF &&
 		# comment
 
+		# other comment
+		# yet another comment
 		Reviewed-by: Johan
 		Cc: Peff
 		# last comment
@@ -286,6 +319,8 @@ test_expect_success 'with message that has an old style conflict block' '
 	cat >>expected <<-\EOF &&
 		# comment
 
+		# other comment
+		# yet another comment
 		Reviewed-by: Johan
 		Cc: Peff
 		# last comment
diff --git a/trailer.c b/trailer.c
index a9ed3f8..d6dfc7a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -27,6 +27,10 @@ static struct conf_info default_conf_info;
 
 struct trailer_item {
 	struct list_head list;
+	/*
+	 * If this is not a trailer line, the line is stored in value
+	 * (excluding the terminating newline) and token is NULL.
+	 */
 	char *token;
 	char *value;
 };
@@ -70,9 +74,14 @@ static size_t token_len_without_separator(const char *token, size_t len)
 
 static int same_token(struct trailer_item *a, struct arg_item *b)
 {
-	size_t a_len = token_len_without_separator(a->token, strlen(a->token));
-	size_t b_len = token_len_without_separator(b->token, strlen(b->token));
-	size_t min_len = (a_len > b_len) ? b_len : a_len;
+	size_t a_len, b_len, min_len;
+
+	if (!a->token)
+		return 0;
+
+	a_len = token_len_without_separator(a->token, strlen(a->token));
+	b_len = token_len_without_separator(b->token, strlen(b->token));
+	min_len = (a_len > b_len) ? b_len : a_len;
 
 	return !strncasecmp(a->token, b->token, min_len);
 }
@@ -130,7 +139,14 @@ static char last_non_space_char(const char *s)
 
 static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 {
-	char c = last_non_space_char(tok);
+	char c;
+
+	if (!tok) {
+		fprintf(outfile, "%s\n", val);
+		return;
+	}
+
+	c = last_non_space_char(tok);
 	if (!c)
 		return;
 	if (strchr(separators, c))
@@ -543,8 +559,16 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
 	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
 }
 
+/*
+ * Parse the given trailer into token and value parts.
+ *
+ * If the given trailer does not have a separator (and thus cannot be separated
+ * into token and value parts), it is treated as a token (if parse_as_arg) or
+ * as a non-trailer line (if not parse_as_arg).
+ */
 static int parse_trailer(struct strbuf *tok, struct strbuf *val,
-			 const struct conf_info **conf, const char *trailer)
+			 const struct conf_info **conf, const char *trailer,
+			 int parse_as_arg)
 {
 	size_t len;
 	struct strbuf seps = STRBUF_INIT;
@@ -557,11 +581,18 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 	len = strcspn(trailer, seps.buf);
 	strbuf_release(&seps);
 	if (len == 0) {
-		int l = strlen(trailer);
+		int l;
+		if (!parse_as_arg)
+			return -1;
+
+		l = strlen(trailer);
 		while (l > 0 && isspace(trailer[l - 1]))
 			l--;
 		return error(_("empty trailer token in trailer '%.*s'"), l, trailer);
 	}
+	if (!parse_as_arg && len == strlen(trailer))
+		return -1;
+
 	if (len < strlen(trailer)) {
 		strbuf_add(tok, trailer, len);
 		strbuf_trim(tok);
@@ -631,7 +662,7 @@ static void process_command_line_args(struct list_head *arg_head,
 
 	/* Add an arg item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
-		if (!parse_trailer(&tok, &val, &conf, tr->string))
+		if (!parse_trailer(&tok, &val, &conf, tr->string, 1))
 			add_arg_item(arg_head,
 				     strbuf_detach(&tok, NULL),
 				     strbuf_detach(&val, NULL),
@@ -683,7 +714,7 @@ static int find_patch_start(struct strbuf **lines, int count)
  */
 static int find_trailer_start(struct strbuf **lines, int count)
 {
-	int start, end_of_title, only_spaces = 1;
+	int start, end_of_title, only_spaces = 1, trailer_found = 0;
 
 	/* The first paragraph is the title and cannot be trailers */
 	for (start = 0; start < count; start++) {
@@ -699,22 +730,17 @@ static int find_trailer_start(struct strbuf **lines, int count)
 	 * for a line with only spaces before lines with one separator.
 	 */
 	for (start = count - 1; start >= end_of_title; start--) {
-		if (lines[start]->buf[0] == comment_line_char)
-			continue;
 		if (contains_only_spaces(lines[start]->buf)) {
 			if (only_spaces)
 				continue;
-			return start + 1;
+			return trailer_found ? start + 1 : count;
 		}
-		if (strcspn(lines[start]->buf, separators) < lines[start]->len) {
-			if (only_spaces)
-				only_spaces = 0;
-			continue;
-		}
-		return count;
+		only_spaces = 0;
+		if (strcspn(lines[start]->buf, separators) < lines[start]->len)
+			trailer_found = 1;
 	}
 
-	return only_spaces ? count : 0;
+	return count;
 }
 
 /* Get the index of the end of the trailers */
@@ -735,11 +761,8 @@ static int find_trailer_end(struct strbuf **lines, int patch_start)
 
 static int has_blank_line_before(struct strbuf **lines, int start)
 {
-	for (;start >= 0; start--) {
-		if (lines[start]->buf[0] == comment_line_char)
-			continue;
+	if (start >= 0)
 		return contains_only_spaces(lines[start]->buf);
-	}
 	return 0;
 }
 
@@ -775,11 +798,17 @@ static int process_input_file(FILE *outfile,
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
-		if (lines[i]->buf[0] != comment_line_char &&
-		    !parse_trailer(&tok, &val, NULL, lines[i]->buf))
+		if (!parse_trailer(&tok, &val, NULL, lines[i]->buf, 0))
 			add_trailer_item(head,
 					 strbuf_detach(&tok, NULL),
 					 strbuf_detach(&val, NULL));
+		else {
+			strbuf_addbuf(&val, lines[i]);
+			strbuf_strip_suffix(&val, "\n");
+			add_trailer_item(head,
+					 NULL,
+					 strbuf_detach(&val, NULL));
+		}
 	}
 
 	return trailer_end;
-- 
2.8.0.rc3.226.g39d4020

