Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C78C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 16:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C87720769
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 16:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMLCD5hS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgDHQia (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:38:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36534 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgDHQia (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 12:38:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id i7so9466244edq.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kJSiGrXImpCPVe/lLCTdGicLe3EOfqSLJA+LjH4Xgow=;
        b=cMLCD5hSLPxhxo3iQ9m5Lsg4VYnrkYnR0ttcod33DGVDhuCl6+FznDHkt4NdNz2Voi
         K3XSpHWfm8txyglyZPiHjke8aKoaeKe+uJef9RFkWUdNI6sLKei8w5IkL8G3zcdTrSaa
         vIQ8HRGW8fU1rC8INrzW/o9XWgju1D4oLziyTT/IkO62zpU7VPiJTn0Ikzsw0zpnu7XY
         SGjOMYxD7INUY6ig6jQAomdV3PM/EmtFKII2iowlBdZNieN7Ux1LPQWuQSiH1GsCKyuE
         GBZmbi1rCIT2MJJARcR4JGDe02+wwRJKSMrMZ3+EkgSVwEB1e6+zwF500ymNvPOP/PB5
         czPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kJSiGrXImpCPVe/lLCTdGicLe3EOfqSLJA+LjH4Xgow=;
        b=qE4mgF2P7wtTTQJx9/DGWAvkIdh/7w0Qyx+l8wExXdPihUD/f+BdY3k2ysS1A6RQkn
         y2+llZ/3uxmqSWDk3939NVGGfliR9jED1DMCuJHELKI9h28iyPuMrNnpw06O8r+XMPh3
         +Zm3fL3S2kKW5EgbNh45L51/fwzcg3YCHslEbvPD4rFnl4pie8pkX0j83sR6PBZC0Kwp
         taWyXgqcNNnKFozkza4c957I3l+p+xt0KTwFUbsEFkaM6rmG2GtAbVOqo2REzYfa+yB0
         to8Nrx0V7nLX8coweVZdMQ5xHhbgT/b5Xi2vU6DMK6ThhNhW2evgUG0GCWikGjOqJijh
         rDpw==
X-Gm-Message-State: AGi0PubSS/EJiGAH0ubKNjLmKqO2nybdyMqWf1RbS6sxD4uq+cuVmLmE
        /94y951LgBEbiocTqUdn0vlE+q2h
X-Google-Smtp-Source: APiQypJ9cZPeRYhfOwNagw+WX8PWCQh8FVCnSDnLfqZGAGymDB0x7QRpZ24aakiQ3SNC8+qRaNi2+g==
X-Received: by 2002:a17:906:edb5:: with SMTP id sa21mr609351ejb.270.1586363908299;
        Wed, 08 Apr 2020 09:38:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19sm3533617ejn.31.2020.04.08.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 09:38:27 -0700 (PDT)
Message-Id: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 16:38:27 +0000
Subject: [PATCH] bloom: ignore renames when computing changed paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The changed-path Bloom filters record an entry in the filter for
every path that was changed. This includes every add and delete,
regardless of whther a rename was detected. Detecting renames
causes significant performance issues, but also will trigger
downloading missing blobs in partial clone.

The simple fix is to disable rename detection when computing a
changed-path Bloom filter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    bloom: ignore renames when computing changed paths
    
    I promised [1] I would adapt the commit that was dropped from
    gs/commit-graph-path-filter [2] on top of gs/commit-graph-path-filter
    and jt/avoid-prefetch-when-able-in-diff. However, I noticed that the
    change was extremely simple and has value without basing it on
    jt/avoid-prefetch-when-able-in-diff.
    
    This change applied to gs/commit-graph-path-filter has obvious CPU time
    improvements for computing changed-path Bloom filters (that I did not
    measure). The partial clone improvements require
    jt/avoid-prefetch-when-able-in-diff to be included, too, but the code
    does not depend on it at compile time.
    
    Thanks, -Stolee
    
    [1] 
    https://lore.kernel.org/git/7de2f54b-8704-a0e1-12aa-0ca9d3d70f6f@gmail.com/
    [2] 
    https://lore.kernel.org/git/55824cda89c1dca7756c8c2d831d6e115f4a9ddb.1585528298.git.gitgitgadget@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-601%2Fderrickstolee%2Fdiff-and-bloom-filters-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-601/derrickstolee/diff-and-bloom-filters-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/601

 bloom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bloom.c b/bloom.c
index c5b461d1cfe..dd9bab9bbd6 100644
--- a/bloom.c
+++ b/bloom.c
@@ -189,6 +189,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
+	diffopt.detect_rename = 0;
 	diffopt.max_changes = max_changes;
 	diff_setup_done(&diffopt);
 

base-commit: d5b873c832d832e44523d1d2a9d29afe2b84c84f
-- 
gitgitgadget
