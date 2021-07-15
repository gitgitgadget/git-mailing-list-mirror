Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF1FC12002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 01:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFA7613C0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 01:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhGOB4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhGOB4D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 21:56:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A40DC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 18:53:10 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k16so4545039ios.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ypANk8DF3TBXINz0IM5wV7X7vAn5z4xlUp+ete2jbrU=;
        b=L8m4R4Kv4gnv9HGPm4yuJdpXESnrUEslhuEI+Mx3oBCE6hlj4PRKyAJBxvY4DVZXxv
         gd12dkLFWm2KYiSMxFLpi/DmYZFCoxN2jLpmVdoCGAFR/zOAWsI3IVem9oa1jOMBW9xQ
         jUME98xKISAfebjUp0kr3323fmmZHKtSw3aNlq8eb1xtu/xlk8eWNM6418t/tjYglYmi
         8rIvc8N855AQos7u42Gohc24Ujf6LgbmJtY5HQbG9c9zmLh6H24IaykcLsnne6rFBjQN
         bL3I8F0PrJaSsYt7VjAufJH7aNT1Nl+zwb9eG8vIQk+EZskk0lcKXaPWv47ljasA1UJz
         daqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ypANk8DF3TBXINz0IM5wV7X7vAn5z4xlUp+ete2jbrU=;
        b=aXmzAZ2ummbmbzfggsyLTtuWKrseNKse9AG4bLLq6Wl8KFBtL49catv6JoiQQoGa7W
         4uk0kMLLFPXy7hQEjblaGL/h+XTA/U1F87AQUrL4U6JdZYidNzfnbAs0h5XX8QoW8qOf
         idjXzsXIymcFJDe+4oWg9yh3GW5Pc1naEmdKwHvX5vcvtFOZnlxOBZ32yDCf+QDWRtAz
         ztkvUa/x76/Mye8WO4h0NsI6X/7KmQkKgOFJtpG2AeCLoH6Uog9eMGQOpHaTEpOwdcv/
         pGmDZVNnh4a94z62D6pOJ5yyQIHxOK1GXV5wG6JvhF0UbW8RiiQNGJnZsvIVWmtu+KHK
         OjKA==
X-Gm-Message-State: AOAM531HgYvFybjevNYI2pwloO2jaJoxsHN3NtxLVFM9ApzJOcaqzF2X
        sXv9oqV8VMFniWw92Zai3S5EUiPWqQe0rZP3jdo=
X-Google-Smtp-Source: ABdhPJxLP1ASlNKxXO9zHqSrcWNAN3KY17+Hrl/BupCO3b++EjX2mCRi2BsGtN9750VdtaCEOWVhMpC+HqYd/lAxBCU=
X-Received: by 2002:a5e:df08:: with SMTP id f8mr951158ioq.172.1626313989728;
 Wed, 14 Jul 2021 18:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
 <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
 <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
 <xmqqtukz2rp4.fsf@gitster.g> <CAOLTT8RR4+tUuT2yc2PDL9NwCburW8bM_Sht6nhKJ_fYV8fGsQ@mail.gmail.com>
In-Reply-To: <CAOLTT8RR4+tUuT2yc2PDL9NwCburW8bM_Sht6nhKJ_fYV8fGsQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 15 Jul 2021 09:53:23 +0800
Message-ID: <CAOLTT8Sa984Eo18QMBeGnMCX3_7sr+9qUYoAR4FS3UF6+CDtGw@mail.gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8815=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:38=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > More importantly, why is such a fast-path even needed?  Isn't it a
> > sign that the ref-filter implementation is eating more cycles than
> > it should for given set of placeholders?  Do we know where the extra
> > cycles goes?
> >
> > I find it somewhat alarming if we are talking about "fast-path"
> > workaround before understanding why we are seeing slowdown in the
> > first place.
>
> There is no complete conclusion yet, but I try to use time and hyperfine =
test
> for these commits (t/perf/* is not accurate enough):
>
> -------------------------------------------------------------------------=
---------------------------------------------------
> |                        subject                                  |
> --batch-check (using hyperfine) |   --batch(using time) |
> -------------------------------------------------------------------------=
---------------------------------------------------
> |[GSOC] cat-file: use fast path when using default_format         |
>         700ms                |          25.450s      |
> -------------------------------------------------------------------------=
---------------------------------------------------
> |[GSOC] cat-file: re-implement --textconv, --filters options      |
>         790ms                |          29.933s      |
> -------------------------------------------------------------------------=
---------------------------------------------------
> |[GSOC] cat-file: reuse err buf in batch_object_write()           |
>         770ms                |          29.153s      |
> -------------------------------------------------------------------------=
---------------------------------------------------
> |[GSOC] cat-file: reuse ref-filter logic                          |
>         780ms                |          29.412s      |
> -------------------------------------------------------------------------=
---------------------------------------------------
> |The third batch (upstream/master)                                |
>         640ms                |          26.025s      |
> -------------------------------------------------------------------------=
---------------------------------------------------
>
> I think we their cost is indeed from "[GSOC] cat-file: reuse ref-filter l=
ogic".
> But what causes the loss of performance needs further analysis.
>

Now I think:
There are three main reasons why the performance of cat-file --batch
deteriorates after refactor.

1. Too many copies are used in ref-filter and we cannot avoid these copies
easily because ref-filter needs these copied data to implement atoms %(if),
%(else), %(end)... and the --sort option. The original cat-file
--batch only needs
to output the data to the final string. Its copy times are relatively small=
.

2. More complex data structure and parsing process are used in ref-filter.
This is why it can provide more and more useful atoms. Therefore, I think t=
he
performance degradation that occurs here is normal.

3. As =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason mentioned, oid_object_info_ext=
end() was used
twice in get_object() before. oid_object_info_extend() is the hot
path, we should
try to avoid calling it, So in last version of  "[GSOC] cat-file:
re-implement --textconv,
--filters options", I make the unified processing of --textconv and
--filter avoid calling
oid_object_info_extend() twice.

Thanks.
--
ZheNing Hu
