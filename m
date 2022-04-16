Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B99C4321E
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiDPCIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiDPCG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:26 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADF82558D
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:02:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 79so1542608iou.7
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rJZpIZY6OaHKplgzh3llIn+2myiaz6AF/mj7pj1Tfpc=;
        b=5aOTzSTjtKGhbbfAPY4G+jAEUZ62qLCKVsHbIpU/RYcNoXuwlelPNNptaHX6ubDQdk
         V/O61n8jVjHKDNqW6giqSxmbgEHgEC4qHlW2IEB1mKOpoW3dWQAnS+dYijiCLo7ZXN+1
         T3FZhz81nqbWSG/oD8HUsPQYuwHwP7vSimURsXkVjT0pUNoxMSUCn6/IUicN2is3ivL+
         OD8FrKrTV9al/JvN1ZHBj/y3Vwlc9T9sFwVTpGX7RCM9tut7JtOtIabIR8FtKQVNAdtW
         xo/ZiiIbVIJH3yN54dn0IJ63oTkrPyjATaNVp0PdoEEcFHRSO9emaI5ldn4W0InjWBIe
         7flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rJZpIZY6OaHKplgzh3llIn+2myiaz6AF/mj7pj1Tfpc=;
        b=Prdy0dzwIAKBAZLxH/3DVnl6CbUd3HNxMMsv0WZlt9YGxKruWZUj2xiVALJLMdstnu
         ezup+NhbOHbtujc5bZs5B1jzSJrWK8u17MAxWUjmaVcgaorpPA3v6T8cUNMWfoD3Awvv
         j7Xf6OYZw+CvP9gU7IECGNsjKffOW43bIQ6PA4AzEMi4oh1KcNeIk92KUWxc7ROi/v+c
         /yp2tJD+uMpGipR8ywwoHDYxCKzrWs8m28JWsphGjldaTzkvH3fJR2XgGqHa4OCdQ+70
         amdQnKmbvdevcCRX4KvAY1y7vw504fwl6Q3FIA4qPaMVfTCoZdQIqOJ/veq05cl7jxQC
         AKnA==
X-Gm-Message-State: AOAM530QmPaRKnRZXeJZhuL/nRRiT0ZNekZOfNfiUcG4wAeOw0GkZuMR
        Bv5eJkxoBZghZofWnaBS8VMQD2GwHxgTKYQa
X-Google-Smtp-Source: ABdhPJx23bxOGKoSTWTblpYvFQ/M1LwYNC/TJAlC9RjIUH2Z8dohnbJnlr3e10OxIKvWqmnXKMdN0w==
X-Received: by 2002:ac8:1e85:0:b0:2ed:8ae:cfc2 with SMTP id c5-20020ac81e85000000b002ed08aecfc2mr1106459qtm.81.1650070338131;
        Fri, 15 Apr 2022 17:52:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y5-20020a05620a0e0500b0069c28a4e8ddsm3153450qkm.72.2022.04.15.17.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:52:17 -0700 (PDT)
Date:   Fri, 15 Apr 2022 20:52:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <YloTQH35r2xVdPm1@nand.local>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnfs4kud.fsf@gitster.g>
 <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqbkx31sc0.fsf@gitster.g>
 <kl6lbkx2821q.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqk0bqat4d.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0bqat4d.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 03:17:54PM -0700, Junio C Hamano wrote:
> What worries me more is the effect on _other_ people's server
> implementations ("server", because that is one major class of use
> case of bare repositories).  Essentially they need to identify the
> places where they depend on the current behaviour (i.e. going to the
> bare repository is enough to use it) and export GIT_DIR=. when they
> invoke "git" there.  The actual change that is necessary might be
> small, but identifying the places that need such changes may be
> added burden to them.

I'm definitely biased here, but I think that this is probably too big of
a burden to place on forge administrators.

Every repository on GitHub (and I suspect GitLab, too) is written as a
bare repository on disk, and so having to inject `GIT_DIR=.` into every
git invocation, while doable, seems like an unnecessary pain to impose.

I suppose you could hide this behavior behind an opt-in configuration
setting, e.g., `core.bareDiscovery` which determines whether or not we
will try to discover bare repositories without `GIT_DIR` in the
environment. That setting could default to true to avoid breaking
existing use-cases.

But I think that's just masking the overall pain that this approach
would incur, without providing much protection, so I wouldn't be unhappy
to see us pursue a different approach here.

Thanks,
Taylor
