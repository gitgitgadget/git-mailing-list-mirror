Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352F6C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 12:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhLIMSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 07:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhLIMSn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 07:18:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95CFC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 04:15:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v1so19065847edx.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kGQS9icuZf5ZXD8k41ZVJdcKiAEwDKNDRXRBqBYev3I=;
        b=d5EZm9yn3xbcCXtpRlzLGSyQqVnmLnkv/Q1stYVGI7AGIrt0c815HsUbi3dkzUjgb3
         KxkO5jRLaL9ug6h6flM/aOw7yPC5rzUz/zYW8DwnY1DiTOkXWdfhzdSn/oQM3u6MreVQ
         TXT3n97bopX0D4q6NoJm1W7Rbdt0za+gfidw3aBVgqfT5j3nanIYGd0zzNEbJ4WtzHH/
         e4M3OZA52vJrW089/JFKIJe1OURny4Mb+8N/Mxl5S7uy96i8S82HekMVFjr0CTtoJf5z
         Z4iHDNCy+EiTLFDQmypn+lR8wCHh8mwiReKk8FTejFrXPeeUiIzpd4XdPANOAZ7w4DIL
         C4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kGQS9icuZf5ZXD8k41ZVJdcKiAEwDKNDRXRBqBYev3I=;
        b=SLymKNlH8dyB8+/SN1H1yF09FBpjKfZttQotx+BlT36ExLXA9g4FRXhcK64ELLr8Ds
         mjMo0rmQcDPfYPmIh7waR04VEW4yqy+11XCQ5Wz0yW1so4rQISaklZRQzMChSU20Tft/
         fDGvSR4N1fEr1uykJAkRx9CaiRpZXuZF1+6h7/Au828+GAheAhojYFh+iZnkCQeUoIub
         QK18yoClOEhFa9iOQTrjTF4UwJ4kYIXqKYCYLack/3P2u8Omx+ehjncaUJS0BlYdod3M
         fIkiTyH0QfKouNobV3ZC8tfYu0BGC52NVMV/ofbhtYfjgrR7eal6e29UYXFESAHT1abo
         cTRw==
X-Gm-Message-State: AOAM532ApWDqb5RPOZt8vrWgbeECceldLta9lhTGkPcxL24Yv8anDvVW
        qPOazGPhXL8lj81QER0BC7Q=
X-Google-Smtp-Source: ABdhPJzmsVs4kEU67q1yvPAZJ2jAiG9NEiSKvec7oiauT8A3/fovoWN6Xj4kLRJ8RBdiT1R+zy9Yaw==
X-Received: by 2002:a05:6402:4249:: with SMTP id g9mr28335471edb.316.1639052107899;
        Thu, 09 Dec 2021 04:15:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bd12sm3519951edb.11.2021.12.09.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 04:15:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvIKI-001ZzW-Iy;
        Thu, 09 Dec 2021 13:15:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] config.mak.dev: specify -std=gnu99 for gcc/clang
Date:   Thu, 09 Dec 2021 13:05:44 +0100
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <xmqqlf0w5bbc.fsf@gitster.g> <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
 <xmqq4k7j68eg.fsf@gitster.g> <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
Message-ID: <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 08 2021, Jeff King wrote:

> On Tue, Dec 07, 2021 at 08:13:43PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> error: ISO C99 doesn't support unnamed structs/unions [-Werror=pedantic]
>> >
>> > Hmm. It's interesting that the regular DEVELOPER=1 doesn't catch this.
>> > It's because we don't specify -std there, and newer gcc defaults to
>> > gnu17 (unnamed unions appeared in c11, I think). I wonder if it would be
>> > helpful to teach config.mak.dev to pass -std=c99.
>> 
>> FWIW, I use -std=gnu99 as our Makefile suggests.
>
> I think the patch below would have detected this both locally for
> Han-Wen, but also in C.
>
> -- >8 --
> Subject: [PATCH] config.mak.dev: specify -std=gnu99 for gcc/clang
>
> The point of DEVELOPER=1 is to turn up the warnings so we can catch
> portability or correctness mistakes at the compiler level. But since
> modern compilers tend to default to modern standards like gnu17, we
> might miss warnings about older standards, even though we expect Git to
> build with compilers that use them.
>
> So it's helpful for developer builds to set the -std argument to our
> lowest-common denominator. Traditionally this was c89, but since we're
> moving to assuming c99 in 7bc341e21b (git-compat-util: add a test
> balloon for C99 support, 2021-12-01) that seems like a good spot to
> land. And as explained in that commit, we want "gnu99" because we still
> want to take advantage of some extensions when they're available.
>
> The new argument kicks in only for clang and gcc (which we know to
> support "-std=" and "gnu" standards). And only for compiler versions
> which default to a newer standard. That will avoid accidentally
> silencing any build problems that non-developers would run into on older
> compilers that default to c89.
>
> My digging found that the default switched to gnu11 in gcc 5.1.0.
> Clang's documentation is less clear, but has done so since at least
> clang-7. So that's what I put in the conditional here. It's OK to err on
> the side of not-enabling this for older compilers. Most developers (as
> well as CI) are using much more recent versions, so any warnings will
> eventually surface.
>
> A concrete example is anonymous unions, which became legal in c11.
> Without this patch, "gcc -pedantic" will not complain about them, but
> will if we add in "-std=gnu99".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  config.mak.dev | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index 7673fed114..d4afac6b51 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -19,6 +19,11 @@ endif
>  endif
>  endif
>  endif
> +
> +ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(COMPILER_FEATURES))),)
> +DEVELOPER_CFLAGS += -std=gnu99
> +endif
> +
>  DEVELOPER_CFLAGS += -Wdeclaration-after-statement
>  DEVELOPER_CFLAGS += -Wformat-security
>  DEVELOPER_CFLAGS += -Wold-style-definition

This approach looks good & the rationale make sense.

I mentioned in [1] that this might be a bad idea because:

    And as you note it's not only that older or non-gcc non-clang compilers
    may not understand this at all, but are we getting worse behavior on
    modern versions of those two because they're forced into some 20 year
    old C99 standard mode, instead of the current preferred default?

But from some short testing of GCC it will generate the exact same
<file>.s regardless of -std=* option, so I think this indeed only
impacts the warnings we'll emit. So pinning this seems to categorically
be a good thing.

A bad thing about this is that we'll explicitly avoid happy accidents
where we start relying on some newer C standard, and discover N releases
later that it was no big deal, and can thus just use that feature.

On the other hand having this means less back & forth churn of adding
such a dependency only to find it breaks on one of our platforms
etc. Overall I think this makes sense, just say'n.

I don't think this needs to change, but FWIW this would benefit from the
same sort of "let's just compile it" step as [2]. I.e. I think you'll
find that we could just check the exit code of:

    $(CC) -E -std=gnu99 - </dev/null

This works on GCC/Clang, and will die on xlc/suncc, and I assume any
other compiler that doesn't grok this. But I think it's better to avoid
a $(shell) here just for that, and any such change can wait until we
have some proper "compile this once and cache it" probing for
config.mak.dev.

1. https://lore.kernel.org/git/211116.86pmr0p82k.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/211118.86lf1m5h1y.gmgdl@evledraar.gmail.com/
