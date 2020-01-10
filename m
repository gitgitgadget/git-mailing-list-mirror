Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D612EC32771
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 01:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C5C2075D
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 01:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyqDrFks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgAJB7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:59:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36827 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgAJB7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 20:59:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so336500wma.1
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 17:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pe9NR1mtlH/jNtiPtoHP9WDAAa3plOvWttDBqc42WdA=;
        b=CyqDrFksIgXf6blrhbP7RLy5hZObqIBdN5iSsJ/JMEPlSsETbyP7WvsEd37oWUt+SD
         P0B+lZ4lKW2Jxatviw1DG6ndxYWYW16pk2GzQoDOJ/Zor+SgGEaU3BIj1AAJRt++e+5c
         G+Ei6snyVbOOZ2S7vyVuyNR9BGsvc/xQom6JNCf3d/Rh15tCHQkgP5485vLUcM8Uq9KX
         Ec0ao3F7NncG8OjdQWS0eilT7AhlTB/kPly6tEZWrRZn8n4A69ZYkoVKPCNxRx5Umxg3
         QQMT/NXUYo2JHECb3wtmNvyh+YGjYSlAPGvF6bu6dqlDbPvxUl49WhMjDcFRd687tSyD
         8a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pe9NR1mtlH/jNtiPtoHP9WDAAa3plOvWttDBqc42WdA=;
        b=nIs9v+RqXkRKHmJ2ImqZ8fu9xGq/Lv6zMlY69XvAZeYQzURPCV07q/Jye6/wRhnV8v
         zFysnBAsOXl2eYpMuwJ7FBUxtoejGfI9DHLRLiz7DHJ7BICNN0N3sxIvoF8hpfYSM+jV
         v5JH1ifRFoJhlCj3I9Re/lyTozC5sdwVBeNPfsJvjVNBhKMTt0uZ1jaRlc/rZ6m5EcP0
         MDOqa0g7M3bHXVrP1bQQ0vIJ1XrJ3UGy9WUdEiIohSOHtYFssGyj1ouUfeSHE+HJmIRd
         WLB73M/ki8Yc5J7GN4G1ggc4FqgVtdHN8Bxl8ZLwJ+zM1Gdlf4knZ42OXYNHrsxCqVZX
         wStA==
X-Gm-Message-State: APjAAAXB28cGsGCTp85dvQH+zlY0/BERI9aYyDkIEF9NDfYpLig+DTVC
        VW/xSdu8nIGzqborcGYyFsBHpZYm
X-Google-Smtp-Source: APXvYqxjuW/K2RM40K50h4dTGahW2pZCv/Q2fi30wjgkbxtzvYzwONVJuDdBa4m9ItBTcUKKi8ThXQ==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr980280wmh.116.1578621571434;
        Thu, 09 Jan 2020 17:59:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm417229wrn.84.2020.01.09.17.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 17:59:30 -0800 (PST)
Message-Id: <pull.520.git.1578621570180.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jan 2020 01:59:30 +0000
Subject: [PATCH] unpack-trees: correctly compute result count
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, johannes.schindelin@gmx.net,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The clear_ce_flags_dir() method processes the cache entries within
a common directory. The returned int is the number of cache entries
processed by that directory. When using the sparse-checkout feature
in cone mode, we can skip the pattern matching for entries in the
directories that are entirely included or entirely excluded.

eb42feca (unpack-trees: hash less in cone mode, 2019-11-21)
introduced this performance feature. The old mechanism relied on
the counts returned by calling clear_ce_flags_1(), but the new
mechanism calculated the number of rows by subtracting "cache_end"
from "cache" to find the size of the range. However, the equation
is wrong because it divides by sizeof(struct cache_entry *). This
is not how pointer arithmetic works!

A coverity build of Git for Windows in preparation for the 2.25.0
release found this issue with the warning, "Pointer differences,
such as cache_end - cache, are automatically scaled down by the
size (8 bytes) of the pointed-to type (struct cache_entry *).
Most likely, the division by sizeof(struct cache_entry *) is
extraneous and should be eliminated." This warning is correct.

This leaves us with the question "how did this even work?" The
problem that occurs with this incorrect pointer arithmetic is
a performance-only bug, and a very slight one at that. Since
the entry count returned by clear_ce_flags_dir() is reduced by
a factor of 8, the loop in clear_ce_flags_1() will re-process
entries from those directories.

By inserting global counters into unpack-tree.c and tracing
them with trace2_data_intmax() (in a private change, for
testing), I was able to see count how many times the loop inside
clear_ce_flags_1() processed an entry and how many times
clear_ce_flags_dir() was called. Each of these are reduced by at
least a factor of 8 with the current change. A factor larger
than 8 happens when multiple levels of directories are repeated.

Specifically, in the Linux kernel repo, the command

	git sparse-checkout set LICENSES

restricts the working directory to only the files at root and
in the LICENSES directory. Here are the measured counts:

clear_ce_flags_1 loop blocks:
	Before: 11,520
	After:   1,621

clear_ce_flags_dir calls:
	Before: 7,048
	After:    606

While these are dramatic counts, the time spent in
clear_ce_flags_1() is under one millisecond in each case, so
the improvement is not measurable as an end-to-end time.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    unpack-trees: correctly compute result count
    
    Here is a very small fix to the cone-mode pattern-matching in
    unpack-trees.c. Johannes found this while running a Coverity scan for
    other issues. He alerted me to the problem and I could immediately see 
    my error here. In creating this patch, most of my time was spent asking
    "how did this work before?" and "why didn't this hurt performance?"
    Hopefully my commit message explains this thoroughly enough.
    
    As for making it into the release, I don't know. The change is small, it
    has a very limited scope, but this flaw is also not really hurting
    anything in a major way.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-520%2Fderrickstolee%2Funpack-trees-division-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-520/derrickstolee/unpack-trees-division-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/520

 unpack-trees.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 2399b6818b..3dba7f9f09 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1305,14 +1305,14 @@ static int clear_ce_flags_dir(struct index_state *istate,
 
 	if (pl->use_cone_patterns && orig_ret == MATCHED_RECURSIVE) {
 		struct cache_entry **ce = cache;
-		rc = (cache_end - cache) / sizeof(struct cache_entry *);
+		rc = cache_end - cache;
 
 		while (ce < cache_end) {
 			(*ce)->ce_flags &= ~clear_mask;
 			ce++;
 		}
 	} else if (pl->use_cone_patterns && orig_ret == NOT_MATCHED) {
-		rc = (cache_end - cache) / sizeof(struct cache_entry *);
+		rc = cache_end - cache;
 	} else {
 		rc = clear_ce_flags_1(istate, cache, cache_end - cache,
 				      prefix,

base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
-- 
gitgitgadget
