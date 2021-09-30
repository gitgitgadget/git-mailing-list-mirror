Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149BAC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 11:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BBE61994
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 11:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350347AbhI3LPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 07:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350340AbhI3LPa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 07:15:30 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC747C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 04:13:47 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u22so6784506oie.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3I1II3nj80ONlKpUmNwL8PmbvNLHXd3njy25z/ub9U=;
        b=DRKnuRZQRLL5PAblAMkfygSkeIC4l3ovzmhtzMBcu+5z5LMCvchqxYydIWM1i6cVrn
         mMsR/wNEXH+BEQiF5QeKezXkjmutsX+pnnub0YbZSF5b3KC0cMDtOexjgsstDv9DpyF7
         7ohZ6VPKokOJTbRQ0xiT6J/MGgySGWnGmSPgedJtx2+/wp/P3Aup9CsRiwmkJR2izyOq
         /uiGOEIQLs8YrNXJ+I33CX9u87gi34CMXdTlICB7ETgw7/J+wdbF3V9c4Sz5qWJRYfbJ
         D6WSVeWR9lXnUIFpBq32H2JaL9NgSV+wQCbKhJs/qhzaiRG+gN96RQNNIocKgAoMNB2y
         3H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3I1II3nj80ONlKpUmNwL8PmbvNLHXd3njy25z/ub9U=;
        b=aWv6D77GBBbys3pdTtnrRQ2c3IfIYJb2ZKSG7tlna0UMsvIbzP+5t5TAMBOh5vVIuM
         vtT2YigWyVSBXGF1nRhcC/vVKclMAO0586ZoZYP2UTt6QslK6LLx86hAjvXIDGzvIWxJ
         sXExLw1ninp39pIXzpkxsuFbS/SjHwU5n7xiMhmLLSUmYR/UO2t9ZyeBb1rnV9VFZcvP
         a3qqlgCbnfoM+HAPPv8dP+A1NGxfccmBvMYUp2rb9zzQPVsgjv6f4Ve6lNJi7OkFdti2
         3H3xMp7X7gRy+41WUC37yGwCSAqr7HNbqlv4g2csXOIAith9VmJnhTBM5zNoo+3O9EFB
         Gv+Q==
X-Gm-Message-State: AOAM533WxAJJV3UtdMbrA2BkX1nDIyVi3JADE62LLF3jCrOgZt3gedjy
        /J/LhNpvky3mHFwPz81T6WQGRqZ3xKy5nA==
X-Google-Smtp-Source: ABdhPJwzfEA+usDqgM0VEX3VVHAiI4GbnOh6EANtAIbKs49hSQrOhh19o2bx8WpuLTTHWicmDiy/ZQ==
X-Received: by 2002:aca:b142:: with SMTP id a63mr2194305oif.115.1633000427056;
        Thu, 30 Sep 2021 04:13:47 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w2sm517850oof.23.2021.09.30.04.13.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 04:13:46 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] fixup! refs: plumb repo into ref stores
Date:   Thu, 30 Sep 2021 04:13:29 -0700
Message-Id: <20210930111329.20952-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <80673975382af534cafaec3fdc034966d6f41105.1632956589.git.jonathantanmy@google.com>
References: <80673975382af534cafaec3fdc034966d6f41105.1632956589.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fails hdr-check in CI[1]

[1] https://github.com/carenas/git/runs/3754992076
---
 refs/packed-backend.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 942c908771..f61a73ec25 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -1,6 +1,7 @@
 #ifndef REFS_PACKED_BACKEND_H
 #define REFS_PACKED_BACKEND_H
 
+struct repository;
 struct ref_transaction;
 
 /*
-- 
2.33.0.955.gee03ddbf0e

