Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DB7C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D02F2339F
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbhAMPOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbhAMPOf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 10:14:35 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A5C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:13:55 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id b9so1284458qtr.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xCcm3kzcMqA3+/d9MJawRbZzOvUQeLhWUA/0VrrPr7c=;
        b=VJup71t6H3zLGpiS1v3emcxkes3mY3ukg06+qlEdmz5aw9fBgTUeO8W+8brzsyuktl
         zGmNfllLjDf5oGmLqx61AVNjZZRKYEc1qBxSeV4r0pnkOtfCSYv5CHCShHYJRfnzPzRd
         Z+54m1OENmKOjG8cCyLEPWReittfZlJEglelJ0PppVof6kstdxKzg9CS+GCYiuuSyY07
         DxJfPNZ3kpzhp5dkDRkpWcq2zLrBdMtjbCpujs/kaNI7vf4X71L2YuJK1AyWjzuEj2MQ
         u65dYlFpXZgq9bVJDs+JIyGok31vSlnG9Wz3YaKTCbk8Uvko6JNqxTBbw72ygyCT17fA
         8FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xCcm3kzcMqA3+/d9MJawRbZzOvUQeLhWUA/0VrrPr7c=;
        b=PSI7I7XSFrwh2rnatINUjoi4thOhNweLceP84EDCdzGsdvpnzwSgJrGxQHnRe1l3dX
         R8JHsUXgHURFIbYLSx4U6aNQZl66bA7oNZhSeCswKwN59zA80zKWbl3w0MU67/XR1wT3
         Av7vHmFxyNQfS2NqHukEes1LopFgjwosgQMmIwazoyWu3sD/Yfs+XWs4prZ28UsQMbtc
         BSKzpcjYnJg8Hp/7tTNpz9s5yzCUim4k0SK23/GQcNc1qPX1aYFGZ+mBoN7Hm6Sv1lvG
         bVRqNHgiR34IwbWb4eKUy8rY4G/vlHhP5zq2+snU65Dsa1SNS8lJVRBOXvUa1OdVVpQ3
         3QTg==
X-Gm-Message-State: AOAM531MBqvDKrQdPUg8JfjOJR1sNago2b4AvCe8ZXVT7dd8IqMSTzUz
        K6KvG5hGp1JZGtL4EBRLt4PXvhqm9RzoSw==
X-Google-Smtp-Source: ABdhPJyXSStNqFm88Q18PfftFGnlqGRXBaFJySgZrkg/1QTRaDTnBf2gi/o00/kk8eT8bYKRVwdSbA==
X-Received: by 2002:aed:232d:: with SMTP id h42mr2676007qtc.143.1610550834054;
        Wed, 13 Jan 2021 07:13:54 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id a35sm1072771qtk.82.2021.01.13.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:13:53 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:13:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: test-tool: bloom: generate_filter for multiple string?
Message-ID: <X/8OLozuyx+rxEHN@nand.local>
References: <20201231035438.22533-1-congdanhqx@gmail.com>
 <X/3+PG2hi71tj/UA@nand.local>
 <X/7guF05a/Bb/VNp@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/7guF05a/Bb/VNp@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 06:59:52PM +0700, Đoàn Trần Công Danh wrote:
> On 2021-01-12 14:53:32-0500, Taylor Blau <me@ttaylorr.com> wrote:
> > On Thu, Dec 31, 2020 at 10:54:38AM +0700, Đoàn Trần Công Danh wrote:
> > > I'm reading the code for Bloom Filter to see if arXiv:2012.00472
> > > could be an improvement.
> >
> > I'm late to the party, but I'm curious to hear which part of this
> > article you think would help out the Bloom filter implementation.
>
> Uhm, no. The article doesn't help the Bloom filter implementation.
> The article was suggesting using Bloom filter to speed-up the
> negotiation in fetch-pack and upload-pack. Which, in my own quick
> experience, doesn't help much. Maybe it's me not understand the
> article idea or I have made a naive implementation. However, I'm not
> convinced to pursued further.

I see. I read your "reading the code for Bloom Filter to see if ...
could be an improvement" as trying to improve the Bloom implementation.
Which after skimming the article, made me quite curious, since I didn't
understand what you were getting at.

But trying to speed up the negotiation makes sense, and is in line with
the goal of the article. It's too bad that you weren't able to produce
the same benefits here, but I understand why.

> If you are curious, I'm attaching 2 quick-and-low-quality patches with
> this email for your consideration.

Thanks. They were an interesting read.

Thanks,
Taylor
