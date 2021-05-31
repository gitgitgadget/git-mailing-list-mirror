Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137FAC47083
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AFA610E7
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEaRU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhEaRTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:19:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4AC0431E0
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:32:36 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b5so10293624ilc.12
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BhLCBhxBzB49X39d5qQ6rJltrDl0j+V6mGLrcMH1FiM=;
        b=rXkG+f88h7yLfojQBs/YOiNMO9xo9oCHgMEohl/o/7xJOCg6Vpnl5HvpyLf4BhVG0M
         wKf5g69Y2HMA76YVqgnO4R06979vcTPIAzLkyP5Bupa7KQU1thRJmf3qR7NWuYJ4YFXK
         yheEQ3cSc5HOxgNq2+Nu40Mfh+1W/aB6fyuA6N4DXpxiJvOkgTwcUV/IoX1Odwj+4/v5
         KTHovOr6qlliKrQNRJAzcuh+IBHyYNmeWPPyMhLgVDrmzuT5CFLdBm9Y53IUE2fP1Avy
         SOrJuxA9xO4DCY4YcXmKEmhFC0wHvDo95VnB+JnqUrhvQ83P3cEta/k7ewAc/Wj9qCcb
         ZI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BhLCBhxBzB49X39d5qQ6rJltrDl0j+V6mGLrcMH1FiM=;
        b=jYIPOHCrS1VMZrJpMQmC1c4oxpaW1NUN7mMhZx5Kbe4VISvYusKpFPo4dqAXdD7CuL
         fwdba7NtXU0o8PgFLMBagbcf8+vayl/gNrg4iViiWKpkSqvdQhMaua6fn+F8jRZA6CJr
         0CG+c34QnX49sOwjTWmfIKZbMwPW0ZsO5YrLrgJQxRA84of5sVVpBbfJgywp97ckvW9z
         rvtm2Iq6Zs+6QiE/X+xEyzge9ZsklgBob1EP2eglPPY2LLOy8KZRyvZabgdYRG1cuNcp
         Hnz9s0AKiZe2fvvGfeImudvxip9GsfeFs9hmS5/povkgTAtMqg+cQLOExtvfXaa3J3E2
         IRZA==
X-Gm-Message-State: AOAM533fbbJFk4fs/d/S/xfg+547zkeAx1bsz4+2ohrGZss8qspSCZ6n
        wEatmVOlKfV2ZZ+bSbvo7zq1zWxA3Fmi1jzQ6DhV1R0mE6AsCw==
X-Google-Smtp-Source: ABdhPJyb5uihzC1R4eLin3cFQ+9QlnxoB70PDdDwykx/mPo+tnQVUSm0Id2Jj4s8Rv7NPaOlfPVrwHIkXC5LCLb7ggI=
X-Received: by 2002:a92:b0b:: with SMTP id b11mr12728430ilf.301.1622475155909;
 Mon, 31 May 2021 08:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
 <YLP/GEN0qIXvWEUn@coredump.intra.peff.net> <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
 <YLT2UfCZyQIXWIOv@coredump.intra.peff.net>
In-Reply-To: <YLT2UfCZyQIXWIOv@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 31 May 2021 23:32:24 +0800
Message-ID: <CAOLTT8T8aJ8X4TFV51JVB-ZAH-5E_E+bAmSMs2UtJ0k3OCON_w@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
To:     Jeff King <peff@peff.net>
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

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B45=E6=9C=8831=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:44=E5=86=99=E9=81=93=EF=BC=9A
>
> > > > +test_expect_success 'cat-file --batch=3D"batman" with --batch-all-=
objects will work' '
> > > > +     git -C all-two cat-file --batch-all-objects --batch=3D"%(obje=
ctname)" | wc -l >expect &&
> > > > +     git -C all-two cat-file --batch-all-objects --batch=3D"batman=
" | wc -l >actual &&
> > > > +     test_cmp expect actual
> > > > +'
> > >
> > > Is it worth testing both of these? The %(objectname) one will fail in
> > > the same way (because we do not need to run oid_object_info() to get =
the
> > > oid, which we already have). I'm OK doing both for better coverage, b=
ut
> > > it may be worth mentioning either in a comment or in the commit messa=
ge
> > > that we expect both to fail, and why.
> >
> > Yes, these damages need to be pointed out in the commit message.
>
> I think what confused me here is that you are using "%(objectname)" as
> the "expect" output, but it also exhibits the bug. So I'd expect this
> test to pass even before your patch (though I didn't try it).
>

Yes, %(objectname) should not be used as the output of "expect",
it is also a broken part.

> Really, the symptom of the bug is that _neither_ of those cat-file
> invocations will exit with a success code. But because they're on the
> left-hand side of a pipe, we wouldn't even notice.
>
> The simplest test is just:
>
>   git -C all-two cat-file --batch-all-objects --batch=3D"%(objectname)" >=
/dev/null
>

Yes, this is enough. I even think about use something like
"!test_must_fail xxx" before... that is not necessary.

> which will currently fail. It would be nice to verify that its output is
> sensible, but I'm not sure how to easily do that (it will spew a bunch
> of binary tree data, and it cannot even be parsed reliably since we
> haven't output the sizes).
>
> -Peff

Thanks!
--
ZheNing Hu
