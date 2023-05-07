Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303FC77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjEGDrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjEGDqh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C11940E
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so7474675e9.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431166; x=1686023166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Axuwz5jkldTe0vO8FKJacAVKxAeMa9U/RSS6hK1PFw=;
        b=k/SiK1KXepjwdMm/iR0418Y3x6Bnl1iTb5wI2uCF5m3YPlquyWNvRkxi8TZo178dgr
         LmIbHzRPuCN5fRSWqivpOy0DFiGOU4CTUVLFUd8ICf3N3SOLygjllqQhK1vxENYQRO9C
         KuIlh5VEvB+q2S4t2ksmRrert+1KsUvpzGuckQ0NpXYZs8NI+QIydmOsJ98UBWqEEoVR
         waQmCjPnW/Gib8DwzS834UowfgH/tSP8Iaq7/YhbDOpdnRv3GeUKkTHCCbUKxrnFPZXu
         IPXsuz+F+hvbZpon6nfbrJz+HkeEp+Cnl2zgYTEypyNpt0Bj66yQtpUXWVja5r7nG4+7
         B70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431166; x=1686023166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Axuwz5jkldTe0vO8FKJacAVKxAeMa9U/RSS6hK1PFw=;
        b=lWit98+wL2sqzsnvSh9sWROA0d6qqAhG0ub6IHPSY/r2mARev7rG5c+Py7uDT08Wjd
         CUnP280gCOOL+QSeFAO5tMtgWUKjZOfeUKu9MxZZdVTFaO6IrTXiwNPJy2Y6ucid4QWZ
         6DSqZqXdqpSKQR5OymaN/d6CvOSvIbYbccJzZ3iDbkJdv/m7Svfns4G2imY6X1Perxj0
         WNumj9hURuuEw2z7NKGJTPEDt8WQDnr3/1JdsTr+7IhOPd+PbzDGPgbsQ52//dxRCdH6
         xokM6IAoompw8An4AE5iRMEIIJfqEqbbDKnOnXY4tGHRo0RR9Y5/6d56E1K/cfu+CarK
         TlKg==
X-Gm-Message-State: AC+VfDwCjt/GNjmStMk5qvfzHlMNAZ8ZRbQoVcCnZIGAUEt+XR6aL7Z1
        3UNAQhKoXcC8kKfxD2kLUpWT5cHnioU=
X-Google-Smtp-Source: ACHHUZ7dcjtiFw0uwdGngeJDl81JLbz1cnCy25QDHQM2ATV5l6jsCWv9B26yK90nSO/n5PTNh9gYGg==
X-Received: by 2002:a1c:7c03:0:b0:3ee:3e07:5d26 with SMTP id x3-20020a1c7c03000000b003ee3e075d26mr4077088wmc.24.1683431166416;
        Sat, 06 May 2023 20:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10-20020adff54a000000b00304b5b2f5ffsm7005311wrp.53.2023.05.06.20.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:06 -0700 (PDT)
Message-Id: <1786a64367a75b5ebcb46c111910501e38219b91.1683431152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:42 +0000
Subject: [PATCH 17/24] log-tree: replace include of revision.h with simple
 forward declaration
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

