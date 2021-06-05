Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36AEC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 04:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C2F61420
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 04:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFEEvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 00:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFEEvb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 00:51:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E85C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 21:49:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id my49so889152ejc.7
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 21:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=js1MmhPpZ4jNE5/aTCfL//u+ieT5wX69KdUb0rHdEr8=;
        b=d0JUNx6gl/t3HTrwm9Ju8RbPCOfGcIdhm28uGFwaW9in+/NCkYb4vfzcUWJfBJQrIY
         Lb6sqoNDHJSwjvOmGJBfqrwt0MDX4OX/zfvdv7GrVxZJ5hmZUqMD91Cuj+UDJ82xte//
         zMRHjdFrVLtbNVbS1i/2KdC4Cl+bjDxqCrKiodj8+8YE4hitbViDGoBkGv15xEspplos
         +odSEBvPVWJj5w+yIFB6TupaDsbDM2pPQFX6qZJOl/Hs3wvIH4dMB6YwZX19st3Ju1Gk
         8ENAdQTtX98SM8LtDxtCUsCgk7Mli5KEBi8iAnLGWRYsv7OT9ptt+OP6vDST7pMWOHQ3
         Yagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=js1MmhPpZ4jNE5/aTCfL//u+ieT5wX69KdUb0rHdEr8=;
        b=KuHvSGxtXlzzC+CJWCMwxsvvroVjVNr+OXVyGZNEWecULW+nLmxiVPRk4BR0I7lh6q
         qKcsWXek2KAOLSDT3jVdWsrhFra46znffUtF0UVNNfl3jAKJiCCBibRCSMQNPk69Vp1g
         XaSXz7EXdjI4zbPtv6NgWfGNjZqc8tuRdg6IRCk0X5SrE60Q7NEHWxfMh+AMKJZCQdgc
         ey0NBeJFi2XId1NNVdKdvkWAqAzR8vIsdn6lJXTgElz1UFhtInkZAdaid9tuKfe9Edvl
         efK5un22iLS+9mi0c3iMTnEHkxOWJ3rtS4rLv3u/XnRVNky93GyIk2siOjN6HePD/HIZ
         g8kw==
X-Gm-Message-State: AOAM533Tm1UcDqFKkfKAWaVTaacE2mhq9+3ekB6hFvhpBvhCAm/NntIa
        AgfPxxskAV9PJOfiPWr6H02u/BbPqi/154S+LTE=
X-Google-Smtp-Source: ABdhPJx8wAcaoG3k8eVvLFEv8XiUgZPNTJiTFXuzGm8QskEPAyRmYePHXss2UvRxUfwCprg+4yCL5Gl+ZilCeFzFYjg=
X-Received: by 2002:a17:906:ecb9:: with SMTP id qh25mr7611209ejb.283.1622868569921;
 Fri, 04 Jun 2021 21:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <pull.966.v2.git.1622808751.gitgitgadget@gmail.com> <CAP8UFD0PPU4O+L3p0qJhKpsiB=MvyGJbbtxP6Vu0YeeVQ-Ojmg@mail.gmail.com>
 <CAOLTT8SEXfNcpzKaGzvMXxJ1NS_dw-S--K5a_jQ=d3be5CgpXw@mail.gmail.com>
In-Reply-To: <CAOLTT8SEXfNcpzKaGzvMXxJ1NS_dw-S--K5a_jQ=d3be5CgpXw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Jun 2021 06:49:18 +0200
Message-ID: <CAP8UFD3SxAh1ZW2TTMqn2e6=qP1YDd5qVd15yFR669+cPr481Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
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

On Sat, Jun 5, 2021 at 6:34 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Hi, Christian,
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:53=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > No need to resend as it's a cover letter, but just in case there is
> > another round and you copy things from this cover letter:
> >
>
> Sorry, what is the bad place in this cover letter I write? This
> cover letter is also different from the last time ...

I was talking about the grammatical issues below in the cover letter.
Sometimes people copy things, for example a text explaining what the
patch series is about, from the cover letter of version N to the cover
letter of version N + 1, so I thought that telling you about
grammatical issues in this cover letter could perhaps help you if you
have to write another cover letter for another version of this patch
series.
