Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A29FC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 03:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4931B61078
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 03:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhHGDBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 23:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhHGDBE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 23:01:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A51BC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 20:00:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id go31so18385837ejc.6
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 20:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+TH6G0ncUbEuRmB6Eum9ZMgq5f6QnQbvbBoyc27Pedg=;
        b=oRzrOHjHT1j4FhaAexNgV1zQn/f/jQpmEHPeaakKyCuGuKIl+CzClPWt2ndKzfd+9p
         msZDSlWKXmdoRB3DEfiOMR4pAnWesKipj725vPRGxKqEN6Gdzgpcc+GOmiQFt2id+5/I
         OgL47z4LH0Q6zCxucvYG7/nLMXcutVIbodblCX9Xdggh6cRLO2zE94YF0KikaNB0k3Kk
         4erKYXw9qUHqbA0uA4WVXzV+jkKXUBty23taHR3+c6LLtPtmnNkO77pkF7V0ahQql2MJ
         pDVmoDI1jZ22xH04He74UrqFFr5XBWkwyjl/UYnzR5m4hmsPEyPZtAgCyniF8Cz8LOpm
         wVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+TH6G0ncUbEuRmB6Eum9ZMgq5f6QnQbvbBoyc27Pedg=;
        b=iw/6bnBQhgCX3MHww6NZ1V1Rnywhf8HKRpGieJ57o5ZJycEFnFIEgp4FMRNKl+6qQr
         xkwelohMdsQeeiTa1Ac1E7wqS9r7rmje8PGlqCMkGOn55qTNmRCb9RhSxdLtgALWd377
         a7MJ8LQl8qmL18v+VonMU83bUZiD9xuOUlw2Gbfxgsgn5A3K0FvVlXgh8x4VIS573YKt
         MbzBzm111woRQQvVpVcQLvZkdR0fb1cD3pVUyvx2xqp0IMLtZYIdKT5SyaxQcank2Ol0
         hWdGpzZsrnC8Jk723khfH6Ius6HyLdC/AvzBryzyJsN/Zuzy1fGME7E//ByQaRMSXuHE
         7YnA==
X-Gm-Message-State: AOAM533w5R/j9cCSEFGvt0KCRidVpt0atXqM+OYsBgb0wNNRoyKxGEp9
        4vH6ftFhF9x4A7yHKA+/YZM=
X-Google-Smtp-Source: ABdhPJwzn2kmPRPP/uqTuwCk/n2oTu8FtNswo+d53cn452AvVmZZndsKrOHcGhl1o2hzpbMN5aMrkw==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr12059753ejc.99.1628305246631;
        Fri, 06 Aug 2021 20:00:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s2sm4128794edd.69.2021.08.06.20.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 20:00:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 0/3] detect-compiler: clang updates
Date:   Sat, 07 Aug 2021 04:56:04 +0200
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
 <87bl6aypke.fsf@evledraar.gmail.com>
 <YQ3suvJfspzRNPL9@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQ3suvJfspzRNPL9@coredump.intra.peff.net>
Message-ID: <875ywiyn4y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 06 2021, Jeff King wrote:

> On Sat, Aug 07, 2021 at 04:02:45AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Perhaps I've missed some obvious reason not to do this, but why are we
>> parsing the --version output of two modern compilers, as opposed to just
>> asking them what type/version they are via their usual macro facilities?
>> I.e. something like the below:
>
> That would probably work OK in practice, but it actually seems more
> complex to me (how do other random compilers react to "-E -"?

We only care about gcc and clang in that script, which I think have
supported that form of "-E" on stdin input for any version we're likely
to care about for the purposes of config.mak.dev. It seems unlikely that
we'll care about non-modern compilers in config.mak.dev, so using more
modern features there seems fine (it's all for opting us into even more
modern warning flags and the like...).

> Is it possible for us to get other output from the preprocessor that
> would confuse an eval?).

Probably, I just meant that as a POC. We could pipe it into some
awk/grep/cut/perl or whatever that would be more strict.
