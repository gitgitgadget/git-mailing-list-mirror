Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0475C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E69160F55
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 08:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhHKIUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 04:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhHKIUo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 04:20:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53FBC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 01:20:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y7so2497035eda.5
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T9BeMvFTG3nb9fOaZsASwcG4GRw8MfgOdtzWk/OSSvM=;
        b=ZiJQmMimljLBiDHRwH6xR24kdyDzB9NYvx6y5P9g4UZQDsJcXp9rUSSQpk46j1g1hM
         iY4uDkwjCN1ZeyDZkBjPeZDxu+kPr16IqvHYpXx7k8PPXjtnaWn38vO9Umx+gqwViVJl
         /qkI8lWobnltJONHhnUuVLItWKhTCQicYfdsxMJ+TzoCIxjgQfpqeFfZdEPe/z77HrDg
         C0KTofdHI8WBbiNHg7nycFoMHWWhnNI5c/1cZVbEEX/W+YVCibaapvQKLgIqtZdnMTXU
         mqBz1cCqx3Qah+hrhJ/weRmqTVBRw7ogwEFMqumuaYxQL0ftmds+TkAk6F0zy5f7lGyI
         ng2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T9BeMvFTG3nb9fOaZsASwcG4GRw8MfgOdtzWk/OSSvM=;
        b=rwPAOh3NOXzhwVgx/phNWmRoqqywr1aoyscHCt7fPFjFJKuowU14eoPfM7ArvozAU5
         ctFppukoIfkoGIx6v+G5mZ2nec6Lj+6ltPCZv5nC+auowfWTFKgl733VLxbznLdfzR7m
         iq5GRe0sAJA8HvUC1Pgdb4AruH8AzSy1fLrIrsdxHPxwvKZSDmYVQUO3336qF7yWzEoP
         DT//OwmpMyLHo1I4sIIUOk4NkJy/DirbSeLt0CliGae7qSKZFJNNEHVQGpe7O2jcHY4B
         7ROFIxEtIJ9vkCwtf2xRZTqVppl0GSsN6Kr202Mzl6Nn1PV5qffk4Kd0Ln2p8X8Rr8qc
         c18w==
X-Gm-Message-State: AOAM530SpWHue6rDXXLWwVuqtwn9lZw5VEq5qkSFwK4eoPSDqLdSOe6I
        7bt3w7nx16r0P9Y+RIo7pNwagSwBVxj9FgIhgoc=
X-Google-Smtp-Source: ABdhPJwQKgQzWjpStoL8N3UxRGfbt6V6h37/We92tbqIEkTPACJ4OYRRSUVU2nL2u5VdtncY6YHQcLRWQT3b7sWXZxo=
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr10086392edu.273.1628670018280;
 Wed, 11 Aug 2021 01:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TYiUbXbkSTPY50jCU1bYP3JFx2P+hVmGL58S8V=AUMbA@mail.gmail.com>
 <CAP8UFD2yG3cC3qM3Ty7prdpVd=gXvArjM1soXD7EUn_NFFODaw@mail.gmail.com>
 <CAOLTT8TQxz2xkQE7etDa3cgb-kRfho-WAyhfHTsK=FrYVsPN1A@mail.gmail.com> <CAOLTT8S0etdnFNKuD7z5QMxWdERZ-FWimn4Sc+u+7Ra1F2WAmA@mail.gmail.com>
In-Reply-To: <CAOLTT8S0etdnFNKuD7z5QMxWdERZ-FWimn4Sc+u+7Ra1F2WAmA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Aug 2021 10:20:07 +0200
Message-ID: <CAP8UFD19PG7DnFzHF42PUDQ49pr8126ucYLVF6H4mAp61+Od2g@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 12
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 5:47 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:20=E5=86=99=E9=81=93=EF=BC=9A

> > I think find_subpos() called by grab_sub_body_contents() and find_wholi=
ne()
> > called by grab_person() are evidences that we are repeating iteratively=
.
> > But the proportion of time they occupy is too small. 0.0142% and 0.0109=
%
> >
>
> Using such a method may reduce some unnecessary scans [1]
> But it can do very little optimization... 1.6%.
> On the other hand, our optimization should focus on the default format of
> `git cat-file --batch`.
>
> My new idea is to need a fast path: when we use the default format,
> let us directly execute get_object() to avoid unnecessary traversal
> and checking.

I think it should be done not only when we use the default format but
when we use any format that only needs the metadata provided by
get_object(). This way that wouldn't be a special case fast path, but
rather a generally useful optimization.
