Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91046EEB581
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 06:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbjIIGQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 02:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjIIGQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 02:16:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195B1BC5
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 23:16:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-403012f276dso4176475e9.0
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694240180; x=1694844980; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R6TUptbEq8L+7sFDFnVsmQFyJZ01GJ9BerfsfkEvVw=;
        b=dVFHUDRaSFGx0z6s07hYlNS/pyCPK0AMEHVduVitZq4FVn6nQYWtU+FMxiIq380oZI
         4foo1j+xNQT844g5K72SzgXL21TP4HpNqur5Op98lkq/0iYfEhtI9OAvqhcRasWdcTTU
         IiMBhOehEROF7Hrxvs7vNdh/hGWy3qElEY02HiRAbsr9xRmsvY8TGn+bjwf2PLL9Avcu
         CsIHaLbSKIF0GOPOamUhUvg/f6y5otvD2nc9cDJxVy0YzSheKwsnPB0fn7P0WWi3fghX
         2bCWgQoN/T27IFEJ082qLInH4TUGC4UbvvAM3RzkCgegOOR2lZiD7FFEexmzQ3zcwFUQ
         cDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694240180; x=1694844980;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3R6TUptbEq8L+7sFDFnVsmQFyJZ01GJ9BerfsfkEvVw=;
        b=N0FO1+moCrLDB+98BcSS+VW6XDZaZalwBICCSPwaVn8WNqSlH4cRifFS/H10jHvkAW
         uvwYI8MyiS91t5S30DNQC2K6GzP7nIBTS7NHXH3iWX9yF4rfgnEswZAdwR9p9FX85rvG
         m1L5f6r9p7KqEBF31nxioIX5HxijXTZ5d3Po7tYYDDwKqtgsp0ZHHnmWvemWcp7ENRva
         8ADYlByaLoMBR5LVXl6X7WvV4zOlqVsvZ/MEQ3FPCUsufbM2ln1WVe9h3Gpt2r3JtNPs
         1Yph/ZfbsoM3JxzZUewKBQqSYx/rB8RWmfjN0VdVOujkCghIU6KGEHuYzvrtym167Dk+
         HIIw==
X-Gm-Message-State: AOJu0Yz/ZJl3uLHFNTZQfiN2dAHXsZk7Geg5MmeGWzwj/Cd/EFaaIJ/w
        qNWOAWAFGOhhKd+UA9yrV9Hc+2Ol55E=
X-Google-Smtp-Source: AGHT+IEo3A/wCZ16UoBcr+LOZ0b64oyb+QBIj89uLbI9n5j0vlNtE3H2i0EV2GGUokZUhV2he9Y/Ww==
X-Received: by 2002:a05:600c:d3:b0:402:95a0:b2ae with SMTP id u19-20020a05600c00d300b0040295a0b2aemr3520447wmm.32.1694240180032;
        Fri, 08 Sep 2023 23:16:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c00c500b003fe2de3f94fsm3640215wmm.12.2023.09.08.23.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:16:19 -0700 (PDT)
Message-ID: <c00f4623d0b97cc8ed71ea018e6ecf6e21739b53.1694240177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Sep 2023 06:16:13 +0000
Subject: [PATCH v2 2/6] trailer: split process_input_file into separate pieces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Currently, process_input_file does three things:

    (1) parse the input string for trailers,
    (2) print text before the trailers, and
    (3) calculate the position of the input where the trailers end.

Rename this function to parse_trailers(), and make it only do
(1). The caller of this function, process_trailers, becomes responsible
for (2) and (3). These items belong inside process_trailers because they
are both concerned with printing the surrounding text around
trailers (which is already one of the immediate concerns of
process_trailers).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/trailer.c b/trailer.c
index de4bdece847..2c56cbc4a2e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -961,28 +961,24 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
-static size_t process_input_file(FILE *outfile,
-				 const char *str,
-				 struct list_head *head,
-				 const struct process_trailer_options *opts)
+/*
+ * Parse trailers in "str", populating the trailer info and "head"
+ * linked list structure.
+ */
+static void parse_trailers(struct trailer_info *info,
+			     const char *str,
+			     struct list_head *head,
+			     const struct process_trailer_options *opts)
 {
-	struct trailer_info info;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	size_t i;
 
-	trailer_info_get(&info, str, opts);
-
-	/* Print lines before the trailers as is */
-	if (!opts->only_trailers)
-		fwrite(str, 1, info.trailer_start - str, outfile);
+	trailer_info_get(info, str, opts);
 
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
-		fprintf(outfile, "\n");
-
-	for (i = 0; i < info.trailer_nr; i++) {
+	for (i = 0; i < info->trailer_nr; i++) {
 		int separator_pos;
-		char *trailer = info.trailers[i];
+		char *trailer = info->trailers[i];
 		if (trailer[0] == comment_line_char)
 			continue;
 		separator_pos = find_separator(trailer, separators);
@@ -1002,10 +998,6 @@ static size_t process_input_file(FILE *outfile,
 					 strbuf_detach(&val, NULL));
 		}
 	}
-
-	trailer_info_release(&info);
-
-	return info.trailer_end - str;
 }
 
 static void free_all(struct list_head *head)
@@ -1054,6 +1046,7 @@ void process_trailers(const char *file,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
+	struct trailer_info info;
 	size_t trailer_end;
 	FILE *outfile = stdout;
 
@@ -1064,8 +1057,16 @@ void process_trailers(const char *file,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
+	parse_trailers(&info, sb.buf, &head, opts);
+	trailer_end = info.trailer_end - sb.buf;
+
 	/* Print the lines before the trailers */
-	trailer_end = process_input_file(outfile, sb.buf, &head, opts);
+	if (!opts->only_trailers)
+		fwrite(sb.buf, 1, info.trailer_start - sb.buf, outfile);
+
+	if (!opts->only_trailers && !info.blank_line_before_trailer)
+		fprintf(outfile, "\n");
+
 
 	if (!opts->only_input) {
 		LIST_HEAD(arg_head);
@@ -1076,6 +1077,7 @@ void process_trailers(const char *file,
 	print_all(outfile, &head, opts);
 
 	free_all(&head);
+	trailer_info_release(&info);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-- 
gitgitgadget

