Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F53C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 11:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D963239CF
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 11:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmaUwXTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgIXLIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 07:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgIXLIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 07:08:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E8C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 04:08:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i26so3834721ejb.12
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 04:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrdbXE7I3HpXCG2bmA2wzmUrDcVDg90WPQFx0JYq++4=;
        b=pmaUwXTyCwIjsmPa7EkydzYmOIwA+U+X3Zkq/jnKuYebMHnx5PkeQ1RTQQP1c4JBJO
         JtZbKNp1FiEWEUE7tD4XQgq6fl5tiYZic19Qb/hFx6EfmruZd0Kq9IGUArRBn+Gk18tv
         0cp1gAbIfjDh0VOSiB8QJybp3rDrLYFe4VFbmgEGuWtfSfV1SI4HToAOLZJQlFZAEwRl
         pAk/fF9QJSmVj/DtEM0x72Ro3p4hwy7PF45rdYUvGC86a1jhgUNhKZ8xVSVoHqEm8Ybz
         p+4UffMQl8bnejNh/4oRewwog8GWghh5rIi2UOEm9Qj04EfBcAUF4t5JrOz+QHulIsXT
         RRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrdbXE7I3HpXCG2bmA2wzmUrDcVDg90WPQFx0JYq++4=;
        b=s894SMRCvtUZ/ZE4RxoVjSIuZQ6IJQqagGMSDM0+y6NxJncuJU9CiEKhBMBCcTf+xO
         If+Kw3xEBw3X796xBnCbxid2oeHLiCQ6bMREdI5zLMRIEoC6CzuH4/xO3zlgXMebE6c0
         p1SOk+AeRnCjA7jyCxD8bigSsdZxR4KyiwOCNKQfJ2B4uYEgTopXyoO7VcD34WnFsMMw
         kUfI+zg8NERTEVprj1kud9cw4g9YPCr8Krwnaf6hCKM35Rme+84/aY4czTK95Hix1X+y
         7PtKngm3iDoYDSZ/wiLitZxLcR/YIDTyT8otZOKUJJEhDGInyDDbrxiDUOGG4y8IXvRT
         lkAQ==
X-Gm-Message-State: AOAM530vwrniBTbgtedeVFiFre4RSPOVyBdBLsR6TCiOyimI1C86pKHw
        f6qzbpmt8zzwEsRYvN4c+KV7DJDnhRmKU7uj9iNe3VYhyCGrqN6k
X-Google-Smtp-Source: ABdhPJysuAp5JG+JdcNYLtoqkdQqWBay+soFHQfYhhnWC0SP0fy45PtP0z9nu2DTQ2DcfF0UnE2EYrlY9b/3cXISBXQ=
X-Received: by 2002:a17:906:68d2:: with SMTP id y18mr400613ejr.197.1600945692377;
 Thu, 24 Sep 2020 04:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
 <20200924060344.15541-1-chriscool@tuxfamily.org> <nycvar.QRO.7.76.6.2009240947080.5061@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009240947080.5061@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Sep 2020 13:08:01 +0200
Message-ID: <CAP8UFD3HtiAj2yiHBZOeqm-=VxVeV7mpwvFRV_mV8y-vsxgQUQ@mail.gmail.com>
Subject: Re: [PATCH v2] bisect: don't use invalid oid as rev when starting
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Sep 24, 2020 at 11:59 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Thu, 24 Sep 2020, Christian Couder wrote:

> > -                       rev=$(git rev-parse -q --verify "$arg^{commit}") || {
> > -                               test $has_double_dash -eq 1 &&
> > -                               die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
> > -                               break
> > -                       }
> > -                       revs="$revs $rev"
>
> These are awfully long lines. The reason is that you kept the indentation
> of the diff. But that's actually not necessary, because we do not need to
> apply a diff here; This code snippet is intended purely for human
> consumption.
>
> What I suggested in my adaptation of your patch was to lose the diff
> markers and to decrease the insane amount of indentation to just one (and
> two) horizontal tabs.

Yeah, I didn't realize that.

When I am sent some code or patch like this, I often hesitate between:

- using it verbatim, which can create issues as it makes me more
likely to overlook something in the case the sender didn't fully check
everything
- looking at the differences with the existing code/patch and applying
them one by one, which has the risk of missing or forgetting a
difference

I guess the best would be to do both and then check the differences
between the 2 results, but it feels like twice the amount of work for
this step.

> > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> > index b886529e59..70c39a9459 100755
> > --- a/t/t6030-bisect-porcelain.sh
> > +++ b/t/t6030-bisect-porcelain.sh
> > @@ -82,6 +82,13 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
> >       git bisect bad $HASH4
> >  '
> >
> > +test_expect_success 'bisect start without -- uses unknown arg as path restriction' '
>
> To avoid the overly long line (and also to re-use existing naming
> conventions), I replaced "path restrictions" by "pathspecs" here. What do
> you think?

It's not a huge issue, but I tend to prefer using "restrictions"
because the tests that check that these arguments are used properly
are called "restricting bisection on one dir" and "restricting
bisection on one dir and a file". So I feel that it keeps test names
more coherent.

Best,
Christian.
