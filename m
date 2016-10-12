Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836DF1F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 01:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbcJLB3N (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 21:29:13 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34633 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbcJLB3N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 21:29:13 -0400
Received: by mail-pf0-f173.google.com with SMTP id 190so10798232pfv.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 18:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y9t6vhCtkpBTj7UyzsHtNmw0a9BoqdSNZkog7WVM1cc=;
        b=FNZqnrMBe04+F0nAp3iWFot2yjRPe/63sNvHAqoY/kzmYmYjrr8T/lBcJZxgoKd+De
         P4o4cqSSNjDULjvur4sYIk/HtjkGBbDW9A1rtL8v7muqG5HqrOU3fTSJXSXFBkrNiBVV
         lMeSiNR6Cc4wtmUc19Wj58fVrx4P/NEhmiIz+0aFAsmV24MPAVuGvfh5tZ3gdzStuOdt
         lg+exxMuaZFDECM52lG3cNbLt63e920WELPygtiOm9avevKQGHShtn5ZmFx8o78Sb02I
         rZcD1n1ECG8xslPdZj7fiyIeHyo/Pbsl/FC69boLCW6u38bYDWFQpeaPU02gRji8IOWI
         m2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y9t6vhCtkpBTj7UyzsHtNmw0a9BoqdSNZkog7WVM1cc=;
        b=atlMNmDG2zM2UsBFepZzsPCy7anD0cB4Wh6BieVNVRKftTknfrj6moOqHAyoUbQi/0
         paGB8TWWU+Z9EEA5zL/NtnI9LPCHoeGCG27vfzcRht5ZzDDHK6kUNBsVqLnUvtYcQQ8T
         rWipwSbybNuFEqQKJm23ukm+iQgUxiiNNSnX6Z9f75XEs729cPPUoeuXrEhCv28CT2Qu
         obtNCIzHlsiurwda6/M4SXVTWwZEiGdwVAYlG3sZxU9Kwy9jGcbnvKSWQCj+Pck8WJte
         1u5hsG2JCXnhE58JvWBjtcMCWywWFL7SXolWipjQWFxjq1aj94L9N/ry7ha2Qe/sMI4f
         KOaQ==
X-Gm-Message-State: AA6/9RnRU7NIVdDe++z50Ezz/54avWTlxa//oaqs/6yoQi6I5nFsPUFF9xacpiMJRaCGJRpS
X-Received: by 10.98.141.2 with SMTP id z2mr1288290pfd.3.1476235421227;
        Tue, 11 Oct 2016 18:23:41 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b11sm7175042pfb.49.2016.10.11.18.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 18:23:40 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, gitster@pobox.com
Subject: [PATCH 5/5] trailer: support values folded to multiple lines
Date:   Tue, 11 Oct 2016 18:23:29 -0700
Message-Id: <4b8616732b719ede04b90c87ab240c29b4e3a0bb.1476232683.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, interpret-trailers requires that a trailer be only on 1 line.
For example:

  a: first line
     second line

would be interpreted as one trailer line followed by one non-trailer line.

Make interpret-trailers support RFC 822-style folding, treating those
lines as one logical trailer.
---
 Documentation/git-interpret-trailers.txt |   7 +-
 t/t7513-interpret-trailers.sh            | 139 +++++++++++++++++++++++++++++++
 trailer.c                                |  40 ++++++---
 3 files changed, 170 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index c480da6..cfec636 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -57,11 +57,12 @@ minus signs start the patch part of the message.
 
 When reading trailers, there can be whitespaces before and after the
 token, the separator and the value. There can also be whitespaces
-inside the token and the value.
+inside the token and the value. The value may be split over multiple lines with
+each subsequent line starting with whitespace, like the "folding" in RFC 822.
 
 Note that 'trailers' do not follow and are not intended to follow many
-rules for RFC 822 headers. For example they do not follow the line
-folding rules, the encoding rules and probably many other rules.
+rules for RFC 822 headers. For example they do not follow
+the encoding rules and probably many other rules.
 
 OPTIONS
 -------
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 7f5cd2a..195cdd3 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -157,6 +157,145 @@ test_expect_success 'with non-trailer lines only' '
 	test_cmp expected actual
 '
 
+test_expect_success 'multiline field treated as atomic for placement' '
+	q_to_tab >patch <<-\EOF &&
+
+		another: trailer
+		name: value on
+		Qmultiple lines
+		another: trailer
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		another: trailer
+		name: value on
+		Qmultiple lines
+		name: value
+		another: trailer
+	EOF
+	test_config trailer.name.where after &&
+	git interpret-trailers --trailer "name: value" patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'multiline field treated as atomic for replacement' '
+	q_to_tab >patch <<-\EOF &&
+
+		another: trailer
+		name: value on
+		Qmultiple lines
+		another: trailer
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		another: trailer
+		another: trailer
+		name: value
+	EOF
+	test_config trailer.name.ifexists replace &&
+	git interpret-trailers --trailer "name: value" patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'multiline field treated as atomic for difference check' '
+	q_to_tab >patch <<-\EOF &&
+
+		another: trailer
+		name: first line
+		Qsecond line
+		another: trailer
+	EOF
+	test_config trailer.name.ifexists addIfDifferent &&
+
+	q_to_tab >trailer <<-\EOF &&
+		name: first line
+		Qsecond line
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		another: trailer
+		name: first line
+		Qsecond line
+		another: trailer
+	EOF
+	git interpret-trailers --trailer "$(cat trailer)" patch >actual &&
+	test_cmp expected actual &&
+
+	q_to_tab >trailer <<-\EOF &&
+		name: first line
+		Qsecond line *DIFFERENT*
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		another: trailer
+		name: first line
+		Qsecond line
+		another: trailer
+		name: first line
+		Qsecond line *DIFFERENT*
+	EOF
+	git interpret-trailers --trailer "$(cat trailer)" patch >actual &&
+	test_cmp expected actual &&
+
+	q_to_tab >trailer <<-\EOF &&
+		name: first line *DIFFERENT*
+		Qsecond line
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		another: trailer
+		name: first line
+		Qsecond line
+		another: trailer
+		name: first line *DIFFERENT*
+		Qsecond line
+	EOF
+	git interpret-trailers --trailer "$(cat trailer)" patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'multiline field treated as atomic for neighbor check' '
+	q_to_tab >patch <<-\EOF &&
+
+		another: trailer
+		name: first line
+		Qsecond line
+		another: trailer
+	EOF
+	test_config trailer.name.where after &&
+	test_config trailer.name.ifexists addIfDifferentNeighbor &&
+
+	q_to_tab >trailer <<-\EOF &&
+		name: first line
+		Qsecond line
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		another: trailer
+		name: first line
+		Qsecond line
+		another: trailer
+	EOF
+	git interpret-trailers --trailer "$(cat trailer)" patch >actual &&
+	test_cmp expected actual &&
+
+	q_to_tab >trailer <<-\EOF &&
+		name: first line
+		Qsecond line *DIFFERENT*
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		another: trailer
+		name: first line
+		Qsecond line
+		name: first line
+		Qsecond line *DIFFERENT*
+		another: trailer
+	EOF
+	git interpret-trailers --trailer "$(cat trailer)" patch >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with config setup' '
 	git config trailer.ack.key "Acked-by: " &&
 	cat >expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index 97e96a9..907baa0 100644
--- a/trailer.c
+++ b/trailer.c
@@ -31,7 +31,7 @@ struct trailer_item {
 	 * (excluding the terminating newline) and token is NULL.
 	 */
 	char *token;
-	char *value;
+	struct strbuf value;
 };
 
 struct arg_item {
@@ -81,7 +81,7 @@ static int same_token(const struct trailer_item *a, const struct arg_item *b)
 
 static int same_value(const struct trailer_item *a, const struct arg_item *b)
 {
-	return !strcasecmp(a->value, b->value);
+	return !strcasecmp(a->value.buf, b->value);
 }
 
 static int same_trailer(const struct trailer_item *a, const struct arg_item *b)
@@ -107,7 +107,7 @@ static inline void strbuf_replace(struct strbuf *sb, const char *a, const char *
 static void free_trailer_item(struct trailer_item *item)
 {
 	free(item->token);
-	free(item->value);
+	strbuf_release(&item->value);
 	free(item);
 }
 
@@ -152,8 +152,8 @@ static void print_all(FILE *outfile, struct trailer_item *first, int trim_empty)
 {
 	struct trailer_item *item;
 	for (item = first; item; item = item->next) {
-		if (!trim_empty || strlen(item->value) > 0)
-			print_tok_val(outfile, item->token, item->value);
+		if (!trim_empty || item->value.len > 0)
+			print_tok_val(outfile, item->token, item->value.buf);
 	}
 }
 
@@ -195,8 +195,8 @@ static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
 		if (arg_tok->value && arg_tok->value[0]) {
 			arg = arg_tok->value;
 		} else {
-			if (in_tok && in_tok->value)
-				arg = xstrdup(in_tok->value);
+			if (in_tok)
+				arg = xstrdup(in_tok->value.buf);
 			else
 				arg = xstrdup("");
 		}
@@ -209,7 +209,9 @@ static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
 	struct trailer_item *new = xcalloc(sizeof(*new), 1);
 	new->token = arg_tok->token;
-	new->value = arg_tok->value;
+	strbuf_init(&new->value, 0);
+	strbuf_attach(&new->value, arg_tok->value, strlen(arg_tok->value),
+		      strlen(arg_tok->value));
 	arg_tok->token = arg_tok->value = NULL;
 	free_arg_item(arg_tok);
 	return new;
@@ -587,14 +589,17 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 	return 0;
 }
 
-static void add_trailer_item(struct trailer_item ***tail, char *tok, char *val)
+static struct trailer_item *add_trailer_item(struct trailer_item ***tail, char *tok,
+					     char *val)
 {
 	struct trailer_item *new = xcalloc(sizeof(*new), 1);
 	new->token = tok;
-	new->value = val;
+	strbuf_init(&new->value, 0);
+	strbuf_attach(&new->value, val, strlen(val), strlen(val));
 
 	**tail = new;
 	*tail = &new->next;
+	return new;
 }
 
 static void add_arg_item(struct arg_item ***tail, char *tok, char *val,
@@ -750,6 +755,7 @@ static int process_input_file(FILE *outfile,
 	int patch_start, trailer_start, trailer_end, i;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
+	struct trailer_item *last = NULL;
 
 	/* Get the line count */
 	while (lines[count])
@@ -767,16 +773,24 @@ static int process_input_file(FILE *outfile,
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
+		if (last && isspace(lines[i]->buf[0])) {
+			/* continuation line of the last trailer item */
+			strbuf_addch(&last->value, '\n');
+			strbuf_addbuf(&last->value, lines[i]);
+			strbuf_strip_suffix(&last->value, "\n");
+			continue;
+		}
 		if (!parse_trailer(&tok, &val, NULL, lines[i]->buf, 0))
-			add_trailer_item(in_tok_tail,
-					 strbuf_detach(&tok, NULL),
-					 strbuf_detach(&val, NULL));
+			last = add_trailer_item(in_tok_tail,
+						strbuf_detach(&tok, NULL),
+						strbuf_detach(&val, NULL));
 		else {
 			strbuf_addbuf(&val, lines[i]);
 			strbuf_strip_suffix(&val, "\n");
 			add_trailer_item(in_tok_tail,
 					 NULL,
 					 strbuf_detach(&val, NULL));
+			last = NULL;
 		}
 	}
 
-- 
2.8.0.rc3.226.g39d4020

