Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA717C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AAB611CE
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhFUW2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhFUW2S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:28:18 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D494C06175F
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:26:03 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id k5so3126828ilv.8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4z4LT0lv5k9umGSR/ooyeHTuJXpCfSVmHmMOmakBiFE=;
        b=N+ZIxn8LZJ8RSoIBdwdGp/5m91mRIeLyK8ZO4thUBPqsxSz28Bonj7JzV7VAWB4q1p
         fGrwTNlFwX5C34b49Hvxqm+1OI7RrEEjVOtr3mRw93jlFEiiOoycgsi9YdbD7H6C9Oa5
         QCYZJu0e+XNqY71yegJ6eL4+3DzcT92BeSLgpyelSznZJtfjNtnTwcdV61Ed+ef15hEh
         4s+TCxz/SKfEPpkTACkFx3YEa/dMXtKbMLeiZo4Sm3+kQrXXONm53HsgmxhGPpToPMn4
         F5U92sVrqhFPpF5nilsQ/nOHe3siwbzBO0Va5YhGSETw46dtukhx6CP/KO99EcqoDzoQ
         g8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4z4LT0lv5k9umGSR/ooyeHTuJXpCfSVmHmMOmakBiFE=;
        b=e6p7McdT3kEuWy2lif68qXe+wvOdxXvhdnZqwkPTya8H90Qyfx5P+5k5fIkEPoGmOt
         aHRez5sgkyn911CLrRRZ0lsqYrJ4443ep1FE815TPp1y7lwfVycnFG+UhTvb0p6ppycr
         lqMiK4E/8dl6r3Zt4DIxADrwLY3AImNjYNWLVYppg+FgErNyDMzH4BTGnnPeqFGuWjCE
         AnQBuDdL3mLiBI7k4E8tw+pTC06LPVOVM8Nj0uNj3qc+tp/Zin5FDwseC3EePu9CYWeU
         o7Vj8X3jQoXWwCEtHxij6lwRSwh/LdhARQI4tbmCvVxgDbTdW9iIgYjnWSfG3GGKKaIx
         J/Sw==
X-Gm-Message-State: AOAM532fS/3UjPHFS4ALfgg7FCDTS1yFAL1S5J4VDcsbplSoYggbvdPy
        5dtjE1sFglzQOEqBcZ13ph10KjZsgRIQt2wH
X-Google-Smtp-Source: ABdhPJzk/phn8Rdb+zqX0oyZsuV25S1BqMaf6fL9iYcm9YSyWt9WJQdxh7G5fZuhW0W+DZ7hhwJ0nQ==
X-Received: by 2002:a92:8e45:: with SMTP id k5mr377355ilh.116.1624314362619;
        Mon, 21 Jun 2021 15:26:02 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id d7sm6725229ilg.60.2021.06.21.15.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:26:02 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:26:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 24/24] p5326: perf tests for MIDX bitmaps
Message-ID: <ec0f53b4249ff668106319473f49260ab8478314.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These new performance tests demonstrate effectively the same behavior as
p5310, but use a multi-pack bitmap instead of a single-pack one.

Notably, p5326 does not create a MIDX bitmap with multiple packs. This
is so we can measure a direct comparison between it and p5310. Any
difference between the two is measuring just the overhead of using MIDX
bitmaps.

Here are the results of p5310 and p5326 together, measured at the same
time and on the same machine (using a Xenon W-2255 CPU):

    Test                                                  HEAD
    ------------------------------------------------------------------------
    5310.2: repack to disk                                96.78(93.39+11.33)
    5310.3: simulated clone                               9.98(9.79+0.19)
    5310.4: simulated fetch                               1.75(4.26+0.19)
    5310.5: pack to file (bitmap)                         28.20(27.87+8.70)
    5310.6: rev-list (commits)                            0.41(0.36+0.05)
    5310.7: rev-list (objects)                            1.61(1.54+0.07)
    5310.8: rev-list count with blob:none                 0.25(0.21+0.04)
    5310.9: rev-list count with blob:limit=1k             2.65(2.54+0.10)
    5310.10: rev-list count with tree:0                   0.23(0.19+0.04)
    5310.11: simulated partial clone                      4.34(4.21+0.12)
    5310.13: clone (partial bitmap)                       11.05(12.21+0.48)
    5310.14: pack to file (partial bitmap)                31.25(34.22+3.70)
    5310.15: rev-list with tree filter (partial bitmap)   0.26(0.22+0.04)

