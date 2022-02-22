Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44414C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiBVKWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiBVKWi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:22:38 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B27F6C4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:22:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i11so34016974eda.9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SSGO8LodzMyckp9vxgELSiLDvPrOKP7OamO6MjyhdR0=;
        b=C1QVNABctHo68nbeb/Tvm3fGPpvhebzrFsUTNu/F94aU81cDhD87gM8k3fz7wXz7g7
         pUGcxLCi3Rud8nzbrotReDbv7M0a0zG5SaT4jfI9gAHsO60PkchpVAHOUEWk7ge17Dmp
         j8JqfP9TgTg1h5eauBNG65hBHK4leGceN5lcdqG20/iPd5RRs+OSz+2Q63ls1VB7Mq6T
         2T4mt7H4Y8696lo6f5f+xuCGckAwXZC9/dN5Yn1joJknfNIiHKUD+B5qTmZswbF5+J+o
         LXmpm5Tw9WdBqMzU7MOpOFWpoqDfQmjKtEFvUyvDNOjaH5GQD4pHgCMTL3V4FcpB/tkN
         Nr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SSGO8LodzMyckp9vxgELSiLDvPrOKP7OamO6MjyhdR0=;
        b=sM1TFoYGk2T/aZ/KrEcQHrVIS83oISntBsimAFbmQt0+leMHTk1OR9hpFZOF0VOxDF
         qT4IO74vHwAQJyZf/faVeCiCQmxwEUztnwBnqBGwfbRBWmIJtiOFKZi52pH+Xwj8cY/g
         2OwPkNX+S44NTW3t2pJRqGwJizGAqmuCoaQQwi6c0cTJwbCijNCCjRlhPB4K2G7u251M
         W+9ANKwB2GSGug0V8GAdT6O8DBC6ZLWaKW05er32OaD5aWyUxMxYHUEyNbAb+RNzdaj/
         h8TnWCp1a6br4Q/RGY/1lnDm65toRj2wfAsGURA+FJtyv84sIh2v154j2aO7qJz9vF8G
         Nikg==
X-Gm-Message-State: AOAM531CtJYFD/rOJ0ImMz6eN/7Fm6A4SVsmYv43gskpnwCxUpQtjP5B
        50bn0I0QrdbwUUEXqn9i+Cq2HuqivyXgmiJY
X-Google-Smtp-Source: ABdhPJyw1PoRTqE0HpJDbxylVY9cDnOXS6C7+cX2QV/cF9bZWLClipkvd4h5gz2VAW/ZRNw14A5ujg==
X-Received: by 2002:a05:6402:1cae:b0:410:d3ae:3c8a with SMTP id cz14-20020a0564021cae00b00410d3ae3c8amr25077428edb.215.1645525328533;
        Tue, 22 Feb 2022 02:22:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i24sm6076603ejg.40.2022.02.22.02.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:22:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMSJ5-005wnr-9L;
        Tue, 22 Feb 2022 11:22:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
Date:   Tue, 22 Feb 2022 11:14:17 +0100
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
 <patch-v3-3.4-b03ae29fc92-20220221T155656Z-avarab@gmail.com>
 <YhPL+wSxtI0KIz07@nand.local>
 <220221.868ru4avw6.gmgdl@evledraar.gmail.com> <xmqqee3vwepd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqee3vwepd.fsf@gitster.g>
Message-ID: <220222.86o82z8als.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Sorry to notice this so late, but this hunk caught my eye. What happens
>>> if `TEST_DIRECTORY` is provided by the user (and doesn't end in "/t")?
>>
>> I think that the preceding 2/4 should cover your concern here, i.e. I
>> think that's not possible.
>>
>>> Before this change, we would have set GIT_BUILD_DIR to the parent of
>>> whatever TEST_DIRECTORY is, whether or not it ended in "/t". We'll still
>>> do the same thing with this patch if TEST_DIRECTORY ends in "/t". But if
>>> it doesn't, then we'll set GIT_BUILD_DIR to be the same as
>>> TEST_DIRECTORY, which is a behavior change.
>>
>> Indeed, but I believe (again see 2/4) that can't happen.
>
> It is not like "can't happen", but "whoever wrote the TEST_DIRECTORY
> override logic did not mean to support such a use case".

To clarify with "can't happen" I mean (and should have said) that "can't
work", i.e. it would error out anyway.

E.g. try in a git.git checkout:
=20=20=20=20
    (
        mv t t2 &&
        cd t &&
        ./t0001-init.sh
    )

It will die with:
=20=20=20=20
    You need to build test-tool:
    Run "make t/helper/test-tool" in the source (toplevel) directory
    FATAL: Unexpected exit with code 1

And if you were to manually patch test-lib.sh to get past that error it
would start erroring on e.g.:

    sed: couldn't open file /home/avar/g/git/t2/../t/chainlint.sed: No such=
 file or directory

And if you "fix" that it'll error out on something else.

I.e. we'll have discovered that $(pwd)/.. must be our build directory,
and we then construct paths by adding the string "/t/[...]" to that.

> I am perfectly fine if we declared that we do not to support the use
> of that override mechanism by anybody but the "subtest" thing we do
> ourselves.  If we can catch a workflow that misuses the mechansim
> cheaply enough (e.g. perhaps erroring out if TEST_DIRECTORY is set
> and it does not end in "/t"), we should do so, I would think, instead
> of doing the "go up and do pwd", which will make things worse.

What I was going for in 2/4 in
http://lore.kernel.org/git/patch-v3-2.4-33a628e9c3a-20220221T155656Z-avarab=
@gmail.com
is that we've already declared that. I.e. test-lib.sh has various
assumptions about appending "/t/..." to the build directory being a
valid way to get paths to various test-lib.sh-adjacent code.

So trimming off "/t" here with a string operation v.s. $(cd .. && pwd)
is being consistent with that code.

It would be odd to make the bit at the top very generic, only to have
the reader keep reading and wonder how that generic mechanism and the
subsequent hardcoding of "/t/[...]" are supposed to work together.
