Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536B4C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 22:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiI0We3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI0We1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 18:34:27 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80231E4597
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:34:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id g6so5820875ild.6
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BJ4ern1ZuNmdPFoCbmzFl8r8n7/HCcJOAk0LnmsX8oQ=;
        b=O+q6v0ZA3SX28BA4G6wPj2/4nI2Lp2ig9obACTJjCFkOojFIQAb70HWozhFsjtNwVC
         G1I0U0rEdoN0czx2UnrXYxdo/4TwoWiZZIcdEejeHNLBqelLGGQBFq5DjLbx26ViHkdF
         SZX1ojuAF9SXB/YVKkKwfmJOzllirGib4ttyO/Oj5uZy1WBUAE+LCgPvHZZyYK5PTyal
         PnDDCX48yjSLPgP1CxKKcVpBxA45ncJfPISFX50aG8SNJQkZ/k/KMjBfw36NWfCtlS81
         vybH1JQmm0qdAMeZe4hL1SrSihmvMFA/Zs/rN0RqyjAOtmBn3l7nDYkKj5Z8FRmA34Pk
         hooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BJ4ern1ZuNmdPFoCbmzFl8r8n7/HCcJOAk0LnmsX8oQ=;
        b=hS9cXeto9nb5Pr8VHQE2+v8YupZL6oHK3XvmxO+AUhJJuu+AOiV/TstHy3swcS9COr
         KcGwiA4lhZkSKKVkJUYVM491SB22I9t0CMM9Dj0It9DMnBH2Zc7wZkhVHp0Zq0O/OqqT
         KrcUfv3ZwA6yQAyJenl1KaZg8F67b0YEWELLhR4pYEg4R5l/szA7G0YytPIsZjY4j357
         eBBCEy8uZp7U2jXyTSqaqD08TFmGlHqVSsRPBLO5z9roKqYCaCaDwfq+y4P16PI6Ein0
         yhCb61MSZdqsoeRiuELHO5QzIvi5CUZlvP3gZ9djl+58Dcxdr+T8Rx8J+geDZk0bEBd+
         UVkA==
X-Gm-Message-State: ACrzQf3gZ3LAh/TpedPZdOiTb30dJ7MqnwhlaqBhW9TxcKLkZKQL+/58
        6izphpwqTy/pabaUfu7Zp24N61yCYhv51g==
X-Google-Smtp-Source: AMsMyM71/vY6/AfC7TCE2jx84UMiT5IyDEtDpGtIpQ/IoIu/176EqmqDNFtDtXmUT9vyEawj8Hq+eg==
X-Received: by 2002:a92:c5b0:0:b0:2f6:a5f1:9311 with SMTP id r16-20020a92c5b0000000b002f6a5f19311mr12116107ilt.55.1664318064160;
        Tue, 27 Sep 2022 15:34:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a12-20020a92d10c000000b002eb5eb4f8f9sm1038394ilb.77.2022.09.27.15.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:34:23 -0700 (PDT)
Date:   Tue, 27 Sep 2022 18:34:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: Git in Outreachy? (December 2022)
Message-ID: <YzN6btb9IzqeTEdi@nand.local>
References: <Ywzv7Dl6n+LcY//n@nand.local>
 <CAP8UFD2gUTuae0nRp2jHHoD3yLsVSGTBzEuHkv8QLDGJVAZ-MQ@mail.gmail.com>
 <CAP8UFD0+qW9aRVbXeKkvZKKi-6rge851FdT3FxPW98_JH_KLRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0+qW9aRVbXeKkvZKKi-6rge851FdT3FxPW98_JH_KLRQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 11:51:23AM +0200, Christian Couder wrote:
> The deadline to submit projects is September 29, so next Thursday.

FWIW, this was extended to make October 6th (at 4pm UTC) the deadline
for submitting projects.

> I think Taylor agreed in private discussions with submitting another
> project related to improving our https://git-scm.com/ website (which
> was discussed previously on the mailing list).

That's not quite the case. If I recall correctly, I said that I'd be
excited for somebody to submit that project. But I don't have the
capacity nor the skills to mentor it this cycle. If somebody else is,
I'd be happy to work with them to find funding for it.

Thanks,
Taylor
