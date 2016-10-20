Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87271F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbcJTVkT (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:40:19 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33357 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbcJTVkK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:10 -0400
Received: by mail-pf0-f180.google.com with SMTP id 128so43881008pfz.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QvMp/g1BgJnhmp4nBGMUWZjJU7+EvWWb/7aTNwyRXlc=;
        b=eTvioJAIZiAs72VWiAHfnovfY9GrmLCl2MnFRnBUGESzbi1l0r49sb1+pKawxKyvi1
         7EeJQgJW4gHTFlyaApEFrJp93Dm/AR1lu/9e4rDpz+DhOxtT6pBmS3Mx8KtLY8yjpUxW
         vCyyV2PDT6P7Ej/gR8ZDxFweOgaxuEOzn8HjDP757RoeIzZAR87A9P+kg0Q5iQIHNqSd
         5l74BCJ8argKzocu1ijD4Ft3khOiLtGACzj5gHJJUKhHDBLjsOVYi51ltgp+WW8+aT7c
         Rf4LMaZDZdcCclBIoMeyeDTKnsExNjqrWZa75jgncG1SBsVvj2UkrFoi7dGQozYTOwFe
         rB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QvMp/g1BgJnhmp4nBGMUWZjJU7+EvWWb/7aTNwyRXlc=;
        b=gmBa5BrbkT2QKxZDuBBkE+JFHDpgV6hV1AOl16Rt2hhucZjTKXp5F19C4Q3qDn931w
         LwbEgqt7JRH4FFul3k95F4zjKpD5abbswJ7AxNXW/swq+UJUxOgbpTjAvMvd4+jEx8L1
         4r3N9u2hU1iPsx9grF3rdAMvDIyMcDcNpP1uAhuTbn0K/Bmkgd/WqDme1nfcxYf03qtB
         hhIP+mpOM/c9k+rSTSXn6hq62DBBXa6ltQz40k3Gp9NKQfsSgw0BY/KH1aYopiBd8xyM
         ObOAQL7c7D5FbvdcVN4VaaZMdd6xfeixjpUq4Dxuyn4Nvq4ezvlIW5jHWTshNj8cyP+r
         ddYw==
X-Gm-Message-State: AA6/9RkD6RYROibyGkwqQbrAICvfXrl+pORhQXcBQyNMCRbTbYlqhu/ghidSbF3tbzbPeJj8
X-Received: by 10.98.102.84 with SMTP id a81mr4896596pfc.176.1476999609254;
        Thu, 20 Oct 2016 14:40:09 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e6sm73883890pfb.57.2016.10.20.14.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 14:40:08 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v4 6/8] trailer: allow non-trailers in trailer block
Date:   Thu, 20 Oct 2016 14:39:51 -0700
Message-Id: <c4d2db03105c8872014ab2514379bb3c05bf3a0e.1476998988.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476998988.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476998988.git.jonathantanmy@google.com>
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
index 137a3fb..da15b79 100644
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
@@ -704,6 +726,7 @@ static int find_patch_start(struct strbuf **lines, int count)
 static int find_trailer_start(struct strbuf **lines, int count)
 {
 	int start, end_of_title, only_spaces = 1;
+	int recognized_prefix = 0, trailer_lines = 0, non_trailer_lines = 0;
 
 	/* The first paragraph is the title and cannot be trailers */
 	for (start = 0; start < count; start++) {
@@ -715,26 +738,60 @@ static int find_trailer_start(struct strbuf **lines, int count)
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
@@ -805,6 +862,12 @@ static int process_input_file(FILE *outfile,
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

