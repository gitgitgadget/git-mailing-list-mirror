Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A66C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D77E2076E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAToLCzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgCUSAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35351 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbgCUSAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id a20so11164113edj.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tFjWYQ6TxRb0kG9aPWL9ULeisxhgKFroJ3GFDS2mMCQ=;
        b=SAToLCzLF6xEtJX0LKKAyUH4m0DG32DA5IFuhbhnVfMunVjlDYW2vlZkS0wwaxPSnB
         TgUIbfIomaZlsZoLkZUP2/5K3kuahITKViA6uw8IouVCw8+Zi5XEwKuJxkNGzsvc3xzo
         /L4mFCFPlNkxA5gpv0yweDB1ZsIVDkt1mk4N8vne/x/h3WbSpqCOS7zSGSr6AlnZCOY5
         rLsYQeISbQKPSdIjj5Psr4Eg03nsS9eeQEIlkOiIaD4izZ5mMc4ThmVYBxjkyI+ElM9w
         6GezqNtvGeYgojniIOeN8tJ9nD4vVKzVucH7KDx1a0/ZPeJEzfV6UYNlShmeiVPZqwpl
         tNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tFjWYQ6TxRb0kG9aPWL9ULeisxhgKFroJ3GFDS2mMCQ=;
        b=NnCS3gB/jeA0Qrc63DDSr0M39+v8pchZkv3MHjUN6RgtHDN5+mCzZC9RB3NBBIXMLu
         g0O0Ket8Yqis5GwJzpFmnjinpceJlcBgnsygo2pZlYoZ4LYhby2mbYQVCMTYHo88vKwh
         kMGgSYh2HaInnfgnMLkte97npHe/UNkiA/q4H5c//buvA1jTaM3lxcbVJ8fYrb6/gyP9
         qC4FsTDk/ar6yARKWShvEouQxvSj6PtjKawS9UGDWfi2krdZmr3K+nYIZvKntN/zVbWH
         BUX1HSgVdevImIbd6pFbYKuCDudRQl6g29guc8qxKqcTivrty4bMDb+iYsn+qwxdQKGO
         ASaw==
X-Gm-Message-State: ANhLgQ1+zolzne7SiH9R451QwiRbbQHQER2G6g1zyQvQCxaOmHflMZtf
        C+ge7p562/KFHCduNhzYEwkNgIU2
X-Google-Smtp-Source: ADFU+vvr6d/W++boKmvQIXfwHVKnlZMeGRuv0909EH10yyvpXaSgQ7OkwZosEjZ0ZranyA3oZ7QCUA==
X-Received: by 2002:a05:6402:899:: with SMTP id e25mr14054718edy.134.1584813612545;
        Sat, 21 Mar 2020 11:00:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm691448edt.43.2020.03.21.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:12 -0700 (PDT)
Message-Id: <739b52393fe595f11df557c28ef9f8aea60eca01.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 17:59:54 +0000
Subject: [PATCH v2 03/18] unpack-trees: simplify verify_absent_sparse()
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

verify_absent_sparse() was introduced in commit 08402b0409
("merge-recursive: distinguish "removed" and "overwritten" messages",
2010-08-11), and has always had exactly one caller which always passes
error_type == ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN.  This function
then checks whether error_type is this value, and if so, sets it instead
to ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN.  It has been nearly a decade
and no other caller has been created, and no other value has ever been
passed, so just pass the expected value to begin with.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f72a7a21f9c..3af2e126abf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -506,7 +506,7 @@ static int apply_sparse_checkout(struct index_state *istate,
 		ce->ce_flags &= ~CE_UPDATE;
 	}
 	if (was_skip_worktree && !ce_skip_worktree(ce)) {
-		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
+		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN, o))
 			return -1;
 		ce->ce_flags |= CE_UPDATE;
 	}
@@ -2026,11 +2026,7 @@ static int verify_absent_sparse(const struct cache_entry *ce,
 				enum unpack_trees_error_types error_type,
 				struct unpack_trees_options *o)
 {
-	enum unpack_trees_error_types orphaned_error = error_type;
-	if (orphaned_error == ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN)
-		orphaned_error = ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN;
-
-	return verify_absent_1(ce, orphaned_error, o);
+	return verify_absent_1(ce, error_type, o);
 }
 
 static int merged_entry(const struct cache_entry *ce,
-- 
gitgitgadget

