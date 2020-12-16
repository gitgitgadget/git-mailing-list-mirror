Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B4DC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 16:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F53233F7
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgLPQZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 11:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgLPQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 11:25:47 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F3C06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 08:25:07 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id q25so23482178otn.10
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nncJuRZOIJcpTTMfUf62YlAprHYuVLWu7/elnZwvr3M=;
        b=gqvSFUdkzdSKq2ipP3LFDOVC/PMprLH8DcbI3bX3GtTE2UD2RaK9xm9jY2vYaey+qN
         5YRSYXbwGgaAZ3SRo8HXvHUkMzjOamzr+myP57o1qdVvsDh+vVLNrCDoaeScFeEGL9Hj
         hmKaoPH4mEan0Ygf/NpzPESM5T8GiVs7SirBl51hBAfA65joQiFJ/mupQ/WM2/hCcNTF
         eA+ag8gDCF1+VRr2bXSyC2OMCIHy/w70Hi29tL99tjEdRH3fGVlgSqQHYH2BMqSs4LDt
         vHDxsGVGkzdUxoqADccAjEzHMaKNdShQW2tE7xa5Ge82Zc96zWEsjSyMbYgyofaes1qX
         iyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nncJuRZOIJcpTTMfUf62YlAprHYuVLWu7/elnZwvr3M=;
        b=aLStwGdVxgr2Rs97rMb/5m42401dfCGU+oegm7faLPb07jlrQ62bvubxDnJ//3ypqk
         C0at9XJqX5p2tC6hcpECWz5T70aIgBXfiqciyvDBa+Y+2kzX8iF4ukBLHY5Y8qV5IEL1
         YVzcQTqpfzIuiD78lf6yXtvNvnklvBqk/MHoAVHkcX8EG0xheAY7qsoxgdPx/JE8vHbQ
         6jWhGIV2CfDrVlsrVxWAr5l1YNx8D/UMKsjDhxAfa7Pn8cMnLm8QQNARulmpetl5OO4g
         Jk3pB0l24jUKy18EukMrhe1WqtefdSYDGJt2l5ag6PnsYgEg1ryHZ69M/oDMwf7u0EO1
         KzzA==
X-Gm-Message-State: AOAM532SdFS7eNzgO4kVBHebr7NdFbB3xX8N56PGfH84/6JzHqBZVY60
        ZmzoLYTu5eTw6iifUiMnQ4r1YGq7UB0SlMKZJLg=
X-Google-Smtp-Source: ABdhPJzVfhDqv1FLmJ4Vilx85vGnxX4MpkgdyC7bUOGjk8o0cXWoxt8cSig4FKqdfe5hqO6Xt3GFiCzkJWW4xes1UJw=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr26354163oth.316.1608135907055;
 Wed, 16 Dec 2020 08:25:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
 <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
 <xmqqh7om5z50.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012161710170.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2012161710170.56@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Dec 2020 08:24:55 -0800
Message-ID: <CABPp-BHf=G7xgVLLF+6hSazHB-=botZ3k2EHNXrZREeMhK787A@mail.gmail.com>
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from merge-recursive.c
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 8:12 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Tue, 15 Dec 2020, Junio C Hamano wrote:
>
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > In a subsequent commit, we will implement the traditional recursiveness
> > > that gave merge-recursive its name, namely merging non-unique
> > > merge-bases to come up with a single virtual merge base.  Copy a few
> > > helper functions from merge-recursive.c that we will use in the
> > > implementation.
> > >
> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > ...
> > > @@ -1462,5 +1492,7 @@ void merge_incore_recursive(struct merge_options *opt,
> > >                         struct commit *side2,
> > >                         struct merge_result *result)
> > >  {
> > > +   (void)reverse_commit_list;
> > > +   (void)make_virtual_commit;
> >
> > To keep these symbols referenced?  Cute ;-)
>
> I saw this technique used extensively in cURL. Note that we ourselves
> introduced the first such thing in 2fb330ca723 (packed_delete_refs():
> implement method, 2017-09-08).
>
> However, we seem to have the `MAYBE_UNUSED` macro specifically for such
> use cases (and use it in four instances as of time of writing). I wonder
> whether we want to settle one one strategy instead of keeping both?

Ooh, MAYBE_UNUSED, I like it.  Much more self-documenting.  I'm
sending another round to address Derrick's comment, so I'll include
this change while at it.
