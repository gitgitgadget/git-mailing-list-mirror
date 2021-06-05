Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A57C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 05:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E6461407
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 05:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFEFoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 01:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEFoY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 01:44:24 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4819C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 22:42:21 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id d1so7853647ils.5
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fFSLWN4kt3XCMcEdCO4IlOMuJvgCPl4ep2yfXiyTajQ=;
        b=RmTVQCTXAG0qyIG1g34DUrvjCOayrFr4YlHr+GDfy3Zgmh+pgJpFUpmtVe36Mix+xO
         /Y/FhopnBgwYXSXUEYwoVaf245wLOFfYJ/5p0mfyNmeTUhqt7a6u9n+o2yJmRH8g9MVf
         dOJE4FjILzhaQ3VBGdGFaGiWxFPCQPyFZcsA5d8hD4RJrCMoqRdse1PrmBjny0K8Z/IY
         Kyq+SRb15AlLRoT7ewJY1zhFKGkF4ZVwzZoUzIQQMzgx0/VUXod2I/PKcm+6A4yNiXBH
         58tI0kusbxRO/iTa4JQqrQBFEtMMfOHNDmFd1UuTv5yzf7KAb5RCbJxIPfGCPqke9icf
         km6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fFSLWN4kt3XCMcEdCO4IlOMuJvgCPl4ep2yfXiyTajQ=;
        b=Jeum8+MyBElbHEzJ+KKfN7ETgy3i2v3JLB7nLxvvGZogSRSHeJ8f+nSkMhEIj5kZx7
         Ig3V2U38hMvwZWZiR7RcvQILM87dEv8iaZ83XA41KYlBDKrN6ohkCj6zQBbLdbUbdeGw
         F6jnhhXxZidoq6UhJpTAi36yiE7DJIjEBYrtQr54jwsUynSP9ZXXCVyABrxnv9/sGOWV
         uMgnWQMoLBXLHHdCD54GJMSPsBi0CnF2VcbuQ3y7Uv9te/WhQ9nP2U45Ww8yHQB28qRO
         TfjrOyjlzk1kwbKwFtOpOr/ebjXWt9s4U+WqOeMPd4yNKHULP7lq2jQr1aQF56osJ7Z4
         bYuA==
X-Gm-Message-State: AOAM530n/Xc6aSD8AkVurpwyQxHWgnlxtouSJ5eXDn/xZ/mXQOH7+9pT
        /pjLVXdUFq/FzlzymVkmCX0/NFbGLKmtay8Zx2w=
X-Google-Smtp-Source: ABdhPJwZLMdAtBDL3x9dXmr31w7YE4RS3hXi9UvqcC0dSXyV84NgrEIi/LKusBfDYITdI3eWYp9sqV9maqVbvBhh8gI=
X-Received: by 2002:a92:b0b:: with SMTP id b11mr6823852ilf.301.1622871739497;
 Fri, 04 Jun 2021 22:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <pull.966.v2.git.1622808751.gitgitgadget@gmail.com> <CAP8UFD0PPU4O+L3p0qJhKpsiB=MvyGJbbtxP6Vu0YeeVQ-Ojmg@mail.gmail.com>
 <CAOLTT8SEXfNcpzKaGzvMXxJ1NS_dw-S--K5a_jQ=d3be5CgpXw@mail.gmail.com> <CAP8UFD3SxAh1ZW2TTMqn2e6=qP1YDd5qVd15yFR669+cPr481Q@mail.gmail.com>
In-Reply-To: <CAP8UFD3SxAh1ZW2TTMqn2e6=qP1YDd5qVd15yFR669+cPr481Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 5 Jun 2021 13:42:07 +0800
Message-ID: <CAOLTT8RP1myY32cOMMvU4Q2_XyKsL=+XERij7RYJYM3We0rP8w@mail.gmail.com>
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

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=885=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8812:49=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Sat, Jun 5, 2021 at 6:34 AM ZheNing Hu <adlternative@gmail.com> wrote:
> >
> > Hi, Christian,
> >
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=
=E6=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:53=E5=86=99=E9=81=
=93=EF=BC=9A
> > >
> > > No need to resend as it's a cover letter, but just in case there is
> > > another round and you copy things from this cover letter:
> > >
> >
> > Sorry, what is the bad place in this cover letter I write? This
> > cover letter is also different from the last time ...
>
> I was talking about the grammatical issues below in the cover letter.
> Sometimes people copy things, for example a text explaining what the
> patch series is about, from the cover letter of version N to the cover
> letter of version N + 1, so I thought that telling you about
> grammatical issues in this cover letter could perhaps help you if you
> have to write another cover letter for another version of this patch
> series.

Ok, I get it.

I want to mention another question:
If I have a new patch series about %(rest) is based on the current %(raw)
patch series, should I submit it immediately?

Thanks.
--
ZheNing Hu
