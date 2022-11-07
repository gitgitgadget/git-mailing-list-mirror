Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8139C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiKGShr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiKGShG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5597286F2
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z14so17566109wrn.7
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsXCzF2hTps28ohqvdqyMgg4sjH5U5fGKLqeeLyAWPg=;
        b=lZOkv2HJqjydlWeBhg9pICrbj30rVD/Zobk2bJmXmxEqKf/POoCP3IccCrH1xabpT7
         hkhZD9D2XeauMWJXEXypkB7rCsARlEQUK9ACMYs/05dSNExk3mrK3mvk4VLpGqpa77Nn
         4ntGhsuTvTg2U2ssKfxF6KklRANoxwd0c+dXqjq8WO9mE2tDYhvwS2FhiZDWKG8ExtKY
         El3K2jTQTwjastkwN3UgbXJJYFotqsdF7ZRztOTJ7v+r0SgpiPKXb7qoeLgPL43J0nu4
         6E29lJUBLwtLYhlV2VrWO46shdZxpfQMW66GTquBC7XHkUZGTBQ62Ii7qlu8zHGFQFGj
         b/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsXCzF2hTps28ohqvdqyMgg4sjH5U5fGKLqeeLyAWPg=;
        b=VqXYuiVYr4WJoEqv9rLiO0xcCmf4eH0P9Sv+c+RH1x4lOAjd9qHqZqvlDRPyJW1C7g
         LzF9DeD+I7LudoLb+0+J6Mz3McfGT6KvgR2589GECS6AVs7+gQq957qVcLhjd+uYOuoE
         7+3CBJOBubyRKNSjmpqGQvQTgzzRIOkf4KMoJB9jVIHgewQrZV5W9oxhslYw3V7exDY5
         eIPmsh3evDBGtoS/VqW54tEGMic0b8sgE3BL2U1fWu6zi4ilmjmfhQPmkroMgsBP1jcu
         OkEZ8gMebNQrq/mNzenz0J/8BU+elL1UsRVcZnpgcFJKy63X5L2wRh27b/jbtHVxGmLr
         wi/Q==
X-Gm-Message-State: ACrzQf1+2LT3uSUxb1Oq1yNo0Ccne1e0KhKAxtV4Gz+69ntE+qf0lG+K
        CZpPa2eps2EFp78oJLrS2Rb0Nk46Rd8=
X-Google-Smtp-Source: AMsMyM4K5+0M7KV4nbGUaBlzwhncoyJ3ddzDPlwbNcSsVBBT9JNLZB1WOSuHJhNIGTKqcFdfdcEXEg==
X-Received: by 2002:adf:e391:0:b0:236:599c:b9a3 with SMTP id e17-20020adfe391000000b00236599cb9a3mr628115wrm.258.1667846190257;
        Mon, 07 Nov 2022 10:36:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d4f02000000b002366553eca7sm7889858wru.83.2022.11.07.10.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:29 -0800 (PST)
Message-Id: <191ad7fdef6880738c25c307bbc3c1d66b6378b5.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:58 +0000
Subject: [PATCH 24/30] t5312: allow packed-refs v2 format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

One test in t5312 uses 'grep' to detect that a ref is written in the
packed-refs file instead of a loose object. This does not work when the
packed-refs file is in v2 format, such as when
GIT_TEST_PACKED_REFS_VERSION=2.

Since the test already checks that the loose ref is missing, it suffices
to check that 'git rev-parse' succeeds.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t3210-pack-refs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 577f32dc71f..fe6c97d9087 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -159,7 +159,7 @@ test_expect_success 'delete ref while another dangling packed ref' '
 test_expect_success 'pack ref directly below refs/' '
 	git update-ref refs/top HEAD &&
 	git pack-refs --all --prune &&
-	grep refs/top .git/packed-refs &&
+	git rev-parse refs/top &&
 	test_path_is_missing .git/refs/top
 '
 
-- 
gitgitgadget

