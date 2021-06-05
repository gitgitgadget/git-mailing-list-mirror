Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54437C4743E
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410A061407
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 13:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFENVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFENVI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 09:21:08 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4839AC061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 06:19:20 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a6so13331979ioe.0
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jlNi95HnKZgjUDztqWnwOeyyekAO7qvJwqIEPXMuCN8=;
        b=SSMQ+OrBDbaEXuqjAU+Izl1JC4tfPhsPwV7cXeUOB+O5kNEI1dyvXdIpvi+gNbAxuR
         IEXE6NkLEfA7NcMt+4KBa3UZYHxn8ELkM07jgKAIvsW1FyKQ5Ore+Q9zVuna2iiYks85
         50AZFWdWpKP9IICAR15EhummukHEqMRiO+wyfeKACPHWdy6y/2fg4UUTx8tmGka46Ohy
         SctpD2Q9NqQ/XMv7tCHPSVe9FoPz4WtsLB2rH49a7iej6vMXjHXaUPScvGa9WL4H0Xi1
         X5ihVYxYRmxqOdh24P8F2vf8U9l04iIMZ0MyL1QP74QAajfVYS8KhBqKbqXfv606SNAd
         fwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jlNi95HnKZgjUDztqWnwOeyyekAO7qvJwqIEPXMuCN8=;
        b=n6zU4TAqoYQEqx32F/w1o8m169QXutAxy0U53YD5CjKlbx6JTuRK4ogpb5JHnZaybB
         iid6SBqlm+UeH+IcTn8ZR6W60ymRHtpALwlY+GbEvcQTFy6AmnzdLP1+GG7q4+ikdcrz
         WyKuzP6ugajCG6hBoUCGA31HYX5oPtINvKKXUsE3dLlIgOZ9Ggc4tkMMElxQilKngz0r
         d9pkBm+eimr+ePCRFa+G6N+VlXeRg683O4jvCSnlwye+wwvwYP4NT9Sch1SAjaOz8JoV
         tVLKngjmNGMcK+lK3e96LQzgtJzAh2VufQzoPWNMn7vIZLrHxeL9202ih2AJtKeY2SB7
         hVdw==
X-Gm-Message-State: AOAM530f/Xt+34vgJGdvFqMlZrwKt75RMQUVJbnhUBbYRXfvH3mB4heg
        e7e6/QxTfN2VN0K48Syu26RhxKvx9vcRKXoeSR4=
X-Google-Smtp-Source: ABdhPJymJhD8S/WT8NxUb0R3Zajk4DykdXeIZezEtZq+ntGo7BEV3WP/whJ89hMsLb6Sh3q6MQf7UU1apNRHWIkGtWo=
X-Received: by 2002:a5d:814d:: with SMTP id f13mr7657589ioo.203.1622899159706;
 Sat, 05 Jun 2021 06:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com> <b699c1b7-5f4c-b52e-1d81-a569c4dc45bd@gmail.com>
In-Reply-To: <b699c1b7-5f4c-b52e-1d81-a569c4dc45bd@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 5 Jun 2021 21:19:07 +0800
Message-ID: <CAOLTT8TTbT3q_qNuhKeSoPr2gkLOupZxRSdMcJvHKbAS3bd5dw@mail.gmail.com>
Subject: Re: [PATCH 0/6] [GSOC][RFC] ref-filter: add %(raw:textconv) and %(raw:filters)
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=885=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=886:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 05/06/21 16.13, ZheNing Hu via GitGitGadget wrote:
> > In order to let git cat-file --batch reuse ref-filter logic, This patch=
,
> > %(rest), %(raw:textconv), %(raw:filters) atoms and --rest=3D<rest> opti=
on are
> > added to ref-filter.
> >
>
> Better say "Add ... atoms and --rest=3D<rest> option to ref-filter, in
> order to let git cat-file reuse ref-filter logic."
>

OK.

> >   * %(rest) int the format will be replaced by the <rest> in --rest=3D<=
rest>.
> >   * the <rest> in --rest=3D<rest> can also be used as the <path> for
> >     %(raw:textconv) and %(raw:filters).
>
> s/int/in/
>
> Did you mean that %(rest) atom can also be used as <path> for the latter?
>

No. just the <rest> in `--rest=3D<rest>` will be treated as <path> for
%(raw:textconv)
and %(raw:filters).

> --
> An old man doll... just what I always wanted! - Clara

Thanks.
--
ZheNing Hu
