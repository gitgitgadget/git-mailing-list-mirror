Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8794C54EEB
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17A920777
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly2fYp2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgCUSAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39314 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgCUSAV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id a43so11137031edf.6
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WKyMbICXXu4py8EyrS2Ci4+xXXaTe6+FuLlCBcIfwEw=;
        b=Ly2fYp2Ca02FKuUBTSiy0tpFv7EsRCRq3FbAyoHVopYVsatP4x4LwGwgOarLA7NhV6
         Bv0Y9XDBZPia3HW6Ip86449yXZUisMs1q9crbJmdZ8fkb4Ch4oin+6N2jgqTX/VwWBfy
         J/jKUu+HdSFiSSINPxP9fRWJnxSNmJGzc1fkfO0rxTyXNGMQnal3Oa3M84LFG5C6KRPg
         oLtP445rczVmpIgcUyenc6qFl78cXHAyAypYH/pUBHvMcKgJoR6rCEqZCC3RFNs/dJj+
         bnXley/JAs/3o5tZYKfeYBcLrPnLjGsFX/fD6q+GQxRDu+uDO8ruv39N3eNcI4xMj0Mh
         x7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WKyMbICXXu4py8EyrS2Ci4+xXXaTe6+FuLlCBcIfwEw=;
        b=taYK+s9G0PXBPvckcihAVAW7IdsggavPFSs3pdGOcAhabx5L1tqkFlE2J92n7kMUMa
         1paClcDblDt8ftxrl8vQhq5RqWFh8bzVAcmvRxBpvFc49xUj8bqlg75sNbKoM1ng9/yr
         +QeHx6HLaes5h78kvI4jMwjY0yfvorVa3pNx6kV3zDzUnamooxDnpvxlW2dKPQ1HjBhX
         xIK7SmOgkEReV1d0xTG+LChtSzFILjlwurfR0gvVB+YyZT3vJ1TIHUuvXmoeJ82/w4Sg
         CI82Y1nwSlWEjVP7+bs4/2GpgHHlYVH4FnVDuhb4Crik78+wHqRmsyGZm/dkkQ6T378A
         JptA==
X-Gm-Message-State: ANhLgQ12CV/66Uo+paryeUWicadWr1DrTkkKLWyYdT6KtOniyfpbY11O
        m1hroakcXldVOagg64kqOvR5Mw8H
X-Google-Smtp-Source: ADFU+vu5UOsoBx0Kzk3hT/+nrZVewnzAMW3HD8qM7dUZcqCoTIp9OnUwqpIMvK+/lft0GuFogYI1dA==
X-Received: by 2002:aa7:c755:: with SMTP id c21mr13599115eds.222.1584813620018;
        Sat, 21 Mar 2020 11:00:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ci22sm409273ejb.41.2020.03.21.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:19 -0700 (PDT)
Message-Id: <203ece0ec2fc7b0e214f8bcf356e299d1bb8f202.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 18:00:04 +0000
Subject: [PATCH v2 13/18] unpack-trees: rename ERROR_* fields meant for
 warnings to WARNING_*
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

We want to treat issues with setting the SKIP_WORKTREE bit as a warning
rather than an error; rename the enum values to reflect this intent as
a simple step towards that goal.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 12 ++++++------
 unpack-trees.h |  8 +++++---
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5c99d588dc3..0554842580b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -46,10 +46,10 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_LOSE_SUBMODULE */
 	"Submodule '%s' cannot checkout new HEAD.",
 
-	/* ERROR_SPARSE_NOT_UPTODATE_FILE */
+	/* WARNING_SPARSE_NOT_UPTODATE_FILE */
 	"Entry '%s' not uptodate. Cannot update sparse checkout.",
 
-	/* ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN */
+	/* WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN */
 	"Working tree file '%s' would be overwritten by sparse checkout update.",
 };
 
@@ -168,9 +168,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
 		_("Cannot update submodule:\n%s");
 
-	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
+	msgs[WARNING_SPARSE_NOT_UPTODATE_FILE] =
 		_("Cannot update sparse checkout: the following entries are not up to date:\n%s");
-	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
+	msgs[WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN] =
 		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
 
 	opts->show_all_errors = 1;
@@ -509,7 +509,7 @@ static int apply_sparse_checkout(struct index_state *istate,
 		ce->ce_flags &= ~CE_UPDATE;
 	}
 	if (was_skip_worktree && !ce_skip_worktree(ce)) {
-		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN, o))
+		if (verify_absent_sparse(ce, WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN, o))
 			return -1;
 		ce->ce_flags |= CE_UPDATE;
 	}
@@ -1876,7 +1876,7 @@ int verify_uptodate(const struct cache_entry *ce,
 static int verify_uptodate_sparse(const struct cache_entry *ce,
 				  struct unpack_trees_options *o)
 {
-	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
+	return verify_uptodate_1(ce, o, WARNING_SPARSE_NOT_UPTODATE_FILE);
 }
 
 /*
diff --git a/unpack-trees.h b/unpack-trees.h
index a656bbf810b..3c6452fe9e5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -23,9 +23,11 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
 	ERROR_WOULD_LOSE_SUBMODULE,
-	ERROR_SPARSE_NOT_UPTODATE_FILE,
-	ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN,
-	NB_UNPACK_TREES_ERROR_TYPES
+
+	WARNING_SPARSE_NOT_UPTODATE_FILE,
+	WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN,
+
+	NB_UNPACK_TREES_ERROR_TYPES,
 };
 
 enum update_sparsity_result {
-- 
gitgitgadget

