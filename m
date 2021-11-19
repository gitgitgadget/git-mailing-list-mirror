Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A433C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3C461A3A
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhKSRgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbhKSRgg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 12:36:36 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B790C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 09:33:34 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id b17so22850980uas.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UAQh8R+S8NkTkiIT7vnZlkhgzRba9LeGhRHyYgtmijI=;
        b=aFDwCQQhLp+Cpt5KrY+tQnPuhqeuuCMGj94H0VDKyzMCAXWIr+3wbL9wlDCGIFrvyg
         KIMCYPQT7/yv/AjhODNgUDX+fy10ibYVk1NANmo8tXtZ//KE8Nk+CiD2l/qjSlCSTN9C
         raduZoh9YALUWC1Kx0Tg3vdRLgAZB0R1MaR+RNV0B87EQJOeBx40FGrqfqWYjr/YtS+x
         jRN7O3ClWrcs5ZJ+D2z+LWzbcUuuIHESocBtdyFcF/jv/IFzETEsCD9ccYwpGqolxXid
         d/lOWrrkZihnAFrLZIcU1WptH58X2MKUvO0/i4s5JZB2egWZKId9zjCXMJ/IIB6oGSp6
         A23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UAQh8R+S8NkTkiIT7vnZlkhgzRba9LeGhRHyYgtmijI=;
        b=MrnzQFShsyMEqkJ1ylr/KO++XFZsTiqLFacD4RebBZOcgr129iRnsvhEqO0ou5zxmJ
         GOqQUnxMk/R24PaFWRURQivCr/orGa7vrWwq4t6dEiLRoc6UlGocnIk7m51qrQF2KcEK
         PAF6In8xD/LLED5Mz20aSvcqmGGxfyvSqvWejnhx2mKNoZ38XuecM4XA26/xXiXbUnqv
         6B4Yx/4ZCRlgPrHpH8TM4MmjTwR3mG5SQVpuXSrGAw4uP8Txn9Os3pGAPXjDqbKLC5Aj
         on/vZpD4Sdh1xKARI3Onw02glZpwIfjsU9xOr43UtJwAB7V27rEx0y0eZP24gMmCFmwC
         fzCg==
X-Gm-Message-State: AOAM532cyAlsWrezvIhdd6VGH9EzWXAWlEx71btirhAhfSoilORs9C+8
        Za8yIEeu5vrZ4o7AaIBEGMthP+8zw4bz1EK19Rw=
X-Google-Smtp-Source: ABdhPJzMo+Nk745zaCkUKR7+3vnvcMYGi7wTcQdlOp/bRDdkAljj7N315kmcX2dnLWGNJ6g4G3Fe8L8gFRm2Fjgx/qk=
X-Received: by 2002:a05:6102:36c:: with SMTP id f12mr93886259vsa.46.1637343213171;
 Fri, 19 Nov 2021 09:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com> <877dd9i1zj.fsf@igel.home>
 <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com> <87o86kv6fh.fsf@igel.home>
 <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
 <87fsrwv46h.fsf@igel.home> <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
 <634c4237-325a-13e8-0a92-09d23bdfb111@web.de> <211117.86y25m5wez.gmgdl@evledraar.gmail.com>
 <xmqqczmxxr8o.fsf@gitster.g> <c5223004-6db6-e808-f607-d11bd45e7d99@web.de>
 <211119.86mtm04og8.gmgdl@evledraar.gmail.com> <d1509690-0341-b6ef-5fd4-878ebbdfaf39@web.de>
In-Reply-To: <d1509690-0341-b6ef-5fd4-878ebbdfaf39@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 19 Nov 2021 09:33:22 -0800
Message-ID: <CAPUEspiq2tdBoCic0mzEXaiut7bwra+pUzj2ArMVU2-ee45=SQ@mail.gmail.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 8:08 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 19.11.21 um 08:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> >
> > On Thu, Nov 18 2021, Ren=C3=A9 Scharfe wrote:
> >
> >> Am 18.11.21 um 19:17 schrieb Junio C Hamano:
> >>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >> [...]
> >>> I guess this is a lot of change in the amount of text involved but
> >>> the least amount of actual change in the behaviour.  For those with
> >>> newer PCREv2, the behaviour would be the same as v2.34.0, and for
> >>> others, the behaviour would be the same as v2.33.0.
> >>>
> >>> Having said all that, because the consensus seems to be that the
> >>> whole "when we should match in UTF mode" may need to be rethought, I
> >>> think reverting Hamza's [v13 3/3] would be the simplest way to clean
> >>> up the mess for v2.34.1 that will give us a cleaner slate to later
> >>> build on, than applying this patch.
> >>
> >> Makes sense to me.  It gives a better starting point to solve the issu=
e
> >> afresh without getting entangled in mind-melting boolean expressions.
> >
> > Yes, agreed. As noted I haven't had time to dig deeply into this, but
> > from what I've seen so far there doesn't seem to be any obvious way
> > forward in terms of a quick fix.
> >
> > I thought perhaps your patch would be that (but I haven't looked into i=
t
> > carefully enough), but since you're on-board with reverting & retrying.
>
> That patch should fix the edge case without any side-effects -- at least
> I haven't seen any reports of ill effects that would apply to it.

Since it isn't restricted to log, it will still cause a regression to
the `git grep` case with binary data for versions of PCRE2 older than
10.34 and unlike the previous one it might not trigger an error in the
testsuite just because we are missing a test for it.

> It's
> easier to understand and reason about when applied after reverting, I
> think.  But it's only for grep.c and I don't know the situation in t/.

We had been focusing in PCRE in this discussion, but I see the strict
behaviour of older PCRE2 as just a "coal mine canary" to point to the
bigger problem that we are expecting git's regex to handle safely and
correctly from the point of UTF, what is technically a binary match
with --color making the mismatch obvious.

The issue is not unique to PCRE, and seems =C3=86var also acknowledges[1]
that by seeing the same bug this was attempting to fix with probably
some version of glibc's ERE.  I suspect FreeBSD's (and derivatives) is
also broken and might be throwing REGILLSEQ errors as well, so I think
that it is better to revert the whole thing.

Carlo

[1] https://lore.kernel.org/git/211119.86r1bc4om5.gmgdl@evledraar.gmail.com=
/
