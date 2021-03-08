Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD156C15509
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38D36523C
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhCHPHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhCHPH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E7C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso4008006wmi.0
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CdqmR7KLMJeWPDXFpE59QQAr6eprHl1xZmch5w6tjaY=;
        b=PloEV3IWxSsKoH45X8dkiU0i/DKeScgKtpTSl4kA7mTatL4wgAy9zliIwWuRlLFRQ1
         dpIQgwR82RP+qkBzpnPyLmZajNLtlqioWPHV3vHRfuwk5qIrOr7JwhJHUZNdKQZpPt9m
         haRq1+9XQ5Du8065tVRrAeg1FzKCqLUnhJWkxTykN/7pQ2OihqOsa4GK4rrsTTr/r0Rc
         U1R+eFDPy8j6MGlO7fpNwd4dHY70Uvd7pOVL7MpxLH+xjkNI8eVtpgap+XiR85Qf+G9z
         v0KsI1qmr8woTw06m/T6gWggcONlxVSlTlouzCwx73lIicd4fJlx79mov8EsjlCt21M0
         uECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdqmR7KLMJeWPDXFpE59QQAr6eprHl1xZmch5w6tjaY=;
        b=mjV4/uyTWyjNV9khL9BtqF5CDrAJHSrxUICP8ZwYNBsInRr26LumwTzqVFjJY4iE3i
         YDolSbXWmZl8C90CwIewq45ZLBXIqh77lLCYNiXjZqpQCgTIpey5b6bUi8dk9uHzQjWo
         k1EzRTUb/I+s8TiUUjR9JEqcIWajBBdH9cwUqgkQrgv/GCBUWqyRTgZc3VBvvNef1Cmv
         oTtCnjYKJupxcf4XcEWfu2EsClqgwTwBtDea+kJ/8GXxkRIZZGnwODsaLbAMcdO6/OYO
         Qhj9iZ3g7dO82f+QZ2/fBQj4lGBZmcB36aTSpf14Hjh9x9Vv3ukxWqW8YH06RYJ5bQd6
         CA1A==
X-Gm-Message-State: AOAM532czz+behqYuuRTY6WMIwqL0EK13Ypj1M2+2yvHHN9WmnOzsIaG
        Ilmql+ZQzY0DEMR091oxaXOJ8Zsjvqrx8w==
X-Google-Smtp-Source: ABdhPJwEYdPqcoBsCR+zd7QC/LRCSW/dK+X6pin/8rNrVNGJ1KJKCXQC5XVYFRghbxfpl7sFWT6zXA==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr22736455wmj.73.1615216041436;
        Mon, 08 Mar 2021 07:07:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/30] merge-ort: correct reference to test in 62fdec17a11
Date:   Mon,  8 Mar 2021 16:06:36 +0100
Message-Id: <20210308150650.18626-17-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a comment added in 62fdec17a11 (merge-ort: flesh out
implementation of handle_content_merge(), 2021-01-01).

The test being referred to here was moved from t6036 in
919df319555 (Collect merge-related tests to t64xx, 2020-08-10).

It has also had the plural of "mode" in the name ever since being
introduced in 5d1daf30cce (t6036: add a failed conflict detection
case: regular files, different modes, 2018-06-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4375027914c..e54be179bd5 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1079,7 +1079,7 @@ static int handle_content_merge(struct merge_options *opt,
 		/*
 		 * FIXME: If opt->priv->call_depth && !clean, then we really
 		 * should not make result->mode match either a->mode or
-		 * b->mode; that causes t6036 "check conflicting mode for
+		 * b->mode; that causes t6416 "check conflicting modes for
 		 * regular file" to fail.  It would be best to use some other
 		 * mode, but we'll confuse all kinds of stuff if we use one
 		 * where S_ISREG(result->mode) isn't true, and if we use
-- 
2.31.0.rc0.126.g04f22c5b82

