Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186BB20966
	for <e@80x24.org>; Wed, 29 Mar 2017 04:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbdC2Eyn (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 00:54:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36636 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbdC2Eyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 00:54:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id n78so457613lfi.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 21:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3lEBEmX6JmoefvEjKQcueZeak52pi7TsycdkfybuYXs=;
        b=fj1dKGR7QkqKzJUB81J9mOUQMg1Sa/yd6kowfR9/rXWcMTdeRDS8i8uV7EYRL2FrEe
         UT7xzJ+I22+7V+c2vCvstmxif1rEcxgE7eSIQmaxzD0mVoz15rsMUxSxXKQL1w4uBFEC
         75aTBwPl/LxjtOt68UfdMjYl3D7R/RfsdQiSOE3NE1CnDCluCM+PYd4RmpR44VvuISXY
         kDJ6cCTQKOXWv25YcHWplT92dSC7+Ip1Gu/gABzzze3l6mCVWXrW+xkacOgmg+D9ahok
         RcmB4F6JydqwkQ9mVbiaL8GYs93xgqtKfEY9r5Y5tvt91PwR5bS0MCHD2lhpHOd5v/mg
         4AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3lEBEmX6JmoefvEjKQcueZeak52pi7TsycdkfybuYXs=;
        b=irhfW8UkTNxjLvMj5xrS9f4haBdGfbw2gk0S8VhhCZTSyBYO9YAmUif8frZ6QItDhJ
         F6EE989kUI4WZuwML0Ku7GXkFV/mPqMm9JFMEVaAG4xlaHDFo+1MBsad08+R0iFWid4b
         zMH7x/9V8JQNjzAh6Rm6aia8gBLuiPq+9sSmYpcpq7ceW7k9Fvy6cm2/kYGX8QUExtC5
         n64x/EEMMJJBLvPGT0Q1+FW18MsKYbihProESoF4l8ZLFaTOTrwOSt0AsdoaKgHlhjXm
         PWE7OUCI3pchcQgR6A+3HaWbIFBcfePBv22HBJloeN7GQRyZUhmL165scoUIjG+6JBWV
         f0hg==
X-Gm-Message-State: AFeK/H2mPOhDkVRRdA+pFY7fbEJHbXf97DL9Ha31lqr3nt99TWkIEfPlTUOoH9Wc3MCDUIxk6Mz08l6mUo/Mpg==
X-Received: by 10.46.71.81 with SMTP id u78mr2779143lja.16.1490763278332; Tue,
 28 Mar 2017 21:54:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Tue, 28 Mar 2017 21:54:37 -0700 (PDT)
In-Reply-To: <20170328214930.bj4etqn5qecv45im@sigill.intra.peff.net>
References: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de> <CAP8UFD3pXSf+RhysULQyd2kdKSkBWdoKs+L6GPQ4jwpoeP+yOA@mail.gmail.com>
 <20170328214930.bj4etqn5qecv45im@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 29 Mar 2017 06:54:37 +0200
Message-ID: <CAP8UFD1wqW221qxWqMz1jHxDLKCg71a2VBh+wUdV8sMSEN2aZw@mail.gmail.com>
Subject: Re: [PATCH] strbuf: support long paths w/o read rights in
 strbuf_getcwd() on FreeBSD
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 11:49 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 28, 2017 at 11:15:12PM +0200, Christian Couder wrote:
>
>> On Sun, Mar 26, 2017 at 3:43 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> > FreeBSD implements getcwd(3) as a syscall, but falls back to a version
>> > based on readdir(3) if it fails for some reason.  The latter requires
>> > permissions to read and execute path components, while the former does
>> > not.  That means that if our buffer is too small and we're missing
>> > rights we could get EACCES, but we may succeed with a bigger buffer.
>> >
>> > Keep retrying if getcwd(3) indicates lack of permissions until our
>> > buffer can fit PATH_MAX bytes, as that's the maximum supported by the
>> > syscall on FreeBSD anyway.  This way we do what we can to be able to
>> > benefit from the syscall, but we also won't loop forever if there is a
>> > real permission issue.
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
> I think the main reason is just that we do not have to pay the price to
> allocate PATH_MAX-sized buffers when they are rarely used.
>
> I doubt it matters all that much in practice, though.

Yeah, I can understand that.

But I also wonder if Ren=C3=A9's patch relies on PATH_MAX being a multiple
of 128 on FreeBSD and what would happen for a path between 129 and
PATH_MAX if PATH_MAX was something like 254.
