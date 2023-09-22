Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDB5CE7AB8
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjIVTvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjIVTu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:50:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E919E
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-403012f27e1so29576665e9.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412249; x=1696017049; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oqDlv0pYbnxTSwUOs2MM78aq6xaarznF51jwKGW4Rk=;
        b=hwLgmzFqfTZR69fwTMvzdaL04/5R87SSfuWd9VfpVaxp9vnKoiI8Mj8Pz2ovGehd8/
         w/Tovm/gadgi0KXjajZh3VZ1MY3h61K2CkdcplbKgaJ38YBlwIn5dDClNWnZ+11ocB8r
         R5IpoLNKZDvdfLWkYh+5giQ0EhrTQDmBL+u4+dsywNgdw8Jx7/rB89g6aDMtaMi5S6Du
         33RXuHbZIjqtL+3dOWertfz5fm9K4jm0M5Vd2oL48gMRJL+4NzF+q46e1HyxQPFMelIk
         amnRK/pSpMmKFUr4mA5sm5hClRNfkmazIyQsizsenAsE+wSzilFkdzPwNfd8JXt0Y3KU
         xIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412249; x=1696017049;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oqDlv0pYbnxTSwUOs2MM78aq6xaarznF51jwKGW4Rk=;
        b=NFkX202h9xaDMBX+lLkgMhjJiSATW90W1lEc+YUK4wahxb/9T/VpEX9z83O/a/cJ1J
         oRB/qzoInrGKtRLr3RG5wnY9B0lDtKbckSaS+zjaMUtwdEIJmWzYQyYiJgKbzciW9zvg
         H3ClCvaZkW56rt5FdSo4TDkdy7lJyMHsDZ46XJCkWnalntoSxtmzIObOwxC4Gkz5zXSd
         0j3sZkrVQgy+eOymMXixCrqfOwixacB284W5cj4dwF+E9DplxqaidGQVNa0dv6eK8Ym0
         RFCjA0a7s9HCR6gVKGC+fmlj1XQK4vJmklACHlTphzaCTyIIwya+WkVUthvT6Rh+hdg6
         VIsg==
X-Gm-Message-State: AOJu0YwC6gjs76N0CZvP0Y9KFtket3a90fbCToPqy4vnVI4Joe9gBopr
        fIljnvsgiBQ8clynojjdSMbCNY8OiDk=
X-Google-Smtp-Source: AGHT+IECFTVbExb5zSRQftBy0ey7ROgeVXOLhg7rF0TzqDmxGGKhMlfIWm+0CBG81FOOMOH1qBj0Yg==
X-Received: by 2002:a05:600c:446:b0:405:34e4:e754 with SMTP id s6-20020a05600c044600b0040534e4e754mr197805wmb.32.1695412248737;
        Fri, 22 Sep 2023 12:50:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c05cb00b003fc06169ab3sm3386177wmd.20.2023.09.22.12.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:48 -0700 (PDT)
Message-ID: <f78c2345fadb37e10feb3a18aabb536357549790.1695412245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:39 +0000
Subject: [PATCH v3 3/9] trailer: split process_command_line_args into separate
 functions
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

Previously, process_command_line_args did two things:

    (1) parse trailers from the configuration, and
    (2) parse trailers defined on the command line.

Separate (1) outside to a new function, parse_trailers_from_config.
Rename the remaining logic to parse_trailers_from_command_line_args.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/trailer.c b/trailer.c
index 2c56cbc4a2e..b6de5d9cb2d 100644
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
@@ -1069,8 +1074,11 @@ void process_trailers(const char *file,
 
 
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

