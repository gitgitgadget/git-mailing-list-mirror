Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAEEC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65632070B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3s0KhiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgG2WDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgG2WDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:03:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C87C0619D2
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:03:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id lx9so2976819pjb.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CooFdYlRlYnW2HaHYHxMebgcLQon9pe4eprT3euFcL0=;
        b=B3s0KhiAxrLvcHmM5WaUdfRwOXwq5SLYdOP41s3QacHl4C1Monofx2wKQO4/PPSUaB
         K62qF8QATJJg+9Ft8c23n4ZUDudQxO9Mez/ctC5FL+1DnQ31nvGaEm0kVh0SrYT3LJw2
         IHAA2oOnkdVfqbkl4vlrPJ24GmVxlA9o7AT2a9Mj35zcV7203S/aY/IigOhVrilq2pW2
         cboMOzACABf88QeWx6zldWCMpDMLD5gt7BRSlvzQMLq5QZeiB6cQXWjI59tVT+JakDoM
         15XG181KIuJtp6d0qtQZH/bN9ywlm/+oM/YCO13hcbcGR1lAuukHRKWmlpeqzQZKeIFJ
         XGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CooFdYlRlYnW2HaHYHxMebgcLQon9pe4eprT3euFcL0=;
        b=RtfHdgULd56/gcxM3AVv3VhEBfpK+4DlyObeQNhT86SR3Tyym++6I9aVrkasI63avW
         2mLtDb5qtmN+3InuzoJSDfGpDGu3ByBIac3jW8Rt1yQcQBXbPFUPMgm9C1Dhb3tBA5Cd
         O6jcPGeRxJS09pmrPRy0XwLfXR/6pOGjoLoXscv7dvo9qphGDm3clixUV1FRohNGyKzH
         hPTWv7yocs1P+rvYWExzw9nIIQvkrdYITh0mFNGG0qRr9SBsYY50c/mE196OX4zrD79J
         HtFTZS2MIEmCGlXy6lE3g0J4mbQfkBpt+Q/Rx1X/LrcM6flf4G5/1LnDD0Kmn8WlnTmG
         zI8Q==
X-Gm-Message-State: AOAM530J9OAJHWmPpsYRIT2CLcoLOx7i4XbqgMvvGjCJPPAD0Y4CuIKa
        eMAHv0jh+k0g6jQvCz/6zS4AHA==
X-Google-Smtp-Source: ABdhPJyN4w2il4fSFhdCzNL8Bfs018Trpq1XbVKLI6SqSlTzIPph3BPEMJWWccZH1o/ZeKSc6ZVdbg==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr631373pjt.172.1596060190566;
        Wed, 29 Jul 2020 15:03:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id g30sm3546230pfq.189.2020.07.29.15.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:03:09 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:03:02 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, sluongng@gmail.com,
        jonathantanmy@google.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/18] Maintenance builtin, allowing 'gc --auto'
 customization
Message-ID: <20200729220302.GA2965447@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 05:56:22PM +0000, Derrick Stolee via GitGitGadget wrote:
> UPDATES in V2
> =============
> 
> I'm sending this between v2.28.0-rc2 adn v2.28.0 as the release things have
> become a bit quiet.
> 
>  * The biggest disruption to the range-diff is that I removed the premature
>    use of struct repository *r and instead continue to rely on 
>    the_repository. This means several patches were dropped that did prep
>    work in builtin/gc.c.
>    
>    
>  * I dropped the task hashmap and opted for a linear scan. This task list
>    will always be too small to justify the extra complication of the
>    hashmap.
>    
>    
>  * struct maintenance_opts is properly static now.
>    
>    
>  * Some tasks are renamed: fetch -> prefetch, pack-files ->
>    incremental-repack.
>    
>    
>  * With the rename, the prefetch task uses refs/prefetch/ instead of 
>    refs/hidden/.
>    
>    
>  * A trace2 region around the task executions are added.
>    
>    
> 
> Thanks, -Stolee

FYI: We covered this series in review club (me, Jonathan Tan, Jonathan
Nieder) so I'll send some mails with comments from all three of us.

We noticed reviewing that it looks like it's time to focus on the
details because the big picture of this series looks good. Since we were
able to review each patch independently, the approach you took to
separate the commits seems effective.

One concern I (Emily) had was about the use of midx without necessarily
checking the config, where users can opt out of using it. What are the
consequences of running maintenance that creates a multipack index
without the config turned on for the rest of Git?

 - Emily
