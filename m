Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F310EC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 21:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiKPVIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbiKPVHw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 16:07:52 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF001F2C3
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 13:07:15 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id h185-20020a636cc2000000b0046fc6e0065dso14398pgc.5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVZKMLNaI2meXsi8uF7O0sYVw5ktTSfzgwsMOMmLcwU=;
        b=AAXavzpVE30uB3jra7hM0HJBeLuAkmz3wJQYR5d3pGPdbqHuIoqfJ2qpuZxu26QGeG
         S2ouVhBBDzMJIATh1PyEKR3YidCAUTNPURDF6324U83uTF+02IPP9myVTBvl+UvlEO5r
         ZXV1i6nIW+g1dtgJc/oYBPsL4/E/b0CI3BXp8V/jjmIg2vRECy0RMR1bvIE8LELqqilu
         sSpiIantyQ14RRyLyD7NtfocmN7TFjD/+i++sJk/YcoGlSPH1AxpUMsMDEizwEULb6S1
         +fZypGI70QY3p5rfXhL7e6vLrBqg0rrk/EDgNzbnXfJ65dUVTbKVcQxujI81CLT754Oc
         0kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RVZKMLNaI2meXsi8uF7O0sYVw5ktTSfzgwsMOMmLcwU=;
        b=5wCmOmBkUZD0oviLDPdZf06iNJQXQKM1BiJ1LaNXtGagmm8e7FW8wX7IIgVHQ4K+03
         z5obT4DuI+5Fyv5ruKygL8hO4nkNmps7N3HUvKR5VJHX5oKiUFIIGi1C90Jv+5Kc4VWC
         Uc+ACCG/A716ko28/a9Yso4xW+EETn9o5JfvAWWSwpq+X/VR9RAFOY1aAvzNBWkuvZc/
         VZHrl6X4toe9k19Uw2DjXmWQUFGKlt1bxXx9piibEx3fSliinEVSJvUHUNyV4Brch7rc
         YNcP02NZB53tZYckvidy8HJ573z+o7YMahejSBpMA+m1hNn1iCxDpDucJmIdiKzhVJMF
         KYKg==
X-Gm-Message-State: ANoB5plfTD3raxVVD+IOfGpGWP89HLxt8t9mc8r+Sbujqkq7XLBono2l
        YYTKzD4R9tdsPC7W3lgm8CaBOy2cxGjoVg==
X-Google-Smtp-Source: AA0mqf45bD2UaIOqUw9IrI4jQ3GEfhXhEZ77q+ELEK4jMRguIewppaHKPt5o7OnPdwbl5Zft0K1xuzoFYIvI1g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:f284:b0:218:61bd:cfeb with SMTP
 id fs4-20020a17090af28400b0021861bdcfebmr330491pjb.1.1668632834869; Wed, 16
 Nov 2022 13:07:14 -0800 (PST)
Date:   Wed, 16 Nov 2022 13:07:05 -0800
In-Reply-To: <221115.868rkdknmz.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
 <kl6lk03xnm1h.fsf@chooglen-macbookpro.roam.corp.google.com> <221115.868rkdknmz.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lsfiivcau.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 00/10] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Nov 14 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> It's also proposing to replace Glen's one-patch[6], which is working
>>> around the problem shown in the test added in 1/10 here. Per
>>> downthread of [7] I think Glen was aiming for getting a more narrow
>>> fix in case we split off 9/10 here into some later fix.
>>>
>>> As we're fixing an edge case in something that's always been broken
>>> (and thus wouldn't backport) I think it's better to just fix the
>>> problem directly, rather than introducing new "--super-prefix" use,
>>> just to take it away later.
>>
>> I still prefer that we take the one-patch to unbreak new releases,
>> because partial clone + submodules is absolutely broken (e.g. it's
>> already causing quite a lot of headaches at $DAYJOB) and the patch is
>> obviously harmless.
>>
>> And more importantly, it lets us take our time with this series and get
>> it right without time pressure. It's not as pressing as, e.g. a
>> regression fix, but it does render certain Git setups unusable.
>>
>> With regards to urgency and when to choose "small and harmless fixes vs
>> bigger and better fixes", I think Junio has generally made those calls
>> in the past. @Taylor if you have an opinion, I'd love to hear it.
>
> I feel like I'm missing something here. What's the regression? The test
> you're adding here didn't work at all until 0f5e8851737 (Merge branch
> 'rc/fetch-refetch', 2022-04-04), as the command didn't exist yet. That
> commit went out with v2.36.0.
>
> If it never worked there's no regression, and we wouldn't be merging
> down a fix for older point-releases.
>
> Or is there some case I've missed here which did work before, doesn't
> now, but just isn't captured in this test? If so what case is that, and
> when did it break?

Right, this wasn't meant to be a regression fix at all. There's good
reason to believe that this was always broken, so I never went digging
to see if it ever worked.

Even so, it doesn't change the fact that it's a use case that we've
expected to work, but doesn't due to some internal silliness, and that
we could fix it without invoking questions of the "--super-prefix"
design and dragging out the process (which is admittedly what I should
have done in the first place). Since we have such an easy fix in front
of us, I don't feel good about not fixing this before the next release.

At any rate, I'm wiling to accept that I'm being overly cautious,
because it's quite likely that this series will make it into the next
release. (We could technically we unbreak 'next', though I don't know
who distributes that other than internally @ Google.) I'm ok to drop my
patch for now, but I'll revive it if it starts to look like this series
won't make it into the next release.
