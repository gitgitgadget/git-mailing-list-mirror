Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB1C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 14:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34652613F2
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 14:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFCOJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:09:42 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:44634 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhFCOJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 10:09:42 -0400
Received: by mail-io1-f45.google.com with SMTP id v9so6370984ion.11
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LscL6y2AXkMzdWGBUqdRIF+5HHQGMUVcyZ9EuyHIZ/Q=;
        b=NW8gmH9gouG69W4jYhBrFck7rlGLX9SdRCMEi9ZNPrXTZawlma51jVxfyruzsusSUY
         OKXZ3fSxWn8C44/MF0Cz5waKDEZloyo4ZUSXtzL/GBiU9RTiESmlydabdeAsCVNEG0iv
         /oDor02lgZa8BiUCBM1sWYXBQPz7LpuGnzmdCBzqDMFGcAawWxNNKpNhTV8h/6FZcKfA
         vocnYSTxaFdnebPR4+ZUj68MGA//tuJeUCT6va+IjaT0P5fPQ5p1zGUYR2AwGaB0ioOG
         EMUdIbY7jVybgz5skLtIoc46hRRLBVRswYFBqabegvJmxFKmjBhKKiD6d7ZT3QU/K+LF
         IHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LscL6y2AXkMzdWGBUqdRIF+5HHQGMUVcyZ9EuyHIZ/Q=;
        b=SnmDjh22LI7o+1Y7kPY+zGV4aTYm4FJ+cMewxIhg6I1xKgXuC9orUjICMVt2ik/f/S
         AtFc/mjcaTAFh/6p+8F/8zPmAlDEGtO5jGrXzP4dmwqsHD9Duir3gHVF0xhNlcFjhmt5
         +GBrdIYBOOHgL+kOAChzXGLfP8cW6UZLQytZJIlNexBZRafgVnGUXcT6nccfm4a5glHa
         xMg8EBlZRrANc4N5tswvrDmVEQLObIHiS8RAvn5UhaINO6ehYlxuHcAtBqJ1B0vJC8e0
         KjMgQtMhx5hDijarzTna1UUe9zv7nFwvYlzkzYXSu4Ub/HT4Idp+m6wEJHPGZ4rKZ/5+
         Z2ig==
X-Gm-Message-State: AOAM53113YBkmiz0WskXbXaN1yGHl5RRH9FNFzyr2d2r8cyogiLFeq2G
        pCCFDsJLeKLuT3DHppufmbeZN+5rB4flcqtJa8w=
X-Google-Smtp-Source: ABdhPJzClmEItMt1munO2u/D+n3gRqMmhYNd35FJ+QuII9bSbooKJA+8BXPHpN3OuscJqVnYDyBZEN9sFf6j2hnJwfk=
X-Received: by 2002:a05:6638:144a:: with SMTP id l10mr11608jad.50.1622729206550;
 Thu, 03 Jun 2021 07:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <5a94705cdbc101169488919e35613d723e6ec581.1622558243.git.gitgitgadget@gmail.com>
 <xmqqsg1z65b8.fsf@gitster.g> <CAOLTT8TiyAtJfcrPoBF6SECfaKOTKt24NSOtTmf84JwHrU8g1A@mail.gmail.com>
In-Reply-To: <CAOLTT8TiyAtJfcrPoBF6SECfaKOTKt24NSOtTmf84JwHrU8g1A@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 3 Jun 2021 22:06:35 +0800
Message-ID: <CAOLTT8QjnFqXHRzAPnJStf4Ra189dZFe9k-Y9COoSCwW47CXiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=883=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8810:38=E5=86=99=E9=81=93=EF=BC=9A
> > But I do not think we want to add the new change at this location,
> > at least for two reasons:
> >
> >  * The posted patch checks '!arg' to avoid rejecting "raw:size",
> >    which would not scale at all.  What if you wanted to later add
> >    "raw:upcase", which you must reject?
> >
>
> Yeah, the code here makes "raw" lack of scalability. Especially we
> want to add "%(raw:textconv)" and "%(raw:filter)" later.
>

Now I am building %(raw:textconv) and %(raw:filter), the code will be
very difficult to write:

        if (format->quote_style && !strncmp(sp, "raw", 3)
                                && ((!arg) || (!strncmp(arg,
":textconv", 9)) || (!strncmp(arg, ":filter", 7))))
                return strbuf_addf_ret(err, -1, _("--format=3D%.*s
cannot be used with"
                                "--python, --shell, --tcl, --perl"),
(int)(ep-atom), atom);

Is there any good way?

Thanks.
--
ZheNing Hu
