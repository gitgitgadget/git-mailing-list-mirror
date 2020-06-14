Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7691BC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 06:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526592068E
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 06:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=goodman-wilson.com header.i=@goodman-wilson.com header.b="ak+MCwTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgFNGe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNGeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 02:34:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58929C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 23:34:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q19so14060063eja.7
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goodman-wilson.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zAFMPuSXAQWC/xPJoqq3w70FfkmCAFCwCPIAN8cjdBk=;
        b=ak+MCwTw9BxL2+sQEvzEz8w3zYc0CtY7KO+qJDQHFSk//6QUX/Iyhpc4YZBIzYk3ui
         B53FQ4Tys83dnDAndN1bPpbq3irhcsF0Pz+IMildRKDS8/BXwoYjP1HM5LdWoEzijD5k
         IG2TZtYYheqzLTjF5aqFiGW34kPY7PAbhF7bSc/NEipLjc+nQSfT0CdvSn54TdnRqEbY
         15sQ/q0wEphzBAXZcV7kxEqk5MWVtc8OvSWX0MGoGexOFPibt82AfQDWcdMPpHMfu4DO
         mUL4t6Ppze+9pq9VnIpmPom/V6NrOB1Vsv27dy9N4gZArAwsD0ycMlQi3zHXlbqu3/cJ
         Tcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zAFMPuSXAQWC/xPJoqq3w70FfkmCAFCwCPIAN8cjdBk=;
        b=FFU+e8jlyOb0XScGyuE/uj5zu5vw1vQzmDDef8afDTguJ+WO2AoDYZ1hUSFdEKhhyx
         pI6dUbV0XAb7XyUhdDs9HRtgp8os6hvcdL2cX9OGSFm2magFzeme+3bBjwxhKuEXbQSB
         Rri8pLbDVXFzufNKURTjXP5X2cYM+DrvOYuyn8cn96YUxwrBc4Ontk61OB++mwjmrxT8
         GI/jybxzWfSIrZTL/k8Mz64/KA+puABZzxYVTCs2LBnuWLjeUg3M3+0pzBFvmNa6pD7L
         CbMMWKYq+NWEDHAbNYT2OtwK3iQOpcnAHd3V1QwCEuvrucUQVJ9e/3vRGvmIJ2uy0To6
         g0AQ==
X-Gm-Message-State: AOAM533A9MS0EnLEPEYOnZh9PuY3OOhC1BB+q6TZB65cD6fWzK7eBk/n
        CTqyQp2V5cnnwWNhfm+sHW8booJbiHW839790KLqBA==
X-Google-Smtp-Source: ABdhPJwvrDCOblwjC+sFcrZpOhXsye7o9MgZVFWRAiSRByNkFMAnpNTPrr0CY+Voi1y+N9/s34tgcpqXAFZgyhHuLVY=
X-Received: by 2002:a17:906:768e:: with SMTP id o14mr21227819ejm.497.1592116464084;
 Sat, 13 Jun 2020 23:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com> <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
 <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
In-Reply-To: <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
From:   Don Goodman-Wilson <don@goodman-wilson.com>
Date:   Sun, 14 Jun 2020 08:34:12 +0200
Message-ID: <CAGA3LAcZa76oSovMYS7kKt9YwbYe74YgEscQKKs5qd5_KCneNQ@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry, I meant "many (if not most) non-native English speakers DON'T
realize just how explosive certain English locutions can be to
American native speakers.")

On Sun, Jun 14, 2020 at 8:32 AM Don Goodman-Wilson
<don@goodman-wilson.com> wrote:
>
> I am an American living in Europe. Let me offer an analogy. Like all
> analogies, this one is imperfect, but I think it will serve to make my
> point.
>
> As an American, I don't understand French humor. It's simply beyond
> me. I've had it explained to me numerous times, but of course
> explaining a joke can't impart its inherent humor. But none of this
> should come as a surprise to anyone, as humor is a deeply cultural
> artifact, something that can only truly be understood by those raised
> within that culture. Even so, we can all appreciate the concept of
> humor generally. More to the point, I certainly don't go around
> denying that French humor exists, on the basis that I don't get it.
>
> In the same way, something I've learned living in Europe is that many
> (if not most) non-native English speakers realize just how explosive
> certain English locutions can be to American native speakers. That's
> totally understanable as, like French humor, you have to have been
> raised in the culture to really understand that fact. Like humor, we
> all have a sense of what offensiveness means, and like humor, this
> explosive content is a deeply cultural artifact, something that can
> only truly be understood by those raised within that culture. The
> visceral feeling of explosive content will probably always be beyond
> grasping, just as French humor will probably never make me laugh.
>
> But to deny that explosive content on the basis that you don't
> personally feel it, that you've never experienced it? To claim that it
> is "meaningless", that some people are "perpetually offended"? That's
> willful ignorance on your part, a bad-faith effort to engage in
> serious intellectual conversation about what is good and right, and
> has no place in a discussion about creating an inclusive space for all
> developers, let alone trying to bring about a more just world.
>
> Don Goodman-Wilson
>
> On Sun, Jun 14, 2020 at 2:50 AM S=C3=A9rgio Augusto Vianna
> <sergio.a.vianna@gmail.com> wrote:
> >
> > Then why create all this disruption by changing the default from master
> > to "main" if you will offer a feature to set the default on creation?
> > Americans were discussing trump's tiny hands last week and will have
> > moved on to any other meaningless subject the next one. You can
> > literally never please the perpetually offended. Taking this kind of
> > slacktivism and creating problems for other people is a disgusting leve=
l
> > of entitlement that only americans display. You really care about
> > others? Remember there's other countries in the world.
> >
