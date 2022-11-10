Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFFAC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 01:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiKJB6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 20:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiKJB5v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 20:57:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FCE2C65C
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 17:57:24 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v1so292605wrt.11
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 17:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/qBtdZ69IG5ihaw98dYPOr1oYuv5CWv1pqA2wxwrrQ=;
        b=TYZJL10xXQBWbr7sUaZ67YGVGyljG0cU/1Mbnd5XSnHUiozqbPrk7cypEeU9vyXKxh
         nVxOT2kyXvVjwF+/Cj4HbTcuy1wsz3w8RLLzFfPIAyHj8k0LWMDjHVYVR/H0Eig4ol5D
         Zf8MJWCYeeEH7u5hbrOfbb2AIEWSLSze+nRFWBOM4W5oXoCNC9qSegcZxSGb+DhiUs+K
         kI8MjtRMNmggFooRYGSB7L/nzWj3ySwgtKznJkrZq+lWhuoe1LjaDPksC3sg2wmOcF3I
         W0jMu5Gup2ckTmg8UJRw3S7wngJReOK1gP5stk9ND6UGkkigIWZ3V3b3vnZlwbOxjFUx
         BXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/qBtdZ69IG5ihaw98dYPOr1oYuv5CWv1pqA2wxwrrQ=;
        b=r9Dwpvfq8inZLm7ubnHmPtny8k6jVl2VwH9NfPIX+YCY5tmnrK3PP/c1Sp/E+kRv2f
         s5dJ0n628uHPyIh+y+K870h6a7S5IKVGj6zECDU2LwiQQ6KUgbURJSnRJ54J4CUogugZ
         wHX+3SJRm7iZZ8V3GH0IQNpVAsaaae/oIqtcwRxooTBuOKIbdMDjCzoNmdVTsCZBKsg7
         j6Tg2F7widA1158z2pKv6OPItyXgmuEd5dolmksWJPQoDfjHjKAnP1luyOgjhxavEARn
         eIChxHR0x9b2HKnZuwWYYdKG9ptkwdQx+Qhtz7dj7/4yCbAk8z5AF/v7ry8fE6IAVEO5
         Q1iw==
X-Gm-Message-State: ACrzQf0gSrW2DmrU8eveW4W2IJljMNf+MrARku5ECTWkbyCBghRanCYf
        qh/sDqiKZuYc8XgYTE7nXSI0lrCKo3Y=
X-Google-Smtp-Source: AMsMyM7j321hc07qraHP1L1KZ7qeMf/eGZ7Ms+DdVdn+KweapK+2U3DIEwmWu/FNHfCctSRvjm5B1g==
X-Received: by 2002:a5d:5710:0:b0:236:cdd4:4cf4 with SMTP id a16-20020a5d5710000000b00236cdd44cf4mr35880548wrv.376.1668045444349;
        Wed, 09 Nov 2022 17:57:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16-20020adfdc50000000b00236695ff94fsm14542578wrj.34.2022.11.09.17.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 17:57:23 -0800 (PST)
Message-Id: <fffe2fc17ed3beb05376f1377ea193199c13c657.1668045438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
        <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 01:57:17 +0000
Subject: [PATCH v2 5/5] rebase: use 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable the 'skip_cache_tree_update' option in both 'do_reset()'
('sequencer.c') and 'reset_head()' ('reset.c'). Both of these callers invoke
'prime_cache_tree()' after 'unpack_trees()', so we can remove an unnecessary
cache tree rebuild by skipping 'cache_tree_update()'.

When testing with 'p3400-rebase.sh' and 'p3404-rebase-interactive.sh', the
performance change of this update was negligible, likely due to the
operation being dominated by more expensive operations (like checking out
trees). However, since the change doesn't harm performance, it's worth
keeping this 'unpack_trees()' usage consistent with others that subsequently
invoke 'prime_cache_tree()'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 reset.c     | 1 +
 sequencer.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/reset.c b/reset.c
index e3383a93343..5ded23611f3 100644
--- a/reset.c
+++ b/reset.c
@@ -128,6 +128,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+	unpack_tree_opts.skip_cache_tree_update = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
 	if (reset_hard)
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
diff --git a/sequencer.c b/sequencer.c
index e658df7e8ff..3f7a73ce4e1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3750,6 +3750,7 @@ static int do_reset(struct repository *r,
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+	unpack_tree_opts.skip_cache_tree_update = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
-- 
gitgitgadget
