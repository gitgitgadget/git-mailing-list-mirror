Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B46200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755445AbcL0QXd (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:33 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34295 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755411AbcL0QX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:27 -0500
Received: by mail-pg0-f68.google.com with SMTP id b1so12843796pgc.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q+1lD0DSbsjWdDKPRnCViPTi/R9h50BYC1bW/OCUK68=;
        b=RWvA91NjyU1SPpA4tcabY6QXSS3miFoVkrZAk0Lvv5e72CV5MtHGmEchyn1wky8xC6
         Elo9GtWGi2tv1T7OM69yAauc51zpf9sws1Cjn4KxkwBPKuJV2RFylZkYgLPbxidmJD68
         YP4geOJAYA/JBNieODZkxgOmWdeC9A8OvPzige8c5W+CtK5j7kAW1Xlu/QcWiTuEGNn6
         4V2fB2Bn9A0Xyu2c56Os7F1ZEziYD0ac1miBF/20VDzGoMTiCwlik9UYX1UAj2BukQGT
         w4llHAoe32+rtJEi/FIA3GmwORr8HQCDPbS2XrpA22KwQPso/cvV90XHnkTo6O2asM49
         pOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q+1lD0DSbsjWdDKPRnCViPTi/R9h50BYC1bW/OCUK68=;
        b=cwIPtyLRtfroWRmMD658INIt9oaSMaI6BNW5SF9Ne/SZILRN2VGwq7ISMI8PLKs4dH
         /BFNWAom6Wc2/BZJyMD3vr/ne4HMuV7B8lq2FZ9pmW5F9dEuzZznQ+tXtZo595CWweYn
         5pG/pA1Q2aH5ZpSpZzFMO2RlOogDwyOnvFcgrKtgNvQYR+ggyqBvDjuEq2YcIYx3keWH
         VLSFTXJ2dYfWKdM9MIoDgynR4ThuX/KQjd/OZGV3Zs+dk+C4sRhNuM20FMarOQU7ElsV
         c3N+G6whEHP4RzTg2A+thbEhdUsj8IZxQSsj/b0o8JdgBrN9uMi5YPd9Vy0jtPdUGU2d
         f5Sg==
X-Gm-Message-State: AIkVDXIYURmk7kOgVrX+Rg8AZ67uKgHybZjKCJwjkdsxwKScueRjHdKG5dsJp6jwtdhHjA==
X-Received: by 10.84.216.17 with SMTP id m17mr67371726pli.82.1482855806545;
        Tue, 27 Dec 2016 08:23:26 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:25 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 06/20] ref-filter: introduce format_ref_array_item()
Date:   Tue, 27 Dec 2016 21:53:43 +0530
Message-Id: <20161227162357.28212-7-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
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
index 5511a20..47b521c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1833,10 +1833,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
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
@@ -1866,9 +1866,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
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
index f78323d..630e7c2 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -100,6 +100,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
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

