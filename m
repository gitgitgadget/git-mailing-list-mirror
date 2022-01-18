Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA49C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 16:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbiARQt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346299AbiARQt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 11:49:59 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226CBC06161C
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:49:59 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i82so26307764ioa.8
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XhqHoWfB9U1weDu24kMOWUYsqgkcQJGPC6H8GaT9rMs=;
        b=2wEl9Tzsc7DfSlpl5y11cXZUy5LAF5cvb+t7ZU/v1GrIs8BGlbMWSX6hS4dwJFpj1n
         T7u3BIPMa/S9TDY7gDni5Z80UrMSruQ8yMqymjVszJi/HeJL05hHQCnCQk3MC0dT6Xm0
         fsf20K/OQPceJrpWSDWjgAVl0I3YGsb90WDl6BwiVVpuH3Yj0s+pBg+9rsfxM8wlU4Ys
         ui4nHiux1hUgFZ0VXsoYN5Z/fnXDC0UfIFiKxr3fUcCelioijL5kj9UTc2yYPSB9K4tM
         syFss/CznKHuVaWMqNMqR3yBQeC1KhPh7Gc6iRFElJ7LOwb5OD5a4F8rpk+RhsLIHZzR
         9vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XhqHoWfB9U1weDu24kMOWUYsqgkcQJGPC6H8GaT9rMs=;
        b=RI2MBz49JhKSII4TxrPTrO7JNTJKSKtFnqafaC0m/+guF5DPZsXqvKD6RZw2h87g+G
         DB6e8eQLTrg5yyCbRXsQWHymxxv2KfJxCd5TpVFASvTL1Q8TgpGhPP2ZStpa9XL148/8
         hwzW5ScNRo90RKdOVqSoO8iU8hKULnsw/g5E+DOkQ/j2egPoOijPrs59qjb+2F894abc
         zA9X5picen9ZU3mLRE3RyhazEZue4mI8ncjhzzlNK4FvlkjSVeYNUfmmMg1qVhihr7vH
         9fuNt6bRG02oEmNJradgC9koqfmgOTuDKvI/1UCDbBMvj7t89mqhwioK6mwZB10/Qyll
         ZrSA==
X-Gm-Message-State: AOAM532Yhw4dsIz+RN4x3E1+jpRbyoIbihCT56+T3vBWufMPHkfnySzX
        AKjOWct5ZR7P4mNwNP4sRe+30nAKYKqnuQ==
X-Google-Smtp-Source: ABdhPJyreJKqGFL2NGlFRPtvgYNW1G+gGIs5u/rNSq3DotzPQNIHjYbZhqyeBDk3oLxX14/ySO2cNg==
X-Received: by 2002:a05:6602:334d:: with SMTP id c13mr13166398ioz.113.1642524598534;
        Tue, 18 Jan 2022 08:49:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k1sm3946788ilo.66.2022.01.18.08.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 08:49:58 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:49:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] leak tests: ignore some new leaks in a few tests
Message-ID: <YebvtSsivC9vGAbX@nand.local>
References: <pull.1192.git.git.1642176433017.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1192.git.git.1642176433017.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 04:07:12PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> These test scripts have not changed at all recently, but topics in seen
> have caused these to trigger the linux-leaks test.  It has been reported
> on list, so let's fix the claim that these are leak free and when
> someone investigates and fixes the problem, they can turn it back on.

I think this problem was likely introduced by a faulty patch in
c2dbe00466 (Merge branch
'ps/avoid-unnecessary-hook-invocation-with-packed-refs' into seen,
2022-01-12), specifically 2e6b34bb1b (refs: open-code deletion of packed
refs, 2022-01-07).

But the newer version 69840cc0f7 of the same patch (merged via
17d1824959) fixes the leak. As a result, all three of those once-failing
tests now pass on 'seen' even when built with SANITIZE=leak.

We should be able to discard this patch as a result.

Thanks,
Taylor
