Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD284C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiHSVtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHSVtp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:49:45 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA3C03
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:49:44 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id w18so4193681qki.8
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ISq6UMXZTKf7zv5KDGAsisZc0/6LC8QZAGMQf16b4jo=;
        b=Co6zZNp2LWRN1KoOMOGNmBFT7CLvXINFKdOOzAcvWit7049srXdOERwyYT4EvSw7qF
         dEdiB1cI6v6V33H0TXUDZkZ8EuNG7/4thLYofJl2HW6CUNKCtZT3kMRTA2hQxV0z/Cxf
         F8tBJsXxX0MMZfSOh6YkspOWPBNdfi85ZsnwoPrKjKeDIzsrpvZQIeUo8mx3oS/noSSk
         vQoGhqzgVQ7wv76WaWqSiG8tT5gxd+MAptFJlAVKGqOi6BcAxhlq3ijkd4pT5wkhS0P0
         SfUN7hxnC+3Qhym6d3FxoqgPTrtrdPEzICCj6jwH0JdD7xJUQoFEbFZ2OtiXjlD4cHDD
         I+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ISq6UMXZTKf7zv5KDGAsisZc0/6LC8QZAGMQf16b4jo=;
        b=C+b4EVWywLf7kj/aQyu/MxMd3E6gcuabe8jQZTfkTZyAjRmfHvVzk5b0jA8ZAduULR
         nTj8s90iYCiBj+oyHuvArVKselmK295gurj8LHFefQ/cNqQWkR6VlZtf6jKX7cz13ze6
         wiTMEd7CvaNT31vEij1igDGyfZDFSuVcC8iCTxhFFRYx/IRmKVN63PKYP+WbHbhIqiOh
         hdvGEDXjrOKkpd0r9EymXOqapG6Zl+NlErP3XKHlsI/B8Y7NIOiCAjfHchYFShYLhOi9
         6c2yZjgybLdNOPQ6iuUpOdJUM7a0tgCjet9hbYznFTfgb+bUGxTf+RlKblfBVtZigUWc
         ehnA==
X-Gm-Message-State: ACgBeo3veTe2wIbYpKzLAgQbOmPNvdi1Ha8NACsLegZlw6Usyv8/O6+R
        EnKs7geKFSyWHUlUj7H/s7oIWw==
X-Google-Smtp-Source: AA6agR4EsSe8OqgbhW61wVpOyqC45HmTvkdCb5yZpuHBsVYhVfJnvS4Xb8lCZOicpVdOiy/U95nSsw==
X-Received: by 2002:a05:620a:4042:b0:6bb:cdb:eef9 with SMTP id i2-20020a05620a404200b006bb0cdbeef9mr6688606qko.498.1660945783188;
        Fri, 19 Aug 2022 14:49:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w18-20020a05620a445200b006b5c061844fsm5219274qkp.49.2022.08.19.14.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:49:42 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:49:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn
 pack.writeBitmapLookupTable and add tests
Message-ID: <YwAFcax1Lmei6NMS@nand.local>
References: <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
 <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
 <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com>
 <805fb0df-45ab-7edd-8787-662b84201e2b@github.com>
 <CAPOJW5x0coFREUPjFbF_zzQYbfEjOrL-j-G4N7MBUN4N6uS2jw@mail.gmail.com>
 <179c0d30-ccb1-36cf-f783-814c9c8d84c2@github.com>
 <CAPOJW5z99b0_NGBYDbZUvmzbWECJKxGvB4RffoPJYszfFB0cEg@mail.gmail.com>
 <YvwS5RlEMvgDm93m@nand.local>
 <CAPOJW5znYngr4n4tBBCgqZY4Hr38NArHC7Go=ujDkmsFXY57mQ@mail.gmail.com>
 <Yv1RtjTkByAdOvjE@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv1RtjTkByAdOvjE@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Wed, Aug 17, 2022 at 04:38:14PM -0400, Taylor Blau wrote:
> > > Abhradeep -- let me know if this is something you want to look into. I
> > > think it's a very worthwhile bug to fix, since it is definitely
> > > trigger-able in the wild (notably, only with `git multi-pack-index write
> > > --bitmap` without `--stdin-packs` and only under certain circumstances),
> > > and not just limited to SHA-256 mode.
> > >
> > > If you are busy experimenting with CRoaring, that's no problem and I can
> > > fix this up, too. Either way, it would be worth you and others weighing
> > > in on which fix you think is worth pursuing.
> >
> > I will be happy to fix it but I can't work on it right now (neither on
> > CRoaring) because I am currently preparing for my exam. I can continue
> > my work after that (i.e. from 19 aug). If you feel it is getting too
> > late then you can do this too. I am also thinking of  writing a patch
> > for bitmap specific test dump tool (as Johannes proposed previously).
>
> No problem. I wrote up some patches today myself that implement the
> above fix. I haven't polished them up yet, but they are available here:
>
>     https://github.com/ttaylorr/git/compare/master...ttaylorr:git:tb/bitmap-use-existing-preferred
>
> I want to add a more direct reproduction that works in both SHA-1 and
> SHA-256 to demonstrate that these patches fix the issue. But in the
> meantime, you can use Dscho's reproduction with these patches (based on
> the tip of `master`) applied on top and observe that it passes
> consistently.

That is now done and I sent the resulting patch series to the list,
which I'd encourage you to review here:

    https://lore.kernel.org/git/cover.1660944574.git.me@ttaylorr.com/T/#t

Phew!

Thanks,
Taylor
