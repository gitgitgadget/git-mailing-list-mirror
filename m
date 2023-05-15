Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECDC7EE23
	for <git@archiver.kernel.org>; Mon, 15 May 2023 12:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbjEOMNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 08:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjEOMNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 08:13:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DE0E67
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so95390525e9.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684152797; x=1686744797;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT6jl+hfZy+5jBejVeoGS17KRh0aHKd4GnSV24Icj4M=;
        b=j1Bb3pcB6KPkBYQh4TbgYY4AcmM0oMZlXX1P33lJVGnGaDwQsFK4qXANc8XuDrxugm
         PP+ZIyG8ybSixMUx1weglRnfYGHCu3So7QO9vP11tbK1VRZNq4opzWnRCc8l3ytslP/M
         RYBBIfX7/RpIJx96pEpp2LLQhSjgQrqjrSNEs1BI/D25n7w1uSrOk267IZs/nRDMjO0x
         aO6vJ5z7zm0aP+fqsg4IiaT2xBAuXEG+nwnde7EFwC15OQLbDJ0lHSnuHOGzNVBnKKxG
         h9Zxr+R/mKd+Vn3DrBFwF1ZMcJ0XxpvAaSiIrNxZEBiylooT+Ql4ScwWsLM/5Mq2/L4l
         GkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152797; x=1686744797;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT6jl+hfZy+5jBejVeoGS17KRh0aHKd4GnSV24Icj4M=;
        b=e6eazjrB2HeapuM3xd4HRMazhscTJBrx5xYfedRNPKJu9EN60/C/r3AMBV58DNXl1a
         ES6/2dD/9Qm+QC1isVtuOpv0Q71yQJX1MQdmBDlxA/kl7PEE1++/OC648zcUZYvAXrNT
         mlt3wqfDa1jXHXg/YuFgY2in5NQldgImjkTxbOLPmt9z0/C4Y2Meh9rmsXzGel8NUqjQ
         WXiEkHzD89jdgZxPcWzE+lGFHggKEEa2Iy3h/f7tl7Zj0pZefrVZDRot4E8pecjJ2b5v
         OoR/LIs7GYMcnMnIe46NUy0FVxCtXokMCfrRnRdARyjFdjsyIGaOvRawvic+xZLgmkJs
         AGCQ==
X-Gm-Message-State: AC+VfDyexGL7UZOt3ua7muokLl8jMVUAHm+tLGdEyUofldmiAtA2iDf5
        4Tfz0p+63zYAi/kWuWPQktXQ30SVF2k=
X-Google-Smtp-Source: ACHHUZ5hvkZFspu+58oxbpbz9E0uO+luItrINdaHPsqvu57UzMGhqWs4EFyUu/U700VJkM3HA2GXJg==
X-Received: by 2002:a05:600c:2191:b0:3f4:1a97:ab1d with SMTP id e17-20020a05600c219100b003f41a97ab1dmr24340481wme.1.1684152797051;
        Mon, 15 May 2023 05:13:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b003f1738d0d13sm28318034wms.1.2023.05.15.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:13:16 -0700 (PDT)
Message-Id: <dc0c5ba17511628b384d7c2d6d5eb43342017b5d.1684152793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:13:11 +0000
Subject: [PATCH v3 4/6] ls-remote doc: show peeled tags in examples
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

Without `--refs`, this command will show peeled tags. Make this clearer
in the examples to further mitigate the possibility of surprises in
consuming scripts.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-ls-remote.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index af71cf4a92d..aabc1a7b90b 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -106,10 +106,10 @@ c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
 
 $ git remote add korg http://www.kernel.org/pub/scm/git/git.git
 $ git ls-remote --tags korg v\*
-d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
-f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
-c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
-7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
+485a869c64a68cc5795dd99689797c5900f4716d	refs/tags/v2.39.2
+cbf04937d5b9fcf0a76c28f69e6294e9e3ecd7e6	refs/tags/v2.39.2^{}
+d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
+73876f4861cd3d187a4682290ab75c9dccadbc56	refs/tags/v2.40.0^{}
 ----
 
 SEE ALSO
-- 
gitgitgadget

