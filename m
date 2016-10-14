Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88CE1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755141AbcJNRiY (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:38:24 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33572 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754504AbcJNRiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:38:18 -0400
Received: by mail-pf0-f174.google.com with SMTP id 128so52987653pfz.0
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ys4FJ+S7zN4RAVNxdmHzVISSsZlBJ+A5+4ab0Rjd72s=;
        b=hf5fRlLjsHj5zpFWvehCqI+RixMclee/2EZsdVGNTjSdkkZB3fK2SP8NWHpe2JEzF5
         FfpbenZn3fp73QvHy4kzXvmW6UEiHedaYP1YNS3OJBYzWeXSV28eGqnsnsW/GhK+0Cli
         1RjG1zVxS4K2gwzrAnK1dfESmOY0DAejQAJvMQ0py9T2Q2bWWOw9dboqJ4etTWemBCnU
         oYzDeF81kjgTrfBsT0Upa6D/UZB69tDZkGuu+R+GLvGMRPyVKnWYMcGiZcKdGyYd/Pcg
         uBJJuibYLEsEmaKIF+epIHO+7yAWERtGmBLj5I8Qm38E3uFciaXwe0ug1Wh9rd0O9vMx
         778w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ys4FJ+S7zN4RAVNxdmHzVISSsZlBJ+A5+4ab0Rjd72s=;
        b=ODp9njAVvuVWjufEMFG/CcgRfxbHQ5D0iLrAclrZPB/MvHR5wxH3jiEBmTYNFMXKgL
         779fxUNhfmqnVZDAaXmnEj9Xx6zHZO97vB8+9YdSJhNH4EZJYPVVM6Y7alvh/mOFZTrr
         E1uoaedUNicc9H97CZgtLxUT6hPmfMkj/p6wNZ+EuKIvIz+lyE6pFAVhnhqSdmY4Dztu
         54FOqYo7zA60bglxARAb4Ai5EA38JNRaBhIppxD3KaItKz+VJOTUrgGzdLy5MnHtDXpn
         FYjYFVMOZMcMMuY2LfhGUNT6PtL48BxcYtkH14coUW2mf6LkVb2W/jiF48b0itWeKcLS
         nQeA==
X-Gm-Message-State: AA6/9RnRNdIKJE1CZLPxqXaaLum06QIi5lZEmz/OQbVQp+TKf8S2NyC0Ba3/fztAk/mvhi6+
X-Received: by 10.99.119.70 with SMTP id s67mr16584518pgc.152.1476466696393;
        Fri, 14 Oct 2016 10:38:16 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b88sm28955706pfe.72.2016.10.14.10.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Oct 2016 10:38:15 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jnareb@gmail.com
Subject: [PATCH v3 6/6] trailer: support values folded to multiple lines
Date:   Fri, 14 Oct 2016 10:38:03 -0700
Message-Id: <0a187897454a5bce946d675f6f6c93283b411f31.1476466609.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476466609.git.jonathantanmy@google.com>
References: <cover.1476466609.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476466609.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476466609.git.jonathantanmy@google.com>
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
 t/t7513-interpret-trailers.sh            | 139 +++++++++++++++++++++++++++++++
 trailer.c                                |  22 +++--
 3 files changed, 160 insertions(+), 8 deletions(-)

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
index 7f5cd2a..31db699 100755
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
index d6dfc7a..ef276e6 100644
--- a/trailer.c
+++ b/trailer.c
@@ -248,7 +248,7 @@ static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
 		if (arg_tok->value && arg_tok->value[0]) {
 			arg = arg_tok->value;
 		} else {
-			if (in_tok && in_tok->value)
+			if (in_tok)
 				arg = xstrdup(in_tok->value);
 			else
 				arg = xstrdup("");
@@ -622,12 +622,14 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val,
 	return 0;
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
@@ -781,6 +783,7 @@ static int process_input_file(FILE *outfile,
 	int patch_start, trailer_start, trailer_end, i;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
+	struct trailer_item *last = NULL;
 
 	/* Get the line count */
 	while (lines[count])
@@ -798,16 +801,25 @@ static int process_input_file(FILE *outfile,
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
+		if (last && isspace(lines[i]->buf[0])) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "%s\n%s", last->value, lines[i]->buf);
+			strbuf_strip_suffix(&sb, "\n");
+			free(last->value);
+			last->value = strbuf_detach(&sb, NULL);
+			continue;
+		}
 		if (!parse_trailer(&tok, &val, NULL, lines[i]->buf, 0))
-			add_trailer_item(head,
-					 strbuf_detach(&tok, NULL),
-					 strbuf_detach(&val, NULL));
+			last = add_trailer_item(head,
+						strbuf_detach(&tok, NULL),
+						strbuf_detach(&val, NULL));
 		else {
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

