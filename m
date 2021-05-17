Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49F2C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBE161241
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhEQMXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 08:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhEQMXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 08:23:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B1FC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:22:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d11so6163489wrw.8
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+TwYNByD5ucstj8TVJmUkvxq558JpIdiNXd40lTgfg4=;
        b=nhFHZbVNtneZ1aRfP0TbIvVvTlVjmHmTD/I2tbj5K8Ab8V0FGWLo/RnzFwseujzRGE
         AkEiSYTXNQeuigQWHqGKeaMzGO1DJftmHIt+F9HSzxU6PSSenwB6zlCJe0s/c62+btHS
         TN6XbgdZFKwA/AxwC3cf+I5RHb8yvagCqnct0WcUWbP0SbJKSStHG9Oxa4a+7FuoOaUH
         8wEHaWslZcnpHIUFZEQsMX+xq/SZKeQTGbCP9oYC8PtrtHGm0P3gcwv6Q742v/U10Sjd
         BSlO8HDtnnVoDGxy2zO+vLab+WpaxAV+TzZXfGlVrnGzy46ZDviNTd8cGN7P9uLzBLcP
         jZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+TwYNByD5ucstj8TVJmUkvxq558JpIdiNXd40lTgfg4=;
        b=IixV5GjPzrZmmcClpAVv1iaa2P7ckUjR4eGN8tJTv11Si7eIXQSzFZpu8Uv96wdEB3
         qjNN/DmqFbvj+G4FLyLMeWiNoLLlbxQht7jHmm3LcHuxghkw5zt3lPWYgrFLCWlQ2TdX
         EpQtC5/YfoHm+YsXteBlRY3F2Y06vhLFRyfh40/ybsLruC64W99Gd35yXPYb/Ans5QWg
         nyFnPoMpyleZh51N1wXO3eR3JLYah1qwrQV88bI1hUX9ZLBuE5OLlQj8nlz8OAfeb2wz
         /j6B/CAkh5FrCRsfYt4xuk3me+CWHvTRkXLedrC2AZVXhLQgWhmh/E6ZgMRu+lSX+ijf
         W3yA==
X-Gm-Message-State: AOAM533Bo7Vpwk25HOpZxTrmhfX1CUOdVsKxNXVcVQy1660PF56KQsp3
        268KlrUKc57WTP+gngwdoS78GXuF6Ns=
X-Google-Smtp-Source: ABdhPJxtnRDbU5vZx2bI7KB8ZtDMT+7ghep0jf9pKKVdEUeHOqjNWQuUW7W3F8UgdpkFcc2rGqwmqA==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr9420726wrq.142.1621254138914;
        Mon, 17 May 2021 05:22:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm20154277wmc.44.2021.05.17.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:22:18 -0700 (PDT)
Message-Id: <pull.953.git.1621254137590.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 May 2021 12:22:17 +0000
Subject: [PATCH] sparse-index: fix uninitialized jump
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While testing the sparse-index, I verified a test with --valgrind and it
complained about an uninitialized value being used in a jump in the
path_matches_pattern_list() method. The line was this one:

	if (*dtype == DT_UNKNOWN)

In the call stack, the culprit was the initialization of the dtype
variable in convert_to_sparse_rec().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    Sparse-index: fix uninitialized variable
    
    I noticed this by accident while using --valgrind for a different
    reason. Seems like an easy fix.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-953%2Fderrickstolee%2Fsparse-index%2Funinitialized-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-953/derrickstolee/sparse-index/uninitialized-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/953

 sparse-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index b0d5dc5f081b..affc4048f279 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -34,7 +34,7 @@ static int convert_to_sparse_rec(struct index_state *istate,
 	int i, can_convert = 1;
 	int start_converted = num_converted;
 	enum pattern_match_result match;
-	int dtype;
+	int dtype = DT_UNKNOWN;
 	struct strbuf child_path = STRBUF_INIT;
 	struct pattern_list *pl = istate->sparse_checkout_patterns;
 

base-commit: bf949ade81106fbda068c1fdb2c6fd1cb1babe7e
-- 
gitgitgadget
