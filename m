Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEB7C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbiCHAuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244301AbiCHAuL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:50:11 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDBB2BDE
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:49:16 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id x4so3209136iom.12
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JzVdd9JqawtGszzL9+N0pu8k6aHd26IbEC4SD47GuiU=;
        b=3AdeYxeADRCbbmTPiWnsL+dhOelvaa7oCXPLeRvsP1QYPRKET8fxZc7JA+VQv0WaTq
         lkqzJNDsYkU0aWphCLv0Y0WyiyVGySHU8FmJhTiVbtBsYkj6iw3dnus1gXp/n3JtzIaO
         vJQVvKDxzFeXPVAH6w9L7gMQF1AcOxfOYWc1BombZJQjqpwhNE7QR0eNRSrXoGR3uRAf
         8n6tiSM/0Ao3jwrHqzxLPSWFliDUaoQBgrCs08DSjrx8M/gxAbkzjbY6GbtBIh1zpHsV
         vcRvZklu73mZvbQfyK+OZ/Z8+DQc0jf2G2vDuDUzN8iEZbD62w+NjM7ToSH8x2S6u6zj
         rKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JzVdd9JqawtGszzL9+N0pu8k6aHd26IbEC4SD47GuiU=;
        b=W5BErRGSqUJppFawFZZz4AeByNSDWiKBg3OHQHYfacCrNctKp+ywzuenFofxT8QN5j
         JDtzbwuRH4yD5QOMf7poQLwkT8VjY8jZz7MwMarJO8eT63YTl+6Gyl/7iXipodbrR0R+
         nV+vtzcorT27Q2eOdpstqb3uaBX68Zc+ay37d5EsBB7tft2oQx5zgPcO0/8Ub5a3bQKo
         Bmc3UIijI7+idN867NO0eo18Gf0H72/yB9JTnMZqDk8xnibuzYNLUkIULGR7TaeAU+Uw
         H3yPGIMAECLxgdelTZS216FpMiZIIAUG1ix44YIuCtj343Je9Sxo02osNIMBP1T0mKdY
         I2yA==
X-Gm-Message-State: AOAM533Ww9TOQphdSE0zhM2rN7tiRyixmaFdLx30RsIXAQz1MYsPc8Uc
        2+likzeL3TVxua7aNQRadw2jmA==
X-Google-Smtp-Source: ABdhPJykjLHlNrd4PpV7k3nch04hPieK6QFHPYtt4UVlQKisg6b+lgtPugLxJAlvuocJrcZqsyiolA==
X-Received: by 2002:a02:b048:0:b0:311:85be:a797 with SMTP id q8-20020a02b048000000b0031185bea797mr13125313jah.284.1646700555595;
        Mon, 07 Mar 2022 16:49:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n7-20020a056e021ba700b002c63098855csm4409770ili.23.2022.03.07.16.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 16:49:15 -0800 (PST)
Date:   Mon, 7 Mar 2022 19:49:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022,
 #01; Thu, 3))
Message-ID: <YiaoCivdcT3QE24f@nand.local>
References: <xmqqv8wu2vag.fsf@gitster.g>
 <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
 <YiZJiPVMZwPXbfrK@google.com>
 <YiZMhuI/DdpvQ/ED@nand.local>
 <xmqqv8wpp9ws.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8wpp9ws.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 07, 2022 at 04:25:55PM -0800, Junio C Hamano wrote:
> > If there are other benefits you had in mind, I'm curious to hear them.
> > But I think we should be fine to "lock in" the first version of the
> > .mtimes format since we have an easy-ish mechanism to change it in the
> > future.
>
> Hmph, how?  For example, if it turns out that rewriting .mtimes file
> for each object access turns out to be too much I/O churn and the
> approach to use the mtime of the cruft pack for expiration of the
> entire cruft pack (while ejecting objects that was used from the
> cruft pack out of it to resurrect them from expiration schedule) is
> more preferrable, how do we back out of from the "lock in" once this
> series is unleashed to the workd?

(Note that this series does not propose rewriting the .mtimes file
during each object access, since we only need to update our view of
"last modified time" when pruning or repacking. I think a more complete
explanation of why can be found in [1] and [2]).

That detail aside, if we suddenly decided that cruft packs were a bad
idea and we should get rid of them, then we would be fine to drop all of
the cruft pack code. A future version of Git that didn't understand
cruft packs would ignore the .mtimes file, and we would go back to
handling unreachable objects as we do today (by ejecting them loose when
pruning a too-new object that hasn't fallen out of the grace period).

In other words, this series is designed intentionally so that older
versions of Git that don't understand cruft packs will continue to work
fine even in the presence of cruft packs. If we backed out of cruft
packs at a later date, it would be no different than using an older
version of Git that predates cruft packs.

In other words, I think Stolee's comparison to a feature like
commit-graphs (where older versions of Git that don't yet understand
commit-graphs work just fine even in repositories that have
commit-graphs written) is applicable to this series, too.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Yap5INmX2ACfjoda@nand.local/
[2]: https://lore.kernel.org/git/YaqCZ7BPwuMGmkZY@nand.local/
