Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C9DC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DD160F44
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbhI1JMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbhI1JMt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 05:12:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A71C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:11:10 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so21220237otv.4
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRtAoP1syZyLmIxeGZtnMNTXV30+xMCVvhWxVYoxkbM=;
        b=ZeGiXg0eQe3NwKAeUlgpu0zlORHKFAkniHRh0iciAY9f+455p3BKkxNr7mC8lLCVW+
         iBAgPKT6oCSxUKbNeo3LRYq+FVU52bjW6HAamWlM4N7RsK1N+dB8v4Wlg5y1yNgCwQCm
         e8UcpL5C9GDvnhqpow5/+cisdNeGxLxs66YGX9f7IEE9BapZICnVTvaoznEXFoo9KYXz
         1yg/maIpcRcMCwaEp1LDE6ZWqk2W3BdgOeBFEA6oK1o8p9aIaTkENF4E5KnPD3AVd0bm
         0y3Rr3jb9GCj37h0XcYs22ZIdWhASyT0fQ1W/gOQRjw0c1sqNDvbH+r093c4wvtwpLTa
         iucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRtAoP1syZyLmIxeGZtnMNTXV30+xMCVvhWxVYoxkbM=;
        b=Q9n1XqhgMCvIk6S8OQZyeGWu6qoN9/YaftmsIBbWTqhqr7tvTJnP0Lr8KucDlHUtZR
         x7mwoO+c54J/boEKJmKrQ14dmuz7nrLk8KcpzCYflfBTpK464dIEzQZoIvCe8WkuCp2b
         lIg5WU7V2rcPNnpNWyDaPN03UByPAMGl30L4QqN8P1zK4zw03jiWc7oCceDAsWqcJDb8
         BfpC0Q9TVM/q+jmOLgpN3VQy1R/tWhAXv16KQANpYN0y/zW9pTmFZuiwJzTy0i7rzEVv
         2NaLRfb3B4MnhJ+cFyraiFxfBpphMDsSVDcjhdaVaurXgtCVpn8BMTW8oZrFgGS4aZ7y
         zAEA==
X-Gm-Message-State: AOAM533QOS/WKYJ+Ce0wnbvmQyjEH/yWJC4mdf9gtgOmZMnSLORqGyqh
        cNKfj28WU89kBE4i0mc7R9dTy1YOsXcKhQ==
X-Google-Smtp-Source: ABdhPJzlC14/MZg0eX1IRMftEZUJEJgmljztz3hQbio2Y09wuEaXswn0gZD74ibUcFYODlyXsO1YIQ==
X-Received: by 2002:a9d:64c8:: with SMTP id n8mr4170031otl.188.1632820269416;
        Tue, 28 Sep 2021 02:11:09 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r23sm4441250otu.54.2021.09.28.02.11.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:11:09 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, avarab@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] config.mak.dev: simplify compiler check for multiple compilers
Date:   Tue, 28 Sep 2021 02:10:54 -0700
Message-Id: <20210928091054.78895-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210928091054.78895-1-carenas@gmail.com>
References: <20210928091054.78895-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1da1580e4c (Makefile: detect compiler and enable more warnings in
DEVELOPER=1, 2018-04-14), includes an $(or) of two different filters
to check for both gcc and clang versions.

As shown in a previous patch, a simpler syntax is available so apply
the same logic here also for consistency.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index 90c47d2782..b66fae8665 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -31,7 +31,7 @@ ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
 endif
 
-ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
+ifneq ($(filter clang4 gcc6,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wextra
 # if a function is public, there should be a prototype and the right
 # header file should be included. If not, it should be static.
-- 
2.33.0.955.gee03ddbf0e

