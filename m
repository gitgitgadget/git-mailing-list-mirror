Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B51C2D0DB
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49752075B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIcBI+JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLYL5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45496 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLYL5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so19722301edw.12
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 03:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=prnawxM73KG9YEc4YMrhTFoFBf5A8wYjttJZSeSVNhc=;
        b=iIcBI+JKyGLx848rNtWYdUrZfZMXBFNGCB3tSGvZWg9z/0PJILyxxiVc8LFsgYZl1E
         76Weqy3oU8CbEX+x00KPlHAzFfQkkhSdB8PUSFSR1D9S4hw2drIuwJf6NXoHiqfo3pC4
         WrRk8W+6kRfeVnTH8QMaIDrYl58WQWMgbuelCqjy5STIDuUxur0yBBlzp70FSfgWi90w
         liIOkWR3puO91SN/vJ/hzwrRvX9EMYNG025G5N2kAM1/OcmFCOnLGxSTl1rqJezpZ00X
         g5TMX+XnuI1G2QflqLp6Sgzqef3A9Q17wTxK71Ov2TKEdA3iga75/2A6i17/DnhIpOJL
         xjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=prnawxM73KG9YEc4YMrhTFoFBf5A8wYjttJZSeSVNhc=;
        b=FKMhHVHNmIVAjTFnUNxqlJeA+pTg29IGfgcNYQpMFtY4Roc9+2PIzIQmMXFaFtSHUy
         3llgf1tZ6DsurFxBTkgnly0MqETQUHYkrJBSGCjtDA2a17xs5E46XjkYsxHBTMz/r8mW
         hKLBGvSsWk9z2GDjgqVESs3m4rLRtqhI4/iJOTBKCEPcVMezC5hjt/eXfuZay3vOwsWH
         kz26tdv7m2535IuWfrveOaGOq1reqvF7gG8U2M5+3tssQk5tyF+wed6FfPQaBEiIzeKm
         MKyWtOMDCX/1e8zfTOwY6vk8cNHcQMRwwc0F2Jva1kQBqc1HxNAaNcZR5tErnex4PVPT
         9p8A==
X-Gm-Message-State: APjAAAW6T1mk4MKFdm9abWh9Wkl5ZszXcG37FWCP3UJEU+NjiaW818kj
        BSJ1Z6psHZAYzlUUtXSmbNkW3nip
X-Google-Smtp-Source: APXvYqxeCG5akZVGQ2nLWzLwqYSStsMDk/Je80HhIC2NXDTwgk4qis9CtmRp26IZfZlneOeNVQPGhw==
X-Received: by 2002:aa7:d3d0:: with SMTP id o16mr44855050edr.102.1577275028951;
        Wed, 25 Dec 2019 03:57:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm3136582ejw.65.2019.12.25.03.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 03:57:08 -0800 (PST)
Message-Id: <23a3a47b0193395a280f32c01deaae5bdeeaa051.1577275020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Dec 2019 11:57:00 +0000
Subject: [PATCH v2 9/9] ci: include the built-in `git add -i` in the
 `linux-gcc` job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This job runs the test suite twice, once in regular mode, and once with
a whole slew of `GIT_TEST_*` variables set.

Now that the built-in version of `git add --interactive` is
feature-complete, let's also throw `GIT_TEST_ADD_I_USE_BUILTIN` into
that fray.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index ff0ef7f08e..4df54c4efe 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -20,6 +20,7 @@ linux-gcc)
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
+	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	make test
 	;;
 linux-gcc-4.8)
-- 
gitgitgadget
