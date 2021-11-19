Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96A8C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A1F611C0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhKSFoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 00:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSFog (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 00:44:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA1C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:41:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v1so4413820edx.2
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ih8X8+f7IxrbfkBSSWnzz9kSq9DF8OUR3LTX/1zoTyo=;
        b=OTDA5/g3gky6u6MKQ/j17V7QJCrTyHGkASfx1TAsialJ7hhFJmw7kqfWE+OtHZHudx
         srpSfZn41DgNbj9MbOaMQnCtKhZYXDqXhdD2T71nsWOTURWyuCts6V74Volh/rxTh8H7
         vkluhavtNYKL+RNM6zJSj91CBlHNW9063Iz1UCk160p6UySK/P62V4B0LFPTxKdPzN8V
         +o3cCCWx14iTeo3qrX/39uhW0Meb0UNnMPq2FuiZr21xBmoDEqAsUUXw6L45Et4iwnHT
         K2vXkYleUFPKDV0wWifRC/msw9XtHnBxNfz5OGWUBEiO/paXUds0iNVWaDOwul3dJBoG
         nakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ih8X8+f7IxrbfkBSSWnzz9kSq9DF8OUR3LTX/1zoTyo=;
        b=JSCI9eDXyvAzZ6X/GcHwcM0Vb2asvEgI64DweUyThqAS8ciwgt13K6D3gN+dw3hM+Z
         c0QZUjaKpDNrfoupXUX/+dCdT+pWt7x6tjLUFsmzdXNKQtGnuN2BMeLnV5d8mDJffKBm
         qOlP5CpAPXav4iAQB2Fzy80vn10T57fQJGWtkOYwLg9ys/of3XuZT4E8YikrBGtOJubq
         JbP/1RtZyVHT+tZXWB4++L0Nn9/aL5XvgPa4m4zS/E+w3YqEXp2Db2Vji4pnif5E1pQQ
         2Acc4hpTNcN+vKa9J0EiKwe7kQk6AucmdoVdPien29oUcif+VwkNaANSswGtaARVhZGd
         PcHg==
X-Gm-Message-State: AOAM53277c1CwMEzR7U5IVxiTbYskfGEhE1dGlAVsFKT8DTqf5a70YVK
        MYJ4P7UuZIY3kWOkW5Pqgmsq0YR01igmTdpD9yI=
X-Google-Smtp-Source: ABdhPJwrpJ3cIKbw+3O91YrCUC/NHL2anFjRsIc1mK+RNmbvNb2gCmUlbIr3bDs914DlPYiLhYoMZEtozm69SrpEP7U=
X-Received: by 2002:a17:906:4c9:: with SMTP id g9mr4263188eja.172.1637300494077;
 Thu, 18 Nov 2021 21:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20211118154317.639118-1-alexhenrie24@gmail.com>
 <xmqqk0h5w3qy.fsf@gitster.g> <CAMMLpeSuL2k2semwS+K1jxTNZEV79GzCymFZo+1VcsyU6bYTrg@mail.gmail.com>
In-Reply-To: <CAMMLpeSuL2k2semwS+K1jxTNZEV79GzCymFZo+1VcsyU6bYTrg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Nov 2021 21:41:22 -0800
Message-ID: <CABPp-BHAqhpK4F2wTRhxZ5DXKOJExMxihbdpx1d2fYqAgtzS9w@mail.gmail.com>
Subject: Re: [PATCH] pull: don't say that merge is "the default strategy"
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 1:40 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Thu, Nov 18, 2021 at 2:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Alex Henrie <alexhenrie24@gmail.com> writes:
> >
> > > Git no longer has a default strategy for reconciling divergent branches,
> > > because there's no way for Git to know which strategy is appropriate in
> > > any particular situation.
> >
> > A very good observation, and the patch makes sense.
>
> Thanks, I'm glad you agree.
>
> > > The initially proposed version of commit
> > > 031e2f7ae195069d00d21cde906fce5b0318dbdd, "pull: abort by default when
> > > fast-forwarding is not possible", dropped this phrase from the message.
> > > It appears that leaving it in the message in the final version of the
> > > patch was accidental.
> >
> > Hmph, the one before later iterations v$N, i.e.
> >
> > https://lore.kernel.org/git/dca0455898a838b46546a29ee79f0a8b112fbff5.1626536508.git.gitgitgadget@gmail.com/
> >
> > seems to keep "the default" label from the beginning.
>
> I was referring to the patch that I originally wrote, before Elijah
> made the changes that actually got the patch accepted:
> https://lore.kernel.org/git/20210627000855.530985-1-alexhenrie24@gmail.com/
>
> > I am tempted to drop this latter last paragraph, which looks more
> > like a guess than anything else, and does not add much value to
> > future readers of the "git log".
>
> That's fine by me. I almost didn't include the second paragraph in the
> commit message to begin with.
>
> -Alex

Sorry for missing that bit from your original patch; thanks for
catching it and sending in the update.
