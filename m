Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D991F453
	for <e@80x24.org>; Wed,  3 Oct 2018 11:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJCSay (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 14:30:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36904 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJCSay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 14:30:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id 63-v6so4788925ljs.4
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0+JdrhQja0hh+ABGqy2/FuhKSn99MdTvWYQdNpQ+kQ=;
        b=ArIdUlIhQZ/eCHOf8rEIusKiYOJ1ScmUaEZsMFdGLn9fEKYRCI6SXZ2GruSiuIXxup
         /Qu/OuodKodV++CaYh8TK//f6V5XEjmXii/4e0jTcLAmxgxeBEtyYkDfWF3RfIL6zrAs
         yshjJl/5JOKPnDP+EPkfn0l76j5jl7dd21YEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0+JdrhQja0hh+ABGqy2/FuhKSn99MdTvWYQdNpQ+kQ=;
        b=mDRoqMbU69r3tjM3GJ7sSRu37yzOj27cJqmGDHKHPlxG3TXxldFj8v7BOXMCx+Wt3j
         KZllt5ItZJUUvF11vLpWcjUcXQBcYXAZ7CGGada1aHNlNxqZan8qTJXQM+c1zJhJDNZC
         eP23el0BjrS1XVrcWV2nNY3cziw/CeR3aCC/1HQbobR5FnvDVGbM2YTzL7iw5ITfsK16
         uNtzplBDyGjzxpbsF+ADxyLA2XaW/mLqTMyn1Dw6h+G/jFhNIjQchboPtLJN+BFIViIZ
         ua4eARCyaqRFPYqPhA3avh95SDdhGLVD6IRUs3yHqGKo76r5fyDQqulCokJQKD/d75qT
         ElWQ==
X-Gm-Message-State: ABuFfoi57WVYUrpQ1jxn1aoTAHUuUjq/diZVO44Yi3gbpS/owd4+2LMh
        zVZdd1KMKox/OY334B+rxCBZW1a3bV+bQxMl
X-Google-Smtp-Source: ACcGV617R5YDemG9Cy9/YvEmm37EWg34vcWaT85fUU3ksvh9mjXWbE+H/BUki+HIKuuhqed/KiXnkw==
X-Received: by 2002:a2e:44d:: with SMTP id 74-v6mr856822lje.146.1538566969883;
        Wed, 03 Oct 2018 04:42:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f22-v6sm279500ljk.11.2018.10.03.04.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 04:42:49 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v3 3/3] git-help.txt: document "git help cmd" vs "git cmd --help" for aliases
Date:   Wed,  3 Oct 2018 13:42:42 +0200
Message-Id: <20181003114242.9858-4-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
References: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181003114242.9858-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This documents the existing behaviour of "git help cmd" when cmd is an
alias, as well as providing a hint to use the "git cmd --help" form to
be taken directly to the man page for the aliased command.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 Documentation/git-help.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 83d25d825a..86a6b42345 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -29,6 +29,10 @@ guide is brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
+If an alias is given, git shows the definition of the alias on
+standard output. To get the manual page for the aliased command, use
+`git COMMAND --help`.
+
 Note that `git --help ...` is identical to `git help ...` because the
 former is internally converted into the latter.
 
-- 
2.19.0

