Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F5BC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C607264E3E
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBRDMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBRDMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:12:30 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D12DC061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:11:50 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id h125so2366859lfd.7
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snbS6bt6684gXv2Rh8fmBHKCGuLTA80+2y0SOsZyfUA=;
        b=eKqidbwcsiEriWaouKvNnAp84EGrh8MlP5lsnwd8KECb7s1vdCqFy/DatACCNjnGXg
         eOYJSrw3EAZBQcneAwpfNPvJNDszsVaM7R7nqjJsrnpGbzcFAZqSGqW62w++h9oGPvu0
         pjkKvngm4ES1bNm+31sCUVd7pZJYLeBUzS61jEglUyGl6uMgdAUrxwIvxXbhFsT9W7bX
         ur4zcSaUomQx1dexos0w8P80IxIag26HpBnKPqfUsJf1Yv0PgUM4ONgv8ugH6sTk8swP
         X7rh1k2gTMUsNg2BemS2e1RICOVKD3tlEDUhUNjnqsS8qlV5GM/i8Pk2MWdk1KKd/RRR
         OY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snbS6bt6684gXv2Rh8fmBHKCGuLTA80+2y0SOsZyfUA=;
        b=oHGkMvA7sPuxKROkJTnbyfASwCyeowLI2XROHrWB/lOuSOO2yXuSMulFCrhVVmY8hm
         mPXf5eaXMDoclQuM6f/bQ3TkHMxJtHtb16tz6vsOIYdUnMuvEWxH10BT5cXDbdXC+ZHM
         aKEfJ+tCojliKvCDxXw+++uobY1BMoXnPP4iaqTEpk0Wgyz6Qjc9jG5JH1CIChcqw/0r
         f6ioMfa5VQW5dDIPni0BnR1rukPtECOLN6DQjsIotigPndtd0ubehDnC1ixlO9g6fYcv
         qQcMWtkZnX2tZSIRsCp+rMSBBXncVxXFUjNt6WtFfLWfQ2uZI+epSLVV/TQXBPrGtAF+
         8HiA==
X-Gm-Message-State: AOAM5302AsXol1fgVVnMeksiNmTzMyOUDGuVI2uzl7M92PZSw4KgxE/r
        E4ZeYUNfvPGIiHIQ4swQowZxjSPNkM0jEd+x5b+/3g==
X-Google-Smtp-Source: ABdhPJxi8QXe7ZERDtH5cw6X4NecBODonBGJpeyhx57OkgkdUN8B7U7Xk6bw6d+cPbk7Mvolse81WAo5JhF3rlmGwtY=
X-Received: by 2002:a19:6916:: with SMTP id e22mr1172249lfc.421.1613617908576;
 Wed, 17 Feb 2021 19:11:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613593946.git.matheus.bernardino@usp.br>
 <6e30f133e234ff1d3a29f36423cd3fdca58d8095.1613593946.git.matheus.bernardino@usp.br>
 <xmqqpn0yi9ii.fsf@gitster.g> <CAPig+cT_ASSSe0jzEWiW_EPEa5FfHigfM+6fGQyG_kwj57XPfQ@mail.gmail.com>
In-Reply-To: <CAPig+cT_ASSSe0jzEWiW_EPEa5FfHigfM+6fGQyG_kwj57XPfQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 18 Feb 2021 00:11:37 -0300
Message-ID: <CAHd-oW6nseo-uEuQL0DxykJQevXyt9xX5kQ7Cy0T2YXqzgKVJg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 8:22 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Feb 17, 2021 at 6:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Matheus Tavares <matheus.bernardino@usp.br> writes:
> > > +for opt in "" -f -u --ignore-removal
> > > +do
> > > +     if test -n "$opt"
> > > +     then
> > > +             opt=" $opt"
> > > +     fi
> > > +     test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
> >
> ... A more idiomatic way to do this would
> have been:
>
>     for opt in "" -f -u --ignore-removal
>     do
>         test_expect_success " git add${opt:+ $opt} does ..." '

That's much better, thanks :)
