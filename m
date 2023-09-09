Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2789EEB57F
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 06:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbjIIGQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbjIIGQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 02:16:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6535B1BC5
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 23:16:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so30844245e9.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694240182; x=1694844982; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9TBO22WdmhUcup4vB+50zpiXLDf7pi6UKvkIeRRTsQ=;
        b=eCnKfkhnL8VFtCVBhD+A92OpOyN7hWrMN9LjkGbGaZblgf8s2zOpsB+t1Qf0YcRW8A
         DQ2oyQV3pLiZxbpsAbRRk93ASh8BxdFH2VEsrzjRpofLdEI6YcHf1Iy4DFXj3kvnJ0z8
         TJEyF/OT7og3c5YYcXRrodbaCE5PUfBIC+WSb8XD/spxot1ysVN9/Ush7TuoQJ6Mosb2
         XQ7Ln5b08D54EiC7sExgnwPdO38slHzrKKRCl5LYblL8xJBFpWwpF9fNdQCmGOUV179o
         nZDV5ApYB7M2vr9zxhQt7b3psTLhSKjoDdRTWhq7o/nFbiyLpY5wwHM8HkHkZ7nIG/Tz
         JTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694240182; x=1694844982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9TBO22WdmhUcup4vB+50zpiXLDf7pi6UKvkIeRRTsQ=;
        b=nYa+YlZQz3f1ffl7RrQIhrJo3UCmYxqrr36dmTPMCcJO2iuI6FDqlxD91qC5nfRb4u
         OgsINCY3TIN4k/yjag5EzPkaq6SUBjOBpsxawydp7EJD6qMMjMGDta6BHmWmaeOH9TkD
         LjJd758Wa8X/unyaPuo3iEJ4NvQtx6iKwov8qaQDzPh5VEjr52PAaXsy68RyhXazE5FE
         ydtFXTulT1jD9Ra7hFG4Xvb11YNzGIF07K4twacFuIrIfPiAHN831cxV6fiJ+tE4PU00
         lY7hMYxhx4NCFYbXuGspkkcXm2KY4bvMu4GsyGwbgRurnWra7wSFpGKlXBL1sXtKFRCg
         0Uug==
X-Gm-Message-State: AOJu0Yw5wdVPIzqowfN9tpZ2HakuwwljUyouxn4OLkxHR4IZMMU4Dmgz
        eV/um9M/e8dZR3ORVgmX9J0PXt7epu8=
X-Google-Smtp-Source: AGHT+IFwgCEUDH3y9uQIhABHNhegEBgNdIa1Lww/MayM9lAWMGvTHKDk1wSZzSspUDj3vlqrKJq7BQ==
X-Received: by 2002:a7b:c01a:0:b0:401:d3dd:c3c with SMTP id c26-20020a7bc01a000000b00401d3dd0c3cmr3590582wmb.39.1694240182407;
        Fri, 08 Sep 2023 23:16:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003ff013a4fd9sm3701856wmc.7.2023.09.08.23.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:16:22 -0700 (PDT)
Message-ID: <52958c3557c34992df59e9c10f098f457526702c.1694240177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Sep 2023 06:16:16 +0000
Subject: [PATCH v2 5/6] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
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
    provided. This concept of defaulting back to the configurations was
    introduced in 0ea5292e6b (interpret-trailers: add options for
    actions, 2017-08-01).

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
index f646e484a23..6ad2fbca942 100644
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
index ab2cd017567..a689d768c79 100644
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

