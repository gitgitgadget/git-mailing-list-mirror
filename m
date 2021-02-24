Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A71C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA1F64E6C
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhBXUjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbhBXUjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 15:39:09 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC7C061788
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 12:38:28 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f1so5117667lfu.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 12:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RG2/AbEW4x+0paH2PxIiEjhrJv1/9fpLg6nvxLfx+Gc=;
        b=jeswGzaSYxqnIK+zWqLFQaBJG17fC9Vbx0BGpqN3loAI0JmzbkryRmQUIh8qnuqXA4
         mGCKT5dIGhRYfE9YInr3b0bshTawxSBNeqvhvKUbNiGt1DGreUdpFj9bMhfT5Z/9ruv5
         kEKXrSZcNuMZmPmTu9Ds+2MhYfDji5+acF5gpv/i+QhX10Sbcxo59zAOVZWEiTAOP60D
         14hqPscBIum82zqEJ16LEkZbogH/wNkCTHOAqWe2Eamr1oPp5xr41uzURaZvvXwZmIzz
         uVCO1UBMcNmbK21JsFg4jzw9aVXyng87C2UbzreR8YuaddhxdoxCGT1gq8G8q1QhmQm4
         PDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RG2/AbEW4x+0paH2PxIiEjhrJv1/9fpLg6nvxLfx+Gc=;
        b=UsOMw8CfIyStlorolc4fN3ydXfr+TpPLQtctv+xjYe2n2G7k1efwnsK0VrrvfZk83G
         y+sZOLAphdxH9QSQ/wur2p3+FqxkNpJM3Wi+hrUFX916RH3+5lGwMIENsuGkj/z/Izia
         Xoebs6wxBXWlb74lm/hVH0RkjAXjaZ1BKL3XXJV0DVhz+jHgtzAPtQYOE//UFfYPJJWm
         73ll9VQNn8eRh6afoaSmWubaCxkg3D1te6KQWIUc4FstHckyg/QJU8FfznYcw5b64j0N
         XNw2BVvYHJ9kE36WQwcPJxgKcyy/BxSdXdCX0xIdS/O2kzoKU45EbeUI5RLYmrr4pTIN
         BQNg==
X-Gm-Message-State: AOAM530DaZoKNdn88bzgLMQStHHQauMsoqKJ8VIyAdsBBw/Ej8Ryoug9
        8tHvB4AeOWh+ojPJmzCBp+EopP1JIAfJPUxx918=
X-Google-Smtp-Source: ABdhPJyKbZW8U3RK05J7juKSVT9gp3o+50BHNoNSD04ZIAHAswL/r2ut0xvNt9sUrgGplHyt5ETdBQxfbEb6fW4M5MI=
X-Received: by 2002:a19:6a10:: with SMTP id u16mr19019379lfu.221.1614199107402;
 Wed, 24 Feb 2021 12:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20210223071840.44267-1-alexhenrie24@gmail.com>
 <CAN0heSqmAgt_hg0-kQpTK2LcuYPV9T9=1bowbuZ7Qah1q0EAtA@mail.gmail.com> <xmqqo8g9z1p2.fsf@gitster.g>
In-Reply-To: <xmqqo8g9z1p2.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 24 Feb 2021 13:38:15 -0700
Message-ID: <CAMMLpeT2uocoWQMoNYoVWa2-scSohwbvz-CFN3zupD7jEBEFew@mail.gmail.com>
Subject: Re: [PATCH v3] rebase: add a config option for --no-fork-point
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 12:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > On Tue, 23 Feb 2021 at 08:24, Alex Henrie <alexhenrie24@gmail.com> wrot=
e:
> >> +rebase.forkPoint:
> >> +       If set to false set `--no-fork-point` option by default.
> >
> > This should be a double-colon at end of the line, not just a single
> > colon, in order to make it a "description list separator". When it's
> > just ":", it ends up being rendered literally, which isn't horrible, to
> > be sure, but which doesn't match this item's neighbours.
> >
> > Martin
>
> Thanks for your sharp eyes; will amend locally before merging it to
> 'next'.

Agreed, thank you!

-Alex
