Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136CCC001DB
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 05:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjHEFFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 01:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHEFEp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 01:04:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6564ED8
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 22:04:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so4773736e87.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 22:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691211883; x=1691816683;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVU3Q/+XSVqi+X/JV8eH4hrNkFtGZzIN3enFRILoyHI=;
        b=iborR6Jannnm4FAn8+UUB0jEYE6Lb9gzBLgyjZJB26Q6y8aHqOLe2zzCN9tXdOCcpv
         Zoqq06I3+XzGkmtvPELT8/Ifc9yMfKcE4Isubr8VwHxOGTZPHYrSzzefaUZRr+IUVFSl
         he2OV89usx/uJMdKsC1isdJbfcWyQeyErbmsff0EcIDaTcLZC+mwDR8BZNYwHT6Nfbnt
         +3Ldr/Rg0kHwMDQ7HVjYuMKoJ7XWN3TupA5qkWKBlPEdu2XGqMNk+gz9TEtU2NPaEBbs
         GI03dXlcFx5OoaK3c4BKSy82KX61BLRvXYjqXd0t7F+bEZtoDM/wCmOUr67O8banIsqg
         1xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691211883; x=1691816683;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVU3Q/+XSVqi+X/JV8eH4hrNkFtGZzIN3enFRILoyHI=;
        b=llHtMY+apEfRrK+cKuiaWQLrOzw1o96XXyZjtKvKZ3AiIZXqojLJUNvbLkefurPY6S
         Rn/YoZ61g1i1p86T9QNm5Y938v+59pnW0vYDuXJeDJ3LXlpPuMaWbJx6JPGPamNZ3oP4
         S4gqmAt6nK+BhfcZ7RGq1kVFuNEvyjATPju+zhzZGyNwIYB467Cb7v7j37yHVxnfJJlH
         gELDw999hPV6d63Bl9cmBdmPNkJLJpi93i+iwUK/5qGcxgzbNG3KS1hWGkGWl8EvlJDD
         QhxKOnhoHwjosjKj+hS1ptlNnq9RCnenJ4FD9xFtvinNqyVBzfyrJxjOtM4DusCfoelC
         n80g==
X-Gm-Message-State: AOJu0YxPdt3Vs4REIW6imaYQpvNCtx/3oDlKY1tQCQMAZg8Y0KWbakWN
        zkn7q/XISTkTEAndg6TDIloxnkTC4Vw=
X-Google-Smtp-Source: AGHT+IGIofkhhTDpAg9urek4os0132okhfK4Ap3iDJ0hFOPvVDK2muQ5u+iyzY+1XtcX/tEGPBQZiQ==
X-Received: by 2002:a05:6512:36cd:b0:4f9:571d:c50e with SMTP id e13-20020a05651236cd00b004f9571dc50emr2361575lfs.36.1691211882540;
        Fri, 04 Aug 2023 22:04:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1-20020adfeac1000000b00317643a93f4sm4125652wrn.96.2023.08.04.22.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 22:04:42 -0700 (PDT)
Message-ID: <c8bb013662187e9239d4a2499a63ed76daa78d14.1691211879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 05:04:37 +0000
Subject: [PATCH 3/5] trailer: split process_command_line_args into separate
 functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Previously, process_command_line_args did two things:

    (1) parse trailers from the configuration, and
    (2) parse trailers defined on the command line.

Separate these concerns into parse_trailers_from_config and
parse_trailers_from_command_line_args, respectively. Remove (now
redundant) process_command_line_args.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/trailer.c b/trailer.c
index 16fbba03d07..89246a0d395 100644
--- a/trailer.c
+++ b/trailer.c
@@ -711,30 +711,35 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 	list_add_tail(&new_item->list, arg_head);
 }
 
-static void process_command_line_args(struct list_head *arg_head,
-				      struct list_head *new_trailer_head)
+static void parse_trailers_from_config(struct list_head *config_head)
 {
 	struct arg_item *item;
-	struct strbuf tok = STRBUF_INIT;
-	struct strbuf val = STRBUF_INIT;
-	const struct conf_info *conf;
 	struct list_head *pos;
 
-	/*
-	 * In command-line arguments, '=' is accepted (in addition to the
-	 * separators that are defined).
-	 */
-	char *cl_separators = xstrfmt("=%s", separators);
-
 	/* Add an arg item for each configured trailer with a command */
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
 		if (item->conf.command)
-			add_arg_item(arg_head,
+			add_arg_item(config_head,
 				     xstrdup(token_from_item(item, NULL)),
 				     xstrdup(""),
 				     &item->conf, NULL);
 	}
+}
+
+static void parse_trailers_from_command_line_args(struct list_head *arg_head,
+						  struct list_head *new_trailer_head)
+{
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	const struct conf_info *conf;
+	struct list_head *pos;
+
+	/*
+	 * In command-line arguments, '=' is accepted (in addition to the
+	 * separators that are defined).
+	 */
+	char *cl_separators = xstrfmt("=%s", separators);
 
 	/* Add an arg item for each trailer on the command line */
 	list_for_each(pos, new_trailer_head) {
@@ -1070,8 +1075,11 @@ void process_trailers(const char *file,
 
 
 	if (!opts->only_input) {
+		LIST_HEAD(config_head);
 		LIST_HEAD(arg_head);
-		process_command_line_args(&arg_head, new_trailer_head);
+		parse_trailers_from_config(&config_head);
+		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
+		list_splice(&config_head, &arg_head);
 		process_trailers_lists(&head, &arg_head);
 	}
 
-- 
gitgitgadget

