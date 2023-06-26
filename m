Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC71EB64DC
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjFZQZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjFZQZA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C11A1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so45401215e9.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796692; x=1690388692;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfh2VMkOGYUvE4AgBkzqydrO8d9hs/sP/UEVum3BtSI=;
        b=C6beSuOLCB9jk6wLpdodzBf0byjJMHea30Ie6PGIObrtPeISt780Vp9xGvu9+xQVFO
         dY41spAjGmY0KoIZDbVsGFc6v3NQaSIy/YArHqAIoaJ5MEvpwH3zhxwYbAV+YgBQV1Pw
         h2tLMBIzRUr7+/iN/wKZLVKeLjUJ1VqvWhvdw4MElraTEPVfpacUKc8O56cg0YX3aPxP
         imPH3EsWqnU7sBVHfjaUT87K9fnP7NMu100suawcfR4lqm7nUl1Tuhh9p7+xo2HF86A1
         GdYbeWJY9lbgP3v5G4VbMtrIDnM2Y16nW8MbByAbt2//y4cdovd3/0dQccop81fdd6Yq
         34ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796692; x=1690388692;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfh2VMkOGYUvE4AgBkzqydrO8d9hs/sP/UEVum3BtSI=;
        b=Z3274+TZqcIlClaZHPaiRz6khCPBHCUHut15rI7Uee0e/STB1ZU14tMp3o0Uxd+5B3
         LjgVVzJMoQHbj79it1SvmFbc5hE8c30jzRsRxAGpFDxadWWDOdGGo8O3BHV6ZMqkdcBT
         Qg5XY4zYPxOaJQJfpgVPkz5rD8bA0rmQ/rtAsyXObkYse/SvVgapEWhL3foCdaUcW212
         rWc0nzQzzNy4E633sNjnAtsehK+lr1299/z6+0hYkztAfdKvIvQIuN1ziLar9+2rD/G7
         3C1gq3j3bu5AC82p3zBmFZcSKeADCaKfaAYnoa4fXjkBCuBN96gltEGfvl49h/ZHMNu2
         1snA==
X-Gm-Message-State: AC+VfDx8b1ToSywbL+/dVObrwAMQ+gzrGj9rYhJaytvx9YYYV3RNFqJt
        QvlFhbNL/nrFTTXA07tFUmSz+ALealA=
X-Google-Smtp-Source: ACHHUZ4bvU8TVZuj2SJb1h9VdqUarhzYCtQVRnja4Z6QD5p5ZqzGhq8z5oBvrJZrQDZufvCQiAcXWA==
X-Received: by 2002:a1c:7417:0:b0:3f9:b87c:10db with SMTP id p23-20020a1c7417000000b003f9b87c10dbmr14880660wmc.3.1687796691670;
        Mon, 26 Jun 2023 09:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11-20020a1ccc0b000000b003fa8158135esm8877469wmb.11.2023.06.26.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:51 -0700 (PDT)
Message-Id: <4edabc7f15c3ad55c911919bec5a406bb48ad0ee.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:25 +0000
Subject: [PATCH v3 01/24] completion: add comments describing __git_diff_*
 globals
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add descriptive comments for '__git_diff_common_options' and
'__git_diff_difftool_options', so that it is clearer when looking at
these variables to know in which command's completion they are used.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc95c34cc85..90fe292459b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1733,6 +1733,7 @@ __git_color_moved_opts="no default plain blocks zebra dimmed-zebra"
 __git_color_moved_ws_opts="no ignore-space-at-eol ignore-space-change
 			ignore-all-space allow-indentation-change"
 
+# Options for the diff machinery (diff, log, show, stash, range-diff, ...)
 __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
 			--no-color --color-words --no-renames --check
@@ -1757,6 +1758,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--anchored=
 "
 
+# Options for diff/difftool
 __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index --relative --merge-base
 			$__git_diff_common_options"
-- 
gitgitgadget

