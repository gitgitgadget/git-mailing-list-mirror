Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BFCC33C9E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 04:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7F22072B
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 04:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grQQgbQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgAHE2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:28:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33453 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgAHE17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 23:27:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so1945972wrq.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 20:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VkIBteIi5AvFpBw1W+hTz38FdMP/rwW+tW0+bCoMGyQ=;
        b=grQQgbQxVMuiK750Kl+nDtS3p6nS+lFFs169LjiQ0bKoiTGlsu7oqS9w1A82iCqMl8
         44ymqFRdytegeykj959F+OOSap5gUFcRiYNv9CdR7elcDXVhxbDYtRhz8OTGUvT8GNSq
         keo114FvwuNcNtXrhv8YDYZETwMJ98fKV/W7AJ9TbwnT4sw/zFX7zZ50NdU+D8bRb3i/
         wvy3m6f4aQBYGmkt7JnYEKVN5uaIfiCkT6uampA3OUbqxTlggzmMayh0d4mZNFjggAkJ
         aI+k5+VreZ6BgQMeWEwCGQ07GlA8G/BHFq4IZcpgBVsmCukd6XKEwHaZOSQNgmX6Uevj
         Y9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VkIBteIi5AvFpBw1W+hTz38FdMP/rwW+tW0+bCoMGyQ=;
        b=PP1O4Dg+21Pkfp6ElrSZIKJZuPgICG1+NVhG0Ilq+PiEEp07LwrfoGev0Gi3kZhFvt
         8vmTF6r1dgVumSixfsCkC74s9Z0e2sPrBmDTrFosXyfEO+oHQDoGBnNNB+9Fp5wC7c7Z
         QPwFJkYHXPCPLGzvPPgX0ETxlRg4BZMns57Y4uzTfQAYbAZRlUCgeKptTtKos/jL1KDK
         6OjQCfdh9EsW1T+SMjjXd3Fhg3KNT32eKc3GgXl1pV2AavjI+gMxTGIIdyqaybJ1FbeP
         o3ifBz1x67rsxJa8lj9g7NvAh4LuQxFdL1v2xuLRCh2HHUQkoybiiUdpVSiLqMkdRnaC
         Ly5w==
X-Gm-Message-State: APjAAAWEzbf9GQwwyZD9C+OxhPGzHSDpfKFPMUZiwavkV/JEVuq8IZFm
        Bw7RU5fQSAqKHOqZ9A20e/mWeOQc
X-Google-Smtp-Source: APXvYqyuOtLX9kb0tIXTWunOxAxKSLqucodP/WZzqXsl0X2MloqwBEfnPa9UvEpjjlNeIQQ5rCcpDw==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr2051597wrm.151.1578457676403;
        Tue, 07 Jan 2020 20:27:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b67sm2177714wmc.38.2020.01.07.20.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 20:27:55 -0800 (PST)
Message-Id: <pull.518.git.1578457675.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jan 2020 04:27:53 +0000
Subject: [PATCH 0/2] Graph horizontal fix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jcoglan@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This depends on ds/graph-assert-fix.

This is a non-critical (not needed for v2.25.0) response to the previous
discussions [1] [2].

While working to resolve the fix for the assert() bug, I noticed this
regression when multiple edges wanted to collapse with horizontal lines. It
takes a reasonably large graph, but real projects are likely to demonstrate
this behavior.

I arranged the series into two patches: 1. the (failing) test, and 2. the
fix.

The fix commit includes some details about why the change to compress merge
commits caused this regression, and why I feel relatively confident that
this is a correct resolution.

Thanks, -Stolee

[1] 
https://lore.kernel.org/git/faa954fa-ccb9-b034-a39d-d2f0696826ea@gmail.com/T/#t
[2] 
https://lore.kernel.org/git/xmqqk1635gwu.fsf@gitster-ct.c.googlers.com/T/#t

Derrick Stolee (2):
  graph: add test to demonstrate horizontal line bug
  graph: fix collapse of multiple edges

 graph.c                      | 10 ++++--
 t/t4215-log-skewed-merges.sh | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)


base-commit: aa2121af50498c7ea9d5c4c87f9dc66605bf772b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-518%2Fderrickstolee%2Fgraph-horizontal-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-518/derrickstolee/graph-horizontal-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/518
-- 
gitgitgadget
