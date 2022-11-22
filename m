Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9DBC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiKVXfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiKVXfw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:35:52 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8908E748D1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:35:51 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p141so12107217iod.6
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVdIXWdinyFePuoFen5+RukpRUuhkAMb7u7B82tmFr0=;
        b=N4dDmSc1fl3PkIZZIy08ikbGDg0PWOwe6AY6EYWLG3mi28HSswva8em3sVkwq3tDRI
         MUcXWreOZTuuHR2FsRAobXZtjCoCR+0DuBGO5qc00EyWHRz5pwI5jOwWGbJJ+TDoScw6
         Ccic7ytv3RBVVf4HOrfQIpbOTKQZNLtmhPeVsgYDUwM7qjmiAfAJLaxOS1SH2iQtrAt8
         LkZkrnxoYpMKO0VEhTjOHzDdCPYCw1aYcauKntpVKU3TUm4I6HY/racd1aj7rf0a43jD
         njTqgYFILSF456EijXqzhMoTFENB88IMR8Dd0ggGwxBZz12CRxMNBk4luRJst+lzb30u
         Z+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVdIXWdinyFePuoFen5+RukpRUuhkAMb7u7B82tmFr0=;
        b=Qi1Alzq8ZkstK1Fy+tl2I1xOzUNkVoM1c/MuHnJLti8FCR16Yw4yFxPADTit5AF9FS
         d2EaVtJ5QDkttL8bL/wrhqm0zSvZ6JuM1Z0WzxS3F3uFmTFX5QPSfQEOSU5LxopyN84p
         O8sEpVLCbWAEPsEhuCJq8GIE6aXBEkCcRDf048j+fHv6CdfzioSWYXCzuTp1Yk2KCPjk
         RMSxgPmzWUKrKbEyGlruszFq0MV/VJCXa9Q4/RIUkSmIy11tDpgKbQGKJ/fvd9P6z15B
         EemMgQu5hqftXiTUWosTMBxljv5VetEaKihbS30qTawPYGc4mcnwmrIPs9CqIsKolFe0
         tNQA==
X-Gm-Message-State: ANoB5pkeHJfU+4kgAdkWDfL6gzqCAl5F/Ln+8wk6BxFTg+rHxwmIjO+e
        myXN8P0dDnb6KbIC+FyynPOgWoDuj41GKA==
X-Google-Smtp-Source: AA0mqf5bS3vi6uW9NnUkzp97D2VdvKMOiGKnSYsBtisYLZLnU432TTa/phmYEg+ms/gw8qoWlrDAGQ==
X-Received: by 2002:a02:2413:0:b0:374:8236:4cc6 with SMTP id f19-20020a022413000000b0037482364cc6mr11608699jaa.7.1669160150878;
        Tue, 22 Nov 2022 15:35:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k25-20020a023359000000b00375f28f47bcsm5766446jak.170.2022.11.22.15.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:35:50 -0800 (PST)
Date:   Tue, 22 Nov 2022 18:35:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #05; Tue, 22)
Message-ID: <Y31c1XZQn0RB+nrr@nand.local>
References: <xmqqfseargo4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfseargo4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 03:24:27AM +0900, Junio C Hamano wrote:
> I have been offline for the last couple of weeks, but it seems that
> the development community have continued to thrive under Taylor's
> care.  Thanks for successfully concluding the "bus factor" exercise,
> everybody.  It will probably take me a few more days to catch up
> with what is in the tree right now and has been described in the
> previous few issues of the "What's cooking" report, and after that
> we will have -rc0 for the coming release.

Welcome back ;-).

Thanks very much for your trust over the past few weeks. It was a lot of
fun, and a lot of work, though having high-quality patches and lots of
review made it easy. I certainly have a new-found appreciation for how
much work goes into being the maintainer.

It would be nice to have more people be able to participate in the
bus-factor exercise in the future. Not just because it gives you a
break, and improves our chances of survival. But it also left me with a
sense of some good "do's" and "don't's" for how to be a better
contributor.

Thanks,
Taylor
