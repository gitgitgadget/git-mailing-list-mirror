Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EC8C433E9
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6478F22955
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 19:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbhAJTAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 14:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJTAe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 14:00:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F481C061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 10:59:53 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id 6so21662621ejz.5
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=i+lD6FSz6C6CcS1qvX7K+HoNahqvN0C/96/m6mZa/Zo=;
        b=E8hna3J5s/r/rqS+7gfr6R/9jX+aSBsuFBVFSQJ0pXOoybetyWj98Uak3KjM5uc+ds
         qY9h9dIwI5w2FMW5/XijnjlZ+dBNoAv5qyWddq+YXXYITx75axushL06qr0Fcbgig+6Q
         0WCCrQ9IbxQVXyFGbVLMA7djJVM+dKOQWtEKsHyN3EHBJ7bBhYB83l4/BD4RAypNG3iV
         mriOiSkzkUn+sTqRyY7dh4C294/RUOtYZqmuhYUt6H7EmWmQ/nU7/Ou0u/JrFxd++qjb
         h1GQxP2gz2eeQNkmzBDQc2BQsCcb+s78JBtTOYhKB/kp+yctSVXFpm61T5iKLusT0lGY
         LqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=i+lD6FSz6C6CcS1qvX7K+HoNahqvN0C/96/m6mZa/Zo=;
        b=aBnwmSwtZcTWSXbtZ8WNdnqP1JamDXyLJ/6Tt2UPU7kAtEDntynCgEu1lQVZCboImw
         hx0fnQLNzgZnMJbsr7wirym7UbavwvQfXZrwxqs3bb+zv2SQNYJJhBPbu0LxaErXyrvm
         v8zhzxV+0RECA2Mt0zX85NftS+CZ3a6Fuzeu8crjvz8qKAbDR4qx707duywDxyXbTRhq
         7y84Sd0s3/08nY4b16gmTkY/aqO5dyRGqkoQOfg5OlQwOjTPJFk0n2PQ647TswDaiIVm
         4lnVpwVCDABasxGGJx3bM2nwL6nzw7HL6bxHghtk0rV55oZZyB0s0r4TSr3xa0X13KrX
         UacQ==
X-Gm-Message-State: AOAM532cZuExs+8fw/vWW+0al/1xrZnSg2MSNggdpoBY4Y5tN4bsc+wt
        Mw0Vzs/XwMUyQ5sJrEXOBLs=
X-Google-Smtp-Source: ABdhPJzHSYfpWPFoT14TNVNxj2tnxQcNoWiiVDMAgLpS3JhVCqSkdDAHV4QjZhYrlgy5VW8kqwRLsw==
X-Received: by 2002:a17:906:7a46:: with SMTP id i6mr8237488ejo.257.1610305192225;
        Sun, 10 Jan 2021 10:59:52 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id gl23sm6053302ejb.87.2021.01.10.10.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 10:59:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Should you use test_i18ngrep or GIT_TEST_GETTEXT_POISON=false?
References: <20201223013606.7972-1-avarab@gmail.com>
 <20210105194252.627-13-avarab@gmail.com>
 <20210110132155.GT8396@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20210110132155.GT8396@szeder.dev>
Date:   Sun, 10 Jan 2021 19:59:50 +0100
Message-ID: <87y2h062jd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 10 2021, SZEDER G=C3=A1bor wrote:

> On Tue, Jan 05, 2021 at 08:42:41PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> The verify_object() function in "mktag.c" is tasked with ensuring that
>> our tag refers to a valid object.
>>=20
>> The existing test for this might fail because it was also testing that
>> "type taggg" didn't refer to a valid object type (it should be "type
>> tag"), or because we referred to a valid object but got the type
>> wrong.
>>=20
>> Let's split these tests up, so we're testing all combinations of a
>> non-existing object and in invalid/wrong "type" lines.
>>=20
>> We need to provide GIT_TEST_GETTEXT_POISON=3Dfalse here because the
>> "invalid object type" error is emitted by
>> parse_loose_header_extended(), which has that message already marked
>> for translation. Another option would be to use test_i18ngrep, but I
>> prefer always running the test, not skipping it under gettext poison
>> testing.
>
> This is fairly unconvincing.  Why do you prefer it that way?  What is
> so special in these tests of 'git mktags' that could possibly warrant
> this special treatment WRT gettext poisoning, as opposed to the other
> ~1500 invocations of test_i18n{grep,cmp}?

You prodded me about this and Johannes also did off-list. So given that
this is already in "next" I think it's best to let usage in this mktag
series land as-is.

I promise I'll follow-up with something to (at least start to) fix this
generally one way or the other on "master" after that. It's a trivial
part of this particular series.

I.e. either document & migrate away from test_i18ngrep (mostly, in some
cases it's still convenient), or git rid of this and the few existing
GIT_TEST_GETTEXT_POISON=3Dfalse uses.

Anyway, as both the initial author of this poison facility & of its
current runtime incarnation in git.git, some context on it:

The need for test_i18ngrep was always a wart. When I submitted the
initial i18n patches a big selling point at the time to a (rightly so)
skeptical audience on the Git ML was that it could almost entirely be
turned off at compile-time, and that we had something in place to make
sure we didn't introduce plumbing bugs by overtranslating.

For a while the mass-i18n patches were about as noisy on-list as the
sha256 conversion patches were in more recenty memory.

So if you look through the history you'll see that first we skipped
whole tests with the C_LOCALE_OUTPUT prereq, and then test_i18ngrep was
a more granular way to do that:

    git some-command >output &&=20
    test_i18ngrep "c locale string" output

But since 6cdccfce1e0 (i18n: make GETTEXT_POISON a runtime option,
2018-11-08) this hasn't been needed. But yes, we have a bit under 10
years of test_i18ngrep usage in the test suite now.

But that stuff is the wart, and purely a historical artifact of this
having once been compile-time only. We don't do this sort of thing with
any other GIT_TEST_* option, e.g. we have tests like:

    t/t5512-ls-remote.sh:   GIT_TEST_PROTOCOL_VERSION=3D0 git ls-remote --s=
ymref --heads . >actual &&
    t/t5512-ls-remote.sh-   test_cmp expect actual &&

Not:

    t/t5512-ls-remote.sh:   git ls-remote --symref --heads . >actual &&
    t/t5512-ls-remote.sh-   test_protocolv0cmp expect actual &&

Because that doesn't make sense. If we know we're testing protocol v0
here why wouldn't we just pass that as a parameter in the test? Same for
GIT_TEST_GETTEXT_POISON=3Dfalse.

But yes. looking at e.g. po/README now I dropped the ball on following
through with some documentation etc. about this at the time.

I have also wondered if a better approach at this point isn't to just
remove the thing entirely. We're just doing incremental i18n-ization at
this point, so the odds that it's catching accidental plumbing
translations is rather low compared to 2011-era git.git.
