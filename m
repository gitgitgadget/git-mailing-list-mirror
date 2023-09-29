Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD884E728F3
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 20:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjI2UdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2UdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 16:33:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A1E1AA
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40651a726acso23229645e9.1
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696019582; x=1696624382; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ylIf1uZiZGE3ip55c/IqshJjsv8SvYQeGMdbhZTES0=;
        b=VM/sbM3/7Wq46Ho+dzRbZj8FWHtIp714CjUvs6V7z/ZfxpA7nkEvs4Aw6e+Oa2ZRNH
         68+GrTT+tXyc3BCekhuQNrMEw2xyOfLncbti2uOzgGEdD/732tqq7mkno0HYwOMEFsmx
         Dcsw7nk4uAH1a8zuhNtvIhUARJRMzCsSS+ojZj3j7F+1lGTn7MpqoFaD3YV4u/IE2XFA
         ND8xMCQGw+Iti/dpsFShuPT4LH6e06ovAmEXiRdEmvLAkxgdeumP8AG4NKclQV+bya+b
         8yUwhuMy6akT36MMnp5dXF/v4gj8IeMzqbcEQ50ULhuqH3A/9qcxOmfheDmuaKNA3BoC
         wU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696019582; x=1696624382;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ylIf1uZiZGE3ip55c/IqshJjsv8SvYQeGMdbhZTES0=;
        b=G4uaZPJ2+yZqdFfVhpnMA3Poae1Xua0BIzPpx7abXaZFuXWfZgUtqkgoKQPi90urqx
         8UVuFogA0NaRU/DuXsluVd08vkp4okP2wlpApHlx2zKmHdeGIYBTQhFEdZYjSyyMRiHt
         1M3p6wadjRSnqDecEZaqSslloJOJkYq/SeGsTi3Af1fwiJggP27VMN5OX1lfx6mhpP0v
         ZCgqPZYDYnAYr0V5Jbnn4h1Fg/KyDqatuM6pp+WJlFaYjJFOT4/MzhSzjqCJB4fvKeN/
         RkWfSlgNP7hPrwVjZLptU0cfktGFRchfj6HMl6UGWDac8HfROuUNEZ0fuDL05uClcbk0
         lLjQ==
X-Gm-Message-State: AOJu0YzJZZpiL5b4UMr6+0/peJYtqIY8nKEeD0pCmVhGw2yoY1nyvcR+
        cmw2sur6lx+O0C4vw95ufh3wnExdRhI=
X-Google-Smtp-Source: AGHT+IHG+HRqB3LwrMPwnduEW/bZ6iZDMd3pYLuzvVJk/UXPg9gYiDh0jof89X5uNcLYP14bEbknYA==
X-Received: by 2002:adf:f08f:0:b0:323:1d06:38e5 with SMTP id n15-20020adff08f000000b003231d0638e5mr4913923wro.55.1696019582111;
        Fri, 29 Sep 2023 13:33:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d42cb000000b0031431fb40fasm980783wrr.89.2023.09.29.13.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:33:01 -0700 (PDT)
Message-ID: <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v2.git.1695399920.gitgitgadget@gmail.com>
References: <pull.1587.v2.git.1695399920.gitgitgadget@gmail.com>
From:   "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Sep 2023 20:32:57 +0000
Subject: [PATCH v3 0/3] subtree: fix split processing with multiple subtrees present
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Zach FettersMoore <zach.fetters@apollographql.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there are multiple subtrees in a repo and git subtree split --rejoin is
being used for the subtrees, the processing of commits for a new split can
take a significant (and constantly growing) amount of time because the split
commits from other subtrees cause the processing to have to scan the entire
history of the other subtree(s). This patch filters out the other subtree
split commits that are unnecessary for the split commit processing.

Zach FettersMoore (3):
  subtree: fix split processing with multiple subtrees present
  subtree: changing location of commit ignore processing
  subtree: adding test to validate fix

 contrib/subtree/git-subtree.sh     | 29 ++++++++++++++++++++-
 contrib/subtree/t/t7900-subtree.sh | 41 ++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)


base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1587%2FBobaFetters%2Fzf%2Fmulti-subtree-processing-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1587/BobaFetters/zf/multi-subtree-processing-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1587

Range-diff vs v2:

 1:  43175154a82 = 1:  43175154a82 subtree: fix split processing with multiple subtrees present
 2:  d6811daf7cf = 2:  d6811daf7cf subtree: changing location of commit ignore processing
 -:  ----------- > 3:  eff8bfcc042 subtree: adding test to validate fix

-- 
gitgitgadget
