Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F1BEB64DD
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 05:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjHEFFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 01:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHEFEr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 01:04:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8CF11B
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 22:04:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so24186475e9.1
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 22:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691211884; x=1691816684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1qMRW4vQEU0fI5SxPOedS4wZ4GleVwAJsylDKgKOHQ=;
        b=DKeyjGHQFHVEpwilVmaJFrdzjpVKjnWEC3tRRjoAmzJMms/KED9OoQDqayX9Ho03vU
         k+S3bX8+SSTblEHss+TWOEl6mbZHxkfZ++HUQL4WwIdiOF2FBtRLWrFm39YV1MrXv8N0
         6U4gaEJTW1NW8Af6yj95jVJZ8GkRoA4VOQEy8axsUuxnayQXhvKVT8cJyj7vA4qeTceb
         cebOwjI9y7pa5TKTJ+HsFdkCxfRaz59KuGxrkVY7OxZ3WLZ0RurPiLLkXhgPJD3Mo/to
         jRXAxP/NxlIgBm2kO4UulPXOkCHbJNAI8hIuzlmXOrxjFN0EBYZrb1CkvW39Lv6t07rj
         81ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691211884; x=1691816684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1qMRW4vQEU0fI5SxPOedS4wZ4GleVwAJsylDKgKOHQ=;
        b=QXXX2rbSTfQYAieql98LHnCdXMSm4z/4REUZppEbsCzI731FlVFP3CyOVwjoP2WZ6s
         eYeNZHYvO7q4jsmwhIknGNWHcvP/pQB2odj9gYigm61QWrw2mwAo4bASoJR3Z4IIWO2c
         b43uEoFu9e8bni82bCAs5S7k+c8tesiS/TvDF+8aXyw5Kp1qMowmy/6IWtHqU0fgaes2
         wuoZ7iKT8IfsuryVZVb+98ANtIt+8qsqlxWYZoIOkV2QR8eVFc6CipI2yYUICW/ButHR
         jJZlkwgfhiZSY+xTUQjSJDk7LCkEfZuOCLnkc1Kty52vSzOjxAJveb+1wb3WCeGSa9KF
         VHiA==
X-Gm-Message-State: AOJu0YyL9l1AF2eyVKQXfZRJFGGFqe2HXF90NA1BbMtzMSNkZVrNn4mu
        tPjXfNXPhQ7Qx9iioLGRcnQEGmTf94c=
X-Google-Smtp-Source: AGHT+IEAW2MxTbE2jKNgS8Sj7APz0R5hn6s1Dxs1RR9yuHRaC+ywmN6Do1/sRSugTaXwqBPrcx7TSw==
X-Received: by 2002:a1c:ed03:0:b0:3f8:f1db:d206 with SMTP id l3-20020a1ced03000000b003f8f1dbd206mr2477729wmh.25.1691211884009;
        Fri, 04 Aug 2023 22:04:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003fbdbd0a7desm8348699wmj.27.2023.08.04.22.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 22:04:43 -0700 (PDT)
Message-ID: <7c9b63c26164b037272fde689bb3150b30aa7528.1691211879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 05:04:39 +0000
Subject: [PATCH 5/5] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
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

Do not use *_DEFAULT as a suffix to the enums, because the word
"default" is overloaded. The following are two examples of the ambiguity
of the word "default":

(1) "Default" can mean using the "default" values that are hardcoded
    in trailer.c as

        default_conf_info.where = WHERE_END;
        default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
        default_conf_info.if_missing = MISSING_ADD;

    in ensure_configured(). These values are referred to as "the
    default" in the docs for interpret-trailers. These defaults are used
    if no "trailer.*" configurations are defined.

(2) "Default" can also mean the "trailer.*" configurations themselves,
    because these configurations are used by "default" (ahead of the
    hardcoded defaults in (1)) if no command line arguments are
    provided.

In addition, the corresponding *_DEFAULT values are chosen when the user
provides the "--no-where", "--no-if-exists", or "--no-if-missing" flags
on the command line. These "--no-*" flags are used to clear previously
provided flags of the form "--where", "--if-exists", and "--if-missing".
Using these "--no-*" flags undoes the specifying of these flags (if
any), so using the word "UNSPECIFIED" is more natural here.

