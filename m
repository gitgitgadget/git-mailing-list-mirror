Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82977C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601EB613B7
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhGJIua (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhGJIu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 04:50:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD5BC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l4-20020a05600c4f04b0290220f8455631so130154wmq.1
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0wvPaHN380yTCVx3BT8BXrOjaiHsKQQbUw48pjI65o=;
        b=touiZRh3z7rrfHN7P93lUiKrQjfQ2x6CdDuhh/3HaYOpTxnrQKf+3Q+WUi+7Dt55ff
         TKM+bT7xhv30gYsxu8GWwSnl1BfWHUUJTrULcNBDaycVAuEa6qbvHitcUhXkhUPxgVUz
         ONap8WG0U2gNok2rz2ZL88HuxzzFzS2bqpCEc5Z8phWAg6y3SZi9vWU6O5iZOg/ysE0s
         JkxLYfm8yeLpFK1hDngWX21lFyQasxZGY/T9htjiBlSpbNMjvv+8oiv7m/q6CuwSQmzJ
         6Cgh8admAgM8OmqqG7p1E685hRoCKgUj96e7PVOmp6b7KSHNaQPlMUCFD6Tcreo3dcza
         BijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0wvPaHN380yTCVx3BT8BXrOjaiHsKQQbUw48pjI65o=;
        b=fUReYBuaN7lYKaLF5TGN/2cfw+8ssYrzZYO5GJrIY46x/gUMHRKpTy+tD4HMR+qXaF
         /Lu2IDzSR1LItN+1Zp8lXCVlqfTudttZUDlgNGJLlm+jg7ZKNufKy6g3SBSgOs2oFDyV
         hPXOFXNGQVpi0VgQr4gJR4zhSaJDMhzannnIe9QCrx8ZSB/y/TRAMg8QU4uCR1LyFAzA
         VS91DYtMuUqrDgAt/BiuiiqZcnqdAbG5PPJCzAhzTrc4vbotKfVay98CYfuDTWjElapa
         wcgy1Zcb9e1GSRdpDhqQV3kzvCLaC1gLPbUrp/xh9Fcf41YdehzARgwpHG0BnHXVhLLP
         5I+g==
X-Gm-Message-State: AOAM531nPj9+1yxYDlr1daSeJW97uj+MZ7VPTFEGRPsPcpw0lW+BpRpu
        WMn5C4VZRCKeBM4L3LYQ4HZBf1kcszJ73w==
X-Google-Smtp-Source: ABdhPJxkDopVXWq/hye0zwGM1aYpx2l9qk+3viKq6w82XBp/dqLeQjM0cUl8KphBXPu+C2Zb9zzQKg==
X-Received: by 2002:a05:600c:3588:: with SMTP id p8mr41626873wmq.137.1625906859646;
        Sat, 10 Jul 2021 01:47:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm165769wrt.93.2021.07.10.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 01:47:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] git-compat-util.h: add __attribute__((printf)) to git_*printf*
Date:   Sat, 10 Jul 2021 10:47:32 +0200
Message-Id: <patch-6.6-365c5cf50b6-20210710T084445Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add __attribute__((printf)) to the compatibility functions we use
under SNPRINTF_RETURNS_BOGUS=Y.

In practice this is redundant to the compiler's default printf format
checking, since we mostly (entirely?)  develop and test on platforms
where SNPRINTF_RETURNS_BOGUS is not set. I'm doing this mainly for
consistency with other code, now we don't need to think about why this
particular case is different.

See c4582f93a26 (Add compat/snprintf.c for systems that return bogus,
2008-03-05) for the commit that added these functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index dca72cba294..af098d5c932 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -788,12 +788,14 @@ FILE *git_fopen(const char*, const char*);
 #undef snprintf
 #endif
 #define snprintf git_snprintf
+__attribute__((format (printf, 3, 4)))
 int git_snprintf(char *str, size_t maxsize,
 		 const char *format, ...);
 #ifdef vsnprintf
 #undef vsnprintf
 #endif
 #define vsnprintf git_vsnprintf
+__attribute__((format (printf, 3, 0)))
 int git_vsnprintf(char *str, size_t maxsize,
 		  const char *format, va_list ap);
 #endif
-- 
2.32.0.636.g43e71d69cff

