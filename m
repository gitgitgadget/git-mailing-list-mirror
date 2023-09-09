Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6A6EEB57F
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 06:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbjIIGQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 02:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbjIIGQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 02:16:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C8B1BEE
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 23:16:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401b393df02so32034755e9.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694240181; x=1694844981; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oqDlv0pYbnxTSwUOs2MM78aq6xaarznF51jwKGW4Rk=;
        b=AYKooOcrufu5C1/ip1l+MOcH1ywI6ObKvDPY/6LY6JRiUkfN+aMbASuZi8zS6QlF0t
         TQ59cGG2s1xchBiSNJbi/XPaZLYmV71AgE0AL3AtL0AuY7CfARSZL6WiDuePiUoWV9xS
         QW4YuqQLI29YLCbCXmOe0Ha6LW/Ag5B/Z6ssG+JUNt6tIU18PL4Eeb9YIIv95cOBZgTn
         5nh90y/aSpFFKlxglXQkqA9VUkFv/IqqryBn2fQW0nB8oGdBb2WEU9rAHstxp7AuopRl
         LF3TSnjbNyvWDs589YrSEsLoNTL7g9Wws24YH7Uz6EwK3BhDEBnubs+siTcyMDQcmzJH
         /GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694240181; x=1694844981;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oqDlv0pYbnxTSwUOs2MM78aq6xaarznF51jwKGW4Rk=;
        b=QzzpaOnK6fe64/+c4Bz7uGrb17KV8mJi+A0H3zPruzA8CqXuYDRgxOo8eeL2/Fjeos
         gBMDzS1bxyONfAaD9gsPEW9FTvneeLsWmG8r45+3kUntBRheoslNnVtMoy7lXP5XigkV
         MQE0UaQUrfitSwrdFR0jcQ7pHMqnL8cDHA2ZRxtsssWw2tdwutV489SYvFvDQVDPVJ0W
         LZZ51n4tjRiVS9JSO7+gguJv90C/srKOvfxq9XuqTQbPfYGp3/uIlVwI+wAI4XTqd0JC
         To6vCPlKXW1+uEMRnBk4E06BNoAetW+bWK8oJJIggfLosHJhl/HheKXdivTNT1bfwxgJ
         YgUg==
X-Gm-Message-State: AOJu0Yw2yuE4mJIafKn/mjeTgKO/V4ysMnPqr1viz8KkpwiyVBuHr6gN
        NGL/lUc4PkMVrgNPGdm2LO5Ai4IEETk=
X-Google-Smtp-Source: AGHT+IHSgL4iv/aOdLe2E87JTJZhpEEXYCXzApd7RuYNh8+bHvdqeJetkNjRyHvJyK0wRlMKP8AO/w==
X-Received: by 2002:a1c:ed08:0:b0:401:d803:6242 with SMTP id l8-20020a1ced08000000b00401d8036242mr3840042wmh.27.1694240180957;
        Fri, 08 Sep 2023 23:16:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3-20020a05600c014300b003fefe70ec9csm6857951wmm.10.2023.09.08.23.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:16:20 -0700 (PDT)
Message-ID: <f78c2345fadb37e10feb3a18aabb536357549790.1694240177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Sep 2023 06:16:14 +0000
Subject: [PATCH v2 3/6] trailer: split process_command_line_args into separate
 functions
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

