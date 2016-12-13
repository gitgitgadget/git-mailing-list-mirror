Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E587A203C1
	for <e@80x24.org>; Tue, 13 Dec 2016 00:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbcLMA1h (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 19:27:37 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35823 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbcLMA1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 19:27:37 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so14802868wme.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 16:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ttR98zjrM8dTcAfDjiuNZB8J/lVQGuyZhRjLQQ1t4Og=;
        b=sSerpxMP6ArSeL6y17EXgUOb+UE8mGUvrm1kIIzxuMId0SFRFCQo6bs1l6TW02M8/h
         6KQxWh9cBnepuj8OY189lbbS2jvOt+lkArxiNXbsDc49joEDO5CK+vJyiGSki2bJdXJn
         3SeOwBwWgvQXZwjdodzAoX+X3NpEkDgwwmYFxDyQuUJI6uGmgZW/lywin0MjTj1N/QQa
         qo0hALxQrJ8Wk7+7ZmFjvnmoKIVdGAiB7Kgn4MsoR+PkxJ/hazoRJNOzMttnZ5TWMaQx
         c/zoqVwSrdyGJHb0RXGsOUMQAVUDL8TWzCtd0sP//LeaFGobsVRb6/Kl8ITedZWBmYXF
         a2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ttR98zjrM8dTcAfDjiuNZB8J/lVQGuyZhRjLQQ1t4Og=;
        b=nIHl53XBv5xVTUT8JgqttTlU5naUD6lds59pKUk1xKB2fqVYKlDlqldS+3nWzQVjui
         xOiWSpO6v5xkPgEyEfbsPXrmmxV2Pcalg8ylrlnE5A4GhsDIZDaEAwxtp98MGXRLcfF5
         eHEMQ/wATEvd1JPjlGDka9Muttx2hfPd9eJigUUKNXQUVrMkKfRkF7NYUjTuPBPkQDEC
         CnwUyOA987MqBWl4wBVpYh84L2TYzCSJwZ9O32hUt6aUcWxInjr2JgZghOd9ibO0sfxx
         HZRePMA2btsvRwPk+jQ/EL5ZaA0nDg90ihRbKfN7Y3MQJaHGDtEcFquZ8rKbIq9vU0rv
         Rcrg==
X-Gm-Message-State: AKaTC02TiaBbz2upuig/b1Y+zHiutZMvEeTH/QZ/rzMHLh/iuCPpG3l97dvEiiK4d0glaflky+ms4zwF5TnKqA==
X-Received: by 10.28.229.72 with SMTP id c69mr117786wmh.110.1481588855562;
 Mon, 12 Dec 2016 16:27:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.145.101 with HTTP; Mon, 12 Dec 2016 16:27:35 -0800 (PST)
In-Reply-To: <xmqqshps96ti.fsf@gitster.mtv.corp.google.com>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <20161208142401.1329-1-szeder.dev@gmail.com> <20161208142401.1329-6-szeder.dev@gmail.com>
 <xmqqshps96ti.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 13 Dec 2016 01:27:35 +0100
Message-ID: <CAM0VKjnPdt3keodXRFNit9=WKeY330N4T2t_dJuArgch7L6BNg@mail.gmail.com>
Subject: Re: [PATCHv2 5/7] versioncmp: cope with common part overlapping with
 prerelease suffix
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 10:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> diff --git a/versioncmp.c b/versioncmp.c
>> index a55c23ad5..f86ac562e 100644
>> --- a/versioncmp.c
>> +++ b/versioncmp.c
>> @@ -26,12 +26,15 @@ static int initialized;
>>
>>  /*
>>   * off is the offset of the first different character in the two string=
s
>> - * s1 and s2. If either s1 or s2 contains a prerelease suffix starting
>> - * at that offset, it will be forced to be on top.
>> + * s1 and s2. If either s1 or s2 contains a prerelease suffix containin=
g
>> + * that offset, then that string will be forced to be on top.
>>   *
>> - * If both s1 and s2 contain a (different) suffix at that position,
>> + * If both s1 and s2 contain a (different) suffix around that position,
>>   * their order is determined by the order of those two suffixes in the
>>   * configuration.
>> + * If any of the strings contains more than one different suffixes arou=
nd
>> + * that position, then that string is sorted according to the contained
>> + * suffix which comes first in the configuration.
>>   *
>>   * Return non-zero if *diff contains the return value for versioncmp()
>>   */
>> @@ -44,10 +47,21 @@ static int swap_prereleases(const char *s1,
>>
>>       for (i =3D 0; i < prereleases->nr; i++) {
>>               const char *suffix =3D prereleases->items[i].string;
>> -             if (i1 =3D=3D -1 && starts_with(s1 + off, suffix))
>> -                     i1 =3D i;
>> -             if (i2 =3D=3D -1 && starts_with(s2 + off, suffix))
>> -                     i2 =3D i;
>> +             int j, start, suffix_len =3D strlen(suffix);
>> +             if (suffix_len < off)
>> +                     start =3D off - suffix_len + 1;
>> +             else
>> +                     start =3D 0;
>
> Now that this function has to rewind the beginning of the comparison
> earlier than the given 'off', it makes me wonder if it still makes
> sense for the caller to compute it in the first place.

The caller has to compute it anyway, because it must deal with all the
cases when the two compared tagnames are not reordered based on their
(prerelease)suffix.
