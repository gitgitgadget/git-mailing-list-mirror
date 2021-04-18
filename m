Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CAFC433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1596120C
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhDRIk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 04:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhDRIkw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 04:40:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1695C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 01:40:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x4so37133030edd.2
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=f7iuF7l9dvLomJs3YmI7aicBdcV9PNqeA3e/qEKiNfk=;
        b=MfiQayVI6oPj+fAjkoAosFLBa6BOF5HegTb7HHCGTMqhkfzZQEjGbMLyph4tQgG5pk
         oi31a4V9Mm53/WLrpInQw5WqJscJzzK0gxD/aDI9ob2sTnCe//M9OFk3HNpXHV2LZgHM
         bCCzUDAIjcitUIG46N4X6JCby4+dMUq9xGgjeSjEzFPRBcEOs983RTN1Dz0Q4dESqyi/
         u9fwWUME5Wmuo0J+tOpIYdXJFlpukHgwr/YHzDaRSEFMdkYZLPnXtx5tUHBMvWA6vSkN
         8DEYrqeRju5MQY2+elBDjlaS2A4wvpLNJ71G/qM4omiY9pAVP5HXEl7LuHB9H+Qmd+EP
         6Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=f7iuF7l9dvLomJs3YmI7aicBdcV9PNqeA3e/qEKiNfk=;
        b=XT2p9K1ZLNZwRJbOfWNmo5IKKRQShWqHifAQ06cQ26fXPIm4ufMKwASWmlbWLzuTXR
         ig43JQPk0rKrSyzq53qZdc1Z9hyq/PZppS3QhZG51Xs1nSfj4Xi1SeqedsgQeXNLLJj9
         EQxDJagRIooWOOinewUnMrm8IijZL89NG5gVZ8jJ+Ma6SnuxYQtjzV5bw9miHYU6cNrg
         6YWVbIWgjXojA7yzVjyIYbGhFLrktppXYj3b7ROA9BqmXHc2OeK+VRsJjHT2NJmnFu5r
         BlwDrsoxK7o5rLqCDu6V8cZ43VtSvCAa17+Dyf/wDqjxZCq7esB38zV2Bg2Z+W5FuwCT
         mE/A==
X-Gm-Message-State: AOAM533cY/2bRSxJH3r3szhna4DKmPNEpr+O5rWHT5NArkd8XiQ/WvHs
        LMuEaRljsFunDcCCXig1inA=
X-Google-Smtp-Source: ABdhPJw2Ggpozr+sUT+6f9GIOTiuqTe0dvvXfhrfwtln/MjBmuwdjVtQ4EKCP0faL0zIbebe0j5xPg==
X-Received: by 2002:a50:eb8f:: with SMTP id y15mr19558592edr.115.1618735223478;
        Sun, 18 Apr 2021 01:40:23 -0700 (PDT)
Received: from cpm12071.fritz.box ([79.140.115.143])
        by smtp.gmail.com with ESMTPSA id q25sm9944679edt.51.2021.04.18.01.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 01:40:22 -0700 (PDT)
References: <20210403090412.GH2271@szeder.dev>
 <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
 <20210414191403.4387-3-rafaeloliveira.cs@gmail.com>
 <xmqqzgxzqv5x.fsf@gitster.g>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] repack: avoid loosening promisor pack objects in
 partial clones
In-reply-to: <xmqqzgxzqv5x.fsf@gitster.g>
Message-ID: <gohp6ktuo456kq.fsf@cpm12071.fritz.box>
Date:   Sun, 18 Apr 2021 10:40:22 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Rafael Silva <rafaeloliveira.cs@gmail.com> writes:
>
>> For instance, a partially cloned repository that filters all the blob
>> objects (e.g. "--filter=blob:none"), `repack` ends up unpacking all
>> blobs into the filesystem that, depending on the repo size, makes
>> nearly impossible to repack the operation before running out of disk.
>
> Could you clarify this paragraph a bit more?  It is unclear why the
> repository has "all the blob objects" that it can loosen with repack
> in the first place, if it was cloned without any blob.  Do you mean
> that repack does not stop at the promisor pack boundary and instead
> lazily download blobs "on-demand", which ends up as loose objects?
>
> Thanks.

I should have written that we "unpack (or better turn loose) the 
promisor objects" not the `blob` objects. Instead, I should have
written something like:

    ... ends up loosening all promisor objects, on this case all
    the `trees` and `commits` objects, into the filesystem ...

Apologise for the confusion and this misleading message. I'll clarify
this in the v2. 

-- 
Thanks
Rafael
