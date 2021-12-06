Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F566C4332F
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhLFQUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387358AbhLFQUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:20:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F12C07E5C3
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:16:25 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so45393652edv.1
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eBv6kLS0QqA/KgrOvgo8mcnixBbLiwBOGyYSYRfwRb8=;
        b=FhmL2yYeKxcnLDGK3QCucnICmXsmzEAX2WPC0hqDYFGfQ8VJNB+gZwhr+PdHRj5otR
         MbdAeSSW7Cno2MizMJ7T5LUlddeUA+sPtYSNhKd01GoPVYUSK1o6r7pFAMUwMVYUYxse
         M2eif9xRWcO4oWLByo932ECzyw4icTqV4OiiPc6xrCMEnH2nYjsck9O8vuU/6LlQO0DK
         5ORXQNz6VGQm3TWRnqk24M5PH+zkDwAKXxeMy3GQespUTuVEAFp7cHSokvCygIEONvHr
         4aLDnihyMIqAEsODEoDyZO9DCH1NuWUafVuNnG6rfM+RKCKW2/0mhZJWQ1ZzejvsXbSv
         BLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eBv6kLS0QqA/KgrOvgo8mcnixBbLiwBOGyYSYRfwRb8=;
        b=wDdst2gxVLEyCrC0x1MyYMb7AxKYRTPYIsN5DeWHb7Bq29WA20pluIqIuQEuzua9xA
         D+YHe5e0TIj3tbL4zcrxBeBRQIOLfz7h1J9+A587AUVB9fCkEOiSgRudC03rQGNo3opF
         T4xafcX7BtkQuX+PVaRwveO9nlKrOl//Pl0n19Ns5Hvp2Srbd82jf0twu5juYbm8N0Ww
         j8664W1SUpJlCnWbdS9cBtRwB1TBvtaEpUWKcTuoPlerUDSlqA0R+whjWGJ+EyxJUAt7
         7vHvO9diK93fyFoxrfFt9kG9jD5UXp6ci9LSSLnvqWRPArlAol3/4B1qLBAJs0g9xuNN
         IFLg==
X-Gm-Message-State: AOAM5324hfUKNbMEuTIIKPqxkyFiurvdpZBNppAlp0FZLvhrcqMywFdg
        xmwPxk8nPvH/7Ga5qW0BTOhSkTgGb5pkbQ==
X-Google-Smtp-Source: ABdhPJw0bcbFzST0SuFmfXX1Invy9eeb52H+sZqbYB+ITKcj20iiNrUIZKf1Dadm4brMqRtrTBpyNg==
X-Received: by 2002:a17:907:e8e:: with SMTP id ho14mr47027746ejc.12.1638807383689;
        Mon, 06 Dec 2021 08:16:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y17sm8806200edd.31.2021.12.06.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:16:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muGf8-000pMj-Ob;
        Mon, 06 Dec 2021 17:16:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>, meta@public-inbox.org
Subject: Re: Large delays in mailing list delivery?
Date:   Mon, 06 Dec 2021 17:12:57 +0100
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
 <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
 <20211203202427.o575sgrx4auqkmjp@meerkat.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203202427.o575sgrx4auqkmjp@meerkat.local>
Message-ID: <211206.867dchr9nt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Konstantin Ryabitsev wrote:

> On Fri, Dec 03, 2021 at 09:02:48PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> When I've experienced delays (sometimes of half a day or more) both
>> https://public-inbox.org/git/ and https://lore.kernel.org/git/ have been
>> updated.
>
> Btw, you can source lore.kernel.org straight into your gmail inbox. :)
>
>     https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
>     https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
>
> Or, you can read it via nntp://nntp.lore.kernel.org/.

[CC'd meta@public-inbox.org, probably best to move this thread over
there sooner than later, but CC'ing git@ still in case this is
interesting to others]

I poked a bit at setting this up but couldn't find from building
public-inbox.org & trying to page through the docs how I'd get from an
existing public-inbox.org/git/ checkout to a local Maildir.

If you could share some recipe or a pointer to the right docs for that
that would be much appreciated. Thanks!
