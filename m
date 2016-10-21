Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D80D120229
	for <e@80x24.org>; Fri, 21 Oct 2016 17:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934425AbcJURza (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:55:30 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33009 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756026AbcJURzT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:55:19 -0400
Received: by mail-pf0-f182.google.com with SMTP id 128so60692064pfz.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Zk6xTEUPDIPn/AiAbAM1FbFQ3zaPFfn/a1nUMlvwg9Y=;
        b=gWm/U2brRA5eJ6JhUuxJJJir/iy14URuIdfVD6egYUVbou01t3CQrk2/CHoGdkRtnJ
         Iy3udhdd0HCzToKjL/P0cVXqFaHbXCtfgxIXb1hOHaA1SfreBawGhN8wDvCDwZ6x1PLe
         NRmHiS8GgjBlf4MP2dW5nrHrXsUqADqTiu32hxMtxkGZOF+LbjMM3Gzrv02WcsZOeiO5
         0WK9hSgyif/H/RGE15XStGokuGuR3TVYiOE4XFhmeMERghHbrQXtNr25iuhdE43ofIIf
         /e5dHl8MKu9FqZK9LqxpwhHIJ8+13Yxg/ToWGkPtHTga0FIzfsxICU6olM2LndqU+hU9
         EKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Zk6xTEUPDIPn/AiAbAM1FbFQ3zaPFfn/a1nUMlvwg9Y=;
        b=mEDbtFykZeECgfnrfjGGMGOhJnoNSfHLEBPksEVVNCqcI2bn2J/wyseHmfbn2pvWFr
         lrGg4JtDDZ9/cLr/DLnucW4BnCDZJvWLRprI+R3keRbd7MlSJB9m2X/JTPETItiVwyMO
         UtX9Z+tZ7z7nH8J5MkJgNjqnF53fV+IIASQH3XQPYH9upjXDF6zwZYmzpV+FU6G/UTu1
         ZDjc1MCd0vv1KHVP2jLXwWEKvaSFSdbEjcCdriCmOLgpe7H4ag0e0hjTbdGSanveseHk
         D7sSK4JdKLpEe4n3fvw5cQWNjLPXwxo9WxVpp/7Zip3/C/m6R+S3wijUTuzHlTjcLbUu
         awPQ==
X-Gm-Message-State: ABUngve+fhxvUKbciX2o1NmvydtkMP64IO3LGmQaICq8as78AQhynCxS6m2Sz/vAd7nQDYCL
X-Received: by 10.98.3.65 with SMTP id 62mr3708767pfd.98.1477072517794;
        Fri, 21 Oct 2016 10:55:17 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id c75sm6714020pfb.23.2016.10.21.10.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 10:55:16 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 6/8] trailer: allow non-trailers in trailer block
Date:   Fri, 21 Oct 2016 10:55:01 -0700
Message-Id: <b7ff1a633688f3523cb641e9c4faf80094d6a435.1477072247.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1477072247.git.jonathantanmy@google.com>
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1477072247.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, interpret-trailers requires all lines of a trailer block to
be trailers (or comments) - if not it would not identify that block as a
trailer block, and thus create its own trailer block, inserting a blank
line.  For example:

  echo -e "\nSigned-off-by: x\nnot trailer" |
  git interpret-trailers --trailer "c: d"

would result in:

  Signed-off-by: x
  not trailer

  c: d

Relax the definition of a trailer block to require that the trailers (i)
are all trailers, or (ii) contain at least one Git-generated trailer and
consists of at least 25% trailers.

  Signed-off-by: x
  not trailer
  c: d

(i) is the existing functionality. (ii) allows arbitrary lines to be
included in trailer blocks, like those in [1], and still allow
interpret-trailers to be used.

[1]
https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable/+/e7d316a02f683864a12389f8808570e37fb90aa3

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-interpret-trailers.txt |   5 +-
 t/t7513-interpret-trailers.sh            | 115 +++++++++++++++++++++++++++++++
 trailer.c                                |  89 ++++++++++++++++++++----
 3 files changed, 194 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 93d1db6..cf4c5ea 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -48,8 +48,9 @@ with only spaces at the end of the commit message part, one blank line
 will be added before the new trailer.
 
 Existing trailers are extracted from the input message by looking for
