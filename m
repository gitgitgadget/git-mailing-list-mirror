Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95561C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 11:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiFILdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbiFILdI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 07:33:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03823D6CF6
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 04:32:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q15so23950198wrc.11
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M8NOAZr2tUKos2MUTXO8bHJbZ3VbbJO88fU9Ov7RXbs=;
        b=gL7Ngt5BBk0fCWjq8iuEdW6wazLSZsxl4bZKE7WttNEGMlL4E2fdmACG8sTuj/+FtD
         IuYlI6p5O2FtEOsup9Efxe2TG97UCIyAYIyJch0FFoAmdC+09xLAlHvNHDpqONoV3tfM
         OMsHFEeNOz4qZfEN/Wk/zblbN7Um3MLFELp/iWeKpwmihZWJ5VeAJKKvcYIqw2jaiZ6Y
         jOinWNUtZyr0pe2dhom6pQcjp3XE0pxEErQPnQecKEHMpNz7Jx3DnaHp7+aM25qYyDSX
         XImVSC9D0wOWDxDRXzc6PxBO7OMOfJkLaI9qGHiyT2vz6LjuLqOaNan28n+HJy3OhZp3
         rPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M8NOAZr2tUKos2MUTXO8bHJbZ3VbbJO88fU9Ov7RXbs=;
        b=QQjl0pWtdJLoMY1ShByXNufIjYmm3BAJ9L2RfkQzStBoGJ4RaMm2uk0uN0gNZD20lv
         23f56TTHwqMJrcFlOo8NzjE75hDlnfHwzRJDjcosC1bgNUvcWwRnU1Pp5MFXRB3wW8gN
         n8LOESts7rr2Bqdii963Ar/a2GX/pGVpTd6eISy0qV6826XS6RR9rioNP1p057R4976G
         B8nSDOokWtg4J8PCCKzWHftFA9hN+8a6EyGoh9z/ZQbxpgn+BOpwhv3kzRO6l2p3HAqy
         tJPXNbCls0aPR2fsLEBErwmFY866qGJucEcfKM+rfWs9BKDqcGNcRBDks869scck4Xg0
         gjRQ==
X-Gm-Message-State: AOAM531KX7nQVjfi2bD4DEKPRVbBHCQvdEqEv03ISIUEmexO1jOV4PVP
        Tn+SPSC2vkvK9i6IdG7bQINB2lIeTfMClqUD
X-Google-Smtp-Source: ABdhPJxupV5v/rcMOHXzzitqEznUovyT3CXVENGG84NkxnETFa1Hh+/EON0aVsVNb3KWCnRYRmLDdA==
X-Received: by 2002:a05:6000:1888:b0:218:3fab:c510 with SMTP id a8-20020a056000188800b002183fabc510mr20548935wri.473.1654774350924;
        Thu, 09 Jun 2022 04:32:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020adfea43000000b0020d02262664sm23781951wrn.25.2022.06.09.04.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:32:30 -0700 (PDT)
Message-Id: <5212c5ec474b9441046203da363f2205795f213e.1654774347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jun 2022 11:32:26 +0000
Subject: [PATCH 1/2] ci(github): use grouping also in the `win-build` job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already do the same when building Git in all the other jobs.

This will allow us to piggy-back on top of grouping to mark up compiler
errors in the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/make-test-artifacts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
index 646967481f6..74141af0cc7 100755
--- a/ci/make-test-artifacts.sh
+++ b/ci/make-test-artifacts.sh
@@ -7,6 +7,6 @@ mkdir -p "$1" # in case ci/lib.sh decides to quit early
 
 . ${0%/*}/lib.sh
 
-make artifacts-tar ARTIFACTS_DIRECTORY="$1"
+group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
 
 check_unignored_build_artifacts
-- 
gitgitgadget

