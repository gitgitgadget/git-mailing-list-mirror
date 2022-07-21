Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFAC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 02:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiGUCDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 22:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiGUCDg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 22:03:36 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED776EAD
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 19:03:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id y18so163155qvo.11
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 19:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWpQFTmYe8TOKl9ERMNbA0Vw+rLQL965Rq1xiqsVgNw=;
        b=caVMd5UtSmtSYrOjbG8SfsYUsvr5wJ8xaP2cwgUQi/E5B/zhynI8J7rh2RGckC3FhP
         OAfW1aVHD8HcL1OeEyn0sWgxT0THl2g+E1dSa5a/NZjzI2zMjK6gvjdxhNCSnBBw6qat
         tThcBe3ttbiN+BxXaxlJqSFfhI92bIXeDkVCXInc+K9SGhneYEYPChDjASupHdC+mO39
         drm5F3LF3F7X7D0R4zkdJWRlJob90nbqmExO8cx+6pzI5+UzJgKzwaraRL+iv8mEO9Yo
         oAW0Rc1vcYTUouEZokXIMcc9rVhHXGNQ1G9lC6rhHQlEvjc29xd2yaZhq0GO5cxyWZH+
         1kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWpQFTmYe8TOKl9ERMNbA0Vw+rLQL965Rq1xiqsVgNw=;
        b=Ou9nWikiQ6Bw+HpHI4LDn0XwofR3Q7Gcf8wohmj2iWL7hzf66fpCjPjZdzuFj9ANjT
         1MaboRvnYoYfd4JJgKU+3sSX3DIKXECx6R/0/syMeODTAtU7MqOBef055ehKMaNjlu2M
         K9lKmjzGb4N860J5dthNNLTy5p2CxEg2oTXr938xzXI2FuTx7KU0wG3isx0WpD2X4tDD
         ecU/N0z7NSgooWfPIb24KDV8W3DaN37n2AsfYcmmqVlCxYt0FlqjpLo7g+zYAdvwzUfF
         00WpHBIyyd7Sb5qbhw7rYs5rw19CLJL4gwhciRq+vp8bDMxY8r2F69LtZZHw7xnCtM3D
         piOg==
X-Gm-Message-State: AJIora+JIGoqGRk3ijaGv4kcTZcpkWY3q5u7Pz9x00v1VFmNaoi2eXA4
        K2UcejBBrXT5eJgVJJL4VPuXu0e/qyeMhokjKSq2DnVXvCI=
X-Google-Smtp-Source: AGRyM1t8fuHUHvJulDZXt3PgkMTdGYZWOR1XmkmyFZD0838L3x7QaYjijL9Bqw8UrkO/9EUbo9EHv83wtkMiCXM8YF4=
X-Received: by 2002:a05:6214:21ec:b0:473:951b:5203 with SMTP id
 p12-20020a05621421ec00b00473951b5203mr30658865qvj.65.1658369014906; Wed, 20
 Jul 2022 19:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <0783b48c121fe74051c13e7d9118d1a5b7cb9aa9.1655621424.git.gitgitgadget@gmail.com>
 <xmqqzgh466ia.fsf@gitster.g> <CAPig+cTqN6nVRGhm-bG6F2RGACAKi7RYa4yp_qqsp7F5pWVaBA@mail.gmail.com>
In-Reply-To: <CAPig+cTqN6nVRGhm-bG6F2RGACAKi7RYa4yp_qqsp7F5pWVaBA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jul 2022 19:03:24 -0700
Message-ID: <CABPp-BHTJR5dUGKqKoH8TUGPZYvQn27E978HkMqPSzcctKmA7w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] merge: do not exit restore_state() prematurely
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2022 at 5:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> [replying to Junio's email since I don't have the original available...]
>
> On Tue, Jul 19, 2022 at 7:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > +     for b in branch1 branch2 branch3
> > > +     do
> > > +             git checkout -b $b main &&
> > > +             test_commit --no-tag "Change on $b" base $b
> > > +     done &&
>
> Let's break out of the loop with `|| return 1` if something in the
> loop body fails.
>
>     for b in branch1 branch2 branch3
>     do
>         git checkout -b $b main &&
>         test_commit --no-tag "Change on $b" base $b || return 1
>     done &&

Okay, will do.
