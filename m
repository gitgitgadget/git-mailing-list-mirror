Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D956C47083
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 06:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E337613FF
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 06:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFDGDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 02:03:25 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35688 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFDGDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 02:03:24 -0400
Received: by mail-ot1-f52.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so8119284otg.2
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MxcMx2Q2TtTC2LlyeR69+NElgLtUKJ7v4kbZJFI+bzw=;
        b=MNBd8KvO9tK+9rPiPq4tpO8QBC0mDM9Z0w2REjGJjpLW2TaOyvmnQ16OQS9LcSfD/r
         L9IbphtQ5tkU2QZrdUK8vpoiVEAyebTZjtadenq5q8cqwKB+ZNF7gCvAI4kHfWeQYlVL
         zRBrS5zCZC1sQRrRa5Xqy1KGy5jp0MNXl6hwz+0277vWJxekZTjq2tMTjcN+y61YufC6
         9gob+IA1KptfFv+mWzLWNQv93ZDTKUgJjP9eFvVGydbUYROn0cxwims0sOM8ny3ooLnt
         KKBDZ8fuj7l4lOwJlRDZXzPjhp+EXuoJoCSbJN8L9iUGPzN5I6BEiJetnI7cG/ScAYrc
         8dPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MxcMx2Q2TtTC2LlyeR69+NElgLtUKJ7v4kbZJFI+bzw=;
        b=Nl4DnIOYkqCtooyEUl//7UkCo1gXOrjRPWssuOKMMhCEV11ghL7m2R8mOI0r7vsS3R
         UVd6IIPQXpORGsw4yHyjHkFZBqxJ6KXrD1QchHpkbo3rSHIKtGLqIxF8WuQen78cEPiz
         QnnI9wUtmJJptbXmnG+/QSiZ6htrLsHw20bvkwkopC1JSNnB/8yQhp9vnETwBGzws4Ql
         S7B2LCA4cQLRlTHElm9eekk0g35Vy7Kgma5J3i7+Ddx3ghyUph0rOdCeAey9ZifZyeBb
         8jti7s0RoSv5k/l2MBy1GyMgS6//coGabFajzQ3vPoGpunNmKvDaVk3DkiTN+dmmUedP
         y33Q==
X-Gm-Message-State: AOAM531Cbim0zMQXWwBe/m/NWtbw2UBuBc7aKURdvR5+g7/Tc/s/eK5t
        DQMBKogxxqqpa/i46tOGs4Q=
X-Google-Smtp-Source: ABdhPJxgVpmrMwdSW2YHxnMFj2LfPIBlal+dNqL3L6TyFBE/13uLTsI40/D0czF4qHqZ8UG0OdD1fQ==
X-Received: by 2002:a05:6830:1db6:: with SMTP id z22mr2571432oti.312.1622786428569;
        Thu, 03 Jun 2021 23:00:28 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v10sm252791ool.45.2021.06.03.23.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 23:00:28 -0700 (PDT)
Date:   Fri, 04 Jun 2021 01:00:26 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <60b9c17ae2306_3bd68520833@natae.notmuch>
In-Reply-To: <YLm4dn4INFPhg2OI@danh.dev>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
 <YLmGxcQ3s2gBbfe0@danh.dev>
 <60b98adc7f8cb_3a25c2208c9@natae.notmuch>
 <YLmLyT0XmQ/lOBKg@danh.dev>
 <60b9a1d25b63f_3a3b7e208fd@natae.notmuch>
 <YLm4dn4INFPhg2OI@danh.dev>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-06-03 22:45:22-0500, Felipe Contreras <felipe.contreras@gmail.c=
om> wrote:
> > =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> >> On 2021-06-03 21:07:24-0500, Felipe Contreras <felipe.contreras@gmai=
l.com> wrote:
> >> > =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> >> > > On 2021-06-03 20:11:45-0500, Felipe Contreras <felipe.contreras@=
gmail.com> wrote:
> >> > > > All you need to enable 2fa is demonstrate that you can *use* 2=
fa... So
> >> > > > you need an OTP client.
> >> > > =

> >> > > In the past, when I tried to enable 2FA, Google always asks for =
my
> >> > > Phone Number because of *security* and *safety* reason.
> >> > > =

> >> > > I tried to create a new Google account to double check my memory=
,
> >> > > Google now requires a phone number in order to *create* new Goog=
le
> >> > > accounts.
> >> > =

> >> > Presumably if you don't have a Google account, then don't have a
> >> > gmail.com address, and you can't use Gmail.
> >> > =

> >> > So why would this thread interest you?
> >> =

> >> The first point ;)
> > =

> > Which is?
> =

> Which is the point I specificly copy-pasted after that comment,
> and it's also the point you stripped out.
> =

> I guess it's my bad that I wasn't very clear in the original comment.
> So, here is the quote:
> =

> >> > > In the past, when I tried to enable 2FA, Google always asks for =
my
> >> > > Phone Number because of *security* and *safety* reason.

I still don't see what is your point.

If you don't have a Gmail account, then why do you care about particular
ways to authenticate into a Gmail account?

-- =

Felipe Contreras=
