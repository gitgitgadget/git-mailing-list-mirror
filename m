Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61046C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 04:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48ECF61420
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 04:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFEEgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 00:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEEg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 00:36:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765FC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 21:34:26 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id w14so1168200ilv.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 21:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bqQdD84XZ+5peSue/j5/06FV9I0UTHkOqwUwdl6MNIQ=;
        b=dgOZDbvgkg7DDOShxNcXAqAuHEyedABSCAKOe8pTjXmI28HBa40ppBzWNmMcTbFTP1
         s6TqiZjWly3OG+z2NkpuwIEpU4Qf7iCKNjzibVkFywxHwZ2sPRGK+OfPAcg1x/OQEfHv
         uIRlbq1tSyk/dHppYBJIk4crqRMhdDFBzqREJmWQxrAErUvCKxFjsGGKOQba1ezfSV5P
         lZfS2zcaFfkhahLixDq74BvxsCYgBeENoROhjQcJ9Q2yyRIY+atvOgbrIGuOWM3pQdfA
         zeIGULVEpTAZGrJUmvLmED6bPUTaejBd7jA7gVSW4sf9rlQKbIDCRcOZlkd9rFQ4H9O4
         p9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bqQdD84XZ+5peSue/j5/06FV9I0UTHkOqwUwdl6MNIQ=;
        b=b78yju4U0HxRlHmTUztGXXR6EOEG0zll9fwm3ymgd3OlcBxz4NPg8x1olY3lRQZsih
         gL+Lo89q2PDeM0dyiUYmkPHufQtRvNFdEGKvtRLAi1NlZlBBpY2ls0rSQeN6lPyt/j7n
         RZ0Smr/SJXJbDheNo/HznGD8zsXM0Bz1NF9pJ5IhwDMoPCZwrwSjfBks8V4AgZlHAeMq
         OyPZiocgRFloAOWSNvZCQfQT+k/oM8iPGMN/mM8z0qCqsRr4j51Qqwe65bBbNedoH3jO
         SlZXXc4vNfu1UiIRDk77rK5f+KJx6jLWVdAdX14kBeTTbo54CECAlid7hCljtrdqFauT
         1PZg==
X-Gm-Message-State: AOAM533KUOKjH89tm3V9Lun3CR0ZPRuIRQOZ3iWCMniCA6qtV0FGdGqS
        pq8qt2TZHCbv+dd8qq/EeeW27LiiG5VaYWLIwH7bYG5ktvDUF+id
X-Google-Smtp-Source: ABdhPJzrUu7inyWcsG0YfqwfukVgxCEWV8dwZ531aG6SG+Mo/ninr2n+qQCGU8OXMOGE/VkEZ2tP8zj1xsGYUf1ZgqE=
X-Received: by 2002:a92:2004:: with SMTP id j4mr6797576ile.53.1622867661688;
 Fri, 04 Jun 2021 21:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <pull.966.v2.git.1622808751.gitgitgadget@gmail.com> <CAP8UFD0PPU4O+L3p0qJhKpsiB=MvyGJbbtxP6Vu0YeeVQ-Ojmg@mail.gmail.com>
In-Reply-To: <CAP8UFD0PPU4O+L3p0qJhKpsiB=MvyGJbbtxP6Vu0YeeVQ-Ojmg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 5 Jun 2021 12:34:10 +0800
Message-ID: <CAOLTT8SEXfNcpzKaGzvMXxJ1NS_dw-S--K5a_jQ=d3be5CgpXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] [GSOC] ref-filter: add %(raw) atom
To:     Christian Couder <christian.couder@gmail.com>
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

Hi, Christian,

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:53=E5=86=99=E9=81=93=EF=
=BC=9A
>
> No need to resend as it's a cover letter, but just in case there is
> another round and you copy things from this cover letter:
>

Sorry, what is the bad place in this cover letter I write? This
cover letter is also different from the last time ...

> On Fri, Jun 4, 2021 at 2:12 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > In order to make git cat-file --batch use ref-filter logic, %(raw) atom=
 is
> > adding to ref-filter.
>
> s/adding/added/
>
> > Change from last version:
> >
> >  1. Change --<lang> and --format=3D%(raw) checkpoint to verify_ref_form=
at(),
> >     which make it more scalable.
>
> s/make/makes/
>
> >  2. Change grab_sub_body_contents() use struct expand_data *data instre=
ad of
>
> s/use/to use/
> s/instread/instead/
>
> >     using obj,buf,buf_size to pass object info which can reduce the del=
ivery
> >     of function parameters.

Thanks for these grammatical corrections.
--
ZheNing Hu
