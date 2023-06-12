Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AC0C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbjFLMxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbjFLMxP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790B310F5
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:52:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f739ec88b2so31417315e9.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574377; x=1689166377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfh2VMkOGYUvE4AgBkzqydrO8d9hs/sP/UEVum3BtSI=;
        b=M/dVCTs18VyuMdc74gQ72h2bSkBPe7mNgu2ePgt2YSiL1vCyUPRbNcxqFN/0gn9R2N
         6Z07u7GXbUeMmZLHsPrJ5IjYYq0+FAyZJyuxNeuIsE0RftnTfSJjjOfBudvHMihE2LJK
         8lzGVIaAIK4e6GEXRml3lRM1aG01R1NaVbHUyY3KyPkV692z/0MRWULPl1eNH0bFk1AO
         8lv6ea0lRPwfd8Pd5T0Uyii6BphaHLikK04FmgivI2vS3acunmWWam+U50tY3OrodQ7o
         Cay/2jPFVtvwzAQJtGvOYZvEV0a2WCXq/1cBkAco+7BJKNcAj5KEl3/7hhulpGLMFjvs
         C6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574377; x=1689166377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfh2VMkOGYUvE4AgBkzqydrO8d9hs/sP/UEVum3BtSI=;
        b=k0ESglVO33mwhdI7SN9Izo55x0I6ndppFqMoSqTobOutrAXFMuN5yskxPx0iGf7x5U
         a7xJYjaNgjrMi2cpz2X+pPzdKySw0ICyltrVpnKRKmtyK8dUY9gR4hmIMT661WPwph+V
         3DLRnWK1tdqZTKL/CZ2VXzvwTlIXPDzDqzPjH/MD8q+pkEQhkLE9udc2+ua/JQFmGC9r
         3DdXx4fJtjEHvBq0MN2EUO0ekA+aN/qyNhlK0joHewugFoXhXJXIS6lLsGEMyD7Gh1/J
         +nPhq/OLrOMSVXlf2JojJAn9oA0UkiWFQW//T485VmBiuEGfEFSPfSxYrjqSqOf4/MVo
         ZRyw==
X-Gm-Message-State: AC+VfDwZpCdZ15SJZnAqW7W1mdjqr+TntsZ60pf9ASGsZCtx/bdJcr6J
        2JkeJOsSL38hYenfexp3xArSZ1I7BD4=
X-Google-Smtp-Source: ACHHUZ4F61tfYL92EgrQUiKpNISMnCY4xjBcXX6oa/+GZ5GkRjtjdxtAodiqj/UvE/yRMGmLZUqUsw==
X-Received: by 2002:a7b:c397:0:b0:3f6:688:f658 with SMTP id s23-20020a7bc397000000b003f60688f658mr5837620wmj.20.1686574376471;
        Mon, 12 Jun 2023 05:52:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c00c900b003f72468833esm11398799wmm.26.2023.06.12.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:52:56 -0700 (PDT)
Message-Id: <4edabc7f15c3ad55c911919bec5a406bb48ad0ee.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:29 +0000
Subject: [PATCH v2 01/25] completion: add comments describing __git_diff_*
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

