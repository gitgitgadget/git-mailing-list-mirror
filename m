Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C41C63777
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 20:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE969217A0
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 20:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0bYJC1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgKUULh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgKUULh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 15:11:37 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF35AC0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 12:11:36 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id q4so4349020ual.8
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qnKRMDw6H6TC1JHIkvi3RNc2YZRzinZLHjjczDUrh/g=;
        b=H0bYJC1/6P0exJ0NLUmqYhKqGh0+RV1CEaidxLlmp+G2HcAhk2kyzCsWvOUsnoKVqf
         vC2fNBb5sOUKcOf8SNG4NKHA/ZmGDzSGEgr8Ih6eFpG1wJSOlhkTXS97BGGO/cL9PFc9
         tckarOXINgBP0LMDT0kr5WznDo60d83dNw4eBJBh6iCYKjsqpeFhR1/kI7eaHvyVDKDS
         VI88Oz8G6wqEh+nn2PsRDoN86vaPItzc9kDIetqTx7XuR/X2SLDely6+5/4vLCoUfhNV
         RIaScPA2048fLu2DKSkp+t/wg1SLWcaWPzUKcz2POZ0A2PKj3bBSxIy9h0YYAhH2H4Rd
         WWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qnKRMDw6H6TC1JHIkvi3RNc2YZRzinZLHjjczDUrh/g=;
        b=sz4v/f2zgJPj5mn3AdlZC8hvTeMUbHGldfGLxa6i9bj27Lx4Y7lzPNMT2fS+oD14jA
         UTxeGsma8BM9cKuuEDci8o1jbXiWNQHJgbbD9ZFb9KKPfA+p04hOtih12qfx9EC/bVUr
         qkwtCHQYpzGftFe+iZkj2LkZgLK8aHlPmipbftZfLC210fqMLGZg1ZnOZT+ULCNBIoFY
         ljGToylCNZD5ThC8AFMnF4qTFHBIWJrHMwrV8hcXivKWxilArKad9rroawpXPd1mSX3K
         xrUIYLwGEIGblHyHtnz/nWJgGDRalZyxZqEhwCTAb8kYNeR5uoxLoYVane1/U4gDU+uW
         95Wg==
X-Gm-Message-State: AOAM530Mc3Q8iuiIUVf3vB41R/DlvcOd391p9Ck0YXnPdSSkIrYFAcDb
        83jOBJ5I0CxUJWr1hUFmp+jXRn0vlDNF1bqlOqk=
X-Google-Smtp-Source: ABdhPJzeFjQ7Uk1/xFXSNOlD5gEDBaEenFi1QPmn7QKfOGFPD7E6YCpoLCiey0oWUQbhBiQ+3YOGxCEQyAymPe13FaA=
X-Received: by 2002:ab0:3112:: with SMTP id e18mr19313162ual.112.1605989495820;
 Sat, 21 Nov 2020 12:11:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605123652.git.me@ttaylorr.com> <cover.1605649533.git.me@ttaylorr.com>
 <CAN0heSq59uX=4pqkhc904oLfeiwF5ctiEb_9cQXYY7T1t=Mt1g@mail.gmail.com> <xmqqy2iusdpy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2iusdpy.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 21 Nov 2020 21:11:21 +0100
Message-ID: <CAN0heSpVnzyE5S5ReKQ0Q_UU48jQ77NVF1x1NTGx29+5KZsyRA@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Nov 2020 at 20:37, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > On Tue, 17 Nov 2020 at 22:46, Taylor Blau <me@ttaylorr.com> wrote:
> >> Not very much has changed since last time, but a range-diff is below
> >> nonetheless. The major changes are:
> >>
> >>   - Avoid an overflow when bounds checking in the second and third
> >>     patches (thanks, Martin, for noticing).
> >
> > FWIW, the updates to patches 2 and 3 look exactly like what I was
> > expecting after the discussion on v1. I have nothing to add.
>
> Thanks, both.  Shall we move the topic down to 'next'?

I really only dug into those patches 2 and 3. I read the rest of the
patches of v1 and went "that makes sense", but that's about it. I
started looking at "pack-bitmap-write: build fewer intermediate bitmaps"
and went "this looks really cool -- I should try to understand this". :-)

There was SZEDER's comment on that last patch in v2, where future
readers of that patch will have to wonder why it does s/256/270/ in a
test. I agree with SZEDER that the change should be mentioned in the
commit message, even if it's just "unfortunately, we have some magicness
here, plus we want to pass both with SHA-1 and SHA-256; turns out 270
hits the problem we want to test for".

Martin
