Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39C72022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933110AbcKHUM2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:28 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33418 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932468AbcKHUMX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:23 -0500
Received: by mail-pf0-f195.google.com with SMTP id 144so12330881pfv.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWa1rXSv/sMy6SZVO7GI4Wk9TRvBVaeZNiF9oIV5kPA=;
        b=esRBcgRgO/UwrZoab5jlyejKfra96HnnjHAHL40v6Jm0UgiXgGCupoEFD1McyMKBuP
         i1nWbi3/jJUcxcYaH4UTk0NaHz8UPvF5Tj9M2HEWSfeTDDGqW03qYGeOOaGT20s/Oqwv
         xBWIgv19c/01qjoViaOn0iAZmGfxXlAE6OQMw/DgNVq034PkflEi+JRLtpX0XrPFqEF6
         KYm2EjwTdoHWFuooqh7UnpDTET/+UZChsmkGwBgzbphnWmJlTAOPwibDHeyADlemK2zQ
         KNty29he0McOP4ylA3FTzGrFOCiV6aup/kd15MN5I8IKelJ9420UhCJL6UGgZNJk8JNB
         U67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWa1rXSv/sMy6SZVO7GI4Wk9TRvBVaeZNiF9oIV5kPA=;
        b=GrXM5PryTI8VWn0XsE/q79pDn8W3a3c5TnB4P0gDQJ0G7p7ondJ/Izgi6NWYDZzv9y
         YdBXNXHAX9BxVwCETc3Ql+Mqebc+kIr0WbLCOi46Qea0yJNoWyIEkNTFYY3nUqe6v6kT
         GvIXuFP34QHlAvZYXKcpf5aOeEbxenYEJ5madWGQR9uq4pLHe3IWvm2Wge0RqnFMX1LJ
         nXAIZ04Oe/x2Zo2oi4sPgE+Qh7ptnDEUFKyoXvOrhriUWtT/4d9Mn7uvxBp6VyiLAQmt
         4DSAp8CcDeIHqTPneGluFvsLoY0tGPry7FkWX6hqGh7WYB07nmCUg4HoKdZWEIUZ9csr
         gNaQ==
X-Gm-Message-State: ABUngvcSmjTPwrCw+cv81NAU5nxt1SwaPens7zOa+oMkNFjs/pAJcptPrG0o9na23FKtCA==
X-Received: by 10.99.123.87 with SMTP id k23mr21509779pgn.101.1478635942592;
        Tue, 08 Nov 2016 12:12:22 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:22 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 06/17] ref-filter: introduce format_ref_array_item()
Date:   Wed,  9 Nov 2016 01:42:00 +0530
Message-Id: <20161108201211.25213-7-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

To allow column display, we will need to first render the output in a
string list to allow print_columns() to compute the proper size of
each column before starting the actual output. Introduce the function
format_ref_array_item() that does the formatting of a ref_array_item
to an strbuf.

show_ref_array_item() is kept as a convenience wrapper around it which
obtains the strbuf and prints it the standard output.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 16 ++++++++++++----
 ref-filter.h |  3 +++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 40bdf97..b8b8a95 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1795,10 +1795,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+void format_ref_array_item(struct ref_array_item *info, const char *format,
+			   int quote_style, struct strbuf *final_buf)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf *final_buf;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
 	state.quote_style = quote_style;
@@ -1828,9 +1828,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	}
 	if (state.stack->prev)
 		die(_("format: %%(end) atom missing"));
-	final_buf = &state.stack->output;
-	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	strbuf_addbuf(final_buf, &state.stack->output);
 	pop_stack_element(&state.stack);
+}
+
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+{
+	struct strbuf final_buf = STRBUF_INIT;
+
+	format_ref_array_item(info, format, quote_style, &final_buf);
+	fwrite(final_buf.buf, 1, final_buf.len, stdout);
+	strbuf_release(&final_buf);
 	putchar('\n');
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 4aea594..0014b92 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -98,6 +98,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
 int verify_ref_format(const char *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
+/*  Based on the given format and quote_style, fill the strbuf */
+void format_ref_array_item(struct ref_array_item *info, const char *format,
+			   int quote_style, struct strbuf *final_buf);
 /*  Print the ref using the given format and quote_style */
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
 /*  Callback function for parsing the sort option */
-- 
2.10.2

