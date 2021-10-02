Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63473C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3158A61A8F
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 08:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhJBIkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 04:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhJBIkS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 04:40:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCEDC061570
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 01:38:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p13so15206205edw.0
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=l+gzQKTKjToRKeqeMGeqqKdwgOAiKSmJ8YPjCfQ6gWk=;
        b=RAnB3BU9R7pn1Xav1frZCaObf6GgPx0EcgEAtB9i1qQgoGpaL0nw+lGMmO1XW9O21R
         SluEbJJHGB3sqO+TvRiVF2YlKLSfm6ZglDLohlk/GfkawhF7ol/JnauQJb+2O0rAliSB
         SVSGFj3OrdzxN4Ya3UcHtHLDNtOyzHiAihGX6ErNGhsVATp82tW6LEtopMXEjq0rkMQu
         3bF0EUM0bELRXEqHwjgp48aFnx1xnHqQAmYbZnE7XDdvM8bDVYiq8trWy0waK1Di2JRB
         PkZYFF/RSmFSu4oglUElgmyHbGrCietNRI60qazGl65EsKNBVgb49vahfABWSbYKNPDQ
         J4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=l+gzQKTKjToRKeqeMGeqqKdwgOAiKSmJ8YPjCfQ6gWk=;
        b=FbW5A4aKWHyLNhy37sc2nXVp4cdcsK8Lz6W0HiRFCFQRD+pZimF/YmM3EERswaSr/o
         054EAg4LDCt7TUuU1g2gQH06or/QPOYNW12wHf8pHbqD+mHoNOBFo5LUn4XS0mt5tg+A
         MNx3j+6jT2TO6I1ZswT4nSh9MUy6kcB6uJsMC4eNVJ/04dJi43nS7s9kMFqox0LLwv7X
         x4b+3kfFOOHWZL6Qx6W6d8OSrzqRE/enBV3JaOUO+hpYo5YEPe6z894CfHk4EUDP3/1U
         loFGM0uUSgKqMmHPLJ+KoGxWTpbJ1TQx06EPW8pmGpJlNj/DMiI5GRGGp0XRDISbpKzv
         hVTA==
X-Gm-Message-State: AOAM533hviISm+SCouoardag+PDf12KjkDnWxR+/g1evd5XWosTF3vs0
        L1XZcZJeBRTqQoYvLdyJuLA08dGbuWHT0Q==
X-Google-Smtp-Source: ABdhPJybPgtbM/16doPB1LEFKZZ5PFXs/Kpldrz6ZfmNMlQ6MApQ1Ve7SOr2WN0tLqMkO3QkL6HDpQ==
X-Received: by 2002:a17:907:2855:: with SMTP id el21mr2937646ejc.141.1633163911682;
        Sat, 02 Oct 2021 01:38:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bj10sm3870463ejb.17.2021.10.02.01.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 01:38:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/9] test-mergesort: add test subcommand
Date:   Sat, 02 Oct 2021 10:35:40 +0200
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de> <xmqq7dew7aqd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq7dew7aqd.fsf@gitster.g>
Message-ID: <87o887q0s9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 01 2021, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> +static void dist_rand(int *arr, int n, int m)
>> +{
>> +	int i;
>> +	for (i =3D 0; i < n; i++)
>> +		arr[i] =3D rand() % m;
>> +}
>> ...
>> +static void dist_shuffle(int *arr, int n, int m)
>> +{
>> +	int i, j, k;
>> +	for (i =3D j =3D 0, k =3D 1; i < n; i++)
>> +		arr[i] =3D (rand() % m) ? (j +=3D 2) : (k +=3D 2);
>> +}
>
> I briefly wondered if we want to seed the rand() in some way to make
> the tests reproducible, but we'd need to ship our own rand() if we
> wanted to go that route, which would probably be too much.

Wouldn't calling srand() with some constant value suffice on most
platforms? I'm aware of it being a NOOP and rand() always being randomly
seeded on (IIRC) OpenBSD, but that should work on e.g. glibc.

>>  int cmd__mergesort(int argc, const char **argv)
>>  {
>>  	if (argc =3D=3D 2 && !strcmp(argv[1], "sort"))
>>  		return sort_stdin();
>> -	usage("test-tool mergesort sort");
>> +	if (argc > 1 && !strcmp(argv[1], "test"))
>> +		return run_tests(argc - 2, argv + 2);
>> +	fprintf(stderr, "usage: test-tool mergesort sort\n");
>> +	fprintf(stderr, "   or: test-tool mergesort test [<n>...]\n");
>> +	return 129;
>
> If you can live with OPT_CMDMODE to implement sort/test subcommands,
> you'd get to have parse_options() to do the usage for you, I think.
> I am not sure if it is worth it, as t/helper/ is not end-user
> facing.

Yeah I think the one thing that could improve here is this custom
getopts handling, in particular the manual formatting of "usage" and
"or" is a bit ugly, considering that you'll get it for free with the
parse_options() "usage" array.
