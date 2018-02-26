Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820101F404
	for <e@80x24.org>; Mon, 26 Feb 2018 12:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeBZMUB (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 07:20:01 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37637 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBZMUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 07:20:00 -0500
Received: by mail-wm0-f65.google.com with SMTP id 139so3683598wmn.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=t9eET0ky0E2D/KAlieFvKtKFzpR5FxUrMDPtORHdhJ4=;
        b=bBtaDR/0vXo9gGYf0rIhRbPm92zaDZ8AkYu3yjbckx/QI9HqQ2dzd/39JGHSgjaaN+
         uKxBRuRpGUwe12amJ1kN7tvIJI0fE65SpgIK6Y6GedThNaPiiq93oyMmWJdjApLBrMOL
         BN9mRG3at9FdxRTtdfxZ7o7qpVV2k4zU7P0020hT87jxqQfcUfD78yQoOv5a+bRrv4+L
         kzT0YRwAiNZ6JkuBNtYsKjDVY92y0lhmIKBDCkjdYmODq28OtOQ+YoUMkdnGRQClmG/o
         c1Mj2H+MCsVTxd6RT+xtL41nHILGiV17xV/vjJc+YZ5fZrqr+UyV3RyUTUAN0LrTtEkK
         7shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=t9eET0ky0E2D/KAlieFvKtKFzpR5FxUrMDPtORHdhJ4=;
        b=OOn/9qJZLiamK+4ldTerijP/lWAamdjLFwdK/nVbqEs320FuLq3QFSAufkBqY08xdr
         LBHD8yHK+3yTFPDNkqiippScPz9vUMTj3XcAUgHV/KCJ6Kkn9D99oKwMYN5YZnnrhGAf
         xE70Ks9Aza0bEpbiJWz+t5I1Ap92tWBLRzm9TFG5pS2//G37BbHXDvuSuRlBswS4l2Nm
         3N2y7ma77rTTEABrjmeZD61pbPjdyPvQdavtik9G96sqO3k8lUbsUAnpsbVrA6TA2vgA
         zGJecITVybdETChpyDzxGSEtdhrax7XMe5TpDMbXYx7jHdhk4tcqqLMS2PtzGx0pH4ft
         Xm4g==
X-Gm-Message-State: APf1xPBE6whmQQfjsEEt4RaxeHoF9sf4I/3ZDN74O4gh63jsu8Tf/fK+
        FmlRjD7Ock+5FfzG/3LZZTU=
X-Google-Smtp-Source: AH8x2240pqHZO3U+UB5d9TYXdvBIko3UedkUFPT69hmC1c0S5BXYmbrD0GHHdbk6Qe+inMf8w69KIQ==
X-Received: by 10.80.180.210 with SMTP id x18mr14202545edd.126.1519647599236;
        Mon, 26 Feb 2018 04:19:59 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id 33sm8459536edz.37.2018.02.26.04.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 04:19:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] wildmatch: add interface for precompiling wildmatch() patterns
References: <20180225203537.28318-1-avarab@gmail.com> <20180225203537.28318-2-avarab@gmail.com> <CACsJy8Dkq4KCgHtvOt9wmxmSTRUaCPzq9jXRwUvMOEUu7Go3yQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8Dkq4KCgHtvOt9wmxmSTRUaCPzq9jXRwUvMOEUu7Go3yQ@mail.gmail.com>
Date:   Mon, 26 Feb 2018 13:19:57 +0100
Message-ID: <87o9kcdjte.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 26 2018, Duy Nguyen jotted:

> On Mon, Feb 26, 2018 at 3:35 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Add the scaffolding necessary for precompiling wildmatch()
>> patterns.
>>
>> There is currently no point in doing this with the wildmatch()
>> function we have now, since it can't make any use of precompiling the
>> pattern.
>>
>> But adding this interface and making use of it will make it easy to
>> refactor the wildmatch() function to parse the pattern into opcodes as
>> some glob() implementations do, or to drop an alternate wildmatch()
>> backend in which trades parsing slowness for faster matching, such as
>> the PCRE v2 conversion function that understands the wildmatch()
>> syntax.
>>
>> It's very unlikely that we'll remove the wildmatch() function as a
>> convenience wrapper even if we end up requiring a separate compilation
>> step in some future implementation. There are a lot of one-shot
>> wildmatches in the codebase, in that case most likely wildmatch() will
>> be kept around as a shorthand for wildmatch_{compile,match,free}().
>>
>> I modeled this interface on the PCRE v2 interface. I didn't go with a
>> glob(3) & globfree(3)-like interface because that would require every
>> wildmatch() user to pass a dummy parameter, which I got rid of in
>> 55d3426929 ("wildmatch: remove unused wildopts parameter",
>> 2017-06-22).
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  wildmatch.c | 25 +++++++++++++++++++++++++
>>  wildmatch.h | 11 +++++++++++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/wildmatch.c b/wildmatch.c
>> index d074c1be10..032f339391 100644
>> --- a/wildmatch.c
>> +++ b/wildmatch.c
>> @@ -276,3 +276,28 @@ int wildmatch(const char *pattern, const char *text, unsigned int flags)
>>  {
>>         return dowild((const uchar*)pattern, (const uchar*)text, flags);
>>  }
>> +
>> +struct wildmatch_compiled *wildmatch_compile(const char *pattern,
>> +                                            unsigned int flags)
>> +{
>> +       struct wildmatch_compiled *wildmatch_compiled = xmalloc(
>> +               sizeof(struct wildmatch_compiled));
>
> struct wildmatch_compiled *data = xmalloc(sizeof(*data));
>
> ?
>
> It shortens the line a bit. We already use WM_ prefix for wildmatch
> flags, perhaps we can use it for wildmatch structs too (e.g.
> wm_compiled instead)

Thanks, that's better.

>> +       wildmatch_compiled->pattern = xstrdup(pattern);
>> +       wildmatch_compiled->flags = flags;
>> +
>> +       return wildmatch_compiled;
>> +}
>> +
>> +int wildmatch_match(struct wildmatch_compiled *wildmatch_compiled,
>> +                   const char *text)
>> +{
>> +       return wildmatch(wildmatch_compiled->pattern, text,
>> +                        wildmatch_compiled->flags);
>> +}
>> +
>> +void wildmatch_free(struct wildmatch_compiled *wildmatch_compiled)
>> +{
>> +       if (wildmatch_compiled)
>> +               free((void *)wildmatch_compiled->pattern);
>
> Why do make pattern type "const char *" then remove "const" with
> typecast here? Why not just "char *" in wildmatch_compiled?
>
> If the reason is to avoid other users from peeking in and modifying
> it, then perhaps you can move struct wildmatch_compiled to wildmatch.c
> and keep it an opaque struct pointer.

Yes, it's to indicate that "pattern" won't ever be modified. I think
it's more readable / self documenting to have the compiler enforce that
via const, even though it requires the cast to free it.
