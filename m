Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788ABC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 20:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiBDUDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiBDUCO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 15:02:14 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A08C061796
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 12:01:35 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w14so15323430edd.10
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 12:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a8IIdidA6giv3pNX4063J/Iyu7CJ6yD2zN7W+cRUxTM=;
        b=IA5vIw5pevmCjF4+2WQG15+CpWqIWqgTu9OkJOgItYIWR1MMvuJhVIW445AHdxNzRy
         i8mPzrVwlIDDV742Brl8TOPGy+p/VxxhBwxivEIikCzBG8P5KyTc0VSFyxObUkNekmnj
         SXlhUuKY0ql+J8Yypq1ds2hBLa780Td9mr3Wq6DJPt5lfCH5fV32lJkOFgBd4LNrJAxs
         ZWzZQonIUACoQqOYY7UeWtAoDk07eNRTiL5qPFmdtVHLCObxbIYAyPeu6c7UuCI+Upt3
         weYWi5/2Um9xdTTHkMO/gFbBTZY/bRBiDIvT5jdQSvFEH4ygQy1tUSLL/9He0pzbRgDt
         tzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8IIdidA6giv3pNX4063J/Iyu7CJ6yD2zN7W+cRUxTM=;
        b=Sb3B+Tx5xpvahjaFUYfR8K20OhY+njELc1+O6derTfTmONh88l8LSHIU4pRYA9qwJk
         h9ZCJ+0jUkcl67z2c8JT7CQE3ol094Ch5eq+253xdcMBLXcQAbNUv/NILcv4uL6UfP1D
         byL/aMpVdSIAlzHJe4YuCh5et+eYHHhlrTY4c2SxNe+rIrO8SVRRIbZsm3Q7BNsFBd0F
         4yjIIHCOFwmHXd30tAvRRe5NM3znsh0QONhbgrcr/2pfIlDvwszJTSkwGO4dLf8+ZDYw
         hK0x4JAZhEtbCoU+IVXZxBrVoaUUs0in1vLnW1LcJUWp+M/E5ddWsItDeB7Fja9Odfpv
         wvGQ==
X-Gm-Message-State: AOAM530oF9KaOkb+aQmcjlHHKQxsiwuPCpyQW3rRmrKoeGStTDN5wcPC
        Fa7nQKOp2/DWCbgqBAgmfjq9b+mM4v4bi69UvFI=
X-Google-Smtp-Source: ABdhPJwGKTIorFz2VccB4YrXaGq3qStG90/zidyZPfSsuVw3O0ZWZXuKgvefxWuCIvLqBlxsCgg9Ks5fqmaaIXzN+dg=
X-Received: by 2002:a05:6402:424a:: with SMTP id g10mr768783edb.309.1644004893881;
 Fri, 04 Feb 2022 12:01:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com> <CABPp-BGM0xu=Hgd_uKevAbpCtxR9ZY5NX=PWNn2Bqw8SaOJvLQ@mail.gmail.com>
 <xmqq1r0io95u.fsf@gitster.g> <CABPp-BGN+rErYFmMbUwxcwSOvCQbJMzB43-VRtim7tXtkuKvCQ@mail.gmail.com>
 <xmqq4k5emmq2.fsf@gitster.g>
In-Reply-To: <xmqq4k5emmq2.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Feb 2022 12:01:22 -0800
Message-ID: <CABPp-BHgU3-VVt+OYfY77_ymPdFHbs8x1SMN_V9jfawDZ570Ng@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] completion: sparse-checkout updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 4, 2022 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > =C3=86var had a good comment about code coverage on Windows that we mig=
ht
> > want to address first[1].  (Namely, splitting one test into two -- one
> > that tests a path with backslashes that can be skipped on windows, and
> > a separate test that checks paths with spaces, tabs, and non-ascii
> > that can be run on all platforms.)
>
> According to the lazy-prereq definition for FUNNYNAMES, we seem to
> skip tab-embedded names on windows, so it may not be used on all
> platforms, but such a detail aside...
>
> I do not get why funny letters should matter and need to be tested
> specially in the first place, to be honest, but because we have with
> FUNNYNAMES prereq already, hiding some tests behind it would be a
> good idea regardless.

Earlier versions of the patch series failed to handle paths that
contained various special characters; see the second comment at
https://lore.kernel.org/git/CABPp-BEq9pTqsy_R_SR1DSgUK58ubNR1Gk4G1RoL8wkady=
o6zw@mail.gmail.com/.
Handling them was specifically the job of the third patch in the
series, and thus it made sense to add some kind of test for them.
