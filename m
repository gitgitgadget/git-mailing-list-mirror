Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFAFC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiKGSgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiKGSg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6CB2648A
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k8so17610547wrh.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl+O9eIsm0qB/+MG2tKxqwEaGg64A+ZDbNtireyw8vg=;
        b=XiZB0rgt5a7QgptSpfOP0SpGSZFWnU/Arpv6Vl5ch31VCraY0+cJig1FaDq3bsmr1+
         Qsy7UULaztfbqNZUYuo4pH1nILaG+EkMwmKBxNJGIiEl+7W4awPpLjGUMgbtAJ9kd5Vk
         WbWLIUmz0w/J1hcuXvT6Ri3ZGb9U1TRQucCpLhGanTDSHg05HopMOGWdnb70FWjvmHvr
         lKJL2/jr0+xVJYr5ZHirAMskxJWLdCroLvNM15SrnlKOs6lPPmr7aRtOWl3CrO5/RxYn
         bAHqS/xCk1E5jx2gDWq8n6useJU/Du6gFsDAaiNQRd/mt4Q5Tik5rkMuWpw75KRGyQVM
         Jmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl+O9eIsm0qB/+MG2tKxqwEaGg64A+ZDbNtireyw8vg=;
        b=bWN8Fu7S94vQPeQwmZggrNlS6G6hz52FCWbcXfD3MV5h+vMd/LOccdwnrfryPOLEmE
         6AIwwodTa5fL0gkbQvJFm+gXXd02699091cuN0M4zwA4j6bPOKbEdx7etXsUNO1NjC0w
         mOC/Di6Rp7Ntn1fLkAUH223bIUNv5/uiKsUu+xAfVHrmG1Th9IfC/1xLNww53yHZ0gEE
         D7zXTidT0WY667Cs2bf/PDjZzf5TRt6AOR0mpdpJ+VPUE/VCNZZ0G8jTw/L6vU+3ik+0
         bxV0IPOOY/J5KNml95v+nDGbqe3eneNL5JP93vJ0th5tyHCMvXm3Ac41PqIU8QZOmyj6
         E2Og==
X-Gm-Message-State: ACrzQf3ur5b+H7sxxRVf3/w8xA+Juo6IMhPNqXJkWxQAL+NKag/Cd7zc
        QvBWivo4o3FGFKRPrGXmqhYyqq/gSVc=
X-Google-Smtp-Source: AMsMyM663zRxM0+DneQz0qjXGkLwx2mQUzMkSIIRmpkmy54uLVXjJJtsPiz6gQwZIuSD/OmKjDh5qQ==
X-Received: by 2002:a05:6000:808:b0:236:9822:718d with SMTP id bt8-20020a056000080800b002369822718dmr32891715wrb.254.1667846175612;
        Mon, 07 Nov 2022 10:36:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5-20020adfef05000000b00225307f43fbsm8122945wro.44.2022.11.07.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:15 -0800 (PST)
Message-Id: <ff176b52306345fbb2ad96193b890839d7959015.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:43 +0000
Subject: [PATCH 09/30] chunk-format: store chunk offset during write
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

As a preparatory step to allowing trailing table of contents, store the
offsets of each chunk as we write them. This replaces an existing use of
a local variable, but the stored value will be used in the next change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 chunk-format.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index 0275b74a895..f1b2c8a8b36 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -13,6 +13,7 @@ struct chunk_info {
 	chunk_write_fn write_fn;
 
 	const void *start;
+	off_t offset;
 };
 
 struct chunkfile {
@@ -78,16 +79,16 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 	hashwrite_be64(cf->f, cur_offset);
 
 	for (i = 0; i < cf->chunks_nr; i++) {
-		off_t start_offset = hashfile_total(cf->f);
+		cf->chunks[i].offset = hashfile_total(cf->f);
 		result = cf->chunks[i].write_fn(cf->f, data);
 
 		if (result)
 			goto cleanup;
 
-		if (hashfile_total(cf->f) - start_offset != cf->chunks[i].size)
+		if (hashfile_total(cf->f) - cf->chunks[i].offset != cf->chunks[i].size)
 			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
 			    cf->chunks[i].size, cf->chunks[i].id,
-			    hashfile_total(cf->f) - start_offset);
+			    hashfile_total(cf->f) - cf->chunks[i].offset);
 	}
 
 cleanup:
-- 
gitgitgadget

