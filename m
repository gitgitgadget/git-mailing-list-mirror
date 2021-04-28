Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4584EC433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 17:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EFA61168
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 17:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbhD1Ruh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 13:50:37 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:42817 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242951AbhD1RtW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 13:49:22 -0400
Received: by mail-ej1-f48.google.com with SMTP id ja3so20002558ejc.9
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 10:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLvXNJfqyjrz34eCpD0XRF7o8S756vFM5kpySF+AYAs=;
        b=CVsE84ht5tB88Pm1ND4VU2+iqP1H9X17zvZmip+MuSc4xxTPeFAjZyInCRLV66P74V
         aE6+VTKuTDomV5o9X6nfmj5E1eYQ7tQ68Ucph50zzfK+JMi8mhfouBr/WGOfl5+PvFMy
         ev8dYD1Y/YOY7+jjbm0wehaOQLReoYAfYvDDaolDLBab8EW15JiECahaA8guNJOfFpyP
         p/Tgx/fWr7m8Bybi033P4NjcmJH+Ra9tjWNgdRAvw5Kyf6LbMQI8+I9SyeZsZEm4BWe3
         kUaZqtGb9xXuqFXlurHcaG9haUPbBTly5TDLq74ANguO/UfRK7CjLyAVbRowVqqISfv5
         m57w==
X-Gm-Message-State: AOAM533Leg3jIDxPgHbbZ4CJBAcPsolm71OpVKpUv6TmctWwm5FpaDOn
        6BkFI+p/p8DdiqyF1/t8zuiY7s6SsOEh8kYsbtM=
X-Google-Smtp-Source: ABdhPJwZuRXwaBvw/tqyP4eGBMruqW7Fmut2pWnlYim/pudhcJbrZ4YA5BiID9I+PXmum1Ac2RA2OCh9tEzR3sGZSNU=
X-Received: by 2002:a17:906:3613:: with SMTP id q19mr13695369ejb.231.1619632116211;
 Wed, 28 Apr 2021 10:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080508.154159-1-bagasdotme@gmail.com> <CAP8UFD0k9fwwW94BKtMPLmA=Qx1ce3Qh3UfF0KiC5+AOj-=MiA@mail.gmail.com>
 <CAPig+cS0yA3TP9PBi2ZtQx5UeKRbFgwXqeqB1sC6QPB7q+Lu2Q@mail.gmail.com> <CAP8UFD10vLX_rF=P374BP-CeE5cxs1Rg6faxqf+m3J4MH9Vb8A@mail.gmail.com>
In-Reply-To: <CAP8UFD10vLX_rF=P374BP-CeE5cxs1Rg6faxqf+m3J4MH9Vb8A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Apr 2021 13:48:25 -0400
Message-ID: <CAPig+cSzLFZeOyJAnkXx6M5L+vUKofV+KF8w1MzH+iAzxYycPw@mail.gmail.com>
Subject: Re: [PATCH v2] t6030: add test for git bisect skip started with
 --term* arguments
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Trygve Aaberge <trygveaa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 1:17 PM Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Apr 28, 2021 at 6:32 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Wed, Apr 28, 2021 at 4:12 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > > On Sun, Apr 25, 2021 at 10:06 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > > > +       HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
> > > > +       HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
> > > > +       test $HASH_SKIPPED_FROM != $HASH_SKIPPED_TO
> > >
> > >        test "$HASH_SKIPPED_FROM" != "$HASH_SKIPPED_TO"
> >
> > Also, is there a reason for upcasing these variable names
> > (HASH_SKIPPED_FROM and HASH_SKIPPED_TO), thus making them appear to be
> > globals even though they are used only in this test? More appropriate
> > and less misleading names might be `skipped_from` and `skipped_to`.
>
> In this test script many variables are called HASH1, HASH2, ... or
> PARA_HASH1, PARA_HASH2, ... So in this regard HASH_SKIPPED_FROM and
> HASH_SKIPPED_TO look ok to me.

Many of the values of the existing uppercase variables -- such as
HASH1, HASH2 -- in this script are explicitly and intentionally shared
among tests, so they are necessarily global, thus the conventional
uppercase names make sense. However, the variables in this test are
local to it (and there is no indication that their values will ever be
shared with other tests, so using uppercase for the names is
misleading and confusing for readers[1].

[1]: It's true that some of the uppercase names in existing tests are
local to those tests, as well, so they ought not use uppercase names,
and therefore share the same problem of misleading and confusing
readers. It would be nice for the naming to be cleaned up, but that's
outside the scope of this patch. Admittedly, considering the existing
naming inconsistency, questioning the uppercase names in this new test
is a relatively minor point, but as a reader, they confuse me and make
me spend extra cycles wondering why they need to be global (even
though they are not, but their uppercase names mislead me into
thinking they are).
