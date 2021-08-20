Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6943C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7BF61131
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhHTQOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhHTQOL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 12:14:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3BC061757
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:13:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id mf2so2727527ejb.9
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rd5x1F0NnF3jY/2GhjM4Ti+D5tWRYDDJmaFBSx08Ka0=;
        b=jlqWNmfdlHBTabuAlJXyZEAgpJ8KXP0XpJ0bGFflVZLddjWiKL0uCAsWmu8GnIa3So
         8v5DXaKmmcL9YLXT3GLzO+cJLM9cxuy+G5W5m5Wa8EdYsAK55IUlZh4HVDn+bcrFpVmD
         RhszeAZOEe7qe8iYmqd86FDqbIg1LT6ovJ/f/jki+eBW6pu5fHnsD1X3Jd3Qc1cD9YaW
         +hVUCYdKE0iSMsMBt8twd1qUeG5/lcOpTPQYGZ0clLQ1qQffPkbgNHtHkOan5RAn1c78
         xWUCHAdVVJ0NAbrmYFngUidV+PVmab2UeGloxP5haBEI+L2s8j8ZAOqitSld9+MuM7dg
         kz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rd5x1F0NnF3jY/2GhjM4Ti+D5tWRYDDJmaFBSx08Ka0=;
        b=FlPylpn7VCe9U93kO5fi3tdc80o1/zjDoVNlakzB0i3Ot8qrwpjs+HZivvmkVS9ooL
         AX/BCXSZ8D56seS7sg8wapKorx1XwloMUNodaxV0tx/QlUyCC/QXN9z9K71r1938FId0
         yLDoTD10W0IIA5ngMR9IuVB7w7Nl6wwcUcFEZzRm2XY/G3M2weP1gxznbfgOu8kenj7D
         T3gfoqJ6iExEak88azbDtMBE5b2TNhNsk/hMovMXBHuad6DGj0r0DpWv12jvUC/11qLX
         eT76T0IQmfkigXM51AddoMVHIOb2ggyWINDYlIDUcEIC+2eLtTVY1dlt/NGjqzGQazbU
         94DA==
X-Gm-Message-State: AOAM531L0kXozrpTLc9eYTdCL2Zypf13q34RpBZ0bGGB+GVD79Ygh1+6
        tl2NYS4Xa5bV9HaTlGiU1YpCctKc7KClQ17Hxss=
X-Google-Smtp-Source: ABdhPJwkuqEU8mVxvyC6kBAeBHmYFbxpE8gTJCHy09vjN1g8YBA5+1S51zRoNAKxNfvfNeEfVxHGXgm4h98iqnJ9lQw=
X-Received: by 2002:a17:906:7d83:: with SMTP id v3mr22626745ejo.216.1629476012040;
 Fri, 20 Aug 2021 09:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
 <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
 <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
 <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com>
 <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com> <CAOLTT8Qx3=C=MwRmKbrp=G5T_rQVcaLbZfzzO60m7P-_k1qh8A@mail.gmail.com>
In-Reply-To: <CAOLTT8Qx3=C=MwRmKbrp=G5T_rQVcaLbZfzzO60m7P-_k1qh8A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 20 Aug 2021 18:13:19 +0200
Message-ID: <CAP8UFD0WB7FYtp9aX4qz5BmLiNz1S5PA1U8-cB8b9zRqdZHOjw@mail.gmail.com>
Subject: Re: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing,

On Thu, Aug 19, 2021 at 3:39 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Hi, Christian and Hariom,
>
> I want to use this patch series as the temporary final version of GSOC pr=
oject:
>
> https://github.com/adlternative/git/commits/cat-file-reuse-ref-filter-log=
ic

I am still not very happy with the last patch in the series,but it can
be improved later.

> Due to the branch ref-filter-opt-code-logic or branch
> ref-filter-opt-perf patch series
> temporarily unable to reflect its optimization to git cat-file
> --batch. Therefore, using
> branch cat-file-reuse-ref-filter-logic is the most effective now.
>
> This is the final performance regression test result:
> Test                                        upstream/master   this
> tree
> -------------------------------------------------------------------------=
-----------
> 1006.2: cat-file --batch-check              0.06(0.06+0.00)
> 0.08(0.07+0.00) +33.3%
> 1006.3: cat-file --batch-check with atoms   0.06(0.04+0.01)
> 0.06(0.06+0.00) +0.0%
> 1006.4: cat-file --batch                    0.49(0.47+0.02)
> 0.48(0.47+0.01) -2.0%
> 1006.5: cat-file --batch with atoms         0.48(0.44+0.03)
> 0.47(0.46+0.01) -2.1%
>
> git cat-file --batch has a performance improvement of about 2%.
> git cat-file --batch-check still has a performance gap of 33.3%.
>
> The performance degradation of git cat-file --batch-check is actually
> not very big.
>
> upstream/master (225bc32a98):
>
> $ hyperfine --warmup=3D10  "~/git/bin-wrappers/git cat-file
> --batch-check --batch-all-objects"
> Benchmark #1: ~/git/bin-wrappers/git cat-file --batch-check --batch-all-o=
bjects
>  Time (mean =C2=B1 =CF=83):     596.2 ms =C2=B1   5.7 ms    [User: 563.0 =
ms, System: 32.5 ms]
>  Range (min =E2=80=A6 max):   586.9 ms =E2=80=A6 607.9 ms    10 runs
>
> cat-file-reuse-ref-filter-logic (709a0c5c12):
>
> $ hyperfine --warmup=3D10  "~/git/bin-wrappers/git cat-file
> --batch-check --batch-all-objects"
> Benchmark #1: ~/git/bin-wrappers/git cat-file --batch-check --batch-all-o=
bjects
>  Time (mean =C2=B1 =CF=83):     601.3 ms =C2=B1   5.8 ms    [User: 566.9 =
ms, System: 33.9 ms]
>  Range (min =E2=80=A6 max):   596.7 ms =E2=80=A6 613.3 ms    10 runs
>
> The execution time of git cat-file --batch-check is only a few
> milliseconds away.

Yeah, it looks like less than 1% overhead.

Great work!

> But look at the execution time changes of git cat-file --batch:
>
> upstream/master (225bc32a98):
>
> $ time ~/git/bin-wrappers/git cat-file --batch --batch-all-objects
> >/dev/null
> /home/adl/git/bin-wrappers/git cat-file --batch --batch-all-objects >
>  24.61s user 0.30s system 99% cpu 24.908 total
>
> cat-file-reuse-ref-filter-logic (709a0c5c12):
>
> $ time ~/git/bin-wrappers/git cat-file --batch --batch-all-objects >/dev/=
null
> cat-file --batch --batch-all-objects > /dev/null  25.10s user 0.30s
> system 99% cpu 25.417 total
>
> The execution time has been reduced by nearly 0.5 seconds.

It looks like it has increased by 0.5s, not been reduced.

> Intuition
> tells me that the performance improvement of git cat-file --batch will be
> more important.
>
> In fact, git cat-file origin code directly adds the obtained object data
> to the output buffer; But after using ref-filter logic, it needs to copy
> the object data to the intermediate data (atom_value), and finally
> to the output buffer. At present, we cannot easily eliminate intermediate
> data, because git for-each-ref --sort has a lot of dependence on it,
> but we can reduce the overhead of copying or allocating memory as
> much as possible.

Ok.

> I had an idea that I didn't implement before: partial data delayed evalua=
tion.
> Or to be more specific, waiting until the data is about to be added to
> the output
> buffer, form specific output content, this may be a way to bypass the
> intermediate
> data.

Yeah, that might be a good idea.
