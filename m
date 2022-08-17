Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A3DC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 20:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbiHQUiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiHQUiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 16:38:18 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB74E15705
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 13:38:16 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id e4so1263701qvr.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=J36laj4L8iROWAtYrFF1Aone9J6aMYpTUskfSNe5dB4=;
        b=mTSGb6mC0GyWvPqABcvNcPhAhsUVjoyQsIVWr3s0sOfgMbLJbhLGIJR0ToHQCPf+4Y
         U0N2FMoJUvHaykohwsx3lzDvweRBIbiw2Uexx6m/2zxl0y3uNpszhbFQ5i76Q9bcI7FR
         74IXJ3605ecl1GkHkv6RpxSKzZc/AC100WXKNrxYu94fbshcAA5gDUPinr4y7ZSags7K
         bE3zi2PnLyIt2tMyHWYbJll+IlOGSQ0xHovpNr5lGb/zNTQWHLGvjCQuFYfdPI5sOsAU
         MUu5joqNOrcTnXdHOrlIVMXIN41qImxsE4AatWrf87QwCWAHdhnWJfNZDOwo25TaIMIP
         JjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=J36laj4L8iROWAtYrFF1Aone9J6aMYpTUskfSNe5dB4=;
        b=sUnsGZQbEkUg9Id6NSrCuSU0fJ/HYgm08FVjcw+K3rkP1syQSVk2PN5cNzGvektpfl
         LN2Cu2c5WCPxNCfbGsQL+GGKWySd+0AJ2EKqIkbJl/vyzZGwdgiXPJ57r7lGguDMA7YB
         TUjrPMMLN6UrYjNnfw3JmHNKQAeWQPy7C9uNh/pABY6vdPoU3y00KbayIxVWP3X1jMC7
         mojykrzam28iJ4pu+gvHqf+7hPlJZ3G2Wv1Na1pSUVf05tOnLjgVhO5bFA5yNAEA6Nd3
         wm5OipRmnIqa6WSezvWwfLVnPrmdQAsidJiTwnglRrp6x6qN5Wn2cA/CEHJfmNbgQ9Vi
         L3Tg==
X-Gm-Message-State: ACgBeo3748tBnj3g0UzcplnSqimjDwsM33HL6xC//Tl507T6PJsfinK3
        lZ+jIHp25tuYeB9Tak5lYvgm+A==
X-Google-Smtp-Source: AA6agR77od2tmI6mTucjcIs2ddMWtuYBz07QlRNJr8y8VSWgaRv+QRgnDwKNdaevzQh+bGmwfbahFQ==
X-Received: by 2002:ad4:5caf:0:b0:496:b2ee:3706 with SMTP id q15-20020ad45caf000000b00496b2ee3706mr1793445qvh.58.1660768695745;
        Wed, 17 Aug 2022 13:38:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d1-20020a05622a100100b0034305a91aaesm13803813qte.83.2022.08.17.13.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:38:15 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:38:14 -0400
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
Message-ID: <Yv1RtjTkByAdOvjE@nand.local>
References: <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
 <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
 <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
 <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com>
 <805fb0df-45ab-7edd-8787-662b84201e2b@github.com>
 <CAPOJW5x0coFREUPjFbF_zzQYbfEjOrL-j-G4N7MBUN4N6uS2jw@mail.gmail.com>
 <179c0d30-ccb1-36cf-f783-814c9c8d84c2@github.com>
 <CAPOJW5z99b0_NGBYDbZUvmzbWECJKxGvB4RffoPJYszfFB0cEg@mail.gmail.com>
 <YvwS5RlEMvgDm93m@nand.local>
 <CAPOJW5znYngr4n4tBBCgqZY4Hr38NArHC7Go=ujDkmsFXY57mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPOJW5znYngr4n4tBBCgqZY4Hr38NArHC7Go=ujDkmsFXY57mQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 03:32:31PM +0530, Abhradeep Chakraborty wrote:
> Hello Taylor, extremely thanks for finding the reason for this failure.

No problem. I appreciate all of the time and effort that you, Dscho, and
Stolee all put into looking into this (especially while I was out).

My experience with the bitmap code is that it can be somewhat difficult
to work in, because there are both (a) many ways to introduce bugs, and
(b) the effect of a bug can occur far away from the source of the bug.
Those two together make debugging difficult, at least for me.

I think that having a test-tool (like Dscho suggested) to dump some
basic information about a bitmap's structure would be quite helpful in
the future.

> On Wed, Aug 17, 2022 at 3:28 AM Taylor Blau <me@ttaylorr.com> wrote:
> I am not able to understand this modification.
> `info[preferred_pack].orig_pack_int_id` and `preferred_pack` have the
> same value, right? I see `ctx.info` getting sorted only after calling
> `get_sorted_entries()` function.

Yeah, I realized that this is bogus. For one, (as you note) those have
the same value before setting up the pack_perm array. But it also goes
against the grain of what we're trying to do: the point is that the
prefered-ness of objects in an existing MIDX should be discarded when
generating a new pseudo-pack order.

> > I think there are a couple of ways to fix this. The easiest thing to do
> > would be to force the identity of the preferred pack to be the same when
> > generating a MIDX bitmap *while reusing an existing MIDX*, since that is
> > the only time this bug can happen.
> >
> > But that's a little magical for my taste. I think a more reasonable fix
> > would be to include copies of all objects from the preferred pack
> > including in the case where that pack was non-preferred in an existing
> > MIDX and at least one object in that pack was selected from a different
> > pack in the existing MIDX.
>
> I think the later approach makes the most sense to me. It might not be
> a good idea to keep the same pack as `preferred` as a better candidate
> would be ignored in that case.

Yep, I agree. Users should feel free to change the identity of the
preferred pack when rewriting a MIDX regardless of whether or not they
are using `--stdin-packs`.

> > Abhradeep -- let me know if this is something you want to look into. I
> > think it's a very worthwhile bug to fix, since it is definitely
> > trigger-able in the wild (notably, only with `git multi-pack-index write
> > --bitmap` without `--stdin-packs` and only under certain circumstances),
> > and not just limited to SHA-256 mode.
> >
> > If you are busy experimenting with CRoaring, that's no problem and I can
> > fix this up, too. Either way, it would be worth you and others weighing
> > in on which fix you think is worth pursuing.
>
> I will be happy to fix it but I can't work on it right now (neither on
> CRoaring) because I am currently preparing for my exam. I can continue
> my work after that (i.e. from 19 aug). If you feel it is getting too
> late then you can do this too. I am also thinking of  writing a patch
> for bitmap specific test dump tool (as Johannes proposed previously).

No problem. I wrote up some patches today myself that implement the
above fix. I haven't polished them up yet, but they are available here:

    https://github.com/ttaylorr/git/compare/master...ttaylorr:git:tb/bitmap-use-existing-preferred

I want to add a more direct reproduction that works in both SHA-1 and
SHA-256 to demonstrate that these patches fix the issue. But in the
meantime, you can use Dscho's reproduction with these patches (based on
the tip of `master`) applied on top and observe that it passes
consistently.

Thanks,
Taylor
