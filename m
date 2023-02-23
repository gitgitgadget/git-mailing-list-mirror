Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D2C6379F
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjBWIGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjBWIFl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D16648E0F
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t13so9841983wrv.13
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4X8dIcN+pCagJlgAf6jZFO+KisEH6zY6nlgFheTPYw=;
        b=Jyy24hU+9EED0PxifpK+XRBMiD1K+AyHVEfjE10d0NiAyX/YeTnqiI/3BgtRipE0TS
         3EGvXZMQfH2b6qUMqTfd2BWBCrVG2lj+ar9ttJEKMrmEpe6ffWiXdaqRY8trktcslpv6
         iQP41P19izj1H7gt0uKwbWpEsb8Nw4YSIWX/B8eN4UOPz/QMl2yBRTdjbeYR3Xi9BtFb
         CFabJAYcdw96LbAUWprparzLr7lSuwXPLVmbdieNTzZ7t7LOariNvZS6EtgtAPsj8A/3
         6niwptxPuTMhMokCJrPW9veTu9165HvRMXP56MafOZTWd3VvaQlFyrZLcFY1OF3BZMm4
         uK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4X8dIcN+pCagJlgAf6jZFO+KisEH6zY6nlgFheTPYw=;
        b=6d47lkSjtZ9by1+PCN1efJ8oalXzv2LBpbShbPG3W9OROhECn6jx4y3MJy3QqUPKLe
         nYe+giHDBKMPx4m0wOKTf0LtsiND4rs9ervLHKRPf132HajMi9lXqVB5LBonUHN3pLq/
         rcVdgmUKr/5ypIZTdphuy07EHnuh+cwtAAqWrRIvfb+nASuOgWaZPJ9b5FUgE+bXcJGW
         KSGmj0p+mKBBV7l5x6g3RqSVrdCZjwovZ3AF3ppYdeQCzz/vpjdX08zJhiZUYMXXPvSr
         wnFZeFYz48ZpYnd6yoBnqOgsn309TTgfH40wVA1mrilrPreCI+oDEGCoa0vnPuiIKfQm
         hgMA==
X-Gm-Message-State: AO0yUKUOX0HeRNwWlWW4qULJEu2OE8ENkKaoO1D+sWYY/65JuaGjg+T/
        j+6FIyQkJ+6ZR9tCmafQ9vbqcYzUV8A=
X-Google-Smtp-Source: AK7set++20dqpm2YVMrEwbPY6oTxxVxEMRxvCZwL8qj6iyD9fwwg3UQXA3H4SJZojNPP73TT9J9caw==
X-Received: by 2002:adf:cd8c:0:b0:2c5:4f2d:d9b4 with SMTP id q12-20020adfcd8c000000b002c54f2dd9b4mr8434295wrj.58.1677139529591;
        Thu, 23 Feb 2023 00:05:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003de2fc8214esm10185103wmf.20.2023.02.23.00.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:29 -0800 (PST)
Message-Id: <a3759d887d28c4e2eaa2fe528853087b05bcda26.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:13 +0000
Subject: [PATCH 08/16] pretty.h: move has_non_ascii() declaration from
 commit.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The function is defined in pretty.c, so this moves the declaration to
a more logical place.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 commit.h           | 1 -
 diffcore-pickaxe.c | 4 ++--
 pretty.h           | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/commit.h b/commit.h
index cc2c5da7bdb..06657b4c6e7 100644
--- a/commit.h
+++ b/commit.h
@@ -205,7 +205,6 @@ void free_commit_list(struct commit_list *list);
 
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
-int has_non_ascii(const char *text);
 const char *logmsg_reencode(const struct commit *commit,
 			    char **commit_encoding,
 			    const char *output_encoding);
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 03fcbcb40ba..13c98a7b5e7 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -2,12 +2,12 @@
  * Copyright (C) 2005 Junio C Hamano
  * Copyright (C) 2010 Google Inc.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
-#include "commit.h"
+#include "pretty.h"
 #include "quote.h"
 
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
diff --git a/pretty.h b/pretty.h
index 9508c22f030..921dd6e0cae 100644
--- a/pretty.h
+++ b/pretty.h
@@ -153,6 +153,8 @@ int commit_format_is_empty(enum cmit_fmt);
 /* Make subject of commit message suitable for filename */
 void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len);
 
+int has_non_ascii(const char *text);
+
 /*
  * Set values of fields in "struct process_trailer_options"
  * according to trailers arguments.
-- 
gitgitgadget

