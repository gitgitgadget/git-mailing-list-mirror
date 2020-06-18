Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C95C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92E8207DD
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="dnsR2sov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgFRU3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgFRU3l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:29:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0BC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:29:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i3so8901809ljg.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNFdJLmIZbV7r218zDApYm8VS3sbW9DPdrSNfobd598=;
        b=dnsR2sovtNlKdiBT15l0yiI7DzgE65iss/NBHKv9553RzwclfaxZV8rt/y7VkRT8ei
         4iGzkV+8Vj64xE8lZsyD/5ukX6mIbzZ5BLO8lQsoGh9IRU5Z/crZyUGr5ooI4YH89ZNs
         gDsuinhZE0MDLehZjNa86c9W80PGIl7YIcmDymxwH0xkg/d2RHzvprp6FH23SzNWpgmZ
         Fhli9j57so99nmBiVOJGyI25KREE8XylbLAEf21g1mDy55UrSsilJFSU6RZBz6AFQCxq
         EzDUajgXiuhXUtI9CA0+BKGaDs0ScZNqrz5lMQ+d4tMK3OBvzyGfae165WJEySpuK1vK
         u61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNFdJLmIZbV7r218zDApYm8VS3sbW9DPdrSNfobd598=;
        b=qr2EL0nPQqF3z3w85/h/IzyawDEKhVfX0WEIfN9e7doV3ZVazbdVpHsZH7wpySfc2E
         QtWtb1OTmIrmLa3pTbcKEd/v7mNTODfQMNBsCb1ylmb1biGAqar3iKvAXiRLMcBashzX
         ipN9RmkY38lmX4XLBfeolWqro/vjwr7RVLIc4AEqf3C/3XejwwZEEVfjUccHu3ZKAp0W
         JmPoVmKdgfJrsFd0a53uChBCpXkesnS7Pk2Hcv5RW/UgWdank4gMZwU01IT5VS1oX5Cz
         eWTxutvUR0PNOH4WVotsCPZQgxLVqS405AWPhij4U6LIURpw1kDl77paEo+JJRrow60I
         0hzg==
X-Gm-Message-State: AOAM533sJtYIcXiwlO1nzSUjnclQVYtyaU77rtdt8uAgIRP0YIkky3dX
        GDXGDZdWR/mcXb1KcoMImE8rQLR39gr1i3DHOD/DRA==
X-Google-Smtp-Source: ABdhPJztq2ytgUt2Gt8U3FKWRaJ1xD3DA56v+AzEwZ+n/Y3TfznqvdWCr6C/cdNB/yPXoIH6UeMe3pndRLWPlw6Chlw=
X-Received: by 2002:a2e:1558:: with SMTP id 24mr86515ljv.202.1592512179389;
 Thu, 18 Jun 2020 13:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.809.git.git.1592356884310.gitgitgadget@gmail.com>
 <CAHd-oW5gTJO=6pYXvg3v=JfjffcajPyMpsUOoqXnozwYrg3WwQ@mail.gmail.com>
 <CABPp-BHtwifTHXxoxTKvz0mx45e2N-4SBTTfoRePcmMFAn1O2g@mail.gmail.com>
 <CAHd-oW7tT7GhHz7mCH9Y66B=kriBKv8ZyrTXT-VTJgcXGa1Jzw@mail.gmail.com> <CABPp-BHV6iKH4PS6Gqfhe6piBdgmZ9D+cgXvSJ+dNcw-UHD-+w@mail.gmail.com>
In-Reply-To: <CABPp-BHV6iKH4PS6Gqfhe6piBdgmZ9D+cgXvSJ+dNcw-UHD-+w@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 18 Jun 2020 17:29:28 -0300
Message-ID: <CAHd-oW7S1NKtwy=LdV95Nw-FPbLyUDV34BXLzd1D7Y6g29AtbQ@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: do not set SKIP_WORKTREE on submodules
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 4:20 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jun 18, 2020 at 7:34 AM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > On Wed, Jun 17, 2020 at 9:24 PM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > When we notice an initialized submodule that does not match the
> > > sparsity patterns, we should print a warning just like we do for
> > > unmerged and dirty entries.
> >
> > Yeah, seems like a good approach. Thanks for the explanations. Some of
> > the test cases in mt/grep-sparse-checkout will have to be adjusted
> > with this change. Should I reroll the series based on the patch you
> > will send or do you prefer to adjust them in your patch (and make it
> > dependent on mt/grep-sparse-checkout)?
>
> Ah, good catch.  Your series came first, is longer, and is reviewed
> other than the submodule/config stuff that needs someone more familiar
> with that area than me.  Since my patch needs more work anyway, how
> about I rebase my patch on top of your work, and make sure to ping you
> as a reviewer to make sure I don't mess anything up?

Sounds good :) Thanks