versus the same tests (this time using a multi-pack index):

    Test                                                  HEAD
    ------------------------------------------------------------------------
    5326.2: setup multi-pack index                        78.99(75.29+11.58)
    5326.3: simulated clone                               11.78(11.56+0.22)
    5326.4: simulated fetch                               1.70(4.49+0.13)
    5326.5: pack to file (bitmap)                         28.02(27.72+8.76)
    5326.6: rev-list (commits)                            0.42(0.36+0.06)
    5326.7: rev-list (objects)                            1.65(1.58+0.06)
    5326.8: rev-list count with blob:none                 0.26(0.21+0.05)
    5326.9: rev-list count with blob:limit=1k             2.97(2.86+0.10)
    5326.10: rev-list count with tree:0                   0.25(0.20+0.04)
    5326.11: simulated partial clone                      5.65(5.49+0.16)
    5326.13: clone (partial bitmap)                       12.22(13.43+0.38)
    5326.14: pack to file (partial bitmap)                30.05(31.57+7.25)
    5326.15: rev-list with tree filter (partial bitmap)   0.24(0.20+0.04)

There is slight overhead in "simulated clone", "simulated partial
clone", and "clone (partial bitmap)". Unsurprisingly, that overhead is
due to using the MIDX's reverse index to map between bit positions and
MIDX positions.

This can be reproduced by running "git repack -adb" along with "git
multi-pack-index write --bitmap" in a large-ish repository. Then run:

    $ perf record -o pack.perf git -c core.multiPackIndex=false \
      pack-objects --all --stdout >/dev/null </dev/null
    $ perf record -o midx.perf git -c core.multiPackIndex=true \
      pack-objects --all --stdout >/dev/null </dev/null

and compare the two with "perf diff -c delta -o 1 pack.perf midx.perf".
The most notable results are below (the next largest positive delta is
+0.14%):

    # Event 'cycles'
    #
    # Baseline    Delta  Shared Object       Symbol
    # ........  .......  ..................  ..........................
    #
                 +5.86%  git                 [.] nth_midxed_offset
                 +5.24%  git                 [.] nth_midxed_pack_int_id
         3.45%   +0.97%  git                 [.] offset_to_pack_pos
         3.30%   +0.57%  git                 [.] pack_pos_to_offset
                 +0.30%  git                 [.] pack_pos_to_midx

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5326-multi-pack-bitmaps.sh | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 t/perf/p5326-multi-pack-bitmaps.sh

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
new file mode 100755
index 0000000000..5845109ac7
--- /dev/null
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='Tests performance using midx bitmaps'
+. ./perf-lib.sh
+. "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
+
+test_perf_large_repo
+
+test_expect_success 'enable multi-pack index' '
+	git config core.multiPackIndex true
+'
+
+test_perf 'setup multi-pack index' '
+	git repack -ad &&
+	git multi-pack-index write --bitmap
+'
+
+test_full_bitmap
+
+test_expect_success 'create partial bitmap state' '
+	# pick a commit to represent the repo tip in the past
+	cutoff=$(git rev-list HEAD~100 -1) &&
+	orig_tip=$(git rev-parse HEAD) &&
+
+	# now pretend we have just one tip
+	rm -rf .git/logs .git/refs/* .git/packed-refs &&
+	git update-ref HEAD $cutoff &&
+
+	# and then repack, which will leave us with a nice
+	# big bitmap pack of the "old" history, and all of
+	# the new history will be loose, as if it had been pushed
+	# up incrementally and exploded via unpack-objects
+	git repack -Ad &&
+	git multi-pack-index write --bitmap &&
+
+	# and now restore our original tip, as if the pushes
+	# had happened
+	git update-ref HEAD $orig_tip
+'
+
+test_partial_bitmap
+
+test_done
-- 
2.31.1.163.ga65ce7f831
