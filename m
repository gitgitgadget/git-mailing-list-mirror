Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75477C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDF961075
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 18:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344986AbhIASEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344961AbhIASEL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 14:04:11 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7BC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 11:03:14 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id i23so571358vsj.4
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HJc7RuXqWh3Ab6TwLIugIZ47ekjRptna5Cg5Ltvp0TU=;
        b=RQHQNul+wavmTP6T27vyvKPhfARgmt6Yqu6llWK68xN7ZBkdBmCcoSTW6N0DWL+C/b
         XuhvKDJk6h4xxNvGXyrNMvf1Omw27tz43ID4zQ+ZgoQzJt0ddLvkmbglWfm+uB1Sbe1U
         S4BBwOK9qOZJHBlzPLh6vsgJiash324nOgmF+oOa+WEYYd8+x1t4U7UyqimtWlEGwYz3
         o32x8P1aXKCw0r45uRzk5gwojtxJAGBpwPIjvn5nk7VMqENwCQ4+qkzOFO5IkuOxmibs
         021ejjbgaPSwuVyzehhADKjmSp5WVhN1FsUmwvqkux+69e1Lo8ixvDXAU9WLyQTqDkJC
         zzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HJc7RuXqWh3Ab6TwLIugIZ47ekjRptna5Cg5Ltvp0TU=;
        b=TesSs74JPfax3lQBwhiLjpYYZuRtOjKNobVhoxwNEiY0HdSnSklfR4NN76/is5DeXv
         DQS3GCaR0PhrSpWnPfJOirivGXBEkBf7EYUNgmQGdW76+k89vfUwdo3jXa8MEJr8Ujg1
         IUh4VTgv0gsLPO5YT4fOszPNlNPwKUEW7+hPjNxW9KAEo21Wrfa/mbr4E0qHEXf3oTbw
         qWFZxBF5Oc53D1gnQQr3bPBSloJAFaIRBBBdykSkTfVjaHHVKS9aF26rdqMw0xnZp7JN
         PIyzbgW3Hpk2lTWLYcC7AQC8YuupWm0ZA3NDHD5GrvF7JdtiD/RDg0d8fPpN01JHQr4Q
         +qAA==
X-Gm-Message-State: AOAM532H9r+uu66x96vtUfBRaOm5FNEyfLIpeDJlLxoABt5BYl3mVgW6
        KdRKj9W2u4lyVSF0N+3xQeUeJ+yQ7iedrpFqDEc=
X-Google-Smtp-Source: ABdhPJyHnHZB2PlNr4nDiJQXAP2SRx7kQUM3ePOe3fWjg4GMLm79kzVe3e/DFw+otIDneFeAd6tSj1XEv6zsWuY9UPI=
X-Received: by 2002:a67:ef92:: with SMTP id r18mr856712vsp.53.1630519393709;
 Wed, 01 Sep 2021 11:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210809013833.58110-4-carenas@gmail.com> <20210901091941.34886-1-carenas@gmail.com>
 <YS9RieTeJSFmd6M7@coredump.intra.peff.net> <878s0gwmvq.fsf@evledraar.gmail.com>
In-Reply-To: <878s0gwmvq.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 1 Sep 2021 11:03:02 -0700
Message-ID: <CAPUEspj2PNCjM2cLU6WzQ+rV7ftRBTfptKwht7N-=zVFTzan-A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] developer: support pedantic
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        phillip.wood@dunelm.org.uk, gitster@pobox.com, mackyle@gmail.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 1, 2021 at 4:34 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Wed, Sep 01 2021, Jeff King wrote:
>
> > Patch 2 looks good to me, though I kind of wonder if it is even worth
> > having an option to turn it off.

I failed to mention "Patch 2" isn't ready as it will break the mingw64
builds in Windows.

While I also hope there is no need to have an option to turn it off,
realistically I expect the wall of errors is still there for non
gcc/clang compilers and I am curious if some developer still using
RHEL 7 (or a clone) will report back and will be forced to use it.

> > IMHO the issue it is trying to find is not worth the inevitable problem=
s
> > that hacky perl parsing of C will cause (both false positives and
> > negatives). Not a statement on your perl code, but just based on
> > previous experience.
> >
> > So I'd probably take the first two patches, and leave the others.

Maybe better to discard the whole series and rebase it on top of =C3=86var'=
s then

> So I think (per [1]) that we should just remove
> USE_PARENS_AROUND_GETTEXT_N, and that the 3/4 here isn't needed at all
> (aside from concerns about parsing C with Perl).
>
> But in the future we need any assertion for this sort of thing at all
> it would be better built on top of my [2]. I.e. parse-options.c could do
> some basic sanity checking on the usage array it takes, we'd then end up
> detecting the issue USE_PARENS_AROUND_GETTEXT_N was trying to address,
> and more (such as the alignment problems I fixed in 1/2 of my [2]).

Regardless of how ugly my perl script was, I don't think this specific
issue could be
handled by the C code, as it needs to be done with preprocessed sources.

note also, it is not really parsing C, but just looking at a regex
which could have been as well handled with a simple grep.

The script was built under the incorrect assumption it would be useful
to track exceptions and have a way to keep that state (as well as the
code) cleanly out of the way (which is why patch 4 is also there).

Carlo
