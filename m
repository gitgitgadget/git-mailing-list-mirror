Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6032C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 13:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F3320771
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 13:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6+JOBUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDINAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:00:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33865 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDINAO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 09:00:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id x62so3772950ede.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AT18Zer8pk6bcT7CmIOeAcIZw8WzZYgTCzRVTzSgog4=;
        b=F6+JOBUj4+FLhucudx50PTXMlON1pCKADZwsYFmgONpOnburzF8s+qByinLLWnsCVQ
         YeVGMV7yw1h6+c49OOfrwFfK5A7HzNgFlQCNnvszZPWljW5aTX39kA4zO3aUMjTFVG1K
         Q3ePUFa1BFdBrxAWREJncJDG1/hIPiO86uQRHudIuDTT4G9qp1otbhfsYuWF6F0HaZAY
         7XIW7a0g6N5R49VLFccZSaoGqFQUgvadkZGR3+uCGj4IzaIZFBq57kqW1798JOYq67I/
         FAfw9sAd0+O4bV8uLJmgkd01xpmGEpeB41kFwhxjEje0ZL+1U6I47W6gjPP9yBSqX+Uk
         EjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AT18Zer8pk6bcT7CmIOeAcIZw8WzZYgTCzRVTzSgog4=;
        b=qVYBmNK5HWksxUkP3+ESpzLAxITRgR0e+D+OW8JtD1+UP65JT85C1iU2nf/BWjio9X
         KvbEOZmXazqSKGkYcG5HxHWnPXndPNRKfVtZdqNmtWa4Vam9V5cSSiFrApdC2iWH3/UV
         JeYQ/yfb5OB4tcSf8+3HCyzNYcNAeV/LKLITyWOOeMbanmhmLI00wyJQRe0zLevkZDgL
         r0m4xKymVmeuWmr6Xl+SWW4WKhd2eKT0XMhuZKqO3fHx8Wn/Jro70RR0B1H35ZraMX6X
         5cuCeKTKwP02cuMygsoXonj70RL+//+OcZ8tsn6PibCVhlO2rpqShEpWrUcoLyzAWQ5Q
         mZmw==
X-Gm-Message-State: AGi0PuZrtGvOU9TKB+3QPwvtNSRx8alJ3QWOFPvZgLfX33q3Qa6oc/pP
        pAhhseFv7NvUXqMllNbGj3BuOpNA
X-Google-Smtp-Source: APiQypIq3UkQ0/QWIcbUkcIovcJ1JOtTkxwd3v2BlgBnfv27TAwLOE3FPUOI1VeatmYK0QcuV8uOaQ==
X-Received: by 2002:aa7:df0b:: with SMTP id c11mr4297000edy.140.1586437213202;
        Thu, 09 Apr 2020 06:00:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d61sm714492edc.1.2020.04.09.06.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 06:00:12 -0700 (PDT)
Message-Id: <pull.601.v2.git.1586437211842.gitgitgadget@gmail.com>
In-Reply-To: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
References: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 13:00:11 +0000
Subject: [PATCH v2] bloom: ignore renames when computing changed paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     philipoakley@iee.email, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The changed-path Bloom filters record an entry in the filter for
every path that was changed. This includes every add and delete,
regardless of whether a rename was detected. Detecting renames
causes significant performance issues, but also will trigger
downloading missing blobs in partial clone.

The simple fix is to disable rename detection when computing a
changed-path Bloom filter. This should already be disabled by
default, but it is good to explicitly enforce the intended
behavior.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-601%2Fderrickstolee%2Fdiff-and-bloom-filters-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-601/derrickstolee/diff-and-bloom-filters-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/601

Range-diff vs v1:

 1:  5fae00adcf0 ! 1:  f4df00a0dd4 bloom: ignore renames when computing changed paths
     @@ Commit message
      
          The changed-path Bloom filters record an entry in the filter for
          every path that was changed. This includes every add and delete,
     -    regardless of whther a rename was detected. Detecting renames
     +    regardless of whether a rename was detected. Detecting renames
          causes significant performance issues, but also will trigger
          downloading missing blobs in partial clone.
      
          The simple fix is to disable rename detection when computing a
     -    changed-path Bloom filter.
     +    changed-path Bloom filter. This should already be disabled by
     +    default, but it is good to explicitly enforce the intended
     +    behavior.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      


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
