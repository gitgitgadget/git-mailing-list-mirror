Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811D0C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 17:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377165AbiBDR4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 12:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiBDR4K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 12:56:10 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F0C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 09:56:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id s13so21677156ejy.3
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 09:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xZZ+N+ie3i+ugzCjkB7J0sDap6yZ0p4Ks7AfEfDfkNc=;
        b=JXigntwZ0WPxbYOFUCEbxjJUb95pwkXtzzW0Dn56TfniNJcOH0n3a5MSvZLC73cAZQ
         r0dGVXB6krdSohrFe8cdyE4HhV8x0nEc4hWiHMj/s0/9RB4CH2G65rbXNARSkl8VmfJj
         BN9ZDl4PkBt8ba4oWjdlLVpQaZzhHoUG80vxBLnGXCyuzXrpwqaTr7SsrAEqc2Hy63Nv
         UHqJRBfrn5ew0N8JYF8J+qlTl82y01FElbw9UqFD17NrwaGMVnWx8dw+eAn4bJTpmANC
         tr8ss8nCh1CGFfKr1SHGRu/Luq3goU+zIXJQo5MzWhP1i0IPDz98jEtnFA9zbf7/BvtZ
         /hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xZZ+N+ie3i+ugzCjkB7J0sDap6yZ0p4Ks7AfEfDfkNc=;
        b=Cj+fo+fCkTode9C/cNfYLokJsn2WQAnSoQomGUrgOvsdEzCFb6+FkqO99Q0/S3patl
         iEzBTF1MbkbPu55U4ed7Z2axFu0MTc5/RwzNJpn4MBdT0ZKVhO/m+YBFM+FNt7uCIkOm
         Yjp+6hTxGisNqSnUJ9TXvjkh1qA5IxL5mYLrhv51/ipzIgAnxFJLq/WI/pLgzmLNj/X3
         2HjZfqBeVo4/PYbOuaFu+AISPSmvewUj0oEUGyPhEnyPE3OK4iRhKnt9sOWpkFJIOt/Y
         oGa1zLJLTHFHiYPbk77AaBhYDyKuVpF+VVPKvlVVL+PRMAlPQI6wKtxQf/OfUH/YKRQn
         Ga4A==
X-Gm-Message-State: AOAM533eiGE7SO269Asxh0GrZDUu/GzAcT7dTVUrStEf/ic1ac9D+9tD
        be+PvTfpGNdAr1zUfQLMrwL2c3Y9Qri9/5LvXVs=
X-Google-Smtp-Source: ABdhPJxdCi1Lm5UrjgQKJb7nqRnoWrtoxKZr28kVUu9hSb0GeAZMK6E2e7NbqvyGPlCaNjYxcz8cGTjDp5MAB3jE7QU=
X-Received: by 2002:a17:907:60d6:: with SMTP id hv22mr52057ejc.476.1643997369085;
 Fri, 04 Feb 2022 09:56:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com> <CABPp-BGM0xu=Hgd_uKevAbpCtxR9ZY5NX=PWNn2Bqw8SaOJvLQ@mail.gmail.com>
 <xmqq1r0io95u.fsf@gitster.g>
In-Reply-To: <xmqq1r0io95u.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Feb 2022 09:55:57 -0800
Message-ID: <CABPp-BGN+rErYFmMbUwxcwSOvCQbJMzB43-VRtim7tXtkuKvCQ@mail.gmail.com>
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

On Fri, Feb 4, 2022 at 9:04 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> Changes since V5
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>  * Fix incorrect conditional that was causing failure of non-cone mode=
 test
> >>    (and causing 'seen' CI to fail).
> >>  * Remove __git_comp_directories indentation changes between the secon=
d and
> >>    third commits.
> >
> > This round looks good to me:
> >
> > Reviewed-by: Elijah Newren <newren@gmail.com>
> >
> > Nice work!
>
> Thanks, both.  Will queue.  Let's mark it to be merged down to
> 'next' soonish.

=C3=86var had a good comment about code coverage on Windows that we might
want to address first[1].  (Namely, splitting one test into two -- one
that tests a path with backslashes that can be skipped on windows, and
a separate test that checks paths with spaces, tabs, and non-ascii
that can be run on all platforms.)

But other than that, yeah, this should be ready for 'next'.

[1] https://lore.kernel.org/git/220204.86h79f45nf.gmgdl@evledraar.gmail.com=
/
