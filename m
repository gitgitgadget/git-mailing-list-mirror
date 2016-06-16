Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999291FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 13:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbcFPNTE (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 09:19:04 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36042 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcFPNTB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 09:19:01 -0400
Received: by mail-pa0-f65.google.com with SMTP id fg1so3752437pad.3
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 06:19:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jleDkIafWJ1DWuGHfanAvnYPva78zFS2qkr6Foz8nlk=;
        b=YleWa23Ob/P1mNmQXVdEjx45yp0sngxfSc/FCE1BE89fADtdAi0S+UNnMLoPjs3u7C
         fB7n0epyx6g66i8t82R3xowDM/rc5xnvHeXRZhpS7M+MIaz4BjF6XK8aph81UedsZZka
         0JUaGovgBraJgxR4E1burSGWK36ZEH++MuFJrj9O7XPlt+GD/5DG/D9hNOI2x7LxfbdQ
         6mdowb5A8E+EO49J9YYih+YrAzhoVq/YIAPUByvozDc9mXY3nAQh6I+87B/NJhJ6G2Jm
         W7j/1bWbZQ9thi99Vp7jvvFBi/CvXPGaT/vPSVlvh8dfJ1XqfSMRuiGguEVAzboI0TKy
         iQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jleDkIafWJ1DWuGHfanAvnYPva78zFS2qkr6Foz8nlk=;
        b=jqaxNA/JXUCpxCMMbtorJH6nBeMBZWLTQCDfZQl4twBPbDnGXsIML9X5CsZAGfOxOo
         FpZaMm+QKzXWBZbvvWU8X9NK7fzDkL1vA3UECFbk8AgbbLvvNZpxSVrlzSXuxum+zP1y
         qK4uvNF9yjvrIciaRQC4KZTpPz0ltv00qu4G0RIIpYOelzt9Vzwcr4rJbZ9L2IqFqZbb
         SYYl7QkYqCh5fSBbC9MaEMolPCVaLvFi1qhAzwTBmrPXtXETYGuNrvfVc1ZWQbEUo15e
         1U2iHCjiFQovec8Z0FaXu4hGCLZ+1YlmN6xPR2xA9xrzBRFPT5PcES911YTFCz/qxHoL
         0MzQ==
X-Gm-Message-State: ALyK8tLS2ylIyXK1BhfYF3u8NBZmz/YB21z7aEsR9T4KsVzkOFMsPWxs8qoVtBaX0VQO6A==
X-Received: by 10.66.222.202 with SMTP id qo10mr4878466pac.141.1466083140168;
        Thu, 16 Jun 2016 06:19:00 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id d65sm17067885pfa.45.2016.06.16.06.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 06:18:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Jun 2016 20:18:55 +0700
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, josef@kufner.cz,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] pretty: pass graph width to pretty formatting for use in '%>|(N)'
Date:	Thu, 16 Jun 2016 20:18:37 +0700
Message-Id: <20160616131838.14440-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160616131838.14440-1-pclouds@gmail.com>
References: <20160616131838.14440-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Josef Kufner <josef@kufner.cz>

Pass graph width to pretty formatting, to make N in '%>|(N)'
include columns consumed by graph rendered when --graph option
is in use.

For example, in the output of

  git log --all --graph --pretty='format: [%>|(20)%h] %ar%d'

this change will make all commit hashes align at 20th column from
the edge of the terminal, not from the edge of the graph.

Signed-off-by: Josef Kufner <josef@kufner.cz>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.h                      |  1 +
 graph.c                       |  7 +++++++
 graph.h                       |  5 +++++
 log-tree.c                    |  2 ++
 pretty.c                      |  1 +
 t/t4205-log-pretty-formats.sh | 24 ++++++++++++++++++++++++
 6 files changed, 40 insertions(+)

diff --git a/commit.h b/commit.h
index b06db4d..0c923f0 100644
--- a/commit.h
+++ b/commit.h
@@ -161,6 +161,7 @@ struct pretty_print_context {
 	 * should not be counted on by callers.
 	 */
 	struct string_list in_body_headers;
+	int graph_width;
 };
 
 struct userformat_want {
diff --git a/graph.c b/graph.c
index 1350bdd..ad766fa 100644
--- a/graph.c
+++ b/graph.c
@@ -669,6 +669,13 @@ static void graph_output_padding_line(struct git_graph *graph,
 	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
 }
 
+
+int graph_width(struct git_graph *graph)
+{
+	return graph->width;
+}
+
+
 static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 {
 	/*
diff --git a/graph.h b/graph.h
index 0be62bd..3f48c19 100644
--- a/graph.h
+++ b/graph.h
@@ -67,6 +67,11 @@ int graph_is_commit_finished(struct git_graph const *graph);
 int graph_next_line(struct git_graph *graph, struct strbuf *sb);
 
 
+/*
+ * Return current width of the graph in on-screen characters.
+ */
+int graph_width(struct git_graph *graph);
+
 /*
  * graph_show_*: helper functions for printing to stdout
  */
diff --git a/log-tree.c b/log-tree.c
index 78a5381..8d39315 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -687,6 +687,8 @@ void show_log(struct rev_info *opt)
 	ctx.output_encoding = get_log_output_encoding();
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
+	if (opt->graph)
+		ctx.graph_width = graph_width(opt->graph);
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index 87c4497..4f33b09 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1299,6 +1299,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		if (!start)
 			start = sb->buf;
 		occupied = utf8_strnwidth(start, -1, 1);
+		occupied += c->pretty_ctx->graph_width;
 		padding = (-padding) - occupied;
 	}
 	while (1) {
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 7398605..d75cdbb 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -319,6 +319,19 @@ EOF
 	test_cmp expected actual
 '
 
+# Note: Space between 'message' and 'two' should be in the same column
+# as in previous test.
+test_expect_success 'right alignment formatting at the nth column with --graph. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=$test_encoding log --graph --pretty="tformat:%h %>|(40)%s" >actual &&
+	iconv -f utf-8 -t $test_encoding >expected <<EOF&&
+* $head1                    message two
+* $head2                    message one
+* $head3                        add bar
+* $head4            $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty="tformat:%>(1)%s" >actual &&
 	cat <<EOF >expected &&
@@ -330,6 +343,17 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'right alignment formatting with no padding and with --graph' '
+	git log --graph --pretty="tformat:%>(1)%s" >actual &&
+	cat <<EOF >expected &&
+* message two
+* message one
+* add bar
+* $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting with no padding. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%>(1)%s" >actual &&
 	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-- 
2.8.2.524.g6ff3d78

