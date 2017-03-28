Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565161FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 21:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753559AbdC1Vrw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 17:47:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33522 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbdC1Vrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 17:47:51 -0400
Received: by mail-lf0-f66.google.com with SMTP id r36so11751130lfi.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xJtCO4CPwprRure9EDHAAT7IE+Ufi/tPFNW8im/vM7c=;
        b=L38J1nqkf16OV9AwU661epHaYcz3H3AMoZ66OPskoeQPZv/ioUEntrJb2QshhRFyIo
         L+aZxPbfFZdWKJl0URuMeRHvlaPlml2feNktI4We4g5e/ZaJ99RrxjFYVmszxA2zZauj
         1xL/JjRlnBtENIWu9xnfenWpdVFBHnUvWWRK7WZxtyqlNL06vcb3o1RrsO9VY+W0UNBH
         H6MGY6+7HoiscpQMnUIejjovk5MpgSuD3EmfefPlwPgjz0XP3WVNQDgpFz0mowS0X5L1
         8TtMnZlVNwSOPWGStRuUQE4pjeB2yWhlZhdYyK4/NnOIcYigxUGxZUuaM84e7sLscSyg
         Jreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xJtCO4CPwprRure9EDHAAT7IE+Ufi/tPFNW8im/vM7c=;
        b=nE+FJXzOsyQf5xQCydei6o+Yb3uX4QE9qOywN3rxVKK0Llci6kb+V+lCq2drk08e8g
         cwY5EMyYsAoKYZGEn2uJMpcZ/nnKm8DNTfa7MPR9XbEMUh7olelOlTNA06fMtL0vw/b5
         mj9y8R/MneE6mGQxJJUEBYF+EKWmvih5ILj8w1ZHQlNd5aPfIdc6FVkQzriE+PU3S0aT
         wFrzci2BXm308wVoDn7blXTxLjmyO2Cvt414saSNVQbAuLIGyxllMRY5XCfbrkmr9gTR
         Xy6PmBCNaBI08wkUAloRyqm54E8oWTBXEOpMK4WjRrLN4B+gim3PxK1i42OcG8qClDqK
         D6KQ==
X-Gm-Message-State: AFeK/H3QQfrpWpaio80G98phi/o03IRkKaGQAgRc5dlhNX6BSWtMrTeldpPokWCChFNnJfXy8ecHtYXfLCi1fA==
X-Received: by 10.25.216.28 with SMTP id p28mr13525495lfg.164.1490737669120;
 Tue, 28 Mar 2017 14:47:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Tue, 28 Mar 2017 14:47:48 -0700 (PDT)
In-Reply-To: <CAGZ79kaFhrEFFfmBUUM7rc9RftS3cKLcvJe5M8jkwKL=bdemgQ@mail.gmail.com>
References: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de> <CAP8UFD3pXSf+RhysULQyd2kdKSkBWdoKs+L6GPQ4jwpoeP+yOA@mail.gmail.com>
 <CAGZ79kaFhrEFFfmBUUM7rc9RftS3cKLcvJe5M8jkwKL=bdemgQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Mar 2017 23:47:48 +0200
Message-ID: <CAP8UFD3sMyJTkoUccC6hV9peT+q3dKyX=ENpPtgjUx+z01EC5A@mail.gmail.com>
Subject: Re: [PATCH] strbuf: support long paths w/o read rights in
 strbuf_getcwd() on FreeBSD
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 11:24 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Mar 28, 2017 at 2:15 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Sun, Mar 26, 2017 at 3:43 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>> FreeBSD implements getcwd(3) as a syscall, but falls back to a version
>>> based on readdir(3) if it fails for some reason.  The latter requires
>>> permissions to read and execute path components, while the former does
>>> not.  That means that if our buffer is too small and we're missing
>>> rights we could get EACCES, but we may succeed with a bigger buffer.
>>>
>>> Keep retrying if getcwd(3) indicates lack of permissions until our
>>> buffer can fit PATH_MAX bytes, as that's the maximum supported by the
>>> syscall on FreeBSD anyway.  This way we do what we can to be able to
>>> benefit from the syscall, but we also won't loop forever if there is a
>>> real permission issue.
>>
>> Sorry to be late and maybe I missed something obvious, but the above
>> and the patch seem complex to me compared with something like:
>>
>> diff --git a/strbuf.c b/strbuf.c
>> index ace58e7367..25eadcbedc 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -441,7 +441,7 @@ int strbuf_readlink(struct strbuf *sb, const char
>> *path, size_t hint)
>>  int strbuf_getcwd(struct strbuf *sb)
>>  {
>>         size_t oldalloc =3D sb->alloc;
>> -       size_t guessed_len =3D 128;
>> +       size_t guessed_len =3D PATH_MAX > 128 ? PATH_MAX : 128;
>>
>>         for (;; guessed_len *=3D 2) {
>>                 strbuf_grow(sb, guessed_len);
>
> From f22a76e911 (strbuf: add strbuf_getcwd(), 2014-07-28):
>     Because it doesn't use a fixed-size buffer it supports
>     arbitrarily long paths, provided the platform's getcwd() does as well=
.
>     At least on Linux and FreeBSD it handles paths longer than PATH_MAX
>     just fine.

Well Ren=C3=A9's patch says:

>>> Keep retrying if getcwd(3) indicates lack of permissions until our
>>> buffer can fit PATH_MAX bytes, as that's the maximum supported by the
>>> syscall on FreeBSD anyway.

So it says that FreeBSD syscall doesn't handle paths longer than PATH_MAX.

> So with your patch, we'd still see the original issue for paths > PATH_MA=
X
> IIUC.

Also, Ren=C3=A9's patch just adds:

+               if (errno =3D=3D EACCES && guessed_len < PATH_MAX)
+                       continue;

so if the length of the path is > PATH_MAX, then guessed_len will have
to be > PATH_MAX and then Ren=C3=A9's patch will do nothing.
