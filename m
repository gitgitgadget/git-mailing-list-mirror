Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C8C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2833611EF
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhHUIVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUIVD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 04:21:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E0C061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:20:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r19so17458119eds.13
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=W76K4g6ec/2wFPM1+I8DqKnCKrNePwcWZ7EB/yL0dus=;
        b=hBK7jKOilK4StBOuv2mF6ouD2FDQTTu0h5NOtJWZ79c+VKJxlNOcGUFuPnSWh4KgaO
         a5eQ/nxya2MM/YQvpehUMVLjssU2AEFx07PswWRZi3WBRT1h9qpmljydSKxt+pqvDuwf
         fGUuEqB9OpXtd8zWC6m5rDzCfymNR1kl8tplHl6YvC8OQRX9+ICKc5oKxYQzBx3RNgQF
         UUykMLDV2ZyNPD++I5ABinYb3fNkOltTVwcTUtMJ9sH/wlPAl9Yx5+2NaUtE0AkRrerp
         0gjzax6B5YCLz95pfTQPM3R8MFxNh9BRoGKWGoLXg9VRhGiDCGfcevCuy/raCvSLxikd
         9EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=W76K4g6ec/2wFPM1+I8DqKnCKrNePwcWZ7EB/yL0dus=;
        b=M1VofDS97JHxPoRQkJfHZAO/bTINTOVssWVlDXDjnoRbtwHw3QsS4Y6EVmTQCkM2v4
         wQ0eAn/6FQkjuJDr0L5WOWM2udnA0zGoXJ9VJWcOf0U3laaSEV/6HTAFrdY+azZvSpa5
         aCnR570OD8xFovuzgLyyw+BsN+HMWOKK3is/iPvnJUmA+2OfGuASSWRJ/k3LlZ/FYdlD
         aGRp2uWLuQAUXaEMYuYwo4QgqC3/Ev9syQWJqoAY9XVsoHws/0kjx6Z5a0SqHk53bKCT
         ef8A12QUcl8ssr6nz9d41mMUfWkZl+jxJ3JBrzxlideTuNNCwE097uIMwHYKLewlmQKu
         5zaQ==
X-Gm-Message-State: AOAM531PsxrqLfAmQS50p6AH113nXVUBviNPc6/+ZLbRXQStAcLiTxFb
        bHocep0hEvU9qXwtWHep10Y=
X-Google-Smtp-Source: ABdhPJzq+vCHw3JYOtkWL7O39sXA/eOTDD4WquobQaUy6kaVtWZm1Lf809aan5AcHx1JeIA9Lj1tSg==
X-Received: by 2002:a05:6402:215:: with SMTP id t21mr26756927edv.68.1629534022309;
        Sat, 21 Aug 2021 01:20:22 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m18sm4978657edr.18.2021.08.21.01.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 01:20:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: Giving priority to the reftable topic    (was Re: What's
 cooking in git.git (Aug 2021, #06; Mon, 16))
Date:   Sat, 21 Aug 2021 10:17:06 +0200
Message-ID: <87a6lbgqey.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

References: <xmqqv945ng61.fsf@gitster.g> <xmqqtujkwsu0.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqtujkwsu0.fsf@gitster.g>

On Thu, Aug 19 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * hn/reftable (2021-08-16) 25 commits
>>  - t1404: annotate test cases with REFFILES
>>  ...
>>  - hash.h: provide constants for the hash IDs
>>
>>  The "reftable" backend for the refs API.
>
> As discussed in the thread that leads to [*1*], this topic has been
> blocked by the "clean-up errno use in the refs subsystem" topic for
> too long.  I think it deserves to have its own chance to be looked
> at by more eyes.
>
> I've reverted the three topics around "errno" out of 'next', while
> rebasing them into a single strand of pearls, and queued them near
> the tip of 'seen'.  The hn/reftable topic is merged into 'seen' 
> earlier then these "errno" topics.
>
> 'seen' that has this topic, without merging known CI breakers (the
> three "errno" topics are known to break when they are with the
> hn/reftable topic, and the "builtin fsmonitor" also breaks CI),
> passes the usual tests [*2*], except for the "pedantic" test we
> recently added [*3*].
>
> The breakage flagged by the compiler are all:
>
> 	char *fn = get_tmp_template(__FUNCTION__);
>
> where the code expects that __FUNCTION__ is unconditionally
> available.
>
> With that problem fixed (which I would imagine should be easier than
> brain surgery), we should be able to move the topic lower in 'seen',
> hopefully touching 'next' soon to give it a wider exposure.
>
> And when hn/reftable gets stable enough, the "errno clean-up" topic
> can perhaps be rebased on top of it to work better together.
>
> Thanks.
>
>
> [Reference]
>
> *1* https://lore.kernel.org/git/xmqqbl5syhiu.fsf@gitster.g/
>
> *2* https://github.com/git/git/actions/runs/1148914175
>
> *3* https://github.com/git/git/runs/3377289487?check_suite_focus=true#step:5:639

I sent the following yesterday in the GMail mobile app as
<CACBZZX41gwo=pv_4fn2VcLz0Qq7Av-CWsnNXfXSuzmwZnu-Q3w@mail.gmail.com>, I
did not have laptop access (vacation, back now), so it was rejected due
to inline HTML. Re-sending it here for the list's benefit:
    
    (In the Gmail app, so this'll probably not make the list, sorry, feel free
    to quote it)
    
    I've been on vacation for a couple of weeks, am back Monday.
    
    I haven't been able to look at these breakages in detail but it looked like
    there was a fix-up plus a logic error in reftable in combination with it
    with the now dead NULL parameter, perhaps something else I missed. I've
    only skimmed the list.
    
    I had a subsequent fixup topic ready on top to remove that parameter, can
    include in in a reroll. Then the segfault will be caught at compile time
    via a signature check.
    
    As I noted on list before we can do it with reftable first if you'd like,
    but I don't think the end result will be easier to review or should be fast
    tracked. We'll have the same questions about how reftable uses those ref
    APIs, but will need to review it against a basis that has more API action
    at a distance.
    
    So if you're willing to give me a few days I think d can sort it out to
    everyone's satisfaction with the refs API fixes first, if not I'll try to
    review the reftable topic again, but will probably use a local merger of it
    and my topics as the basis for that.

I hadn't seen c128427fd74 (Revert hn/refs-errno-cleanup and related
topics, 2021-08-19) yet, but in any case, I'll look at the breakages
etc. and see what can be done about them. Sorry for the
non-responsiveness for the last 2 weeks.
