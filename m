Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA8FC43332
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784AA20777
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWs8JOJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgCUSAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:16 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45390 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgCUSAP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:15 -0400
Received: by mail-ed1-f43.google.com with SMTP id u59so11090595edc.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zwz9fp8GDmEutq5JqvT/Jch8IMQfRIsjqwWjfm7JQM0=;
        b=CWs8JOJzgppZRNQVj+xLeRTLP24mF2zkMF2Z+zWnB5MXeeyOyztuCwy1PKe8rmrMsn
         Fanc6QJ0/qaGxHPhrcR4tViu5biQO/RSuFE896UnJXOo63/HXD9xAiRYN/GgyAu3kbpd
         ZKMHLytFolbsab55hrW4CYYDICedidOC+QsoKsqLvORzRI7RcKOJoYmID7tB9rQyf8Mr
         Y+XdWSJkEqTy7WlfjeoImBd7DOn/G7Lo9Bv974+U1ap2WPxC5iIK8QMwSBcsD89IWqrS
         7fK2AO1Qb9QK7UOGtNKPqi4tAzKLusW9XH9WczA2RkPo+hoOQ+lx9SsdAx9fyo5fRTyX
         LbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zwz9fp8GDmEutq5JqvT/Jch8IMQfRIsjqwWjfm7JQM0=;
        b=PjRbAX8YZDDupLtCMIi3UFr6mnaa0BghSVKfsGh3RI3frTzI7oB379J47lrF/KZI7G
         KtPxFKsNJff54hNZe75gnu2H4yjuX9IPRSr1cadXlwo8I6net6idCPqn/1KfVR7Ap42E
         IuYoaGTRl7f/VRO/SE4KzEh2lbLPY5kLTCeSPXO0H5PLeJC2sOgUqgLqaMhg526P/g+2
         RaI7nJHEHftWl+EIGYvQeUBA2FFmXYJZKRyUBvUaY+IeGIANILAXgjzbBFvQYL8Cg0Xn
         lxF6MSf/+6qln1cB13+oJ/syDmW1ojQJjiRVwgxxedSD1lai6eWf1AAp7hUcZU0crgVX
         Cozw==
X-Gm-Message-State: ANhLgQ28ksCn4HcqC47wFVxfoy7zl43G7yHpcieQ6nHLPXFab9XJDLjX
        ruV5LwjENwdYNoWP1VAFevsvFDrb
X-Google-Smtp-Source: ADFU+vuy/RJJ3VNyctslz4/+tg3Xk3o7j+3IFenGPRTMzELT8gvuXzCDyM86653zRHb4EJmHmuXDtw==
X-Received: by 2002:a17:906:3fd4:: with SMTP id k20mr13267973ejj.51.1584813611804;
        Sat, 21 Mar 2020 11:00:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e26sm600277ejh.32.2020.03.21.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:11 -0700 (PDT)
Message-Id: <e6beb1c5810391274676e4ed0cac78e7e02b804b.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 17:59:53 +0000
Subject: [PATCH v2 02/18] unpack-trees: remove unused error type
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

