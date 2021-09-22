Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23299C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9D86109E
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbhIVUid (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbhIVUic (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:38:32 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F02C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:37:02 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id 10so2722899uae.10
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YyQU8YwWRWJw9IGMuFUaxX1PMuMFIxO31JgjqzzWOVk=;
        b=dNecQie9AhPgX0JN7ZvOZUaImA4VEDQOUhEfs8Vq3Bk/ZX4ku46HLXVFqxvf9ixJ3j
         ZFlSTf4d7riCih+RhUIi+stHgmnfS5oRUxKzd24egGD070uUmTILPBoisgikBCCwj/dc
         lTXUcbJWglMpOP2us9k6QEdaUNjb0kw3jRO0doQStgZE0Y3TXNVhZ0OOT01KFLgVJ0Uh
         PcvsMlNKrN7xXmi7KQTPvbhRRTtfGkMn+Uca9WH2JE/1SQ1mx9yWR5WzzeTEob7Idl4s
         AZtXdkBSoIBUwaHeKxejLDI1MccOCKM3Q3WNSJh37dc1pHoYN8C7PK2p6Ze1spM1W1Iz
         Duew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YyQU8YwWRWJw9IGMuFUaxX1PMuMFIxO31JgjqzzWOVk=;
        b=A8tZ/Bc/kKk9wmmxvI7BvjlXfonYTGVOhtk3WeVgx2UHxyf1/aRkHrt6EZxxsW/GoS
         RkrxDmNaDPhBN+2MC4PBWOxUGv+AN0JF2E3ctaIdROo87DYRw+trnGGb6rXzdIHlNkw3
         QwSXqXw4QQZ8e/QqL90DztiEwnk7wD7TleITdRn9Zks7nCNjd5eu6cXMsQwC/en9E7Es
         Pdc+pByoGEoHWvpL8DoVmJOe0h/Rm6gRLaXVhC4nH4SoCZ3LCQ+6jeF7K+6pb9K+VQ35
         Jsj/9367Nurk4iltXfxAel1FTSbg0Eu1B2OtyTdkdFXGuehLniYt8YG7ya5ccBtpdeFd
         bI1w==
X-Gm-Message-State: AOAM533qKkmVPmM3kCRe4bUM9YioYLb2jv8J0dWpPbfRkt7xlhN/afTO
        kFUKkjrUGc+6J4VSZihXjUemm3yTRy4OP/a3soI=
X-Google-Smtp-Source: ABdhPJw4vUNR30xa96RS710EqqxH8TnuKyj6Z+HiBha/k29vrrBmqXf46quw+/56YOVgdFS7LYXsD9KOQHqaY2Hu9L8=
X-Received: by 2002:ab0:7c4a:: with SMTP id d10mr1550822uaw.138.1632343021290;
 Wed, 22 Sep 2021 13:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <xmqqmto48ufz.fsf@gitster.g> <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net>
 <xmqqzgs479d5.fsf@gitster.g> <YUuPYDkxjDIvIfwI@coredump.intra.peff.net>
In-Reply-To: <YUuPYDkxjDIvIfwI@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 13:36:50 -0700
Message-ID: <CAPUEspi5B8gQ5XVsgkAFDDrkE+Uo__9dzFm7UTZzCZUeExA=8w@mail.gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with DEVOPTS=pedantic
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 1:17 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Sep 22, 2021 at 11:28:38AM -0700, Junio C Hamano wrote:
>
> > >  ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
> > > -dep_check =3D $(shell $(CC) $(ALL_CFLAGS) \
> > > +dep_check =3D $(shell $(CC) \
> > >     -c -MF /dev/null -MQ /dev/null -MMD -MP \
> > >     -x c /dev/null -o /dev/null 2>&1; \
> > >     echo $$?)
> >
> > I am all for this simplification.  It takes us back to the state
> > before 1816bf26 (Makefile: Improve compiler header dependency check,
> > 2011-08-30).  But I think that is more or less orthogonal to the
> > "you are not supposed to feed an empty compilation unit" issue.
>
> Hmm, my suggestion was off the cuff without digging to see whether we
> used to do something similar. ;)
>
> I do worry a bit that we'd be regressing the case that commit tried to
> fix. OTOH, I'm not sure I understand its commit message. It talks about
> things in CFLAGS being a problem, but it looks like the original (and my
> proposal here) would not look at CFLAGS at all? If people are putting
> stuff into CC that will break when used without CFLAGS, then I feel like
> the answer might be "don't do that". Or are there common situations
> where $(CC) is not expected to behave sensibly on its own?

Yes, the problem was ONLY with the gcc that came in macOS before they
moved to clang and that had a frankenstein set of options which will
prevent people building BOTH fat binaries and doing this header
dependency computation at the same time.

Ironically, modern clang makes his use case even uglier (running on
top of =C3=86var's fix) :

$ make CFLAGS=3D"-arch x86_64 -arch arm64"
fatal error: /Library/Developer/CommandLineTools/usr/bin/lipo: can't
create temporary output file: /dev/null.lipo (Operation not permitted)
clang: error: lipo command failed with exit code 1 (use -v to see invocatio=
n)
fatal error: /Library/Developer/CommandLineTools/usr/bin/lipo: can't
create temporary output file: /dev/null.lipo (Operation not permitted)
clang: error: lipo command failed with exit code 1 (use -v to see invocatio=
n)
Non-zero 1 exit with COMPUTE_HEADER_DEPENDENCIES=3Dauto, set it to "yes" or=
 "no" t

so the test fails, and COMPUTE_HEADER_DEPENDENCIES is disabled, but it
shouldn't and works fine if the test is overridden with
COMPUTE_HEADER_DEPENDENCIES=3Dyes

so by removing the CFLAGS from that test, we will actually be fixing
this use case as well IMHO.

Carlo
