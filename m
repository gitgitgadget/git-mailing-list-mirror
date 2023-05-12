Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947A0C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbjELHFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbjELHEw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600F65B9
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-306281edf15so8957158f8f.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875091; x=1686467091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Axuwz5jkldTe0vO8FKJacAVKxAeMa9U/RSS6hK1PFw=;
        b=H9mhxCK7ei2FNPng3bRzJ1PjC2lTS4r3dnjtmLsy6AYz/P6u3xUcQLx7Tx9CLoYTr8
         x66sejaE9LxxvubRMYDoEHW1lT5pHMbrzGDdo6dlNaOjJM9l4zo6iLcyOmNBJJviZPWT
         A+bhk7U3AVZ1aUfwu0WUAS5gAjfv7gKOtgarBqNBBgXTUbwQDwcXTY+wdajbKSG64H9N
         gU1wU48slOY6TOHBr6AMWgcS+HkJBn+Y+DgEgTcFvcOW0g2BKXw3qKuJUFA37Vkhi9J7
         rC80hfQtGOSwwI8qCLWNeZmlr21oy8g/jft6ANEtRI5Yn3ZFPd4oMFLZS0XIlPaDnxnl
         aIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875091; x=1686467091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Axuwz5jkldTe0vO8FKJacAVKxAeMa9U/RSS6hK1PFw=;
        b=E0JnsJBzX3GAk/9X/Bk4RC8xlcO8hOTkh8mTUcKUSYqGD4T1avyXZMl2l+Mmaa2sLX
         xCTPuk8tCX783JeBQwl9pMpL1xYW6/LcH9zVGTlikt1PfSZabdodETOPzGDQ3o7Z7FbS
         taLNXL4OeZ43zUKLoyGSTUqugB4eKhgX/gj90iqeNclI5RDVi7Vsroy3uA1wvKEjHfrf
         tucozPK0qz+Qr1Vz6iD7ke5DTRp19vlk38tyAFC5X2lFsCpy7RdSdDfD9yjvNa30qeU4
         PvpaGHX0uBNxBSZzPLOIy8/gIzgewms2HsVfXGiOVXKVaE8k2Ik6dALC9YGfWUqxQ8a8
         Ff+A==
X-Gm-Message-State: AC+VfDyRkcRY6hNvl9niOdBNzjAvLccewHd8DXXQf7KrZ4iTGzvAs3UN
        N0ZV5NcIK5xSXFhxmZrcQCKz/sXJBZg=
X-Google-Smtp-Source: ACHHUZ58HgIfk/5249wVsUDScoTyrA55wprSvPgS8X1pj9td5kxnwH+5lGMqEMAKtHcthgdcWiqRlA==
X-Received: by 2002:a5d:58c1:0:b0:306:41d4:475a with SMTP id o1-20020a5d58c1000000b0030641d4475amr16493499wrf.19.1683875090891;
        Fri, 12 May 2023 00:04:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17-20020adfe3d1000000b00301a351a8d6sm22713963wrm.84.2023.05.12.00.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:50 -0700 (PDT)
Message-Id: <ea21839a95aa8e66c5228f80a3a188f07c992293.1683875071.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:19 +0000
Subject: [PATCH v2 18/27] log-tree: replace include of revision.h with simple
 forward declaration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/diff-tree.c | 1 +
 log-tree.c          | 1 +
 log-tree.h          | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 3e281150473..4ad55ecc3fc 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -9,6 +9,7 @@
 #include "submodule.h"
 #include "read-cache-ll.h"
 #include "repository.h"
+#include "revision.h"
 #include "tree.h"
 
 static struct rev_info log_tree_opt;
diff --git a/log-tree.c b/log-tree.c
index f4b22a60cc5..07d0b47b168 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -16,6 +16,7 @@
 #include "reflog-walk.h"
 #include "refs.h"
 #include "replace-object.h"
+#include "revision.h"
 #include "string-list.h"
 #include "color.h"
 #include "gpg-interface.h"
diff --git a/log-tree.h b/log-tree.h
index e7e4641cf83..bdb64328154 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -1,7 +1,7 @@
 #ifndef LOG_TREE_H
 #define LOG_TREE_H
 
-#include "revision.h"
+struct rev_info;
 
 struct log_info {
 	struct commit *commit, *parent;
-- 
gitgitgadget

