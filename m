Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D36BC433FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFAA608FB
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJ1U7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhJ1U7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:59:30 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDD8C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:57:03 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h4so6512933qth.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKFxtKN3yyVj0ZKB41F6yssw8gLtkASC1420kU03sLs=;
        b=CEXlAxXibHgY0yz+ZfUiZ5UFQDsfp/Huh9upaS0jKlfBleKF02/ACudP3PQ8vN9aZw
         LHdrceRHjUHoaKsig1LWDAxfsacpMTmh5NiHCJH4P5DNC+7FJMFCdHsgswv49VJhJ8zG
         tepIF9zP4HvaNHaEA5nzgkcnLCGQAXkfwnwgLOO1Jnj/vbemrRNyBZ6jci2e9LNnZ2Dk
         y2CSer4J3WJXc1qAiL3QXJsG8uaSFzb8emyONkr/rwCUt9hhgu9VL048E4YrLIr11ba3
         eZIU4y18Y2cltRBG7+QFOdjmColAM5pFLM/Z/JoYlxzj6lx71TQ4zWXau2Yr1CtvbMRM
         4X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKFxtKN3yyVj0ZKB41F6yssw8gLtkASC1420kU03sLs=;
        b=ePFZoZfOFT5ZiVbYqEAlJ0Lh+BoY4A0g2/6bQrVMeSILXP/cvFbgX7nb8/QS8xKM4k
         46AH2vR+6xJq2D7QmgvKQszvbSdVHc5hVEUecpJUxcUG/3w4dtBNL2+litHxInzTGrmX
         yQIVT9HWl58oFc7bRv3+T3PHPnbwNLVlckNUkblv/IG2jiapSDNxWH0sBKnQFHF22qry
         9xlyWX6/+q9fDSOsyf2Wdap8zttAAlbdMHPbAvf7FTdlWqBpNzlhqZZ96CR01LiBfRWE
         bSLPE2ta4LBfEia3t5HNB21V3RuWDRog0eRwN8e44ACt8Ihdfa7O6yZfenlq8E2xDwTc
         d2Rw==
X-Gm-Message-State: AOAM531ErrLfyHP6b55j1sbMYtVtxQRv7DarTmkya+9jg+15fOskHHHo
        19cr1JfNOqki1ChucsQeugKHnwNMq/Q=
X-Google-Smtp-Source: ABdhPJzRoa+b31N3RzRh77WZu73YiueI38Y4kL7SSUSt7PwmqU4RtAtsL4t4ABaoeaIulZGly9LTOg==
X-Received: by 2002:ac8:5a4d:: with SMTP id o13mr7369628qta.330.1635454621963;
        Thu, 28 Oct 2021 13:57:01 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id az12sm2626136qkb.28.2021.10.28.13.57.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 13:57:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, vtbassmatt@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] fixup! t1051: introduce a smudge filter test for extremely large files
Date:   Thu, 28 Oct 2021 13:56:48 -0700
Message-Id: <20211028205649.84036-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1155.gbdb71ac078
In-Reply-To: <20211028205649.84036-1-carenas@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
 <20211028205649.84036-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t1051-large-conversion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index c488850bee..dd5f270b20 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -85,7 +85,7 @@ test_expect_success 'ident converts on output' '
 
 # This smudge filter prepends 5GB of zeros to the file it checks out. This
 # ensures that smudging doesn't mangle large files on 64-bit Windows.
-test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
+test_expect_success EXPENSIVE,IS_64BIT,!LONG_IS_64BIT 'files over 4GB convert on output' '
 	test_commit test small "a small file" &&
 	test_config filter.makelarge.smudge "dd if=/dev/zero bs=$((1024*1024)) count=$((5*1024)) && cat" &&
 	echo "small filter=makelarge" >.gitattributes &&
-- 
2.33.0.1155.gbdb71ac078

