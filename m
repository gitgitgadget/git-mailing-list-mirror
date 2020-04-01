Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142C6C2D0F0
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6A72077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6ztxREQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgDAVAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:00:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36168 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbgDAVAt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 17:00:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id d202so1337513wmd.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LZVzsYJ2b+HMkPBih5OXoJhxelrcxP4yXqivu+PbECo=;
        b=r6ztxREQjsp6HpmICZ9dKdn/FfILt0krj5WSLea8aWWkR4UoJNEWgg4K7+eIXKOpoZ
         u4nfOc1kdCt35RYqxiaLismELjpsyY1sDNMOnyqt8S7tsMoJMu/ZoCgCTQEpbYnLK10W
         AB7RRGSYRxX/cL1I/yRF7gwlJYnVJk6h5MRY/hLj+OL09GosXb8TaYJa/sPUcRTvcoY+
         Ie8CYjtv7aUgzSEvPifOwKJxBfoYmCpL4BD+kaACnulguk2uwbqB8XdCfQWOZcqRMoIR
         sApIRSovn9sh4pQ28JAA857dnH9iwg2X+zXLGnvDIxpPz8UcFvSD4UTBTDPOERsNqQ/y
         sYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LZVzsYJ2b+HMkPBih5OXoJhxelrcxP4yXqivu+PbECo=;
        b=MFWYMQhcXaqWEaphgyjjj9xconxxoCkmBDeRqMk+tBbc6UjLN4VOCuNgPZeSbX/80b
         kYaMgwgvIM0vOWcP/dPRhNG9nZStTmtRW7BPtl8H599OmoxU01lQtyQ9Yxb1Vpuzk40N
         6fRTPjTYMzuTHjy98oZyZXXgfy8s/b3Zg2BN68kTwly1sQ0X6ViPBz81hhFSrqgxsNhZ
         mLtm4U7aiaV2JPghZtsemmSVcCfeBGsF67Dwqx3Mv+cGijDzycRVv0QpCxQJcGkKlb4a
         coPWqBjDXDhITEMXiXMax9MpCea+ERRnlX8V6v2P3uDrOv/nMo/T9LEmVl0FMHHf0j1j
         Ct3A==
X-Gm-Message-State: AGi0PuYEiUarr2ytfUrQR+vse+vghkDYSPyYY/ios4Zde9NQNdsetKYo
        xQXBg9aF4D2tXWyJ2rZ3lxGcc6nH
X-Google-Smtp-Source: APiQypJGMrR2qH2aCl7nNPjYGLu050hMoCXY+Z98Vao7LLZxX7L0VkdKV+JX6yNe1r79vhhyo3ItMw==
X-Received: by 2002:a1c:b642:: with SMTP id g63mr279692wmf.108.1585774846504;
        Wed, 01 Apr 2020 14:00:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm4490353wru.68.2020.04.01.14.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 14:00:46 -0700 (PDT)
Message-Id: <24e26ecda632421e4c1a61ebabf6ea78301685b1.1585774844.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
        <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 21:00:43 +0000
Subject: [PATCH v2 1/2] t5319: replace 'touch -m' with 'test-tool chmtime'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The use of 'touch -m' to modify a file's mtime is slightly less
portable than using our own 'test-tool chmtime'. The important
thing is that these pack-files are ordered in a special way to
ensure the multi-pack-index selects some as the "newer" pack-files
when resolving duplicate objects.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 43a7a66c9d1..6b20e60314d 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -521,10 +521,10 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 		cd dup &&
 		rm -rf .git/objects/pack &&
 		mv .git/objects/pack-backup .git/objects/pack &&
-		touch -m -t 201901010000 .git/objects/pack/pack-D* &&
-		touch -m -t 201901010001 .git/objects/pack/pack-C* &&
-		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
-		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
+		test-tool chmtime =-5 .git/objects/pack/pack-D* &&
+		test-tool chmtime =-4 .git/objects/pack/pack-C* &&
+		test-tool chmtime =-3 .git/objects/pack/pack-B* &&
+		test-tool chmtime =-2 .git/objects/pack/pack-A* &&
 		ls .git/objects/pack >expect &&
 		MINSIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 1) &&
 		git multi-pack-index repack --batch-size=$MINSIZE &&
-- 
gitgitgadget