So instead of using "*_DEFAULT", use "*_UNSPECIFIED" because this
signals to the reader that the *_UNSPECIFIED value by itself carries no
meaning (it's a zero value and by itself does not "default" to anything,
necessitating the need to have some other way of getting to a useful
value).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 17 ++++++++++-------
 trailer.h |  6 +++---
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3b9ce199636..c49826decae 100644
--- a/trailer.c
+++ b/trailer.c
@@ -388,7 +388,7 @@ static void process_trailers_lists(struct list_head *head,
 int trailer_set_where(enum trailer_where *item, const char *value)
 {
 	if (!value)
-		*item = WHERE_DEFAULT;
+		*item = WHERE_UNSPECIFIED;
 	else if (!strcasecmp("after", value))
 		*item = WHERE_AFTER;
 	else if (!strcasecmp("before", value))
@@ -405,7 +405,7 @@ int trailer_set_where(enum trailer_where *item, const char *value)
 int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
 {
 	if (!value)
-		*item = EXISTS_DEFAULT;
+		*item = EXISTS_UNSPECIFIED;
 	else if (!strcasecmp("addIfDifferent", value))
 		*item = EXISTS_ADD_IF_DIFFERENT;
 	else if (!strcasecmp("addIfDifferentNeighbor", value))
@@ -424,7 +424,7 @@ int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
 int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
 {
 	if (!value)
-		*item = MISSING_DEFAULT;
+		*item = MISSING_UNSPECIFIED;
 	else if (!strcasecmp("doNothing", value))
 		*item = MISSING_DO_NOTHING;
 	else if (!strcasecmp("add", value))
@@ -586,7 +586,10 @@ static void ensure_configured(void)
 	if (configured)
 		return;
 
-	/* Default config must be setup first */
+	/*
+	 * Default config must be setup first. These defaults are used if there
+	 * are no "trailer.*" or "trailer.<token>.*" options configured.
+	 */
 	default_conf_info.where = WHERE_END;
 	default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
 	default_conf_info.if_missing = MISSING_ADD;
@@ -701,11 +704,11 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 	new_item->value = val;
 	duplicate_conf(&new_item->conf, conf);
 	if (new_trailer_item) {
-		if (new_trailer_item->where != WHERE_DEFAULT)
+		if (new_trailer_item->where != WHERE_UNSPECIFIED)
 			new_item->conf.where = new_trailer_item->where;
-		if (new_trailer_item->if_exists != EXISTS_DEFAULT)
+		if (new_trailer_item->if_exists != EXISTS_UNSPECIFIED)
 			new_item->conf.if_exists = new_trailer_item->if_exists;
-		if (new_trailer_item->if_missing != MISSING_DEFAULT)
+		if (new_trailer_item->if_missing != MISSING_UNSPECIFIED)
 			new_item->conf.if_missing = new_trailer_item->if_missing;
 	}
 	list_add_tail(&new_item->list, arg_head);
diff --git a/trailer.h b/trailer.h
index db57e028650..924cf5405c6 100644
--- a/trailer.h
+++ b/trailer.h
@@ -5,14 +5,14 @@
 #include "strbuf.h"
 
 enum trailer_where {
-	WHERE_DEFAULT,
+	WHERE_UNSPECIFIED,
 	WHERE_END,
 	WHERE_AFTER,
 	WHERE_BEFORE,
 	WHERE_START
 };
 enum trailer_if_exists {
-	EXISTS_DEFAULT,
+	EXISTS_UNSPECIFIED,
 	EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
 	EXISTS_ADD_IF_DIFFERENT,
 	EXISTS_ADD,
@@ -20,7 +20,7 @@ enum trailer_if_exists {
 	EXISTS_DO_NOTHING
 };
 enum trailer_if_missing {
-	MISSING_DEFAULT,
+	MISSING_UNSPECIFIED,
 	MISSING_ADD,
 	MISSING_DO_NOTHING
 };
-- 
gitgitgadget
