Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4E4C77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjEGDqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEGDqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C921884E
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f423521b10so576435e9.0
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431163; x=1686023163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST0fwY7y3AT9WtPSXWaBBn71IAShr0kXfKKXOHLsZdE=;
        b=Dk7ezvIY0F0LEJSWIXwqZJZcUp3/dH6jIBYrKDWsnFL9d2KFzSkqdjifLUnji9QcFP
         osykB7aciM4FboUJcF7YPM3vdzbS5HUKxGZdelRuHS68/DA14WWPnsIJujVEUNEOMYuX
         82D7clX5EJ1hiTTrSZWNHpKwY4zl/b3ux5CaVde/cLYRE3TlEQt5WbfUSXXX5saQ67vY
         fVeOonUyz5Vub5F7tuX2nKxwH8BRAFrV+kJqy3CCeSMunhYVv5/vXIB1c0QJtX8+RsDJ
         /kj3OEE2+9OMN0wHE2EG4KPygZ8DzP7WfRqPVlEqRQsWTmgbmV5m4wQWRDvXUCC91/zy
         UOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431163; x=1686023163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST0fwY7y3AT9WtPSXWaBBn71IAShr0kXfKKXOHLsZdE=;
        b=lgoPGvqBU9Of9iEvnUusMVt9YncRYAp3r0I47kbfPXz1KF9GQTKV468v3XYU1+JmRw
         seWfjCAh3LjVQ/eIcx1ytvqqhF9NTMhLkhdTA95izmPwnSR056xWE180wUlwYSwqspjU
         6fI2foDLiSKdDBPL0nLjZHKDAjx59v+umm7ZXjEZ6VKZRnjA9Ju+aB7Ipq+Z1HuqfD8S
         fYGNtCqa/Hq9LGUfG8l5YCwNm6hK67n/gW0FrCqjh5ifXRG25Q0Z4IxhYpVsNMJHpAoz
         IzeT/WKfvmufG35Gsh2fwtf6MLSqWSbfZwd5UPVYG7a00CsJofS2zo/oR5xPYYYfd1ql
         NH6g==
X-Gm-Message-State: AC+VfDwsXG5SWir82jlGDqwTJMStIi6fgXfRlRgu4zilSg2gJ7JS0QqG
        FEe6bKrd8CdSpXwMmrpq3l7PsFdxVS4=
X-Google-Smtp-Source: ACHHUZ4RLXKDtPbYVk6ukb0n7a5SbSdqKbDDx610SaoBltxR3WqJIjwSTXz3Bcs5Eehmit3IoWtqmA==
X-Received: by 2002:a05:600c:20c:b0:3f1:70cf:a2d9 with SMTP id 12-20020a05600c020c00b003f170cfa2d9mr4196599wmi.9.1683431162835;
        Sat, 06 May 2023 20:46:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b003f1978bbcd6sm1980607wms.3.2023.05.06.20.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:02 -0700 (PDT)
Message-Id: <41baa22c5d66fff520e30f904480ea3f66a8439d.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:37 +0000
Subject: [PATCH 12/24] diff.h: move declaration for global in diff.c from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h | 3 ---
 diff.h  | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index b79802a4639..08f6fbd801d 100644
--- a/cache.h
+++ b/cache.h
@@ -523,9 +523,6 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, int include_sparse,
 		       int flags);
 
-/* diff.c */
-extern int diff_auto_refresh_index;
-
 /* ls-files */
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/diff.h b/diff.h
index 3a7a9e8b888..29a9cd217c2 100644
--- a/diff.h
+++ b/diff.h
@@ -694,4 +694,6 @@ void print_stat_summary(FILE *fp, int files,
 			int insertions, int deletions);
 void setup_diff_pager(struct diff_options *);
 
+extern int diff_auto_refresh_index;
+
 #endif /* DIFF_H */
-- 
gitgitgadget

