Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B70C4332F
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbiCBVhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245350AbiCBVhH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:37:07 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF06C7D6B
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:36:23 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v3so2903945qta.11
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 13:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZvAAq8VUvKmqkorI15l43WY4nZerFsx4iUMTRr33+aE=;
        b=tVfgHWJQsxkprQFOZfEDi4RzVXXufjGmdvoy1qhLmUCHbb2TAL9lGHwVS09E1P0EXJ
         HLGV56eyJ40KbNxpUddqQWNoEWeXlfTnOrI2FTAHbHvzQdu7FPHMwzxcWH+26A/x5dVm
         //zrWj5TOZVj2byEfvI1Ek+r7Fzn2mYZFW8HU6fg1ifCKYH7Df1yQ86cNq5doJVZqr/K
         8KJCaTZUKwixoI/sSIJ8e2gJdk+ICYPMCPS03SgiFlh3RGKCs8VmyvWXjusFg9fD4PTk
         61qdD5ou5Hw5FUWmii6LJL0dewl0gF1enWVbpBSfA3qpinduvjHUzUD7kOfYpj3It50k
         omnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZvAAq8VUvKmqkorI15l43WY4nZerFsx4iUMTRr33+aE=;
        b=nGphIWfuohYzNurl4lTbcYL1/bPP4DNkkHNRX8+xIcgCKAJ9db/Ios7Ota8/8kUOaz
         h0WItC0CuMSVGPkKa8BkqGcuDIPN5VYa82jMBLXfJzddy21rltyHpeCucSDSiIOAyg4h
         4YlsVNX1G7hyM00WDJ2pUlnPud/isUH5+h2l2bZScATjISvILuM0pdKfO7OOoZi6s2zm
         qnKv7TTWUIwT6MRIJd5jVflTaKjcSa4DnQGxsz1vwfCalWImfG2RhDptWfcs43kIohl7
         JjaU8imSz1Auziugo4xGgEiMgui2ZspLqYM9oQfLgTpHIi8YKr9XX77ZufzdC8TPtXtX
         NrfA==
X-Gm-Message-State: AOAM530XKbHBQSQamycU8OfDXFlqRQcC0xBdlS6cuIQmWlkFJCWEv6Di
        e3s1bkS/Gtc5MQqngoQM3xt9mw==
X-Google-Smtp-Source: ABdhPJxTVw2dYyY2vBG9Gi8JXHNjYoJD/buswNR+vsjOEU4tQnRnGx8X8Irrs6tXKICbKMIPNjfkkw==
X-Received: by 2002:ac8:5b51:0:b0:2de:4b7b:9657 with SMTP id n17-20020ac85b51000000b002de4b7b9657mr25586861qtw.347.1646256982941;
        Wed, 02 Mar 2022 13:36:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 7-20020ac85747000000b002de73a851ffsm103220qtx.89.2022.03.02.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:36:22 -0800 (PST)
Date:   Wed, 2 Mar 2022 16:36:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v2 00/17] cruft packs
Message-ID: <Yh/jVeXfohXJBu6t@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
 <138d98bd-928d-1708-128f-217bfe9a2788@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <138d98bd-928d-1708-128f-217bfe9a2788@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 02, 2022 at 03:23:05PM -0500, Derrick Stolee wrote:
> > For convenience, a range-diff is below. Thanks in advance for taking
> > another look!
>
> It had been a while since my last read, so I read the patches
> in full one more time. I found a couple nitpicks, but otherwise
> everything is looking good.

Thanks for reading! I took both of your suggestions (along with Junio's
to rename the test script to t5329 to avoid a clash with your series)
and will re-submit a tiny reroll shortly.

Thanks,
Taylor
