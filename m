Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E9FC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 23:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbhLJXbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 18:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhLJXbl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 18:31:41 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81247C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 15:28:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y13so34113606edd.13
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 15:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Shwag4saauSJV7B1/2lZQRrmZu+Q4xZg6Tu8yoXUTIM=;
        b=JiHl1wSBrMGvdsKilKNuoJd92wD7m8SR/DlYl18MVncjVE5BLubIlB6OD9ZAdeuMF8
         ucwEceEkJZywVk7UIUpuGc1vMSk+oFJ2/Hdxy2kj6GAu8x7LvoHkPicjMI4M4kgTsvFN
         MwBJ8cmFCAoq/yhU+G1SCdKHt0A6LUPw+6Q78iLFxGfg5CI9qRb1Q+/f0V8UNzON8jX0
         E1yriGSqEu4QO65pCeThQhO3MalD29mAF+2bM7qxiRJbzhqtATmqj5FJWbH9iNlTemfV
         SQwmTr/zNcgHFOU20IZD7mpBmSy7bSW7j6FKkTTJFUKw5eTgiJTgdiZOnzlEJRzwFygS
         AyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Shwag4saauSJV7B1/2lZQRrmZu+Q4xZg6Tu8yoXUTIM=;
        b=zkMQbYz45ea6gl1QI06XUPp/VAhddJjHgN69D4ZdmV2LAXVHg926GVmuab3HlEBzfJ
         8pelIaqc6HCh5tGsF9rkD3mWX/vJrvPRzus5vhqu7qcaRsDutUIiCMvBr/SQ+r8Nk1KN
         TCK8XjFIsb5a+9Skl6tU/8q4ncUIApXrfqOIpkrswro/Fgc4KkWsNLjkisPKdRdiSjYQ
         H/N205mE2H930uJ2PSK1Wyfd3bXJrWv1M4Qfp9zSNJFOEEgnkNragSbm9RYJUgWy0x8G
         itORsZHex2wEcKekm4Z9H16EPPeRKZujoSYe57C4ekeo8nACdPSF0SLbvtUPlBitAqay
         K4fQ==
X-Gm-Message-State: AOAM531PWI6/sI7GA7IgU5MwyPj05SI38BKbLfBnH3iJBNRDepmI91/t
        npZPMhu/dVvHdNvnheZ6rHnO5kwIqSLXDU8WlTo=
X-Google-Smtp-Source: ABdhPJxHHVXm0+DhMutrPRKUia2ySBo2Ia9P84IrciiXqzU5ou2W/Oy2rZTKs+iGDAGtaQcvdY0JwojjwCWOOeJ+plM=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr28740963ejc.74.1639178884030;
 Fri, 10 Dec 2021 15:28:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com> <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g> <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
 <211209.86fsr2l8vn.gmgdl@evledraar.gmail.com> <xmqq4k7htzpk.fsf@gitster.g>
In-Reply-To: <xmqq4k7htzpk.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Dec 2021 15:27:52 -0800
Message-ID: <CABPp-BHbOwXcV-FqNLpCVhLPpw3yWLV0J1MQEB++D_SHb9j7Bw@mail.gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 9, 2021 at 10:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> >> So, how about doing it this way?  This is based on 'master' and does
> >> not cover contrib/scalar, but if we want to go this route, it should
> >> be trivial to do it on top of a merge of ab/ci-updates and js/scalar
> >> into 'master'.  Good idea?  Terrible idea?  Not good enough?
> >
> > With the caveat that I think the greater direction here makes no sense,
> > i.e. scalar didn't need its own build system etc. in the first place, s=
o
> > having hack-upon-hack to fix various integration issues is clearly wors=
e
> > than just having it behave like everything else....
>
> We decided to start Scalar in contrib/, as it hasn't been proven
> that Scalar is in a good enough shape to deserve to be in this tree,
> and we are giving it a chance by adding it to contrib/ first, hoping
> that it may graduate to the more official status someday [*].

Is that the hope?  I thought the wish was for it to eventually
"disappear" rather than "graduate", as per the following bits of
Dscho's cover letter:

"""
The Scalar project was designed to be a self-destructing vehicle...For
example, partial clone, sparse-checkout, and scheduled background
maintenance have already been upstreamed and removed from Scalar
proper...[Adding Scalar to contrib will] make it substantially easier
to experiment with moving functionality from Scalar into core Git.
"""
