Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ED5C41515
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69934610A0
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhEJLNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbhEJLLt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 07:11:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E130AC061245
        for <git@vger.kernel.org>; Mon, 10 May 2021 04:09:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id di13so18224739edb.2
        for <git@vger.kernel.org>; Mon, 10 May 2021 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2NQTLWR+get2HLvyxh3vYbrF/ET80Fx4KgCIWNfjSy8=;
        b=eLORWuUzde+8lHl2xs2/7buSeb1HXjFkpNRR6CC0DIqXokFhw7VVsr9h29CC/1CRVT
         SHxU4pZzHXw6YK53OlQ8tD4Kf6r5Oq9wwvrjjoS84RFgboFx7FRQiVxR+dIblB4wQ1IV
         C+s8wjtIKOum0aJjkJ4Etjr4Nas++yeoiPnGh9OPi4kXKWJkST44rE5dpS0mBgS7ETRd
         vjcn91QdOwUuP72AK3RSpZ3U8THIaexPlpL5GiZpDL5Qa/d8PYipHASnl6A2infhnH+L
         NwWxSJky8dOd3ppfySRUe7+KUmFUsnL0I1l9f0wcqA9LwtLrbhZbrdaXQLpe4tydAX/C
         sFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2NQTLWR+get2HLvyxh3vYbrF/ET80Fx4KgCIWNfjSy8=;
        b=tKKf2Ov0xY/+C9B9XC/y+wlDeQVBUTkFAWhY706eCbpu4QG7dh06QIoYmxubXfqmnA
         RYpxd6NBMfUl5XXgngIy0jENeJoUb2GMhhtPhnb6BQXdAx3X5h+S99a0WhDVm7deMVqL
         RLfpwj+QQfbH/EuLvxoUVX6j5/0gUTlYC5WNgR77DcpF9KFGBypbv+VG0gk9hEHpTdgH
         lmJIGG9rakVzyvAAHI0ywavQC/NK9Bgx0+NswySUf/fgkJWfoz5yiXd+DleOqr4FVjDK
         X6ETGVS0PDRIdCy8bgUtsvPIIkGFjBvjmE98Kr8KPTQRp1Kizao3os6ILF/OCCOsmHBi
         IG/g==
X-Gm-Message-State: AOAM533ZApe805kqT6eKlBDDehLKH1FiKh+SEQjsHzU1ioBjhvrXolcT
        RzN0ZufuZTF22rCqbbaVVCg=
X-Google-Smtp-Source: ABdhPJyIcLgh0OEY8ye1H9vPXRx0qyEY6vunCvkYsu00zI16fP7jrg7WeuFpV23XTOdlqfZqx2jwHg==
X-Received: by 2002:a05:6402:750:: with SMTP id p16mr28715261edy.156.1620644942576;
        Mon, 10 May 2021 04:09:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u11sm10951735edr.13.2021.05.10.04.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:09:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
Date:   Mon, 10 May 2021 13:04:48 +0200
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <877dkdwgfe.fsf@evledraar.gmail.com> <xmqq35v01ua3.fsf@gitster.g>
 <87pmy4uqhz.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <87pmy4uqhz.fsf@evledraar.gmail.com>
Message-ID: <87zgx2u9pu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 06 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, May 06 2021, Junio C Hamano wrote:

*Poke*

>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I mean, I see why. You don't want a typo of "master" as "maaster" to
>>> create a new "maaster" branch, so really that's out. But it really
>>> should be:
>>>
>>>     # -n or -N for --new / --new --force (the latter just in case of a
>>>     # race, and just for consistency)
>>>     git switch -n doesnotexist
>>
>> I do not see why --new is better than --create; we did choose not to
>> reuse --branch from "checkout" and I remember that was a deliberate
>> decision (i.e. once split into "switch" and "restore", "switch"
>> becomes only about branches, so unlike in the context of "checkout",
>> in the context of "switch", the word "branch" adds a lot less value,
>> and certainly does not signal we are creating a branch and switching
>> to it).
>
> I don't think --new is better than --create when considered in
> isolation. I happen to think --create is better.
>
> What I'm arguing is that we should be aiming for some consistency in the
> command-set. In this case the relatively small change of
> s/--create/--new/ server so make the rest consistent. I.e. the branch
> and switch commands can mirror each other in the ways that matter for
> these common operations of create/copy/move.
>
>> It would have been a stronger argument to favor --new if we had "git
>> branch --new <branchname>", but that is not the case.
>
> The argument is that switch's experimental design squats on 2x other
> options, so changing -c to -n so we can make -c and -m do the same thing
> is better.

Whatever the merit of the argument I'm putting forward here, it would be
useful to get some idea of whether you'd be categorically opposed to
changing the interface of switch/restore in breaking ways even though
they've been marked as "THIS COMMAND IS EXPERIMENTAL".

Of course any series to implement what I suggested in
<877dkdwgfe.fsf@evledraar.gmail.com> would need to stand on its own
merits.

I'm not planning on working on that since I expect the response will be
at best "neat, but that ship has sailed", but if that's not the case...
