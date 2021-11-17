Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813CC433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 19:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E535761057
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 19:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbhKQT7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhKQT7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 14:59:36 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12120C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 11:56:38 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id n6so8577839uak.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aT+1gLIGaa895ocRipJWFcWC9s3dl+CF7YHUayKN4L0=;
        b=DX9hGiF9Mru0nHuBugEP4t3ycnXUBiYSrugLIAUI3Pv7eoHbwr6XuG+uIH/vTjnUbE
         GpRTB0Tl+Q8dfI5Zv1RcC7twcMshEUUD5leN9lDrxHts8Rktv/dYch8IG7Eu7U/JyTD/
         QZy/oU3DpqX9wfcQFE1qQNob27+qIgMR9tCGMv4RqMx2pRxiBMge4NQWaJARePXwW+2D
         fDxgOFONKdbelvJDdhM/i8tmO2nsU8wAwvZW+rD/9sj8G3B/pAg/10pLOxiBp06gc7xj
         rtCiWK3pm4VLG2yTZ+C4HeRl5wQifO7NDJ7pBOM1Ssl1PnonAW6SuI9PX7gMwVArauxZ
         F89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aT+1gLIGaa895ocRipJWFcWC9s3dl+CF7YHUayKN4L0=;
        b=0RpSNr2lBOzkezipXV93mWYldNQiWVhzQ4oeozCptuLmPVot+shHSFDZe9HkTwrS/6
         gb3hII9hk+pUxhr6F/qGPPsDuOtA97O3+K2pGMjPqnYiTlzFdAxwYV2huQ6/gvk2bdSK
         BMA8dFGwco1K5cdrTGJz9uLsP1YLNl5Y9uZ8c00h9KLYHHilkw7rBu3AXG8BmT7OjLj4
         MgF90Noyj574AI9SjmHw58DwkbGNhrZUlJfEmpxu7TgAFn7pkLYkiW9pKyk7X6KTpxx2
         wXE3dkHPJVmsU2vSPXLL1/BrVezL6iG+O2tuVoE8l6VtY+tZqYcKuHEwgusIc5hfMMAJ
         4WgA==
X-Gm-Message-State: AOAM533NbcK8s+BCTj44DAwi7zrhBjlO2UtjZIQvx/P9BlHU56ocVngl
        BI7K9wfCtdSQtWJKFruExxFf0MjSY29DLaK8kBMRorfoTD8=
X-Google-Smtp-Source: ABdhPJxb1p0HHpIwC5HBjqhR2hHvwXxU9eiNEarPdPNJtEP4uxQ+s8K6LG0012v41BT1s3fDWEUHAsreIiVH5PBTcrI=
X-Received: by 2002:a05:6102:512b:: with SMTP id bm43mr73156365vsb.14.1637178997125;
 Wed, 17 Nov 2021 11:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com> <877dd9i1zj.fsf@igel.home>
 <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com> <87o86kv6fh.fsf@igel.home>
 <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
 <87fsrwv46h.fsf@igel.home> <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
 <634c4237-325a-13e8-0a92-09d23bdfb111@web.de>
In-Reply-To: <634c4237-325a-13e8-0a92-09d23bdfb111@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 17 Nov 2021 11:56:25 -0800
Message-ID: <CAPUEspg3Ox41H-dCKzqV5oS4UP5Pkdoq0wUaXtxfNWWRTO0k1w@mail.gmail.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 10:46 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 16.11.21 um 10:38 schrieb Carlo Arenas:
> > On Tue, Nov 16, 2021 at 1:30 AM Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> >>
> >> expecting success of 7812.13 'PCRE v2: grep ASCII from invalid UTF-8 d=
ata':
> >>         git grep -h "var" invalid-0x80 >actual &&
> >>         test_cmp expected actual &&
> >>         git grep -h "(*NO_JIT)var" invalid-0x80 >actual &&
> >>         test_cmp expected actual
> >>
> >> ++ git grep -h var invalid-0x80
> >> ++ test_cmp expected actual
> >> ++ test 2 -ne 2
> >> ++ eval 'diff -u' '"$@"'
> >> +++ diff -u expected actual
> >> ++ git grep -h '(*NO_JIT)var' invalid-0x80
> >> fatal: pcre2_match failed with error code -22: UTF-8 error: isolated b=
yte with 0x80 bit set
> >
> > That is exactly what I was worried about, this is not failing one
> > test, but making `git grep` unusable in any repository that has any
> > binary files that might be reachable by it, and it is likely affecting
> > anyone using PCRE older than 10.34
>
> Let's have a look at the map.  Here are the differences between the
> versions regarding use of PCRE2_UTF:
>
> o: opt->ignore_locale
> h: has_non_ascii(p->pattern)
> i: is_utf8_locale()
> l: !opt->ignore_case && (p->fixed || p->is_fixed)
>
> o h i l master hamza rene2
> 0 0 0 0      0     1     0
> 0 0 0 1      0     1     0
> 0 0 1 0      0     1     1
> 0 0 1 1      0     1     0  <=3D=3D 7812.13, confirmed using fprint() deb=
ugging
>
> So http://public-inbox.org/git/0ea73e7a-6d43-e223-ab2e-24c684102856@web.d=
e/
> should not have this breakage, because it doesn't enable PCRE2_UTF for
> literal patterns.

Correct, and indeed I had your expression instead of the ugly one in
my draft for v2[1] but then I found the tests were even more broken
than reported originally and got worried it might introduce yet
another issue because of the brittleness of the rest of the code
around it.  I am hoping it will be introduced in a follow up series
though, and unless this code gets thrown away in the promised
refactoring by =C3=86var which I haven't seen yet and once this is in
maint.

IMHO and in line with the previous warnings you raised[2] during the
development of this feature, it might be worth looking at it more
deeply, but at least the proposed patch keeps the feature working in
practice (the only case that won't work as expected will be when the
expression includes "." with the intention of matching a UTF-8
character and while using PCRE2 older than 10.34) and more importantly
fixes the regression that it introduced.

Carlo

[1] https://lore.kernel.org/git/20211117102329.95456-1-carenas@gmail.com/
[2] https://lore.kernel.org/git/fc7eb9fc-9521-5484-b05f-9c20086fd485@web.de=
/
