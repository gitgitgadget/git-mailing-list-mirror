Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028EDC2D0E7
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF938206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYwSiIzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0AtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:06 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:53178 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgC0AtG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:06 -0400
Received: by mail-wm1-f47.google.com with SMTP id z18so9819010wmk.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Ao+d/tKNKgUrYNtOhoOth8Mw9Bm9lN98qlt1FAbRb8=;
        b=nYwSiIztOZXPjJpdfjjSqcoyXjzD6YLsEp5IQIC928u/xWcqg6oxkZhDuEj0PcVXS9
         AdsT4Sf42ZRUkV++WzouCHNozQFhMo0E1v5ye7L1b4v3fsWHuP0VrP6ZWfmbrI1nhH/s
         Wz+NOk6xtxSR7tgKjjiL1KewQT4RDtwFtKNUSMEfyNJPafyf6/pegNOT1okQfuN3PImc
         UUEcRvNYblYturA8tqFmNlRdOuqFBvEfkUAAQXsQcqLklIwrANKxioO+ShgiFczXaiKA
         8V+CQHflVIJ0G9HwCz+90XjV4f73ChpuBTu8rZv+6TQ24u0z/rrvEXCzXhRTyVMqVCyD
         Ll7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Ao+d/tKNKgUrYNtOhoOth8Mw9Bm9lN98qlt1FAbRb8=;
        b=k3o+HKvbZg4N9sjVHWQfv6liqPapnXJVr6RDK1DSUr8/aGQ48Hm+VPDvqUPjJT0Jnt
         6K8NtzayZ8feTEUmPebuM3pxdnhl244/3ALMqelcGsqcpBwk604t5PGF6JVZRjgm8PK5
         ANFpuNJqbgVO/3litK2GdbrEk+yIddTDgg+dcNrrys86abGZgufcyqd1bswn7q+xjplP
         f6Tzi+qEkPjMbLw8lGEOEBsnP/b82zWquxuJRZJ3segbJfcnOsTOA84NvkLJmV2ghFka
         8vGtagkgj5/mLGfeUMI1/RvSrdxnoYnStMGTSZvv8buMpLQTsp635ONcQeCvsFUr54+S
         9gEQ==
X-Gm-Message-State: ANhLgQ0UJXLxzzw9fqd9XixQ+nDLt4y7K8eZcXXEyAx/q22lRnBy+hat
        ZZmRFdsSwZoquy0YfRtwFqqG3qGK
X-Google-Smtp-Source: ADFU+vthYfErFwMwTIW7rX9nDWzPnIKKfxOSGnBCwJiMNXxgIxrjdLDK+3R0yamsOf08w3etO4QntQ==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr2606964wmc.116.1585270144923;
        Thu, 26 Mar 2020 17:49:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n186sm5425029wme.25.2020.03.26.17.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:04 -0700 (PDT)
Message-Id: <1dc36eb33f7879f5553c2bb28c516022d040e12b.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:45 +0000
Subject: [PATCH v3 02/18] unpack-trees: remove unused error type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

commit 08402b0409 ("merge-recursive: distinguish "removed" and
"overwritten" messages", 2010-08-11) split
    ERROR_WOULD_LOSE_UNTRACKED
into both
    ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN
    ERROR_WOULD_LOSE_UNTRACKED_REMOVED
and also split
    ERROR_WOULD_LOSE_ORPHANED
into both
    ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN
    ERROR_WOULD_LOSE_ORPHANED_REMOVED

However, despite the split only three of these four types were used.
ERROR_WOULD_LOSE_ORPHANED_REMOVED was not put into use when it was
introduced and nothing else has used it in the intervening decade
either.  Remove it.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 4 ----
 unpack-trees.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 0d0eec0221e..f72a7a21f9c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -49,8 +49,6 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN */
 	"Working tree file '%s' would be overwritten by sparse checkout update.",
 
-	/* ERROR_WOULD_LOSE_ORPHANED_REMOVED */
-	"Working tree file '%s' would be removed by sparse checkout update.",
 
 	/* ERROR_WOULD_LOSE_SUBMODULE */
 	"Submodule '%s' cannot checkout new HEAD.",
@@ -172,8 +170,6 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		_("Cannot update sparse checkout: the following entries are not up to date:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
 		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
-	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
-		_("The following working tree files would be removed by sparse checkout update:\n%s");
 	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
 		_("Cannot update submodule:\n%s");
 
diff --git a/unpack-trees.h b/unpack-trees.h
index ae1557fb804..6d7c7b6c2e0 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -24,7 +24,6 @@ enum unpack_trees_error_types {
 	ERROR_BIND_OVERLAP,
 	ERROR_SPARSE_NOT_UPTODATE_FILE,
 	ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN,
-	ERROR_WOULD_LOSE_ORPHANED_REMOVED,
 	ERROR_WOULD_LOSE_SUBMODULE,
 	NB_UNPACK_TREES_ERROR_TYPES
 };
-- 
gitgitgadget

