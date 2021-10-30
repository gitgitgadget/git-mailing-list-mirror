Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F0C4332F
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C469260E8C
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhJ3Vev (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhJ3Vei (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DFDC061746;
        Sat, 30 Oct 2021 14:32:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p14so22161814wrd.10;
        Sat, 30 Oct 2021 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eox6PRsRpEY00CGOdl4cPybo4DywF53uifzQxdgpiLY=;
        b=TzhhV0w/tJEKXZbRawpWyU3u4Qc/qElavXhRhPZr9/zNTnf5U55zZBeWg7lIZXgZed
         lDLJLgfxctlC0yXOIDfvWgK7ExFFBFT5DI4mmvWKxE6YkttE0noajGx3+SwM7Xj6i0my
         gqdissRCW//RQubgZA3D6YpwawWo55kvXN7XOgmpk58md0c1iu55hAwusHnkWirMdAhX
         VVDJXIn+mxgNrzEBldotuJcpTD6C4VBE3NGBS2QEfiWw7Zve1t93jqxSTJijOZqV4C2X
         F73eAu6AbJpxfdD6HQF/XJM7CLkyOF5BOirS30bs5mIl5o3T/PJTNEftDu992It6SBM1
         gHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eox6PRsRpEY00CGOdl4cPybo4DywF53uifzQxdgpiLY=;
        b=DO2MuzHNrVSw8X+8UkW0fGWrWm8e9f5Ou0Se2ET6+v1G9LjMurACCYEYLYOHKu/v7V
         43PGIsFoZxSbP9lHucRhA4kUuzubZFjrvMT7N6bTl8Cl737LfU/p8LN6JqObgn8cqVSk
         u+NkGyUSxS6MpKj/412yrcLNdyzNr8mdirKQk7oitVcD8aUBKqMjSv2GKvn1wFKmSXFR
         x2JonXDCNm28j1+IGO11+EUSjZLulLCr0UboW83yeEfPxSHsWvk9xhDuNmdNYiRgFsI3
         hg3tJiFWupuJV9kN3TycspgHU1EeJa4U3dvjdqkzDQ0DE6kYfsGluZygFD6QDFHiwUip
         +mQQ==
X-Gm-Message-State: AOAM532ZJ8s8N0bPdrphqf9kwHAp8zhbI8khI1zCyvkCw/8zq7xMgirH
        9qs0ueyH7jJzoTCKKPuBA3s=
X-Google-Smtp-Source: ABdhPJwaVsBgeWGPZzo5ovQ9lNRDiAekg6xCVT06tElP5DFsquBt0bE9vWr6WIftzsfczCge8eUTNg==
X-Received: by 2002:a5d:59a9:: with SMTP id p9mr26445538wrr.386.1635629526175;
        Sat, 30 Oct 2021 14:32:06 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:05 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 12/22] pthread_mutex_consistent.3: Mark *_np() old function as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:22 +0200
Message-Id: <20211030213131.140429-13-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man3/pthread_mutex_consistent.3 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/man3/pthread_mutex_consistent.3 b/man3/pthread_mutex_consistent.3
index c4963582b..ab280e961 100644
--- a/man3/pthread_mutex_consistent.3
+++ b/man3/pthread_mutex_consistent.3
@@ -85,6 +85,7 @@ glibc defined the following equivalent nonstandard function if
 was defined:
 .PP
 .nf
+.B [[deprecated]]
 .BI "int pthread_mutex_consistent_np(const pthread_mutex_t *" mutex );
 .fi
 .PP
-- 
2.33.1

