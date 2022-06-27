Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDEAC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 17:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiF0Rtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 13:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiF0Rtl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 13:49:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B976B1F8
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:49:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c137so7426085qkg.5
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CV0dLKve3Cxe87bikDa1ZrkBIZMur98PWnoJphrBMvI=;
        b=gkKIZpo7Pyn7wR2xYGtkD/XoFIjwRqRLBuOagBSoegwqS6KOTWra1ZBbWHLjqj/OC0
         V8m6DvAlhCaKotXWvt8n56Sw+SZrGMdd78PjMVKX9Vzp7Ej03xLJuO+1pbhcV/L3pthn
         1vH7qZPjwAXTVt0zHzbdGZnRezespiT5nfFbwilt0A1j7vJHOA7BsvY0/3Zybnb2yzag
         8QCs0iP4UfRDhuD1pMavSIVVw2Btg6eZ2fN/ua4uSpoa835M8oAAViPCaR2A8cx7hsLA
         VJvwfKOTR0nDn8Li1ul+OKWxfAVJC049l8kW2qVBuCrpcFSx57g1AkY+V20/9x63u8Mj
         amgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CV0dLKve3Cxe87bikDa1ZrkBIZMur98PWnoJphrBMvI=;
        b=Q/E/njQm4C8llhNDyf9tokaGePtVDBp720E7UO7sc1d8kwA7LwZsnkSW4r/f0K78cU
         MWcC1J6ks2RmhjbxJVcZ3Chu8jL7zICFtYJxDk08An9rPANLesdllb1zO/Rotn4QjYTF
         caLFM6poPjJBB7GXzfIyD2C8kXzdb1KkO1ewi4tSWtHGBNAdr4rGiIRnDtTAF1/BPacr
         lH6vZGa+LYMlFAzmkUUFFQDqt+wziwcoVUxas0rlLWhIZZAb6Btc6FBFFmEJmKiFl7Aj
         aw1GsvFNySem54nwEqrLErwr8IDQA77mUjuJIR+Sxhsc/p5+w8xZRi5nHreA59Rybxom
         t6wA==
X-Gm-Message-State: AJIora+W/s9PMRL15fcRg2vbSem3UtN4htqO/Tc8GiV1LOOGx7U0Cz7/
        e7Ci148ULKQ3GSi1U9YOdGLdng==
X-Google-Smtp-Source: AGRyM1uLPsHuDZXzbrqD+D+Jm3pqmFRUpznUxNOagM0igv4zO4U+vvDC0nWcipvdxubUl74dggZrHA==
X-Received: by 2002:ae9:e302:0:b0:6af:591:d9a1 with SMTP id v2-20020ae9e302000000b006af0591d9a1mr9007903qkf.39.1656352179611;
        Mon, 27 Jun 2022 10:49:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j17-20020ac84c91000000b002f39b99f6a4sm2557294qtv.62.2022.06.27.10.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:49:39 -0700 (PDT)
Date:   Mon, 27 Jun 2022 13:49:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 3/6] pack-bitmap-write: learn
 pack.writeBitmapLookupTable and add tests
Message-ID: <Yrntsj06L1G0joIz@nand.local>
References: <05edd01a-8b6f-b25d-0cd1-b1a46ca7c219@github.com>
 <20220627174230.16253-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627174230.16253-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 27, 2022 at 11:12:30PM +0530, Abhradeep Chakraborty wrote:
> Derrick Stolee <derrickstolee@github.com> wrote:
>
> > I wonder if it makes sense to have it default to 'false' for now, but to
> > change that default after the feature has been shipped and running in
> > production for a while.
>
> I do not have any opinion. If most reviewers agree on it, I will surely
> Set it to false.

I think it's definitely a safe approach. I don't have a huge concern
about enabling it earlier, but I don't think we're in a huge rush to add
a new feature here, either.

So I'd be fine to ship this with the default being disabled (IOW, *not*
writing the lookup table). That should give us a window where we can
shake out whatever bugs there are, as is often the case when working
with the bitmap code ;).

Thanks,
Taylor
