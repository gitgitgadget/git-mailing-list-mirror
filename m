Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28506C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E28206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYlLjRAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgC0AtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33088 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgC0AtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id w25so6110291wmi.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iD+URmCch3dlpKunooFhgiXiFTPoxlpEZUdcXCIDs+s=;
        b=NYlLjRAjlns1Hlx2RSPy3NUa20Jl8SydbsD5Uz1xepr0MjGz76Ajgz1lAeOEIrOeON
         VTI31OyXqZf3Yvdc9khb7VPbXkybQNmt9zCpnnqBRm5kAk0BvWHk6iq+HheW1/zpmxZf
         DtxFinI5CIxXC+nm6a/zOM+pwxKuRiuVcze1No3B3tYs+3V0fN/ovqXxbi678QDbF56w
         StL/8bvmsjtwoS0VAo6MzIt/rJCmmrlgPZpIF0Ra1O2HPbX0zgUzSlWdIrY5TvOX1JEM
         LD45mWn0Zr6kDHNbPEgdcuUyjTma9fPdcUy71XSXUndVmcJIYQh8kCX7X/bc1LlPt9M5
         FuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iD+URmCch3dlpKunooFhgiXiFTPoxlpEZUdcXCIDs+s=;
        b=aWv0fkFzOhXV9aqqxxNpAOjHF63SMUDr0jo+cJxC9rs37OFR5tcSet3YOx7mMf527m
         qjUluEj4/MjAoQ4PLbXZjqhawr5ELavCkbxJ1jwaYNV2gwQa6CHuCrTkt+N0znd0k6aM
         4BTozWvs9jj3REjJB20Oz+9fV+7uQOGHsOFH4COY3qf4GA79d99Sr1vjNdkW5A4NdXjt
         J+UjRudslG0E1uZo64aCRXtyHMAyZNFfOjGGUqomLM7prBl8ffW/F8TR/gdAiImK9Ax0
         QLzVzz5Opz0j+LS61nfaRHkJjq/zue6the5Ka+O5KUi7g6fk5K9sE2hhPQ6oTwCxKoXV
         pccQ==
X-Gm-Message-State: ANhLgQ3nEcHUhTYFpmaP+GR7QvksR0CVQ7kQzCgmuHNnx8hEkrnGyAQC
        ZncOs/KsVQss58DVOPy8icQfmT76
X-Google-Smtp-Source: ADFU+vtLawSlUE9UCmud61Az3T6clXQA4RTdY2qOuNg/CUKQRAukjvVaL5DCPv3RQacyuXyh9L7Gag==
X-Received: by 2002:a1c:6608:: with SMTP id a8mr2519184wmc.113.1585270148664;
        Thu, 26 Mar 2020 17:49:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm6026647wrv.76.2020.03.26.17.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:08 -0700 (PDT)
Message-Id: <10ec70fa697e060ddc65c1245f73e37612edefc2.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:50 +0000
Subject: [PATCH v3 07/18] unpack-trees: do not mark a dirty path with
 SKIP_WORKTREE
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

If a path is dirty, removing from the working tree risks losing data.
As such, we want to make sure any such path is not marked with
SKIP_WORKTREE.  While the current callers of this code detect this case
and re-populate with a previous set of sparsity patterns, we want to
allow some paths to be marked with SKIP_WORKTREE while others are left
unmarked without it being considered an error.  The reason this
shouldn't be considered an error is that SKIP_WORKTREE has always been
an advisory-only setting; merge and rebase for example were free to
materialize paths and clear the SKIP_WORKTREE bit in order to accomplish
their work even though they kept the SKIP_WORKTREE bit set for other
paths.  Leaving dirty working files in the working tree is thus a
natural extension of what we have already been doing.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index dde50047a82..e8e794880ab 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -500,8 +500,11 @@ static int apply_sparse_checkout(struct index_state *istate,
 		 * also stat info may have lost after merged_entry() so calling
 		 * verify_uptodate() again may fail
 		 */
-		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
+		if (!(ce->ce_flags & CE_UPDATE) &&
+		    verify_uptodate_sparse(ce, o)) {
+			ce->ce_flags &= ~CE_SKIP_WORKTREE;
 			return -1;
+		}
 		ce->ce_flags |= CE_WT_REMOVE;
 		ce->ce_flags &= ~CE_UPDATE;
 	}
-- 
gitgitgadget

