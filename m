Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC60C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 06:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiKOGr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 01:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKOGry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 01:47:54 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43191D655
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 22:47:53 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y6so9992669iof.9
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 22:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/da04Vb/wSMDsiBXmbSS74iymlehU6G5ix9tEfvXerM=;
        b=39Rza/OYBoZvgyBrLNnojpNk12DT9aSlVFSjoiECcjEKQ2P0+m6dp1qS7B3zicdncN
         3Z/0PLr9+fuxlgYCcdDaKh8pSzQEfajoaLAta7curckcTeYdvpmyUkxoyupKIFkFcqyd
         eTShEzYsDbfZC9UFOkLNtWzM9nEnub3ObMgPo4Ab/l50LtpoKRD47Gdrt2t1fxjhDlDW
         2ZIB6TOq2fYHw0MqlPGy6TnP2n1e2UBZ1GjTwn84Wwo0v2VdI4gBIshN0UXK/MBbO+r7
         tuOPJkf2UPwDGPl4KNCl10CLUbh+0v4GoqwtrAdHG8JLxAlMfoWbUBT0xudEcuDQkrLP
         KFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/da04Vb/wSMDsiBXmbSS74iymlehU6G5ix9tEfvXerM=;
        b=g/ZVS3G//s2lP+fzaDpJY8ElZeq2Ovrao31O9t6u627SAkwUyNuhxNn+Ot8PooxHt0
         tFmWWBI2bdVOmFFcNJNWKoiuKiyP3d8gQzP0BlOV9x0MoO71XOX/q6xrP62vkFnRQVpY
         Uq8OHEiJIUAPVlUc8oxg8ueEh+ABUWrb9UDGD+TQHXoWDWK/x3uImoZLdFFP0K9RKrE3
         IUFpveGSl9nRke7n4xDzIR+S9EwbswskXwO+YKZawgcsdatt5vWl/IsnllTzykwbsQ1s
         uq3spvmF0Gzp2XVh9veMQu7qOrMPiDxOVIVdkUnsMtd8qVWMOy77y8DhzVAQCedzRJpH
         p7iQ==
X-Gm-Message-State: ANoB5pn4lT0ttJP5FQkr2wMRKabxgOW4ve/sBkKJp58ur+bTICnt8y7i
        euthDSe4FTZe+q0bjKulXaZVAw==
X-Google-Smtp-Source: AA0mqf6Mr782ebglTeAy2IjFg7MLIwA11ncZsX40jmPLGU3SZofltMBKCYvijDgYcGTPgNVHLKTScg==
X-Received: by 2002:a05:6638:3782:b0:374:f852:fb62 with SMTP id w2-20020a056638378200b00374f852fb62mr7586342jal.116.1668494873023;
        Mon, 14 Nov 2022 22:47:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z22-20020a05663822b600b003752e5b3c23sm4415687jas.20.2022.11.14.22.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:47:51 -0800 (PST)
Date:   Tue, 15 Nov 2022 01:47:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: ps/receive-use-only-advertised
Message-ID: <Y3M2Fq7pZk4lNY9G@nand.local>
References: <Y3Mag8qG2D3qjlmg@nand.local>
 <Y3MxmzestKm9iMTU@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3MxmzestKm9iMTU@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 07:28:43AM +0100, Patrick Steinhardt wrote:
> On Mon, Nov 14, 2022 at 11:50:11PM -0500, Taylor Blau wrote:
> [snip]
> > * ps/receive-use-only-advertised (2022-11-11) 7 commits
> >  - receive-pack: only use visible refs for connectivity check
> >  - rev-parse: add `--exclude-hidden=` option
> >  - revision: add new parameter to exclude hidden refs
> >  - revision: introduce struct to handle exclusions
> >  - revision: move together exclusion-related functions
> >  - refs: get rid of global list of hidden refs
> >  - refs: fix memory leak when parsing hideRefs config
> >
> >  "git receive-pack" used to use all the local refs as the boundary
> >  for checking connectivity of the data "git push" sent, but now it
> >  uses only the refs that it advertised to the pusher.  In a
> >  repository with the .hideRefs configuration, this reduces the
> >  resource needed to perform the check, and also forces the pusher to
> >  prove they have all objects that are necessary to complete the
> >  history on top of only the history available to them.
>
> We have at a later point established that this is not true: the pusher
> does not have to prove they have all objects. As the `--not --all` part
> in git-rev-list(1) is merely an optimization the semantics aren't
> changed at all

Thanks; this is Junio's description from when he picked up the topic
back in WC #08 from October. I'll need to update before graduating it
down.

> >  Expecting a (final?) reroll.
>
> I think this is stale, right? There was no further feedback until now,
> and in your [1] you say that things look good to you, but that you
> intend to wait a few days for further feedback.
>
> Thanks!

Yes, that is indeed stale, thanks for catching. I'm just waiting for a
review from somebody that isn't you or me ;-).


Thanks,
Taylor
