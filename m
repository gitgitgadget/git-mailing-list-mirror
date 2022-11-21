Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B55C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKUTQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiKUTQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:16:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E016F34
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:16:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a1-20020a056902056100b006e6f103d4c1so11932409ybt.23
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57bFs2QLhohC55tjV5/Hv/e/kKd4TCmSc6PIO96a3GE=;
        b=i7EJ9By1EBWiK/KmJdkT5NKYyialgsYC2I+r8csq1LjtWpyJKe4mLelQyDSEZe5gNs
         T53mJiC7WHXoYUX32yvIv/Y4SMHd5j4BCDMPUeu84rjKhqdPMaur3ZQetN0CdH9R8v/k
         LHOi/cUUwz+bsvQ1W+ORtCFUR7Kajnmp16BEKHewYPEgo+7++T35jcbhqVd4Dl5yveMS
         liSQD+GZF50rQjqGSJ+bZbFtTpL3NbqOwKq1H9MkvTFsscNys5ugI5rdv3vXrHbxJohT
         ET/HtxsDK3crn3yPiFQb8mloLSMrqFvHmt9Q+BLBeXit8HKBNyt7v7hPByrIp/wDq/VF
         Chpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57bFs2QLhohC55tjV5/Hv/e/kKd4TCmSc6PIO96a3GE=;
        b=GEmYJUeuL3G8XjPrcd8GMF71zwAu5+FB0SqvPN463Y0dRGMWysC6NrDKVev1KBq6wJ
         DRJ06s6HKvhyFIiWWa+44XfhykMTZinCP9xQem8OEcxdabvbUr1GueTX7cwZZvJji523
         JTynT9HQy5l7lkGX2p3kcavS9TXBWYoSvW//x+HSfk3aZ9mtDEVRFB8hfgsbAJeccjN6
         ll2Yi/5J3xDy8bFpyEuyHv5Aw7damr+zJ4Vlb5VdBW3SCDEx2sFPFynF9bpposMsUWCY
         jxbIPvtUYY5/5nFobVGELYt/QteGxpFfbRbFNunk0etXbAF9dvn8HjtYNlttRW0jb/dN
         BF+Q==
X-Gm-Message-State: ANoB5plyoptwWRtDwsQ5/BlL10nFZkHYuhWyZRpPGmXGP84dedj5QOni
        saRlJ9Z9eXPTU73IhaYP1/7KXZYCihFFgQ==
X-Google-Smtp-Source: AA0mqf6swV2wlkgsjGrisQY4AxPuX2U2LEanQxMlfAzuvu1Xr+pA13eUBQriljl/5nOEAXTyIEQhbTb91W6mAA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:5016:0:b0:6eb:b268:3694 with SMTP id
 e22-20020a255016000000b006ebb2683694mr0ybb.421.1669058179170; Mon, 21 Nov
 2022 11:16:19 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:16:15 -0800
In-Reply-To: <221117.86y1s9h2q5.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
 <kl6lk03xnm1h.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221115.868rkdknmz.gmgdl@evledraar.gmail.com> <kl6lsfiivcau.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221117.86y1s9h2q5.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lzgckdsow.fsf@chooglen-macbookpro.roam.corp.google.com>
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

> On Wed, Nov 16 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Mon, Nov 14 2022, Glen Choo wrote:
>>>
>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>>
>>>>> It's also proposing to replace Glen's one-patch[6], which is working
>>>>> around the problem shown in the test added in 1/10 here. Per
>>>>> downthread of [7] I think Glen was aiming for getting a more narrow
>>>>> fix in case we split off 9/10 here into some later fix.
>>>>>
>>>>> As we're fixing an edge case in something that's always been broken
>>>>> (and thus wouldn't backport) I think it's better to just fix the
>>>>> problem directly, rather than introducing new "--super-prefix" use,
>>>>> just to take it away later.
>>>>
>>>> I still prefer that we take the one-patch to unbreak new releases,
>>>> because partial clone + submodules is absolutely broken (e.g. it's
>>>> already causing quite a lot of headaches at $DAYJOB) and the patch is
>>>> obviously harmless.
>>>>
>>>> And more importantly, it lets us take our time with this series and ge=
t
>>>> it right without time pressure. It's not as pressing as, e.g. a
>>>> regression fix, but it does render certain Git setups unusable.
>>>>
>>>> With regards to urgency and when to choose "small and harmless fixes v=
s
>>>> bigger and better fixes", I think Junio has generally made those calls
>>>> in the past. @Taylor if you have an opinion, I'd love to hear it.
>>>
>>> I feel like I'm missing something here. What's the regression? The test
>>> you're adding here didn't work at all until 0f5e8851737 (Merge branch
>>> 'rc/fetch-refetch', 2022-04-04), as the command didn't exist yet. That
>>> commit went out with v2.36.0.
>>>
>>> If it never worked there's no regression, and we wouldn't be merging
>>> down a fix for older point-releases.
>>>
>>> Or is there some case I've missed here which did work before, doesn't
>>> now, but just isn't captured in this test? If so what case is that, and
>>> when did it break?
>>
>> Right, this wasn't meant to be a regression fix at all. There's good
>> reason to believe that this was always broken, so I never went digging
>> to see if it ever worked.
>>
>> Even so, it doesn't change the fact that it's a use case that we've
>> expected to work, but doesn't due to some internal silliness, and that
>> we could fix it without invoking questions of the "--super-prefix"
>> design and dragging out the process (which is admittedly what I should
>> have done in the first place). Since we have such an easy fix in front
>> of us, I don't feel good about not fixing this before the next release.
>>
>> At any rate, I'm wiling to accept that I'm being overly cautious,
>> because it's quite likely that this series will make it into the next
>> release. (We could technically we unbreak 'next', though I don't know
>> who distributes that other than internally @ Google.) I'm ok to drop my
>> patch for now, but I'll revive it if it starts to look like this series
>> won't make it into the next release.
>
> Understood, I'm re-rolling this v2, will send it out soon.
>
> I'll keep that patch out for now, but if we're starting to run up
> against the next release how about we split it out? So it'll depend on
> how fast we can review & test this, and if/when Taylor is OK with
> merging it down.
>
> I really don't care if the fix comes first, but just thought I was
> missing something and it didn't seem urgent, as it was in the "never
> worked" and not "a regression" category AFAICT. But if you'd still like
> it shout, and I'll just stack it at the start...

That sounds good, thanks :) That's very helpful of you, and I appreciate
you making the way forward clear.
