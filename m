Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AFBC47083
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D0761406
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhFDEMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:12:21 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36860 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFDEMU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 00:12:20 -0400
Received: by mail-ed1-f50.google.com with SMTP id w21so9460661edv.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 21:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+afrMdnVoFMomJN6iSGxnHdp/FHylXXwwtw1D3hN4A=;
        b=dJ0ONYHkHi9A8k47GBbyMVuoUFmpwdWNzeXWSZsXk3xPo/dNCU9LqtCBSQKmOWbr1T
         NjkzWNL8LFdf+KJCe7XpvLmKoKjBA/NWicO9bsiqEmpibQAnHfXW6YmWdXTnThey0V8O
         reri6gM2rLSwx3R4l8TFckeWCBQGOTc6sSrQbE65EedAQzt0Rz6gUwddeT/IZxCsOcBU
         H6ZhEHvYV6DOXFda7DCPwkX7BSPRSfnF0qchynPBocqg3+E7SM+828l8hF6Nu0Ovj0rd
         iDhObC2/vQgEVatD41sZdXtlAmBkswmLqEim+PuimDFzofN67e69i2XOEQxvuwYe86Q4
         74yQ==
X-Gm-Message-State: AOAM533S967oEHi3Mx3ZoR2B6PIePQueluS40CEjHzy8U18WHqdXDs71
        qHYWeozQKSvkrMhxGaE/Q1pESarKU6HvA70IZWk=
X-Google-Smtp-Source: ABdhPJz5vJyZel4RFbcnaTMgm8H7ireyYQhr1Snu+8fSRtQtGnIaxuvCiIfbA++waB4z+z2mjYVpV5iwVvXl4BZnj7E=
X-Received: by 2002:a05:6402:311c:: with SMTP id dc28mr2586508edb.291.1622779820548;
 Thu, 03 Jun 2021 21:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local> <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch> <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
In-Reply-To: <60b97dd1acd9d_3a18272087b@natae.notmuch>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Jun 2021 00:10:09 -0400
Message-ID: <CAPig+cSXbCTymdrUOZwFBeUNMWuhnGb91Ar9Jth2cHCG2xav+g@mail.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 9:11 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Eric Sunshine wrote:
> > Google requires 2fa to be enabled in order to create app passwords,
>
> That doesn't make sense.

What doesn't make sense? My statement? Or Google's requirements?

> It's like complaining that you need to lose a limb in order to use
> prostetics...
> App passwords are a suboptimal solution in case you cannot use 2fa for a
> certain application.

Nevertheless, that's what Google requires.

> If you cannot use 2fa for any application, then don't enable 2fa, and
> then you don't need an app password. Just use your regular password.

Google has been clamping down on "regular password" use for
third-party applications/sign-ins for several years now and they
heavily discourage it. It is still possible to do it, though, by
enabling "Less secure apps" explicitly[1]. However, when "Less secure
apps" is enabled, they regularly send messages "strongly suggesting"
turning it off. I won't be surprised if the "Less secure apps" option
disappears at some point.

> > Thanks, that's an interesting bit of information, though if a person
> > can't enable 2fa in the first place, then... (intentionally left
> > blank)
>
> All you need to enable 2fa is demonstrate that you can *use* 2fa... So
> you need an OTP client.

I'd be happy to see concrete instructions explaining how to accomplish
all of this since each time I attempted it, Google's instructions led
me in endless circles, with each cycle always asking for (er,
requiring) my non-existent phone number.

[1]: https://support.google.com/accounts/answer/6010255/less-secure-apps-amp-your-google-account
