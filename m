Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DC9C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CBA60BD3
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhFBN3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 09:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhFBN3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 09:29:45 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ADFC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 06:28:02 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b9so2143138ilr.2
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bRIqw54OnccRJwNLHgt1rUTwywxvR664G4/FhdfHbEU=;
        b=chWta0TGe4PdHNIUL5l6JGf//oE3wchOkNFJDXALXZNNw0u909lOPG5fCyEGTVAMB/
         L7NXi3G0JxnRGIsPVB39MV2rlcrw+hY5hV+6RbYzmpLW/zag+a4wiYNXFO3M8y05iGr8
         kOl8TSo8g1HM9gE8oYYOAZk+KsOb3tzcromil/UQwzVT3Lypzr4A6wEVf1PrNOaouuh7
         seIDAihD+kbf4s47jwHSULNY3xEbsDkkWmFNROyMzelZXyY4imW5ws43sQJPvvu0/dNC
         AZeLHYLUPiv5lyuvlJdSTn0Fh93v6RoaJdU4Evj98X/288V4JhctAPyuiF0TwGu/PRWC
         om6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bRIqw54OnccRJwNLHgt1rUTwywxvR664G4/FhdfHbEU=;
        b=hhmTIG4hEjJe9tW52WicnzjM8WlkYWC30fbSIj4qXURHRVVzBJYoxLMB1ARh1zWFTl
         gMUjexud57xbaXqEBwsRt3xZbGrLxveJlPNnS7Z+jlbw+jLKcGdZ0JDx5CW7UOz3TjMR
         mKw00r1FTFhbPN++DDOcjmkYrbySnslKgQydLXM+KsLMKBvuGa6EWRis1vrS//k65a/j
         /7eYnIvKlyEG3HEw2+rxXOJb9EX5nAhoug5Ljs4nsnn4eBFn7yyKCDReQvddziD4AxpN
         2Xysj6DKtPHM0BCgqFVB/MZer22J22l6oQQZC8+ttSfASPNuVY8TKrTbrjhhPglnkfeO
         tC+w==
X-Gm-Message-State: AOAM533pTA3qJZwHQQCPEufXkZwngzObtF6+lISxSnIiuKNM85u2lh7q
        bkdsBpZm57QX86NofnvbvFUE4laqRNtl5AUZZAA=
X-Google-Smtp-Source: ABdhPJzWNbFoQ97TOQNzEcnO2GezfaWwDRYkXMTVKmMzYD5kb57wY0eHi0LBPhxP9z3KSUTHM9ssBOZNUBkZMVi6aFg=
X-Received: by 2002:a05:6e02:1ba5:: with SMTP id n5mr6404593ili.174.1622640482402;
 Wed, 02 Jun 2021 06:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
 <f02c1144d916bd36bd32069e439cfc08b2a7898a.1622558157.git.gitgitgadget@gmail.com>
 <YLZYZS8jBiOJynbz@coredump.intra.peff.net>
In-Reply-To: <YLZYZS8jBiOJynbz@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 2 Jun 2021 21:27:51 +0800
Message-ID: <CAOLTT8QfvRQdLOhHUsK63Z_8K2VsRq1umwFCNVhHKeodtu7BNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] cat-file: merge two block into one
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B46=E6=9C=881=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 01, 2021 at 02:35:57PM +0000, ZheNing Hu via GitGitGadget wro=
te:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> >  Because the two "if (opt->all_objects)" block
> >  are redundant, merge them into one, to provide
> >  better readability.
>
> Funny indentation of the commit message. :)
>

Yes, there is a small space that I didn=E2=80=99t notice. :)

> I think this is worth doing, and I agree the end-result is easier to
> read. Really minor nit, but I probably wouldn't have said "redundant"
> here. The conditionals themselves are redundant, but not the blocks.
> Maybe: There are two "if (opt->all_objects)" blocks next to each other;
> merge them into one to provide better readability.
>

Yeah, your expression is correct.

> (not a huge deal, as I think seeing the patch helps explain what is
> going on. But again, just trying to offer polishing advice for future
> patches)

Thanks.
--
ZheNing Hu
