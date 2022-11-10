Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D765C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 19:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiKJTIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 14:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiKJTHf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 14:07:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C959FCD
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g12so3614106wrs.10
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/qBtdZ69IG5ihaw98dYPOr1oYuv5CWv1pqA2wxwrrQ=;
        b=RI0UmMPTMJ03ZBTKcTpR80Vavb+CbEasyQZkYDTqIHT4MS35AKvfeblTq6Z3BrHlB0
         Jok/YNctqu1rKHYhCBwq+8PWKZlEKfVD8mEwAlcUFIOJXiB5Uge/exFDHIfk0p8RHjQ0
         xEOwC5xy6TgYUWNHpO50rkfTdgzoLAwZ3xBI6uQm1/iUg7NWGch5MAPEnNmE+JCnx2a0
         9pMm875uR1EwkiXP4SC0Z1xeILaJSt4kHsgI/Fj1tnp+gmmn4TZj1sdGv318X+Au/OOB
         zlpvk/IOaofMTbRDz/tPA2YnRKCPMM62co36v1jourcnvcAgOnOU3CCP3O7n9GaNozQR
         OYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/qBtdZ69IG5ihaw98dYPOr1oYuv5CWv1pqA2wxwrrQ=;
        b=55DoGQCAFF+K64gjSP2haUsLXApKrsqPTVRcIv3Usmb2JVUJVy3tlrE1ngvYMkjSN4
         Q522r68MII4kqnFNqybiOJWXDDiXvFJlpmmAlSxlZbWM7n9TmSZyZF/ApevONJWPvnEM
         /MIXD5+1ahiE0sQ8lCf0rkVzT6AITzVTuuFQx0dQUTA66pFHpcDe3gz5F9b8zDVoZx6x
         Zzk2SYsukRlZ0Ey5tJ7IFZUiz0T43weHvP5S5EI/3m1ejL+e86hhUmVN40Cq7A5dJNdL
         RxgQ9D1VkD4Apzc+aF3Vc+Rm43+6/LOegDvRrC76Xm1IqfiXaSWGCZDbajjEA2k3w8tU
         UWTg==
X-Gm-Message-State: ACrzQf0JsRgL39VupLk/LVH9vAhrZSWAYiMFIrC31AAbGHGPm20q9t0d
        TkkTzojMUcYZOZGH+XaXvHLHmss5Ja8=
X-Google-Smtp-Source: AMsMyM6szy3mK8I3aGgewFSpzvPpdcfa8sES3GKr2I99rzQ/3APrSkmQpaz8YzzPzdJbO3wQfbsfDg==
X-Received: by 2002:a5d:6743:0:b0:236:6301:918 with SMTP id l3-20020a5d6743000000b0023663010918mr42626468wrw.247.1668107174356;
        Thu, 10 Nov 2022 11:06:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c1c8700b003c6b7f5567csm9557073wms.0.2022.11.10.11.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:06:13 -0800 (PST)
Message-Id: <100c01e936cb331ab5b3c231dcd3050ea06e1868.1668107165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
        <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 19:06:05 +0000
Subject: [PATCH v3 5/5] rebase: use 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        szeder.dev@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
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
