Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB1591F597
	for <e@80x24.org>; Wed,  1 Aug 2018 07:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbeHAJBC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 05:01:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40976 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733123AbeHAJBC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 05:01:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so6213243edr.8
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 00:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AUltqlsGVFx0cJLuRjRyxkNW9r2N0WzdBpfYOjH9tjU=;
        b=T1hKgj9pTi0xQhEAkzeM3YQMOGneZHMzePUQZYxSRz/WnYg2deQKiFLZP2MTeqVhy/
         hEONQ0onZU4P7Ii2uCWtfuVCRn+h/S64nHXY8AzJWVY1GacH/F4XAsPNYyc/MY3p2auk
         RUcHGU/TvJP1RkOH3dxPL1eYR2Oo/lD0HlMrvM+6991Kp8y8F3WqKYqVP3rlZ7Tryu5R
         P67q6+fyXOEUjeem8363tTEcBDw+qG4mYJF/eb/lrWvczzpYri6+K1zSNh2sVvd3yMpL
         MgZVDIK0GNrpdyhcVuFsOEGpvyjbeMTfKeEftcx3B8HQRXJjhXd2VCbPuP7X6IVKieF+
         FvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AUltqlsGVFx0cJLuRjRyxkNW9r2N0WzdBpfYOjH9tjU=;
        b=hFtAeuncxgIc2cOzm9WFsQm4KXweQEK3A7DswhpRbyGzP2gbsiyWgzyC984FIFxbd+
         tqUP/YztGL9AOwc4T6WyU5AHsKzU5wMyNM3ZvDqAuWuNh8HYAvHC7It/TO6k1GnhNZZl
         7U4NxiWbhWXW9ngdxDqI5TWhZboEWS+GGC8GxBRwryQ+5zqntwajHW0Pw2cF3jIe093o
         sUCDWljPp4/Fw0t6Ds7ltezx8aM3DniNG8khc6dcfQSLTuiFXfRAbgDi0od+hSEWuWNh
         WW8Asmn2d/6C9j2Ujg9febLgODSrqk/hnmyN9O9GxOFMYEFkIANh3XCmLiEIiBJncl2s
         M4Uw==
X-Gm-Message-State: AOUpUlH4Myk40bV6MXm2OEkeNGqA1WfOo6NYkfW2zwaUrTi1kMpOJmBE
        pu4Z+GD5RVxZLK5Tywwp3/Y=
X-Google-Smtp-Source: AAOMgpeZ8/tI6boJyIMKU2zi1uCHj70AuzeRSfcbzK8g6awWalRCSPBC2iuCWCk2nu47HnRn6ULTYQ==
X-Received: by 2002:a50:ba6e:: with SMTP id 43-v6mr2765048eds.292.1533107805601;
        Wed, 01 Aug 2018 00:16:45 -0700 (PDT)
Received: from evledraar ([5.57.20.50])
        by smtp.gmail.com with ESMTPSA id u2-v6sm4199020eds.43.2018.08.01.00.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 00:16:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael <aixtools@felt.demon.nl>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: Is detecting endianness at compile-time unworkable?
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
        <20180729181006.GC945730@genre.crustytoothpaste.net>
        <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
        <20180729192753.GD945730@genre.crustytoothpaste.net>
        <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
        <20180729200623.GF945730@genre.crustytoothpaste.net>
        <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
        <87wotdt649.fsf@evledraar.gmail.com>
        <xmqq600wkc4i.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq600wkc4i.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 01 Aug 2018 09:16:43 +0200
Message-ID: <87pnz2tv38.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 30 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> And, as an aside, the reason we can't easily make it better ourselves is
>> because the build process for git.git doesn't have a facility to run
>> code to detect this type of stuff (the configure script is always
>> optional). So we can't just run this test ourselves.
>
> It won't help those who cross-compile anyway.

I was being unclear, what I mean by having "a hard dependency on some
way of doing checks via compiled code in our build system" is that we
would do some equivalent of this:

    diff --git a/Makefile b/Makefile
    index 08e5c54549..b021b6e1b6 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -1107,7 +1107,7 @@ DC_SHA1_SUBMODULE = auto
     endif

     include config.mak.uname
    --include config.mak.autogen
    +include config.mak.autogen
     -include config.mak

     ifdef DEVELOPER

And document that in order to build git you needed to do './configure &&
make' instead of just 'make', and we'd error out by default if
config.mak.autogen wasn't there.

Now obviously that would need some sort of escape hatch. I.e. you could
invoke 'make' like this:

    make CONFIGURE_MAK_AUTOGEN_FILE=some-file

That's how you would do cross-compilation, you'd arrange to run
'./configure' on some system, save the output, and ferry over this
'some-file' to where you're building git, or you would manually prepare
a file that had all the settings we'd expect to have been set already
set.

Now, whether we do this with autoconf or not is just an implementation
detail. Looking at this some more I think since we already use the
$(shell) construct we could just have some 'configure-detect' Makefile
target which would compile various test programs, and we'd use their
output to set various settings, a sort of home-grown autoconf (because
people are bound to have objections to a hard dependency on it...).

> I thought we declared "we make a reasonable effort to guess the target
> endianness from the system header by inspecting usual macros, but will
> not aim to cover every system on the planet---instead there is a knob
> to tweak it for those on exotic platforms" last time we discussed
> this?

Yes, but I think it's worth re-visiting that decision, which was made
with the constraints that we don't have a build system that can do
checks via compiled code, so we need this hack in the first place
instead of things Just Working.

And as I pointed out in the linked E-Mail this also impacts us in other
ways, and will cause other issues in the future, so it's worth thinking
about if this is the right path to take.