-a group of one or more lines that contain a colon (by default), where
-the group is preceded by one or more empty (or whitespace-only) lines.
+a group of one or more lines that (i) are all trailers, or (ii) contains at
+least one Git-generated trailer and consists of at least 25% trailers.
+The group must be preceded by one or more empty (or whitespace-only) lines.
 The group must either be at the end of the message or be the last
 non-whitespace lines before a line that starts with '---'. Such three
 minus signs start the patch part of the message.
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index aee785c..003e90f 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -126,6 +126,121 @@ test_expect_success 'with multiline title in the message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with non-trailer lines mixed with Signed-off-by' '
+	cat >patch <<-\EOF &&
+
+		this is not a trailer
+		this is not a trailer
+		Signed-off-by: a <a@example.com>
+		this is not a trailer
+	EOF
+	cat >expected <<-\EOF &&
+
+		this is not a trailer
+		this is not a trailer
+		Signed-off-by: a <a@example.com>
+		this is not a trailer
+		token: value
+	EOF
+	git interpret-trailers --trailer "token: value" patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with non-trailer lines mixed with cherry picked from' '
+	cat >patch <<-\EOF &&
+
+		this is not a trailer
+		this is not a trailer
+		(cherry picked from commit x)
+		this is not a trailer
+	EOF
+	cat >expected <<-\EOF &&
+
+		this is not a trailer
+		this is not a trailer
+		(cherry picked from commit x)
+		this is not a trailer
+		token: value
+	EOF
+	git interpret-trailers --trailer "token: value" patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with non-trailer lines mixed with a configured trailer' '
+	cat >patch <<-\EOF &&
+
+		this is not a trailer
+		this is not a trailer
+		My-trailer: x
+		this is not a trailer
+	EOF
+	cat >expected <<-\EOF &&
+
+		this is not a trailer
+		this is not a trailer
+		My-trailer: x
+		this is not a trailer
+		token: value
+	EOF
+	test_config trailer.my.key "My-trailer: " &&
+	git interpret-trailers --trailer "token: value" patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with non-trailer lines mixed with a non-configured trailer' '
+	cat >patch <<-\EOF &&
+
+		this is not a trailer
+		this is not a trailer
+		I-am-not-configured: x
+		this is not a trailer
+	EOF
+	cat >expected <<-\EOF &&
+
+		this is not a trailer
+		this is not a trailer
+		I-am-not-configured: x
+		this is not a trailer
+
+		token: value
+	EOF
+	test_config trailer.my.key "My-trailer: " &&
+	git interpret-trailers --trailer "token: value" patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with all non-configured trailers' '
+	cat >patch <<-\EOF &&
+
+		I-am-not-configured: x
+		I-am-also-not-configured: x
+	EOF
+	cat >expected <<-\EOF &&
+
+		I-am-not-configured: x
+		I-am-also-not-configured: x
+		token: value
+	EOF
+	test_config trailer.my.key "My-trailer: " &&
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
diff --git a/trailer.c b/trailer.c
index aff858b..199f86a 100644
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
@@ -44,6 +48,12 @@ static char *separators = ":";
 
 #define TRAILER_ARG_STRING "$ARG"
 
+static const char *git_generated_prefixes[] = {
+	"Signed-off-by: ",
+	"(cherry picked from commit ",
+	NULL
+};
+
 /* Iterate over the elements of the list. */
 #define list_for_each_dir(pos, head, is_reverse) \
 	for (pos = is_reverse ? (head)->prev : (head)->next; \
@@ -70,9 +80,14 @@ static size_t token_len_without_separator(const char *token, size_t len)
 
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
@@ -130,7 +145,14 @@ static char last_non_space_char(const char *s)
 
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
@@ -709,6 +731,7 @@ static int find_patch_start(struct strbuf **lines, int count)
 static int find_trailer_start(struct strbuf **lines, int count)
 {
 	int start, end_of_title, only_spaces = 1;
+	int recognized_prefix = 0, trailer_lines = 0, non_trailer_lines = 0;
 
 	/* The first paragraph is the title and cannot be trailers */
 	for (start = 0; start < count; start++) {
@@ -720,26 +743,60 @@ static int find_trailer_start(struct strbuf **lines, int count)
 	end_of_title = start;
 
 	/*
-	 * Get the start of the trailers by looking starting from the end
-	 * for a line with only spaces before lines with one separator.
+	 * Get the start of the trailers by looking starting from the end for a
+	 * blank line before a set of non-blank lines that (i) are all
+	 * trailers, or (ii) contains at least one Git-generated trailer and
+	 * consists of at least 25% trailers.
 	 */
 	for (start = count - 1; start >= end_of_title; start--) {
+		const char **p;
+		int separator_pos;
+
 		if (lines[start]->buf[0] == comment_line_char)
 			continue;
 		if (contains_only_spaces(lines[start]->buf)) {
 			if (only_spaces)
 				continue;
-			return start + 1;
+			if (recognized_prefix &&
+			    trailer_lines * 3 >= non_trailer_lines)
+				return start + 1;
+			if (trailer_lines && !non_trailer_lines)
+				return start + 1;
+			return count;
 		}
-		if (strcspn(lines[start]->buf, separators) < lines[start]->len) {
-			if (only_spaces)
-				only_spaces = 0;
-			continue;
+		only_spaces = 0;
+
+		for (p = git_generated_prefixes; *p; p++) {
+			if (starts_with(lines[start]->buf, *p)) {
+				trailer_lines++;
+				recognized_prefix = 1;
+				goto continue_outer_loop;
+			}
 		}
-		return count;
+
+		separator_pos = find_separator(lines[start]->buf);
+		if (separator_pos >= 1) {
+			struct list_head *pos;
+
+			trailer_lines++;
+			if (recognized_prefix)
+				continue;
+			list_for_each(pos, &conf_head) {
+				struct arg_item *item;
+				item = list_entry(pos, struct arg_item, list);
+				if (token_matches_item(lines[start]->buf, item,
+						       separator_pos)) {
+					recognized_prefix = 1;
+					break;
+				}
+			}
+		} else
+			non_trailer_lines++;
+continue_outer_loop:
+		;
 	}
 
-	return only_spaces ? count : 0;
+	return count;
 }
 
 /* Get the index of the end of the trailers */
@@ -810,6 +867,12 @@ static int process_input_file(FILE *outfile,
 			add_trailer_item(head,
 					 strbuf_detach(&tok, NULL),
 					 strbuf_detach(&val, NULL));
+		} else {
+			strbuf_addbuf(&val, lines[i]);
+			strbuf_strip_suffix(&val, "\n");
+			add_trailer_item(head,
+					 NULL,
+					 strbuf_detach(&val, NULL));
 		}
 	}
 
-- 
2.8.0.rc3.226.g39d4020

