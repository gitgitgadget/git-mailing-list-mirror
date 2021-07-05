Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F02C07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBD6613FB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGEHVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhGEHVB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 03:21:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A4C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 00:18:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k17so4703855edq.2
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Sftok5+EbKf7gWA7jNHkJ6pEmROHOkF/3bvtwLZNq60=;
        b=bmQbRMBSDxcjWXAd4fnwEE666se+ktlVuyvY5u038OjVTQGAREj09MC5uByfK8/NI6
         HxNq6rgHS7TEbUJtIPR4l2K1tqKmAelhw3t4JjhAWARk2b3fKGftDqEEO2wSJ05te6FX
         J52UtgT0bp9qMWuU0O0mYXgVAY6OP0GyuuTs8Aj5NlRJY17VcVytzM9UPSscih2n18hm
         CwiYZyEGIv39R41osCG6dknn62DDTBo37vjpMrH5OBk49+29qVTUlUIHG5vJ0X6h6EqO
         9ii+ueiZDbibDAMj7K+0wgLD7sZEA2IuSShzUZZYFxZYlJxMwCoiq3Cn4CEMi6ZaGOb4
         Sovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Sftok5+EbKf7gWA7jNHkJ6pEmROHOkF/3bvtwLZNq60=;
        b=hbd5WBEXjtMCE1bBUuXR52GtuoByRW6tpDviaUZkuM/zTdbSZ+6qc78//id4tf2WxF
         3bJTqrEnq1dniDz7C1x8VIPbQhpHOUHXM4aA4VJwbkm+3O3lhccJiyoD+fzlyHoekVLY
         5JogMxTGaJ0t4WtEWf3zj9yDRfhuDZV0XdjrvpeI8PG9Ijm4cng54KFlEUyebF1zyEVS
         ZcP+CEyihnQpvkuYfG+B4cMPZxNOPkv2YD1pTCGgSAEbGWTWCqezh4nb9IVnOyS+3SzA
         Yu6/3euURZs4G47Hg4EKebvLhuzr9wBW3fmps+guRNZ440AddpMwyul2UYkC5wi0b0n6
         ovfg==
X-Gm-Message-State: AOAM531epF8Naec0VmuwX19qhss1jZ4b8tJpFMlCo87aVhEhHa9PJer/
        lyBZUYIPG2yL2IG/TaTjFmT962E4qBc=
X-Google-Smtp-Source: ABdhPJxuKvX+nsLcgYNk6zNzWPhzwrozXcjuh8M+b8dXaFTfZ1eybMLTsp2akM3If/QOzpEce2jrsg==
X-Received: by 2002:aa7:d448:: with SMTP id q8mr14798296edr.250.1625469501943;
        Mon, 05 Jul 2021 00:18:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c15sm4844062eds.16.2021.07.05.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:18:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/15] [GSOC] ref-filter: add cat_file_mode in struct
 ref_format
Date:   Mon, 05 Jul 2021 09:17:27 +0200
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <9568baf5dddcc0637c15f698aea24d230c4d01b2.1625155693.git.gitgitgadget@gmail.com>
 <87czs0alhg.fsf@evledraar.gmail.com>
 <CAPig+cQinUsEZqEDb2_zhi37SdYuBCVEznmFbXPJuFB5cFznKg@mail.gmail.com>
 <CAP8UFD2FjY1mY=GS4ZZHiAxTpsqq7+1ywHfCvdRvJrr8Oo9-qg@mail.gmail.com>
 <CAOLTT8SHAxtQFNYAhJcfpbv8P7k5xq2id8Bvwp8vwnLYm+2beg@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAOLTT8SHAxtQFNYAhJcfpbv8P7k5xq2id8Bvwp8vwnLYm+2beg@mail.gmail.com>
Message-ID: <87lf6l6xfn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 03 2021, ZheNing Hu wrote:

> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=
=9C=883=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=886:11=E5=86=99=E9=81=93=
=EF=BC=9A
>>
>> On Fri, Jul 2, 2021 at 9:28 PM Eric Sunshine <sunshine@sunshineco.com> w=
rote:
>> >
>> > Aside from the potential maintenance burden of the `atom_type >=3D ...
>> > && atom_type <=3D ...` approach, another problem is that it increases
>> > cognitive load. The reader has to go reference the enum to fully
>> > understand the cases to which this code applies. On the other hand,
>> > the way the patch mentions the enumeration items explicitly, it is
>> > obvious at-a-glance to which cases the code applies. An additional
>> > downside of the suggestion is that the range specified by `>=3D` and
>> > `<=3D` may cause some readers to think that there is some sort of
>> > implicit relationship between the items in the range, which doesn't
>> > seem to be the case. So, I find the way it's done in the patch
>> > presently easier to comprehend.
>>
>> I agree that it's less cognitive load, but maybe it could be improved
>> using a separate function like:
>>
>> static int reject_atom(int cat_file_mode, enum atom_type atom_type)
>> {
>>     if (!cat_file_mode)
>>         return atom_type =3D=3D ATOM_REST;
>>
>>     /* cat_file_mode */
>>     switch (atom_type) {
>>     case ATOM_FLAG:
>>     case ATOM_HEAD:
>>     case ATOM_PUSH:
>>     case ATOM_REFNAME:
>>     case ATOM_SYMREF:
>>     case ATOM_UPSTREAM:
>>     case ATOM_WORKTREEPATH:
>>         return 1;
>>     default:
>>         return 0;
>>     }
>> }
>
> I agree. It is clearer to use a function to wrap origin reject atoms step.
>
> Thanks.

Yeah I guess you're both right, I just found the dense giant if to be
hard to read, but having a helper is even better.
