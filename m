Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E81CE7AB8
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjIVTu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjIVTu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:50:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966919B
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3214de9cd8bso2378508f8f.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412248; x=1696017048; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R6TUptbEq8L+7sFDFnVsmQFyJZ01GJ9BerfsfkEvVw=;
        b=GZhoAiJrnV/QO3ImVWD9twmRgpX1tMiS/r+r62sWX8KnY2nR32QTsFad57iuOiXNv7
         PIoCBpN3P0bZlWZf1JMtuuadq0pBlS/iV2TDoY6N8aNFHuuzK5Y1da5b+bcAnKgnmRlU
         uyj3kr5pz8HRp2i3Dl6QOKRP7lT2kME8QsGIHj4Ev/XhJ5/bp6bYBvqYBIWsraIr4rKP
         SwB935iMISvP2+/7OmWI52TClyh4lh8V57xEkeuyXKOq7fZKJ/9VyfQM3h2CP5KJCctd
         O+SMSSdnNMcyuXUyve62BcMdkoZ4xD1Eyy4AcWrizTPbKwkrguJoxI7flHqFlSr5T8NX
         a9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412248; x=1696017048;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3R6TUptbEq8L+7sFDFnVsmQFyJZ01GJ9BerfsfkEvVw=;
        b=hp7/uTe2EWQ17eAO5qXxYQseILwUdCf2wHVIHQBHSaTig7teripr5y0/bmg5p2cwX+
         2MsKMCh40Mi7gjmzHJq/k+8ywlImZaPbBJZjczmem0JxjHXKeX3xCwyHNR6tyqGAz8f+
         R6cEetuAGUU4QYufCofLoDw/P9pk0xrNe5SI365cMyuTCSPgzgaUxhxZ7rq0fl7tdxZQ
         3tUNeC2TxzXJQ+fbTHgxVpvu4g6VcjiHS645jsJ4h9Jbwa5/PxaUMjNweBQzf3dy6lWX
         n6Oi3JtJmYATUfK4Rm/5ZcQyGSAPsZ7WujZ7bwDlvbxLxNdxv9g2UE+j+UofRwyvkBec
         GVrw==
X-Gm-Message-State: AOJu0YxulfTH+Eae0ix8UCjlVvSIEjaPvAePbdREX9n8UQoyRHs97IlB
        d0Fgp2cn1XHIAY96JzaoC7t19kkr0p4=
X-Google-Smtp-Source: AGHT+IFyzo6hFpjdIdWN0qykJ0x70HkFj830YP3T0vKrp61BpKLjzPHF7GycHk8wcnNeOCTK1SqJBQ==
X-Received: by 2002:a5d:5605:0:b0:317:5351:e428 with SMTP id l5-20020a5d5605000000b003175351e428mr786628wrv.4.1695412248017;
        Fri, 22 Sep 2023 12:50:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d69d1000000b003141e629cb6sm5172525wrw.101.2023.09.22.12.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:47 -0700 (PDT)
Message-ID: <c00f4623d0b97cc8ed71ea018e6ecf6e21739b53.1695412245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:38 +0000
Subject: [PATCH v3 2/9] trailer: split process_input_file into separate pieces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
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

