Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC498C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 12:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7B4206FA
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 12:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8HjMAu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHSMjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgHSMj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 08:39:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E37C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 05:39:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so26099493ejr.5
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GXCtJ8ipSuGhwNfvhBFxaQqCF9dWbepJtmxjJQg4y8=;
        b=u8HjMAu4Oz5fEkVJVkRJZRF5iWd0x9JJMw6NhLC42f2aWGZTp/l5Bfn57NZcsEUDgV
         1HI79y3KiXr0pflsHGkV4QDlobmuhXsT2oxJybjXQGLsGNNYYLV0HdI5Sdf75kY8yeXh
         4KxWmTEBK9TcxpHoPgh1pF9R5DFhD52TxdG/bEfoixXnnlhqp3naJGzoPobaLj9n9G1W
         aqp1FLUXaIi5t0edhTu2woL5Lm0Aha1PusDNeOnF7TfPD0B69joa2V6C9iizdEWZ8YTz
         Tdk5Z28PgaKNt78chqadaViOqk8XX0b9jltv52zxFqDhWFrL6VKrDVDl5LrLi9EJt5os
         +vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GXCtJ8ipSuGhwNfvhBFxaQqCF9dWbepJtmxjJQg4y8=;
        b=qfD80/7hLqguZ7NzZtwheLlEjmHrgtmlavdvTJrFh3x7vfEXwGFLvao/b1xPuMQQWl
         MrI03aJhopUWaRyiMT6NU3f5tiNBsTC8YQ6M/NscDoPG1C5VcHKDubhoqfoTP1my7dOG
         LN0TLSyhoe3NkxjgXNE39rv86i5HxfOi8CqV9JFd6jLdh0TfhsX2f0BeVyWGPaK5Fmt1
         ouWyrIajCxeITtO1W/bE9APkubMCsaGXhPThrH9+an6xjslj1HnI8D2qyA+dTdLz0U6n
         gStEhaEsblyfVfes5+FYcTHAJhsG+cgx7l6jRvz6BMknVXXBrd7O3zsmwbJO1EZk7frS
         T9tw==
X-Gm-Message-State: AOAM533AzGx5xFDfqrgQdPI1vKEVapc4S9nEvQU85IzJD7mlJXB/8bQ8
        lsyMeJcRRagMV8hv0Oo+Q9NO9wlhya2Pmq9rneu+Ew==
X-Google-Smtp-Source: ABdhPJz5Cjl9gMigs6e/xpqFOaI3e4KvMwBoqpcoSaDmmqvM0x0K/ArUVwYgViLCGD+64IGptxfNIr4TFF5yKCbbFrQ=
X-Received: by 2002:a17:906:3b91:: with SMTP id u17mr24447784ejf.305.1597840765541;
 Wed, 19 Aug 2020 05:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Twho+nyERK1Ljdy6MnXA=iK6SiU85v4yLQc+fRmW83JVa+hQ@mail.gmail.com>
 <20200819095109.GA60828@cat>
In-Reply-To: <20200819095109.GA60828@cat>
From:   Carmen Andoh <candoh@google.com>
Date:   Wed, 19 Aug 2020 08:39:14 -0400
Message-ID: <CA+Twho+=Xh4pPzdg+cbSOWMGX8_tPUuHLAe5Cuu8BwGtP3HYbw@mail.gmail.com>
Subject: Re: Git Inclusion Contributor Summit Registration
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, git-inclusion@googlegroups.com,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A welcome addition! Thanks for doing this Thomas.


On Wed, Aug 19, 2020 at 5:51 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 08/14, Carmen Andoh wrote:
> > Registration is now open for the Git contributor summit dedicated to
> > inclusion. The summit will take place online over two half days on
> > Monday, September 14th, 16:00-19:30 UTC (9am-12:30pm PDT) and Tuesday,
> > September 15th, 17:00-21:00 UTC (10am-2pm PDT).
>
> I've taken the liberty to add the event to tinyurl.com/gitCal with the
> link to the registration form, to give it some more visibility.
>
> Should that be unwelcome please let me know and I'm happy to remove
> it again :)
>
> > This is a free event.  We encourage anyone interested to register by
> > Tuesday, September 7th.  Registration does not guarantee attendance.
> > If you might want to lead a break-out discussion and attend a
> > moderator training session in advance, please respond by September
> > 1st.
> >
> > The contributor summit is an opportunity for members of the Git
> > community to gather, discuss issues of inclusion, and get face time
> > with some of the Git development team and other contributors.
> >
> > Please fill out the registration form [1] and organizers will be in
> > touch with more information in the coming weeks. If you have any
> > questions, contact git-inclusion@googlegroups.com.
> >
> >
> > [1] https://forms.gle/ryhQRv6yXiy2Y9MK6
> >
> > Thanks,
> > Carmen Andoh
