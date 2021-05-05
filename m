Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B01C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 03:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7B9613CC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 03:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhEEEAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 00:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEEEAC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 00:00:02 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A4BC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 20:59:04 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v24so990028oiv.9
        for <git@vger.kernel.org>; Tue, 04 May 2021 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=cKGYKhwkvO6ak/+LW7lDwwlYVHZYgbGVuoGPhpTeSQA=;
        b=Zjuw3Z0ts/N6HcyHZ30J9MhikoDZObpvfSNbF62WUglCI+73OYffGUL1j7PQa7eIZJ
         DobKGuFZJZH5N7uw1px4PVKuOREuOCNoZItbY2ak/PNsTEXwb5i3GcD+VFj88MOxljeK
         izGjV7hxYYQEpto/27Te1H6EuavmRh+fqkosIeQST2+Xq2jarup+UpzpoGGI2Ncl5EG5
         7OvOY1kO5MpK31iaewZjywOk5rAll91fVN/9oQnjW2nCYoslNmwTwEXZkImAK8HrP0Z9
         1QRGUpRF0btQpLs3ncwlgBTT7Q0YSZvdZjHRxqUHzqFzyvKm6ZApnCC07MbX9oalhzV3
         2dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=cKGYKhwkvO6ak/+LW7lDwwlYVHZYgbGVuoGPhpTeSQA=;
        b=lTBM7OCJt20zNz6JbarSDlWK6xN4+pPa05nrzbbBsG3Z1TdBub1F+Mo2/kMy9NU49F
         huGIW3ms8ZqdEDimNZDpdrpRy9olNS6cbhUDZlWixe63G6A2ZgJx8HM2KV56dyqPXhnm
         LWt/ZQK3oB3moYumi8XuHHO2EmdBC0c5cjTnoFYHkIiRaschdvFFwUdeW0+WV/cMR1Mz
         40U7srJD1ttLu1Rk884Iptp5Uli7LxOHk4eTb8V1U7qHjwbc0ErULWOPv/b1ujqx8HlP
         rdgmcw2Nchj6kdrYs9rTRalI+GWT+RoVTEkFJDb6wqwEROngOqJszX2FJXgV8LF3xmj9
         kuZQ==
X-Gm-Message-State: AOAM531TqgeHilDF36PI4MnpRU4hXjVppP8gwrNMFow9oQ1EHxmOV0zP
        8FlV67EqddS4LxRdT1y3RBI=
X-Google-Smtp-Source: ABdhPJyMgRJnQ4SQvAmf/fZ1lOzRap8fpDatDh7Azf3AKoP41cNW326SM/0QCGfFQQJFhPVhwFV2ww==
X-Received: by 2002:aca:5a45:: with SMTP id o66mr5481941oib.121.1620187144199;
        Tue, 04 May 2021 20:59:04 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id r2sm1259712otq.28.2021.05.04.20.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 20:59:03 -0700 (PDT)
Date:   Tue, 04 May 2021 22:59:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <6092180651fdc_105ac2088a@natae.notmuch>
In-Reply-To: <YJH712E2kT9yJkGT@camp.crustytoothpaste.net>
References: <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
 <xmqqsg348k9j.fsf@gitster.g>
 <xmqqo8ds8k6r.fsf_-_@gitster.g>
 <877dkgxk9p.fsf@evledraar.gmail.com>
 <xmqqpmy76w31.fsf@gitster.g>
 <87czu6wuf3.fsf@evledraar.gmail.com>
 <xmqq7dke7jeo.fsf@gitster.g>
 <87a6pawmyu.fsf@evledraar.gmail.com>
 <YJHWJRYOcFEvHoD/@camp.crustytoothpaste.net>
 <6091e1f12ddf9_cc8208b9@natae.notmuch>
 <YJH712E2kT9yJkGT@camp.crustytoothpaste.net>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-05 at 00:08:17, Felipe Contreras wrote:
> > brian m. carlson wrote:
> > > On 2021-05-04 at 15:09:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason w=
rote:
> > > > My aim here was to discover if we had any reason to think that "l=
ocal"
> > > > was less universally implemented than other POSIX/C89-plus featur=
es we
> > > > rely on. It seems that it's not.
> > > =

> > > "local" is missing in AT&T ksh.
> > =

> > It's not missing, it's supported only in "functions", which have a
> > different syntax in ksh:
> > =

> >   function f { local x=3D"foo"; echo $x; }; f
> =

> I believe there's a bash compatibility mode that enables this, but I
> don't see support for it in the version Debian ships[0], which doesn't
> enable that mode:
> =

>   ksh -c 'function f { local x=3D"foo"; echo $x; }; f'
>   ksh: f[1]: local: not found [No such file or directory]

I tried to build ksh myself to make sure, and apparently there's a mess
of different versions of it. I manually applied some patches and tried
three times before giving up.

It's clear the Debian version and the Arch Linux version are completely
different.

> Regardless of the specifics, I think we can both agree that it doesn't
> work in sh-style functions, so for Git's purposes, AT&T ksh does not
> meet our needs in terms of support for local.

Indeed. But it also probably doesn't meet many other needs. A quick
check shows 54 failed tests just on t0000-basic.sh. I don't think it's
something we should even consider.

Cheers.

-- =

Felipe Contreras=
