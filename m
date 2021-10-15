Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84440C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 01:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C57611CC
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 01:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhJOB4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 21:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhJOB4v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 21:56:51 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5729C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 18:54:45 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id x1so6020155iof.7
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 18:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nuvweKoQjJBHteaR+/ADFNoIN4FUFGQnHEgGGPgpRBM=;
        b=Ar8s85f3C3BE+eM9zEGZEzxw9O8PP4lxbOy3kJv+2pjGfGisbleE/0EGZVxh2Xi5Xq
         zKkzqqWK9NLppEnFStv2g6D6UX2YwR7ZE5QCBsG6twlOM6C9AxTkfVG4wLTfWi6/SM3s
         BbvnbW4e+qFL3wxtweSLbvQ4Juzb6KAUaak81bYlZYxUoIvtLvOAw1Nn1yScLYXcoT8y
         KYeM1JI2XaROxtZLRuXG5X+p02ZQIdfEhFURehBpgAeH/+3t5hObOVauN6Bjg23U77aT
         N8iX9Ep0LXkOhDu1aWLJq0AbDMprM4BqA4TYexOaJ7sluNtFCFsStgjPwLasLBT2qswc
         fWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nuvweKoQjJBHteaR+/ADFNoIN4FUFGQnHEgGGPgpRBM=;
        b=8BkkMcYf3SmEqMHq7cY76MVl7CrqY0veAknJVeB3Uy1pxHq1ZuTbrNdB+IWTsT6DAX
         HK3w0kmNIWnadLWh2JQ2m40qCTZRkdW0KtrekN1NznwGqN0ID6hQfzg8cMdWlvWlyTwr
         B6/LrB2xy0DKADB3rMQHrOMkj6lhk8gL1c0acUXzl4XJVovLbLs44YyXxOwGRzSFOGha
         riVysQ0MHwo1Adp4KIQk7b16BbZv83DTLUfT9YeM1XajA25xf9Cl47gax+KyEONo6YxB
         e0mQspZl22N1HfuBITYLMdPcSs+lYwVSYn7ukpYCzbMYtjaKSj7Pqr1/8ty/LsWLRTQI
         97Ow==
X-Gm-Message-State: AOAM530t12pLZ67i/7LMoYzRqUqoJF0CE6aboMhyVUOrdERYlzmrn/Oq
        fg3+Vtknsc8k4VNkOvrIw0zQDSWEMsXR+Q==
X-Google-Smtp-Source: ABdhPJzXnGRGH/ByCoXWE5RQHetrTZWF2a4+k0SUPvixGIIJuvHyIXF1MjCV7SmJlUb84sErWpd9dQ==
X-Received: by 2002:a5e:a619:: with SMTP id q25mr1898416ioi.144.1634262885056;
        Thu, 14 Oct 2021 18:54:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v63sm1996069ioe.17.2021.10.14.18.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 18:54:44 -0700 (PDT)
Date:   Thu, 14 Oct 2021 21:54:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #04; Thu, 14)
Message-ID: <YWjfY3/62q6qNhFo@nand.local>
References: <xmqqwnmf9lnv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnmf9lnv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 05:28:04PM -0700, Junio C Hamano wrote:
> * tb/repack-write-midx (2021-10-07) 10 commits

This reminded me to check on the status of

    https://lore.kernel.org/git/42a8d2ef-3a67-ca2c-4334-b79975d45da7@gmail.com/

which hasn't been picked up yet. Stolee took a look and didn't have any
problems, and I think this is an important one to pick up before you cut
-rc0, since AFAICT `git multi-pack-index {expire,repack}` are broken on
platforms that do not allow move-into-place when the destination is
memory mapped.

Thanks,
Taylor
