Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA1CC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA6564DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 17:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhBPRLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhBPRLi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 12:11:38 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7170FC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 09:10:57 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id r77so10044955qka.12
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 09:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WryWoJK+EKW8kVXvyhO4kAK0lW5p7xq/QcEq3oLwYbM=;
        b=xWoWkHC9mSuWAplnSFRKiAkY5phyBy+iZCNt6OHYSPmD/SWuJBCLGD8mdeBZ8FrC8W
         hiE8UfvFL0RQGydgE/BnfOrFiFOZ93yqoUVfCepbu2HZaX6fmOKxvyYENkiI761kaS5P
         zuxEusqWXF4lgdDaG3XG8TJQkz/B2Bj6upoS1Yp3le60l9Z1qbI/Zv89iSN8YHSvvoZ/
         fMaC10fFnqV3fsesP6UejIxV9X5O+CQLRJorvtBcZfhko8GD263mBeA5lW6iIJ8e7q4c
         hGRtimLwycP/7zSEaWSkCmgCTwrJsKhx6nOeLDvKyex06W6HfNgrnxUVl7K57XY9Tr6q
         CxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WryWoJK+EKW8kVXvyhO4kAK0lW5p7xq/QcEq3oLwYbM=;
        b=VmvJWdMQEzDUf/glvS6KvHlE2TfrRBKjOSdO83o30tkm3G+2y62M+9jpy37cSZsOsM
         NQwI4AbEvJNMcyGc8Bemixqc4BudZs5NyKmqDtB8EHaFwql3NsCgTe9E60wBbjgKW484
         wSXPjXEjSKDedXNn4fSP1GphtKNpp353drFZw+eRmCx04NN0Xk+4xWXqQltNYzK4iErt
         3BAZx3f0JZokFK31Xk2u52OOOLuRZcH2iCFd0kGXeUtQyP2PNGCrawfmVWBKIhz/GXeK
         4vzM/fCEPHvvjTF+HKmz2XIz1BmbuIW2XpsmFV+E2x654AIDlGf5ZE1/OsOZpwqwhMNd
         7VSg==
X-Gm-Message-State: AOAM532qQ61Fw9/5nijwr5cGjf/XUw/GSx8Nv4uK6KePy3JroIHYqePo
        WYe2ga72WAKVGUUYw1O+86dowg==
X-Google-Smtp-Source: ABdhPJw87omsVrsMovxD+hoc9DcUh9JCTVxRWDtw+GTtMxyJ+dsXfsRnGLN4LkSAf0Ko3g2AHJpx7w==
X-Received: by 2002:a37:a016:: with SMTP id j22mr21350534qke.490.1613495456724;
        Tue, 16 Feb 2021 09:10:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id m5sm3764441qkf.55.2021.02.16.09.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 09:10:56 -0800 (PST)
Date:   Tue, 16 Feb 2021 12:10:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] blame: remove unnecessary use of get_commit_info()
Message-ID: <YCv8nvJ6faO7esoj@nand.local>
References: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
 <20210216163151.76307-2-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210216163151.76307-2-rafaeloliveira.cs@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 05:31:51PM +0100, Rafael Silva wrote:
> When `git blame --color-by-age`, the determine_line_heat() is called to
> select how to color the output based on the commit author's date.  It
> uses the get_commit_info() to parse the information into a `commit_info`
> structure, however, this is actually unnecessary because the
> determine_line_heat() caller also does the same.

Interesting. It looks like this micro-optimization could have been
safely performed as early as 25d5f52901 (builtin/blame: highlight
recently changed lines, 2018-04-23), which is when this feature was
originally introduced.

I looked at 25d5f52901 to see if there was any reason that we didn't at
the time, but couldn't find anything.

So this looks correct to me. I'm a little disappointed that some of
your more detailed performance numbers from the cover letter didn't make
it into the patch description, but it may not be worth belaboring the
point further.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
