Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD47C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7900360F55
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhHBMum (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 08:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhHBMum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 08:50:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11013C061760
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 05:50:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v20so10278550eda.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mu4APawPjQtBo4oMSgsqYwvoEIUsl5IZUpF4oZAmo3o=;
        b=M0R+Gt6PqDOjK3eKrLXMlmjMmKbcwnd29T/YLxKZYezwjsGBpgedQmVKYVV0YhW+wp
         pkYs2W/jcIPZc4nqYSrPDnPdobvAspg4fcChocxIlZZIEayC64mSJTP9u5jdkDuymf+H
         Z2lqiWRgqx1/swQN48oNKOiNCqz14eJdvIKrWo6HNrAPIYmavr94/h4b2azPhlq7FoLA
         dqJQdLHfZPItuamuttqBT7w1nBnBeuPvXB7eLI2i7sAh5cjRoTx08QSpJpD+hWTuuD2B
         Soe85S1ns1lzEyOLZUgH11mKUsAgKAjP9IXxBAEaMa/URq13gMtiaceDxLK2+d41bp8V
         PjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mu4APawPjQtBo4oMSgsqYwvoEIUsl5IZUpF4oZAmo3o=;
        b=asmJSrSjamq6z9O0XB3hLv+sDZdG2cf4fA89Vx9rvhz1nxE7wSMfiU4Ind7YZWTGEa
         QvRf5hq5A1uCwKAUhu5kdWW0KIxSz1BeSQbh7uzYc7XXTEAclt1UV++kM/hfhq//dJAc
         px8QvPMbs/tdFOrffTo6i5MuahzIqkRpUoK16Qmgi7f2XeGgJlwXRd9UGZXUamXkbPKf
         ZhI5Da1Bvqtzcbf15+IT3Xt0/OT9GBtaXszsHX/QEJJGrETfUAgViEOHocKYBlbUide4
         IiuVZa1B1Ih7hLYP7CAv9HMM224/UVWSHft3mXzxugazo33uxMY9HJxmgQ680Zqf4lU1
         7fbQ==
X-Gm-Message-State: AOAM530G02HGBtl9B8pwrV0Sr7ybjrEBy81AiW8lmQhBMd1vJkCTr8i7
        p8m3+p0UiBRGJ3d+AznQ+Z8=
X-Google-Smtp-Source: ABdhPJwJPpnZwdLPcLPHGrPjfeyJX+01lHmxunP3w6GXDedi+JaSiaaPHbRRJYCN4xwxUZ2JvCE60w==
X-Received: by 2002:aa7:c9d8:: with SMTP id i24mr19124328edt.79.1627908630545;
        Mon, 02 Aug 2021 05:50:30 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m5sm2083403ejg.53.2021.08.02.05.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 05:50:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/4] connected: do not sort input revisions
Date:   Mon, 02 Aug 2021 14:49:29 +0200
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <1fd83f726a04dfb5be27c74cb116618cb76be923.1627896460.git.ps@pks.im>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <1fd83f726a04dfb5be27c74cb116618cb76be923.1627896460.git.ps@pks.im>
Message-ID: <871r7covsa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 02 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> In order to compute whether objects reachable from a set of tips are all
> connected, we do a revision walk with these tips as positive references
> and `--not --all`. `--not --all` will cause the revision walk to load
> all preexisting references as uninteresting, which can be very expensive
> in repositories with many references.
>
> Benchmarking the git-rev-list(1) command highlights that by far the most
> expensive single phase is initial sorting of the input revisions: after
> all references have been loaded, we first sort commits by author date.
> In a real-world repository with about 2.2 million references, it makes
> up about 40% of the total runtime of git-rev-list(1).
>
> Ultimately, the connectivity check shouldn't really bother about the
> order of input revisions at all. We only care whether we can actually
> walk all objects until we hit the cut-off point. So sorting the input is
> a complete waste of time.

Really good results:

> Introduce a new "--unsorted-input" flag to git-rev-list(1) which will
> cause it to not sort the commits and adjust the connectivity check to
> always pass the flag. This results in the following speedups, executed
> in a clone of gitlab-org/gitlab [1]:
>
>     Benchmark #1: git rev-list  --objects --quiet --not --all --not $(cat=
 newrev)
>       Time (mean =C2=B1 =CF=83):      7.639 s =C2=B1  0.065 s    [User: 7=
.304 s, System: 0.335 s]
>       Range (min =E2=80=A6 max):    7.543 s =E2=80=A6  7.742 s    10 runs
>
>     Benchmark #2: git rev-list --unsorted-input --objects --quiet --not -=
-all --not $newrev
>       Time (mean =C2=B1 =CF=83):      4.995 s =C2=B1  0.044 s    [User: 4=
.657 s, System: 0.337 s]
>       Range (min =E2=80=A6 max):    4.909 s =E2=80=A6  5.048 s    10 runs
>
>     Summary
>       'git rev-list --unsorted-input --objects --quiet --not --all --not =
$(cat newrev)' ran
>         1.53 =C2=B1 0.02 times faster than 'git rev-list  --objects --qui=
et --not --all --not $newrev'

Just bikeshedding for a potential re-roll, perhaps --unordered-input, so
that it matches/rhymes with the existing "git cat-file --unordered",
which serves the same conceptual purpose (except this one's input, that
one's output).
