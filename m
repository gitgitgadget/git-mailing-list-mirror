Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634BBC63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4542961283
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhGVH1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhGVH1z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 03:27:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78959C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:08:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l26so5683771eda.10
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uaR11Zxzp8at2bywoh7G4sl0eolzn9btsrM+ENeuhDo=;
        b=Ah4KXP+ib+tkr9qcx1wZMv1U49v0U313ihcL3sZ2TO13e/+CLl1VfBwh9PpBqqnsLR
         xC6wBXJi5QNsfPXxcsYZgDIs3ESW1gviIYI8YaRQpDxCn8nHz8uX1NnKz4PxpUr3P3Wn
         GUivfvuf2BB2Qrr22cU89lyo4HD9UW8nyf+vhbSUItW5PLNwlZFC2QvCZf9qomTA2AiV
         Iyi1nDmZxLgBiAZIcW+fO3v+Tev/e8Gap7xx5NYQpmzbR1Dp284hUqsZ2E0xvBkUAy+B
         lKJWrxtFIHC4Qs0HqBSIjR6+whqnRE0zxNfV4+SZhQKapVb2eqkaKq1f797RgDdx3tlh
         GtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uaR11Zxzp8at2bywoh7G4sl0eolzn9btsrM+ENeuhDo=;
        b=XGU8uWBfWLTfWBgT6LNzBmcTFmENFP7D4ffy2YQ/NabkX0LwfUAsgxmPgPfUkcD4if
         LDot60N9/QMUODUEVW/2bC/83ovqk3BBRfC0CcsJw/pNuQCP1XrZtMuhHkvk4U3nROYb
         Y4WV6gzBhFcMKSsUbmtYZqHCDOi5aUDrMForEbJ8NBZp+/TdYG2ggsFl1akA/Y0+Kz2v
         jzc4s4CrgbjKbKq8Kalp5jYYqAvbgjDmsuEQApyB4XqvdM/L84zwR+vc0PegDzKOKtGY
         8sBqPjp98QRRBifxlOKLvngihxHR2+owce/VIdeGJoxj1wPtYyqZrHZxJsA3KjSYePXV
         j+QQ==
X-Gm-Message-State: AOAM531yoa9N5XvrINbqlrWGqoKt5tCAQABm8A1SOyupTrwMM0RpfNuU
        2iuR9ER6x6PTYOYcgxCI19Iog0VxZy6aUCsRRvo=
X-Google-Smtp-Source: ABdhPJx3ll6q4V6SrLIThLHQ/w2Id2v3A8dBeILMzVk05LGUd6EAh6bQ2HC33N1fewL3nh7RPDY7i3vagFHZl84rHms=
X-Received: by 2002:a05:6402:6cf:: with SMTP id n15mr40805907edy.362.1626941307063;
 Thu, 22 Jul 2021 01:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 22 Jul 2021 10:08:15 +0200
Message-ID: <CAP8UFD3ENBZdm8yQn6J-yb4PvUsrzTA3KGxes42dE3bTrYbr9Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] [GSOC] ref-filter: add %(raw) and %(rest) atoms
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 9:39 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This patch series is split from my main patch series zh/ref-filter-raw-data,
> to make things easier for reviewers to read.

Thanks for doing that!

> This patch series provided %(raw) and %(rest) for ref-filter, which will be
> used by zh/cat-file-reuse-ref-filter-logic later.

Great!

It would be nice if you could also point to the previous times when
you sent this to the mailing list, so that previous reviews can more
easily be found and maybe checked.

Another nice improvement would be to link to a branch on GitHub or
GitLab, so that people could more easily fetch your work and try it.
