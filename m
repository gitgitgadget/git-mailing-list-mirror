Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C4BC64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBXAKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBXAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:10:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63602302AE
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k37so7327275wms.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irEOlEc1lU4vJhiELaNbnA1GkGfzGfif8QJhz74IucQ=;
        b=cdVFjYeMFV5jjcKBNwSkHTyW5yTUvved+E89Y37gWIhzbQLLmCGKR9EOqUQg1hkcoW
         81RTw7QFgQxwBHDeeYSE+BkpWnab8wiD5bgMW3Up54FzgGAiy13c31Jlkv4ZD5tFT/Vd
         WJabfy+bE94ZQ4UhZr5h19BvlIhxwd1HwTIio/Y657aZ6UPlgkNIyZbXGvDK4fJFXSct
         ESJHZ5aao2Fl52Yi3QL13eqd8Qzd+mXS1I3K5KFoDg4lVMHuPMVFL4qLPN1hJYtkeWzm
         nbNUmKywCnhGmgqMegB5cPw9Mxhq9s+oe7jJnIeI2l7/JN9kNRR4YQkKUaQaDS5d3jtT
         7xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irEOlEc1lU4vJhiELaNbnA1GkGfzGfif8QJhz74IucQ=;
        b=A3lWNEHzQj4y2vlN+DELEwwZF/o25Wj4cjcllf3aA6MEes0KXccKiJP4xJggTekL+a
         j+k6oDE69ngX2w0j752jbEH/WRKtJZoD7ZGnXg2RbxyCA7feB92rYWoFdY4fDrlwFRRv
         Q71baHkD5g9z+sUWrmwUy9qLJqBMPbBlNEc+80po3eGhJ/zhfeIA2IuVsPVHxYoUb9r5
         IAuHbIarPt2pNMj5haklLELg3dtI/Uwhm3jVc3BX2wzC8RG6A2tGuo9RHCOcOGmRCJ+k
         yc2uf8M2PGnHH43dlRxIvbYUJl9oVJGfaKhqI+jXlbyRSIo4ClkBeyXu17XXYu0eWicq
         qPVg==
X-Gm-Message-State: AO0yUKVirST0ozB+L9qKPn9Nv9pjOSTdL7fIZZyC//WeqsIsMmQB0Bcv
        TLi164exeCYfAuEGEMgS7NTvCN+rKcM=
X-Google-Smtp-Source: AK7set/8SF52LTgKpP+W0zy5loWcpPhgqbJoJtsWyWMVqWKCwzzWX0ld1YkQFWWMLR3J9b4RP9CYMw==
X-Received: by 2002:a05:600c:1c8e:b0:3ea:e677:5017 with SMTP id k14-20020a05600c1c8e00b003eae6775017mr1293807wms.8.1677197392876;
        Thu, 23 Feb 2023 16:09:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ja20-20020a05600c557400b003dfefe115b9sm899765wmb.0.2023.02.23.16.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:52 -0800 (PST)
Message-Id: <97d3032346fc669b2cc7cd5e22a37c522bca8916.1677197378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:35 +0000
Subject: [PATCH v2 16/17] Remove unnecessary includes of builtin.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff-no-index.c   | 1 -
 merge-recursive.c | 1 -
 send-pack.c       | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 05fafd0019b..a3cf358baf0 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -13,7 +13,6 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
-#include "builtin.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "dir.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index ee144676b76..89731f40908 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -10,7 +10,6 @@
 #include "alloc.h"
 #include "attr.h"
 #include "blob.h"
-#include "builtin.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
diff --git a/send-pack.c b/send-pack.c
index 954104673f3..423a5cfe22d 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,4 +1,4 @@
-#include "builtin.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
 #include "hex.h"
-- 
gitgitgadget

