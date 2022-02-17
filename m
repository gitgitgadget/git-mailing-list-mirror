Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB9FC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 15:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiBQPSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:18:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiBQPSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 10:18:35 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4422C1598E5
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 07:18:21 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qk11so8123921ejb.2
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 07:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5pLtHUVYnGmc7s8Amd2eTHNr/MtvuEfjZdOuAq0ZF8=;
        b=iTeBP7mrU0h6mKe1do0bhrhHy4p2eu2PFifInix/IAdw55nAcf1xMTxqC0imuodIM2
         wm3mn9T/vR8DIOHHHoUJMow+NfNfoPLMhNmHNHBhd7A9Y1Gq8o3D7S+mv1K393QeWC4y
         ZznZvFEu+O5B7LyCJGw5QL+V7DSkvoQfNzEke8TNam7/XRCCrUxCnmqCwUV/8Dl95cpl
         xVWSZFW4OA3ZtSTiNE1TNDII1fPs9wFk55WHH7+WeWIshsxhKULl2zULuHuR65bJpZWk
         K1UYs7L940QLiuC2CG3oKyJcNXGmSc2nX7x1xEt3QvqiIlI6wZ4HHCdrqn4No4jh1ObN
         K2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5pLtHUVYnGmc7s8Amd2eTHNr/MtvuEfjZdOuAq0ZF8=;
        b=dj4xENiQJV92UpjTCiRz+e6EIgngghLroTFK4GO3VjiKnNlI2tc0Y0BNs0D3Rv+Q+v
         NpSuPHEUDJ+YVYNn2JHmT0uEEm3TrCGaUECAqfQmyXPw1goYegL5JR30ZEa3DfBVqv9N
         ZwB+WbBS79INd+NVGb4ZdbUwU1ABc8TTPIzsmk61hhRd/Qp2iNgOBlrFKKUsR/0WEmZt
         F0Hp2MDwGN2BybMLBAjBbpEduyJVnfo9QUUCm11df5NySWhrueZqVLftBvTNIzqJAez3
         mhjKq1zBfJr3W2draRs8jVWlfnJ0aPo2ZiYmq9XitGCGTgKz1UBci0cH7iS5DtXZatTg
         VPvA==
X-Gm-Message-State: AOAM530E1D8Jzyhb3QLcwCvDsp+BbkSzNJ3Opn2KZWfPBC0Jd21zK2iV
        zqiQtjld1d+A2fWeYbgonGncHgRGlbcj2BAEuaM=
X-Google-Smtp-Source: ABdhPJwqoG5Gpj1W8SzC64tVZeMUdUKj7oR73WAL4sZm/LPrjb1Ae3SCXSpIEpgBbfgpBrzeYwEjLtD2UAZ0/lsdBJo=
X-Received: by 2002:a17:907:366:b0:6ba:fff6:4fc7 with SMTP id
 rs6-20020a170907036600b006bafff64fc7mr2687281ejb.756.1645111099727; Thu, 17
 Feb 2022 07:18:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645102965.git.ps@pks.im> <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
In-Reply-To: <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 17 Feb 2022 16:18:07 +0100
Message-ID: <CAP8UFD2kr6WJvv7eoDvytx5Q982XBXTpSTUQw5hXmRrDm-UuBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] fetch: increase test coverage of fetches
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 2:04 PM Patrick Steinhardt <ps@pks.im> wrote:

> +test_expect_success 'atomic fetch with failing backfill' '
> +       git init clone3 &&
> +
> +       # We want to test whether a failure when backfilling tags correctly
> +       # aborts the complete transaction when `--atomic` is passed: we should
> +       # neither create the branch nor should we create the tag when either
> +       # one of both fails to update correctly.
> +       #
> +       # To trigger failure we simply abort when backfilling a tag.
> +       write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
> +               while read oldrev newrev reference
> +               do
> +                       if test "$reference" = refs/tags/tag1
> +                       then
> +                               exit 1
> +                       fi

Maybe the following could save a few lines:

                       test "$reference" = refs/tags/tag1 && exit 1

It would make the code look a bit different than in another hook
script written below though, so not a big deal.

> +               done
> +       EOF

Overall it looks good, and I like the improved commit message!
