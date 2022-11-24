Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF57C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 03:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKXDhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXDhO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 22:37:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BBD0DFE
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:37:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n7so597011wrr.13
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHNFOWtP4VhR3z/tUB/xIW67tXXehKn4LoM7rTwi6Xw=;
        b=FU4KOKkbICnQvtP/UIqsAAm7xIYj8N5WfH1M//kbsxJP4EX4/sggNqFwlKqXejBd4S
         gl8ii3CRAlN+lwIK1CFV6aU2W8RVurKeuNC0+Ev55D+YbTUnP8kKTQnBk+2nzBB8m+qG
         5G0W1UvMSwDvW1ylvJ7heAEnHU2SzLMILPYA4XE59DcavBJSqDb1XpIM+RGOGkjjEjmt
         MuD1e7AEdHZoPzUGeLqkBxud3DHRxJYC08gUl5B7RLCJWcQ0BuLHkyGmNVV/Zvlwb79v
         4bmaf2lnHRjOI1eEav0EE+xWXLq7T5dH4b8eEhAcUKMpmgxeEPzHRylzuJD9eX7fM1o8
         4MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHNFOWtP4VhR3z/tUB/xIW67tXXehKn4LoM7rTwi6Xw=;
        b=HSIdDJhCsYpQM00gqqjvykHNNPuC+H5DaM+Je7lhs6a4z1RId4/Ueh/hsnDfw5u0NX
         G49dKEa/YbcOmtI1e9TO4Fy1dyhHEG1Z92xUOIYMt5BZtQKc6ZbA9V/gdYYl4rvuVeb1
         iYIwXUMgYQXS/0Gsx3VgPKnVJeQi7N4OXshssOnaQ80mPvonvHCsFk95OXXtdNsE1+fU
         DvyRASaEZ000ZHJhbdhMnNe0nh1f01JoOoPqBCSYc8R53Qo0REATlQD5BqfGYOZPuc0x
         NEdaVReXGRrpp/lsBz7jRArxa42FZzM3YNYpUyUmOYbOub5LBdvSvP0eN5G40NVlK+Nc
         xpqw==
X-Gm-Message-State: ANoB5plFKbMLLEmJ9tHk+K7685rujx0j/Jb8pqn8gW13pOA3gWjthCgP
        vbHSAAIFlF1Nw+5bwqFjpji/1C3E31Q=
X-Google-Smtp-Source: AA0mqf4BX1ZHBGwrlNRso9vR6x0KgsnIgzg+P60+EuYJXusqn8G9YCptCutBdQHpoEnmkvP9vNSijw==
X-Received: by 2002:a5d:4f85:0:b0:22e:35f4:9182 with SMTP id d5-20020a5d4f85000000b0022e35f49182mr6601063wru.121.1669261031937;
        Wed, 23 Nov 2022 19:37:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b00241d2df4960sm100130wrv.17.2022.11.23.19.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:37:11 -0800 (PST)
Message-Id: <c21466d1db0e7f7fcd7308b61aa1e3cd4e3d67c4.1669261026.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v8.git.1669261026.gitgitgadget@gmail.com>
References: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
        <pull.1397.v8.git.1669261026.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 03:37:06 +0000
Subject: [PATCH v8 3/3] docs: fix description of the `--merge-base` option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
 Documentation/git-merge-tree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 298c133fdb6..88ee942101a 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -66,8 +66,8 @@ OPTIONS
 
 --merge-base=<commit>::
 	Instead of finding the merge-bases for <branch1> and <branch2>,
-	specify a merge-base for the merge. This option is incompatible
-	with `--stdin`.
+	specify a merge-base for the merge, and specifying multiple bases is
+	currently not supported. This option is incompatible with `--stdin`.
 
 [[OUTPUT]]
 OUTPUT
-- 
gitgitgadget
