Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9AD20229
	for <e@80x24.org>; Thu, 20 Oct 2016 21:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932638AbcJTVkU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:40:20 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36839 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbcJTVkM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:12 -0400
Received: by mail-pf0-f174.google.com with SMTP id e6so43674759pfk.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jqr4OjQep43Nv78/95zE5yLOqv2rTBfYjFAhmYDhAPw=;
        b=oY1vkAOdvivTcgqhyZ2adUWxQhOdFdpoP/A2ETtSY9kRx+CNPwyvBNN+LpDTRSkbUO
         6IqmsV1558pdUxq33JkN2a877XuEmhVzFCg+8jApVXGQxQWWT5e97zygegnJf99t9gYO
         9lY283/81wisLuFnFC5QsHDdAlXbfZ6FfAMMEI9DWJyNGgmtFTLJekjtDjwXTqWYOFFV
         DxQm8Vxtnm+RhEk3jgL05ah2vjFOWr1vGGp5UkfrCZbHkhl1onC2cuzJFrRem6VPycnz
         H+QYRD0Gbj5WW6U92/WPm23T6OTaJS2EllVpIpl9BAg40cDuve8ewBy6PxuOY0zV0gDu
         r++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jqr4OjQep43Nv78/95zE5yLOqv2rTBfYjFAhmYDhAPw=;
        b=PsH+FCfO7gvfcnAwJ9xJT4MHYR541zCU1w6X9yj5JUr0gBiN6lG4fGgi3/DxnoTP1Y
         LqTa7tPx7iwR1N/FvK97ggIC65OQtnv6fn9vjhzzbKBSUt4StSduff/FNX2EV1Qv3JhZ
         37oa9mVFYepqDNaqo0tnwFFuyyp5LJgsyvq0jn7fK6domQ/vxdO6zRTwfuuRzF06OZwo
         4ceINfj7ArxmDZXziJjZ5zcDKjaCRfckjyNg/baju//myf1BucGpBtLyPWmry35FSuyG
         NjPM5Ng/+yzpnsp3bSEz400krfe1StkoZNQy+i8MvARVF//1ta2D8xelG+SbjI7buVsI
         XEFw==
X-Gm-Message-State: AA6/9Rlx655U46U7eS7nQKFXNNoknoDgmQa2/HvMe5owJr79JJd1OUFM8TQyZ017OLEew/nk
X-Received: by 10.99.123.94 with SMTP id k30mr4158992pgn.153.1476999610709;
        Thu, 20 Oct 2016 14:40:10 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e6sm73883890pfb.57.2016.10.20.14.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 14:40:10 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v4 8/8] trailer: support values folded to multiple lines
Date:   Thu, 20 Oct 2016 14:39:53 -0700
Message-Id: <e6d7454d3cc040810a3eaefd61a7e071e58dce6d.1476998988.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476998988.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476998988.git.jonathantanmy@google.com>
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

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-interpret-trailers.txt |   7 +-
 t/t7513-interpret-trailers.sh            | 169 +++++++++++++++++++++++++++++++
 trailer.c                                |  43 ++++++--
 3 files changed, 210 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 4966b5b..e99bda6 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -57,11 +57,12 @@ minus signs start the patch part of the message.
 
 When reading trailers, there can be whitespaces after the
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
index 3d94b3a..4dd1d7c 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -256,6 +256,175 @@ test_expect_success 'line with leading whitespace is not trailer' '
 	test_cmp expected actual
 '
 
+test_expect_success 'multiline field treated as one trailer for 25% check' '
+	q_to_tab >patch <<-\EOF &&
+
+		Signed-off-by: a <a@example.com>
+		name: value on
+		Qmultiple lines
+		this is not a trailer
+		this is not a trailer
+		this is not a trailer
+		this is not a trailer
+		this is not a trailer
+		this is not a trailer
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		Signed-off-by: a <a@example.com>
+		name: value on
+		Qmultiple lines
+		this is not a trailer
+		this is not a trailer
+		this is not a trailer
+		this is not a trailer
+		this is not a trailer
+		this is not a trailer
+		name: value
+	EOF
+	git interpret-trailers --trailer "name: value" patch >actual &&
+	test_cmp expected actual
+'
+
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
+		QQQQQsecond line
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		another: trailer
+		name: first line
+		Qsecond line
+		another: trailer
+		name: first line
+		QQQQQsecond line
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
+		QQQQQsecond line
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		another: trailer
+		name: first line
+		Qsecond line
+		name: first line
+		QQQQQsecond line
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
index 3ef5576..306c387 100644
--- a/trailer.c
+++ b/trailer.c
@@ -622,12 +622,14 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 	}
 }
 
