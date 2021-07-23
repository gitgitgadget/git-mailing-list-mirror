Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666C3C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A585608FE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 14:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhGWNaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbhGWNaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 09:30:07 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F168C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 07:10:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s5so1655645ild.8
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jKJfzm8YHbTTpJhWNO1L6gT4xlnu91XBgbxgGA+DdRA=;
        b=Qzc2GdKgAeroFl7kJpCw4eej6H4HZlaagikAkSFAmJ9ugV1B4TvJPL04RnB2dDEtKU
         WrDEt7TBMQ5x31paR/Q6uyrEPLjDoNKxouRuR2IsI+0lRG3C4xxxwTFRl+GDIDGgwSjA
         F3I4OP8eDfYV4+7nibVYGHYu3mkzOYttJrRNRYzNsg88XnqsBK0QaK7x9wPa7Viuy5VX
         a0ogLOVpy/lIfj6Z6rGQHCG/Z3UpV4Z9OXb71C2YMC78QDvIpkfhAU+VBDgyZdftLbpG
         JLBmD8QqEbQp1usuWKhcOe+zJjpDvmk5bKKmkEafOI89LQu0HfETWFYX2AaIu1dnc3pl
         xcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jKJfzm8YHbTTpJhWNO1L6gT4xlnu91XBgbxgGA+DdRA=;
        b=BHzUWUq67rCQq39yj0dNMOWoQsv/npCPfZ4YVXeyzb9haqaWKT00suS/DY09gBgnzC
         OqxQmyqtR6D7ZHSfyge3f4IzABL6fEGX06oCnwXaXI1kRcYEJe56vUz3TqgQK/62zY5V
         Gn+TEOdwqPBO3YteYCdIQgu6xNtjq/O7SHRGAD7YjF6/PKng8Pu/Sn90r6+PPLlIfhuc
         92/cLibyiIgi/uxm2z1pPCo0QiFd5nhp5H0MfuM4qQ8DD/Dia+qwnCYNgCVjVii+MWXu
         gD3VrmDsPGvvx3+pM9gpbI12wmwRpu3uJ9OQjwb+Svte+Kyy0Mig1Y0UR7RbAY5OK21D
         wgmw==
X-Gm-Message-State: AOAM532DMmde4UxD883bX1QQDGnkrAfcMSWp4Yrp1ofOVNN0ZYS7qlJz
        MpO0ETIHyBo+Ub/oesdVviSzQImKKqxkjCLdzDw=
X-Google-Smtp-Source: ABdhPJzp7iCbv2Ydz03Z5U+1E4eWZqxPlkIh9c6k2bRFY8B/ACtZeJtxFbR5VKf103gf0AJjry2VOwwpXDuw59tM1kI=
X-Received: by 2002:a92:dd02:: with SMTP id n2mr3452476ilm.259.1627049439694;
 Fri, 23 Jul 2021 07:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
 <75eb2f6740eb5845afcb7d31956cc5b3e3957f97.1626939557.git.gitgitgadget@gmail.com>
 <CA+P7+xr7GCZCk44e_CSYFDr_ow3-BBMUfP5t6=cErFBES4N8+Q@mail.gmail.com>
In-Reply-To: <CA+P7+xr7GCZCk44e_CSYFDr_ow3-BBMUfP5t6=cErFBES4N8+Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 23 Jul 2021 22:11:06 +0800
Message-ID: <CAOLTT8Q1A8FBiWdEqF90_yQfT11uE3OwRy-2MGV9qm-4O4S1QQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] [GSOC] ref-filter: add %(rest) atom
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jul 22, 2021 at 12:40 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > In order to let "cat-file --batch=3D%(rest)" use the ref-filter
> > interface, add %(rest) atom for ref-filter. Introduce the
> > reject_atom() to reject the atom %(rest) for "git for-each-ref",
> > "git branch", "git tag" and "git verify-tag".
> >
>
> To a reader intimately familiar with cat-file, %(rest) might be
> obvious.. but it would help the commit message read more easily if
> there was a short explanation of what %(rest) did. It is not obvious
> just from the name to me.
>

You are right, I may subconsciously think that everyone knows the
%(rest) in cat-file.
I will change it.

> Thanks,
> Jake

Thanks.
--
ZheNing Hu
