Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE8C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354096AbiETXac (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiETXa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:30:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7BD1A7D0B
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:30:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x7so5724688qta.6
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+qD19mgsM/y9Jd6j4FR2e0jFkrOH+ZDYNaxRrMfYAas=;
        b=SJrJ4QGYpybrpqEj9OY7N9HTE8btwD3urWtHJtDltHARpRSMBuTT5mRfGmoSbHMBbF
         CCkLQjzJ3RpPBcIk0bP4p0eS4EAyDgXskW0GTLDTnw03rTo2dCiJN8PMTVH9hfZLq2Nb
         rLi4GAVDmVRQ00da0xtjfzGlz9uMzOcYtaw0gNbad508QEYHJm32PDTPgsmtSr+sroBk
         wW+H2G4YJFDoovexEKYv2Trxk8UdnS5Knq1pbpW8J2yvloZYuT8eHlqAIvWiwEKAGKSQ
         d8GM5Wm/tL/lT2LEodcEOWrjtjcmTl08mn/XX5hPjkIuHyBYogDhgPWG9boZypAceim4
         ldrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qD19mgsM/y9Jd6j4FR2e0jFkrOH+ZDYNaxRrMfYAas=;
        b=FcSCFPKaMCRTDFuZOzncFADiPUttwSlKKchsHD39eoCRsHtLkNJv9bOdRNfYO2SM0E
         m0MBE3puN13bSRz8olyfBNyvmNyX1ajrk25MXE/of53nHw/pbCsTbwk/5hZdDId9HQCM
         gBnJ7gQm9WJ12ontqkKpyLYa1ekCIp9utRCukl9GmrF27XipQpWFBNPsNFvy1qq1wHfE
         VQgtoj9xYKXrq2m8OZnok674ZMh+6BlAb8U4dpqKH86M7PoL84q8duRrJgU/WQ3lVXrb
         hCq+r/ieYahLGOlKc13L9YZQC+mtUyhcyQQos63sUdeSfhTf56dJVXLFzhZObOXYzaHg
         WENw==
X-Gm-Message-State: AOAM531Gat43MBvjrODesGNXtlZ04BD/ObmIv4vJSjLyeCDeslPCojSj
        otIuuZ2nB9i/gp8cGa34UzWf1A==
X-Google-Smtp-Source: ABdhPJwjkBy8wCXxmAXNGYudxOIXl75F6Q0H97Jzq6kb+F0qvfdi/P0QOr0KqE41h34Q+WGgEe/wnA==
X-Received: by 2002:ac8:7f4b:0:b0:2f3:d0f4:b5af with SMTP id g11-20020ac87f4b000000b002f3d0f4b5afmr9503416qtk.577.1653089424717;
        Fri, 20 May 2022 16:30:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cb15-20020a05622a1f8f00b002f90a33c78csm452946qtb.67.2022.05.20.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:30:24 -0700 (PDT)
Date:   Fri, 20 May 2022 19:30:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, jrnieder@gmail.com, larsxschneider@gmail.com,
        tytso@mit.edu
Subject: Re: [PATCH v4 00/17] cruft packs
Message-ID: <Yogkj5ypIdLdLnIC@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <98d9bbe5-1902-0dc4-e41e-33020d0396ad@github.com>
 <xmqqa6bbg5cc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6bbg5cc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2022 at 04:19:15PM -0700, Junio C Hamano wrote:
> >> As always, a range-diff is below. Thanks in advance for taking another
> >> look!
> >
> > Looking at the range-diff, I'm happy with this version.
>
> Thanks.  I am tempted to mark the topic as "expecting (hopefully the
> final) reroll", to be merged down to 'next' soonish.

Here it is:

    https://lore.kernel.org/git/cover.1653088640.git.me@ttaylorr.com/.

Thanks,
Taylor
