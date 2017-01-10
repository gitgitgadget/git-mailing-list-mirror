Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE53205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760419AbdAJItG (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:06 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35379 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760375AbdAJItE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:04 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so9037448pfa.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D3/FV6M9Is5cbWwMVU88RtozEui6bk/JMtAdvH5lTG8=;
        b=MOVTr7OayZYfDbmE/wisp77rgQdgUE8yQxJWvTZN45VWLrdupsEnb4DBa2or920otF
         1FuY1xnLqcCoJ/Z023S/Tey0Z2k/TAXg7RTuFJnteaLU2XAM4TltVmHKlT2t8jmqD7y1
         Mfqe17765PdN+2jTv4u7JcB3ZK4E7tayzfHcICFNtKccLibkJ8VJqO+3N/yIKRDNceLc
         OoysAuYqoSYpc1j0aBs1y/kbeEm+pjhRqNfMGfL9ZEJD9yYxM6YkznwG2xQrQ9h6nG0N
         nnI5A05Zl0s0V5EhIGi8+Ivi5CwmLOJLKHHSZHdr39p8QhsSLsf6npHF43W6+IrXtyvc
         f9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D3/FV6M9Is5cbWwMVU88RtozEui6bk/JMtAdvH5lTG8=;
        b=tEXqf19sjc9oIXP7CS7MkUSRzp7in+KtZbD8EolLM7NYnvmwnnTKPKevNBazOpDUF7
         HHCyOcHdEB3r+BggBlqoxOdg7ZqOJttb6oh52z8L5Ereum6NgV8+X8vRjgtlzXz5b6Hw
         hPcIwNwkSBF+AXiT20RfmedW9pwfEdFfCiq8duT08zA2V7tvZeszXyY1OHtxpqUoK+xx
         RRft4hfHse6Bs0zaOa9nJcE71dGsHvsZnwuoVOWzxKpjOJXCtbTkz24j9a2nx5iLJcBY
         lOYOTJLoTFjpD0SDu+W1fuaso5wkt/w1+tOwfwRzJG1wD0akdOJfqiZSgnIApjWIi2+o
         Hclw==
X-Gm-Message-State: AIkVDXIXktSvdsm+0HPjPGWfP5xjhyBMmouz7ZqHuOtV/oYoga8bk2D5m6Isjw2dCNpLwQ==
X-Received: by 10.99.60.76 with SMTP id i12mr2729047pgn.170.1484038143880;
        Tue, 10 Jan 2017 00:49:03 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:03 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 06/20] ref-filter: introduce format_ref_array_item()
Date:   Tue, 10 Jan 2017 14:19:39 +0530
Message-Id: <20170110084953.15890-7-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
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
index 5511a200c..47b521cca 100644
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
index f78323de0..630e7c2b9 100644
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
2.11.0