-static void add_trailer_item(struct list_head *head, char *tok, char *val)
+static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
+					     char *val)
 {
 	struct trailer_item *new = xcalloc(sizeof(*new), 1);
 	new->token = tok;
 	new->value = val;
 	list_add_tail(&new->list, head);
+	return new;
 }
 
 static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
@@ -727,6 +729,14 @@ static int find_trailer_start(struct strbuf **lines, int count)
 {
 	int start, end_of_title, only_spaces = 1;
 	int recognized_prefix = 0, trailer_lines = 0, non_trailer_lines = 0;
+	/*
+	 * Number of possible continuation lines encountered. This will be
+	 * reset to 0 if we encounter a trailer (since those lines are to be
+	 * considered continuations of that trailer), and added to
+	 * non_trailer_lines if we encounter a non-trailer (since those lines
+	 * are to be considered non-trailers).
+	 */
+	int possible_continuation_lines = 0;
 
 	/* The first paragraph is the title and cannot be trailers */
 	for (start = 0; start < count; start++) {
@@ -747,11 +757,15 @@ static int find_trailer_start(struct strbuf **lines, int count)
 		const char **p;
 		int separator_pos;
 
-		if (lines[start]->buf[0] == comment_line_char)
+		if (lines[start]->buf[0] == comment_line_char) {
+			non_trailer_lines += possible_continuation_lines;
+			possible_continuation_lines = 0;
 			continue;
+		}
 		if (contains_only_spaces(lines[start]->buf)) {
 			if (only_spaces)
 				continue;
+			non_trailer_lines += possible_continuation_lines;
 			if (recognized_prefix &&
 			    trailer_lines * 3 >= non_trailer_lines)
 				return start + 1;
@@ -764,6 +778,7 @@ static int find_trailer_start(struct strbuf **lines, int count)
 		for (p = git_generated_prefixes; *p; p++) {
 			if (starts_with(lines[start]->buf, *p)) {
 				trailer_lines++;
+				possible_continuation_lines = 0;
 				recognized_prefix = 1;
 				goto continue_outer_loop;
 			}
@@ -774,6 +789,7 @@ static int find_trailer_start(struct strbuf **lines, int count)
 			struct list_head *pos;
 
 			trailer_lines++;
+			possible_continuation_lines = 0;
 			if (recognized_prefix)
 				continue;
 			list_for_each(pos, &conf_head) {
@@ -785,8 +801,13 @@ static int find_trailer_start(struct strbuf **lines, int count)
 					break;
 				}
 			}
-		} else
+		} else if (isspace(lines[start]->buf[0]))
+			possible_continuation_lines++;
+		else {
 			non_trailer_lines++;
+			non_trailer_lines += possible_continuation_lines;
+			possible_continuation_lines = 0;
+		}
 continue_outer_loop:
 		;
 	}
@@ -835,6 +856,7 @@ static int process_input_file(FILE *outfile,
 	int patch_start, trailer_start, trailer_end, i;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
+	struct trailer_item *last = NULL;
 
 	/* Get the line count */
 	while (lines[count])
@@ -855,19 +877,28 @@ static int process_input_file(FILE *outfile,
 		int separator_pos;
 		if (lines[i]->buf[0] == comment_line_char)
 			continue;
+		if (last && isspace(lines[i]->buf[0])) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "%s\n%s", last->value, lines[i]->buf);
+			strbuf_strip_suffix(&sb, "\n");
+			free(last->value);
+			last->value = strbuf_detach(&sb, NULL);
+			continue;
+		}
 		separator_pos = find_separator(lines[i]->buf);
 		if (separator_pos >= 1) {
 			parse_trailer(&tok, &val, NULL, lines[i]->buf,
 				      separator_pos);
-			add_trailer_item(head,
-					 strbuf_detach(&tok, NULL),
-					 strbuf_detach(&val, NULL));
+			last = add_trailer_item(head,
+						strbuf_detach(&tok, NULL),
+						strbuf_detach(&val, NULL));
 		} else {
 			strbuf_addbuf(&val, lines[i]);
 			strbuf_strip_suffix(&val, "\n");
 			add_trailer_item(head,
 					 NULL,
 					 strbuf_detach(&val, NULL));
+			last = NULL;
 		}
 	}
 
-- 
2.8.0.rc3.226.g39d4020

