Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11916C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA84864FB1
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhCJRzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 12:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhCJRyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 12:54:49 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E1C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 09:54:49 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id r24so9119321otp.12
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FuwWk6hSb7zzkmkuQa82398T2vKFih12er0K9NfnOdQ=;
        b=Kd02UGBWLz2vnMNbP8DrHsJzlZIDNQczwRtwz1rLkRjXJf8v2f3JqSbbs148/421xD
         JmNvVoKPZyb2TVNGUGU0XP3t3jN8NsO3MFHr5NEnwd3QrHPquSzDgHDjZORkJea99bqX
         q6EX5K37KvvG+7LNuVB1gXS4qsXr0Fr5IAt3pw4EYpJ7QXxcBhOHwv/lUQBuYHz7NqLu
         uzkbh3OL0U5w3ZqhCQ10iHgdc4lowufFGL3iAGtJPgqSyyQ5P2TSaVYlf8FLCZ6qJVlZ
         dfDG6JBizOdLYCMmhEfdSeRfD72mr5FGOdAHz+baAX7pEptbL0HFQxFSYk/48QCn3/xN
         SpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FuwWk6hSb7zzkmkuQa82398T2vKFih12er0K9NfnOdQ=;
        b=bkzMahwX+jLMHUXnxb8krARtkWhPKoIsqmitLWuG8ygSpPelr8cr88ip2lqAiAGcjM
         8qRRLp7FqFo28Qf+P+LN/A7CzHHqXu77Gzer8If+aYJZ6vIakMpSzEyYLAixC/2cw5Oe
         lfguHXEI839ui9aHaGakiMv5+PxS86QWlKsSzPYKgGdcEmWv3DfXelZDUCGPiDXKZkMY
         8PrSzKM1aK1CEpakTDF8FBHkxOp17soxMeNZNAFyM2pmPC6RjWZJo+0Ilio75vNNcvfL
         1EMY/7ceIjhzkthecAKy6+KIe7vZcxcBvTawAtN4LgD3ZM/T9paPd6XLLeB3aMagoqP5
         6IOg==
X-Gm-Message-State: AOAM533PPKPOypgU4NzoFRJ4JcXQ3xv9RbRLu9+EQbJaUcTX1ss9TFVE
        lswExIjPX3++PqJz+nXsylIKSe+ai8uvGJmEBKg=
X-Google-Smtp-Source: ABdhPJy4zXwMcqihaIuyGbhvpphMGSWGDiOS+FVAFnV2WwyYD5fAk4mI8UPv3aHIYyHF3F3SHJ61xBcJt09/mRWpW84=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr3400042otf.316.1615398888488;
 Wed, 10 Mar 2021 09:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net> <8735x3i59m.fsf@evledraar.gmail.com>
 <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
In-Reply-To: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Mar 2021 09:54:37 -0800
Message-ID: <CABPp-BH9epFANH15Om4095PHZTkNSAgV9o2cr5OD0vc0yWGMVg@mail.gmail.com>
Subject: Re: [PATCH 0/3] sha256 fixes for filter-branch
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 9:06 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Mar 10, 2021 at 01:04:37PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
> > I found a missing spot that wasn't trivial to fix, so sending an E-Mail=
:
> >
> > In git-filter-branch.sh we have:
> >
> > _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
> > _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> >
> > Then later we have a case condition based on matching a SHA-1:
> >
> >         $_x40)
> >                 echo "Ref '$ref' was rewritten"
> >                 if ! git update-ref -m "filter-branch: rewrite" \
> >
> > Just deleting that case arm has filter-branch tests passing, so whateve=
r
> > it's meant to do it has zero coverage, which explains why it hasn't
> > broken with our tests.
>
> It actually does get covered. Dropping that case-arm means we'll fall
> through to the one below, which does _roughly_ the same thing with a
> bunch of extra warnings. But none of the tests actually check the error
> messages, so they don't notice.
>
> Here's a series which fixes it, plus extra tests to notice the
> distinction.
>
>   [1/3]: t7003: test ref rewriting explicitly
>   [2/3]: filter-branch: drop multiple-ancestor warning
>   [3/3]: filter-branch: drop $_x40 glob
>
>  git-filter-branch.sh     | 16 ++--------------
>  t/t7003-filter-branch.sh | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 14 deletions(-)
>
> -Peff

=C3=86var successfully nerd sniped you.

...and sucked me in too, since I went through and read your patches.
:-)  They look good to me.
