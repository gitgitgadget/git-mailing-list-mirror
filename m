Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B482CE7ABB
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjIVTvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjIVTu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:50:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785ED1A5
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so2595421f8f.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412250; x=1696017050; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmgqWi7Cs5VukM9Vh3fswTlGXwbBtsWGyteqiqH/Gdg=;
        b=guI8NbHXuo4SAbktQgbfAw356lbedAlZLv6MT0aEroab7qN26LXT0wGvIQIgoHzS4h
         nQYBbLcnRCEFW81ZDLPlGEbDsBqNOZGRQonejr/pLPE5mGorZxzRg/1DXvM96kjotYlJ
         MQqBVueHwZnyLZXRDXphY+ivh0Qv7rzQA8SoU9Eo4z8pt6js5oSxAQR0YIQ36PY1Qnx2
         1fA4enKXMY5L0a5lX/bQJrfuf83KSHIzD+bTEuVbXh+xSCpSORzFGNvCy/6rRXPdHte0
         0jjLRCmG/M+x/Su6UBVFxZ3wAOz0bO5gjtKlxQyLqvNzudyvJ8h4T4kWv2j9P/jQZKa6
         oSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412250; x=1696017050;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmgqWi7Cs5VukM9Vh3fswTlGXwbBtsWGyteqiqH/Gdg=;
        b=d+c4LmBuilPaBVgg1lt9F9CGxuj84IFL12hPK7K9uNpcT+4BkEjsAFMN7ByWEKS8IJ
         6cAl+kW2M7f5GNx3GI58uO2mAQDY9mSMPyqS5dYIuNdN98f25Kbz4Clxc/PLe6peTY0S
         NqZ7N0NNEMBwIv9/jzTEXe8/gfaJHFKk980+6ZTH3KyNEKy1C6h62XonRUMIbH/DSiQh
         4cE2N1yoGY9NsyiFDgSX+q/Qpro75MwAVSmJU7w1ZAP8/+VgpvLm1ysqqzeLqIqc8Q8t
         fpV77Zwax30DiKh1lu2eWAkNS7ZvlXZhoTIYNZRBKfWacHgpmwysGbIMzePQZ2HbzxaH
         5WWA==
X-Gm-Message-State: AOJu0Yxf6Dczv+5YOs6rCF1kkGpJ48flxyMfDqn/MzvHmuGRcZtlHyiG
        WXFX/LhlHlxs2qSaSmELJyZCT3U+W5E=
X-Google-Smtp-Source: AGHT+IGfn3Iea6vjy7I5uGpKs1/2d43+xoyLaWCytEbSU+7r1AGdSid2tGIqaF8W5XeYv5mWkRMW0Q==
X-Received: by 2002:a5d:4011:0:b0:320:371:afbf with SMTP id n17-20020a5d4011000000b003200371afbfmr650423wrp.10.1695412249413;
        Fri, 22 Sep 2023 12:50:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d68c2000000b0031431fb40fasm5197699wrw.89.2023.09.22.12.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:49 -0700 (PDT)
Message-ID: <47186a09b24522bacf459006330fd469766072f2.1695412245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:40 +0000
Subject: [PATCH v3 4/9] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
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
index b6de5d9cb2d..0b66effceb5 100644
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

