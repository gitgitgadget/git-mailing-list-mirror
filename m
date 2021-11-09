Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E59C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF25B61152
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhKICNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 21:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhKICNH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 21:13:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234BC061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 18:10:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j21so70158226edt.11
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 18:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=hkrCvcHNn5OoOMStmZPvm1FhH1Hl/qDrXJOhqTNecAg=;
        b=bNgPTR9vCBLz1nHCaQUoU1pkFj3Ar3LuAoVLzWRZCyimmho2LOX0yFPacs7vNSU9vO
         zuM7CO+WWRsgF62G80edU3IFFeruJ8qUgICykbkkldmote1t7gMG/oY6yci002Xqod1P
         esov68QlKeqPTRRhuO34RCUEaSiiCYcg1zak+Dtc/qYfSG4KA7IlfU9CUEkmaeCwtI7E
         djc2ERReBJ+9Xp7HprbCcR8AcTikmvptoINC/wpTJYnuDwZS6e6AQi2KREblEmQKIXH2
         giiotFmeheWeR2/enhWbthc5qXcyrkq3RaHOqo0qHKybuBul9bEIymqWaYpZWx3tY6LU
         SC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=hkrCvcHNn5OoOMStmZPvm1FhH1Hl/qDrXJOhqTNecAg=;
        b=Usb3WdIPu1/meWPlG+TPitCDLGyleNgfrLumR9AFzCByGerJt/VWzMbJbousueheAS
         v7Jo92JZV4f7sdL+JSsWIjnt/iQRD0pRc8KcYh4vdLjjH17M83Uom5utvRoBDXZiiBBG
         V8HNiadINA/7iNbfIyxorjAQz2g5iPr5mnXsjxY38kjedCWpt75W1bUbncQYFKCi3btj
         spe/b8vwALtEW12a+XgxaNGpy0JH0ZO46nWUYzCRIbj98vFOBgT4rUxk3bbK0Wqx7JsH
         mRUB5GIjJCfrHZ3ex3ByJr9zrsQrQRaIzo065zD3u+mvQf3HqGWqiRzEOcNNxJ36ceOk
         ABlg==
X-Gm-Message-State: AOAM531/Uv4a+4+Gvqo/uAf2IYvaaGEYwcGNCNNvN0+8fOhLavNsDrd7
        nLp5TLa+QW33qCf3k3JZ3EQ=
X-Google-Smtp-Source: ABdhPJxCIGN9zSYltg3ntAHcU0ozd6Bf1d8s4ItacW52E9m97JCKYhCovD7q6jvOGHa2htGcVtMxFw==
X-Received: by 2002:a05:6402:206c:: with SMTP id bd12mr5044407edb.283.1636423820994;
        Mon, 08 Nov 2021 18:10:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sc27sm8786046ejc.125.2021.11.08.18.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:10:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkGaa-001JPs-30;
        Tue, 09 Nov 2021 03:10:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] grep API: call grep_config() after grep_init()
Date:   Tue, 09 Nov 2021 03:06:22 +0100
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-6.8-933ac853bca-20211106T210711Z-avarab@gmail.com>
 <YYmbTOR+uk7prM8A@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYmbTOR+uk7prM8A@nand.local>
Message-ID: <211109.86a6iedqpf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, Taylor Blau wrote:

> On Sat, Nov 06, 2021 at 10:10:52PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> The grep_init() function used the odd pattern of initializing the
>> passed-in "struct grep_opt" with a statically defined "grep_defaults"
>> struct, which would be modified in-place when we invoked
>> grep_config().
>>
>> So we effectively (b) initialized config, (a) then defaults, (c)
>> followed by user options. Usually those are ordered as "a", "b" and
>> "c" instead.
>
> Do we risk changing any user-visible behavior here? Based on my reading
> of grep.c before and after this patch, I think the answer is "no", but I
> wasn't sure if you had done a similar analysis.
>
> In any case, I think the "bring your own structure" instead of getting
> one copied around is much easier to reason about. Even if we weren't
> accidentally stomping on ownership of the struct before, not having to
> reason about it is a nice benefit.

I don't think we're changing any behavior except the one noted in this
series.

We only set a few config variables, so I thought that was fairly easy to
trace...

> [...]
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 960c7aac123..7f95f44e948 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -288,7 +288,7 @@ static int wait_all(void)
>>  static int grep_cmd_config(const char *var, const char *value, void *cb)
>>  {
>>  	int st =3D grep_config(var, value, cb);
>> -	if (git_color_default_config(var, value, cb) < 0)
>> +	if (git_color_default_config(var, value, NULL) < 0)
>
> This doesn't appear strictly related to the rest of your changes, but
> only serves to prevent the caller-provided data from being sent down to
> git_color_default_config().
>
> It didn't matter before because (a) the caller doesn't specify any data
> to begin with, and git_color_default_config() (or the functions that it
> calls) don't do anything with the extra pointer. Now cmd_grep() is going
> to start passing around a pointer to a struct grep_opt.
>
> But git_color_default_config() still doesn't do anything with the
> pointer it receives, and passing that pointer around is standard
> practice among config.c code. So I don't think that this hunk is
> strictly necessary, and it's somewhat different than the pattern
> established within config.c.
>
> I wouldn't be sad to see this hunk dropped (and in fact have a slight
> preference leaning this way), but I don't mind keeping it around,
> either.

Will either split it up or drop it.

> [...]
>> -/*
>> - * Initialize one instance of grep_opt and copy the
>> - * default values from the template we read the configuration
>> - * information in an earlier call to git_config(grep_config).
>> - */
>>  void grep_init(struct grep_opt *opt, struct repository *repo)
>>  {
>> -	*opt =3D grep_defaults;
>> +	struct grep_opt blank =3D GREP_OPT_INIT;
>> +	memcpy(opt, &blank, sizeof(*opt));
>
> I'm nit-picking, but creating a throwaway struct for the convenience of
> using designated initialization (at the cost of having to memcpy an
> entire struct around) seems like overkill.
>
> Especially since we're just going to write into the other fields of the
> the target struct anyway, I'd probably rather have seen everything
> written out explicitly without the throwaway or memcpy.

It's a widely used pattern in the codebase at this point, see
5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
macro, 2021-07-01) (mine, but I stole it from Jeff King).

As his linked-to compiler test shows the memcpy() is optimized away, so
modern compilers will treat these idioms the same way.

There was a suggestions somewhere that we should prorably move to that
"*<x> =3D <y>" or whatever it was briefer C99 (I think) syntax across the
board, it would be less verbose. But I haven't tested if it's as widely
supported, so I've just been sticking with that blank/memcpy() pattern
for "do init in terms of macro".
