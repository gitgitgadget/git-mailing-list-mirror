Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C75C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiEWNtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbiEWNtD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:49:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AED45642F
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:49:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso11393471wma.0
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2IlzxJ7VZLFYW9FoTSMVdEvLGG9ryAdgqq2Dl4y6yJU=;
        b=iH3Lck59MraRwB3kLEIeolCggQh3mTAUFDXl3Tpi/xo3RY1Yoxn3kzfgUBznEa5/dT
         ngLpzqMmiklPH62E/DZtvk64B2iGO5BbPsrTz4Upnjrc3wKfjhLOAo1rENKqUQYjYrZu
         gfOgTe0joSC9XozgdBh+RiHhMqwgrgIipXAh/VrqmmWSoKwS+90hyVify0tw8FSIfxu9
         +WE2SU79qIqHlnXYW3VszhbtMJv6tEgooHb0Re69hcqE9tKcTCVwLbDKgPdhuV795qme
         ssiBO4noPbfr95PTCqElQaL/KZJL81ousGlxg5F+OeEmv7SJsJm9FCAq6Gbh4FtdiTRW
         FlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2IlzxJ7VZLFYW9FoTSMVdEvLGG9ryAdgqq2Dl4y6yJU=;
        b=SWLUOs+XzH5MooSCFPAhGLW2LJz+IApYqbpEwqjzaVuWIpn14oph9wUtmApToHT4xv
         KiKivbkhdmcXmeA7Y718THNtPhWNcQcu2m3JBWDyagrN5U9B6ifNO1LPzdtSOgYKI2BU
         fCgCqVuIp9Rbe6ebA4AFY5cg0UhNq4mFwCoGhQNYKcoKHeprZV0FQKt+pq9sPlXpCmQB
         bvULofGPfgcxy7c8DMmIhuGXRtipS2MbbVk8rj2DY+Fb58MjRbBRaBNFKnVVmoOwqGz6
         WzMyEiGWxDqH27DUiwXX6K/KvFSZ6+ko7wadD8o8V9ldftPq4OoQSXXvZ+VV40H5hAMh
         DPiQ==
X-Gm-Message-State: AOAM530mHSA6czUoyq1Caav27I2qFSuTB/zI0Zgj3qFMHAT/YBbVwiEX
        tFQoyrPjVnL5GXz6HuGSQ1XZzc9yDZ0=
X-Google-Smtp-Source: ABdhPJw+LvtfgBLiJ4uOjF1XoVpV0ALJlO5Uhk1rsGFMZYndFb0FherrCOK+wWEbQEczMEn9A3EXLQ==
X-Received: by 2002:a05:600c:34d4:b0:394:91a8:104b with SMTP id d20-20020a05600c34d400b0039491a8104bmr20201449wmq.134.1653313739716;
        Mon, 23 May 2022 06:48:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5-20020a05600c348500b003974d9d088fsm2062226wmq.30.2022.05.23.06.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:59 -0700 (PDT)
Message-Id: <aa3bdcf705cc67565966076b09afa8219549771a.1653313727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:45 +0000
Subject: [PATCH v3 09/10] p2000: add test for 'git sparse-checkout [add|set]'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The sparse-checkout builtin is almost completely integrated with the
sparse index, allowing the sparse-checkout boundary to be modified
without expanding a sparse index to a full one. Add a test to
p2000-sparse-operations.sh that adds a directory to the sparse-checkout
definition, then removes it. Using both operations is important to
ensure that the operation is doing the same work in each repetition as
well as leaving the test repo in a good state for later tests.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/perf/p2000-sparse-operations.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 382716cfca9..ce5cfac5714 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -110,6 +110,7 @@ test_perf_on_all git add -A
 test_perf_on_all git add .
 test_perf_on_all git commit -a -m A
 test_perf_on_all git checkout -f -
+test_perf_on_all "git sparse-checkout add f2/f3/f1 && git sparse-checkout set $SPARSE_CONE"
 test_perf_on_all git reset
 test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
-- 
gitgitgadget

