Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F249C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjEPGfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjEPGeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E14683
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4249b7badso96477775e9.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218868; x=1686810868;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST0fwY7y3AT9WtPSXWaBBn71IAShr0kXfKKXOHLsZdE=;
        b=avowM2IZzpSYwIj09VUhr7y9c4qs/2fHOy42sinyE06D9J6TdYYAl103pYOCg5X8sA
         /oCCKm6izmQ0C3oSFwDr9iEeEtOsRQoJvPYojVWBFsg2oxyBdfFaMUcKWyHX5kkB4iI8
         iqmppHSNqU7bQe56ILmQJxrfrw3wAgqYO6T83q40iDgp1pV6AAzJXgaYqTnfx3zsSqGn
         CiWjuN5nbZnYS8EfPpJqE63UFg15bhB0jjQH94AuazbzFVmilD18b7E+fcpSKiNOLOkl
         vZZc2Wx1zB0EBe7BPyJGF2i7rc9xLwZs/8uLfjS8PcMcxbEmDNEeQmrK2/aKlXkN9LH1
         xEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218868; x=1686810868;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST0fwY7y3AT9WtPSXWaBBn71IAShr0kXfKKXOHLsZdE=;
        b=AgGQmE3/WD/GrsjL4BQoUxQFTCutHslTvtD3/kR/u2U0cdaXiUt8SDAqOwe5u0mYYL
         1J/H3iG22eEoa8jYS6mZkkgJHDzERf/IZ3UycXod3n+BBYJxexz/vOQlsHIgd9N/tmxL
         aazkU80OVV/LUxs6e6KdQSZqEtGtz7ylyfGSBh5qZn8ideORA24oZH1jFyOG5NG/6fGV
         Q+zketDLUhFbJUFDAlKJ99Jv4aGBpU7bOMzEfp7RCrE8DHF5QgASuQIrXyMyNndgY5gd
         brvK7Fg7e/LisDzg4znCJq+Da4r/EJQfZ6WBNudnbuu9RrEjVAFnC4U10HYYpYq67Ols
         ChMw==
X-Gm-Message-State: AC+VfDwPjWJ86WMXbniCDrh2gYzHQHOCM3aYSc6scbFfu8r6m6qeKTo0
        5Gvj83hdwmgenC2F5rxvlxUA1LfGw58=
X-Google-Smtp-Source: ACHHUZ6wUyjaSGRVnMEmhC9jU7qPOLoVqHBE0cB+aGQ+nbI6+/9WZN2DTx0QQZ9bKcfgC6XN2m5PEg==
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id y24-20020a05600c365800b003f423743517mr19266616wmq.19.1684218868111;
        Mon, 15 May 2023 23:34:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t22-20020a7bc3d6000000b003f427cba193sm1088455wmj.41.2023.05.15.23.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:27 -0700 (PDT)
Message-Id: <2be96fbbe56ce92cd7e255636bff1e53d117dfd4.1684218851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:53 +0000
Subject: [PATCH v3 13/28] diff.h: move declaration for global in diff.c from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

