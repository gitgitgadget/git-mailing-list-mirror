Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11BFC7EE24
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjEPGfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjEPGes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A9468E
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30796c0cbcaso9965289f8f.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218871; x=1686810871;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Axuwz5jkldTe0vO8FKJacAVKxAeMa9U/RSS6hK1PFw=;
        b=b7i7gPrDXQaEVFwuDliGkikvijmtIF9y088F2CSwiKBbvx05bWBd1zKn2vfBMButOU
         hkPB2Rwk/CzXQvnD0+OcGObk+dRrDmceBlqGTRgJmOmMnr6OZJUL/qhNOBCMgUaIfEpu
         wayLWJXLMH09LdHZVFz6fLI/qGG//sFDiQf+7LsfotkoQEuIndlUrLROI7l8O9IrB1QD
         E4y6rEZz91ysEtK+yAk1kLNJzyLO9NSlJqm8CQbB0xSORH1ycdslx/RVnGJmrhqBeXO7
         UQjTItSPk9MzdH1rlXTT9o2sL3QARUfW9VIvj46r3miFnkdqCqQlhMGWtMN3T6dI6M8w
         XiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218871; x=1686810871;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Axuwz5jkldTe0vO8FKJacAVKxAeMa9U/RSS6hK1PFw=;
        b=L5Okhto5vz+xn5T3M/Q1ae+kwvbOXKa1BzbyUG4ld3z3imqL0C1dzzrk2dXEeK2N3y
         7qdmF5u7kg5xV0QUpCbvbotCprD+zoc0MZ7RgeDz2HkMrT4AJmo21JX25Lk0qK/Z2il/
         8KGRc3r5K3T9hc7M9YMxa4dNBW69vX96I6azVY8A6EEtLYBzS60vF9bFs7lOEU/d7NVK
         Ft+UcyNW5iMixJvKIYB75kZhQrx3Jgvj61BcEoyxg1Q6hQGQIfTGmJLccyz3pDRBNixT
         Pdl1PXUlAzA1+eBJH5X45Hwv+oHv822e52pawDSM91qwaZ1NOteRN03bTPnJJwN2whDJ
         BhMg==
X-Gm-Message-State: AC+VfDzzGwp0/2Xifr5nNK+7ajSiPYISNQ0pYRN5uCFMqX7I7aqWJGez
        SQn5Ia3cnhUX5ucRB5QboSKNVWAxvcM=
X-Google-Smtp-Source: ACHHUZ47+imfmDR84do/YC+YyKCv1E2647OTJbVRwWQxqbuBcpnvF9kKS4q/C76TIspT64lkQfE98A==
X-Received: by 2002:a5d:43c4:0:b0:2f8:2d4:74ef with SMTP id v4-20020a5d43c4000000b002f802d474efmr28141003wrr.43.1684218871614;
        Mon, 15 May 2023 23:34:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5-20020adff145000000b0030631a599a0sm1403943wro.24.2023.05.15.23.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:31 -0700 (PDT)
Message-Id: <beb4287dd6532f22742c2415336eea381728fc2e.1684218852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:58 +0000
Subject: [PATCH v3 18/28] log-tree: replace include of revision.h with simple
 forward declaration
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

