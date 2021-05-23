Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82769C4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 18:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DA661261
	for <git@archiver.kernel.org>; Sun, 23 May 2021 18:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhEWShm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 14:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhEWShl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 14:37:41 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859F0C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 11:36:13 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id b25so25143437oic.0
        for <git@vger.kernel.org>; Sun, 23 May 2021 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=F/81jvG7jyYa8B6ZwFd1f5N5OWUqhMVokLrdhQ90Fqs=;
        b=SV5nWymQo5/B+9D1ShBRY8zimxDBpkKS+9FLsaeijqT7ElfeSDdSlMw473azU+hrXK
         ibCkwc/qA4CIKs9hRDvDuVLpqM+9rt1D3oAFvLUwVWmqp40Ndz+wBGEte/RRMDkGTR5I
         9c3QUrJT3ZzSFbvIYCc2K7DtULuyAa0SL/6KCxP6sTEAeJrb6Cpq5W4vojtzpTHEMJ8n
         MKDukaWkHyPJqaVv/yi7x/SHH8rv13XJzPrbzKWwqQ4NhMW9S5WSqXrkbgy6SO2MRbmQ
         T5niqWT5R0u6j9IPLme67Eor34ASgCXP3Nc6j4+SwoGz0O1e9yQFRllS2q7lpSUcQj+t
         YJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=F/81jvG7jyYa8B6ZwFd1f5N5OWUqhMVokLrdhQ90Fqs=;
        b=dSkVK/lamDLRs9HsztweCaKujNpRmHnrnXgydEXxqIqC2Do4Bw9vuTy0hvvWKwibMh
         ocM6osC3dYqI9i6kWWZEOSqLyzdJchLSRn7i9acYl509gB7oB2hgZSLUXKSPOJZ64ev1
         0oo6eodU9ErOSpyGK2mqkKr3rujGN/3ploN3vRx3jBedTihWNEswaYrMhztP8A19+5qa
         UWd7idfsPipq2dGpiZWwQRKYBijjbF0E+UvQ8pnNj+MQXrUToo8WyJITPHX0cUH3fNev
         sjnwnEIGUT1fiMTCfkcdp6cF40uw9/Hnj3Itr0/1MuWkW+Fm7s2BmXgg0ydDNs50DBaP
         Jytw==
X-Gm-Message-State: AOAM5320tcGcr1Ycw8z0Lss4KFWmnFDfLu/SIEL0EMyvUwnBPcYetw3W
        sRd7sUTpauSchV8Qjp80G1BKuVZec32s1g==
X-Google-Smtp-Source: ABdhPJx4aaaOIsnYyd4GICzVdskWorhtd0x1uuLCDfBVSIFIvWLBmzNUvEKPHWPMa1zv6Zr2Lp5pKA==
X-Received: by 2002:aca:2311:: with SMTP id e17mr8543565oie.160.1621794972857;
        Sun, 23 May 2021 11:36:12 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id w15sm2380925oiw.34.2021.05.23.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 11:36:12 -0700 (PDT)
Date:   Sun, 23 May 2021 13:36:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Message-ID: <60aaa09aebce4_454920811@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-5-lenaic@lhuard.fr>
 <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
 <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on
 Linux
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Fri, 21 May 2021, Derrick Stolee wrote:
> =

> > On 5/21/2021 5:59 AM, Bagas Sanjaya wrote:
> > > On 21/05/21 05.13, L=C3=A9na=C3=AFc Huard wrote:
> > >> The existing mechanism for scheduling background maintenance is do=
ne
> > >> through cron. On Linux systems managed by systemd, systemd provide=
s an
> > >> alternative to schedule recurring tasks: systemd timers.
> > >>
> > >> The main motivations to implement systemd timers in addition to cr=
on
> > >> are:
> > >> * cron is optional and Linux systems running systemd might not hav=
e it
> > >> =C2=A0=C2=A0 installed.
> > >> * The execution of `crontab -l` can tell us if cron is installed b=
ut not
> > >> =C2=A0=C2=A0 if the daemon is actually running.
> > >> * With systemd, each service is run in its own cgroup and its logs=
 are
> > >> =C2=A0=C2=A0 tagged by the service inside journald. With cron, all=
 scheduled tasks
> > >> =C2=A0=C2=A0 are running in the cron daemon cgroup and all the log=
s of the
> > >> =C2=A0=C2=A0 user-scheduled tasks are pretended to belong to the s=
ystem cron
> > >> =C2=A0=C2=A0 service.
> > >> =C2=A0=C2=A0 Concretely, a user that doesn=E2=80=99t have access t=
o the system logs won=E2=80=99t
> > >> =C2=A0=C2=A0 have access to the log of its own tasks scheduled by =
cron whereas he
> > >> =C2=A0=C2=A0 will have access to the log of its own tasks schedule=
d by systemd
> > >> =C2=A0=C2=A0 timer.
> > >
> > > For gender neutrality, we can use he/she instead.
> >
> > Singular "they" is better. Fully accurate and less awkward.
> =

> I agree.

I disagree.

> If the singular they was good enough for Shakespeare,

Shakespeare:

 1. Did not know gammar
 2. Invented words as we went along
 3. Was no writing prose

This is not the kind of English we wish to replicate:

  "This was the most unkindest cut of all."

> See for yourself:
> http://itre.cis.upenn.edu/~myl/languagelog/archives/002748.html

I do not see a single instance of a singular antecedent there.

Not that it matters, because unlike Shakespeare we are wriing classic
prose style. The styles could not be more different.


The singular they is a controversial topic[1][2], even among linguists.
This is a software project, we must not make decrees about proper use of
English language, especially when linguists themselves have not yet
fully decided.

If you want to use "they", go ahead, other people want to use "he/she".
The git project should steer cleer of value judgements that one is
_better_ than the other.

Not to mention that these kinds of promulgations invite the culture war.

Cheers.

[1] https://time.com/5748649/word-of-year-they-merriam-webster/
[2] https://www.theatlantic.com/culture/archive/2013/01/singular-their-af=
front-good-writing/319329/

-- =

Felipe Contreras=
