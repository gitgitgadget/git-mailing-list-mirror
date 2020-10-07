Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FE0C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEE5207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVKUoU2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgJGH43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgJGH42 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 03:56:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675F9C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:56:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 34so848500pgo.13
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U4n2v+dJHIiHGZtBxeT6+F0Xumd7zVgfX09RJlpl2GA=;
        b=FVKUoU2cBLt/5ggMR5b4BUEggdjh/QicPDEv82iOORnRwQbCN6h3/z3nzNVGjFyCvL
         g5Eje0aJh0TTp7c4n0jLAS+PSSmriTecrYmHOGE7plggr4HJoQlY40+onobn26zX7sOF
         nx071THsONNUh7nq0c1afuQafeyWJ1icSXVtrwSuI5P1QHelJvCoKaGJOnINxNM6OizG
         QybMIRA2U+8L+02uhAxUINnmqg5cqFRPEFpzObnY3N42hE2cvKTGx4avJwu3MwWu4sQQ
         VHPCfux7U6y44rs5Y3zDnmuYP45EeLW3rtErOzjOSqp1Nf1VJNfAo7IbPWYexesnm6Vs
         HQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4n2v+dJHIiHGZtBxeT6+F0Xumd7zVgfX09RJlpl2GA=;
        b=YYv/uJLTeJrZTpbWTDmAgMp7YXOM2UBcbDAud4wa4wXLg+fzT7POYL2aW0xED0XHHX
         mJrVjYOO1LvZCJ7gNKjHjDQbOIF4tGKlMolk6FySX3uucQxnGB4ZL+oaTSNjkxEyrQHS
         62jSpONxm9vxGGWzQrDWBgkozKM0VfCQsoRTRU3gKuL3VWUcQk6F7lz5q0wbh6YZjDA8
         z6fwmv+pJsaXdMDK22JFAEh1TS57Djxzc7wCL2UzihPnHRznhIdZ5Ic/WYcIA0b84Ge9
         vXGpW6NTtIVj4QzW0pq777+EyTmwwwlVI7yNcs/FOP1iD8Ti9w4euIbM8nzeqJ3tputM
         PL1A==
X-Gm-Message-State: AOAM530DdfCOedelJ6XZTOHlkUrFRGhCgwPQCxI7HyTRMOHo4v9ihdGi
        239rhZk0uQriUGxU3EyP+o4W+4F7sSY=
X-Google-Smtp-Source: ABdhPJyJSfUGfjoBEAt3prJ661U2gSkqKkHjvsIse8JwB7okGN14lmGBCyvDy7WnRg8Tw2jZWMHOUA==
X-Received: by 2002:a62:545:0:b029:142:2501:35db with SMTP id 66-20020a6205450000b0290142250135dbmr1894530pff.59.1602057387759;
        Wed, 07 Oct 2020 00:56:27 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id n9sm1909950pgi.2.2020.10.07.00.56.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:56:27 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 2/4] Doc: document "A...B" form for <tree-ish> in checkout and switch
Date:   Wed,  7 Oct 2020 00:56:16 -0700
Message-Id: <a0ed2f313d606bb889f0d7520cc38a38d72a9a36.1602057332.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1602057332.git.liu.denton@gmail.com>
References: <cover.1601814601.git.liu.denton@gmail.com> <cover.1602057332.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using "A...B" has been supported for the <tree-ish> argument for a
while. However, its support has never been explicitly documented.

Explicitly document it so that users know that it is available.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-checkout.txt | 4 ++++
 Documentation/git-restore.txt  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index afa5c11fd3..6ae8bf8dee 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -351,6 +351,10 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 <tree-ish>::
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
++
+As a special case, you may use `"A...B"` as a shortcut for the
+merge base of `A` and `B` if there is exactly one merge base. You can
+leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 84c6c40010..55bde91ef9 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -40,6 +40,10 @@ OPTIONS
 +
 If not specified, the contents are restored from `HEAD` if `--staged` is
 given, otherwise from the index.
++
+As a special case, you may use `"A...B"` as a shortcut for the
+merge base of `A` and `B` if there is exactly one merge base. You can
+leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 -p::
 --patch::
-- 
2.28.0.942.g77c4c6094c

